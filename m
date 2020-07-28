Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F663C4345B
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 23:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1F342075D
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 23:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="GsT0TmXy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730362AbgG1Xfa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 19:35:30 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40956 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728364AbgG1Xf2 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Jul 2020 19:35:28 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id F291260479;
        Tue, 28 Jul 2020 23:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595979295;
        bh=KFMeRDooXyllRzFNqSAMvFu+V6n6sQvQI3p+TKp8z9Y=;
        h=From:To:Cc:Subject:Date:Content-Type:From:Reply-To:Subject:Date:
         To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=GsT0TmXyP3sqLy7OVglqIO5NoGfHacFrOEJOK1EuxDm5mTs8ktDUlwA86KC43oVjI
         TbNr08YvDVhBS2WGKELmAZxnQ2HsfflYasuCi8mNGTdHz8q6sWfkxj4+jOy9o1R6HJ
         +L+jUWr5QOv325gPUFBmxOaFMmxcbsDDvkI/NGfzfkVSWEJu0gsUMKFUOylEvKSsjs
         m8ocz63d1pmfQiTz0Yd40D/lj8vtFLd+1N9Ohpya3D8swXKfWO3frAFiLUjLsIIqIQ
         DXd2i7dybwUAYibLe3MOnUqdmygJ4KVJCHj7YDHix0grisbBTqsAuhnVM33TEe1Z2A
         LQEtU1/eGjSS5uJqZzjA3BzL2Ru6sTN7bNfEytBbVC/GVaE5OCfc5xmXdc14W6xH0e
         OotbEeVoYXGMuhDLbd7xEqO3HwVTsr7ve1ag9HKwdpORLjMDmXrVHOhXG0PTkr4GBo
         lKAWvVLMMPCeYvom9FaHR/zsdmJ0eTgoaHIyUi/THpMJ/eUsUb1
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v5 00/39] SHA-256, part 3/3
Date:   Tue, 28 Jul 2020 23:34:07 +0000
Message-Id: <20200728233446.3066485-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the final part required for the stage 4 implementation of
SHA-256.

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
  Enable SHA-256 support by default
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
 http-fetch.c                              |   4 +-
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
 t/t9301-fast-import-notes.sh              |  13 +-
 t/t9350-fast-export.sh                    |  15 +--
 t/t9500-gitweb-standalone-no-errors.sh    |  22 +++-
 t/t9700/test.pl                           |   6 +-
 t/test-lib-functions.sh                   |  16 ++-
 t/test-lib.sh                             |   9 +-
 74 files changed, 635 insertions(+), 354 deletions(-)
 create mode 100644 Documentation/config/extensions.txt

Diff-intervalle contre v4 :
 1:  2d720a6beb =  1:  fb53834bd3 t: make test-bloom initialize repository
 2:  530704736a =  2:  8170f55d65 t1001: use $ZERO_OID
 3:  33e7822d0e =  3:  4b14099f1a t3305: make hash agnostic
 4:  82a6827f45 !  4:  8d3ce7cccd t3404: prepare 'short SHA-1 collision' tests for SHA-256
    @@ Commit message
         commit message "collide2" to find such a collision. To make it easier to
         find such a collision, we reduce the number of digits to 4.
     
    -    The `t/oid-info/oid` file now lists the values found in that way, and
    -    the test cases are modified to use those values.
    -
         As the tests are no longer dependent on SHA-1, we also rename their
         titles to talk about "commit IDs" instead of "SHA-1s".
     
 5:  23cbd25060 =  5:  8329368075 t6100: make hash size independent
 6:  9e2553b1f2 =  6:  63595c30d4 t6101: make hash size independent
 7:  c2c5dd407e =  7:  88c7a501db t6301: make hash size independent
 8:  1ab4ed032a =  8:  4546001417 t6500: specify test values for SHA-256
 9:  54fcc025bb =  9:  4a9304a648 t6501: avoid hard-coded objects
10:  a2f420fcd4 = 10:  7785b7cc1f t7003: compute appropriate length constant
11:  766bba42f6 ! 11:  71db1716f5 t7063: make hash size independent
    @@ Metadata
      ## Commit message ##
         t7063: make hash size independent
     
    -    Use test_oid instead of hard-coding a fixed size all-zeros object ID.
    +    Use test_oid instead of hard-coding algorithm-specific constants and
    +    all-zero values.
     
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
     
    @@ t/t7063-status-untracked-cache.sh: EOF
      two
      EOF
      	test_cmp ../expect-from-test-dump ../actual
    -@@ t/t7063-status-untracked-cache.sh: test_expect_success 'using --untracked-cache does not fail when core.untrackedCa
    - '
    - 
    - test_expect_success 'setting core.untrackedCache to keep' '
    -+	touch ../expect-from-test-dump &&
    - 	git config core.untrackedCache keep &&
    - 	git update-index --untracked-cache &&
    - 	test-tool dump-untracked-cache >../actual &&
     @@ t/t7063-status-untracked-cache.sh: test_expect_success '"status" after file replacement should be clean with UC=tru
      	test-tool dump-untracked-cache >../actual &&
      	grep -F "recurse valid" ../actual >../actual.grep &&
