Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F2861F406
	for <e@80x24.org>; Sun, 13 May 2018 02:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752025AbeEMCZl (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 22:25:41 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:45252 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752007AbeEMCZ2 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 12 May 2018 22:25:28 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:64f1:3b3f:8f13:59ed])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0DCA660743;
        Sun, 13 May 2018 02:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1526178327;
        bh=mqBu9whqEeMOR8DofMG/yQNOXY/GMlA/bIFoc06U86k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=FNrJVbP/tbuTlBS76h4rmSuZiKgDSVw/Ak0/w7IdoybHCIoF0o5xd/LN11hECLmkV
         m//D1nVa6K39r6pqgTM5KlExeeaM9KzAOR/AelyCsxLqWcT9Zq8uHLnA4hoD3RlwMR
         vKCGc0/UbUr0MbR2jxzv/elM7gwzLN4VV+IjAVJ6ux9Rm6ST5Wp3niLygBNFv3j8c3
         dwfw7Wk2Ewjw0pvdg/ItbUrzAEPo3asnL8QASGuAvTseUFQHAMbhjgJHA6s0pxfNjd
         WofkLo9p2cl2exXsgMABWxDB956spViIOzuCx9JcX+bt9SC65AXcCXMQZXYMKqauIt
         3wzLCpVg1LMXYFRyAIu25F4FuhTrJy4d3JhwbaD4/9Rh/R2gVFWWjFvUN70Wri/ET/
         jMCyzmrCdQs+yTUycIH28pHsoG2dt4jYRyiJbuejRCMrZbVW+hxjKGytaF9gfCvNwN
         JeftT0bGQ91MJXiERaDN82nq4E1P55FF+btp3zEUdsBu0N9HoBi
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 08/28] t1512: skip test if not using SHA-1
Date:   Sun, 13 May 2018 02:24:18 +0000
Message-Id: <20180513022438.60003-9-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180513022438.60003-1-sandals@crustytoothpaste.net>
References: <20180513022438.60003-1-sandals@crustytoothpaste.net>
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
