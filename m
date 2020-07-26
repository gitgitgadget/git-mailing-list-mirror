Return-Path: <SRS0=BIPJ=BF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC48C433E0
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 19:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4EE220738
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 19:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="JKKQVDHl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbgGZTyn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jul 2020 15:54:43 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40648 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726244AbgGZTym (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 26 Jul 2020 15:54:42 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6122E607A2;
        Sun, 26 Jul 2020 19:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595793280;
        bh=7gZmHwXI75uycU+T/KAZwMAEtdQ1nsBqm3XrTvU8aWg=;
        h=From:To:Cc:Subject:Date:Content-Type:From:Reply-To:Subject:Date:
         To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=JKKQVDHlJWHFFyqSNy/TmTEmMNovnW7VZqYnZPTJb/BfrpLtdRCb8g0eKMlUlZunw
         PHRSxYqdpHP7eochUJ8JZaoiUQ2i+rDtnr4mL7lXCGVmZHoq1FbmtMnNm17DaXVRxf
         5JPyDaqyoWUSSLdAOViIW9rc6EbzZVMKVw2yFQLJb7i+7SjTWgXeqrGS+9aopZndrK
         D1Ab0d24RzMvSHwnED+Of24649PHjDmtLDoNNZc273siKkUuu+44VdvoabX2lJUsZH
         Y87zb9EqjwaYGUwgP7qxiX1837XP9NSxVh/MQ2bX6LK3dSCuLNXQddQ3MzvrpjO3jt
         SnVvvgLHyNFsJUtGG1SNXe9RlSwDNbPJGXfnehp7q2gfP6fTncsFdBWwgOhrHk6+FZ
         Ze5n+VBW8tTeWctsEWkhJ7uYpkoU2OdzOnsriQW5/5zJLtCbSbFHjqWNtKkitiIIHY
         8wQKOpJEKu9cIjrlzJeDZEhc/98yMaNiwH7n2aTT/ttA34/u3rm
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 00/39] SHA-256, part 3/3
Date:   Sun, 26 Jul 2020 19:53:45 +0000
Message-Id: <20200726195424.626969-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.rc2.160.gd0b3904b262
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the final part required for the stage 4 implementation of
SHA-256.

Changes from v3:

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
 builtin/verify-pack.c                     |  29 +++--
 bundle.c                                  |  85 ++++++++----
 bundle.h                                  |   4 +-
 ci/run-build-and-tests.sh                 |   5 +
 config.mak.dev                            |   2 -
 http-fetch.c                              |   4 +-
 repository.c                              |   4 -
 setup.c                                   |  16 ++-
 t/helper/test-bloom.c                     |   2 +
 t/lib-pack.sh                             |  11 +-
 t/lib-submodule-update.sh                 |   1 -
 t/t0000-basic.sh                          |  15 ++-
 t/t0001-init.sh                           |  29 +++++
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
 t/t5510-fetch.sh                          |  15 ++-
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
 t/t7063-status-untracked-cache.sh         | 151 ++++++++++++----------
 t/t7102-reset.sh                          |  93 +++++++------
 t/t7201-co.sh                             |   5 +-
 t/t7400-submodule-basic.sh                |  26 ++--
 t/t7405-submodule-merge.sh                |   4 +-
 t/t7506-status-submodule.sh               |  12 +-
 t/t7508-status.sh                         |   2 +-
 t/t8002-blame.sh                          |  15 ++-
 t/t8003-blame-corner-cases.sh             |   3 +-
 t/t8011-blame-split-file.sh               |   2 +-
 t/t9300-fast-import.sh                    | 117 +++++++++--------
 t/t9301-fast-import-notes.sh              |  13 +-
 t/t9350-fast-export.sh                    |  15 +--
 t/t9500-gitweb-standalone-no-errors.sh    |  22 +++-
 t/t9700/test.pl                           |   6 +-
 t/test-lib-functions.sh                   |  16 ++-
 t/test-lib.sh                             |   6 +-
 74 files changed, 629 insertions(+), 355 deletions(-)
 create mode 100644 Documentation/config/extensions.txt

