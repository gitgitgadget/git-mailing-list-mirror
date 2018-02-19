Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB63F1F404
	for <e@80x24.org>; Mon, 19 Feb 2018 23:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932350AbeBSXBa (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Feb 2018 18:01:30 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33298 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932223AbeBSW7i (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Feb 2018 17:59:38 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3D521609DB;
        Mon, 19 Feb 2018 22:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1519081177;
        bh=yPanls0eoYg/enOBpT0eIKnDj5qMZSoKxoTkbwl+5NA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=KWY3HNz63DfKgTIBDEjmp+o+r4FXyNKpuA5fBLTXm63CYQ/g1C73RqUjnbtrUNWmr
         Sb7n6RXnSdrTIHfzyeKamGHFGDFnL5pICJIuxwVgLcXF9k7neL//ytIEm0qm9QeyxM
         lCSwmX3wD6jrmDxBa8ykFVwYtNPs82uD7QnHILnN27uw63N1o/md9rFoaaLKXccZ6G
         FDuQN0GV+HaDSyEk+6jkEj5sZHfrzhEP0U1rGoq2kYBZLpDdpJXU6BullRK2ckASod
         qswG+1qVSHFmhXtkiFw36kOdHTofbFvcu8jpohqFx0HUD/jWww+u6yudRlvop5HUZG
         j6OQ0YAnwIbV3bi00ijLb1dQQtI+t5ltdUUOdCNdAWfUiNAdCZm19f4DTom0CGtl3/
         hzwBApeafkZc8FSPEHeZtEbndv/Uj9U55BFxMYEKW6BEW8QoatG8cxr4+tue4lZuKn
         f0M1a3XR3+cyL668VzIHBJjOKmBWpBTCBr2VN03mBks2JrDI5GR
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 04/36] cache-tree: convert remnants to struct object_id
Date:   Mon, 19 Feb 2018 22:58:55 +0000
Message-Id: <20180219225927.386065-5-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132
In-Reply-To: <20180219225927.386065-1-sandals@crustytoothpaste.net>
References: <20180219225927.386065-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the remaining portions of cache-tree.c to use struct object_id.
Convert several instances of 20 to use the_hash_algo instead.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 cache-tree.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index ba07a8067e..601dd1bb1f 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -320,7 +320,7 @@ static int update_one(struct cache_tree *it,
 		struct cache_tree_sub *sub = NULL;
 		const char *path, *slash;
 		int pathlen, entlen;
-		const unsigned char *sha1;
+		const struct object_id *oid;
 		unsigned mode;
 		int expected_missing = 0;
 		int contains_ita = 0;
@@ -338,7 +338,7 @@ static int update_one(struct cache_tree *it,
 				die("cache-tree.c: '%.*s' in '%s' not found",
 				    entlen, path + baselen, path);
 			i += sub->count;
-			sha1 = sub->cache_tree->oid.hash;
+			oid = &sub->cache_tree->oid;
 			mode = S_IFDIR;
 			contains_ita = sub->cache_tree->entry_count < 0;
 			if (contains_ita) {
@@ -347,19 +347,19 @@ static int update_one(struct cache_tree *it,
 			}
 		}
 		else {
-			sha1 = ce->oid.hash;
+			oid = &ce->oid;
 			mode = ce->ce_mode;
 			entlen = pathlen - baselen;
 			i++;
 		}
 
-		if (is_null_sha1(sha1) ||
-		    (mode != S_IFGITLINK && !missing_ok && !has_sha1_file(sha1))) {
+		if (is_null_oid(oid) ||
+		    (mode != S_IFGITLINK && !missing_ok && !has_object_file(oid))) {
 			strbuf_release(&buffer);
 			if (expected_missing)
 				return -1;
 			return error("invalid object %06o %s for '%.*s'",
-				mode, sha1_to_hex(sha1), entlen+baselen, path);
+				mode, oid_to_hex(oid), entlen+baselen, path);
 		}
 
 		/*
@@ -385,12 +385,12 @@ static int update_one(struct cache_tree *it,
 		/*
 		 * "sub" can be an empty tree if all subentries are i-t-a.
 		 */
-		if (contains_ita && !hashcmp(sha1, EMPTY_TREE_SHA1_BIN))
+		if (contains_ita && !oidcmp(oid, &empty_tree_oid))
 			continue;
 
 		strbuf_grow(&buffer, entlen + 100);
 		strbuf_addf(&buffer, "%o %.*s%c", mode, entlen, path + baselen, '\0');
-		strbuf_add(&buffer, sha1, 20);
+		strbuf_add(&buffer, oid->hash, the_hash_algo->rawsz);
 
 #if DEBUG
 		fprintf(stderr, "cache-tree update-one %o %.*s\n",
@@ -401,7 +401,7 @@ static int update_one(struct cache_tree *it,
 	if (repair) {
 		struct object_id oid;
 		hash_object_file(buffer.buf, buffer.len, tree_type, &oid);
-		if (has_sha1_file(oid.hash))
+		if (has_object_file(&oid))
 			oidcpy(&it->oid, &oid);
 		else
 			to_invalidate = 1;
@@ -465,7 +465,7 @@ static void write_one(struct strbuf *buffer, struct cache_tree *it,
 #endif
 
 	if (0 <= it->entry_count) {
-		strbuf_add(buffer, it->oid.hash, 20);
+		strbuf_add(buffer, it->oid.hash, the_hash_algo->rawsz);
 	}
 	for (i = 0; i < it->subtree_nr; i++) {
 		struct cache_tree_sub *down = it->down[i];
@@ -520,11 +520,11 @@ static struct cache_tree *read_one(const char **buffer, unsigned long *size_p)
 		goto free_return;
 	buf++; size--;
 	if (0 <= it->entry_count) {
-		if (size < 20)
+		if (size < the_hash_algo->rawsz)
 			goto free_return;
 		hashcpy(it->oid.hash, (const unsigned char*)buf);
-		buf += 20;
-		size -= 20;
+		buf += the_hash_algo->rawsz;
+		size -= the_hash_algo->rawsz;
 	}
 
 #if DEBUG
