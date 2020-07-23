Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15AB9C433E0
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 01:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE7242053B
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 01:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="so9LfGPQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387644AbgGWBK0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jul 2020 21:10:26 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40522 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387462AbgGWBKX (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 22 Jul 2020 21:10:23 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 219236044E
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 01:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595466591;
        bh=oTnqlLzc3z6+XBWryRRjh1uq39etXQdYH3IVOqGrVP0=;
        h=From:To:Subject:Date:From:Reply-To:Subject:Date:To:CC:Resent-Date:
         Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=so9LfGPQiaeLcWfrg/jnENKhMRZOggCqV9JQli1A9Rx28+Ppux3dXar871a/Qbplo
         9ViGioh4DbwO1ElPqcWKTQxBpAQIMdiapxXl2X6WRHO+ToirEBpA+cMiYYR5Fl3SFR
         KdJwTgBNP6mOLQVwKUVOj/FQzvgoBu7RooOzM4KgPqPF0KyaEs1r//irxe84LH00Cf
         HOPvtoHZ9dnqOVnjdY48wRDXhafhZY7/SgvNzzquoT8ex2S3Adn8ExWWPSMqDCCg9t
         7PxuvyX7SmYwW6BcDKmnheW6f2N8CzdnlgBmw33sOy95Q74PJMQAZn9Tn8eq7P+UDD
         2cEOBFZwv0Mm1APYvR8EfMx1zpqh2qO7t1mGEXVmnu8pcrTVbNvPKiagGBUcsEig6P
         X3WrTkUmB9XRmamkJIFz+H0GFOb8hEoceR+niPkST4pKnrazsD3tp1/KE8+n/NDwk9
         iepV6LsHEkZbdH0hICEGuPcYZAvlYixwYWL8bADDRIbgbRXVnDZ
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [PATCH v3 00/39] SHA-256, part 3/3
Date:   Thu, 23 Jul 2020 01:09:04 +0000
Message-Id: <20200723010943.2329634-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.rc1.129.ge9626dbbb9f
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the final part required for the stage 4 implementation of
SHA-256.

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
 builtin/verify-pack.c                     |  25 ++--
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
 t/t5510-fetch.sh                          |  11 +-
 t/t5530-upload-pack-error.sh              |   1 -
 t/t5562-http-backend-content-length.sh    |   1 -
 t/t5607-clone-bundle.sh                   |  29 +++++
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
 74 files changed, 620 insertions(+), 354 deletions(-)
 create mode 100644 Documentation/config/extensions.txt

Range-diff against v2:
 1:  11bb3918df =  1:  792a7e6b99 t: make test-bloom initialize repository
 2:  bff32965d2 =  2:  652259edaa t1001: use $ZERO_OID
 3:  03f49899e0 =  3:  b719726393 t3305: make hash agnostic
 4:  d6c75da18f =  4:  137c86a4e0 t3404: prepare 'short SHA-1 collision' tests for SHA-256
 5:  31cbce9d44 =  5:  307b90fa2a t6100: make hash size independent
 6:  bc21adaf33 =  6:  f5f4028291 t6101: make hash size independent
 7:  31a1c614cf =  7:  654b95494c t6301: make hash size independent
 8:  4c19b39507 =  8:  787bde1ffc t6500: specify test values for SHA-256
 9:  cd43450d20 =  9:  b63ed599fe t6501: avoid hard-coded objects
