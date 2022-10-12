Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCCAC4332F
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 09:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiJLJCu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 05:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiJLJC1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 05:02:27 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A2BBBE36
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 02:01:55 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id a10so25199263wrm.12
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 02:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=26HNmMIt+e5BOyybrcX7bo5j81DiUQ9iRBcmvdBxeDw=;
        b=Ubj/f02vr8EJNUP7KL/dYd/cQvuX5CiFTr35x1D38auewSQMjRxs+WcQhW/W4nCfYq
         dPg8FyHdbNXdKG3ZGa2ourf7QLpKAbuRisY+sa+51Yiwjcm6f/NP7FLp2ZV/KbZ0hhhF
         6klikuHrrxzvKz1LSgDsrjzFwebJ4Wm7uxFs4x/3Seb1coG9P3Lthy/qEuAK34rGyev9
         RGEr9Jk5pZrcSw8Eje2ZOU3IqcY5WomL7wVEBlw16+EJUwq0vuIOGViHTA1rnJprq9Yp
         GlyGn72nY1gAnO4f2pzoCQTFU+U1jvCHrjv5r/RXf+CvA+yyDnRxGLppiE6jJ9oWVyDa
         LNtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=26HNmMIt+e5BOyybrcX7bo5j81DiUQ9iRBcmvdBxeDw=;
        b=PvwtGumQyZkDri9LOaVPr+Y/VjqIRdcNMnBREA+q8vtHLrmDaJRp6P6SEdNO/W4rjr
         iYeZ9T0HtMMLraVUokctG/q/wFFfIUOkZYmiV21AW/8uShl3Xw6cNbIY7pAE/q5IeUge
         1fnNIQutQ04q///ivuxByN5UQN/LOhfyoACmp7O2e2Ax0D7e5VooNXK4HX9GI+eWBbcc
         oMSTc3czjyFms7MitRGSzROkQqyvRVTVfAadEUuWS3PCsgV1jNkQ11XJhRWg2uD0Hn1H
         eV5wj+VPOLtdEN4Yp17WghXnMyeAVpiKTzpK9p7tA3s3pkZ8HqoWnz17rwUWoiCW2Zb1
         jMCQ==
X-Gm-Message-State: ACrzQf33EaKyPFeTQTNTfl3oDj2TwKUH/mZl9Yl+bkgDSzMzr+GrIOFk
        idnjB1x1vivqLCmCjhLr1N3QPCZR5oUi+w==
X-Google-Smtp-Source: AMsMyM4dr6+t6T7aE1htf5z4lvt+x0vK5mEO1Z4POmmjG/e/TgIOqv9uyHXJapAgI9w5vbz9UVI7Tg==
X-Received: by 2002:a5d:6484:0:b0:230:7cad:c268 with SMTP id o4-20020a5d6484000000b002307cadc268mr9645994wri.335.1665565312815;
        Wed, 12 Oct 2022 02:01:52 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b1-20020a05600c4e0100b003a3170a7af9sm1280362wmq.4.2022.10.12.02.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 02:01:51 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 12/22] run-command API: add nascent "struct run_process_parallel_opts"
Date:   Wed, 12 Oct 2022 11:01:20 +0200
Message-Id: <patch-v2-12.22-fde2af11579-20221012T084850Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.971.ge79ff6d20e7
In-Reply-To: <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com> <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As noted in fd3aaf53f71 (run-command: add an "ungroup" option to
run_process_parallel(), 2022-06-07) which added the "ungroup" passing
it to "run_process_parallel()" via the global
"run_processes_parallel_ungroup" variable was a compromise to get the
smallest possible regression fix for "maint" at the time.

This follow-up to that is a start at passing that parameter and others
via a new "struct run_process_parallel_opts", as the earlier
version[1] of what became fd3aaf53f71 did.

For now we're only changing how data is passed internally to
"run-command.c", i.e. from "run_process_parallel()" to
pp_init(). Subsequent commits will change "run_processes_parallel()"
itself, as well as the "run_processes_parallel_tr2()" wrapper
function.

Since we need to change all of the occurrences of "n" to
"opt->SOMETHING" let's take the opportunity and rename the terse "n"
to "processes". We could also have picked "max_processes", "jobs",
"threads" etc., but as the API is named "run_processes_parallel()"
let's go with "processes".

1. https://lore.kernel.org/git/cover-v2-0.8-00000000000-20220518T195858Z-avarab@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 run-command.c | 30 ++++++++++++++++++++----------
 run-command.h | 46 +++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 59 insertions(+), 17 deletions(-)

