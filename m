Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE29FC636C9
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 20:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A778360FEA
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 20:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbhGTT7b (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 15:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbhGTTeg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 15:34:36 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8379EC061762
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 13:14:43 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id f8-20020a1c1f080000b029022d4c6cfc37so2171063wmf.5
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 13:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LxQkQBRfHZID/NeCkl+5Df7UWdumZc+YV5wyHpznmWU=;
        b=Zai3R6NlfA7EhJh6RzXHk7BXYUtmR/xrxRIr40bIsq6wBxwdl+JBkMrTv5Z9kYxfEb
         ERf/g6c5fWdZDNTIiB6DwA9mm8LS0MWyNoXK97BQ5v3Y4BK0saXAOxzA5ZQWsLEzXLDK
         l71VkEdQrw09e2tkvFID/dJwC0PzrR7uxP82mMXXWc8T+EeVIEciWmy9v5A7lHRXBJEo
         /fxNDy8jCvJiOxVdJ+7pCn7qsUVobnyjxcyrGUmyvaitXwN+90xxbvallzZH+8P46ppH
         n2Hu1pBOc7afi7JTMaAjjs7vh+f3h9F4AjBFfwjhXVx1eqsn6jlCRvYMPUtLtgpOLYvz
         foWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LxQkQBRfHZID/NeCkl+5Df7UWdumZc+YV5wyHpznmWU=;
        b=SvdRZEOB0HBmp/dy17GHKS9BrvtdO8K1v0pB0OJ0i6rCuY/2QUCeKArBh6HpT/T30i
         PsX1wg3dYLcj/NihfU7OiL1AEB1A+OGNLIqEqSztn3SSVFt9SUF8prS2xZKYh3GuvwOb
         F9eyg/XcCJVLzhavIyi/5oByLgzjvCCWfYcoqRSx3O5NSVfze8hrzYsbMBSrD005ATbU
         XV6O9oXha83GVK4DSzYqmZzNiCKidU4TdUbs94cVLdT4kSy7QLgoh3TqqlJRtw4KMdhD
         QM/02A+koYFDmWhvA82VnzuB66VjY9bRPazNdYMYTozqgAtPWpTwk142owjaDY9MjECZ
         xSbw==
X-Gm-Message-State: AOAM5302AgKhGAX5Ov9FJu2qrzzCDWnBhR0xHo9Zzkl0ydWxXoIjeGPj
        OdAVZ/U6MlkGN1nlQhWJNQVKeUYiFXU=
X-Google-Smtp-Source: ABdhPJwyLopcs/hoYKijDoduURmyUO06pJzqGeVSDYlEbu/f70VRkQAnvV4CYcLwXEKlzDKfk8ksmg==
X-Received: by 2002:a05:600c:2319:: with SMTP id 25mr170675wmo.91.1626812082140;
        Tue, 20 Jul 2021 13:14:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o18sm3973976wmh.0.2021.07.20.13.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 13:14:41 -0700 (PDT)
Message-Id: <pull.973.v2.git.1626812081.gitgitgadget@gmail.com>
In-Reply-To: <pull.973.git.1624932786.gitgitgadget@gmail.com>
References: <pull.973.git.1624932786.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Jul 2021 20:14:34 +0000
Subject: [PATCH v2 0/7] Sparse index: integrate with commit and checkout
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, matheus.bernardino@usp.br,
        stolee@gmail.com, Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series extends our integration of sparse-index to 'git commit' and 'git
checkout'.

This is based on ds/status-with-sparse-index (v7) and v2.32.0. The hard work
was already done in that topic, so these changes are simple.

Recall that we have delayed our integration with 'git add' until we can work
out the concerns about how to deal with pathspecs outside of the
sparse-checkout definition. Those concerns might have some overlap with how
'git commit' takes a pathspec, but this seems like a rare enough case to
handle here and we can be more careful with the behavior change in the next
series which will integrate with git add.

In addition to the tests that already exist in t1092, I have integrated
these changes in microsoft/git and tested them against the Scalar functional
tests, which go through quite a few complicated scenarios, verifying that
things work the same across the full index and sparse-index cases.


Update in V2
============

 * There is no change to the code, but it is presented in a slightly
   different order.
 * We've been discussing some complicated directory/file conflict cases, in
   particular with a staged change inside the directory. These tests are
   added and described as documenting incorrect behavior that should be
   changed.
 * After those tests are in place, we can motivate the change to
   twoway_merge() as necessary for a more-common situation (still rare) but
   still incorrect in an already-broken situation. Hopefully that balance is
   sufficient for now, until we can do the bigger work of fixing the bad
   behavior.

Thanks, -Stolee

Derrick Stolee (7):
  p2000: add 'git checkout -' test and decrease depth
  p2000: compress repo names
  commit: integrate with sparse-index
  sparse-index: recompute cache-tree
  checkout: stop expanding sparse indexes
  t1092: document bad 'git checkout' behavior
  unpack-trees: resolve sparse-directory/file conflicts

 builtin/checkout.c                       |   8 +-
 builtin/commit.c                         |   3 +
 cache-tree.c                             |   2 -
 sparse-index.c                           |   2 +
 t/perf/p2000-sparse-operations.sh        |  47 ++++--
 t/t1092-sparse-checkout-compatibility.sh | 197 ++++++++++++++++++++++-
 unpack-trees.c                           |  11 ++
 7 files changed, 240 insertions(+), 30 deletions(-)


base-commit: e5ca291076a8a936283bb2c57433c4393d3f80c2
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-973%2Fderrickstolee%2Fsparse-index%2Fcommit-and-checkout-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-973/derrickstolee/sparse-index/commit-and-checkout-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/973

Range-diff vs v1:

 1:  bb3dd1fdd48 = 1:  6e74958f590 p2000: add 'git checkout -' test and decrease depth
 2:  eb15bf37685 = 2:  3e1d03c41be p2000: compress repo names
 3:  413babe6e77 ! 3:  cd94f820052 commit: integrate with sparse-index
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse-index is e
      +	ensure_not_expanded commit --include deep/deeper1/a -m deeper
       '
       
     - test_expect_success 'reset mixed and checkout orphan' '
     + # NEEDSWORK: a sparse-checkout behaves differently from a full checkout
 4:  ffe8473caab = 4:  65e79b8037c sparse-index: recompute cache-tree
 5:  8710fee36b7 ! 5:  e9a9981477e checkout: stop expanding sparse indexes
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse-index is n
      +	ensure_not_expanded restore -s rename-out-to-out -- deep/deeper1
       '
       
     - test_expect_success 'reset mixed and checkout orphan' '
     + # NEEDSWORK: a sparse-checkout behaves differently from a full checkout
 -:  ----------- > 6:  4b801c854fb t1092: document bad 'git checkout' behavior
 -:  ----------- > 7:  71e301501c8 unpack-trees: resolve sparse-directory/file conflicts

-- 
gitgitgadget
