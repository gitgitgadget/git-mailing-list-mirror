Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF0DD200B9
	for <e@80x24.org>; Sun,  6 May 2018 23:19:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751982AbeEFXSr (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 19:18:47 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41092 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751903AbeEFXSj (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 6 May 2018 19:18:39 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C108860765;
        Sun,  6 May 2018 23:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525648717;
        bh=mqBu9whqEeMOR8DofMG/yQNOXY/GMlA/bIFoc06U86k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=MzUS6C1e6qmBLVDeco7AL15lKzgBXCIKBL6GbMwAA1I4r+xqcQFUFpcRN1IaIZLIs
         QpWb/9Po0lFSi+H/dvmlWmdrRXXjdWMpPBX7QSapKnRDUAcHDKdWU30EjnPVmtdF2e
         NY76tG4RvUUwgmz7fp4dqvEY7DkoT/Rrl31cFSsLmDwHxmN1n3okylOPTJbgJB81eL
         f2P/LczjxO40XvbjTOTG4SzJGSdt1DOu9QLSMNHeyWhwCFwAxRBNBSrdRcy4mxDwVi
         MM8cKX8TEkm4/R8HqmS9bcGRCSPTTY2Z5R2wKiBwuMWvehcUBcMyfPPADHx2BmwrTi
         rvrnsit/AkivsVgRkTYwa8FRzJKm5zL/vDBnjnUNpQCV7N+8UoywI5v2qjjUhoGLNo
         JJcjXltn8SJEwig8varuLg+MjazQiBSZXoF2iZjnGGnJc5F350Z0/rq2AwW867CIM1
         S0ZToMlz/qOQGCoHopOl5h5kncR+3rW19p5tnkwIoQQW9BJDpOn
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH 08/28] t1512: skip test if not using SHA-1
Date:   Sun,  6 May 2018 23:17:32 +0000
Message-Id: <20180506231752.975110-9-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180506231752.975110-1-sandals@crustytoothpaste.net>
References: <20180506231752.975110-1-sandals@crustytoothpaste.net>
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
