Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC8671F404
	for <e@80x24.org>; Mon,  3 Sep 2018 23:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbeIDDr6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Sep 2018 23:47:58 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:43994 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726008AbeIDDr6 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 3 Sep 2018 23:47:58 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:1024:89fd:c4a5:84be])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6C64860758;
        Mon,  3 Sep 2018 23:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1536017133;
        bh=HBDfUlDiWUkXCzOoMFPRUbu1RhDOyOPJAJTwcJSm4bo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=U3Z6eUs4I9LINeJlbJgdHuxU/PRKATgxWMUAivmqkfaqjxH0ipOaD2YMAhgpQYFzi
         dHUjMLjuo/zt+SDMt+5vrPKkRkJv0NoGcEuBpUIhN5uLVsM/x/H8wIp8yi2mp0l6RD
         ypWX2PMVY8q93c+FEvDOmsVE82dMmSJAEl0VVju3rqEgQf31/FREOCpr7lGAFFx9EO
         eKlq1vWYzma0nSd463QZNtkAw4YerQ+TF6/++V1j4AQ5jfo1LA+cGxbBvZtRdKfLhx
         WkZsmG9GNYdW49pmCS06spyIiZyMbfdDUiW12MsiCtLgxdKaX68AaZeYU5r2oHxIpr
         NsT27H4ER0pzfONQHDX1d3t9+KnIOOLa+QmzUx0R6VaRHeipV4/ouaVXWVT3gJgVUX
         eKI5GPkOel2guwoju71NeTLDlQTxW+nQ4svdSi9HStotRkFxvt1y92KVW7SxwjX0Gx
         AY7BTBquRSNGBz49SEHlof49kwAwddh7iUl+p+QXO4YjA9sZiVP
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 03/12] t0000: update tests for SHA-256
Date:   Mon,  3 Sep 2018 23:25:06 +0000
Message-Id: <20180903232515.336397-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1
In-Reply-To: <20180903232515.336397-1-sandals@crustytoothpaste.net>
References: <20180903232515.336397-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test t0000 tests the "basics of the basics" and as such, checks that we
have various fixed hard-coded object IDs.  The tests relying on these
assertions have been marked with the SHA1 prerequisite, as they will
obviously not function in their current form with SHA-256.

Use the test_oid helper to update these assertions and provide values
for both SHA-1 and SHA-256.

These object IDs were synthesized using a set of scripts that created
the objects for both SHA-1 and SHA-256 using the same method to ensure
that they are indeed the correct values.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t0000-basic.sh | 163 +++++++++++++++++++++++++++++------------------
 1 file changed, 102 insertions(+), 61 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index a9dc534048..391f910c6a 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -861,6 +861,47 @@ test_expect_success 'test_oid can look up data for SHA-256' '
 ################################################################
 # Basics of the basics
 
+test_oid_cache <<\EOF
+path0f sha1:f87290f8eb2cbbea7857214459a0739927eab154
+path0f sha256:638106af7c38be056f3212cbd7ac65bc1bac74f420ca5a436ff006a9d025d17d
+
+path0s sha1:15a98433ae33114b085f3eb3bb03b832b3180a01
+path0s sha256:3a24cc53cf68edddac490bbf94a418a52932130541361f685df685e41dd6c363
+
+path2f sha1:3feff949ed00a62d9f7af97c15cd8a30595e7ac7
+path2f sha256:2a7f36571c6fdbaf0e3f62751a0b25a3f4c54d2d1137b3f4af9cb794bb498e5f
+
+path2s sha1:d8ce161addc5173867a3c3c730924388daedbc38
+path2s sha256:18fd611b787c2e938ddcc248fabe4d66a150f9364763e9ec133dd01d5bb7c65a
+
+path2d sha1:58a09c23e2ca152193f2786e06986b7b6712bdbe
+path2d sha256:00e4b32b96e7e3d65d79112dcbea53238a22715f896933a62b811377e2650c17
+
+path3f sha1:0aa34cae68d0878578ad119c86ca2b5ed5b28376
+path3f sha256:09f58616b951bd571b8cb9dc76d372fbb09ab99db2393f5ab3189d26c45099ad
+
+path3s sha1:8599103969b43aff7e430efea79ca4636466794f
+path3s sha256:fce1aed087c053306f3f74c32c1a838c662bbc4551a7ac2420f5d6eb061374d0
+
+path3d sha1:21ae8269cacbe57ae09138dcc3a2887f904d02b3
+path3d sha256:9b60497be959cb830bf3f0dc82bcc9ad9e925a24e480837ade46b2295e47efe1
+
+subp3f sha1:00fb5908cb97c2564a9783c0c64087333b3b464f
+subp3f sha256:a1a9e16998c988453f18313d10375ee1d0ddefe757e710dcae0d66aa1e0c58b3
+
+subp3s sha1:6649a1ebe9e9f1c553b66f5a6e74136a07ccc57c
+subp3s sha256:81759d9f5e93c6546ecfcadb560c1ff057314b09f93fe8ec06e2d8610d34ef10
+
+subp3d sha1:3c5e5399f3a333eddecce7a9b9465b63f65f51e2
+subp3d sha256:76b4ef482d4fa1c754390344cf3851c7f883b27cf9bc999c6547928c46aeafb7
+
+root sha1:087704a96baf1c2d1c869a8b084481e121c88b5b
+root sha256:9481b52abab1b2ffeedbf9de63ce422b929f179c1b98ff7bee5f8f1bc0710751
+
+simpletree sha1:7bb943559a305bdd6bdee2cef6e5df2413c3d30a
+simpletree sha256:1710c07a6c86f9a3c7376364df04c47ee39e5a5e221fcdd84b743bc9bb7e2bc5
+EOF
+
 # updating a new file without --add should fail.
 test_expect_success 'git update-index without --add should fail adding' '
 	test_must_fail git update-index should-be-empty
