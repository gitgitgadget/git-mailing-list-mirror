Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31422C33C9E
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 04:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9693207E0
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 04:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USd3gH9Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbgAGEx2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 23:53:28 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45933 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbgAGEx2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jan 2020 23:53:28 -0500
Received: by mail-qk1-f194.google.com with SMTP id x1so41566763qkl.12
        for <git@vger.kernel.org>; Mon, 06 Jan 2020 20:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4KKdlByYdzHx1cbaKt7AiHZFK4UjSyO0Sd5+gdZBhWs=;
        b=USd3gH9Zn49sD6LjT3bcW0BIH7k3jkSjo34J5zarmrwQiGWP4GCtNjAyMIwuvgLMx8
         ZCyFcLWinUlLWRqEoYM9rXe3/PJTVkhYU6pwuD70kO9oV3nCRnLtIp5RrTdiPZkZrcBn
         9J3SlZ2H1aakN+mJR+nO0oTtP0+ghR26Q0pXUQV0QojhtnzA51yp5A3dmY8lsb/cC0IP
         HJmgoKVpF2ba5MCyOQLu+201CK19MQkW1QmsjtZV1680jD/8mOYHsbtM7IXNVC5Y9ieN
         Y6hbTYJaOefjLswTJvd7RaJUS0fXrVc5wEoGWUK1b+BtLiAfn5ewvmXKCRhCPmcBRGwr
         5TKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4KKdlByYdzHx1cbaKt7AiHZFK4UjSyO0Sd5+gdZBhWs=;
        b=Kt4kAj8Rqr1KZ/4vhY/enXl33EjjeVUNeaLsu+VFq+D8eELUfpa/aYemMr2eKz52HP
         faLIfTtpNywm+wWFdSa0B5fm089eyTYQjAbYdZy25tOXcvdy28B2aSBGRiYR8zS/CBwe
         LdUoV1U5pJJidwNw0bCElTEfnmWLH4vOz63yB5S2bf6Nk+2hrbTeAvFWI1W7hHx8cr1C
         +yQopNDiSOdwM8LoRRMT2uX4pvLibujqONxjiOaz2Uao4gO47QO/NJEz1BEO1ZN4ecKD
         hvFp/swWpKcmw/FBIGWUTE2i2hBTpBdLDVfkuwCgS18zF9jVzwtThl4/n67cPu5sIRda
         dfsA==
X-Gm-Message-State: APjAAAVl6s7Qx3MiHnGsaul8EkJQ0SVxBnHkiyKMmEb7rQa+A5/euh8U
        LrcrzOOrB4KMNvsuC57KDgQ981N2
X-Google-Smtp-Source: APXvYqwK8O9We/VOLAAhOUn5MDTEAsg6s08yDphkDNTy1iw6363XjCvo94X9OunmxTHLXa3QIdBD8g==
X-Received: by 2002:a05:620a:16c6:: with SMTP id a6mr87565332qkn.140.1578372806243;
        Mon, 06 Jan 2020 20:53:26 -0800 (PST)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id t2sm21663893qkc.31.2020.01.06.20.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 20:53:25 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 00/16] t: replace incorrect test_must_fail usage (part 2)
Date:   Mon,  6 Jan 2020 23:52:57 -0500
Message-Id: <cover.1578372682.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.25.0.rc1.180.g49a268d3eb
In-Reply-To: <cover.1577454401.git.liu.denton@gmail.com>
References: <cover.1577454401.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The overall scope of these patches is to replace inappropriate uses of
test_must_fail. IOW, we should only allow test_must_fail to run on `git`
and `test-tool`. Ultimately, we will conclude by making test_must_fail
error out on non-git commands. An advance view of the final series can
be found here[1].

This is the second part. It focuses on t[234]*.sh. The first part can be
found here[2].

Changes since v1:

* Rewrite commit messages to be shorter and use the present tense when
  referring to the present state

* Clean up as suggested by Eric

* Replace 12/16 with J6t's patch

* Drop "let sed open its own files"

[1]: (may be rebased at any time) https://github.com/Denton-L/git/tree/ready/cleanup-test-must-fail2
[2]: https://lore.kernel.org/git/cover.1576583819.git.liu.denton@gmail.com/

