Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BF061F404
	for <e@80x24.org>; Mon, 12 Mar 2018 02:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932672AbeCLC3i (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Mar 2018 22:29:38 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34348 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932516AbeCLC21 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 11 Mar 2018 22:28:27 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id EF47760B1A;
        Mon, 12 Mar 2018 02:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1520821706;
        bh=x8CsBL3TuYohj1FJMa/9E1/jneefLs+pAPWUKjAy5WA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=U3wA/B+YSwM+PXOmsLt7nMdlMg2DxREdfYnWo7yzmKIsQtgmiacrecIOda+WJdcie
         NO5dmX88G8Tc3hF7GYQGiTx3m4Nv/b9o1DQ97KLHjZTfb2URl7vo0rjuQqG4xDOygK
         ly1oRZ9AQsNSB95PjRvKcomQAw4GAeAHdR1lcA6H0LLBY4C+ZQJIU01KMDURVZ+v3c
         vms5DQJIkjXb5qpsZuW2uAurccvp4GnX7DPE7ZpUUjwK69EqKaNXtPJLNod71IS620
         fan7BoC/ol4G//Z3wS/vlyWHe4ZetghCIv1+f39Qa19KdV54px/teLH4JNVLPOBAN8
         Dv3aqNGnh2VvpqqqWu1sPS/xDbWaISpLRCrcFwKhusVqFiYcbPs5at3yHZPh+9iXTo
         7Jb49a05hy1tQFRqIIEtfg42OQIG2CtCYh2Y1x0YoSPm6pJhYp/rdtixEr+ZbPd4XR
         +qLAZulOYb0vGwr7HKFv2PE9WVUH67Yqu4RxMyvS6XNefYUI3Q0
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 12/36] send-pack: convert remaining functions to struct object_id
Date:   Mon, 12 Mar 2018 02:27:32 +0000
Message-Id: <20180312022756.483934-13-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.2.660.g709887971b
In-Reply-To: <20180312022756.483934-1-sandals@crustytoothpaste.net>
References: <20180312022756.483934-1-sandals@crustytoothpaste.net>
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
 
