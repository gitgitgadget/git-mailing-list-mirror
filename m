Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D2AC4332F
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 21:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiJLVDe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 17:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiJLVD2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 17:03:28 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1FBBDB
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 14:03:26 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id u10so27977019wrq.2
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 14:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5i/VlNChALuCT9gMq8XDHo5XRVOUINHsUwh5rkTXCOE=;
        b=jvBNbLjgavQrhzS6Og/0BnB44jLkJ14n+xVIZOe4qH4FIODozjTTOJAJL3Ce18HXQJ
         Lis4LLF1I8YuE44L6OZ8fdbBg7ADx/uP4ecTqqH/MmNNHPE+NSp3mMxwxwITCqu8pybm
         Zxd0c38YvA3AWGEZ7eNrjH9vxfJ2NWbPQH/poyYVRuzEWu/hOePUtpTbMxNhJ4zc4QTI
         hB4hJBMVIlXgcOS9cHtJPHXhLenW1gshkuBd8vHoTJiokEumJvX1d8lOc+TkvaaHgeb9
         8/SRHSAwWf+e3P4wN2BH4Rt6EgyKvklQdVwjXcm3UtGGpECANp5qZT7MhCCb7eFD2mzB
         uRgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5i/VlNChALuCT9gMq8XDHo5XRVOUINHsUwh5rkTXCOE=;
        b=nT3dq55b3loHq49MIu5wWwnAPvgUdJzfxfCn1sWWWLuT2ckRzNvexxc4W6aqAApUS4
         jAUfsFtakP+I9yNEySnWMJ3WcD3B25vLxWyiB2jryrLHuwLW057C+wSboCkkt7m6nCdg
         33KK17ZBK4+CKVvbLZxPmh32modj2nFBU29o2FTUHXlOOneTYT3rUIWby7hqz0w6c+Mz
         Wj8CfFyfLFOF0peyFksp6eCHYk67w+gQGU2DjW/ue4WcKqIY2p02jdOALZbBZDSSTuLS
         kWQz6neE411bBdxTOFhVrU99PswrUdiqRelQcw81m+vKuwz4ls9zIGIAsWeQ60YjDbgU
         P8Kw==
X-Gm-Message-State: ACrzQf2bltTjnmJHZmJMXL2Rym3D3vAOLsn75fpFWznh+TLCQdp9UcXT
        kib2kByOlSET8HugKBzY7CJJkadEvjsafg==
X-Google-Smtp-Source: AMsMyM6aylExyrGIx/aXGw7DbNT5xRb0LCN9zLqHuwN9HDzbcbdk4rt3W9RU04AhFL8/cFszTqKwPw==
X-Received: by 2002:adf:ebcf:0:b0:22c:9eb4:d6f6 with SMTP id v15-20020adfebcf000000b0022c9eb4d6f6mr19270092wrn.251.1665608604770;
        Wed, 12 Oct 2022 14:03:24 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b6-20020adff246000000b00228a6ce17b4sm550079wrp.37.2022.10.12.14.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 14:03:24 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 04/15] run-command API: make "n" parameter a "size_t"
Date:   Wed, 12 Oct 2022 23:02:23 +0200
Message-Id: <patch-v3-04.15-58018a79b2f-20221012T205712Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.971.ge79ff6d20e7
In-Reply-To: <cover-v3-00.15-00000000000-20221012T205712Z-avarab@gmail.com>
References: <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com> <cover-v3-00.15-00000000000-20221012T205712Z-avarab@gmail.com>
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

Only has one (and new) -Wsigned-compare warning relevant to a
comparison about our "n" or "{nr,max}_processes": About using our
"n" (size_t) in the same expression as online_cpus() (int). A
subsequent commit will adjust & deal with online_cpus() and that
warning.

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
 run-command.c | 42 ++++++++++++++++++------------------------
 run-command.h |  4 ++--
 2 files changed, 20 insertions(+), 26 deletions(-)

