Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B9532023D
	for <e@80x24.org>; Sun,  6 May 2018 23:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752008AbeEFXSw (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 19:18:52 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41124 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751913AbeEFXSn (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 6 May 2018 19:18:43 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 69BA460753;
        Sun,  6 May 2018 23:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525648721;
        bh=OKImVgLsuITK2qTIabYzypDTP06l4T0y+9Jxfu7Rz7I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=ms6ZOXK9OBi8rQ9C3bOwr6cRBhDOLiUbnXXXrlW0a+eSwjByjuJw7gcWCiC1cGF9W
         dgiXZJ6/+mL048fuuHeMWEXYXykgarb6yjV5NzRqM0RqQvztAw42RrFTb6kffQkiT2
         K0TmuvN/2DRS68xjXgT1p3eS6jQFoE0KXvJ5tfjfdAW5LIrQDKE24B7e8Nnuc8VbHH
         L378+iw85zhlP/RBCEQOufQdxZalaX2+uC8F42LyE1s2T2ud+WQDtbY5UurCOohk6W
         wRX7kRqe+hiqJY0O55MiEhwcXkcasVTbRTWeDltk0afU4+AKnh++kEmIptX93R6ffC
         KbJUETfyUvn+0eTeSDM7dNfBAJ9XiUVvbNtyDufDr3aqRW3ksU5/Mp/Y3qi7PPnFtK
         Tlt41fpEVIBa6ulojyxIElEEQPpvCzKXYgWGykmqIHFyAfVqlS80l4yqAkhB2ULqxt
         f59yI+Y+ifMNhd1AScCc6fPujZeb9aA392REHNy4zeOTlKAEQTE
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH 11/28] t2203: abstract away SHA-1-specific constants
Date:   Sun,  6 May 2018 23:17:35 +0000
Message-Id: <20180506231752.975110-12-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180506231752.975110-1-sandals@crustytoothpaste.net>
References: <20180506231752.975110-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust the test so that it computes variables for blobs instead of using
hard-coded hashes.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t2203-add-intent.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index 1797f946b9..04d840a544 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -27,8 +27,8 @@ test_expect_success 'git status' '
 
 test_expect_success 'git status with porcelain v2' '
 	git status --porcelain=v2 | grep -v "^?" >actual &&
-	nam1=d00491fd7e5bb6fa28c517a0bb32b8b506539d4d &&
-	nam2=ce013625030ba8dba906f756967f9e9ca394464a &&
+	nam1=$(echo 1 | git hash-object --stdin) &&
+	nam2=$(git hash-object elif) &&
 	cat >expect <<-EOF &&
 	1 DA N... 100644 000000 100644 $nam1 $ZERO_OID 1.t
 	1 A. N... 000000 100644 100644 $ZERO_OID $nam2 elif
@@ -181,7 +181,7 @@ test_expect_success 'rename detection finds the right names' '
 		EOF
 		test_cmp expected.2 actual.2 &&
 
-		hash=12f00e90b6ef79117ce6e650416b8cf517099b78 &&
+		hash=$(git hash-object third) &&
 		git status --porcelain=v2 | grep -v "^?" >actual.3 &&
 		cat >expected.3 <<-EOF &&
 		2 .R N... 100644 100644 100644 $hash $hash R100 third	first
@@ -212,7 +212,7 @@ test_expect_success 'double rename detection in status' '
 		EOF
 		test_cmp expected.2 actual.2 &&
 
-		hash=12f00e90b6ef79117ce6e650416b8cf517099b78 &&
+		hash=$(git hash-object third) &&
 		git status --porcelain=v2 | grep -v "^?" >actual.3 &&
 		cat >expected.3 <<-EOF &&
 		2 R. N... 100644 100644 100644 $hash $hash R100 second	first
