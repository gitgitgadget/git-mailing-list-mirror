Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6BBD1F406
	for <e@80x24.org>; Wed, 16 May 2018 01:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752646AbeEPB73 (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 21:59:29 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47480 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752359AbeEPB64 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 15 May 2018 21:58:56 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:64f1:3b3f:8f13:59ed])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7111560443;
        Wed, 16 May 2018 01:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1526435936;
        bh=HgZxE5D0+6JfaobdOtxElSsK+uXh9myHMFGd0+ulCkE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=FIFwb5IsxPzSovgwSlF0IvJSYEJtNt+bG+nQnobcNYHCXYtkAoCTG68KyHJs5jbzP
         +lL0X6UxZTKpTrXC7VM2VDw2Zea41dNLakdqL3n2Egd359auH8JXcf5r0e+osjzvqX
         SBS4fAqs/vndY14BtWxHn7Icp3/He3K/wDTlvGm7Y93La7/czGjEcLTyjXXhXRYbEK
         kMpQh2Leyws1nBVJhrexXDvKKIekXXWSE2O036PDMj2CRtxOqhn6R724L4sryx9vb8
         wt/ndSyA1See7b18WoSAq+BCkeURNqoMNpv6YeQFx+A8130xVn4v1ShnaA8E/ZP1d0
         XErKiI4xhBtMykSyeCV0TeRA96udy/c9oAWP3r4pgGaqOuyuarpvNXjnOg2leLRXzy
         5l6OeijDaskZIkyttB4Ki07A8SeepG3761In3Giu81WczWi1P4Ye96CEICF+/Mc7dV
         Qm+5Fv/oSMQ4wV7Bk2+Hzx3AoU8uxkPG7viho7Zr+MAok832Wg4
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v3 19/28] t4022: abstract away SHA-1-specific constants
Date:   Wed, 16 May 2018 01:56:21 +0000
Message-Id: <20180516015630.661349-20-sandals@crustytoothpaste.net>
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
 t/t4022-diff-rewrite.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t4022-diff-rewrite.sh b/t/t4022-diff-rewrite.sh
index cb51d9f9d4..6d1c3d949c 100755
--- a/t/t4022-diff-rewrite.sh
+++ b/t/t4022-diff-rewrite.sh
@@ -13,6 +13,8 @@ test_expect_success setup '
 	  "nopqrstuvwxyzabcdefghijklmNOPQRSTUVWXYZABCDEFGHIJKLM" \
 	  <"$TEST_DIRECTORY"/../COPYING >test &&
 	echo "to be deleted" >test2 &&
+	blob=$(git hash-object test2) &&
+	blob=$(git rev-parse --short $blob) &&
 	git add test2
 
 '
@@ -27,7 +29,7 @@ test_expect_success 'detect rewrite' '
 cat >expect <<EOF
 diff --git a/test2 b/test2
 deleted file mode 100644
-index 4202011..0000000
+index $blob..0000000
 --- a/test2
 +++ /dev/null
 @@ -1 +0,0 @@
@@ -43,7 +45,7 @@ test_expect_success 'show deletion diff without -D' '
 cat >expect <<EOF
 diff --git a/test2 b/test2
 deleted file mode 100644
-index 4202011..0000000
+index $blob..0000000
 EOF
 test_expect_success 'suppress deletion diff with -D' '
 
