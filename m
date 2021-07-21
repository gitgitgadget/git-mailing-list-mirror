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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8EBC6377A
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 21:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54AA7613FD
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 21:07:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhGUU03 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 16:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbhGUU02 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 16:26:28 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F26CC061757
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 14:07:03 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l11-20020a7bc34b0000b029021f84fcaf75so316933wmj.1
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 14:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=J9N9Y3TTk0oY7Us5Osz7APqG+lo0OhkBPQ1D46Jl8tk=;
        b=Ob8DJPsr3ORl/J3YvnvjRQuDl1UTWCQ8friYMpZ6VsFOBW4AY/BjxRGjikHnjH3gi/
         8TXbmlxK3XMbYHP76A8x3obJGw+0Hyet/Z1T+nmCQX6tLkPSYs52y6hVP9ubFbSkTX2a
         F1FfgOhFuog48OkHKe2zmHY0V8H94p8gY+2GQeXKKt7Pr3uFr0zGhwheEUsmUDz1GD0t
         f82N/lTaZ0+BMgQ+tIdpdRlrsbPwQCuQKGellrNnhs+gCErsgKVCMtdMP1YjphHt107j
         qZMmMSMcgsAMkulTvyK64H8XuVEOfdk+7RHuCHeLF5YvJeZ+yMvIKjIJ5FcRf5qFUN31
         ZGFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=J9N9Y3TTk0oY7Us5Osz7APqG+lo0OhkBPQ1D46Jl8tk=;
        b=beacc1zLe7W7YQXYpBn6XM1fjIEP0/Fo3qb0jou629TYPlBXQmf6lKXf4bcmOuhMPT
         GOOA7xLQk3kPyNYGzKklKQ9JMtnlfn7Ym08pgYZCuu2rrKfVD0B5OgTxXDiFyH14XwvG
         0COdFEnbT/a5zmac/yrXbBIUCKiV2LroLYdB7Z4+BROG6E7VZrympp1Kyhf5gWPCFkr8
         8dMPSUvEoYReCDhk6M7atF265eBy8SaHH2IfTLw1Kc5VPzZ+uMh+vvr7vaJp0ZFZA/HZ
         b1fm9DiQAZKyqXutsV6b08qY7MeALqZVClE0yE4hY7VtBVUt5BgX8bY+BNi6LHRtLWv3
         RakA==
X-Gm-Message-State: AOAM530Q41+KmI8RI2MCj1DvWHeSrgkQztzFqhMt3m3Zu+jHvWgt1X2B
        gC/PP8IJdIK7ursvodeSWPOaquYM7jE=
X-Google-Smtp-Source: ABdhPJz+XJlWDmcxTmlsONY62whCZOVNqjBUAS15h46tStmBXdcbk3dH8IEttMSDMzaABPU8brNGeg==
X-Received: by 2002:a05:600c:3509:: with SMTP id h9mr1063958wmq.81.1626901621969;
        Wed, 21 Jul 2021 14:07:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d18sm22009294wmp.46.2021.07.21.14.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 14:07:01 -0700 (PDT)
Message-Id: <a577ea4c74d86e57defcc4f45011871b634bcf56.1626901619.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.999.git.1626901619.gitgitgadget@gmail.com>
References: <pull.999.git.1626901619.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 21 Jul 2021 21:06:57 +0000
Subject: [PATCH 3/5] pathspec: stop calling ensure_full_index
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

The add_pathspec_matches_against_index() focuses on matching a pathspec
to file entries in the index. This already works correctly for its only
use: checking if untracked files exist in the index.

The compatibility checks in t1092 already test that 'git add <dir>'
works for a directory outside of the sparse cone. That provides coverage
for removing this guard.

This finalizes our ability to run 'git add .' without expanding a sparse
index to a full one. This is evidenced by an update to t1092 and by
these performance numbers for p2000-sparse-operations.sh:

Test                                    HEAD~1            HEAD
--------------------------------------------------------------------------------
2000.10: git add . (full-index-v3)      0.37(0.28+0.07)   0.36(0.27+0.06) -2.7%
2000.11: git add . (full-index-v4)      0.33(0.26+0.06)   0.32(0.28+0.05) -3.0%
2000.12: git add . (sparse-index-v3)    0.57(0.53+0.07)   0.06(0.06+0.07) -89.5%
2000.13: git add . (sparse-index-v4)    0.57(0.53+0.07)   0.05(0.03+0.09) -91.2%

While the ~90% improvement is shown by the test results, it is worth
noting that expanding the sparse index was adding overhead in previous
commits. Comparing to the full index case, we see the performance go
from 0.33s to 0.05s, an 85% improvement.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 pathspec.c                               | 2 --
 t/t1092-sparse-checkout-compatibility.sh | 7 +++----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index 08f8d3eedc3..44306fdaca2 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -37,8 +37,6 @@ void add_pathspec_matches_against_index(const struct pathspec *pathspec,
 			num_unmatched++;
 	if (!num_unmatched)
 		return;
-	/* TODO: audit for interaction with sparse-index. */
-	ensure_full_index(istate);
 	for (i = 0; i < istate->cache_nr; i++) {
 		const struct cache_entry *ce = istate->cache[i];
 		if (sw_action == PS_IGNORE_SKIP_WORKTREE && ce_skip_worktree(ce))
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index a11d9d7f35d..f9e2f5f4aa1 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -322,9 +322,6 @@ test_expect_success 'commit including unstaged changes' '
 test_expect_success 'status/add: outside sparse cone' '
 	init_repos &&
 
-	# adding a "missing" file outside the cone should fail
-	test_sparse_match test_must_fail git add folder1/a &&
-
 	# folder1 is at HEAD, but outside the sparse cone
 	run_on_sparse mkdir folder1 &&
 	cp initial-repo/folder1/a sparse-checkout/folder1/a &&
@@ -633,7 +630,9 @@ test_expect_success 'sparse-index is not expanded' '
 	echo >>sparse-index/README.md &&
 	ensure_not_expanded add -A &&
 	echo >>sparse-index/extra.txt &&
-	ensure_not_expanded add extra.txt
+	ensure_not_expanded add extra.txt &&
+	echo >>sparse-index/untracked.txt &&
+	ensure_not_expanded add .
 '
 
 # NEEDSWORK: a sparse-checkout behaves differently from a full checkout
-- 
gitgitgadget

