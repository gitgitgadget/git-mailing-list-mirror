Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F18C433FE
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 11:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbiI3Lgv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 07:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbiI3LgB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 07:36:01 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC9A13DDB8
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 04:28:31 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id e18so2711578wmq.3
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 04:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=AD/QZmAfR6eDUjOXOvNOQF1j/tU0rDuXEX4MM5rqwAk=;
        b=ogVUlzMvpgls0BvwsSowkRzN0ohnVyvYVBXDzIEff94e0X4kT7ZCgyjL24QRxnMvpa
         D1oQiyM/7zrL5arkB5rMkVO6mS11BO6panibVxJ0XqiXuoVAE50ZfD5jLBP7IE6/+sli
         nAPyXtB3T7H26kLiTtsJm0pK03F5AlACrecL5rpPYbPyKltmM97CR1v18a2uBMhYN27/
         omHZDE8ag4zyTvQWNMsN35RHNqZajE7iPUMAIESrfE6KBxUpILjkVp4+f4OsMGX+OlSJ
         BlmLPOcGSrPOeFypWzZs+dsBPMpbfszlz6B+ZWt9R/svNVSmIDGArGmFGgnAYjzPePhf
         XSaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=AD/QZmAfR6eDUjOXOvNOQF1j/tU0rDuXEX4MM5rqwAk=;
        b=NKO5X0c2oy8z2mR/vfbnfNP70asE/K6VSJ7YhkPk2T9/bZW6NiCd1JyCxAkUhzK/4M
         IVW1LNJTH0IFCCZhxKG3mGbJvOUZpl4pr2+kosrbJeZofNYMUpapgezCwD+eLmdTK+Dj
         KrsJsWUleIoab28cShzBJYiwnPBe+lETkAHlMpBY9uEMAlZuUgYCIGgRQqxty+txr5hP
         3h0oVR7m4QQowqthkwIBynQ359i85ynmzD6RnVkGMVffC+zizQHrxat+TTWcNuT47dhd
         gdNzCpTQYmwWdlMgNWI/OUWeh9KdZQWnQ6GG/D5vPHiO+Pe9RDnz5ranhCH0QTR1yRnj
         xRLQ==
X-Gm-Message-State: ACrzQf360mMFrNzoQU5MOP7eFnimFBu8VAER9kCAuF9HQXYqd6HBCdZl
        CGc7BkSxZlLN/Ha4Q5QOYHd9bIU1KQhmVg==
X-Google-Smtp-Source: AMsMyM7PYAcKxVlHc1qDyDacSXIQv2ZMISs03vK+N+az1gROYjVE5eLxHhEG7UXc9fKfuiBT0m2n0Q==
X-Received: by 2002:a05:600c:1c03:b0:3b4:618b:5d14 with SMTP id j3-20020a05600c1c0300b003b4618b5d14mr5264719wms.59.1664537308077;
        Fri, 30 Sep 2022 04:28:28 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l19-20020a5d5273000000b00228dbf15072sm1760799wrc.62.2022.09.30.04.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 04:28:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 11/15] run-command API: make run_process_parallel{,_tr2}() thin wrappers
Date:   Fri, 30 Sep 2022 13:28:08 +0200
Message-Id: <patch-11.15-bad36eabfe9-20220930T111343Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com>
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
 run-command.c | 67 ++++++++++++++++++++++++++++++++++++---------------
 run-command.h |  7 ++++++
 2 files changed, 54 insertions(+), 20 deletions(-)

diff --git a/run-command.c b/run-command.c
index f82fc7f1515..7a138234b40 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1784,29 +1784,25 @@ static int pp_collect_finished(struct parallel_processes *pp)
 	return result;
 }
 
-void run_processes_parallel(unsigned int jobs,
-			    get_next_task_fn get_next_task,
-			    start_failure_fn start_failure,
-			    task_finished_fn task_finished,
-			    void *pp_cb)
+static void run_processes_parallel_1(const struct run_process_parallel_opts *opts)
 {
 	int i, code;
 	int output_timeout = 100;
 	int spawn_cap = 4;
 	struct parallel_processes pp = PARALLEL_PROCESSES_INIT;
-	const struct run_process_parallel_opts opts = {
-		.jobs = jobs,
-		.get_next_task = get_next_task,
-		.start_failure = start_failure,
-		.task_finished = task_finished,
-		.ungroup = run_processes_parallel_ungroup,
-		.data = pp_cb,
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
+					   "max:%d", opts->jobs);
+
+	pp_init(&pp, opts);
 	while (1) {
 		for (i = 0;
 		    i < spawn_cap && !pp.shutdown &&
@@ -1823,7 +1819,7 @@ void run_processes_parallel(unsigned int jobs,
 		}
 		if (!pp.nr_processes)
 			break;
-		if (opts.ungroup) {
+		if (opts->ungroup) {
 			int i;
 
 			for (i = 0; i < pp.max_processes; i++)
@@ -1841,6 +1837,29 @@ void run_processes_parallel(unsigned int jobs,
 	}
 
 	pp_cleanup(&pp);
+
+	if (do_trace2)
+		trace2_region_leave(tr2_category, tr2_label, NULL);
+}
+
+void run_processes_parallel(unsigned int jobs,
+			    get_next_task_fn get_next_task,
+			    start_failure_fn start_failure,
+			    task_finished_fn task_finished,
+			    void *pp_cb)
+{
+	const struct run_process_parallel_opts opts = {
+		.jobs = jobs,
+		.ungroup = run_processes_parallel_ungroup,
+
+		.get_next_task = get_next_task,
+		.start_failure = start_failure,
+		.task_finished = task_finished,
+
+		.data = pp_cb,
+	};
+
+	run_processes_parallel_1(&opts);
 }
 
 void run_processes_parallel_tr2(unsigned int jobs, get_next_task_fn get_next_task,
@@ -1848,13 +1867,21 @@ void run_processes_parallel_tr2(unsigned int jobs, get_next_task_fn get_next_tas
 				task_finished_fn task_finished, void *pp_cb,
 				const char *tr2_category, const char *tr2_label)
 {
-	trace2_region_enter_printf(tr2_category, tr2_label, NULL, "max:%d",
-				   jobs);
+	const struct run_process_parallel_opts opts = {
+		.tr2_category = tr2_category,
+		.tr2_label = tr2_label,
+
+		.jobs = jobs,
+		.ungroup = run_processes_parallel_ungroup,
 
-	run_processes_parallel(jobs, get_next_task, start_failure,
-			       task_finished, pp_cb);
+		.get_next_task = get_next_task,
+		.start_failure = start_failure,
+		.task_finished = task_finished,
+
+		.data = pp_cb,
+	};
 
-	trace2_region_leave(tr2_category, tr2_label, NULL);
+	run_processes_parallel_1(&opts);
 }
 
 int run_auto_maintenance(int quiet)
diff --git a/run-command.h b/run-command.h
index 210fb9e8bc4..7151312592e 100644
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
 	 * jobs: see 'jobs' in run_processes_parallel() below.
 	 */
-- 
2.38.0.rc2.935.g6b421ae1592

