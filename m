Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B24F1F404
	for <e@80x24.org>; Mon, 19 Feb 2018 23:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932274AbeBSW7t (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Feb 2018 17:59:49 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33306 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932251AbeBSW7k (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Feb 2018 17:59:40 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id EE239609DD;
        Mon, 19 Feb 2018 22:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1519081179;
        bh=p15uJpq/NkGbNLkh4n1gMt6Am2KDO4G8ayB+6ErTLH8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=NnZy5hOWc53WdMwt7z/CPeczJCCL4OBPENIGgg/qAQWGy96kgGe/w3N5nQTdAqZHl
         gREA8rUzDRMY0Ng8gl913L1SsCvw21VCjQ/4ip7ky1IZmF4262HlL2cnkfNHkrI+OC
         zG87eF1fu9VbipStazG/TNfH5aamjREr+mR6dobzBL9D5LN4yizYwz3A5t2+fVtTns
         lKG6bTCnm9/G+wOoXXfOw6CXYMx41y7S+WEQhyfd6UbFmRiio/r4b/ZJsEQWDQU2ZG
         vBeS+YWBdHGSqDaRYA69HdFTvB8UBf3weYmlZOITbFCU2+J9rDxs4KExFu0HEZjEst
         eGrYXC6NaVezqRiRcbOHQ+f4icDgbeIQjfDE/ELkivq/y3AJDyTuP3ud8hjatFxA8M
         NoiiszEpo0WwSBLowh1f5HMcoBc14GhBR+ttoBM4YrsjjVrFOqn/hJa57rAK+pf/1B
         sCCZ9m1ECmqDIUWQNRV5tgxbT1CTJ/b2BW8Prso9olg1tksB2Xe
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 06/36] tree: convert read_tree_recursive to struct object_id
Date:   Mon, 19 Feb 2018 22:58:57 +0000
Message-Id: <20180219225927.386065-7-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132
In-Reply-To: <20180219225927.386065-1-sandals@crustytoothpaste.net>
References: <20180219225927.386065-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the callback functions for read_tree_recursive to take a pointer
to struct object_id.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 archive.c          |  8 ++++----
 builtin/checkout.c |  4 ++--
 builtin/log.c      |  2 +-
 builtin/ls-tree.c  |  8 ++++----
 merge-recursive.c  |  2 +-
 tree.c             | 14 +++++++-------
 tree.h             |  2 +-
 7 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/archive.c b/archive.c
index 0b7b62af0c..e664cdb624 100644
--- a/archive.c
+++ b/archive.c
@@ -198,7 +198,7 @@ static int write_directory(struct archiver_context *c)
 	return ret ? -1 : 0;
 }
 
