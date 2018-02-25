Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 000F71F404
	for <e@80x24.org>; Sun, 25 Feb 2018 21:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751925AbeBYVMk (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Feb 2018 16:12:40 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33888 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751923AbeBYVMi (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 25 Feb 2018 16:12:38 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A204460E53;
        Sun, 25 Feb 2018 21:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1519593157;
        bh=7cnOo4Vi2m/3V9BImHHTPZy38YkTcyakA/iQqVhwSag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=VRdBjWgiCYO2vigh+uPt3ME69lnh79iMRu0jh+7i2eUbhnoA+XyFH2HhojFyz90Fs
         AwAgjiiZRXAwTnI0nK8tetyca/6ud6lN9stvajNrxzoiQ8r+s2B5xmlaMYrlFqMTOK
         Owpv/HZ2SXtXxTPDdANSShGoYZDOZc3IInP/a8ekatCRwm/HbsrGiakoFHbO1aHPiz
         rIEuVlY51JokDttv2YfiizanpjXpYlf5LCeGKONefR8+9MXOyNwBE3z8YDOZMSfYBT
         DS9BqecAsEbNKY/43EDnuUDe0OLL2WrzVKo0I0vD2ydrAbeefD9x1FrNIcaouBGCbX
         SYFkcIccY/JP0sSFct2AKWBE9n35Z2vhK5qL+qIGFrj+zV+PsZQVrucilRw0NnYAFw
         k1DdD03RvPmWY2z7K2RwQ8HS5U0nH8CJuLMCAJQ8Pk7hreTd5mUZgFoBhpDUFfMxk/
         l26y93Ye8zhcW6sGqkSbJIJlrRWJFag5de4ndk9BrDe7uoX4u1F
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 12/36] send-pack: convert remaining functions to struct object_id
Date:   Sun, 25 Feb 2018 21:11:48 +0000
Message-Id: <20180225211212.477570-13-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.2.395.g2e18187dfd
In-Reply-To: <20180225211212.477570-1-sandals@crustytoothpaste.net>
References: <20180225211212.477570-1-sandals@crustytoothpaste.net>
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
index 2112d3b27a..7350af8883 100644
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
 
