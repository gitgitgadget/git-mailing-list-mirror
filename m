Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5B6C433F5
	for <git@archiver.kernel.org>; Sun,  9 Jan 2022 04:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235162AbiAIE5o (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Jan 2022 23:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235152AbiAIE5n (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jan 2022 23:57:43 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A7DC06173F
        for <git@vger.kernel.org>; Sat,  8 Jan 2022 20:57:43 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id q3so10722644qvc.7
        for <git@vger.kernel.org>; Sat, 08 Jan 2022 20:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WJ+lcat7TdJzrA+uVDs/kXLpPycO2X/9dQuKXHABiCA=;
        b=ZnYpzdaCSyhC0iODM2wmV6XZwcGaR0YO06cKddSYwS9L2Ye/NJFIRb1fAEuFmkzS13
         xk7AV04O7+ChmSmB0/uKOrd9hLTMEzhHwPYymM76WOxmrUheAK3/bfvl1c9Ah9TfVKSk
         iArvwRUu7hGy6KDsQGj+xM6YqVkICxG0EeRZLzcie8l7b42CgvYUA5Fs5v9l/W6I7Nt8
         QYqK9JCZVAOyq7U5qAKy30YN7GeWUVjm+lN/ZP9l4JDbMTFhr8Rjqed9p51xJRGBm5CK
         krXuclyETtz8LOo/AXRDO21djrKeH954sbV+PhAMe5JzizxYZr6p//CC10pdSRDZR3Z+
         WyCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WJ+lcat7TdJzrA+uVDs/kXLpPycO2X/9dQuKXHABiCA=;
        b=devUEcqFBUkiMqnSnlCZo2b9gqHvFO6kpe+p8MlXxQlck7NF3/tTdndZrzj/pxidbN
         Igd7os409Xtuq8Qea2E4ZXztibGeU0z4UJIHk/bzY4ghp1+uYYCbfMD/ejSqfO+r+Xoc
         iBCC25V75r2R8aPWyCHcKzvQUk2zH+PskyNa9JWbgy4UQ12UCLHYRrAL1bL6dgGC6weR
         GHt/jXAwcMTxR6CjSqupvlx9flFYH1CJDPPRFoCEodhwdBRGcApMnA4EajcpwMGL+lae
         NAcntyUAiZWBtUpTWuo/VAx4g7qyi2EDPBVdsqmX3+LDYb7SF2eRmm/HRnDQlq8ST+zs
         YoFw==
X-Gm-Message-State: AOAM531v7E4EkZ+w15Nwfw9ZJmpbll4nznyzn/q2+U+aLxMD6Li9n9k1
        hAdMDdM5vI+pLWOY5SrkkoNr3rXn3DIZWQ==
X-Google-Smtp-Source: ABdhPJzd1/jz6nYtaFJwQBquAMGhvIgbsVo1z4Ro+9cfiAfB0lVtqVeOg4uuSqhkw9YII7gmwHznrg==
X-Received: by 2002:a05:6214:27cd:: with SMTP id ge13mr65563526qvb.24.1641704261999;
        Sat, 08 Jan 2022 20:57:41 -0800 (PST)
Received: from iron-rod.attlocal.net ([2600:1700:bae0:2de0::1b])
        by smtp.gmail.com with ESMTPSA id t5sm2118915qtp.60.2022.01.08.20.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 20:57:41 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>, Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 0/5] Remove the present-despite-SKIP_WORKTREE class of bugs
Date:   Sat,  8 Jan 2022 20:57:27 -0800
Message-Id: <20220109045732.2497526-1-newren@gmail.com>
X-Mailer: git-send-email 2.34.1.442.ge63c19bdd2.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(Maintainer note: This series builds on vd/sparse-clean-etc, because it
tweaks one of the testcases added there.)

Files in the present-despite-SKIP_WORKTREE state have caused no ends of
discussions and bugs[1,2,3,4,5,6,...and lots of others].  Trying to
address the big issue of discovering & recovering from this state has
befuddled me for over a year because I was worried we'd need additional
code at every skip_worktree-checking path in the code (and they are all
over the place), and that we'd make the code significantly slower unless
we plumbed a bunch of additional information all over the place to allow
some reasonable optimizations.

This series tries to solve the problem a bit differently by automatic
early discovery and recovery; as it result, it greatly simplifies the
landscape, reduces our testing matrix burden, and fixes a large swath of
bugs.  It does have a cost, though.  See the commit message of patch 3
(the crux of this series) for the details.

Quick overview:

  * Patches 1 & 2 add a test to demonstrate accidental deletion of
    possibly-modified files, and then fix the bug.
  * Patch 3 is the crux of this series; a small amount of code with a
    huge commit message
  * Patch 4 updates the documentation
  * Patch 5 adds some optimizations to reduce the performance impact of
    patch 3

[1] https://lore.kernel.org/git/CABPp-BFnFpzwGC11TLoLs8YK5yiisA5D5-fFjXnJsbESVDwZsA@mail.gmail.com/
[2] https://lore.kernel.org/git/CABPp-BGJ_Nvi5TmgriD9Bh6eNXE2EDq2f8e8QKXAeYG3BxZafA@mail.gmail.com/
[3] https://lore.kernel.org/git/pull.809.git.git.1592356884310.gitgitgadget@gmail.com/
[4] commit 66b209b86a ("merge-ort: implement CE_SKIP_WORKTREE handling with conflicted entries", 2021-03-20)
[5] commit ba359fd507 ("stash: fix stash application in sparse-checkouts", 2020-12-01)
[6] https://lore.kernel.org/git/CABPp-BH9tju7WVm=QZDOvaMDdZbpNXrVWQdN-jmfN8wC6YVhmw@mail.gmail.com/

[Final note: This series and test results can also be seen at
https://github.com/gitgitgadget/git/pull/1113; gitgitgadget wanted me to
"rewrap" the lines with >80 character URLS in commit messages, and I
refuse to remove the URLs or break them by inserting newlines, so I'm
sending it manually instead.]

Elijah Newren (5):
  t1011: add testcase demonstrating accidental loss of user
    modifications
  unpack-trees: fix accidental loss of user changes
  repo_read_index: ensure SKIP_WORKTREE means skip worktree
  Update documentation related to sparsity and the skip-worktree bit
  Accelerate ensure_skip_worktree_means_skip_worktree by caching

 Documentation/git-read-tree.txt          |  12 ++-
 Documentation/git-sparse-checkout.txt    |  76 ++++++++------
 Documentation/git-update-index.txt       |  55 +++++++---
 repository.c                             |   7 ++
 sparse-index.c                           | 123 +++++++++++++++++++++++
 sparse-index.h                           |   1 +
 t/t1011-read-tree-sparse-checkout.sh     |  23 ++++-
 t/t1092-sparse-checkout-compatibility.sh |  16 +--
 t/t3705-add-sparse-checkout.sh           |   2 +
 t/t6428-merge-conflicts-sparse.sh        |  23 +----
 t/t7012-skip-worktree-writing.sh         |  44 ++------
 t/t7817-grep-sparse-checkout.sh          |  11 +-
 unpack-trees.c                           |   4 +-
 13 files changed, 284 insertions(+), 113 deletions(-)

-- 
2.34.1.442.ge63c19bdd2.dirty

