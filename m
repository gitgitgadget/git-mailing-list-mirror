Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DAB3C433FE
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 15:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239666AbhLTPVs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 10:21:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240294AbhLTPTz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 10:19:55 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B499DC019D94
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 07:01:17 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id s1so20755839wrg.1
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 07:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FWNekHD4UNiIpGuNJBIhbdSoA54z/Sgt2Zx08Walfcs=;
        b=EbkBF13INrawchC+rRFzLdPnQNT4P/ULrdgj3xGyrF94CNnThNmiTTa8VWgaxz3olF
         oN6DnCtDEc1N0WwaAVx07TBErJL1ExgALHB+Aog9e2HQp5PNKWX3+/OqW3pG+SbhMv5w
         D5jHAdzISY5pxuR5iUrQM5YB/Y/JSq+Ub37LhaLmY8eN5VPA014FpwrWZcie9jpB7Pu0
         EkAUf90gExqujFNzCQHCTuEXytSmpskT1jxzcLIq0K1AX+6rpQzXpGybORnLC/U30nR/
         E0BKronoHvUnb92vjiYsf5Ryi/z+8pw37zo0lHYgyH2Qry/Uang7Uolc3DsRmXD+DJiG
         pGag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FWNekHD4UNiIpGuNJBIhbdSoA54z/Sgt2Zx08Walfcs=;
        b=1jPhRVjEEGnLELGIBdnR53rZkGm1oOxb4quT81MBELKkiEWTDnrtuMFd2PhG/z/96/
         N5dajiuQ6PJdSMmj0VFW20qqSX+uYivv//3A6Y94BU95QkOhAexlR/Ez/xVjydc8DKBU
         jm0yDfcXN84fJJYYqQcTEPTkcf6CKQoK3rzZHj/eq3khoR3esoNz++hZtvQIqklGfXjJ
         f87/IVLO3F9AHl1gLzL4SVhJowIFoWZxcZxAN5Xcqp3Qk9kUe+/1YrGQazC0OGJw012Z
         A6eVdX1piXriFRcUfa6Go270IWsirHQ4jW2rev3us6t6Nqc7rjpJ08YTnzNLpxxb023r
         N7yg==
X-Gm-Message-State: AOAM533gN8yDbmUSRdQGmCARtnVxzh9m02eCn7oc8MzttIt7PL+N+Cce
        AeRHk/vS5nGbwFq0lTZ7+cnsZ1mm7mU=
X-Google-Smtp-Source: ABdhPJwMjkw2kB4dY0phUOsZ5mvUcuPOb56+0v7chFULZ89RNo7nkLRfjTShAv2EXPzO7aw+20tYjQ==
X-Received: by 2002:adf:ab43:: with SMTP id r3mr13767568wrc.585.1640012475958;
        Mon, 20 Dec 2021 07:01:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g13sm19823872wrd.57.2021.12.20.07.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 07:01:15 -0800 (PST)
Message-Id: <596caede216c44d2a01358229bc1a47248e708b1.1640012469.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1099.git.1640012469.gitgitgadget@gmail.com>
References: <pull.1099.git.1640012469.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Dec 2021 15:01:09 +0000
Subject: [PATCH 9/9] trace2: add global counters
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Add global counters to Trace2.

Create a mechanism in Trace2 to count an activity and emit a single
"counter" event at the end of the program.  This is an alternative
to the existing "data" events that are emitted immediately.

Create an array of counters (indexed by `enum trace2_counter_id`)
to allow various activites to be tracked as desired.

Preload the array with two counters for testing purposes.

Create unit tests to demonstrate and verify.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Documentation/technical/api-trace2.txt | 67 ++++++++++++++++++++
 Makefile                               |  1 +
 t/helper/test-trace2.c                 | 86 ++++++++++++++++++++++++++
 t/t0211-trace2-perf.sh                 | 24 +++++++
 t/t0212-trace2-event.sh                | 34 ++++++++++
 trace2.c                               | 52 ++++++++++++++++
 trace2.h                               | 33 ++++++++++
 trace2/tr2_ctr.c                       | 65 +++++++++++++++++++
 trace2/tr2_ctr.h                       | 75 ++++++++++++++++++++++
 trace2/tr2_tls.c                       | 29 +++++++++
 trace2/tr2_tls.h                       | 16 +++++
 11 files changed, 482 insertions(+)
 create mode 100644 trace2/tr2_ctr.c
 create mode 100644 trace2/tr2_ctr.h

diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
index bb116dc85db..14e6e50a2d6 100644
--- a/Documentation/technical/api-trace2.txt
+++ b/Documentation/technical/api-trace2.txt
@@ -1297,6 +1297,73 @@ d0 | main                     | atexit       |     |  0.111026 |           |
 In this example, the "test1" timer was started 4 times and ran for
 0.000393 seconds.
 
+Counter Events::
+
+	Trace2 also provides global counters as an alternative to regions
+	and data events.  These make it possible to count an activity of
+	interest, such a call to a library routine, during the program
+	and get a single counter event at the end.
++
+At the end of the program, a single summary event is emitted; this
+value is aggregated across all threads.  These events have "summary"
+as their thread name.
++
+For some counters, individual (per-thread) counter events are also
+generated.  This may be helpful in understanding how work is balanced
+between threads in some circumstances.
++
+----------------
+static void *load_cache_entries_thread(void *_data)
+{
+	struct load_cache_entries_thread_data *p = _data;
+	int i;
+
+	trace2_thread_start("load_cache_entries");
+	...
+	trace2_thread_exit();
+}
+
+static unsigned long load_cache_entry_block(struct index_state *istate,
+			struct mem_pool *ce_mem_pool, int offset, int nr, const char *mmap,
+			unsigned long start_offset, const struct cache_entry *previous_ce)
+{
+	int i;
+	unsigned long src_offset = start_offset;
+
+	trace2_counter_add(TRACE2_COUNTER_ID_TEST2, nr);
+
+	for (i = offset; i < offset + nr; i++) {
+		...
+	}
+}
+----------------
++
+----------------
+$ export GIT_TRACE2_PERF_BRIEF=1
+$ export GIT_TRACE2_PERF=~/log.perf
+$ git status
+...
+$ cat ~/log.perf
+...
+d0 | main                     | exit         |     | 53.977680 |           |              | code:0
+d0 | th12:load_cache_entries  | counter      |     | 53.977708 |           | test         | name:test2 value:193220
+d0 | th11:load_cache_entries  | counter      |     | 53.977708 |           | test         | name:test2 value:193221
+d0 | th10:load_cache_entries  | counter      |     | 53.977708 |           | test         | name:test2 value:193221
+d0 | th09:load_cache_entries  | counter      |     | 53.977708 |           | test         | name:test2 value:193221
+d0 | th08:load_cache_entries  | counter      |     | 53.977708 |           | test         | name:test2 value:193221
+d0 | th07:load_cache_entries  | counter      |     | 53.977708 |           | test         | name:test2 value:193221
+d0 | th06:load_cache_entries  | counter      |     | 53.977708 |           | test         | name:test2 value:193221
+d0 | th05:load_cache_entries  | counter      |     | 53.977708 |           | test         | name:test2 value:193221
+d0 | th04:load_cache_entries  | counter      |     | 53.977708 |           | test         | name:test2 value:193221
+d0 | th03:load_cache_entries  | counter      |     | 53.977708 |           | test         | name:test2 value:193221
+d0 | th02:load_cache_entries  | counter      |     | 53.977708 |           | test         | name:test2 value:193221
+d0 | summary                  | counter      |     | 53.977708 |           | test         | name:test2 value:2125430
+d0 | main                     | atexit       |     | 53.977708 |           |              | code:0
+----------------
++
+This example shows the value computed by each of the 11
+`load_cache_entries` threads and the total across all threads.
+
 == Future Work
 
 === Relationship to the Existing Trace Api (api-trace.txt)
diff --git a/Makefile b/Makefile
index 8b657f0162a..cc5bd8593f1 100644
--- a/Makefile
+++ b/Makefile
@@ -1020,6 +1020,7 @@ LIB_OBJS += trace.o
 LIB_OBJS += trace2.o
 LIB_OBJS += trace2/tr2_cfg.o
 LIB_OBJS += trace2/tr2_cmd_name.o
