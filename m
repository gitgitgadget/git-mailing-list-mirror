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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE5EC433B4
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 10:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 595B161164
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 10:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237773AbhD0Kjg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 06:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237485AbhD0KjK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 06:39:10 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629C1C061574
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 03:38:26 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id x5so8650570wrv.13
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 03:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vFWlOnDA7sOJJOObvq/UbdhVyXzzigiFxKgOFULeu3s=;
        b=eqK0RduutDcwIZwCMLoKxOIfOIbZUJ6RVIkxqz/q7SDt/y2hGiXtA1LNB8UEb0hbnJ
         8dw5JQvVghEwGScwkFtKuu+InnrqFt+MdEB8iFD6z29GpEqhswu0XVV8WXHi+dqu32bZ
         jSAavgRWaV+MJ+PG6zqj7hyO3bZy7sfEjdVGtGzc8CnnnDeUwGqBByTMNjI/TVyFee3w
         LKGBijMeByxBwJiJpGjhe9F6+TrYIOJtzpTHhD8U+rC2JC5QDZtWyCUwXoS3IcWcR68+
         edR9Ebyiu9OXuB9mSYo34/RzwW/fG5DWuxcdCadwtS9rImJntaiDBgh14TfJH8dzoOvd
         a+9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vFWlOnDA7sOJJOObvq/UbdhVyXzzigiFxKgOFULeu3s=;
        b=ex8tLPiA3ZlOusKmAAok2fQawC7TDTZEHnyO3e+0ZbnRcRUxNgZBrOVvi+j763CqE+
         4xIh4sI+mtORkeEMdVG3k1neRjkKH9XX29F14jG9saG0TTJR4xutnABs5gQ62lY9ochf
         nQRrSLbS6ltcWqIyavX8qUEMZsX9SIAbRvJdPN1s8Tea2FyGlOvNMMDe+phZWeaFR8PK
         6WZ6ClcOlJVBl5G6iNc311tUIrMWCy3Ut+xvP+izGzq3Vena8KCancm+Oyz2CKwZ2vKj
         sjZtbowlpJz1VL614YpV7eLYDk30lDRmTAtidaR9KIUqvDfH8keUof4STLK3Yt769dmb
         jEHg==
X-Gm-Message-State: AOAM532TzmugbljjzKR08/qFjKcr3gQvqDyHtcZC4V4d4EUWcFmAsfVE
        RUU/ni+OUvdZrSoYQ6qwAeeTLKRKBTQ=
X-Google-Smtp-Source: ABdhPJyQT8aBAAtrf7DW+plGcIMJ+KUJh++HdfqGHbjIa30GKw+6s/UFAj1g6WsndGk73senhPN2Jg==
X-Received: by 2002:a05:6000:1843:: with SMTP id c3mr29456012wri.361.1619519905065;
        Tue, 27 Apr 2021 03:38:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l25sm20428853wmi.17.2021.04.27.03.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 03:38:24 -0700 (PDT)
Message-Id: <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
In-Reply-To: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 27 Apr 2021 10:38:01 +0000
Subject: [PATCH v2 00/21] Prepare tests for reftable backend
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rewrites some tests to avoid direct filesystem access.

Introduces the test prereq REFFILES to mark other tests that depend on
specifics of the files ref backend.

changes in v2 (relative to v1 from Apr 19)

 * t9300: use ref-store test-helper to read toplevel tag.
 * t1401: use $TAR for restoring.
 * t1407: clarify what test is doing.
 * t1417: "$TAR" rather than tar
 * t1415: clarify test objective.
 * t7003: formatting.
 * README entry for REFFILES.

cc: SZEDER Gábor szeder.dev@gmail.com cc: Ævar Arnfjörð Bjarmason
avarab@gmail.com cc: Han-Wen Nienhuys hanwen@google.com

cc: Han-Wen Nienhuys hanwen@google.com