10:  2f7ef3bd9d = 10:  40847a1490 t7003: compute appropriate length constant
11:  96b29887b0 = 11:  3dbd65993c t7063: make hash size independent
12:  d67c1e49d0 = 12:  bba7969017 t7201: abstract away SHA-1-specific constants
13:  48b254250b = 13:  bf5d06f1fc t7102: abstract away SHA-1-specific constants
14:  cfc96d8181 = 14:  a272eafa86 t7400: make hash size independent
15:  187f3bf5c1 = 15:  4dc14d1ded t7405: make hash size independent
16:  0d91991588 = 16:  f291df2f20 t7506: avoid checking for SHA-1-specific constants
17:  e22ec03788 = 17:  ded35216ce t7508: use $ZERO_OID instead of hard-coded constant
18:  bfd9a593a7 = 18:  a197d7f09a t8002: make hash size independent
19:  d4ca86e473 = 19:  7c49d9a8e8 t8003: make hash size independent
20:  28d1b7bf0b = 20:  4ab13f691a t8011: make hash size independent
21:  c982602ffa = 21:  81edf64b72 t9300: abstract away SHA-1-specific constants
22:  503be79740 = 22:  d8253d9aca t9300: use $ZERO_OID instead of hard-coded object ID
23:  bdede03ff0 = 23:  7b40da5753 t9301: make hash size independent
24:  a50d67d7bd = 24:  1890f22a5b t9350: make hash size independent
25:  acea64aa18 = 25:  708f599a71 t9500: ensure that algorithm info is preserved in config
26:  0b5bb05dea = 26:  33c84a2bc6 t9700: make hash size independent
27:  41a1e3a78f = 27:  3d7476f28b t5308: make test work with SHA-256
28:  70f77a2508 <  -:  ---------- t0410: mark test with SHA1 prerequisite
 -:  ---------- > 28:  0d80e419e5 t0410: mark test with SHA1 prerequisite
