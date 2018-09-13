Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 327DA1F404
	for <e@80x24.org>; Thu, 13 Sep 2018 05:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbeIMKZw (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 06:25:52 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54364 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726317AbeIMKZw (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 13 Sep 2018 06:25:52 -0400
Received: from genre.crustytoothpaste.net (108-60-118-130.static.wiline.com [108.60.118.130])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 348F26046C;
        Thu, 13 Sep 2018 05:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1536815875;
        bh=fy8vvX67K2YBoTYt0cRFOv55ElLTT0+1jQ2pN97uwa0=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=TNUxgqDXlvO8AW3bU2Q4ic+BbUniyevBOFHH2L4vPcTZLpFfmPTby78Psp0f9kURS
         Kd3zBBQQJbB0Afvcl0XO00Hz/RxgCPQrEuPGWHkwvRjRXlzFJtvGdkeQEGLokiam+h
         GCLel0F6smQHPF0DJZmAGmPAOy/uwrB/KrRSwgAyF8fkrVQpKF7g+L6pmH4iFj3rWi
         2KSn+V0OslQ43TKykK195AQlLHzBEkOQqlzG28OJ52LL7m3ti4aXmp7R3dKX8ksUW0
         hP+LTIJlGPWs7Y50Av7hWj0OEVkkTgshyPz+E/YhwyR2uTexT+uKRnkUVsSx1eFCQU
         zSosf4ngrs84oMr7gxK2akuk8yGvM8/hwv1SXSqp/qU+c7UEw/WiXfeU2HSv0+PUaf
         i1+kDIVhiimXWuL3LKr9kuc8zbla2bam83D4uOSw+fquspAZeY5MYrXww4i2WBp0wn
         LLCA7zTnQep8a2d5OrVwLoW1rEktOkJYzsGnaXSFDpHMdlmtGdE
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 00/12] Hash-independent tests (part 3)
Date:   Thu, 13 Sep 2018 05:17:30 +0000
Message-Id: <20180913051742.252276-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the next in the series of improvements to make tests
hash-independent.

A range-diff is below.

Changes from v4:
* Add local statements to the &&-chain.
* Fix a typo in the local statement.
* Add a helpful comment about why test_detect_hash is hard-coded to
  SHA-1.

Changes from v3:
* Update t/README to specify new helpers.
* Escape "$" in double quotes.
* Add documentation comments to test helpers.
* Use local instead of underscores in variable names.
* Use expr instead of egrep to match hash algorithm names.
* Improve clarity of unset variable check in test_oid.
* Wrap test_oid_init in a test_expect_success.
* Improved && chain handling in test functions.
* Add test_detect_hash in test_oid_init.
* Clean up extra blank line.
* Add patch from Derrick Stolee for t5318, modified slightly.

Changes from v2:
* Fix a typo in "zero_2".
* Provide better matching of expected output.
* Add and use test_oid_init instead of filename-based test_oid_cache.
* Add test_set_hash.
* Provide better error checking in newly added test functions.
* Move t0000 constants into the test, removing the separate file.
* Switch to using a differently named temporary file in t0027.

Changes from v1:
* Adopt pure shell approach for helper.
* Add tests for the helpers.
* Explicitly refer to SHA-256 now that we know it will be NewHash.
* Updated t0000 to remove SHA1 prerequisite.
* Change name of helper from test_translate to test_oid.
* Add helper to cache information in the shell.
* Simplified lookup of HEAD in t0002.
* Switched to using existing helper function in t0027.
* Simplified handling of IDs in t0064.

Derrick Stolee (1):
  t5318: use test_oid for HASH_LEN

brian m. carlson (11):
  t: add test functions to translate hash-related values
  t0000: use hash translation table
  t0000: update tests for SHA-256
  t0002: abstract away SHA-1 specific constants
  t0027: make hash size independent
  t0064: make hash size independent
  t1006: make hash size independent
  t1400: switch hard-coded object ID to variable
  t1405: make hash size independent
  t1406: make hash-size independent
  t1407: make hash size independent

 t/README                       |  22 ++++
 t/oid-info/README              |  19 +++
 t/oid-info/hash-info           |   8 ++
 t/oid-info/oid                 |  29 +++++
 t/t0000-basic.sh               | 213 ++++++++++++++++++++++-----------
 t/t0002-gitfile.sh             |  27 +++--
 t/t0027-auto-crlf.sh           |   3 +-
 t/t0064-sha1-array.sh          |  49 ++++----
 t/t1006-cat-file.sh            |   6 +-
 t/t1400-update-ref.sh          |   2 +-
 t/t1405-main-ref-store.sh      |   4 +-
 t/t1406-submodule-ref-store.sh |   6 +-
 t/t1407-worktree-ref-store.sh  |   4 +-
 t/t5318-commit-graph.sh        |   5 +-
 t/test-lib-functions.sh        |  69 +++++++++++
 15 files changed, 352 insertions(+), 114 deletions(-)
 create mode 100644 t/oid-info/README
 create mode 100644 t/oid-info/hash-info
 create mode 100644 t/oid-info/oid

Range-diff against v4:
 1:  fd13b542e7 !  1:  831a0df666 t: add test functions to translate hash-related values
    @@ -222,6 +222,8 @@
     +
     +# Detect the hash algorithm in use.
     +test_detect_hash () {
    ++	# Currently we only support SHA-1, but in the future this function will
    ++	# actually detect the algorithm in use.
     +	test_hash_algo='sha1'
     +}
     +
    @@ -241,9 +243,9 @@
     +# rawsz sha1:20
     +# rawsz sha256:32
     +test_oid_cache () {
    -+	local tag reset k v
    ++	local tag rest k v &&
     +
    -+	test -n "$test_hash_algo" || test_detect_hash &&
    ++	{ test -n "$test_hash_algo" || test_detect_hash; } &&
     +	while read tag rest
     +	do
     +		case $tag in
    @@ -271,7 +273,7 @@
     +# Look up a per-hash value based on a key ($1).  The value must have been loaded
     +# by test_oid_init or test_oid_cache.
     +test_oid () {
    -+	local var="test_oid_${test_hash_algo}_$1"
    ++	local var="test_oid_${test_hash_algo}_$1" &&
     +
     +	# If the variable is unset, we must be missing an entry for this
     +	# key-hash pair, so exit with an error.
 2:  335c75e1ec =  2:  75eb36456b t0000: use hash translation table
 3:  257b458ad9 =  3:  d1cebc5dba t0000: update tests for SHA-256
 4:  69080d3bfc =  4:  a75f4a049e t0002: abstract away SHA-1 specific constants
 5:  a4297d7ae8 =  5:  ab8598048e t0027: make hash size independent
 6:  7cf1221274 =  6:  ed540a08e8 t0064: make hash size independent
 7:  7e5c857c25 =  7:  e221995a27 t1006: make hash size independent
 8:  9271787d4b =  8:  3a168746ff t1400: switch hard-coded object ID to variable
 9:  43bd41156a =  9:  3e55ccdd15 t1405: make hash size independent
10:  875bbd7fc5 = 10:  df7d4eb112 t1406: make hash-size independent
11:  a9c2d31089 = 11:  b1a04c1986 t1407: make hash size independent
12:  10452cc352 = 12:  63d21a1eca t5318: use test_oid for HASH_LEN