+LIB_OBJS += trace2/tr2_ctr.o
 LIB_OBJS += trace2/tr2_dst.o
 LIB_OBJS += trace2/tr2_sid.o
 LIB_OBJS += trace2/tr2_tmr.o
diff --git a/t/helper/test-trace2.c b/t/helper/test-trace2.c
index e98db5ba4c1..b64264cfed4 100644
--- a/t/helper/test-trace2.c
+++ b/t/helper/test-trace2.c
@@ -302,6 +302,90 @@ static int ut_009timer(int argc, const char **argv)
 	return 0;
 }
 
+/*
+ * Single-threaded counter test.  Add several values to the TEST1 counter.
+ * The test script can verify that an aggregate Trace2 "counter" event is
+ * emitted containing the sum of the values provided.
+ */
+static int ut_010counter(int argc, const char **argv)
+{
+	const char *usage_error =
+		"expect <v1> [<v2> [...]]";
+	int value;
+	int k;
+
+	if (argc < 1)
+		die("%s", usage_error);
+
+	for (k = 0; k < argc; k++) {
+		if (get_i(&value, argv[k]))
+			die("invalid value[%s] -- %s",
+			    argv[k], usage_error);
+		trace2_counter_add(TRACE2_COUNTER_ID_TEST1, value);
+	}
+
+	return 0;
+}
+
+struct ut_011_data {
+	int v1, v2;
+};
+
+static void *ut_011counter_thread_proc(void *_ut_011_data)
+{
+	struct ut_011_data *data = _ut_011_data;
+
+	trace2_thread_start("ut_011");
+
+	trace2_counter_add(TRACE2_COUNTER_ID_TEST2, data->v1);
+	trace2_counter_add(TRACE2_COUNTER_ID_TEST2, data->v2);
+
+	trace2_thread_exit();
+	return NULL;
+}
+
+/*
+ * Multi-threaded counter test.  Create several threads that each
+ * increment the TEST2 global counter.  The test script can verify
+ * that an individual Trace2 "counter" event for each thread and an
+ * aggregate "counter" event are generated.
+ */
+static int ut_011counter(int argc, const char **argv)
+{
+	const char *usage_error =
+		"expect <v1> <v2> <threads>";
+
+	struct ut_011_data data = { 0, 0 };
+	int nr_threads = 0;
+	int k;
+	pthread_t *pids = NULL;
+
+	if (argc != 3)
+		die("%s", usage_error);
+	if (get_i(&data.v1, argv[0]))
+		die("%s", usage_error);
+	if (get_i(&data.v2, argv[1]))
+		die("%s", usage_error);
+	if (get_i(&nr_threads, argv[2]))
+		die("%s", usage_error);
+
+	CALLOC_ARRAY(pids, nr_threads);
+
+	for (k = 0; k < nr_threads; k++) {
+		if (pthread_create(&pids[k], NULL, ut_011counter_thread_proc, &data))
+			die("failed to create thread[%d]", k);
+	}
+
+	for (k = 0; k < nr_threads; k++) {
+		if (pthread_join(pids[k], NULL))
+			die("failed to join thread[%d]", k);
+	}
+
+	free(pids);
+
+	return 0;
+}
+
 /*
  * Usage:
  *     test-tool trace2 <ut_name_1> <ut_usage_1>
@@ -321,6 +405,8 @@ static struct unit_test ut_table[] = {
 	{ ut_007bug,      "007bug",    "" },
 	{ ut_008timer,    "008timer",  "<count> <ms_delay>" },
 	{ ut_009timer,    "009timer",  "<count> <ms_delay> <threads>" },
+	{ ut_010counter,  "010counter","<v1> [<v2> [<v3> [...]]]" },
+	{ ut_011counter,  "011counter","<v1> <v2> <threads>" },
 };
 /* clang-format on */
 
diff --git a/t/t0211-trace2-perf.sh b/t/t0211-trace2-perf.sh
index 5c99d734ea2..498cbb7316b 100755
--- a/t/t0211-trace2-perf.sh
+++ b/t/t0211-trace2-perf.sh
@@ -198,4 +198,28 @@ test_expect_success 'test stopwatch timers - summary and threads' '
 	grep "d0|summary|timer||_T_ABS_||test|name:test2 count:15" actual
 '
 
