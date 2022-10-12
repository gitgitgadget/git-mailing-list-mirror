Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C500C433FE
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 09:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiJLJCs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 05:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiJLJC1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 05:02:27 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C523BBA92A
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 02:01:56 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id w18so25251476wro.7
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 02:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uhZnxruwdib1SKtKhYB8j5uaCVItY1O3/SJsSpNO5U4=;
        b=BSSK8TbLaOlrOE/c5bOwUnKLvYxE1F/WJzvzPyOJgdlViu1Vvo6MF6FQ6tlHLi9KnQ
         2y7EWo5y60CVfJ9Um6tHuvrCkrvirAkuXEki1X1k5493JPUyVm4JbYlx5AXTL3wqSXnb
         2sL87nNahA8TOmVOB9U/8afqsbCi6hQlz885lVE6UuMtcKpS9uL5leRjykqgbgdkPtuD
         kUEZWOTPa8qiSTfgnvgFxoYl5pTaauDzek3rbO4Xienuxs+21654bhO21Ll3Pt537BDR
         sHgjIGsQgo3S7uH99JOQOlGZVzVBiqVAe/cd9lu0fPZvrFGAdvI48WdYM0f3I30aJZx7
         rdiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uhZnxruwdib1SKtKhYB8j5uaCVItY1O3/SJsSpNO5U4=;
        b=R2yDYUQMfSK/W4pW4U1KtMqUQAUsgtj3I+8dqltkDC3j5oVkGmn6nTZ40nm+C76gzL
         WlcO6xxZzAhFe1kbYqmMnT0p3WGUmKvz848maesMvySZyQWHbmdcn5zo2QNTv1jO5rX5
         vSke9Y+lQpLdkcjbv0cBxG1A38IP158o1q9453PXoj3USmhxh4FkdzhKM1pkoFZhPzAn
         30kZaqWcdDeWMsxltvdJvJmnXGpbw6CjowFwqpmFn66hQrtWbZqQUPwd6GC1wK/AAqCL
         RESdMBUWkc0XfTG7qKfk/IdsqhKbmdoLjF1AXTZww4vFpMuwlqFaSSZtwaWrNr+MOuB7
         T6TQ==
X-Gm-Message-State: ACrzQf0nBtsJEspUK36sW9vznUEKfz5n5KcgyO77VFw+7k1JyjHlSeqX
        Xa871mYbseX1ijzk62KInqbttG4P7rzz6A==
X-Google-Smtp-Source: AMsMyM4laT0Ynxiwjt/7XLh22ajZzYxcLsj7au6vhXMdmPMIsqTfB10FERHjfMpyqC7SAzDzRqYYxQ==
X-Received: by 2002:adf:f710:0:b0:22c:d668:504e with SMTP id r16-20020adff710000000b0022cd668504emr17373619wrp.98.1665565314515;
        Wed, 12 Oct 2022 02:01:54 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b1-20020a05600c4e0100b003a3170a7af9sm1280362wmq.4.2022.10.12.02.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 02:01:53 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 13/22] run-command API: make run_process_parallel{,_tr2}() thin wrappers
Date:   Wed, 12 Oct 2022 11:01:21 +0200
Message-Id: <patch-v2-13.22-01e894bed90-20221012T084850Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.971.ge79ff6d20e7
In-Reply-To: <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com> <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make the "run_process_parallel()" and "run_process_parallel_tr2()"
functions thin wrappers that construct a "struct
run_process_parallel_opts" struct, this is in preparation for changing
the API users to use a "struct run_process_parallel_opts" directly.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 run-command.c | 66 ++++++++++++++++++++++++++++++++++-----------------
 run-command.h |  7 ++++++
 2 files changed, 51 insertions(+), 22 deletions(-)

diff --git a/run-command.c b/run-command.c
index 3042cb26172..3cdf85876c1 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1766,36 +1766,30 @@ static int pp_collect_finished(struct parallel_processes *pp)
 	return result;
 }
 
