Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974AEC433FE
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 12:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384163AbiDUM2e (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 08:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384099AbiDUM21 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 08:28:27 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401002F012
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 05:25:37 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id k22so6478040wrd.2
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 05:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ALNVf6XTog1ip44ETsfqawX0FgQBOP4D7H94Epb/xzQ=;
        b=dKghuYt4s+wZaBauxRmgSkCNaugmX1oXnShOjRsCkYqM946+hSQ5VwS0LjDlsRGfyS
         NH4C//wp7xPo1tqAn1KPaxS6wUDzfmuaDeZB62wfK9KDR/t7Dx7XZPmfLWu/XPh5jnGt
         gRNb2ip50cpkWMF82oWkw1WZSHXrJ7lYnGlL27UzQipqQX9woPT5bj6tRwKnFR/msxuu
         0Orh7OO1OIuUT5dO0aDKXKt/H+pQEFtBtkyU+OM1ilMyktvAcScQewUCJZCRTOZIYrdn
         V1BShZAQa33qP2LDfZFJzr0lOTblPzY2Lj+oGv0/PBBIGwvtd5Qd1r5sR1MZzIS/uSMD
         Z+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ALNVf6XTog1ip44ETsfqawX0FgQBOP4D7H94Epb/xzQ=;
        b=e0vSXrzcA2alk8zmimXAy0Gn2E9sqi513NbB4sEdOX+HEwIwOwzvOVtgU+2BKSsy5e
         PBpkFk9eDbC2/Hi1LhNVZX42dSddnS8OUU+3eDcmCAlXLKnAWL5jHVjJ1IpNVJxMRkhQ
         tccvLC6XxcGelyRIYZKoriJjc1x5k8MPOczmIUR9/Uu5K76dCBn91WW42Y+1RlPJLQWf
         Qic/lvRfuldXybK4t16e3QcsjmY4ijKUDHJ8ABZR4FiV7u2NCfpPzO3pBOCXdPxc1se6
         EOVcOf6p+Nphrl1oPVdlVhYsQRL3ryKwDExcqxr7d9bCtH7rS76slkrJ3BmmJ7BD8DoQ
         5Xnw==
X-Gm-Message-State: AOAM530BQMWTzwN82dHH4zJOvqvwVWY7r+mW80JVrq7dfGhTpGhKD5i+
        GMZThD6hGT8bai4LAU4t1IDwsJxKuMnqSg==
X-Google-Smtp-Source: ABdhPJzkPOr8pCgdm8+3hIgd/sRW1ru+H3w53s/T4fH8MIijfawcfjy9xSumfj04VoJIc4r4ISYwDg==
X-Received: by 2002:a5d:52c9:0:b0:207:99d3:7b4d with SMTP id r9-20020a5d52c9000000b0020799d37b4dmr20504131wrv.77.1650543935459;
        Thu, 21 Apr 2022 05:25:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r7-20020a05600c2c4700b0038eb7d8df69sm1920168wmg.11.2022.04.21.05.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 05:25:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Anthony Sottile <asottile@umich.edu>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/6] run-command API: replace run_processes_parallel_tr2() with opts struct
Date:   Thu, 21 Apr 2022 14:25:26 +0200
Message-Id: <patch-1.6-8bf71ce63dd-20220421T122108Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.893.g80a51c675f6
In-Reply-To: <cover-0.6-00000000000-20220421T122108Z-avarab@gmail.com>
References: <CA+dzEBn108QoMA28f0nC8K21XT+Afua0V2Qv8XkR8rAeqUCCZw@mail.gmail.com> <cover-0.6-00000000000-20220421T122108Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new "struct run_process_parallel_opts" to cover the trace2
use-case added in ee4512ed481 (trace2: create new combined trace
facility, 2019-02-22). A subsequent commit will add more options, and
having a proliferation of new functions or extra parameters would
result in needless churn.

