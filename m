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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37571C433DB
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 00:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7F9261953
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 00:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbhCTAEA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 20:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhCTAD7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 20:03:59 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CAAC061760
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 17:03:59 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id o16so10757300wrn.0
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 17:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OdzhT1hDoEFc5dxisNMxLTsHFZkjwuEMARXDpX4M+0U=;
        b=ZLLmQPOpWX7ocSdr82UFCzzO4OstLk0xCKAaYzQrMKB4SZUaXl4MBV7KGhNKak31oY
         0e1TV1xIXkf4Nk/qGHhJcp1gQJSnukiycsN9Tgav5JASHpV2yUSX4GkSPpjEibInvGhT
         XrEzBo/H2VEbMBNWaGjgGnGvp4ngF0jAkaE3h0zyun2JSOyXOvifEkb+zo2N/61oqj2X
         RwY1joDMbVbbuk3maTsBJbFI/M76J3gsrQiTM9N1rObopWPU4b3YxGEaZzJVVYTCR+8b
         eABQa9XwevSojexB20DW+FKD1fo0hY2XnICTRpMB6ddxugD1tBmfOh3IzYK9TTM24TV6
         AXrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OdzhT1hDoEFc5dxisNMxLTsHFZkjwuEMARXDpX4M+0U=;
        b=H58+EmPYOSmboI7qG/yGPSJpDwBl3pPN032N/Thi9qf7ehHGA+of4YKRm1Qu0PC27G
         pm76+sGTZF7jPji39CaLCZTkkCDYD26o+P5V7Q8wUzeCKa5mu6+ElJcB/BQR/Rr+z3Lk
         BsPNYwoU+WbwSo6WZUp4AOFvj2iXZJ93CJLVMkBenLdX0n0lvtRAWFnw7qqR5hFcgEGs
         5+eqRpoYJ48zEPvBFyJoZokX0aejKh2Z6fU2/0VYKsrHWXBJvCCtmMDpLXOB1DILYtSt
         VdGyCXtkzJ70ItfA7XJWRscQQNwfZwgK/JhA1Ek4wRWndYxK5PYzLaWdxfU5XwawoCUH
         vw3w==
X-Gm-Message-State: AOAM530szvXUzhMu0fvnTxVCzgrpCdijFdgHJiIb2SlCMJfCLPIcn/Pt
        BcYcURmwpLR4Y/qH6PB+jgB7ZZTvBrY=
X-Google-Smtp-Source: ABdhPJzxNojCnFhKEcPD1/9iSXMlXZlchiPWgW5PpX+/z6FwjIH0YEkLCIzgDeZoOrKvAjtcB+YA0g==
X-Received: by 2002:a05:6000:1363:: with SMTP id q3mr6962239wrz.74.1616198637953;
        Fri, 19 Mar 2021 17:03:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a8sm8023699wmm.46.2021.03.19.17.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 17:03:57 -0700 (PDT)
Message-Id: <pull.905.v3.git.1616198636.gitgitgadget@gmail.com>
In-Reply-To: <pull.905.v2.git.1616016485.gitgitgadget@gmail.com>
References: <pull.905.v2.git.1616016485.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 20 Mar 2021 00:03:43 +0000
Subject: [PATCH v3 00/13] Declare merge-ort ready for general usage
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series depends on ort-perf-batch-10[1], and obsoletes the ort-remainder
topic[2] (that hadn't been picked up yet, so hopefully this doesn't cause
any confusion)

With this series, merge-ort is ready for general usage -- it passes all
tests, passes dozens of tests that don't under merge-recursive, and
merge-ort is is already significantly faster than merge-recursive when
rename detection is involved. Users can select merge-ort by (a) passing
-sort to either git merge or git rebase, or (b) by setting pull.twohead=ort
[3], or (c) by setting GIT_TEST_MERGE_ALGORITHM=ort.

Changes since v2:

 * changed the last patch to default testing to ort so people don't have to
   wait until CI for failures (but still keep linux-gcc testing
   merge-recursive so it retains coverage), as suggested by Stolee

