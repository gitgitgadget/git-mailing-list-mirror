Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D62F1F954
	for <e@80x24.org>; Sun, 19 Aug 2018 17:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbeHSVGa (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Aug 2018 17:06:30 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55008 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726508AbeHSVG3 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 19 Aug 2018 17:06:29 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:1024:89fd:c4a5:84be])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3FFB960748;
        Sun, 19 Aug 2018 17:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1534701250;
        bh=lJgyXPuxOwiFsRIP2T7X7kyNzL3VH27M6SZ7z+RHruo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=UHrO+O486r5H/ktk9qmqOksAwfiFkQUKB8gap0IS1SYGnGb6nM4Oqer94SCsOd0Y5
         U0ScUhgnIIhgUnRIE5yx4urMIFt1uvJCeasLpL080r9P0UWRGQ7FQtwSA0ZuZ/E5Te
         n7uTDuITO/lPd1O17azFdVpVY+WDrpJJv3wzzKzPMgOAFHzk29Y8/pszOzwNU2Uh6G
         nQLnh5N+MTutlnY3E4Qc7eF1ojabku7o2pyBIpBjA24mlQYtSv5rPjs1sxYC2ntCPW
         N02g/Ht3Euvg62HZEtbezrnrCxcY7xQqAOt8Fsj/h5D6gBQDWQ4ob9eLK2/UQ/skQx
         WO1w8sWLoqmI/2Rh+IbcEoJTnyF1zIML2N16z46fwWOS0dDm4RBwk23ddIHXXGySHS
         JQcP98DXDuRfpiakMPtKGsVl3kAyqdzTeRPBkSrxsnqpDkc3RUsyCcOY/RBG5Cae5w
         aa9gLqCjrIMKxrEWQSVx1y2/JJaa2Mbs1N4r+r+/CxVEw35fDaS
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v2 01/11] t: add tool to translate hash-related values
Date:   Sun, 19 Aug 2018 17:53:41 +0000
Message-Id: <20180819175351.449973-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.18.0.1017.ga543ac7ca45
In-Reply-To: <20180819175351.449973-1-sandals@crustytoothpaste.net>
References: <20180819175351.449973-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a test function helper, test_oid, that produces output that varies
depending on the hash in use.  Add an additional helper, test_oid_cache,
that can be used to load data for test_oid, either through a list of
filenames or on standard input.  Check that these functions work in
t0000, as the rest of the testsuite will soon come to depend on them.

Implement two basic lookup charts, one for common invalid or synthesized
object IDs, and one for various facts about the hash function in use.
Individual tests can use their own translation files to map object IDs
or other data that needs to vary across hash functions.  Provide
versions for both SHA-1 and SHA-256.

Note that due to the implementation used, keys cannot be anything but
shell identifier characters.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/oid-info/hash-info    |  8 ++++++++
 t/oid-info/oid          | 29 +++++++++++++++++++++++++++++
 t/t0000-basic.sh        | 29 +++++++++++++++++++++++++++++
 t/test-lib-functions.sh | 36 ++++++++++++++++++++++++++++++++++++
 4 files changed, 102 insertions(+)
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
index 0000000000..6f1c49dbc1
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
+zero_2		sha256:000000000000000000000000000000000000000000000000000000000000000
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
index 34859fe4a5..ace779bf7d 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -821,6 +821,35 @@ test_expect_success 'tests clean up even on failures' "
 	EOF
 "
 
+test_oid_cache hash-info oid
+
+test_expect_success 'test_oid_info provides sane info by default' '
+	test_oid zero &&
+	test_oid zero >actual &&
+	grep "00*" actual &&
+	test "$(test_oid hexsz)" -eq $(wc -c <actual) &&
+	test $(( $(test_oid rawsz) * 2)) -eq "$(test_oid hexsz)"
+'
+
+test_expect_success 'test_oid_info can look up data for SHA-1' '
+	test_detect_hash sha1 &&
+	test_oid zero >actual &&
+	grep "00*" actual &&
+	test $(wc -c <actual) -eq 40 &&
+	test "$(test_oid rawsz)" -eq 20 &&
+	test "$(test_oid hexsz)" -eq 40
+'
+
+test_expect_success 'test_oid_info can look up data for SHA-256' '
+	test_when_finished "test_detect_hash" &&
+	test_detect_hash sha256 &&
+	test_oid zero >actual &&
+	grep "00*" actual &&
+	test $(wc -c <actual) -eq 64 &&
+	test "$(test_oid rawsz)" -eq 32 &&
+	test "$(test_oid hexsz)" -eq 64
+'
+
 ################################################################
 # Basics of the basics
 
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 2b2181dca0..ac18789a70 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1147,3 +1147,39 @@ depacketize () {
 		}
 	'
 }
+
+test_detect_hash () {
+	if test -n "$1"
+	then
+		test_hash_algo="$1"
+	else
+		test_hash_algo='sha1'
+	fi
+}
+
+test_oid_cache () {
+	test -n "$test_hash_algo" || test_detect_hash
+	if test -n "$1"
+	then
+		while test -n "$1"
+		do
+			test_oid_cache <"$TEST_DIRECTORY/oid-info/$1"
+			shift
+		done
+		return $?
+	fi
+	while read _tag _rest
+	do
+		case $_tag in \#*)
+			continue;;
+		esac
+
+		_k="${_rest%:*}"
+		_v="${_rest#*:}"
+		eval "test_oid_${_k}_$_tag=\"$_v\""
+	done
+}
+
+test_oid () {
+	eval "printf '%s' \"\${test_oid_${test_hash_algo}_$1}\""
+}
