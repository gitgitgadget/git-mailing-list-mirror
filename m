Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4994A1F404
	for <e@80x24.org>; Mon,  3 Sep 2018 23:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbeIDDry (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Sep 2018 23:47:54 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:43962 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726004AbeIDDry (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 3 Sep 2018 23:47:54 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:1024:89fd:c4a5:84be])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7127860737;
        Mon,  3 Sep 2018 23:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1536017125;
        bh=uJqRAL95dlc/+P2hk6ju1ROt/+Eugr6kOr+XaZO8C4s=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=qNpHhabFfCk/F3BphZpqPVf1HIEePPWuHxfodRGcQd7XCj29hcjdEta5QeHsxHMEn
         JtcOKdWANzja+bI9rItoaHGFZNqDIuIX183tcuIMluL1JMBgeyVbhKeqZV6EEU3tYt
         VFhkz82iyL+DhRjfvRMRu053xXYnJwSAjffkKwGOXmmKmDn0t/YxmMT0Ik7KRHkoUZ
         3kgKTUm+F8s1v1gYdM/CI3oWl0xrknRb7IJXEqeRx+Q3Fnbi1IraGTT86xbADixLmr
         QAIcRBg5odMwPp4fVtM0PItazsg8kozTnBlrMDZsbts07EhiNZlpHijSlFU4W4vZKa
         jqORlcHsvwmpSKH8+wRfsMW9EXO9njCgVYT+r388DYleqlh3v70lLz8t0I9dP8+n/s
         S3IN5Qy5Nr8R9nJZzROG5EsiuzzPwdDAWkHyAUYe8EhaKOx+qdOf0lfMwkVG3DhyPO
         BLPCsrTSfdL8UWM1vEsp1oeRBri3zGjooqxOGfR4zqHVAOqkpfC
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 00/12] Hash-independent tests (part 3)
Date:   Mon,  3 Sep 2018 23:25:03 +0000
Message-Id: <20180903232515.336397-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1
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
 t/test-lib-functions.sh        |  67 +++++++++++
 15 files changed, 350 insertions(+), 114 deletions(-)
 create mode 100644 t/oid-info/README
 create mode 100644 t/oid-info/hash-info
 create mode 100644 t/oid-info/oid

