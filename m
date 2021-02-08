Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2005C433DB
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 14:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 992E764E27
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 14:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbhBHOx4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 09:53:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbhBHOxI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Feb 2021 09:53:08 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEA4C06178B
        for <git@vger.kernel.org>; Mon,  8 Feb 2021 06:52:27 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 190so12870280wmz.0
        for <git@vger.kernel.org>; Mon, 08 Feb 2021 06:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=W5OAfLE3jgzH7wPcudxJ6PxOL+I6aRwACXOjzMnyYIE=;
        b=tAL4JJgfdKev51uyjmC7xQCeYfIoXZc6+77f1AJg0A3pBM3uSNVwJZ7LuzgaBpADXT
         hTbcmHDpzm/6cNkqSAJPVBlUDyJwk42hnv87GYUgGtFiE6g2IVWhyvdYHhc/gx7LJd5W
         0igoaLq2wPcrlEB19IufbTIcRWJcu/aYtizCr5Q7YRisj1at2SVqToXIrBdJExREpE3R
         zTifukgKW8jCyifLJsSAY6DLm4rGCxmKke6QTYsXuhJqZroNy0zDc1F1fvG5132SMg5R
         r2NdzzpeEBOyf4OYyIZyFCbt5xq8FGP7xf72wZDRpb4/7K5VlfSN68MscYDDnCT+hI6G
         FATw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=W5OAfLE3jgzH7wPcudxJ6PxOL+I6aRwACXOjzMnyYIE=;
        b=ZpDYzuwjXdrRyYWBGT/y47PWJ6TUFk2+xqBsqSBEkM/oD1RcYqVFC5bOd3AL9eWy0p
         ydmzTAv22qaI2V5QbgCkVkBCgZ5ligvri8CWxcYfV2e/GhTx9QGOcG4PRhIGBh1H3JKq
         r7DKbo4bG1Zg+0TgYL8WFnceQFvXegHE4ma6hWz9x6OaTfOdkzfOGk152D8IleJrUVaQ
         yLixpCkKQxZvNOSkQNe1FNXqsh4iuHqKb+8S/h+H3j8N2lzs3zP+GpBEgGyWUP7G4BR1
         DojVWAv+snhukcVcjhOv2s8AbRZnJs7IK1Jml3DHNPp8ORAR1iaeexDTbn+WGUnNsuvg
         H49A==
X-Gm-Message-State: AOAM530l0B6TNZkbOtpTLeHD1+TNS1X0yWS2Wd0Y5nuYy33bYCppkO2D
        R7qo0xfiAqfKwfGgPb5YDtRKzYj6ypY=
X-Google-Smtp-Source: ABdhPJx0sEzpSpZ8EdaR/02v5VZCNIqmLsklrWKQm4C3vPTjYaDiM54rEFxFha6ra8mZZcFlUuwZzA==
X-Received: by 2002:a1c:720b:: with SMTP id n11mr15254369wmc.154.1612795946238;
        Mon, 08 Feb 2021 06:52:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j125sm13812363wmb.44.2021.02.08.06.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 06:52:25 -0800 (PST)
Message-Id: <33b7a74af4eb45756c3648eb7b002d06e4ec3563.1612795943.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.871.git.1612795943.gitgitgadget@gmail.com>
References: <pull.871.git.1612795943.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 08 Feb 2021 14:52:22 +0000
Subject: [PATCH 1/2] maintenance: add pack-refs task
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sluongng@gmail.com, martin.agren@gmail.com,
        sunshine@sunshineco.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

It is valuable to collect loose refs into a more compressed form. This
is typically the packed-refs file, although this could be the reftable
in the future. Having packed refs can be extremely valuable in repos
with many tags or remote branches that are not modified by the local
user, but still are necessary for other queries.

For instance, with many exploded refs, commands such as

	git describe --tags --exact-match HEAD

can be very slow (multiple seconds). This command in particular is used
by terminal prompts to show when a detatched HEAD is pointing to an
existing tag, so having it be slow causes significant delays for users.

Add a new 'pack-refs' maintenance task. This is already a sub-step of
the 'gc' task, but users could run this at other intervals if they are
interested. Also, if users opt-in to the default background maintenance
schedule, then the 'gc' task is disabled.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-maintenance.txt |  6 ++++++
 builtin/gc.c                      | 21 +++++++++++++++++----
 t/t7900-maintenance.sh            | 10 ++++++++++
 3 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
