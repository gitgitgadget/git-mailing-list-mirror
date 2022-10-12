Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D092BC433FE
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 09:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiJLJCp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 05:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiJLJCO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 05:02:14 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D352CBB061
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 02:01:50 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id ay36so10056579wmb.0
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 02:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MjFMAeeGU++6ujCSCowCWceZiRYmFLX8xaffSWmvtHk=;
        b=dYt7CCDqXWCug0te3xu9+U7MNVo1QDbulDErRUwWnBJshobRIk5obrE5N7reGXjr3v
         tJWqr1+aIEgFRr8HZX+okf2MGLJ1ePD230u6QG/5IYMwjoku35VUw+sXWhE594OOVk10
         MPJ3OXelsPb82lbytGfgLiSs+T+o1e6B7wDbJaNV4+XQRrgdyu89MFjltn7Sd4feAzUn
         61K6SmpTtrF/gapUm5EyuiN4b2RmS93ZM2eQEbuf+wvACxHk5N6CLbBnLaOdbDc6Q9AH
         2ysz2AIvqJlWh7eiPXUzDH6Yto7448CWrkgyx4LUtXipFNM2qej8OxRKVPOFd1pmP2Mx
         4lQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MjFMAeeGU++6ujCSCowCWceZiRYmFLX8xaffSWmvtHk=;
        b=lY/pEW4O3qJIqmTggm6KmRFEHNoz1u6Ctqw16NpWAxfOqGnbd6Pv4z63xmUHU6Os0V
         2kdd234xHi8dHVfHlC79eThiz7rY+TTklRl37p8Qcjb1IVqT/F0PTuIMz2o3VX9eABD7
         Kom1Qb2RY27kbAqMqJBeL1bmEpEo5Ztzbmn8h104EsdyLseVsz0j6iXKL2D+HrzHI2zc
         2GffZvGe3NPOvk0kBL53ADz+2d55gX5g2arzxAHlKo3kPxVGOrE582EwWwilYyGHCiry
         h3CopYNj1P2tasI/h4ymOfzZ2Vibyr4/PWmlPSLWfolyZcQXO1HvoYGaBaBnE/gkLvST
         M3mg==
X-Gm-Message-State: ACrzQf00Oqh/DzIzP9kPHpX30etVaHAsNFXhcAwsJOAHKRJGLEV0jC54
        DCCGTCmP928kvaltnWQ7vxzsffhDfKDr2Q==
X-Google-Smtp-Source: AMsMyM4rIzXTbrGfyl68sOB+A2K7oWOIY/lDW7T8f3NtIWzVGmglHwdNVCvDrD7K7HK2wbsU9gZjRA==
X-Received: by 2002:a05:600c:5388:b0:3c5:4c1:a1f6 with SMTP id hg8-20020a05600c538800b003c504c1a1f6mr1999390wmb.11.1665565307675;
        Wed, 12 Oct 2022 02:01:47 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b1-20020a05600c4e0100b003a3170a7af9sm1280362wmq.4.2022.10.12.02.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 02:01:46 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 09/22] run-command API: make "n" parameter a "size_t"
Date:   Wed, 12 Oct 2022 11:01:17 +0200
Message-Id: <patch-v2-09.22-a900711270c-20221012T084850Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.971.ge79ff6d20e7
In-Reply-To: <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com> <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make the "n" variable added in c553c72eed6 (run-command: add an
asynchronous parallel child processor, 2015-12-15) a "size_t". As
we'll see in a subsequent commit we do pass "0" here, but never "jobs
< 0".

We could have made it an "unsigned int", but as we're having to change
this let's not leave another case in the codebase where a size_t and
"unsigned int" size differ on some platforms. In this case it's likely
to never matter, but it's easier to not need to worry about it.

After this and preceding changes:

	make run-command.o DEVOPTS=extra-all CFLAGS=-Wno-unused-parameter

Only has one (and new) -Wsigned-compare warning, about a comparison of
"i" to online_cpus(), a subsequent commit will adjust & deal with
online_cpus() and that warning.

