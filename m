Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC24C433F5
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 10:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbiBXKJZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 05:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232880AbiBXKJX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 05:09:23 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC9228A104
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 02:08:51 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id b5-20020a631b05000000b00373bd90134dso905195pgb.22
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 02:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/1JzIwcLxmykCD4DSvczrWTseQUw/dmxE6eCwus/w38=;
        b=CxWrf9pvCrtpa/resiKspkqdv58tzt3gkRS9xnOZZLnbPvGqEY1TfouyJpKpNvvgLd
         HDfxf6XAku/SRFZ3jmSc0BGstXCBQI3ls5iJV1PYN6zvEcBGigSsGcXgsKsAjU6IQJY1
         DtzisxTbEIoSU1mfshMIWGaRQBQhlnlaJsoqmslNS6GcpwqdtN4vyPRdZNm63iH+Yn0L
         DMrbSjx2fhNHxLk6Me287ZyfGvFJA23+pG/l4jqCtJptEyRkdrBeO/ZU4kyIw4vFnPGG
         DGTVDIJcio0Ht5E5K6Z4aKaUHxXuNNJ7FuQ8R9WdjInKJopIa2zG6ciIUk5rXI5Tj2FB
         /d4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/1JzIwcLxmykCD4DSvczrWTseQUw/dmxE6eCwus/w38=;
        b=geD5OD4FFrqkHuuKgGiZ3gLwqBRPf+4Ak5njpYV83BwSfHmYNAanqCZJ+46IETHUy2
         DQBRWrlx7ymbrdlM8uogO08bI0LdWQegpHYfd6fzOayAUJG2ceIxT0ZWAo7oKyerAQY8
         KKF2mxSMzYwfKdLLekKvdg0XDOy2pYOYxsl3zC9IXQ3BPZN5iY3KpbWQKj0Dmx2xSmrX
         CkUj8z6uGqWkMEkQZLaVd2F+iUE5ZgUWOnFz6n8RzOuwl5xY9ECp/kPOkZxjwm32FNJz
         wKQioSYdNsx9Zwoc0rD4ylU1CRfrAv08+uwUb5+x9ORF7OfLvX9IQnXoHE1p8Ge/qYYB
         EaKg==
X-Gm-Message-State: AOAM531bOgIvP6s7JN2RfZci/MAnkNXEHAWVRjE+1EONr2b/tegYtrNI
        SLeQhdf5SW0Mi/se1uddBcXy6rfOfEcp+hEWdSMzf/8+KZTiwbUj0eAQ6cJEeK4jbS09HO3z8cE
        uP3JQJ6KbK1MNFIVeWWAzAqMRw1PwQqw57xS3GaMlH+acef/yhtVWsH+21wm7+qU=
X-Google-Smtp-Source: ABdhPJyfqDosbo0hoF3LkGHVD6nUCmc1NW2AMcjSXuw6CsBNXzuoygIExpNlM/SOu6pG52se6k32T9JRgKxVhg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:ca86:b0:1bc:11f9:f3cf with SMTP
 id y6-20020a17090aca8600b001bc11f9f3cfmr2046110pjt.172.1645697331338; Thu, 24
 Feb 2022 02:08:51 -0800 (PST)
Date:   Thu, 24 Feb 2022 18:08:32 +0800
In-Reply-To: <20220215172318.73533-1-chooglen@google.com>
Message-Id: <20220224100842.95827-1-chooglen@google.com>
Mime-Version: 1.0
References: <20220215172318.73533-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
Subject: [PATCH v3 00/10] fetch --recurse-submodules: fetch unpopulated submodules
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

This series is based on gc/branch-recurse-submodules.

Thanks for the feedback, and sorry for the delay - I've made some
substantial changes in response to the feedback, as well as unearthing
some surprising bugs.

Patches 2 and 9 have some extra discussion in their --- descriptions.
I'd appreciate feedback on those (especially the 'future work' described
in patch 9).

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
 submodule.c                     | 395 ++++++++++++++---------
 submodule.h                     |  21 +-
 t/t5526-fetch-submodules.sh     | 533 ++++++++++++++++++++++++--------
 6 files changed, 687 insertions(+), 312 deletions(-)

