Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E709C43214
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4C016108E
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345205AbhIBNON (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 09:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345215AbhIBNNv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 09:13:51 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA57CC061147
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 06:12:19 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id o39-20020a05600c512700b002e74638b567so1345866wms.2
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 06:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xmf2YvCFWQ+MBH9/Is0EbWNT4TWAV+YT4gBMT8bsF5k=;
        b=gpy1TFQIzk/7tENgboMkCLMNJOaWceuHk9HgCcgpxvio8dfm3vBqSTtjZqfdWNJOkt
         QiQaCIU7g/0LVJP+2iyt0APH9OdeVyVZQfJAQKGod/xGMwjxa4c9b8kFk0Y9zrLqi0VI
         6gqiO/REUng1E8LFtbjHon1qQxcE7zLwKVPwoMSafZs1JQMjM5mRfsMhQQ0phGdwWmOi
         +yewIYfwjQ6C8GKaqHUFY7JgXU4y/qTP2Gf5tN83HHihKO4cxb3QqKBiw71NrZ/C0ohj
         pkPdX0fTRrSdXfbnkR28RHMqlfAFQoFSYzduPb6rLhMaZEBIc6QGErFD8CdBJwaUDZ0A
         hGbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xmf2YvCFWQ+MBH9/Is0EbWNT4TWAV+YT4gBMT8bsF5k=;
        b=BSFe3+/qdSlW6JBr4Tk1zqYr/A6UwRvQ55Vb9RGACDbLIxJQBMWL44S8JOsa+dylNi
         uTDAN6mgRDuNHb09vUR/D5NAL7iKWVm4lFhpc4ejKv1B/Sf74EnnlFEKVNzPAStBWUzX
         WR1jhCeZPSalC+7wt86ps7Hcjn+JUjTU5yvDEdgkU2ouK2aES+F8yJ9+M4lWxyM01GIM
         yHDnUI4RCOoIzzGb/dEkNhuELPqTaZEytjrsQaeznpAEPbOJE0vjO9IQG8GWqJt+giH7
         LT3vGeiI+LtR4eOpNsUnCdxxo/XD1iuoCXLc9SxB5ZMscTb1Mww8MEUsf3rXr2mzHogV
         tV0g==
X-Gm-Message-State: AOAM532oufVCtBXCJ6dmB+l6pahZTMIuz0QJKuKDcQdOTkoMOoAGW1x0
        rkOg7/Uuv3c13583flW14crI8zvXclRahQ==
X-Google-Smtp-Source: ABdhPJzYwawZnnsr01CN+fRyOw9ETmP0w6QAqeHoEmWPm+wKBw+ztLBRY2n6vSzJ3H9kErm6oibk5A==
X-Received: by 2002:a1c:7506:: with SMTP id o6mr3270135wmc.112.1630588337931;
        Thu, 02 Sep 2021 06:12:17 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o7sm1479635wmq.36.2021.09.02.06.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 06:12:17 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 31/36] run-command: allow capturing of collated output
Date:   Thu,  2 Sep 2021 15:11:31 +0200
Message-Id: <patch-v5-31.36-fac56a9d8af-20210902T125111Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.816.g1ba32acadee
In-Reply-To: <cover-v5-00.36-00000000000-20210902T125110Z-avarab@gmail.com>
References: <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com> <cover-v5-00.36-00000000000-20210902T125110Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

Some callers, for example server-side hooks which wish to relay hook
output to clients across a transport, want to capture what would
normally print to stderr and do something else with it. Allow that via a
callback.

By calling the callback regardless of whether there's output available,
we allow clients to send e.g. a keepalive if necessary.

