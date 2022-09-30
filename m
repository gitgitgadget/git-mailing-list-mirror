Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38AE1C433F5
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 11:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbiI3Lgl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 07:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbiI3Lfs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 07:35:48 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB55613EEBE
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 04:28:32 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id f11so3713686wrm.6
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 04:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=q9wxY/IQpQ6zUbVdQPRFb3NEzFZr3yNJjIeo3t7oiTs=;
        b=DmNoMatMir0wu/0tBq+uNlJ3Nrc2oV7ZBQwogIUu1l3yNo6XR9OWVnzh/pJ5FEJ03Q
         ux+OPfnAfIYy7ANxWGp8u+lEMWSZY1/7rjF70TnbYmYTneCVphVdpNxhkWx2oMWrPUU9
         NlOFL6ySlxUrEzqyWPp/mFPVu684ag5DiH/BcmydctIUvr01nQBHD8KIK21PlxsVm+Rq
         Qto8mFFRp1KPsn3MT5NGRdEaokbIA8ESmI/t+6ZM3WLfL7G7ca56/jdhfPti7RUJy1N+
         1p2rxM7Asv50D6oEpz206mmGpUyW2y8ltwEFnMRlHx2nZs+QKe4oLT96rAIJblM8plHF
         0cug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=q9wxY/IQpQ6zUbVdQPRFb3NEzFZr3yNJjIeo3t7oiTs=;
        b=uMAU4VVJsvsabkiHEZyceYepxaP+UvFWo5HPWH2VFeJxvF9OkxSdAZbjPCCzBw78N7
         +FNHDdyJj2ePfMRy1CEE27RH6mSU6ovUDSMtH8F3wDPfeJOQWszpKzKGZ/vgK6JvcCPm
         DE/0nUj8UNVn+qWF90NA54JdDKTJCa9xsppaPA4OvhPlcj7CJ4k9+qkrdQBEVcTtMIPt
         RwLV1p/FiC9NhzhvO5bFRL8EkPPluaukVGVNhsvGKQwgG2L76w/KNPB9GJZfAo6ZFdih
         XFU4wvxl3DkjYnTj5QDKDWYDWXFeCHQyJiS/csIBma5V7JQbeTWNKSA+hO31nVVyBeO1
         gdxg==
X-Gm-Message-State: ACrzQf1r8bOlPYxuTkghsRCOT/0lz/ARHgPE39wlWSKAhuuotSuoMcf+
        7OYLf75RcWWmLC1nU04gCEU+dWCSC2XLvA==
X-Google-Smtp-Source: AMsMyM6zzjrxCkjxnFuIu0Ih5/+xwGIhIXG8WiZbtIYIAuEqIIv8ZWfLEoyN2GggFI8gn8I1I8JkAQ==
X-Received: by 2002:a05:6000:887:b0:21e:24a0:f302 with SMTP id ca7-20020a056000088700b0021e24a0f302mr5272923wrb.466.1664537310404;
        Fri, 30 Sep 2022 04:28:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l19-20020a5d5273000000b00228dbf15072sm1760799wrc.62.2022.09.30.04.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 04:28:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 13/15] run-command API: move *_tr2() users to "run_processes_parallel()"
Date:   Fri, 30 Sep 2022 13:28:10 +0200
Message-Id: <patch-13.15-37d194a338f-20220930T111343Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com>
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
 run-command.c               | 21 ---------------------
 run-command.h               |  3 ---
 submodule.c                 | 18 ++++++++++++------
 5 files changed, 36 insertions(+), 40 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 82f1da14ec1..a4eea27cdae 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1953,15 +1953,21 @@ static int fetch_multiple(struct string_list *list, int max_children)
 
 	if (max_children != 1 && list->nr != 1) {
 		struct parallel_fetch_state state = { argv.v, list, 0, 0 };
+		const struct run_process_parallel_opts opts = {
+			.tr2_category = "fetch",
+			.tr2_label = "parallel/fetch",
+
+			.jobs = max_children,
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
index 0b4acb442b2..cd34d021b70 100644
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
+		.jobs = update_data->max_jobs,
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
index cdbba15a0ba..1d5a500ecce 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1838,27 +1838,6 @@ void run_processes_parallel(const struct run_process_parallel_opts *opts)
 		trace2_region_leave(tr2_category, tr2_label, NULL);
 }
 
-void run_processes_parallel_tr2(unsigned int jobs, get_next_task_fn get_next_task,
-				start_failure_fn start_failure,
-				task_finished_fn task_finished, void *pp_cb,
-				const char *tr2_category, const char *tr2_label)
-{
-	const struct run_process_parallel_opts opts = {
-		.tr2_category = tr2_category,
-		.tr2_label = tr2_label,
-
-		.jobs = jobs,
-
-		.get_next_task = get_next_task,
-		.start_failure = start_failure,
-		.task_finished = task_finished,
-
-		.data = pp_cb,
-	};
-
-	run_processes_parallel(&opts);
-}
-
 int run_auto_maintenance(int quiet)
 {
 	int enabled;
diff --git a/run-command.h b/run-command.h
index 0f1d4081dcd..075bd9b9de4 100644
--- a/run-command.h
+++ b/run-command.h
@@ -528,9 +528,6 @@ struct run_process_parallel_opts
  * conditions due to writing in parallel to stdout and stderr.
  */
 void run_processes_parallel(const struct run_process_parallel_opts *opts);
-void run_processes_parallel_tr2(unsigned int jobs, get_next_task_fn, start_failure_fn,
-				task_finished_fn, void *pp_cb,
-				const char *tr2_category, const char *tr2_label);
 
 /**
  * Convenience function which prepares env for a command to be run in a
diff --git a/submodule.c b/submodule.c
index bf7a2c79183..72b295b87b7 100644
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
+		.jobs = max_parallel_jobs,
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
2.38.0.rc2.935.g6b421ae1592

