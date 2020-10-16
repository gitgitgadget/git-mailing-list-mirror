Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E18C433E7
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 22:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5A8520874
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 22:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKVwQVVe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391664AbgJPWvB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 18:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391504AbgJPWu6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Oct 2020 18:50:58 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76E4C0613D3
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 15:50:56 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id n15so4845693wrq.2
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 15:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fs6eJKT8HziUOplqM9cyLdODQlNkkoWTwh7v2nGl1B0=;
        b=TKVwQVVe4SAhcZJJdCPXq/vbVk85BcRCV+oHolhlpCtAnqMzuvvDq0KAbu/fnHVQ5v
         k3EIFR0421mRYjYTjh8Dac4z2BhPMoxOVWI8mCGxS5hXTpYYK7cdpBUYUmxgvjprUCsp
         PQVRjLp1Gz/Je+1H5oLNcS17I8vKhjhD620scbeaAgvZ0WyjJdIawH9nWFoL8TCuB9qy
         zwo2/jXyKn2nhneDrbNXUg+bD5OTXuuIW8wKLjLDoopO6xLgUsvFz44fzUfMn8Tb8G9k
         d9OVJH7RM7JoPhuRNuK2gHwaMCU0lrdMyyIl7UNEEPX7+kt2Vj11kJ75gk0hbwBtS1KK
         ezEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fs6eJKT8HziUOplqM9cyLdODQlNkkoWTwh7v2nGl1B0=;
        b=W0UEmPdAO5+zKMygBvfezqbT/D3uAZ+KIDhTU99DGwQjO2pnvJbXBpMcvIBub1uAwH
         rnZg4QCWbPEIoV6Sdv7q7jQbN+zGtfFYjRt2ze6YafAiD6upQzVpIR+Vkz6J/+qf+qbf
         5dyV6StK6D8jH7ChF1/VNabVS12ZaxbedJ+1Ng9L1fVx7ZeG1r7d8FuQLRC7+Xq7lU/7
         KuNMI7nC2YkmRpui53d76CFXF9Sj7+2Pzwckcd+PJ4LD2fSb4O2RJr8letIuVKm63QQE
         rsvAxtjPzkxfsiwntmRwWZerkSLRwjwlLo8LIEM6HqibO4qKxmvX4BRJHGnDdqcTIxs5
         dBew==
X-Gm-Message-State: AOAM531GxEcI/UkSS998/I42cB0Qndtn9waQJA+sOVKLN3Q4LbdIZ/7z
        IwU6spXrHo+PYueN6Iufr7k4n8lXeLI=
X-Google-Smtp-Source: ABdhPJyBwIuSkXfyh62u4KWe76vXFqTN+45DDbveJi6yw67tMTR46cuAu7bJMrrXs5F3zorc7B+j1Q==
X-Received: by 2002:adf:e741:: with SMTP id c1mr6921054wrn.16.1602888654013;
        Fri, 16 Oct 2020 15:50:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q10sm609242wme.2.2020.10.16.15.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 15:50:53 -0700 (PDT)
Message-Id: <pull.878.v5.git.git.1602888652.gitgitgadget@gmail.com>
In-Reply-To: <pull.878.v4.git.git.1602876532.gitgitgadget@gmail.com>
References: <pull.878.v4.git.git.1602876532.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 16 Oct 2020 22:50:49 +0000
Subject: [PATCH v5 0/3] Make test selection easier by specifying description substrings instead of
 just numeric counters
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series enables me to change

 ./t9999-my-test.sh --run=1-3,5,17,19

into

 ./t9999-my-test.sh --run=setup,rename,symlink

and have it pick out tests with "setup", "rename", or "symlink" in their
description and run those. Saves me a lot of time, especially since numbers
for tests aren't readily accessible. The easiest way for me to get the
numbers corresponding to the tests I want to run, is to run all the tests
and look at the output to match up the descriptions with their numbers --
thus defeating the point of selecting just a subset of the tests to run in
the first place.

Changes since v4:

 * Changed to only split tests on commas