diff --git a/run-command.c b/run-command.c
index 6acfd29d8c1..3042cb26172 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1556,11 +1556,12 @@ static void handle_children_on_signal(int signo)
 }
 
 static void pp_init(struct parallel_processes *pp,
-		    get_next_task_fn get_next_task,
-		    start_failure_fn start_failure,
-		    task_finished_fn task_finished)
+		    const struct run_process_parallel_opts *opts)
 {
-	const size_t n = pp->max_processes;
+	const size_t n = opts->processes;
+	get_next_task_fn get_next_task = opts->get_next_task;
+	start_failure_fn start_failure = opts->start_failure;
+	task_finished_fn task_finished = opts->task_finished;
 
 	if (!n)
 		BUG("you must provide a non-zero number of processes!");
@@ -1765,7 +1766,7 @@ static int pp_collect_finished(struct parallel_processes *pp)
 	return result;
 }
 
-void run_processes_parallel(size_t n,
+void run_processes_parallel(size_t processes,
 			    get_next_task_fn get_next_task,
 			    start_failure_fn start_failure,
 			    task_finished_fn task_finished,
@@ -1774,18 +1775,27 @@ void run_processes_parallel(size_t n,
 	int code;
 	int output_timeout = 100;
 	int spawn_cap = 4;
-	int ungroup = run_processes_parallel_ungroup;
 	struct parallel_processes pp = {
-		.max_processes = n,
+		.max_processes = processes,
 		.data = pp_cb,
 		.buffered_output = STRBUF_INIT,
-		.ungroup = ungroup,
+		.ungroup = run_processes_parallel_ungroup,
+	};
+	const struct run_process_parallel_opts opts = {
+		.processes = processes,
+
+		.get_next_task = get_next_task,
+		.start_failure = start_failure,
+		.task_finished = task_finished,
+
+		.ungroup = run_processes_parallel_ungroup,
 	};
 
 	/* unset for the next API user */
 	run_processes_parallel_ungroup = 0;
 
-	pp_init(&pp, get_next_task, start_failure, task_finished);
+	pp_init(&pp, &opts);
+
 	while (1) {
 		for (int i = 0;
 		    i < spawn_cap && !pp.shutdown &&
@@ -1802,7 +1812,7 @@ void run_processes_parallel(size_t n,
 		}
 		if (!pp.nr_processes)
 			break;
-		if (ungroup) {
+		if (opts.ungroup) {
 			for (size_t i = 0; i < pp.max_processes; i++)
 				pp.children[i].state = GIT_CP_WAIT_CLEANUP;
 		} else {
diff --git a/run-command.h b/run-command.h
index 6f7604e1146..03be48e7ce3 100644
--- a/run-command.h
+++ b/run-command.h
@@ -459,7 +459,42 @@ typedef int (*task_finished_fn)(int result,
 				void *pp_task_cb);
 
 /**
- * Runs up to n processes at the same time. Whenever a process can be
+ * Option used by run_processes_parallel(), { 0 }-initialized means no
+ * options.
+ */
+struct run_process_parallel_opts
+{
+	/**
+	 * processes: see 'processes' in run_processes_parallel() below.
+	 */
+	size_t processes;
+
+	/**
+	 * ungroup: see 'ungroup' in run_processes_parallel() below.
+	 */
+	unsigned int ungroup:1;
+
+	/**
+	 * get_next_task: See get_next_task_fn() above. This must be
+	 * specified.
+	 */
+	get_next_task_fn get_next_task;
+
+	/**
+	 * start_failure: See start_failure_fn() above. This can be
+	 * NULL to omit any special handling.
+	 */
+	start_failure_fn start_failure;
+
+	/**
+	 * task_finished: See task_finished_fn() above. This can be
+	 * NULL to omit any special handling.
+	 */
+	task_finished_fn task_finished;
+};
+
+/**
+ * Runs N 'processes' at the same time. Whenever a process can be
  * started, the callback get_next_task_fn is called to obtain the data
  * required to start another child process.
  *
@@ -467,9 +502,6 @@ typedef int (*task_finished_fn)(int result,
  * (both stdout and stderr) is routed to stderr in a manner that output
  * from different tasks does not interleave (but see "ungroup" below).
  *
- * start_failure_fn and task_finished_fn can be NULL to omit any
- * special handling.
- *
  * If the "ungroup" option isn't specified, the API will set the
  * "stdout_to_stderr" parameter in "struct child_process" and provide
  * the callbacks with a "struct strbuf *out" parameter to write output
@@ -485,13 +517,13 @@ typedef int (*task_finished_fn)(int result,
  * API reads that setting.
  */
 extern int run_processes_parallel_ungroup;
-void run_processes_parallel(size_t n,
+void run_processes_parallel(size_t processes,
 			    get_next_task_fn,
 			    start_failure_fn,
 			    task_finished_fn,
 			    void *pp_cb);
-void run_processes_parallel_tr2(size_t n, get_next_task_fn, start_failure_fn,
-				task_finished_fn, void *pp_cb,
+void run_processes_parallel_tr2(size_t processes, get_next_task_fn,
+				start_failure_fn, task_finished_fn, void *pp_cb,
 				const char *tr2_category, const char *tr2_label);
 
 /**
-- 
2.38.0.971.ge79ff6d20e7

