Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BFBC433FE
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 09:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiJLJDJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 05:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiJLJC2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 05:02:28 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7015DBC44A
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 02:02:01 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id a3so25307554wrt.0
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 02:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W0exEticuLke4K4IWD+gzWx94T1NJ37WOST9HH/2Gvk=;
        b=ll+28SGn5hya3lQyu8GDcq6SNgCP1byfcXGRmQxx4sMDm7LMc/SMagTlwhXECt3T0h
         kCENR5uCRAexhGDlrJRmQd3QAoq7st04iJu+tmPGr3gIrSsuMV5bODysHNQUWpXRpb+p
         1YlarGJFAkqX1TtiUL/x82RhtBupJVnXUSxRoyJKxzDf/0PE4vna1+AxjlreTVCo8p8X
         KUBcrko/BhQnJ1XqqKZzLnEVyJg96PbPzKvrIZowQH5NYgJbSZPUY8TLty86oBDacIiF
         eW9K7wol6l5jlknJuetUX2UFG60rj5m0jP6zqQ85XhEyxhx5vifqK0ihuZrorg8wsZH8
         55ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W0exEticuLke4K4IWD+gzWx94T1NJ37WOST9HH/2Gvk=;
        b=bsGWHc9deivUxSHutYvgzM/wqn1wXhxZxwJwz/ADKF1yOd5nXyrXn22OYyjM+wyACn
         1D5a1jTMvFumZMSFDEMA6S+/yT6gyz4LL5dRtVtg0UhXfdaGiL6qeNfJa2CJeB2v4S+k
         9ES+VNpGwm3Ec0S8eO2JZRdMCNXBJbaYoSzueOBwb+QrkkiAaSuJq2yrBBEAwe5oXc2f
         ZOcb8sDCVApfThJrhmCQ+/8tE6SJPnkmsVPLpFsSqQn9wEuZ9CJ/LGqpL6MgwNZ72RWD
         BMEp0Pqoc15HUVc1nG9f2f/LUYp5V38e/iEm2jPPi+aQY+uIi13h+Vboz54cOEN59ZmL
         flyQ==
X-Gm-Message-State: ACrzQf0oABTlHOl6oE0lukx2ymDNLQKdgX2rpcZgtA9ISm+GoEOS32lK
        wfGAtR2hCVxk+bHaDn8mpamAOPddO2qY0A==
X-Google-Smtp-Source: AMsMyM5Yw7FCzoxCXjnSRqAYF5ctCfzP14nCgk7vk5u65sLItJ40vGqoe3UPTixatQM1PYS5blB3HA==
X-Received: by 2002:adf:e192:0:b0:232:3648:776d with SMTP id az18-20020adfe192000000b002323648776dmr690499wrb.698.1665565318582;
        Wed, 12 Oct 2022 02:01:58 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b1-20020a05600c4e0100b003a3170a7af9sm1280362wmq.4.2022.10.12.02.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 02:01:57 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 15/22] run-command API: move *_tr2() users to "run_processes_parallel()"
Date:   Wed, 12 Oct 2022 11:01:23 +0200
Message-Id: <patch-v2-15.22-391d1d99d91-20221012T084850Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.971.ge79ff6d20e7
In-Reply-To: <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com> <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Have the users of the "run_processes_parallel_tr2()" function use
"run_processes_parallel()" instead. In preceding commits the latter
was refactored to take a "struct run_process_parallel_opts" argument,
since the only reason for "run_processes_parallel_tr2()" to exist was
to take arguments that are now a part of that struct we can do away
with it.

