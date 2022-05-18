Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2AF6C433F5
	for <git@archiver.kernel.org>; Wed, 18 May 2022 20:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242259AbiERUFf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 May 2022 16:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242244AbiERUFe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 May 2022 16:05:34 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853672375D2
        for <git@vger.kernel.org>; Wed, 18 May 2022 13:05:32 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id k126-20020a1ca184000000b003943fd07180so1599764wme.3
        for <git@vger.kernel.org>; Wed, 18 May 2022 13:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zDIvb4GctMknH+vb94WMvGaJKCld3OdP+R0L/ci7OWI=;
        b=ce/rkdVjWJENDYIes+msEKqzOkDvnxw2ZIVYLQY0mlMpWEd2Xu7i+C72lsvPVDoDUJ
         wNc6fAeW/NfY8MdvGx2zweLUoASEXLwniSoIIKG/J5KeW3wc/qM+lMnDcbpa8BNK93GV
         ZYlZ6MPQqEBZhMW35MSTxqRCyvVyaViomANrxVs9QaEQDgMbNC5Fua0DSbjawhe7O5pS
         AQ6X5vPl0dpPoAP+xGEV3FevzDBCRuKTXGb/VsXFfR221c6SFeJMeB6HBxCiVBBymYTg
         01sMC48fFsiTSPlleBdxZfz9DmJgmKKdt7TJwIVZTgFYx888R+WS92V0vxW/X3+YcgI/
         iSUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zDIvb4GctMknH+vb94WMvGaJKCld3OdP+R0L/ci7OWI=;
        b=mPJByfWt7RJJVuv7hFphOdTTBSaCXdo/vqOypg6+94a2mpFIvBjGePJsBFOvACpdIT
         y4HsuZbkhiGdPaE8qOdxhdqIxAioFyx2hIBA2o2QrPcno2Nw4kN8CKbV1IDUE7XWn13G
         xXxWHuvmtPFB2u2SgvKCwbJYNeWFILC4BGffc1DOkVeMFD+lWoLNHdB/wNUNNZgCMQi9
         lU9M3X/zc5jXoJcQP5DQcBUZLGm9r+RXGtjwjfsWa528h6RX4cVdCTjKubfQnHdttgAP
         VUPV0ENgqAKGxdyNQL0G33zjkh60B23/X68O/2TGsaRuFkQVuw2mYnkjMqs7N7VUcgP1
         brlg==
X-Gm-Message-State: AOAM533+/qWZ1x5Q7hU9AFDb6IwnmoiqYHsdng9qWu4Gfseq9HhvZJFT
        XUBhOHLgO+WwT8nfuGa8Bc4s1qp3T3m7VA==
X-Google-Smtp-Source: ABdhPJzuictw1yLcSl8ziECY0iu40V58FI0hgLKljPJgReiNy39sJRfYzIuTdX1K38nnO/wNMLzC/Q==
X-Received: by 2002:a05:600c:382:b0:394:6172:59dc with SMTP id w2-20020a05600c038200b00394617259dcmr1400357wmd.120.1652904330841;
        Wed, 18 May 2022 13:05:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f18-20020adfb612000000b0020d00174eabsm2674441wre.94.2022.05.18.13.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 13:05:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Anthony Sottile <asottile@umich.edu>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/8] run-command API: use "opts" struct for run_processes_parallel{,_tr2}()
Date:   Wed, 18 May 2022 22:05:18 +0200
Message-Id: <patch-v2-2.8-5f0a6e9925f-20220518T195858Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.952.g0ae626f6cd7
In-Reply-To: <cover-v2-0.8-00000000000-20220518T195858Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20220421T122108Z-avarab@gmail.com> <cover-v2-0.8-00000000000-20220518T195858Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new "struct run_process_parallel_opts" to replace the growing
run_processes_parallel() and run_processes_parallel_tr2() argument
lists. This refactoring makes it easier to add new options and
parameters easier.

