Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41398C4338F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 14:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21CB960EBC
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 14:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237640AbhG2OwR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jul 2021 10:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhG2OwP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jul 2021 10:52:15 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C33C0613CF
        for <git@vger.kernel.org>; Thu, 29 Jul 2021 07:52:11 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id l18so7307685wrv.5
        for <git@vger.kernel.org>; Thu, 29 Jul 2021 07:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UgvhPu+guleWuAFXyyEnpZpN9uiWr9d7+4IVmwrw76s=;
        b=UvhIwpTGWbGkMmh55pNXrDLwFQBXSmMS0/RxUUuPg7dfMO6MukwCmbKDSPuHSBFF/x
         ZtIPXleMYzt1V7xh8S2raVJ04FsgZoReVxkM6erUb+x7U85xfAtSBjNDaUpp53jZyuj7
         rVgNRV2XhNH0YmBET2gZ41j/NdkThSD1ZXml8c8X0iHKS28gp+Fb4jGjhrvQO3QQxaPZ
         hm5T8FDyT83V2G7wztGGbsUrqNOhfMEpD23RAKUo6kKeGC33+weFjPeAi+BuwVihYI3l
         bBhAO3MC5w+j3rkAflzarBpJxR+DLFa0pUk03WdwFzEHVVBq9dLj2X9Dh/n6U6Xpu7Z4
         2+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UgvhPu+guleWuAFXyyEnpZpN9uiWr9d7+4IVmwrw76s=;
        b=Frt1W6ysQ7erzzCUW9Ku2PAeRK7Wsf7PIpYaEhjHy4OLgsnO+iIqYRviyHS7+bqZ6z
         uFSuyAGg8iyqIo5+pJrlYo4ygnwEL4hYG/zMumwvTTQhm4UDdahwDqPSnE5gBxli42rV
         BMpx21YIUkV65UDnNJM0HOHe5o1aZhdrPGhZqLCqp3GfoXRfEtsWSWH6QXECxZPM2NXu
         WgpVBaTAxVgYym6wjvP1adNz5/rHTWZAidglwwJCGyDix2mGpCiBmkqwboMHfoP0O3uH
         DQA1yE/HwPROqb7CdLb0Vk86rRoFSRucNQZGXReEtll3VAsu48Q+uEZbeIsmUyMh+q+4
         X+VQ==
X-Gm-Message-State: AOAM531I1CQuepezzHZzxIrP9+s6xb737aM61mJXOUb6dE9iGBXmuRi9
        fRmDGeZ0DnMD07Y3BpCAQwvUzDeTJk4=
X-Google-Smtp-Source: ABdhPJwUyAMzEk+ZkhU5j6+fA0kinPSvCDgPcivKH42zoHlfYtdFrLrA3n9ZqkXfQGCmzrVxXtNtOg==
X-Received: by 2002:adf:eec9:: with SMTP id a9mr5167414wrp.226.1627570330385;
        Thu, 29 Jul 2021 07:52:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t1sm3601447wrm.42.2021.07.29.07.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 07:52:10 -0700 (PDT)
Message-Id: <defab1b86d3427c9e369e81cc481083a7dacace7.1627570327.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.999.v3.git.1627570327.gitgitgadget@gmail.com>
References: <pull.999.v2.git.1627312727.gitgitgadget@gmail.com>
        <pull.999.v3.git.1627570327.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 29 Jul 2021 14:52:04 +0000
Subject: [PATCH v3 2/5] add: allow operating on a sparse-only index
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

Reviewed-by: Elijah Newren <newren@gmail.com>
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
index 4c3bcb34999..77343cb6d95 100755
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
@@ -641,7 +647,12 @@ test_expect_success 'sparse-index is not expanded' '
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

