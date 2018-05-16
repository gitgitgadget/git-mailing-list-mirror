Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1663A1F406
	for <e@80x24.org>; Wed, 16 May 2018 01:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752640AbeEPB7Q (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 21:59:16 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47544 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752601AbeEPB7D (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 15 May 2018 21:59:03 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:64f1:3b3f:8f13:59ed])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DCBDA60443;
        Wed, 16 May 2018 01:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1526435942;
        bh=7J7D5LHnPjUgkTU4kM/Tt7qCRP9l7HTj4/hWCGEBDt8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=zFtvCt/3hO6pwy+2GiCaa7KwcX1SHmCYn9ljiHbv4pWIlVMAPrmHgeKftFV1ZxKuh
         SYhsPNShM2ZZ1BOo7ZDivF3kV+qY6Pq2zz1htAxW5rEFyIPd8lG7V+n4K4dGeGFWsM
         PwQyBOVPSIC/HB71PjWJ+mVxW8ZiT1R+pqdl2pPkTvQ7dW5f17idoXADHXXcBClwNT
         D3j8Y1SFAYcDrONl3t/Q35+MUWQF7sG8puhi+nxyqQUQDnDwYcA4FOSkUcDDQaVQiw
         16JanWqFTJ199+6UQgQ0T6QOipqBTUEDvy2tKkLQcyZovhQ88w9gaf0YhP816/92H5
         A4THPLu2oXrqt6uVLfCnuSiY0wLHd2ZVQ1IzSYq2XlT5uQMe/1thsEVo0ksLoyzrq3
         6x1TzdMmuKezCW2/AYaEi4A/VNmE+E4KgSrFqntY1+FUOheO+euXxxTIjOKu5Oiodi
         RQRcoDDyIEuMv5IefrjwcOdmyg9hjEbgXrd9pbyKhxBeQBM5X+a
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v3 25/28] t4042: abstract away SHA-1-specific constants
Date:   Wed, 16 May 2018 01:56:27 +0000
Message-Id: <20180516015630.661349-26-sandals@crustytoothpaste.net>
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
