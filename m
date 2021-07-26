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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BF4C432BE
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 15:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 040AA60F51
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 15:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235056AbhGZOil (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 10:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234778AbhGZOiX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 10:38:23 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26BEC061760
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 08:18:51 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id l4so11542465wrs.4
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 08:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CbrIICt1ZseenszcmvctOJ+a8mIFfyJkW43dB77sJ+w=;
        b=cyM7k/pX5lxB5KYAkbSeqxp+LyXJWm42MjKPeKEGJxnYwILBbhT9tNY8Rpyj8MsENl
         Li5JBGgmq9N4XzL5IoVViXhpFGXZa51I9y6zG16JwOq0mBZAA4agiI4IZBw3OsZ8b/gC
         k+1kyhQX+nReCKJ53yxxxfzo3y0mbqwb/j/5kCa2xsvNhYUo4uaoXWeKZkAsA2Bni2wJ
         5oHyxfnqU7XicNpZozDjV9DetMfcZWYnhiQY2o4PqT2fcjCgj15trc5UGZryF3GI2EF/
         QWrYLmqD3LM1aSQah+WvSATbWH1CSVkRAHoRGjI65TykwrrEB/u3Gyzz3jB+yPOp4eRA
         /gpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CbrIICt1ZseenszcmvctOJ+a8mIFfyJkW43dB77sJ+w=;
        b=dnvkUm5CetmDcEIWjRCZ/FR5Gd8BHOQB+oDffihiQwdB7KqeDnUZ7NK+Q1yn+WEKhu
         6XvBy7z7RY5ioYDN7DBAWTEHdBefT7rouoT00HF8oMtBP7nCrnhtfT2XPqrIEqyvr8Ml
         pzaMVq5ilLkza4nupzpSIIwD37VHK0ReYJ1hOMUW5CvfqhOk/dt6paQolAkY5kgvutm3
         YRbOMF8+7kZkBgIOFLWOdJalI24aEHYlaE+G1buEc/FLXkCoSvJAgs1ssAzE5GWFeIQy
         z+A44DJss/Eg9CUyf5ikhnjr5Nn7eFGWfvHGAWD8GC9DPth+0uZCTMF5IaQjWisZ7FXl
         xVpg==
X-Gm-Message-State: AOAM53298RD+GHJVjLlVNTST4+RySlCO5YKLcG6Y2QmK5dRO3zPYA8lx
        IjEaylkiVQiFOYkZnzJyrwTxFVSCKDw=
X-Google-Smtp-Source: ABdhPJzBPPjJ1rUf8zykw5hmRhfTnPyGHBVWETdl8JDxwKFb9LukRQBnRMmPa0pUPjFJmNYD62lG4Q==
X-Received: by 2002:a5d:6481:: with SMTP id o1mr20505732wri.164.1627312730426;
        Mon, 26 Jul 2021 08:18:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s14sm78658wmc.25.2021.07.26.08.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 08:18:49 -0700 (PDT)
Message-Id: <6e43f118fa0b7a6ba2e841f75a90406d847d9f09.1627312727.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.999.v2.git.1627312727.gitgitgadget@gmail.com>
References: <pull.999.git.1626901619.gitgitgadget@gmail.com>
        <pull.999.v2.git.1627312727.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Jul 2021 15:18:44 +0000
Subject: [PATCH v2 2/5] add: allow operating on a sparse-only index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, matheus.bernardino@usp.br,
        stolee@gmail.com, Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <derrickstolee@github.com>,
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

This modification to 'git add' creates some behavior change depending on
the use of a sparse index. We modify a test in t1092 to demonstrate
these changes which will be remedied in future changes.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/add.c                            |  3 +++
 t/t1092-sparse-checkout-compatibility.sh | 25 +++++++++++++++++-------
 2 files changed, 21 insertions(+), 7 deletions(-)

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
index 47f8e5e54e3..19d38f18ed6 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -340,21 +340,27 @@ test_expect_success 'status/add: outside sparse cone' '
 
 	test_sparse_match git status --porcelain=v2 &&
 
-	# This "git add folder1/a" fails with a warning
-	# in the sparse repos, differing from the full
-	# repo. This is intentional.
+	# Adding the path outside of the sparse-checkout cone should fail.
 	test_sparse_match test_must_fail git add folder1/a &&
-	test_sparse_match test_must_fail git add --refresh folder1/a &&
-	test_all_match git status --porcelain=v2 &&
+
+	test_must_fail git -C sparse-checkout add --refresh folder1/a 2>sparse-checkout-err &&
+	test_must_fail git -C sparse-index add --refresh folder1/a 2>sparse-index-err &&
+	# NEEDSWORK: A sparse index changes the error message.
+	! test_cmp sparse-checkout-err sparse-index-err &&
+
+	# NEEDSWORK: Adding a newly-tracked file outside the cone succeeds
+	test_sparse_match git add folder1/new &&
 
 	test_all_match git add . &&
 	test_all_match git status --porcelain=v2 &&
 	test_all_match git commit -m folder1/new &&
+	test_all_match git rev-parse HEAD^{tree} &&
 
 	run_on_all ../edit-contents folder1/newer &&
 	test_all_match git add folder1/ &&
 	test_all_match git status --porcelain=v2 &&
-	test_all_match git commit -m folder1/newer
+	test_all_match git commit -m folder1/newer &&
+	test_all_match git rev-parse HEAD^{tree}
 '
 
 test_expect_success 'checkout and reset --hard' '
@@ -636,7 +642,12 @@ test_expect_success 'sparse-index is not expanded' '
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