The *_tr2() variant of the function was added in ee4512ed481 (trace2:
create new combined trace facility, 2019-02-22), and has subsequently
been used by every caller except t/helper/test-run-command.c.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/fetch.c             | 18 +++++++++-----
 builtin/submodule--helper.c | 15 ++++++++----
 hook.c                      | 21 +++++++++-------
 run-command.c               | 48 ++++++++++++++++---------------------
 run-command.h               | 35 ++++++++++++++++++++-------
 submodule.c                 | 18 +++++++++-----
 t/helper/test-run-command.c | 17 ++++++++++---
 7 files changed, 109 insertions(+), 63 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index e3791f09ed5..d85bf135e66 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1948,14 +1948,20 @@ static int fetch_multiple(struct string_list *list, int max_children)
 
 	if (max_children != 1 && list->nr != 1) {
 		struct parallel_fetch_state state = { argv.v, list, 0, 0 };
+		struct run_process_parallel_opts run_opts = {
+			.tr2_category = "fetch",
+			.tr2_label = "parallel/fetch",
+
+			.jobs = max_children,
+
+			.get_next_task = &fetch_next_remote,
+			.start_failure = &fetch_failed_to_start,
+			.task_finished = &fetch_finished,
+			.data = &state,
+		};
 
 		strvec_push(&argv, "--end-of-options");
-		result = run_processes_parallel_tr2(max_children,
-						    &fetch_next_remote,
-						    &fetch_failed_to_start,
-						    &fetch_finished,
-						    &state,
-						    "fetch", "parallel/fetch");
+		result = run_processes_parallel(&run_opts);
 
 		if (!result)
 			result = state.result;
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 1a8e5d06214..756807e965d 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2651,12 +2651,19 @@ static int update_submodules(struct update_data *update_data)
 {
 	int i, res = 0;
 	struct submodule_update_clone suc = SUBMODULE_UPDATE_CLONE_INIT;
+	struct run_process_parallel_opts run_opts = {
+		.tr2_category = "submodule",
+		.tr2_label = "parallel/update",
+
+		.get_next_task = update_clone_get_next_task,
+		.start_failure = update_clone_start_failure,
+		.task_finished = update_clone_task_finished,
+		.data = &suc,
+	};
 
 	suc.update_data = update_data;
-	run_processes_parallel_tr2(suc.update_data->max_jobs, update_clone_get_next_task,
-				   update_clone_start_failure,
-				   update_clone_task_finished, &suc, "submodule",
-				   "parallel/update");
+	run_opts.jobs = suc.update_data->max_jobs;
+	run_processes_parallel(&run_opts);
 
 	/*
 	 * We saved the output and put it out all at once now.
diff --git a/hook.c b/hook.c
index 1d51be3b77a..9aefccfc34a 100644
--- a/hook.c
+++ b/hook.c
@@ -121,8 +121,19 @@ int run_hooks_opt(const char *hook_name, struct run_hooks_opt *options)
 		.options = options,
 	};
 	const char *const hook_path = find_hook(hook_name);
-	int jobs = 1;
+	const int jobs = 1;
 	int ret = 0;
+	struct run_process_parallel_opts run_opts = {
+		.tr2_category = "hook",
+		.tr2_label = hook_name,
+
+		.jobs = jobs,
+
+		.get_next_task = pick_next_hook,
+		.start_failure = notify_start_failure,
+		.task_finished = notify_hook_finished,
+		.data = &cb_data,
+	};
 
 	if (!options)
 		BUG("a struct run_hooks_opt must be provided to run_hooks");
@@ -144,13 +155,7 @@ int run_hooks_opt(const char *hook_name, struct run_hooks_opt *options)
 		cb_data.hook_path = abs_path.buf;
 	}
 
-	run_processes_parallel_tr2(jobs,
-				   pick_next_hook,
-				   notify_start_failure,
-				   notify_hook_finished,
-				   &cb_data,
-				   "hook",
-				   hook_name);
+	run_processes_parallel(&run_opts);
 	ret = cb_data.rc;
 cleanup:
 	strbuf_release(&abs_path);
diff --git a/run-command.c b/run-command.c
index a8501e38ceb..8c156fd080e 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1533,13 +1533,14 @@ static void handle_children_on_signal(int signo)
 }
 
 static void pp_init(struct parallel_processes *pp,
-		    int n,
-		    get_next_task_fn get_next_task,
-		    start_failure_fn start_failure,
-		    task_finished_fn task_finished,
-		    void *data)
+		    struct run_process_parallel_opts *opts)
 {
 	int i;
+	int n = opts->jobs;
+	void *data = opts->data;
+	get_next_task_fn get_next_task = opts->get_next_task;
+	start_failure_fn start_failure = opts->start_failure;
+	task_finished_fn task_finished = opts->task_finished;
 
 	if (n < 1)
 		n = online_cpus();
@@ -1738,18 +1739,23 @@ static int pp_collect_finished(struct parallel_processes *pp)
 	return result;
 }
 
-int run_processes_parallel(int n,
-			   get_next_task_fn get_next_task,
-			   start_failure_fn start_failure,
-			   task_finished_fn task_finished,
-			   void *pp_cb)
+int run_processes_parallel(struct run_process_parallel_opts *opts)
 {
 	int i, code;
 	int output_timeout = 100;
 	int spawn_cap = 4;
 	struct parallel_processes pp;
+	const char *tr2_category = opts->tr2_category;
+	const char *tr2_label = opts->tr2_label;
+	const int do_trace2 = tr2_category && tr2_label;
+	const int n = opts->jobs;
 
-	pp_init(&pp, n, get_next_task, start_failure, task_finished, pp_cb);
+	if (do_trace2)
+		trace2_region_enter_printf(tr2_category, tr2_label, NULL,
+					   "max:%d", ((n < 1) ? online_cpus()
+						      : n));
+
+	pp_init(&pp, opts);
 	while (1) {
 		for (i = 0;
 		    i < spawn_cap && !pp.shutdown &&
@@ -1777,25 +1783,11 @@ int run_processes_parallel(int n,
 	}
 
 	pp_cleanup(&pp);
-	return 0;
-}
-
-int run_processes_parallel_tr2(int n, get_next_task_fn get_next_task,
-			       start_failure_fn start_failure,
-			       task_finished_fn task_finished, void *pp_cb,
-			       const char *tr2_category, const char *tr2_label)
-{
-	int result;
 
-	trace2_region_enter_printf(tr2_category, tr2_label, NULL, "max:%d",
-				   ((n < 1) ? online_cpus() : n));
+	if (do_trace2)
+		trace2_region_leave(tr2_category, tr2_label, NULL);
 
-	result = run_processes_parallel(n, get_next_task, start_failure,
-					task_finished, pp_cb);
-
-	trace2_region_leave(tr2_category, tr2_label, NULL);
-
-	return result;
+	return 0;
 }
 
 int run_auto_maintenance(int quiet)
diff --git a/run-command.h b/run-command.h
index 5bd0c933e80..b0268ed3db1 100644
--- a/run-command.h
+++ b/run-command.h
@@ -458,6 +458,32 @@ typedef int (*task_finished_fn)(int result,
 				void *pp_task_cb);
 
 /**
+ * Options to pass to run_processes_parallel(), { 0 }-initialized
+ * means no options. Fields:
+ *
+ * tr2_category & tr2_label: sets the trace2 category and label for
+ * logging. These must either be unset, or both of them must be set.
+ *
+ * jobs: see 'n' in run_processes_parallel() below.
+ *
+ * *_fn & data: see run_processes_parallel() below.
+ */
+struct run_process_parallel_opts
+{
+	const char *tr2_category;
+	const char *tr2_label;
+
+	int jobs;
+
+	get_next_task_fn get_next_task;
+	start_failure_fn start_failure;
+	task_finished_fn task_finished;
+	void *data;
+};
+
+/**
+ * Options are passed via the "struct run_process_parallel_opts" above.
+
  * Runs up to n processes at the same time. Whenever a process can be
  * started, the callback get_next_task_fn is called to obtain the data
  * required to start another child process.
@@ -469,14 +495,7 @@ typedef int (*task_finished_fn)(int result,
  * start_failure_fn and task_finished_fn can be NULL to omit any
  * special handling.
  */
-int run_processes_parallel(int n,
-			   get_next_task_fn,
-			   start_failure_fn,
-			   task_finished_fn,
-			   void *pp_cb);
-int run_processes_parallel_tr2(int n, get_next_task_fn, start_failure_fn,
-			       task_finished_fn, void *pp_cb,
-			       const char *tr2_category, const char *tr2_label);
+int run_processes_parallel(struct run_process_parallel_opts *opts);
 
 /**
  * Convenience function which prepares env_array for a command to be run in a
diff --git a/submodule.c b/submodule.c
index 86c8f0f89db..8cbcd3fce23 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1817,6 +1817,17 @@ int fetch_submodules(struct repository *r,
 {
 	int i;
 	struct submodule_parallel_fetch spf = SPF_INIT;
+	struct run_process_parallel_opts run_opts = {
+		.tr2_category = "submodule",
+		.tr2_label = "parallel/fetch",
+
+		.jobs = max_parallel_jobs,
+
+		.get_next_task = get_next_submodule,
+		.start_failure = fetch_start_failure,
+		.task_finished = fetch_finish,
+		.data = &spf,
+	};
 
 	spf.r = r;
 	spf.command_line_option = command_line_option;
@@ -1838,12 +1849,7 @@ int fetch_submodules(struct repository *r,
 
 	calculate_changed_submodule_paths(r, &spf.changed_submodule_names);
 	string_list_sort(&spf.changed_submodule_names);
-	run_processes_parallel_tr2(max_parallel_jobs,
-				   get_next_submodule,
-				   fetch_start_failure,
-				   fetch_finish,
-				   &spf,
-				   "submodule", "parallel/fetch");
+	run_processes_parallel(&run_opts);
 
 	if (spf.submodules_with_errors.len > 0)
 		fprintf(stderr, _("Errors during submodule fetch:\n%s"),
diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index bd98dd9624b..56a806f228b 100644
--- a/t/helper/test-run-command.c
+++ b/t/helper/test-run-command.c
@@ -142,6 +142,12 @@ static int testsuite(int argc, const char **argv)
 			 "write JUnit-style XML files"),
 		OPT_END()
 	};
+	struct run_process_parallel_opts run_opts = {
+		.get_next_task = next_test,
+		.start_failure = test_failed,
+		.task_finished = test_finished,
+		.data = &suite,
+	};
 
 	argc = parse_options(argc, argv, NULL, options,
 			testsuite_usage, PARSE_OPT_STOP_AT_NON_OPTION);
@@ -181,9 +187,9 @@ static int testsuite(int argc, const char **argv)
 
 	fprintf(stderr, "Running %"PRIuMAX" tests (%d at a time)\n",
 		(uintmax_t)suite.tests.nr, max_jobs);
+	run_opts.jobs = max_jobs;
 
-	ret = run_processes_parallel(max_jobs, next_test, test_failed,
-				     test_finished, &suite);
+	ret = run_processes_parallel(&run_opts);
 
 	if (suite.failed.nr > 0) {
 		ret = 1;
@@ -373,6 +379,7 @@ int cmd__run_command(int argc, const char **argv)
 	int jobs;
 	get_next_task_fn next_fn = NULL;
 	task_finished_fn finished_fn = NULL;
+	struct run_process_parallel_opts opts = { 0 };
 
 	if (argc > 1 && !strcmp(argv[1], "testsuite"))
 		exit(testsuite(argc - 1, argv + 1));
@@ -412,6 +419,8 @@ int cmd__run_command(int argc, const char **argv)
 	jobs = atoi(argv[2]);
 	strvec_clear(&proc.args);
 	strvec_pushv(&proc.args, (const char **)argv + 3);
+	opts.jobs = jobs;
+	opts.data = &proc;
 
 	if (!strcmp(argv[1], "run-command-parallel")) {
 		next_fn = parallel_next;
@@ -426,5 +435,7 @@ int cmd__run_command(int argc, const char **argv)
 		return 1;
 	}
 
-	exit(run_processes_parallel(jobs, next_fn, NULL, finished_fn, &proc));
+	opts.get_next_task = next_fn;
+	opts.task_finished = finished_fn;
+	exit(run_processes_parallel(&opts));
 }
-- 
2.36.1.952.g0ae626f6cd7

