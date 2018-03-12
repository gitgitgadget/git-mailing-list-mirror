Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A982B1F404
	for <e@80x24.org>; Mon, 12 Mar 2018 02:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932569AbeCLC37 (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Mar 2018 22:29:59 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34266 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932426AbeCLC2Q (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 11 Mar 2018 22:28:16 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5014860479;
        Mon, 12 Mar 2018 02:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1520821695;
        bh=l/ZjgfmEdPH63a5+PxoJes0WtiPfGGj7/5IEnIzZS/Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=GbaL2VT9aaHvrAXUBkHh8TmXzlPInr0eYjNpF3iPq9TWWykBakMXPEmtSV/qdABqq
         /G0wrC8ntZsz2JVHs+gHaACzflD3ZeU2JSuVqgiwtQZYVHmOQemVlFa3ZnfxYUbJVl
         YwaE/mI2HwEBAEhJ2Fi8gK802jbOVW5YSWK43ybzbM8rhl22ewsGsCITYjAyzv2t4o
         7jxUuWLkilgzP5Z6xApbyEFEY+yIwCMjbjJK0sWKQoIQ4LR+3vEYIzEgcZyEAh7PkD
         dmGJUS5u0fXBdN6iJXYe/CfTZUIZT74JWSKW7gkawiHWqf+penc/kLNGQSjtAB9ExQ
         Dl0eCDCMUDTRtS4bR9EnHAsS/CjnjYLGPDL0MJFL+/C4XG3ajKJ2hokL+kiFk0aecq
         2XcQhr5EpZGLiQY0gxcKjzxHSkuawLMbzdasduPoNmQNw22zwZ0wTQSUbJO8n+9vOL
         J7gEfYiKLi0CYrXNnYfsTGNcDSRY3nHDcaiEoHD53e3s0TOqeOQ
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 02/36] builtin/write-tree: convert to struct object_id
Date:   Mon, 12 Mar 2018 02:27:22 +0000
Message-Id: <20180312022756.483934-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.2.660.g709887971b
In-Reply-To: <20180312022756.483934-1-sandals@crustytoothpaste.net>
References: <20180312022756.483934-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is needed to convert parts of the cache-tree code.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/write-tree.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/write-tree.c b/builtin/write-tree.c
index bd0a78aa3c..299a121531 100644
--- a/builtin/write-tree.c
+++ b/builtin/write-tree.c
@@ -19,7 +19,7 @@ int cmd_write_tree(int argc, const char **argv, const char *unused_prefix)
 {
 	int flags = 0, ret;
 	const char *prefix = NULL;
-	unsigned char sha1[20];
+	struct object_id oid;
 	const char *me = "git-write-tree";
 	struct option write_tree_options[] = {
 		OPT_BIT(0, "missing-ok", &flags, N_("allow missing objects"),
@@ -38,10 +38,10 @@ int cmd_write_tree(int argc, const char **argv, const char *unused_prefix)
 	argc = parse_options(argc, argv, unused_prefix, write_tree_options,
 			     write_tree_usage, 0);
 
-	ret = write_cache_as_tree(sha1, flags, prefix);
+	ret = write_cache_as_tree(oid.hash, flags, prefix);
 	switch (ret) {
 	case 0:
-		printf("%s\n", sha1_to_hex(sha1));
+		printf("%s\n", oid_to_hex(&oid));
 		break;
 	case WRITE_TREE_UNREADABLE_INDEX:
 		die("%s: error reading the index", me);
