Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9661F20365
	for <e@80x24.org>; Thu, 13 Jul 2017 23:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752941AbdGMXti (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 19:49:38 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:59670 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752801AbdGMXtf (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 13 Jul 2017 19:49:35 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 4A610280AF;
        Thu, 13 Jul 2017 23:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1499989774;
        bh=Fl49lY/Ag5NXLT57rIH0Ixth5gdsxAQjAFzKgBT9IME=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mtYqS5e+io85vFqP69eWhxSc0GTWzRp+eWiQGNmBTXMEeIBesYp9lra21Nt+slyEy
         M+Ca9HHOVwCnsaZVPvvXcNEuubGTnGZ9O+LFNm27RTOiyxvxDhhiWQPKNVEY1jn+ay
         +alfBEnvr4ftloseXqc3fWEkoyLpwwlmrbIrQk054uypNWQy7Ale+I8kLLcqQk1bqv
         H5h9uVZW32hBSB3Wh9PKxDnJBnXt6/UXodFgOtk+jEZA3Vj2ye7SKd5+HuFOl7xGWn
         BsITR3/9In041xgcXcDZIDtthhQgfGJpZ2Jq3AEMRvaFNHOYQhluVy6NcJ3NQlK503
         Ua9xf+03yrY7utJa6MZYD8Cp1kJ8n0ugxUix/p6KTyU80icf+/1ej0uDWArMeJrY+7
         Osy1Mu+51o53xMV1HnUtOPjEID7xTew2f0BrxMrMMdKiKBKN+wMjXTnuVf2Y5pK0AK
         tS2RlHTlcTw0+zfdAUeG2VohqsiRxsCb1gB4KqnhIkjfsmIVUIN
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2 02/13] builtin/merge-tree: convert remaining caller of get_sha1 to object_id
Date:   Thu, 13 Jul 2017 23:49:19 +0000
Message-Id: <20170713234930.949612-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.2.932.g7449e964c
In-Reply-To: <20170713234930.949612-1-sandals@crustytoothpaste.net>
References: <20170713234930.949612-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/merge-tree.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index bad6735c76..f12da292cf 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -347,12 +347,12 @@ static void merge_trees(struct tree_desc t[3], const char *base)
 
 static void *get_tree_descriptor(struct tree_desc *desc, const char *rev)
 {
-	unsigned char sha1[20];
+	struct object_id oid;
 	void *buf;
 
-	if (get_sha1(rev, sha1))
+	if (get_oid(rev, &oid))
 		die("unknown rev %s", rev);
-	buf = fill_tree_descriptor(desc, sha1);
+	buf = fill_tree_descriptor(desc, oid.hash);
 	if (!buf)
 		die("%s is not a tree", rev);
 	return buf;
