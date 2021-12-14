Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00ADEC433FE
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 04:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233924AbhLNEJV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 23:09:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233692AbhLNEJR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 23:09:17 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87930C061574
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 20:09:16 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id a9so30278993wrr.8
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 20:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=c+h3Ljxdzm8BQwJ5+vMGcrhGlWagJnPB8SRgTeEyRyE=;
        b=BhJxA/SEdoVvEIzj3K8dIJojXC44DE7PsX8B2Tuz42R2VjmqhJMGs10nAQRsqFtlSi
         G4mtlWH1tInHLcsysUl4UyZAcaVZNb19IebbzckCKdEMcYF3P0NAMzRQ7b80fzOckIUY
         ctgMhaytN7ohBO+gUDdiD9FFCbzhyIgBhlCl1OUvc7uwt/zEiMvrHHKhUpNPI7OuGioY
         7CwFQQr5BFWt7OF3RFswCYyu7JnLFmiiEFwbYXpbTV0xAJU5mhAl/UQSnjr7yABqyb1Z
         d1YwRmYAJySGTWeX7++H5rdztZGqkseOUDRFnxIZz8K5ZTSilzQTqZYOSuMzE87eEdO2
         /PQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=c+h3Ljxdzm8BQwJ5+vMGcrhGlWagJnPB8SRgTeEyRyE=;
        b=OsVs3tMH4qbOD6dHc5Hgc5S0JhYYhVp3N0/SD6J2n9ZgET6cod36PWqcmYdH+/Z5tb
         iE5vHHwsZV+xHoeWA/KiwFNH1BQyyh98lCo7X8D8xYoXVRFyx89WOj647ULGPPt1hgiR
         rVJ88NpldKSvCY5oVSOtAwqcnl3UvxruFyg9iSvOAvAgDCJbdGLTmd6w1Bfcf0cdJqa7
         /pSLhklqtoT2WGcxK8e3BDVKup+NQKqbXkt1wCmnFIWTPp9mBaxIq/5bloo5QvZRbrAl
         fJb3iGuXudyFbIZsEB8fDWV3W08ud8pt+KZfcRt0/qHkL57NqHXMz9z0hvaoq2wr+zws
         pRgw==
X-Gm-Message-State: AOAM530oPhkSL3UyoPgmN7oHMw4UI2LMSFZqbOAsENAxBuzxqExpPXNA
        /GAh7DkK/4jxtN2nozy3uss7mDdZkY8=
X-Google-Smtp-Source: ABdhPJyta3M0d36/4rl+CPH3SEBWUkf9bhomfXpbIkzGbblRItALKFFC6hq46vSCkG9t8S52JODPtQ==
X-Received: by 2002:a5d:680b:: with SMTP id w11mr2975504wru.345.1639454954967;
        Mon, 13 Dec 2021 20:09:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e7sm16122061wrg.31.2021.12.13.20.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 20:09:14 -0800 (PST)
Message-Id: <a8fdda35b914aa0d0a44df8e44afd481e173367f.1639454952.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1151.v4.git.git.1639454952.gitgitgadget@gmail.com>
References: <pull.1151.v3.git.git.1639108573.gitgitgadget@gmail.com>
        <pull.1151.v4.git.git.1639454952.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Dec 2021 04:09:05 +0000
Subject: [PATCH v4 03/10] sparse-checkout: add sanity-checks on initial
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

Most sparse-checkout subcommands (list, add, reapply) only make sense
when already in a sparse state.  Add a quick check that will error out
early if this is not the case.

Also document with a comment why we do not exit early in `disable` even
when core.sparseCheckout starts as false.

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
Reviewed-by: Victoria Dye <vdye@github.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/sparse-checkout.c          | 20 ++++++++++++++++++++
 t/t1091-sparse-checkout-builtin.sh | 10 +++++++++-
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index e252b82136e..eb8fbd36b0b 100644
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
@@ -740,6 +749,17 @@ static int sparse_checkout_disable(int argc, const char **argv)
 	struct pattern_list pl;
 	struct strbuf match_all = STRBUF_INIT;
 
+	/*
+	 * We do not exit early if !core_apply_sparse_checkout; due to the
+	 * ability for users to manually muck things up between
+	 *   direct editing of .git/info/sparse-checkout
+	 *   running read-tree -m u HEAD or update-index --skip-worktree
+	 *   direct toggling of config options
+	 * users might end up with an index with SKIP_WORKTREE bit set on
+	 * some files and not know how to undo it.  So, here we just
+	 * forcibly return to a dense checkout regardless of initial state.
+	 */
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

