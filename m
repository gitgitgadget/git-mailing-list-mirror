Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18828C433FE
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 11:36:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbiI3Lgf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 07:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbiI3Lfq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 07:35:46 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC68913DD8E
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 04:28:27 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id o5so2718871wms.1
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 04:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=yIwuSoiiEH9AiKkzxmDSA48lbt+NQqPIUYO9+pPBnM4=;
        b=XLwZkUSvgbONziDzKIx+VXzpiZxpKT+Uba9EYsVM2BdcDqiQzYebepJHGGMS72eU2o
         q3DCTOFz3Gbe2DGqPiKbip7Jlt9Ho0lB46qmDN6tHRuLo2pMVFVjx3GfsM2a0LdAX9AP
         mQtsJKLUOZdE92guRbLsRUQfD+if/KOWkQ10mwV+LYyg2EbImr8UVJXW7AW2iv4jZcSx
         jfe43HJlNqvcpkuzQVfnLz2CnlQE6d5ywcjav6BPY2KJVsEf1nblfx90JE1VlZkwNXzd
         jf7pb2/dwYlgoaJkja/hnYcpEwEnASEwsItUFgh2jLupXFxU0DEJ5kQJ20gbjn78BBZn
         mGuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=yIwuSoiiEH9AiKkzxmDSA48lbt+NQqPIUYO9+pPBnM4=;
        b=V7A+H5q1r5vGckMPmnosa6aT520Vv/qFKpX2OiG0n5EHyOZolXDzPDkfwhwJeSvRPY
         eA1BVv4a+g/iU7BmMImMJ4G6KW4KDJJSMwK0Qxv+oOT3HJxtXx7DqjnYPletsalWfVVD
         F46zoMb39nXVh+77XrAuSjZCVg9kdBZGG/Kn5CtTT5IVDafRB8YtuDQMquJr7wu3VQL0
         oGcDgZd6V4m4SPJo2gzFAxIKxlpERkcpW5Ho/SandYEop6SkO9a+2Ix3Xg2wgCMb2oA8
         aDrUC8ARg78bGgaL3WicS+m7utk1urQRIgfPZhM8qaSm5ArTneahH1M94kZyrjLdqp3T
         tBTA==
X-Gm-Message-State: ACrzQf2GezJRRSbc25CauhUZ8yz9uHWqUPNZJJ9tebtXPBxLfBww2X85
        b93N++/S+f8lT6Eig6jaiC0m1t48Ju3tQg==
X-Google-Smtp-Source: AMsMyM4BkT2qIQKkcl6+t51tKLtZ4UkY36IBFhKtOJULvdQ2q8gw9KbbHbWF/xhn6JjyW+EjK2qnyQ==
X-Received: by 2002:a05:600c:3d86:b0:3b4:b65f:a393 with SMTP id bi6-20020a05600c3d8600b003b4b65fa393mr5656814wmb.0.1664537303715;
        Fri, 30 Sep 2022 04:28:23 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l19-20020a5d5273000000b00228dbf15072sm1760799wrc.62.2022.09.30.04.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 04:28:22 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 07/15] run-command API: make "jobs" parameter an "unsigned int"
Date:   Fri, 30 Sep 2022 13:28:04 +0200
Message-Id: <patch-07.15-a9810aaa852-20220930T111343Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The rename the "n" variable added in c553c72eed6 (run-command: add an
asynchronous parallel child processor, 2015-12-15) to "jobs", and
change the type to an "unsigned int". As we'll see in a subsequent
commit we do pass "0" here, but never "jobs < 0".

The only users of the "jobs" parameter are:

 * builtin/fetch.c: defaults to 1, reads from the "fetch.parallel"
   config. As seen in the code that parses the config added in
   d54dea77dba (fetch: let --jobs=<n> parallelize --multiple, too,
   2019-10-05) will die if the git_config_int() return value is < 0.

   It will however pass us jobs = 0, as we'll see in a subsequent
   commit.

 * submodule.c: defaults to 1, reads from "submodule.fetchJobs"
   config. Read via code originally added in a028a1930c6 (fetching
   submodules: respect `submodule.fetchJobs` config option, 2016-02-29).

   It now piggy-backs on the the submodule.fetchJobs code and
   validation added in f20e7c1ea24 (submodule: remove
   submodule.fetchjobs from submodule-config parsing, 2017-08-02).

   Like builtin/fetch.c it will die if the git_config_int() return
   value is < 0, but like builtin/fetch.c it will pass us jobs = 0.

 * builtin/submodule--helper.c: defaults to 1. Read via code
   originally added in 2335b870fa7 (submodule update: expose parallelism
   to the user, 2016-02-29).

   Since f20e7c1ea24 (submodule: remove submodule.fetchjobs from
   submodule-config parsing, 2017-08-02) it shares a config parser and
   semantics with the submodule.c caller.

 * hook.c: hardcoded to 1, see 96e7225b310 (hook: add 'run'
   subcommand, 2021-12-22).

 * t/helper/test-run-command.c: can be -1 after parsing the arguments,
   but will then be overridden to online_cpus() before passing it to
   this API. See be5d88e1128 (test-tool run-command: learn to run (parts
   of) the testsuite, 2019-10-04).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 run-command.c | 33 +++++++++++++++++----------------
 run-command.h |  6 +++---
 2 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/run-command.c b/run-command.c
