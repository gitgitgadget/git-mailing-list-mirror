Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54E3E201A0
	for <e@80x24.org>; Mon,  3 Jul 2017 18:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753705AbdGCSz6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jul 2017 14:55:58 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:52956 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752114AbdGCSzs (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 3 Jul 2017 14:55:48 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 25405280AF;
        Mon,  3 Jul 2017 18:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1499108147;
        bh=nq7UXLQh4YbMPuwgym3LBHCconSL+bP0g75/Wl7sQbQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gG6bVyVAv+URuN76K7yfETBhuhksfcc0EFPx5jLPhhM8dy9dbkqd7uQRX5D6wJZN9
         N65BjIvHxZCmMcX24VEGb21o8pDfPFjmQfEwqjUNvBDy6dyhp7xOGNcXWbgqtqtVmH
         NyHDDvlL3cLgkeEdC+8isFTdEdKDakVlrqI/yTCsnkzrwjPne7Mxu5+FL36WsBF5iT
         l210z9FhKW2CE4/z71dPxS7XV3xfE7bB/hMqvVfQhJZy0wMix/xMyeRuGiSv5QVwsh
         WDsmoi4oA/x9USsR+MCRF2vlac1cnRGjuPoXcbpoZDJmFA2SgddN22krm6xdM8KsxV
         wcQ8PdDPvj95rs4skjhDgSs54Gjib5FTKIoY5wX22AD++UFVFn8gSMs1N1NN7d87k2
         S3bfwoOliAoGho2oaCGFogjdgLexl1l+UDQz+fijyWvq6iYF3cJgfT+3tZyuXltQ2X
         7vEi66BE0MHgbUH8QXL9lCgh5O64G4xzfjAb8ULlaZDNUvdm+zX
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH 02/12] builtin/merge-tree: convert remaining caller of get_sha1 to object_id
Date:   Mon,  3 Jul 2017 18:55:23 +0000
Message-Id: <20170703185533.51530-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.2.753.g7f5404b18
In-Reply-To: <20170703185533.51530-1-sandals@crustytoothpaste.net>
References: <20170703185533.51530-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/merge-tree.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index bad6735c7..f12da292c 100644
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
