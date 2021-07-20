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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35ABC636CA
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 20:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAF7E61009
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 20:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233937AbhGTUAf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 16:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbhGTTeg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 15:34:36 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4D6C0613E2
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 13:14:46 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id n4so84353wms.1
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 13:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=emMgPNDmsinyWNQuDS25z5uXhezmqYrHYu56d0gVkXA=;
        b=dXuinKtA5HSTeOHsMeZEzix45r5ncAbgWj83GrbQib/fcuHGtOcvEnaXIiDF7sUWfg
         Bf2p5S1eOWK4E/JU5I/xig3nPYHUix40mAvqCJHwAofqY85sfN5PlSFXBOZBOLRItsbi
         WEmv6SiVizzIre4mfJyKqFibX6oz3CGM97OGXGH/NXfqp9+L6Fw/9kwDPKXSsuHmukEW
         K4Ik2VWHg4LrViFKTIQUCBK9cO2p4a/IciopezFR1dDZSsIjtmrPpZZkPOzbiUH3i3Qs
         6L9Kfz1S2wy4rhxXlHDL5AWHFTA3ZPyZ0yGY0ekSqIquIVeVHamewuwAn1Qlj1B4scjs
         G8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=emMgPNDmsinyWNQuDS25z5uXhezmqYrHYu56d0gVkXA=;
        b=lUZdxYUUTmdbbgU8whlqgnuQuMuZdJ90PGm2hbvjBsC1ODYvdiwk013n1g9Q2wiW4u
         dQPzO+8CnCcF9HrNdBBMzo1LK4G0/MTDJYApABenbbwPfxpgrMKmcfAR9yH32vS9q7ya
         pNbuBcbY9MzPbORfTOnAB/tlBGR+RkLdyS9Fg8Xrd3W4G24yACoZxAr68AGYbdndys74
         CuIspcjHsofyL1TcfFjTbkmnN5GQxtVTA97LMRgzwKfLcLcMMN5obDUWRWjvkekdALdq
         os8Xg4DLVUGguZNm/ksJixp2TUiNQIJAJcdj+cGKYBQoJ9+f8UTxcFsNgL7cIuoxIxi5
         +ZtA==
X-Gm-Message-State: AOAM533GUIxIGnrYkBQh1ZZMq5q335phihVtLxjbalm8W+2KKX6Y30BP
        FKAg7lOitZb449pAV5XGG5Em1v7Ir/k=
X-Google-Smtp-Source: ABdhPJxN3/tsecDoUsHNWjAYWMNG8eS9wlRkogvDSx8NyYTguaDLxidHhtp19vPaZCs4JCO/rODK7g==
X-Received: by 2002:a05:600c:35c1:: with SMTP id r1mr33787931wmq.0.1626812085230;
        Tue, 20 Jul 2021 13:14:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o6sm24270953wry.91.2021.07.20.13.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 13:14:44 -0700 (PDT)
Message-Id: <e9a9981477e9d6ba3aef96e39db5736b334d7189.1626812081.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.973.v2.git.1626812081.gitgitgadget@gmail.com>
References: <pull.973.git.1624932786.gitgitgadget@gmail.com>
        <pull.973.v2.git.1626812081.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Jul 2021 20:14:39 +0000
Subject: [PATCH v2 5/7] checkout: stop expanding sparse indexes
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

Previous changes did the necessary improvements to unpack-trees.c and
diff-lib.c in order to modify a sparse index based on its comparision
with a tree. The only remaining work is to remove some
ensure_full_index() calls and add tests that verify that the index is
not expanded in our interesting cases. Include 'switch' and 'restore' in
these tests, as they share a base implementation with 'checkout'.

Here are the relevant performance results from
p2000-sparse-operations.sh:

Test                                     HEAD~1           HEAD
--------------------------------------------------------------------------------
2000.18: git checkout -f - (full-v3)     0.49(0.43+0.03)  0.47(0.39+0.05) -4.1%
2000.19: git checkout -f - (full-v4)     0.45(0.37+0.06)  0.42(0.37+0.05) -6.7%
2000.20: git checkout -f - (sparse-v3)   0.76(0.71+0.07)  0.04(0.03+0.04) -94.7%
2000.21: git checkout -f - (sparse-v4)   0.75(0.72+0.04)  0.05(0.06+0.04) -93.3%

It is important to compare the full index case to the sparse index case,
as the previous results for the sparse index were inflated by the index
expansion. For index v4, this is an 88% improvement.

On an internal repository with over two million paths at HEAD and a
sparse-checkout definition containing ~60,000 of those paths, 'git
checkout' went from 3.5s to 297ms with this change. The theoretical
optimum where only those ~60,000 paths exist was 275ms, so the extra
sparse directory entries contribute a 22ms overhead.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/checkout.c                       |  8 +++-----
 t/t1092-sparse-checkout-compatibility.sh | 10 +++++++++-
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index f4cd7747d35..b5d477919a7 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -378,9 +378,6 @@ static int checkout_worktree(const struct checkout_opts *opts,
 	if (pc_workers > 1)
 		init_parallel_checkout();
 
-	/* TODO: audit for interaction with sparse-index. */
-	ensure_full_index(&the_index);
-
 	for (pos = 0; pos < active_nr; pos++) {
 		struct cache_entry *ce = active_cache[pos];
 		if (ce->ce_flags & CE_MATCHED) {
@@ -530,8 +527,6 @@ static int checkout_paths(const struct checkout_opts *opts,
 	 * Make sure all pathspecs participated in locating the paths
 	 * to be checked out.
 	 */
-	/* TODO: audit for interaction with sparse-index. */
-	ensure_full_index(&the_index);
 	for (pos = 0; pos < active_nr; pos++)
 		if (opts->overlay_mode)
 			mark_ce_for_checkout_overlay(active_cache[pos],
@@ -1593,6 +1588,9 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 
 	git_config(git_checkout_config, opts);
 
+	prepare_repo_settings(the_repository);
+	the_repository->settings.command_requires_full_index = 0;
+
 	opts->track = BRANCH_TRACK_UNSPECIFIED;
 
 	if (!opts->accept_pathspec && !opts->accept_ref)
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index d3e34d0acac..fde3b41aba8 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -560,7 +560,15 @@ test_expect_success 'sparse-index is not expanded' '
 	echo >>sparse-index/a &&
 	ensure_not_expanded commit --include a -m a &&
 	echo >>sparse-index/deep/deeper1/a &&
-	ensure_not_expanded commit --include deep/deeper1/a -m deeper
+	ensure_not_expanded commit --include deep/deeper1/a -m deeper &&
+	ensure_not_expanded checkout rename-out-to-out &&
+	ensure_not_expanded checkout - &&
+	ensure_not_expanded switch rename-out-to-out &&
+	ensure_not_expanded switch - &&
+	git -C sparse-index reset --hard &&
+	ensure_not_expanded checkout rename-out-to-out -- deep/deeper1 &&
+	git -C sparse-index reset --hard &&
+	ensure_not_expanded restore -s rename-out-to-out -- deep/deeper1
 '
 
 # NEEDSWORK: a sparse-checkout behaves differently from a full checkout
-- 
gitgitgadget

