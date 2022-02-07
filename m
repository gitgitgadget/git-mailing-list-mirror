Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A89C4321E
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 01:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239476AbiBHBFS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 20:05:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343716AbiBGXuC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 18:50:02 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32B4C061355
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 15:50:01 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id k1so11089999wrd.8
        for <git@vger.kernel.org>; Mon, 07 Feb 2022 15:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Z/eTfqeDYSMb5AY37vp+R/cP595Jzlv0gw2+Yn+Qu8Q=;
        b=GLkqyhRZUWj2B3Kg17NsDfbt/2tE+ByT3Klphwytjb7ReksexAHnA28IGZCWxDGBpc
         IldVIY9T+4kGX4E4B6XyuVaDb5Ue57wnnKKLWqgnUzC/DrnnNptn8Gruk+hejkxJLpOA
         esyeMifGGBMbiqCI/lp3JEg4HiP0NQ/cVMIXvHzsnkQ3NnCA0jDYUoOCtMBLin9zLSoN
         JRmRC8M2UkDYPOkRsMpzfbEYE8Eg1A8XGZTpgIxkw5qFNHEkZhsqTA3UCcFpC1sU3Wa2
         R5WtNR/WySnl34emFCNUrgQZhlOWcGkORdMvHGwzCQ8M/HtQR5H44jJ7X7HbsqT2TYmV
         ZHRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Z/eTfqeDYSMb5AY37vp+R/cP595Jzlv0gw2+Yn+Qu8Q=;
        b=uRmqCjOv1eX0F/rqU0M3tHiPRXj7vLn9hkv/Mm0SUkg26saEYhFZAROBJ9rtQCbxkB
         ZGHAy9h1mW83EUT4Os1za6GCTOZxBRfsjv+SHDvsnYQeDzDFFi9WhU9HIXobXLpWf08b
         4ijPXC8lqAK1wAh5yob3whDH9Qb/lwtaInMwCk0fQ98hiHmybuBrVZhIKCY/v77BXIQD
         C1l3eY/cwOWkAYPGeJEax7Q11TaTif9Vp9WZDtvmulWw0V+CVkGfNiYR/ypBcT9MoNtt
         PG8wO1EBPh8vcKoR7IB3Og963T6l5KnU7H+tpBhXCT/NFWMW2SmMBuxEmXTrVWUflmmW
         2o/A==
X-Gm-Message-State: AOAM5338HNAZiumZOLgxop0goR94yeImHdfHzJABzVxU1JPVdGCkq8rx
        l0LYejUkiqo0D3+zz6CJKWnQiNalTsY=
X-Google-Smtp-Source: ABdhPJztIxutd/T0eJlLJBWo3Ymdx2Nfp8G3uQRIolV7GxKAw7m3U/DAomMw8+wnpGq0nu9h7MEXOw==
X-Received: by 2002:adf:e350:: with SMTP id n16mr1305333wrj.160.1644277799342;
        Mon, 07 Feb 2022 15:49:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 1sm554537wmk.16.2022.02.07.15.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 15:49:58 -0800 (PST)
Message-Id: <25d1a2963f2934753de4fb6899429301637377c9.1644277797.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1139.git.1644277797.gitgitgadget@gmail.com>
References: <pull.1139.git.1644277797.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Feb 2022 23:49:56 +0000
Subject: [PATCH 1/2] checkout/fetch/pull/pack-objects: allow `-h` outside a
 repository
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When we taught these commands about the sparse index, we did not account
for the fact that the `cmd_*()` functions _can_ be called without a
gitdir, namely when `-h` is passed to show the usage.

A plausible approach to address this is to move the
`prepare_repo_settings()` calls right after the `parse_options()` calls:
The latter will never return when it handles `-h`, and therefore it is
safe to assume that we have a `gitdir` at that point, as long as the
built-in is marked with the `RUN_SETUP` flag.

However, it is unfortunately not that simple. In `cmd_pack_objects()`,
for example, the repo settings need to be fully populated so that the
command-line options `--sparse`/`--no-sparse` can override them, not the
other way round.

Therefore, we choose to imitate the strategy taken in `cmd_diff()`,
where we simply do not bother to prepare and initialize the repo
settings unless we have a `gitdir`.

This fixes https://github.com/git-for-windows/git/issues/3688

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/checkout.c     | 7 ++++---
 builtin/fetch.c        | 7 +++++--
 builtin/pack-objects.c | 8 +++++---
 builtin/pull.c         | 6 ++++--
 4 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index cc804ba8e1e..1c13d7fedb3 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1602,9 +1602,10 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 	opts->show_progress = -1;
 
 	git_config(git_checkout_config, opts);
-
-	prepare_repo_settings(the_repository);
-	the_repository->settings.command_requires_full_index = 0;
+	if (the_repository->gitdir) {
+		prepare_repo_settings(the_repository);
+		the_repository->settings.command_requires_full_index = 0;
+	}
 
 	opts->track = BRANCH_TRACK_UNSPECIFIED;
 
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 5f06b21f8e9..e0a05de10ee 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2014,11 +2014,14 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	}
 
 	git_config(git_fetch_config, NULL);
-	prepare_repo_settings(the_repository);
-	the_repository->settings.command_requires_full_index = 0;
+	if (the_repository->gitdir) {
+		prepare_repo_settings(the_repository);
+		the_repository->settings.command_requires_full_index = 0;
+	}
 
 	argc = parse_options(argc, argv, prefix,
 			     builtin_fetch_options, builtin_fetch_usage, 0);
+
 	if (recurse_submodules != RECURSE_SUBMODULES_OFF) {
 		int *sfjc = submodule_fetch_jobs_config == -1
 			    ? &submodule_fetch_jobs_config : NULL;
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index ba2006f2212..87cb7b45c37 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3976,9 +3976,11 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	read_replace_refs = 0;
 
 	sparse = git_env_bool("GIT_TEST_PACK_SPARSE", -1);
-	prepare_repo_settings(the_repository);
-	if (sparse < 0)
-		sparse = the_repository->settings.pack_use_sparse;
+	if (the_repository->gitdir) {
+		prepare_repo_settings(the_repository);
+		if (sparse < 0)
+			sparse = the_repository->settings.pack_use_sparse;
+	}
 
 	reset_pack_idx_option(&pack_idx_opts);
 	git_config(git_pack_config, NULL);
diff --git a/builtin/pull.c b/builtin/pull.c
index 100cbf9fb85..d15007d93f3 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -994,8 +994,10 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		set_reflog_message(argc, argv);
 
 	git_config(git_pull_config, NULL);
-	prepare_repo_settings(the_repository);
-	the_repository->settings.command_requires_full_index = 0;
+	if (the_repository->gitdir) {
+		prepare_repo_settings(the_repository);
+		the_repository->settings.command_requires_full_index = 0;
+	}
 
 	argc = parse_options(argc, argv, prefix, pull_options, pull_usage, 0);
 
-- 
gitgitgadget

