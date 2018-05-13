Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10E4C1F406
	for <e@80x24.org>; Sun, 13 May 2018 02:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752045AbeEMCZs (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 22:25:48 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:45310 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752031AbeEMCZr (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 12 May 2018 22:25:47 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:64f1:3b3f:8f13:59ed])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8E00860742;
        Sun, 13 May 2018 02:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1526178346;
        bh=2EqZeLsV5DlZf+tHplzQNzUojW0Sl8W2gW5NIUZQYaw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=O4IaBIHnAgnJTajgDpQ+yCmjMCjETK4gih25fhnu13clQLO94jQiMKZKI/513VQ6Z
         tvAViISnq+VgFsJWPTvgAPkF7jE7Ncl1xn9+oNdPtx1b+WHOYiZ3I436HVw6f9IS5W
         s0JUAuJP4C6UTBziRRizxQbcxNoeKlRgpLQHeaZzPU3WNJrbTA45pT6pQmGH7uuFR+
         Sd3UzPPuz10Zq5PCICccshxplFB82Xl+GroIZRIawlhOTu3S2aBj1vSnYZ2qDE/QEh
         9sZeXT/VV5Bcv8rIH9kxDcrI9p/TuJR8lOyrMDxOCpDGV+uE3E8YMmYeRFB0oaKRHW
         H4c/SkT3zOFULd7CgPye52YeTq9p7caygVWCs68u+VTd02qp2RcStZHpwT9KED9Hye
         tWhHXIybE0jZXGh3HDnyXo81Dq+ygFfUkA3Ljf7O3Rt4Mz/AFwjSMWLUAuWILHGvkV
         vVM/gW0HU/JzaObPhwfDAOpleXE/HXBIwjWI6i95u1TOHILFhSv
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 15/28] t4007: abstract away SHA-1-specific constants
Date:   Sun, 13 May 2018 02:24:25 +0000
Message-Id: <20180513022438.60003-16-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180513022438.60003-1-sandals@crustytoothpaste.net>
References: <20180513022438.60003-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust the test so that it computes variables for blobs and uses the
ZERO_OID variable instead of using hard-coded hashes.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t4007-rename-3.sh | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/t/t4007-rename-3.sh b/t/t4007-rename-3.sh
index dae327fabb..b187b7f6c6 100755
--- a/t/t4007-rename-3.sh
+++ b/t/t4007-rename-3.sh
@@ -17,6 +17,7 @@ test_expect_success 'prepare reference tree' '
 	echo $tree
 '
 
+blob=$(git hash-object "$TEST_DIRECTORY/diff-lib/COPYING")
 test_expect_success 'prepare work tree' '
 	cp path0/COPYING path1/COPYING &&
 	git update-index --add --remove path0/COPYING path1/COPYING
@@ -26,8 +27,8 @@ test_expect_success 'prepare work tree' '
 # path1 both have COPYING and the latter is a copy of path0/COPYING.
 # Comparing the full tree with cache should tell us so.
 
-cat >expected <<\EOF
-:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 6ff87c4664981e4397625791c8ea3bbb5f2279a3 C100	path0/COPYING	path1/COPYING
+cat >expected <<EOF
+:100644 100644 $blob $blob C100	path0/COPYING	path1/COPYING
 EOF
 
 test_expect_success 'copy detection' '
@@ -46,8 +47,8 @@ test_expect_success 'copy detection, cached' '
 # path1/COPYING suddenly appearing from nowhere, not detected as
 # a copy from path0/COPYING.
 
-cat >expected <<\EOF
-:000000 100644 0000000000000000000000000000000000000000 6ff87c4664981e4397625791c8ea3bbb5f2279a3 A	path1/COPYING
+cat >expected <<EOF
+:000000 100644 $ZERO_OID $blob A	path1/COPYING
 EOF
 
 test_expect_success 'copy, limited to a subtree' '
@@ -64,8 +65,8 @@ test_expect_success 'tweak work tree' '
 # path0/COPYING.  Showing the full tree with cache should tell us about
 # the rename.
 
-cat >expected <<\EOF
-:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 6ff87c4664981e4397625791c8ea3bbb5f2279a3 R100	path0/COPYING	path1/COPYING
+cat >expected <<EOF
+:100644 100644 $blob $blob R100	path0/COPYING	path1/COPYING
 EOF
 
 test_expect_success 'rename detection' '
@@ -78,8 +79,8 @@ test_expect_success 'rename detection' '
 # path0/COPYING.  When we say we care only about path1, we should just
 # see path1/COPYING appearing from nowhere.
 
-cat >expected <<\EOF
-:000000 100644 0000000000000000000000000000000000000000 6ff87c4664981e4397625791c8ea3bbb5f2279a3 A	path1/COPYING
+cat >expected <<EOF
+:000000 100644 $ZERO_OID $blob A	path1/COPYING
 EOF
 
 test_expect_success 'rename, limited to a subtree' '
