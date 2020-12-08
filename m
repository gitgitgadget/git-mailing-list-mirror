Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D10C433FE
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 22:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDBF722472
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 22:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730590AbgLHWEC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 17:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729455AbgLHWD7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 17:03:59 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8495DC0613D6
        for <git@vger.kernel.org>; Tue,  8 Dec 2020 14:03:13 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id w3so202180otp.13
        for <git@vger.kernel.org>; Tue, 08 Dec 2020 14:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wOfPgTlb7pa69QHxiRbjkFSg0VBvoDvpR5A1tAerswk=;
        b=v7r5bMX2jLqMtC1mV+PwqSyKxtua8ivyvpoUncUgi2APWldU9XcEULTpKfiwPHltBz
         Uu3qAWAnygk57BDy1NCdX/dhcz2OmkhZBSxO9wiohA2J90gaOvfXzfM+4Ftp3bZMqnXK
         e7rlp5/tc37I3Ee9O0KpHDwSTlxOVkL2xu0r69t0p9hMBF/rQ+q5f+nrmIU7dtnwmbd2
         m0MW/m+eC+rKkdlsdVsR/iFgUppbXKFKR9PUHCFR84sp98f5KMA8FnmgSG0rDxfRNnNH
         n0cC8erOVhhmOa7uqm/KPRDegYFXEFvIrM9F2H15i5k1O4j0cwGy/57MBTTeCg94eM3N
         2hiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wOfPgTlb7pa69QHxiRbjkFSg0VBvoDvpR5A1tAerswk=;
        b=A7scZKne3VxGoJHX00h1Gyeq1ksHumSiaIvWPql07RoYUsC1dhuQtb3aoUbkRn33Ja
         6JR+xwDsZ06KhpmdTiUr0ZW1bNPZVYDt39xwkcano5tTq46tT+t/7BpNCtntXlAESGTs
         VrBC185CXX85RzS6UOdsad7SMSoLCM59tKgGIxBXUsNDY5VhTsfGhfnNOMDtAxqSm8/z
         8pzBu2ZR+qvlE28H9jHlsBfWfsjZ7CtDLGEqDAWcf7bcZNoWc6Vx5h6n5NqEB84u+Jgn
         Kl4d5fUgXeS3zWtTrprbQKRiCD64MvjfToESxkxTBh0yR+g+Z7m7obsUrhnN8LnE0RyV
         i+Ww==
X-Gm-Message-State: AOAM530e8AOmUKB2ROrPcrM5GlciNbJP/CGAhbyDi3+RnjmrP+/GJBEc
        FgmFGD6NCqBrLs4CMRzKNZjeuD7P3j7r48LH
X-Google-Smtp-Source: ABdhPJwZHyu5Svc39tiwcC8EqpcWD4ge0ZYDAWFbEFd1kZhVN3fZWOFCOInB9Cbju6bfi68nQJdZuw==
X-Received: by 2002:a05:6830:2371:: with SMTP id r17mr141551oth.236.1607464992282;
        Tue, 08 Dec 2020 14:03:12 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id t24sm67625oou.4.2020.12.08.14.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 14:03:11 -0800 (PST)
Date:   Tue, 8 Dec 2020 17:03:08 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jonathantanmy@google.com, dstolee@microsoft.com,
        gitster@pobox.com
Subject: [PATCH v4 00/24] pack-bitmap: bitmap generation improvements
Message-ID: <cover.1607464775.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1605123652.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's v4 as requested from [1, 2], but I think we can safely call this
"the improved v3", since all we're doing here is removing new instances
of "master" as part of the ongoing default branch transition.

A range-diff that shows this is included below, but it counts v4's 4/24
as a complete replacement of v3's, so careful readers are encouraged to
look at the inter-diff there.

I also snuck a typo-fix into 23/24 (which has existed unnoticed since
v1) changing "rewalk" to "revwalk".

Sorry for all of the shuffling around, hopefully this one should do the
trick.

[1]: https://lore.kernel.org/git/xmqqmtyo6mqi.fsf@gitster.c.googlers.com/
[2]: https://lore.kernel.org/git/pull.809.git.1607260623935.gitgitgadget@gmail.com/

Derrick Stolee (9):
  pack-bitmap-write: fill bitmap with commit history
  bitmap: implement bitmap_is_subset()
  commit: implement commit_list_contains()
  t5310: add branch-based checks
  pack-bitmap-write: rename children to reverse_edges
  pack-bitmap-write: build fewer intermediate bitmaps
  pack-bitmap-write: use existing bitmaps
  pack-bitmap-write: relax unique revwalk condition
  pack-bitmap-write: better reuse bitmaps

