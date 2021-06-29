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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23742C11F67
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 02:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05DF561CD4
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 02:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbhF2CPl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 22:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbhF2CPj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 22:15:39 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102FEC061766
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 19:13:12 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id j2so23739482wrs.12
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 19:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SQPTNKDRI4ssneXDiJuN5/cJooiS3xOo4L8xI+dA0QU=;
        b=qPG3rDjHYmn651EPiC82qrgXry0TC7V+ndD4EHQVlUSEjfgZCs4AbKCRosPulyln45
         9vneamYbPXl2QQbIOeg+RAVtef1cQe+OE/HrxqmedfDEq1YWUHT1Mk/VuhRz/6yRAFht
         pFvkxnr04Kce7EOGv4Xd+OklhmkpobcvDRcUNvIeMv7UiwIs0jIP467CAwtfVNZIG61q
         5Ir4jT3jRB0IDIiipM1DMmxcFtFVF+elQIzu6mQ8qPm7OlDuPQBSkU0kkhWTzvpGenPc
         v5IH50Vg0A8G+CVW9ox1NNppMnREOz3KbzS30OE3+LY+wI4uMG1QmZEqimz/K29ISgjf
         x38Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SQPTNKDRI4ssneXDiJuN5/cJooiS3xOo4L8xI+dA0QU=;
        b=q0hkUkSqR3VRpSJlocervtimxMOt3oSErFo4GBFSkxlARFnBWEjBnaDSBRhfiO1xX/
         tYQykf7/4vSpU/7dJLumI6edearhZEKVJ18Ptug/FzvwKTHjh+tM2Qtm7LeYWt3LJ8JN
         csOG5hJUEyY+x7qCFg/Hwyo2pnE6VjXNbLOy2StMSLWsT8T1s/DedBy8x3txxVjWVpV5
         p3SjTRsgtPr9x2ZZfWQN0bLUMW1MOvnB/6eez3/0jIHg2zFEe7uVrkucQBrZnhILDyH5
         xANoLUuIPPAG6pwB33gytpwiO2sWaTySqCs9AbtDZfOFGo3UmmLpvXc5ANMcByjuhsyY
         Wp/A==
X-Gm-Message-State: AOAM531bGLLdJLQ10I34Z+nVTB24Fuk/8ONWhR0mn/t+hy6Mf0kMqx0M
        PUydGEjoi5cCSzqrpkQgXAL0gjEnSog=
X-Google-Smtp-Source: ABdhPJyF28g5K0KlY6EYm+m1jUvOT9oGpOyV0++LfM6n00W8xY639S0ZhuGc1B9i8hNk3e+MDRmV2A==
X-Received: by 2002:a5d:65d1:: with SMTP id e17mr1471803wrw.275.1624932790686;
        Mon, 28 Jun 2021 19:13:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x1sm15392666wmc.31.2021.06.28.19.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 19:13:10 -0700 (PDT)
Message-Id: <8710fee36b7821e0c36196b8e7b9a27d5994ae72.1624932787.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.973.git.1624932786.gitgitgadget@gmail.com>
References: <pull.973.git.1624932786.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Jun 2021 02:13:06 +0000
Subject: [PATCH 5/5] checkout: stop expanding sparse indexes
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
index 11c6dc8ec1f..1d7dd735d7d 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -581,7 +581,15 @@ test_expect_success 'sparse-index is not expanded' '
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
 
 test_expect_success 'reset mixed and checkout orphan' '
-- 
gitgitgadget
