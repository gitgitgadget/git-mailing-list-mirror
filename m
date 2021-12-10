Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7C9C433EF
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 03:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236533AbhLJD7z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 22:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236507AbhLJD7x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 22:59:53 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A385DC061746
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 19:56:18 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id j140-20020a1c2392000000b003399ae48f58so8072703wmj.5
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 19:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gHA4U75xsPIKpJIIv+JjG+B5ZKrealR67VghNEi5u7U=;
        b=a6l+mF5Pvdh/b+iqJvp+MEFsCp3FnRMgOd1YxEB7GRwgbQ5flW7pwWhCyDfhC/lAKv
         iLQazrvkOaDl9RUqS4+SxSo1z0ChbsJJHV8bug3woXPClYOxVnkYUAs5TdM4PHbSesxf
         P3+TXBlm118m8T0xbcVF/Yz1GKUjsZ25IyPVX5Zxjrlu6KTMdryKJ+VIwtKnchF7ZPOJ
         4LSurvLp88Y2Y6Y9PoMC+c+5Rnl1tUHDnbdn8rO5GvMw/7/hxU6e8r2i8Y7bBrlrw6TC
         CIoIK9hIYegVN1BXcfoReTNHho20vhUbLjMg//7xZfGc2OOtjT8Gab5+6aRsNxO2fvWm
         PMCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gHA4U75xsPIKpJIIv+JjG+B5ZKrealR67VghNEi5u7U=;
        b=rtVMDoyO/K4i9GgWxcPyLkkIrbmSBaHxRGU5MvyKh+Ehn+jQWC1mkCVFvtAps/vPmU
         oQoyE4wzkubwvAkiORt2UYCChLp65fiBLzpKJFUHjpcB39K1Ub+KGMhXN/6l5am3axWZ
         gRDFZ4uo4Tzx4Umuu86RWTzGcZ9SfP0wYeMCAO5zv3Q9GeLE4zSLvO7dqtRBxAlw8OYE
         KYltHx4rBMvk/srEpLpClhwTzbmH80UpIRznRGtaDbbptipo2StK1B3nXRH/P97YLwvZ
         4SAIOkkT/buwtDblObSfaSAWJLYvEdTpPW8pCSw1FZnRmvi+wIsNM1XS4qczDdrLgFbv
         y84Q==
X-Gm-Message-State: AOAM5305lqdgJ98j2ueO/Fdol/3UarYeSCx614TdkYwv0Zex/9FzphvC
        NKcVuzZDeNgcRUygF8DLxl3iES80wE0=
X-Google-Smtp-Source: ABdhPJwfbJU8Zo+3LcSmXsSjCkFdXKaGvVKxgDC6tqiHZSoa3kOKcS/n9BuVCOtNZmhtf2BraxU4xQ==
X-Received: by 2002:a1c:7714:: with SMTP id t20mr13098712wmi.139.1639108576526;
        Thu, 09 Dec 2021 19:56:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m9sm1769138wmq.1.2021.12.09.19.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 19:56:16 -0800 (PST)
Message-Id: <f3af5edb25d5bed46996a1b826ae0c8306eeb912.1639108573.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1151.v3.git.git.1639108573.gitgitgadget@gmail.com>
References: <pull.1151.v2.git.git.1638908410.gitgitgadget@gmail.com>
        <pull.1151.v3.git.git.1639108573.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Dec 2021 03:56:06 +0000
Subject: [PATCH v3 03/10] sparse-checkout: add sanity-checks on initial
 sparsity state
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Most sparse-checkout subcommands (list, add, reapply, disable)
only make sense when already in a sparse state.  Add a quick check
that will error out early if this is not the case.

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
Reviewed-by: Victoria Dye <vdye@github.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/sparse-checkout.c          | 12 ++++++++++++
 t/t1091-sparse-checkout-builtin.sh | 10 +++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index e252b82136e..e9f644ac362 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -56,6 +56,9 @@ static int sparse_checkout_list(int argc, const char **argv)
 	char *sparse_filename;
 	int res;
 
+	if (!core_apply_sparse_checkout)
+		die(_("this worktree is not sparse"));
+
 	argc = parse_options(argc, argv, NULL,
 			     builtin_sparse_checkout_list_options,
 			     builtin_sparse_checkout_list_usage, 0);
@@ -671,6 +674,9 @@ static int sparse_checkout_add(int argc, const char **argv, const char *prefix)
 		OPT_END(),
 	};
 
+	if (!core_apply_sparse_checkout)
+		die(_("no sparse-checkout to add to"));
+
 	repo_read_index(the_repository);
 
 	argc = parse_options(argc, argv, prefix,
@@ -719,6 +725,9 @@ static int sparse_checkout_reapply(int argc, const char **argv)
 		OPT_END(),
 	};
 
+	if (!core_apply_sparse_checkout)
+		die(_("must be in a sparse-checkout to reapply sparsity patterns"));
+
 	argc = parse_options(argc, argv, NULL,
 			     builtin_sparse_checkout_reapply_options,
 			     builtin_sparse_checkout_reapply_usage, 0);
@@ -740,6 +749,9 @@ static int sparse_checkout_disable(int argc, const char **argv)
 	struct pattern_list pl;
 	struct strbuf match_all = STRBUF_INIT;
 
+	if (!core_apply_sparse_checkout)
+		die(_("no active sparse-checkout to disable"));
+
 	argc = parse_options(argc, argv, NULL,
 			     builtin_sparse_checkout_disable_options,
 			     builtin_sparse_checkout_disable_usage, 0);
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 272ba1b566b..90a281bcf64 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -41,7 +41,15 @@ test_expect_success 'setup' '
 	)
 '
 
-test_expect_success 'git sparse-checkout list (empty)' '
+test_expect_success 'git sparse-checkout list (not sparse)' '
+	test_must_fail git -C repo sparse-checkout list >list 2>err &&
+	test_must_be_empty list &&
+	test_i18ngrep "this worktree is not sparse" err
+'
+
+test_expect_success 'git sparse-checkout list (not sparse)' '
+	git -C repo sparse-checkout set &&
+	rm repo/.git/info/sparse-checkout &&
 	git -C repo sparse-checkout list >list 2>err &&
 	test_must_be_empty list &&
 	test_i18ngrep "this worktree is not sparse (sparse-checkout file may not exist)" err
-- 
gitgitgadget

