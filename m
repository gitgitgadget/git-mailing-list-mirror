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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450FEC432BE
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 17:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2543960FD9
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 17:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbhHQRJ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 13:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbhHQRJW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 13:09:22 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90DBC061796
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 10:08:48 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 79-20020a1c0452000000b002e6cf79e572so2437629wme.1
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 10:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ro893bLvb1ewTMCxZ8A9UF4Z5ELXQAo6aO7w7HpWQBc=;
        b=T547T3ZNLnftqFv1OqxI/k1YpOLuLYeXbpfbIzozRRlaKwkwPEXQ980Nz9A9qNCaXA
         r0RJVWBlqxQX52o08VqV4UiU1Oo5gTQgqy57QbSogDW+jVfWrzNhRW4JHl1HtKkB7a9k
         swl5g7Rjp19ra9FQWEbKZ2W4DS5yZILQBwGwbvfn40mhc3eBtFBrxr7lVNthN85SxDbu
         dBBVFkg6hHh66pGj57gE16qaqqAAgtKWWCuuoebJ804oKeWcJPFDML2r1c/FZSYwGSu1
         qzd3zWRqc+lZ+v6+0R04jNUSP5ElSn7jF/JLpDunpTXQPDX5QexGXYHaEPxvJSirqDtN
         RjDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ro893bLvb1ewTMCxZ8A9UF4Z5ELXQAo6aO7w7HpWQBc=;
        b=HM9ZmCH/MP2EXV9pOtFep5cng9AkWBwVS3Kmxo+X0KpJaqOPL65ROt1wCmuhVNY+t0
         e5+I3K34MQcig4JK6s5Zx6CoNvxGAGwNvTqyPddqxBNu39lxHXHop/+5ABIBZf+46xK2
         qvK1hpVh54m7rzfrpvq+Kt0XNxFQUkoIhnmQmTrFWhViIv1SA6+BhEMToixzkAySyxI7
         gV3VftN7Cw2pAZL+YX0J4PG0bsQqT6pThriXQnK9wj7OQnCO5N3fsNpYHLHLAZfRWuRh
         EVToHS9+QC/bCR0BgtY1mXu1H15fK/J2PTOb3qjJp1DWZVWeqUga6WhUItU9pRVMaHaf
         MR9w==
X-Gm-Message-State: AOAM533pcMIdaycNduCVKfBum7e3K5eNWSvx7aQr+XL4YGrphhbsMmTM
        vPO1A1Ili0swdreI3qD8C8bRlRtlcIA=
X-Google-Smtp-Source: ABdhPJxQNfq4ZOMLx0Qjv/WEODOYiU+Y5sU5Ewxp9L1K1JzA9KHwXrnxy7aUA9wQxIsGeMxbtCNbpg==
X-Received: by 2002:a7b:c1d7:: with SMTP id a23mr4488406wmj.69.1629220127453;
        Tue, 17 Aug 2021 10:08:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i21sm3158632wrb.62.2021.08.17.10.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 10:08:47 -0700 (PDT)
Message-Id: <4c1104a0dd3af4a895df42f43306c24965a0323c.1629220124.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1019.git.1629220124.gitgitgadget@gmail.com>
References: <pull.1019.git.1629220124.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Aug 2021 17:08:41 +0000
Subject: [PATCH 3/6] merge: make sparse-aware with ORT
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, stolee@gmail.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Allow 'git merge' to operate without expanding a sparse index, at least
not immediately. The index still will be expanded in a few cases:

1. If the merge strategy is 'recursive', then we enable
   command_requires_full_index at the start of the merge_recursive()
   method. We expect sparse-index users to also have the 'ort' strategy
   enabled.

2. If the merge results in a conflicted file, then we expand the index
   before updating the working tree. The loop that iterates over the
   worktree replaces index entries and tracks 'origintal_cache_nr' which
   can become completely wrong if the index expands in the middle of the
   operation. This safety valve is important before that loop starts. A
   later change will focus this to only expand if we indeed have a
   conflict outside of the sparse-checkout cone.

Some test updates are required, including a mistaken 'git checkout -b'
that did not specify the base branch, causing merges to be fast-forward
merges.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/merge.c                          | 3 +++
 merge-ort.c                              | 8 ++++++++
 merge-recursive.c                        | 3 +++
 t/t1092-sparse-checkout-compatibility.sh | 8 ++++++--
 4 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 22f23990b37..926de328fbb 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1276,6 +1276,9 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(builtin_merge_usage, builtin_merge_options);
 
+	prepare_repo_settings(the_repository);
+	the_repository->settings.command_requires_full_index = 0;
+
 	/*
 	 * Check if we are _not_ on a detached HEAD, i.e. if there is a
 	 * current branch.
diff --git a/merge-ort.c b/merge-ort.c
index 6eb910d6f0c..8e754b769e1 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -4058,6 +4058,14 @@ static int record_conflicted_index_entries(struct merge_options *opt)
 	if (strmap_empty(&opt->priv->conflicted))
 		return 0;
 
+	/*
+	 * We are in a conflicted state. These conflicts might be inside
+	 * sparse-directory entries, so expand the index preemtively.
+	 * Also, we set original_cache_nr below, but that might change if
+	 * index_name_pos() calls ask for paths within sparse directories.
+	 */
+	ensure_full_index(index);
+
 	/* If any entries have skip_worktree set, we'll have to check 'em out */
 	state.force = 1;
 	state.quiet = 1;
diff --git a/merge-recursive.c b/merge-recursive.c
index 3355d50e8ad..1f563cd6874 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3750,6 +3750,9 @@ int merge_recursive(struct merge_options *opt,
 	assert(opt->ancestor == NULL ||
 	       !strcmp(opt->ancestor, "constructed merge base"));
 
+	prepare_repo_settings(opt->repo);
+	opt->repo->settings.command_requires_full_index = 1;
+
 	if (merge_start(opt, repo_get_commit_tree(opt->repo, h1)))
 		return -1;
 	clean = merge_recursive_internal(opt, h1, h2, merge_bases, result);
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 3e01e70fa0b..781ebd9a656 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -52,7 +52,7 @@ test_expect_success 'setup' '
 		git checkout -b base &&
 		for dir in folder1 folder2 deep
 		do
-			git checkout -b update-$dir &&
+			git checkout -b update-$dir base &&
 			echo "updated $dir" >$dir/a &&
 			git commit -a -m "update $dir" || return 1
 		done &&
@@ -652,7 +652,11 @@ test_expect_success 'sparse-index is not expanded' '
 	echo >>sparse-index/extra.txt &&
 	ensure_not_expanded add extra.txt &&
 	echo >>sparse-index/untracked.txt &&
-	ensure_not_expanded add .
+	ensure_not_expanded add . &&
+
+	ensure_not_expanded checkout -f update-deep &&
+	ensure_not_expanded merge -s ort -m merge update-folder1 &&
+	ensure_not_expanded merge -s ort -m merge update-folder2
 '
 
 # NEEDSWORK: a sparse-checkout behaves differently from a full checkout
-- 
gitgitgadget