@@ -876,8 +917,8 @@ test_expect_success 'writing tree out with git write-tree' '
 '
 
 # we know the shape and contents of the tree and know the object ID for it.
-test_expect_success SHA1 'validate object ID of a known tree' '
-	test "$tree" = 7bb943559a305bdd6bdee2cef6e5df2413c3d30a
+test_expect_success 'validate object ID of a known tree' '
+	test "$tree" = "$(test_oid simpletree)"
     '
 
 # Removing paths.
@@ -919,16 +960,16 @@ test_expect_success 'showing stage with git ls-files --stage' '
 	git ls-files --stage >current
 '
 
-test_expect_success SHA1 'validate git ls-files output for a known tree' '
-	cat >expected <<-\EOF &&
-	100644 f87290f8eb2cbbea7857214459a0739927eab154 0	path0
-	120000 15a98433ae33114b085f3eb3bb03b832b3180a01 0	path0sym
-	100644 3feff949ed00a62d9f7af97c15cd8a30595e7ac7 0	path2/file2
-	120000 d8ce161addc5173867a3c3c730924388daedbc38 0	path2/file2sym
-	100644 0aa34cae68d0878578ad119c86ca2b5ed5b28376 0	path3/file3
-	120000 8599103969b43aff7e430efea79ca4636466794f 0	path3/file3sym
-	100644 00fb5908cb97c2564a9783c0c64087333b3b464f 0	path3/subp3/file3
-	120000 6649a1ebe9e9f1c553b66f5a6e74136a07ccc57c 0	path3/subp3/file3sym
+test_expect_success 'validate git ls-files output for a known tree' '
+	cat >expected <<-EOF &&
+	100644 $(test_oid path0f) 0	path0
+	120000 $(test_oid path0s) 0	path0sym
+	100644 $(test_oid path2f) 0	path2/file2
+	120000 $(test_oid path2s) 0	path2/file2sym
+	100644 $(test_oid path3f) 0	path3/file3
+	120000 $(test_oid path3s) 0	path3/file3sym
+	100644 $(test_oid subp3f) 0	path3/subp3/file3
+	120000 $(test_oid subp3s) 0	path3/subp3/file3sym
 	EOF
 	test_cmp expected current
 '
@@ -937,20 +978,20 @@ test_expect_success 'writing tree out with git write-tree' '
 	tree=$(git write-tree)
 '
 
-test_expect_success SHA1 'validate object ID for a known tree' '
-	test "$tree" = 087704a96baf1c2d1c869a8b084481e121c88b5b
+test_expect_success 'validate object ID for a known tree' '
+	test "$tree" = "$(test_oid root)"
 '
 
 test_expect_success 'showing tree with git ls-tree' '
     git ls-tree $tree >current
 '
 
-test_expect_success SHA1 'git ls-tree output for a known tree' '
-	cat >expected <<-\EOF &&
-	100644 blob f87290f8eb2cbbea7857214459a0739927eab154	path0
-	120000 blob 15a98433ae33114b085f3eb3bb03b832b3180a01	path0sym
-	040000 tree 58a09c23e2ca152193f2786e06986b7b6712bdbe	path2
-	040000 tree 21ae8269cacbe57ae09138dcc3a2887f904d02b3	path3
+test_expect_success 'git ls-tree output for a known tree' '
+	cat >expected <<-EOF &&
+	100644 blob $(test_oid path0f)	path0
+	120000 blob $(test_oid path0s)	path0sym
+	040000 tree $(test_oid path2d)	path2
+	040000 tree $(test_oid path3d)	path3
 	EOF
 	test_cmp expected current
 '
