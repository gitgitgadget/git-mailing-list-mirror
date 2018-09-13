Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E89111F404
	for <e@80x24.org>; Thu, 13 Sep 2018 05:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbeIMKZz (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 06:25:55 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54378 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726317AbeIMKZz (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 13 Sep 2018 06:25:55 -0400
Received: from genre.crustytoothpaste.net (108-60-118-130.static.wiline.com [108.60.118.130])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E226960743;
        Thu, 13 Sep 2018 05:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1536815881;
        bh=K0vd8xVWGMvbFRQvk4rtRa3fxMr68zCfarQZ/Gfvyos=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=QO9qwl/I04s/+o6noqPVy0Lsgq7s3KIxar+BzZDTFPEbXc4cQHvf/QYE1fRyyxwgi
         qW9nwzPn97Y092qMudLfnoW3YYV/Jw3vAOipXfguXxqoQHH7FByHkxDBHC2fIyYK2m
         Cq9KAqqwMcoCYxdmluI5DVDfzWWALMFbMsRxkdI5+h8TrpQ6ay1NeVqkLiOIcfr3J4
         KDQzlhsxtX8StcUPG6zJS+5kg1vaKeFXoJTVzk8fHtummFTMOLLuQN++Y09Jt21YVF
         fsefdGeVUZZdQlAui1Lsw62D2NS6evu0192OTEhjts/J6xiCQXEYdpUqHkG4jrdES6
         PaDKrbrJdTDZKg2EL4Jg7DtUrr9+eB5WmlMFLzDo1xwSkY/MwE5owv2dQB9qTQEGyR
         rdaHBgiyY6oL4Q5eHqdN6eapz3aII/C9KfCp57NSzgXNSaVftVHW/wofD/onYAKKfD
         gtTSCV39rz0qjv5V0U7AlbfeJr5rDwu4JA0a0K+hLFspBl/3rEd
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 01/12] t: add test functions to translate hash-related values
Date:   Thu, 13 Sep 2018 05:17:31 +0000
Message-Id: <20180913051742.252276-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a
In-Reply-To: <20180913051742.252276-1-sandals@crustytoothpaste.net>
References: <20180913051742.252276-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add several test functions to make working with various hash-related
values easier.

Add test_oid_init, which loads common hash-related constants and
placeholder object IDs from the newly added files in t/oid-info.
Provide values for these constants for both SHA-1 and SHA-256.

Add test_oid_cache, which accepts data on standard input in the form of
hash-specific key-value pairs that can be looked up later, using the
same format as the files in t/oid-info.  Document this format in a
t/oid-info/README directory so that it's easier to use in the future.

Add test_oid, which is used to specify look up a per-hash value
(produced on standard output) based on the key specified as its
argument.  Usually the data to be looked up will be a hash-related
constant (such as the size of the hash in binary or hexadecimal), a
well-known or placeholder object ID (such as the all-zeros object ID or
one consisting of "deadbeef" repeated), or something similar.  For these
reasons, test_oid will usually be used within a command substitution.
Consequently, redirect the error output to standard error, since
otherwise it will not be displayed.

Add test_detect_hash, which currently only detects SHA-1, and
test_set_hash, which can be used to set a different hash algorithm for
test purposes.  In the future, test_detect_hash will learn to actually
detect the hash depending on how the testsuite is to be run.

Use the local keyword within these functions to avoid overwriting other
shell variables.  We have had a test balloon in place for a couple of
releases to catch shells that don't have this keyword and have not
received any reports of failure.  Note that the varying usages of local
used here are supported by all common open-source shells supporting the
local keyword.

Test these new functions as part of t0000, which also serves to
demonstrate basic usage of them.  In addition, add documentation on how
to format the lookup data and how to use the test functions.

Implement two basic lookup charts, one for common invalid or synthesized
object IDs, and one for various facts about the hash function in use.
Provide versions of the data for both SHA-1 and SHA-256.

Since we use shell variables for storage, names used for lookup can
currently consist only of shell identifier characters.  If this is a
problem in the future, we can hash the names before use.

Improved-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/README                | 22 +++++++++++++
 t/oid-info/README       | 19 ++++++++++++
 t/oid-info/hash-info    |  8 +++++
 t/oid-info/oid          | 29 +++++++++++++++++
 t/t0000-basic.sh        | 37 ++++++++++++++++++++++
 t/test-lib-functions.sh | 69 +++++++++++++++++++++++++++++++++++++++++
 6 files changed, 184 insertions(+)
 create mode 100644 t/oid-info/README
 create mode 100644 t/oid-info/hash-info
 create mode 100644 t/oid-info/oid

diff --git a/t/README b/t/README
index 9028b47d92..eed574dd9b 100644
--- a/t/README
+++ b/t/README
@@ -806,6 +806,28 @@ library for your script to use.
    the symbolic link in the file system and a part that does; then only
    the latter part need be protected by a SYMLINKS prerequisite (see below).
 
+ - test_oid_init
+
+   This function loads facts and useful object IDs related to the hash
+   algorithm(s) in use from the files in t/oid-info.
+
+ - test_oid_cache
+
+   This function reads per-hash algorithm information from standard
+   input (usually a heredoc) in the format described in
+   t/oid-info/README.  This is useful for test-specific values, such as
+   object IDs, which must vary based on the hash algorithm.
+
+   Certain fixed values, such as hash sizes and common placeholder
+   object IDs, can be loaded with test_oid_init (described above).
+
+ - test_oid <key>
+
+   This function looks up a value for the hash algorithm in use, based
+   on the key given.  The value must have been loaded using
+   test_oid_init or test_oid_cache.  Providing an unknown key is an
+   error.
+
 Prerequisites
 -------------
 
diff --git a/t/oid-info/README b/t/oid-info/README
new file mode 100644
index 0000000000..27f843fc00
--- /dev/null
+++ b/t/oid-info/README
@@ -0,0 +1,19 @@
+This directory contains various per-hash values that are used in the testsuite.
+
+Each file contains lines containing a key-value pair; blank lines and lines
+starting with `#` are ignored.  The key and value are separated by whitespace
+(specifically, those whitespace in the default `$IFS`).  The key consists only
+of shell identifier characters, and the value consists of a hash algorithm,
+colon, and value.  The hash algorithm also consists only of shell identifier
+characters; it should match the value in sha1-file.c.
+
+For example, the following lines map the key "rawsz" to "20" if SHA-1 is in use
+and to "32" if SHA-256 is in use:
+
+----
+rawsz sha1:20
+rawsz sha256:32
+----
+
+The keys and values used here are loaded by `test_oid_init` (see the README file
+in the "t" directory) and are used by calling `test_oid`.
diff --git a/t/oid-info/hash-info b/t/oid-info/hash-info
new file mode 100644
index 0000000000..ccdbfdf974
--- /dev/null
+++ b/t/oid-info/hash-info
@@ -0,0 +1,8 @@
+rawsz sha1:20
+rawsz sha256:32
+
+hexsz sha1:40
+hexsz sha256:64
+
+zero sha1:0000000000000000000000000000000000000000
+zero sha256:0000000000000000000000000000000000000000000000000000000000000000
diff --git a/t/oid-info/oid b/t/oid-info/oid
new file mode 100644
index 0000000000..a754970523
--- /dev/null
+++ b/t/oid-info/oid
@@ -0,0 +1,29 @@
+# These are some common invalid and partial object IDs used in tests.
+001	sha1:0000000000000000000000000000000000000001
+001	sha256:0000000000000000000000000000000000000000000000000000000000000001
+002	sha1:0000000000000000000000000000000000000002
+002	sha256:0000000000000000000000000000000000000000000000000000000000000002
+003	sha1:0000000000000000000000000000000000000003
+003	sha256:0000000000000000000000000000000000000000000000000000000000000003
+004	sha1:0000000000000000000000000000000000000004
+004	sha256:0000000000000000000000000000000000000000000000000000000000000004
+005	sha1:0000000000000000000000000000000000000005
+005	sha256:0000000000000000000000000000000000000000000000000000000000000005
+006	sha1:0000000000000000000000000000000000000006
+006	sha256:0000000000000000000000000000000000000000000000000000000000000006
+007	sha1:0000000000000000000000000000000000000007
+007	sha256:0000000000000000000000000000000000000000000000000000000000000007
+# All zeros or Fs missing one or two hex segments.
+zero_1		sha1:000000000000000000000000000000000000000
+zero_1		sha256:000000000000000000000000000000000000000000000000000000000000000
+zero_2		sha1:00000000000000000000000000000000000000
+zero_2		sha256:00000000000000000000000000000000000000000000000000000000000000
+ff_1		sha1:fffffffffffffffffffffffffffffffffffffff
+ff_1		sha256:fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
+ff_2		sha1:ffffffffffffffffffffffffffffffffffffff
+ff_2		sha256:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
+# More various invalid OIDs.
+numeric		sha1:0123456789012345678901234567890123456789
+numeric		sha256:0123456789012345678901234567890123456789012345678901234567890123
+deadbeef	sha1:deadbeefdeadbeefdeadbeefdeadbeefdeadbeef
+deadbeef	sha256:deadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeef
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 850f651e4e..b94221b951 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -821,6 +821,43 @@ test_expect_success 'tests clean up even on failures' "
 	EOF
 "
 
+test_expect_success 'test_oid setup' '
+	test_oid_init
+'
+
+test_expect_success 'test_oid provides sane info by default' '
+	test_oid zero >actual &&
+	grep "^00*\$" actual &&
+	rawsz="$(test_oid rawsz)" &&
+	hexsz="$(test_oid hexsz)" &&
+	test "$hexsz" -eq $(wc -c <actual) &&
+	test $(( $rawsz * 2)) -eq "$hexsz"
+'
+
+test_expect_success 'test_oid can look up data for SHA-1' '
+	test_when_finished "test_detect_hash" &&
+	test_set_hash sha1 &&
+	test_oid zero >actual &&
+	grep "^00*\$" actual &&
+	rawsz="$(test_oid rawsz)" &&
+	hexsz="$(test_oid hexsz)" &&
+	test $(wc -c <actual) -eq 40 &&
+	test "$rawsz" -eq 20 &&
+	test "$hexsz" -eq 40
+'
+
+test_expect_success 'test_oid can look up data for SHA-256' '
+	test_when_finished "test_detect_hash" &&
+	test_set_hash sha256 &&
+	test_oid zero >actual &&
+	grep "^00*\$" actual &&
+	rawsz="$(test_oid rawsz)" &&
+	hexsz="$(test_oid hexsz)" &&
+	test $(wc -c <actual) -eq 64 &&
+	test "$rawsz" -eq 32 &&
+	test "$hexsz" -eq 64
+'
+
 ################################################################
 # Basics of the basics
 
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 4207af4077..7293041b1e 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1155,3 +1155,72 @@ depacketize () {
 		}
 	'
 }
