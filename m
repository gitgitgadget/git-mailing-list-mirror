Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C3EC433EF
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 00:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234735AbiCHAPs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 19:15:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbiCHAPr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 19:15:47 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A6BC1D
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 16:14:51 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id s19-20020a170902b19300b00149a463ad43so8218491plr.1
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 16:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9Hfsr8fzRx4+QZrMHmo60aXmrFZkfVugyL3ipDZ1LPU=;
        b=OsymPAgYH0+e0bsR9xfsQeDtCnJkQJsRh3H2Q93pOmRwlVmycjJe8Yuen/iBuCkYQJ
         Oco5i0X0KmFPP9hPYF95PsRDwIEAclDJT8ozvag0gYz/tTiRUklvsk2jScklIJc8QirH
         onVZI2ltiVosG+5Yslst6TFecNRaa9lDdY0yA1czgbTA/38RjPs9m84Y9MPy2d4SD0my
         BWV3/95t6E+ca6ThmhX+SO9twUTMngOUMpj9K6+Q39qpmBi4R/UvgUkNKmNIfqQ48T7k
         15RUYzCxY08XvPYDEU25+gZTET30+ZqKSvF3uWmpVQ/T4+sIQFW6j+aSSYqI19erxJFo
         KbYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9Hfsr8fzRx4+QZrMHmo60aXmrFZkfVugyL3ipDZ1LPU=;
        b=MjAtVqo03nqP2V4RewZC1XPLkKryW7dDI7XWNvxPjP6pmS4wj0lxdFzgewQ+Vmv09W
         93rfv/J9Kynl1tRiO1wIvWbmHapYUMDizh5C/mTxIrillGR2UiZr651qaabXpbZzAvBP
         ineGsdcpm6bSNH1dZfZGDVKu+1GEfNaQ0zxBhHlY7TfFTY0Q4JTQ11D6jKvtcno4ApYX
         rofUt2Bl18dogZ2gWA7C57BN5uQKKchC8L1xNyNl6pA809asGkLmd7gru588/MTwLdgy
         0GthO+OyWTLs7y22iUCCXMeZUSh/lXCY+DrX/0t262+8SEKYFiyf60nrQDtsuSAmHQ67
         gByQ==
X-Gm-Message-State: AOAM533nTkeWpjjUF/7snyunuQdmgembyg/26icJI+dBSFJ22kUJsV2+
        9VuoIJJdtk25X0Tt0aiN4RNcRkSmDt8NV1ZjL/cL1siPYe2eEBctaTr/Mkz2Hs0kfhXTU2bnM3q
        IqSCpoi3ZAuX+Hco+3Gvr9MK0FK6m5PtT8tW11NKUMcOQzUZ1H5bBFUGjAbi6T0U=
X-Google-Smtp-Source: ABdhPJx6xbVB512UNuz9bTZXZd8AxGAnJx0zPNn4DPhnUXoypLwOZm7RXJ6lRPm5ibrJIQMtL6Wc6Cegjfksyw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:d4c8:b0:151:a7b2:e3fd with SMTP
 id o8-20020a170902d4c800b00151a7b2e3fdmr14231165plg.99.1646698490525; Mon, 07
 Mar 2022 16:14:50 -0800 (PST)
Date:   Mon,  7 Mar 2022 16:14:23 -0800
In-Reply-To: <20220304005757.70107-1-chooglen@google.com>
Message-Id: <20220308001433.94995-1-chooglen@google.com>
Mime-Version: 1.0
References: <20220304005757.70107-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH v5 00/10] fetch --recurse-submodules: fetch unpopulated submodules
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Original cover letter: https://lore.kernel.org/git/20220210044152.78352-1-chooglen@google.com

Based off 'master'.

Thanks as always for the kind feedback :) I believe I incorporated all
of feedback from the previous round except for the following:

- <xmqqk0d9w91r.fsf@gitster.g> In a recursive fetch, we thought that we
  could use the submodule name instead of the superproject commit oid
  and path.

  It's true that we don't need <.super_oid, .path> in order to init the
  subrepo, but it turns out that recursive fetch reads some
  configuration values from .gitmodules (via submodule_from_path()), so
  we still need to store super_oid in order to read the correct
  .gitmodules file.

