Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F9211F404
	for <e@80x24.org>; Sun, 25 Mar 2018 19:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752042AbeCYTVb (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 15:21:31 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:42536 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752025AbeCYTVY (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 25 Mar 2018 15:21:24 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 633BB6099F;
        Sun, 25 Mar 2018 19:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1522005682;
        bh=sHbYcKFqOjZniGnJ4Or68J/jvti7KrpnxtpLbKDlBhQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=TADegQSMlLfgME9BYkEEfwkGvg8XLmbszszrIhyhx0r1rGjPqzziT0jtFjoT3IMo8
         Dg8ifsxYqXWmo2njJzqT32UHQ6pxUyZLxnAxL/OGfPz43O5OOTnhm+YCDF6GYZbjlj
         aonorBYVpUNtlPwlcmmpFeulXJsKWwf3hDS92dCCz4Nx3WV8dUm2EV5W8Vi0hVDHHz
         uJ7/WDHIbra0Sf+kjOPtQdRiME7VcmDQbZmlnVrB+Vhd2a6KSVbPEna6oBZS6FPk6p
         E4ndo7QZMbHcrQDXCb0oVpB66E4R5Vf8vuhPzdNmf77mRxLIKh9BFPVtk5VeQpfv+S
         aWZCG2rSMkAnPUxgWfSuyS7qp7r57+lrgvDb6APmtYWVIGL0e2qLsDLHVWPIPf7yKx
         VsKXrU0TnMdXPBKuJY2lcOf75v2Yf/0OJ0c9WVn4UGN6h1VCGcO1fZ1nXS4rwNo7JK
         46toFgpqUBBvaSNj0pw/EOqJkapxK4cvyRl05PPIZulK/CtP/vF
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH 09/10] t2101: abstract away SHA-1-specific constants
Date:   Sun, 25 Mar 2018 19:20:54 +0000
Message-Id: <20180325192055.841459-10-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.rc1.317.g4a561d2cc9
In-Reply-To: <20180325192055.841459-1-sandals@crustytoothpaste.net>
References: <20180325192055.841459-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust the test so that it uses variables and command substitution for
blobs instead of hard-coded hashes.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t2101-update-index-reupdate.sh | 41 ++++++++++++++++----------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/t/t2101-update-index-reupdate.sh b/t/t2101-update-index-reupdate.sh
index 168733a3c7..685ec45639 100755
--- a/t/t2101-update-index-reupdate.sh
+++ b/t/t2101-update-index-reupdate.sh
@@ -8,15 +8,15 @@ test_description='git update-index --again test.
 
 . ./test-lib.sh
 
-cat > expected <<\EOF
-100644 3b18e512dba79e4c8300dd08aeb37f8e728b8dad 0	file1
-100644 9db8893856a8a02eaa73470054b7c1c5a7c82e47 0	file2
-EOF
 test_expect_success 'update-index --add' '
 	echo hello world >file1 &&
 	echo goodbye people >file2 &&
 	git update-index --add file1 file2 &&
 	git ls-files -s >current &&
+	cat >expected <<-EOF &&
+	100644 $(git hash-object file1) 0	file1
+	100644 $(git hash-object file2) 0	file2
+	EOF
 	cmp current expected
 '
 
@@ -34,21 +34,17 @@ test_expect_success 'update-index --again' '
 	cmp current expected
 '
 
-cat > expected <<\EOF
-100644 0f1ae1422c2bf43f117d3dbd715c988a9ed2103f 0	file2
-EOF
 test_expect_success 'update-index --remove --again' '
 	git update-index --remove --again &&
 	git ls-files -s >current &&
+	cat >expected <<-EOF &&
+	100644 $(git hash-object file2) 0	file2
+	EOF
 	cmp current expected
 '
 
 test_expect_success 'first commit' 'git commit -m initial'
 
-cat > expected <<\EOF
-100644 53ab446c3f4e42ce9bb728a0ccb283a101be4979 0	dir1/file3
-100644 0f1ae1422c2bf43f117d3dbd715c988a9ed2103f 0	file2
-EOF
 test_expect_success 'update-index again' '
 	mkdir -p dir1 &&
 	echo hello world >dir1/file3 &&
@@ -58,13 +54,14 @@ test_expect_success 'update-index again' '
 	echo happy >dir1/file3 &&
 	git update-index --again &&
 	git ls-files -s >current &&
+	cat >expected <<-EOF &&
+	100644 $(git hash-object dir1/file3) 0	dir1/file3
+	100644 $(git hash-object file2) 0	file2
+	EOF
 	cmp current expected
 '
 
-cat > expected <<\EOF
-100644 d7fb3f695f06c759dbf3ab00046e7cc2da22d10f 0	dir1/file3
-100644 0f1ae1422c2bf43f117d3dbd715c988a9ed2103f 0	file2
-EOF
+file2=$(git hash-object file2)
 test_expect_success 'update-index --update from subdir' '
 	echo not so happy >file2 &&
 	(cd dir1 &&
@@ -72,18 +69,22 @@ test_expect_success 'update-index --update from subdir' '
 	git update-index --again
 	) &&
 	git ls-files -s >current &&
-	cmp current expected
+	cat >expected <<-EOF &&
+	100644 $(git hash-object dir1/file3) 0	dir1/file3
+	100644 $file2 0	file2
+	EOF
+	test_cmp current expected
 '
 
-cat > expected <<\EOF
-100644 594fb5bb1759d90998e2bf2a38261ae8e243c760 0	dir1/file3
-100644 0f1ae1422c2bf43f117d3dbd715c988a9ed2103f 0	file2
-EOF
 test_expect_success 'update-index --update with pathspec' '
 	echo very happy >file2 &&
 	cat file2 >dir1/file3 &&
 	git update-index --again dir1/ &&
 	git ls-files -s >current &&
+	cat >expected <<-EOF &&
+	100644 $(git hash-object dir1/file3) 0	dir1/file3
+	100644 $file2 0	file2
+	EOF
 	cmp current expected
 '
 
