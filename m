Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A80E31F404
	for <e@80x24.org>; Sun, 28 Jan 2018 00:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752904AbeA1ANe (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Jan 2018 19:13:34 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:44119 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751839AbeA1ANa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Jan 2018 19:13:30 -0500
Received: by mail-lf0-f68.google.com with SMTP id v188so5003904lfa.11
        for <git@vger.kernel.org>; Sat, 27 Jan 2018 16:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
         :references;
        bh=HUzP2sBmeSNkYXjOH7wosMpFnGhtQtbDHoRHdlpnC9A=;
        b=nd14Ung7+2yN0DTcQ5UTPYRiKemVsvAoyz2q6rmrDopj5MRB8cY2YT+7gc9+g9xirO
         5gOEUjT5hemgFOKmGxX46HzZ+/7VjfchVxsebMooB0XH7aNvEuk9mGh69EXX3apMxG4w
         3kd39FtM6TdlC90G1s4MkNgDt5iGN2zGeaXZkzzmBdZ70b7nZt1A5nnO3gQQwFHGN7Un
         a3PFJNB15+qFCyW0cHlujE8CIPQxJxUK8w+HslFDHXpl3EHZ0uBxHAp0SfAUsZxl6Gtv
         Sx2ZnW7JrpV9nBA7YbPjPJK41mwGE1q9EbAmkaP0o2kkFynAatgEuxyQHFmllysO+cLA
         Gxqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=HUzP2sBmeSNkYXjOH7wosMpFnGhtQtbDHoRHdlpnC9A=;
        b=MGuELypc3cu0R8WQG0qQT/Wf8S5/If7gba+Cu7Rn+5WC5SDOmRfRMMf2Hx8ZeiBo3m
         EsMnJWBFdCP/f72Gp5rGXa+rKFkHXambYnIh0L77vFgmU/ijNZTZ2qmVY49URinQB4s/
         75cb/p9MMzYjsVvWQvna7oQ0eQFnBh8QgGelwp/7qU2sNZeP7D+HyKfLNl2BHC5a75Mj
         ljU5DxDtRnfneTilasHuF6XOYPS8FqtUBoiD3DpDp/e3BfwhVqnBTArMnhPO/54klgu2
         EDPj5ojo0EW2uuCPBO3kj6S1ukg5vYZUoRk9UISzQxatzOrgjqsO9dMC9fyV7aTp1cid
         oWPg==
X-Gm-Message-State: AKwxytfbXk259nQXQnj2IYja2CQo7pbmx0S4+xTF1sMCSZmCKQdxGDuv
        zYYwISJln2YBu/Jl+orOyz/lurYi
X-Google-Smtp-Source: AH8x224MJGTRio5Zk03MbRtfm5eHBjviyDT+60kuXifmewkmyyvlkIf9O//wmskvpipSNx0X1scNkA==
X-Received: by 10.25.235.202 with SMTP id f71mr10198382lfk.9.1517098408561;
        Sat, 27 Jan 2018 16:13:28 -0800 (PST)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id y26sm2144695lfk.30.2018.01.27.16.13.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Jan 2018 16:13:27 -0800 (PST)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 03/12] sha1_file: convert hash_sha1_file to object_id
Date:   Sun, 28 Jan 2018 01:13:13 +0100
Message-Id: <98f571ea11dc7709377a0ae75c725056ae0c7cdb.1517097306.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <cover.1517097306.git.patryk.obara@gmail.com>
References: <cover.1516790478.git.patryk.obara@gmail.com>
 <cover.1517097306.git.patryk.obara@gmail.com>
In-Reply-To: <cover.1517097306.git.patryk.obara@gmail.com>
References: <cover.1517097306.git.patryk.obara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the declaration and definition of hash_sha1_file to use
struct object_id and adjust all function calls.

Rename this function to hash_object_file.

Signed-off-by: Patryk Obara <patryk.obara@gmail.com>
---
 apply.c                  |  4 ++--
 builtin/index-pack.c     |  5 ++---
 builtin/replace.c        |  2 +-
 builtin/unpack-objects.c |  2 +-
 cache-tree.c             | 11 +++++------
 cache.h                  |  5 ++++-
 convert.c                |  6 +++---
 diffcore-rename.c        |  4 ++--
 dir.c                    |  4 ++--
 log-tree.c               |  2 +-
 sha1_file.c              | 26 +++++++++++++-------------
 11 files changed, 36 insertions(+), 35 deletions(-)

