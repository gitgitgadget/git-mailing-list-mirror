Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E86C2D0E5
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 19:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C70962076F
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 19:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+SWdkBC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgCYTcF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 15:32:05 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41968 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727281AbgCYTcE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 15:32:04 -0400
Received: by mail-ed1-f68.google.com with SMTP id v1so4047493edq.8
        for <git@vger.kernel.org>; Wed, 25 Mar 2020 12:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=29bpbz6jbmGJk5sGJ+KlihmFRtVXL5aooQnqZ2gwaqc=;
        b=R+SWdkBCl50csGZ3zHerJdTUXqchOENzP7UKo6u4tnHC8p5PK8phhsStJl9IXrQvmW
         dc9Ecz8gOW2c8Oqn1v9otB0cih7h24WFQfEkYr2CAq4ijVtQX9WYtpcv1Brul5gnLiF2
         Xjc120A7BaxwrfenlSukXDaQb+rM8AP4YFhcnXHIaz2WnTp+eu01HS6c0bwoytfWs7Ez
         7jSybSVc4U6SRm71S5UdMVgrMUOHNPzcPncmn/eeFB1d0PBaUBTLxm9SXhbacpuBDLYY
         YMu2s5/dpuL10JQiIAnyS1wXABHBTwk8KngzyRvuFQjiy50tQY1cI5S8MFRl2pYWQza6
         QQXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=29bpbz6jbmGJk5sGJ+KlihmFRtVXL5aooQnqZ2gwaqc=;
        b=TZC7PwcAHo31HaPwPMbOC6Qg6Psx5zHZ0MO1YdWmMtE1us5KPuorFo5/+K0cgiUNNL
         4bPBB5a6R5mAlV0kB7/CadV+KoOhlExTfDy9UU8K+XHaXEf67L56lybSafXr7I2kQUzj
         Xg9eSeN8TqbZzupZKTyiw7wz23byj07A8TtQuoMcHEv3aXeOpwRqD2ShxxLwQj/WtyuK
         dsaHfZy1hYvR1SJyo9M8A6hnmXkZl7mWryjmJIXyKhsEL5NaAGqn8lq2fNIhjaiovf9K
         0LkLNrlR7y82zxswyJoZiY1v2qCqoC6J4LH+1GygJiT/rCK11h7UWLD+JLNCx6xOSSnp
         fNfw==
X-Gm-Message-State: ANhLgQ0KpGyjuGsv9A/dm6MTp8bXtSd0vfI6CQc5cJiQ5CQ8U3ZirvYS
        KejNJLx/ZxLSo2z28WQign9mxF7m
X-Google-Smtp-Source: ADFU+vsKlioJlVwpcYTDLqh2wLOA2rREX4PJhnM+ea8toPP4kbdRSkqxhjLrNURtcQbl5Th34rc1KQ==
X-Received: by 2002:a17:906:4e81:: with SMTP id v1mr4513810eju.259.1585164719245;
        Wed, 25 Mar 2020 12:31:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d34sm1683116edd.41.2020.03.25.12.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 12:31:58 -0700 (PDT)
Message-Id: <pull.700.v3.git.git.1585164718.gitgitgadget@gmail.com>
In-Reply-To: <pull.700.v2.git.git.1580495486.gitgitgadget@gmail.com>
References: <pull.700.v2.git.git.1580495486.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 Mar 2020 19:31:50 +0000
Subject: [PATCH v3 0/7] Avoid multiple recursive calls for same path in read_directory_recursive()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Martin Melka <martin.melka@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
        <pclouds@gmail.com>, Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry for the really long delay on this series; I think I finally figured
out the untracked cache stuff, though it comes with bad news: existing users
of untracked cache are dealing with a buggy implementation that may be
causing git commands that list untracked files to omit expected paths from
the output. This series fixes it, though with a big hammer (partial
disabling of the cache; see the final commit in the series).

Also, as before, this series provides some "modest" speedups (see last
commit message), and should allow 'git status --ignored' to complete in a
more reasonable timeframe for Martin Melka (see 
https://lore.kernel.org/git/CANt4O2L_DZnMqVxZzTBMvr=BTWqB6L0uyORkoN_yMHLmUX7yHw@mail.gmail.com/
).

