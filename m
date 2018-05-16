Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDDE01F406
	for <e@80x24.org>; Wed, 16 May 2018 01:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752431AbeEPB6w (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 21:58:52 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47404 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752537AbeEPB6s (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 15 May 2018 21:58:48 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:64f1:3b3f:8f13:59ed])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id BA1FE60747;
        Wed, 16 May 2018 01:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1526435927;
        bh=OKImVgLsuITK2qTIabYzypDTP06l4T0y+9Jxfu7Rz7I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=D1t1Sg5zP4d0BFXq+A0W+I30LGCfgv+ztt3hRwfwfqe8+YPaOwcU47Q4057gj14eq
         BQh8pFw4/uCTmpAFeatBI1wQIEamdMu7ddJMpvYlZG2pNTEV7Ehl44uPE4IYG38HdG
         QhOMtTeeyvl5F+kVKa2dB9LjY9zDoJNhBR6/ph4d+UIqYM6JAKdMsY4xWnClG4lz8l
         9T+hS5PsBD41ts8Gj7PEBEUSZj+Y7z9estffz1b1x9rcM79jeEKTYBCbhhF7TKg5Pr
         i7d70O5/W0IsyIPu1+2oVyCZsFKC7lwbM1HZFGUM1nYD4f3x5UsQW8MiYEAtqWo3We
         ryjCT0mqF1mcNwa9VVJbP+vAw018lB8biqRiz4DKjC4F7CojbqLlWb0ZxvwC036kI6
         va8N1xx0G/ozfC1bG6UZfGo9zvQoY9nt5eHwyN+ps4nL/5+uJENskzwVtnkg8IOsUg
         gcUBaD/5XNMSBm7D8jQZf8+EEFPVyStBEnXOo9MzcmJwEhytHaP
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v3 11/28] t2203: abstract away SHA-1-specific constants
Date:   Wed, 16 May 2018 01:56:13 +0000
Message-Id: <20180516015630.661349-12-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180516015630.661349-1-sandals@crustytoothpaste.net>
References: <20180516015630.661349-1-sandals@crustytoothpaste.net>
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
