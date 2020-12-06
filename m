Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B608DC433FE
	for <git@archiver.kernel.org>; Sun,  6 Dec 2020 13:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 796252311B
	for <git@archiver.kernel.org>; Sun,  6 Dec 2020 13:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgLFNRr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Dec 2020 08:17:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727395AbgLFNRq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Dec 2020 08:17:46 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EE8C0613D0
        for <git@vger.kernel.org>; Sun,  6 Dec 2020 05:17:06 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id p8so10044670wrx.5
        for <git@vger.kernel.org>; Sun, 06 Dec 2020 05:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=PRU6TKl281LMoYfk/yEQRRK9OaUD9gNB/ucYSBnrdnI=;
        b=DwhJ7ZXsL6sI6NW+BSF4rtttccGp9CzgKFTupw8rqA6ByDyxY3Hde2xEo/39TEmBvS
         z62nkyOhTHdhWqlUr47iOyr0CvBd+lw2rwBZdmL5+hU4dHxAh7mDAqc1NJ9mydYcHMZA
         lLFQaIiwJP7zhvVXIZbK26JXz6yUZA7/hG59sQyHzq6bxiOz4yK2Vpbo73BFcOYOLYNT
         EbotMtn94O/9wsz65Z1eBy3O95FK/UcRRBmt3hgqjRzdQMwHXgBBipc9vTGegeo3klJk
         czeB9Hhqr8R0ip4jeb7lxtAx8aRDsIPGmkeoPbFzqzd0I8t35Fdi86RjF78UG3K/zEPr
         2gQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PRU6TKl281LMoYfk/yEQRRK9OaUD9gNB/ucYSBnrdnI=;
        b=DMApY2teUCp1Nb0v9tqIyd/pRUfKmNRtqv+Zrf9sgWim0ml6ImQj0SpuTI7U83zmmc
         73JJPjYKFRjLCaCiZRIek8F+12cAmPpR4qBQtxZ/6i0hRhW+AIsxi71xHd3EpuyxAsfU
         F34d+85sz7kfA+2fOX0xJ/A/WjQzrxAFzeWOQWZr73k7pSYZL/9ifGkQWD3z5IzTV8Fx
         ac21Vc0Gna5QBTH9+nUpRJKrgydeV8QJsaWu7GIGnB4MaPba1DkEAO68hrY1wYeWJZe0
         L6uKaF8l+f7PhwXoovXziZO3xUvxLLjIPgyCRNtj3+2jBcxbv6Y842scf4zYRKCyHOU+
         EgrA==
X-Gm-Message-State: AOAM533x23U/iltFsqeA/q0H3b4FxzpKsJ/l2naHvgBUpQi47a97hgfO
        bYLZ1MBoz/RDyHzslICIgttNUFZw4MQ=
X-Google-Smtp-Source: ABdhPJwGp1V3ffydfweVQhTqexApFmI/lLZjv1WLPuHQ14o1wHKVYa0SBlQirr6HhbMK9YxaB7sP8Q==
X-Received: by 2002:adf:b64b:: with SMTP id i11mr14527212wre.78.1607260624972;
        Sun, 06 Dec 2020 05:17:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u85sm10647592wmu.43.2020.12.06.05.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Dec 2020 05:17:04 -0800 (PST)
Message-Id: <pull.809.git.1607260623935.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 06 Dec 2020 13:17:03 +0000
Subject: [PATCH] t5310: stop expecting the default branch name `master`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

To open the door for changing the fall-back value for
`init.defaultBranch` when it is not set by the user, we started to
modify the test suite to work with any such fall-back value (instead of
expecting the default branch name to be `master`).

