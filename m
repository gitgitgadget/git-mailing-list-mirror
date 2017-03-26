Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0309E20958
	for <e@80x24.org>; Sun, 26 Mar 2017 16:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751521AbdCZQCF (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Mar 2017 12:02:05 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:58064 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751456AbdCZQCA (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 26 Mar 2017 12:02:00 -0400
Received: from genre.crustytoothpaste.net (unknown [172.16.2.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 4C531280B7;
        Sun, 26 Mar 2017 16:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1490544116;
        bh=DYmgBJmbnx7NbwcGLJ1LKLeV6v5XhubAhCvKAy2tNZk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l6mgUGDH8UH3UtZwqXvJCz0a/bVPQWNgc7zWTHr4FWkud49b6uJzzzDwxpQbh/gGa
         4WMhRuSj1sbtJUmhi00qxZ2cNv3RfJtRVvyR3Pfj4YjZVB2Bct9kagkb6E0ZgpURSR
         pTmlJH//3Dbgj1IPb1RSI4B+WKJSDTgFkHeDuLOPqX9kjyfNsAfzFlCj8o0dvEycLk
         fjJUP6rd3OxNJfDpW+o8bRef7vUyJQsHCFgFV+wQTkb43HStBPJRCDUMy+QESRLlne
         3y6pVZOn4KBLKAXaAg6Y3XyOibF0f17hgPcQa9J+BR7Go+ryfj/4sFL/Kq5aUWbSXj
         +esV+shZ0DA6djFRm5nveqn8RVyMCVB+TWSo2HlKECqBRqARRR1Ku+GHu104I/FvJT
         K8G5SHtru7UqXwFo0T7dT8xEaP3/2tng0aofOrujVf4v5dIILn1z6tBxkfiMYXCcYF
         R2qaC/HTSGjfdv21zXpkUAk5WOauTylSeTDZGstirE+CQNADxof
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 10/21] test-sha1-array: convert most code to struct object_id
Date:   Sun, 26 Mar 2017 16:01:32 +0000
Message-Id: <20170326160143.769630-11-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170326160143.769630-1-sandals@crustytoothpaste.net>
References: <20170326160143.769630-1-sandals@crustytoothpaste.net>
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