+# Exercise the global counter "test" in a loop and confirm that we get an
+# event with the sum.
+#
+test_expect_success 'test global counters - global, single-thead' '
+	test_when_finished "rm trace.perf actual" &&
+	test_config_global trace2.perfBrief 1 &&
+	test_config_global trace2.perfTarget "$(pwd)/trace.perf" &&
+	test-tool trace2 010counter 2 3 5 7 11 13  &&
+	perl "$TEST_DIRECTORY/t0211/scrub_perf.perl" <trace.perf >actual &&
+	grep "d0|summary|counter||_T_ABS_||test|name:test1 value:41" actual
+'
+
+test_expect_success 'test global counters - global+threads' '
+	test_when_finished "rm trace.perf actual" &&
+	test_config_global trace2.perfBrief 1 &&
+	test_config_global trace2.perfTarget "$(pwd)/trace.perf" &&
+	test-tool trace2 011counter 5 10 3 &&
+	perl "$TEST_DIRECTORY/t0211/scrub_perf.perl" <trace.perf >actual &&
+	grep "d0|th01:ut_011|counter||_T_ABS_||test|name:test2 value:15" actual &&
+	grep "d0|th02:ut_011|counter||_T_ABS_||test|name:test2 value:15" actual &&
+	grep "d0|th02:ut_011|counter||_T_ABS_||test|name:test2 value:15" actual &&
+	grep "d0|summary|counter||_T_ABS_||test|name:test2 value:45" actual
+'
+
 test_done
diff --git a/t/t0212-trace2-event.sh b/t/t0212-trace2-event.sh
index 462c001deca..66a73243585 100755
--- a/t/t0212-trace2-event.sh
+++ b/t/t0212-trace2-event.sh
@@ -358,4 +358,38 @@ test_expect_success 'test stopwatch timers - global+threads' '
 	have_timer_event "summary" "test2" 15 trace.event
 '
 
+# Exercise the global counter in a loop and confirm that we get the
+# expected sum in an event record.
+#
+
+have_counter_event () {
+	thread=$1
+	name=$2
+	value=$3
+	file=$4
+
+	grep "\"event\":\"counter\".*\"thread\":\"${thread}\".*\"name\":\"${name}\".*\"value\":${value}" $file
+
+	return $?
+}
+
+test_expect_success 'test global counter - global, single-thread' '
+	test_when_finished "rm trace.event" &&
+	test_config_global trace2.eventBrief 1 &&
+	test_config_global trace2.eventTarget "$(pwd)/trace.event" &&
+	test-tool trace2 010counter 2 3 5 7 11 13 &&
+	have_counter_event "summary" "test1" 41 trace.event
+'
+
+test_expect_success 'test global counter - global+threads' '
+	test_when_finished "rm trace.event" &&
+	test_config_global trace2.eventBrief 1 &&
+	test_config_global trace2.eventTarget "$(pwd)/trace.event" &&
+	test-tool trace2 011counter 5 10 3 &&
+	have_counter_event "th01:ut_011" "test2" 15 trace.event &&
+	have_counter_event "th02:ut_011" "test2" 15 trace.event &&
+	have_counter_event "th03:ut_011" "test2" 15 trace.event &&
+	have_counter_event "summary" "test2" 45 trace.event
+'
+
 test_done
diff --git a/trace2.c b/trace2.c
index c073ffa836f..4c94c5cca68 100644
--- a/trace2.c
+++ b/trace2.c
@@ -8,6 +8,7 @@
 #include "version.h"
 #include "trace2/tr2_cfg.h"
 #include "trace2/tr2_cmd_name.h"
+#include "trace2/tr2_ctr.h"
 #include "trace2/tr2_dst.h"
 #include "trace2/tr2_sid.h"
 #include "trace2/tr2_sysenv.h"
@@ -120,6 +121,43 @@ static void tr2main_emit_thread_timers(uint64_t us_elapsed_absolute)
 							   us_elapsed_absolute);
 }
 