Because we expose a strbuf, not a fd or FILE*, there's no need to create
a temporary pipe or similar - we can just skip the print to stderr and
instead hand it to the caller.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/fetch.c             |  2 +-
 builtin/submodule--helper.c |  2 +-
 hook.c                      |  1 +
 run-command.c               | 33 +++++++++++++++++++++++++--------
 run-command.h               | 18 +++++++++++++++++-
 submodule.c                 |  2 +-
 t/helper/test-run-command.c | 25 ++++++++++++++++++++-----
 t/t0061-run-command.sh      |  7 +++++++
 8 files changed, 73 insertions(+), 17 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index b18ada08842..27b63ee5200 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1819,7 +1819,7 @@ static int fetch_multiple(struct string_list *list, int max_children)
 		result = run_processes_parallel_tr2(max_children,
 						    &fetch_next_remote,
 						    &fetch_failed_to_start,
-						    NULL,
+						    NULL, NULL,
 						    &fetch_finished,
 						    &state,
 						    "fetch", "parallel/fetch");
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 0b73739c160..fbceab08b0d 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2311,7 +2311,7 @@ static int update_submodules(struct submodule_update_clone *suc)
 	int i;
 
 	run_processes_parallel_tr2(suc->max_jobs, update_clone_get_next_task,
-				   update_clone_start_failure, NULL,
+				   update_clone_start_failure, NULL, NULL,
 				   update_clone_task_finished, suc, "submodule",
 				   "parallel/update");
 
