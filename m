Return-Path: <SRS0=B2P3=AY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56858C433E2
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 02:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DCB0206D9
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 02:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="fmutzuwr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgGMCt1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jul 2020 22:49:27 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40578 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726261AbgGMCtY (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 12 Jul 2020 22:49:24 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3E8BB60479;
        Mon, 13 Jul 2020 02:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1594608562;
        bh=Hlv6CqR8v+pQwoxRuC6J/Frhc93qcRkSRODHCh1fLws=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=fmutzuwrJMx5YZRh7nJlnh07TrJy6n5pUMXce8DVCMDI7hOi9qIHmSnYDC5wXJRi6
         4Asrk0PY+eKBpVbk5fTMAR4xv/t7m0BglAm6CKwzyTdF9Zm+/1YGCOSaTobSz78xlK
         DiSWWWh0X9egZooMpQr7ojq0A9BwO+//TT3tsOXysthAAD75n5GALsU6KyWqn5uzRv
         jgA4ivOpP5CPF2Y6s/N8RZNX3Z866dCtIsZAJT0iBknMlZJNECxkjMOKtqmER4kY3X
         m3oGjjnRErEj+cgsc6ixBh/OnlJxYhCpXnMuLel/aIGfWvwzLIa41yUOfBQBN+YXcR
         m75EEilgzWHQ7VCDlVJiugGDAspfY8XKdDFY+fb2K2fG2MwU61TAl2uXOIluVGz3Ge
         H+tWhOJJSYaUEk+k2Ts0ghg/9+AVVXteYoZ+/qnT8Xmmo3ZQg47+6UynFEAQJLbE5Q
         HLkt1L98esc34gklXtSHn+XYdwMHIqHJryFNKMMVNKPMj8dVW8b
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 00/39] SHA-256, part 3/3
Date:   Mon, 13 Jul 2020 02:48:30 +0000
Message-Id: <20200713024909.3714837-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.353.gb9a2d1a020
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the final part required for the stage 4 implementation of
SHA-256.

Note that the bundle code will necessarily conflict with the fixup patch
I sent earlier today because this series removes the code.  The correct
resolution is to just remove the code altogether.  Note that the bundle
code is not reachable for SHA-256 because SHA-256 repositories cannot
yet be created, so dropping support for SHA-256 bundles in the v2 format
does not cause compatibility concerns.

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
 Documentation/config/extensions.txt       |   9 ++
 Documentation/git-bundle.txt              |   9 +-
 Documentation/technical/bundle-format.txt |  30 ++++-
 builtin/bundle.c                          |   5 +-
 builtin/init-db.c                         |   5 -
 builtin/verify-pack.c                     |  25 ++--
 bundle.c                                  |  69 ++++++----
 bundle.h                                  |   4 +-
 ci/run-build-and-tests.sh                 |   5 +
 config.mak.dev                            |   2 -
 http-fetch.c                              |   4 +-
 repository.c                              |   4 -
 setup.c                                   |  12 +-
 t/helper/test-bloom.c                     |   2 +
 t/lib-pack.sh                             |  11 +-
 t/lib-submodule-update.sh                 |   1 -
 t/t0000-basic.sh                          |  15 ++-
 t/t0001-init.sh                           |  31 +++++
 t/t0410-partial-clone.sh                  |   2 +-
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
 t/t5510-fetch.sh                          |   9 +-
 t/t5530-upload-pack-error.sh              |   1 -
 t/t5562-http-backend-content-length.sh    |   1 -
 t/t5607-clone-bundle.sh                   |  27 ++++
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
 74 files changed, 598 insertions(+), 353 deletions(-)
 create mode 100644 Documentation/config/extensions.txt

Range-diff against v1:
 1:  11bb3918df =  1:  11bb3918df t: make test-bloom initialize repository
 2:  bff32965d2 =  2:  bff32965d2 t1001: use $ZERO_OID
 3:  03f49899e0 =  3:  03f49899e0 t3305: make hash agnostic
 4:  d6c75da18f =  4:  d6c75da18f t3404: prepare 'short SHA-1 collision' tests for SHA-256
 5:  31cbce9d44 =  5:  31cbce9d44 t6100: make hash size independent
 6:  bc21adaf33 =  6:  bc21adaf33 t6101: make hash size independent
 7:  31a1c614cf =  7:  31a1c614cf t6301: make hash size independent
 8:  4c19b39507 =  8:  4c19b39507 t6500: specify test values for SHA-256
 9:  cd43450d20 =  9:  cd43450d20 t6501: avoid hard-coded objects
10:  2f7ef3bd9d = 10:  2f7ef3bd9d t7003: compute appropriate length constant
11:  15b046720c ! 11:  96b29887b0 t7063: make hash size independent
    @@ t/t7063-status-untracked-cache.sh: test_expect_success 'move two from tracked to
     +/dtwo/ $ZERO_OID recurse check_only valid
      two
      EOF
    --	test_cmp ../expect ../actual
    -+	test_might_fail test_cmp ../expect ../actual
    - '
    - 
    - test_expect_success 'status after the move' '
    + 	test_cmp ../expect ../actual
     @@ t/t7063-status-untracked-cache.sh: EOF
      test_expect_success 'verify untracked cache dump' '
      	test-tool dump-untracked-cache >../actual &&
    @@ t/t7063-status-untracked-cache.sh: test_expect_success 'move two from untracked
     +/dtwo/ $ZERO_OID recurse check_only valid
      two
      EOF
    --	test_cmp ../expect ../actual
    -+	test_might_fail test_cmp ../expect ../actual
    - '
    - 
    - test_expect_success 'status after the move' '
    + 	test_cmp ../expect ../actual
     @@ t/t7063-status-untracked-cache.sh: EOF
      test_expect_success 'verify untracked cache dump' '
      	test-tool dump-untracked-cache >../actual &&
