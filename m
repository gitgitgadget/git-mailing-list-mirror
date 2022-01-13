Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76EBC433EF
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 16:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbiAMQny (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 11:43:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiAMQnx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 11:43:53 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B422C061574
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 08:43:53 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id d18-20020a05600c251200b0034974323cfaso5775672wma.4
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 08:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=hfn9xdPvmy3F8SubHDGjWLDU9ZXzngXNG2rnBgt1odw=;
        b=iGDmsbAhLJxm1xoZ42lHnpBHvulAERW7j0LRnVkTfWDw0d1X8hx7RgZjb4epAxVlrJ
         +c0bRTRQ0y7s8FPGm4dkPVOx5xPC8FxznzP0lZvv4GkmFeiJmh/s0R70Ta0qNzIjXS1W
         2N7VsusjifvERRCcujuceeQsC3jGQYS3yk50+vTsCF8pGZ9maYBXhyX6ozL51qqo06jn
         2V7Y9U84U7+tZnWjk2nJIuTovJNmwI0QE8lmSlMIDk2grgBxrLyS3W2n0y1r16aCEo8T
         BA7JCK9Hd2jYEMxYuVoVrf0Tl1v8eI809ISJAlXbilOR2zrHMb5TO6Sd64vgWrUnLa3h
         i5aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hfn9xdPvmy3F8SubHDGjWLDU9ZXzngXNG2rnBgt1odw=;
        b=tveb4UUx47Wua8Pmzdl0D90nPqsR4XbS9QXKC74hHPAGtXyLP/1KFCf/Z0TPczuK+C
         zBiMlSVrwGUv8BI+Axp78PExBIy8MPpogpmbPlSiqflXpUOqIXS4GTxfy5PGvLayOId1
         5tXQTdz65OoKzR/Ch8+K9tBtGTO2pDg+O1ebg+x1r4k5+hhSVDhMJ8rHDllqlqhg9znK
         nJ2RQ4UjZbFf4BWh2aqZQDGnAKpAei9sVVtTIFtSZMBbT3isOjIut/Vj/yugEi4qqx6b
         6taLMjhdX+nYZh/Q+FdQdwaQxVvB7IjMNnFBpED1B3XnseOC7KFw/VU0d9Zu5OjztGqB
         0T8A==
X-Gm-Message-State: AOAM530EJznSsTOSPJT7qX6zkHFNyZB3ybfYpcJ7HODkNtPTQVwQRaGi
        AyKt0j2dUTI5/6LtIKQLmDtHgTCKTTk=
X-Google-Smtp-Source: ABdhPJyNIqh473YS2lkuJBPUzep+T9h3Cncc1GAIfHaO2dkhJAVK3QCfuZBkeaQHZ5zL93sj2PjE7w==
X-Received: by 2002:a05:600c:2f90:: with SMTP id t16mr11785857wmn.69.1642092231791;
        Thu, 13 Jan 2022 08:43:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g84sm7201465wme.7.2022.01.13.08.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 08:43:51 -0800 (PST)
Message-Id: <pull.1114.git.1642092230.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 13 Jan 2022 16:43:45 +0000
Subject: [PATCH 0/5] Remove the present-despite-SKIP_WORKTREE class of bugs (for
 sparse-checkouts)
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>, Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(Maintainer note: This series builds on (v2 of) vd/sparse-clean-etc, because
it tweaks one of the testcases added there.)

(Note 2: There was a previous RFC round of this series at
https://lore.kernel.org/git/20220109045732.2497526-1-newren@gmail.com/.)

Files in the present-despite-SKIP_WORKTREE state have caused no ends of
discussions and bugs[1,2,3,4,5,6,...and lots of others]. Trying to address
the big issue of discovering & recovering from this state has befuddled me
for over a year because I was worried we'd need additional code at every
skip_worktree-checking path in the code (and they are all over the place),
and that we'd make the code significantly slower unless we plumbed a bunch
of additional information all over the place to allow some reasonable
optimizations.

This series tries to solve the problem a bit differently by automatic early
discovery and recovery; as it result, it greatly simplifies the landscape,
reduces our testing matrix burden, and fixes a large swath of bugs. And I
figured out how to get the perf cost down to essentially negligible.

Changes since RFC version:

 * updated the commit messages as per suggestions from Victoria, including
   adding performance measurements
 * renamed the new function to use a clearer name
 * replaced the final patch with a different optimization, which is both
   simpler and performs quite a bit better (the cost for my previous patch 5
   was already decent in many cases, but had a few cases where the cost was
   significant).

Quick overview:

 * Patches 1 & 2 add a test to demonstrate accidental deletion of
   possibly-modified files, and then fix the bug.
 * Patch 3 is the crux of this series; a small amount of code with a huge
   commit message
 * Patch 4 updates the documentation
 * Patch 5 adds an optimization to reduce the performance impact of patch 3

[1]
https://lore.kernel.org/git/CABPp-BFnFpzwGC11TLoLs8YK5yiisA5D5-fFjXnJsbESVDwZsA@mail.gmail.com/
[2]
https://lore.kernel.org/git/CABPp-BGJ_Nvi5TmgriD9Bh6eNXE2EDq2f8e8QKXAeYG3BxZafA@mail.gmail.com/
[3]
https://lore.kernel.org/git/pull.809.git.git.1592356884310.gitgitgadget@gmail.com/
[4] commit 66b209b ("merge-ort: implement CE_SKIP_WORKTREE handling with
conflicted entries", 2021-03-20) [5] commit ba359fd ("stash: fix stash
application in sparse-checkouts", 2020-12-01) [6]
https://lore.kernel.org/git/CABPp-BH9tju7WVm=QZDOvaMDdZbpNXrVWQdN-jmfN8wC6YVhmw@mail.gmail.com/

Elijah Newren (5):
  t1011: add testcase demonstrating accidental loss of user
    modifications
  unpack-trees: fix accidental loss of user changes
  repo_read_index: clear SKIP_WORKTREE bit from files present in
    worktree
  Update documentation related to sparsity and the skip-worktree bit
  Accelerate clear_skip_worktree_from_present_files() by caching

 Documentation/git-read-tree.txt          | 12 +++-
 Documentation/git-sparse-checkout.txt    | 76 ++++++++++++++----------
 Documentation/git-update-index.txt       | 57 +++++++++++++-----
 repository.c                             |  7 +++
 sparse-index.c                           | 73 +++++++++++++++++++++++
 sparse-index.h                           |  1 +
 t/t1011-read-tree-sparse-checkout.sh     | 23 ++++++-
 t/t1092-sparse-checkout-compatibility.sh | 16 ++---
 t/t3705-add-sparse-checkout.sh           |  2 +
 t/t6428-merge-conflicts-sparse.sh        | 23 ++-----
 t/t7012-skip-worktree-writing.sh         | 44 +++-----------
 t/t7817-grep-sparse-checkout.sh          | 11 +++-
 unpack-trees.c                           |  4 +-
 13 files changed, 235 insertions(+), 114 deletions(-)


base-commit: 80697e9259e4a2c12fd0546f5f1895fb3068a66c
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1114%2Fnewren%2Ffix-present-despite-skip-worktree-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1114/newren/fix-present-despite-skip-worktree-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1114
-- 
gitgitgadget
