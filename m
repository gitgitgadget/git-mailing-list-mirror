Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F1911F404
	for <e@80x24.org>; Mon, 19 Feb 2018 23:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932248AbeBSXBU (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Feb 2018 18:01:20 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33328 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932264AbeBSW7r (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Feb 2018 17:59:47 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B801C609E9;
        Mon, 19 Feb 2018 22:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1519081186;
        bh=x8CsBL3TuYohj1FJMa/9E1/jneefLs+pAPWUKjAy5WA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=t3jG+KP0wP/KS8V0JCjSfBzv8YCV+f43wFt9rY1OzTQjuFh7eLP+WIbdoADXIjuGD
         wtlFmTb3fmF6/rIeGbimpd6Grk/hgJrSmsylxWY1gSDkWz+p4hwGA0Mu9j+kC8rjVE
         e1r47NZWUW7o38xeHGt+MfycA0gm8m4D8VKh9BctBOJpGGhHURTazYjI9WzToSkUqf
         +Vp9kk7nuRZ0sGoqrLjRK0EccWH32vhAVIk6ooDJLJPjm/PfVUsC/xgiIsoAkyQNEt
         sHVmRonm6AMG31vY6KD2lRsyUMRlGMqTgHMpCeA4UPjhRBeBY6RRZ1XYthsDVUpGAA
         5v3asIRMfcp79VtMjdDt6SrNDxf8OqP7qnaHFOjtmfTfWAO6t+NNxV90pqcJr2xbxP
         VaqsjBq8718j6Ti10UrdnUqdyiKvXG7mrpr72K7dNe940HTSgaUAkdy1sjaby3ATi8
         xqMAIjxvljtouhWcswLYNI+jJ8Wq9OjZlR898baSm1zx1KSWpuq
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 12/36] send-pack: convert remaining functions to struct object_id
Date:   Mon, 19 Feb 2018 22:59:03 +0000
Message-Id: <20180219225927.386065-13-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132
In-Reply-To: <20180219225927.386065-1-sandals@crustytoothpaste.net>
References: <20180219225927.386065-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the remaining function, feed_object, to use struct object_id.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 send-pack.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index 8d9190f5e7..19025a7aca 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -37,14 +37,14 @@ int option_parse_push_signed(const struct option *opt,
 	die("bad %s argument: %s", opt->long_name, arg);
 }
 
-static void feed_object(const unsigned char *sha1, FILE *fh, int negative)
+static void feed_object(const struct object_id *oid, FILE *fh, int negative)
 {
-	if (negative && !has_sha1_file(sha1))
+	if (negative && !has_sha1_file(oid->hash))
 		return;
 
 	if (negative)
 		putc('^', fh);
-	fputs(sha1_to_hex(sha1), fh);
+	fputs(oid_to_hex(oid), fh);
 	putc('\n', fh);
 }
 
@@ -89,13 +89,13 @@ static int pack_objects(int fd, struct ref *refs, struct oid_array *extra, struc
 	 */
 	po_in = xfdopen(po.in, "w");
 	for (i = 0; i < extra->nr; i++)
-		feed_object(extra->oid[i].hash, po_in, 1);
+		feed_object(&extra->oid[i], po_in, 1);
 
 	while (refs) {
 		if (!is_null_oid(&refs->old_oid))
-			feed_object(refs->old_oid.hash, po_in, 1);
+			feed_object(&refs->old_oid, po_in, 1);
 		if (!is_null_oid(&refs->new_oid))
-			feed_object(refs->new_oid.hash, po_in, 0);
+			feed_object(&refs->new_oid, po_in, 0);
 		refs = refs->next;
 	}
 