The only users of the "n" parameter are:

 * builtin/fetch.c: defaults to 1, reads from the "fetch.parallel"
   config. As seen in the code that parses the config added in
   d54dea77dba (fetch: let --jobs=<n> parallelize --multiple, too,
   2019-10-05) will die if the git_config_int() return value is < 0.

   It will however pass us n = 0, as we'll see in a subsequent commit.

 * submodule.c: defaults to 1, reads from "submodule.fetchJobs"
   config. Read via code originally added in a028a1930c6 (fetching
   submodules: respect `submodule.fetchJobs` config option, 2016-02-29).

   It now piggy-backs on the the submodule.fetchJobs code and
   validation added in f20e7c1ea24 (submodule: remove
   submodule.fetchjobs from submodule-config parsing, 2017-08-02).

   Like builtin/fetch.c it will die if the git_config_int() return
   value is < 0, but like builtin/fetch.c it will pass us n = 0.

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
 run-command.c | 44 ++++++++++++++++++--------------------------
 run-command.h |  4 ++--
 2 files changed, 20 insertions(+), 28 deletions(-)

diff --git a/run-command.c b/run-command.c
index 7b27e4de78d..5a63008b6e1 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1498,8 +1498,8 @@ int run_processes_parallel_ungroup;
 struct parallel_processes {
 	void *data;
 
-	int max_processes;
-	int nr_processes;
+	size_t max_processes;
+	size_t nr_processes;
 
 	get_next_task_fn get_next_task;
 	start_failure_fn start_failure;
@@ -1520,7 +1520,7 @@ struct parallel_processes {
 	unsigned shutdown : 1;
 	unsigned ungroup : 1;
 
-	int output_owner;
+	size_t output_owner;
 	struct strbuf buffered_output; /* of finished children */
 };
 
@@ -1541,9 +1541,7 @@ static int default_task_finished(int result,
 
 static void kill_children(struct parallel_processes *pp, int signo)
 {
-	int i, n = pp->max_processes;
-
-	for (i = 0; i < n; i++)
+	for (size_t i = 0; i < pp->max_processes; i++)
 		if (pp->children[i].state == GIT_CP_WORKING)
 			kill(pp->children[i].process.pid, signo);
 }
@@ -1558,20 +1556,19 @@ static void handle_children_on_signal(int signo)
 }
 
 static void pp_init(struct parallel_processes *pp,
-		    int n,
+		    size_t n,
 		    get_next_task_fn get_next_task,
 		    start_failure_fn start_failure,
 		    task_finished_fn task_finished,
 		    void *data, int ungroup)
 {
-	int i;
-
 	if (n < 1)
 		n = online_cpus();
 
 	pp->max_processes = n;
 
-	trace_printf("run_processes_parallel: preparing to run up to %d tasks", n);
+	trace_printf("run_processes_parallel: preparing to run up to %"PRIuMAX" tasks",
+		     (uintmax_t)n);
 
 	pp->data = data;
 	if (!get_next_task)
@@ -1592,7 +1589,7 @@ static void pp_init(struct parallel_processes *pp,
 		CALLOC_ARRAY(pp->pfd, n);
 	strbuf_init(&pp->buffered_output, 0);
 
-	for (i = 0; i < n; i++) {
+	for (size_t i = 0; i < n; i++) {
 		strbuf_init(&pp->children[i].err, 0);
 		child_process_init(&pp->children[i].process);
 		if (pp->pfd) {
@@ -1607,10 +1604,8 @@ static void pp_init(struct parallel_processes *pp,
 
 static void pp_cleanup(struct parallel_processes *pp)
 {
-	int i;
-
 	trace_printf("run_processes_parallel: done");
-	for (i = 0; i < pp->max_processes; i++) {
+	for (size_t i = 0; i < pp->max_processes; i++) {
 		strbuf_release(&pp->children[i].err);
 		child_process_clear(&pp->children[i].process);
 	}
@@ -1637,7 +1632,8 @@ static void pp_cleanup(struct parallel_processes *pp)
  */
 static int pp_start_one(struct parallel_processes *pp)
 {
-	int i, code;
+	size_t i;
+	int code;
 
 	for (i = 0; i < pp->max_processes; i++)
 		if (pp->children[i].state == GIT_CP_FREE)
@@ -1685,8 +1681,6 @@ static int pp_start_one(struct parallel_processes *pp)
 
 static void pp_buffer_stderr(struct parallel_processes *pp, int output_timeout)
 {
-	int i;
-
 	while (poll(pp->pfd, pp->max_processes, output_timeout) < 0) {
 		if (errno == EINTR)
 			continue;
@@ -1695,7 +1689,7 @@ static void pp_buffer_stderr(struct parallel_processes *pp, int output_timeout)
 	}
 
 	/* Buffer output from all pipes. */
-	for (i = 0; i < pp->max_processes; i++) {
+	for (size_t i = 0; i < pp->max_processes; i++) {
 		if (pp->children[i].state == GIT_CP_WORKING &&
 		    pp->pfd[i].revents & (POLLIN | POLLHUP)) {
 			int n = strbuf_read_once(&pp->children[i].err,
@@ -1712,7 +1706,7 @@ static void pp_buffer_stderr(struct parallel_processes *pp, int output_timeout)
 
 static void pp_output(struct parallel_processes *pp)
 {
-	int i = pp->output_owner;
+	size_t i = pp->output_owner;
 
 	if (pp->children[i].state == GIT_CP_WORKING &&
 	    pp->children[i].err.len) {
@@ -1723,8 +1717,8 @@ static void pp_output(struct parallel_processes *pp)
 
 static int pp_collect_finished(struct parallel_processes *pp)
 {
-	int i, code;
-	int n = pp->max_processes;
+	int code;
+	size_t i, n = pp->max_processes;
 	int result = 0;
 
 	while (pp->nr_processes > 0) {
@@ -1781,7 +1775,7 @@ static int pp_collect_finished(struct parallel_processes *pp)
 	return result;
 }
 
-void run_processes_parallel(int n,
+void run_processes_parallel(size_t n,
 			    get_next_task_fn get_next_task,
 			    start_failure_fn start_failure,
 			    task_finished_fn task_finished,
@@ -1815,9 +1809,7 @@ void run_processes_parallel(int n,
 		if (!pp.nr_processes)
 			break;
 		if (ungroup) {
-			int i;
-
-			for (i = 0; i < pp.max_processes; i++)
+			for (size_t i = 0; i < pp.max_processes; i++)
 				pp.children[i].state = GIT_CP_WAIT_CLEANUP;
 		} else {
 			pp_buffer_stderr(&pp, output_timeout);
@@ -1834,7 +1826,7 @@ void run_processes_parallel(int n,
 	pp_cleanup(&pp);
 }
 
-void run_processes_parallel_tr2(int n, get_next_task_fn get_next_task,
+void run_processes_parallel_tr2(size_t n, get_next_task_fn get_next_task,
 				start_failure_fn start_failure,
 				task_finished_fn task_finished, void *pp_cb,
 				const char *tr2_category, const char *tr2_label)
diff --git a/run-command.h b/run-command.h
index e76a1b6b5b3..6f7604e1146 100644
--- a/run-command.h
+++ b/run-command.h
@@ -485,12 +485,12 @@ typedef int (*task_finished_fn)(int result,
  * API reads that setting.
  */
 extern int run_processes_parallel_ungroup;
-void run_processes_parallel(int n,
+void run_processes_parallel(size_t n,
 			    get_next_task_fn,
 			    start_failure_fn,
 			    task_finished_fn,
 			    void *pp_cb);
-void run_processes_parallel_tr2(int n, get_next_task_fn, start_failure_fn,
+void run_processes_parallel_tr2(size_t n, get_next_task_fn, start_failure_fn,
 				task_finished_fn, void *pp_cb,
 				const char *tr2_category, const char *tr2_label);
 
-- 
2.38.0.971.ge79ff6d20e7