Diff-intervalle contre v3 :
 1:  792a7e6b99 =  1:  2d720a6beb t: make test-bloom initialize repository
 2:  652259edaa =  2:  530704736a t1001: use $ZERO_OID
 3:  b719726393 =  3:  33e7822d0e t3305: make hash agnostic
 4:  137c86a4e0 =  4:  82a6827f45 t3404: prepare 'short SHA-1 collision' tests for SHA-256
 5:  307b90fa2a =  5:  23cbd25060 t6100: make hash size independent
 6:  f5f4028291 =  6:  9e2553b1f2 t6101: make hash size independent
 7:  654b95494c =  7:  c2c5dd407e t6301: make hash size independent
 8:  787bde1ffc =  8:  1ab4ed032a t6500: specify test values for SHA-256
 9:  b63ed599fe =  9:  54fcc025bb t6501: avoid hard-coded objects
10:  40847a1490 = 10:  a2f420fcd4 t7003: compute appropriate length constant
11:  3dbd65993c = 11:  766bba42f6 t7063: make hash size independent
12:  bba7969017 = 12:  66d242ccd9 t7201: abstract away SHA-1-specific constants
13:  bf5d06f1fc = 13:  090041ee54 t7102: abstract away SHA-1-specific constants
14:  a272eafa86 = 14:  4a6991d6a1 t7400: make hash size independent
15:  4dc14d1ded = 15:  d39bbeb5a2 t7405: make hash size independent
16:  f291df2f20 = 16:  5b0d52ae0e t7506: avoid checking for SHA-1-specific constants
17:  ded35216ce = 17:  54d1706107 t7508: use $ZERO_OID instead of hard-coded constant
18:  a197d7f09a = 18:  f3f4239ce9 t8002: make hash size independent
19:  7c49d9a8e8 = 19:  719db3822e t8003: make hash size independent
20:  4ab13f691a = 20:  803e5665e9 t8011: make hash size independent
21:  81edf64b72 = 21:  d1c4351bc9 t9300: abstract away SHA-1-specific constants
22:  d8253d9aca = 22:  db74bf3c8c t9300: use $ZERO_OID instead of hard-coded object ID
23:  7b40da5753 = 23:  fa7daed2bf t9301: make hash size independent
24:  1890f22a5b = 24:  84aef86ac0 t9350: make hash size independent
25:  708f599a71 = 25:  541108fc64 t9500: ensure that algorithm info is preserved in config
26:  33c84a2bc6 = 26:  2de5d2da58 t9700: make hash size independent
27:  3d7476f28b = 27:  c916058c38 t5308: make test work with SHA-256
28:  0d80e419e5 = 28:  b0781430ef t0410: mark test with SHA1 prerequisite
29:  bd812fb0e4 = 29:  230a933e87 http-fetch: set up git directory before parsing pack hashes
30:  667537e1aa ! 30:  d3dbe9e760 builtin/verify-pack: implement an --object-format option
    @@ Commit message
         Since we're not in a repository here, we need to provide git verify-pack
         help to set things up properly.  git index-pack already knows an
         --object-format option, so let's accept one as well and pass it down to
    -    our git index-pack invocation.  Since this argument is optional, let's
    -    dynamically determine the proper location to insert it into the array.
    -    Finally, let's make t5702 pass the proper argument on down to its git
    -    verify-pack caller.
    +    our git index-pack invocation.  Since we're now dynamically adjusting
    +    the elements in argv, let's switch to using struct argv_array to manage
    +    them.  Finally, let's make t5702 pass the proper argument on down to its
    +    git verify-pack caller.
     
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
     
    @@ builtin/verify-pack.c
      	struct child_process index_pack = CHILD_PROCESS_INIT;
     -	const char *argv[] = {"index-pack", NULL, NULL, NULL };
     -	struct strbuf arg = STRBUF_INIT;
    -+	const char *argv[] = {"index-pack", NULL, NULL, NULL, NULL };
    ++	struct argv_array argv = ARGV_ARRAY_INIT;
     +	struct strbuf arg = STRBUF_INIT, hash_arg = STRBUF_INIT;
      	int verbose = flags & VERIFY_PACK_VERBOSE;
      	int stat_only = flags & VERIFY_PACK_STAT_ONLY;
      	int err;
    -+	int argno = 1;
      
    ++	argv_array_push(&argv, "index-pack");
    ++
      	if (stat_only)
     -		argv[1] = "--verify-stat-only";
    -+		argv[argno++] = "--verify-stat-only";
    ++		argv_array_push(&argv, "--verify-stat-only");
      	else if (verbose)
     -		argv[1] = "--verify-stat";
    -+		argv[argno++] = "--verify-stat";
    ++		argv_array_push(&argv, "--verify-stat");
      	else
     -		argv[1] = "--verify";
    -+		argv[argno++] = "--verify";
    ++		argv_array_push(&argv, "--verify");
     +
     +	if (hash_algo) {
     +		strbuf_addf(&hash_arg, "--object-format=%s", hash_algo);
    -+		argv[argno++] = hash_arg.buf;
    ++		argv_array_push(&argv, hash_arg.buf);
     +	}
      
      	/*
    @@ builtin/verify-pack.c: static int verify_one_pack(const char *path, unsigned int
      	    !ends_with(arg.buf, ".pack"))
      		strbuf_addstr(&arg, ".pack");
     -	argv[2] = arg.buf;
    -+	argv[argno++] = arg.buf;
    ++	argv_array_push(&argv, arg.buf);
      
    - 	index_pack.argv = argv;
    +-	index_pack.argv = argv;
    ++	index_pack.argv = argv.argv;
      	index_pack.git_cmd = 1;
    + 
    + 	err = run_command(&index_pack);
    +@@ builtin/verify-pack.c: static int verify_one_pack(const char *path, unsigned int flags)
    + 		}
    + 	}
    + 	strbuf_release(&arg);
    ++	argv_array_clear(&argv);
    + 
    + 	return err;
    + }
     @@ builtin/verify-pack.c: int cmd_verify_pack(int argc, const char **argv, const char *prefix)
      {
      	int err = 0;
31:  acdf1d9009 ! 31:  e3805101ce bundle: add new version for use with SHA-256
    @@ Commit message
         for SHA-256.
     
         In t5510, always use format v3 so we can be sure we produce consistent
    -    results across hash algorithms.  Note here that head -n N lists the top
    -    N lines, whereas we want to check only the given line, so while we're at
    -    it, switch to use sed to make sure we're checking only the line we care
    -    about for a match.
    +    results across hash algorithms.  Since head -n N lists the top N lines
    +    instead of the Nth line, let's run our output through sed to normalize
    +    it and compare it against a fixed value, which will make sure we get
    +    exactly what we're expecting.
     
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
     
    @@ Documentation/technical/bundle-format.txt: reference    = obj-id SP refname LF
      == Semantics
      
     -A Git bundle consists of three parts.
    -+A Git bundle consists of four parts.
    ++A Git bundle consists of several parts.
     +
     +* "Capabilities", which are only in the v3 format, indicate functionality that
     +	the bundle requires to be read properly.
    @@ t/t5510-fetch.sh: test_expect_success 'create bundle 1' '
     -	head -n 2 "$D"/bundle1 | grep "^-$OID_REGEX " &&
     -	head -n 3 "$D"/bundle1 | grep "^$OID_REGEX " &&
     -	head -n 4 "$D"/bundle1 | grep "^$"
    -+	sed -n -e 1p "$D"/bundle1 | grep "^#" &&
    -+	sed -n -e 2p "$D"/bundle1 | grep "^@object-format=" &&
    -+	sed -n -e 3p "$D"/bundle1 | grep "^-$OID_REGEX " &&
    -+	sed -n -e 4p "$D"/bundle1 | grep "^$OID_REGEX " &&
    -+	sed -n -e 5p "$D"/bundle1 | grep "^$"
    ++	cat >expect <<-EOF &&
    ++	# v3 git bundle
    ++	@object-format=$(test_oid algo)
    ++	-OID message
    ++	OID message
    ++
    ++	EOF
    ++	sed -e "s/$OID_REGEX .*/OID message/g" -e "5q" "$D"/bundle1 >actual &&
    ++	test_cmp expect actual
      '
      
      test_expect_success 'create bundle 2' '
    @@ t/t5607-clone-bundle.sh: test_expect_success 'fetch SHA-1 from bundle' '
     +	# v3 git bundle
     +	@object-format=$(test_oid algo)
     +	EOF
    -+	test_cmp actual expect &&
    ++	test_cmp expect actual &&
     +	git bundle verify bundle
     +'
     +
    -+test_expect_success 'git bundle v3 rejects unknown extensions' '
    -+	head -n2 bundle >new &&
    -+	echo "@unknown=silly" >>new &&
    -+	sed "1,2d" bundle >>new &&
    ++test_expect_success 'git bundle v3 rejects unknown capabilities' '
    ++	cat >new <<-EOF &&
    ++	# v3 git bundle
    ++	@object-format=$(test_oid algo)
    ++	@unknown=silly
    ++	EOF
     +	test_must_fail git bundle verify new 2>output &&
     +	test_i18ngrep "unknown capability .unknown=silly." output
     +'