See ee4512ed481 (trace2: create new combined trace facility,
2019-02-22) for the addition of the "*_tr2()" variant of the function,
it was used by every caller except "t/helper/test-run-command.c"..

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/fetch.c             | 18 ++++++++++++------
 builtin/submodule--helper.c | 16 ++++++++++++----
 run-command.c               | 18 ------------------
 run-command.h               |  3 ---
 submodule.c                 | 18 ++++++++++++------
 5 files changed, 36 insertions(+), 37 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 82f1da14ec1..b06e454cbdd 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1953,15 +1953,21 @@ static int fetch_multiple(struct string_list *list, int max_children)
 
 	if (max_children != 1 && list->nr != 1) {
 		struct parallel_fetch_state state = { argv.v, list, 0, 0 };
+		const struct run_process_parallel_opts opts = {
+			.tr2_category = "fetch",
+			.tr2_label = "parallel/fetch",
+
+			.processes = max_children,
+
+			.get_next_task = &fetch_next_remote,
+			.start_failure = &fetch_failed_to_start,
+			.task_finished = &fetch_finished,
+			.data = &state,
+		};
 
 		strvec_push(&argv, "--end-of-options");
-		run_processes_parallel_tr2(max_children,
-					   &fetch_next_remote,
-					   &fetch_failed_to_start,
-					   &fetch_finished,
-					   &state,
-					   "fetch", "parallel/fetch");
 
+		run_processes_parallel(&opts);
 		result = state.result;
 	} else
 		for (i = 0; i < list->nr; i++) {
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 0b4acb442b2..df526525c1e 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2567,12 +2567,20 @@ static int update_submodules(struct update_data *update_data)
 {
 	int i, ret = 0;
 	struct submodule_update_clone suc = SUBMODULE_UPDATE_CLONE_INIT;
+	const struct run_process_parallel_opts opts = {
+		.tr2_category = "submodule",
+		.tr2_label = "parallel/update",
+
+		.processes = update_data->max_jobs,
+
+		.get_next_task = update_clone_get_next_task,
+		.start_failure = update_clone_start_failure,
+		.task_finished = update_clone_task_finished,
+		.data = &suc,
+	};
 
 	suc.update_data = update_data;
-	run_processes_parallel_tr2(suc.update_data->max_jobs, update_clone_get_next_task,
-				   update_clone_start_failure,
-				   update_clone_task_finished, &suc, "submodule",
-				   "parallel/update");
+	run_processes_parallel(&opts);
 
 	/*
 	 * We saved the output and put it out all at once now.
diff --git a/run-command.c b/run-command.c
index 0956cc572b7..64fa0299175 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1823,24 +1823,6 @@ void run_processes_parallel(const struct run_process_parallel_opts *opts)
 		trace2_region_leave(tr2_category, tr2_label, NULL);
 }
 
-void run_processes_parallel_tr2(size_t processes, get_next_task_fn get_next_task,
-				start_failure_fn start_failure,
-				task_finished_fn task_finished, void *pp_cb,
-				const char *tr2_category, const char *tr2_label)
-{
-	const struct run_process_parallel_opts opts = {
-		.tr2_category = tr2_category,
-		.tr2_label = tr2_label,
-		.processes = processes,
-
-		.get_next_task = get_next_task,
-		.start_failure = start_failure,
-		.task_finished = task_finished,
-	};
-
-	run_processes_parallel(&opts);
-}
-
 int run_auto_maintenance(int quiet)
 {
 	int enabled;
diff --git a/run-command.h b/run-command.h
index aabdaf684db..e3e1ea01ad9 100644
--- a/run-command.h
+++ b/run-command.h
@@ -528,9 +528,6 @@ struct run_process_parallel_opts
  * conditions due to writing in parallel to stdout and stderr.
  */
 void run_processes_parallel(const struct run_process_parallel_opts *opts);
-void run_processes_parallel_tr2(size_t processes, get_next_task_fn,
-				start_failure_fn, task_finished_fn, void *pp_cb,
-				const char *tr2_category, const char *tr2_label);
 
 /**
  * Convenience function which prepares env for a command to be run in a
diff --git a/submodule.c b/submodule.c
index bf7a2c79183..f7c71f1f4b1 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1819,6 +1819,17 @@ int fetch_submodules(struct repository *r,
 {
 	int i;
 	struct submodule_parallel_fetch spf = SPF_INIT;
+	const struct run_process_parallel_opts opts = {
+		.tr2_category = "submodule",
+		.tr2_label = "parallel/fetch",
+
+		.processes = max_parallel_jobs,
+
+		.get_next_task = get_next_submodule,
+		.start_failure = fetch_start_failure,
+		.task_finished = fetch_finish,
+		.data = &spf,
+	};
 
 	spf.r = r;
 	spf.command_line_option = command_line_option;
@@ -1840,12 +1851,7 @@ int fetch_submodules(struct repository *r,
 
 	calculate_changed_submodule_paths(r, &spf.changed_submodule_names);
 	string_list_sort(&spf.changed_submodule_names);
-	run_processes_parallel_tr2(max_parallel_jobs,
-				   get_next_submodule,
-				   fetch_start_failure,
-				   fetch_finish,
-				   &spf,
-				   "submodule", "parallel/fetch");
+	run_processes_parallel(&opts);
 
 	if (spf.submodules_with_errors.len > 0)
 		fprintf(stderr, _("Errors during submodule fetch:\n%s"),
-- 
2.38.0.971.ge79ff6d20e7

