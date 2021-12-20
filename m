Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11E8C433F5
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 15:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239653AbhLTPVq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 10:21:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240281AbhLTPTx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 10:19:53 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DC0C019D92
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 07:01:16 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id b73so7102719wmd.0
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 07:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uKcgXVgq1f37HkR4Ln5fYXBlIfuAHUGpJ3P0vMT5TNI=;
        b=NJ98v1banzRt8G+Bb7ecs3lFJUhQP9I0KbkCJxWAsO27FZZmfdqfVOuK0H6nGHw8zB
         Uq3GelIxaP1T59i2DdK+I59+pX94JROH/3BAxMyCuC3kaYZimBPQMMfH8RfMa3ZY7J36
         o+exT6GGzrXAu386k3F2G5z20lE6S9iy8QPKpRScJMeN4QszMuigETzkcSMjs7zXkmLo
         HiMRRYgYrZToOMG6vNfbs8STuE9w2Jl0biSi6cotjvVmIp7/cvtqwQNmO4A8uJ9ooC6R
         3hUDYGwF0sPMNxFfVnVP7qeb1bdX1FDlDALN9NVc9Cb7eBiUhs3aS6rZEf8dahYCMkni
         a2zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uKcgXVgq1f37HkR4Ln5fYXBlIfuAHUGpJ3P0vMT5TNI=;
        b=fnhXx/AQ0PCvT75hLX/NeAXPQVlFz4zF58uMwtocIGLYBRIQghWwluRC9PzsBVNtaU
         mekbjrzcgHgLX1ME9IuVLLfegT4Dp+bMoeJE3bxUUVqCjPfStSu9SCUyRS4Zev1LfTTf
         boXlMbcQdrrXHgT2SVIUKxulB/oNMePy73Lb6IG4VlkskE3F0zA+Ep23QtBFq01I7Mkv
         IFLys7gWTk1aRok5EjjRF5U9T3Sq9zsSVse1xTmvZSzUR2aY/SdevVbP8Y9NsFBn7Rwe
         KQsQffDVBr9AY+F53S2BCD3IrPGbZwxrf4vUGeNDRO7sQNMAB96Ib6WtKlxMwUjisXe+
         097w==
X-Gm-Message-State: AOAM533EzfHC5N12kbu4Sdc6j+ejcewoF/h/WkRGZ3z8MRNj7YP5/7Uf
        y2zxD5giB+vqCQ0mjDXlW2sjWodmFHU=
X-Google-Smtp-Source: ABdhPJx5dvSSOIBYzfg+75cnsye0U8PaDIG6CxG40eZwY2XK/Hfx5l32q1UUpLh0euuX8FXqh6Zw4w==
X-Received: by 2002:a1c:a5c5:: with SMTP id o188mr14621515wme.22.1640012474781;
        Mon, 20 Dec 2021 07:01:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o7sm1407766wrc.89.2021.12.20.07.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 07:01:14 -0800 (PST)
Message-Id: <dd4f0576254defa3ab0e73a73c9c433f28fcca5b.1640012469.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1099.git.1640012469.gitgitgadget@gmail.com>
References: <pull.1099.git.1640012469.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Dec 2021 15:01:07 +0000
Subject: [PATCH 7/9] trace2: add stopwatch timers
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

Add a stopwatch timer mechanism to Git.

Timers are an alternative to regions.  Timers can capture a series of
intervals, such as calls to a library routine or a span of code.  They
are intended for code that is not necessarily associated with a
particular phase of the command.

Timer data is accumulated throughout the command and a timer "summary"
event is logged (one per timer) at program exit.