To that end, we specifically rename the initial branch from whatever it
was called to `second` (forcing it, just in case that the hard-coded
fall-back is `second`, in which case the rename is a no-op that would
fail unless forced).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    Adjust t5310 to be independent of the default branch name
    
    Yet another patch making the test suite stop relying on master being the
    default branch name.
    
    This one goes on top of tb/pack-bitmap, and requires an update of
    js/default-branch-name-tests-final-stretch (it no longer needs to
    hard-code GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME in t5310).

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-809%2Fdscho%2Ft5310-and-the-default-branch-name-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-809/dscho/t5310-and-the-default-branch-name-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/809

 t/t5310-pack-bitmaps.sh | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index a83e7a93fbc..55b2cde378b 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -23,12 +23,12 @@ has_any () {
 # To ensure the logic for "maximal commits" is exercised, make
 # the repository a bit more complicated.
 #
-#    other                         master
+#    other                         second
 #      *                             *
 # (99 commits)                  (99 commits)
 #      *                             *
 #      |\                           /|
-#      | * octo-other  octo-master * |
+#      | * octo-other  octo-second * |
 #      |/|\_________  ____________/|\|
 #      | \          \/  __________/  |
 #      |  | ________/\ /             |
@@ -48,10 +48,10 @@ has_any () {
 #
 # The important part for the maximal commit algorithm is how
 # the bitmasks are extended. Assuming starting bit positions
-# for master (bit 0) and other (bit 1), the bitmasks at the
+# for second (bit 0) and other (bit 1), the bitmasks at the
 # end should be:
 #
-#      master: 1       (maximal, selected)
+#      second: 1       (maximal, selected)
 #       other: 01      (maximal, selected)
 #      (base): 11 (maximal)
 #
@@ -64,6 +64,7 @@ has_any () {
 
 test_expect_success 'setup repo with moderate-sized history' '
 	test_commit_bulk --id=file 10 &&
+	git branch -M second &&
 	git checkout -b other HEAD~5 &&
 	test_commit_bulk --id=side 10 &&
 
@@ -71,13 +72,13 @@ test_expect_success 'setup repo with moderate-sized history' '
 	# ambiguous merge-bases
 
 	git checkout -b merge-left other~2 &&
-	git merge master~2 -m "merge-left" &&
+	git merge second~2 -m "merge-left" &&
 
-	git checkout -b merge-right master~1 &&
+	git checkout -b merge-right second~1 &&
 	git merge other~1 -m "merge-right" &&
 
-	git checkout -b octo-master master &&
-	git merge merge-left merge-right -m "octopus-master" &&
+	git checkout -b octo-second second &&
+	git merge merge-left merge-right -m "octopus-second" &&
 
 	git checkout -b octo-other other &&
 	git merge merge-left merge-right -m "octopus-other" &&
@@ -85,24 +86,24 @@ test_expect_success 'setup repo with moderate-sized history' '
 	git checkout other &&
 	git merge octo-other -m "pull octopus" &&
 
-	git checkout master &&
-	git merge octo-master -m "pull octopus" &&
+	git checkout second &&
+	git merge octo-second -m "pull octopus" &&
 
 	# Remove these branches so they are not selected
 	# as bitmap tips
 	git branch -D merge-left &&
 	git branch -D merge-right &&
 	git branch -D octo-other &&
-	git branch -D octo-master &&
+	git branch -D octo-second &&
 
 	# add padding to make these merges less interesting
 	# and avoid having them selected for bitmaps
 	test_commit_bulk --id=file 100 &&
 	git checkout other &&
 	test_commit_bulk --id=side 100 &&
-	git checkout master &&
+	git checkout second &&
 
-	bitmaptip=$(git rev-parse master) &&
+	bitmaptip=$(git rev-parse second) &&
 	blob=$(echo tagged-blob | git hash-object -w --stdin) &&
 	git tag tagged-blob $blob &&
 	git config repack.writebitmaps true
@@ -141,8 +142,8 @@ rev_list_tests_head () {
 	'
 
 	test_expect_success "counting non-linear history ($state, $branch)" '
-		git rev-list --count other...master >expect &&
-		git rev-list --use-bitmap-index --count other...master >actual &&
+		git rev-list --count other...second >expect &&
+		git rev-list --use-bitmap-index --count other...second >actual &&
 		test_cmp expect actual
 	'
 
@@ -179,7 +180,7 @@ rev_list_tests_head () {
 rev_list_tests () {
 	state=$1
 
-	for branch in "master" "other"
+	for branch in "second" "other"
 	do
 		rev_list_tests_head
 	done
@@ -215,7 +216,7 @@ test_expect_success 'setup further non-bitmapped commits' '
 rev_list_tests 'partial bitmap'
 
 test_expect_success 'fetch (partial bitmap)' '
-	git --git-dir=clone.git fetch origin master:master &&
+	git --git-dir=clone.git fetch origin second:second &&
 	git rev-parse HEAD >expect &&
 	git --git-dir=clone.git rev-parse HEAD >actual &&
 	test_cmp expect actual
@@ -317,7 +318,7 @@ test_expect_success 'full repack, reusing previous bitmaps' '
 '
 
 test_expect_success 'fetch (full bitmap)' '
-	git --git-dir=clone.git fetch origin master:master &&
+	git --git-dir=clone.git fetch origin second:second &&
 	git rev-parse HEAD >expect &&
 	git --git-dir=clone.git rev-parse HEAD >actual &&
 	test_cmp expect actual

base-commit: b2555b4647fd66e043db04796670df89156942b6
-- 
gitgitgadget
