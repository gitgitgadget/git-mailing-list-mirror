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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDC4C432BE
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5423D6108E
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345223AbhIBNNw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 09:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345145AbhIBNNn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 09:13:43 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF54C0612A4
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 06:12:11 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v10so2855693wrd.4
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 06:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h1n2lBVFFvzwmpKaHJ/cBboK1g18RxJd1kUSpIHdmDU=;
        b=aMCheC508S0q67XG8siBXMj8qgtsyJcBOXORMxne0LxOnoKU+hJo0CcTOe9Uv0mdkk
         a7ZirKFCRs6EKS4KfEO6aBTFwm0nWqFPBHhNX+ifkGMRSPqCwN8UHEEhhXwNwZyBCCAd
         1OaF8ES/GVLzoORqVXLtMoHMlv76gLRPss9PbLshstxIEeD3DwogDus0s4U/Ra+xnWUf
         5Epc2ObhBapRq0gnkjwjauA1Z8WjR67DEVYBw+17M8ZOJ0uJSkD0P+hIEKNezbHm4IDK
         K6fBVAhG78+xC+Uf4Ps4oM2PTq3e4W3mBArXGyOFBRQLeLbz4ElVpQ3rsEvVcFySKU+G
         bavQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h1n2lBVFFvzwmpKaHJ/cBboK1g18RxJd1kUSpIHdmDU=;
        b=CbDQZYHb0M9LgG7rhP+I3GYo37hzTBNseCtisFph8ZlegepRtc6bJJk/Rc3OYf3Qpl
         N6jHMrzQBW9ww7DL4Ph6gm/e/ngfuwvOWCLG5nHGslExKOyU6VSVsiXCpJ+Z9K+IL/WF
         ghQ8J9iLPFAnC4MqAgpjlzatSkH9GdTzdenh2YAK+0SU7uHnIdSnvl8ej24dNdFpgZF0
         SrP4DoEPPt2M9hnlSSr/+PoxlJVT0Uo7hNZ1oKL+ZARDVJKBVxbE1p5SxPn6RRd22WN3
         NhyJkQowCLxi/vIdIQ9sEzeM5DB+XRN+kP2z8Hpb6PmioabUYNkOKECOXQ4UrAcL1mPW
         YpCg==
X-Gm-Message-State: AOAM532lw34FLfn7bO7EInGfpuALP0EjDwdf6nCDHbGTIjCfbSknyMyA
        r9gOb2jdg/H4J63YH8gjOdD385wT2bLMRA==
X-Google-Smtp-Source: ABdhPJxXiJlPzXee0M7NfNJTap/Upfc8+54mdj8sEtEQRenApUfLq+JjnRrjViw4fq2vJVJorxl7YQ==
X-Received: by 2002:a5d:6286:: with SMTP id k6mr3586159wru.103.1630588329285;
        Thu, 02 Sep 2021 06:12:09 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o7sm1479635wmq.36.2021.09.02.06.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 06:12:08 -0700 (PDT)
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
Subject: [PATCH v5 24/36] run-command: add stdin callback for parallelization
Date:   Thu,  2 Sep 2021 15:11:24 +0200
Message-Id: <patch-v5-24.36-bb119fa7cc0-20210902T125110Z-avarab@gmail.com>
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
index e064687dbdc..b18ada08842 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1819,6 +1819,7 @@ static int fetch_multiple(struct string_list *list, int max_children)
 		result = run_processes_parallel_tr2(max_children,
 						    &fetch_next_remote,
 						    &fetch_failed_to_start,
+						    NULL,
 						    &fetch_finished,
 						    &state,
 						    "fetch", "parallel/fetch");
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index ef2776a9e45..0b73739c160 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2311,7 +2311,7 @@ static int update_submodules(struct submodule_update_clone *suc)
 	int i;
 
 	run_processes_parallel_tr2(suc->max_jobs, update_clone_get_next_task,
-				   update_clone_start_failure,
+				   update_clone_start_failure, NULL,
 				   update_clone_task_finished, suc, "submodule",
 				   "parallel/update");
 
