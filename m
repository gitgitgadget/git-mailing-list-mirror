Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C194AC433DF
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 23:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83AC82067D
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 23:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Xy2cTrg/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbgG2XPU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 19:15:20 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41148 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728009AbgG2XPS (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Jul 2020 19:15:18 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C029660799;
        Wed, 29 Jul 2020 23:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1596064486;
        bh=SSAj1k4J8DxDsWEtb8L0a2Osg3+NQpDcP6NlKfq6yzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Content-Type:From:
         Reply-To:Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:
         Resent-Cc:In-Reply-To:References:Content-Type:Content-Disposition;
        b=Xy2cTrg/sKgSt+ZfxLVHrOnDR+oQ8rFv1m9KUCjcoUWChBi0pavNSUY7RLSiVrt6T
         z3pBZBl5PEhNmPpRWyqDY0k3hPT25EwIND6IZ1kE5AzCIh6pc/TxaKTVfGrakofHPG
         2bo+SWUP9TjK2xqVJCppJtoxjoZSYK+dR4WQfIQjK6TN47GWlaPHS85CYqF4v4z9IY
         DbexwH+yFhlMlPdXTGDLpzd3DVX5JaX6PKSFPPZedM/d3EQ3AqKxaS9z+eA0DM0J85
         b3OF5kr2jf3HtFpZ7wb9ad6h34jCauEwUh5oU3BVVtVHdqfK1kjixy6KLdda4AewQv
         iv3wRvTNiME5tqDlPNeB47FbA3cIFd3dXuaI5hDdykhc+Lf30V3wUdsXuc64ZCC4hF
         VazQUQgEB5qwY7cFvYebjDrIPL/d9Z+su6ENFgDRF5YJQtXuwBUqWtcoDI3v3xizEZ
         utnMXn5e62CGq2zCAmo03a5g9McFTiJBIER67zaaojwaWdV0ZA3
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v6 00/39] SHA-256, part 3/3
Date:   Wed, 29 Jul 2020 23:13:49 +0000
Message-Id: <20200729231428.3658647-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6
In-Reply-To: <20200728233446.3066485-1-sandals@crustytoothpaste.net>
References: <20200728233446.3066485-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes from v5:
* Remove useless test_oid_init invocations throughout the series.
* Fix a commit message for grammar and style.
* Fix a typo in a shell case statement.
* Fix http-fetch to allow parsing options before failing on a missing
  git directory.

Changes from v4:
* Fix several commit message to fix typos and inaccuracies.
* Remove useless touch statement in tests.
* Adjust several tests to introduce less dependence on previous test
  assertions other than the setup ones.
* Loosen the regexp for object IDs in a Perl script in a test.
* Ensure help functionality works for git http-fetch.
* Switch http-fetch.c to use the already existing struct argv_array
  instance.
* Avoid a memory leak, albeit a minor one.
* Improve error message for unknown bundle hash algorithm.
* Hoist a strbuf_rtrim in the bundle parsing code to simplify things.
* Specify a minimum version instead of a default version in the bundle
  code.
* Remove a useless line in tests.
* Avoid invoking git hash-object needlessly for the SHA1 prerequisite.
* Be explicit about which algorithms we're testing in CI.
* Properly capitalize "core.repositoryFormatVersion" in documentation.

Changes from v2:
* Move bundle signature parsing into a function.
* Improve parsing of bundle capabilities.
* Improve t5510 to select only the interesting lines with sed.
* Use cat and a heredoc instead of multiple echos.
* Use test_i18ngrep where appropriate.
* Reject extensions.objectFormat for repo v0.
* Update documentation accordingly.

Changes from v1:
* Add a patch to add a bundle v3 format with capabilities that include
  the hash algorithm.
* Remove bundle detection of hash algorithm using hash algorithm length.
* Fix typo in the extensions.objectFormat documentation.
* Document that extensions.objectFormat is ignored for repo v0.
* Use test instead of brackets.
* Use a command group instead of a subshell for efficiency.
* Drop the bizarre test_might_fail, since it isn't needed (and is
  bizarre and wrong).
