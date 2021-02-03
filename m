Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69262C433DB
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 05:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 245F964F68
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 05:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbhBCFtt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 00:49:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhBCFts (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 00:49:48 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED90C061573
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 21:49:07 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id g10so22793013wrx.1
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 21:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=b5uGhq8qCjQOpAitpv2vBhGiSNKkmV6JsaFnCTYQepM=;
        b=bRlHMtHyZHRuL2KqtJ7kGFF9hUkHdvCsv+e4TWM9k7+bIy1q1XLc+exSw93RYwj2Wd
         EgbWZsvDR1OqIUPwtbfYXsJhvQ83fXMI8H+3w8FY/wqzl68om5ENmeYR2F8wwV/oD+CY
         eFVA9WFMUsolLRRdwRlHDH3QBexJ2vEtqxCochmgpvwd2xNpMrY9aUWFi+t0HrgscTw9
         QCmDkr/JpiXnE6kSwjHtOwhFZVl0Chw3r6ZCCh04fxOWZ+gxRqbLb2P3XbalQurndyDz
         7vI5HQtmsMTuRMcSMdoDkwLBP7sGqOGp6ZxbwDNp3U+xqlDZxQJdXHhUJo6QUKz3HgBq
         Wa3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=b5uGhq8qCjQOpAitpv2vBhGiSNKkmV6JsaFnCTYQepM=;
        b=eBEYQXR/LpimqpDYBiqQ9T/rC/+n7qM3Uqo9djyWYWb8K0qtoHlwW3+PqJDisISmwl
         6QueK7qCoeYYjCndWjZEDVtjqfjb/ujejIJXNkoFhwLJ9r9T1/0CWAS1zVSommN0Gz1W
         qdVxy7diatG6y/ciOSr5ytHKMe6uSZVE8hdQBlHVw5uxNCXgKrGOqZNM9lA61+XFTbk9
         h95HciP/GPTWFe79TyTv/9DF5uK82+6XbF6ztQLRVOZNqf1Awxp4cFAzGb4A2leKTu2E
         oKZuXJGqV1tFbv/bzyhbQbN1jft6ql7LVCI63h8mydSjnDqqLkfdAWqgsD6mBc8bHsVB
         WTVQ==
X-Gm-Message-State: AOAM530U3aOmy3m/izvvi2GGXjB9S9Vmjm7iQQmFoCxB8MavNrtYkkVh
        2FUFK875qyZS3QXdvvuepMc3cPQZLyY=
X-Google-Smtp-Source: ABdhPJyrm63O3OHqhpM/xsINdQntrAD3Ch+Pwx3i3rIL7ltZbGwKvJaWEvJzCWvoYBUeHsilRjt+lA==
X-Received: by 2002:a05:6000:18a3:: with SMTP id b3mr1460447wri.373.1612331346511;
        Tue, 02 Feb 2021 21:49:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z4sm1592605wrw.38.2021.02.02.21.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 21:49:06 -0800 (PST)
Message-Id: <pull.842.git.1612331345.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 03 Feb 2021 05:49:03 +0000
Subject: [PATCH 0/2] Optimization batch 6: make full use of exact renames
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Karsten Blees <blees@dcon.de>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series depends on en/merge-ort-perf.

For the very curious who are wondering about the first five optimization
batches; see the end of this email.

This series makes full use of exact renames; see commit messages for
details. It represents "Optimization #1" from my Git Merge 2020 talk[1]. For
the testcases mentioned in commit 557ac0350d ("merge-ort: begin performance
work; instrument with trace2_region_* calls", 2020-10-28), the changes in
just this series improves the performance as follows:

                     Before Series           After Series
no-renames:       14.263 s ±  0.053 s    13.815 s ±  0.062 s
mega-renames:   5504.231 s ±  5.150 s  1799.937 s ±  0.493 s
just-one-mega:   158.534 s ±  0.498 s    51.289 s ±  0.019 s


As a reminder, before any merge-ort/diffcore-rename performance work, the
performance results we started with (as noted in the same commit message)
were:

no-renames-am:      6.940 s ±  0.485 s
no-renames:        18.912 s ±  0.174 s
mega-renames:    5964.031 s ± 10.459 s
just-one-mega:    149.583 s ±  0.751 s


[1]
https://github.com/newren/presentations/blob/pdfs/merge-performance/merge-performance-slides.pdf

=== Previous optimization batches ===

I'm labeling this as the "6th" batch, due to other optimizations submitted
previously, and a number of optimizations baked into the design of
fast-rebase and merge-ort.

 1. Previously submitted hashmap/strmap optimizations 1a) 33f20d8217
    (hashmap: introduce a new hashmap_partial_clear()) 1b) 6ccdfc2a20
    (strmap: enable faster clearing and reusing of strmaps) 1c) a208ec1f0b
    (strmap: enable allocations to come from a mem_pool) 1d) 23a276a9c4
    (strmap: take advantage of FLEXPTR_ALLOC_STR when relevant)

 2. Previously submitted diffcore-rename optimizations 2a) b970b4ef62
    (diffcore-rename: simplify and accelerate register_rename_src()) 2b)
    9db2ac5616 (diffcore-rename: accelerate rename_dst setup) 2c) 350410f6b1
    (diffcore-rename: remove unnecessary duplicate entry checks)

 3. fast-rebase optimizations 3a) Avoid updating working-tree/index with
    every intermediate patch 3b) avoid reading/writing rebase metadata until
    conflict or completion

 4. Small stuff baked into merge-ort design 4a) Using pahole to note I can
    reduce size of merged_info by 8 bytes 4b) Avoid recomparing hashes (due
    to use of match_masks) 4c) Avoid unconditional dropping and re-reading
    of the index 4d) avoid checking index matches HEAD with every patch; do
    it at start only

 5. Big stuff baked into merge-ort design 5a) Avoid quadratic behavior with
    O(N) insertions/removals of index entries 5b) Avoid numerous expensive
    mini-tree traversals done by merge-recursive 5c) Avoid recursing into
    trees where both sides match merge base

Elijah Newren (2):
  diffcore-rename: no point trying to find a match better than exact
  diffcore-rename: filter rename_src list when possible

 diffcore-rename.c | 69 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 62 insertions(+), 7 deletions(-)


base-commit: 557ac0350d9efa1f59c708779ca3fb3aee121131
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-842%2Fnewren%2Fort-perf-batch-6-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-842/newren/ort-perf-batch-6-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/842
-- 
gitgitgadget
