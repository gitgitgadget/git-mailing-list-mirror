Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECAC1C433FE
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 09:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiJLJC6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 05:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiJLJC2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 05:02:28 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0AEBBF35
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 02:01:59 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id r8-20020a1c4408000000b003c47d5fd475so798758wma.3
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 02:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HxRZpG2I81ydM6dFAD1SlTvy5KVNSlLWIzWEJPls/rU=;
        b=CWlWJBWYUTqiGlreln6yyMt6Hh5VHBee7fFUDeu7xFylVhZrOnsxVbKo1uPQajdaYW
         lvHd0Ostppe7zJket+KUT1OuCmMv5yPuaWCVUe4Zz1yxRH+NMoBfIYsOYKYYPkv0idTG
         x3OrU+9mekuQBNjwkbQFaJ+WtSbKtlu5GpB6EDOuozt7jq9ldtwC+GwmiS5pWI1Fpghu
         eSgNWtHhrwmfSZq5u4K1z6VfgHOWZQe1GiAJrdwu/ZFO3tLxnSFNEf4KPbmMXfeTHMuB
         q9z/MGBvSxC1EvSM1gc3sZUbe+l1ndOrrVXNIZpoyS84Qi8l0CoOnTDtSA+mkjlSWhXZ
         Ha9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HxRZpG2I81ydM6dFAD1SlTvy5KVNSlLWIzWEJPls/rU=;
        b=u2kU6wdrb0fd0HQy/0Ed/VDXVw5gLI93wzgzt7bd+gtZDPKF46dT8jjWxH4owrLdw/
         2t1wW2lsRMEEoMwzpvdVE+jCA20i781VK1zhl1X4FxOPCDLBFXaRoseJkut8+GBZWxZd
         xW7fFRq73eQwOAoEXN99l/TVT0hZTVMJeslHzuUvdc4J9RSQt6wek1oYWMbqENOHK9QA
         CQa+/Zt+oDs+tDs1GzTLIAriNqovT1nRR+OarKTfQeG+T+CFgEqGORrVYt8szog87Ziw
         NinIWJokbV2dgdRifSgotmt0iQ6NlYiYH6rS0QUDJVAYvr6TexPouqX2NMPo2fzyG1XJ
         0ZGQ==
X-Gm-Message-State: ACrzQf3GVGNXFcl2i2IRq56P8p+TomcEhvDBnngI2evhLIGz9XK64nD6
        6PCMZGLIYU2faYmSPwCBM6OQEc4MSOq66w==
X-Google-Smtp-Source: AMsMyM7kCu9aLuqUSbD4rAz6oho8hg4D05NA8xJwpjl1IYGlnu5Dtp8jvBpPM5HwvdjTIqa1FLEuXA==
X-Received: by 2002:a05:600c:4f0f:b0:3b4:c09b:37c5 with SMTP id l15-20020a05600c4f0f00b003b4c09b37c5mr1992125wmq.181.1665565317242;
        Wed, 12 Oct 2022 02:01:57 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b1-20020a05600c4e0100b003a3170a7af9sm1280362wmq.4.2022.10.12.02.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 02:01:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 14/22] run-command API: have run_process_parallel() take an "opts" struct
Date:   Wed, 12 Oct 2022 11:01:22 +0200
Message-Id: <patch-v2-14.22-41c2886b44b-20221012T084850Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.971.ge79ff6d20e7
In-Reply-To: <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com> <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com>
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
 run-command.c               | 32 ++++----------------------------
 run-command.h               | 21 ++++++++++-----------
 t/helper/test-run-command.c | 31 +++++++++++++++++++++----------
 4 files changed, 49 insertions(+), 58 deletions(-)

diff --git a/hook.c b/hook.c
index a493939a4fc..a4fa1031f28 100644
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
+		.processes = 1,
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
index 3cdf85876c1..0956cc572b7 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1494,7 +1494,6 @@ enum child_state {
 	GIT_CP_WAIT_CLEANUP,
 };
 
-int run_processes_parallel_ungroup;
 struct parallel_processes {
 	void *const data;
 
@@ -1766,25 +1765,22 @@ static int pp_collect_finished(struct parallel_processes *pp)
 	return result;
 }
 