* Write "SHA-256" instead of "NewHash" in commit messages.
* Split SHA-256 CI tests to an independent run and avoid running a third
  test run to a single CI job.

Range-diff below.

Johannes Schindelin (1):
  t3404: prepare 'short SHA-1 collision' tests for SHA-256

brian m. carlson (38):
  t: make test-bloom initialize repository
  t1001: use $ZERO_OID
  t3305: make hash agnostic
  t6100: make hash size independent
  t6101: make hash size independent
  t6301: make hash size independent
  t6500: specify test values for SHA-256
  t6501: avoid hard-coded objects
  t7003: compute appropriate length constant
  t7063: make hash size independent
  t7201: abstract away SHA-1-specific constants
  t7102: abstract away SHA-1-specific constants
  t7400: make hash size independent
  t7405: make hash size independent
  t7506: avoid checking for SHA-1-specific constants
  t7508: use $ZERO_OID instead of hard-coded constant
  t8002: make hash size independent
  t8003: make hash size independent
  t8011: make hash size independent
  t9300: abstract away SHA-1-specific constants
  t9300: use $ZERO_OID instead of hard-coded object ID
  t9301: make hash size independent
  t9350: make hash size independent
  t9500: ensure that algorithm info is preserved in config
  t9700: make hash size independent
  t5308: make test work with SHA-256
  t0410: mark test with SHA1 prerequisite
  http-fetch: set up git directory before parsing pack hashes
  builtin/verify-pack: implement an --object-format option
  bundle: add new version for use with SHA-256
  setup: add support for reading extensions.objectformat
  repository: enable SHA-256 support by default
  t: add test_oid option to select hash algorithm
  t: allow testing different hash algorithms via environment
  t: make SHA1 prerequisite depend on default hash
  ci: run tests with SHA-256
  docs: add documentation for extensions.objectFormat
  t: remove test_oid_init in tests

 Documentation/config.txt                  |   2 +
 Documentation/config/extensions.txt       |   8 ++
 Documentation/git-bundle.txt              |   9 +-
 Documentation/technical/bundle-format.txt |  30 ++++-
 builtin/bundle.c                          |   5 +-
 builtin/init-db.c                         |   5 -
 builtin/verify-pack.c                     |  23 ++--
 bundle.c                                  |  83 +++++++++---
 bundle.h                                  |   4 +-
 ci/run-build-and-tests.sh                 |   6 +
 config.mak.dev                            |   2 -
 http-fetch.c                              |   6 +-
 repository.c                              |   4 -
 setup.c                                   |  16 ++-
 t/helper/test-bloom.c                     |   2 +
 t/lib-pack.sh                             |  11 +-
 t/lib-submodule-update.sh                 |   1 -
 t/t0000-basic.sh                          |  15 ++-
 t/t0001-init.sh                           |  33 +++++
 t/t0410-partial-clone.sh                  |   4 +-
 t/t1006-cat-file.sh                       |   2 -
 t/t1050-large.sh                          |   1 -
 t/t1091-sparse-checkout-builtin.sh        |   4 +-
 t/t1410-reflog.sh                         |   1 -
 t/t1450-fsck.sh                           |   1 -
 t/t1500-rev-parse.sh                      |   1 -
 t/t3305-notes-fanout.sh                   |   2 +-
 t/t3308-notes-merge.sh                    |   1 -
 t/t3404-rebase-interactive.sh             |  49 +++++--
 t/t3600-rm.sh                             |   1 -
 t/t3800-mktag.sh                          |   1 -
 t/t4002-diff-basic.sh                     |   2 -
 t/t4027-diff-submodule.sh                 |   1 -
 t/t4134-apply-submodule.sh                |   1 -
 t/t4200-rerere.sh                         |   1 -
 t/t4211-line-log.sh                       |   1 -
 t/t5300-pack-object.sh                    |   3 +-
 t/t5302-pack-index.sh                     |   1 -
 t/t5308-pack-detect-duplicates.sh         |  20 +--
 t/t5313-pack-bounds-checks.sh             |   1 -
 t/t5318-commit-graph.sh                   |   3 +-
 t/t5319-multi-pack-index.sh               |   1 -
 t/t5324-split-commit-graph.sh             |   1 -
 t/t5504-fetch-receive-strict.sh           |   1 -
 t/t5510-fetch.sh                          |  16 ++-
 t/t5530-upload-pack-error.sh              |   1 -
 t/t5562-http-backend-content-length.sh    |   1 -
 t/t5607-clone-bundle.sh                   |  31 +++++
 t/t5702-protocol-v2.sh                    |   3 +-
 t/t5703-upload-pack-ref-in-want.sh        |   1 -
 t/t6006-rev-list-format.sh                |   1 -
 t/t6100-rev-list-in-order.sh              |   4 +-
 t/t6101-rev-parse-parents.sh              |   2 +-
 t/t6301-for-each-ref-errors.sh            |   2 +-
 t/t6500-gc.sh                             |  27 +++-
 t/t6501-freshen-objects.sh                |  14 +-
 t/t7003-filter-branch.sh                  |   3 +-
 t/t7063-status-untracked-cache.sh         | 150 ++++++++++++----------
 t/t7102-reset.sh                          |  93 ++++++++------
 t/t7201-co.sh                             |   6 +-
 t/t7400-submodule-basic.sh                |  26 ++--
 t/t7405-submodule-merge.sh                |   4 +-
 t/t7506-status-submodule.sh               |  12 +-
 t/t7508-status.sh                         |   2 +-
 t/t8002-blame.sh                          |  18 ++-
 t/t8003-blame-corner-cases.sh             |   3 +-
 t/t8011-blame-split-file.sh               |   2 +-
 t/t9300-fast-import.sh                    | 118 +++++++++--------
 t/t9301-fast-import-notes.sh              |  12 +-
 t/t9350-fast-export.sh                    |  14 +-
 t/t9500-gitweb-standalone-no-errors.sh    |  22 +++-
 t/t9700/test.pl                           |   6 +-
 t/test-lib-functions.sh                   |  16 ++-
 t/test-lib.sh                             |   9 +-
 74 files changed, 638 insertions(+), 351 deletions(-)
 create mode 100644 Documentation/config/extensions.txt