index 642e6b6e057..80d282dbdb6 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1500,8 +1500,8 @@ int run_processes_parallel_ungroup;
 struct parallel_processes {
 	void *data;
 
-	int max_processes;
-	int nr_processes;
+	unsigned int max_processes;
+	unsigned int nr_processes;
 
 	get_next_task_fn get_next_task;
 	start_failure_fn start_failure;
@@ -1560,20 +1560,21 @@ static void handle_children_on_signal(int signo)
 }
 
 static void pp_init(struct parallel_processes *pp,
-		    int n,
+		    unsigned int jobs,
 		    get_next_task_fn get_next_task,
 		    start_failure_fn start_failure,
 		    task_finished_fn task_finished,
 		    void *data, int ungroup)
 {
-	int i;
+	unsigned int i;
 
-	if (n < 1)
-		n = online_cpus();
+	if (jobs < 1)
+		jobs = online_cpus();
 
-	pp->max_processes = n;
+	pp->max_processes = jobs;
 
-	trace_printf("run_processes_parallel: preparing to run up to %d tasks", n);
+	trace_printf("run_processes_parallel: preparing to run up to %d tasks",
+		     jobs);
 
 	pp->data = data;
 	if (!get_next_task)
@@ -1587,14 +1588,14 @@ static void pp_init(struct parallel_processes *pp,
 	pp->output_owner = 0;
 	pp->shutdown = 0;
 	pp->ungroup = ungroup;
-	CALLOC_ARRAY(pp->children, n);
+	CALLOC_ARRAY(pp->children, jobs);
 	if (pp->ungroup)
 		pp->pfd = NULL;
 	else
-		CALLOC_ARRAY(pp->pfd, n);
+		CALLOC_ARRAY(pp->pfd, jobs);
 	strbuf_init(&pp->buffered_output, 0);
 
-	for (i = 0; i < n; i++) {
+	for (i = 0; i < jobs; i++) {
 		strbuf_init(&pp->children[i].err, 0);
 		child_process_init(&pp->children[i].process);
 		if (pp->pfd) {
@@ -1783,7 +1784,7 @@ static int pp_collect_finished(struct parallel_processes *pp)
 	return result;
 }
 
-void run_processes_parallel(int n,
+void run_processes_parallel(unsigned int jobs,
 			    get_next_task_fn get_next_task,
 			    start_failure_fn start_failure,
 			    task_finished_fn task_finished,
@@ -1798,7 +1799,7 @@ void run_processes_parallel(int n,
 	/* unset for the next API user */
 	run_processes_parallel_ungroup = 0;
 
-	pp_init(&pp, n, get_next_task, start_failure, task_finished, pp_cb,
+	pp_init(&pp, jobs, get_next_task, start_failure, task_finished, pp_cb,
 		ungroup);
 	while (1) {
 		for (i = 0;
@@ -1836,15 +1837,15 @@ void run_processes_parallel(int n,
 	pp_cleanup(&pp);
 }
 
-void run_processes_parallel_tr2(int n, get_next_task_fn get_next_task,
+void run_processes_parallel_tr2(unsigned int jobs, get_next_task_fn get_next_task,
 				start_failure_fn start_failure,
 				task_finished_fn task_finished, void *pp_cb,
 				const char *tr2_category, const char *tr2_label)
 {
 	trace2_region_enter_printf(tr2_category, tr2_label, NULL, "max:%d",
-				   ((n < 1) ? online_cpus() : n));
+				   ((jobs < 1) ? online_cpus() : jobs));
 
-	run_processes_parallel(n, get_next_task, start_failure,
+	run_processes_parallel(jobs, get_next_task, start_failure,
 			       task_finished, pp_cb);
 
 	trace2_region_leave(tr2_category, tr2_label, NULL);
diff --git a/run-command.h b/run-command.h
index e76a1b6b5b3..4502bdc64dc 100644
--- a/run-command.h
+++ b/run-command.h
@@ -459,7 +459,7 @@ typedef int (*task_finished_fn)(int result,
 				void *pp_task_cb);
 
 /**
- * Runs up to n processes at the same time. Whenever a process can be
+ * Runs up to 'jobs' processes at the same time. Whenever a process can be
  * started, the callback get_next_task_fn is called to obtain the data
  * required to start another child process.
  *
@@ -485,12 +485,12 @@ typedef int (*task_finished_fn)(int result,
  * API reads that setting.
  */
 extern int run_processes_parallel_ungroup;
-void run_processes_parallel(int n,
+void run_processes_parallel(unsigned int jobs,
 			    get_next_task_fn,
 			    start_failure_fn,
 			    task_finished_fn,
 			    void *pp_cb);
-void run_processes_parallel_tr2(int n, get_next_task_fn, start_failure_fn,
+void run_processes_parallel_tr2(unsigned int jobs, get_next_task_fn, start_failure_fn,
 				task_finished_fn, void *pp_cb,
 				const char *tr2_category, const char *tr2_label);
 
-- 
2.38.0.rc2.935.g6b421ae1592