+static void tr2main_emit_summary_counters(uint64_t us_elapsed_absolute)
+{
+	struct tr2_tgt *tgt_j;
+	int j;
+	struct tr2ctr_block merged;
+
+	memset(&merged, 0, sizeof(merged));
+
+	/*
+	 * Sum across all of the per-thread counter data into
+	 * a single composite block of counter values.
+	 */
+	tr2tls_aggregate_counter_blocks(&merged);
+
+	/*
+	 * Emit "summary" counter events for each composite counter value
+	 * that had activity.
+	 */
+	for_each_wanted_builtin (j, tgt_j)
+		if (tgt_j->pfn_counter)
+			tr2ctr_emit_block(tgt_j->pfn_counter,
+					  us_elapsed_absolute,
+					  &merged, "summary");
+}
+
+static void tr2main_emit_thread_counters(uint64_t us_elapsed_absolute)
+{
+	struct tr2_tgt *tgt_j;
+	int j;
+
+	for_each_wanted_builtin (j, tgt_j)
+		if (tgt_j->pfn_counter)
+			tr2tls_emit_counter_blocks_by_thread(
+				tgt_j->pfn_counter,
+				us_elapsed_absolute);
+}
+
 static int tr2main_exit_code;
 
 /*
@@ -150,6 +188,9 @@ static void tr2main_atexit_handler(void)
 	tr2main_emit_thread_timers(us_elapsed_absolute);
 	tr2main_emit_summary_timers(us_elapsed_absolute);
 
+	tr2main_emit_thread_counters(us_elapsed_absolute);
+	tr2main_emit_summary_counters(us_elapsed_absolute);
+
 	for_each_wanted_builtin (j, tgt_j)
 		if (tgt_j->pfn_atexit)
 			tgt_j->pfn_atexit(us_elapsed_absolute,
@@ -903,3 +944,14 @@ void trace2_timer_stop(enum trace2_timer_id tid)
 
 	tr2tmr_stop(tid);
 }
+
+void trace2_counter_add(enum trace2_counter_id cid, uint64_t value)
+{
+	if (!trace2_enabled)
+		return;
+
+	if (cid < 0 || cid >= TRACE2_NUMBER_OF_COUNTERS)
+		BUG("invalid counter id: %d", cid);
+
+	tr2ctr_add(cid, value);
+}
diff --git a/trace2.h b/trace2.h
index 32e2eaca7c8..80c781f5a94 100644
--- a/trace2.h
+++ b/trace2.h
@@ -52,6 +52,7 @@ struct json_writer;
  * [] trace2_data*      -- emit region/thread/repo data messages.
  * [] trace2_printf*    -- legacy trace[1] messages.
  * [] trace2_timer*     -- start/stop stopwatch timer (messages are deferred).
+ * [] trace2_counter*   -- global counters (messages are deferrred).
  */
 
 /*
@@ -573,4 +574,36 @@ enum trace2_timer_id {
 void trace2_timer_start(enum trace2_timer_id tid);
 void trace2_timer_stop(enum trace2_timer_id tid);
 
+/*
+ * Define the set of global counters.
+ *
+ * We can add more at any time, but they must be defined at compile
+ * time (to avoid the need to dynamically allocate and synchronize
+ * them between different threads).
+ *
+ * These must start at 0 and be contiguous (because we them elsewhere
+ * as array indexes).
+ *
+ * Any value added to this enum must also be added to the counter
+ * definitions array.  See `trace2/tr2_ctr.c:tr2ctr_def_block[]`.
+ */
+enum trace2_counter_id {
+	/*
+	 * Define two counters for testing.  See `t/helper/test-trace2.c`.
+	 * These can be used for ad hoc testing, but should not be used
+	 * for permanent analysis code.
+	 */
+	TRACE2_COUNTER_ID_TEST1 = 0, /* emits summary event only */
+	TRACE2_COUNTER_ID_TEST2,     /* emits summary and thread events */
+
+
+	/* Add additional counter definitions before here. */
+	TRACE2_NUMBER_OF_COUNTERS
+};
+
+/*
+ * Increment global counter by value.
+ */
+void trace2_counter_add(enum trace2_counter_id cid, uint64_t value);
+
 #endif /* TRACE2_H */