-void run_processes_parallel(size_t processes,
-			    get_next_task_fn get_next_task,
-			    start_failure_fn start_failure,
-			    task_finished_fn task_finished,
-			    void *pp_cb)
+static void run_processes_parallel_1(const struct run_process_parallel_opts *opts, void *pp_cb)
 {
 	int code;
 	int output_timeout = 100;
 	int spawn_cap = 4;
 	struct parallel_processes pp = {
-		.max_processes = processes,
+		.max_processes = opts->processes,
 		.data = pp_cb,
 		.buffered_output = STRBUF_INIT,
 		.ungroup = run_processes_parallel_ungroup,
 	};
-	const struct run_process_parallel_opts opts = {
-		.processes = processes,
-
-		.get_next_task = get_next_task,
-		.start_failure = start_failure,
-		.task_finished = task_finished,
-
-		.ungroup = run_processes_parallel_ungroup,
-	};
+	/* options */
+	const char *tr2_category = opts->tr2_category;
+	const char *tr2_label = opts->tr2_label;
+	const int do_trace2 = tr2_category && tr2_label;
 
 	/* unset for the next API user */
 	run_processes_parallel_ungroup = 0;
 
-	pp_init(&pp, &opts);
+	if (do_trace2)
+		trace2_region_enter_printf(tr2_category, tr2_label, NULL,
+					   "max:%d", opts->processes);
 
+	pp_init(&pp, opts);
 	while (1) {
 		for (int i = 0;
 		    i < spawn_cap && !pp.shutdown &&
@@ -1812,7 +1806,7 @@ void run_processes_parallel(size_t processes,
 		}
 		if (!pp.nr_processes)
 			break;
-		if (opts.ungroup) {
+		if (opts->ungroup) {
 			for (size_t i = 0; i < pp.max_processes; i++)
 				pp.children[i].state = GIT_CP_WAIT_CLEANUP;
 		} else {
@@ -1828,19 +1822,47 @@ void run_processes_parallel(size_t processes,
 	}
 
 	pp_cleanup(&pp);
+
+	if (do_trace2)
+		trace2_region_leave(tr2_category, tr2_label, NULL);
+}
+
+void run_processes_parallel(size_t processes,
+			    get_next_task_fn get_next_task,
+			    start_failure_fn start_failure,
+			    task_finished_fn task_finished,
+			    void *pp_cb)
+{
+	const struct run_process_parallel_opts opts = {
+		.processes = processes,
+		.ungroup = run_processes_parallel_ungroup,
+
+		.get_next_task = get_next_task,
+		.start_failure = start_failure,
+		.task_finished = task_finished,
+	};
+
+	run_processes_parallel_1(&opts, pp_cb);
 }
 
-void run_processes_parallel_tr2(size_t n, get_next_task_fn get_next_task,
+void run_processes_parallel_tr2(size_t processes, get_next_task_fn get_next_task,
 				start_failure_fn start_failure,
 				task_finished_fn task_finished, void *pp_cb,
 				const char *tr2_category, const char *tr2_label)
 {
-	trace2_region_enter_printf(tr2_category, tr2_label, NULL, "max:%d", n);
+	const struct run_process_parallel_opts opts = {
+		.tr2_category = tr2_category,
+		.tr2_label = tr2_label,
+
+		.processes = processes,
+		.ungroup = run_processes_parallel_ungroup,
 
-	run_processes_parallel(n, get_next_task, start_failure,
-			       task_finished, pp_cb);
+		.get_next_task = get_next_task,
+		.start_failure = start_failure,
+		.task_finished = task_finished,
+	};
 
-	trace2_region_leave(tr2_category, tr2_label, NULL);
+	run_processes_parallel_1(&opts, pp_cb);
 }
 
 int run_auto_maintenance(int quiet)
diff --git a/run-command.h b/run-command.h
index 03be48e7ce3..bd0b7b70b27 100644
--- a/run-command.h
+++ b/run-command.h
@@ -464,6 +464,13 @@ typedef int (*task_finished_fn)(int result,
  */
 struct run_process_parallel_opts
 {
+	/**
+	 * tr2_category & tr2_label: sets the trace2 category and label for
+	 * logging. These must either be unset, or both of them must be set.
+	 */
+	const char *tr2_category;
+	const char *tr2_label;
+
 	/**
 	 * processes: see 'processes' in run_processes_parallel() below.
 	 */
-- 
2.38.0.971.ge79ff6d20e7