Diff-intervalle contre v5 :
 1:  2d720a6beb =  1:  fb53834bd3 t: make test-bloom initialize repository
 2:  530704736a =  2:  8170f55d65 t1001: use $ZERO_OID
 3:  33e7822d0e !  3:  94b585296d t3305: make hash agnostic
    @@ t/t3305-notes-fanout.sh: test_description='Test that adding/removing many notes
      	echo $path | grep -q "^\([0-9a-f]\{2\}/\)\{$fanout\}[0-9a-f]\{$after_last_slash\}$"
      }
      
    -@@ t/t3305-notes-fanout.sh: all_notes_have_fanout() {
    - }
    - 
    - test_expect_success 'tweak test environment' '
    -+	test_oid_init &&
    - 	git checkout -b nondeterminism &&
    - 	test_commit A &&
    - 	git checkout --orphan with_notes;
 4:  99081937cf !  4:  82b373b830 t3404: prepare 'short SHA-1 collision' tests for SHA-256
    @@ Commit message
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
     
      ## t/t3404-rebase-interactive.sh ##
    -@@ t/t3404-rebase-interactive.sh: Initial setup:
    - . "$TEST_DIRECTORY"/lib-rebase.sh
    - 
    - test_expect_success 'setup' '
    -+	test_oid_init &&
    - 	test_commit A file1 &&
    - 	test_commit B file1 &&
    - 	test_commit C file2 &&
     @@ t/t3404-rebase-interactive.sh: test_expect_success 'rebase -i error on commits with \ in message' '
      	test_expect_code 1 grep  "	emp" error
      '
 5:  3cfa8bba75 =  5:  adc32c2903 t6100: make hash size independent
 6:  9a7de5790c =  6:  40db5bb392 t6101: make hash size independent
 7:  76942eec3d !  7:  d4055790f3 t6301: make hash size independent
    @@ Commit message
     
         Instead of hard-coding a fixed length example object ID in the test,
         compute one using the translation tables.  Move a variable into the
    -    setup block so that we can ensure the exit status of test_oid_init is
    +    setup block so that we can ensure the exit status of test_oid is
         checked.
     
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
    @@ t/t6301-for-each-ref-errors.sh: test_description='for-each-ref errors for broken
     -MISSING=abababababababababababababababababababab
      
      test_expect_success setup '
    -+	test_oid_init &&
     +	MISSING=$(test_oid deadbeef) &&
      	git commit --allow-empty -m "Initial" &&
      	git tag testtag &&
 8:  b30a8a6736 =  8:  a9578382ab t6500: specify test values for SHA-256
 9:  c3d68dcf1b !  9:  b022dda379 t6501: avoid hard-coded objects
    @@ Commit message
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
     
      ## t/t6501-freshen-objects.sh ##
    -@@ t/t6501-freshen-objects.sh: maybe_repack () {
    - 	fi
    - }
    - 
    -+test_expect_success 'setup' '
    -+	test_oid_init
    -+'
    -+
    - for repack in '' true; do
    - 	title=${repack:+repack}
    - 	title=${title:-loose}
     @@ t/t6501-freshen-objects.sh: for repack in '' true; do
      done
      
