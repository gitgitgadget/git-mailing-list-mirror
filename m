Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA91C4332F
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 21:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiJLVEH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 17:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiJLVDi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 17:03:38 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9117D4F6AB
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 14:03:33 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id j16so27954906wrh.5
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 14:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MHCCJOqGjSoeHoqDQ8V5ZtNIvPBBNJ+hIkGAq/Fcg5g=;
        b=d8LyOz4bFE9qZ1xUVmpG2EKWT5pdYk4tVoBDLXsaVhsyxsVPxCOBVIkCl+F7bxD//y
         CXNlQTRFNMn+NzOCG7m37Nrokh8/uvNQEpcuq8o9m4O/llsPSkMQDsfei67TaqwGJ/k3
         lzC9Y/HfQSTvhQnZ8R2/+PkInqYblJS9XZ3QCClcmib31JiHoy1HX2Dm42muyittNE/y
         oAedXSAEG35okoBRTUH2jHzaLz4QRPPPM2HgkKRPyp4I34hoTXrCUa6Mv1cCsv5uiEvQ
         2llt6dIX0xvWozsIZiHosL5c7czV5J73UHULvh/sVkc8Qv7ec0o7MbCt+yc5mL7siiGn
         uKzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MHCCJOqGjSoeHoqDQ8V5ZtNIvPBBNJ+hIkGAq/Fcg5g=;
        b=kl7O3kKXKMbjvRoUoGxaBlf/5h+zDY2mqVeok7Ju0xFLlGnSYpOCcP78hvoXwRjdUZ
         aKwwyeY4VJJiuRKD9wSqcpOH8FShypeIlcHoV3G7oxClibKsgskA5KOoj4qOYc7XU5eg
         cwIu/OYEvfbB1EjJoaCP9I8dN3hF5McB+SGdu4r31BKrVaFfg1msvb1uWZlYF8agA0rA
         x5BtBnQqcJOffO3ral/d16JFVeYMyrIUON5Eovo2EIFx5qMPIMaQgWAleUg6W81Fvnaz
         py4gjM9bploVXQRxDEtzUWWaBCDykkRb7IYHWUfq8IH6j3lsMoD7YHhN6b0HWB7GEUMO
         1Gvw==
X-Gm-Message-State: ACrzQf29zkasChkJPSSmRjeRY1ZZMXEgoAlY3s+c/6g8h47JB7wMCFqk
        +8U4Ibdo9JZSaKQ2kWKE+K5ThQjXf38whg==
X-Google-Smtp-Source: AMsMyM74FVa8H4Oi9udUBn64ihJp7cVJM1QSe50j/NvQXDG3Ot+yUoJmY36hxQC21rhxpi7q52fb0Q==
X-Received: by 2002:a5d:59ae:0:b0:230:24a1:f295 with SMTP id p14-20020a5d59ae000000b0023024a1f295mr12595884wrr.457.1665608611007;
        Wed, 12 Oct 2022 14:03:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b6-20020adff246000000b00228a6ce17b4sm550079wrp.37.2022.10.12.14.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 14:03:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 08/15] run-command API: move *_tr2() users to "run_processes_parallel()"
Date:   Wed, 12 Oct 2022 23:02:27 +0200
Message-Id: <patch-v3-08.15-c19c60b2e95-20221012T205712Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.971.ge79ff6d20e7
In-Reply-To: <cover-v3-00.15-00000000000-20221012T205712Z-avarab@gmail.com>
References: <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com> <cover-v3-00.15-00000000000-20221012T205712Z-avarab@gmail.com>
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
index 2858ec7bef5..646ea22e399 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1827,24 +1827,6 @@ void run_processes_parallel(const struct run_process_parallel_opts *opts)
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