diff --git a/apply.c b/apply.c
index 321a9fa68d..57ab8a8a29 100644
--- a/apply.c
+++ b/apply.c
@@ -3154,7 +3154,7 @@ static int apply_binary(struct apply_state *state,
 		 * See if the old one matches what the patch
 		 * applies to.
 		 */
-		hash_sha1_file(img->buf, img->len, blob_type, oid.hash);
+		hash_object_file(img->buf, img->len, blob_type, &oid);
 		if (strcmp(oid_to_hex(&oid), patch->old_sha1_prefix))
 			return error(_("the patch applies to '%s' (%s), "
 				       "which does not match the "
@@ -3199,7 +3199,7 @@ static int apply_binary(struct apply_state *state,
 				     name);
 
 		/* verify that the result matches */
-		hash_sha1_file(img->buf, img->len, blob_type, oid.hash);
+		hash_object_file(img->buf, img->len, blob_type, &oid);
 		if (strcmp(oid_to_hex(&oid), patch->new_sha1_prefix))
 			return error(_("binary patch to '%s' creates incorrect result (expecting %s, got %s)"),
 				name, patch->new_sha1_prefix, oid_to_hex(&oid));
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 4c51aec81f..7f5a95e6ff 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -958,9 +958,8 @@ static void resolve_delta(struct object_entry *delta_obj,
 	free(delta_data);
 	if (!result->data)
 		bad_object(delta_obj->idx.offset, _("failed to apply delta"));
-	hash_sha1_file(result->data, result->size,
-		       typename(delta_obj->real_type),
-		       delta_obj->idx.oid.hash);
+	hash_object_file(result->data, result->size,
+			 typename(delta_obj->real_type), &delta_obj->idx.oid);
 	sha1_object(result->data, NULL, result->size, delta_obj->real_type,
 		    &delta_obj->idx.oid);
 	counter_lock();
diff --git a/builtin/replace.c b/builtin/replace.c
index 10078ae371..814bf6bfde 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -355,7 +355,7 @@ static void check_one_mergetag(struct commit *commit,
 	struct tag *tag;
 	int i;
 
-	hash_sha1_file(extra->value, extra->len, typename(OBJ_TAG), tag_oid.hash);
+	hash_object_file(extra->value, extra->len, typename(OBJ_TAG), &tag_oid);
 	tag = lookup_tag(&tag_oid);
 	if (!tag)
 		die(_("bad mergetag in commit '%s'"), ref);
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 62ea264c46..85a40d1af7 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -258,7 +258,7 @@ static void write_object(unsigned nr, enum object_type type,
 	} else {
 		struct object *obj;
 		int eaten;
-		hash_sha1_file(buf, size, typename(type), obj_list[nr].oid.hash);
+		hash_object_file(buf, size, typename(type), &obj_list[nr].oid);
 		added_object(nr, type, buf, size);
 		obj = parse_object_buffer(&obj_list[nr].oid, type, size, buf,
 					  &eaten);
diff --git a/cache-tree.c b/cache-tree.c
index e03e72c34a..6574eeb80d 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -400,15 +400,14 @@ static int update_one(struct cache_tree *it,
 	}
 
 	if (repair) {
-		unsigned char sha1[20];
-		hash_sha1_file(buffer.buf, buffer.len, tree_type, sha1);
-		if (has_sha1_file(sha1))
-			hashcpy(it->oid.hash, sha1);
+		struct object_id oid;
+		hash_object_file(buffer.buf, buffer.len, tree_type, &oid);
+		if (has_sha1_file(oid.hash))
+			oidcpy(&it->oid, &oid);
 		else
 			to_invalidate = 1;
 	} else if (dryrun)
-		hash_sha1_file(buffer.buf, buffer.len, tree_type,
-			       it->oid.hash);
+		hash_object_file(buffer.buf, buffer.len, tree_type, &it->oid);
 	else if (write_sha1_file(buffer.buf, buffer.len, tree_type, it->oid.hash)) {
 		strbuf_release(&buffer);
 		return -1;
diff --git a/cache.h b/cache.h
index ed72933ba7..08f2b81e1b 100644
--- a/cache.h
+++ b/cache.h
@@ -1236,7 +1236,10 @@ static inline const unsigned char *lookup_replace_object(const unsigned char *sh
 
 /* Read and unpack a sha1 file into memory, write memory to a sha1 file */
 extern int sha1_object_info(const unsigned char *, unsigned long *);
-extern int hash_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *sha1);
+
+extern int hash_object_file(const void *buf, unsigned long len,
+			    const char *type, struct object_id *oid);
+
 extern int write_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *return_sha1);
 extern int hash_sha1_file_literally(const void *buf, unsigned long len, const char *type, struct object_id *oid, unsigned flags);
 
diff --git a/convert.c b/convert.c
index 1a41a48e15..5e46708c73 100644
--- a/convert.c
+++ b/convert.c
@@ -898,7 +898,7 @@ static int ident_to_git(const char *path, const char *src, size_t len,
 static int ident_to_worktree(const char *path, const char *src, size_t len,
                              struct strbuf *buf, int ident)
 {
-	unsigned char sha1[20];
+	struct object_id oid;
 	char *to_free = NULL, *dollar, *spc;
 	int cnt;
 
@@ -912,7 +912,7 @@ static int ident_to_worktree(const char *path, const char *src, size_t len,
 	/* are we "faking" in place editing ? */
 	if (src == buf->buf)
 		to_free = strbuf_detach(buf, NULL);
-	hash_sha1_file(src, len, "blob", sha1);
+	hash_object_file(src, len, "blob", &oid);
 
 	strbuf_grow(buf, len + cnt * 43);
 	for (;;) {
@@ -969,7 +969,7 @@ static int ident_to_worktree(const char *path, const char *src, size_t len,
 
 		/* step 4: substitute */
 		strbuf_addstr(buf, "Id: ");
-		strbuf_add(buf, sha1_to_hex(sha1), 40);
+		strbuf_addstr(buf, oid_to_hex(&oid));
 		strbuf_addstr(buf, " $");
 	}
 	strbuf_add(buf, src, len);
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 245e999fe5..e27d0bb632 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -260,8 +260,8 @@ static unsigned int hash_filespec(struct diff_filespec *filespec)
 	if (!filespec->oid_valid) {
 		if (diff_populate_filespec(filespec, 0))
 			return 0;
-		hash_sha1_file(filespec->data, filespec->size, "blob",
-			       filespec->oid.hash);
+		hash_object_file(filespec->data, filespec->size, "blob",
+				 &filespec->oid);
 	}
 	return sha1hash(filespec->oid.hash);
 }
diff --git a/dir.c b/dir.c
index 22cadbda9d..fe0f25463f 100644
--- a/dir.c
+++ b/dir.c
@@ -846,8 +846,8 @@ static int add_excludes(const char *fname, const char *base, int baselen,
 				oidcpy(&oid_stat->oid,
 				       &istate->cache[pos]->oid);
 			else
-				hash_sha1_file(buf, size, "blob",
-					       oid_stat->oid.hash);
+				hash_object_file(buf, size, "blob",
+						 &oid_stat->oid);
 			fill_stat_data(&oid_stat->stat, &st);
 			oid_stat->valid = 1;
 		}
diff --git a/log-tree.c b/log-tree.c
index fca29d4799..fc0cc0d6d1 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -499,7 +499,7 @@ static void show_one_mergetag(struct commit *commit,
 	int status, nth;
 	size_t payload_size, gpg_message_offset;
 
-	hash_sha1_file(extra->value, extra->len, typename(OBJ_TAG), oid.hash);
+	hash_object_file(extra->value, extra->len, typename(OBJ_TAG), &oid);
 	tag = lookup_tag(&oid);
 	if (!tag)
 		return; /* error message already given */
diff --git a/sha1_file.c b/sha1_file.c
index 830b93b428..4c44c60cec 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -788,7 +788,7 @@ void *xmmap(void *start, size_t length,
 int check_sha1_signature(const unsigned char *sha1, void *map,
 			 unsigned long size, const char *type)
 {
-	unsigned char real_sha1[20];
+	struct object_id real_oid;
 	enum object_type obj_type;
 	struct git_istream *st;
 	git_SHA_CTX c;
@@ -796,8 +796,8 @@ int check_sha1_signature(const unsigned char *sha1, void *map,
 	int hdrlen;
 
 	if (map) {
-		hash_sha1_file(map, size, type, real_sha1);
-		return hashcmp(sha1, real_sha1) ? -1 : 0;
+		hash_object_file(map, size, type, &real_oid);
+		return hashcmp(sha1, real_oid.hash) ? -1 : 0;
 	}
 
 	st = open_istream(sha1, &obj_type, &size, NULL);
@@ -822,9 +822,9 @@ int check_sha1_signature(const unsigned char *sha1, void *map,
 			break;
 		git_SHA1_Update(&c, buf, readlen);
 	}
-	git_SHA1_Final(real_sha1, &c);
+	git_SHA1_Final(real_oid.hash, &c);
 	close_istream(st);
-	return hashcmp(sha1, real_sha1) ? -1 : 0;
+	return hashcmp(sha1, real_oid.hash) ? -1 : 0;
 }
 
 int git_open_cloexec(const char *name, int flags)
@@ -1317,7 +1317,7 @@ int pretend_object_file(void *buf, unsigned long len, enum object_type type,
 {
 	struct cached_object *co;
 
-	hash_sha1_file(buf, len, typename(type), oid->hash);
+	hash_object_file(buf, len, typename(type), oid);
 	if (has_sha1_file(oid->hash) || find_cached_object(oid->hash))
 		return 0;
 	ALLOC_GROW(cached_objects, cached_object_nr + 1, cached_object_alloc);
@@ -1485,12 +1485,12 @@ static int write_buffer(int fd, const void *buf, size_t len)
 	return 0;
 }
 
-int hash_sha1_file(const void *buf, unsigned long len, const char *type,
-                   unsigned char *sha1)
+int hash_object_file(const void *buf, unsigned long len, const char *type,
+		     struct object_id *oid)
 {
 	char hdr[32];
 	int hdrlen = sizeof(hdr);
-	write_sha1_file_prepare(buf, len, type, sha1, hdr, &hdrlen);
+	write_sha1_file_prepare(buf, len, type, oid->hash, hdr, &hdrlen);
 	return 0;
 }
 
@@ -1769,7 +1769,7 @@ static int index_mem(struct object_id *oid, void *buf, size_t size,
 	if (write_object)
 		ret = write_sha1_file(buf, size, typename(type), oid->hash);
 	else
-		ret = hash_sha1_file(buf, size, typename(type), oid->hash);
+		ret = hash_object_file(buf, size, typename(type), oid);
 	if (re_allocated)
 		free(buf);
 	return ret;
@@ -1792,8 +1792,8 @@ static int index_stream_convert_blob(struct object_id *oid, int fd,
 		ret = write_sha1_file(sbuf.buf, sbuf.len, typename(OBJ_BLOB),
 				      oid->hash);
 	else
-		ret = hash_sha1_file(sbuf.buf, sbuf.len, typename(OBJ_BLOB),
-				     oid->hash);
+		ret = hash_object_file(sbuf.buf, sbuf.len, typename(OBJ_BLOB),
+				       oid);
 	strbuf_release(&sbuf);
 	return ret;
 }
@@ -1907,7 +1907,7 @@ int index_path(struct object_id *oid, const char *path, struct stat *st, unsigne
 		if (strbuf_readlink(&sb, path, st->st_size))
 			return error_errno("readlink(\"%s\")", path);
 		if (!(flags & HASH_WRITE_OBJECT))
-			hash_sha1_file(sb.buf, sb.len, blob_type, oid->hash);
+			hash_object_file(sb.buf, sb.len, blob_type, oid);
 		else if (write_sha1_file(sb.buf, sb.len, blob_type, oid->hash))
 			rc = error("%s: failed to insert into database", path);
 		strbuf_release(&sb);
-- 
2.14.3