10:  865662f5c5 ! 10:  d9eda002b9 t7003: compute appropriate length constant
    @@ Commit message
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
     
      ## t/t7003-filter-branch.sh ##
    -@@ t/t7003-filter-branch.sh: test_description='git filter-branch'
    - . "$TEST_DIRECTORY/lib-gpg.sh"
    - 
    - test_expect_success 'setup' '
    -+	test_oid_init &&
    - 	test_commit A &&
    - 	GIT_COMMITTER_DATE="@0 +0000" GIT_AUTHOR_DATE="@0 +0000" &&
    - 	test_commit --notick B &&
     @@ t/t7003-filter-branch.sh: test_expect_success 'rewrite submodule with another content' '
      '
      
11:  1a7bd71fb4 = 11:  02da9e5630 t7063: make hash size independent
12:  55c545cf1f = 12:  4f567ee443 t7201: abstract away SHA-1-specific constants
13:  9875576b08 = 13:  cec9eca4a3 t7102: abstract away SHA-1-specific constants
14:  d1a2f91516 = 14:  0408e53002 t7400: make hash size independent
15:  9acdbf294c = 15:  3f0bb9751d t7405: make hash size independent
16:  2b506517de = 16:  406c9088af t7506: avoid checking for SHA-1-specific constants
17:  976974106c = 17:  bea582c49f t7508: use $ZERO_OID instead of hard-coded constant
18:  459e6d2455 = 18:  bb044354bc t8002: make hash size independent
19:  8c19b1280d ! 19:  888ffd32d3 t8003: make hash size independent
    @@ t/t8003-blame-corner-cases.sh: test_description='git blame corner cases'
      pick_fc='s/^[0-9a-f^]* *\([^ ]*\) *(\([^ ]*\) .*/\1-\2/'
      
      test_expect_success setup '
    -+	test_oid_init &&
    - 
    +-
      	echo A A A A A >one &&
      	echo B B B B B >two &&
    + 	echo C C C C C >tres &&
     @@ t/t8003-blame-corner-cases.sh: test_expect_success 'blame coalesce' '
      	$oid 1) ABC
      	$oid 2) DEF