diff --git a/trace2/tr2_ctr.c b/trace2/tr2_ctr.c
new file mode 100644
index 00000000000..bfc27005dca
--- /dev/null
+++ b/trace2/tr2_ctr.c
@@ -0,0 +1,65 @@
+#include "cache.h"
+#include "thread-utils.h"
+#include "trace2/tr2_tls.h"
+#include "trace2/tr2_ctr.h"
+
+/*
+ * Define metadata for each global counter.  This list must match the
+ * set defined in "enum trace2_counter_id".
+ */
+struct tr2ctr_def {
+	const char *category;
+	const char *name;
+
+	unsigned int want_thread_events:1;
+};
+
+static struct tr2ctr_def tr2ctr_def_block[TRACE2_NUMBER_OF_COUNTERS] = {
+	[TRACE2_COUNTER_ID_TEST1] = { "test", "test1", 0 },
+	[TRACE2_COUNTER_ID_TEST2] = { "test", "test2", 1 },
+};
+
+void tr2ctr_add(enum trace2_counter_id cid, uint64_t value)
+{
+	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
+	struct tr2ctr_counter *c = &ctx->counters.counter[cid];
+
+	c->value += value;
+}
+
+void tr2ctr_aggregate_counters(struct tr2ctr_block *merged,
+			       const struct tr2ctr_block *src)
+{
+	enum trace2_counter_id cid;
+
+	for (cid = 0; cid < TRACE2_NUMBER_OF_COUNTERS; cid++) {
+		struct tr2ctr_counter *c_merged = &merged->counter[cid];
+		const struct tr2ctr_counter *c = &src->counter[cid];
+
+		c_merged->is_aggregate = 1;
+
+		c_merged->value += c->value;
+	}
+
+	merged->is_aggregate = 1;
+}
+
+void tr2ctr_emit_block(tr2_tgt_evt_counter_t *pfn, uint64_t us_elapsed_absolute,
+		       const struct tr2ctr_block *blk, const char *thread_name)
+{
+	enum trace2_counter_id cid;
+
+	for (cid = 0; cid < TRACE2_NUMBER_OF_COUNTERS; cid++) {
+		const struct tr2ctr_counter *c = &blk->counter[cid];
+		const struct tr2ctr_def *d = &tr2ctr_def_block[cid];
+
+		if (!c->value)
+			continue; /* counter was not used */
+
+		if (!d->want_thread_events && !c->is_aggregate)
+			continue; /* per-thread events not wanted */
+
+		pfn(us_elapsed_absolute, thread_name, d->category, d->name,
+		    c->value);
+	}
+}
diff --git a/trace2/tr2_ctr.h b/trace2/tr2_ctr.h
new file mode 100644
index 00000000000..9a805062069
--- /dev/null
+++ b/trace2/tr2_ctr.h
@@ -0,0 +1,75 @@
+#ifndef TR2_CTR_H
+#define TR2_CTR_H
+
+#include "trace2.h"
+#include "trace2/tr2_tgt.h"
+
+/*
+ * Define a mechanism to allow global "counters".
+ *
+ * Counters can be used count interesting activity that does not fit
+ * the "region and data" model, such as code called from many
+ * different regions and/or where you want to count a number of items,
+ * but don't have control of when the last item will be processed,
+ * such as counter the number of calls to `lstat()`.
+ *
+ * Counters differ from Trace2 "data" events.  Data events are emitted
+ * immediately and are appropriate for documenting loop counters and
+ * etc.  Counter values are accumulated during the program and the final
+ * counter value event is emitted at program exit.
+ *
+ * To make this model efficient, we define a compile-time fixed set
+ * of counters and counter ids.  This lets us avoid the complexities
+ * of dynamically allocating a counter and sharing that definition
+ * with other threads.
+ *
+ * We define (at compile time) a set of "counter ids" to access the
+ * various counters inside of a fixed size "counter block".
+ *
+ * A counter defintion table provides the counter category and name
+ * so we can eliminate those arguments from the public counter API.
+ *
+ * Each active thread maintains a counter block in its TLS CTX and
+ * increments them without locking.  At program exit, the counter
+ * blocks from all of the individual CTXs are added together to give
+ * the final summary value for the each global counter.
+ */
+
+/*
+ * The definition of an individual counter.
+ */
+struct tr2ctr_counter {
+	uint64_t value;
+
+	unsigned int is_aggregate:1;
+};
+
+/*
+ * Compile time fixed block of all defined counters.
+ */
+struct tr2ctr_block {
+	struct tr2ctr_counter counter[TRACE2_NUMBER_OF_COUNTERS];
+
+	unsigned int is_aggregate:1;
+};
+
+/*
+ * Add "value" to the global counter.
+ */
+void tr2ctr_add(enum trace2_counter_id cid, uint64_t value);
+
+/*
+ * Accumulate counter data from the source block into the merged block.
+ */
+void tr2ctr_aggregate_counters(struct tr2ctr_block *merged,
+			       const struct tr2ctr_block *src);
+
+/*
+ * Send counter data for all counters in this block to the target.
+ *
+ * This will generate an event record for each counter that had activity.
+ */
+void tr2ctr_emit_block(tr2_tgt_evt_counter_t *pfn, uint64_t us_elapsed_absolute,
+		       const struct tr2ctr_block *blk, const char *thread_name);
+
+#endif /* TR2_CTR_H */
diff --git a/trace2/tr2_tls.c b/trace2/tr2_tls.c
index 068938d334e..ff795d104e6 100644
--- a/trace2/tr2_tls.c
+++ b/trace2/tr2_tls.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "thread-utils.h"
+#include "trace2/tr2_ctr.h"
 #include "trace2/tr2_tls.h"
 #include "trace2/tr2_tmr.h"
 
