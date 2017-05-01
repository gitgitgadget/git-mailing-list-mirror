Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4F401F829
	for <e@80x24.org>; Mon,  1 May 2017 02:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1035519AbdEACcq (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Apr 2017 22:32:46 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:36062 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2999571AbdEACbf (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 30 Apr 2017 22:31:35 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 68C8E280DF;
        Mon,  1 May 2017 02:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1493605816;
        bh=+mAAAtoNz3kJb+IdmaThrululN03OrZ/eoN3fL3SVW8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HaAA5wy+osK+wHyqWrv49tZ4tZAhWhCzdo/do9ZM5coLBbujvWHMd/QvgTKVXY9SA
         4KdM3fn4G1BCvMYj5KV2aAMQQNUXF1fwz+WC2cJvcNAoTdEj5EL2YpQEA5FBL3wDPg
         DtTCpB2NkLm0uxjrmE2YY4JMYJDRLmgmHqInqbkNPiCXZNUkJmjNzdK889z/VWez3H
         5jUyY+pLlpWCgy4G7F6ZduMs9zMiamQp6Cz9EshFT4RxpWXNWhhpr7RfVGde49+Ra4
         wTeLQyQy977L2iBxY7tUdpT7uzOEGibTeY5RXaL4V9wRNfwYxKz+pkewQe4sOpeGAy
         QWOt1YUUPr62l3IbB8L+dazIIwVEwJEKt48CfIMcZOf1a5R4JXm0hFdt2azvYdBACy
         S9zWJx4jOZggqvBAw5LShUn14zTmy6mUOAqv69FzZ0aQVSg1E2B2p8GfUzobyWJ/wK
         pkeHD6gk6i+iUrffxfvxpb0G6V2Bih+8eygEDkwVdkzm7LAWAY+
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 49/53] builtin/ls-tree: convert to struct object_id
Date:   Mon,  1 May 2017 02:29:42 +0000
Message-Id: <20170501022946.258735-50-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.0.rc0.306.g87b477812d
In-Reply-To: <20170501022946.258735-1-sandals@crustytoothpaste.net>
References: <20170501022946.258735-1-sandals@crustytoothpaste.net>
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