Denton Liu (15):
  t2018: remove trailing space from test description
  t2018: add space between function name and ()
  t2018: improve style of if-statement
  t2018: use test_expect_code for failing git commands
  t2018: teach do_checkout() to accept `!` arg
  t2018: don't lose return code of git commands
  t2018: replace "sha" with "oid"
  t3030: use test_path_is_missing()
  t3310: extract common notes_merge_files_gone()
  t3415: stop losing return codes of git commands
  t3415: increase granularity of test_auto_{fixup,squash}()
  t3419: stop losing return code of git command
  t3507: fix indentation
  t3507: use test_path_is_missing()
  t4124: only mark git command with test_must_fail

Johannes Sixt (1):
  t3504: do check for conflict marker after failed cherry-pick

 t/t2018-checkout-branch.sh            |  77 ++++++++-----
 t/t3030-merge-recursive.sh            |   2 +-
 t/t3310-notes-merge-manual-resolve.sh |  22 ++--
 t/t3415-rebase-autosquash.sh          | 153 +++++++++++++++++++-------
 t/t3419-rebase-patch-id.sh            |   3 +-
 t/t3504-cherry-pick-rerere.sh         |   6 +-
 t/t3507-cherry-pick-conflict.sh       |  28 ++---
 t/t4124-apply-ws-rule.sh              |  10 +-
 8 files changed, 205 insertions(+), 96 deletions(-)