Elijah Newren (3):
  test-lib: allow selecting tests by substring/glob with --run
  t6006, t6012: adjust tests to use 'setup' instead of synonyms
  test-lib: reduce verbosity of skipped tests

 t/README                     | 48 ++++++++++++++++++++------------
 t/t0000-basic.sh             | 53 +++++++++++++++++++++---------------
 t/t6006-rev-list-format.sh   |  2 +-
 t/t6012-rev-list-simplify.sh |  2 +-
 t/test-lib.sh                | 19 +++++++------
 5 files changed, 75 insertions(+), 49 deletions(-)


base-commit: d98273ba77e1ab9ec755576bc86c716a97bf59d7
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-878%2Fnewren%2Ftest-selection-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-878/newren/test-selection-v5
Pull-Request: https://github.com/git/git/pull/878

Range-diff vs v4:

 1:  8f5d4ad318 ! 1:  389c2c171a test-lib: allow selecting tests by substring/glob with --run
     @@ t/README: For an individual test suite --run could be used to specify that
      +ends been included.  You may omit the first or the second number to
      +mean "from the first test" or "up to the very last test" respectively.
      +
     -+The argument to --run is split on commas and whitespace into separate
     -+strings, numbers, and ranges, and picks all tests that match any of
     -+the individual selection criteria.  If the substring of the
     -+description text that you want to match includes a comma or space, use
     -+the glob character '?' instead.  For example --run='unnecessary?update
     -+timing' would match on all tests that match either the glob
     -+*unnecessary?update* or the glob *timing*.
     ++The argument to --run is split on commas into separate strings,
     ++numbers, and ranges, and picks all tests that match any of the
     ++individual selection criteria.  If the substring of the description
     ++text that you want to match includes a comma, use the glob character
     ++'?' instead.  For example --run='rebase,merge?cherry-pick' would match
     ++on all tests that match either the glob *rebase* or the glob
     ++*merge?cherry-pick*.
       
       If --run starts with an unprefixed number or range the initial
       set of tests to run is empty. If the first item starts with '!'
     +@@ t/README: all the tests are added to the initial set.  After initial set is
     + determined every test number or range is added or excluded from
     + the set one by one, from left to right.
     + 
     +-Individual numbers or ranges could be separated either by a space
     +-or a comma.
     +-
     + For example, to run only tests up to a specific test (21), one
     + could do this:
     + 
     +@@ t/README: or this:
     + Common case is to run several setup tests (1, 2, 3) and then a
     + specific test (21) that relies on that setup:
     + 
     +-    $ sh ./t9200-git-cvsexport-commit.sh --run='1 2 3 21'
     ++    $ sh ./t9200-git-cvsexport-commit.sh --run='1,2,3,21'
     + 
     + or:
     + 
     +@@ t/README: or:
     + 
     + or:
     + 
     +-    $ sh ./t9200-git-cvsexport-commit.sh --run='-3 21'
     ++    $ sh ./t9200-git-cvsexport-commit.sh --run='-3,21'
     + 
     + As noted above, the test set is built by going through the items
     + from left to right, so this:
     + 
     +-    $ sh ./t9200-git-cvsexport-commit.sh --run='1-4 !3'
     ++    $ sh ./t9200-git-cvsexport-commit.sh --run='1-4,!3'
     + 
     + will run tests 1, 2, and 4.  Items that come later have higher
     + precedence.  It means that this:
     + 
     +-    $ sh ./t9200-git-cvsexport-commit.sh --run='!3 1-4'
     ++    $ sh ./t9200-git-cvsexport-commit.sh --run='!3,1-4'
     + 
     + would just run tests from 1 to 4, including 3.
     + 
      @@ t/README: test in the test suite except from 7 up to 11:
       
           $ sh ./t9200-git-cvsexport-commit.sh --run='!7-11'
     @@ t/README: test in the test suite except from 7 up to 11:
       "setup" test, so you cannot _arbitrarily_ disable one test and
      
       ## t/t0000-basic.sh ##
     +@@ t/t0000-basic.sh: test_expect_success 'GIT_SKIP_TESTS does not skip unmatched suite' "
     + 
     + test_expect_success '--run basic' "
     + 	run_sub_test_lib_test run-basic \
     +-		'--run basic' --run='1 3 5' <<-\\EOF &&
     ++		'--run basic' --run='1,3,5' <<-\\EOF &&
     + 	for i in 1 2 3 4 5 6
     + 	do
     + 		test_expect_success \"passing test #\$i\" 'true'
     +@@ t/t0000-basic.sh: test_expect_success '--run with a range' "
     + 
     + test_expect_success '--run with two ranges' "
     + 	run_sub_test_lib_test run-two-ranges \
     +-		'--run with two ranges' --run='1-2 5-6' <<-\\EOF &&
     ++		'--run with two ranges' --run='1-2,5-6' <<-\\EOF &&
     + 	for i in 1 2 3 4 5 6
     + 	do
     + 		test_expect_success \"passing test #\$i\" 'true'
     +@@ t/t0000-basic.sh: test_expect_success '--run with basic negation' "
     + 
     + test_expect_success '--run with two negations' "
     + 	run_sub_test_lib_test run-two-neg \
     +-		'--run with two negations' --run='"'!3 !6'"' <<-\\EOF &&
     ++		'--run with two negations' --run='"'!3,!6'"' <<-\\EOF &&
     + 	for i in 1 2 3 4 5 6
     + 	do
     + 		test_expect_success \"passing test #\$i\" 'true'
     +@@ t/t0000-basic.sh: test_expect_success '--run with two negations' "
     + 
     + test_expect_success '--run a range and negation' "
     + 	run_sub_test_lib_test run-range-and-neg \
     +-		'--run a range and negation' --run='"'-4 !2'"' <<-\\EOF &&
     ++		'--run a range and negation' --run='"'-4,!2'"' <<-\\EOF &&
     + 	for i in 1 2 3 4 5 6
     + 	do
     + 		test_expect_success \"passing test #\$i\" 'true'
     +@@ t/t0000-basic.sh: test_expect_success '--run range negation' "
     + test_expect_success '--run include, exclude and include' "
     + 	run_sub_test_lib_test run-inc-neg-inc \
     + 		'--run include, exclude and include' \
     +-		--run='"'1-5 !1-3 2'"' <<-\\EOF &&
     ++		--run='"'1-5,!1-3,2'"' <<-\\EOF &&
     + 	for i in 1 2 3 4 5 6
     + 	do
     + 		test_expect_success \"passing test #\$i\" 'true'
     +@@ t/t0000-basic.sh: test_expect_success '--run include, exclude and include, comma separated' "
     + test_expect_success '--run exclude and include' "
     + 	run_sub_test_lib_test run-neg-inc \
     + 		'--run exclude and include' \
     +-		--run='"'!3- 5'"' <<-\\EOF &&
     ++		--run='"'!3-,5'"' <<-\\EOF &&
     + 	for i in 1 2 3 4 5 6
     + 	do
     + 		test_expect_success \"passing test #\$i\" 'true'
      @@ t/t0000-basic.sh: test_expect_success '--run empty selectors' "
       	EOF
       "
     @@ t/test-lib.sh: match_pattern_list () {
       	title="$1"
       	shift
       	arg="$1"
     +@@ t/test-lib.sh: match_test_selector_list () {
     + 
     + 	# Both commas and whitespace are accepted as separators.
     + 	OLDIFS=$IFS
     +-	IFS=' 	,'
     ++	IFS=','
     + 	set -- $1
     + 	IFS=$OLDIFS
     + 
      @@ t/test-lib.sh: match_test_selector_list () {
       			*-*)
       				if expr "z${selector%%-*}" : "z[0-9]*[^0-9]" >/dev/null
 2:  bbae029cc8 = 2:  7c7a3d9a34 t6006, t6012: adjust tests to use 'setup' instead of synonyms
 3:  0e1a1125f7 = 3:  01494bc0ba test-lib: reduce verbosity of skipped tests

-- 
gitgitgadget
