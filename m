Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6F1C433F5
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 11:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbiI3Lgy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 07:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbiI3LgD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 07:36:03 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD23213EAC5
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 04:28:31 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id m4so6382404wrr.5
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 04:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=LnSGwn6fdEGmG4w0YIXHofVJmksdhbXPMRoHZdW8/0g=;
        b=ZqMwLNEoqizwgt0VOzLlj9SAHcsNpq72HrWdc3YcjE+7GlzrTHg1EPnzGCs7/XCvRm
         DKd4/QuXpUx3i/6mSLrPH8SDpU/ix6Z5JNEX/8hptiVshHLZAKSxkBH6xZOW1DmcAi4X
         tM0gntDAPB+6D12IS+ybyBbCW9m6r4q/6I2UI9d3Rv+JyyvFKkXD9QXGB0agx5zAdHgH
         hT1XiFgvlA2xW5WraCsPUAV3S+SlkwDGoEPBSPH4VkUXHnGHrUuq9zD60eaMA2aaXBuZ
         SH4l1Z9+s2AX+Ml191z2xNun6/5H3LNCZXv0BfPDNoGoqvk29xpvg9QQ5Zii8sZ62LuY
         jQKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=LnSGwn6fdEGmG4w0YIXHofVJmksdhbXPMRoHZdW8/0g=;
        b=mhdSPTSLZxpVZdTAShzhy2YRreS4U5Og/BXhbDc9hkp8+8+qi7NJoDXLNEWLbGV/wm
         AOHEIJ5x3fiCPP8lERpOoOdh1bYWCvfoZyl/wHZESKw+lhlUXwEK3dbtlH2a7XhTp7z6
         NXahRIOs0oTi5amK9/IQGBH3v1ATa1DLeyrZeC7ZErOND3EQv4Df4qtGTK8Vb4dpisOV
         52U6x20Mr292OPzG300nLtyFTHUUaOT13T9aOXW2rZPR2p/WTLsFHRBL20xha5+nfPQk
         7/mTkW/G3mYNep6ka7yIn1SlxYb33FcdhvF/qCJB+GKer2P5g2HoTHxZa7PZsesmH5Om
         uPzw==
X-Gm-Message-State: ACrzQf2LEoYTAqnj+YJStv4XdxXgSZz74FXl/lR8su03xPrLwWEJoqoi
        u88P4/TokzLJDUKu6QJAwlwVvBiqiFTKmQ==
X-Google-Smtp-Source: AMsMyM5bsewpbrHPv8sa8uDoFIK1jx5XENIv+aj4tnZ41qTNqbTOgm9orwIMqXMQh9afwnB/5q0xlg==
X-Received: by 2002:adf:ce8b:0:b0:22c:dea6:6ea with SMTP id r11-20020adfce8b000000b0022cdea606eamr2923869wrn.387.1664537309109;
        Fri, 30 Sep 2022 04:28:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l19-20020a5d5273000000b00228dbf15072sm1760799wrc.62.2022.09.30.04.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 04:28:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 12/15] run-command API: have run_process_parallel() take an "opts" struct
Date:   Fri, 30 Sep 2022 13:28:09 +0200
Message-Id: <patch-12.15-eeaac80fbac-20220930T111343Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Have the "run_process_parallel()" function take an "opts" struct,
which allows us to eliminate it as a wrapper for
"run_processes_parallel_1()".

Since the new "run_processes_parallel()" function is able to take an
optional "tr2_category" and "tr2_label" via the struct we can at this
point migrate all of the users of "run_processes_parallel_tr2()" over
to it.

But let's not migrate all the API users, only the two users that
passed the "ungroup" parameter via the
"run_processes_parallel_ungroup" global, allowing us to delete that
global in favor of passing "ungroup" via the "opts" struct. As noted
in fd3aaf53f71 (run-command: add an "ungroup" option to
run_process_parallel(), 2022-06-07) which added
"run_processes_parallel_ungroup" passing this as a global was a hack
to produce a small regression fix for "maint".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 hook.c                      | 23 ++++++++++++++---------
 run-command.c               | 29 ++---------------------------
 run-command.h               | 15 ++++-----------
 t/helper/test-run-command.c | 32 +++++++++++++++++++++-----------
 4 files changed, 41 insertions(+), 58 deletions(-)

diff --git a/hook.c b/hook.c
index a493939a4fc..ce91a5d1f80 100644
--- a/hook.c
+++ b/hook.c
@@ -114,8 +114,20 @@ int run_hooks_opt(const char *hook_name, struct run_hooks_opt *options)
 		.options = options,
 	};
 	const char *const hook_path = find_hook(hook_name);
