Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C11CC6377B
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 21:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28B6F613CF
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 21:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbhGUU03 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 16:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbhGUU02 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 16:26:28 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6B7C061575
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 14:07:03 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 14-20020a05600c028eb0290228f19cb433so337807wmk.0
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 14:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ueE21I85gUWcxNadFee1ccr3Z6nBX8ycBGkFpABYXrY=;
        b=n89H8jN+ScWY5budL/Fp1iL9Lhta5sybM9h4cPxhrle0/a2KYDfOFDcbTrZU1Uw4iN
         aj655TFIe1wMonPFkV/WOx0zZQa5tcoYYdqRGjbbrZXv5pifFuAZ/g9VLXcj5OaA3gTR
         cYRzp+WTrIPAd/9ZvzA3QRmbN7ntcu/UVxkSWpsCLPOcsu8NXWMHodlGBsJHPsyAnjcZ
         8zhY2pvhCQPKGSsvPW2UzZOH/EzAoM8+iPsazh2Gqo6+VftAxm763BKnsEPOMyHFPSEM
         ZguuoeUpjVkPnJ7TpqqGuxl43bBEGIMQHJxqAEA9+F/fG1yUvHMkR6gwGxx/mVbQUyea
         yOyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ueE21I85gUWcxNadFee1ccr3Z6nBX8ycBGkFpABYXrY=;
        b=eJ4xwxC9pfpPgzyfaDZa3uuwMj9Ki2hLRTxZRnzIwx67OimVVbJZ+cLrMM1e2k3JcO
         iipmNBOhNxkoztoy8B9P+MphhzlH4XVy1bAQdv93zzUyRd9pvGNICvgD4PxtHBIrKT2q
         Z/PSvzsYBSq2h1LQcuUboXBsGyxFXalX21pA9fzznCdtfOWHIBr68LE9lutKv2nk/WIr
         Tnkz+GAscI4PfjqSLnHQzcWCzKf2mClFbffjRZqKjzXdsHxEyZyCiQ9Ap6PkwOpO3skq
         oVPtJhi0eaJ96PVOUnuQBVUy2YJYFBo2ojWxJDvwoeTG6zc83EPzUwjmatg0cmMS2hiX
         EoJw==
X-Gm-Message-State: AOAM533sG6uKN6/DdGYPVR9f574Hku1vgu6Supp7+ac3PQNZIgxyPW1f
        o3b3Ui3PFbTTyAvVSRSu5F6TXiFo7Gg=
X-Google-Smtp-Source: ABdhPJzYcd7uaYcJ0asx3/RGrbOlbwsF6hKmhF6+xfKgmiNyrIsGRSdspWditRFioJtHlHR9Zzrr6A==
X-Received: by 2002:a1c:4b0a:: with SMTP id y10mr39128011wma.178.1626901621331;
        Wed, 21 Jul 2021 14:07:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g15sm22957627wmh.44.2021.07.21.14.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 14:07:01 -0700 (PDT)
Message-Id: <791c6c2c9ade5b065fc0f367e00c52a493d086ef.1626901619.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.999.git.1626901619.gitgitgadget@gmail.com>
References: <pull.999.git.1626901619.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 21 Jul 2021 21:06:56 +0000
Subject: [PATCH 2/5] add: allow operating on a sparse-only index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, matheus.bernardino@usp.br,
        stolee@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Disable command_requires_full_index for 'git add'. This does not require
any additional removals of ensure_full_index(). The main reason is that
'git add' discovers changes based on the pathspec and the worktree
itself. These are then inserted into the index directly, and calls to
index_name_pos() or index_file_exists() already call expand_to_path() at
the appropriate time to support a sparse-index.

Add a test to check that 'git add -A' and 'git add <file>' does not
expand the index at all, as long as <file> is not within a sparse
directory. This does not help the global 'git add .' case.

We can measure the improvement using p2000-sparse-operations.sh with
these results:

Test                                  HEAD~1           HEAD
------------------------------------------------------------------------------
2000.6: git add -A (full-index-v3)    0.35(0.30+0.05)  0.37(0.29+0.06) +5.7%
2000.7: git add -A (full-index-v4)    0.31(0.26+0.06)  0.33(0.27+0.06) +6.5%
2000.8: git add -A (sparse-index-v3)  0.57(0.53+0.07)  0.05(0.04+0.08) -91.2%
2000.9: git add -A (sparse-index-v4)  0.58(0.55+0.06)  0.05(0.05+0.06) -91.4%

While the 91% improvement seems impressive, it's important to recognize
that previously we had significant overhead for expanding the
sparse-index. Comparing to the full index case, 'git add -A' goes from
0.37s to 0.05s, which is "only" an 86% improvement.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/add.c                            |  3 +++
 t/t1092-sparse-checkout-compatibility.sh | 14 ++++++--------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index b773b5a4993..c76e6ddd359 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -528,6 +528,9 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	add_new_files = !take_worktree_changes && !refresh_only && !add_renormalize;
 	require_pathspec = !(take_worktree_changes || (0 < addremove_explicit));
 
+	prepare_repo_settings(the_repository);
+	the_repository->settings.command_requires_full_index = 0;
+
 	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
 
 	/*
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index a3c01d588d8..a11d9d7f35d 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -340,13 +340,6 @@ test_expect_success 'status/add: outside sparse cone' '
 
 	test_sparse_match git status --porcelain=v2 &&
 
-	# This "git add folder1/a" fails with a warning
-	# in the sparse repos, differing from the full
-	# repo. This is intentional.
-	test_sparse_match test_must_fail git add folder1/a &&
-	test_sparse_match test_must_fail git add --refresh folder1/a &&
-	test_all_match git status --porcelain=v2 &&
-
 	test_all_match git add . &&
 	test_all_match git status --porcelain=v2 &&
 	test_all_match git commit -m folder1/new &&
@@ -635,7 +628,12 @@ test_expect_success 'sparse-index is not expanded' '
 	git -C sparse-index reset --hard &&
 	ensure_not_expanded checkout rename-out-to-out -- deep/deeper1 &&
 	git -C sparse-index reset --hard &&
-	ensure_not_expanded restore -s rename-out-to-out -- deep/deeper1
+	ensure_not_expanded restore -s rename-out-to-out -- deep/deeper1 &&
+
+	echo >>sparse-index/README.md &&
+	ensure_not_expanded add -A &&
+	echo >>sparse-index/extra.txt &&
+	ensure_not_expanded add extra.txt
 '
 
 # NEEDSWORK: a sparse-checkout behaves differently from a full checkout
-- 
gitgitgadget

