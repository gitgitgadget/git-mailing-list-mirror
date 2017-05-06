Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E532207F8
	for <e@80x24.org>; Sat,  6 May 2017 22:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755203AbdEFWNY (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 May 2017 18:13:24 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:37710 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754223AbdEFWL4 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 6 May 2017 18:11:56 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 530FE280B7;
        Sat,  6 May 2017 22:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1494108679;
        bh=+mAAAtoNz3kJb+IdmaThrululN03OrZ/eoN3fL3SVW8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cD7LZcDaANZ9zl2spWopv6rhqtHNr9dyLERMnE2Iy1usfGH/NQ740fcvVpWovYsNb
         emfUNCVuWFvfpgPEtSKLZ1R17Ll3hdzWdHlmT432S/aqE98XavmTd9KxZPdylGQP6i
         hsHT5rswNdIS27FZBfmZQ2WV3aJL1tFUShDPKm5atVxffek9+gtxdAsvtevGHlzQut
         zrPidGRJWi+oanX/esSieGS8a1EikTtbrcCdoQq2QIJo6ZJ98x+7HRGO8jPKLMQ74X
         VHm7IaR75U0uPxQbGo/afHAq+BXGq7/4imYbUAV+rEhP/Y9HwdD5h0xcXn8IZ96lDu
         hsGOvcSSNR8ikeezR/+1HCdxwxvA4pgncxk55kn88wq1sIaUhwdPs5G+lA/Hb5KwzH
         PUwITGixqACMLhs1LjM11qcZWTJJLVzWu/xVrC/WYgV+2Ba0Bje8APbi7vx0yyntLo
         8bhHcIBwIlUOnT8Uec9frVa83Ce64hNA8LPvmjVgvxRC8s0a/ay
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 49/53] builtin/ls-tree: convert to struct object_id
Date:   Sat,  6 May 2017 22:10:34 +0000
Message-Id: <20170506221038.296722-50-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.0.rc1.294.g07d810a77f
In-Reply-To: <20170506221038.296722-1-sandals@crustytoothpaste.net>
References: <20170506221038.296722-1-sandals@crustytoothpaste.net>
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