12:  66d242ccd9 ! 12:  79dcdc3496 t7201: abstract away SHA-1-specific constants
    @@ t/t7201-co.sh: test_expect_success 'switch to another branch while carrying a de
      	test_line_count = 1 messages &&
      	H=$(git rev-parse --verify HEAD) &&
      	M=$(git show-ref -s --verify refs/heads/master) &&
    -@@ t/t7201-co.sh: test_expect_success 'checkout to detach HEAD' '
    +@@ t/t7201-co.sh: test_expect_success 'checkout to detach HEAD (with advice declined)' '
    + 
    + test_expect_success 'checkout to detach HEAD' '
      	git config advice.detachedHead true &&
    ++	rev=$(git rev-parse --short renamer^) &&
      	git checkout -f renamer && git clean -f &&
      	GIT_TEST_GETTEXT_POISON=false git checkout renamer^ 2>messages &&
     -	grep "HEAD is now at 7329388" messages &&
13:  090041ee54 = 13:  f89560df08 t7102: abstract away SHA-1-specific constants
14:  4a6991d6a1 = 14:  79800ba8a3 t7400: make hash size independent
15:  d39bbeb5a2 = 15:  07d287fe0f t7405: make hash size independent
16:  5b0d52ae0e = 16:  1ee37967f2 t7506: avoid checking for SHA-1-specific constants
17:  54d1706107 = 17:  ba3c997fd7 t7508: use $ZERO_OID instead of hard-coded constant
18:  f3f4239ce9 ! 18:  362e0a9440 t8002: make hash size independent
    @@ Metadata
      ## Commit message ##
         t8002: make hash size independent
     
    -    Compute the length of an object ID instead of of hard-coding 40-based
    +    Compute the length of an object ID instead of hard-coding 40-based
         values.
     
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
    @@ t/t8002-blame.sh: test_description='git blame'
      . "$TEST_DIRECTORY"/annotate-tests.sh
      
     +test_expect_success 'setup' '
    -+	test_oid_init
    ++	hexsz=$(test_oid hexsz)
     +'
     +
      test_expect_success 'blame untracked file in empty repo' '
    @@ t/t8002-blame.sh: test_expect_success 'blame --abbrev=<n> works' '
      test_expect_success 'blame -l aligns regular and boundary commits' '
     -	check_abbrev 40 -l HEAD &&
     -	check_abbrev 39 -l ^HEAD
    -+	hexsz=$(test_oid hexsz) &&
     +	check_abbrev $hexsz         -l HEAD &&
     +	check_abbrev $((hexsz - 1)) -l ^HEAD
      '