diff --git a/hook.c b/hook.c
index d156b0dc800..45983d08aed 100644
--- a/hook.c
+++ b/hook.c
@@ -146,6 +146,7 @@ int run_hooks(const char *hook_name, const char *hook_path,
 	run_processes_parallel_tr2(jobs,
 				   pick_next_hook,
 				   notify_start_failure,
+				   NULL,
 				   notify_hook_finished,
 				   &cb_data,
 				   "hook",
diff --git a/run-command.c b/run-command.c
index 482ee2d76c6..f1616858d18 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1492,6 +1492,7 @@ struct parallel_processes {
 
 	get_next_task_fn get_next_task;
 	start_failure_fn start_failure;
+	feed_pipe_fn feed_pipe;
 	task_finished_fn task_finished;
 
 	struct {
@@ -1519,6 +1520,13 @@ static int default_start_failure(struct strbuf *out,
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
@@ -1549,6 +1557,7 @@ static void pp_init(struct parallel_processes *pp,
 		    int n,
 		    get_next_task_fn get_next_task,
 		    start_failure_fn start_failure,
+		    feed_pipe_fn feed_pipe,
 		    task_finished_fn task_finished,
 		    void *data)
 {
@@ -1567,6 +1576,7 @@ static void pp_init(struct parallel_processes *pp,
 	pp->get_next_task = get_next_task;
 
 	pp->start_failure = start_failure ? start_failure : default_start_failure;
+	pp->feed_pipe = feed_pipe ? feed_pipe : default_feed_pipe;
 	pp->task_finished = task_finished ? task_finished : default_task_finished;
 
 	pp->nr_processes = 0;
@@ -1664,6 +1674,37 @@ static int pp_start_one(struct parallel_processes *pp)
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
@@ -1728,6 +1769,7 @@ static int pp_collect_finished(struct parallel_processes *pp)
 		pp->nr_processes--;
 		pp->children[i].state = GIT_CP_FREE;
 		pp->pfd[i].fd = -1;
+		pp->children[i].process.in = 0;
 		child_process_init(&pp->children[i].process);
 
 		if (i != pp->output_owner) {
@@ -1761,6 +1803,7 @@ static int pp_collect_finished(struct parallel_processes *pp)
 int run_processes_parallel(int n,
 			   get_next_task_fn get_next_task,
 			   start_failure_fn start_failure,
+			   feed_pipe_fn feed_pipe,
 			   task_finished_fn task_finished,
 			   void *pp_cb)
 {
@@ -1769,7 +1812,9 @@ int run_processes_parallel(int n,
 	int spawn_cap = 4;
 	struct parallel_processes pp;
 
-	pp_init(&pp, n, get_next_task, start_failure, task_finished, pp_cb);
+	sigchain_push(SIGPIPE, SIG_IGN);
+
+	pp_init(&pp, n, get_next_task, start_failure, feed_pipe, task_finished, pp_cb);
 	while (1) {
 		for (i = 0;
 		    i < spawn_cap && !pp.shutdown &&
@@ -1786,6 +1831,7 @@ int run_processes_parallel(int n,
 		}
 		if (!pp.nr_processes)
 			break;
+		pp_buffer_stdin(&pp);
 		pp_buffer_stderr(&pp, output_timeout);
 		pp_output(&pp);
 		code = pp_collect_finished(&pp);
@@ -1797,11 +1843,15 @@ int run_processes_parallel(int n,
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
@@ -1811,7 +1861,7 @@ int run_processes_parallel_tr2(int n, get_next_task_fn get_next_task,
 				   ((n < 1) ? online_cpus() : n));
 
 	result = run_processes_parallel(n, get_next_task, start_failure,
-					task_finished, pp_cb);
+					feed_pipe, task_finished, pp_cb);
 
 	trace2_region_leave(tr2_category, tr2_label, NULL);
 
diff --git a/run-command.h b/run-command.h
index cfb6887e4ae..80d394664ae 100644
--- a/run-command.h
+++ b/run-command.h
@@ -422,6 +422,20 @@ typedef int (*start_failure_fn)(struct strbuf *out,
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
@@ -456,10 +470,11 @@ typedef int (*task_finished_fn)(int result,
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
 
 /**
diff --git a/submodule.c b/submodule.c
index 8e611fe1dbf..db1700a502d 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1632,6 +1632,7 @@ int fetch_populated_submodules(struct repository *r,
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
2.33.0.816.g1ba32acadee

