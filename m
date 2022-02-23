Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF8EC433EF
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 18:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243835AbiBWSZt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 13:25:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243832AbiBWSZs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 13:25:48 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC04D4A90F
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:25:19 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id l1-20020a7bcf01000000b0037f881182a8so2129025wmg.2
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=wLzvX9zh7lTejm3WeQPLmhIB4JvcEWYj5IaQFBR2Duo=;
        b=H39Nz8GcdUZadpvza0FdIoC+gO22SbP69fnoaMwnxkNeNJmIbGZg5S2S//0nlXl8Si
         3Rrt45nVO5q8GhSFSQbwVXunETsyWOdLDfnt6WCzEGmkrYnAZDIXIfWuaEkjYRpABwzV
         OC361f8lEkhqREdKQPIIxn/GBaNSsN/5vzVDAekw7y2DEnEqi5W2sIjAwqg2+A8EiHcz
         PFN+CrCegsXkPNl5sMgqfmVaASaPGS4s2quiQvrhvffUDQ9SgMrgYxuEUPoPEXQ8CLop
         fmmPB4pJ3ypG19i7tW/sZLVIhBOUHnEfKJPOQq+shYAIDUaOlJSczRGpUa3ZiNyE5MMJ
         eXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wLzvX9zh7lTejm3WeQPLmhIB4JvcEWYj5IaQFBR2Duo=;
        b=KjYGpjjuUv8IgsypsbGEtKPbI9EWXQICMjekeY/z2uI20293nNHUCmsJVR3CEgCaZz
         0CThX90cNQu8MAcepfqUzPzHKh/gpsk0UoHcQhshL9aubC79CAVO0ZPfVdcsmLmXg63p
         OIw0s6ONdNp7fiAKO1vxpxOPX6tmiUM6U2O+l4cvu/bF5HczmnWffqJDDn5GTvLVjh4k
         E6Fxxa7mJ1sdDVGgVSEiGEYw4C3OHaLLVCR1YmimA32MEQrGtgReAEKkEB6hlo2bV70O
         RhPKrfxd7Jnz3Y/FJErwHB+/YG//zGR23t5V0xpv40g7gM45Bgid4vwJEuzFAAhtSs7+
         mrrA==
X-Gm-Message-State: AOAM530+ZxCDTsDEg8fgcxv3AMhywr/co1TzKLmGnCT1B62mOnm2C1vl
        nfrfcNFPBkRjs9pjV20T9S0AafhDHr0=
X-Google-Smtp-Source: ABdhPJyuXrRIwx5xanP8oN9B5Ej10u4XFqCQE2ICrkQIdKOYEJaQf/z3MyywVOAA9MYCj0H9Icu+Bg==
X-Received: by 2002:a1c:7915:0:b0:381:9d:3c6b with SMTP id l21-20020a1c7915000000b00381009d3c6bmr728176wme.163.1645640718379;
        Wed, 23 Feb 2022 10:25:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p17sm270025wrx.23.2022.02.23.10.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 10:25:18 -0800 (PST)
Message-Id: <pull.1157.git.1645640717.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 18:25:09 +0000
Subject: [PATCH 0/7] Sparse index: integrate with 'read-tree'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "mailto:stolee@gmail.com" <[stolee@gmail.com]@vger.kernel.org>,
        "mailto:newren@gmail.com" <[newren@gmail.com]@vger.kernel.org>,
        "mailto:gitster@pobox.com" <[gitster@pobox.com]@vger.kernel.org>,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Like previous integrations [1] [2], this series allows 'git read-tree' to
operate using a sparse index.

The first two patches are bugfixes for issues found while implementing the
'read-tree' integration:

 * The first (patch 1/7) fixes an edge case in which a repo with no in-cone
   files or directories would have its root collapsed into a sparse
   directory; the fix ensures the root directory is never collapsed into a
   sparse directory.
 * The second (patch 2/7) corrects the 'git status' reporting of changes
   nested inside the subdirectory of a sparse directory, ensuring that the
   modified file (not the subdirectory) is correctly reported as having
   changes.

The remainder of the series focuses on utilizing the sparse index in 'git
read-tree'. After some baseline behavior-establishing tests (patch 3/7),
sparse index usage is trivially enabled (patch 4/7) for 'read-tree' except:

 * usage with '--prefix'
 * two- and three-way merge

These cases require additional changes in order to work as expected (i.e.,
outwardly matching non-sparse index sparse-checkout). For the former, the
sparse index can be enabled as long as the index is expanded when the prefix
is a directory outside the sparse cone (patch 5/7). For the latter, sparse
directories that cannot be trivially merged must have their contents merged
file-by-file, done by recursively traversing the trees represented by the
sparse directories (patches 6/7 & 7/7).

Thanks!

 * Victoria

[1]
https://lore.kernel.org/git/pull.1109.v2.git.1641924306.gitgitgadget@gmail.com/
[2]
https://lore.kernel.org/git/pull.1048.v6.git.1638201164.gitgitgadget@gmail.com/

Victoria Dye (7):
  sparse-index: prevent repo root from becoming sparse
  status: fix nested sparse directory diff in sparse index
  read-tree: expand sparse checkout test coverage
  read-tree: integrate with sparse index
  read-tree: narrow scope of index expansion for '--prefix'
  read-tree: make two-way merge sparse-aware
  read-tree: make three-way merge sparse-aware

 builtin/read-tree.c                      |  10 +-
 dir.c                                    |   7 +-
 t/perf/p2000-sparse-operations.sh        |   1 +
 t/t1092-sparse-checkout-compatibility.sh | 129 +++++++++++++++++++++++
 unpack-trees.c                           | 121 ++++++++++++++++++++-
 wt-status.c                              |   9 ++
 6 files changed, 268 insertions(+), 9 deletions(-)


base-commit: e6ebfd0e8cbbd10878070c8a356b5ad1b3ca464e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1157%2Fvdye%2Fsparse%2Fread-tree-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1157/vdye/sparse/read-tree-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1157
-- 
gitgitgadget
