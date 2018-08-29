Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AB0B1F404
	for <e@80x24.org>; Wed, 29 Aug 2018 00:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbeH2EvT (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 00:51:19 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37194 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727166AbeH2EvS (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Aug 2018 00:51:18 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:1024:89fd:c4a5:84be])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DEB126074C;
        Wed, 29 Aug 2018 00:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1535504222;
        bh=bGUYLK4cx+LnQojvmYW/KZklRswp5FBNT813zlLjigc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=c7mKgW57p636O/h9ySM6kd5PBCT9VB7oAnrpf8bn23/wdynxo/GTbE5IlmZ3bmjNf
         dbX4SsExKRsz1UxnZSsn7UqXYAYdKTfI/5NWneZYiMgRUU8v9pgwtrcF4TumTpewLI
         Gxa534arqBSIwgzjtMxEA97d6X1/yIR3/Dhp2m8ljU8S00WaIM+/WxU+n09VfAK6R3
         twJupY4ttf3tmYKWfLD1uKfTz3a01O5iX0wc21zK74EPApiEiPpDrdkn0ZeM2rmWaS
         dG7cp1E3TmaXuLT6mhA5sXx6FqNZ8VW1VbgcQHnYb0vD6t92kDzeg1/HiLYbC7E9lI
         QCm+iHxt3ortc6YTnrr6cPJozAk1rHJmpxqUYXMwA0gacyIhPoECa/wqnVTo2/+tZ6
         3Sjn1/D6fKSEnq0rtFYc+ToZkgbt7OFdUP1wv0SD3/kyaM4dQY6h7mdi3aE0el18mg
         WgVTA5xm/grCDLz4oDyoibUfPrRQQIE4V8refx/qsXV63wZm4XC
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v3 01/11] t: add tool to translate hash-related values
Date:   Wed, 29 Aug 2018 00:56:32 +0000
Message-Id: <20180829005642.980617-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0
In-Reply-To: <20180829005642.980617-1-sandals@crustytoothpaste.net>
References: <20180829005642.980617-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a test function helper, test_oid, that produces output that varies
depending on the hash in use.  Add two additional helpers,
test_oid_cache, which can be used to load data for test_oid from
standard input, and test_oid_init, which can be used to load certain
fixed values from lookup charts.  Check that these functions work in
t0000, as the rest of the testsuite will soon come to depend on them.

Implement two basic lookup charts, one for common invalid or synthesized
object IDs, and one for various facts about the hash function in use.
Provide versions for both SHA-1 and SHA-256.

Note that due to the implementation used, names used for lookup can
currently consist only of shell identifier characters.  If this is a
problem in the future, we can hash the names before use.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/oid-info/hash-info    |  8 ++++++++
 t/oid-info/oid          | 29 +++++++++++++++++++++++++++
 t/t0000-basic.sh        | 35 ++++++++++++++++++++++++++++++++
 t/test-lib-functions.sh | 44 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 116 insertions(+)
 create mode 100644 t/oid-info/hash-info
 create mode 100644 t/oid-info/oid

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
index 850f651e4e..e3cace299e 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -821,6 +821,41 @@ test_expect_success 'tests clean up even on failures' "
 	EOF
 "
 
+test_oid_init
+
+test_expect_success 'test_oid provides sane info by default' '
+	test_oid zero >actual &&
+	grep "^00*$" actual &&
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
+	grep "^00*$" actual &&
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
+	grep "^00*$" actual &&
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
index 4207af4077..2300ec49dd 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1155,3 +1155,47 @@ depacketize () {
 		}
 	'
 }
+
+test_set_hash () {
+	test_hash_algo="$1"
+}
+
+test_detect_hash () {
+	test_hash_algo='sha1'
+}
+
+test_oid_init () {
+	test_oid_cache <"$TEST_DIRECTORY/oid-info/hash-info" &&
+	test_oid_cache <"$TEST_DIRECTORY/oid-info/oid"
+}
+
+test_oid_cache () {
+	test -n "$test_hash_algo" || test_detect_hash
+	while read _tag _rest
+	do
+		case $_tag in
+		\#*)
+			continue;;
+		?*)
+			# non-empty
+			;;
+		*)
+			# blank line
+			continue;;
+
+		esac &&
+
+		_k="${_rest%:*}" &&
+		_v="${_rest#*:}" &&
+		{ echo "$_k" | egrep '^[a-z0-9]+$' >/dev/null ||
+			error 'bug in the test script: bad hash algorithm'; } &&
+		eval "test_oid_${_k}_$_tag=\"\$_v\"" || return 1
+	done
+}
+
+test_oid () {
+	eval "
+		test -n \"\${test_oid_${test_hash_algo}_$1+set}\" &&
+		printf '%s' \"\${test_oid_${test_hash_algo}_$1}\"
+	"
+}
