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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F60C433B4
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 14:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 364E161353
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 14:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237436AbhDMOCx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 10:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237575AbhDMOCI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 10:02:08 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBEFDC06175F
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 07:01:45 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id o20-20020a05600c4fd4b0290114265518afso8804482wmq.4
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 07:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SrgOTEjinxEkmRzJNt4NPuTMuL2Eyhqp5grWczNHIq4=;
        b=Iaj0ZL4pB6nKPiMhftItDUnf6QRPb/SQQDegi9x7SWIis5duukE0do3MG097u27HIT
         2cnR0LtI1CWkHhoqbUtQwVUJNLnswjHpIS0775QiM4S2T40puCpsU1SYGrtvx/EdUkxr
         AA11N7EWD8zqygZeEQNbdc+HN3myUxqlYzqEbjjCrvu4qYI2T6tSIV8NEDWYvvVheq2p
         PDBA0FjxMQWP5NW0SqAHtMiSD6CLj58Tu6a68G/MBtugbURzAN60Hj89vtgcriovgtmX
         +dQTVE1k4XmpmZDJ2LxifE1uNQ5HYvzJh9JW06tAMgMY0bGy83nezfFcmXSrGH7GJIBB
         tcYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SrgOTEjinxEkmRzJNt4NPuTMuL2Eyhqp5grWczNHIq4=;
        b=YDh1trCTbPR+6ScbFv7+/jBdvkJXoWFwdKBR7jq4vXAcG88d4SBmz91O5vOsvCQbxh
         BoiSDN0jZKJeD5TQS4OwpqYrVa70tESPLhqZ5usWS7dyoO6NU69XR2ZnVkDkYys+aNqp
         Ib7jk4+CxwPsAifP4zoIZwrMNV6ZxTzAfhvMO3h83d2XeFF8z4a0Njig1D6iVY1jnuVe
         4EOj2Qnj1P+5SMzXa9P3d4eKTOgDTdcL9mc0ITG/G921rM7A3hdxzcJQO4xeevUtKt1l
         rUvYxx6sV5v44HVDR9HhEazR5BiEIYhn2RxFzZ1v5870IEcI9sSq9jclPWf+GAqXRlEQ
         X7Bw==
X-Gm-Message-State: AOAM532o7Fmw4ItBPhItnVckNHntp8vP+gtSq/oGU7Jvr+mAA7z9cn0l
        iqjgcJ3bez4xPeX1SaOjzPvuZHtFaxY=
X-Google-Smtp-Source: ABdhPJznoy2ISpEUULU+qyRaLoxnzuOq+ddx5JByeOn7dt0nrvwO7ZNqGstx2/hn+QjRVWvWKzN5jw==
X-Received: by 2002:a7b:cf27:: with SMTP id m7mr136509wmg.95.1618322504653;
        Tue, 13 Apr 2021 07:01:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z15sm14034280wrv.39.2021.04.13.07.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 07:01:44 -0700 (PDT)
Message-Id: <6d7f30f2b90ac2151645a29c6a12639074c8f2d3.1618322498.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.git.1618322497.gitgitgadget@gmail.com>
References: <pull.932.git.1618322497.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 13 Apr 2021 14:01:35 +0000
Subject: [PATCH 08/10] pathspec: stop calling ensure_full_index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
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
2000.10: git add . (full-index-v3)      1.37(1.02+0.18)   1.38(1.01+0.20) +0.7%
2000.11: git add . (full-index-v4)      1.26(1.00+0.15)   1.27(0.99+0.17) +0.8%
2000.12: git add . (sparse-index-v3)    2.39(2.29+0.14)   0.06(0.05+0.07) -97.5%
2000.13: git add . (sparse-index-v4)    2.42(2.32+0.14)   0.06(0.05+0.06) -97.5%

While the 97% improvement is shown by the test results, it is worth
noting that expanding the sparse index was adding overhead in previous
commits. Comparing to the full index case, we see the performance go
from 1.27s to 0.06s, a 95% improvement.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 pathspec.c                               | 2 --
 t/t1092-sparse-checkout-compatibility.sh | 6 ++++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index 54813c0c4e8e..b51b48471fe6 100644
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
index c210dba78067..738013b00191 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -471,6 +471,12 @@ test_expect_success 'sparse-index is not expanded' '
 	echo >>sparse-index/extra.txt &&
 	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
 		git -C sparse-index add extra.txt &&
+	test_region ! index ensure_full_index trace2.txt &&
+
+	rm trace2.txt &&
+	echo >>sparse-index/untracked.txt &&
+	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
+		git -C sparse-index add . &&
 	test_region ! index ensure_full_index trace2.txt
 '
 
-- 
gitgitgadget

