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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36F6C47087
	for <git@archiver.kernel.org>; Fri, 28 May 2021 12:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99B4D601FD
	for <git@archiver.kernel.org>; Fri, 28 May 2021 12:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236681AbhE1MOp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 08:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236593AbhE1MNp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 08:13:45 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FA8C06134D
        for <git@vger.kernel.org>; Fri, 28 May 2021 05:12:00 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id m18so2028101wmq.0
        for <git@vger.kernel.org>; Fri, 28 May 2021 05:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S9mjDfk++LIIVr2VKDRNRxOCBcEi8IjzmMWEsYog3GM=;
        b=PziZD6k54H5vjW+DJ7CZUVy55HFbjGJq0d/dVoW5mBTF9gMnvQP+uAFhX14hIrJ1Sw
         YN9+QsQU9inXU0Z1HA3AGmTQlxDMcO2vImfG6PZSzsQyIUMjpVzZ2ZFCz5bDkogC3SVj
         34zR8av4SI8EQEptSwogTdDG1qODz7rRkAJVAW3mXITaH2yC4+UFSf+IDVR8eV0HHkOY
         PBTOWmEAcEVUV/QVBcORg2sMQmsxHdN28e1QFNwD6OLSdBvCuVHJVLlnQj6BB8WV228s
         0E8tJqP5wpmAI6K4AWcnHUGt/j//Hna15VYuIyrNE7UmUpDLUGIFNxvAEtFDIKKBf1C+
         sRHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S9mjDfk++LIIVr2VKDRNRxOCBcEi8IjzmMWEsYog3GM=;
        b=MAsMvjMDmdKqqDKFfBxO8e4oFW/GsEbhDsxQziaeIVgT77ob068eyoU9zGtjh34Wht
         iIlqTxfvp7CXS3Qtf7r1gFpoX2JN7EGpG3Z86cgiywh7JVNv0jDY+pC39IUll6/BDkXR
         I2Ti57IPBVIvxNqoEeaYfzbsIdGpxt5ilmz/aWF8X6f6vDF4xBeEnu1Ke5/3PNqMr2J7
         CiaU4unC/zQI9yOMybS0qPauIOWAPWng5t0ay9PKLx93gj4qCoPWMR2Mj9IjBViC4jgx
         ywPTWMWlXqVTA1tOGY7YSVs1pkaRs85k+OPRp7QXfujv6dCZLrxxfPqRvOtW7bwdOV6p
         vcZw==
X-Gm-Message-State: AOAM533iAVPBso7sR/nBA6GLAOx+saK+NvuVh7sG2+MWHZEboolNTLBh
        cRsUltILkfO7MkTn8eUhp0bVXXGPSOsivA==
X-Google-Smtp-Source: ABdhPJzvbTlAgS96yn2tEVa504oL6vgrn+FaSQ2GqaMdVxn55cY7qQNddgY+rHfsHh1k5VMQRILQxw==
X-Received: by 2002:a05:600c:3043:: with SMTP id n3mr8257964wmh.98.1622203918860;
        Fri, 28 May 2021 05:11:58 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c15sm7372269wro.21.2021.05.28.05.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 05:11:58 -0700 (PDT)
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
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 20/31] run-command: add stdin callback for parallelization
Date:   Fri, 28 May 2021 14:11:22 +0200
Message-Id: <patch-20.31-756f52af22d-20210528T110515Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc1.460.g26a014da44c
In-Reply-To: <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com>
References: <87lf80l1m6.fsf@evledraar.gmail.com> <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

If a user of the run_processes_parallel() API wants to pipe a large
amount of information to stdin of each parallel command, that
information could exceed the buffer of the pipe allocated for that
process's stdin.  Generally this is solved by repeatedly writing to
child_process.in between calls to start_command() and finish_command();
run_processes_parallel() did not provide users an opportunity to access
child_process at that time.