@@ -961,16 +1002,16 @@ test_expect_success 'showing tree with git ls-tree -r' '
 	git ls-tree -r $tree >current
 '
 
-test_expect_success SHA1 'git ls-tree -r output for a known tree' '
-	cat >expected <<-\EOF &&
-	100644 blob f87290f8eb2cbbea7857214459a0739927eab154	path0
-	120000 blob 15a98433ae33114b085f3eb3bb03b832b3180a01	path0sym
-	100644 blob 3feff949ed00a62d9f7af97c15cd8a30595e7ac7	path2/file2
-	120000 blob d8ce161addc5173867a3c3c730924388daedbc38	path2/file2sym
-	100644 blob 0aa34cae68d0878578ad119c86ca2b5ed5b28376	path3/file3
-	120000 blob 8599103969b43aff7e430efea79ca4636466794f	path3/file3sym
-	100644 blob 00fb5908cb97c2564a9783c0c64087333b3b464f	path3/subp3/file3
-	120000 blob 6649a1ebe9e9f1c553b66f5a6e74136a07ccc57c	path3/subp3/file3sym
+test_expect_success 'git ls-tree -r output for a known tree' '
+	cat >expected <<-EOF &&
+	100644 blob $(test_oid path0f)	path0
+	120000 blob $(test_oid path0s)	path0sym
+	100644 blob $(test_oid path2f)	path2/file2
+	120000 blob $(test_oid path2s)	path2/file2sym
+	100644 blob $(test_oid path3f)	path3/file3
+	120000 blob $(test_oid path3s)	path3/file3sym
+	100644 blob $(test_oid subp3f)	path3/subp3/file3
+	120000 blob $(test_oid subp3s)	path3/subp3/file3sym
 	EOF
 	test_cmp expected current
 '
@@ -980,19 +1021,19 @@ test_expect_success 'showing tree with git ls-tree -r -t' '
 	git ls-tree -r -t $tree >current
 '
 
-test_expect_success SHA1 'git ls-tree -r output for a known tree' '
-	cat >expected <<-\EOF &&
-	100644 blob f87290f8eb2cbbea7857214459a0739927eab154	path0
-	120000 blob 15a98433ae33114b085f3eb3bb03b832b3180a01	path0sym
-	040000 tree 58a09c23e2ca152193f2786e06986b7b6712bdbe	path2
-	100644 blob 3feff949ed00a62d9f7af97c15cd8a30595e7ac7	path2/file2
-	120000 blob d8ce161addc5173867a3c3c730924388daedbc38	path2/file2sym
-	040000 tree 21ae8269cacbe57ae09138dcc3a2887f904d02b3	path3
-	100644 blob 0aa34cae68d0878578ad119c86ca2b5ed5b28376	path3/file3
-	120000 blob 8599103969b43aff7e430efea79ca4636466794f	path3/file3sym
-	040000 tree 3c5e5399f3a333eddecce7a9b9465b63f65f51e2	path3/subp3
-	100644 blob 00fb5908cb97c2564a9783c0c64087333b3b464f	path3/subp3/file3
-	120000 blob 6649a1ebe9e9f1c553b66f5a6e74136a07ccc57c	path3/subp3/file3sym
+test_expect_success 'git ls-tree -r output for a known tree' '
+	cat >expected <<-EOF &&
+	100644 blob $(test_oid path0f)	path0
+	120000 blob $(test_oid path0s)	path0sym
+	040000 tree $(test_oid path2d)	path2
+	100644 blob $(test_oid path2f)	path2/file2
+	120000 blob $(test_oid path2s)	path2/file2sym
+	040000 tree $(test_oid path3d)	path3
+	100644 blob $(test_oid path3f)	path3/file3
+	120000 blob $(test_oid path3s)	path3/file3sym
+	040000 tree $(test_oid subp3d)	path3/subp3
+	100644 blob $(test_oid subp3f)	path3/subp3/file3
+	120000 blob $(test_oid subp3s)	path3/subp3/file3sym
 	EOF
 	test_cmp expected current
 '
@@ -1001,16 +1042,16 @@ test_expect_success 'writing partial tree out with git write-tree --prefix' '
 	ptree=$(git write-tree --prefix=path3)
 '
 
