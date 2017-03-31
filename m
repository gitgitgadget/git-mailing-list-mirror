Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1038720966
	for <e@80x24.org>; Fri, 31 Mar 2017 01:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935092AbdCaBkN (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 21:40:13 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:59216 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935038AbdCaBkK (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 30 Mar 2017 21:40:10 -0400
Received: from genre.crustytoothpaste.net (unknown [172.16.2.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 7142D280B6;
        Fri, 31 Mar 2017 01:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1490924409;
        bh=DYmgBJmbnx7NbwcGLJ1LKLeV6v5XhubAhCvKAy2tNZk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B9Yyr9L0FzE1+4FtGU7r5Zr5RVkeDh3fBxTVY9Ri66JrdxbtXgB41pvstz7AqJoFt
         VNOpLn5th0PUzte59pgMFsRlBc/ZI9mv3nVy5bc1+XnGwgdtOZzLvhjCdguVbGvfa/
         Wuguy4zWbSzHn+Ups3SB4k1a43lyBiEjvY+zxLhUbO6TSHjuDvE0HsSBwg2DRQw3o1
         rPhU7mwW+ix8SJXiM2pWkMoa6cbmMzKoksCrep2gLCAk3zeHkrkqTsKw05UtjDPeaC
         thPcaoiwAt/X8xhZjjTHrUB42/Do5bIfM0qht7Tto0yZgktBic1k9TIJPGLlTC64sS
         XwVSDCpwWgtkCsNLcPKrxyRTyIYo3xOGZRtxTTNzLDaxNMKdka6WBzONVbkJvsA10y
         im3NfApMonTBD9oC19SM5YPVaYOkTssOKKDi7UqQ1OHoYbL1pd/lH4Co9CLdXxHOEL
         YF4HXLUHnzwX/Rnu1d8sm/CE45hcOy++AWXzj/1rGJG3dZcIgN4
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 09/20] test-sha1-array: convert most code to struct object_id
Date:   Fri, 31 Mar 2017 01:39:50 +0000
Message-Id: <20170331014001.953484-10-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170331014001.953484-1-sandals@crustytoothpaste.net>
References: <20170331014001.953484-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This helper is very small, so convert the entire thing.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/helper/test-sha1-array.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/helper/test-sha1-array.c b/t/helper/test-sha1-array.c
index f7a53c4ad6..b4bb97fccc 100644
--- a/t/helper/test-sha1-array.c
+++ b/t/helper/test-sha1-array.c
@@ -14,16 +14,16 @@ int cmd_main(int argc, const char **argv)
 
 	while (strbuf_getline(&line, stdin) != EOF) {
 		const char *arg;
-		unsigned char sha1[20];
+		struct object_id oid;
 
 		if (skip_prefix(line.buf, "append ", &arg)) {
-			if (get_sha1_hex(arg, sha1))
+			if (get_oid_hex(arg, &oid))
 				die("not a hexadecimal SHA1: %s", arg);
-			sha1_array_append(&array, sha1);
+			sha1_array_append(&array, oid.hash);
 		} else if (skip_prefix(line.buf, "lookup ", &arg)) {
-			if (get_sha1_hex(arg, sha1))
+			if (get_oid_hex(arg, &oid))
 				die("not a hexadecimal SHA1: %s", arg);
-			printf("%d\n", sha1_array_lookup(&array, sha1));
+			printf("%d\n", sha1_array_lookup(&array, oid.hash));
 		} else if (!strcmp(line.buf, "clear"))
 			sha1_array_clear(&array);
 		else if (!strcmp(line.buf, "for_each_unique"))
