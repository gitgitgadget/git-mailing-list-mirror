Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77AFDC47080
	for <git@archiver.kernel.org>; Mon, 31 May 2021 17:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 598DB60231
	for <git@archiver.kernel.org>; Mon, 31 May 2021 17:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbhEaRlH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 13:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbhEaRkp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 13:40:45 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2ACFC068EFC
        for <git@vger.kernel.org>; Mon, 31 May 2021 09:56:40 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id n2so11602854wrm.0
        for <git@vger.kernel.org>; Mon, 31 May 2021 09:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=BkNu8bOvAhMPqMHCT7xg+3kVtU4oSRbzMk0QcRi4wdc=;
        b=D9j3NEc3E09uF54LPtKsjDVWmcFxE9gJG8IfE06iV6rBErUSt1EwudijsiySWT8fwG
         hh+oZBAApm7iHM4xxOmzQMY6kRvXOZAoohETwRsxFm2CP/lfCnFIwO/AyNWlkdKOaFBx
         zlJjEUicHiJqLHEL1/Ij+nPRriHJ+ZKtfj8rJYOEoRrpDPNCeUw4vgyLtAOc4TZ6RaGM
         1IR2z16pb50jtwBbH9mG0vzaksA8cPMHkGa9SnvUyGLxKSKspaXSz73DDbycg0dpwBVX
         RMl7oP0XZBjiY9XXvpHB01KRdwQbuEGgV7DLyzKwDo/0kMc1vLpv8mV8toj278yP3Gru
         XQig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=BkNu8bOvAhMPqMHCT7xg+3kVtU4oSRbzMk0QcRi4wdc=;
        b=WSQFdyvz+hiMUhLclmFRqasJMeSKuuLLQE3w05AEYV7pDhwoZvByIDs+0v8NZdP+qY
         9ck7sZ27CX8GA7fEGSqC30750gVOnyACnbOCngtV325lXyt/itdl4zuY1foF/ZgdJT+x
         jiUp4/DXmvOb7jF0/UZ7jn6lwsHrDVao8KzPyX0o4MMOeEQLf8TdDcf+aMS38Aoo8CU3
         pvL4Y32Y8SDHSCyaGEts3KvsiwE1kZssawQXAQTbGNvNeKeHWVRJEl5vw6C2/j5azf8y
         rPokxyyE4/aE6qO9COrNG55eklNGyfxLfvlqqR0HemhAW1p2oTMRaKPOA/0rU38cf4i7
         TJ9w==
X-Gm-Message-State: AOAM532VB6zmVEXP+RWJgIp9xumORR1GVz7gSt7zaQXt5R5N+RTB6XCK
        YYhhTp8ZhaSKYMbqlk0zXox1TTq6o48=
X-Google-Smtp-Source: ABdhPJzGiHDIAsui6Dw7a6JL8mr/D9M5mOPNtoPbaWbVpLYKAjemGpxkLKnl/qQPekU24jrKnSsn1A==
X-Received: by 2002:a05:6000:10d1:: with SMTP id b17mr22950570wrx.281.1622480199281;
        Mon, 31 May 2021 09:56:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r14sm219083wrx.74.2021.05.31.09.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 09:56:38 -0700 (PDT)
Message-Id: <pull.1008.v3.git.git.1622480197.gitgitgadget@gmail.com>
In-Reply-To: <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
References: <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 31 May 2021 16:56:15 +0000
Subject: [PATCH v3 00/22] Prepare tests for reftable backend
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rewrites some tests to avoid direct filesystem access.

Introduces the test prereq REFFILES to mark other tests that depend on
specifics of the files ref backend.

changes in v3 (relative to v2 from Apr 27)

 * address avarab's feedback.