Changes since v2:

 * Added a patch at the beginning which highlights how the untracked cache
   has been broken from the beginning. Using it will result in other
   commands giving erroneous output. At least, before this series it did.
 * Added another patch at the beginning of the series to fix a simple
   comment typo.
 * Dropped the final patch of the previous series, and instead squashed in a
   fix for the untracked cache problems to what is now the final patch of
   the series. I would have liked to have made that a separate commit
   earlier in the series, but the fix depended on both disabling the
   check_only portion of the cache and the avoid-exponential-visiting. If I
   move the partial disabling earlier, nothing is fixed and stuff is still
   visited. If I move the partial disabling later, then I have to
   temporarily mark lots of extra tests with test_expect_failure. It's only
   three extra one-line changes to dir.c, which you can probably spot in the
   range-diff.

Stuff still missing from v3:

 * I didn't make the DIR_KEEP_UNTRACKED_CONTENTS changes I mentioned in 
   https://lore.kernel.org/git/CABPp-BEQ5s=+6Rnb-A+pdEaoPXxfo-hMSegSe1eai=RE74A3Og@mail.gmail.com/ 
   which I think would make the code cleaner & clearer. I guess I'm leaving
   that for future work.

As per the commit message of the final patch, this series has some risk.
Extra eyes would be greatly appreciated. Also, we should probably merge it
early in some cycle, either this one or a later one.

Derrick Stolee (1):
  dir: refactor treat_directory to clarify control flow

Elijah Newren (6):
  t7063: correct broken test expectation
  dir: fix simple typo in comment
  dir: consolidate treat_path() and treat_one_path()
  dir: fix broken comment
  dir: fix confusion based on variable tense
  dir: replace exponential algorithm with a linear one, fix untracked
    cache

 dir.c                             | 339 +++++++++++++++++-------------
 t/t7063-status-untracked-cache.sh |  79 +++----
 2 files changed, 220 insertions(+), 198 deletions(-)


base-commit: 0cbb60574e741e8255ba457606c4c90898cfc755
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-700%2Fnewren%2Ffill-directory-exponential-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-700/newren/fill-directory-exponential-v3
Pull-Request: https://github.com/git/git/pull/700

