Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 841A7200B9
	for <e@80x24.org>; Sun,  6 May 2018 23:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752098AbeEFXTl (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 19:19:41 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41134 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751931AbeEFXSr (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 6 May 2018 19:18:47 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DDA2E60761;
        Sun,  6 May 2018 23:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525648726;
        bh=2EqZeLsV5DlZf+tHplzQNzUojW0Sl8W2gW5NIUZQYaw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=X4hq39awh0j/2Y0a0ndPGu/TnQG+qX06hONWoIeIE+z+FmXvtJzfugvWI8RtU4Sn+
         7Lzwd6Kx8DuuvOyPAd7roCNLFCarvHRy0gPJFJiMxBLOnDmBI6yjXrM7bOP5PTj4My
         eT2oIzGFf8Z6e0OQO9KF8btEGY0U+NS9WE4Q8Y44/L1FGaC70Kxf7s4/t93wl1Qiqb
         8F7aTtR4ZTrsag67XcqIPTIy03lSHCosfertoJpq442W2lo6GAzRL6TAbpCrErwL6K
         6UP3jZuP5ZR9NMDjm6dmiO24OfatIrGky3qXk9Ncv+4HpBl9ihXeVpiYaMPrLytXl9
         bYFVzH5pek2cUFS1tpp7q5W83YIljpmSXI99qik2Yep8ep9I1iLceGT4H85ocpo/bE
         4MUADPDTbHbIHqFfl2pA5e9EOBR16ULlRCO4IPsMeRulgLmuLXlw2lbZYSQVdgUSAn
         8jHMZZRBdfgevbl7BCycjIpn312WxS6Lk0H5qn2e0ozPIJB+Cgt
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH 15/28] t4007: abstract away SHA-1-specific constants
Date:   Sun,  6 May 2018 23:17:39 +0000
Message-Id: <20180506231752.975110-16-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180506231752.975110-1-sandals@crustytoothpaste.net>
References: <20180506231752.975110-1-sandals@crustytoothpaste.net>
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