Han-Wen Nienhuys (22):
  t4202: split testcase for invalid HEAD symref and HEAD hash
  t/helper/ref-store: initialize oid in resolve-ref
  t9300: check ref existence using test-helper rather than a file system
    check
  t5601: read HEAD using rev-parse
  t1401: use tar to snapshot and restore repo state
  t1401-symbolic-ref: avoid direct filesystem access
  t1413: use tar to save and restore entire .git directory
  t1301: fix typo in error message
  t5000: reformat indentation to the latest fashion
  t5000: inspect HEAD using git-rev-parse
  t7003: use rev-parse rather than FS inspection
  t5304: restyle: trim empty lines, drop ':' before >
  t5304: use "reflog expire --all" to clear the reflog
  test-lib: provide test prereq REFFILES
  t1407: require REFFILES for for_each_reflog test
  t1414: mark corruption test with REFFILES
  t2017: mark --orphan/logAllRefUpdates=false test as REFFILES
  t1404: mark tests that muck with .git directly as REFFILES.
  t7900: stop checking for loose refs
  t7003: check reflog existence only for REFFILES
  t4202: mark bogus head hash test with REFFILES
  t1415: set REFFILES for test specific to storage format

 t/README                      |   6 ++
 t/helper/test-ref-store.c     |   2 +-
 t/t1301-shared-repo.sh        |   2 +-
 t/t1401-symbolic-ref.sh       |  25 ++++---
 t/t1404-update-ref-errors.sh  |  30 ++++-----
 t/t1407-worktree-ref-store.sh |   9 ++-
 t/t1413-reflog-detach.sh      |   5 +-
 t/t1414-reflog-walk.sh        |   4 +-
 t/t1415-worktree-refs.sh      |   5 +-
 t/t2017-checkout-orphan.sh    |   2 +-
 t/t4202-log.sh                |  18 +++--
 t/t5000-tar-tree.sh           | 122 +++++++++++++++++++---------------
 t/t5304-prune.sh              |  83 +++++++----------------
 t/t5601-clone.sh              |   3 +-
 t/t7003-filter-branch.sh      |   7 +-
 t/t7900-maintenance.sh        |   2 -
 t/t9300-fast-import.sh        |   2 +-
 t/test-lib.sh                 |   2 +
 18 files changed, 170 insertions(+), 159 deletions(-)


base-commit: 4e42405f00ecbbee412846f48cb0253efeebe726
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1008%2Fhanwen%2Freffiles-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1008/hanwen/reffiles-v3
Pull-Request: https://github.com/git/git/pull/1008