20:  42e8d962dc = 20:  a6f7345990 t8011: make hash size independent
21:  076249fdea = 21:  25458092e4 t9300: abstract away SHA-1-specific constants
22:  36fed34e25 = 22:  637673d0f4 t9300: use $ZERO_OID instead of hard-coded object ID
23:  fd2b44e138 ! 23:  77a42dbf51 t9301: make hash size independent
    @@ Commit message
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
     
      ## t/t9301-fast-import-notes.sh ##
    -@@ t/t9301-fast-import-notes.sh: EOF
    - INPUT_END
    - 
    - test_expect_success 'set up master branch' '
    --
    -+	test_oid_init &&
    - 	git fast-import <input &&
    - 	git whatchanged master
    - '
     @@ t/t9301-fast-import-notes.sh: test_expect_success 'add lots of commits and notes' '
      '
      
24:  5cf2612131 ! 24:  3c405c54fd t9350: make hash size independent
    @@ Commit message
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
     
      ## t/t9350-fast-export.sh ##
    -@@ t/t9350-fast-export.sh: test_description='git fast-export'
    - . ./test-lib.sh
    - 
    - test_expect_success 'setup' '
    -+	test_oid_init &&
    - 
    - 	echo break it > file0 &&
    - 	git add file0 &&
     @@ t/t9350-fast-export.sh: test_expect_success 'reencoding iso-8859-7' '
      	sed "s/wer/i18n/" iso-8859-7.fi |
      		(cd new &&
25:  64b56a029a = 25:  c75d879bca t9500: ensure that algorithm info is preserved in config
26:  46800750af = 26:  82f2a6146f t9700: make hash size independent
27:  9c5a7b9c38 = 27:  60d7922842 t5308: make test work with SHA-256
28:  1a98d1e4b6 = 28:  c668823701 t0410: mark test with SHA1 prerequisite
29:  359543b8de <  -:  ---------- http-fetch: set up git directory before parsing pack hashes
 -:  ---------- > 29:  e1e0e04e83 http-fetch: set up git directory before parsing pack hashes
30:  bc5e6f6199 = 30:  96e770dce2 builtin/verify-pack: implement an --object-format option
31:  10f9420219 = 31:  dd79604c8b bundle: add new version for use with SHA-256
32:  59717a9f42 = 32:  425fdcca3d setup: add support for reading extensions.objectformat
33:  8313384a88 ! 33:  e7256281f4 Enable SHA-256 support by default
    @@ Metadata
     Author: brian m. carlson <sandals@crustytoothpaste.net>
     
      ## Commit message ##
    -    Enable SHA-256 support by default
    +    repository: enable SHA-256 support by default
     
    -    Now that the we have a complete SHA-256 implementation in Git, let's
    -    enable it so people can use it.  Remove the ENABLE_SHA256 define
    -    constant everywhere it's used.  Add tests for initializing a repository
    -    with SHA-256.
    +    Now that we have a complete SHA-256 implementation in Git, let's enable
    +    it so people can use it.  Remove the ENABLE_SHA256 define constant
    +    everywhere it's used.  Add tests for initializing a repository with
    +    SHA-256.
     
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
     
34:  e8439aa0d0 = 34:  65d43826f6 t: add test_oid option to select hash algorithm
35:  e5c9553da9 = 35:  d32ff6431b t: allow testing different hash algorithms via environment
36:  2a6f2ccd55 ! 36:  8cc8c77f48 t: make SHA1 prerequisite depend on default hash
    @@ t/test-lib.sh: test_lazy_prereq CURL '
     +	case "$GIT_DEFAULT_HASH" in
     +	sha1) true ;;
     +	"") test $(git hash-object /dev/null) = e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 ;;
    -+	*) false ::
    ++	*) false ;;
     +	esac
      '
      