Range-diff against v2:
 1:  a159cdaabb !  1:  b6d34b0f5c t5526: introduce test helper to assert on fetches
    @@ Metadata
      ## Commit message ##
         t5526: introduce test helper to assert on fetches
     
    -    A future commit will change the stderr of "git fetch
    -    --recurse-submodules" and add new tests to t/t5526-fetch-submodules.sh.
    -    This poses two challenges:
    +    Tests in t/t5526-fetch-submodules.sh are unnecessarily noisy:
    +
    +    * The tests have extra logic in order to reproduce the expected stderr
    +      literally, but not all of these details (e.g. the head of the
    +      remote-tracking branch before the fetch) are relevant to the test.
     
    -    * The tests use test_cmp to assert on the stderr, which will fail on the
    -      future test because the stderr changes slightly, even though it still
    -      contains the information we expect.
         * The expect.err file is constructed by the add_upstream_commit() helper
           as input into test_cmp, but most tests fetch a different combination
           of repos from expect.err. This results in noisy tests that modify
    @@ Commit message
         helper to t/t5526-fetch-submodules.sh that asserts on the output of "git
         fetch --recurse-submodules" and handles the ordering of expect.err.
     
    -    As a result, the tests no longer construct expect.err manually. test_cmp
    -    is still invoked by verify_fetch_result(), but that will be replaced in
    -    a later commit.
    +    As a result, the tests no longer construct expect.err manually. Tests
    +    still consider the old head of the remote-tracking branch ("$head1"),
    +    but that will be fixed in a later commit.
     
         Signed-off-by: Glen Choo <chooglen@google.com>
     
 2:  48894c6c43 !  2:  0b85fa35c2 t5526: use grep to assert on fetches
    @@ Metadata
     Author: Glen Choo <chooglen@google.com>
     
      ## Commit message ##
    -    t5526: use grep to assert on fetches
    +    t5526: stop asserting on stderr literally
     
    -    In a previous commit, we replaced test_cmp invocations with
    -    verify_fetch_result(). Finish the process of removing test_cmp by using
    -    grep in verify_fetch_result() instead.
    +    In the previous commit message, we noted that not all of the "git fetch"
    +    stderr is relevant to the tests. Most of the test setup lines are
    +    dedicated to these details of the stderr:
     
    -    This makes the tests less sensitive to changes because, instead of
    -    checking the whole stderr, we only grep for the lines of the form
    +    1. which repos (super/sub/deep) are involved in the fetch
    +    2. the head of the remote-tracking branch before the fetch (i.e. $head1)
    +    3. the head of the remote-tracking branch after the fetch (i.e. $head2)
     
    -    * "<old-head>..<new-head>\s+branch\s+-> origin/branch"
    -    * "Fetching submodule <submodule-path>" (if fetching a submodule)
    +    1. and 3. are relevant because they tell us that the expected commit is
    +    fetched by the expected repo, but 2. is completely irrelevant.
     
    -    when we expect the repo to have fetched. If we expect the repo to not
    -    have fetched, grep to make sure the lines are absent. Also, simplify the
    -    assertions by using grep patterns that match only the relevant pieces of
    -    information, e.g. <old-head> is irrelevant because we only want to know
    -    if the fetch was performed, so we don't need to know where the branch
    -    was before the fetch.
    +    Stop asserting on $head1 by replacing it with a dummy value in the
    +    actual and expected output. Do this by introducing test
    +    helpers (check_*()) that make it easier to construct the expected
    +    output, and use sed to munge the actual output.
     
         Signed-off-by: Glen Choo <chooglen@google.com>
     
      ## t/t5526-fetch-submodules.sh ##
    +@@ t/t5526-fetch-submodules.sh: export GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB
    + 
    + pwd=$(pwd)
    + 
    ++check_sub() {
    ++	NEW_HEAD=$1 &&
    ++	cat <<-EOF >$pwd/expect.err.sub
    ++	Fetching submodule submodule
    ++	From $pwd/submodule
    ++	   OLD_HEAD..$NEW_HEAD  sub        -> origin/sub
    ++	EOF
    ++}
    ++
    ++check_deep() {
    ++	NEW_HEAD=$1 &&
    ++	cat <<-EOF >$pwd/expect.err.deep
    ++	Fetching submodule submodule/subdir/deepsubmodule
    ++	From $pwd/deepsubmodule
    ++	   OLD_HEAD..$NEW_HEAD  deep       -> origin/deep
    ++	EOF
    ++}
    ++
    ++check_super() {
    ++	NEW_HEAD=$1 &&
    ++	cat <<-EOF >$pwd/expect.err.super
    ++	From $pwd/.
    ++	   OLD_HEAD..$NEW_HEAD  super      -> origin/super
    ++	EOF
    ++}
    ++
    + # For each submodule in the test setup, this creates a commit and writes
    + # a file that contains the expected err if that new commit were fetched.
    + # These output files get concatenated in the right order by
     @@ t/t5526-fetch-submodules.sh: pwd=$(pwd)
      add_upstream_commit() {
      	(
    @@ t/t5526-fetch-submodules.sh: pwd=$(pwd)
     -		echo "Fetching submodule submodule" > ../expect.err.sub &&
     -		echo "From $pwd/submodule" >> ../expect.err.sub &&
     -		echo "   $head1..$head2  sub        -> origin/sub" >> ../expect.err.sub
    -+		git rev-parse --short HEAD >../subhead
    ++		new_head=$(git rev-parse --short HEAD) &&
    ++		check_sub $new_head
      	) &&
      	(
      		cd deepsubmodule &&
    @@ t/t5526-fetch-submodules.sh: pwd=$(pwd)
     -		echo "Fetching submodule submodule/subdir/deepsubmodule" > ../expect.err.deep
     -		echo "From $pwd/deepsubmodule" >> ../expect.err.deep &&
     -		echo "   $head1..$head2  deep       -> origin/deep" >> ../expect.err.deep
    -+		git rev-parse --short HEAD >../deephead
    ++		new_head=$(git rev-parse --short HEAD) &&
    ++		check_deep $new_head
      	)
      }
      
    - # Verifies that the expected repositories were fetched. This is done by
    --# concatenating the files expect.err.[super|sub|deep] in the correct
    --# order and comparing it to the actual stderr.
    -+# checking that the branches of [super|sub|deep] were updated to
    -+# [super|sub|deep]head if the corresponding file exists.
    - #
    --# If a repo should not be fetched in the test, its corresponding
    --# expect.err file should be rm-ed.
    -+# If the [super|sub|deep] head file does not exist, this verifies that
    -+# the corresponding repo was not fetched. Thus, if a repo should not be
    -+# fetched in the test, its corresponding head file should be
    -+# rm-ed.
    - verify_fetch_result() {
    - 	ACTUAL_ERR=$1 &&
    --	rm -f expect.err.combined &&
    --	if [ -f expect.err.super ]; then
    --		cat expect.err.super >>expect.err.combined
    -+	# Each grep pattern is guaranteed to match the correct repo
    -+	# because each repo uses a different name for their branch i.e.
    -+	# "super", "sub" and "deep".
    -+	if [ -f superhead ]; then
    -+		grep -E "\.\.$(cat superhead)\s+super\s+-> origin/super" $ACTUAL_ERR
    -+	else
    -+		! grep "super" $ACTUAL_ERR
    - 	fi &&
    --	if [ -f expect.err.sub ]; then
    --		cat expect.err.sub >>expect.err.combined
    -+	if [ -f subhead ]; then
    -+		grep "Fetching submodule submodule" $ACTUAL_ERR &&
    -+		grep -E "\.\.$(cat subhead)\s+sub\s+-> origin/sub" $ACTUAL_ERR
    -+	else
    -+		! grep "Fetching submodule submodule" $ACTUAL_ERR
    +@@ t/t5526-fetch-submodules.sh: verify_fetch_result() {
    + 	if [ -f expect.err.deep ]; then
    + 		cat expect.err.deep >>expect.err.combined
      	fi &&
    --	if [ -f expect.err.deep ]; then
    --		cat expect.err.deep >>expect.err.combined
    --	fi &&
     -	test_cmp expect.err.combined $ACTUAL_ERR
    -+	if [ -f deephead ]; then
    -+		grep "Fetching submodule submodule/subdir/deepsubmodule" $ACTUAL_ERR &&
    -+		grep -E "\.\.$(cat deephead)\s+deep\s+-> origin/deep" $ACTUAL_ERR
    -+	else
    -+		! grep "Fetching submodule submodule/subdir/deepsubmodule" $ACTUAL_ERR
    -+	fi
    ++	sed -E 's/[0-9a-f]+\.\./OLD_HEAD\.\./' $ACTUAL_ERR >actual.err.cmp &&
    ++	test_cmp expect.err.combined actual.err.cmp
      }
      
      test_expect_success setup '
    @@ t/t5526-fetch-submodules.sh: test_expect_success "Recursion doesn't happen when
     -	head2=$(git rev-parse --short HEAD) &&
     -	echo "From $pwd/." > expect.err.super &&
     -	echo "   $head1..$head2  super      -> origin/super" >>expect.err.super &&
    --	rm expect.err.deep &&
    -+	git rev-parse --short HEAD >superhead &&
    -+	rm deephead &&
    ++	new_head=$(git rev-parse --short HEAD) &&
    ++	check_super $new_head &&
    + 	rm expect.err.deep &&
      	(
      		cd downstream &&
    - 		git fetch >../actual.out 2>../actual.err
     @@ t/t5526-fetch-submodules.sh: test_expect_success "Recursion stops when no new submodule commits are fetched"
      
      test_expect_success "Recursion doesn't happen when new superproject commits don't change any submodules" '
    @@ t/t5526-fetch-submodules.sh: test_expect_success "Recursion stops when no new su
     -	head2=$(git rev-parse --short HEAD) &&
     -	echo "From $pwd/." > expect.err.super &&
     -	echo "   $head1..$head2  super      -> origin/super" >> expect.err.super &&
    --	rm expect.err.sub &&
    --	rm expect.err.deep &&
    -+	git rev-parse --short HEAD >superhead &&
    -+	rm subhead &&
    -+	rm deephead &&
    ++	new_head=$(git rev-parse --short HEAD) &&
    ++	check_super $new_head &&
    + 	rm expect.err.sub &&
    + 	rm expect.err.deep &&
      	(
    - 		cd downstream &&
    - 		git fetch >../actual.out 2>../actual.err
     @@ t/t5526-fetch-submodules.sh: test_expect_success "Recursion picks up config in submodule" '
      		)
      	) &&
    @@ t/t5526-fetch-submodules.sh: test_expect_success "Recursion picks up config in s
     -	head2=$(git rev-parse --short HEAD) &&
     -	echo "From $pwd/." > expect.err.super &&
     -	echo "   $head1..$head2  super      -> origin/super" >> expect.err.super &&
    -+	git rev-parse --short HEAD >superhead &&
    ++	new_head=$(git rev-parse --short HEAD) &&
    ++	check_super $new_head &&
      	(
      		cd downstream &&
      		git fetch >../actual.out 2>../actual.err &&
    @@ t/t5526-fetch-submodules.sh: test_expect_success "Recursion picks up all submodu
     -		echo "Fetching submodule submodule" > ../expect.err.sub &&
     -		echo "From $pwd/submodule" >> ../expect.err.sub &&
     -		echo "   $head1..$head2  sub        -> origin/sub" >> ../expect.err.sub
    -+		git rev-parse --short HEAD >../subhead
    ++		new_head=$(git rev-parse --short HEAD) &&
    ++		check_sub $new_head
      	) &&
     -	head1=$(git rev-parse --short HEAD) &&
      	git add submodule &&
    @@ t/t5526-fetch-submodules.sh: test_expect_success "Recursion picks up all submodu
     -	head2=$(git rev-parse --short HEAD) &&
     -	echo "From $pwd/." > expect.err.super &&
     -	echo "   $head1..$head2  super      -> origin/super" >> expect.err.super &&
    -+	git rev-parse --short HEAD >superhead &&
    ++	new_head=$(git rev-parse --short HEAD) &&
    ++	check_super $new_head &&
      	(
      		cd downstream &&
      		git fetch >../actual.out 2>../actual.err
    @@ t/t5526-fetch-submodules.sh: test_expect_success "'--recurse-submodules=on-deman
     -		echo Fetching submodule submodule > ../expect.err.sub &&
     -		echo "From $pwd/submodule" >> ../expect.err.sub &&
     -		echo "   $head1..$head2  sub        -> origin/sub" >> ../expect.err.sub
    -+		git rev-parse --short HEAD >../subhead
    ++		new_head=$(git rev-parse --short HEAD) &&
    ++		check_sub $new_head
      	) &&
      	(
      		cd downstream &&
    @@ t/t5526-fetch-submodules.sh: test_expect_success "'--recurse-submodules=on-deman
     -	head2=$(git rev-parse --short HEAD) &&
     -	echo "From $pwd/." > expect.err.super &&
     -	echo "   $head1..$head2  super      -> origin/super" >>expect.err.super &&
    -+	git rev-parse --short HEAD >superhead &&
    ++	new_head=$(git rev-parse --short HEAD) &&
    ++	check_super $new_head &&
      	(
      		cd downstream &&
      		git config fetch.recurseSubmodules false &&
    @@ t/t5526-fetch-submodules.sh: test_expect_success "'--recurse-submodules=on-deman
     -	head2=$(git rev-parse --short HEAD) &&
     -	echo "From $pwd/." > expect.err.super &&
     -	echo "   $head1..$head2  super      -> origin/super" >> expect.err.super &&
    --	rm expect.err.sub &&
    --	rm expect.err.deep &&
    -+	git rev-parse --short HEAD >superhead &&
    -+	rm subhead &&
    -+	rm deephead &&
    ++	new_head=$(git rev-parse --short HEAD) &&
    ++	check_super $new_head &&
    + 	rm expect.err.sub &&
    + 	rm expect.err.deep &&
      	(
    - 		cd downstream &&
    - 		git fetch --recurse-submodules=on-demand >../actual.out 2>../actual.err
     @@ t/t5526-fetch-submodules.sh: test_expect_success "'fetch.recurseSubmodules=on-demand' overrides global config
      	) &&
      	add_upstream_commit &&
    @@ t/t5526-fetch-submodules.sh: test_expect_success "'fetch.recurseSubmodules=on-de
     -	head2=$(git rev-parse --short HEAD) &&
     -	echo "From $pwd/." > expect.err.super &&
     -	echo "   $head1..$head2  super      -> origin/super" >>expect.err.super &&
    --	rm expect.err.deep &&
    -+	git rev-parse --short HEAD >superhead &&
    -+	rm deephead &&
    ++	new_head=$(git rev-parse --short HEAD) &&
    ++	check_super $new_head &&
    + 	rm expect.err.deep &&
      	(
      		cd downstream &&
    - 		git config fetch.recurseSubmodules on-demand &&
     @@ t/t5526-fetch-submodules.sh: test_expect_success "'submodule.<sub>.fetchRecurseSubmodules=on-demand' override
      	) &&
      	add_upstream_commit &&
    @@ t/t5526-fetch-submodules.sh: test_expect_success "'submodule.<sub>.fetchRecurseS
     -	head2=$(git rev-parse --short HEAD) &&
     -	echo "From $pwd/." > expect.err.super &&
     -	echo "   $head1..$head2  super      -> origin/super" >>expect.err.super &&
    --	rm expect.err.deep &&
    -+	git rev-parse --short HEAD >superhead &&
    -+	rm deephead &&
    ++	new_head=$(git rev-parse --short HEAD) &&
    ++	check_super $new_head &&
    + 	rm expect.err.deep &&
      	(
      		cd downstream &&
    - 		git config submodule.submodule.fetchRecurseSubmodules on-demand &&
     @@ t/t5526-fetch-submodules.sh: test_expect_success "don't fetch submodule when newly recorded commits are alrea
      		cd submodule &&
      		git checkout -q HEAD^^
    @@ t/t5526-fetch-submodules.sh: test_expect_success "don't fetch submodule when new
     -	head2=$(git rev-parse --short HEAD) &&
     -	echo "From $pwd/." > expect.err.super &&
     -	echo "   $head1..$head2  super      -> origin/super" >> expect.err.super &&
    --	rm expect.err.sub &&
    -+	git rev-parse --short HEAD >superhead &&
    -+	rm subhead &&
    ++	new_head=$(git rev-parse --short HEAD) &&
    ++	check_super $new_head &&
    + 	rm expect.err.sub &&
      	# This file does not exist, but rm -f for readability
    --	rm -f expect.err.deep &&
    -+	rm -f deephead &&
    - 	(
    - 		cd downstream &&
    - 		git fetch >../actual.out 2>../actual.err
    + 	rm -f expect.err.deep &&
     @@ t/t5526-fetch-submodules.sh: test_expect_success "'fetch.recurseSubmodules=on-demand' works also without .git
      		git fetch --recurse-submodules
      	) &&
    @@ t/t5526-fetch-submodules.sh: test_expect_success "'fetch.recurseSubmodules=on-de
     -	head2=$(git rev-parse --short HEAD) &&
     -	echo "From $pwd/." >expect.err.super &&
     -	echo "   $head1..$head2  super      -> origin/super" >>expect.err.super &&
    --	rm expect.err.deep &&
    -+	git rev-parse --short HEAD >superhead &&
    -+	rm deephead &&
    ++	new_head=$(git rev-parse --short HEAD) &&
    ++	check_super $new_head &&
    + 	rm expect.err.deep &&
      	(
      		cd downstream &&
    - 		rm .gitmodules &&
 -:  ---------- >  3:  bb8ef6094a t5526: create superproject commits with test helper
 3:  6cf5e76d62 !  4:  e83a1713c4 submodule: make static functions read submodules from commits
    @@ Commit message
         Submodules will be read from commits when we fetch unpopulated
         submodules.
     
    -    The changed function signatures follow repo_submodule_init()'s argument
    -    order, i.e. "path" then "treeish_name". Where needed, reorder the
    -    arguments of functions that already take "path" and "treeish_name" to be
    -    consistent with this convention.
    -
         Signed-off-by: Glen Choo <chooglen@google.com>
     
      ## submodule.c ##
    @@ submodule.c: static int check_has_commit(const struct object_id *oid, void *data
      				 struct oid_array *commits)
      {
     -	struct has_commit_data has_commit = { r, 1, path };
    -+	struct has_commit_data has_commit = { r, 1, path, super_oid };
    ++	struct has_commit_data has_commit = {
    ++		.repo = r,
    ++		.result = 1,
    ++		.path = path,
    ++		.super_oid = super_oid
    ++	};
      
      	/*
      	 * Perform a cheap, but incorrect check for the existence of 'commits'.
 4:  07fd4ff0a9 =  5:  e27d402b9a submodule: inline submodule_commits() into caller
 5:  f049cb231b !  6:  1c7c8218b8 submodule: store new submodule commits oid_array in a struct
    @@ submodule.c: static void collect_changed_submodules(struct repository *r,
     +static void free_submodules_data(struct string_list *submodules)
      {
      	struct string_list_item *item;
    --	for_each_string_list_item(item, submodules)
    + 	for_each_string_list_item(item, submodules)
     -		oid_array_clear((struct oid_array *) item->util);
    -+	for_each_string_list_item(item, submodules) {
     +		changed_submodule_data_clear(item->util);
    -+	}
    ++
      	string_list_clear(submodules, 1);
      }
      
 6:  814073eecc !  7:  80cf317722 submodule: extract get_fetch_task()
    @@ Commit message
         Signed-off-by: Glen Choo <chooglen@google.com>
     
      ## submodule.c ##
    +@@ submodule.c: struct fetch_task {
    + 	struct repository *repo;
    + 	const struct submodule *sub;
    + 	unsigned free_sub : 1; /* Do we need to free the submodule? */
    ++	const char *default_argv;
    + 
    + 	struct oid_array *commits; /* Ensure these commits are fetched */
    + };
     @@ submodule.c: static struct repository *get_submodule_repo_for(struct repository *r,
      	return ret;
      }
    @@ submodule.c: static struct repository *get_submodule_repo_for(struct repository
     -static int get_next_submodule(struct child_process *cp,
     -			      struct strbuf *err, void *data, void **task_cb)
     +static struct fetch_task *
    -+get_fetch_task(struct submodule_parallel_fetch *spf,
    -+	       const char **default_argv, struct strbuf *err)
    ++get_fetch_task(struct submodule_parallel_fetch *spf, struct strbuf *err)
      {
     -	struct submodule_parallel_fetch *spf = data;
     -
    @@ submodule.c: static int get_next_submodule(struct child_process *cp,
      					task->sub->name))
      				continue;
     -			default_argv = "on-demand";
    -+			*default_argv = "on-demand";
    ++			task->default_argv = "on-demand";
      			break;
      		case RECURSE_SUBMODULES_ON:
     -			default_argv = "yes";
    -+			*default_argv = "yes";
    ++			task->default_argv = "yes";
      			break;
      		case RECURSE_SUBMODULES_OFF:
      			continue;
    @@ submodule.c: static int get_next_submodule(struct child_process *cp,
     +			      void *data, void **task_cb)
     +{
     +	struct submodule_parallel_fetch *spf = data;
    -+	const char *default_argv = NULL;
    -+	struct fetch_task *task = get_fetch_task(spf, &default_argv, err);
    ++	struct fetch_task *task = get_fetch_task(spf, err);
     +
     +	if (task) {
     +		struct strbuf submodule_prefix = STRBUF_INIT;
    @@ submodule.c: static int get_next_submodule(struct child_process *cp,
     +		cp->git_cmd = 1;
     +		strvec_init(&cp->args);
     +		strvec_pushv(&cp->args, spf->args.v);
    -+		strvec_push(&cp->args, default_argv);
    ++		strvec_push(&cp->args, task->default_argv);
     +		strvec_push(&cp->args, "--submodule-prefix");
     +
     +		strbuf_addf(&submodule_prefix, "%s%s/",
 -:  ---------- >  8:  bf9cfa7054 submodule: move logic into fetch_task_create()
 7:  10fd5bf921 !  9:  c7c2ff71b6 fetch: fetch unpopulated, changed submodules
    @@ Commit message
         commands like "git checkout --recurse-submodules" might fail.
     
         Teach "git fetch" to fetch cloned, changed submodules regardless of
    -    whether they are populated (this is in addition to the current behavior
    -    of fetching populated submodules).
    +    whether they are populated. This is in addition to the current behavior
    +    of fetching populated submodules (which is always attempted regardless
    +    of what was fetched in the superproject, or even if nothing was fetched
    +    in the superproject).
     
    -    Since a submodule may be encountered multiple times (via the list of
    -    populated submodules or via the list of changed submodules), maintain a
    -    list of seen submodules to avoid fetching a submodule more than once.
    +    A submodule may be encountered multiple times (via the list of
    +    populated submodules or via the list of changed submodules). When this
    +    happens, "git fetch" only reads the 'populated copy' and ignores the
    +    'changed copy'. Amend the verify_fetch_result() test helper so that we
    +    can assert on which 'copy' is being read.
     
         Signed-off-by: Glen Choo <chooglen@google.com>
     
    @@ submodule.c: void check_for_new_submodule_commits(struct object_id *oid)
      }
      
     +/*
    -+ * Returns 1 if the repo has absorbed submodule gitdirs, and 0
    -+ * otherwise. Like submodule_name_to_gitdir(), this checks
    ++ * Returns 1 if there is at least one submodule gitdir in
    ++ * $GIT_DIR/modules and 0 otherwise. This follows
    ++ * submodule_name_to_gitdir(), which looks for submodules in
     + * $GIT_DIR/modules, not $GIT_COMMON_DIR.
    ++ *
    ++ * A submodule can be moved to $GIT_DIR/modules manually by running "git
    ++ * submodule absorbgitdirs", or it may be initialized there by "git
    ++ * submodule update".
     + */
     +static int repo_has_absorbed_submodules(struct repository *r)
     +{
    @@ submodule.c: struct submodule_parallel_fetch {
      	.submodules_with_errors = STRBUF_INIT, \
      }
      
    -@@ submodule.c: static struct repository *get_submodule_repo_for(struct repository *r,
    +@@ submodule.c: struct fetch_task {
    + 	const struct submodule *sub;
    + 	unsigned free_sub : 1; /* Do we need to free the submodule? */
    + 	const char *default_argv;
    ++	struct strvec git_args;
    + 
    + 	struct oid_array *commits; /* Ensure these commits are fetched */
    + };
    +@@ submodule.c: static void fetch_task_release(struct fetch_task *p)
    + 	if (p->repo)
    + 		repo_clear(p->repo);
    + 	FREE_AND_NULL(p->repo);
    ++
    ++	strvec_clear(&p->git_args);
    + }
    + 
    + static struct repository *get_submodule_repo_for(struct repository *r,
    +@@ submodule.c: static struct fetch_task *fetch_task_create(struct submodule_parallel_fetch *spf
    + 		task->free_sub = 1;
    + 	}
    + 
    ++	if (string_list_lookup(&spf->seen_submodule_names, task->sub->name))
    ++		goto cleanup;
    ++
    + 	switch (get_fetch_recurse_config(task->sub, spf))
    + 	{
    + 	default:
    +@@ submodule.c: static struct fetch_task *fetch_task_create(struct submodule_parallel_fetch *spf
      }
      
      static struct fetch_task *
    --get_fetch_task(struct submodule_parallel_fetch *spf,
    --	       const char **default_argv, struct strbuf *err)
    +-get_fetch_task(struct submodule_parallel_fetch *spf, struct strbuf *err)
     +get_fetch_task_from_index(struct submodule_parallel_fetch *spf,
    -+			  const char **default_argv, struct strbuf *err)
    ++			  struct strbuf *err)
      {
     -	for (; spf->count < spf->r->index->cache_nr; spf->count++) {
     -		const struct cache_entry *ce = spf->r->index->cache[spf->count];
    @@ submodule.c: static struct repository *get_submodule_repo_for(struct repository
      		struct fetch_task *task;
      
      		if (!S_ISGITLINK(ce->ce_mode))
    -@@ submodule.c: get_fetch_task(struct submodule_parallel_fetch *spf,
    - 		if (!task)
    - 			continue;
    - 
    -+		/*
    -+		 * We might have already considered this submodule
    -+		 * because we saw it when iterating the changed
    -+		 * submodule names.
    -+		 */
    -+		if (string_list_lookup(&spf->seen_submodule_names,
    -+				       task->sub->name))
    -+			continue;
    -+
    - 		switch (get_fetch_recurse_config(task->sub, spf))
    - 		{
    - 		default:
    -@@ submodule.c: get_fetch_task(struct submodule_parallel_fetch *spf,
    +@@ submodule.c: get_fetch_task(struct submodule_parallel_fetch *spf, struct strbuf *err)
      				strbuf_addf(err, _("Fetching submodule %s%s\n"),
      					    spf->prefix, ce->name);
      
    @@ submodule.c: get_fetch_task(struct submodule_parallel_fetch *spf,
      			return task;
      		} else {
      			struct strbuf empty_submodule_path = STRBUF_INIT;
    -@@ submodule.c: get_fetch_task(struct submodule_parallel_fetch *spf,
    +@@ submodule.c: get_fetch_task(struct submodule_parallel_fetch *spf, struct strbuf *err)
      	return NULL;
      }
      
     +static struct fetch_task *
     +get_fetch_task_from_changed(struct submodule_parallel_fetch *spf,
    -+			    const char **default_argv, struct strbuf *err)
    ++			    struct strbuf *err)
     +{
     +	for (; spf->changed_count < spf->changed_submodule_names.nr;
     +	     spf->changed_count++) {
    @@ submodule.c: get_fetch_task(struct submodule_parallel_fetch *spf,
     +		struct changed_submodule_data *cs_data = item.util;
     +		struct fetch_task *task;
     +
    -+		/*
    -+		 * We might have already considered this submodule
    -+		 * because we saw it in the index.
    -+		 */
    -+		if (string_list_lookup(&spf->seen_submodule_names, item.string))
    ++		if (!is_tree_submodule_active(spf->r, cs_data->super_oid,cs_data->path))
     +			continue;
     +
    -+		task = fetch_task_create(spf->r, cs_data->path,
    ++		task = fetch_task_create(spf, cs_data->path,
     +					 cs_data->super_oid);
     +		if (!task)
     +			continue;
     +
    -+		switch (get_fetch_recurse_config(task->sub, spf)) {
    -+		default:
    -+		case RECURSE_SUBMODULES_DEFAULT:
    -+		case RECURSE_SUBMODULES_ON_DEMAND:
    -+			*default_argv = "on-demand";
    -+			break;
    -+		case RECURSE_SUBMODULES_ON:
    -+			*default_argv = "yes";
    -+			break;
    -+		case RECURSE_SUBMODULES_OFF:
    -+			continue;
    -+		}
    -+
    -+		task->repo = get_submodule_repo_for(spf->r, task->sub->path,
    -+						    cs_data->super_oid);
     +		if (!task->repo) {
    ++			strbuf_addf(err, _("Could not access submodule '%s' at commit %s\n"),
    ++				    cs_data->path,
    ++				    find_unique_abbrev(cs_data->super_oid, DEFAULT_ABBREV));
    ++
     +			fetch_task_release(task);
     +			free(task);
    -+
    -+			strbuf_addf(err, _("Could not access submodule '%s'\n"),
    -+				    cs_data->path);
     +			continue;
     +		}
    -+		if (!is_tree_submodule_active(spf->r, cs_data->super_oid,
    -+					      task->sub->path))
    -+			continue;
     +
     +		if (!spf->quiet)
     +			strbuf_addf(err,
    @@ submodule.c: get_fetch_task(struct submodule_parallel_fetch *spf,
     +				    spf->prefix, task->sub->path,
     +				    find_unique_abbrev(cs_data->super_oid,
     +						       DEFAULT_ABBREV));
    ++
     +		spf->changed_count++;
    ++		/*
    ++		 * NEEDSWORK: A submodule unpopulated by "git rm" will
    ++		 * have core.worktree set, but the actual core.worktree
    ++		 * directory won't exist, causing the child process to
    ++		 * fail. Forcibly set --work-tree until we get smarter
    ++		 * handling for core.worktree in unpopulated submodules.
    ++		 */
    ++		strvec_push(&task->git_args, "--work-tree=.");
     +		return task;
     +	}
     +	return NULL;
    @@ submodule.c: get_fetch_task(struct submodule_parallel_fetch *spf,
      			      void *data, void **task_cb)
      {
      	struct submodule_parallel_fetch *spf = data;
    - 	const char *default_argv = NULL;
    --	struct fetch_task *task = get_fetch_task(spf, &default_argv, err);
    +-	struct fetch_task *task = get_fetch_task(spf, err);
     +	struct fetch_task *task =
    -+		get_fetch_task_from_index(spf, &default_argv, err);
    ++		get_fetch_task_from_index(spf, err);
     +	if (!task)
    -+		task = get_fetch_task_from_changed(spf, &default_argv, err);
    ++		task = get_fetch_task_from_changed(spf, err);
      
      	if (task) {
      		struct strbuf submodule_prefix = STRBUF_INIT;
    +@@ submodule.c: static int get_next_submodule(struct child_process *cp, struct strbuf *err,
    + 		prepare_submodule_repo_env_in_gitdir(&cp->env_array);
    + 		cp->git_cmd = 1;
    + 		strvec_init(&cp->args);
    ++		if (task->git_args.nr)
    ++			strvec_pushv(&cp->args, task->git_args.v);
    + 		strvec_pushv(&cp->args, spf->args.v);
    + 		strvec_push(&cp->args, task->default_argv);
    + 		strvec_push(&cp->args, "--submodule-prefix");
     @@ submodule.c: static int get_next_submodule(struct child_process *cp, struct strbuf *err,
      		*task_cb = task;
      
    @@ submodule.h: int should_update_submodules(void);
      
     
      ## t/t5526-fetch-submodules.sh ##
    +@@ t/t5526-fetch-submodules.sh: pwd=$(pwd)
    + 
    + check_sub() {
    + 	NEW_HEAD=$1 &&
    ++	SUPER_HEAD=$2 &&
    + 	cat <<-EOF >$pwd/expect.err.sub
    +-	Fetching submodule submodule
    ++	Fetching submodule submodule${SUPER_HEAD:+ at commit $SUPER_HEAD}
    + 	From $pwd/submodule
    + 	   OLD_HEAD..$NEW_HEAD  sub        -> origin/sub
    + 	EOF
    +@@ t/t5526-fetch-submodules.sh: check_sub() {
    + 
    + check_deep() {
    + 	NEW_HEAD=$1 &&
    ++	SUB_HEAD=$2 &&
    + 	cat <<-EOF >$pwd/expect.err.deep
    +-	Fetching submodule submodule/subdir/deepsubmodule
    ++	Fetching submodule submodule/subdir/deepsubmodule${SUB_HEAD:+ at commit $SUB_HEAD}
    + 	From $pwd/deepsubmodule
    + 	   OLD_HEAD..$NEW_HEAD  deep       -> origin/deep
    + 	EOF
     @@ t/t5526-fetch-submodules.sh: test_expect_success "'--recurse-submodules=on-demand' recurses as deep as necess
      	verify_fetch_result actual.err
      '
    @@ t/t5526-fetch-submodules.sh: test_expect_success "'--recurse-submodules=on-deman
     +	(
     +		cd downstream &&
     +		git checkout --recurse-submodules -b no-submodules &&
    -+		rm .gitmodules &&
    ++		git rm .gitmodules &&
     +		git rm submodule &&
    -+		git add .gitmodules &&
     +		git commit -m "no submodules" &&
     +		git checkout --recurse-submodules super
     +	)
     +'
     +
     +test_expect_success "'--recurse-submodules=on-demand' should fetch submodule commits if the submodule is changed but the index has no submodules" '
    -+	git -C downstream fetch --recurse-submodules &&
    -+	# Create new superproject commit with updated submodules
    -+	add_upstream_commit &&
    -+	(
    -+		cd submodule &&
    -+		(
    -+			cd subdir/deepsubmodule &&
    -+			git fetch &&
    -+			git checkout -q FETCH_HEAD
    -+		) &&
    -+		git add subdir/deepsubmodule &&
    -+		git commit -m "new deep submodule"
    -+	) &&
    -+	git add submodule &&
    -+	git commit -m "new submodule" &&
    -+
    ++	add_submodule_commits &&
    ++	add_superproject_commits &&
     +	# Fetch the new superproject commit
     +	(
     +		cd downstream &&
     +		git switch --recurse-submodules no-submodules &&
     +		git fetch --recurse-submodules=on-demand >../actual.out 2>../actual.err
     +	) &&
    -+	test_must_be_empty actual.out &&
    -+	git rev-parse --short HEAD >superhead &&
    -+	git -C submodule rev-parse --short HEAD >subhead &&
    -+	git -C deepsubmodule rev-parse --short HEAD >deephead &&
    -+	verify_fetch_result actual.err &&
    ++	super_head=$(git rev-parse --short HEAD) &&
    ++	sub_head=$(git -C submodule rev-parse --short HEAD) &&
    ++	deep_head=$(git -C submodule/subdir/deepsubmodule rev-parse --short HEAD) &&
    ++
    ++	# assert that these are fetched from commits, not the index
    ++	check_sub $sub_head $super_head &&
    ++	check_deep $deep_head $sub_head &&
     +
    -+	# Assert that the fetch happened at the non-HEAD commits
    -+	grep "Fetching submodule submodule at commit $superhead" actual.err &&
    -+	grep "Fetching submodule submodule/subdir/deepsubmodule at commit $subhead" actual.err
    ++	test_must_be_empty actual.out &&
    ++	verify_fetch_result actual.err
     +'
     +
     +test_expect_success "'--recurse-submodules' should fetch submodule commits if the submodule is changed but the index has no submodules" '
    -+	# Fetch any leftover commits from other tests.
    -+	git -C downstream fetch --recurse-submodules &&
    -+	# Create new superproject commit with updated submodules
    -+	add_upstream_commit &&
    -+	(
    -+		cd submodule &&
    -+		(
    -+			cd subdir/deepsubmodule &&
    -+			git fetch &&
    -+			git checkout -q FETCH_HEAD
    -+		) &&
    -+		git add subdir/deepsubmodule &&
    -+		git commit -m "new deep submodule"
    -+	) &&
    -+	git add submodule &&
    -+	git commit -m "new submodule" &&
    -+
    ++	add_submodule_commits &&
    ++	add_superproject_commits &&
     +	# Fetch the new superproject commit
     +	(
     +		cd downstream &&
     +		git switch --recurse-submodules no-submodules &&
     +		git fetch --recurse-submodules >../actual.out 2>../actual.err
     +	) &&
    -+	test_must_be_empty actual.out &&
    -+	git rev-parse --short HEAD >superhead &&
    -+	git -C submodule rev-parse --short HEAD >subhead &&
    -+	git -C deepsubmodule rev-parse --short HEAD >deephead &&
    -+	verify_fetch_result actual.err &&
    ++	super_head=$(git rev-parse --short HEAD) &&
    ++	sub_head=$(git -C submodule rev-parse --short HEAD) &&
    ++	deep_head=$(git -C submodule/subdir/deepsubmodule rev-parse --short HEAD) &&
    ++
    ++	# assert that these are fetched from commits, not the index
    ++	check_sub $sub_head $super_head &&
    ++	check_deep $deep_head $sub_head &&
     +
    -+	# Assert that the fetch happened at the non-HEAD commits
    -+	grep "Fetching submodule submodule at commit $superhead" actual.err &&
    -+	grep "Fetching submodule submodule/subdir/deepsubmodule at commit $subhead" actual.err
    ++	test_must_be_empty actual.out &&
    ++	verify_fetch_result actual.err
     +'
     +
     +test_expect_success "'--recurse-submodules' should ignore changed, inactive submodules" '
    -+	# Fetch any leftover commits from other tests.
    -+	git -C downstream fetch --recurse-submodules &&
    -+	# Create new superproject commit with updated submodules
    -+	add_upstream_commit &&
    -+	(
    -+		cd submodule &&
    -+		(
    -+			cd subdir/deepsubmodule &&
    -+			git fetch &&
    -+			git checkout -q FETCH_HEAD
    -+		) &&
    -+		git add subdir/deepsubmodule &&
    -+		git commit -m "new deep submodule"
    -+	) &&
    -+	git add submodule &&
    -+	git commit -m "new submodule" &&
    ++	add_submodule_commits &&
    ++	add_superproject_commits &&
     +
     +	# Fetch the new superproject commit
     +	(
    @@ t/t5526-fetch-submodules.sh: test_expect_success "'--recurse-submodules=on-deman
     +		git -c submodule.submodule.active=false fetch --recurse-submodules >../actual.out 2>../actual.err
     +	) &&
     +	test_must_be_empty actual.out &&
    -+	git rev-parse --short HEAD >superhead &&
    ++	super_head=$(git rev-parse --short HEAD) &&
    ++	check_super $super_head &&
     +	# Neither should be fetched because the submodule is inactive
    -+	rm subhead &&
    -+	rm deephead &&
    ++	rm expect.err.sub &&
    ++	rm expect.err.deep &&
     +	verify_fetch_result actual.err
     +'
     +
    @@ t/t5526-fetch-submodules.sh: test_expect_success "'--recurse-submodules=on-deman
     +'
     +
     +test_expect_success "'--recurse-submodules' should fetch submodule commits in changed submodules and the index" '
    -+	# Fetch any leftover commits from other tests.
    -+	git -C downstream fetch --recurse-submodules &&
     +	# Create new commit in origin/super
    -+	add_upstream_commit &&
    -+	(
    -+		cd submodule &&
    -+		(
    -+			cd subdir/deepsubmodule &&
    -+			git fetch &&
    -+			git checkout -q FETCH_HEAD
    -+		) &&
    -+		git add subdir/deepsubmodule &&
    -+		git commit -m "new deep submodule"
    -+	) &&
    -+	git add submodule &&
    -+	git commit -m "new submodule" &&
    ++	add_submodule_commits &&
    ++	add_superproject_commits &&
     +
     +	# Create new commit in origin/super-sub2-only
     +	git checkout super-sub2-only &&
    @@ t/t5526-fetch-submodules.sh: test_expect_success "'--recurse-submodules=on-deman
     +		git fetch --recurse-submodules >../actual.out 2>../actual.err
     +	) &&
     +	test_must_be_empty actual.out &&
    -+
    -+	# Assert that the submodules in the super branch are fetched
    -+	git rev-parse --short HEAD >superhead &&
    -+	git -C submodule rev-parse --short HEAD >subhead &&
    -+	git -C deepsubmodule rev-parse --short HEAD >deephead &&
    -+	verify_fetch_result actual.err &&
    -+	# grep for the exact line to check that the submodule is read
    -+	# from the index, not from a commit
    -+	grep "^Fetching submodule submodule\$" actual.err &&
    -+
    -+	# Assert that super-sub2-only and submodule2 were fetched even
    -+	# though another branch is checked out
    ++	deep_head=$(git -C submodule/subdir/deepsubmodule rev-parse --short HEAD) &&
    ++	sub_head=$(git -C submodule rev-parse --short HEAD) &&
    ++	sub2_head=$(git -C submodule2 rev-parse --short HEAD) &&
    ++	super_head=$(git rev-parse --short HEAD) &&
     +	super_sub2_only_head=$(git rev-parse --short super-sub2-only) &&
    -+	grep -E "\.\.${super_sub2_only_head}\s+super-sub2-only\s+-> origin/super-sub2-only" actual.err &&
    -+	grep "Fetching submodule submodule2 at commit $super_sub2_only_head" actual.err &&
    -+	sub2head=$(git -C submodule2 rev-parse --short HEAD) &&
    -+	grep -E "\.\.${sub2head}\s+sub2\s+-> origin/sub2" actual.err
    ++
    ++	# Use test_cmp manually because verify_fetch_result does not
    ++	# consider submodule2. All the repos should be fetched, but only
    ++	# submodule2 should be read from a commit
    ++	cat <<-EOF > expect.err.combined &&
    ++	From $pwd/.
    ++	   OLD_HEAD..$super_head  super           -> origin/super
    ++	   OLD_HEAD..$super_sub2_only_head  super-sub2-only -> origin/super-sub2-only
    ++	Fetching submodule submodule
    ++	From $pwd/submodule
    ++	   OLD_HEAD..$sub_head  sub        -> origin/sub
    ++	Fetching submodule submodule/subdir/deepsubmodule
    ++	From $pwd/deepsubmodule
    ++	   OLD_HEAD..$deep_head  deep       -> origin/deep
    ++	Fetching submodule submodule2 at commit $super_sub2_only_head
    ++	From $pwd/submodule2
    ++	   OLD_HEAD..$sub2_head  sub2       -> origin/sub2
    ++	EOF
    ++	sed -E "s/[0-9a-f]+\.\./OLD_HEAD\.\./" actual.err >actual.err.cmp &&
    ++	test_cmp expect.err.combined actual.err.cmp
     +'
     +
      test_expect_success "'--recurse-submodules=on-demand' stops when no new submodule commits are found in the superproject (and ignores config)" '
    - 	add_upstream_commit &&
    + 	add_submodule_commits &&
      	echo a >> file &&
    +@@ t/t5526-fetch-submodules.sh: test_expect_success 'recursive fetch after deinit a submodule' '
    + 	test_cmp expect actual
    + '
    + 
    ++test_expect_success 'setup repo with upstreams that share a submodule name' '
    ++	mkdir same-name-1 &&
    ++	(
    ++		cd same-name-1 &&
    ++		git init &&
    ++		test_commit --no-tag a
    ++	) &&
    ++	git clone same-name-1 same-name-2 &&
    ++	# same-name-1 and same-name-2 both add a submodule with the
    ++	# name "submodule"
    ++	(
    ++		cd same-name-1 &&
    ++		mkdir submodule &&
    ++		git -C submodule init &&
    ++		test_commit -C submodule --no-tag a1 &&
    ++		git submodule add "$pwd/same-name-1/submodule" &&
    ++		git add submodule &&
    ++		git commit -m "super-a1"
    ++	) &&
    ++	(
    ++		cd same-name-2 &&
    ++		mkdir submodule &&
    ++		git -C submodule init &&
    ++		test_commit -C submodule --no-tag a2 &&
    ++		git submodule add "$pwd/same-name-2/submodule" &&
    ++		git add submodule &&
    ++		git commit -m "super-a2"
    ++	) &&
    ++	git clone same-name-1 -o same-name-1 same-name-downstream &&
    ++	(
    ++		cd same-name-downstream &&
    ++		git remote add same-name-2 ../same-name-2 &&
    ++		git fetch --all &&
    ++		# init downstream with same-name-1
    ++		git submodule update --init
    ++	)
    ++'
    ++
    ++test_expect_success 'fetch --recurse-submodules updates name-conflicted, populated submodule' '
    ++	test_when_finished "git -C same-name-downstream checkout master" &&
    ++	(
    ++		cd same-name-1 &&
    ++		test_commit -C submodule --no-tag b1 &&
    ++		git add submodule &&
    ++		git commit -m "super-b1"
    ++	) &&
    ++	(
    ++		cd same-name-2 &&
    ++		test_commit -C submodule --no-tag b2 &&
    ++		git add submodule &&
    ++		git commit -m "super-b2"
    ++	) &&
    ++	(
    ++		cd same-name-downstream &&
    ++		# even though the .gitmodules is correct, we cannot
    ++		# fetch from same-name-2
    ++		git checkout same-name-2/master &&
    ++		git fetch --recurse-submodules same-name-1 &&
    ++		test_must_fail git fetch --recurse-submodules same-name-2
    ++	) &&
    ++	super_head1=$(git -C same-name-1 rev-parse HEAD) &&
    ++	git -C same-name-downstream cat-file -e $super_head1 &&
    ++
    ++	super_head2=$(git -C same-name-2 rev-parse HEAD) &&
    ++	git -C same-name-downstream cat-file -e $super_head2 &&
    ++
    ++	sub_head1=$(git -C same-name-1/submodule rev-parse HEAD) &&
    ++	git -C same-name-downstream/submodule cat-file -e $sub_head1 &&
    ++
    ++	sub_head2=$(git -C same-name-2/submodule rev-parse HEAD) &&
    ++	test_must_fail git -C same-name-downstream/submodule cat-file -e $sub_head2
    ++'
    ++
    ++test_expect_success 'fetch --recurse-submodules updates name-conflicted, unpopulated submodule' '
    ++	(
    ++		cd same-name-1 &&
    ++		test_commit -C submodule --no-tag c1 &&
    ++		git add submodule &&
    ++		git commit -m "super-c1"
    ++	) &&
    ++	(
    ++		cd same-name-2 &&
    ++		test_commit -C submodule --no-tag c2 &&
    ++		git add submodule &&
    ++		git commit -m "super-c2"
    ++	) &&
    ++	(
    ++		cd same-name-downstream &&
    ++		git checkout master &&
    ++		git rm .gitmodules &&
    ++		git rm submodule &&
    ++		git commit -m "no submodules" &&
    ++		git fetch --recurse-submodules same-name-1
    ++	) &&
    ++	head1=$(git -C same-name-1/submodule rev-parse HEAD) &&
    ++	head2=$(git -C same-name-2/submodule rev-parse HEAD) &&
    ++	(
    ++		cd same-name-downstream/.git/modules/submodule &&
    ++		# The submodule has core.worktree pointing to the "git
    ++		# rm"-ed directory, overwrite the invalid value.
    ++		git --work-tree=. cat-file -e $head1 &&
    ++		test_must_fail git --work-tree=. cat-file -e $head2
    ++	)
    ++'
    ++
    + test_done
 8:  8aa68111b0 <  -:  ---------- submodule: read shallows when finding changed submodules
 9:  05a8b93154 ! 10:  e1ac74eee4 submodule: fix latent check_has_commit() bug
    @@ submodule.c: static int check_has_commit(const struct object_id *oid, void *data
      
      	type = oid_object_info(&subrepo, oid, NULL);
     @@ submodule.c: static int submodule_has_commits(struct repository *r,
    - {
    - 	struct has_commit_data has_commit = { r, 1, path, super_oid };
    + 		.super_oid = super_oid
    + 	};
      
     -	/*
     -	 * Perform a cheap, but incorrect check for the existence of 'commits'.

base-commit: 679e3693aba0c17af60c031f7eef68f2296b8dad
-- 
2.33.GIT