diff --git a/hook.c b/hook.c
index 7a6ef527443..169287ad152 100644
--- a/hook.c
+++ b/hook.c
@@ -174,6 +174,7 @@ int run_hooks(const char *hook_name, const char *hook_path,
 				   pick_next_hook,
 				   notify_start_failure,
 				   options->feed_pipe,
+				   NULL,
 				   notify_hook_finished,
 				   &cb_data,
 				   "hook",
diff --git a/run-command.c b/run-command.c
index f1616858d18..aacc336f951 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1493,6 +1493,7 @@ struct parallel_processes {
 	get_next_task_fn get_next_task;
 	start_failure_fn start_failure;
 	feed_pipe_fn feed_pipe;
+	consume_sideband_fn consume_sideband;
 	task_finished_fn task_finished;
 
 	struct {
@@ -1558,6 +1559,7 @@ static void pp_init(struct parallel_processes *pp,
 		    get_next_task_fn get_next_task,
 		    start_failure_fn start_failure,
 		    feed_pipe_fn feed_pipe,
+		    consume_sideband_fn consume_sideband,
 		    task_finished_fn task_finished,
 		    void *data)
 {
@@ -1578,6 +1580,7 @@ static void pp_init(struct parallel_processes *pp,
 	pp->start_failure = start_failure ? start_failure : default_start_failure;
 	pp->feed_pipe = feed_pipe ? feed_pipe : default_feed_pipe;
 	pp->task_finished = task_finished ? task_finished : default_task_finished;
+	pp->consume_sideband = consume_sideband;
 
 	pp->nr_processes = 0;
 	pp->output_owner = 0;
@@ -1614,7 +1617,10 @@ static void pp_cleanup(struct parallel_processes *pp)
 	 * When get_next_task added messages to the buffer in its last
 	 * iteration, the buffered output is non empty.
 	 */
-	strbuf_write(&pp->buffered_output, stderr);
+	if (pp->consume_sideband)
+		pp->consume_sideband(&pp->buffered_output, pp->data);
+	else
+		strbuf_write(&pp->buffered_output, stderr);
 	strbuf_release(&pp->buffered_output);
 
 	sigchain_pop_common();
@@ -1735,9 +1741,13 @@ static void pp_buffer_stderr(struct parallel_processes *pp, int output_timeout)
 static void pp_output(struct parallel_processes *pp)
 {
 	int i = pp->output_owner;
+
 	if (pp->children[i].state == GIT_CP_WORKING &&
 	    pp->children[i].err.len) {
-		strbuf_write(&pp->children[i].err, stderr);
+		if (pp->consume_sideband)
+			pp->consume_sideband(&pp->children[i].err, pp->data);
+		else
+			strbuf_write(&pp->children[i].err, stderr);
 		strbuf_reset(&pp->children[i].err);
 	}
 }
@@ -1776,11 +1786,15 @@ static int pp_collect_finished(struct parallel_processes *pp)
 			strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
 			strbuf_reset(&pp->children[i].err);
 		} else {
-			strbuf_write(&pp->children[i].err, stderr);
+			/* Output errors, then all other finished child processes */
+			if (pp->consume_sideband) {
+				pp->consume_sideband(&pp->children[i].err, pp->data);
+				pp->consume_sideband(&pp->buffered_output, pp->data);
+			} else {
+				strbuf_write(&pp->children[i].err, stderr);
+				strbuf_write(&pp->buffered_output, stderr);
+			}
 			strbuf_reset(&pp->children[i].err);
-
-			/* Output all other finished child processes */
-			strbuf_write(&pp->buffered_output, stderr);
 			strbuf_reset(&pp->buffered_output);
 
 			/*
@@ -1804,6 +1818,7 @@ int run_processes_parallel(int n,
 			   get_next_task_fn get_next_task,
 			   start_failure_fn start_failure,
 			   feed_pipe_fn feed_pipe,
+			   consume_sideband_fn consume_sideband,
 			   task_finished_fn task_finished,
 			   void *pp_cb)
 {
@@ -1814,7 +1829,7 @@ int run_processes_parallel(int n,
 
 	sigchain_push(SIGPIPE, SIG_IGN);
 
-	pp_init(&pp, n, get_next_task, start_failure, feed_pipe, task_finished, pp_cb);
+	pp_init(&pp, n, get_next_task, start_failure, feed_pipe, consume_sideband, task_finished, pp_cb);
 	while (1) {
 		for (i = 0;
 		    i < spawn_cap && !pp.shutdown &&
@@ -1852,6 +1867,7 @@ int run_processes_parallel(int n,
 int run_processes_parallel_tr2(int n, get_next_task_fn get_next_task,
 			       start_failure_fn start_failure,
 			       feed_pipe_fn feed_pipe,
+			       consume_sideband_fn consume_sideband,
 			       task_finished_fn task_finished, void *pp_cb,
 			       const char *tr2_category, const char *tr2_label)
 {
@@ -1861,7 +1877,8 @@ int run_processes_parallel_tr2(int n, get_next_task_fn get_next_task,
 				   ((n < 1) ? online_cpus() : n));
 
 	result = run_processes_parallel(n, get_next_task, start_failure,
-					feed_pipe, task_finished, pp_cb);
+					feed_pipe, consume_sideband,
+					task_finished, pp_cb);
 
 	trace2_region_leave(tr2_category, tr2_label, NULL);
 
diff --git a/run-command.h b/run-command.h
index 80d394664ae..e321d23bbd2 100644
--- a/run-command.h
+++ b/run-command.h
@@ -436,6 +436,20 @@ typedef int (*feed_pipe_fn)(struct strbuf *pipe,
 			    void *pp_cb,
 			    void *pp_task_cb);
 
+/**
+ * If this callback is provided, instead of collating process output to stderr,
+ * they will be collated into a new pipe. consume_sideband_fn will be called
+ * repeatedly. When output is available on that pipe, it will be contained in
+ * 'output'. But it will be called with an empty 'output' too, to allow for
+ * keepalives or similar operations if necessary.
+ *
+ * pp_cb is the callback cookie as passed into run_processes_parallel.
+ *
+ * Since this callback is provided with the collated output, no task cookie is
+ * provided.
+ */
+typedef void (*consume_sideband_fn)(struct strbuf *output, void *pp_cb);
+
 /**
  * This callback is called on every child process that finished processing.
  *
@@ -471,10 +485,12 @@ int run_processes_parallel(int n,
 			   get_next_task_fn,
 			   start_failure_fn,
 			   feed_pipe_fn,
+			   consume_sideband_fn,
 			   task_finished_fn,
 			   void *pp_cb);
 int run_processes_parallel_tr2(int n, get_next_task_fn, start_failure_fn,
-			       feed_pipe_fn, task_finished_fn, void *pp_cb,
+			       feed_pipe_fn, consume_sideband_fn,
+			       task_finished_fn, void *pp_cb,
 			       const char *tr2_category, const char *tr2_label);
 
 /**
diff --git a/submodule.c b/submodule.c
index db1700a502d..32364d8bd56 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1632,7 +1632,7 @@ int fetch_populated_submodules(struct repository *r,
 	run_processes_parallel_tr2(max_parallel_jobs,
 				   get_next_submodule,
 				   fetch_start_failure,
-				   NULL,
+				   NULL, NULL,
 				   fetch_finish,
 				   &spf,
 				   "submodule", "parallel/fetch");
diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index 9348184d303..d53db6d11c4 100644
--- a/t/helper/test-run-command.c
+++ b/t/helper/test-run-command.c
@@ -51,6 +51,16 @@ static int no_job(struct child_process *cp,
 	return 0;
 }
 
+static void test_consume_sideband(struct strbuf *output, void *cb)
+{
+	FILE *sideband;
+
+	sideband = fopen("./sideband", "a");
+
+	strbuf_write(output, sideband);
+	fclose(sideband);
+}
+
 static int task_finished(int result,
 			 struct strbuf *err,
 			 void *pp_cb,
@@ -201,7 +211,7 @@ static int testsuite(int argc, const char **argv)
 		suite.tests.nr, max_jobs);
 
 	ret = run_processes_parallel(max_jobs, next_test, test_failed,
-				     test_stdin, test_finished, &suite);
+				     test_stdin, NULL, test_finished, &suite);
 
 	if (suite.failed.nr > 0) {
 		ret = 1;
@@ -429,23 +439,28 @@ int cmd__run_command(int argc, const char **argv)
 
 	if (!strcmp(argv[1], "run-command-parallel"))
 		exit(run_processes_parallel(jobs, parallel_next,
-					    NULL, NULL, NULL, &proc));
+					    NULL, NULL, NULL, NULL, &proc));
 
 	if (!strcmp(argv[1], "run-command-abort"))
 		exit(run_processes_parallel(jobs, parallel_next,
-					    NULL, NULL, task_finished, &proc));
+					    NULL, NULL, NULL, task_finished, &proc));
 
 	if (!strcmp(argv[1], "run-command-no-jobs"))
 		exit(run_processes_parallel(jobs, no_job,
-					    NULL, NULL, task_finished, &proc));
+					    NULL, NULL, NULL, task_finished, &proc));
 
 	if (!strcmp(argv[1], "run-command-stdin")) {
 		proc.in = -1;
 		proc.no_stdin = 0;
 		exit (run_processes_parallel(jobs, parallel_next, NULL,
-					     test_stdin, NULL, &proc));
+					     test_stdin, NULL, NULL, &proc));
 	}
 
+	if (!strcmp(argv[1], "run-command-sideband"))
+		exit(run_processes_parallel(jobs, parallel_next, NULL, NULL,
+					    test_consume_sideband, NULL,
+					    &proc));
+
 	fprintf(stderr, "check usage\n");
 	return 1;
 }
diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index 87759482ad1..e99f6c7f445 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -143,6 +143,13 @@ test_expect_success 'run_command runs in parallel with more tasks than jobs avai
 	test_cmp expect actual
 '
 
+test_expect_success 'run_command can divert output' '
+	test_when_finished rm sideband &&
+	test-tool run-command run-command-sideband 3 sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
+	test_must_be_empty actual &&
+	test_cmp expect sideband
+'
+
 cat >expect <<-EOF
 preloaded output of a child
 listening for stdin:
-- 
2.33.0.816.g1ba32acadee