- <20220304235328.649768-1-jonathantanmy@google.com> I've described the
  differences between the no-submodule-in-index test and the
  other-submodule-in-index test (their comments now refer to one
  another, so the contrast is more obvious), but didn't reorder them
  because I thought that made the test setup less intuitive to read.

- <20220304234622.647776-1-jonathantanmy@google.com> I added
  expect.err.sub2 to verify_test_result() but didn't change
  write_expected_super() to account for sub2. It turned out to be tricky
  to predict the output when 'super' fetches >1 branch because each
  fetched branch can affect the formatting. e.g.

    	   OLD_HEAD..super  super           -> origin/super

  can become

    	   OLD_HEAD..super  super                   -> origin/super
    	   OLD_HEAD..super  some-other-branch       -> origin/some-other-branch

  (I could work around this by replacing the whitespace with sed, but it
  seemed like too much overhead for a one-off test).

= Patch organization

- Patches 1-3 are quality-of-life improvements to the test suite that
  make it easier to write the tests in patch 9.
- Patches 4-6 are preparation for "git fetch" to read .gitmodules from
  the superproject commit in patch 7.
- Patches 7-8 refactor out the logic of "finding which submodules to
  fetch" and "fetching the submodules", making it easier to tell "git
  fetch" to fetch unpopulated submodules.
- Patch 9 teaches "git fetch" to fetch changed, unpopulated submodules
  in addition to populated submodules.
- Patch 10 is an optional bugfix + cleanup of the "git fetch" code that
  removes the last caller of the deprecated "add_submodule_odb()".

= Changes 

== Since v4
- Rename test helpers (s/check_/write_expected_)
- Test style fixes
- Update test comments
- Remove the manual test_cmp in the test that checks sub2 (but we still
  construct expect.err.super manually).

== Since v3
- Numerous style fixes + improved comments.
- Fix sed portability issues.
- Fix failing test due to default branch name assumptions.
- Patch 3: change a test so that it no longer depends on state from the
  previous test.
- Patch 9: fix memory leak when recording super_oid and path + add
  explanatory comment.

== Since v2
- Numerous small fixes to the code and commit message (thanks to all who
  helped spot these :))
- In patch 2, use test_cmp + sed to assert on test output, effectively
  reverting the "use grep" approach of v1-2 (see patch 2's description).
- New patch 3: introduce a test helper that creates the expected
  superproject commit (instead of copy-pasting the code over and over).
  - I did not get rid of "git fetch" inside the test helper (as Jonathan
    suggested) though, because that requires a bigger change in the test
    setup, and I think the test helper makes the test straightforward
    enough.
- New patch 8: refactor some shared logic out into fetch_task_create().
  This reduces code duplication between the get_fetch_task_from_*
  functions.
- In patch 9, add additional tests for 'submodules with the same name'.
- In patch 9, handle a bug where a submodule that is unpopulated by "git
  rm" still has "core.worktree" set and cannot be fetched (see patch 9's
  description).
- Remove the "git fetch --update-shallow" patch (I'll try to send it
  separately).

== Since v1
- Numerous style fixes suggested by Jonathan (thanks!)
- In patch 3, don't prematurely read submodules from the superproject
  commit (see:
  <kl6l5yplyat6.fsf@chooglen-macbookpro.roam.corp.google.com>).
- In patch 7, stop using "git checkout" and "! grep" in tests.
- In patch 7, stop doing the "find changed submodules" rev walk
  unconditionally. Instead, continue to check for .gitmodules, but also
  check for submodules in $GIT_DIR/modules.
  - I'm not entirely happy with the helper function name, see "---" for
    details.
- Move "git fetch --update-shallow" bugfix to patch 8.
  - Because the "find changed submodules" rev walk is no longer
    unconditional, this fix is no longer needed for tests to pass.
- Rename fetch_populated_submodules() to fetch_submodules().


Glen Choo (10):
  t5526: introduce test helper to assert on fetches
  t5526: stop asserting on stderr literally
  t5526: create superproject commits with test helper
  submodule: make static functions read submodules from commits
  submodule: inline submodule_commits() into caller
  submodule: store new submodule commits oid_array in a struct
  submodule: extract get_fetch_task()
  submodule: move logic into fetch_task_create()
  fetch: fetch unpopulated, changed submodules
  submodule: fix latent check_has_commit() bug

 Documentation/fetch-options.txt |  26 +-
 Documentation/git-fetch.txt     |  10 +-
 builtin/fetch.c                 |  14 +-
 submodule.c                     | 442 +++++++++++++++++---------
 submodule.h                     |  21 +-
 t/t5526-fetch-submodules.sh     | 545 ++++++++++++++++++++++++--------
 6 files changed, 746 insertions(+), 312 deletions(-)