-static void run_processes_parallel_1(const struct run_process_parallel_opts *opts, void *pp_cb)
+void run_processes_parallel(const struct run_process_parallel_opts *opts)
 {
 	int code;
 	int output_timeout = 100;
 	int spawn_cap = 4;
 	struct parallel_processes pp = {
 		.max_processes = opts->processes,
-		.data = pp_cb,
+		.data = opts->data,
 		.buffered_output = STRBUF_INIT,
-		.ungroup = run_processes_parallel_ungroup,
+		.ungroup = opts->ungroup,
 	};
 	/* options */
 	const char *tr2_category = opts->tr2_category;
 	const char *tr2_label = opts->tr2_label;
 	const int do_trace2 = tr2_category && tr2_label;
 
-	/* unset for the next API user */
-	run_processes_parallel_ungroup = 0;
-
 	if (do_trace2)
 		trace2_region_enter_printf(tr2_category, tr2_label, NULL,
 					   "max:%d", opts->processes);
@@ -1827,24 +1823,6 @@ static void run_processes_parallel_1(const struct run_process_parallel_opts *opt
 		trace2_region_leave(tr2_category, tr2_label, NULL);
 }
 
-void run_processes_parallel(size_t processes,
-			    get_next_task_fn get_next_task,
-			    start_failure_fn start_failure,
-			    task_finished_fn task_finished,
-			    void *pp_cb)
-{
-	const struct run_process_parallel_opts opts = {
-		.processes = processes,
-		.ungroup = run_processes_parallel_ungroup,
-
-		.get_next_task = get_next_task,
-		.start_failure = start_failure,
-		.task_finished = task_finished,
-	};
-
-	run_processes_parallel_1(&opts, pp_cb);
-}
-
 void run_processes_parallel_tr2(size_t processes, get_next_task_fn get_next_task,
 				start_failure_fn start_failure,
 				task_finished_fn task_finished, void *pp_cb,
@@ -1853,16 +1831,14 @@ void run_processes_parallel_tr2(size_t processes, get_next_task_fn get_next_task
 	const struct run_process_parallel_opts opts = {
 		.tr2_category = tr2_category,
 		.tr2_label = tr2_label,
-
 		.processes = processes,
-		.ungroup = run_processes_parallel_ungroup,
 
 		.get_next_task = get_next_task,
 		.start_failure = start_failure,
 		.task_finished = task_finished,
 	};
 
-	run_processes_parallel_1(&opts, pp_cb);
+	run_processes_parallel(&opts);
 }
 
 int run_auto_maintenance(int quiet)
diff --git a/run-command.h b/run-command.h
index bd0b7b70b27..aabdaf684db 100644
--- a/run-command.h
+++ b/run-command.h
@@ -498,11 +498,19 @@ struct run_process_parallel_opts
 	 * NULL to omit any special handling.
 	 */
 	task_finished_fn task_finished;
+
+	/**
+	 * data: user data, will be passed as "pp_cb" to the callback
+	 * parameters.
+	 */
+	void *data;
 };
 
 /**
+ * Options are passed via the "struct run_process_parallel_opts" above.
+ *
  * Runs N 'processes' at the same time. Whenever a process can be
- * started, the callback get_next_task_fn is called to obtain the data
+ * started, the callback opts.get_next_task is called to obtain the data
  * required to start another child process.
  *
  * The children started via this function run in parallel. Their output
@@ -518,17 +526,8 @@ struct run_process_parallel_opts
  * NULL "struct strbuf *out" parameter, and are responsible for
  * emitting their own output, including dealing with any race
  * conditions due to writing in parallel to stdout and stderr.
- * The "ungroup" option can be enabled by setting the global
- * "run_processes_parallel_ungroup" to "1" before invoking
- * run_processes_parallel(), it will be set back to "0" as soon as the
- * API reads that setting.
  */
-extern int run_processes_parallel_ungroup;
-void run_processes_parallel(size_t processes,
-			    get_next_task_fn,
-			    start_failure_fn,
-			    task_finished_fn,
-			    void *pp_cb);
+void run_processes_parallel(const struct run_process_parallel_opts *opts);
 void run_processes_parallel_tr2(size_t processes, get_next_task_fn,
 				start_failure_fn, task_finished_fn, void *pp_cb,
 				const char *tr2_category, const char *tr2_label);
diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index ee509aefa2f..3ecb830f4a8 100644
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
+	opts.processes = max_jobs;
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
@@ -435,18 +444,20 @@ int cmd__run_command(int argc, const char **argv)
 	strvec_pushv(&proc.args, (const char **)argv + 3);
 
 	if (!strcmp(argv[1], "run-command-parallel")) {
-		run_processes_parallel(jobs, parallel_next, NULL, NULL, &proc);
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
+	opts.processes = jobs;
+	run_processes_parallel(&opts);
 	ret = 0;
 cleanup:
 	child_process_clear(&proc);
-- 
2.38.0.971.ge79ff6d20e7

