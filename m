Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03F691F406
	for <e@80x24.org>; Wed, 16 May 2018 01:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752661AbeEPB7n (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 21:59:43 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47368 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751859AbeEPB6n (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 15 May 2018 21:58:43 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:64f1:3b3f:8f13:59ed])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 246A660747;
        Wed, 16 May 2018 01:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1526435922;
        bh=mqBu9whqEeMOR8DofMG/yQNOXY/GMlA/bIFoc06U86k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=igz36UfG7tLEc5tKSf+xOOyN09BNj3AgvTyszSrCD5fBPZKTBiuM+6xD99JObC+B9
         gGWn5d+M0rtkk4GkVID1wTLC5pwZKSPAx9o8FIUH92S6rcudgp8hPu1QVvqinvbBiV
         nHYL8PMp8LO+fIz0+up7FIXSvqshYh9ozhMJfJRE05gKJC3zu5H3YI/kW4c4ALYR4O
         yN2PSGKXlxoU9V2GM0dJGnB9bJOLxkyydB5xlZpXU1yUTS2CWc/Mz+WDQXkYayZKZB
         F7sIHFg9CcNWIzvK0/e7Sny55W3tLxyb5HBljAW7wLB1fmq6fUgjVXvJjHeSYRXSE+
         l5PDFUuCDRWXbi/UWoMMFW5b41Rbt8XW37CUbDmj4ArL/23UCpHXMjL/BiuSzZcpse
         W/08I+7blxPq0NeFBkEJv6P2hqOj5wUutq9bvw8wa39147LkCw37XFoCVNE3XT+sqZ
         7qCT9oXlc/4q8QpIa1/oCVKF132jb16SDLw3mRam5t0y068kYW1
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v3 08/28] t1512: skip test if not using SHA-1
Date:   Wed, 16 May 2018 01:56:10 +0000
Message-Id: <20180516015630.661349-9-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180516015630.661349-1-sandals@crustytoothpaste.net>
References: <20180516015630.661349-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test relies on objects with colliding short names which are
necessarily dependent on the hash used.  Skip the test if we're not
using SHA-1.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t1512-rev-parse-disambiguation.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-disambiguation.sh
index 711704ba5a..6537f30c9e 100755
--- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -22,6 +22,12 @@ one tagged as v1.0.0.  They all have one regular file each.
 
 . ./test-lib.sh
 
+if ! test_have_prereq SHA1
+then
+	skip_all='not using SHA-1 for objects'
+	test_done
+fi
+
 test_expect_success 'blob and tree' '
 	test_tick &&
 	(
