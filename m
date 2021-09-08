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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7562DC433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 11:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48CAA61078
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 11:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349172AbhIHLZN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 07:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbhIHLZM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 07:25:12 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6832C061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 04:24:04 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id n14-20020a05600c3b8e00b002f8bd2f8ab6so1288354wms.5
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 04:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Zx7ObIA2wwWuS3JFh/nM0UxpZHuqbGjHvDjytypa6Uc=;
        b=YnP1WZOE154EbISzxty5XEvwFrE5SCTP++AV3SyumjshjN4bcSoQutLwnd3IKf8aDN
         zr3c7HBl25EtnDItXnnuIoH/7fd5FwKiRedepAgCU26h4JB2VeU1/UKLEONZbuW0WDYa
         6/Ad5T3JfEimyHsWAncYvg+uLZfoiOj3TCPBcDcErkqTNCj0PNYmQdltH6bU7a+2rDSh
         1cF7XtdaanNj+ov/idW95EueDvBap5pojPFS901zuQwnU2taIwFD8FQTiy0HVkWNeIvO
         Shy6SVebEMHQe6TBJOXaInbP4vLyzb82c1lLb1vmQTvDo0WNp+eERIfgeKryHkyEQTEm
         p4mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Zx7ObIA2wwWuS3JFh/nM0UxpZHuqbGjHvDjytypa6Uc=;
        b=fLh3jf0xiIiY46SCDSRHsxLcoaPqIWvh9ADyYIA6PIpmRSqfwvci9+RTYf5eSIjxQS
         4a97npVhtmjUsAPdRJeAf+t0R2XVDRBbjj6IbnAOegEErtMh1WtjOkIFra4d4oOxwQcL
         TOFAPvVpK/ixY5rl2tDWe+ULWZNvImpJI85lWRLJyPA4FMmD+FLxwHhB7A+JfrZSO64w
         +PSDRYpoCUfroD2tbNiWu7jV6CBxE4SweVEqOX5M+YJL8guTCAHRUFp6Fsx3BNyleKjW
         Z+uQXsOKYJb5+rRSKny7fX6om91Fhl/9qh/vBrLXM3X8uYRBXauPMEhIWjEHCO7m/bDw
         UXBw==
X-Gm-Message-State: AOAM531ww164MCaAck6mWdjJFqJRrt1nFozabqf3ZhSf9ye6GEs4K+NR
        e7SEz8o90iIYvOJz8Rtt4+5u0g2PVl0=
X-Google-Smtp-Source: ABdhPJyxhGMbqXlrNvk8RH0efdPM/5DHDGIrplcf+pdWLy/iKNZu69pw1R90Y/pORjcXMRTgCk2htA==
X-Received: by 2002:a1c:4e11:: with SMTP id g17mr3062221wmh.130.1631100243193;
        Wed, 08 Sep 2021 04:24:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i5sm1801756wrc.86.2021.09.08.04.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 04:24:02 -0700 (PDT)
Message-Id: <pull.1019.v3.git.1631100241.gitgitgadget@gmail.com>
In-Reply-To: <pull.1019.v2.git.1629841965.gitgitgadget@gmail.com>
References: <pull.1019.v2.git.1629841965.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Sep 2021 11:23:55 +0000
Subject: [PATCH v3 0/6] Sparse Index: Integrate with merge, cherry-pick, rebase, and revert
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


Updates in V3
=============

 * Fixed a typo in patch 2 (it is then moved in patch 3, affecting the
   range-diff)

 * There was a recommendation to use test_config over git config, but that
   is not possible in a subshell. So, it got moved outside of the subshell
   and that works just fine.

 * The other comments were about the use of GIT_TEST_MERGE_ALGORITHM in the
   test script, but the tests that isolate that environment variable are
   only for the 'ensure_not_expanded' tests, not the rest of the tests that
   already exist and are beneficial to cover the 'recursive' mode.


Updates in V2
=============

 * The tests no longer specify GIT_TEST_MERGE_ALGORITHM or directly
   reference "-s ort". By relaxing this condition, I found an issue with
   'git cherry-pick' and 'git rebase' when using the 'recursive' algorithm
   which is fixed in a new patch.

 * Use the pull.twohead config to specify the ORT merge algorithm to avoid
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


base-commit: 91b53f20109fe55635b1815f87afd5d5da68a182
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1019%2Fderrickstolee%2Fsparse-index%2Fmerge-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1019/derrickstolee/sparse-index/merge-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1019

Range-diff vs v2:

 1:  c5ae705648c = 1:  a6963182fe0 diff: ignore sparse paths in diffstat
 2:  bb150483bcf ! 2:  141f7fb26d6 merge: make sparse-aware with ORT
     @@ merge-ort.c: static int record_conflicted_index_entries(struct merge_options *op
       
      +	/*
      +	 * We are in a conflicted state. These conflicts might be inside
     -+	 * sparse-directory entries, so expand the index preemtively.
     ++	 * sparse-directory entries, so expand the index preemptively.
      +	 * Also, we set original_cache_nr below, but that might change if
      +	 * index_name_pos() calls ask for paths within sparse directories.
      +	 */
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse-index is n
      +	ensure_not_expanded add . &&
      +
      +	ensure_not_expanded checkout -f update-deep &&
     ++	test_config -C sparse-index pull.twohead ort &&
      +	(
      +		sane_unset GIT_TEST_MERGE_ALGORITHM &&
     -+		git -C sparse-index config pull.twohead ort &&
      +		ensure_not_expanded merge -m merge update-folder1 &&
      +		ensure_not_expanded merge -m merge update-folder2
      +	)
 3:  815b1b1cfbf ! 3:  c3c9ffd855c merge-ort: expand only for out-of-cone conflicts
     @@ merge-ort.c: static int record_conflicted_index_entries(struct merge_options *op
       
       	/*
       	 * We are in a conflicted state. These conflicts might be inside
     --	 * sparse-directory entries, so expand the index preemtively.
     +-	 * sparse-directory entries, so expand the index preemptively.
      -	 * Also, we set original_cache_nr below, but that might change if
      +	 * sparse-directory entries, so check if any entries are outside
      +	 * of the sparse-checkout cone preemptively.
 4:  8032154bc8a = 4:  7aae5727fb7 t1092: add cherry-pick, rebase tests
 5:  90ac85500b8 = 5:  20f5bbae546 sequencer: ensure full index if not ORT strategy
 6:  df4bbec744f ! 6:  36cecb22330 sparse-index: integrate with cherry-pick and rebase
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'merge with confli
       	init_repos &&
       
      @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse-index is not expanded' '
     + 	test_config -C sparse-index pull.twohead ort &&
       	(
       		sane_unset GIT_TEST_MERGE_ALGORITHM &&
     - 		git -C sparse-index config pull.twohead ort &&
      -		ensure_not_expanded merge -m merge update-folder1 &&
      -		ensure_not_expanded merge -m merge update-folder2
      +		for OPERATION in "merge -m merge" cherry-pick rebase

-- 
gitgitgadget