Jeff King (11):
  pack-bitmap: fix header size check
  pack-bitmap: bounds-check size of cache extension
  t5310: drop size of truncated ewah bitmap
  rev-list: die when --test-bitmap detects a mismatch
  ewah: factor out bitmap growth
  ewah: make bitmap growth less aggressive
  ewah: implement bitmap_or()
  ewah: add bitmap_dup() function
  pack-bitmap-write: reimplement bitmap writing
  pack-bitmap-write: pass ownership of intermediate bitmaps
  pack-bitmap-write: ignore BITMAP_FLAG_REUSE

Taylor Blau (4):
  ewah/ewah_bitmap.c: avoid open-coding ALLOC_GROW()
  pack-bitmap.c: check reads more aggressively when loading
  pack-bitmap: factor out 'bitmap_for_commit()'
  pack-bitmap: factor out 'add_commit_to_bitmap()'

 builtin/pack-objects.c  |   1 -
 commit.c                |  11 +
 commit.h                |   2 +
 ewah/bitmap.c           |  54 ++++-
 ewah/ewah_bitmap.c      |  15 +-
 ewah/ewok.h             |   3 +-
 pack-bitmap-write.c     | 474 ++++++++++++++++++++++++++--------------
 pack-bitmap.c           | 139 ++++++------
 pack-bitmap.h           |   8 +-
 t/t5310-pack-bitmaps.sh | 177 +++++++++++----
 10 files changed, 583 insertions(+), 301 deletions(-)

Range-diff against v3:
 1:  0b25ba4ca7 =  1:  e72f85f82f ewah/ewah_bitmap.c: avoid open-coding ALLOC_GROW()
 2:  b455b248e4 =  2:  b24395e4b0 pack-bitmap: fix header size check
 3:  7322427444 =  3:  97533dba27 pack-bitmap: bounds-check size of cache extension
 4:  055bc1fe66 <  -:  ---------- t5310: drop size of truncated ewah bitmap
 -:  ---------- >  4:  2e7454d7b9 t5310: drop size of truncated ewah bitmap
 5:  c99cacea67 =  5:  3cb4156372 rev-list: die when --test-bitmap detects a mismatch
 6:  b79360383e =  6:  570bf22425 ewah: factor out bitmap growth
 7:  4b56f12932 =  7:  48a1949ee6 ewah: make bitmap growth less aggressive
 8:  34137a7f35 =  8:  04bf0de474 ewah: implement bitmap_or()
 9:  fe89f87716 =  9:  c8bd4ed5fa ewah: add bitmap_dup() function