-	int jobs = 1;
 	int ret = 0;
+	const struct run_process_parallel_opts opts = {
+		.tr2_category = "hook",
+		.tr2_label = hook_name,
+
+		.jobs = 1,
+		.ungroup = 1,
+
+		.get_next_task = pick_next_hook,
+		.start_failure = notify_start_failure,
+		.task_finished = notify_hook_finished,
+
+		.data = &cb_data,
+	};
 
 	if (!options)
 		BUG("a struct run_hooks_opt must be provided to run_hooks");
@@ -137,14 +149,7 @@ int run_hooks_opt(const char *hook_name, struct run_hooks_opt *options)
 		cb_data.hook_path = abs_path.buf;
 	}
 
-	run_processes_parallel_ungroup = 1;
-	run_processes_parallel_tr2(jobs,
-				   pick_next_hook,
-				   notify_start_failure,
-				   notify_hook_finished,
-				   &cb_data,
-				   "hook",
-				   hook_name);
+	run_processes_parallel(&opts);
 	ret = cb_data.rc;
 cleanup:
 	strbuf_release(&abs_path);
diff --git a/run-command.c b/run-command.c
index 7a138234b40..cdbba15a0ba 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1496,7 +1496,6 @@ enum child_state {
 	GIT_CP_WAIT_CLEANUP,
 };
 
-int run_processes_parallel_ungroup;
 struct parallel_processes {
 	void *data;
 
@@ -1784,7 +1783,7 @@ static int pp_collect_finished(struct parallel_processes *pp)
 	return result;
 }
 
