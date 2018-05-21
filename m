Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BB421F51C
	for <e@80x24.org>; Mon, 21 May 2018 02:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752687AbeEUCC7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 22:02:59 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:50956 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752671AbeEUCCy (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 20 May 2018 22:02:54 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:fc4d:8d90:22bd:91d8])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B8F0A60748;
        Mon, 21 May 2018 02:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1526868173;
        bh=2EqZeLsV5DlZf+tHplzQNzUojW0Sl8W2gW5NIUZQYaw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=qV5fknYHNNN/HCwZVRDx7rfS5w50krxnMM1VD/rzsxg79Jf5PklWn6BUSiRp+kck8
         6Tzlf2Id/5iwswQU553IycAsTnfu9nn6rbJEzYXw1rudxmlij3BL91tLTI46WQrEnX
         RUO5zrqy7ciTPoGEkilglPobvrrK6yuPXpWMffbQxxjzdiK1FlV77u58TACj9x+DD+
         2+JUrOVe7Hy+dIrcUfm4BjwzR68QRRHuZXDf5Z597f3Ecc82n7zi9zsv4F0tq5v1y8
         lzNXQfaxokag2ZJXFw0Os8phmXR7NF7de4M2dJCzb97gqQm/GhEL8KvZhmK4ysSPvK
         OtzJUrjUz0qGuZsemTNK3/0BrZDJMSqFQaCbR7H2PXy2bGPuu+CIY1f2AxXi4Mieig
         IZpu7Hzt/SiXNuuZqL022ul5N8pX58ypZGBlQNO4ID+16HFKeJkJXNeVIObkf1rzXY
         5H6dM7nw5ik4Qff1/pA1cCznNAN8VMynEQueQLJ87tiG9K+pY+N
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v4 15/28] t4007: abstract away SHA-1-specific constants
Date:   Mon, 21 May 2018 02:01:34 +0000
Message-Id: <20180521020147.648496-16-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180521020147.648496-1-sandals@crustytoothpaste.net>
References: <20180516015630.661349-1-sandals@crustytoothpaste.net>
 <20180521020147.648496-1-sandals@crustytoothpaste.net>
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