+
+# Set the hash algorithm in use to $1.  Only useful when testing the testsuite.
+test_set_hash () {
+	test_hash_algo="$1"
+}
+
+# Detect the hash algorithm in use.
+test_detect_hash () {
+	# Currently we only support SHA-1, but in the future this function will
+	# actually detect the algorithm in use.
+	test_hash_algo='sha1'
+}
+
+# Load common hash metadata and common placeholder object IDs for use with
+# test_oid.
+test_oid_init () {
+	test -n "$test_hash_algo" || test_detect_hash &&
+	test_oid_cache <"$TEST_DIRECTORY/oid-info/hash-info" &&
+	test_oid_cache <"$TEST_DIRECTORY/oid-info/oid"
+}
+
+# Load key-value pairs from stdin suitable for use with test_oid.  Blank lines
+# and lines starting with "#" are ignored.  Keys must be shell identifier
+# characters.
+#
+# Examples:
+# rawsz sha1:20
+# rawsz sha256:32
+test_oid_cache () {
+	local tag rest k v &&
+
+	{ test -n "$test_hash_algo" || test_detect_hash; } &&
+	while read tag rest
+	do
+		case $tag in
+		\#*)
+			continue;;
+		?*)
+			# non-empty
+			;;
+		*)
+			# blank line
+			continue;;
+		esac &&
+
+		k="${rest%:*}" &&
+		v="${rest#*:}" &&
+
+		if ! expr "$k" : '[a-z0-9][a-z0-9]*$' >/dev/null
+		then
+			error 'bug in the test script: bad hash algorithm'
+		fi &&
+		eval "test_oid_${k}_$tag=\"\$v\""
+	done
+}
+
+# Look up a per-hash value based on a key ($1).  The value must have been loaded
+# by test_oid_init or test_oid_cache.
+test_oid () {
+	local var="test_oid_${test_hash_algo}_$1" &&
+
+	# If the variable is unset, we must be missing an entry for this
+	# key-hash pair, so exit with an error.
+	if eval "test -z \"\${$var+set}\""
+	then
+		error "bug in the test script: undefined key '$1'" >&2
+	fi &&
+	eval "printf '%s' \"\${$var}\""
+}