range-diff:

 1:  a897533a90 !  1:  fd13b542e7 t: add tool to translate hash-related values
    @@ -1,25 +1,115 @@
     Author: brian m. carlson <sandals@crustytoothpaste.net>
     
    -    t: add tool to translate hash-related values
    +    t: add test functions to translate hash-related values
     
    -    Add a test function helper, test_oid, that produces output that varies
    -    depending on the hash in use.  Add two additional helpers,
    -    test_oid_cache, which can be used to load data for test_oid from
    -    standard input, and test_oid_init, which can be used to load certain
    -    fixed values from lookup charts.  Check that these functions work in
    -    t0000, as the rest of the testsuite will soon come to depend on them.
    +    Add several test functions to make working with various hash-related
    +    values easier.
    +
    +    Add test_oid_init, which loads common hash-related constants and
    +    placeholder object IDs from the newly added files in t/oid-info.
    +    Provide values for these constants for both SHA-1 and SHA-256.
    +
    +    Add test_oid_cache, which accepts data on standard input in the form of
    +    hash-specific key-value pairs that can be looked up later, using the
    +    same format as the files in t/oid-info.  Document this format in a
    +    t/oid-info/README directory so that it's easier to use in the future.
    +
    +    Add test_oid, which is used to specify look up a per-hash value
    +    (produced on standard output) based on the key specified as its
    +    argument.  Usually the data to be looked up will be a hash-related
    +    constant (such as the size of the hash in binary or hexadecimal), a
    +    well-known or placeholder object ID (such as the all-zeros object ID or
    +    one consisting of "deadbeef" repeated), or something similar.  For these
    +    reasons, test_oid will usually be used within a command substitution.
    +    Consequently, redirect the error output to standard error, since
    +    otherwise it will not be displayed.
    +
    +    Add test_detect_hash, which currently only detects SHA-1, and
    +    test_set_hash, which can be used to set a different hash algorithm for
    +    test purposes.  In the future, test_detect_hash will learn to actually
    +    detect the hash depending on how the testsuite is to be run.
    +
    +    Use the local keyword within these functions to avoid overwriting other
    +    shell variables.  We have had a test balloon in place for a couple of
    +    releases to catch shells that don't have this keyword and have not
    +    received any reports of failure.  Note that the varying usages of local
    +    used here are supported by all common open-source shells supporting the
    +    local keyword.
    +
    +    Test these new functions as part of t0000, which also serves to
    +    demonstrate basic usage of them.  In addition, add documentation on how
    +    to format the lookup data and how to use the test functions.
     
         Implement two basic lookup charts, one for common invalid or synthesized
         object IDs, and one for various facts about the hash function in use.
    -    Provide versions for both SHA-1 and SHA-256.
    +    Provide versions of the data for both SHA-1 and SHA-256.
     
    -    Note that due to the implementation used, names used for lookup can
    +    Since we use shell variables for storage, names used for lookup can
         currently consist only of shell identifier characters.  If this is a
         problem in the future, we can hash the names before use.
     
    +    Improved-by: Eric Sunshine <sunshine@sunshineco.com>
         Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
     
    + diff --git a/t/README b/t/README
    + --- a/t/README
    + +++ b/t/README
    +@@
    +    the symbolic link in the file system and a part that does; then only
    +    the latter part need be protected by a SYMLINKS prerequisite (see below).
    + 
    ++ - test_oid_init
    ++
    ++   This function loads facts and useful object IDs related to the hash
    ++   algorithm(s) in use from the files in t/oid-info.
    ++
    ++ - test_oid_cache
    ++
    ++   This function reads per-hash algorithm information from standard
    ++   input (usually a heredoc) in the format described in
    ++   t/oid-info/README.  This is useful for test-specific values, such as
    ++   object IDs, which must vary based on the hash algorithm.
    ++
    ++   Certain fixed values, such as hash sizes and common placeholder
    ++   object IDs, can be loaded with test_oid_init (described above).
    ++
    ++ - test_oid <key>
    ++
    ++   This function looks up a value for the hash algorithm in use, based
    ++   on the key given.  The value must have been loaded using
    ++   test_oid_init or test_oid_cache.  Providing an unknown key is an
    ++   error.
    ++
    + Prerequisites
    + -------------
    + 
    +
    + diff --git a/t/oid-info/README b/t/oid-info/README
    + new file mode 100644
    + --- /dev/null
    + +++ b/t/oid-info/README
    +@@
    ++This directory contains various per-hash values that are used in the testsuite.
    ++
    ++Each file contains lines containing a key-value pair; blank lines and lines
    ++starting with `#` are ignored.  The key and value are separated by whitespace
    ++(specifically, those whitespace in the default `$IFS`).  The key consists only
    ++of shell identifier characters, and the value consists of a hash algorithm,
    ++colon, and value.  The hash algorithm also consists only of shell identifier
    ++characters; it should match the value in sha1-file.c.
    ++
    ++For example, the following lines map the key "rawsz" to "20" if SHA-1 is in use
    ++and to "32" if SHA-256 is in use:
    ++
    ++----
    ++rawsz sha1:20
    ++rawsz sha256:32
    ++----
    ++
    ++The keys and values used here are loaded by `test_oid_init` (see the README file
    ++in the "t" directory) and are used by calling `test_oid`.
    +
      diff --git a/t/oid-info/hash-info b/t/oid-info/hash-info
      new file mode 100644
      --- /dev/null
    @@ -76,11 +166,13 @@
      	EOF
      "
      
    -+test_oid_init
    ++test_expect_success 'test_oid setup' '
    ++	test_oid_init
    ++'
     +
     +test_expect_success 'test_oid provides sane info by default' '
     +	test_oid zero >actual &&
    -+	grep "^00*$" actual &&
    ++	grep "^00*\$" actual &&
     +	rawsz="$(test_oid rawsz)" &&
     +	hexsz="$(test_oid hexsz)" &&
     +	test "$hexsz" -eq $(wc -c <actual) &&
    @@ -91,7 +183,7 @@
     +	test_when_finished "test_detect_hash" &&
     +	test_set_hash sha1 &&
     +	test_oid zero >actual &&
    -+	grep "^00*$" actual &&
    ++	grep "^00*\$" actual &&
     +	rawsz="$(test_oid rawsz)" &&
     +	hexsz="$(test_oid hexsz)" &&
     +	test $(wc -c <actual) -eq 40 &&
    @@ -103,7 +195,7 @@
     +	test_when_finished "test_detect_hash" &&
     +	test_set_hash sha256 &&
     +	test_oid zero >actual &&
    -+	grep "^00*$" actual &&
    ++	grep "^00*\$" actual &&
     +	rawsz="$(test_oid rawsz)" &&
     +	hexsz="$(test_oid hexsz)" &&
     +	test $(wc -c <actual) -eq 64 &&
    @@ -123,24 +215,38 @@
      	'
      }
     +
    ++# Set the hash algorithm in use to $1.  Only useful when testing the testsuite.
     +test_set_hash () {
     +	test_hash_algo="$1"
     +}
     +
    ++# Detect the hash algorithm in use.
     +test_detect_hash () {
     +	test_hash_algo='sha1'
     +}
     +
    ++# Load common hash metadata and common placeholder object IDs for use with
    ++# test_oid.
     +test_oid_init () {
    ++	test -n "$test_hash_algo" || test_detect_hash &&
     +	test_oid_cache <"$TEST_DIRECTORY/oid-info/hash-info" &&
     +	test_oid_cache <"$TEST_DIRECTORY/oid-info/oid"
     +}
     +
    ++# Load key-value pairs from stdin suitable for use with test_oid.  Blank lines
    ++# and lines starting with "#" are ignored.  Keys must be shell identifier
    ++# characters.
    ++#
    ++# Examples:
    ++# rawsz sha1:20
    ++# rawsz sha256:32
     +test_oid_cache () {
    -+	test -n "$test_hash_algo" || test_detect_hash
    -+	while read _tag _rest
    ++	local tag reset k v
    ++
    ++	test -n "$test_hash_algo" || test_detect_hash &&
    ++	while read tag rest
     +	do
    -+		case $_tag in
    ++		case $tag in
     +		\#*)
     +			continue;;
     +		?*)
    @@ -149,20 +255,29 @@
     +		*)
     +			# blank line
     +			continue;;
    -+
     +		esac &&
     +
    -+		_k="${_rest%:*}" &&
    -+		_v="${_rest#*:}" &&
    -+		{ echo "$_k" | egrep '^[a-z0-9]+$' >/dev/null ||
    -+			error 'bug in the test script: bad hash algorithm'; } &&
    -+		eval "test_oid_${_k}_$_tag=\"\$_v\"" || return 1
    ++		k="${rest%:*}" &&
    ++		v="${rest#*:}" &&
    ++
    ++		if ! expr "$k" : '[a-z0-9][a-z0-9]*$' >/dev/null
    ++		then
    ++			error 'bug in the test script: bad hash algorithm'
    ++		fi &&
    ++		eval "test_oid_${k}_$tag=\"\$v\""
     +	done
     +}
     +
    ++# Look up a per-hash value based on a key ($1).  The value must have been loaded
    ++# by test_oid_init or test_oid_cache.
     +test_oid () {
    -+	eval "
    -+		test -n \"\${test_oid_${test_hash_algo}_$1+set}\" &&
    -+		printf '%s' \"\${test_oid_${test_hash_algo}_$1}\"
    -+	"
    ++	local var="test_oid_${test_hash_algo}_$1"
    ++
    ++	# If the variable is unset, we must be missing an entry for this
    ++	# key-hash pair, so exit with an error.
    ++	if eval "test -z \"\${$var+set}\""
    ++	then
    ++		error "bug in the test script: undefined key '$1'" >&2
    ++	fi &&
    ++	eval "printf '%s' \"\${$var}\""
     +}
 2:  d63dc976f4 =  2:  335c75e1ec t0000: use hash translation table
 3:  9e55529efd =  3:  257b458ad9 t0000: update tests for SHA-256
 4:  4d5b8d4025 =  4:  69080d3bfc t0002: abstract away SHA-1 specific constants
 5:  6037c4d10a <  -:  ---------- t0027: make hash size independent
 -:  ---------- >  5:  a4297d7ae8 t0027: make hash size independent
 6:  dfad561965 =  6:  7cf1221274 t0064: make hash size independent
 7:  8a860a7492 =  7:  7e5c857c25 t1006: make hash size independent
 8:  1baaf8374a =  8:  9271787d4b t1400: switch hard-coded object ID to variable
 9:  232c043ed7 =  9:  43bd41156a t1405: make hash size independent
10:  9d0207bc52 = 10:  875bbd7fc5 t1406: make hash-size independent
11:  d292c6311f = 11:  a9c2d31089 t1407: make hash size independent
 -:  ---------- > 12:  10452cc352 t5318: use test_oid for HASH_LEN
