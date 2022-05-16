Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B87C433FE
	for <git@archiver.kernel.org>; Mon, 16 May 2022 18:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344494AbiEPSLr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 May 2022 14:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242544AbiEPSLn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 May 2022 14:11:43 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2048B3D492
        for <git@vger.kernel.org>; Mon, 16 May 2022 11:11:37 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id bd25-20020a05600c1f1900b0039485220e16so363234wmb.0
        for <git@vger.kernel.org>; Mon, 16 May 2022 11:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=0Iwctf6yWHFlYfVS0y3XEp3zXjzoA1fatcTP94Ledrk=;
        b=gVeHlFCEoHNyOVAD+bJpDC85CUC8DrZznlAjsQDkX47CvK83jK66Q9GnMAcOvfhGDm
         mmnm3ID+mEyfDu7qWlaoO0X6xTtNMZ0NRMie1EfRppfk/EmLMzUI0Nc8r3B296bFMMls
         wNV6QPbhH18lZwDFFSMKnijSxCantUMTVyf1ZTjsMnEKL4GXMTQmMnjsY81DmdZwK9cP
         nd9tSRbcaZLsYrZQTHoj+V5WlLB5OL6qaAQ/CecAdSUR0+NtbFjSAdLfG010NgBmSJHM
         J6Ouu464bPgCaf+zS7SRregeQx9a3oBpXqcnofcXs5jrt539QOPjkI7UPVvcggV7o0nd
         BfoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0Iwctf6yWHFlYfVS0y3XEp3zXjzoA1fatcTP94Ledrk=;
        b=JKDt29+bMpdgE4XwrDxa1ZVwFo6HCvhp+Z5X+MbcT3Ap6kiSFaQKcG7Hoe/7zXs6rE
         HprvboKTPUVe4OhxHbsPnKXDpWE8WjJ4sTcPyY1zoZmy2SDzSpoP81ne3Y86wPptGgP2
         hgrtfObPc97AMLX7eEsbL0mJ4a/PGZbImF2+Abprv7EXrOq6UdlqLzxVbR58+3HppKaz
         EgQij8Zg6nnGYEM1xHjDQd976ytrm+P/nsbf1FOLymrUuR+dfheQDKSBWGeJT+cLMtFr
         nLLvVj5afJ9VdmiD2PrwHHP5C9f/UVgL/xmL6VkPrHPUGJ6azj2H2kTZ5+Mh+ysHUIUn
         rGdw==
X-Gm-Message-State: AOAM532qXjQt9RPwuWkWZB3HMLVMB4VlsqUNRCJH7dSjSz1fdvEw1DCg
        P6hTQ9+mV7HNFrasBNfv7X3Me/n+zrU=
X-Google-Smtp-Source: ABdhPJzAKUmOL1OpwLygnAGptBtxCX5EwqbSkVynJ2/i90zVgVGDZj7pyDgXdr3oOIqKxOvJlJkcRQ==
X-Received: by 2002:a05:600c:600d:b0:394:5353:507a with SMTP id az13-20020a05600c600d00b003945353507amr18031766wmb.96.1652724695109;
        Mon, 16 May 2022 11:11:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n12-20020adf8b0c000000b0020cdf6ecafbsm12545589wra.81.2022.05.16.11.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 11:11:34 -0700 (PDT)
Message-Id: <pull.1208.git.1652724693.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 16 May 2022 18:11:25 +0000
Subject: [PATCH 0/8] Sparse index: integrate with sparse-checkout
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, vdye@github.com, shaoxuan.yuan02@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is based on ds/sparse-colon-path.

This series integrates the 'git sparse-checkout' builtin with the sparse
index. This is the last integration that we fast-tracked into the
microsoft/git fork. After this, we have no work in flight that would
conflict with a Google Summer of Code project in this area.

The tricky part about the sparse-checkout builtin is that we actually do
need to expand the index when growing the sparse-checkout boundary. The
trick is to expand it only as far as we need it, and then ensure that we
collapse any removed directories before the command completes.

To do this, we introduce a concept of a "partially expanded" index. In fact,
we break the boolean sparse_index member into an enum with three states:

 * COMPLETELY_FULL (0): No sparse directories exist.

 * COMPLETELY_SPARSE (1): Sparse directories may exist. Files outside the
   sparse-checkout cone are reduced to sparse directory entries whenever
   possible.

 * PARTIALLY_SPARSE (2): Sparse directories may exist. Some file entries
   outside the sparse-checkout cone may exist. Running convert_to_sparse()
   may further reduce those files to sparse directory entries.

Most of the patches in this series focus on introducing this enum and
carefully converting previous uses of the boolean to use the enum. Some
additional work is required to refactor ensure_full_index() into a new
expand_to_pattern_list() method, as they are doing essentially the same
thing, but with different scopes.

The result is improved performance on the sparse-checkout builtin as
demonstrated in a new p2000-sparse-operations.sh performance test:


Test HEAD~1 HEAD
================

2000.24: git sparse-checkout ... (sparse-v3) 2.14(1.55+0.58) 1.57(1.03+0.53)
-26.6% 2000.25: git sparse-checkout ... (sparse-v4) 2.20(1.62+0.57)
1.58(0.98+0.59) -28.2%

The improvement here is less dramatic because the operation is dominated by
writing and deleting a lot of files in the worktree. A repeated no-op
operation such as git sparse-checkout set $SPARSE_CONE would show a greater
improvement, but is less interesting since it could gain that improvement
without satisfying the "hard" parts of this builtin.

I specifically chose how to update the tests in t1092 and p2000 to avoid
conflicts with Victoria's 'git stash' work.

Thanks, -Stolee

Derrick Stolee (8):
  sparse-index: create expand_to_pattern_list()
  sparse-index: introduce partially-sparse indexes
  cache-tree: implement cache_tree_find_path()
  sparse-checkout: --no-sparse-index needs a full index
  sparse-index: partially expand directories
  sparse-index: complete partial expansion
  p2000: add test for 'git sparse-checkout [add|set]'
  sparse-checkout: integrate with sparse index

 builtin/sparse-checkout.c                |   8 +-
 cache-tree.c                             |  24 +++++
 cache-tree.h                             |   2 +
 cache.h                                  |  32 ++++--
 read-cache.c                             |   6 +-
 sparse-index.c                           | 126 ++++++++++++++++++++---
 sparse-index.h                           |  14 +++
 t/perf/p2000-sparse-operations.sh        |   1 +
 t/t1092-sparse-checkout-compatibility.sh |  25 +++++
 unpack-trees.c                           |   4 +
 10 files changed, 214 insertions(+), 28 deletions(-)


base-commit: 124b05b23005437fa5fb91863bde2a8f5840e164
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1208%2Fderrickstolee%2Fsparse-index%2Fsparse-checkout-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1208/derrickstolee/sparse-index/sparse-checkout-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1208
-- 
gitgitgadget
