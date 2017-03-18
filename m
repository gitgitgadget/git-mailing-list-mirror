Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 679E32095B
	for <e@80x24.org>; Sat, 18 Mar 2017 23:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751283AbdCRXPQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 19:15:16 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:46254 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751314AbdCRXPI (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 18 Mar 2017 19:15:08 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 323BF280B6;
        Sat, 18 Mar 2017 21:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1489872002;
        bh=DYmgBJmbnx7NbwcGLJ1LKLeV6v5XhubAhCvKAy2tNZk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BhUGPSn117C8hbb+8igeeHODa9kBN/LGbCsKEQj45Naw0nQZq3xfJRZ9tJIzmRqdi
         pF4aibr4T5aUQjP82ItoUpjBPVqBCIW5gjON1FBklRkxI8Ygt0FxYiCI9qhpbi5Uek
         2BPehv5kAjzjm44g18VOhSdgAjbuPn9Fuem8Q6X+PF9sqLTsLtaDLnz/3yyrZ8/Ym6
         gfrx8fQKdrvOeUjZ6kwF/Twp14ADhtlnFB7EmT1JcWGLZcmx2hHtEbL2STDup45/34
         L2IG22ju3WRVPjBgVbF2xof4irP55oNl+2OugAje3DalgtKn7zXJNCzs5OKkW5+Qb5
         MPjmb8CSzE9SwOHVmhOPoITFtBUDTSwrIZozXdIo8Lxf51ufkluXngOZQNyjI+cV+k
         PG7VAzhz6sCjDaQhAfQPwBlc0a/Tx/8hTqVSbkDj9uZTxLSdPEn0zZfmSA3TEGx9nk
         /gu3DVWXkqnAwElWGMuvoypsgY59BKEo7//1TejmMA+PPqr13Lf
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 09/20] test-sha1-array: convert most code to struct object_id
Date:   Sat, 18 Mar 2017 21:19:43 +0000
Message-Id: <20170318211954.564030-10-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170318211954.564030-1-sandals@crustytoothpaste.net>
References: <20170318211954.564030-1-sandals@crustytoothpaste.net>
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