12:  d1e337a599 = 12:  d67c1e49d0 t7201: abstract away SHA-1-specific constants
13:  96f2727d48 = 13:  48b254250b t7102: abstract away SHA-1-specific constants
14:  85c9ac34f0 = 14:  cfc96d8181 t7400: make hash size independent
15:  9cbe6d9627 = 15:  187f3bf5c1 t7405: make hash size independent
16:  5aa1be2acf = 16:  0d91991588 t7506: avoid checking for SHA-1-specific constants
17:  62ff93bafd = 17:  e22ec03788 t7508: use $ZERO_OID instead of hard-coded constant
18:  f7bf7bf486 = 18:  bfd9a593a7 t8002: make hash size independent
19:  cd7840d3ef = 19:  d4ca86e473 t8003: make hash size independent
20:  407be13d21 ! 20:  28d1b7bf0b t8011: make hash size independent
    @@ Commit message
         t8011: make hash size independent
     
         Allow lines which start with either a 40- or 64-character hex object ID,
    -    to allow for both SHA-1 and NewHash.
    +    to allow for both SHA-1 and SHA-256.
     
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
     
21:  a29656ccfb = 21:  c982602ffa t9300: abstract away SHA-1-specific constants
22:  5c58ffc462 = 22:  503be79740 t9300: use $ZERO_OID instead of hard-coded object ID
23:  60f571ec20 = 23:  bdede03ff0 t9301: make hash size independent
24:  89af756277 = 24:  a50d67d7bd t9350: make hash size independent
25:  a770492eba = 25:  acea64aa18 t9500: ensure that algorithm info is preserved in config
26:  c9ef0e4de8 ! 26:  0b5bb05dea t9700: make hash size independent
    @@ Commit message
         t9700: make hash size independent
     
         The Perl test script for t9700 was matching on exactly 40 hex
    -    characters.  With NewHash, we'll have 64 hex-character object IDs.
    +    characters.  With SHA-256, we'll have 64 hex-character object IDs.
         Create a variable with a regex which matches exactly 40 or 64 hex
         characters and use that to match the output.  Note that both of the uses
         of this can be anchored, which makes the code simpler, so do that as
27:  963673a704 = 27:  41a1e3a78f t5308: make test work with SHA-256
28:  10af46914d = 28:  70f77a2508 t0410: mark test with SHA1 prerequisite
29:  25377eac9e = 29:  1c619ed160 http-fetch: set up git directory before parsing pack hashes
30:  52e957865e = 30:  cd643a0b1d builtin/verify-pack: implement an --object-format option
 -:  ---------- > 31:  611ad8ffd0 bundle: add new version for use with SHA-256
31:  dcd6a91833 = 32:  f299f46406 setup: add support for reading extensions.objectformat
32:  6949426537 = 33:  59652ad4e7 Enable SHA-256 support by default
33:  916458875a = 34:  90d38c1f09 t: add test_oid option to select hash algorithm
34:  361cce1e6a = 35:  8eb68c2895 t: allow testing different hash algorithms via environment
35:  9bdcdfe2a7 ! 36:  b0b832f3d8 t: make SHA1 prerequisite depend on default hash
    @@ t/test-lib.sh: test_lazy_prereq CURL '
      test_lazy_prereq SHA1 '
     -	test $(git hash-object /dev/null) = e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
     +	test $(git hash-object /dev/null) = e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 &&
    -+	([ -z "$GIT_DEFAULT_HASH" ] || [ "$GIT_DEFAULT_HASH" = "sha1" ])
    ++	{ test -z "$GIT_DEFAULT_HASH" || test "$GIT_DEFAULT_HASH" = "sha1"; }
      '
      
      test_lazy_prereq REBASE_P '
36:  7dbc2a5a58 <  -:  ---------- ci: run tests with SHA-256
 -:  ---------- > 37:  f6fdad20d2 ci: run tests with SHA-256
37:  1dc23e970b ! 38:  dce20fcd6e docs: add documentation for extensions.objectFormat
    @@ Documentation/config.txt: include::config/diff.txt[]
      ## Documentation/config/extensions.txt (new) ##
     @@
     +extensions.objectFormat::
    -+	Specify the hash algorithm to use.  The acceptable values are `sha1`
    -+	and (if supported) `sha256`.  If not specified, `sha1` is assumed.
    ++	Specify the hash algorithm to use.  The acceptable values are `sha1` and
    ++	`sha256`.  If not specified, `sha1` is assumed.  As with other keys under
    ++	the `extensions` hierarchy, this value is ignored and has no effect unless
    ++	`core.repositoryformatversion` is 1.
     ++
    -+Note that this setting should only by set by linkgit:git-init[1] or
    ++Note that this setting should only be set by linkgit:git-init[1] or
     +linkgit:git-clone[1].  Trying to change it after initialization will not
     +work and will produce hard-to-diagnose issues.
38:  f2c01f33d7 = 39:  42d1c5b8d1 t: remove test_oid_init in tests