diff --git a/run-command.c b/run-command.c
index 642e6b6e057..14a6e38e804 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1500,8 +1500,8 @@ int run_processes_parallel_ungroup;
 struct parallel_processes {
 	void *data;
 
-	int max_processes;
-	int nr_processes;
+	size_t max_processes;
+	size_t nr_processes;
 
 	get_next_task_fn get_next_task;
 	start_failure_fn start_failure;
@@ -1522,7 +1522,7 @@ struct parallel_processes {
 	unsigned shutdown : 1;
 	unsigned ungroup : 1;
 
-	int output_owner;
+	size_t output_owner;
 	struct strbuf buffered_output; /* of finished children */
 };
 
@@ -1543,9 +1543,7 @@ static int default_task_finished(int result,
 
 static void kill_children(struct parallel_processes *pp, int signo)
 {
-	int i, n = pp->max_processes;
-
-	for (i = 0; i < n; i++)
+	for (size_t i = 0; i < pp->max_processes; i++)
 		if (pp->children[i].state == GIT_CP_WORKING)
 			kill(pp->children[i].process.pid, signo);
 }
@@ -1560,20 +1558,19 @@ static void handle_children_on_signal(int signo)
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
@@ -1594,7 +1591,7 @@ static void pp_init(struct parallel_processes *pp,
 		CALLOC_ARRAY(pp->pfd, n);
 	strbuf_init(&pp->buffered_output, 0);
 
-	for (i = 0; i < n; i++) {
+	for (size_t i = 0; i < n; i++) {
 		strbuf_init(&pp->children[i].err, 0);
 		child_process_init(&pp->children[i].process);
 		if (pp->pfd) {
@@ -1609,10 +1606,8 @@ static void pp_init(struct parallel_processes *pp,
 
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
@@ -1639,7 +1634,8 @@ static void pp_cleanup(struct parallel_processes *pp)
  */
 static int pp_start_one(struct parallel_processes *pp)
 {
-	int i, code;
+	size_t i;
+	int code;
 
 	for (i = 0; i < pp->max_processes; i++)
 		if (pp->children[i].state == GIT_CP_FREE)
@@ -1697,7 +1693,7 @@ static void pp_buffer_stderr(struct parallel_processes *pp, int output_timeout)
 	}
 
 	/* Buffer output from all pipes. */
-	for (i = 0; i < pp->max_processes; i++) {
+	for (size_t i = 0; i < pp->max_processes; i++) {
 		if (pp->children[i].state == GIT_CP_WORKING &&
 		    pp->pfd[i].revents & (POLLIN | POLLHUP)) {
 			int n = strbuf_read_once(&pp->children[i].err,
@@ -1714,7 +1710,7 @@ static void pp_buffer_stderr(struct parallel_processes *pp, int output_timeout)
 
 static void pp_output(struct parallel_processes *pp)
 {
-	int i = pp->output_owner;
+	size_t i = pp->output_owner;
 
 	if (pp->children[i].state == GIT_CP_WORKING &&
 	    pp->children[i].err.len) {
@@ -1725,8 +1721,8 @@ static void pp_output(struct parallel_processes *pp)
 
 static int pp_collect_finished(struct parallel_processes *pp)
 {
-	int i, code;
-	int n = pp->max_processes;
+	int code;
+	size_t i, n = pp->max_processes;
 	int result = 0;
 
 	while (pp->nr_processes > 0) {
@@ -1783,7 +1779,7 @@ static int pp_collect_finished(struct parallel_processes *pp)
 	return result;
 }
 
-void run_processes_parallel(int n,
+void run_processes_parallel(size_t n,
 			    get_next_task_fn get_next_task,
 			    start_failure_fn start_failure,
 			    task_finished_fn task_finished,
@@ -1817,9 +1813,7 @@ void run_processes_parallel(int n,
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
@@ -1836,7 +1830,7 @@ void run_processes_parallel(int n,
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