Range-diff vs v2:

 6:  9a3f20656e2 ! 1:  d4fe5d33577 t7063: blindly accept diffs
     @@ -1,17 +1,61 @@
      Author: Elijah Newren <newren@gmail.com>
      
     -    t7063: blindly accept diffs
     +    t7063: correct broken test expectation
      
     -    Assuming that the changes I made in the last commit to drastically
     -    modify how and when and especially how frequently untracked paths are
     -    visited should result in changes to the untracked-cache, this commit
     -    simply updates the t7063 testcases to match what the code now reports.
     +    The untracked cache is caching wrong information, resulting in commands
     +    like `git status --porcelain` producing erroneous answers.  The tests in
     +    t7063 actually have a wide enough test to catch a relevant case, in
     +    particular surrounding the directory 'dthree/', but it appears the
     +    answers were not checked quite closely enough and the tests were coded
     +    with the wrong expectation.  Once the wrong info got into the cache in
     +    an early test, since later tests built on it, many others have a wrong
     +    expectation as well.  This affects just over a third of the tests in
     +    t7063.
      
     -    If this is correct, this commit should be squashed into the previous
     -    one.
     +    The error can be seen starting at t7063.12 (the first one switched from
     +    expect_success to expect_failure in this patch).  That test runs in a
     +    directory with the following files present:
     +      done/one
     +      dthree/three
     +      dtwo/two
     +      four
     +      .gitignore
     +      one
     +      three
     +      two
      
     -    It'd be nice if I could get an untracked-cache expert to comment on
     -    this...
     +    Of those files, the following files are tracked:
     +      done/one
     +      one
     +      two
     +
     +    and the contents of .gitignore are:
     +      four
     +
     +    and the contents of .git/info/exclude are:
     +      three
     +
     +    And there is no core.excludesfile.  Therefore, the following should be
     +    untracked:
     +      .gitignore
     +      dthree/
     +      dtwo/
     +    Indeed, these three paths are reported if you run
     +      git ls-files -o --directory --exclude-standard
     +    within this directory.  However, 'git status --porcelain' was reporting
     +    for this test:
     +      A  done/one
     +      A  one
     +      A  two
     +      ?? .gitignore
     +      ?? dtwo/
     +    which was clearly wrong -- dthree/ should also be listed as untracked.
     +    This appears to have been broken since the test was introduced with
     +    commit a3ddcefd97 ("t7063: tests for untracked cache", 2015-03-08).
     +    Correct the test to expect the right output, marking the test as failed
     +    for now.  Make the same change throughout the remainder of the testsuite
     +    to reflect that dthree/ remains an untracked directory throughout and
     +    should be recognized as such.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     @@ -19,50 +63,14 @@
       --- a/t/t7063-status-untracked-cache.sh
       +++ b/t/t7063-status-untracked-cache.sh
      @@
     - three
     - /done/ 0000000000000000000000000000000000000000 recurse valid
     - /dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
     --three
     - /dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
     --two
     - EOF
     - 
     - test_expect_success 'status first time (empty cache)' '
     -@@
     - A  done/one
     - A  one
     - A  two
     --?? dthree/
     --?? dtwo/
     - ?? four
     - ?? three
     - EOF
     -@@
     - exclude_per_dir .gitignore
     - flags 00000006
     - / 0000000000000000000000000000000000000000 recurse valid
     --dthree/
     --dtwo/
     - four
     - three
     - /done/ 0000000000000000000000000000000000000000 recurse valid
     - /dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
     --three
     - /dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
     --two
     - EOF
     - 	test_cmp ../expect ../actual
     - '
     -@@
     - three
     - /done/ 0000000000000000000000000000000000000000 recurse valid
     - /dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
     --three
     - /dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
     --two
     - EOF
       	test_cmp ../expect ../actual
       '
     + 
     +-test_expect_success 'new info/exclude invalidates everything' '
     ++test_expect_failure 'new info/exclude invalidates everything' '
     + 	avoid_racy &&
     + 	echo three >>.git/info/exclude &&
     + 	: >../trace &&
      @@
       A  one
       A  two
     @@ -71,6 +79,15 @@
       ?? dtwo/
       EOF
       	test_cmp ../status.expect ../actual &&
     +@@
     + 	test_cmp ../trace.expect ../trace
     + '
     + 
     +-test_expect_success 'verify untracked cache dump' '
     ++test_expect_failure 'verify untracked cache dump' '
     + 	test-tool dump-untracked-cache >../actual &&
     + 	cat >../expect <<EOF &&
     + info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
      @@
       flags 00000006
       / e6fcc8f2ee31bae321d66afd183fcb7237afae6e recurse valid
     @@ -79,164 +96,246 @@
       dtwo/
       /done/ 0000000000000000000000000000000000000000 recurse valid
       /dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
     - /dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
     --two
     - EOF
     - 	test_cmp ../expect ../actual
     - '
      @@
     - /done/ 0000000000000000000000000000000000000000 recurse valid
     - /dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
     - /dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
     --two
     - EOF
       	test_cmp ../expect ../actual
       '
     + 
     +-test_expect_success 'status after the move' '
     ++test_expect_failure 'status after the move' '
     + 	: >../trace &&
     + 	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
     + 	git status --porcelain >../actual &&
      @@
       A  done/one
       A  one
       ?? .gitignore
     --?? dtwo/
     ++?? dthree/
     + ?? dtwo/
       ?? two
       EOF
     - 	test_cmp ../status.expect ../actual &&
     +@@
     + 	test_cmp ../trace.expect ../trace
     + '
     + 
     +-test_expect_success 'verify untracked cache dump' '
     ++test_expect_failure 'verify untracked cache dump' '
     + 	test-tool dump-untracked-cache >../actual &&
     + 	cat >../expect <<EOF &&
     + info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
      @@
       flags 00000006
       / e6fcc8f2ee31bae321d66afd183fcb7237afae6e recurse valid
       .gitignore
     --dtwo/
     ++dthree/
     + dtwo/
       two
       /done/ 0000000000000000000000000000000000000000 recurse valid
     - /dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
     - /dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
     --two
     - EOF
     - 	test_cmp ../expect ../actual
     - '
      @@
     - /done/ 0000000000000000000000000000000000000000 recurse valid
     - /dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
     - /dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
     --two
     - EOF
       	test_cmp ../expect ../actual
       '
     + 
     +-test_expect_success 'status after the move' '
     ++test_expect_failure 'status after the move' '
     + 	: >../trace &&
     + 	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
     + 	git status --porcelain >../actual &&
      @@
       A  one
       A  two
       ?? .gitignore
     --?? dtwo/
     ++?? dthree/
     + ?? dtwo/
       EOF
       	test_cmp ../status.expect ../actual &&
     - 	cat >../trace.expect <<EOF &&
     +@@
     + 	test_cmp ../trace.expect ../trace
     + '
     + 
     +-test_expect_success 'verify untracked cache dump' '
     ++test_expect_failure 'verify untracked cache dump' '
     + 	test-tool dump-untracked-cache >../actual &&
     + 	cat >../expect <<EOF &&
     + info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
      @@
       flags 00000006
       / e6fcc8f2ee31bae321d66afd183fcb7237afae6e recurse valid
       .gitignore
     --dtwo/
     ++dthree/
     + dtwo/
       /done/ 0000000000000000000000000000000000000000 recurse valid
       /dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
     - /dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
     --two
     - EOF
     - 	test_cmp ../expect ../actual
     - '
      @@
     + 	git commit -m "first commit"
     + '
     + 
     +-test_expect_success 'status after commit' '
     ++test_expect_failure 'status after commit' '
     + 	: >../trace &&
     + 	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
       	git status --porcelain >../actual &&
       	cat >../status.expect <<EOF &&
       ?? .gitignore
     --?? dtwo/
     ++?? dthree/
     + ?? dtwo/
       EOF
       	test_cmp ../status.expect ../actual &&
     - 	cat >../trace.expect <<EOF &&
     +@@
     + 	test_cmp ../trace.expect ../trace
     + '
     + 
     +-test_expect_success 'untracked cache correct after commit' '
     ++test_expect_failure 'untracked cache correct after commit' '
     + 	test-tool dump-untracked-cache >../actual &&
     + 	cat >../expect <<EOF &&
     + info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
      @@
       flags 00000006
       / e6fcc8f2ee31bae321d66afd183fcb7237afae6e recurse valid
       .gitignore
     --dtwo/
     ++dthree/
     + dtwo/
       /done/ 0000000000000000000000000000000000000000 recurse valid
       /dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
     - /dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
     --two
     - EOF
     - 	test_cmp ../expect ../actual
     +@@
     + 	sync_mtime
       '
     + 
     +-test_expect_success 'test sparse status with untracked cache' '
     ++test_expect_failure 'test sparse status with untracked cache' '
     + 	: >../trace &&
     + 	avoid_racy &&
     + 	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
      @@
        M done/two
       ?? .gitignore
       ?? done/five
     --?? dtwo/
     ++?? dthree/
     + ?? dtwo/
       EOF
       	test_cmp ../status.expect ../status.actual &&
     - 	cat >../trace.expect <<EOF &&
     +@@
     + 	test_cmp ../trace.expect ../trace
     + '
     + 
     +-test_expect_success 'untracked cache correct after status' '
     ++test_expect_failure 'untracked cache correct after status' '
     + 	test-tool dump-untracked-cache >../actual &&
     + 	cat >../expect <<EOF &&
     + info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
      @@
       flags 00000006
       / e6fcc8f2ee31bae321d66afd183fcb7237afae6e recurse valid
       .gitignore
     --dtwo/
     ++dthree/
     + dtwo/
       /done/ 1946f0437f90c5005533cbe1736a6451ca301714 recurse valid
       five
     - /dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
     - /dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
     --two
     - EOF
     +@@
       	test_cmp ../expect ../actual
       '
     + 
     +-test_expect_success 'test sparse status again with untracked cache' '
     ++test_expect_failure 'test sparse status again with untracked cache' '
     + 	avoid_racy &&
     + 	: >../trace &&
     + 	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
      @@
        M done/two
       ?? .gitignore
       ?? done/five
     --?? dtwo/
     ++?? dthree/
     + ?? dtwo/
       EOF
       	test_cmp ../status.expect ../status.actual &&
     - 	cat >../trace.expect <<EOF &&
     +@@
     + 	echo "sub" > done/sub/sub/file
     + '
     + 
     +-test_expect_success 'test sparse status with untracked cache and subdir' '
     ++test_expect_failure 'test sparse status with untracked cache and subdir' '
     + 	avoid_racy &&
     + 	: >../trace &&
     + 	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
      @@
       ?? .gitignore
       ?? done/five
       ?? done/sub/
     --?? dtwo/
     ++?? dthree/
     + ?? dtwo/
       EOF
       	test_cmp ../status.expect ../status.actual &&
     - 	cat >../trace.expect <<EOF &&
     +@@
     + 	test_cmp ../trace.expect ../trace
     + '
     + 
     +-test_expect_success 'verify untracked cache dump (sparse/subdirs)' '
     ++test_expect_failure 'verify untracked cache dump (sparse/subdirs)' '
     + 	test-tool dump-untracked-cache >../actual &&
     + 	cat >../expect-from-test-dump <<EOF &&
     + info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
      @@
       flags 00000006
       / e6fcc8f2ee31bae321d66afd183fcb7237afae6e recurse valid
       .gitignore
     --dtwo/
     ++dthree/
     + dtwo/
       /done/ 1946f0437f90c5005533cbe1736a6451ca301714 recurse valid
       five
     - sub/
     - /done/sub/ 0000000000000000000000000000000000000000 recurse check_only valid
     --sub/
     - /done/sub/sub/ 0000000000000000000000000000000000000000 recurse check_only valid
     --file
     - /dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
     - /dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
     --two
     - EOF
     +@@
       	test_cmp ../expect-from-test-dump ../actual
       '
     + 
     +-test_expect_success 'test sparse status again with untracked cache and subdir' '
     ++test_expect_failure 'test sparse status again with untracked cache and subdir' '
     + 	avoid_racy &&
     + 	: >../trace &&
     + 	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
      @@
     - 	test_cmp ../expect-no-uc ../actual &&
     - 	git status &&
     + 	test_cmp ../trace.expect ../trace
     + '
     + 
     +-test_expect_success 'move entry in subdir from untracked to cached' '
     ++test_expect_failure 'move entry in subdir from untracked to cached' '
     + 	git add dtwo/two &&
     + 	git status --porcelain >../status.actual &&
     + 	cat >../status.expect <<EOF &&
     +@@
     + ?? .gitignore
     + ?? done/five
     + ?? done/sub/
     ++?? dthree/
     + EOF
     + 	test_cmp ../status.expect ../status.actual
     + '
     + 
     +-test_expect_success 'move entry in subdir from cached to untracked' '
     ++test_expect_failure 'move entry in subdir from cached to untracked' '
     + 	git rm --cached dtwo/two &&
     + 	git status --porcelain >../status.actual &&
     + 	cat >../status.expect <<EOF &&
     +@@
     + ?? .gitignore
     + ?? done/five
     + ?? done/sub/
     ++?? dthree/
     + ?? dtwo/
     + EOF
     + 	test_cmp ../status.expect ../status.actual
     +@@
     + 	test_cmp ../expect-no-uc ../actual
     + '
     + 
     +-test_expect_success 'setting core.untrackedCache to true and using git status creates the cache' '
     ++test_expect_failure 'setting core.untrackedCache to true and using git status creates the cache' '
     + 	git config core.untrackedCache true &&
       	test-tool dump-untracked-cache >../actual &&
     -+	cat >../expect-from-test-dump <<EOF &&
     -+info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
     -+core.excludesfile 0000000000000000000000000000000000000000
     -+exclude_per_dir .gitignore
     -+flags 00000006
     -+/ e6fcc8f2ee31bae321d66afd183fcb7237afae6e recurse valid
     -+.gitignore
     -+dthree/
     -+dtwo/
     -+/done/ 1946f0437f90c5005533cbe1736a6451ca301714 recurse valid
     -+five
     -+sub/
     -+/done/sub/ 0000000000000000000000000000000000000000 recurse check_only valid
     -+/done/sub/sub/ 0000000000000000000000000000000000000000 recurse check_only valid
     -+/dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
     -+/dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
     -+EOF
     - 	test_cmp ../expect-from-test-dump ../actual
     + 	test_cmp ../expect-no-uc ../actual &&
     +@@
     + 	test_cmp ../expect-empty ../actual
       '
       
     +-test_expect_success 'setting core.untrackedCache to keep' '
     ++test_expect_failure 'setting core.untrackedCache to keep' '
     + 	git config core.untrackedCache keep &&
     + 	git update-index --untracked-cache &&
     + 	test-tool dump-untracked-cache >../actual &&
 -:  ----------- > 2:  b20bc3b9afd dir: fix simple typo in comment
 1:  27bc1357964 = 3:  fa9035949e0 dir: consolidate treat_path() and treat_one_path()
 2:  2ceb64ae61e = 4:  02e652d1869 dir: fix broken comment
 3:  e6d21228d12 = 5:  705c008d993 dir: fix confusion based on variable tense
 4:  f73f0d66d14 = 6:  f5d69102946 dir: refactor treat_directory to clarify control flow
 5:  d3136ef52f3 ! 7:  6cfca619e2c dir: replace exponential algorithm with a linear one
     @@ -1,6 +1,6 @@
      Author: Elijah Newren <newren@gmail.com>
      
     -    dir: replace exponential algorithm with a linear one
     +    dir: replace exponential algorithm with a linear one, fix untracked cache
      
          dir's read_directory_recursive() naturally operates recursively in order
          to walk the directory tree.  Treating of directories is sometimes weird
     @@ -161,10 +161,27 @@
          to have completed the 240 nested directories case.  It's not often
          that you get to speed something up by a factor of 3*10^69.
      
     -    WARNING: This change breaks t7063.  I don't know whether that is to be expected
     -    (I now intentionally visit untracked directories differently so naturally the
     -    untracked cache should change), or if I've broken something.  I'm hoping to get
     -    an untracked cache expert to chime in...
     +    Finally, this also fixes the untracked cache, as noted by the test fixes
     +    in t7063.  Unfortunately, it does so by passing stop_at_first_file to
     +    close_cached_dir() in order to disable the caching of whether
     +    directories were empty (this caching was only relevant for directories
     +    that we knew we didn't need to walk all the entries under but just
     +    needed to know whether the directory had any entries within it in order
     +    to know if the directory itself should be marked as path_none or
     +    path_untracked).  I'm not convinced that disabling the is-the-dir-empty
     +    check is necessary; there is probably some way to still cache that and
     +    not get erroneous results.  However, I have not figured out how to do
     +    so.  If I revert the change to close_cached_dir() in this patch (thus
     +    continuing to cache cases where stop_at_first_file is true meaning we
     +    continue to cache whether directories are empty), then the untracked
     +    cache breakage in t7063 becomes more prevalant.  With my change to
     +    close_cached_dir() and the other changes to avoid traversing directories
     +    2^n times in this patch, I not only avoid making the untracked_cache
     +    breakage in t7063 worse but actually fix the existing breakage.  Update
     +    the test results in t7063 to no longer expect check_only cache entries,
     +    to reflect that we have to do a bit more work in terms of how many
     +    directories we have to open, and to reflect that we fixed the 1/3 of
     +    tests that were broken in that testsuite.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     @@ -305,6 +322,24 @@
       	strbuf_setlen(path, baselen);
       	if (!cdir->ucd) {
       		strbuf_addstr(path, cdir->file);
     +@@
     + 	return -1;
     + }
     + 
     +-static void close_cached_dir(struct cached_dir *cdir)
     ++static void close_cached_dir(struct cached_dir *cdir, int stop_at_first_file)
     + {
     + 	if (cdir->fdir)
     + 		closedir(cdir->fdir);
     +@@
     + 	 * We have gone through this directory and found no untracked
     + 	 * entries. Mark it valid.
     + 	 */
     +-	if (cdir->untracked) {
     ++	if (!stop_at_first_file && cdir->untracked) {
     + 		cdir->untracked->valid = 1;
     + 		cdir->untracked->recurse = 1;
     + 	}
      @@
       	int stop_at_first_file, const struct pathspec *pathspec)
       {
     @@ -338,6 +373,15 @@
       			struct untracked_cache_dir *ud;
       			ud = lookup_untracked(dir->untracked, untracked,
       					      path.buf + baselen,
     +@@
     + 						    istate, &path, baselen,
     + 						    pathspec, state);
     + 	}
     +-	close_cached_dir(&cdir);
     ++	close_cached_dir(&cdir, stop_at_first_file);
     +  out:
     + 	strbuf_release(&path);
     + 
      @@
       			      const char *path, int len,
       			      const struct pathspec *pathspec)
     @@ -379,3 +423,342 @@
       
       		if (state != path_recurse)
       			break; /* do not recurse into it */
     +
     + diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
     + --- a/t/t7063-status-untracked-cache.sh
     + +++ b/t/t7063-status-untracked-cache.sh
     +@@
     + dtwo/
     + three
     + /done/ 0000000000000000000000000000000000000000 recurse valid
     +-/dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
     +-three
     +-/dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
     +-two
     + EOF
     + 
     + test_expect_success 'status first time (empty cache)' '
     +@@
     + EOF
     + 	test_cmp ../status.expect ../actual &&
     + 	cat >../trace.expect <<EOF &&
     +-node creation: 0
     ++node creation: 2
     + gitignore invalidation: 0
     + directory invalidation: 1
     +-opendir: 1
     ++opendir: 3
     + EOF
     + 	test_cmp ../trace.expect ../trace
     + 
     +@@
     + four
     + three
     + /done/ 0000000000000000000000000000000000000000 recurse valid
     +-/dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
     +-three
     +-/dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
     +-two
     + EOF
     + 	test_cmp ../expect ../actual
     + '
     +@@
     + EOF
     + 	test_cmp ../status.expect ../actual &&
     + 	cat >../trace.expect <<EOF &&
     +-node creation: 0
     ++node creation: 2
     + gitignore invalidation: 1
     + directory invalidation: 1
     + opendir: 4
     +@@
     + dtwo/
     + three
     + /done/ 0000000000000000000000000000000000000000 recurse valid
     +-/dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
     +-three
     +-/dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
     +-two
     + EOF
     + 	test_cmp ../expect ../actual
     + '
     + 
     +-test_expect_failure 'new info/exclude invalidates everything' '
     ++test_expect_success 'new info/exclude invalidates everything' '
     + 	avoid_racy &&
     + 	echo three >>.git/info/exclude &&
     + 	: >../trace &&
     +@@
     + EOF
     + 	test_cmp ../status.expect ../actual &&
     + 	cat >../trace.expect <<EOF &&
     +-node creation: 0
     ++node creation: 2
     + gitignore invalidation: 1
     + directory invalidation: 0
     + opendir: 4
     +@@
     + 	test_cmp ../trace.expect ../trace
     + '
     + 
     +-test_expect_failure 'verify untracked cache dump' '
     ++test_expect_success 'verify untracked cache dump' '
     + 	test-tool dump-untracked-cache >../actual &&
     + 	cat >../expect <<EOF &&
     + info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
     +@@
     + dthree/
     + dtwo/
     + /done/ 0000000000000000000000000000000000000000 recurse valid
     +-/dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
     +-/dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
     +-two
     + EOF
     + 	test_cmp ../expect ../actual
     + '
     +@@
     + flags 00000006
     + / e6fcc8f2ee31bae321d66afd183fcb7237afae6e recurse
     + /done/ 0000000000000000000000000000000000000000 recurse valid
     +-/dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
     +-/dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
     +-two
     + EOF
     + 	test_cmp ../expect ../actual
     + '
     + 
     +-test_expect_failure 'status after the move' '
     ++test_expect_success 'status after the move' '
     + 	: >../trace &&
     + 	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
     + 	git status --porcelain >../actual &&
     +@@
     + EOF
     + 	test_cmp ../status.expect ../actual &&
     + 	cat >../trace.expect <<EOF &&
     +-node creation: 0
     ++node creation: 2
     + gitignore invalidation: 0
     + directory invalidation: 0
     +-opendir: 1
     ++opendir: 3
     + EOF
     + 	test_cmp ../trace.expect ../trace
     + '
     + 
     +-test_expect_failure 'verify untracked cache dump' '
     ++test_expect_success 'verify untracked cache dump' '
     + 	test-tool dump-untracked-cache >../actual &&
     + 	cat >../expect <<EOF &&
     + info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
     +@@
     + dtwo/
     + two
     + /done/ 0000000000000000000000000000000000000000 recurse valid
     +-/dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
     +-/dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
     +-two
     + EOF
     + 	test_cmp ../expect ../actual
     + '
     +@@
     + flags 00000006
     + / e6fcc8f2ee31bae321d66afd183fcb7237afae6e recurse
     + /done/ 0000000000000000000000000000000000000000 recurse valid
     +-/dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
     +-/dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
     +-two
     + EOF
     + 	test_cmp ../expect ../actual
     + '
     + 
     +-test_expect_failure 'status after the move' '
     ++test_expect_success 'status after the move' '
     + 	: >../trace &&
     + 	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
     + 	git status --porcelain >../actual &&
     +@@
     + EOF
     + 	test_cmp ../status.expect ../actual &&
     + 	cat >../trace.expect <<EOF &&
     +-node creation: 0
     ++node creation: 2
     + gitignore invalidation: 0
     + directory invalidation: 0
     +-opendir: 1
     ++opendir: 3
     + EOF
     + 	test_cmp ../trace.expect ../trace
     + '
     + 
     +-test_expect_failure 'verify untracked cache dump' '
     ++test_expect_success 'verify untracked cache dump' '
     + 	test-tool dump-untracked-cache >../actual &&
     + 	cat >../expect <<EOF &&
     + info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
     +@@
     + dthree/
     + dtwo/
     + /done/ 0000000000000000000000000000000000000000 recurse valid
     +-/dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
     +-/dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
     +-two
     + EOF
     + 	test_cmp ../expect ../actual
     + '
     +@@
     + 	git commit -m "first commit"
     + '
     + 
     +-test_expect_failure 'status after commit' '
     ++test_expect_success 'status after commit' '
     + 	: >../trace &&
     + 	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
     + 	git status --porcelain >../actual &&
     +@@
     + EOF
     + 	test_cmp ../status.expect ../actual &&
     + 	cat >../trace.expect <<EOF &&
     +-node creation: 0
     ++node creation: 2
     + gitignore invalidation: 0
     + directory invalidation: 0
     +-opendir: 2
     ++opendir: 4
     + EOF
     + 	test_cmp ../trace.expect ../trace
     + '
     + 
     +-test_expect_failure 'untracked cache correct after commit' '
     ++test_expect_success 'untracked cache correct after commit' '
     + 	test-tool dump-untracked-cache >../actual &&
     + 	cat >../expect <<EOF &&
     + info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
     +@@
     + dthree/
     + dtwo/
     + /done/ 0000000000000000000000000000000000000000 recurse valid
     +-/dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
     +-/dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
     +-two
     + EOF
     + 	test_cmp ../expect ../actual
     + '
     +@@
     + 	sync_mtime
     + '
     + 
     +-test_expect_failure 'test sparse status with untracked cache' '
     ++test_expect_success 'test sparse status with untracked cache' '
     + 	: >../trace &&
     + 	avoid_racy &&
     + 	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
     +@@
     + EOF
     + 	test_cmp ../status.expect ../status.actual &&
     + 	cat >../trace.expect <<EOF &&
     +-node creation: 0
     ++node creation: 2
     + gitignore invalidation: 1
     + directory invalidation: 2
     +-opendir: 2
     ++opendir: 4
     + EOF
     + 	test_cmp ../trace.expect ../trace
     + '
     + 
     +-test_expect_failure 'untracked cache correct after status' '
     ++test_expect_success 'untracked cache correct after status' '
     + 	test-tool dump-untracked-cache >../actual &&
     + 	cat >../expect <<EOF &&
     + info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
     +@@
     + dtwo/
     + /done/ 1946f0437f90c5005533cbe1736a6451ca301714 recurse valid
     + five
     +-/dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
     +-/dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
     +-two
     + EOF
     + 	test_cmp ../expect ../actual
     + '
     + 
     +-test_expect_failure 'test sparse status again with untracked cache' '
     ++test_expect_success 'test sparse status again with untracked cache' '
     + 	avoid_racy &&
     + 	: >../trace &&
     + 	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
     +@@
     + 	echo "sub" > done/sub/sub/file
     + '
     + 
     +-test_expect_failure 'test sparse status with untracked cache and subdir' '
     ++test_expect_success 'test sparse status with untracked cache and subdir' '
     + 	avoid_racy &&
     + 	: >../trace &&
     + 	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
     +@@
     + 	test_cmp ../trace.expect ../trace
     + '
     + 
     +-test_expect_failure 'verify untracked cache dump (sparse/subdirs)' '
     ++test_expect_success 'verify untracked cache dump (sparse/subdirs)' '
     + 	test-tool dump-untracked-cache >../actual &&
     + 	cat >../expect-from-test-dump <<EOF &&
     + info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
     +@@
     + /done/ 1946f0437f90c5005533cbe1736a6451ca301714 recurse valid
     + five
     + sub/
     +-/done/sub/ 0000000000000000000000000000000000000000 recurse check_only valid
     +-sub/
     +-/done/sub/sub/ 0000000000000000000000000000000000000000 recurse check_only valid
     +-file
     +-/dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
     +-/dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
     +-two
     + EOF
     + 	test_cmp ../expect-from-test-dump ../actual
     + '
     + 
     +-test_expect_failure 'test sparse status again with untracked cache and subdir' '
     ++test_expect_success 'test sparse status again with untracked cache and subdir' '
     + 	avoid_racy &&
     + 	: >../trace &&
     + 	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
     +@@
     + 	test_cmp ../trace.expect ../trace
     + '
     + 
     +-test_expect_failure 'move entry in subdir from untracked to cached' '
     ++test_expect_success 'move entry in subdir from untracked to cached' '
     + 	git add dtwo/two &&
     + 	git status --porcelain >../status.actual &&
     + 	cat >../status.expect <<EOF &&
     +@@
     + 	test_cmp ../status.expect ../status.actual
     + '
     + 
     +-test_expect_failure 'move entry in subdir from cached to untracked' '
     ++test_expect_success 'move entry in subdir from cached to untracked' '
     + 	git rm --cached dtwo/two &&
     + 	git status --porcelain >../status.actual &&
     + 	cat >../status.expect <<EOF &&
     +@@
     + 	test_cmp ../expect-no-uc ../actual
     + '
     + 
     +-test_expect_failure 'setting core.untrackedCache to true and using git status creates the cache' '
     ++test_expect_success 'setting core.untrackedCache to true and using git status creates the cache' '
     + 	git config core.untrackedCache true &&
     + 	test-tool dump-untracked-cache >../actual &&
     + 	test_cmp ../expect-no-uc ../actual &&
     +@@
     + 	test_cmp ../expect-empty ../actual
     + '
     + 
     +-test_expect_failure 'setting core.untrackedCache to keep' '
     ++test_expect_success 'setting core.untrackedCache to keep' '
     + 	git config core.untrackedCache keep &&
     + 	git update-index --untracked-cache &&
     + 	test-tool dump-untracked-cache >../actual &&

-- 
gitgitgadget
