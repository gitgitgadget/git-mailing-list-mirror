Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C12ABC4320A
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4AA76138B
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235498AbhHXVx4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 17:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235905AbhHXVxd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 17:53:33 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE671C0613CF
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:52:48 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id j17-20020a05600c1c1100b002e754875260so3221904wms.4
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ADiFOmo2bUf+MXKAE1TCMkgb2iHINOvgP/mleKvpvp0=;
        b=d1gE/jvXMZ3nH6ABv+g6Bb5AqgijNQ3fGDSnD5p6jHbQdIWc+m126dZ7bBpwjSJ646
         VcyaiTv0NjKrbVjtOC6m5KWYxpWlwBzzhXyX0tthwKYAGOYqnWX+H+inm54wAIf4BIIp
         Lp0H3k8r/zMF3bv2+lFOKymSRxKuY1tnLN79JBmW8I0yfjH0v9H35zgzXxO8+Kx7YTAV
         650z9SQXygOgQ1ruyR5e6TgSWi9iow6AFb8ujK26xysw0FOvE0tgwwxOhDIS1EY6c07u
         hPlWwGjGtFBBnZMq2xX8od7HKP/otQgLFguci5V0xSS084HAcg951A7zHq1ZXUi5NjnX
         fdBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ADiFOmo2bUf+MXKAE1TCMkgb2iHINOvgP/mleKvpvp0=;
        b=nv4xcpJC1/rKADEXhPC26j8XKaCwBCSVtqHz3Gfz5hK9c8aZwoTOfkPlpxxeF9Ffqh
         BwhE0db+yMdiesUDHJ4asgzLdzcqkRA+dNAWXRGrSjOl8Ls8jrgFWp2B+/4DgtBx2oGZ
         W30Q149fqicv1Ugd0I1z//YCUzTDPAJqf5rt7ThnrlBArek7UJdz2deIPt5oQY+Um2Fw
         RU4kWuSxzYrUuluZtUMncRD+yBus02aEh3FbepKGcKOjWQfWtMjVJHjbeQv4Bb175ppl
         sOy46FbrdMkw4HgX1g6jRDktvPds6/UNoJfjmrtbUZg8m7sCTL3yajVHovmU/Z7UGQ/k
         JoEw==
X-Gm-Message-State: AOAM5301agYE/d449vOY4x2oxJYwlcVpvrWtpbYLm2282ZnEt4+kG9Fe
        8uqUHs6ZzuJ7GiCdsOL59YSdj3jr/5w=
X-Google-Smtp-Source: ABdhPJypYpiTqS5TgAymAbW/U62sIMGO/2aB+a74yPLb25gnxDPa8c9VgDrG4q9C1PSH/qT7SXYCsA==
X-Received: by 2002:a05:600c:26c4:: with SMTP id 4mr5783022wmv.111.1629841966966;
        Tue, 24 Aug 2021 14:52:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x11sm11816562wro.83.2021.08.24.14.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 14:52:46 -0700 (PDT)
Message-Id: <pull.1019.v2.git.1629841965.gitgitgadget@gmail.com>
In-Reply-To: <pull.1019.git.1629220124.gitgitgadget@gmail.com>
References: <pull.1019.git.1629220124.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 Aug 2021 21:52:39 +0000
Subject: [PATCH v2 0/6] Sparse Index: Integrate with merge, cherry-pick, rebase, and revert
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, stolee@gmail.com, gitster@pobox.com,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series integrates the sparse index with commands that perform merges
such as 'git merge', 'git cherry-pick', 'git revert' (free with
cherry-pick), and 'git rebase'.

When the ORT merge strategy is enabled, this allows most merges to succeed
without expanding the sparse index, leading to significant performance
gains. I tested these changes against an internal monorepo with over 2
million paths at HEAD but with a sparse-checkout that only has ~60,000 files
within the sparse-checkout cone. 'git merge' commands went from 5-6 seconds
to 0.750-1.250s.

In the case of the recursive merge strategy, the sparse index is expanded
before the recursive algorithm proceeds. We expect that this is as good as
we can get with that strategy. When the strategy shifts to ORT as the
default, then this will not be a problem except for users who decide to
change the behavior.

Most of the hard work was done by previous series, such as
ds/sparse-index-ignored-files (which this series is based on).


Updates in V2
=============

 * The tests no longer specify GIT_TEST_MERGE_ALGORITHM or directly
   reference "-s ort". By relaxing this condition, I found an issue with
   'git cherry-pick' and 'git rebase' when using the 'recursive' algorithm
   which is fixed in a new patch.

 * Use the pul.twohead config to specify the ORT merge algorithm to avoid
   expanding the sparse index when that is what we are testing.

 * Corrected some misstatements in my commit messages.

Thanks, -Stolee

