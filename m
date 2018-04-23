Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 374621F424
	for <e@80x24.org>; Mon, 23 Apr 2018 23:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932678AbeDWXmH (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 19:42:07 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60552 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932684AbeDWXkS (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 23 Apr 2018 19:40:18 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4041B6099D;
        Mon, 23 Apr 2018 23:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1524526817;
        bh=qKIgG64QG3/HN8ePJjAXAcXXi+hVNH0qbMOvtdjuWC0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Lsesf0Jx4EJfpcNtWpQ4Ray0FY0dbpthsUiAevcm8AcIY9TNhcKqsqU0eRn0GCmDf
         357FttMX+9ZPFoSceUUsoWwTF3ZqoV5P9LHBooz01QQyBWRg3icET//zjPKXq8Le7B
         tZdwljM5+xKPlYIE0mRi7UcxyT5kTT+saHu56v+sSyxlITi1Ixq7b9KqTaTadR0uI9
         F22KLhIe2UmIfROOgu6VUWJ1edSmp3pCxmDOua5ZY3P3S030dLLzuf0+jsPSC76rBG
         cEE04vKvR85ObQrZ1/6VwAoLdjA6eG0lqyAw1JQtgbfp1OhPm5XXtuBxVYwpnMcNBC
         VYeNDMOtTw1tksrIPfUpgnGcBcTmBJSyElZgfM7vpF9OFtWdLvu8uHPY1SjCVYqGGn
         qd7v6jJJBjIBNGS3UdLXdutgVpT5tWTPkIa5WaNm3l3m0SBdzy6v8qVDOwK2YI5TJn
         8G5MFX1C/d/s2/YXUzjcLRQAgy6GaskEifAi3QHyPZKxJ8YtRTb
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 12/41] tree-walk: convert get_tree_entry_follow_symlinks to object_id
Date:   Mon, 23 Apr 2018 23:39:22 +0000
Message-Id: <20180423233951.276447-13-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180423233951.276447-1-sandals@crustytoothpaste.net>
References: <20180423233951.276447-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since the only caller of this function already uses struct object_id,
update get_tree_entry_follow_symlinks to use it in parameters and
internally.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 sha1_name.c |  4 ++--
 tree-walk.c | 16 ++++++++--------
 tree-walk.h |  2 +-
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 7043652a24..7c2d08a202 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1685,8 +1685,8 @@ static int get_oid_with_context_1(const char *name,
 			if (new_filename)
 				filename = new_filename;
 			if (flags & GET_OID_FOLLOW_SYMLINKS) {
-				ret = get_tree_entry_follow_symlinks(tree_oid.hash,
-					filename, oid->hash, &oc->symlink_path,
+				ret = get_tree_entry_follow_symlinks(&tree_oid,
+					filename, oid, &oc->symlink_path,
 					&oc->mode);
 			} else {
 				ret = get_tree_entry(&tree_oid, filename, oid,
diff --git a/tree-walk.c b/tree-walk.c
index 27797c5406..8f5090862b 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -488,7 +488,7 @@ int traverse_trees(int n, struct tree_desc *t, struct traverse_info *info)
 struct dir_state {
 	void *tree;
 	unsigned long size;
-	unsigned char sha1[20];
+	struct object_id oid;
 };
 
 static int find_tree_entry(struct tree_desc *t, const char *name, struct object_id *result, unsigned *mode)
@@ -576,7 +576,7 @@ int get_tree_entry(const struct object_id *tree_oid, const char *name, struct ob
  * See the code for enum follow_symlink_result for a description of
  * the return values.
  */
-enum follow_symlinks_result get_tree_entry_follow_symlinks(unsigned char *tree_sha1, const char *name, unsigned char *result, struct strbuf *result_path, unsigned *mode)
+enum follow_symlinks_result get_tree_entry_follow_symlinks(struct object_id *tree_oid, const char *name, struct object_id *result, struct strbuf *result_path, unsigned *mode)
 {
 	int retval = MISSING_OBJECT;
 	struct dir_state *parents = NULL;
@@ -589,7 +589,7 @@ enum follow_symlinks_result get_tree_entry_follow_symlinks(unsigned char *tree_s
 
 	init_tree_desc(&t, NULL, 0UL);
 	strbuf_addstr(&namebuf, name);
-	hashcpy(current_tree_oid.hash, tree_sha1);
+	oidcpy(&current_tree_oid, tree_oid);
 
 	while (1) {
 		int find_result;
@@ -609,11 +609,11 @@ enum follow_symlinks_result get_tree_entry_follow_symlinks(unsigned char *tree_s
 			ALLOC_GROW(parents, parents_nr + 1, parents_alloc);
 			parents[parents_nr].tree = tree;
 			parents[parents_nr].size = size;
-			hashcpy(parents[parents_nr].sha1, root.hash);
+			oidcpy(&parents[parents_nr].oid, &root);
 			parents_nr++;
 
 			if (namebuf.buf[0] == '\0') {
-				hashcpy(result, root.hash);
+				oidcpy(result, &root);
 				retval = FOUND;
 				goto done;
 			}
@@ -663,7 +663,7 @@ enum follow_symlinks_result get_tree_entry_follow_symlinks(unsigned char *tree_s
 
 		/* We could end up here via a symlink to dir/.. */
 		if (namebuf.buf[0] == '\0') {
-			hashcpy(result, parents[parents_nr - 1].sha1);
+			oidcpy(result, &parents[parents_nr - 1].oid);
 			retval = FOUND;
 			goto done;
 		}
@@ -677,7 +677,7 @@ enum follow_symlinks_result get_tree_entry_follow_symlinks(unsigned char *tree_s
 
 		if (S_ISDIR(*mode)) {
 			if (!remainder) {
-				hashcpy(result, current_tree_oid.hash);
+				oidcpy(result, &current_tree_oid);
 				retval = FOUND;
 				goto done;
 			}
@@ -687,7 +687,7 @@ enum follow_symlinks_result get_tree_entry_follow_symlinks(unsigned char *tree_s
 				      1 + first_slash - namebuf.buf);
 		} else if (S_ISREG(*mode)) {
 			if (!remainder) {
-				hashcpy(result, current_tree_oid.hash);
+				oidcpy(result, &current_tree_oid);
 				retval = FOUND;
 			} else {
 				retval = NOT_DIR;
diff --git a/tree-walk.h b/tree-walk.h
index 4617deeb0e..805f58f00f 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -64,7 +64,7 @@ enum follow_symlinks_result {
 		       */
 };
 
-enum follow_symlinks_result get_tree_entry_follow_symlinks(unsigned char *tree_sha1, const char *name, unsigned char *result, struct strbuf *result_path, unsigned *mode);
+enum follow_symlinks_result get_tree_entry_follow_symlinks(struct object_id *tree_oid, const char *name, struct object_id *result, struct strbuf *result_path, unsigned *mode);
 
 struct traverse_info {
 	const char *traverse_path;
