Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F0BC433EF
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 19:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbhL1ThC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 14:37:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237191AbhL1Tgw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 14:36:52 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6750CC061747
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 11:36:51 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id s1so40171399wra.6
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 11:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=O6tS3yPo6TcsoBnkL0dTAbJuWIxyk24bsF/NbJhiAwU=;
        b=CV0qXdvaRvPyTj6E88T/0vPIKQ3b/lL/fx7pO3lvIvI5bSVH2OXm2Wy58qhECqUtz3
         pg7NxLUH7pp2PzKEW1RQ3r7XDiCuD40+wICJrVTtkH6haFwMiR8G+9UjD1jJpfz3ythP
         L+nAQ/SSGhC5VNlS/h4lUDh5Paf31yIQjRr+BabewY+g6qSlB1IGAP9O7uXEyahZjDA+
         wQoh+Lko1OfhzoNGcbDjWRRjRij7c0HHAgRrEsACY7tTppkk8C46NEIJ7JvXjHcx1aWO
         gvaSJFyX1Ga0RLiMMHrQe4aHxeJ7GcN+yU4tdlLf0LN4i8KfqTJ286ut1m2/Wb1Glbr/
         QDoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=O6tS3yPo6TcsoBnkL0dTAbJuWIxyk24bsF/NbJhiAwU=;
        b=Xos0TOAWt3ePvlzbIIh+DLZC6CcYbt5QW2s3pVYMYeOYuBAmbaHP99xdKt9NM0C2Xs
         X+Nb/UgPOhwZepw1Oz86i41CyoNcd5m3dgxRq5AP0cvVuwb3ky9ltHu8L3TkkjqgBoEK
         v0hXpeqvYFX+S9eQ+6AY9VAnNEhsUPggkVRji02MKnPg6lYOwdDKyPoLX/WU39z0mrcM
         bsPNgzmSBnTYnNQF6YRAqMmfXu+TI5aPgF8qWJ9Qk89iijSiY98Mq5yHya7LI1kkXO5H
         kVILVV7avLHWOUYWg8C3VjVgLiYkcvdZUm/mP2YVDPI2enrVyGurGoJywHBjKpp6i7jk
         tpSA==
X-Gm-Message-State: AOAM530DRDmSddNECnpPDafmSA5Jsfr3k/Yq40W2oItqj0qT6pt6bPZp
        AwDl5BKXK9kH1sJXyMKjZpB47RdLRAw=
X-Google-Smtp-Source: ABdhPJxferIorfEml42odFf8D/kSVxrfmob0MdlP0tW9zlIAjtiv/4tb7lHAfchnJp+qtMnkq7hILw==
X-Received: by 2002:a05:6000:16c4:: with SMTP id h4mr17546764wrf.312.1640720209552;
        Tue, 28 Dec 2021 11:36:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l26sm18529226wrz.44.2021.12.28.11.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 11:36:49 -0800 (PST)
Message-Id: <4d6155e4e4c2c600084d892999ebc4579623dc83.1640720202.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1099.v2.git.1640720202.gitgitgadget@gmail.com>
References: <pull.1099.git.1640012469.gitgitgadget@gmail.com>
        <pull.1099.v2.git.1640720202.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Dec 2021 19:36:42 +0000
Subject: [PATCH v2 9/9] trace2: add global counters
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Johannes Sixt <j6t@kdbg.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
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
 t/helper/test-trace2.c                 | 88 +++++++++++++++++++++++++-
 t/t0211-trace2-perf.sh                 | 42 ++++++++++++
 t/t0212-trace2-event.sh                | 41 ++++++++++++
 trace2.c                               | 50 +++++++++++++++
 trace2.h                               | 33 ++++++++++
 trace2/tr2_ctr.c                       | 67 ++++++++++++++++++++
 trace2/tr2_ctr.h                       | 79 +++++++++++++++++++++++
 trace2/tr2_tls.c                       | 29 +++++++++
 trace2/tr2_tls.h                       | 16 +++++
 11 files changed, 512 insertions(+), 1 deletion(-)
 create mode 100644 trace2/tr2_ctr.c
 create mode 100644 trace2/tr2_ctr.h

diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
index bdba0f92280..a3ea867ff92 100644
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
+	trace2_counter_increment(TRACE2_COUNTER_ID_TEST2, nr);
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
index 51d022422bf..a7dbecfda9a 100644
--- a/t/helper/test-trace2.c
+++ b/t/helper/test-trace2.c
@@ -270,7 +270,7 @@ static int ut_009timer(int argc, const char **argv)
 	const char *usage_error =
 		"expect <count> <ms_delay> <threads>";
 
-	struct ut_009_data data = { 0, 0 };
+	struct ut_009_data data = { 0 };
 	int nr_threads = 0;
 	int k;
 	pthread_t *pids = NULL;
@@ -301,6 +301,90 @@ static int ut_009timer(int argc, const char **argv)
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
@@ -320,6 +404,8 @@ static struct unit_test ut_table[] = {
 	{ ut_007bug,      "007bug",    "" },
 	{ ut_008timer,    "008timer",  "<count> <ms_delay>" },
 	{ ut_009timer,    "009timer",  "<count> <ms_delay> <threads>" },
+	{ ut_010counter,  "010counter","<v1> [<v2> [<v3> [...]]]" },
+	{ ut_011counter,  "011counter","<v1> <v2> <threads>" },
 };
 /* clang-format on */
 
diff --git a/t/t0211-trace2-perf.sh b/t/t0211-trace2-perf.sh
index 381c3eea458..5f9a3533ce4 100755
--- a/t/t0211-trace2-perf.sh
+++ b/t/t0211-trace2-perf.sh
@@ -219,4 +219,46 @@ test_expect_success 'test stopwatch timers - summary and threads' '
 	have_timer_event "summary" "test2" 15 actual
 '
 
+# Exercise the global counter "test" in a loop and confirm that we get an
+# event with the sum.
+#
+
+have_counter_event () {
+	thread=$1
+	name=$2
+	value=$3
+	file=$4
+
+	pattern="d0|${thread}|counter||_T_ABS_||test"
+	pattern="${pattern}|name:${name}"
+	pattern="${pattern} value:${value}"
+
+	grep "${pattern}" ${file}
+
+	return $?
+}
+
+test_expect_success 'test global counters - global, single-thead' '
+	test_when_finished "rm trace.perf actual" &&
+	test_config_global trace2.perfBrief 1 &&
+	test_config_global trace2.perfTarget "$(pwd)/trace.perf" &&
+	test-tool trace2 010counter 2 3 5 7 11 13  &&
+	perl "$TEST_DIRECTORY/t0211/scrub_perf.perl" <trace.perf >actual &&
+
+	have_counter_event "summary" "test1" 41 actual
+'
+
+test_expect_success 'test global counters - global+threads' '
+	test_when_finished "rm trace.perf actual" &&
+	test_config_global trace2.perfBrief 1 &&
+	test_config_global trace2.perfTarget "$(pwd)/trace.perf" &&
+	test-tool trace2 011counter 5 10 3 &&
+	perl "$TEST_DIRECTORY/t0211/scrub_perf.perl" <trace.perf >actual &&
+
+	have_counter_event "th01:ut_011" "test2" 15 actual &&
+	have_counter_event "th02:ut_011" "test2" 15 actual &&
+	have_counter_event "th03:ut_011" "test2" 15 actual &&
+	have_counter_event "summary" "test2" 45 actual
+'
+
 test_done
diff --git a/t/t0212-trace2-event.sh b/t/t0212-trace2-event.sh
index 277688fdbc4..9e76ef5caa7 100755
--- a/t/t0212-trace2-event.sh
+++ b/t/t0212-trace2-event.sh
@@ -368,4 +368,45 @@ test_expect_success 'test stopwatch timers - global+threads' '
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
+	pattern="\"event\":\"counter\""
+	pattern="${pattern}.*\"thread\":\"${thread}\""
+	pattern="${pattern}.*\"name\":\"${name}\""
+	pattern="${pattern}.*\"value\":${value}"
+
+	grep "${pattern}" ${file}
+
+	return $?
+}
+
+test_expect_success 'test global counter - global, single-thread' '
+	test_when_finished "rm trace.event" &&
+	test_config_global trace2.eventBrief 1 &&
+	test_config_global trace2.eventTarget "$(pwd)/trace.event" &&
+	test-tool trace2 010counter 2 3 5 7 11 13 &&
+
+	have_counter_event "summary" "test1" 41 trace.event
+'
+
+test_expect_success 'test global counter - global+threads' '
+	test_when_finished "rm trace.event" &&
+	test_config_global trace2.eventBrief 1 &&
+	test_config_global trace2.eventTarget "$(pwd)/trace.event" &&
+	test-tool trace2 011counter 5 10 3 &&
+
+	have_counter_event "th01:ut_011" "test2" 15 trace.event &&
+	have_counter_event "th02:ut_011" "test2" 15 trace.event &&
+	have_counter_event "th03:ut_011" "test2" 15 trace.event &&
+	have_counter_event "summary" "test2" 45 trace.event
+'
+
 test_done
