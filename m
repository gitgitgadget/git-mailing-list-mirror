Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B117C433F5
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 15:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243088AbiANP7r (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 10:59:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243087AbiANP7q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 10:59:46 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661B5C06161C
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 07:59:46 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id x4so16353389wru.7
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 07:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NeRwnIrSAZpB7sE85vdoEqtErH9y9iBhyVTosP2cxqo=;
        b=W9QKH+UN9kPxkggq+nmzErsR0g8fYy/fBhmkHzoDik6UypJfCUpjbjYcWV6s2cx2xd
         ytdfTUDXsypbCzxZh5e+Rwppg9rdxU1I0ve3XCSSzrCFWEskzFZGZ3IwEX6pio64ScxN
         B43nmUShbzatRzfZfNXfCN3Vj3hSyWKAq/KZvD1O/buxR77XKd4DHrQfg4staucqJYNc
         jjpTUw4XHu3HvT0CONqd53iYR/DGG8hEZ1gnYXa5XXNYr+jXeTRyeVFHBrJZ0HMbQHc4
         TYjM+VPnJ8Hz+Nuwbn2RXGA1hdOsqyw7XGst7eNka/1C6gAzlYzHu9IMPb6jETgZHloC
         1wbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NeRwnIrSAZpB7sE85vdoEqtErH9y9iBhyVTosP2cxqo=;
        b=nLbq9W2u/f791nblQCN3HVvU99ywvOsFcNiVxVVrbu+U+EgA/Hq6gU7LvgpBymc9Ph
         6iezm7w3i+E0B8sK28whxvzNAo/yVK4HkdCbgFwqwYaq4N4vXOv8B/rUYlwQS/aoQHWK
         m2swgvSSfD6C6wntBkWKGjlZVGauL0zFxkA7uwwJJ80lNTwVch+V14bLsL7bJmttWjy0
         VpcRMSMgJ4I/+Sc96Q+7g8Vdl1xDbtaTK87xuBTbpQ1mZI1kNN0Da0v4tulGWqMQ2DHb
         IX+k2cWSmzEeQhPTxByoig0KYFhXFLf9pgsH31rK31jxcCXChlpQs1DFUk3LFONYe2TF
         FgnA==
X-Gm-Message-State: AOAM530OAbSl0Q7Y3HyhFZovXcvuhqyRQQmn6VkGQdH19cmkNvbE4P0g
        7LLeWWaMYoWyEKDnjy1RbzYV5xO5nAQ=
X-Google-Smtp-Source: ABdhPJzASSHy+9A35G92eH9ti/hOLpAEj7WB0bzW/WZgBAziu4m/cp/wDYIExTFlGRU0Gh0m9yEkkQ==
X-Received: by 2002:adf:ce12:: with SMTP id p18mr8919671wrn.225.1642175984730;
        Fri, 14 Jan 2022 07:59:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h5sm5708504wrq.44.2022.01.14.07.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 07:59:44 -0800 (PST)
Message-Id: <pull.1114.v2.git.1642175983.gitgitgadget@gmail.com>
In-Reply-To: <pull.1114.git.1642092230.gitgitgadget@gmail.com>
References: <pull.1114.git.1642092230.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 Jan 2022 15:59:38 +0000
Subject: [PATCH v2 0/5] Remove the present-despite-SKIP_WORKTREE class of bugs (for
 sparse-checkouts)
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>, Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Elijah Newren <newren@gmail.com>,
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
discovery and recovery; as a result, it greatly simplifies the landscape,
reduces our testing matrix burden, and fixes a large swath of bugs. And I
figured out how to get the perf cost down to essentially negligible.

Changes since v1 (or v2 if you count RFC as v1):

 * now includes some fixes for testcases from
   ds/fetch-pull-with-sparse-index (which topic marked its own new tests as
   potentially suboptimal; with my series, the sparse behavior now matches
   the full tree behavior on that test. Wahoo!). Note that Junio's version
   of vd/sparse-clean-etc already includes ds/fetch-pull-with-sparse-index,
   so no need to merge in anything extra.

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
 t/t1092-sparse-checkout-compatibility.sh | 41 ++++++-------
 t/t3705-add-sparse-checkout.sh           |  2 +
 t/t6428-merge-conflicts-sparse.sh        | 23 ++-----
 t/t7012-skip-worktree-writing.sh         | 44 +++-----------
 t/t7817-grep-sparse-checkout.sh          | 11 +++-
 unpack-trees.c                           |  4 +-
 13 files changed, 246 insertions(+), 128 deletions(-)


base-commit: 48609de3bf32befb69c40c1a2595a98dac0448b4
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1114%2Fnewren%2Ffix-present-despite-skip-worktree-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1114/newren/fix-present-despite-skip-worktree-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1114

Range-diff vs v1:

 1:  c553d558c2f = 1:  d50d804af4e t1011: add testcase demonstrating accidental loss of user modifications
 2:  1e3958576e2 = 2:  206c638fa90 unpack-trees: fix accidental loss of user changes
 3:  b263cc75b7d ! 3:  11d46a399d2 repo_read_index: clear SKIP_WORKTREE bit from files present in worktree
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'update-index modi
       
       	# When skip-worktree is disabled (even on files outside sparse cone), file
       	# is updated in the index
     +@@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'ls-files' '
     + 	test_cmp dense sparse &&
     + 
     + 	# Set up a strange condition of having a file edit
     +-	# outside of the sparse-checkout cone. This is just
     +-	# to verify that sparse-checkout and sparse-index
     +-	# behave the same in this case.
     ++	# outside of the sparse-checkout cone. We want to verify
     ++	# that all modes handle this the same, and detect the
     ++	# modification.
     + 	write_script edit-content <<-\EOF &&
     +-	mkdir folder1 &&
     ++	mkdir -p folder1 &&
     + 	echo content >>folder1/a
     + 	EOF
     +-	run_on_sparse ../edit-content &&
     ++	run_on_all ../edit-content &&
     + 
     +-	# ls-files does not currently notice modified files whose
     +-	# cache entries are marked SKIP_WORKTREE. This may change
     +-	# in the future, but here we test that sparse index does
     +-	# not accidentally create a change of behavior.
     +-	test_sparse_match git ls-files --modified &&
     +-	test_must_be_empty sparse-checkout-out &&
     +-	test_must_be_empty sparse-index-out &&
     ++	test_all_match git ls-files --modified &&
     + 
     + 	git -C sparse-index ls-files --sparse --modified >sparse-index-out &&
     +-	test_must_be_empty sparse-index-out &&
     ++	cat >expect <<-\EOF &&
     ++	folder1/a
     ++	EOF
     ++	test_cmp expect sparse-index-out &&
     + 
     + 	# Add folder1 to the sparse-checkout cone and
     + 	# check that ls-files shows the expanded files.
     + 	test_sparse_match git sparse-checkout add folder1 &&
     +-	test_sparse_match git ls-files --modified &&
     ++	test_all_match git ls-files --modified &&
     + 
     + 	test_all_match git ls-files &&
     + 	git -C sparse-index ls-files --sparse >actual &&
      
       ## t/t3705-add-sparse-checkout.sh ##
      @@ t/t3705-add-sparse-checkout.sh: setup_sparse_entry () {
 4:  c74ad19616e = 4:  0af00779128 Update documentation related to sparsity and the skip-worktree bit
 5:  e68028ebe0a = 5:  05ac964e630 Accelerate clear_skip_worktree_from_present_files() by caching

-- 
gitgitgadget