Han-Wen Nienhuys (21):
  t4202: split testcase for invalid HEAD symref and HEAD hash
  t/helper/ref-store: initialize oid in resolve-ref
  t9300: check ref existence using test-helper rather than a file system
    check
  t5601: read HEAD using rev-parse
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
  t7900: mark pack-refs tests as REFFILES
  t7003: check reflog existence only for REFFILES
  t4202: mark bogus head hash test with REFFILES
  t1415: set REFFILES for test specific to storage format

 t/README                      |   6 ++
 t/helper/test-ref-store.c     |   2 +-
 t/t1301-shared-repo.sh        |   2 +-
 t/t1401-symbolic-ref.sh       |  34 +++++-----
 t/t1404-update-ref-errors.sh  |  30 ++++-----
 t/t1407-worktree-ref-store.sh |   9 ++-
 t/t1413-reflog-detach.sh      |   5 +-
 t/t1414-reflog-walk.sh        |   2 +-
 t/t1415-worktree-refs.sh      |   5 +-
 t/t2017-checkout-orphan.sh    |   2 +-
 t/t4202-log.sh                |  10 ++-
 t/t5000-tar-tree.sh           | 113 +++++++++++++++++-----------------
 t/t5304-prune.sh              |  83 ++++++++-----------------
 t/t5601-clone.sh              |   3 +-
 t/t7003-filter-branch.sh      |   7 ++-
 t/t7900-maintenance.sh        |   2 +-
 t/t9300-fast-import.sh        |   2 +-
 t/test-lib.sh                 |   2 +
 18 files changed, 156 insertions(+), 163 deletions(-)


base-commit: 311531c9de557d25ac087c1637818bd2aad6eb3a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1008%2Fhanwen%2Freffiles-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1008/hanwen/reffiles-v2
Pull-Request: https://github.com/git/git/pull/1008