32:  65310eaf1b = 32:  c941fcf63c setup: add support for reading extensions.objectformat
33:  f69cf8b1b5 = 33:  7c6264ac79 Enable SHA-256 support by default
34:  e41d139b78 ! 34:  2719ab94e6 t: add test_oid option to select hash algorithm
    @@ Commit message
     
         In order to do so, we'll need to read both the source algorithm and the
         current algorithm, so add an optional flag to the test_oid helper that
    -    lets us read look up a value for a specified hash algorithm. This should
    +    lets us look up a value for a specified hash algorithm. This should
         not cause any conflicts with existing tests, since key arguments to
         test_oid are allowed to contains only shell identifier characters.
     
    @@ t/t0000-basic.sh: test_expect_success 'test_oid can look up data for SHA-256' '
      	test "$hexsz" -eq 64
      '
      
    -+test_expect_success 'test_oid can look up data a specified algorithm' '
    ++test_expect_success 'test_oid can look up data for a specified algorithm' '
     +	rawsz="$(test_oid --hash=sha1 rawsz)" &&
     +	hexsz="$(test_oid --hash=sha1 hexsz)" &&
     +	test "$rawsz" -eq 20 &&
    @@ t/test-lib-functions.sh: test_oid_cache () {
     +	local algo="${test_hash_algo}" &&
     +
     +	case "$1" in
    -+		--hash=*)
    -+			algo="${1#--hash=}" &&
    -+			shift;;
    -+		*)
    -+			;;
    ++	--hash=*)
    ++		algo="${1#--hash=}" &&
    ++		shift;;
    ++	*)
    ++		;;
     +	esac &&
     +
     +	local var="test_oid_${algo}_$1" &&
35:  20dbc5ff66 = 35:  1c8e5041d1 t: allow testing different hash algorithms via environment
36:  4ee7f9eec8 = 36:  7213d59222 t: make SHA1 prerequisite depend on default hash
37:  0080a96f7b = 37:  caf6c026ba ci: run tests with SHA-256
38:  03e1203a08 = 38:  ec4e6ae166 docs: add documentation for extensions.objectFormat
39:  fbc015258f = 39:  3185c62cfc t: remove test_oid_init in tests