19:  719db3822e = 19:  eeeba30e75 t8003: make hash size independent
20:  803e5665e9 ! 20:  a71b7fb7f1 t8011: make hash size independent
    @@ t/t8011-blame-split-file.sh: test_expect_success 'setup simulated porcelain' '
      	my $field = shift;
      	while (<>) {
     -		if (/^[0-9a-f]{40} /) {
    -+		if (/^[0-9a-f]{40,64} /) {
    ++		if (/^[0-9a-f]{40,} /) {
      			flush();
      			$hash = $&;
      		} elsif (/^$field (.*)/) {
21:  d1c4351bc9 ! 21:  b9a4ac6547 t9300: abstract away SHA-1-specific constants
    @@ Commit message
         t9300: abstract away SHA-1-specific constants
     
         Adjust the test so that it computes variables for object IDs instead of
    -    using hard-coded hashes.
    +    using hard-coded hashes.  In addition, use cut to filter out the object
    +    IDs and verify only the information that we're really interested in.
     
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
     
      ## t/t9300-fast-import.sh ##
     @@ t/t9300-fast-import.sh: test_expect_success 'A: verify pack' '
    + '
      
      test_expect_success 'A: verify diff' '
    ++	copy=$(git rev-parse --verify master:file2) &&
      	cat >expect <<-EOF &&
     -	:000000 100755 0000000000000000000000000000000000000000 7123f7f44e39be127c5eb701e5968176ee9d78b1 A	copy-of-file2
    -+	:000000 100755 0000000000000000000000000000000000000000 $(git rev-parse --verify master:file2) A	copy-of-file2
    ++	:000000 100755 0000000000000000000000000000000000000000 $copy A	copy-of-file2
      	EOF
      	git diff-tree -M -r master verify--import-marks >actual &&
      	compare_diff_raw expect actual &&
22:  db74bf3c8c ! 22:  8d617381c0 t9300: use $ZERO_OID instead of hard-coded object ID
    @@ t/t9300-fast-import.sh: test_expect_success 'A: create pack from stdin' '
      	tag nested
      	mark :7
     @@ t/t9300-fast-import.sh: test_expect_success 'A: verify pack' '
    - 
      test_expect_success 'A: verify diff' '
    + 	copy=$(git rev-parse --verify master:file2) &&
      	cat >expect <<-EOF &&
    --	:000000 100755 0000000000000000000000000000000000000000 $(git rev-parse --verify master:file2) A	copy-of-file2
    -+	:000000 100755 $ZERO_OID $(git rev-parse --verify master:file2) A	copy-of-file2
    +-	:000000 100755 0000000000000000000000000000000000000000 $copy A	copy-of-file2
    ++	:000000 100755 $ZERO_OID $copy A	copy-of-file2
      	EOF
      	git diff-tree -M -r master verify--import-marks >actual &&
      	compare_diff_raw expect actual &&
23:  fa7daed2bf = 23:  d3ddbe3bcf t9301: make hash size independent
24:  84aef86ac0 = 24:  70bfe6c076 t9350: make hash size independent
25:  541108fc64 = 25:  c784e76075 t9500: ensure that algorithm info is preserved in config
26:  2de5d2da58 = 26:  00e82dc23e t9700: make hash size independent
27:  c916058c38 = 27:  2d03d136df t5308: make test work with SHA-256
28:  b0781430ef = 28:  d8941dd81d t0410: mark test with SHA1 prerequisite
29:  230a933e87 ! 29:  39eb2e82b5 http-fetch: set up git directory before parsing pack hashes
    @@ Commit message
         To ensure that we can parse packfile hashes of the right length, let's
         set up the git directory before we start parsing arguments.
     
    +    Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
    +
      ## http-fetch.c ##
     @@ http-fetch.c: int cmd_main(int argc, const char **argv)
      	int packfile = 0;
      	struct object_id packfile_hash;
      
    -+	setup_git_directory();
    ++	setup_git_directory_gently(NULL);
     +
      	while (arg < argc && argv[arg][0] == '-') {
      		const char *p;
30:  d3dbe9e760 ! 30:  7c71a12f67 builtin/verify-pack: implement an --object-format option
    @@ builtin/verify-pack.c
      {
      	struct child_process index_pack = CHILD_PROCESS_INIT;
     -	const char *argv[] = {"index-pack", NULL, NULL, NULL };
    --	struct strbuf arg = STRBUF_INIT;
    -+	struct argv_array argv = ARGV_ARRAY_INIT;
    -+	struct strbuf arg = STRBUF_INIT, hash_arg = STRBUF_INIT;
    ++	struct argv_array *argv = &index_pack.args;
    + 	struct strbuf arg = STRBUF_INIT;
      	int verbose = flags & VERIFY_PACK_VERBOSE;
      	int stat_only = flags & VERIFY_PACK_STAT_ONLY;
      	int err;
      
    -+	argv_array_push(&argv, "index-pack");
    ++	argv_array_push(argv, "index-pack");
     +
      	if (stat_only)
     -		argv[1] = "--verify-stat-only";
    -+		argv_array_push(&argv, "--verify-stat-only");
    ++		argv_array_push(argv, "--verify-stat-only");
      	else if (verbose)
     -		argv[1] = "--verify-stat";
    -+		argv_array_push(&argv, "--verify-stat");
    ++		argv_array_push(argv, "--verify-stat");
      	else
     -		argv[1] = "--verify";
    -+		argv_array_push(&argv, "--verify");
    ++		argv_array_push(argv, "--verify");
     +
    -+	if (hash_algo) {
    -+		strbuf_addf(&hash_arg, "--object-format=%s", hash_algo);
    -+		argv_array_push(&argv, hash_arg.buf);
    -+	}
    ++	if (hash_algo)
    ++		argv_array_pushf(argv, "--object-format=%s", hash_algo);
      
      	/*
      	 * In addition to "foo.pack" we accept "foo.idx" and "foo";
    @@ builtin/verify-pack.c: static int verify_one_pack(const char *path, unsigned int
      	    !ends_with(arg.buf, ".pack"))
      		strbuf_addstr(&arg, ".pack");
     -	argv[2] = arg.buf;
    -+	argv_array_push(&argv, arg.buf);
    ++	argv_array_push(argv, arg.buf);
      
     -	index_pack.argv = argv;
    -+	index_pack.argv = argv.argv;
      	index_pack.git_cmd = 1;
      
      	err = run_command(&index_pack);
    -@@ builtin/verify-pack.c: static int verify_one_pack(const char *path, unsigned int flags)
    - 		}
    - 	}
    - 	strbuf_release(&arg);
    -+	argv_array_clear(&argv);
    - 
    - 	return err;
    - }
     @@ builtin/verify-pack.c: int cmd_verify_pack(int argc, const char **argv, const char *prefix)
      {
      	int err = 0;
31:  e3805101ce ! 31:  9a0345a1f6 bundle: add new version for use with SHA-256
    @@ bundle.c: static void add_to_ref_list(const struct object_id *oid, const char *n
     +	if (skip_prefix(capability, "object-format=", &arg)) {
     +		int algo = hash_algo_by_name(arg);
     +		if (algo == GIT_HASH_UNKNOWN)
    -+			return error(_("unable to detect hash algorithm"));
    ++			return error(_("unrecognized bundle hash algorithm: %s"), arg);
     +		header->hash_algo = &hash_algos[algo];
     +		return 0;
     +	}
    @@ bundle.c: static int parse_bundle_header(int fd, struct bundle_header *header,
      		int is_prereq = 0;
      		const char *p;
      
    -+		if (header->version == 3 && *buf.buf == '@') {
    -+			buf.buf[--buf.len] = '\0';
    -+			if (parse_capability(header, buf.buf + 1)) {
    -+				status = -1;
    -+				break;
    -+			}
    -+			continue;
    -+		}
    -+
    - 		if (*buf.buf == '-') {
    - 			is_prereq = 1;
    - 			strbuf_remove(&buf, 0, 1);
    - 		}
    +-		if (*buf.buf == '-') {
    +-			is_prereq = 1;
    +-			strbuf_remove(&buf, 0, 1);
    +-		}
      		strbuf_rtrim(&buf);
      
     -		if (!header->hash_algo) {
     -			header->hash_algo = detect_hash_algo(&buf);
     -			if (!header->hash_algo) {
     -				error(_("unknown hash algorithm length"));
    --				status = -1;
    --				break;
    --			}
    --		}
    --
    ++		if (header->version == 3 && *buf.buf == '@') {
    ++			if (parse_capability(header, buf.buf + 1)) {
    + 				status = -1;
    + 				break;
    + 			}
    ++			continue;
    ++		}
    ++
    ++		if (*buf.buf == '-') {
    ++			is_prereq = 1;
    ++			strbuf_remove(&buf, 0, 1);
    + 		}
    + 
      		/*
    - 		 * Tip lines have object name, SP, and refname.
    - 		 * Prerequisites have object name that is optionally
     @@ bundle.c: static int write_bundle_refs(int bundle_fd, struct rev_info *revs)
      }
      
    @@ bundle.c: static int write_bundle_refs(int bundle_fd, struct rev_info *revs)
      	int bundle_to_stdout;
      	int ref_count = 0;
      	struct rev_info revs;
    -+	int default_version = the_hash_algo == &hash_algos[GIT_HASH_SHA1] ? 2 : 3;
    ++	int min_version = the_hash_algo == &hash_algos[GIT_HASH_SHA1] ? 2 : 3;
      
      	bundle_to_stdout = !strcmp(path, "-");
      	if (bundle_to_stdout)
    @@ bundle.c: int create_bundle(struct repository *r, const char *path,
     -	/* write signature */
     -	write_or_die(bundle_fd, bundle_signature, strlen(bundle_signature));
     +	if (version == -1)
    -+		version = default_version;
    ++		version = min_version;
     +
     +	if (version < 2 || version > 3) {
     +		die(_("unsupported bundle version %d"), version);
    -+	} else if (version < default_version) {
    ++	} else if (version < min_version) {
     +		die(_("cannot write bundle version %d with algorithm %s"), version, the_hash_algo->name);
     +	} else if (version == 2) {
     +		write_or_die(bundle_fd, v2_bundle_signature, strlen(v2_bundle_signature));
    @@ t/t5510-fetch.sh: test_expect_success 'create bundle 1' '
      '
      
      test_expect_success 'header of bundle looks right' '
    - 	head -n 4 "$D"/bundle1 &&
    +-	head -n 4 "$D"/bundle1 &&
     -	head -n 1 "$D"/bundle1 | grep "^#" &&
     -	head -n 2 "$D"/bundle1 | grep "^-$OID_REGEX " &&
     -	head -n 3 "$D"/bundle1 | grep "^$OID_REGEX " &&
    @@ t/t5510-fetch.sh: test_expect_success 'create bundle 1' '
     +	cat >expect <<-EOF &&
     +	# v3 git bundle
     +	@object-format=$(test_oid algo)
    -+	-OID message
    -+	OID message
    ++	-OID updated by origin
    ++	OID refs/heads/master
     +
     +	EOF
    -+	sed -e "s/$OID_REGEX .*/OID message/g" -e "5q" "$D"/bundle1 >actual &&
    ++	sed -e "s/$OID_REGEX/OID/g" -e "5q" "$D"/bundle1 >actual &&
     +	test_cmp expect actual
      '
      
32:  c941fcf63c = 32:  4b72b98ce7 setup: add support for reading extensions.objectformat
33:  7c6264ac79 ! 33:  73ef3ef66a Enable SHA-256 support by default
    @@ t/t0001-init.sh: test_expect_success 're-init from a linked worktree' '
     +'
     +
     +test_expect_success 'init honors --object-format' '
    -+	git init --object-format=sha256 explicit &&
    -+	git -C explicit rev-parse --show-object-format >actual &&
    ++	git init --object-format=sha1 explicit-sha1 &&
    ++	git -C explicit-sha1 rev-parse --show-object-format >actual &&
    ++	echo sha1 >expected &&
    ++	test_cmp expected actual &&
    ++	git init --object-format=sha256 explicit-sha256 &&
    ++	git -C explicit-sha256 rev-parse --show-object-format >actual &&
     +	echo sha256 >expected &&
     +	test_cmp expected actual
     +'
34:  2719ab94e6 = 34:  2512a1669c t: add test_oid option to select hash algorithm
35:  1c8e5041d1 = 35:  015636559b t: allow testing different hash algorithms via environment
36:  7213d59222 <  -:  ---------- t: make SHA1 prerequisite depend on default hash
 -:  ---------- > 36:  6f2dec51cd t: make SHA1 prerequisite depend on default hash
37:  caf6c026ba ! 37:  32536503f3 ci: run tests with SHA-256
    @@ Commit message
         run as fast as possible, so we wouldn't want to add a third run to the
         linux-gcc job.  To make sure we properly exercise the code, let's run
         the tests in the default mode (SHA-1) first and then run a second time
    -    with SHA-256.
    +    with SHA-256.  We explicitly specify SHA-1 for the first run so that if
    +    we change the default in the future, we make sure to test both cases.
     
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
     
    @@ ci/run-build-and-tests.sh: linux-gcc)
      	make test
      	;;
     +linux-clang)
    ++	export GIT_TEST_DEFAULT_HASH=sha1
     +	make test
     +	export GIT_TEST_DEFAULT_HASH=sha256
     +	make test
38:  ec4e6ae166 ! 38:  cc5679d353 docs: add documentation for extensions.objectFormat
    @@ Documentation/config/extensions.txt (new)
     +extensions.objectFormat::
     +	Specify the hash algorithm to use.  The acceptable values are `sha1` and
     +	`sha256`.  If not specified, `sha1` is assumed.  It is an error to specify
    -+	this key unless `core.repositoryformatversion` is 1.
    ++	this key unless `core.repositoryFormatVersion` is 1.
     ++
     +Note that this setting should only be set by linkgit:git-init[1] or
     +linkgit:git-clone[1].  Trying to change it after initialization will not
39:  3185c62cfc ! 39:  307b75c88e t: remove test_oid_init in tests
    @@ t/t7003-filter-branch.sh: test_description='git filter-branch'
      	GIT_COMMITTER_DATE="@0 +0000" GIT_AUTHOR_DATE="@0 +0000" &&
      	test_commit --notick B &&
     
    - ## t/t8002-blame.sh ##
    -@@ t/t8002-blame.sh: test_description='git blame'
    - PROG='git blame -c'
    - . "$TEST_DIRECTORY"/annotate-tests.sh
    - 
    --test_expect_success 'setup' '
    --	test_oid_init
    --'
    --
    - test_expect_success 'blame untracked file in empty repo' '
    - 	>untracked &&
    - 	test_must_fail git blame untracked
    -
      ## t/t8003-blame-corner-cases.sh ##
     @@ t/t8003-blame-corner-cases.sh: test_description='git blame corner cases'
      pick_fc='s/^[0-9a-f^]* *\([^ ]*\) *(\([^ ]*\) .*/\1-\2/'