Optionally, timer data may also be reported by thread for certain
timers.  (See trace2/tr2_tmr.c:tr2tmr_def_block[].)

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Documentation/technical/api-trace2.txt |  48 ++++++++++
 Makefile                               |   1 +
 t/helper/test-trace2.c                 |  98 +++++++++++++++++++
 t/t0211-trace2-perf.sh                 |  25 +++++
 t/t0212-trace2-event.sh                |  35 +++++++
 trace2.c                               |  62 ++++++++++++
 trace2.h                               |  42 +++++++++
 trace2/tr2_tls.c                       |  29 ++++++
 trace2/tr2_tls.h                       |  17 ++++
 trace2/tr2_tmr.c                       | 126 +++++++++++++++++++++++++
 trace2/tr2_tmr.h                       | 120 +++++++++++++++++++++++
 11 files changed, 603 insertions(+)
 create mode 100644 trace2/tr2_tmr.c
 create mode 100644 trace2/tr2_tmr.h

diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
index e6ed94ba814..03a61332a2d 100644
--- a/Documentation/technical/api-trace2.txt
+++ b/Documentation/technical/api-trace2.txt
@@ -1230,6 +1230,54 @@ at offset 508.
 This example also shows that thread names are assigned in a racy manner
 as each thread starts and allocates TLS storage.
 
+Timer Events::
+
+	Trace2 also provides global stopwatch timers as an alternative
+	to regions.  These make it possible to measure the time spent
+	in a span of code or a library routine called from many places
+	and not	associated with a single phase of the overall command.
++
+At the end of the program, a single summary timer event is emitted; this
+aggregates timer usage across all threads.  These events have "summary"
+as their thread name.
++
+For some timers, individual (per-thread) timer events are also generated.
+These may be helpful in understanding how work is balanced between threads
+in some circumstances.
++
+Timers are defined in `enum trace2_timer_id` in trace2.h and in
+`trace2/tr2_tmr.c:tr2tmr_def_block[]`.
++
+----------------
+static void *unpack_compressed_entry(struct packed_git *p,
+				    struct pack_window **w_curs,
+				    off_t curpos,
+				    unsigned long size)
+{
+	...
+	trace2_timer_start(TRACE2_TIMER_ID__TEST1);
+	git_inflate_init(&stream);
+	...
+	git_inflate_end(&stream);
+	trace2_timer_stop(TRACE2_TIMER_ID__TEST1);
+	...
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
+d0 | summary                  | timer        |     |  0.111026 |           | test         | name:test1 count:4 total: 0.000393 min: 0.000006 max: 0.000302
+d0 | main                     | atexit       |     |  0.111026 |           |              | code:0
+----------------
++
+In this example, the "test1" timer was started 4 times and ran for
+0.000393 seconds.
+
 == Future Work
 
 === Relationship to the Existing Trace Api (api-trace.txt)
diff --git a/Makefile b/Makefile
index ed75ed422b5..8b657f0162a 100644
--- a/Makefile
+++ b/Makefile
@@ -1022,6 +1022,7 @@ LIB_OBJS += trace2/tr2_cfg.o
 LIB_OBJS += trace2/tr2_cmd_name.o
 LIB_OBJS += trace2/tr2_dst.o
 LIB_OBJS += trace2/tr2_sid.o
+LIB_OBJS += trace2/tr2_tmr.o
 LIB_OBJS += trace2/tr2_sysenv.o
 LIB_OBJS += trace2/tr2_tbuf.o
 LIB_OBJS += trace2/tr2_tgt_event.o
diff --git a/t/helper/test-trace2.c b/t/helper/test-trace2.c
index f93633f895a..e98db5ba4c1 100644
--- a/t/helper/test-trace2.c
+++ b/t/helper/test-trace2.c
@@ -206,6 +206,102 @@ static int ut_007bug(int argc, const char **argv)
 	BUG("the bug message");
 }
 