It makes for a smaller change to make run_processes_parallel() and
run_processes_parallel_tr2() wrapper functions for the new "static"
run_processes_parallel_1(), which contains the main logic. We pass
down "opts" to the *_1() function even though it isn't used there
yet (only in the *_tr2() function), a subsequent commit will make more
use of it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/fetch.c             | 15 ++++++++------
 builtin/submodule--helper.c | 12 +++++++----
 hook.c                      | 13 ++++++------
 run-command.c               | 40 +++++++++++++++++++++++++++----------
 run-command.h               | 26 ++++++++++++++++--------
 submodule.c                 | 13 ++++++------
 t/helper/test-run-command.c | 13 ++++++------
 7 files changed, 84 insertions(+), 48 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index e3791f09ed5..9bc99183191 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1948,14 +1948,17 @@ static int fetch_multiple(struct string_list *list, int max_children)
 
 	if (max_children != 1 && list->nr != 1) {
 		struct parallel_fetch_state state = { argv.v, list, 0, 0 };
+		struct run_process_parallel_opts run_opts = {
+			.tr2_category = "fetch",
+			.tr2_label = "parallel/fetch",
+		};
 
 		strvec_push(&argv, "--end-of-options");
-		result = run_processes_parallel_tr2(max_children,
-						    &fetch_next_remote,
-						    &fetch_failed_to_start,
-						    &fetch_finished,
-						    &state,
-						    "fetch", "parallel/fetch");
+		result = run_processes_parallel(max_children,
+						&fetch_next_remote,
+						&fetch_failed_to_start,
+						&fetch_finished, &state,
+						&run_opts);
 
 		if (!result)
 			result = state.result;
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 2c87ef9364f..c3d1aace546 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2652,12 +2652,16 @@ static int update_submodules(struct update_data *update_data)
 {
 	int i, res = 0;
 	struct submodule_update_clone suc = SUBMODULE_UPDATE_CLONE_INIT;
+	struct run_process_parallel_opts run_opts = {
+		.tr2_category = "submodule",
+		.tr2_label = "parallel/update",
+	};
 
 	suc.update_data = update_data;
-	run_processes_parallel_tr2(suc.update_data->max_jobs, update_clone_get_next_task,
-				   update_clone_start_failure,
-				   update_clone_task_finished, &suc, "submodule",
-				   "parallel/update");
+	run_processes_parallel(suc.update_data->max_jobs,
+			       update_clone_get_next_task,
+			       update_clone_start_failure,
+			       update_clone_task_finished, &suc, &run_opts);
 
 	/*
 	 * We saved the output and put it out all at once now.
diff --git a/hook.c b/hook.c
index 1d51be3b77a..eadb2d58a7b 100644
--- a/hook.c
+++ b/hook.c
@@ -123,6 +123,10 @@ int run_hooks_opt(const char *hook_name, struct run_hooks_opt *options)
 	const char *const hook_path = find_hook(hook_name);
 	int jobs = 1;
 	int ret = 0;
+	struct run_process_parallel_opts run_opts = {
+		.tr2_category = "hook",
+		.tr2_label = hook_name,
+	};
 
 	if (!options)
 		BUG("a struct run_hooks_opt must be provided to run_hooks");
@@ -144,13 +148,8 @@ int run_hooks_opt(const char *hook_name, struct run_hooks_opt *options)
 		cb_data.hook_path = abs_path.buf;
 	}
 
-	run_processes_parallel_tr2(jobs,
-				   pick_next_hook,
-				   notify_start_failure,
-				   notify_hook_finished,
-				   &cb_data,
-				   "hook",
-				   hook_name);
+	run_processes_parallel(jobs, pick_next_hook, notify_start_failure,
+			       notify_hook_finished, &cb_data, &run_opts);
 	ret = cb_data.rc;
 cleanup:
 	strbuf_release(&abs_path);
diff --git a/run-command.c b/run-command.c
index a8501e38ceb..7b8159aa235 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1738,11 +1738,11 @@ static int pp_collect_finished(struct parallel_processes *pp)
 	return result;
 }
 
-int run_processes_parallel(int n,
-			   get_next_task_fn get_next_task,
-			   start_failure_fn start_failure,
-			   task_finished_fn task_finished,
-			   void *pp_cb)
+static int run_processes_parallel_1(int n, get_next_task_fn get_next_task,
+				    start_failure_fn start_failure,
+				    task_finished_fn task_finished,
+				    void *pp_cb,
+				    struct run_process_parallel_opts *opts)
 {
 	int i, code;
 	int output_timeout = 100;
@@ -1780,24 +1780,42 @@ int run_processes_parallel(int n,
 	return 0;
 }
 
-int run_processes_parallel_tr2(int n, get_next_task_fn get_next_task,
-			       start_failure_fn start_failure,
-			       task_finished_fn task_finished, void *pp_cb,
-			       const char *tr2_category, const char *tr2_label)
+static int run_processes_parallel_tr2(int n, get_next_task_fn get_next_task,
+				      start_failure_fn start_failure,
+				      task_finished_fn task_finished,
+				      void *pp_cb,
+				      struct run_process_parallel_opts *opts)
 {
+	const char *tr2_category = opts->tr2_category;
+	const char *tr2_label = opts->tr2_label;
 	int result;
 
 	trace2_region_enter_printf(tr2_category, tr2_label, NULL, "max:%d",
 				   ((n < 1) ? online_cpus() : n));
 
-	result = run_processes_parallel(n, get_next_task, start_failure,
-					task_finished, pp_cb);
+	result = run_processes_parallel_1(n, get_next_task, start_failure,
+					  task_finished, pp_cb, opts);
 
 	trace2_region_leave(tr2_category, tr2_label, NULL);
 
 	return result;
 }
 
+int run_processes_parallel(int n, get_next_task_fn get_next_task,
+			   start_failure_fn start_failure,
+			   task_finished_fn task_finished, void *pp_cb,
+			   struct run_process_parallel_opts *opts)
+{
+	if (opts->tr2_category && opts->tr2_label)
+		return run_processes_parallel_tr2(n, get_next_task,
+						  start_failure, task_finished,
+						  pp_cb, opts);
+
+	return run_processes_parallel_1(n, get_next_task, start_failure,
+					task_finished, pp_cb, opts);
+}
+
+
 int run_auto_maintenance(int quiet)
 {
 	int enabled;
diff --git a/run-command.h b/run-command.h
index 07bed6c31b4..66e7bebd88a 100644
--- a/run-command.h
+++ b/run-command.h
@@ -458,6 +458,19 @@ typedef int (*task_finished_fn)(int result,
 				void *pp_cb,
 				void *pp_task_cb);
 
+/**
+ * Options to pass to run_processes_parallel(), { 0 }-initialized
+ * means no options. Fields:
+ *
+ * tr2_category & tr2_label: sets the trace2 category and label for
+ * logging. These must either be unset, or both of them must be set.
+ */
+struct run_process_parallel_opts
+{
+	const char *tr2_category;
+	const char *tr2_label;
+};
+
 /**
  * Runs up to n processes at the same time. Whenever a process can be
  * started, the callback get_next_task_fn is called to obtain the data
@@ -469,15 +482,12 @@ typedef int (*task_finished_fn)(int result,
  *
  * start_failure_fn and task_finished_fn can be NULL to omit any
  * special handling.
+ *
+ * Options are passed via a "struct run_process_parallel_opts".
  */
-int run_processes_parallel(int n,
-			   get_next_task_fn,
-			   start_failure_fn,
-			   task_finished_fn,
-			   void *pp_cb);
-int run_processes_parallel_tr2(int n, get_next_task_fn, start_failure_fn,
-			       task_finished_fn, void *pp_cb,
-			       const char *tr2_category, const char *tr2_label);
+int run_processes_parallel(int n, get_next_task_fn, start_failure_fn,
+			   task_finished_fn, void *pp_cb,
+			   struct run_process_parallel_opts *opts);
 
 /**
  * Convenience function which prepares env_array for a command to be run in a
diff --git a/submodule.c b/submodule.c
index 86c8f0f89db..256c6bb4b8f 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1817,6 +1817,10 @@ int fetch_submodules(struct repository *r,
 {
 	int i;
 	struct submodule_parallel_fetch spf = SPF_INIT;
+	struct run_process_parallel_opts run_opts = {
+		.tr2_category = "submodule",
+		.tr2_label = "parallel/fetch",
+	};
 
 	spf.r = r;
 	spf.command_line_option = command_line_option;
@@ -1838,12 +1842,9 @@ int fetch_submodules(struct repository *r,
 
 	calculate_changed_submodule_paths(r, &spf.changed_submodule_names);
 	string_list_sort(&spf.changed_submodule_names);
-	run_processes_parallel_tr2(max_parallel_jobs,
-				   get_next_submodule,
-				   fetch_start_failure,
-				   fetch_finish,
-				   &spf,
-				   "submodule", "parallel/fetch");
+	run_processes_parallel(max_parallel_jobs, get_next_submodule,
+			       fetch_start_failure, fetch_finish, &spf,
+			       &run_opts);
 
 	if (spf.submodules_with_errors.len > 0)
 		fprintf(stderr, _("Errors during submodule fetch:\n%s"),
diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index f3b90aa834a..9b21f2f9f83 100644
--- a/t/helper/test-run-command.c
+++ b/t/helper/test-run-command.c
@@ -183,7 +183,7 @@ static int testsuite(int argc, const char **argv)
 		(uintmax_t)suite.tests.nr, max_jobs);
 
 	ret = run_processes_parallel(max_jobs, next_test, test_failed,
-				     test_finished, &suite);
+				     test_finished, &suite, NULL);
 
 	if (suite.failed.nr > 0) {
 		ret = 1;
@@ -371,6 +371,7 @@ int cmd__run_command(int argc, const char **argv)
 {
 	struct child_process proc = CHILD_PROCESS_INIT;
 	int jobs;
+	struct run_process_parallel_opts opts = { 0 };
 
 	if (argc > 1 && !strcmp(argv[1], "testsuite"))
 		exit(testsuite(argc - 1, argv + 1));
@@ -413,15 +414,15 @@ int cmd__run_command(int argc, const char **argv)
 
 	if (!strcmp(argv[1], "run-command-parallel"))
 		exit(run_processes_parallel(jobs, parallel_next,
-					    NULL, NULL, &proc));
+					    NULL, NULL, &proc, &opts));
 
 	if (!strcmp(argv[1], "run-command-abort"))
-		exit(run_processes_parallel(jobs, parallel_next,
-					    NULL, task_finished, &proc));
+		exit(run_processes_parallel(jobs, parallel_next, NULL,
+					    task_finished, &proc, &opts));
 
 	if (!strcmp(argv[1], "run-command-no-jobs"))
-		exit(run_processes_parallel(jobs, no_job,
-					    NULL, task_finished, &proc));
+		exit(run_processes_parallel(jobs, no_job, NULL, task_finished,
+					    &proc, &opts));
 
 	fprintf(stderr, "check usage\n");
 	return 1;
-- 
2.36.0.893.g80a51c675f6