-test_expect_success SHA1 'validate object ID for a known tree' '
-	test "$ptree" = 21ae8269cacbe57ae09138dcc3a2887f904d02b3
+test_expect_success 'validate object ID for a known tree' '
+	test "$ptree" = $(test_oid path3d)
 '
 
 test_expect_success 'writing partial tree out with git write-tree --prefix' '
 	ptree=$(git write-tree --prefix=path3/subp3)
 '
 
-test_expect_success SHA1 'validate object ID for a known tree' '
-	test "$ptree" = 3c5e5399f3a333eddecce7a9b9465b63f65f51e2
+test_expect_success 'validate object ID for a known tree' '
+	test "$ptree" = $(test_oid subp3d)
 '
 
 test_expect_success 'put invalid objects into the index' '
@@ -1044,16 +1085,16 @@ test_expect_success 'git read-tree followed by write-tree should be idempotent'
 	test "$newtree" = "$tree"
 '
 
-test_expect_success SHA1 'validate git diff-files output for a know cache/work tree state' '
-	cat >expected <<\EOF &&
-:100644 100644 f87290f8eb2cbbea7857214459a0739927eab154 0000000000000000000000000000000000000000 M	path0
-:120000 120000 15a98433ae33114b085f3eb3bb03b832b3180a01 0000000000000000000000000000000000000000 M	path0sym
-:100644 100644 3feff949ed00a62d9f7af97c15cd8a30595e7ac7 0000000000000000000000000000000000000000 M	path2/file2
-:120000 120000 d8ce161addc5173867a3c3c730924388daedbc38 0000000000000000000000000000000000000000 M	path2/file2sym
-:100644 100644 0aa34cae68d0878578ad119c86ca2b5ed5b28376 0000000000000000000000000000000000000000 M	path3/file3
-:120000 120000 8599103969b43aff7e430efea79ca4636466794f 0000000000000000000000000000000000000000 M	path3/file3sym
-:100644 100644 00fb5908cb97c2564a9783c0c64087333b3b464f 0000000000000000000000000000000000000000 M	path3/subp3/file3
-:120000 120000 6649a1ebe9e9f1c553b66f5a6e74136a07ccc57c 0000000000000000000000000000000000000000 M	path3/subp3/file3sym
+test_expect_success 'validate git diff-files output for a know cache/work tree state' '
+	cat >expected <<EOF &&
+:100644 100644 $(test_oid path0f) $ZERO_OID M	path0
+:120000 120000 $(test_oid path0s) $ZERO_OID M	path0sym
+:100644 100644 $(test_oid path2f) $ZERO_OID M	path2/file2
+:120000 120000 $(test_oid path2s) $ZERO_OID M	path2/file2sym
+:100644 100644 $(test_oid path3f) $ZERO_OID M	path3/file3
+:120000 120000 $(test_oid path3s) $ZERO_OID M	path3/file3sym
+:100644 100644 $(test_oid subp3f) $ZERO_OID M	path3/subp3/file3
+:120000 120000 $(test_oid subp3s) $ZERO_OID M	path3/subp3/file3sym
 EOF
 	git diff-files >current &&
 	test_cmp current expected
@@ -1069,23 +1110,23 @@ test_expect_success 'no diff after checkout and git update-index --refresh' '
 '
 
 ################################################################
-P=087704a96baf1c2d1c869a8b084481e121c88b5b
+P=$(test_oid root)
 
-test_expect_success SHA1 'git commit-tree records the correct tree in a commit' '
+test_expect_success 'git commit-tree records the correct tree in a commit' '
 	commit0=$(echo NO | git commit-tree $P) &&
 	tree=$(git show --pretty=raw $commit0 |
 		 sed -n -e "s/^tree //p" -e "/^author /q") &&
 	test "z$tree" = "z$P"
 '
 
-test_expect_success SHA1 'git commit-tree records the correct parent in a commit' '
+test_expect_success 'git commit-tree records the correct parent in a commit' '
 	commit1=$(echo NO | git commit-tree $P -p $commit0) &&
 	parent=$(git show --pretty=raw $commit1 |
 		sed -n -e "s/^parent //p" -e "/^author /q") &&
 	test "z$commit0" = "z$parent"
 '
 
-test_expect_success SHA1 'git commit-tree omits duplicated parent in a commit' '
+test_expect_success 'git commit-tree omits duplicated parent in a commit' '
 	commit2=$(echo NO | git commit-tree $P -p $commit0 -p $commit0) &&
 	     parent=$(git show --pretty=raw $commit2 |
 		sed -n -e "s/^parent //p" -e "/^author /q" |
