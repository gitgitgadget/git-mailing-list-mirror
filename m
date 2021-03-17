Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE5BC433E0
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 21:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3448664F04
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 21:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbhCQV2X (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 17:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbhCQV2I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 17:28:08 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290C3C06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 14:28:08 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id v11so3306638wro.7
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 14:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TBlYP2CJ6pLRR9Sp4z147sbxYMFo9SmaRYu2J+H/5aw=;
        b=ZkSf04OTdTG74p0MLA1l0kriWXPFJNDKvfS7dTFTJMeBr7duk3A9SCcVrr0oEdpYXw
         APWoL2IpRsCZlfTbTC7s5M5w/kABFgNgphCzDiCEdqRgRKizlqe0MTkDlt7nq5n93Q2F
         0P94oSczeokLTFgxC30Wd3TSEJ9+/cT9yAkXK7r2gO8YPo8ybO22+kl/8pjJ48KEf6Xp
         cYbFhPlT2albwqejUrEKNLRAIYXCanNksLT8J6I8wDs4dkJu1Xsiivxch4wtyIFJkwSW
         uZoiRxuM4NLnJG/xf2anp8j4N2XF4fP+AalTDPi180U5dFd8crzes1JKIs+p+hbY264w
         hsxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TBlYP2CJ6pLRR9Sp4z147sbxYMFo9SmaRYu2J+H/5aw=;
        b=TBwKT20R7yT1mjIIBHqgrxScplo+YAru6XhNAZIL6pf8n0FtaUKrzmlYAT51YD5Cxf
         bkrJ1t4JWYiB0O1Cgq1KGce0yt8pNiv8kPGYZA6ZijEqDS+mMDcXEvYu04rIlzTdMbjW
         JuBvutq+LqVWskwLctnrAZFG9QhSCkx3HNcnk4Afrs61O1rAXoW1LdCm3ZczRH9hLwxN
         vIwRSBJ1T1HiP/NNVFToiA9jQcl5Q252rAOtGzppsm6zBvMTZIRCHC+IrB7PhLiF99oR
         zYDYu5ixZCHf4QyZmClrgse2tid/fXWNGOJ9h+iyTe7B+w68av5Lvi7fDcILtG2Z+6jj
         ZxNg==
X-Gm-Message-State: AOAM530dh5f5KCtOctJrEchbCxc1TgdhL4FJO4GXAenfjy2y6HolFyn8
        pRirnx1uxJk9vyqdSR3M60TiF1iSugY=
X-Google-Smtp-Source: ABdhPJwMBreUIt1xxPe6tyDRKpP5eNFU4xn4zbjqvgVSQ3ECIg6HKjKIFqYFT2/4wz0NctZ3jabvUA==
X-Received: by 2002:a5d:56c9:: with SMTP id m9mr6171630wrw.422.1616016486954;
        Wed, 17 Mar 2021 14:28:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t20sm123260wmi.15.2021.03.17.14.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 14:28:06 -0700 (PDT)
Message-Id: <pull.905.v2.git.1616016485.gitgitgadget@gmail.com>
In-Reply-To: <pull.905.git.1615867503.gitgitgadget@gmail.com>
References: <pull.905.git.1615867503.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 17 Mar 2021 21:27:52 +0000
Subject: [PATCH v2 00/13] Declare merge-ort ready for general usage
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

Changes since v1:

 * subsumed the ort-remainder topic (the first 10 patches), which has
   already been reviewed by both Ævar and Stolee[2].
 * the next two patches were the original v1, reviewed by Stolee
 * the final patch is new and adds testing.

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

 .github/workflows/main.yml                    |   1 +
 branch.c                                      |   1 +
 builtin/rebase.c                              |   1 +
 ci/lib.sh                                     |   6 +
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
 16 files changed, 449 insertions(+), 38 deletions(-)
 create mode 100755 t/t6428-merge-conflicts-sparse.sh


base-commit: ac0ba91ce275227f5df8f16fb986308ff88b198b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-905%2Fgitgitgadget%2Fort-readiness-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-905/gitgitgadget/ort-readiness-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/905

Range-diff vs v1:

  -:  ------------ >  1:  e223f842748c merge-ort: use STABLE_QSORT instead of QSORT where required
  -:  ------------ >  2:  6d34cc466bd5 merge-ort: add a special minimal index just for renormalization
  -:  ------------ >  3:  4ff23d2f52a0 merge-ort: have ll_merge() use a special attr_index for renormalization
  -:  ------------ >  4:  c1c9605c1932 merge-ort: let renormalization change modify/delete into clean delete
  -:  ------------ >  5:  41fffcdd3b78 merge-ort: support subtree shifting
  -:  ------------ >  6:  6aec1f499b80 t6428: new test for SKIP_WORKTREE handling and conflicts
  -:  ------------ >  7:  fe3baf696785 merge-ort: implement CE_SKIP_WORKTREE handling with conflicted entries
  -:  ------------ >  8:  f9325647a9fc t: mark several submodule merging tests as fixed under merge-ort
  -:  ------------ >  9:  4a79e6134691 merge-ort: write $GIT_DIR/AUTO_MERGE whenever we hit a conflict
  -:  ------------ > 10:  a37979454069 merge-recursive: add a bunch of FIXME comments documenting known bugs
  1:  7a8e26638a16 = 11:  6bda855f2980 Revert "merge-ort: ignore the directory rename split conflict for now"
  2:  0d41038fad91 = 12:  1c6361c9b88a t6423: mark remaining expected failure under merge-ort as such
  -:  ------------ > 13:  d8536f56ab29 Add testing with merge-ort merge strategy

-- 
gitgitgadget