Because the data might be extremely large (for example, a list of all
refs received during a push from a client) simply taking a string_list
or strbuf is not as scalable as using a callback; the rest of the
run_processes_parallel() API also uses callbacks, so making this feature
match the rest of the API reduces mental load on the user.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/fetch.c             |  1 +
 builtin/submodule--helper.c |  2 +-
 hook.c                      |  1 +
 run-command.c               | 54 +++++++++++++++++++++++++++++++++++--
 run-command.h               | 17 +++++++++++-
 submodule.c                 |  1 +
 t/helper/test-run-command.c | 31 ++++++++++++++++++---
 t/t0061-run-command.sh      | 30 +++++++++++++++++++++
 8 files changed, 129 insertions(+), 8 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index dfde96a4354..a07816b6504 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1817,6 +1817,7 @@ static int fetch_multiple(struct string_list *list, int max_children)
 		result = run_processes_parallel_tr2(max_children,
 						    &fetch_next_remote,
 						    &fetch_failed_to_start,
+						    NULL,
 						    &fetch_finished,
 						    &state,
 						    "fetch", "parallel/fetch");
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index d55f6262e9c..8d1e7310737 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2295,7 +2295,7 @@ static int update_submodules(struct submodule_update_clone *suc)
 	int i;
 
 	run_processes_parallel_tr2(suc->max_jobs, update_clone_get_next_task,
-				   update_clone_start_failure,
+				   update_clone_start_failure, NULL,
 				   update_clone_task_finished, suc, "submodule",
 				   "parallel/update");
 
