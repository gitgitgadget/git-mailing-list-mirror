Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA5C2200B9
	for <e@80x24.org>; Sun,  6 May 2018 23:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752104AbeEFXTm (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 19:19:42 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41134 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751949AbeEFXSp (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 6 May 2018 19:18:45 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 32D0E60768;
        Sun,  6 May 2018 23:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525648723;
        bh=UhHGOqdw5Cc2OBcW1AITqL3yRBZ2I6Ujh2NfIrs47X8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Ndhkh4v9F57V/UcJQN6CIfZTkJA04kO6LgdXLxzHLWe6lKrL2FyP9FBbYl8m/ZTI2
         RufSiCrIk3uOxRZ0J3O18tPm+C5x+U1ca8VW+Sxtq8A9BpW83qZX5E2j7XMbc5qQa6
         HdxF9IzJdyi1O/LcnyuqSxoucrPFOEQq6mryRL8CaxIfOt+qGyI7MaYsTdXW2CNUJk
         2VSNJJTbC8Jb4M30MlPqiL3Zkd/YXq6U/Hz+RxQXelC7/s45nsQ5T1kP7JIfbui5+F
         YATlXtGPSEKsVVjNzFsEOE4xXq8OkvfpYhW2TEWGSKJLXr0sdd0tNgoQeN1kb/riuh
         95vvy0T2ntq2FTObzra7xE6qj7ILwaK1I8RoqQ71SrBYIDuzmKFoDfpIM2V/HfBLcc
         32zZPy36lljEjUkZKNUZCtUikN51Lgm7x6u+8QWxgRmfU5iGt/sx4BL6YMn4tbZjwo
         ko6HwgkkCkIiCy/XP3oTNMW3XWBaw3rb6NdTZXT0numhloyvMlV
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH 13/28] t3702: abstract away SHA-1-specific constants
Date:   Sun,  6 May 2018 23:17:37 +0000
Message-Id: <20180506231752.975110-14-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180506231752.975110-1-sandals@crustytoothpaste.net>
References: <20180506231752.975110-1-sandals@crustytoothpaste.net>
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