-static void run_processes_parallel_1(const struct run_process_parallel_opts *opts)
+void run_processes_parallel(const struct run_process_parallel_opts *opts)
 {
 	int i, code;
 	int output_timeout = 100;
@@ -1795,9 +1794,6 @@ static void run_processes_parallel_1(const struct run_process_parallel_opts *opt
 	const char *tr2_label = opts->tr2_label;
 	const int do_trace2 = tr2_category && tr2_label;
 
-	/* unset for the next API user */
-	run_processes_parallel_ungroup = 0;
-
 	if (do_trace2)
 		trace2_region_enter_printf(tr2_category, tr2_label, NULL,
 					   "max:%d", opts->jobs);
@@ -1842,26 +1838,6 @@ static void run_processes_parallel_1(const struct run_process_parallel_opts *opt
 		trace2_region_leave(tr2_category, tr2_label, NULL);
 }
 
-void run_processes_parallel(unsigned int jobs,
-			    get_next_task_fn get_next_task,
-			    start_failure_fn start_failure,
-			    task_finished_fn task_finished,
-			    void *pp_cb)
-{
-	const struct run_process_parallel_opts opts = {
-		.jobs = jobs,
-		.ungroup = run_processes_parallel_ungroup,
-
-		.get_next_task = get_next_task,
-		.start_failure = start_failure,
-		.task_finished = task_finished,
-
-		.data = pp_cb,
-	};
-
-	run_processes_parallel_1(&opts);
-}
-
 void run_processes_parallel_tr2(unsigned int jobs, get_next_task_fn get_next_task,
 				start_failure_fn start_failure,
 				task_finished_fn task_finished, void *pp_cb,
@@ -1872,7 +1848,6 @@ void run_processes_parallel_tr2(unsigned int jobs, get_next_task_fn get_next_tas
 		.tr2_label = tr2_label,
 
 		.jobs = jobs,
-		.ungroup = run_processes_parallel_ungroup,
 
 		.get_next_task = get_next_task,
 		.start_failure = start_failure,
@@ -1881,7 +1856,7 @@ void run_processes_parallel_tr2(unsigned int jobs, get_next_task_fn get_next_tas
 		.data = pp_cb,
 	};
 
-	run_processes_parallel_1(&opts);
+	run_processes_parallel(&opts);
 }
 
 int run_auto_maintenance(int quiet)
diff --git a/run-command.h b/run-command.h
index 7151312592e..0f1d4081dcd 100644
--- a/run-command.h
+++ b/run-command.h
@@ -507,8 +507,10 @@ struct run_process_parallel_opts
 };
 
 /**
+ * Options are passed via the "struct run_process_parallel_opts" above.
+ *
  * Runs up to 'jobs' processes at the same time. Whenever a process can be
- * started, the callback get_next_task_fn is called to obtain the data
+ * started, the callback opts.get_next_task is called to obtain the data
  * required to start another child process.
  *
  * The children started via this function run in parallel. Their output
@@ -524,17 +526,8 @@ struct run_process_parallel_opts
  * NULL "struct strbuf *out" parameter, and are responsible for
  * emitting their own output, including dealing with any race
  * conditions due to writing in parallel to stdout and stderr.
- * The "ungroup" option can be enabled by setting the global
- * "run_processes_parallel_ungroup" to "1" before invoking
- * run_processes_parallel(), it will be set back to "0" as soon as the
- * API reads that setting.
  */
-extern int run_processes_parallel_ungroup;
-void run_processes_parallel(unsigned int jobs,
-			    get_next_task_fn,
-			    start_failure_fn,
-			    task_finished_fn,
-			    void *pp_cb);
+void run_processes_parallel(const struct run_process_parallel_opts *opts);
 void run_processes_parallel_tr2(unsigned int jobs, get_next_task_fn, start_failure_fn,
 				task_finished_fn, void *pp_cb,
 				const char *tr2_category, const char *tr2_label);
diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index c431e3094df..46bac2bb700 100644
--- a/t/helper/test-run-command.c
+++ b/t/helper/test-run-command.c
@@ -136,7 +136,7 @@ static const char * const testsuite_usage[] = {
 static int testsuite(int argc, const char **argv)
 {
 	struct testsuite suite = TESTSUITE_INIT;
-	int max_jobs = 1, i, ret;
+	int max_jobs = 1, i, ret = 0;
 	DIR *dir;
 	struct dirent *d;
 	struct option options[] = {
@@ -152,6 +152,12 @@ static int testsuite(int argc, const char **argv)
 			 "write JUnit-style XML files"),
 		OPT_END()
 	};
+	struct run_process_parallel_opts opts = {
+		.get_next_task = next_test,
+		.start_failure = test_failed,
+		.task_finished = test_finished,
+		.data = &suite,
+	};
 
 	argc = parse_options(argc, argv, NULL, options,
 			testsuite_usage, PARSE_OPT_STOP_AT_NON_OPTION);
@@ -192,8 +198,8 @@ static int testsuite(int argc, const char **argv)
 	fprintf(stderr, "Running %"PRIuMAX" tests (%d at a time)\n",
 		(uintmax_t)suite.tests.nr, max_jobs);
 
-	run_processes_parallel(max_jobs, next_test, test_failed,
-			       test_finished, &suite);
+	opts.jobs = max_jobs;
+	run_processes_parallel(&opts);
 
 	if (suite.failed.nr > 0) {
 		ret = 1;
@@ -206,7 +212,7 @@ static int testsuite(int argc, const char **argv)
 	string_list_clear(&suite.tests, 0);
 	string_list_clear(&suite.failed, 0);
 
-	return !!ret;
+	return ret;
 }
 
 static uint64_t my_random_next = 1234;
@@ -382,6 +388,9 @@ int cmd__run_command(int argc, const char **argv)
 	struct child_process proc = CHILD_PROCESS_INIT;
 	int jobs;
 	int ret;
+	struct run_process_parallel_opts opts = {
+		.data = &proc,
+	};
 
 	if (argc > 1 && !strcmp(argv[1], "testsuite"))
 		return testsuite(argc - 1, argv + 1);
@@ -427,7 +436,7 @@ int cmd__run_command(int argc, const char **argv)
 	if (!strcmp(argv[1], "--ungroup")) {
 		argv += 1;
 		argc -= 1;
-		run_processes_parallel_ungroup = 1;
+		opts.ungroup = 1;
 	}
 
 	jobs = atoi(argv[2]);
@@ -435,19 +444,20 @@ int cmd__run_command(int argc, const char **argv)
 	strvec_pushv(&proc.args, (const char **)argv + 3);
 
 	if (!strcmp(argv[1], "run-command-parallel")) {
-		run_processes_parallel(jobs, parallel_next, NULL, NULL,
-				       &proc);
+		opts.get_next_task = parallel_next;
 	} else if (!strcmp(argv[1], "run-command-abort")) {
-		run_processes_parallel(jobs, parallel_next, NULL,
-				       task_finished, &proc);
+		opts.get_next_task = parallel_next;
+		opts.task_finished = task_finished;
 	} else if (!strcmp(argv[1], "run-command-no-jobs")) {
-		run_processes_parallel(jobs, no_job, NULL, task_finished,
-				       &proc);
+		opts.get_next_task = no_job;
+		opts.task_finished = task_finished;
 	} else {
 		ret = 1;
 		fprintf(stderr, "check usage\n");
 		goto cleanup;
 	}
+	opts.jobs = jobs;
+	run_processes_parallel(&opts);
 	ret = 0;
 cleanup:
 	child_process_clear(&proc);
-- 
2.38.0.rc2.935.g6b421ae1592