diff --git a/trace2.c b/trace2.c
index 23289dd6eb4..aa6ed6dd3ee 100644
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
@@ -114,6 +115,41 @@ static void tr2main_emit_thread_timers(uint64_t us_elapsed_absolute)
 						  us_elapsed_absolute);
 }
 
+static void tr2main_emit_summary_counters(uint64_t us_elapsed_absolute)
+{
+	struct tr2_tgt *tgt_j;
+	int j;
+	struct tr2_counter_block merged = { { { 0 } } };
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
+			tr2_emit_counter_block(tgt_j->pfn_counter,
+					       us_elapsed_absolute,
+					       &merged, "summary");
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
@@ -144,6 +180,9 @@ static void tr2main_atexit_handler(void)
 	tr2main_emit_thread_timers(us_elapsed_absolute);
 	tr2main_emit_summary_timers(us_elapsed_absolute);
 
+	tr2main_emit_thread_counters(us_elapsed_absolute);
+	tr2main_emit_summary_counters(us_elapsed_absolute);
+
 	for_each_wanted_builtin (j, tgt_j)
 		if (tgt_j->pfn_atexit)
 			tgt_j->pfn_atexit(us_elapsed_absolute,
@@ -897,3 +936,14 @@ void trace2_timer_stop(enum trace2_timer_id tid)
 
 	tr2_stop_timer(tid);
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
+	tr2_counter_increment(cid, value);
+}
diff --git a/trace2.h b/trace2.h
index 22da5c5516c..d4ed602c19a 100644
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
+ * definitions array.  See `trace2/tr2_ctr.c:tr2_counter_def_block[]`.
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
index 00000000000..ce80ceb5476
--- /dev/null
+++ b/trace2/tr2_ctr.c
@@ -0,0 +1,67 @@
+#include "cache.h"
+#include "thread-utils.h"
+#include "trace2/tr2_tls.h"
+#include "trace2/tr2_ctr.h"
+
+/*
+ * Define metadata for each global counter.  This list must match the
+ * set defined in "enum trace2_counter_id".
+ */
+struct tr2_counter_def {
+	const char *category;
+	const char *name;
+
+	unsigned int want_thread_events:1;
+};
+
+static struct tr2_counter_def tr2_counter_def_block[TRACE2_NUMBER_OF_COUNTERS] = {
+	[TRACE2_COUNTER_ID_TEST1] = { "test", "test1", 0 },
+	[TRACE2_COUNTER_ID_TEST2] = { "test", "test2", 1 },
+};
+
+void tr2_counter_increment(enum trace2_counter_id cid, uint64_t value)
+{
+	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
+	struct tr2_counter *c = &ctx->counters.counter[cid];
+
+	c->value += value;
+}
+
+void tr2_merge_counter_block(struct tr2_counter_block *merged,
+			     const struct tr2_counter_block *src)
+{
+	enum trace2_counter_id cid;
+
+	for (cid = 0; cid < TRACE2_NUMBER_OF_COUNTERS; cid++) {
+		struct tr2_counter *c_merged = &merged->counter[cid];
+		const struct tr2_counter *c = &src->counter[cid];
+
+		c_merged->is_aggregate = 1;
+
+		c_merged->value += c->value;
+	}
+
+	merged->is_aggregate = 1;
+}
+
+void tr2_emit_counter_block(tr2_tgt_evt_counter_t *pfn,
+			    uint64_t us_elapsed_absolute,
+			    const struct tr2_counter_block *blk,
+			    const char *thread_name)
+{
+	enum trace2_counter_id cid;
+
+	for (cid = 0; cid < TRACE2_NUMBER_OF_COUNTERS; cid++) {
+		const struct tr2_counter *c = &blk->counter[cid];
+		const struct tr2_counter_def *d = &tr2_counter_def_block[cid];
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
index 00000000000..fd6fbef89a2
--- /dev/null
+++ b/trace2/tr2_ctr.h
@@ -0,0 +1,79 @@
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
+ * These are defined in a parallel tabel in `tr2_ctr.c`.
+ *
+ * Each thread has a private block of counters in its thread local
+ * storage data so no locks are required for a thread to increment
+ * it's version of the counter.  At program exit, the counter blocks
+ * from all of the per-thread counters are added together to give the
+ * final summary value for the each global counter.
+ */
+
+/*
+ * The definition of an individual counter.
+ */
+struct tr2_counter {
+	uint64_t value;
+
+	unsigned int is_aggregate:1;
+};
+
+/*
+ * Compile time fixed block of all defined counters.
+ */
+struct tr2_counter_block {
+	struct tr2_counter counter[TRACE2_NUMBER_OF_COUNTERS];
+
+	unsigned int is_aggregate:1;
+};
+
+/*
+ * Add "value" to the global counter.
+ */
+void tr2_counter_increment(enum trace2_counter_id cid, uint64_t value);
+
+/*
+ * Accumulate counter data from the source block into the merged block.
+ */
+void tr2_merge_counter_block(struct tr2_counter_block *merged,
+			       const struct tr2_counter_block *src);
+
+/*
+ * Send counter data for all counters in this block to the target.
+ *
+ * This will generate an event record for each counter that had activity.
+ */
+void tr2_emit_counter_block(tr2_tgt_evt_counter_t *pfn,
+			    uint64_t us_elapsed_absolute,
+			    const struct tr2_counter_block *blk,
+			    const char *thread_name);
+
+#endif /* TR2_CTR_H */
diff --git a/trace2/tr2_tls.c b/trace2/tr2_tls.c
index 675f6aeef31..28ea55863d1 100644
--- a/trace2/tr2_tls.c
+++ b/trace2/tr2_tls.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "thread-utils.h"
+#include "trace2/tr2_ctr.h"
 #include "trace2/tr2_tls.h"
 #include "trace2/tr2_tmr.h"
 
@@ -233,3 +234,31 @@ void tr2_emit_timers_by_thread(tr2_tgt_evt_timer_t *pfn,
 		ctx = next;
 	}
 }
+
+void tr2tls_aggregate_counter_blocks(struct tr2_counter_block *merged)
+{
+	struct tr2tls_thread_ctx *ctx = tr2tls_ctx_list;
+
+	while (ctx) {
+		struct tr2tls_thread_ctx *next = ctx->next_ctx;
+
+		tr2_merge_counter_block(merged, &ctx->counters);
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
+		tr2_emit_counter_block(pfn, us_elapsed_absolute, &ctx->counters,
+				       ctx->thread_name);
+
+		ctx = next;
+	}
+}
diff --git a/trace2/tr2_tls.h b/trace2/tr2_tls.h
index 72e37beb1e7..503829bbd44 100644
--- a/trace2/tr2_tls.h
+++ b/trace2/tr2_tls.h
@@ -2,6 +2,7 @@
 #define TR2_TLS_H
 
 #include "strbuf.h"
+#include "trace2/tr2_ctr.h"
 #include "trace2/tr2_tmr.h"
 
 struct tr2tls_thread_ctx {
@@ -12,10 +13,25 @@ struct tr2tls_thread_ctx {
 	int thread_id;
 
 	struct tr2_timer_block timers;
+	struct tr2_counter_block counters;
 
 	char thread_name[FLEX_ARRAY];
 };
 
+/*
+ * Iterate over the global list of threads and aggregate the
+ * counter data into the given counter block.  The resulting block
+ * will contain the global counter sums.
+ */
+void tr2tls_aggregate_counter_blocks(struct tr2_counter_block *merged);
+
+/*
+ * Iterate over the global list of threads and emit "per-thread"
+ * counter data for each.
+ */
+void tr2tls_emit_counter_blocks_by_thread(tr2_tgt_evt_counter_t *pfn,
+					  uint64_t us_elapsed_absolute);
+
 /*
  * Iterate over the global list of threads and aggregate the timer
  * data into the given timer block.  The resulting block will contain
-- 
gitgitgadget