Range-diff vs v2:

  1:  8ad4a35cda70 !  1:  6d875c6d7579 t4202: split testcase for invalid HEAD symref and HEAD hash
     @@ t/t4202-log.sh: test_expect_success 'log --graph --no-walk is forbidden' '
      -test_expect_success 'log diagnoses bogus HEAD' '
      +test_expect_success 'log diagnoses bogus HEAD hash' '
       	git init empty &&
     ++	test_when_finished "rm -rf empty" &&
       	test_must_fail git -C empty log 2>stderr &&
       	test_i18ngrep does.not.have.any.commits stderr &&
       	echo 1234abcd >empty/.git/refs/heads/main &&
     @@ t/t4202-log.sh: test_expect_success 'log --graph --no-walk is forbidden' '
      +	test_i18ngrep broken stderr'
      +
      +test_expect_success 'log diagnoses bogus HEAD symref' '
     -+	rm -rf empty &&
      +	git init empty &&
      +	git --git-dir empty/.git symbolic-ref HEAD refs/heads/invalid.lock &&
       	test_must_fail git -C empty log 2>stderr &&
  2:  e6222944a3eb !  2:  7c6ef1dcadfc t/helper/ref-store: initialize oid in resolve-ref
     @@ Commit message
          provides a reliable mechanism for accessing REFNAME, while avoiding the implicit
          resolution to refs/heads/REFNAME.
      
     +    Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
       ## t/helper/test-ref-store.c ##
     @@ t/helper/test-ref-store.c: static int cmd_for_each_ref(struct ref_store *refs, c
       static int cmd_resolve_ref(struct ref_store *refs, const char **argv)
       {
      -	struct object_id oid;
     -+	struct object_id oid = { 0 };
     ++	struct object_id oid = *null_oid();
       	const char *refname = notnull(*argv++, "refname");
       	int resolve_flags = arg_flags(*argv++, "resolve-flags");
       	int flags;
  3:  c5855b0caa73 !  3:  130099d30aba t9300: check ref existence using test-helper rather than a file system check
     @@ Commit message
          t9300: check ref existence using test-helper rather than a file system check
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
     +    Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
      
       ## t/t9300-fast-import.sh ##
      @@ t/t9300-fast-import.sh: test_expect_success 'B: accept branch name "TEMP_TAG"' '
  4:  369c968ab837 !  4:  c898982255c1 t5601: read HEAD using rev-parse
     @@ Commit message
          t5601: read HEAD using rev-parse
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
     +    Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
      
       ## t/t5601-clone.sh ##
      @@ t/t5601-clone.sh: test_expect_success 'clone from original with relative alternate' '
  -:  ------------ >  5:  12d43ff6a9e5 t1401: use tar to snapshot and restore repo state
  5:  248d9ffe7927 !  6:  f05817d80565 t1401-symbolic-ref: avoid direct filesystem access
     @@ Metadata
       ## Commit message ##
          t1401-symbolic-ref: avoid direct filesystem access
      
     +    Use symbolic-ref and rev-parse to inspect refs.
     +
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
     +    Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
      
       ## t/t1401-symbolic-ref.sh ##
     -@@
     - test_description='basic symbolic-ref tests'
     - . ./test-lib.sh
     +@@ t/t1401-symbolic-ref.sh: test_expect_success 'setup' '
     + 	"$TAR" cf .git.tar .git/
     + '
       
     --# If the tests munging HEAD fail, they can break detection of
     --# the git repo, meaning that further tests will operate on
     --# the surrounding git repo instead of the trash directory.
     --reset_to_sane() {
     --	echo ref: refs/heads/foo >.git/HEAD
     --}
     --
      -test_expect_success 'symbolic-ref writes HEAD' '
     -+test_expect_success 'setup' '
     - 	git symbolic-ref HEAD refs/heads/foo &&
     +-	git symbolic-ref HEAD refs/heads/foo &&
      -	echo ref: refs/heads/foo >expect &&
      -	test_cmp expect .git/HEAD
     -+	test_commit file &&
     -+	"$TAR" cf .git.tar .git/
     - '
     - 
     +-'
     +-
      -test_expect_success 'symbolic-ref reads HEAD' '
      -	echo refs/heads/foo >expect &&
     -+reset_to_sane() {
     -+	rm -rf .git &&
     -+	"$TAR" xf .git.tar
     -+}
     -+
      +test_expect_success 'symbolic-ref read/write roundtrip' '
      +	git symbolic-ref HEAD refs/heads/read-write-roundtrip &&
      +	echo refs/heads/read-write-roundtrip >expect &&
  6:  e4e8fc1d4b4f !  7:  f6ab40c4e659 t1413: use tar to save and restore entire .git directory
     @@ Commit message
          This makes the test independent of the particulars of the storage formats.
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
     +    Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
      
       ## t/t1413-reflog-detach.sh ##
      @@ t/t1413-reflog-detach.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
  7:  89cc215c6014 !  8:  852bc0f3055d t1301: fix typo in error message
     @@ Commit message
          t1301: fix typo in error message
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
     +    Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
      
       ## t/t1301-shared-repo.sh ##
      @@ t/t1301-shared-repo.sh: test_expect_success POSIXPERM 'git reflog expire honors core.sharedRepository' '
  8:  e67b90847c4e !  9:  e76c1e71bcb0 t5000: reformat indentation to the latest fashion
     @@ Commit message
          t5000: reformat indentation to the latest fashion
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
     +    Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
      
       ## t/t5000-tar-tree.sh ##
      @@ t/t5000-tar-tree.sh: test_expect_success 'setup' '
     @@ t/t5000-tar-tree.sh: test_expect_success 'setup' '
      +test_expect_success 'populate workdir' '
      +	mkdir a &&
      +	echo simple textfile >a/a &&
     -+	ten=0123456789 && hundred=$ten$ten$ten$ten$ten$ten$ten$ten$ten$ten &&
     -+	echo long filename >a/four$hundred &&
     ++	ten=0123456789 &&
     ++	hundred="$ten$ten$ten$ten$ten$ten$ten$ten$ten$ten" &&
     ++	echo long filename >"a/four$hundred" &&
      +	mkdir a/bin &&
      +	test-tool genrandom "frotz" 500000 >a/bin/sh &&
      +	printf "A\$Format:%s\$O" "$SUBSTFORMAT" >a/substfile1 &&
      +	printf "A not substituted O" >a/substfile2 &&
     -+	if test_have_prereq SYMLINKS; then
     ++	if test_have_prereq SYMLINKS
     ++	then
      +		ln -s a a/l1
      +	else
      +		printf %s a >a/l1
      +	fi &&
     -+	(p=long_path_to_a_file && cd a &&
     -+		for depth in 1 2 3 4 5; do mkdir $p && cd $p; done &&
     -+		echo text >file_with_long_path) &&
     ++	(
     ++		p=long_path_to_a_file &&
     ++		cd a &&
     ++		for depth in 1 2 3 4 5
     ++		do
     ++			mkdir $p &&
     ++			cd $p
     ++		done &&
     ++		echo text >file_with_long_path
     ++	) &&
      +	(cd a && find .) | sort >a.lst
      +'
       
     @@ t/t5000-tar-tree.sh: check_added with_untracked2 untracked one/untracked
      -    'git archive in a bare repo' \
      -    '(cd bare.git && git archive HEAD) >b3.tar'
      +test_expect_success 'git archive in a bare repo' '
     -+	(cd bare.git && git archive HEAD) >b3.tar
     ++	git --git-dir bare.git archive HEAD >b3.tar
      +'
       
      -test_expect_success \
  9:  d6072a70ae7d ! 10:  3e748285876b t5000: inspect HEAD using git-rev-parse
     @@ Commit message
          t5000: inspect HEAD using git-rev-parse
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
     +    Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
      
       ## t/t5000-tar-tree.sh ##
      @@ t/t5000-tar-tree.sh: test_expect_success 'validate file modification time' '
 10:  4bf1bf16bca3 ! 11:  a0605387d153 t7003: use rev-parse rather than FS inspection
     @@ Commit message
          t7003: use rev-parse rather than FS inspection
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
     +    Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
      
       ## t/t7003-filter-branch.sh ##
      @@ t/t7003-filter-branch.sh: test_expect_success '--prune-empty is able to prune root commit' '
 11:  6f15c15573af ! 12:  c12406ac9655 t5304: restyle: trim empty lines, drop ':' before >
     @@ Commit message
          t5304: restyle: trim empty lines, drop ':' before >
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
     +    Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
      
       ## t/t5304-prune.sh ##
      @@ t/t5304-prune.sh: add_blob() {
 12:  d8e80d83b6f8 ! 13:  9ede1b73d523 t5304: use "reflog expire --all" to clear the reflog
     @@ Metadata
       ## Commit message ##
          t5304: use "reflog expire --all" to clear the reflog
      
     -    This is more explicit, and reduces the depency between test functions. It also
     -    is more amenable to use with reftable, which has no concept of (non)existence of
     -    a reflog
     +    This test checks that unreachable objects are really removed. For the test to
     +    work, it has to ensure that no reflog retain any reachable objects.
     +
     +    Previously, it did this by manipulating the file system to remove reflog in the
     +    first test, and relying on git not updating the reflog if the relevant logfile
     +    doesn't exist in follow-up tests.
     +
     +    Now, explicitly clear the reflog using 'reflog expire'. This reduces the
     +    dependency between test functions. It also is more amenable to use with
     +    reftable, which has no concept of (non)-existence of a reflog
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
     +    Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
      
       ## t/t5304-prune.sh ##
      @@ t/t5304-prune.sh: test_expect_success 'prune: prune nonsense parameters' '
 13:  180847f4db14 ! 14:  8c552699fdbc test-lib: provide test prereq REFFILES
     @@ Commit message
          introducing the reftable storage backend.
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
     +    Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
      
       ## t/README ##
      @@ t/README: use these, and "test_set_prereq" for how to define your own.
 14:  f3307b62bfd7 ! 15:  57fcd175fa72 t1407: require REFFILES for for_each_reflog test
     @@ Commit message
          that apparently also doesn't cause reflogs to be created for pseudorefs
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
     +    Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
      
       ## t/t1407-worktree-ref-store.sh ##
      @@ t/t1407-worktree-ref-store.sh: test_expect_success 'create_symref(FOO, refs/heads/main)' '
 15:  0d3b18cd3542 ! 16:  5fe2dc0efce9 t1414: mark corruption test with REFFILES
     @@ Metadata
       ## Commit message ##
          t1414: mark corruption test with REFFILES
      
     -    The reftable format guarantees that reflog entries are well-formed
     +    The test checks what happens if reflog and ref database disagree on the state of
     +    the latest commit. This seems to require accessing reflog storage directly.
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
     +    Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
      
       ## t/t1414-reflog-walk.sh ##
      @@ t/t1414-reflog-walk.sh: test_expect_success 'min/max age uses entry date to limit' '
     @@ t/t1414-reflog-walk.sh: test_expect_success 'min/max age uses entry date to limi
       '
       
      -test_expect_success 'walk prefers reflog to ref tip' '
     ++# Create a situation where the reflog and ref database disagree about the latest
     ++# state of HEAD.
      +test_expect_success REFFILES 'walk prefers reflog to ref tip' '
       	head=$(git rev-parse HEAD) &&
       	one=$(git rev-parse one) &&
 16:  b64e3e7ade15 ! 17:  496796d4e084 t2017: mark --orphan/logAllRefUpdates=false test as REFFILES
     @@ Commit message
          of the reflog file infeasible.
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
     +    Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
      
       ## t/t2017-checkout-orphan.sh ##
      @@ t/t2017-checkout-orphan.sh: test_expect_success '--orphan makes reflog by default' '
 17:  fcc2b714dd50 ! 18:  c9d199b84499 t1404: mark tests that muck with .git directly as REFFILES.
     @@ Commit message
          locking scheme, none of which applies to reftable.
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
     +    Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
      
       ## t/t1404-update-ref-errors.sh ##
      @@ t/t1404-update-ref-errors.sh: test_expect_success 'one new ref is a simple prefix of another' '
 18:  ff3b67c84c41 <  -:  ------------ t7900: mark pack-refs tests as REFFILES
  -:  ------------ > 19:  6919c15e5f98 t7900: stop checking for loose refs
 19:  24dcf05d8fa6 ! 20:  73f89faa3b0a t7003: check reflog existence only for REFFILES
     @@ Commit message
          t7003: check reflog existence only for REFFILES
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
     +    Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
      
       ## t/t7003-filter-branch.sh ##
      @@ t/t7003-filter-branch.sh: test_expect_success '--prune-empty is able to prune entire branch' '
 20:  a33cdfda74ff ! 21:  ff86cf916943 t4202: mark bogus head hash test with REFFILES
     @@ Metadata
       ## Commit message ##
          t4202: mark bogus head hash test with REFFILES
      
     -    In reftable, hashes are correctly formed by design
     +    In reftable, hashes are correctly formed by design.
     +
     +    Split off test for git-log in empty repo.
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
     +    Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
      
       ## t/t4202-log.sh ##
      @@ t/t4202-log.sh: test_expect_success 'log --graph --no-walk is forbidden' '
     @@ t/t4202-log.sh: test_expect_success 'log --graph --no-walk is forbidden' '
       '
       
      -test_expect_success 'log diagnoses bogus HEAD hash' '
     -+test_expect_success REFFILES 'log diagnoses bogus HEAD hash' '
     ++test_expect_success 'log on empty repo fails' '
       	git init empty &&
     + 	test_when_finished "rm -rf empty" &&
     + 	test_must_fail git -C empty log 2>stderr &&
     +-	test_i18ngrep does.not.have.any.commits stderr &&
     ++	test_i18ngrep does.not.have.any.commits stderr
     ++'
     ++
     ++test_expect_success REFFILES 'log diagnoses bogus HEAD hash' '
     ++	git init empty &&
     ++	test_when_finished "rm -rf empty" &&
     + 	echo 1234abcd >empty/.git/refs/heads/main &&
       	test_must_fail git -C empty log 2>stderr &&
     - 	test_i18ngrep does.not.have.any.commits stderr &&
     +-	test_i18ngrep broken stderr'
     ++	test_i18ngrep broken stderr
     ++'
     + 
     + test_expect_success 'log diagnoses bogus HEAD symref' '
     + 	git init empty &&
 21:  d7e5de8dba46 ! 22:  cbcbb2d78fc9 t1415: set REFFILES for test specific to storage format
     @@ Metadata
       ## Commit message ##
          t1415: set REFFILES for test specific to storage format
      
     -    Packing refs (and therefore checking that certain refs are not packed) is a
     -    property of the packed/loose ref storage. Add a comment to explain what the test
     -    checks.
     +    Packing refs (and therefore checking that certain refs are not packed)
     +    is a property of the packed/loose ref storage. Add a comment to explain
     +    what the test checks.
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
     +    Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
      
       ## t/t1415-worktree-refs.sh ##
      @@ t/t1415-worktree-refs.sh: test_expect_success 'setup' '
     @@ t/t1415-worktree-refs.sh: test_expect_success 'setup' '
       '
       
      -test_expect_success 'refs/worktree must not be packed' '
     -+# The 'packed-refs' files is stored directly in .git/. This means it is global
     ++# The 'packed-refs' file is stored directly in .git/. This means it is global
      +# to the repository, and can only contain refs that are shared across all
      +# worktrees.
      +test_expect_success REFFILES 'refs/worktree must not be packed' '

-- 
gitgitgadget
