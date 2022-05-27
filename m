Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 869CBC433EF
	for <git@archiver.kernel.org>; Fri, 27 May 2022 09:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238528AbiE0JOp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 05:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241899AbiE0JOn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 05:14:43 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3F82AF2
        for <git@vger.kernel.org>; Fri, 27 May 2022 02:14:41 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f23-20020a7bcc17000000b003972dda143eso4211303wmh.3
        for <git@vger.kernel.org>; Fri, 27 May 2022 02:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E8WSc+AMxr5b3bae1WT4AVQJueRnn5oNwqohbdxVFVg=;
        b=CKdpBUwTPiLAVwkaDNpfobRHUubXUJZzOMn0kv7yYaYt0ValQXgujUXl/B1QBuFRf1
         35UR07Pm0ITrhKecT1b5CWuyd73CbOrJIole+2pNIof4vmlOp7Q7pRbRLk+EQ3icCprz
         /qikrj5eZR7h60wQVLyxUOAebAavEEN1PJiwv1t6+lJlgMmL/vwL0u7H04DPsO71UYKi
         onVJQHg4JoJFE0ONGI5UbCaXijaZ383wfttYjEm9ydQctAo05lQDkPFAHKrHiduZQQC/
         MvO7pmzOf+LLzQV0uIf0KCWQBIXnIC8aqZVCtjXVOcVG2xPBCFo7qwkKu/diGxdAcLUh
         2rcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E8WSc+AMxr5b3bae1WT4AVQJueRnn5oNwqohbdxVFVg=;
        b=rKJYfmdj9lwizq7dD2V31YEMZG/gXogGFX3LXqCEbnrcK5LXx4wpWDpWHC8pjRmiL8
         DA+gd9in3s1yYXgnZSe7cSDFLGFUfPq62G8wruyTQUuSjzTur2kzuLV7pPaqejlAvMt0
         DvHykIZ5PJIziNz1xqhQf+5P/QUfnxi136HdKzbvx7VL8xoTNtSvZT272g8GYRR7YC+z
         3e3G4PgspUWlVYCYUlHmjvRbBh6LZ1UFxWTpu7Icouxws+x2WBcn3GP0ij9i6SgnQIa9
         NNm1bQYCxECqOem4FtUhAmKa4vJ0Ldrbq2B9NbwbkU0/u8CHu+bpMFOY05DRIK3qdcer
         aTkA==
X-Gm-Message-State: AOAM530shV795QOWgkCmPD631wmurxrtou3xPtqXHQaQaN6nKnsoTfMy
        SVLIi2Cr8mdF3vdlhIp/8BJ0bngwO/DQWg==
X-Google-Smtp-Source: ABdhPJxMkFoOLsfE0F13fZ89EOxs3Q6f6XHdgqM6HBt+nHblhV0E/cLQ3vPNNDE1jssajzBN8N6/mA==
X-Received: by 2002:a05:600c:1d28:b0:397:65ef:fb9e with SMTP id l40-20020a05600c1d2800b0039765effb9emr5882687wms.136.1653642879111;
        Fri, 27 May 2022 02:14:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d11-20020a05600c3acb00b003942a244ecbsm1551466wms.16.2022.05.27.02.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 02:14:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Anthony Sottile <asottile@umich.edu>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 1/2] run-command: add an "ungroup" option to run_process_parallel()
Date:   Fri, 27 May 2022 11:14:30 +0200
Message-Id: <patch-v3-1.2-aabd99de680-20220527T090618Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1046.g586767a6996
In-Reply-To: <cover-v3-0.2-00000000000-20220527T090618Z-avarab@gmail.com>
References: <cover-v2-0.8-00000000000-20220518T195858Z-avarab@gmail.com> <cover-v3-0.2-00000000000-20220527T090618Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extend the parallel execution API added in c553c72eed6 (run-command:
add an asynchronous parallel child processor, 2015-12-15) to support a
mode where the stdout and stderr of the processes isn't captured and
output in a deterministic order, instead we'll leave it to the kernel
and stdio to sort it out.

