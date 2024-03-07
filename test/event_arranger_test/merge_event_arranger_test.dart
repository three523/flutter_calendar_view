import 'dart:html';

import 'package:calendar_view/calendar_view.dart';
import 'package:flutter_test/flutter_test.dart';

const height = 1440.0;
const width = 500.0;
const heightPerMinute = 1.0;
const startHour = 0;

void main() {
  final now = DateTime.now().withoutTime;

  group('MergeEventArrangerTest', () {
    test('Events which does not overlap.', () {
      final events = [
        CalendarEventData(
          price: 10000,
          type: EventType.income,
          date: now,
          startTime: now.add(Duration(hours: 1)),
          endTime: now.add(
            Duration(hours: 2),
          ),
        ),
        CalendarEventData(
          price: 2000,
          type: EventType.income,
          date: now,
          startTime: now.add(Duration(hours: 2, minutes: 15)),
          endTime: now.add(
            Duration(hours: 3),
          ),
        ),
        CalendarEventData(
          price: 1000,
          type: EventType.income,
          date: now,
          startTime: now.add(Duration(hours: 3, minutes: 15)),
          endTime: now.add(
            Duration(hours: 4),
          ),
        ),
        CalendarEventData(
          price: 4000,
          type: EventType.expenses,
          date: now,
          startTime: now.add(Duration(hours: 4, minutes: 15)),
          endTime: now.add(
            Duration(hours: 5),
          ),
        ),
        CalendarEventData(
          price: 25000,
          type: EventType.income,
          date: now,
          startTime: now.add(Duration(hours: 10)),
          endTime: now.add(
            Duration(hours: 13),
          ),
        ),
      ];

      final mergedEvents = MergeEventArranger().arrange(
          events: events,
          height: height,
          width: width,
          heightPerMinute: heightPerMinute,
          startHour: startHour);

      expect(mergedEvents.length, events.length);
    });
    test('Only start time is overlapping', () {
      final events = [
        CalendarEventData(
          price: 2500,
          type: EventType.income,
          date: now,
          startTime: now.add(Duration(hours: 10)),
          endTime: now.add(
            Duration(hours: 12),
          ),
        ),
        CalendarEventData(
          price: 6000,
          type: EventType.expenses,
          date: now,
          startTime: now.add(Duration(hours: 8)),
          endTime: now.add(
            Duration(hours: 10),
          ),
        ),
      ];

      final mergedEvents = MergeEventArranger().arrange(
          events: events,
          height: height,
          width: width,
          heightPerMinute: heightPerMinute,
          startHour: startHour);

      expect(mergedEvents.length, 1);
    });
    test('Only end time is overlapping', () {
      final events = [
        CalendarEventData(
          price: 6000,
          type: EventType.income,
          date: now,
          startTime: now.add(Duration(hours: 8)),
          endTime: now.add(
            Duration(hours: 10),
          ),
        ),
        CalendarEventData(
          price: 4000,
          type: EventType.expenses,
          date: now,
          startTime: now.add(Duration(hours: 10)),
          endTime: now.add(
            Duration(hours: 12),
          ),
        ),
      ];

      final mergedEvents = MergeEventArranger().arrange(
          events: events,
          height: height,
          width: width,
          heightPerMinute: heightPerMinute,
          startHour: startHour);

      expect(mergedEvents.length, 1);
    });
    test('Event1 is smaller than event 2 and overlapping', () {
      final events = [
        CalendarEventData(
          price: 6000,
          type: EventType.income,
          date: now,
          startTime: now.add(Duration(hours: 10)),
          endTime: now.add(
            Duration(hours: 12),
          ),
        ),
        CalendarEventData(
          price: 4000,
          type: EventType.expenses,
          date: now,
          startTime: now.add(Duration(hours: 8)),
          endTime: now.add(
            Duration(hours: 14),
          ),
        ),
      ];

      final mergedEvents = MergeEventArranger().arrange(
          events: events,
          height: height,
          width: width,
          heightPerMinute: heightPerMinute,
          startHour: startHour);

      expect(mergedEvents.length, 1);
    });
    test('Event2 is smaller than event 1 and overlapping', () {
      final events = [
        CalendarEventData(
          price: 6000,
          type: EventType.income,
          date: now,
          startTime: now.add(Duration(hours: 8)),
          endTime: now.add(
            Duration(hours: 14),
          ),
        ),
        CalendarEventData(
          price: 5000,
          type: EventType.expenses,
          date: now,
          startTime: now.add(Duration(hours: 10)),
          endTime: now.add(
            Duration(hours: 12),
          ),
        ),
      ];

      final mergedEvents = MergeEventArranger().arrange(
          events: events,
          height: height,
          width: width,
          heightPerMinute: heightPerMinute,
          startHour: startHour);

      expect(mergedEvents.length, 1);
    });
    test('Both events are of same duration and occurs at the same time', () {
      final events = [
        CalendarEventData(
          price: 6000,
          type: EventType.income,
          date: now,
          startTime: now.add(Duration(hours: 10)),
          endTime: now.add(
            Duration(hours: 12),
          ),
        ),
        CalendarEventData(
          price: 4000,
          type: EventType.expenses,
          date: now,
          startTime: now.add(Duration(hours: 10)),
          endTime: now.add(
            Duration(hours: 12),
          ),
        ),
      ];

      final mergedEvents = MergeEventArranger().arrange(
          events: events,
          height: height,
          width: width,
          heightPerMinute: heightPerMinute,
          startHour: startHour);

      expect(mergedEvents.length, 1);
    });
    test('Only few events overlaps', () {
      final events = [
        CalendarEventData(
          price: 6000,
          type: EventType.income,
          date: now,
          startTime: now.add(Duration(hours: 1)),
          endTime: now.add(
            Duration(hours: 2),
          ),
        ),
        CalendarEventData(
          price: 3000,
          type: EventType.income,
          date: now,
          startTime: now.add(Duration(hours: 7)),
          endTime: now.add(
            Duration(hours: 11),
          ),
        ),
        CalendarEventData(
          price: 7000,
          type: EventType.expenses,
          date: now,
          startTime: now.add(Duration(hours: 3)),
          endTime: now.add(
            Duration(hours: 3, minutes: 30),
          ),
        ),
        CalendarEventData(
          price: 9000,
          type: EventType.expenses,
          date: now,
          startTime: now.add(Duration(hours: 1, minutes: 15)),
          endTime: now.add(
            Duration(hours: 2, minutes: 15),
          ),
        ),
        CalendarEventData(
          price: 15000,
          type: EventType.income,
          date: now,
          startTime: now.add(Duration(hours: 5)),
          endTime: now.add(
            Duration(hours: 6),
          ),
        ),
        CalendarEventData(
          price: 6500,
          type: EventType.income,
          date: now,
          startTime: now.add(Duration(hours: 8)),
          endTime: now.add(
            Duration(hours: 9),
          ),
        ),
      ];

      final mergedEvents = MergeEventArranger().arrange(
          events: events,
          height: height,
          width: width,
          heightPerMinute: heightPerMinute,
          startHour: startHour);

      expect(mergedEvents.length, 4);
    });
    test('All events overlaps with each other', () {
      final events = [
        CalendarEventData(
          price: 6000,
          type: EventType.income,
          date: now,
          startTime: now.add(Duration(hours: 1)),
          endTime: now.add(
            Duration(hours: 2),
          ),
        ),
        CalendarEventData(
          price: 6000,
          type: EventType.income,
          date: now,
          startTime: now.add(Duration(hours: 4)),
          endTime: now.add(
            Duration(hours: 5),
          ),
        ),
        CalendarEventData(
          price: 8000,
          type: EventType.income,
          date: now,
          startTime: now.add(Duration(hours: 2)),
          endTime: now.add(
            Duration(hours: 6),
          ),
        ),
        CalendarEventData(
          price: 9000,
          type: EventType.expenses,
          date: now,
          startTime: now.add(Duration(hours: 7)),
          endTime: now.add(
            Duration(hours: 10),
          ),
        ),
        CalendarEventData(
          price: 10000,
          type: EventType.expenses,
          date: now,
          startTime: now.add(Duration(hours: 5)),
          endTime: now.add(
            Duration(hours: 7),
          ),
        ),
        CalendarEventData(
          price: 6000,
          type: EventType.income,
          date: now,
          startTime: now.add(Duration(hours: 3)),
          endTime: now.add(
            Duration(hours: 6),
          ),
        ),
      ];

      final mergedEvents = MergeEventArranger().arrange(
          events: events
            ..sort((e1, e2) =>
                (e1.startTime?.getTotalMinutes ?? 0) -
                (e2.startTime?.getTotalMinutes ?? 0)),
          height: height,
          width: width,
          heightPerMinute: heightPerMinute,
          startHour: startHour);

      expect(mergedEvents.length, 1);
    });

    group('Edge event should not merge', () {
      test('End of Event 1 and Start of Event 2 is same', () {
        final events = [
          CalendarEventData(
            price: 6000,
            type: EventType.income,
            date: now,
            startTime: now.add(Duration(hours: 1)),
            endTime: now.add(
              Duration(hours: 2),
            ),
          ),
          CalendarEventData(
            price: 3000,
            type: EventType.income,
            date: now,
            startTime: now.add(Duration(hours: 2)),
            endTime: now.add(
              Duration(hours: 3),
            ),
          ),
        ];

        final mergedEvents = MergeEventArranger(includeEdges: false).arrange(
            events: events
              ..sort((e1, e2) =>
                  (e1.startTime?.getTotalMinutes ?? 0) -
                  (e2.startTime?.getTotalMinutes ?? 0)),
            height: height,
            width: width,
            heightPerMinute: heightPerMinute,
            startHour: startHour);

        expect(mergedEvents.length, 2);
      });

      test('Start of Event 1 and End of Event 2 is same', () {
        final events = [
          CalendarEventData(
            price: 6000,
            type: EventType.income,
            date: now,
            startTime: now.add(Duration(hours: 2)),
            endTime: now.add(
              Duration(hours: 3),
            ),
          ),
          CalendarEventData(
            price: 3000,
            type: EventType.expenses,
            date: now,
            startTime: now.add(Duration(hours: 1)),
            endTime: now.add(
              Duration(hours: 2),
            ),
          ),
        ];

        final mergedEvents = MergeEventArranger(includeEdges: false).arrange(
            events: events
              ..sort((e1, e2) =>
                  (e1.startTime?.getTotalMinutes ?? 0) -
                  (e2.startTime?.getTotalMinutes ?? 0)),
            height: height,
            width: width,
            heightPerMinute: heightPerMinute,
            startHour: startHour);

        expect(mergedEvents.length, 2);
      });
    });
    group('Edge event should merge', () {
      test('End of Event 1 and Start of Event 2 is same', () {
        final events = [
          CalendarEventData(
            price: 6000,
            type: EventType.income,
            date: now,
            startTime: now.add(Duration(hours: 1)),
            endTime: now.add(
              Duration(hours: 2),
            ),
          ),
          CalendarEventData(
            price: 8000,
            type: EventType.expenses,
            date: now,
            startTime: now.add(Duration(hours: 2)),
            endTime: now.add(
              Duration(hours: 3),
            ),
          ),
        ];

        final mergedEvents = MergeEventArranger(includeEdges: true).arrange(
            events: events
              ..sort((e1, e2) =>
                  (e1.startTime?.getTotalMinutes ?? 0) -
                  (e2.startTime?.getTotalMinutes ?? 0)),
            height: height,
            width: width,
            heightPerMinute: heightPerMinute,
            startHour: startHour);

        expect(mergedEvents.length, 1);
      });

      test('Start of Event 1 and End of Event 2 is same', () {
        final events = [
          CalendarEventData(
            price: 6000,
            type: EventType.expenses,
            date: now,
            startTime: now.add(Duration(hours: 2)),
            endTime: now.add(
              Duration(hours: 3),
            ),
          ),
          CalendarEventData(
            price: 8000,
            type: EventType.expenses,
            date: now,
            startTime: now.add(Duration(hours: 1)),
            endTime: now.add(
              Duration(hours: 2),
            ),
          ),
        ];

        final mergedEvents = MergeEventArranger(includeEdges: true).arrange(
            events: events
              ..sort((e1, e2) =>
                  (e1.startTime?.getTotalMinutes ?? 0) -
                  (e2.startTime?.getTotalMinutes ?? 0)),
            height: height,
            width: width,
            heightPerMinute: heightPerMinute,
            startHour: startHour);

        expect(mergedEvents.length, 1);
      });
    });

// TODO: add tests for the events where start or end time is not valid.
  });
}
