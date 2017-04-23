Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A409207BD
	for <e@80x24.org>; Sun, 23 Apr 2017 21:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1046284AbdDWViL (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Apr 2017 17:38:11 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:37408 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1046187AbdDWVg3 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 23 Apr 2017 17:36:29 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 2510D280DE;
        Sun, 23 Apr 2017 21:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1492983343;
        bh=+mAAAtoNz3kJb+IdmaThrululN03OrZ/eoN3fL3SVW8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wKkExddDsXrT/P1d6kDQUwML0lRFcRpd0DkdqrU9ldNUWNuj1GlLvhNUfUeMsAMIF
         0Vr2pc5soUuKC1Mx2UjkB+8YouQPGl72dMbJNNkRNrnAW08c2zDPn49RpSJ4twO+1+
         yQQB9MFH0akGueSWPYmbbjNB3ZHDDQL7rBJZa1w32Md+ZuAWfLVHNbVekoObzTAuZx
         E/vNwTdGTGvCaaGY+oIKRFiTqLOmxb1BwPzgI6Wt6DJ4SIk57yzNE6VVoNfF0djUd2
         CrFobaXCt/oRZTIGYpUZxamxET5mtdNi7KuI0r1uhTetNay40TuHBtTZ6Y8FB0VN3m
         BGWHNr0dA3k1yj81hccftD1YrgHfY37DD4Dk8+nJXmWIRxFHrNdQyelXbuxfk+ES3z
         lbC69SAqZmkTgaG5ut2tfujSi0F5ufqwc7oFFCri6BUR7WnTluUyrJwMprqdXFwqFJ
         4Xow8betDGa1zL4z7KYaj6Cz38cHo8BaMj9l7D8mtusioHkkqO6
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 49/53] builtin/ls-tree: convert to struct object_id
Date:   Sun, 23 Apr 2017 21:34:49 +0000
Message-Id: <20170423213453.253425-50-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.12.2.762.g0e3151a226
In-Reply-To: <20170423213453.253425-1-sandals@crustytoothpaste.net>
References: <20170423213453.253425-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a prerequisite to convert do_diff_cache, which is required to
convert parse_tree_indirect.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/ls-tree.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index d7ebeb4ce..5baac3ef2 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -119,7 +119,7 @@ static int show_tree(const unsigned char *sha1, struct strbuf *base,
 
 int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 {
-	unsigned char sha1[20];
+	struct object_id oid;
 	struct tree *tree;
 	int i, full_tree = 0;
 	const struct option ls_tree_options[] = {
@@ -164,7 +164,7 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 
 	if (argc < 1)
 		usage_with_options(ls_tree_usage, ls_tree_options);
-	if (get_sha1(argv[0], sha1))
+	if (get_oid(argv[0], &oid))
 		die("Not a valid object name %s", argv[0]);
 
 	/*
@@ -180,7 +180,7 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	for (i = 0; i < pathspec.nr; i++)
 		pathspec.items[i].nowildcard_len = pathspec.items[i].len;
 	pathspec.has_wildcard = 0;
-	tree = parse_tree_indirect(sha1);
+	tree = parse_tree_indirect(oid.hash);
 	if (!tree)
 		die("not a tree object");
 	return !!read_tree_recursive(tree, "", 0, 0, &pathspec, show_tree, NULL);