This gives the API same functionality as GNU parallel's --ungroup
option. As we'll see in a subsequent commit the main reason to want
this is to support stdout and stderr being connected to the TTY in the
case of jobs=1, demonstrated here with GNU parallel:

	$ parallel --ungroup 'test -t {} && echo TTY || echo NTTY' ::: 1 2
	TTY
	TTY
	$ parallel 'test -t {} && echo TTY || echo NTTY' ::: 1 2
	NTTY
	NTTY

Another is as GNU parallel's documentation notes a potential for
optimization. Our results will be a bit different, but in cases where
you want to run processes in parallel where the exact order isn't
important this can be a lot faster:

	$ hyperfine -r 3 -L o ,--ungroup 'parallel {o} seq ::: 10000000 >/dev/null '
	Benchmark 1: parallel  seq ::: 10000000 >/dev/null
	  Time (mean ± σ):     220.2 ms ±   9.3 ms    [User: 124.9 ms, System: 96.1 ms]
	  Range (min … max):   212.3 ms … 230.5 ms    3 runs

	Benchmark 2: parallel --ungroup seq ::: 10000000 >/dev/null
	  Time (mean ± σ):     154.7 ms ±   0.9 ms    [User: 136.2 ms, System: 25.1 ms]
	  Range (min … max):   153.9 ms … 155.7 ms    3 runs

	Summary
	  'parallel --ungroup seq ::: 10000000 >/dev/null ' ran
	    1.42 ± 0.06 times faster than 'parallel  seq ::: 10000000 >/dev/null '

A large part of the juggling in the API is to make the API safer for
its maintenance and consumers alike.

For the maintenance of the API we e.g. avoid malloc()-ing the
"pp->pfd", ensuring that SANITIZE=address and other similar tools will
catch any unexpected misuse.

For API consumers we take pains to never pass the non-NULL "out"
buffer to an API user that provided the "ungroup" option. The
resulting code in t/helper/test-run-command.c isn't typical of such a
user, i.e. they'd typically use one mode or the other, and would know
whether they'd provided "ungroup" or not.

We could also avoid the strbuf_init() for "buffered_output" by having
"struct parallel_processes" use a static PARALLEL_PROCESSES_INIT
initializer, but let's leave that cleanup for later.

Using a global "run_processes_parallel_ungroup" variable to enable
this option is rather nasty, but is being done here to produce as
minimal of a change as possible for a subsequent regression fix. This
change is extracted from a larger initial version[1] which ends up
with a better end-state for the API, but in doing so needed to modify
all existing callers of the API. Let's defer that for now, and
narrowly focus on what we need for fixing the regression in the
subsequent commit.

It's safe to do this with a global variable because:

 A) hook.c is the only user of it that sets it to non-zero, and before
    we'll get any other API users we'll refactor away this method of
    passing in the option, i.e. re-roll [1].

 B) Even if hook.c wasn't the only user we don't have callers of this
    API that concurrently invoke this parallel process starting API
    itself in parallel.

As noted above "A" && "B" are rather nasty, and we don't want to live
with those caveats long-term, but for now they should be an acceptable
compromise.

1. https://lore.kernel.org/git/cover-v2-0.8-00000000000-20220518T195858Z-avarab@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 run-command.c               | 88 ++++++++++++++++++++++++++++---------
 run-command.h               | 31 ++++++++++---
 t/helper/test-run-command.c | 19 ++++++--
 t/t0061-run-command.sh      | 35 +++++++++++++++
 4 files changed, 143 insertions(+), 30 deletions(-)