37:  2eec901cdf = 37:  01d865b03e ci: run tests with SHA-256
38:  6a7fb3e911 = 38:  83f565d1d2 docs: add documentation for extensions.objectFormat
39:  448faa92fe ! 39:  6c3bf65a7d t: remove test_oid_init in tests
    @@ t/t1500-rev-parse.sh: test_rev_parse () {
      	cp -R .git repo.git
      '
     
    - ## t/t3305-notes-fanout.sh ##
    -@@ t/t3305-notes-fanout.sh: all_notes_have_fanout() {
    - }
    - 
    - test_expect_success 'tweak test environment' '
    --	test_oid_init &&
    - 	git checkout -b nondeterminism &&
    - 	test_commit A &&
    - 	git checkout --orphan with_notes;
    -
      ## t/t3308-notes-merge.sh ##
     @@ t/t3308-notes-merge.sh: test_expect_success setup '
      	# Copy notes to remote-notes
    @@ t/t3308-notes-merge.sh: test_expect_success setup '
      	hash4a sha1:5e93d24084d32e1cb61f7070505b9d2530cca987
      	hash3a sha1:8366731eeee53787d2bdf8fc1eff7d94757e8da0
     
    - ## t/t3404-rebase-interactive.sh ##
    -@@ t/t3404-rebase-interactive.sh: Initial setup:
    - . "$TEST_DIRECTORY"/lib-rebase.sh
    - 
    - test_expect_success 'setup' '
    --	test_oid_init &&
    - 	test_commit A file1 &&
    - 	test_commit B file1 &&
    - 	test_commit C file2 &&
    -
      ## t/t3600-rm.sh ##
     @@ t/t3600-rm.sh: test_expect_success 'refresh index before checking if it is up-to-date' '
      '
    @@ t/t6006-rev-list-format.sh: changed_iso88591=$(echo "$changed" | iconv -f utf-8
      	: >foo &&
      	git add foo &&
      	git config i18n.commitEncoding $test_encoding &&
    -
    - ## t/t6301-for-each-ref-errors.sh ##
    -@@ t/t6301-for-each-ref-errors.sh: test_description='for-each-ref errors for broken refs'
    - ZEROS=$ZERO_OID
    - 
    - test_expect_success setup '
    --	test_oid_init &&
    - 	MISSING=$(test_oid deadbeef) &&
    - 	git commit --allow-empty -m "Initial" &&
    - 	git tag testtag &&
    -
    - ## t/t6501-freshen-objects.sh ##
    -@@ t/t6501-freshen-objects.sh: maybe_repack () {
    - 	fi
    - }
    - 
    --test_expect_success 'setup' '
    --	test_oid_init
    --'
    --
    - for repack in '' true; do
    - 	title=${repack:+repack}
    - 	title=${title:-loose}
    -
    - ## t/t7003-filter-branch.sh ##
    -@@ t/t7003-filter-branch.sh: test_description='git filter-branch'
    - . "$TEST_DIRECTORY/lib-gpg.sh"
    - 
    - test_expect_success 'setup' '
    --	test_oid_init &&
    - 	test_commit A &&
    - 	GIT_COMMITTER_DATE="@0 +0000" GIT_AUTHOR_DATE="@0 +0000" &&
    - 	test_commit --notick B &&
    -
    - ## t/t8003-blame-corner-cases.sh ##
    -@@ t/t8003-blame-corner-cases.sh: test_description='git blame corner cases'
    - pick_fc='s/^[0-9a-f^]* *\([^ ]*\) *(\([^ ]*\) .*/\1-\2/'
    - 
    - test_expect_success setup '
    --	test_oid_init &&
    --
    - 	echo A A A A A >one &&
    - 	echo B B B B B >two &&
    - 	echo C C C C C >tres &&
    -
    - ## t/t9301-fast-import-notes.sh ##
    -@@ t/t9301-fast-import-notes.sh: EOF
    - INPUT_END
    - 
    - test_expect_success 'set up master branch' '
    --	test_oid_init &&
    - 	git fast-import <input &&
    - 	git whatchanged master
    - '
    -
    - ## t/t9350-fast-export.sh ##
    -@@ t/t9350-fast-export.sh: test_description='git fast-export'
    - . ./test-lib.sh
    - 
    - test_expect_success 'setup' '
    --	test_oid_init &&
    --
    - 	echo break it > file0 &&
    - 	git add file0 &&
    - 	test_tick &&
