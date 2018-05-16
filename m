Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6B871F406
	for <e@80x24.org>; Wed, 16 May 2018 01:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752655AbeEPB7h (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 21:59:37 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47422 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751976AbeEPB6u (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 15 May 2018 21:58:50 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:64f1:3b3f:8f13:59ed])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E72C960749;
        Wed, 16 May 2018 01:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1526435929;
        bh=UhHGOqdw5Cc2OBcW1AITqL3yRBZ2I6Ujh2NfIrs47X8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=LhcHQolpDjiCTFRtkY0pcqd0v2ZgjRdpeVBrV1s08Lx4Lr1VrtmRtDU/4YBkjfrQ6
         gZk94q4haC5TrAlCTqjGSXx4jiIo2m9m8fVlzRhxu8co+q3iKBK5edj2bjk+3/akLw
         KJWaxGEt5XWezmdk5ajrI/b1u8DjcQWGRYDi00ZFkhhu5hmQgMTbCv66JBYafGsbu6
         qR1+MxCw4O9KdjIxuqDa2TNsddQhmH72RTOKqD7tGgEtvIujrOAtPOfCJBN2DGbeXN
         7MbHU+KB0dOTefEpYurKrSC1ftO8zUzpCfZ0h29hNJqPFancfxwkD/iKyUrFijFrLe
         iKDa5AlxNo//wCN89zkJ3lyDxhVKpMrAsjafY3lC1544UzC0vTbBq19UFhjGJfXshT
         NRTS0EYz57xNmh2r6mzQyWA5no0rjTj8IqjpczAxUiyno1TDbJAP+9Sy+3SngRCXg4
         B9mzO65x9YvWHxp2aSlVxPofzv28TVNqxlnvxYSi58ksKesnZIk
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v3 13/28] t3702: abstract away SHA-1-specific constants
Date:   Wed, 16 May 2018 01:56:15 +0000
Message-Id: <20180516015630.661349-14-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180516015630.661349-1-sandals@crustytoothpaste.net>
References: <20180516015630.661349-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Strip out the index lines in the diff before comparing them, as these
will differ between hash algorithms.  This leads to a smaller, simpler
change than editing the index line.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t3702-add-edit.sh | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/t/t3702-add-edit.sh b/t/t3702-add-edit.sh
index 3cb74ca296..1be5cd5756 100755
--- a/t/t3702-add-edit.sh
+++ b/t/t3702-add-edit.sh
@@ -40,7 +40,6 @@ test_expect_success 'setup' '
 
 cat > expected-patch << EOF
 diff --git a/file b/file
-index b9834b5..9020acb 100644
 --- a/file
 +++ b/file
 @@ -1,11 +1,6 @@
@@ -80,7 +79,6 @@ EOF
 
 cat > expected << EOF
 diff --git a/file b/file
-index b9834b5..ef6e94c 100644
 --- a/file
 +++ b/file
 @@ -1,10 +1,12 @@
@@ -100,7 +98,7 @@ EOF
 
 echo "#!$SHELL_PATH" >fake-editor.sh
 cat >> fake-editor.sh <<\EOF
-mv -f "$1" orig-patch &&
+egrep -v '^index' "$1" >orig-patch &&
 mv -f patch "$1"
 EOF
 
@@ -113,7 +111,8 @@ test_expect_success 'add -e' '
 	git add -e &&
 	test_cmp second-part file &&
 	test_cmp orig-patch expected-patch &&
-	git diff --cached > out &&
+	git diff --cached >actual &&
+	egrep -v "^index " actual >out &&
 	test_cmp out expected
 
 '