[1]
https://lore.kernel.org/git/pull.853.git.1615674128.gitgitgadget@gmail.com/
[2]
https://lore.kernel.org/git/pull.973.v2.git.git.1615271086.gitgitgadget@gmail.com/
[3] See commit 14c4586c2d ("merge,rebase,revert: select ort or recursive by
config or environment", 2020-11-02)

Elijah Newren (13):
  merge-ort: use STABLE_QSORT instead of QSORT where required
  merge-ort: add a special minimal index just for renormalization
  merge-ort: have ll_merge() use a special attr_index for
    renormalization
  merge-ort: let renormalization change modify/delete into clean delete
  merge-ort: support subtree shifting
  t6428: new test for SKIP_WORKTREE handling and conflicts
  merge-ort: implement CE_SKIP_WORKTREE handling with conflicted entries
  t: mark several submodule merging tests as fixed under merge-ort
  merge-ort: write $GIT_DIR/AUTO_MERGE whenever we hit a conflict
  merge-recursive: add a bunch of FIXME comments documenting known bugs
  Revert "merge-ort: ignore the directory rename split conflict for now"
  t6423: mark remaining expected failure under merge-ort as such
  Add testing with merge-ort merge strategy

 branch.c                                      |   1 +
 builtin/rebase.c                              |   1 +
 ci/run-build-and-tests.sh                     |   1 +
 merge-ort.c                                   | 242 ++++++++++++++++--
 merge-recursive.c                             |  37 +++
 path.c                                        |   1 +
 path.h                                        |   2 +
 sequencer.c                                   |   5 +
 t/t3512-cherry-pick-submodule.sh              |   7 +-
 t/t3513-revert-submodule.sh                   |   5 +-
 t/t5572-pull-submodule.sh                     |   7 +-
 t/t6423-merge-rename-directories.sh           |   2 +-
 t/t6428-merge-conflicts-sparse.sh             | 158 ++++++++++++
 t/t6437-submodule-merge.sh                    |   5 +-
 t/t6438-submodule-directory-file-conflicts.sh |   7 +-
 t/test-lib.sh                                 |   2 +
 16 files changed, 445 insertions(+), 38 deletions(-)
 create mode 100755 t/t6428-merge-conflicts-sparse.sh


base-commit: ac0ba91ce275227f5df8f16fb986308ff88b198b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-905%2Fgitgitgadget%2Fort-readiness-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-905/gitgitgadget/ort-readiness-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/905

Range-diff vs v2:

  1:  e223f842748c =  1:  e223f842748c merge-ort: use STABLE_QSORT instead of QSORT where required
  2:  6d34cc466bd5 =  2:  6d34cc466bd5 merge-ort: add a special minimal index just for renormalization
  3:  4ff23d2f52a0 =  3:  4ff23d2f52a0 merge-ort: have ll_merge() use a special attr_index for renormalization
  4:  c1c9605c1932 =  4:  c1c9605c1932 merge-ort: let renormalization change modify/delete into clean delete
  5:  41fffcdd3b78 =  5:  41fffcdd3b78 merge-ort: support subtree shifting
  6:  6aec1f499b80 =  6:  6aec1f499b80 t6428: new test for SKIP_WORKTREE handling and conflicts
  7:  fe3baf696785 =  7:  fe3baf696785 merge-ort: implement CE_SKIP_WORKTREE handling with conflicted entries
  8:  f9325647a9fc =  8:  f9325647a9fc t: mark several submodule merging tests as fixed under merge-ort
  9:  4a79e6134691 =  9:  4a79e6134691 merge-ort: write $GIT_DIR/AUTO_MERGE whenever we hit a conflict
 10:  a37979454069 = 10:  a37979454069 merge-recursive: add a bunch of FIXME comments documenting known bugs
 11:  6bda855f2980 = 11:  6bda855f2980 Revert "merge-ort: ignore the directory rename split conflict for now"
 12:  1c6361c9b88a = 12:  1c6361c9b88a t6423: mark remaining expected failure under merge-ort as such
 13:  d8536f56ab29 <  -:  ------------ Add testing with merge-ort merge strategy
  -:  ------------ > 13:  c2d2a1ccaea7 Add testing with merge-ort merge strategy

-- 
gitgitgadget