10:  91cd8b1a49 = 10:  bbeb87a95d pack-bitmap-write: reimplement bitmap writing
11:  64598024ec = 11:  f87c11700b pack-bitmap-write: pass ownership of intermediate bitmaps
12:  93fc437a3c = 12:  c466dda576 pack-bitmap-write: fill bitmap with commit history
13:  0d5213ba44 = 13:  0cfa932b71 bitmap: implement bitmap_is_subset()
14:  72e745fed8 = 14:  033fb2ed55 commit: implement commit_list_contains()
15:  c2cae4a8d0 ! 15:  76071f9f4e t5310: add branch-based checks
    @@ Commit message
         'master' and 'other' branches.

         Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
    +    Helped-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Taylor Blau <me@ttaylorr.com>

      ## t/t5310-pack-bitmaps.sh ##
    @@ t/t5310-pack-bitmaps.sh: test_expect_success 'rev-list --test-bitmap verifies bi

     -	test_expect_success "counting non-linear history ($state)" '
     +	test_expect_success "counting non-linear history ($state, $branch)" '
    - 		git rev-list --count other...master >expect &&
    - 		git rev-list --use-bitmap-index --count other...master >actual &&
    + 		git rev-list --count other...second >expect &&
    + 		git rev-list --use-bitmap-index --count other...second >actual &&
      		test_cmp expect actual
      	'

    @@ t/t5310-pack-bitmaps.sh: test_expect_success 'rev-list --test-bitmap verifies bi
     +rev_list_tests () {
     +	state=$1
     +
    -+	for branch in "master" "other"
    ++	for branch in "second" "other"
     +	do
     +		rev_list_tests_head
     +	done
16:  c0e2b6f5d9 = 16:  d8c6f0f0bc pack-bitmap-write: rename children to reverse_edges
17:  37f9636098 = 17:  2e08243706 pack-bitmap.c: check reads more aggressively when loading
18:  e520c8fdc4 ! 18:  b4c5d2c3df pack-bitmap-write: build fewer intermediate bitmaps
    @@ Commit message

         Helped-by: Jeff King <peff@peff.net>
         Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
    +    Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
         Signed-off-by: Taylor Blau <me@ttaylorr.com>

      ## pack-bitmap-write.c ##
    @@ t/t5310-pack-bitmaps.sh: has_any () {
      test_expect_success 'setup repo with moderate-sized history' '
     -	test_commit_bulk --id=file 100 &&
     +	test_commit_bulk --id=file 10 &&
    + 	git branch -M second &&
      	git checkout -b other HEAD~5 &&
      	test_commit_bulk --id=side 10 &&
     +
    @@ t/t5310-pack-bitmaps.sh: has_any () {
     +	# ambiguous merge-bases
     +
     +	git checkout -b merge-left other~2 &&
    -+	git merge master~2 -m "merge-left" &&
    ++	git merge second~2 -m "merge-left" &&
     +
    -+	git checkout -b merge-right master~1 &&
    ++	git checkout -b merge-right second~1 &&
     +	git merge other~1 -m "merge-right" &&
     +
    -+	git checkout -b octo-master master &&
    -+	git merge merge-left merge-right -m "octopus-master" &&
    ++	git checkout -b octo-second second &&
    ++	git merge merge-left merge-right -m "octopus-second" &&
     +
     +	git checkout -b octo-other other &&
     +	git merge merge-left merge-right -m "octopus-other" &&
    @@ t/t5310-pack-bitmaps.sh: has_any () {
     +	git checkout other &&
     +	git merge octo-other -m "pull octopus" &&
     +
    - 	git checkout master &&
    -+	git merge octo-master -m "pull octopus" &&
    + 	git checkout second &&
    ++	git merge octo-second -m "pull octopus" &&
     +
     +	# Remove these branches so they are not selected
     +	# as bitmap tips
     +	git branch -D merge-left &&
     +	git branch -D merge-right &&
     +	git branch -D octo-other &&
    -+	git branch -D octo-master &&
    ++	git branch -D octo-second &&
     +
     +	# add padding to make these merges less interesting
     +	# and avoid having them selected for bitmaps
     +	test_commit_bulk --id=file 100 &&
     +	git checkout other &&
     +	test_commit_bulk --id=side 100 &&
    -+	git checkout master &&
    ++	git checkout second &&
     +
    - 	bitmaptip=$(git rev-parse master) &&
    + 	bitmaptip=$(git rev-parse second) &&
      	blob=$(echo tagged-blob | git hash-object -w --stdin) &&
      	git tag tagged-blob $blob &&
     @@ t/t5310-pack-bitmaps.sh: test_expect_success 'setup repo with moderate-sized history' '
19:  c3975fcf78 = 19:  d973cf240d pack-bitmap-write: ignore BITMAP_FLAG_REUSE
20:  d5ef2c7f81 = 20:  4d7a4184ac pack-bitmap: factor out 'bitmap_for_commit()'
21:  f0500190f0 = 21:  bd3a16088b pack-bitmap: factor out 'add_commit_to_bitmap()'
22:  c6fde2b0c4 = 22:  e0d989b98f pack-bitmap-write: use existing bitmaps
23:  50d2031deb ! 23:  8f9fdb0f43 pack-bitmap-write: relax unique rewalk condition
    @@ Metadata
     Author: Derrick Stolee <dstolee@microsoft.com>

      ## Commit message ##
    -    pack-bitmap-write: relax unique rewalk condition
    +    pack-bitmap-write: relax unique revwalk condition

         The previous commits improved the bitmap computation process for very
         long, linear histories with many refs by removing quadratic growth in
    @@ Commit message
           this patch |  88.478 |   53.218 |   2.157 |    2.224 |

         Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
    +    Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
         Signed-off-by: Taylor Blau <me@ttaylorr.com>

      ## pack-bitmap-write.c ##
    @@ pack-bitmap-write.c: static void bitmap_builder_init(struct bitmap_builder *bb,


      ## t/t5310-pack-bitmaps.sh ##
    +@@ t/t5310-pack-bitmaps.sh: has_any () {
    + # To ensure the logic for "maximal commits" is exercised, make
    + # the repository a bit more complicated.
    + #
    +-#    other                         master
    ++#    other                         second
    + #      *                             *
    + # (99 commits)                  (99 commits)
    + #      *                             *
    + #      |\                           /|
    +-#      | * octo-other  octo-master * |
    ++#      | * octo-other  octo-second * |
    + #      |/|\_________  ____________/|\|
    + #      | \          \/  __________/  |
    + #      |  | ________/\ /             |
     @@ t/t5310-pack-bitmaps.sh: has_any () {
      #                                   \|
      #                                    * (base)
    @@ t/t5310-pack-bitmaps.sh: has_any () {
     -# for master (bit 0) and other (bit 1), and some flexibility
     -# in the order that merge bases are visited, the bitmasks at
     -# the end should be:
    -+# for master (bit 0) and other (bit 1), the bitmasks at the
    ++# for second (bit 0) and other (bit 1), the bitmasks at the
     +# end should be:
      #
    - #      master: 1       (maximal, selected)
    +-#      master: 1       (maximal, selected)
    ++#      second: 1       (maximal, selected)
      #       other: 01      (maximal, selected)
     -# octo-master: 1
     -#  octo-other: 01
24:  6b9950771e = 24:  720b6e0dc7 pack-bitmap-write: better reuse bitmaps
--
2.29.2.533.g07db1f5344
