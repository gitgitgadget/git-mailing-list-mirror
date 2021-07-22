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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F91C6377D
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 05:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2724961279
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 05:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhGVEYe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 00:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbhGVEYU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 00:24:20 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FBCC061757
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 22:04:56 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id a23-20020a05600c2257b0290236ec98bebaso2187732wmm.1
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 22:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=u4eYxipDMAxbYblkUS92aVDQ9qEXGT9x9EEpRM0/ULw=;
        b=HIS1K45HW8sGP49TyAc8iiFZZgplAK5cA0967hW8XqhzGwqgNprffZuBJSOACQJjXe
         xQiYz5m+ggQkXnvAgHyTupmzb3XborGJp1HZEbefRpmaYOBlfxCyEKvPHN1p7EyE+JDk
         DNa+fZAgliYSlJFo3n7DAqt6h6e5Npxxzfqkg6d8KcdaGGL5hd+6AklFlTwMuEGmui7x
         JYD2F2C7qZl2Au6mn8WtDLrXKsAF0iNtK2LvWShlv6LZZwfw7zWsyfmv6vd1sLxfacr6
         4okkpH96ZKEcQxFDoX2kCcKk/ce0CU6x2XVF4YPaY2UAg7fYL334DDEyimFaYiq2khBF
         Iiww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=u4eYxipDMAxbYblkUS92aVDQ9qEXGT9x9EEpRM0/ULw=;
        b=PPgN+aCuBGEonbE5boS36Z+5XLgYoASmKarCi3ZFgo7kWKhebJPLvgt2E3com5K014
         ODDDsPKmGI4c30JW/XpqmtwJfiHtuM8EakxjFymupGS/IKXrcPHziP9MdjOgGTfbMbmQ
         E85BvfA3u0m7o5U4qZq7SN4pmc97tyizf8i0GeQx5ScRrtOhuWGRTKY3NytJwkAhmrs0
         rsgNGUUYshHpfhszN1e0s/waj9zTo0GcXRoY/e3eOZ/8ev6cM1UASI32qLPvb+t6kOUA
         jwiR1Va6UKsddr7zhGEjSn5jh6tlnqHPSc8ll6iF4tKkUheQ4Yx9d13qIlABH/WGNX5p
         m9cw==
X-Gm-Message-State: AOAM5306KPnt5ZVgenVGxJdUXhHw9fgilgRvmhx/TVOoZDlftibJEng5
        xEzrTtoooE2DAs42ANrKKrpvj5egWrk=
X-Google-Smtp-Source: ABdhPJwR7J/D3fgY9g37ls2GniQfiJwFandkgc2kbvs/3mjGg8ZuYwedjmCCVdj05OoTF41Az4CezA==
X-Received: by 2002:a1c:7f57:: with SMTP id a84mr7307864wmd.46.1626930294758;
        Wed, 21 Jul 2021 22:04:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o5sm1569280wms.43.2021.07.21.22.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 22:04:54 -0700 (PDT)
Message-Id: <b242d001132880533077722342abb8675dcea90f.1626930290.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1049.v3.git.git.1626930290.gitgitgadget@gmail.com>
References: <pull.1049.v2.git.git.1626831744.gitgitgadget@gmail.com>
        <pull.1049.v3.git.git.1626930290.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 22 Jul 2021 05:04:47 +0000
Subject: [PATCH v3 5/8] pull: make --rebase and --no-rebase override
 pull.ff=only
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Matthias Baumgarten <matthias.baumgarten@aixigo.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Fix the last few precedence tests failing in t7601 by now implementing
the logic to have --[no-]rebase override a pull.ff=only config setting.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/pull.c               | 16 +++++++++++++++-
 t/t7601-merge-pull-config.sh |  4 ++--
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 1f452020375..9bf03255291 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -966,8 +966,22 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 	parse_repo_refspecs(argc, argv, &repo, &refspecs);
 
-	if (!opt_ff)
+	if (!opt_ff) {
 		opt_ff = xstrdup_or_null(config_get_ff());
+		/*
+		 * A subtle point: opt_ff was set on the line above via
+		 * reading from config.  opt_rebase, in contrast, is set
+		 * before this point via command line options.  The setting
+		 * of opt_rebase via reading from config (using
+		 * config_get_rebase()) does not happen until later.  We
+		 * are relying on the next if-condition happening before
+		 * the config_get_rebase() call so that an explicit
+		 * "--rebase" can override a config setting of
+		 * pull.ff=only.
+		 */
+		if (opt_rebase >= 0 && opt_ff && !strcmp(opt_ff, "--ff-only"))
+			opt_ff = "--ff";
+	}
 
 	if (opt_rebase < 0)
 		opt_rebase = config_get_rebase(&rebase_unspecified);
diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index d1f621725ad..0c0dfecd2a3 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -260,11 +260,11 @@ test_expect_success '--ff-only takes precedence over pull.rebase=false' '
 	test_attempts_fast_forward -c pull.rebase=false pull --ff-only
 '
 
-test_expect_failure '--no-rebase takes precedence over pull.ff=only' '
+test_expect_success '--no-rebase takes precedence over pull.ff=only' '
 	test_falls_back_to_full_merge -c pull.ff=only pull --no-rebase
 '
 
-test_expect_failure '--rebase takes precedence over pull.ff=only' '
+test_expect_success '--rebase takes precedence over pull.ff=only' '
 	test_does_rebase -c pull.ff=only pull --rebase
 '
 
-- 
gitgitgadget