diff --git a/run-command.c b/run-command.c
index a8501e38ceb..b5ede8655d3 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1468,9 +1468,10 @@ int pipe_command(struct child_process *cmd,
 enum child_state {
 	GIT_CP_FREE,
 	GIT_CP_WORKING,
-	GIT_CP_WAIT_CLEANUP,
+	GIT_CP_WAIT_CLEANUP, /* only for !ungroup */
 };
 
+int run_processes_parallel_ungroup;
 struct parallel_processes {
 	void *data;
 
@@ -1494,6 +1495,7 @@ struct parallel_processes {
 	struct pollfd *pfd;
 
 	unsigned shutdown : 1;
+	unsigned ungroup : 1;
 
 	int output_owner;
 	struct strbuf buffered_output; /* of finished children */
@@ -1537,7 +1539,7 @@ static void pp_init(struct parallel_processes *pp,
 		    get_next_task_fn get_next_task,
 		    start_failure_fn start_failure,
 		    task_finished_fn task_finished,
-		    void *data)
+		    void *data,  const int ungroup)
 {
 	int i;
 
@@ -1559,13 +1561,19 @@ static void pp_init(struct parallel_processes *pp,
 	pp->nr_processes = 0;
 	pp->output_owner = 0;
 	pp->shutdown = 0;
+	pp->ungroup = ungroup;
 	CALLOC_ARRAY(pp->children, n);
-	CALLOC_ARRAY(pp->pfd, n);
+	if (pp->ungroup)
+		pp->pfd = NULL;
+	else
+		CALLOC_ARRAY(pp->pfd, n);
 	strbuf_init(&pp->buffered_output, 0);
 
 	for (i = 0; i < n; i++) {
 		strbuf_init(&pp->children[i].err, 0);
 		child_process_init(&pp->children[i].process);
+		if (!pp->pfd)
+			continue;
 		pp->pfd[i].events = POLLIN | POLLHUP;
 		pp->pfd[i].fd = -1;
 	}
@@ -1591,7 +1599,8 @@ static void pp_cleanup(struct parallel_processes *pp)
 	 * When get_next_task added messages to the buffer in its last
 	 * iteration, the buffered output is non empty.
 	 */
-	strbuf_write(&pp->buffered_output, stderr);
+	if (!pp->ungroup)
+		strbuf_write(&pp->buffered_output, stderr);
 	strbuf_release(&pp->buffered_output);
 
 	sigchain_pop_common();
@@ -1606,6 +1615,7 @@ static void pp_cleanup(struct parallel_processes *pp)
  */
 static int pp_start_one(struct parallel_processes *pp)
 {
+	const int ungroup = pp->ungroup;
 	int i, code;
 
 	for (i = 0; i < pp->max_processes; i++)
@@ -1615,24 +1625,30 @@ static int pp_start_one(struct parallel_processes *pp)
 		BUG("bookkeeping is hard");
 
 	code = pp->get_next_task(&pp->children[i].process,
-				 &pp->children[i].err,
+				 ungroup ? NULL : &pp->children[i].err,
 				 pp->data,
 				 &pp->children[i].data);
 	if (!code) {
-		strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
-		strbuf_reset(&pp->children[i].err);
+		if (!ungroup) {
+			strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
+			strbuf_reset(&pp->children[i].err);
+		}
 		return 1;
 	}
-	pp->children[i].process.err = -1;
-	pp->children[i].process.stdout_to_stderr = 1;
+	if (!ungroup) {
+		pp->children[i].process.err = -1;
+		pp->children[i].process.stdout_to_stderr = 1;
+	}
 	pp->children[i].process.no_stdin = 1;
 
 	if (start_command(&pp->children[i].process)) {
-		code = pp->start_failure(&pp->children[i].err,
+		code = pp->start_failure(ungroup ? NULL : &pp->children[i].err,
 					 pp->data,
 					 pp->children[i].data);
-		strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
-		strbuf_reset(&pp->children[i].err);
+		if (!ungroup) {
+			strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
+			strbuf_reset(&pp->children[i].err);
+		}
 		if (code)
 			pp->shutdown = 1;
 		return code;
@@ -1640,14 +1656,26 @@ static int pp_start_one(struct parallel_processes *pp)
 
 	pp->nr_processes++;
 	pp->children[i].state = GIT_CP_WORKING;
-	pp->pfd[i].fd = pp->children[i].process.err;
+	if (pp->pfd)
+		pp->pfd[i].fd = pp->children[i].process.err;
 	return 0;
 }
 
+static void pp_mark_working_for_cleanup(struct parallel_processes *pp)
+{
+	int i;
+
+	for (i = 0; i < pp->max_processes; i++)
+		if (pp->children[i].state == GIT_CP_WORKING)
+			pp->children[i].state = GIT_CP_WAIT_CLEANUP;
+}
+
 static void pp_buffer_stderr(struct parallel_processes *pp, int output_timeout)
 {
 	int i;
 
+	assert(!pp->ungroup);
+
 	while ((i = poll(pp->pfd, pp->max_processes, output_timeout)) < 0) {
 		if (errno == EINTR)
 			continue;
@@ -1674,6 +1702,9 @@ static void pp_buffer_stderr(struct parallel_processes *pp, int output_timeout)
 static void pp_output(struct parallel_processes *pp)
 {
 	int i = pp->output_owner;
+
+	assert(!pp->ungroup);
+
 	if (pp->children[i].state == GIT_CP_WORKING &&
 	    pp->children[i].err.len) {
 		strbuf_write(&pp->children[i].err, stderr);
@@ -1683,10 +1714,15 @@ static void pp_output(struct parallel_processes *pp)
 
 static int pp_collect_finished(struct parallel_processes *pp)
 {
+	const int ungroup = pp->ungroup;
 	int i, code;
 	int n = pp->max_processes;
 	int result = 0;
 
+	if (ungroup)
+		for (i = 0; i < pp->max_processes; i++)
+			pp->children[i].state = GIT_CP_WAIT_CLEANUP;
+
 	while (pp->nr_processes > 0) {
 		for (i = 0; i < pp->max_processes; i++)
 			if (pp->children[i].state == GIT_CP_WAIT_CLEANUP)
@@ -1697,8 +1733,8 @@ static int pp_collect_finished(struct parallel_processes *pp)
 		code = finish_command(&pp->children[i].process);
 
 		code = pp->task_finished(code,
-					 &pp->children[i].err, pp->data,
-					 pp->children[i].data);
+					 ungroup ? NULL : &pp->children[i].err,
+					 pp->data, pp->children[i].data);
 
 		if (code)
 			result = code;
@@ -1707,10 +1743,13 @@ static int pp_collect_finished(struct parallel_processes *pp)
 
 		pp->nr_processes--;
 		pp->children[i].state = GIT_CP_FREE;
-		pp->pfd[i].fd = -1;
+		if (pp->pfd)
+			pp->pfd[i].fd = -1;
 		child_process_init(&pp->children[i].process);
 
-		if (i != pp->output_owner) {
+		if (ungroup) {
+			; /* no strbuf_*() work to do here */
+		} else if (i != pp->output_owner) {
 			strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
 			strbuf_reset(&pp->children[i].err);
 		} else {
@@ -1748,8 +1787,13 @@ int run_processes_parallel(int n,
 	int output_timeout = 100;
 	int spawn_cap = 4;
 	struct parallel_processes pp;
+	const int ungroup = run_processes_parallel_ungroup;
 
-	pp_init(&pp, n, get_next_task, start_failure, task_finished, pp_cb);
+	/* unset for the next API user */
+	run_processes_parallel_ungroup = 0;
+
+	pp_init(&pp, n, get_next_task, start_failure, task_finished, pp_cb,
+		ungroup);
 	while (1) {
 		for (i = 0;
 		    i < spawn_cap && !pp.shutdown &&
@@ -1766,8 +1810,12 @@ int run_processes_parallel(int n,
 		}
 		if (!pp.nr_processes)
 			break;
-		pp_buffer_stderr(&pp, output_timeout);
-		pp_output(&pp);
+		if (ungroup) {
+			pp_mark_working_for_cleanup(&pp);
+		} else {
+			pp_buffer_stderr(&pp, output_timeout);
+			pp_output(&pp);
+		}
 		code = pp_collect_finished(&pp);
 		if (code) {
 			pp.shutdown = 1;
diff --git a/run-command.h b/run-command.h
index 5bd0c933e80..a44d2a6ba75 100644
--- a/run-command.h
+++ b/run-command.h
@@ -405,6 +405,10 @@ void check_pipe(int err);
  * pp_cb is the callback cookie as passed to run_processes_parallel.
  * You can store a child process specific callback cookie in pp_task_cb.
  *
+ * The "struct strbuf *err" parameter is either a pointer to a string
+ * to write errors to, or NULL if the "ungroup" option was
+ * provided. See run_processes_parallel() below.
+ *
  * Even after returning 0 to indicate that there are no more processes,
  * this function will be called again until there are no more running
  * child processes.
@@ -423,9 +427,9 @@ typedef int (*get_next_task_fn)(struct child_process *cp,
  * This callback is called whenever there are problems starting
  * a new process.
  *
- * You must not write to stdout or stderr in this function. Add your
- * message to the strbuf out instead, which will be printed without
- * messing up the output of the other parallel processes.
+ * The "struct strbuf *err" parameter is either a pointer to a string
+ * to write errors to, or NULL if the "ungroup" option was
+ * provided. See run_processes_parallel() below.
  *
  * pp_cb is the callback cookie as passed into run_processes_parallel,
  * pp_task_cb is the callback cookie as passed into get_next_task_fn.
@@ -441,9 +445,9 @@ typedef int (*start_failure_fn)(struct strbuf *out,
 /**
  * This callback is called on every child process that finished processing.
  *
- * You must not write to stdout or stderr in this function. Add your
- * message to the strbuf out instead, which will be printed without
- * messing up the output of the other parallel processes.
+ * The "struct strbuf *err" parameter is either a pointer to a string
+ * to write errors to, or NULL if the "ungroup" option was
+ * provided. See run_processes_parallel() below.
  *
  * pp_cb is the callback cookie as passed into run_processes_parallel,
  * pp_task_cb is the callback cookie as passed into get_next_task_fn.
@@ -464,11 +468,24 @@ typedef int (*task_finished_fn)(int result,
  *
  * The children started via this function run in parallel. Their output
  * (both stdout and stderr) is routed to stderr in a manner that output
- * from different tasks does not interleave.
+ * from different tasks does not interleave (but see "ungroup" above).
  *
  * start_failure_fn and task_finished_fn can be NULL to omit any
  * special handling.
+ *
+ * If the "ungroup" option isn't specified the callbacks will get a
+ * pointer to a "struct strbuf *out", and must not write to stdout or
+ * stderr as such output will mess up the output of the other parallel
+ * processes. If "ungroup" option is specified callbacks will get a
+ * NULL "struct strbuf *out" parameter, and are responsible for
+ * emitting their own output, including dealing with any race
+ * conditions due to writing in parallel to stdout and stderr.
+ * The "ungroup" option can be enabled by setting the global
+ * "run_processes_parallel_ungroup" to "1" before invoking
+ * run_processes_parallel(), it will be set back to "0" as soon as the
+ * API reads that setting.
  */
+extern int run_processes_parallel_ungroup;
 int run_processes_parallel(int n,
 			   get_next_task_fn,
 			   start_failure_fn,
diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index f3b90aa834a..6405c9a076a 100644
--- a/t/helper/test-run-command.c
+++ b/t/helper/test-run-command.c
@@ -31,7 +31,11 @@ static int parallel_next(struct child_process *cp,
 		return 0;
 
 	strvec_pushv(&cp->args, d->args.v);
-	strbuf_addstr(err, "preloaded output of a child\n");
+	if (err)
+		strbuf_addstr(err, "preloaded output of a child\n");
+	else
+		fprintf(stderr, "preloaded output of a child\n");
+
 	number_callbacks++;
 	return 1;
 }
@@ -41,7 +45,10 @@ static int no_job(struct child_process *cp,
 		  void *cb,
 		  void **task_cb)
 {
-	strbuf_addstr(err, "no further jobs available\n");
+	if (err)
+		strbuf_addstr(err, "no further jobs available\n");
+	else
+		fprintf(stderr, "no further jobs available\n");
 	return 0;
 }
 
@@ -50,7 +57,10 @@ static int task_finished(int result,
 			 void *pp_cb,
 			 void *pp_task_cb)
 {
-	strbuf_addstr(err, "asking for a quick stop\n");
+	if (err)
+		strbuf_addstr(err, "asking for a quick stop\n");
+	else
+		fprintf(stderr, "asking for a quick stop\n");
 	return 1;
 }
 
@@ -411,6 +421,9 @@ int cmd__run_command(int argc, const char **argv)
 	strvec_clear(&proc.args);
 	strvec_pushv(&proc.args, (const char **)argv + 3);
 
+	if (getenv("RUN_PROCESSES_PARALLEL_UNGROUP"))
+		run_processes_parallel_ungroup = 1;
+
 	if (!strcmp(argv[1], "run-command-parallel"))
 		exit(run_processes_parallel(jobs, parallel_next,
 					    NULL, NULL, &proc));
diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index ee281909bc3..69ccaa8d298 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -134,16 +134,37 @@ test_expect_success 'run_command runs in parallel with more jobs available than
 	test_cmp expect actual
 '
 
+test_expect_success 'run_command runs ungrouped in parallel with more jobs available than tasks' '
+	RUN_PROCESSES_PARALLEL_UNGROUP=1 \
+	test-tool run-command run-command-parallel 5 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
+	test_line_count = 8 out &&
+	test_line_count = 4 err
+'
+
 test_expect_success 'run_command runs in parallel with as many jobs as tasks' '
 	test-tool run-command run-command-parallel 4 sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
 	test_cmp expect actual
 '
 
+test_expect_success 'run_command runs ungrouped in parallel with as many jobs as tasks' '
+	RUN_PROCESSES_PARALLEL_UNGROUP=1 \
+	test-tool run-command run-command-parallel 4 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
+	test_line_count = 8 out &&
+	test_line_count = 4 err
+'
+
 test_expect_success 'run_command runs in parallel with more tasks than jobs available' '
 	test-tool run-command run-command-parallel 3 sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
 	test_cmp expect actual
 '
 
+test_expect_success 'run_command runs ungrouped in parallel with more tasks than jobs available' '
+	RUN_PROCESSES_PARALLEL_UNGROUP=1 \
+	test-tool run-command run-command-parallel 3 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
+	test_line_count = 8 out &&
+	test_line_count = 4 err
+'
+
 cat >expect <<-EOF
 preloaded output of a child
 asking for a quick stop
@@ -158,6 +179,13 @@ test_expect_success 'run_command is asked to abort gracefully' '
 	test_cmp expect actual
 '
 
+test_expect_success 'run_command is asked to abort gracefully (ungroup)' '
+	RUN_PROCESSES_PARALLEL_UNGROUP=1 \
+	test-tool run-command run-command-abort 3 false >out 2>err &&
+	test_must_be_empty out &&
+	test_line_count = 6 err
+'
+
 cat >expect <<-EOF
 no further jobs available
 EOF
@@ -167,6 +195,13 @@ test_expect_success 'run_command outputs ' '
 	test_cmp expect actual
 '
 
+test_expect_success 'run_command outputs (ungroup) ' '
+	RUN_PROCESSES_PARALLEL_UNGROUP=1 \
+	test-tool run-command run-command-no-jobs 3 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
+	test_must_be_empty out &&
+	test_cmp expect err
+'
+
 test_trace () {
 	expect="$1"
 	shift
-- 
2.36.1.1046.g586767a6996