29:  1c619ed160 = 29:  bd812fb0e4 http-fetch: set up git directory before parsing pack hashes
30:  cd643a0b1d = 30:  667537e1aa builtin/verify-pack: implement an --object-format option
31:  611ad8ffd0 ! 31:  acdf1d9009 bundle: add new version for use with SHA-256
    @@ Commit message
         for SHA-256.
     
         In t5510, always use format v3 so we can be sure we produce consistent
    -    results across hash algorithms.
    +    results across hash algorithms.  Note here that head -n N lists the top
    +    N lines, whereas we want to check only the given line, so while we're at
    +    it, switch to use sed to make sure we're checking only the line we care
    +    about for a match.
     
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
     
    @@ bundle.c
      #include "argv-array.h"
      
     -static const char bundle_signature[] = "# v2 git bundle\n";
    ++
     +static const char v2_bundle_signature[] = "# v2 git bundle\n";
     +static const char v3_bundle_signature[] = "# v3 git bundle\n";
    ++static struct {
    ++	int version;
    ++	const char *signature;
    ++} bundle_sigs[] = {
    ++	{ 2, v2_bundle_signature },
    ++	{ 3, v3_bundle_signature },
    ++};
      
      static void add_to_ref_list(const struct object_id *oid, const char *name,
      		struct ref_list *list)
    @@ bundle.c: static void add_to_ref_list(const struct object_id *oid, const char *n
      {
     -	size_t len = strcspn(buf->buf, " \n");
     -	int algo;
    --
    --	algo = hash_algo_by_length(len / 2);
    --	if (algo == GIT_HASH_UNKNOWN)
    --		return NULL;
    --	return &hash_algos[algo];
     +	const char *arg;
     +	if (skip_prefix(capability, "object-format=", &arg)) {
     +		int algo = hash_algo_by_name(arg);
    @@ bundle.c: static void add_to_ref_list(const struct object_id *oid, const char *n
     +		return 0;
     +	}
     +	return error(_("unknown capability '%s'"), capability);
    ++}
    + 
    +-	algo = hash_algo_by_length(len / 2);
    +-	if (algo == GIT_HASH_UNKNOWN)
    +-		return NULL;
    +-	return &hash_algos[algo];
    ++static int parse_bundle_signature(struct bundle_header *header, const char *line)
    ++{
    ++	int i;
    ++
    ++	for (i = 0; i < ARRAY_SIZE(bundle_sigs); i++) {
    ++		if (!strcmp(line, bundle_sigs[i].signature)) {
    ++			header->version = bundle_sigs[i].version;
    ++			return 0;
    ++		}
    ++	}
    ++	return -1;
      }
      
    -+
      static int parse_bundle_header(int fd, struct bundle_header *header,
    - 			       const char *report_path)
    - {
     @@ bundle.c: static int parse_bundle_header(int fd, struct bundle_header *header,
      
      	/* The bundle header begins with the signature */
      	if (strbuf_getwholeline_fd(&buf, fd, '\n') ||
     -	    strcmp(buf.buf, bundle_signature)) {
    -+	    (strcmp(buf.buf, v2_bundle_signature) &&
    -+	     strcmp(buf.buf, v3_bundle_signature))) {
    ++	    parse_bundle_signature(header, buf.buf)) {
      		if (report_path)
     -			error(_("'%s' does not look like a v2 bundle file"),
     +			error(_("'%s' does not look like a v2 or v3 bundle file"),
    @@ bundle.c: static int parse_bundle_header(int fd, struct bundle_header *header,
      		goto abort;
      	}
      
    -+	header->version = buf.buf[3] - '0';
     +	header->hash_algo = the_hash_algo;
     +
      	/* The bundle header ends with an empty line */
    @@ bundle.c: static int parse_bundle_header(int fd, struct bundle_header *header,
      		const char *p;
      
     +		if (header->version == 3 && *buf.buf == '@') {
    -+			buf.buf[buf.len - 1] = '\0';
    ++			buf.buf[--buf.len] = '\0';
     +			if (parse_capability(header, buf.buf + 1)) {
     +				status = -1;
     +				break;
    @@ t/t5510-fetch.sh: test_expect_success 'create bundle 1' '
      
      test_expect_success 'header of bundle looks right' '
      	head -n 4 "$D"/bundle1 &&
    - 	head -n 1 "$D"/bundle1 | grep "^#" &&
    +-	head -n 1 "$D"/bundle1 | grep "^#" &&
     -	head -n 2 "$D"/bundle1 | grep "^-$OID_REGEX " &&
     -	head -n 3 "$D"/bundle1 | grep "^$OID_REGEX " &&
     -	head -n 4 "$D"/bundle1 | grep "^$"
    -+	head -n 2 "$D"/bundle1 | grep "^@object-format=" &&
    -+	head -n 3 "$D"/bundle1 | grep "^-$OID_REGEX " &&
    -+	head -n 4 "$D"/bundle1 | grep "^$OID_REGEX " &&
    -+	head -n 5 "$D"/bundle1 | grep "^$"
    ++	sed -n -e 1p "$D"/bundle1 | grep "^#" &&
    ++	sed -n -e 2p "$D"/bundle1 | grep "^@object-format=" &&
    ++	sed -n -e 3p "$D"/bundle1 | grep "^-$OID_REGEX " &&
    ++	sed -n -e 4p "$D"/bundle1 | grep "^$OID_REGEX " &&
    ++	sed -n -e 5p "$D"/bundle1 | grep "^$"
      '
      
      test_expect_success 'create bundle 2' '
    @@ t/t5607-clone-bundle.sh: test_expect_success 'fetch SHA-1 from bundle' '
     +	git branch side HEAD &&
     +	git bundle create --version=3 bundle HEAD^..side &&
     +	head -n2 bundle >actual &&
    -+	echo "# v3 git bundle" >expected &&
    -+	echo "@object-format=$(test_oid algo)" >>expected &&
    -+	test_cmp actual expected &&
    ++	cat >expect <<-EOF &&
    ++	# v3 git bundle
    ++	@object-format=$(test_oid algo)
    ++	EOF
    ++	test_cmp actual expect &&
     +	git bundle verify bundle
     +'
     +
     +test_expect_success 'git bundle v3 rejects unknown extensions' '
     +	head -n2 bundle >new &&
     +	echo "@unknown=silly" >>new &&
    -+	sed "1,2d" >>new &&
    ++	sed "1,2d" bundle >>new &&
     +	test_must_fail git bundle verify new 2>output &&
    -+	grep "unknown capability .unknown=silly." output
    ++	test_i18ngrep "unknown capability .unknown=silly." output
     +'
     +
      test_done
32:  f299f46406 ! 32:  65310eaf1b setup: add support for reading extensions.objectformat
    @@ Commit message
         the extensions we support.  If the user has specified an invalid value,
         fail.
     
    -    Ensure that we don't use the value of the extension if the repository
    -    format version is 0.
    +    Ensure that we reject the extension if the repository format version is
    +    0.
     
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
     
    @@ setup.c: static int check_repo_format(const char *var, const char *value, void *
      			string_list_append(&data->unknown_extensions, ext);
      	}
      
    -@@ setup.c: static int check_repository_format_gently(const char *gitdir, struct repository_
    - 		repository_format_precious_objects = 0;
    - 		set_repository_format_partial_clone(NULL);
    - 		repository_format_worktree_config = 0;
    -+		candidate->hash_algo = GIT_HASH_SHA1;
    +@@ setup.c: int verify_repository_format(const struct repository_format *format,
    + 		return -1;
      	}
    - 	string_list_clear(&candidate->unknown_extensions, 0);
    + 
    ++	if (format->version <= 0 && format->hash_algo != GIT_HASH_SHA1) {
    ++		strbuf_addstr(err, _("extensions.objectFormat is not valid in repo v0"));
    ++		return -1;
    ++	}
    ++
    + 	return 0;
    + }
      
33:  59652ad4e7 ! 33:  f69cf8b1b5 Enable SHA-256 support by default
    @@ t/t0001-init.sh: test_expect_success 're-init from a linked worktree' '
     +	test_cmp expected actual
     +'
     +
    -+test_expect_success 'extensions.objectFormat is not honored with repo version 0' '
    ++test_expect_success 'extensions.objectFormat is not allowed with repo version 0' '
     +	git init --object-format=sha256 explicit-v0 &&
    -+	test_config -C explicit-v0 core.repositoryformatversion 0 &&
    -+	git -C explicit-v0 rev-parse --show-object-format >actual &&
    -+	echo sha1 >expected &&
    -+	test_cmp expected actual
    ++	git -C explicit-v0 config core.repositoryformatversion 0 &&
    ++	test_must_fail git -C explicit-v0 rev-parse --show-object-format
     +'
     +
     +test_expect_success 'init rejects attempts to initialize with different hash' '
34:  90d38c1f09 = 34:  e41d139b78 t: add test_oid option to select hash algorithm
35:  8eb68c2895 = 35:  20dbc5ff66 t: allow testing different hash algorithms via environment
36:  b0b832f3d8 = 36:  4ee7f9eec8 t: make SHA1 prerequisite depend on default hash
37:  f6fdad20d2 = 37:  0080a96f7b ci: run tests with SHA-256
38:  dce20fcd6e ! 38:  03e1203a08 docs: add documentation for extensions.objectFormat
    @@ Documentation/config/extensions.txt (new)
     @@
     +extensions.objectFormat::
     +	Specify the hash algorithm to use.  The acceptable values are `sha1` and
    -+	`sha256`.  If not specified, `sha1` is assumed.  As with other keys under
    -+	the `extensions` hierarchy, this value is ignored and has no effect unless
    -+	`core.repositoryformatversion` is 1.
    ++	`sha256`.  If not specified, `sha1` is assumed.  It is an error to specify
    ++	this key unless `core.repositoryformatversion` is 1.
     ++
     +Note that this setting should only be set by linkgit:git-init[1] or
     +linkgit:git-clone[1].  Trying to change it after initialization will not
39:  42d1c5b8d1 = 39:  fbc015258f t: remove test_oid_init in tests
