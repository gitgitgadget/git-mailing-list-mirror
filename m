Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CFDC2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FCDA61057
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbhFQK0N (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 06:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbhFQKZn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 06:25:43 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FC0C0611FA
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:23:29 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id l1so8998266ejb.6
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kFJeV17qGyARyccj49s4e3wij8+nEK0KT0IfkNYY6sE=;
        b=Knhx7gLa6Ngsaqeh1Bork7lG+H5m9k4avN5IurUvBSK/Zstcy2mwa2hFxO8ww6wZUL
         HrH7K53cMoU6N3jiYTPBsmb2W3GNDzA/Mmnt6kc4GqkJSfrFkQhL9a7YzacyiCqOHiT0
         k31GkULYCWQ3mamaTMP0pCpwV0Dqy8qRCUso5owGRpFdelXwT4XrRwjeA+lmXq7qr59b
         acwo2w4xF9Gtww5qxhi2qrOzlw5lHflJRT2CrDe4TOfMInIGyDsOeJgvO+YhPmSU1SNB
         rGYm/7GSxWMqoMMiGwltCqyd2v8eRRQzL8u94Ps7WhaUinPTd6SeYPM2HRnepsyuuWMI
         legQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kFJeV17qGyARyccj49s4e3wij8+nEK0KT0IfkNYY6sE=;
        b=ew2bmFgs1koy0FGVYVJPB0l2rMLkrz0q2V6Gv5jfgk3QZ3O7yXs/lNADg6yYJgyAu5
         1bKW/zlOfOe2CNNntWmeY14s8okODfnqFC3yY9ABltU0d8xovivZ7Y2LSFgK5e/uBC4s
         /7Hejtc0oF+uaMqjB53X0EhJPXacYqeFeZC+BCeL12vdtJiw6KbdUYG1vePG2N4x9Yjo
         jxMF59IcfpMVVsDRiaSUtlwsQ30hcVXV6cZsRO4S577sU0kKviDtf/yUzKGSD9Z5vhMQ
         1tkfnIdUUKTqYa+ThMpmKjrncyROdo+T9/qwweqQJgZGhiNTDDNpZPYuw+RWXEb61yRJ
         Zp/A==
X-Gm-Message-State: AOAM533RJ5rMYIuHoZUCbJVxi+e7JVubYZrwzZsv9NZuYtfpSxI6rjOb
        CV6keYqYvissod040j6E0eLZ6mxkebH4UA==
X-Google-Smtp-Source: ABdhPJx0cPR/qMCM5nMWrWJxEz03QjEJeZU6Kq6GOroFxJhWQhZ8xLgunEhWr2GPtL5NAL6xRljyow==
X-Received: by 2002:a17:906:488f:: with SMTP id v15mr4358724ejq.428.1623925407477;
        Thu, 17 Jun 2021 03:23:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id jo13sm3447293ejb.91.2021.06.17.03.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 03:23:27 -0700 (PDT)
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
Subject: [PATCH 22/27] run-command: allow capturing of collated output
Date:   Thu, 17 Jun 2021 12:22:56 +0200
Message-Id: <patch-22.27-f7f56d0a3b-20210617T101217Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.576.g59759b6ca7d
In-Reply-To: <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com>
References: <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com> <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com>
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
index 3d8f04b392..0595b88b7c 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1817,7 +1817,7 @@ static int fetch_multiple(struct string_list *list, int max_children)
 		result = run_processes_parallel_tr2(max_children,
 						    &fetch_next_remote,
 						    &fetch_failed_to_start,
-						    NULL,
+						    NULL, NULL,
 						    &fetch_finished,
 						    &state,
 						    "fetch", "parallel/fetch");
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 818494dd18..69782f6204 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2295,7 +2295,7 @@ static int update_submodules(struct submodule_update_clone *suc)
 	int i;
 
 	run_processes_parallel_tr2(suc->max_jobs, update_clone_get_next_task,
-				   update_clone_start_failure, NULL,
+				   update_clone_start_failure, NULL, NULL,
 				   update_clone_task_finished, suc, "submodule",
 				   "parallel/update");
 
diff --git a/hook.c b/hook.c
index c4df787f13..2dca969f9e 100644
--- a/hook.c
+++ b/hook.c
@@ -192,6 +192,7 @@ int run_found_hooks(const char *hook_name, const char *hook_path,
 				   pick_next_hook,
 				   notify_start_failure,
 				   options->feed_pipe,
+				   NULL,
 				   notify_hook_finished,
 				   &cb_data,
 				   "hook",
diff --git a/run-command.c b/run-command.c
index 3392640f17..4a1a7a1082 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1494,6 +1494,7 @@ struct parallel_processes {
 	get_next_task_fn get_next_task;
 	start_failure_fn start_failure;
 	feed_pipe_fn feed_pipe;
+	consume_sideband_fn consume_sideband;
 	task_finished_fn task_finished;
 
 	struct {
@@ -1559,6 +1560,7 @@ static void pp_init(struct parallel_processes *pp,
 		    get_next_task_fn get_next_task,
 		    start_failure_fn start_failure,
 		    feed_pipe_fn feed_pipe,
+		    consume_sideband_fn consume_sideband,
 		    task_finished_fn task_finished,
 		    void *data)
 {
@@ -1579,6 +1581,7 @@ static void pp_init(struct parallel_processes *pp,
 	pp->start_failure = start_failure ? start_failure : default_start_failure;
 	pp->feed_pipe = feed_pipe ? feed_pipe : default_feed_pipe;
 	pp->task_finished = task_finished ? task_finished : default_task_finished;
+	pp->consume_sideband = consume_sideband;
 
 	pp->nr_processes = 0;
 	pp->output_owner = 0;
@@ -1615,7 +1618,10 @@ static void pp_cleanup(struct parallel_processes *pp)
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
@@ -1736,9 +1742,13 @@ static void pp_buffer_stderr(struct parallel_processes *pp, int output_timeout)
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
@@ -1777,11 +1787,15 @@ static int pp_collect_finished(struct parallel_processes *pp)
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
@@ -1805,6 +1819,7 @@ int run_processes_parallel(int n,
 			   get_next_task_fn get_next_task,
 			   start_failure_fn start_failure,
 			   feed_pipe_fn feed_pipe,
+			   consume_sideband_fn consume_sideband,
 			   task_finished_fn task_finished,
 			   void *pp_cb)
 {
@@ -1815,7 +1830,7 @@ int run_processes_parallel(int n,
 
 	sigchain_push(SIGPIPE, SIG_IGN);
 
-	pp_init(&pp, n, get_next_task, start_failure, feed_pipe, task_finished, pp_cb);
+	pp_init(&pp, n, get_next_task, start_failure, feed_pipe, consume_sideband, task_finished, pp_cb);
 	while (1) {
 		for (i = 0;
 		    i < spawn_cap && !pp.shutdown &&
@@ -1853,6 +1868,7 @@ int run_processes_parallel(int n,
 int run_processes_parallel_tr2(int n, get_next_task_fn get_next_task,
 			       start_failure_fn start_failure,
 			       feed_pipe_fn feed_pipe,
+			       consume_sideband_fn consume_sideband,
 			       task_finished_fn task_finished, void *pp_cb,
 			       const char *tr2_category, const char *tr2_label)
 {
@@ -1862,7 +1878,8 @@ int run_processes_parallel_tr2(int n, get_next_task_fn get_next_task,
 				   ((n < 1) ? online_cpus() : n));
 
 	result = run_processes_parallel(n, get_next_task, start_failure,
-					feed_pipe, task_finished, pp_cb);
+					feed_pipe, consume_sideband,
+					task_finished, pp_cb);
 
 	trace2_region_leave(tr2_category, tr2_label, NULL);
 
diff --git a/run-command.h b/run-command.h
index 41e36d26cb..7150da851a 100644
--- a/run-command.h
+++ b/run-command.h
@@ -433,6 +433,20 @@ typedef int (*feed_pipe_fn)(struct strbuf *pipe,
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
@@ -468,10 +482,12 @@ int run_processes_parallel(int n,
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
 
 #endif
diff --git a/submodule.c b/submodule.c
index ea026a8195..7fe0c8f7c9 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1645,7 +1645,7 @@ int fetch_populated_submodules(struct repository *r,
 	run_processes_parallel_tr2(max_parallel_jobs,
 				   get_next_submodule,
 				   fetch_start_failure,
-				   NULL,
+				   NULL, NULL,
 				   fetch_finish,
 				   &spf,
 				   "submodule", "parallel/fetch");
diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index 9348184d30..d53db6d11c 100644
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
index 87759482ad..e99f6c7f44 100755
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
2.32.0.576.g59759b6ca7d

