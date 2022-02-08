Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7D1C433EF
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 11:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376465AbiBHLca (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 06:32:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357050AbiBHLV7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 06:21:59 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC26CC03FEC9
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 03:21:57 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id k3-20020a1ca103000000b0037bdea84f9cso1368525wme.1
        for <git@vger.kernel.org>; Tue, 08 Feb 2022 03:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=f4NL/D5bJHBH54sFIOk/5UVjCJf0p+Be5/HI96ORygQ=;
        b=TUV35y6lLGOylUn73e/ChxgFQYa3Aja7O2T6KHi5SlBb4nVSPcIs23LyFocIHajzN5
         mGN2KNFFBCb+b2e4laM6xqPZ73ohQxW9x7V+xdegiyCFwyi5NLrpCNNTdJ5js+LpEOgJ
         GYoBC3YAdaTzewo+tco2ADleLO50OXidFgs+cSTnlCd/Ln+b64SwZ/NOTgVBC/LolNmR
         GCDWcJyBhTcGsi6edF1sy9zSDobjdtjq4sAemVTuby6wbGkQG/6KGMK7AFMPY8AMNJft
         gHyzFN9xk7yMi8EFsK0hq4rMq0mDO2jiXPznPOVeyzzCEqflVka8Z9RaB8payLVUOFbS
         6Drw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=f4NL/D5bJHBH54sFIOk/5UVjCJf0p+Be5/HI96ORygQ=;
        b=D6DxbsbMJ/Uoq4Swchsf1BDtICNplSo7jb6IBTPfFCSjpRzgvGcc2j+AVERI6DA+TY
         FSai7aRr06WxmhExQ4KzDNgjrgP8xTmAov0JfEgPjco+o9hjSqn8gKV1MLcdBz1JpnSH
         z3ROql5yi1UHml8bHR2u8K5GQQfRpj+RwiLKb/+zhoaue901jZ3NgDOzMrpw4rNMcNPk
         HdHltRCU86kqL2EGKl6rXBhevgNyIbUSglFhJOS/ZuWfjN9BOTnR9rFCpUc9z0UBK6es
         vU9me26AsME1KDsc3o9+24yIewE4wRRt05L95kgFLXTjj5XFIK51BrxE/OlCWEqukUv4
         nT1w==
X-Gm-Message-State: AOAM530eS2uDM+x0mM3iNjo0fMLPLFHNMdpYNNDASBOvP+jNocn7o7PZ
        6FReseqxPapJ5Kl/w+svwVQnEEzGtzY=
X-Google-Smtp-Source: ABdhPJw8JPDkK5R++slFCW6uVnG/lA8TK4KX6sRugdCFZ2ZJM+74/8FcLW0wjak2jiv/qiX2DiLJOg==
X-Received: by 2002:a05:600c:4e93:: with SMTP id f19mr683010wmq.195.1644319316130;
        Tue, 08 Feb 2022 03:21:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e9sm14339983wrg.60.2022.02.08.03.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 03:21:55 -0800 (PST)
Message-Id: <6e9cdd10a70801da5124db1f55770d05c002671d.1644319314.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1139.v2.git.1644319314.gitgitgadget@gmail.com>
References: <pull.1139.git.1644277797.gitgitgadget@gmail.com>
        <pull.1139.v2.git.1644319314.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Feb 2022 11:21:53 +0000
Subject: [PATCH v2 1/2] checkout/fetch/pull/pack-objects: allow `-h` outside a
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
 builtin/fetch.c        | 6 ++++--
 builtin/pack-objects.c | 8 +++++---
 builtin/pull.c         | 6 ++++--
 4 files changed, 17 insertions(+), 10 deletions(-)

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
index 5f06b21f8e9..c8ca4262de6 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2014,8 +2014,10 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
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

