Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E16C25B06
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 20:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234816AbiHDUqO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 16:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiHDUqM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 16:46:12 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3A96D55B
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 13:46:11 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id ay36-20020a05600c1e2400b003a4e30d7995so3057406wmb.5
        for <git@vger.kernel.org>; Thu, 04 Aug 2022 13:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc;
        bh=wzNRlFJu43E6dBPPL5pFcAuvsInAlzWlJvPgmNvPMfo=;
        b=UU+k7I1hG3QGl7Qvd69HAMwA/wBOQ2C4tVvdj7VglZhqFDr4n5pGEdXkYaeJeeek8s
         cpHEUiOQ3MEL7e37+/tbMt/s0PDm/yg2WdkxvPQ/ey84GgNtX1k1CmOn+chhF/DCjWgX
         Mv/R5TRyS4/wGda3MX1sW56LHbBpfdd6sdorAKohRu2l8l78xJ17hNxyxbp5DWqMoLNp
         iEzYdNvRqO4c6GxLNfOCyukX5LL0V2Vqj/v4Gb70YR+Qr84nRqGcyWgUxhRt94OMcJVm
         pefx+RYXIhdcrXv4fGYlNfeyMH96VsDLO+eLAdqYSOZ0HTYX/BkmdG3uT5r4MqWmTete
         AXdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc;
        bh=wzNRlFJu43E6dBPPL5pFcAuvsInAlzWlJvPgmNvPMfo=;
        b=VVfID+hjPJqjZ1jZeoXCtai8Can+qEtdgSJSACrLtpEtvkXbZ3L8BYIcemkXnwQG7f
         H/Wu9Jz6mej/0Q3IYGsu3+lTvkioeN4EI0WFUGNx0dNCHrx5b7LGCnpg1xQM3i+EQA6m
         qMzeFLPnkMe4YtWgUGe2IITcJZ/Wkf2svDKpwHqhFvuMXMF0Mixo7NDReDGs98hGcagd
         l3P5NUVqjS5vFcqns/DKUiuBQOTRb63XqGiPuF1wThskoU5cW/kxFgSEfJW+xHeHLN2A
         gx5o6CEbXbcfOtqEw9F6DeG0c5WN6YvBybaZiHsZBQUP+qHs4B8h+IDonXAHjWbxbnDb
         Q4lA==
X-Gm-Message-State: ACgBeo3XDU4u9hXRIVRtKOp/APFzGD6UGmFT+YPHOPHaZpp3FKiOqhAF
        xsSVl+MwiWV+3/UWjl95HIJ/mc2u7nI=
X-Google-Smtp-Source: AA6agR7t5V6evbbmV5DUUaP9rz110fbKZmMCcTaSfkLXvIQIJ7qPKGJAHuTatA8ud9IJQkykGrQNUg==
X-Received: by 2002:a05:600c:a184:b0:3a3:e5c3:e5c2 with SMTP id id4-20020a05600ca18400b003a3e5c3e5c2mr7277999wmb.130.1659645969133;
        Thu, 04 Aug 2022 13:46:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e16-20020a5d65d0000000b0021b970a68f9sm2150212wrw.26.2022.08.04.13.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 13:46:08 -0700 (PDT)
Message-Id: <pull.1312.git.1659645967.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 04 Aug 2022 20:46:03 +0000
Subject: [PATCH 0/4] reset/checkout: fix miscellaneous sparse index bugs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, shaoxuan.yuan02@gmail.com,
        newren@gmail.com, gitster@pobox.com, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While working on sparse index integration for 'git rm' [1], Shaoxuan found
that removed sparse directories, when reset, would no longer be sparse. This
was due to how 'unpack_trees()' determined whether a traversed directory was
a sparse directory or not; it would only unpack an entry as a sparse
directory if it existed in the index. However, if the sparse directory was
removed, it would be treated like a non-sparse directory and its contents
would be individually unpacked.

To avoid this unnecessary traversal and keep the results of 'reset' as
sparse as possible, the decision logic for whether a directory is sparse is
changed to:

 * If the directory is a sparse directory in the index, unpack it.
 * If not, is the directory inside the sparse cone? If so, do not unpack it.
 * If the directory is outside the sparse cone, does it have any child
   entries in the index? If so, do not unpack it.
 * Otherwise, unpack the entry as a sparse directory.

In the process of updating 'reset', a separate issue was found in 'checkout'
where collapsed sparse directories did not have modified contents reported
file-by-file. A similar bug was found with 'status' in 2c521b0e49 (status:
fix nested sparse directory diff in sparse index, 2022-03-01), and
'checkout' was corrected the same way (setting the diff flag 'recursive' to
1).

Thanks!

 * Victoria

[1]
https://lore.kernel.org/git/20220803045118.1243087-1-shaoxuan.yuan02@gmail.com/

Victoria Dye (4):
  checkout: fix nested sparse directory diff in sparse index
  oneway_diff: handle removed sparse directories
  cache.h: replace 'index_entry_exists()' with 'index_name_pos_sparse()'
  unpack-trees: handle missing sparse directories

 builtin/checkout.c                       |  1 +
 cache-tree.c                             |  2 +-
 cache.h                                  | 15 ++--
 diff-lib.c                               |  5 ++
 read-cache.c                             |  4 +-
 t/t1092-sparse-checkout-compatibility.sh | 25 +++++++
 unpack-trees.c                           | 88 +++++++++++++++++++++---
 7 files changed, 119 insertions(+), 21 deletions(-)


base-commit: 4af7188bc97f70277d0f10d56d5373022b1fa385
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1312%2Fvdye%2Freset%2Fhandle-missing-dirs-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1312/vdye/reset/handle-missing-dirs-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1312
-- 
gitgitgadget