Range-diff against v4:
 1:  57cd31afc2 !  1:  f22f992e2b t5526: introduce test helper to assert on fetches
    @@ t/t5526-fetch-submodules.sh: add_upstream_commit() {
     +#
     +# If a repo should not be fetched in the test, its corresponding
     +# expect.err file should be rm-ed.
    -+verify_fetch_result() {
    ++verify_fetch_result () {
     +	ACTUAL_ERR=$1 &&
     +	rm -f expect.err.combined &&
     +	if test -f expect.err.super
 2:  b70c894cff !  2:  f6ee125e16 t5526: stop asserting on stderr literally
    @@ Commit message
     
         Stop asserting on $head1 by replacing it with a dummy value in the
         actual and expected output. Do this by introducing test
    -    helpers (check_*()) that make it easier to construct the expected
    -    output, and use sed to munge the actual output.
    +    helpers (write_expected_*()) that make it easier to construct the
    +    expected output, and use sed to munge the actual output.
     
         Signed-off-by: Glen Choo <chooglen@google.com>
     
    @@ t/t5526-fetch-submodules.sh: export GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB
      
      pwd=$(pwd)
      
    -+check_sub () {
    ++write_expected_sub () {
     +	NEW_HEAD=$1 &&
    -+	cat >$pwd/expect.err.sub <<-EOF
    ++	cat >"$pwd/expect.err.sub" <<-EOF
     +	Fetching submodule submodule
     +	From $pwd/submodule
     +	   OLD_HEAD..$NEW_HEAD  sub        -> origin/sub
     +	EOF
     +}
     +
    -+check_deep () {
    ++write_expected_deep () {
     +	NEW_HEAD=$1 &&
    -+	cat >$pwd/expect.err.deep <<-EOF
    ++	cat >"$pwd/expect.err.deep" <<-EOF
     +	Fetching submodule submodule/subdir/deepsubmodule
     +	From $pwd/deepsubmodule
     +	   OLD_HEAD..$NEW_HEAD  deep       -> origin/deep
     +	EOF
     +}
     +
    -+check_super () {
    ++write_expected_super () {
     +	NEW_HEAD=$1 &&
    -+	cat >$pwd/expect.err.super <<-EOF
    ++	cat >"$pwd/expect.err.super" <<-EOF
     +	From $pwd/.
     +	   OLD_HEAD..$NEW_HEAD  super      -> origin/super
     +	EOF
    @@ t/t5526-fetch-submodules.sh: pwd=$(pwd)
     -		echo "From $pwd/submodule" >> ../expect.err.sub &&
     -		echo "   $head1..$head2  sub        -> origin/sub" >> ../expect.err.sub
     +		new_head=$(git rev-parse --short HEAD) &&
    -+		check_sub $new_head
    ++		write_expected_sub $new_head
      	) &&
      	(
      		cd deepsubmodule &&
    @@ t/t5526-fetch-submodules.sh: pwd=$(pwd)
     -		echo "From $pwd/deepsubmodule" >> ../expect.err.deep &&
     -		echo "   $head1..$head2  deep       -> origin/deep" >> ../expect.err.deep
     +		new_head=$(git rev-parse --short HEAD) &&
    -+		check_deep $new_head
    ++		write_expected_deep $new_head
      	)
      }
      
    -@@ t/t5526-fetch-submodules.sh: add_upstream_commit() {
    - #
    - # If a repo should not be fetched in the test, its corresponding
    - # expect.err file should be rm-ed.
    --verify_fetch_result() {
    -+verify_fetch_result () {
    - 	ACTUAL_ERR=$1 &&
    - 	rm -f expect.err.combined &&
    - 	if test -f expect.err.super
    -@@ t/t5526-fetch-submodules.sh: verify_fetch_result() {
    +@@ t/t5526-fetch-submodules.sh: verify_fetch_result () {
      	then
      		cat expect.err.deep >>expect.err.combined
      	fi &&
    @@ t/t5526-fetch-submodules.sh: test_expect_success "Recursion doesn't happen when
     -	echo "From $pwd/." > expect.err.super &&
     -	echo "   $head1..$head2  super      -> origin/super" >>expect.err.super &&
     +	new_head=$(git rev-parse --short HEAD) &&
    -+	check_super $new_head &&
    ++	write_expected_super $new_head &&
      	rm expect.err.deep &&
      	(
      		cd downstream &&
    @@ t/t5526-fetch-submodules.sh: test_expect_success "Recursion stops when no new su
     -	echo "From $pwd/." > expect.err.super &&
     -	echo "   $head1..$head2  super      -> origin/super" >> expect.err.super &&
     +	new_head=$(git rev-parse --short HEAD) &&
    -+	check_super $new_head &&
    ++	write_expected_super $new_head &&
      	rm expect.err.sub &&
      	rm expect.err.deep &&
      	(
    @@ t/t5526-fetch-submodules.sh: test_expect_success "Recursion picks up config in s
     -	echo "From $pwd/." > expect.err.super &&
     -	echo "   $head1..$head2  super      -> origin/super" >> expect.err.super &&
     +	new_head=$(git rev-parse --short HEAD) &&
    -+	check_super $new_head &&
    ++	write_expected_super $new_head &&
      	(
      		cd downstream &&
      		git fetch >../actual.out 2>../actual.err &&
    @@ t/t5526-fetch-submodules.sh: test_expect_success "Recursion picks up all submodu
     -		echo "From $pwd/submodule" >> ../expect.err.sub &&
     -		echo "   $head1..$head2  sub        -> origin/sub" >> ../expect.err.sub
     +		new_head=$(git rev-parse --short HEAD) &&
    -+		check_sub $new_head
    ++		write_expected_sub $new_head
      	) &&
     -	head1=$(git rev-parse --short HEAD) &&
      	git add submodule &&
    @@ t/t5526-fetch-submodules.sh: test_expect_success "Recursion picks up all submodu
     -	echo "From $pwd/." > expect.err.super &&
     -	echo "   $head1..$head2  super      -> origin/super" >> expect.err.super &&
     +	new_head=$(git rev-parse --short HEAD) &&
    -+	check_super $new_head &&
    ++	write_expected_super $new_head &&
      	(
      		cd downstream &&
      		git fetch >../actual.out 2>../actual.err
    @@ t/t5526-fetch-submodules.sh: test_expect_success "'--recurse-submodules=on-deman
     -		echo "From $pwd/submodule" >> ../expect.err.sub &&
     -		echo "   $head1..$head2  sub        -> origin/sub" >> ../expect.err.sub
     +		new_head=$(git rev-parse --short HEAD) &&
    -+		check_sub $new_head
    ++		write_expected_sub $new_head
      	) &&
      	(
      		cd downstream &&
    @@ t/t5526-fetch-submodules.sh: test_expect_success "'--recurse-submodules=on-deman
     -	echo "From $pwd/." > expect.err.super &&
     -	echo "   $head1..$head2  super      -> origin/super" >>expect.err.super &&
     +	new_head=$(git rev-parse --short HEAD) &&
    -+	check_super $new_head &&
    ++	write_expected_super $new_head &&
      	(
      		cd downstream &&
      		git config fetch.recurseSubmodules false &&
    @@ t/t5526-fetch-submodules.sh: test_expect_success "'--recurse-submodules=on-deman
     -	echo "From $pwd/." > expect.err.super &&
     -	echo "   $head1..$head2  super      -> origin/super" >> expect.err.super &&
     +	new_head=$(git rev-parse --short HEAD) &&
    -+	check_super $new_head &&
    ++	write_expected_super $new_head &&
      	rm expect.err.sub &&
      	rm expect.err.deep &&
      	(
    @@ t/t5526-fetch-submodules.sh: test_expect_success "'fetch.recurseSubmodules=on-de
     -	echo "From $pwd/." > expect.err.super &&
     -	echo "   $head1..$head2  super      -> origin/super" >>expect.err.super &&
     +	new_head=$(git rev-parse --short HEAD) &&
    -+	check_super $new_head &&
    ++	write_expected_super $new_head &&
      	rm expect.err.deep &&
      	(
      		cd downstream &&
    @@ t/t5526-fetch-submodules.sh: test_expect_success "'submodule.<sub>.fetchRecurseS
     -	echo "From $pwd/." > expect.err.super &&
     -	echo "   $head1..$head2  super      -> origin/super" >>expect.err.super &&
     +	new_head=$(git rev-parse --short HEAD) &&
    -+	check_super $new_head &&
    ++	write_expected_super $new_head &&
      	rm expect.err.deep &&
      	(
      		cd downstream &&
    @@ t/t5526-fetch-submodules.sh: test_expect_success "don't fetch submodule when new
     -	echo "From $pwd/." > expect.err.super &&
     -	echo "   $head1..$head2  super      -> origin/super" >> expect.err.super &&
     +	new_head=$(git rev-parse --short HEAD) &&
    -+	check_super $new_head &&
    ++	write_expected_super $new_head &&
      	rm expect.err.sub &&
      	# This file does not exist, but rm -f for readability
      	rm -f expect.err.deep &&
    @@ t/t5526-fetch-submodules.sh: test_expect_success "'fetch.recurseSubmodules=on-de
     -	echo "From $pwd/." >expect.err.super &&
     -	echo "   $head1..$head2  super      -> origin/super" >>expect.err.super &&
     +	new_head=$(git rev-parse --short HEAD) &&
    -+	check_super $new_head &&
    ++	write_expected_super $new_head &&
      	rm expect.err.deep &&
      	(
      		cd downstream &&
 3:  7e2a01164e !  3:  17ccae2933 t5526: create superproject commits with test helper
    @@ Commit message
         Signed-off-by: Glen Choo <chooglen@google.com>
     
      ## t/t5526-fetch-submodules.sh ##
    -@@ t/t5526-fetch-submodules.sh: check_super () {
    +@@ t/t5526-fetch-submodules.sh: write_expected_super () {
      # a file that contains the expected err if that new commit were fetched.
      # These output files get concatenated in the right order by
      # verify_fetch_result().
    @@ t/t5526-fetch-submodules.sh: add_upstream_commit() {
     +	git commit -m "new submodule" &&
     +	super_head=$(git rev-parse --short HEAD) &&
     +	sub_head=$(git -C submodule rev-parse --short HEAD) &&
    -+	check_super $super_head &&
    -+	check_sub $sub_head
    ++	write_expected_super $super_head &&
    ++	write_expected_sub $sub_head
     +}
     +
      # Verifies that the expected repositories were fetched. This is done by
    @@ t/t5526-fetch-submodules.sh: test_expect_success "Recursion picks up config in s
     -		git add subdir/deepsubmodule &&
     -		git commit -m "new deepsubmodule" &&
     -		new_head=$(git rev-parse --short HEAD) &&
    --		check_sub $new_head
    +-		write_expected_sub $new_head
     -	) &&
     -	git add submodule &&
     -	git commit -m "new submodule" &&
     -	new_head=$(git rev-parse --short HEAD) &&
    --	check_super $new_head &&
    +-	write_expected_super $new_head &&
     +	add_submodule_commits &&
     +	add_superproject_commits &&
      	(
    @@ t/t5526-fetch-submodules.sh: test_expect_success "Recursion picks up all submodu
     -		git add subdir/deepsubmodule &&
     -		git commit -m "new deepsubmodule" &&
     -		new_head=$(git rev-parse --short HEAD) &&
    --		check_sub $new_head
    +-		write_expected_sub $new_head
     -	) &&
     +	add_submodule_commits &&
      	(
    @@ t/t5526-fetch-submodules.sh: test_expect_success "'--recurse-submodules=on-deman
     -	git add submodule &&
     -	git commit -m "new submodule" &&
     -	new_head=$(git rev-parse --short HEAD) &&
    --	check_super $new_head &&
    +-	write_expected_super $new_head &&
    ++	add_submodule_commits &&
     +	add_superproject_commits &&
      	(
      		cd downstream &&
 4:  88112ee225 =  4:  b220dd32c1 submodule: make static functions read submodules from commits
 5:  007cd97aba =  5:  da346aa12a submodule: inline submodule_commits() into caller
 6:  f34ea88fe9 =  6:  c1fd9c3abf submodule: store new submodule commits oid_array in a struct
 7:  f66ab663c5 =  7:  dbb931fe30 submodule: extract get_fetch_task()
 8:  4e3db1bc9d =  8:  7242236df9 submodule: move logic into fetch_task_create()
 9:  9e7b1c1bbe !  9:  0dada865d4 fetch: fetch unpopulated, changed submodules
    @@ submodule.h: int should_update_submodules(void);
      ## t/t5526-fetch-submodules.sh ##
     @@ t/t5526-fetch-submodules.sh: pwd=$(pwd)
      
    - check_sub () {
    + write_expected_sub () {
      	NEW_HEAD=$1 &&
     +	SUPER_HEAD=$2 &&
    - 	cat >$pwd/expect.err.sub <<-EOF
    + 	cat >"$pwd/expect.err.sub" <<-EOF
     -	Fetching submodule submodule
     +	Fetching submodule submodule${SUPER_HEAD:+ at commit $SUPER_HEAD}
      	From $pwd/submodule
      	   OLD_HEAD..$NEW_HEAD  sub        -> origin/sub
      	EOF
    -@@ t/t5526-fetch-submodules.sh: check_sub () {
    + }
      
    - check_deep () {
    ++write_expected_sub2 () {
    ++	NEW_HEAD=$1 &&
    ++	SUPER_HEAD=$2 &&
    ++	cat >"$pwd/expect.err.sub2" <<-EOF
    ++	Fetching submodule submodule2${SUPER_HEAD:+ at commit $SUPER_HEAD}
    ++	From $pwd/submodule2
    ++	   OLD_HEAD..$NEW_HEAD  sub2       -> origin/sub2
    ++	EOF
    ++}
    ++
    + write_expected_deep () {
      	NEW_HEAD=$1 &&
     +	SUB_HEAD=$2 &&
    - 	cat >$pwd/expect.err.deep <<-EOF
    + 	cat >"$pwd/expect.err.deep" <<-EOF
     -	Fetching submodule submodule/subdir/deepsubmodule
     +	Fetching submodule submodule/subdir/deepsubmodule${SUB_HEAD:+ at commit $SUB_HEAD}
      	From $pwd/deepsubmodule
      	   OLD_HEAD..$NEW_HEAD  deep       -> origin/deep
      	EOF
    -@@ t/t5526-fetch-submodules.sh: test_expect_success "'--recurse-submodules=on-demand' doesn't recurse when no ne
    - '
    - 
    - test_expect_success "'--recurse-submodules=on-demand' recurses as deep as necessary (and ignores config)" '
    -+	add_submodule_commits &&
    - 	add_superproject_commits &&
    - 	(
    - 		cd downstream &&
    +@@ t/t5526-fetch-submodules.sh: verify_fetch_result () {
    + 	then
    + 		cat expect.err.deep >>expect.err.combined
    + 	fi &&
    ++	if test -f expect.err.sub2
    ++	then
    ++		cat expect.err.sub2 >>expect.err.combined
    ++	fi &&
    + 	sed -e 's/[0-9a-f][0-9a-f]*\.\./OLD_HEAD\.\./' "$ACTUAL_ERR" >actual.err.cmp &&
    + 	test_cmp expect.err.combined actual.err.cmp
    + }
     @@ t/t5526-fetch-submodules.sh: test_expect_success "'--recurse-submodules=on-demand' recurses as deep as necess
      	verify_fetch_result actual.err
      '
      
    -+# Test that we can fetch submodules in other branches by running fetch
    -+# in a commit that has no submodules.
    ++# These tests verify that we can fetch submodules that aren't in the
    ++# index.
    ++#
    ++# First, test the simple case where the index is empty and we only fetch
    ++# submodules that are not in the index.
     +test_expect_success 'setup downstream branch without submodules' '
     +	(
     +		cd downstream &&
    @@ t/t5526-fetch-submodules.sh: test_expect_success "'--recurse-submodules=on-deman
     +	deep_head=$(git -C submodule/subdir/deepsubmodule rev-parse --short HEAD) &&
     +
     +	# assert that these are fetched from commits, not the index
    -+	check_sub $sub_head $super_head &&
    -+	check_deep $deep_head $sub_head &&
    ++	write_expected_sub $sub_head $super_head &&
    ++	write_expected_deep $deep_head $sub_head &&
     +
     +	test_must_be_empty actual.out &&
     +	verify_fetch_result actual.err
    @@ t/t5526-fetch-submodules.sh: test_expect_success "'--recurse-submodules=on-deman
     +	deep_head=$(git -C submodule/subdir/deepsubmodule rev-parse --short HEAD) &&
     +
     +	# assert that these are fetched from commits, not the index
    -+	check_sub $sub_head $super_head &&
    -+	check_deep $deep_head $sub_head &&
    ++	write_expected_sub $sub_head $super_head &&
    ++	write_expected_deep $deep_head $sub_head &&
     +
     +	test_must_be_empty actual.out &&
     +	verify_fetch_result actual.err
    @@ t/t5526-fetch-submodules.sh: test_expect_success "'--recurse-submodules=on-deman
     +	) &&
     +	test_must_be_empty actual.out &&
     +	super_head=$(git rev-parse --short HEAD) &&
    -+	check_super $super_head &&
    ++	write_expected_super $super_head &&
     +	# Neither should be fetched because the submodule is inactive
     +	rm expect.err.sub &&
     +	rm expect.err.deep &&
     +	verify_fetch_result actual.err
     +'
     +
    -+# In downstream, init "submodule2", but do not check it out while
    -+# fetching. This lets us assert that unpopulated submodules can be
    -+# fetched.
    ++# Now that we know we can fetch submodules that are not in the index,
    ++# test that we can fetch index and non-index submodules in the same
    ++# operation.
     +test_expect_success 'setup downstream branch with other submodule' '
     +	mkdir submodule2 &&
     +	(
    @@ t/t5526-fetch-submodules.sh: test_expect_success "'--recurse-submodules=on-deman
     +'
     +
     +test_expect_success "'--recurse-submodules' should fetch submodule commits in changed submodules and the index" '
    ++	test_when_finished "rm expect.err.sub2" &&
     +	# Create new commit in origin/super
     +	add_submodule_commits &&
     +	add_superproject_commits &&
    @@ t/t5526-fetch-submodules.sh: test_expect_success "'--recurse-submodules=on-deman
     +		git fetch --recurse-submodules >../actual.out 2>../actual.err
     +	) &&
     +	test_must_be_empty actual.out &&
    -+	deep_head=$(git -C submodule/subdir/deepsubmodule rev-parse --short HEAD) &&
    -+	sub_head=$(git -C submodule rev-parse --short HEAD) &&
     +	sub2_head=$(git -C submodule2 rev-parse --short HEAD) &&
    -+	super_head=$(git rev-parse --short HEAD) &&
    ++	super_head=$(git rev-parse --short super) &&
     +	super_sub2_only_head=$(git rev-parse --short super-sub2-only) &&
    ++	write_expected_sub2 $sub2_head $super_sub2_only_head &&
     +
    -+	# Use test_cmp manually because verify_fetch_result does not
    -+	# consider submodule2. All the repos should be fetched, but only
    -+	# submodule2 should be read from a commit
    -+	cat > expect.err.combined <<-EOF &&
    ++	# write_expected_super cannot handle >1 branch. Since this is a
    ++	# one-off, construct expect.err.super manually.
    ++	cat >"$pwd/expect.err.super" <<-EOF &&
     +	From $pwd/.
     +	   OLD_HEAD..$super_head  super           -> origin/super
     +	   OLD_HEAD..$super_sub2_only_head  super-sub2-only -> origin/super-sub2-only
    -+	Fetching submodule submodule
    -+	From $pwd/submodule
    -+	   OLD_HEAD..$sub_head  sub        -> origin/sub
    -+	Fetching submodule submodule/subdir/deepsubmodule
    -+	From $pwd/deepsubmodule
    -+	   OLD_HEAD..$deep_head  deep       -> origin/deep
    -+	Fetching submodule submodule2 at commit $super_sub2_only_head
    -+	From $pwd/submodule2
    -+	   OLD_HEAD..$sub2_head  sub2       -> origin/sub2
     +	EOF
    -+	sed -e "s/[0-9a-f][0-9a-f]*\.\./OLD_HEAD\.\./" actual.err >actual.err.cmp &&
    -+	test_cmp expect.err.combined actual.err.cmp
    ++	verify_fetch_result actual.err
     +'
     +
      test_expect_success "'--recurse-submodules=on-demand' stops when no new submodule commits are found in the superproject (and ignores config)" '
10:  362ce3c7f8 = 10:  71bb456041 submodule: fix latent check_has_commit() bug

base-commit: 715d08a9e51251ad8290b181b6ac3b9e1f9719d7
-- 
2.33.GIT