Range-diff against v1:
 1:  7517159cc1 =  1:  a0199f1e48 t2018: remove trailing space from test description
 2:  0674eee69e !  2:  f0f541b520 t2018: add space between function name and ()
    @@ Metadata
      ## Commit message ##
         t2018: add space between function name and ()
     
    +    Add a space between the function name and () which brings the style in
    +    line with Git's coding guidelines.
    +
      ## t/t2018-checkout-branch.sh ##
     @@ t/t2018-checkout-branch.sh: test_description='checkout'
      #   2) HEAD is <sha>; if <sha> is not specified, the old HEAD is used.
 -:  ---------- >  3:  501eb147c3 t2018: improve style of if-statement
 3:  2451bff3af !  4:  587e53053f t2018: use test_must_fail for failing git commands
    @@ Metadata
     Author: Denton Liu <liu.denton@gmail.com>
     
      ## Commit message ##
    -    t2018: use test_must_fail for failing git commands
    +    t2018: use test_expect_code for failing git commands
     
    -    Before, when we expected `git diff` to fail, we negated its status with
    +    When we are expecting `git diff` to fail, we negate its status with
         `!`. However, if git ever exits unexpectedly, say due to a segfault, we
         would not be able to tell the difference between that and a controlled
    -    failure. Use `test_must_fail git diff` instead so that if an unepxected
    -    failure occurs, we can catch it.
    +    failure. Use `test_expect_code 1 git diff` instead so that if an
    +    unexpected failure occurs, we can catch it.
     
    -    We had some instances of `test_must_fail test_dirty_{un,}mergable`.
    -    However, `test_must_fail` should only be used on git commands. Teach
    -    test_dirty_{un,}mergable() to accept `!` as a potential first argument
    -    which will run the git command without test_must_fail(). This prevents
    -    the double-negation where we were effectively running
    -    `test_must_fail test_must_fail git diff ...`.
    +    We have some instances of `test_must_fail test_dirty_{un,}mergable`.
    +    However, `test_must_fail` should only be used on git commands. Convert
    +    these instances to use the `test_dirty_{un,}mergeable_discards_changes`
    +    helper functions so that we remove the double-negation.
     
         While we're at it, remove redirections to /dev/null since output is
    -    silenced when running without `-v` and debugging output is useful with
    -    `-v`, remove redirections to /dev/null as it is not useful.
    +    silenced when running without `-v` anyway.
     
      ## t/t2018-checkout-branch.sh ##
     @@ t/t2018-checkout-branch.sh: do_checkout () {
    @@ t/t2018-checkout-branch.sh: do_checkout () {
      
      test_dirty_unmergeable () {
     -	! git diff --exit-code >/dev/null
    -+	should_fail="test_expect_code 1" &&
    -+	if test "x$1" = "x!"
    -+	then
    -+		should_fail=
    -+	fi &&
    -+	$should_fail git diff --exit-code
    ++	test_expect_code 1 git diff --exit-code
    ++}
    ++
    ++test_dirty_unmergeable_discards_changes () {
    ++	git diff --exit-code
      }
      
      setup_dirty_unmergeable () {
    @@ t/t2018-checkout-branch.sh: setup_dirty_unmergeable () {
      
      test_dirty_mergeable () {
     -	! git diff --cached --exit-code >/dev/null
    -+	should_fail="test_expect_code 1"  &&
    -+	if test "x$1" = "x!"
    -+	then
    -+		should_fail=
    -+	fi &&
    -+	$should_fail git diff --cached --exit-code
    ++	test_expect_code 1 git diff --cached --exit-code
    ++}
    ++
    ++test_dirty_mergeable_discards_changes () {
    ++	git diff --cached --exit-code
      }
      
      setup_dirty_mergeable () {
    @@ t/t2018-checkout-branch.sh: test_expect_success 'checkout -f -b to a new branch
      	# still dirty and on branch1
      	do_checkout branch2 $HEAD1 "-f -b" &&
     -	test_must_fail test_dirty_unmergeable
    -+	test_dirty_unmergeable !
    ++	test_dirty_unmergeable_discards_changes
      '
      
      test_expect_success 'checkout -b to a new branch preserves mergeable changes' '
    @@ t/t2018-checkout-branch.sh: test_expect_success 'checkout -f -b to a new branch
      	setup_dirty_mergeable &&
      	do_checkout branch2 $HEAD1 "-f -b" &&
     -	test_must_fail test_dirty_mergeable
    -+	test_dirty_mergeable !
    ++	test_dirty_mergeable_discards_changes
      '
      
      test_expect_success 'checkout -b to an existing branch fails' '
    @@ t/t2018-checkout-branch.sh: test_expect_success 'checkout -B to an existing bran
      	# still dirty and on branch1
      	do_checkout branch2 $HEAD1 "-f -B" &&
     -	test_must_fail test_dirty_unmergeable
    -+	test_dirty_unmergeable !
    ++	test_dirty_unmergeable_discards_changes
      '
      
      test_expect_success 'checkout -B to an existing branch preserves mergeable changes' '
    @@ t/t2018-checkout-branch.sh: test_expect_success 'checkout -f -B to an existing b
      	setup_dirty_mergeable &&
      	do_checkout branch2 $HEAD1 "-f -B" &&
     -	test_must_fail test_dirty_mergeable
    -+	test_dirty_mergeable !
    ++	test_dirty_mergeable_discards_changes
      '
      
      test_expect_success 'checkout -b <describe>' '
 4:  bc6330557e !  5:  c43c11b912 t2018: teach do_checkout() to accept `!` arg
    @@ Metadata
      ## Commit message ##
         t2018: teach do_checkout() to accept `!` arg
     
    -    Before, we were running `test_must_fail do_checkout`. However,
    +    We are running `test_must_fail do_checkout`. However,
         `test_must_fail` should only be used on git commands. Teach
         do_checkout() to accept `!` as a potential first argument which will
    -    prepend `test_must_fail` to the enclosed git command and skips the
    -    remainder of the function.
    +    cause the function to expect the "git checkout" to fail.
     
         This increases the granularity of the test as, instead of blindly
         checking that do_checkout() failed, we check that only the specific
    @@ Commit message
     
      ## t/t2018-checkout-branch.sh ##
     @@ t/t2018-checkout-branch.sh: test_description='checkout'
    + 
    + . ./test-lib.sh
    + 
    +-# Arguments: <branch> <sha> [<checkout options>]
    ++# Arguments: [!] <branch> <sha> [<checkout options>]
    + #
    + # Runs "git checkout" to switch to <branch>, testing that
    + #
    +@@ t/t2018-checkout-branch.sh: test_description='checkout'
    + #   2) HEAD is <sha>; if <sha> is not specified, the old HEAD is used.
      #
      # If <checkout options> is not specified, "git checkout" is run with -b.
    ++#
    ++# If the first argument is `!`, "git checkout" is expected to fail when
    ++# it is run.
      do_checkout () {
     +	should_fail= &&
     +	if test "x$1" = "x!"
     +	then
    -+		should_fail=test_must_fail &&
    ++		should_fail=yes &&
     +		shift
     +	fi &&
      	exp_branch=$1 &&
    @@ t/t2018-checkout-branch.sh: do_checkout () {
      	fi
      
     -	git checkout $opts $exp_branch $exp_sha &&
    -+	$should_fail git checkout $opts $exp_branch $exp_sha &&
    - 
    +-
     -	test $exp_ref = $(git rev-parse --symbolic-full-name HEAD) &&
     -	test $exp_sha = $(git rev-parse --verify HEAD)
    -+	if test -z "$should_fail"
    ++	if test -n "$should_fail"
     +	then
    ++		test_must_fail git checkout $opts $exp_branch $exp_sha
    ++	else
    ++		git checkout $opts $exp_branch $exp_sha &&
     +		test $exp_ref = $(git rev-parse --symbolic-full-name HEAD) &&
     +		test $exp_sha = $(git rev-parse --verify HEAD)
     +	fi
 5:  fb2b865e6a !  6:  e09a70f6ca t2018: don't lose return code of git commands
    @@ Metadata
      ## Commit message ##
         t2018: don't lose return code of git commands
     
    -    We had some git commands wrapped in non-assignment command substitutions
    -    which would result in their return codes to be lost. Rewrite these
    -    instances so that their return codes are now checked.
    +    Fix invocations of git commands so their exit codes are not lost
    +    within non-assignment command substitutions.
     
      ## t/t2018-checkout-branch.sh ##
     @@ t/t2018-checkout-branch.sh: do_checkout () {
    - 	exp_ref="refs/heads/$exp_branch" &&
    - 
    - 	# if <sha> is not specified, use HEAD.
    --	exp_sha=${2:-$(git rev-parse --verify HEAD)} &&
    -+	head=$(git rev-parse --verify HEAD) &&
    -+	exp_sha=${2:-$head} &&
    - 
    - 	# default options for git checkout: -b
    - 	if [ -z "$3" ]; then
    -@@ t/t2018-checkout-branch.sh: do_checkout () {
    - 
    - 	if test -z "$should_fail"
    - 	then
    + 		test_must_fail git checkout $opts $exp_branch $exp_sha
    + 	else
    + 		git checkout $opts $exp_branch $exp_sha &&
     -		test $exp_ref = $(git rev-parse --symbolic-full-name HEAD) &&
     -		test $exp_sha = $(git rev-parse --verify HEAD)
     +		echo "$exp_ref" >ref.expect &&
 6:  7c26b921c3 !  7:  71f84811c7 t2018: replace "sha" with "oid"
    @@ t/t2018-checkout-branch.sh: test_description='checkout'
      
      . ./test-lib.sh
      
    --# Arguments: <branch> <sha> [<checkout options>]
    -+# Arguments: <branch> <oid> [<checkout options>]
    +-# Arguments: [!] <branch> <sha> [<checkout options>]
    ++# Arguments: [!] <branch> <oid> [<checkout options>]
      #
      # Runs "git checkout" to switch to <branch>, testing that
      #
    @@ t/t2018-checkout-branch.sh: test_description='checkout'
     +#   2) HEAD is <oid>; if <oid> is not specified, the old HEAD is used.
      #
      # If <checkout options> is not specified, "git checkout" is run with -b.
    - do_checkout () {
    + #
     @@ t/t2018-checkout-branch.sh: do_checkout () {
      	exp_branch=$1 &&
      	exp_ref="refs/heads/$exp_branch" &&
      
     -	# if <sha> is not specified, use HEAD.
    +-	exp_sha=${2:-$(git rev-parse --verify HEAD)} &&
     +	# if <oid> is not specified, use HEAD.
    - 	head=$(git rev-parse --verify HEAD) &&
    --	exp_sha=${2:-$head} &&
    -+	exp_oid=${2:-$head} &&
    ++	exp_oid=${2:-$(git rev-parse --verify HEAD)} &&
      
      	# default options for git checkout: -b
    - 	if [ -z "$3" ]; then
    + 	if test -z "$3"
     @@ t/t2018-checkout-branch.sh: do_checkout () {
    - 		opts="$3"
    - 	fi
      
    --	$should_fail git checkout $opts $exp_branch $exp_sha &&
    -+	$should_fail git checkout $opts $exp_branch $exp_oid &&
    - 
    - 	if test -z "$should_fail"
    + 	if test -n "$should_fail"
      	then
    +-		test_must_fail git checkout $opts $exp_branch $exp_sha
    ++		test_must_fail git checkout $opts $exp_branch $exp_oid
    + 	else
    +-		git checkout $opts $exp_branch $exp_sha &&
    ++		git checkout $opts $exp_branch $exp_oid &&
      		echo "$exp_ref" >ref.expect &&
      		git rev-parse --symbolic-full-name HEAD >ref.actual &&
      		test_cmp ref.expect ref.actual &&
 7:  9e37358f38 !  8:  f0da1d6350 t3030: use test_path_is_missing()
    @@ Metadata
      ## Commit message ##
         t3030: use test_path_is_missing()
     
    -    Previously, we would use `test_must_fail test -d` to ensure that the
    -    directory is removed. However, test_must_fail() should only be used for
    -    git commands. Use test_path_is_missing() instead to check that the
    -    directory has been removed.
    +    We use `test_must_fail test -d` to ensure that the directory is removed.
    +    However, test_must_fail() should only be used for git commands. Use
    +    test_path_is_missing() instead to check that the directory has been
    +    removed.
     
      ## t/t3030-merge-recursive.sh ##
     @@ t/t3030-merge-recursive.sh: test_expect_success 'merge removes empty directories' '
 8:  9705769841 !  9:  46fe82b856 t3310: extract common no_notes_merge_left()
    @@ Metadata
     Author: Denton Liu <liu.denton@gmail.com>
     
      ## Commit message ##
    -    t3310: extract common no_notes_merge_left()
    +    t3310: extract common notes_merge_files_gone()
     
    -    We had many statements which were duplicated. Extract and replace these
    -    duplicate statements with no_notes_merge_left().
    +    We have many statements which are duplicated. Extract and replace these
    +    duplicate statements with notes_merge_files_gone().
     
         While we're at it, replace the test_might_fail(), which should only be
    -    used on git commands, with a compound command that always returns 0,
    -    even if the underlying ls fails.
    +    used on git commands.
     
         Also, remove the redirection from stderr to /dev/null. This is because
         the test scripts automatically suppress output already. Otherwise, if a
    @@ t/t3310-notes-merge-manual-resolve.sh: verify_notes () {
      	test_cmp "expect_log_$notes_ref" "output_log_$notes_ref"
      }
      
    -+no_notes_merge_left () {
    ++notes_merge_files_gone () {
    ++	# No .git/NOTES_MERGE_* files left
     +	{ ls .git/NOTES_MERGE_* >output || :; } &&
     +	test_must_be_empty output
     +}
    @@ t/t3310-notes-merge-manual-resolve.sh: EOF
     -	# No .git/NOTES_MERGE_* files left
     -	test_might_fail ls .git/NOTES_MERGE_* >output 2>/dev/null &&
     -	test_must_be_empty output &&
    -+	no_notes_merge_left &&
    ++	notes_merge_files_gone &&
      	# Merge commit has pre-merge y and pre-merge z as parents
      	test "$(git rev-parse refs/notes/m^1)" = "$(cat pre_merge_y)" &&
      	test "$(git rev-parse refs/notes/m^2)" = "$(cat pre_merge_z)" &&
    @@ t/t3310-notes-merge-manual-resolve.sh: test_expect_success 'redo merge of z into
     -	# No .git/NOTES_MERGE_* files left
     -	test_might_fail ls .git/NOTES_MERGE_* >output 2>/dev/null &&
     -	test_must_be_empty output &&
    -+	no_notes_merge_left &&
    ++	notes_merge_files_gone &&
      	# m has not moved (still == y)
      	test "$(git rev-parse refs/notes/m)" = "$(cat pre_merge_y)" &&
      	# Verify that other notes refs has not changed (w, x, y and z)
    @@ t/t3310-notes-merge-manual-resolve.sh: EOF
     -	# No .git/NOTES_MERGE_* files left
     -	test_might_fail ls .git/NOTES_MERGE_* >output 2>/dev/null &&
     -	test_must_be_empty output &&
    -+	no_notes_merge_left &&
    ++	notes_merge_files_gone &&
      	# Merge commit has pre-merge y and pre-merge z as parents
      	test "$(git rev-parse refs/notes/m^1)" = "$(cat pre_merge_y)" &&
      	test "$(git rev-parse refs/notes/m^2)" = "$(cat pre_merge_z)" &&
    @@ t/t3310-notes-merge-manual-resolve.sh: EOF
     -	# No .git/NOTES_MERGE_* files left
     -	test_might_fail ls .git/NOTES_MERGE_* >output 2>/dev/null &&
     -	test_must_be_empty output &&
    -+	no_notes_merge_left &&
    ++	notes_merge_files_gone &&
      	# m has not moved (still == w)
      	test "$(git rev-parse refs/notes/m)" = "$(git rev-parse refs/notes/w)" &&
      	# Verify that other notes refs has not changed (w, x, y and z)
 9:  b6d8f6a6e1 ! 10:  32d2051b31 t3415: stop losing return codes of git commands
    @@ Metadata
      ## Commit message ##
         t3415: stop losing return codes of git commands
     
    -    When a command is in a non-assignment subshell, the return code will be
    -    lost in favour of the surrounding command's. Rewrite instances of this
    -    such that the return code of git commands is no longer lost.
    +    Fix invocations of git commands so their exit codes are not lost
    +    within non-assignment command substitutions.
     
      ## t/t3415-rebase-autosquash.sh ##
     @@ t/t3415-rebase-autosquash.sh: test_auto_fixup () {
10:  e2818d1761 ! 11:  8b716c6a81 t3415: increase granularity of test_auto_{fixup,squash}()
    @@ Metadata
      ## Commit message ##
         t3415: increase granularity of test_auto_{fixup,squash}()
     
    -    We used to use `test_must_fail test_auto_{fixup,squash}` which would
    +    We are using `test_must_fail test_auto_{fixup,squash}` which would
         ensure that the function failed. However, this is a little ham-fisted as
         there is no way of ensuring that the expected part of the function
         actually fails.
11:  0357bb8533 ! 12:  ea36028d53 t3419: stop losing return code of git command
    @@ Metadata
      ## Commit message ##
         t3419: stop losing return code of git command
     
    -    We had an instance of a git command in a non-assignment command
    -    substitution. Its return code was lost so we would not be able to detect
    -    if the command failed for some reason. Since we were testing to make
    -    sure the output of the command was empty, rewrite it in a more canonical
    -    way.
    +    Fix invocation of git command so its exit codes is not lost within
    +    a non-assignment command substitution.
     
      ## t/t3419-rebase-patch-id.sh ##
     @@ t/t3419-rebase-patch-id.sh: do_tests () {
12:  35e32f21e1 <  -:  ---------- t3504: don't use `test_must_fail test_cmp`
 -:  ---------- > 13:  88134bb6d1 t3504: do check for conflict marker after failed cherry-pick
13:  1c38a5b3f7 ! 14:  96310b7d28 t3507: fix indentation
    @@ Metadata
      ## Commit message ##
         t3507: fix indentation
     
    -    We had some test cases which were indented 7-spaces instead of a tab.
    -    Fix this by reindenting with a tab instead.
    +    We have some test cases which are indented 7-spaces instead of a tab.
    +    Reindent with a tab instead.
     
         This patch should appear empty with `--ignore-all-space`.
     
14:  7fa886809e = 15:  69125b8e2f t3507: use test_path_is_missing()
15:  e214e1a667 ! 16:  b93ebc0e42 t4124: only mark git command with test_must_fail
    @@ t/t4124-apply-ws-rule.sh: prepare_test_file () {
      }
      
      apply_patch () {
    -+	should_fail= &&
    ++	cmd_prefix= &&
     +	if test "x$1" = 'x!'
     +	then
    -+		should_fail=test_must_fail &&
    ++		cmd_prefix=test_must_fail &&
     +		shift
     +	fi &&
      	>target &&
      	sed -e "s|\([ab]\)/file|\1/target|" <patch |
     -	git apply "$@"
    -+	$should_fail git apply "$@"
    ++	$cmd_prefix git apply "$@"
      }
      
      test_fix () {
16:  31aa0c7d15 <  -:  ---------- t4124: let sed open its own files
-- 
2.25.0.rc1.180.g49a268d3eb