index 3b432171d608..8cc0225b3304 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.txt
@@ -145,6 +145,12 @@ incremental-repack::
 	which is a special case that attempts to repack all pack-files
 	into a single pack-file.
 
+pack-refs::
+	The `pack-refs` task collects the loose reference files and
+	collects them into a single file. This speeds up operations that
+	need to iterate across many refereences. See linkgit:git-pack-refs[1]
+	for more information.
+
 OPTIONS
 -------
 --auto::
diff --git a/builtin/gc.c b/builtin/gc.c
index 4c40594d660e..8f13c3bb8607 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -54,7 +54,6 @@ static const char *prune_worktrees_expire = "3.months.ago";
 static unsigned long big_pack_threshold;
 static unsigned long max_delta_cache_size = DEFAULT_DELTA_CACHE_SIZE;
 
-static struct strvec pack_refs_cmd = STRVEC_INIT;
 static struct strvec reflog = STRVEC_INIT;
 static struct strvec repack = STRVEC_INIT;
 static struct strvec prune = STRVEC_INIT;
@@ -163,6 +162,15 @@ static void gc_config(void)
 	git_config(git_default_config, NULL);
 }
 
+struct maintenance_run_opts;
+static int maintenance_task_pack_refs(struct maintenance_run_opts *opts)
+{
+	struct strvec pack_refs_cmd = STRVEC_INIT;
+	strvec_pushl(&pack_refs_cmd, "pack-refs", "--all", "--prune", NULL);
+
+	return run_command_v_opt(pack_refs_cmd.v, RUN_GIT_CMD);
+}
+
 static int too_many_loose_objects(void)
 {
 	/*
@@ -518,8 +526,8 @@ static void gc_before_repack(void)
 	if (done++)
 		return;
 
-	if (pack_refs && run_command_v_opt(pack_refs_cmd.v, RUN_GIT_CMD))
-		die(FAILED_RUN, pack_refs_cmd.v[0]);
+	if (pack_refs && maintenance_task_pack_refs(NULL))
+		die(FAILED_RUN, "pack-refs");
 
 	if (prune_reflogs && run_command_v_opt(reflog.v, RUN_GIT_CMD))
 		die(FAILED_RUN, reflog.v[0]);
@@ -556,7 +564,6 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(builtin_gc_usage, builtin_gc_options);
 
-	strvec_pushl(&pack_refs_cmd, "pack-refs", "--all", "--prune", NULL);
 	strvec_pushl(&reflog, "reflog", "expire", "--all", NULL);
 	strvec_pushl(&repack, "repack", "-d", "-l", NULL);
 	strvec_pushl(&prune, "prune", "--expire", NULL);
@@ -1224,6 +1231,7 @@ enum maintenance_task_label {
 	TASK_INCREMENTAL_REPACK,
 	TASK_GC,
 	TASK_COMMIT_GRAPH,
+	TASK_PACK_REFS,
 
 	/* Leave as final value */
 	TASK__COUNT
@@ -1255,6 +1263,11 @@ static struct maintenance_task tasks[] = {
 		maintenance_task_commit_graph,
 		should_write_commit_graph,
 	},
+	[TASK_PACK_REFS] = {
+		"pack-refs",
+		maintenance_task_pack_refs,
+		NULL,
+	},
 };
 
 static int compare_tasks_by_selection(const void *a_, const void *b_)
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 78ccf4b33f87..ef4527823d29 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -343,6 +343,16 @@ test_expect_success 'maintenance.incremental-repack.auto' '
 	test_subcommand git multi-pack-index write --no-progress <trace-B
 '
 
+test_expect_success 'pack-refs task' '
+	for n in $(test_seq 1 5)
+	do
+		git branch -f to-pack/$n HEAD || return 1
+	done &&
+	git maintenance run --task=pack-refs &&
+	ls .git/refs/heads/ >after &&
+	test_must_be_empty after
+'
+
 test_expect_success '--auto and --schedule incompatible' '
 	test_must_fail git maintenance run --auto --schedule=daily 2>err &&
 	test_i18ngrep "at most one" err
-- 
gitgitgadget