diff --git a/hook.c b/hook.c
index daf39f61741..5f6335bac3f 100644
--- a/hook.c
+++ b/hook.c
@@ -139,6 +139,7 @@ int run_found_hooks(const char *hook_name, const char *hook_path,
 	run_processes_parallel_tr2(options->jobs,
 				   pick_next_hook,
 				   notify_start_failure,
+				   NULL,
 				   notify_hook_finished,
 				   &cb_data,
 				   "hook",
diff --git a/run-command.c b/run-command.c
index 0bf771845e4..3392640f17b 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1493,6 +1493,7 @@ struct parallel_processes {
 
 	get_next_task_fn get_next_task;
 	start_failure_fn start_failure;
+	feed_pipe_fn feed_pipe;
 	task_finished_fn task_finished;
 
 	struct {
@@ -1520,6 +1521,13 @@ static int default_start_failure(struct strbuf *out,
 	return 0;
 }
 
+static int default_feed_pipe(struct strbuf *pipe,
+			     void *pp_cb,
+			     void *pp_task_cb)
+{
+	return 1;
+}
+
 static int default_task_finished(int result,
 				 struct strbuf *out,
 				 void *pp_cb,
@@ -1550,6 +1558,7 @@ static void pp_init(struct parallel_processes *pp,
 		    int n,
 		    get_next_task_fn get_next_task,
 		    start_failure_fn start_failure,
+		    feed_pipe_fn feed_pipe,
 		    task_finished_fn task_finished,
 		    void *data)
 {
@@ -1568,6 +1577,7 @@ static void pp_init(struct parallel_processes *pp,
 	pp->get_next_task = get_next_task;
 
 	pp->start_failure = start_failure ? start_failure : default_start_failure;
+	pp->feed_pipe = feed_pipe ? feed_pipe : default_feed_pipe;
 	pp->task_finished = task_finished ? task_finished : default_task_finished;
 
 	pp->nr_processes = 0;
@@ -1665,6 +1675,37 @@ static int pp_start_one(struct parallel_processes *pp)
 	return 0;
 }
 
+static void pp_buffer_stdin(struct parallel_processes *pp)
+{
+	int i;
+	struct strbuf sb = STRBUF_INIT;
+
+	/* Buffer stdin for each pipe. */
+	for (i = 0; i < pp->max_processes; i++) {
+		if (pp->children[i].state == GIT_CP_WORKING &&
+		    pp->children[i].process.in > 0) {
+			int done;
+			strbuf_reset(&sb);
+			done = pp->feed_pipe(&sb, pp->data,
+					      pp->children[i].data);
+			if (sb.len) {
+				if (write_in_full(pp->children[i].process.in,
+					      sb.buf, sb.len) < 0) {
+					if (errno != EPIPE)
+						die_errno("write");
+					done = 1;
+				}
+			}
+			if (done) {
+				close(pp->children[i].process.in);
+				pp->children[i].process.in = 0;
+			}
+		}
+	}
+
+	strbuf_release(&sb);
+}
+
 static void pp_buffer_stderr(struct parallel_processes *pp, int output_timeout)
 {
 	int i;
@@ -1729,6 +1770,7 @@ static int pp_collect_finished(struct parallel_processes *pp)
 		pp->nr_processes--;
 		pp->children[i].state = GIT_CP_FREE;
 		pp->pfd[i].fd = -1;
+		pp->children[i].process.in = 0;
 		child_process_init(&pp->children[i].process);
 
 		if (i != pp->output_owner) {
@@ -1762,6 +1804,7 @@ static int pp_collect_finished(struct parallel_processes *pp)
 int run_processes_parallel(int n,
 			   get_next_task_fn get_next_task,
 			   start_failure_fn start_failure,
+			   feed_pipe_fn feed_pipe,
 			   task_finished_fn task_finished,
 			   void *pp_cb)
 {
@@ -1770,7 +1813,9 @@ int run_processes_parallel(int n,
 	int spawn_cap = 4;
 	struct parallel_processes pp;
 
-	pp_init(&pp, n, get_next_task, start_failure, task_finished, pp_cb);
+	sigchain_push(SIGPIPE, SIG_IGN);
+
+	pp_init(&pp, n, get_next_task, start_failure, feed_pipe, task_finished, pp_cb);
 	while (1) {
 		for (i = 0;
 		    i < spawn_cap && !pp.shutdown &&
@@ -1787,6 +1832,7 @@ int run_processes_parallel(int n,
 		}
 		if (!pp.nr_processes)
 			break;
+		pp_buffer_stdin(&pp);
 		pp_buffer_stderr(&pp, output_timeout);
 		pp_output(&pp);
 		code = pp_collect_finished(&pp);
@@ -1798,11 +1844,15 @@ int run_processes_parallel(int n,
 	}
 
 	pp_cleanup(&pp);
+
+	sigchain_pop(SIGPIPE);
+
 	return 0;
 }
 
 int run_processes_parallel_tr2(int n, get_next_task_fn get_next_task,
 			       start_failure_fn start_failure,
+			       feed_pipe_fn feed_pipe,
 			       task_finished_fn task_finished, void *pp_cb,
 			       const char *tr2_category, const char *tr2_label)
 {
@@ -1812,7 +1862,7 @@ int run_processes_parallel_tr2(int n, get_next_task_fn get_next_task,
 				   ((n < 1) ? online_cpus() : n));
 
 	result = run_processes_parallel(n, get_next_task, start_failure,
-					task_finished, pp_cb);
+					feed_pipe, task_finished, pp_cb);
 
 	trace2_region_leave(tr2_category, tr2_label, NULL);
 
diff --git a/run-command.h b/run-command.h
index 748d4fc2a72..41e36d26cb1 100644
--- a/run-command.h
+++ b/run-command.h
@@ -419,6 +419,20 @@ typedef int (*start_failure_fn)(struct strbuf *out,
 				void *pp_cb,
 				void *pp_task_cb);
 
+/**
+ * This callback is called repeatedly on every child process who requests
+ * start_command() to create a pipe by setting child_process.in < 0.
+ *
+ * pp_cb is the callback cookie as passed into run_processes_parallel, and
+ * pp_task_cb is the callback cookie as passed into get_next_task_fn.
+ * The contents of 'send' will be read into the pipe and passed to the pipe.
+ *
+ * Return nonzero to close the pipe.
+ */
+typedef int (*feed_pipe_fn)(struct strbuf *pipe,
+			    void *pp_cb,
+			    void *pp_task_cb);
+
 /**
  * This callback is called on every child process that finished processing.
  *
@@ -453,10 +467,11 @@ typedef int (*task_finished_fn)(int result,
 int run_processes_parallel(int n,
 			   get_next_task_fn,
 			   start_failure_fn,
+			   feed_pipe_fn,
 			   task_finished_fn,
 			   void *pp_cb);
 int run_processes_parallel_tr2(int n, get_next_task_fn, start_failure_fn,
-			       task_finished_fn, void *pp_cb,
+			       feed_pipe_fn, task_finished_fn, void *pp_cb,
 			       const char *tr2_category, const char *tr2_label);
 
 #endif
diff --git a/submodule.c b/submodule.c
index 0b1d9c1dde5..ea026a8195f 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1645,6 +1645,7 @@ int fetch_populated_submodules(struct repository *r,
 	run_processes_parallel_tr2(max_parallel_jobs,
 				   get_next_submodule,
 				   fetch_start_failure,
+				   NULL,
 				   fetch_finish,
 				   &spf,
 				   "submodule", "parallel/fetch");
diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index 7ae03dc7123..9348184d303 100644
--- a/t/helper/test-run-command.c
+++ b/t/helper/test-run-command.c
@@ -32,8 +32,13 @@ static int parallel_next(struct child_process *cp,
 		return 0;
 
 	strvec_pushv(&cp->args, d->argv);
+	cp->in = d->in;
+	cp->no_stdin = d->no_stdin;
 	strbuf_addstr(err, "preloaded output of a child\n");
 	number_callbacks++;
+
+	*task_cb = xmalloc(sizeof(int));
+	*(int*)(*task_cb) = 2;
 	return 1;
 }
 
@@ -55,6 +60,17 @@ static int task_finished(int result,
 	return 1;
 }
 
+static int test_stdin(struct strbuf *pipe, void *cb, void *task_cb)
+{
+	int *lines_remaining = task_cb;
+
+	if (*lines_remaining)
+		strbuf_addf(pipe, "sample stdin %d\n", --(*lines_remaining));
+
+	return !(*lines_remaining);
+}
+
+
 struct testsuite {
 	struct string_list tests, failed;
 	int next;
@@ -185,7 +201,7 @@ static int testsuite(int argc, const char **argv)
 		suite.tests.nr, max_jobs);
 
 	ret = run_processes_parallel(max_jobs, next_test, test_failed,
-				     test_finished, &suite);
+				     test_stdin, test_finished, &suite);
 
 	if (suite.failed.nr > 0) {
 		ret = 1;
@@ -413,15 +429,22 @@ int cmd__run_command(int argc, const char **argv)
 
 	if (!strcmp(argv[1], "run-command-parallel"))
 		exit(run_processes_parallel(jobs, parallel_next,
-					    NULL, NULL, &proc));
+					    NULL, NULL, NULL, &proc));
 
 	if (!strcmp(argv[1], "run-command-abort"))
 		exit(run_processes_parallel(jobs, parallel_next,
-					    NULL, task_finished, &proc));
+					    NULL, NULL, task_finished, &proc));
 
 	if (!strcmp(argv[1], "run-command-no-jobs"))
 		exit(run_processes_parallel(jobs, no_job,
-					    NULL, task_finished, &proc));
+					    NULL, NULL, task_finished, &proc));
+
+	if (!strcmp(argv[1], "run-command-stdin")) {
+		proc.in = -1;
+		proc.no_stdin = 0;
+		exit (run_processes_parallel(jobs, parallel_next, NULL,
+					     test_stdin, NULL, &proc));
+	}
 
 	fprintf(stderr, "check usage\n");
 	return 1;
diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index 7d599675e35..87759482ad1 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -143,6 +143,36 @@ test_expect_success 'run_command runs in parallel with more tasks than jobs avai
 	test_cmp expect actual
 '
 
+cat >expect <<-EOF
+preloaded output of a child
+listening for stdin:
+sample stdin 1
+sample stdin 0
+preloaded output of a child
+listening for stdin:
+sample stdin 1
+sample stdin 0
+preloaded output of a child
+listening for stdin:
+sample stdin 1
+sample stdin 0
+preloaded output of a child
+listening for stdin:
+sample stdin 1
+sample stdin 0
+EOF
+
+test_expect_success 'run_command listens to stdin' '
+	write_script stdin-script <<-\EOF &&
+	echo "listening for stdin:"
+	while read line; do
+		echo "$line"
+	done
+	EOF
+	test-tool run-command run-command-stdin 2 ./stdin-script 2>actual &&
+	test_cmp expect actual
+'
+
 cat >expect <<-EOF
 preloaded output of a child
 asking for a quick stop
-- 
2.32.0.rc1.458.gd885d4f985c