+/*
+ * Single-threaded timer test.  Create several intervals using the
+ * TEST1 timer.  The test script can verify that an aggregate Trace2
+ * "timer" event is emitted indicating that we started+stopped the
+ * timer the requested number of times.
+ */
+static int ut_008timer(int argc, const char **argv)
+{
+	const char *usage_error =
+		"expect <count> <ms_delay>";
+
+	int count = 0;
+	int delay = 0;
+	int k;
+
+	if (argc != 2)
+		die("%s", usage_error);
+	if (get_i(&count, argv[0]))
+		die("%s", usage_error);
+	if (get_i(&delay, argv[1]))
+		die("%s", usage_error);
+
+	for (k = 0; k < count; k++) {
+		trace2_timer_start(TRACE2_TIMER_ID_TEST1);
+		sleep_millisec(delay);
+		trace2_timer_stop(TRACE2_TIMER_ID_TEST1);
+	}
+
+	return 0;
+}
+
+struct ut_009_data {
+	int count;
+	int delay;
+};
+
+static void *ut_009timer_thread_proc(void *_ut_009_data)
+{
+	struct ut_009_data *data = _ut_009_data;
+	int k;
+
+	trace2_thread_start("ut_009");
+
+	for (k = 0; k < data->count; k++) {
+		trace2_timer_start(TRACE2_TIMER_ID_TEST2);
+		sleep_millisec(data->delay);
+		trace2_timer_stop(TRACE2_TIMER_ID_TEST2);
+	}
+
+	trace2_thread_exit();
+	return NULL;
+}
+
+
+/*
+ * Multi-threaded timer test.  Create several threads that each create
+ * several intervals using the TEST2 timer.  The test script can verify
+ * that an individual Trace2 "timer" event for each thread and an
+ * aggregate "timer" event are generated.
+ */
+static int ut_009timer(int argc, const char **argv)
+{
+	const char *usage_error =
+		"expect <count> <ms_delay> <threads>";
+
+	struct ut_009_data data = { 0, 0 };
+	int nr_threads = 0;
+	int k;
+	pthread_t *pids = NULL;
+
+	if (argc != 3)
+		die("%s", usage_error);
+	if (get_i(&data.count, argv[0]))
+		die("%s", usage_error);
+	if (get_i(&data.delay, argv[1]))
+		die("%s", usage_error);
+	if (get_i(&nr_threads, argv[2]))
+		die("%s", usage_error);
+
+	CALLOC_ARRAY(pids, nr_threads);
+
+	for (k = 0; k < nr_threads; k++) {
+		if (pthread_create(&pids[k], NULL, ut_009timer_thread_proc, &data))
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
@@ -223,6 +319,8 @@ static struct unit_test ut_table[] = {
 	{ ut_005exec,     "005exec",   "<git_command_args>" },
 	{ ut_006data,     "006data",   "[<category> <key> <value>]+" },
 	{ ut_007bug,      "007bug",    "" },
+	{ ut_008timer,    "008timer",  "<count> <ms_delay>" },
+	{ ut_009timer,    "009timer",  "<count> <ms_delay> <threads>" },
 };
 /* clang-format on */
 
diff --git a/t/t0211-trace2-perf.sh b/t/t0211-trace2-perf.sh
index 22d0845544e..5c99d734ea2 100755
--- a/t/t0211-trace2-perf.sh
+++ b/t/t0211-trace2-perf.sh
@@ -173,4 +173,29 @@ test_expect_success 'using global config, perf stream, return code 0' '
 	test_cmp expect actual
 '
 
+# Exercise the stopwatch timer "test" in a loop and confirm that it was
+# we have as many start/stop intervals as expected.  We cannot really test
+# the (elapsed, min, max) timer values, so we assume they are good.
+#
+test_expect_success 'test stopwatch timers - summary only' '
+	test_when_finished "rm trace.perf actual" &&
+	test_config_global trace2.perfBrief 1 &&
+	test_config_global trace2.perfTarget "$(pwd)/trace.perf" &&
+	test-tool trace2 008timer 5 10 &&
+	perl "$TEST_DIRECTORY/t0211/scrub_perf.perl" <trace.perf >actual &&
+	grep "d0|summary|timer||_T_ABS_||test|name:test1 count:5" actual
+'
+
+test_expect_success 'test stopwatch timers - summary and threads' '
+	test_when_finished "rm trace.perf actual" &&
+	test_config_global trace2.perfBrief 1 &&
+	test_config_global trace2.perfTarget "$(pwd)/trace.perf" &&
+	test-tool trace2 009timer 5 10 3 &&
+	perl "$TEST_DIRECTORY/t0211/scrub_perf.perl" <trace.perf >actual &&
+	grep "d0|th01:ut_009|timer||_T_ABS_||test|name:test2 count:5" actual &&
+	grep "d0|th02:ut_009|timer||_T_ABS_||test|name:test2 count:5" actual &&
+	grep "d0|th02:ut_009|timer||_T_ABS_||test|name:test2 count:5" actual &&
+	grep "d0|summary|timer||_T_ABS_||test|name:test2 count:15" actual
+'
+
 test_done
diff --git a/t/t0212-trace2-event.sh b/t/t0212-trace2-event.sh
index 6d3374ff773..462c001deca 100755
--- a/t/t0212-trace2-event.sh
+++ b/t/t0212-trace2-event.sh
@@ -323,4 +323,39 @@ test_expect_success 'discard traces when there are too many files' '
 	head -n2 trace_target_dir/git-trace2-discard | tail -n1 | grep \"event\":\"too_many_files\"
 '
 
+# Exercise the stopwatch timer "test" in a loop and confirm that it was
+# we have as many start/stop intervals as expected.  We cannot really test
+# the (t_timer, t_min, t_max) timer values, so we assume they are good.
+#
+
+have_timer_event () {
+	thread=$1
+	name=$2
+	count=$3
+	file=$4
+
+	grep "\"event\":\"timer\".*\"thread\":\"${thread}\".*\"name\":\"${name}\".*\"count\":${count}" $file
+
+	return $?
+}
+
+test_expect_success 'test stopwatch timers - global, single-thread' '
+	test_when_finished "rm trace.event" &&
+	test_config_global trace2.eventBrief 1 &&
+	test_config_global trace2.eventTarget "$(pwd)/trace.event" &&
+	test-tool trace2 008timer 5 10 &&
+	have_timer_event "summary" "test1" 5 trace.event
+'
+
+test_expect_success 'test stopwatch timers - global+threads' '
+	test_when_finished "rm trace.event" &&
+	test_config_global trace2.eventBrief 1 &&
+	test_config_global trace2.eventTarget "$(pwd)/trace.event" &&
+	test-tool trace2 009timer 5 10 3 &&
+	have_timer_event "th01:ut_009" "test2" 5 trace.event &&
+	have_timer_event "th02:ut_009" "test2" 5 trace.event &&
+	have_timer_event "th03:ut_009" "test2" 5 trace.event &&
+	have_timer_event "summary" "test2" 15 trace.event
+'
+
 test_done
diff --git a/trace2.c b/trace2.c
index b2d471526fd..c073ffa836f 100644
--- a/trace2.c
+++ b/trace2.c
@@ -13,6 +13,7 @@
 #include "trace2/tr2_sysenv.h"
 #include "trace2/tr2_tgt.h"
 #include "trace2/tr2_tls.h"
+#include "trace2/tr2_tmr.h"
 
 static int trace2_enabled;
 
@@ -83,6 +84,42 @@ static void tr2_tgt_disable_builtins(void)
 		tgt_j->pfn_term();
 }
 
+static void tr2main_emit_summary_timers(uint64_t us_elapsed_absolute)
+{
+	struct tr2_tgt *tgt_j;
+	int j;
+	struct tr2tmr_block merged;
+
+	memset(&merged, 0, sizeof(merged));
+
+	/*
+	 * Sum across all of the per-thread stopwatch timer data into
+	 * a single composite block of timer values.
+	 */
+	tr2tls_aggregate_timer_blocks(&merged);
+
+	/*
+	 * Emit "summary" timer events for each composite timer value
+	 * that had activity.
+	 */
+	for_each_wanted_builtin (j, tgt_j)
+		if (tgt_j->pfn_timer)
+			tr2tmr_emit_block(tgt_j->pfn_timer,
+					  us_elapsed_absolute,
+					  &merged, "summary");
+}
+
+static void tr2main_emit_thread_timers(uint64_t us_elapsed_absolute)
+{
+	struct tr2_tgt *tgt_j;
+	int j;
+
+	for_each_wanted_builtin (j, tgt_j)
+		if (tgt_j->pfn_timer)
+			tr2tls_emit_timer_blocks_by_thread(tgt_j->pfn_timer,
+							   us_elapsed_absolute);
+}
+
 static int tr2main_exit_code;
 
 /*
@@ -110,6 +147,9 @@ static void tr2main_atexit_handler(void)
 	 */
 	tr2tls_pop_unwind_self();
 
+	tr2main_emit_thread_timers(us_elapsed_absolute);
+	tr2main_emit_summary_timers(us_elapsed_absolute);
+
 	for_each_wanted_builtin (j, tgt_j)
 		if (tgt_j->pfn_atexit)
 			tgt_j->pfn_atexit(us_elapsed_absolute,
@@ -841,3 +881,25 @@ const char *trace2_session_id(void)
 {
 	return tr2_sid_get();
 }
+
+void trace2_timer_start(enum trace2_timer_id tid)
+{
+	if (!trace2_enabled)
+		return;
+
+	if (tid < 0 || tid >= TRACE2_NUMBER_OF_TIMERS)
+		BUG("invalid timer id: %d", tid);
+
+	tr2tmr_start(tid);
+}
+
+void trace2_timer_stop(enum trace2_timer_id tid)
+{
+	if (!trace2_enabled)
+		return;
+
+	if (tid < 0 || tid >= TRACE2_NUMBER_OF_TIMERS)
+		BUG("invalid timer id: %d", tid);
+
+	tr2tmr_stop(tid);
+}
diff --git a/trace2.h b/trace2.h
index 0cc7b5f5312..32e2eaca7c8 100644
--- a/trace2.h
+++ b/trace2.h
@@ -51,6 +51,7 @@ struct json_writer;
  * [] trace2_region*    -- emit region nesting messages.
  * [] trace2_data*      -- emit region/thread/repo data messages.
  * [] trace2_printf*    -- legacy trace[1] messages.
+ * [] trace2_timer*     -- start/stop stopwatch timer (messages are deferred).
  */
 
 /*
@@ -531,4 +532,45 @@ void trace2_collect_process_info(enum trace2_process_info_reason reason);
 
 const char *trace2_session_id(void);
 
+/*
+ * Define the set of stopwatch timers.
+ *
+ * We can add more at any time, but they must be defined at compile
+ * time (to avoid the need to dynamically allocate and synchronize
+ * them between different threads).
+ *
+ * These must start at 0 and be contiguous (because we use them
+ * elsewhere as array indexes).
+ *
+ * Any values added to this enum must also be added to the timer definitions
+ * array.  See `trace2/tr2_tmr.c:tr2tmr_def_block[]`.
+ */
+enum trace2_timer_id {
+	/*
+	 * Define two timers for testing.  See `t/helper/test-trace2.c`.
+	 * These can be used for ad hoc testing, but should not be used
+	 * for permanent analysis code.
+	 */
+	TRACE2_TIMER_ID_TEST1 = 0, /* emits summary event only */
+	TRACE2_TIMER_ID_TEST2,     /* emits summary and thread events */
+
+
+	/* Add additional timer definitions before here. */
+	TRACE2_NUMBER_OF_TIMERS
+};
+
+/*
+ * Start/Stop a stopwatch timer in the current thread.
+ *
+ * The time spent in each start/stop interval will be accumulated and
+ * a "timer" event will be emitted when the program exits.
+ *
+ * Note: Since the stopwatch API routines do not generate individual
+ * events, they do not take (file, line) arguments.  Similarly, the
+ * category and timer name values are defined at compile-time in the
+ * timer definitions array, so they are not needed here in the API.
+ */
+void trace2_timer_start(enum trace2_timer_id tid);
+void trace2_timer_stop(enum trace2_timer_id tid);
+
 #endif /* TRACE2_H */
diff --git a/trace2/tr2_tls.c b/trace2/tr2_tls.c
index b68d297bf51..068938d334e 100644
--- a/trace2/tr2_tls.c
+++ b/trace2/tr2_tls.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "thread-utils.h"
 #include "trace2/tr2_tls.h"
+#include "trace2/tr2_tmr.h"
 
 /*
  * Initialize size of the thread stack for nested regions.
@@ -199,3 +200,31 @@ int tr2tls_locked_increment(int *p)
 
 	return current_value;
 }
+
+void tr2tls_aggregate_timer_blocks(struct tr2tmr_block *merged)
+{
+	struct tr2tls_thread_ctx *ctx = tr2tls_ctx_list;
+
+	while (ctx) {
+		struct tr2tls_thread_ctx *next = ctx->next_ctx;
+
+		tr2tmr_aggregate_timers(merged, &ctx->timers);
+
+		ctx = next;
+	}
+}
+
+void tr2tls_emit_timer_blocks_by_thread(tr2_tgt_evt_timer_t *pfn,
+					uint64_t us_elapsed_absolute)
+{
+	struct tr2tls_thread_ctx *ctx = tr2tls_ctx_list;
+
+	while (ctx) {
+		struct tr2tls_thread_ctx *next = ctx->next_ctx;
+
+		tr2tmr_emit_block(pfn, us_elapsed_absolute, &ctx->timers,
+				  ctx->thread_name);
+
+		ctx = next;
+	}
+}
diff --git a/trace2/tr2_tls.h b/trace2/tr2_tls.h
index c6b6c69b25a..10669f0d7b9 100644
--- a/trace2/tr2_tls.h
+++ b/trace2/tr2_tls.h
@@ -2,6 +2,7 @@
 #define TR2_TLS_H
 
 #include "strbuf.h"
+#include "trace2/tr2_tmr.h"
 
 /*
  * Arbitry limit for thread names for column alignment.
@@ -15,8 +16,24 @@ struct tr2tls_thread_ctx {
 	size_t alloc;
 	size_t nr_open_regions; /* plays role of "nr" in ALLOC_GROW */
 	int thread_id;
+
+	struct tr2tmr_block timers;
 };
 
+/*
+ * Iterate over the global list of TLS CTX data and aggregate the timer
+ * data into the given timer block.
+ */
+void tr2tls_aggregate_timer_blocks(struct tr2tmr_block *merged);
+
+/*
+ * Iterate over the global list of TLS CTX data (the complete set of
+ * threads that have used Trace2 resources) data and emit "per-thread"
+ * timer data for each.
+ */
+void tr2tls_emit_timer_blocks_by_thread(tr2_tgt_evt_timer_t *pfn,
+					uint64_t us_elapsed_absolute);
+
 /*
  * Create TLS data for the current thread.  This gives us a place to
  * put per-thread data, such as thread start time, function nesting
diff --git a/trace2/tr2_tmr.c b/trace2/tr2_tmr.c
new file mode 100644
index 00000000000..216cbd04cca
--- /dev/null
+++ b/trace2/tr2_tmr.c
@@ -0,0 +1,126 @@
+#include "cache.h"
+#include "thread-utils.h"
+#include "trace2/tr2_tls.h"
+#include "trace2/tr2_tmr.h"
+
+/*
+ * Define metadata for each stopwatch timer.  This list must match the
+ * set defined in "enum trace2_timer_id".
+ */
+struct tr2tmr_def {
+	const char *category;
+	const char *name;
+
+	unsigned int want_thread_events:1;
+};
+
+static struct tr2tmr_def tr2tmr_def_block[TRACE2_NUMBER_OF_TIMERS] = {
+	[TRACE2_TIMER_ID_TEST1] = { "test", "test1", 0 },
+	[TRACE2_TIMER_ID_TEST2] = { "test", "test2", 1 },
+};
+
+void tr2tmr_start(enum trace2_timer_id tid)
+{
+	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
+	struct tr2tmr_timer *t = &ctx->timers.timer[tid];
+
+	t->recursion_count++;
+	if (t->recursion_count > 1)
+		return; /* ignore recursive starts */
+
+	t->start_us = getnanotime() / 1000;
+}
+
+void tr2tmr_stop(enum trace2_timer_id tid)
+{
+	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
+	struct tr2tmr_timer *t = &ctx->timers.timer[tid];
+	uint64_t us_now;
+	uint64_t us_interval;
+
+	assert(t->recursion_count > 0);
+
+	t->recursion_count--;
+	if (t->recursion_count > 0)
+		return; /* still in recursive call */
+
+	us_now = getnanotime() / 1000;
+	us_interval = us_now - t->start_us;
+
+	t->total_us += us_interval;
+
+	if (!t->interval_count) {
+		t->min_us = us_interval;
+		t->max_us = us_interval;
+	} else {
+		if (us_interval < t->min_us)
+			t->min_us = us_interval;
+		if (us_interval > t->max_us)
+			t->max_us = us_interval;
+	}
+
+	t->interval_count++;
+}
+
+void tr2tmr_aggregate_timers(struct tr2tmr_block *merged,
+			     const struct tr2tmr_block *src)
+{
+	enum trace2_timer_id tid;
+
+	for (tid = 0; tid < TRACE2_NUMBER_OF_TIMERS; tid++) {
+		struct tr2tmr_timer *t_merged = &merged->timer[tid];
+		const struct tr2tmr_timer *t = &src->timer[tid];
+
+		t_merged->is_aggregate = 1;
+
+		if (t->recursion_count > 0) {
+			/*
+			 * A thread exited with a stopwatch running.
+			 *
+			 * NEEDSWORK: should we assert or throw a warning
+			 * for the open interval.  I'm going to ignore it
+			 * and keep going because we may have valid data
+			 * for previously closed intervals on this timer.
+			 */
+		}
+
+		if (!t->interval_count)
+			continue; /* this timer was not used by this thread. */
+
+		t_merged->total_us += t->total_us;
+
+		if (!t_merged->interval_count) {
+			t_merged->min_us = t->min_us;
+			t_merged->max_us = t->max_us;
+		} else {
+			if (t->min_us < t_merged->min_us)
+				t_merged->min_us = t->min_us;
+			if (t->max_us > t_merged->max_us)
+				t_merged->max_us = t->max_us;
+		}
+
+		t_merged->interval_count += t->interval_count;
+	}
+
+	merged->is_aggregate = 1;
+}
+
+void tr2tmr_emit_block(tr2_tgt_evt_timer_t *pfn, uint64_t us_elapsed_absolute,
+		       const struct tr2tmr_block *blk, const char *thread_name)
+{
+	enum trace2_timer_id tid;
+
+	for (tid = 0; tid < TRACE2_NUMBER_OF_TIMERS; tid++) {
+		const struct tr2tmr_timer *t = &blk->timer[tid];
+		const struct tr2tmr_def *d = &tr2tmr_def_block[tid];
+
+		if (!t->interval_count)
+			continue; /* timer was not used */
+
+		if (!d->want_thread_events && !t->is_aggregate)
+			continue; /* per-thread events not wanted */
+
+		pfn(us_elapsed_absolute, thread_name, d->category, d->name,
+		    t->interval_count, t->total_us, t->min_us, t->max_us);
+	}
+}
diff --git a/trace2/tr2_tmr.h b/trace2/tr2_tmr.h
new file mode 100644
index 00000000000..72f34f36d5f
--- /dev/null
+++ b/trace2/tr2_tmr.h
@@ -0,0 +1,120 @@
+#ifndef TR2_TM_H
+#define TR2_TM_H
+
+#include "trace2.h"
+#include "trace2/tr2_tgt.h"
+
+/*
+ * Define a mechanism to allow "stopwatch" timers.
+ *
+ * Timers can be used to measure "interesting" activity that does not
+ * fit the "region" model, such as code called from many different
+ * regions (like zlib) and/or where data for individual calls are not
+ * interesting or are too numerous to be efficiently logged.
+ *
+ * Timer values are accumulated during program execution and emitted
+ * to the Trace2 logs at program exit.
+ *
+ * To make this model efficient, we define a compile-time fixed set of
+ * timers and timer ids.  This lets us avoid the complexities of
+ * dynamically allocating a timer on demand and sharing that
+ * definition with other threads.
+ *
+ * Timer values are stored in a fixed size "timer block" inside the
+ * TLS CTX.  This allows data to be collected on a thread-by-thread
+ * basis without locking.
+ *
+ * We define (at compile time) a set of "timer ids" to access the
+ * various timers inside the fixed size "timer block".
+ *
+ * Timer definitions include the Trace2 "category" and similar fields.
+ * This eliminates the need to include those args on the various timer
+ * APIs.
+ *
+ * Timer results are summarized and emitted by the main thread at
+ * program exit by iterating over the global list of CTX data.
+ */
+
+/*
+ * The definition of an individual timer and used by an individual
+ * thread.
+ */
+struct tr2tmr_timer {
+	/*
+	 * Total elapsed time for this timer in this thread.
+	 */
+	uint64_t total_us;
+
+	/*
+	 * The maximum and minimum interval values observed for this
+	 * timer in this thread.
+	 */
+	uint64_t min_us;
+	uint64_t max_us;
+
+	/*
+	 * The value of the clock when this timer was started in this
+	 * thread.  (Undefined when the timer is not active in this
+	 * thread.)
+	 */
+	uint64_t start_us;
+
+	/*
+	 * Number of times that this timer has been started and stopped
+	 * in this thread.  (Recursive starts are ignored.)
+	 */
+	size_t interval_count;
+
+	/*
+	 * Number of nested starts on the stack in this thread.  (We
+	 * ignore recursive starts and use this to track the recursive
+	 * calls.)
+	 */
+	unsigned int recursion_count;
+
+	/*
+	 * Has data from multiple threads been combined into this object.
+	 */
+	unsigned int is_aggregate:1;
+};
+
+/*
+ * A compile-time fixed-size block of timers to insert into the TLS CTX.
+ *
+ * We use this simple wrapper around the array of timer instances to
+ * avoid C syntax quirks and the need to pass around an additional size_t
+ * argument.
+ */
+struct tr2tmr_block {
+	struct tr2tmr_timer timer[TRACE2_NUMBER_OF_TIMERS];
+
+	/*
+	 * Has data from multiple threads been combined into this block.
+	 */
+	unsigned int is_aggregate:1;
+};
+
+/*
+ * Private routines used by trace2.c to actually start/stop an individual
+ * timer in the current thread.
+ */
+void tr2tmr_start(enum trace2_timer_id tid);
+void tr2tmr_stop(enum trace2_timer_id tid);
+
+/*
+ * Accumulate timer data from source block into the merged block.
+ */
+void tr2tmr_aggregate_timers(struct tr2tmr_block *merged,
+			     const struct tr2tmr_block *src);
+
+/*
+ * Send stopwatch data for all of the timers in this block to the
+ * target.
+ *
+ * This will generate an event record for each timer that had activity
+ * during the program's execution.
+ */
+void tr2tmr_emit_block(tr2_tgt_evt_timer_t *pfn, uint64_t us_elapsed_absolute,
+		       const struct tr2tmr_block *blk, const char *thread_name);
+
+#endif /* TR2_TM_H */
-- 
gitgitgadget