Range-diff vs v1:

  1:  91ef012cbcc9 !  1:  8ad4a35cda70 t4202: split testcase for invalid HEAD symref and HEAD hash
     @@ t/t4202-log.sh: test_expect_success 'log --graph --no-walk is forbidden' '
      +	test_i18ngrep broken stderr'
      +
      +test_expect_success 'log diagnoses bogus HEAD symref' '
     ++	rm -rf empty &&
      +	git init empty &&
      +	git --git-dir empty/.git symbolic-ref HEAD refs/heads/invalid.lock &&
       	test_must_fail git -C empty log 2>stderr &&
  -:  ------------ >  2:  e6222944a3eb t/helper/ref-store: initialize oid in resolve-ref
  2:  ccc26a8950be !  3:  c5855b0caa73 t9300: check ref existence using git-rev-parse rather than FS check
     @@ Metadata
      Author: Han-Wen Nienhuys <hanwen@google.com>
      
       ## Commit message ##
     -    t9300: check ref existence using git-rev-parse rather than FS check
     +    t9300: check ref existence using test-helper rather than a file system check
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
     @@ t/t9300-fast-import.sh: test_expect_success 'B: accept branch name "TEMP_TAG"' '
       		git prune" &&
       	git fast-import <input &&
      -	test -f .git/TEMP_TAG &&
     -+	git rev-parse TEMP_TAG &&
     ++	test $(test-tool ref-store main resolve-ref TEMP_TAG 0 | cut -f1 -d " " ) != "$ZERO_OID" &&
       	test $(git rev-parse main) = $(git rev-parse TEMP_TAG^)
       '
       
  3:  47b5ec56a383 =  4:  369c968ab837 t5601: read HEAD using rev-parse
  4:  53cf1069552b !  5:  248d9ffe7927 t1401-symbolic-ref: avoid direct filesystem access
     @@ Commit message
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
       ## t/t1401-symbolic-ref.sh ##
     -@@ t/t1401-symbolic-ref.sh: test_description='basic symbolic-ref tests'
     - # the git repo, meaning that further tests will operate on
     - # the surrounding git repo instead of the trash directory.
     - reset_to_sane() {
     --	echo ref: refs/heads/foo >.git/HEAD
     -+	git --git-dir .git symbolic-ref HEAD refs/heads/foo
     - }
     +@@
     + test_description='basic symbolic-ref tests'
     + . ./test-lib.sh
       
     +-# If the tests munging HEAD fail, they can break detection of
     +-# the git repo, meaning that further tests will operate on
     +-# the surrounding git repo instead of the trash directory.
     +-reset_to_sane() {
     +-	echo ref: refs/heads/foo >.git/HEAD
     +-}
     +-
      -test_expect_success 'symbolic-ref writes HEAD' '
     --	git symbolic-ref HEAD refs/heads/foo &&
     ++test_expect_success 'setup' '
     + 	git symbolic-ref HEAD refs/heads/foo &&
      -	echo ref: refs/heads/foo >expect &&
      -	test_cmp expect .git/HEAD
     --'
     --
     ++	test_commit file &&
     ++	"$TAR" cf .git.tar .git/
     + '
     + 
      -test_expect_success 'symbolic-ref reads HEAD' '
      -	echo refs/heads/foo >expect &&
     --	git symbolic-ref HEAD >actual &&
     ++reset_to_sane() {
     ++	rm -rf .git &&
     ++	"$TAR" xf .git.tar
     ++}
     ++
      +test_expect_success 'symbolic-ref read/write roundtrip' '
      +	git symbolic-ref HEAD refs/heads/read-write-roundtrip &&
     -+	echo refs/heads/read-write-roundtrip > expect &&
     -+	git symbolic-ref HEAD > actual &&
     ++	echo refs/heads/read-write-roundtrip >expect &&
     + 	git symbolic-ref HEAD >actual &&
       	test_cmp expect actual
       '
     +@@ t/t1401-symbolic-ref.sh: test_expect_success 'symbolic-ref reads HEAD' '
     + test_expect_success 'symbolic-ref refuses non-ref for HEAD' '
     + 	test_must_fail git symbolic-ref HEAD foo
     + '
     ++
     + reset_to_sane
     + 
     + test_expect_success 'symbolic-ref refuses bare sha1' '
     +-	echo content >file && git add file && git commit -m one &&
     + 	test_must_fail git symbolic-ref HEAD $(git rev-parse HEAD)
     + '
     ++
     + reset_to_sane
       
     + test_expect_success 'HEAD cannot be removed' '
      @@ t/t1401-symbolic-ref.sh: reset_to_sane
       test_expect_success 'symbolic-ref can be deleted' '
       	git symbolic-ref NOTHEAD refs/heads/foo &&
     @@ t/t1401-symbolic-ref.sh: reset_to_sane
      -	test_path_is_file .git/refs/heads/foo &&
      -	test_path_is_missing .git/NOTHEAD
      +	git rev-parse refs/heads/foo &&
     -+	! git symbolic-ref NOTHEAD
     ++	test_must_fail git symbolic-ref NOTHEAD
       '
       reset_to_sane
       
     @@ t/t1401-symbolic-ref.sh: reset_to_sane
       	git symbolic-ref -d NOTHEAD &&
      -	test_path_is_missing .git/refs/heads/missing &&
      -	test_path_is_missing .git/NOTHEAD
     -+	! git rev-parse refs/heads/missing &&
     -+	! git symbolic-ref NOTHEAD
     ++	test_must_fail git rev-parse refs/heads/missing &&
     ++	test_must_fail git symbolic-ref NOTHEAD
       '
       reset_to_sane
       
  5:  223583594c00 !  6:  e4e8fc1d4b4f t1413: use tar to save and restore entire .git directory
     @@ t/t1413-reflog-detach.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
       reset_state () {
      -	git checkout main &&
      -	cp saved_reflog .git/logs/HEAD
     -+	rm -rf .git && tar -xf .git-saved.tar
     ++	rm -rf .git && "$TAR" xf .git-saved.tar
       }
       
       test_expect_success setup '
     @@ t/t1413-reflog-detach.sh: test_expect_success setup '
       	test_tick &&
       	git commit --allow-empty -m second &&
      -	cat .git/logs/HEAD >saved_reflog
     -+	tar -cf .git-saved.tar .git
     ++	"$TAR" cf .git-saved.tar .git
       '
       
       test_expect_success baseline '
  6:  70da8f5631d0 =  7:  89cc215c6014 t1301: fix typo in error message
  -:  ------------ >  8:  e67b90847c4e t5000: reformat indentation to the latest fashion
  7:  79843c0d5727 !  9:  d6072a70ae7d t5000: inspect HEAD using git-rev-parse
     @@ Commit message
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
       ## t/t5000-tar-tree.sh ##
     -@@ t/t5000-tar-tree.sh: test_expect_success \
     -      test_cmp expected.mtime b.mtime'
     +@@ t/t5000-tar-tree.sh: test_expect_success 'validate file modification time' '
     + 	test_cmp expected.mtime b.mtime
     + '
       
     - test_expect_success \
     +-test_expect_success \
      -    'git get-tar-commit-id' \
      -    'git get-tar-commit-id <b.tar >b.commitid &&
      -     test_cmp .git/$(git symbolic-ref HEAD) b.commitid'
     -+	'git get-tar-commit-id' \
     -+	'git get-tar-commit-id <b.tar >actual &&
     -+	git rev-parse HEAD > expect &&
     -+	test_cmp expect actual'
     ++test_expect_success 'git get-tar-commit-id' '
     ++	git get-tar-commit-id <b.tar >actual &&
     ++	git rev-parse HEAD >expect &&
     ++	test_cmp expect actual
     ++'
       
       test_expect_success 'git archive with --output, override inferred format' '
       	git archive --format=tar --output=d4.zip HEAD &&
  8:  dbb81b5b89d8 = 10:  4bf1bf16bca3 t7003: use rev-parse rather than FS inspection
  -:  ------------ > 11:  6f15c15573af t5304: restyle: trim empty lines, drop ':' before >
  9:  ba575839e422 ! 12:  d8e80d83b6f8 t5304: use "reflog expire --all" to clear the reflog
     @@ Commit message
      
       ## t/t5304-prune.sh ##
      @@ t/t5304-prune.sh: test_expect_success 'prune: prune nonsense parameters' '
     - '
       
       test_expect_success 'prune: prune unreachable heads' '
     --
       	git config core.logAllRefUpdates false &&
      -	mv .git/logs .git/logs.old &&
     - 	: > file2 &&
     +-	: > file2 &&
     ++	>file2 &&
       	git add file2 &&
       	git commit -m temporary &&
       	tmp_head=$(git rev-list -1 HEAD) &&
     @@ t/t5304-prune.sh: test_expect_success 'prune: prune nonsense parameters' '
      +	git reflog expire --all &&
       	git prune &&
       	test_must_fail git reset $tmp_head --
     --
       '
     - 
     +@@ t/t5304-prune.sh: test_expect_success 'prune: prune unreachable heads' '
       test_expect_success 'prune: do not prune detached HEAD with no reflog' '
     - 
       	git checkout --detach --quiet &&
       	git commit --allow-empty -m "detached commit" &&
      -	# verify that there is no reflogs
     @@ t/t5304-prune.sh: test_expect_success 'prune: prune nonsense parameters' '
      +	git reflog expire --all &&
       	git prune -n >prune_actual &&
       	test_must_be_empty prune_actual
     - 
     -@@ t/t5304-prune.sh: test_expect_success 'prune: prune former HEAD after checking out branch' '
     - 
     + '
     +@@ t/t5304-prune.sh: test_expect_success 'prune: do not prune detached HEAD with no reflog' '
     + test_expect_success 'prune: prune former HEAD after checking out branch' '
       	head_oid=$(git rev-parse HEAD) &&
       	git checkout --quiet main &&
      +	git reflog expire --all &&
       	git prune -v >prune_actual &&
       	grep "$head_oid" prune_actual
     - 
     + '
 10:  3d3b733c3127 ! 13:  180847f4db14 test-lib: provide test prereq REFFILES
     @@ Commit message
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
     + ## t/README ##
     +@@ t/README: use these, and "test_set_prereq" for how to define your own.
     + 
     +    Git wasn't compiled with NO_PTHREADS=YesPlease.
     + 
     ++ - REFFILES
     ++
     ++   Test is specific to packed/loose ref storage, and should be
     ++   disabled for other ref storage backends
     ++
     ++
     + Tips for Writing Tests
     + ----------------------
     + 
     +
       ## t/test-lib.sh ##
      @@ t/test-lib.sh: parisc* | hppa*)
       	;;
 11:  dd1f6969c28d ! 14:  f3307b62bfd7 t1407: require REFFILES for for_each_reflog test
     @@ Metadata
       ## Commit message ##
          t1407: require REFFILES for for_each_reflog test
      
     -    It tries to setup a reflog by catting to .git/logs/
     +    Add extensive comment why this test needs a REFFILES annotation.
     +
     +    I tried forcing universal reflog creation with core.logAllRefUpdates=true, but
     +    that apparently also doesn't cause reflogs to be created for pseudorefs
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
     @@ t/t1407-worktree-ref-store.sh: test_expect_success 'create_symref(FOO, refs/head
       '
       
      -test_expect_success 'for_each_reflog()' '
     ++# Some refs (refs/bisect/*, pseudorefs) are kept per worktree, so they should
     ++# only appear in the for-each-reflog output if it is called from the correct
     ++# worktree, which is exercised in this test. This test is poorly written (and
     ++# therefore marked REFFILES) for mulitple reasons: 1) it creates invalidly
     ++# formatted log entres. 2) it uses direct FS access for creating the reflogs. 3)
     ++# PSEUDO-WT and refs/bisect/random do not create reflogs by default, so it is
     ++# not testing a realistic scenario.
      +test_expect_success REFFILES 'for_each_reflog()' '
       	echo $ZERO_OID > .git/logs/PSEUDO-MAIN &&
       	mkdir -p     .git/logs/refs/bisect &&
 12:  86951eb39cb6 = 15:  0d3b18cd3542 t1414: mark corruption test with REFFILES
 13:  1ce545043846 = 16:  b64e3e7ade15 t2017: mark --orphan/logAllRefUpdates=false test as REFFILES
 14:  a3abc4f70e7d ! 17:  fcc2b714dd50 t1404: mark tests that muck with .git directly as REFFILES.
     @@ Metadata
       ## Commit message ##
          t1404: mark tests that muck with .git directly as REFFILES.
      
     +    The packed/loose ref storage is an overlay combination of packed-refs (refs and
     +    tags in a single file) and one-file-per-ref. This creates all kinds of edge
     +    cases related to directory/file conflicts, (non-)empty directories, and the
     +    locking scheme, none of which applies to reftable.
     +
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
       ## t/t1404-update-ref-errors.sh ##
 15:  2b3021c4ba62 ! 18:  ff3b67c84c41 t7900: mark pack-refs tests as REFFILES
     @@ Metadata
       ## Commit message ##
          t7900: mark pack-refs tests as REFFILES
      
     +    Reftable automatically compacts tables on writes. The functionality of
     +    incremental compaction is unittested in reftable/stack_test.c
     +    (test_reftable_stack_auto_compaction)
     +
     +    In addition, pack-refs triggers a full compaction of the entire stack. This is
     +    exercised in t0031-reftable.sh.
     +
     +    Given that git-maintenance simply calls out git-pack-refs, it seems superfluous
     +    to test this further for reftable.
     +
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
       ## t/t7900-maintenance.sh ##
 16:  a5b9439192db ! 19:  24dcf05d8fa6 t7003: check reflog existence only for REFFILES
     @@ t/t7003-filter-branch.sh: test_expect_success '--prune-empty is able to prune en
       	git filter-branch -f --prune-empty --index-filter "git update-index --remove A.t B.t" prune-entire &&
       	test_must_fail git rev-parse refs/heads/prune-entire &&
      -	test_must_fail git reflog exists refs/heads/prune-entire
     -+	if test_have_prereq REFFILES ; then
     ++	if test_have_prereq REFFILES
     ++	then
      +		test_must_fail git reflog exists refs/heads/prune-entire
      +	fi
       '
 17:  a2cce772d44f = 20:  a33cdfda74ff t4202: mark bogus head hash test with REFFILES
 18:  0665edb1308b ! 21:  d7e5de8dba46 t1415: set REFFILES for test specific to storage format
     @@ Metadata
       ## Commit message ##
          t1415: set REFFILES for test specific to storage format
      
     +    Packing refs (and therefore checking that certain refs are not packed) is a
     +    property of the packed/loose ref storage. Add a comment to explain what the test
     +    checks.
     +
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
       ## t/t1415-worktree-refs.sh ##
     @@ t/t1415-worktree-refs.sh: test_expect_success 'setup' '
       '
       
      -test_expect_success 'refs/worktree must not be packed' '
     ++# The 'packed-refs' files is stored directly in .git/. This means it is global
     ++# to the repository, and can only contain refs that are shared across all
     ++# worktrees.
      +test_expect_success REFFILES 'refs/worktree must not be packed' '
       	git pack-refs --all &&
       	test_path_is_missing .git/refs/tags/wt1 &&

-- 
gitgitgadget