-static int queue_or_write_archive_entry(const unsigned char *sha1,
+static int queue_or_write_archive_entry(const struct object_id *oid,
 		struct strbuf *base, const char *filename,
 		unsigned mode, int stage, void *context)
 {
@@ -224,14 +224,14 @@ static int queue_or_write_archive_entry(const unsigned char *sha1,
 
 		if (check_attr_export_ignore(check))
 			return 0;
-		queue_directory(sha1, base, filename,
+		queue_directory(oid->hash, base, filename,
 				mode, stage, c);
 		return READ_TREE_RECURSIVE;
 	}
 
 	if (write_directory(c))
 		return -1;
-	return write_archive_entry(sha1, base->buf, base->len, filename, mode,
+	return write_archive_entry(oid->hash, base->buf, base->len, filename, mode,
 				   stage, context);
 }
 
@@ -303,7 +303,7 @@ static const struct archiver *lookup_archiver(const char *name)
 	return NULL;
 }
 
-static int reject_entry(const unsigned char *sha1, struct strbuf *base,
+static int reject_entry(const struct object_id *oid, struct strbuf *base,
 			const char *filename, unsigned mode,
 			int stage, void *context)
 {
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 191b96c49c..87182aa018 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -66,7 +66,7 @@ static int post_checkout_hook(struct commit *old, struct commit *new,
 
 }
 
-static int update_some(const unsigned char *sha1, struct strbuf *base,
+static int update_some(const struct object_id *oid, struct strbuf *base,
 		const char *pathname, unsigned mode, int stage, void *context)
 {
 	int len;
@@ -78,7 +78,7 @@ static int update_some(const unsigned char *sha1, struct strbuf *base,
 
 	len = base->len + strlen(pathname);
 	ce = xcalloc(1, cache_entry_size(len));
-	hashcpy(ce->oid.hash, sha1);
+	oidcpy(&ce->oid, oid);
 	memcpy(ce->name, base->buf, base->len);
 	memcpy(ce->name + base->len, pathname, len - base->len);
 	ce->ce_flags = create_ce_flags(0) | CE_UPDATE;
diff --git a/builtin/log.c b/builtin/log.c
index 94ee177d56..32a744bfd2 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -541,7 +541,7 @@ static int show_tag_object(const struct object_id *oid, struct rev_info *rev)
 	return 0;
 }
 
-static int show_tree_object(const unsigned char *sha1,
+static int show_tree_object(const struct object_id *oid,
 		struct strbuf *base,
 		const char *pathname, unsigned mode, int stage, void *context)
 {
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index ef965408e8..c613dd7b82 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -60,7 +60,7 @@ static int show_recursive(const char *base, int baselen, const char *pathname)
 	return 0;
 }
 
-static int show_tree(const unsigned char *sha1, struct strbuf *base,
+static int show_tree(const struct object_id *oid, struct strbuf *base,
 		const char *pathname, unsigned mode, int stage, void *context)
 {
 	int retval = 0;
@@ -94,7 +94,7 @@ static int show_tree(const unsigned char *sha1, struct strbuf *base,
 			char size_text[24];
 			if (!strcmp(type, blob_type)) {
 				unsigned long size;
-				if (sha1_object_info(sha1, &size) == OBJ_BAD)
+				if (sha1_object_info(oid->hash, &size) == OBJ_BAD)
 					xsnprintf(size_text, sizeof(size_text),
 						  "BAD");
 				else
@@ -103,11 +103,11 @@ static int show_tree(const unsigned char *sha1, struct strbuf *base,
 			} else
 				xsnprintf(size_text, sizeof(size_text), "-");
 			printf("%06o %s %s %7s\t", mode, type,
-			       find_unique_abbrev(sha1, abbrev),
+			       find_unique_abbrev(oid->hash, abbrev),
 			       size_text);
 		} else
 			printf("%06o %s %s\t", mode, type,
-			       find_unique_abbrev(sha1, abbrev));
+			       find_unique_abbrev(oid->hash, abbrev));
 	}
 	baselen = base->len;
 	strbuf_addstr(base, pathname);
diff --git a/merge-recursive.c b/merge-recursive.c
index 6ff971f9a2..c886f2e9cd 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -335,7 +335,7 @@ struct tree *write_tree_from_memory(struct merge_options *o)
 	return result;
 }
 
-static int save_files_dirs(const unsigned char *sha1,
+static int save_files_dirs(const struct object_id *oid,
 		struct strbuf *base, const char *path,
 		unsigned int mode, int stage, void *context)
 {
diff --git a/tree.c b/tree.c
index b224115e0f..1a0f03f520 100644
--- a/tree.c
+++ b/tree.c
@@ -10,7 +10,7 @@
 const char *tree_type = "tree";
 
 static int read_one_entry_opt(struct index_state *istate,
-			      const unsigned char *sha1,
+			      const struct object_id *oid,
 			      const char *base, int baselen,
 			      const char *pathname,
 			      unsigned mode, int stage, int opt)
@@ -31,16 +31,16 @@ static int read_one_entry_opt(struct index_state *istate,
 	ce->ce_namelen = baselen + len;
 	memcpy(ce->name, base, baselen);
 	memcpy(ce->name + baselen, pathname, len+1);
-	hashcpy(ce->oid.hash, sha1);
+	oidcpy(&ce->oid, oid);
 	return add_index_entry(istate, ce, opt);
 }
 
-static int read_one_entry(const unsigned char *sha1, struct strbuf *base,
+static int read_one_entry(const struct object_id *oid, struct strbuf *base,
 			  const char *pathname, unsigned mode, int stage,
 			  void *context)
 {
 	struct index_state *istate = context;
-	return read_one_entry_opt(istate, sha1, base->buf, base->len, pathname,
+	return read_one_entry_opt(istate, oid, base->buf, base->len, pathname,
 				  mode, stage,
 				  ADD_CACHE_OK_TO_ADD|ADD_CACHE_SKIP_DFCHECK);
 }
@@ -49,12 +49,12 @@ static int read_one_entry(const unsigned char *sha1, struct strbuf *base,
  * This is used when the caller knows there is no existing entries at
  * the stage that will conflict with the entry being added.
  */
-static int read_one_entry_quick(const unsigned char *sha1, struct strbuf *base,
+static int read_one_entry_quick(const struct object_id *oid, struct strbuf *base,
 				const char *pathname, unsigned mode, int stage,
 				void *context)
 {
 	struct index_state *istate = context;
-	return read_one_entry_opt(istate, sha1, base->buf, base->len, pathname,
+	return read_one_entry_opt(istate, oid, base->buf, base->len, pathname,
 				  mode, stage,
 				  ADD_CACHE_JUST_APPEND);
 }
@@ -83,7 +83,7 @@ static int read_tree_1(struct tree *tree, struct strbuf *base,
 				continue;
 		}
 
-		switch (fn(entry.oid->hash, base,
+		switch (fn(entry.oid, base,
 			   entry.path, entry.mode, stage, context)) {
 		case 0:
 			continue;
diff --git a/tree.h b/tree.h
index 744e6dc2ac..e2a80be4ef 100644
--- a/tree.h
+++ b/tree.h
@@ -27,7 +27,7 @@ void free_tree_buffer(struct tree *tree);
 struct tree *parse_tree_indirect(const struct object_id *oid);
 
 #define READ_TREE_RECURSIVE 1
-typedef int (*read_tree_fn_t)(const unsigned char *, struct strbuf *, const char *, unsigned int, int, void *);
+typedef int (*read_tree_fn_t)(const struct object_id *, struct strbuf *, const char *, unsigned int, int, void *);
 
 extern int read_tree_recursive(struct tree *tree,
 			       const char *base, int baselen,
