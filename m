Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF5EA1F406
	for <e@80x24.org>; Sun, 13 May 2018 02:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752023AbeEMCZe (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 22:25:34 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:45276 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752014AbeEMCZc (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 12 May 2018 22:25:32 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:64f1:3b3f:8f13:59ed])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 63C6460743;
        Sun, 13 May 2018 02:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1526178330;
        bh=OKImVgLsuITK2qTIabYzypDTP06l4T0y+9Jxfu7Rz7I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=wr0gqZlzosxowITmMx+U28C1Q6ObpXIzDn2ZMwkyHMeq/aYOzd994C/QKOEaPmCRI
         Sj8WkZWpsBprAdR3ciPegMGJtGNiGmM4Q/p4cm7iLQ61lN4RSqOY0X1O2SjsH/Wc/t
         bzlhikjyGc1EHhJ58X8MHTbb2+Y7ZKe9Dv0Ihkls9hR2vwXaM28cuQddudxt49ze8B
         Tco9FNRggNdUXE4HGaQJWVeSqZonJFQt/X87dwEy+MEJG1qJKEfBJwcWGkebkVCiSA
         hos5wBa64okRB9JKa+iR8hLcJ4vZ8v68k6r32l9CSqDghizcQGXP5P8JlVVvsg3kgI
         kNnQIIsYCrwPdXit7vaC4gIMppTZg40rRQX2Wzhlizwm5u86VBy79iV5fKRDsddVv0
         eA4F6iSTeE6ZJIfnIzD0EEbQ7jOk/jUL+JftqVO3VL+fvCJ7IgPxtK8hyCX1pLrqat
         X5LKMMnBpWnXXnqrCjKs2gSvAot98yPk0LU5vqC2+NldpHGDmp2
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 11/28] t2203: abstract away SHA-1-specific constants
Date:   Sun, 13 May 2018 02:24:21 +0000
Message-Id: <20180513022438.60003-12-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180513022438.60003-1-sandals@crustytoothpaste.net>
References: <20180513022438.60003-1-sandals@crustytoothpaste.net>
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
