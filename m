Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56256C433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 11:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35DA761078
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 11:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351446AbhIHLZO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 07:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351306AbhIHLZN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 07:25:13 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC99DC061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 04:24:05 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id i28so2761871wrb.2
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 04:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZDmWBBGaLotuFCux6mhd7u56pgdwp86r+MClGOgh9fA=;
        b=kV+ur8WpR1KAiyzq1Tx0EoGpr1+GfqQPrXUjIXgPLWb4+EVoNDgOQhFqX29aBPl9Ad
         HGIkBwzcZE+2/2SsA6Ko4mQoen5FFbGh/imItwA0c33CuzKkJp1BNw0L5hy/vXm5c8b4
         XqOCIeuh6h3t7iL5r2r1H86/yT0rTR0gZ+EuKWkwvlwQYGj0Ygp0jIpd2mn5eMw+rGBA
         PrfAb6Dwoln87SvrQg6yy2DyN2MO208F/LsF7ZxXTKkRQ1CrhN/QAOtaZRMj4bsGHA1s
         PjPxWsAplib+Bi7pHChgSpw5r7vhWTPKVM3pNSDWHMzskFu/zH2rEv2UI18a4JrhC3nP
         t7dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZDmWBBGaLotuFCux6mhd7u56pgdwp86r+MClGOgh9fA=;
        b=Uwi3R7EZfUsCopwoaCiarjJf493YzNqTxpT1r73h/hHwkVafyf5A2MpEC1Lmh2toaB
         AN4ONHShmgeNulwn7J2w6kqNw/wk94MiiiFMOyNMTLBHIqq8sRv7H5NFcVNjW/UPsL1f
         OQ4GrfDHARcHQdl/2cySpBgnBjP+jRZjDLmGaxaRg8nHcj1JloVuTfpxEHOO4E1lFYgs
         aoACC4uLLbx6fatVZfG+kpddbSasH8Z30Nmf97EwgBEQbMkaowLWZd37azTSzVU47h/2
         TPa6RsOEPF2crKRtLr7qjEHWUQ08zGLSB0hbZRm+dxeLMiKjwaFtRvrTsZT877PpUHwO
         Fjyw==
X-Gm-Message-State: AOAM5319K+NaEguiFJAu1PawULBcDaS9I3UnHclz4ffeonxnwNchYiFL
        2x2yaVB5TiKF/n0WT6XUU+g30EZuxgA=
X-Google-Smtp-Source: ABdhPJzXUjfQa3eE2LhY046WUBSkkuYXkAIQgf0gFD309ZkUsTP63vDs6aWDDBKdSBSV4omnD6Y7Aw==
X-Received: by 2002:a5d:5262:: with SMTP id l2mr3477009wrc.190.1631100244299;
        Wed, 08 Sep 2021 04:24:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t14sm1877553wrw.59.2021.09.08.04.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 04:24:04 -0700 (PDT)
Message-Id: <141f7fb26d6aacf3d2dae7dfbc7cf1bf4fe0561d.1631100241.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1019.v3.git.1631100241.gitgitgadget@gmail.com>
References: <pull.1019.v2.git.1629841965.gitgitgadget@gmail.com>
        <pull.1019.v3.git.1631100241.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Sep 2021 11:23:57 +0000
Subject: [PATCH v3 2/6] merge: make sparse-aware with ORT
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, stolee@gmail.com, gitster@pobox.com,
        Taylor Blau <me@ttaylorr.com>,
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

2. With the 'ort' strategy, if the merge results in a conflicted file,
   then we expand the index before updating the working tree. The loop
   that iterates over the worktree replaces index entries and tracks
   'origintal_cache_nr' which can become completely wrong if the index
   expands in the middle of the operation. This safety valve is
   important before that loop starts. A later change will focus this
   to only expand if we indeed have a conflict outside of the
   sparse-checkout cone.

3. Other merge strategies are executed as a 'git merge-X' subcommand,
   and those strategies are currently protected with the
   'command_requires_full_index' guard.

Some test updates are required, including a mistaken 'git checkout -b'
that did not specify the base branch, causing merges to be fast-forward
merges.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/merge.c                          |  3 +++
 merge-ort.c                              |  8 ++++++++
 merge-recursive.c                        |  3 +++
 t/t1092-sparse-checkout-compatibility.sh | 12 ++++++++++--
 4 files changed, 24 insertions(+), 2 deletions(-)

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
index 6eb910d6f0c..1531b4c94c2 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -4058,6 +4058,14 @@ static int record_conflicted_index_entries(struct merge_options *opt)
 	if (strmap_empty(&opt->priv->conflicted))
 		return 0;
 
+	/*
+	 * We are in a conflicted state. These conflicts might be inside
+	 * sparse-directory entries, so expand the index preemptively.
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
index ddc86bb4152..3b331a6bfe7 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -47,7 +47,7 @@ test_expect_success 'setup' '
 		git checkout -b base &&
 		for dir in folder1 folder2 deep
 		do
-			git checkout -b update-$dir &&
+			git checkout -b update-$dir base &&
 			echo "updated $dir" >$dir/a &&
 			git commit -a -m "update $dir" || return 1
 		done &&
@@ -647,7 +647,15 @@ test_expect_success 'sparse-index is not expanded' '
 	echo >>sparse-index/extra.txt &&
 	ensure_not_expanded add extra.txt &&
 	echo >>sparse-index/untracked.txt &&
-	ensure_not_expanded add .
+	ensure_not_expanded add . &&
+
+	ensure_not_expanded checkout -f update-deep &&
+	test_config -C sparse-index pull.twohead ort &&
+	(
+		sane_unset GIT_TEST_MERGE_ALGORITHM &&
+		ensure_not_expanded merge -m merge update-folder1 &&
+		ensure_not_expanded merge -m merge update-folder2
+	)
 '
 
 # NEEDSWORK: a sparse-checkout behaves differently from a full checkout
-- 
gitgitgadget

