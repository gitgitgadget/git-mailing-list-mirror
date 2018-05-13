Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34A411F406
	for <e@80x24.org>; Sun, 13 May 2018 02:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752083AbeEMC0B (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 22:26:01 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:45390 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752031AbeEMCZ6 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 12 May 2018 22:25:58 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:64f1:3b3f:8f13:59ed])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D620760749;
        Sun, 13 May 2018 02:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1526178357;
        bh=7J7D5LHnPjUgkTU4kM/Tt7qCRP9l7HTj4/hWCGEBDt8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=ZKWSzsk/gOwttKL3p0Of7vNvWSfJt04DmF9tiI4GuGFI74dtLikaT9j2B205WF2Bg
         6KeYs5aL1BH+g0Y7x3tjrHTJolgQQbZPOXt4HRI/mRM9kHvR9DUSyF6aJx/+6tyA9I
         oiRqzxmsVlR6H3MMO0DL0k+uV2Htk9+M5aUDsVZjUY5acSm64XGw+eyM0M2ThjqsIi
         h7o/jrtb7BblYz8i7Ez4i8DvVgnbqxTJ2qTyHDCSh31rTVBs8tkmnJVcOAHbZJn836
         fDOMRHlO7Zd0bKzGYQwAMlVVDuJX15LegcIHgVmNTfIXzLfgzOJwX08mtYgeqnlLEf
         HMfuLL0fHAZvX9Hxc4wFaEaNjDlLotEsrB4lkGX53dxvVZU8tzUnVj1NXin+iADkLu
         4sxAamXbwhn25o4SOaFeCE/KfGE3C0hxIcgSeOii5pNc75jl+ubE9jQ2dfOnMkpWUV
         wyAWIH9MhBClc6hLaE86PQZTLnV9BfzU5KT5yEXpWnU1yb1MsQd
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 25/28] t4042: abstract away SHA-1-specific constants
Date:   Sun, 13 May 2018 02:24:35 +0000
Message-Id: <20180513022438.60003-26-sandals@crustytoothpaste.net>
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
 t/t4042-diff-textconv-caching.sh | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/t/t4042-diff-textconv-caching.sh b/t/t4042-diff-textconv-caching.sh
index 04a44d5c61..bf33aedf4b 100755
--- a/t/t4042-diff-textconv-caching.sh
+++ b/t/t4042-diff-textconv-caching.sh
@@ -15,9 +15,13 @@ test_expect_success 'setup' '
 	echo bar content 1 >bar.bin &&
 	git add . &&
 	git commit -m one &&
+	foo1=$(git rev-parse --short HEAD:foo.bin) &&
+	bar1=$(git rev-parse --short HEAD:bar.bin) &&
 	echo foo content 2 >foo.bin &&
 	echo bar content 2 >bar.bin &&
 	git commit -a -m two &&
+	foo2=$(git rev-parse --short HEAD:foo.bin) &&
+	bar2=$(git rev-parse --short HEAD:bar.bin) &&
 	echo "*.bin diff=magic" >.gitattributes &&
 	git config diff.magic.textconv ./helper &&
 	git config diff.magic.cachetextconv true
@@ -25,14 +29,14 @@ test_expect_success 'setup' '
 
 cat >expect <<EOF
 diff --git a/bar.bin b/bar.bin
-index fcf9166..28283d5 100644
+index $bar1..$bar2 100644
 --- a/bar.bin
 +++ b/bar.bin
 @@ -1 +1 @@
 -converted: bar content 1
 +converted: bar content 2
 diff --git a/foo.bin b/foo.bin
-index d5b9fe3..1345db2 100644
+index $foo1..$foo2 100644
 --- a/foo.bin
 +++ b/foo.bin
 @@ -1 +1 @@
@@ -59,7 +63,7 @@ test_expect_success 'cached textconv does not run helper' '
 
 cat >expect <<EOF
 diff --git a/bar.bin b/bar.bin
-index fcf9166..28283d5 100644
+index $bar1..$bar2 100644
 --- a/bar.bin
 +++ b/bar.bin
 @@ -1,2 +1,2 @@
@@ -67,7 +71,7 @@ index fcf9166..28283d5 100644
 -converted: bar content 1
 +converted: bar content 2
 diff --git a/foo.bin b/foo.bin
-index d5b9fe3..1345db2 100644
+index $foo1..$foo2 100644
 --- a/foo.bin
 +++ b/foo.bin
 @@ -1,2 +1,2 @@
@@ -84,7 +88,7 @@ test_expect_success 'changing textconv invalidates cache' '
 
 cat >expect <<EOF
 diff --git a/bar.bin b/bar.bin
-index fcf9166..28283d5 100644
+index $bar1..$bar2 100644
 --- a/bar.bin
 +++ b/bar.bin
 @@ -1,2 +1,2 @@
@@ -92,7 +96,7 @@ index fcf9166..28283d5 100644
 -converted: bar content 1
 +converted: bar content 2
 diff --git a/foo.bin b/foo.bin
-index d5b9fe3..1345db2 100644
+index $foo1..$foo2 100644
 --- a/foo.bin
 +++ b/foo.bin
 @@ -1 +1 @@