Derrick Stolee (6):
  diff: ignore sparse paths in diffstat
  merge: make sparse-aware with ORT
  merge-ort: expand only for out-of-cone conflicts
  t1092: add cherry-pick, rebase tests
  sequencer: ensure full index if not ORT strategy
  sparse-index: integrate with cherry-pick and rebase

 builtin/merge.c                          |  3 +
 builtin/rebase.c                         |  6 ++
 builtin/revert.c                         |  3 +
 diff.c                                   |  8 +++
 merge-ort.c                              | 15 ++++
 merge-recursive.c                        |  3 +
 sequencer.c                              |  9 +++
 t/t1092-sparse-checkout-compatibility.sh | 92 +++++++++++++++++++++---
 8 files changed, 129 insertions(+), 10 deletions(-)


base-commit: 8d55a6ba2fdf64cee4eb51f3cb6f9808bd0b7505
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1019%2Fderrickstolee%2Fsparse-index%2Fmerge-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1019/derrickstolee/sparse-index/merge-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1019

Range-diff vs v1:

 1:  7cad9eee90b < -:  ----------- t1092: use ORT merge strategy
 2:  9f50f11d394 ! 1:  c5ae705648c diff: ignore sparse paths in diffstat
     @@ Commit message
          diff: ignore sparse paths in diffstat
      
          The diff_populate_filespec() method is used to describe the diff after a
     -    merge operation is complete, especially when a conflict appears. In
     -    order to avoid expanding a sparse index, the reuse_worktree_file() needs
     -    to be adapted to ignore files that are outside of the sparse-checkout
     -    cone. The file names and OIDs used for this check come from the merged
     -    tree in the case of the ORT strategy, not the index, hence the ability
     -    to look into these paths without having already expanded the index.
     +    merge operation is complete. In order to avoid expanding a sparse index,
     +    the reuse_worktree_file() needs to be adapted to ignore files that are
     +    outside of the sparse-checkout cone. The file names and OIDs used for
     +    this check come from the merged tree in the case of the ORT strategy,
     +    not the index, hence the ability to look into these paths without having
     +    already expanded the index.
     +
     +    The work done by reuse_worktree_file() is only an optimization, and
     +    requires the file being on disk for it to be of any value. Thus, it is
     +    safe to exit the method early if we do not expect the file on disk.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
     @@ diff.c
       #ifdef NO_FAST_WORKING_DIRECTORY
       #define FAST_WORKING_DIRECTORY 0
      @@ diff.c: static int reuse_worktree_file(struct index_state *istate,
     - 	if (!FAST_WORKING_DIRECTORY && !want_file && has_object_pack(oid))
     + 	if (!want_file && would_convert_to_git(istate, name))
       		return 0;
       
      +	/*
     @@ diff.c: static int reuse_worktree_file(struct index_state *istate,
      +	if (!path_in_sparse_checkout(name, istate))
      +		return 0;
      +
     - 	/*
     - 	 * Similarly, if we'd have to convert the file contents anyway, that
     - 	 * makes the optimization not worthwhile.
     + 	len = strlen(name);
     + 	pos = index_name_pos(istate, name, len);
     + 	if (pos < 0)
 3:  4c1104a0dd3 ! 2:  bb150483bcf merge: make sparse-aware with ORT
     @@ Commit message
             method. We expect sparse-index users to also have the 'ort' strategy
             enabled.
      
     -    2. If the merge results in a conflicted file, then we expand the index
     -       before updating the working tree. The loop that iterates over the
     -       worktree replaces index entries and tracks 'origintal_cache_nr' which
     -       can become completely wrong if the index expands in the middle of the
     -       operation. This safety valve is important before that loop starts. A
     -       later change will focus this to only expand if we indeed have a
     -       conflict outside of the sparse-checkout cone.
     +    2. With the 'ort' strategy, if the merge results in a conflicted file,
     +       then we expand the index before updating the working tree. The loop
     +       that iterates over the worktree replaces index entries and tracks
     +       'origintal_cache_nr' which can become completely wrong if the index
     +       expands in the middle of the operation. This safety valve is
     +       important before that loop starts. A later change will focus this
     +       to only expand if we indeed have a conflict outside of the
     +       sparse-checkout cone.
     +
     +    3. Other merge strategies are executed as a 'git merge-X' subcommand,
     +       and those strategies are currently protected with the
     +       'command_requires_full_index' guard.
      
          Some test updates are required, including a mistaken 'git checkout -b'
          that did not specify the base branch, causing merges to be fast-forward
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse-index is n
      +	ensure_not_expanded add . &&
      +
      +	ensure_not_expanded checkout -f update-deep &&
     -+	ensure_not_expanded merge -s ort -m merge update-folder1 &&
     -+	ensure_not_expanded merge -s ort -m merge update-folder2
     ++	(
     ++		sane_unset GIT_TEST_MERGE_ALGORITHM &&
     ++		git -C sparse-index config pull.twohead ort &&
     ++		ensure_not_expanded merge -m merge update-folder1 &&
     ++		ensure_not_expanded merge -m merge update-folder2
     ++	)
       '
       
       # NEEDSWORK: a sparse-checkout behaves differently from a full checkout
 4:  e47b15554e3 ! 3:  815b1b1cfbf merge-ort: expand only for out-of-cone conflicts
     @@ Commit message
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## merge-ort.c ##
     -@@
     - #include "tree.h"
     - #include "unpack-trees.h"
     - #include "xdiff-interface.h"
     -+#include "dir.h"
     - 
     - /*
     -  * We have many arrays of size 3.  Whenever we have such an array, the
      @@ merge-ort.c: static int record_conflicted_index_entries(struct merge_options *opt)
       
       	/*
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse-index is e
      +	if test "$1" = "!"
      +	then
      +		shift &&
     -+		(
     -+			GIT_TRACE2_EVENT="$(pwd)/trace2.txt" &&
     -+			GIT_TRACE2_EVENT_NESTING=10 &&
     -+			export GIT_TRACE2_EVENT &&
     -+			export GIT_TRACE2_EVENT_NESTING &&
     -+			test_must_fail git -C sparse-index "$@" || return 1
     -+		)
     ++		test_must_fail env \
     ++			GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
     ++			git -C sparse-index "$@" || return 1
      +	else
      +		GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
      +			git -C sparse-index "$@" || return 1
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse-index is e
       }
       
      @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse-index is not expanded' '
     - 	ensure_not_expanded merge -s ort -m merge update-folder2
     + 	)
       '
       
      +test_expect_success 'sparse-index is not expanded: merge conflict in cone' '
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse-index is n
      +		git -C sparse-index commit -a -m "$side" || return 1
      +	done &&
      +
     -+	ensure_not_expanded ! merge -m merged expand-right
     ++	(
     ++		sane_unset GIT_TEST_MERGE_ALGORITHM &&
     ++		git -C sparse-index config pull.twohead ort &&
     ++		ensure_not_expanded ! merge -m merged expand-right
     ++	)
      +'
      +
       # NEEDSWORK: a sparse-checkout behaves differently from a full checkout
 5:  ca23bf38bd9 ! 4:  8032154bc8a t1092: add cherry-pick, rebase tests
     @@ Commit message
          t1092: add cherry-pick, rebase tests
      
          Add tests to check that cherry-pick and rebase behave the same in the
     -    sparse-index case as in the full index cases.
     +    sparse-index case as in the full index cases. These tests are agnostic
     +    to GIT_TEST_MERGE_ALGORITHM, so a full CI test suite will check both the
     +    'ort' and 'recursive' strategies on this test.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'checkout and rese
      -	test_all_match git rev-parse HEAD^{tree} &&
      -	test_all_match git merge -m "folder2" update-folder2 &&
      -	test_all_match git rev-parse HEAD^{tree}
     -+	for OPERATION in "merge -s ort -m merge" cherry-pick rebase
     ++	for OPERATION in "merge -m merge" cherry-pick rebase
      +	do
      +		test_all_match git checkout -B temp update-deep &&
      +		test_all_match git $OPERATION update-folder1 &&
 -:  ----------- > 5:  90ac85500b8 sequencer: ensure full index if not ORT strategy
 6:  350ed86a453 ! 6:  df4bbec744f sparse-index: integrate with cherry-pick and rebase
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'merge with confli
       	init_repos &&
       
      @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse-index is not expanded' '
     - 	echo >>sparse-index/untracked.txt &&
     - 	ensure_not_expanded add . &&
     - 
     --	ensure_not_expanded checkout -f update-deep &&
     --	ensure_not_expanded merge -s ort -m merge update-folder1 &&
     --	ensure_not_expanded merge -s ort -m merge update-folder2
     -+	for OPERATION in "merge -s ort -m merge" cherry-pick rebase
     -+	do
     -+		ensure_not_expanded checkout -f -B temp update-deep &&
     -+		ensure_not_expanded $OPERATION update-folder1 &&
     -+		ensure_not_expanded $OPERATION update-folder2 || return 1
     -+	done
     + 	(
     + 		sane_unset GIT_TEST_MERGE_ALGORITHM &&
     + 		git -C sparse-index config pull.twohead ort &&
     +-		ensure_not_expanded merge -m merge update-folder1 &&
     +-		ensure_not_expanded merge -m merge update-folder2
     ++		for OPERATION in "merge -m merge" cherry-pick rebase
     ++		do
     ++			ensure_not_expanded merge -m merge update-folder1 &&
     ++			ensure_not_expanded merge -m merge update-folder2 || return 1
     ++		done
     + 	)
       '
       
     - test_expect_success 'sparse-index is not expanded: merge conflict in cone' '

-- 
gitgitgadget