@@ -228,3 +229,31 @@ void tr2tls_emit_timer_blocks_by_thread(tr2_tgt_evt_timer_t *pfn,
 		ctx = next;
 	}
 }
+
+void tr2tls_aggregate_counter_blocks(struct tr2ctr_block *merged)
+{
+	struct tr2tls_thread_ctx *ctx = tr2tls_ctx_list;
+
+	while (ctx) {
+		struct tr2tls_thread_ctx *next = ctx->next_ctx;
+
+		tr2ctr_aggregate_counters(merged, &ctx->counters);
+
+		ctx = next;
+	}
+}
+
+void tr2tls_emit_counter_blocks_by_thread(tr2_tgt_evt_counter_t *pfn,
+					  uint64_t us_elapsed_absolute)
+{
+	struct tr2tls_thread_ctx *ctx = tr2tls_ctx_list;
+
+	while (ctx) {
+		struct tr2tls_thread_ctx *next = ctx->next_ctx;
+
+		tr2ctr_emit_block(pfn, us_elapsed_absolute, &ctx->counters,
+				  ctx->thread_name);
+
+		ctx = next;
+	}
+}
diff --git a/trace2/tr2_tls.h b/trace2/tr2_tls.h
index 10669f0d7b9..032b90fa46b 100644
--- a/trace2/tr2_tls.h
+++ b/trace2/tr2_tls.h
@@ -2,6 +2,7 @@
 #define TR2_TLS_H
 
 #include "strbuf.h"
+#include "trace2/tr2_ctr.h"
 #include "trace2/tr2_tmr.h"
 
 /*
@@ -17,9 +18,24 @@ struct tr2tls_thread_ctx {
 	size_t nr_open_regions; /* plays role of "nr" in ALLOC_GROW */
 	int thread_id;
 
+	struct tr2ctr_block counters;
 	struct tr2tmr_block timers;
 };
 
+/*
+ * Iterate over the global list of TLS CTX data and aggregate the
+ * counter data into the given counter block.
+ */
+void tr2tls_aggregate_counter_blocks(struct tr2ctr_block *merged);
+
+/*
+ * Iterate over the global list of TLS CTX data (the complete set of
+ * threads that have used Trace2 resources) data and emit "per-thread"
+ * counter data for each.
+ */
+void tr2tls_emit_counter_blocks_by_thread(tr2_tgt_evt_counter_t *pfn,
+					  uint64_t us_elapsed_absolute);
+
 /*
  * Iterate over the global list of TLS CTX data and aggregate the timer
  * data into the given timer block.
-- 
gitgitgadget
