Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD99C433F5
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 13:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359185AbiBDNv5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 08:51:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359122AbiBDNvo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 08:51:44 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5E5C06174A
        for <git@vger.kernel.org>; Fri,  4 Feb 2022 05:51:40 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id j16so11400645wrd.8
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 05:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pZQMwPnTZDN/Pw0gAQDUSvBv7s6CzIEJb1hG0W17144=;
        b=Y6xn91nqLtpAf2dXl0r5FILl9jBEjviM2iKu69/3kY7eZxJQYHBZcI7p6Ysyf4/24D
         vVycv6p0/vlN3KiAC3NVfYI+k2vQdkDDhfDng3JIv+7eMQAI3RcB+nJ54GftmlAXVphc
         m6xq+yrJkVv/9f0KBbmgCUOZ+1G44NY2zxwN1Xmui3qVK2nGdUF+46Lxi33amGNQt5MK
         tN/LbbwkVsy+zcJqkPPtjINHpWw9l13FCZI+UJhtysAtP7skbPecx4FKAI0X/qA/XD/J
         kANTDClLdSxL3SboR9RCWmlqdk62UfK4GdyK8ON3GO4zP3qDK63hqCXHneUIR1SypExG
         YL1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pZQMwPnTZDN/Pw0gAQDUSvBv7s6CzIEJb1hG0W17144=;
        b=udtOwanCVk5afIect5jENRdSgCP1BynoNztYV5UljsxiBN3B16Lsvrwy6iG+ooGs0a
         nCqEJCB0cDIJiuMeXsGps2eNYJwMOnEA6/OiTRfGVEzd3a2EiFUbIPaaWkITeE1/j7vN
         RFf/U+kNJuqU3MY07Wk/xSiQanuHSG3OaLgIDQxmwnNlXKdTVNVKnPU/shfBG5tegXBB
         shhCTMbwwJHekVKuk5kXw13Cxcyw/PC1QpbLBRfZC2Azb87knbLfbQ63jEkf0J3INulZ
         MxQ4PyPEXlgtuoLov9m2hCaRR/dGyGgYX6CJRApENZeW2c5tEgcjj/c4nGw2nopwtWFB
         YDtA==
X-Gm-Message-State: AOAM5329LkWwJbjJ2ddjAtwOn2hPQoQ2uQZ43Tt7YHOXBTIHj+89c13f
        WAxO6SiW1UvTB20xyNPpqfSFqqxqX8t4Sw==
X-Google-Smtp-Source: ABdhPJyJXpEsNsM1f74JNPmJaoRn02KvzC4WUuHtyFLypO6olpTtTQtuFKMV9dtjGQzg7W1fGKd+7g==
X-Received: by 2002:a05:6000:18af:: with SMTP id b15mr2464400wri.589.1643982699056;
        Fri, 04 Feb 2022 05:51:39 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z2sm205963wmi.22.2022.02.04.05.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 05:51:38 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han Xin <chiyutianyi@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 09/11] object-file API: have hash_object_file() take "enum object_type"
Date:   Fri,  4 Feb 2022 14:51:23 +0100
Message-Id: <patch-v2-09.11-40647be525b-20220204T135005Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.940.ge7a5b4b05f2
In-Reply-To: <cover-v2-00.11-00000000000-20220204T135005Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20220201T144803Z-avarab@gmail.com> <cover-v2-00.11-00000000000-20220204T135005Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the hash_object_file() function to take an "enum
object_type".

Since a preceding commit all of its callers are passing either
"{commit,tree,blob,tag}_type", or the result of a call to type_name(),
the parse_object() caller that would pass NULL is now using
stream_object_signature().

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 apply.c                  |  4 ++--
 builtin/fast-export.c    |  2 +-
 builtin/index-pack.c     |  4 ++--
 builtin/mktag.c          |  2 +-
 builtin/replace.c        |  2 +-
 builtin/unpack-objects.c |  2 +-
 cache-tree.c             |  6 +++---
 cache.h                  |  3 ++-
 convert.c                |  2 +-
 diffcore-rename.c        |  2 +-
 dir.c                    |  2 +-
 log-tree.c               |  2 +-
 object-file.c            | 35 +++++++++++++++++++++--------------
 object-store.h           |  2 +-
 object.c                 |  3 +--
 pack-check.c             |  2 +-
 16 files changed, 41 insertions(+), 34 deletions(-)

diff --git a/apply.c b/apply.c
index e82a7c30f01..8513755e254 100644
--- a/apply.c
+++ b/apply.c
@@ -3157,7 +3157,7 @@ static int apply_binary(struct apply_state *state,
 		 * See if the old one matches what the patch
 		 * applies to.
 		 */
-		hash_object_file(the_hash_algo, img->buf, img->len, blob_type,
+		hash_object_file(the_hash_algo, img->buf, img->len, OBJ_BLOB,
 				 &oid);
 		if (strcmp(oid_to_hex(&oid), patch->old_oid_prefix))
 			return error(_("the patch applies to '%s' (%s), "
@@ -3203,7 +3203,7 @@ static int apply_binary(struct apply_state *state,
 				     name);
 
 		/* verify that the result matches */
-		hash_object_file(the_hash_algo, img->buf, img->len, blob_type,
+		hash_object_file(the_hash_algo, img->buf, img->len, OBJ_BLOB,
 				 &oid);
 		if (strcmp(oid_to_hex(&oid), patch->new_oid_prefix))
 			return error(_("binary patch to '%s' creates incorrect result (expecting %s, got %s)"),
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 1878ec34960..187985666e7 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -300,7 +300,7 @@ static void export_blob(const struct object_id *oid)
 		if (!buf)
 			die("could not read blob %s", oid_to_hex(oid));
 		if (!check_object_signature(the_repository, oid, buf, size,
-					    type_name(type)))
+					    type))
 			die("oid mismatch in blob %s", oid_to_hex(oid));
 		object = parse_object_buffer(the_repository, oid, type,
 					     size, buf, &eaten);
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index eaa7b6698d1..1c0d3971074 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -970,7 +970,7 @@ static struct base_data *resolve_delta(struct object_entry *delta_obj,
 	if (!result_data)
 		bad_object(delta_obj->idx.offset, _("failed to apply delta"));
 	hash_object_file(the_hash_algo, result_data, result_size,
-			 type_name(delta_obj->real_type), &delta_obj->idx.oid);
+			 delta_obj->real_type, &delta_obj->idx.oid);
 	sha1_object(result_data, NULL, result_size, delta_obj->real_type,
 		    &delta_obj->idx.oid);
 
@@ -1413,7 +1413,7 @@ static void fix_unresolved_deltas(struct hashfile *f)
 			continue;
 
 		if (!check_object_signature(the_repository, &d->oid, data,
-					    size, type_name(type)))
+					    size, type))
 			die(_("local object %s is corrupt"), oid_to_hex(&d->oid));
 
 		/*
diff --git a/builtin/mktag.c b/builtin/mktag.c
index 1282e8cd9e2..bebc88faed0 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -62,7 +62,7 @@ static int verify_object_in_tag(struct object_id *tagged_oid, int *tagged_type)
 
 	repl = lookup_replace_object(the_repository, tagged_oid);
 	ret = !check_object_signature(the_repository, repl, buffer, size,
-				      type_name(*tagged_type));
+				     *tagged_type);
 	free(buffer);
 
 	return ret;
diff --git a/builtin/replace.c b/builtin/replace.c
index 995ca683302..53a3b246570 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -409,7 +409,7 @@ static int check_one_mergetag(struct commit *commit,
 	int i;
 
 	hash_object_file(the_hash_algo, extra->value, extra->len,
-			 type_name(OBJ_TAG), &tag_oid);
+			 OBJ_TAG, &tag_oid);
 	tag = lookup_tag(the_repository, &tag_oid);
 	if (!tag)
 		return error(_("bad mergetag in commit '%s'"), ref);
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 808041551fd..dbeb0680a58 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -266,7 +266,7 @@ static void write_object(unsigned nr, enum object_type type,
 	} else {
 		struct object *obj;
 		int eaten;
-		hash_object_file(the_hash_algo, buf, size, type_name(type),
+		hash_object_file(the_hash_algo, buf, size, type,
 				 &obj_list[nr].oid);
 		added_object(nr, type, buf, size);
 		obj = parse_object_buffer(the_repository, &obj_list[nr].oid,
diff --git a/cache-tree.c b/cache-tree.c
index fdbbd191d22..6752f69d515 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -432,14 +432,14 @@ static int update_one(struct cache_tree *it,
 	if (repair) {
 		struct object_id oid;
 		hash_object_file(the_hash_algo, buffer.buf, buffer.len,
-				 tree_type, &oid);
+				 OBJ_TREE, &oid);
 		if (has_object_file_with_flags(&oid, OBJECT_INFO_SKIP_FETCH_OBJECT))
 			oidcpy(&it->oid, &oid);
 		else
 			to_invalidate = 1;
 	} else if (dryrun) {
 		hash_object_file(the_hash_algo, buffer.buf, buffer.len,
-				 tree_type, &it->oid);
+				 OBJ_TREE, &it->oid);
 	} else if (write_object_file_flags(buffer.buf, buffer.len, OBJ_TREE,
 					   &it->oid, flags & WRITE_TREE_SILENT
 					   ? HASH_SILENT : 0)) {
@@ -948,7 +948,7 @@ static int verify_one(struct repository *r,
 		strbuf_addf(&tree_buf, "%o %.*s%c", mode, entlen, name, '\0');
 		strbuf_add(&tree_buf, oid->hash, r->hash_algo->rawsz);
 	}
-	hash_object_file(r->hash_algo, tree_buf.buf, tree_buf.len, tree_type,
+	hash_object_file(r->hash_algo, tree_buf.buf, tree_buf.len, OBJ_TREE,
 			 &new_oid);
 	if (!oideq(&new_oid, &it->oid))
 		BUG("cache-tree for path %.*s does not match. "
diff --git a/cache.h b/cache.h
index 5a13bbfd904..42761bb12cb 100644
--- a/cache.h
+++ b/cache.h
@@ -1327,7 +1327,8 @@ int parse_loose_header(const char *hdr, struct object_info *oi);
  * except that negative values might also indicate a generic error.
  */
 int check_object_signature(struct repository *r, const struct object_id *oid,
-			   void *buf, unsigned long size, const char *type);
+			   void *map, unsigned long size,
+			   enum object_type type);
 
 /**
  * A streaming version of check_object_signature().
diff --git a/convert.c b/convert.c
index df7186bd813..d88072fe320 100644
--- a/convert.c
+++ b/convert.c
@@ -1159,7 +1159,7 @@ static int ident_to_worktree(const char *src, size_t len,
 	/* are we "faking" in place editing ? */
 	if (src == buf->buf)
 		to_free = strbuf_detach(buf, NULL);
-	hash_object_file(the_hash_algo, src, len, "blob", &oid);
+	hash_object_file(the_hash_algo, src, len, OBJ_BLOB, &oid);
 
 	strbuf_grow(buf, len + cnt * (the_hash_algo->hexsz + 3));
 	for (;;) {
diff --git a/diffcore-rename.c b/diffcore-rename.c
index bebd4ed6a42..c0422d9e709 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -261,7 +261,7 @@ static unsigned int hash_filespec(struct repository *r,
 		if (diff_populate_filespec(r, filespec, NULL))
 			return 0;
 		hash_object_file(r->hash_algo, filespec->data, filespec->size,
-				 "blob", &filespec->oid);
+				 OBJ_BLOB, &filespec->oid);
 	}
 	return oidhash(&filespec->oid);
 }
diff --git a/dir.c b/dir.c
index d91295f2bcd..5674e8a6256 100644
--- a/dir.c
+++ b/dir.c
@@ -1113,7 +1113,7 @@ static int add_patterns(const char *fname, const char *base, int baselen,
 				       &istate->cache[pos]->oid);
 			else
 				hash_object_file(the_hash_algo, buf, size,
-						 "blob", &oid_stat->oid);
+						 OBJ_BLOB, &oid_stat->oid);
 			fill_stat_data(&oid_stat->stat, &st);
 			oid_stat->valid = 1;
 		}
diff --git a/log-tree.c b/log-tree.c
index d3e7a40b648..27a5b0bd61a 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -561,7 +561,7 @@ static int show_one_mergetag(struct commit *commit,
 	struct strbuf signature = STRBUF_INIT;
 
 	hash_object_file(the_hash_algo, extra->value, extra->len,
-			 type_name(OBJ_TAG), &oid);
+			 OBJ_TAG, &oid);
 	tag = lookup_tag(the_repository, &oid);
 	if (!tag)
 		return -1; /* error message already given */
diff --git a/object-file.c b/object-file.c
index a68af32308e..97a3493f5fb 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1067,7 +1067,8 @@ int format_object_header(char *str, size_t size, enum object_type type,
 }
 
 int check_object_signature(struct repository *r, const struct object_id *oid,
-			   void *buf, unsigned long size, const char *type)
+			   void *buf, unsigned long size,
+			   enum object_type type)
 {
 	struct object_id real_oid;
 
@@ -1676,7 +1677,7 @@ int pretend_object_file(void *buf, unsigned long len, enum object_type type,
 {
 	struct cached_object *co;
 
-	hash_object_file(the_hash_algo, buf, len, type_name(type), oid);
+	hash_object_file(the_hash_algo, buf, len, type, oid);
 	if (has_object_file_with_flags(oid, OBJECT_INFO_QUICK | OBJECT_INFO_SKIP_FETCH_OBJECT) ||
 	    find_cached_object(oid))
 		return 0;
@@ -1850,15 +1851,23 @@ static int write_buffer(int fd, const void *buf, size_t len)
 	return 0;
 }
 
-void hash_object_file(const struct git_hash_algo *algo, const void *buf,
-		     unsigned long len, const char *type,
-		     struct object_id *oid)
+static void hash_object_file_literally(const struct git_hash_algo *algo,
+				       const void *buf, unsigned long len,
+				       const char *type, struct object_id *oid)
 {
 	char hdr[MAX_HEADER_LEN];
 	int hdrlen = sizeof(hdr);
+
 	write_object_file_prepare(algo, buf, len, type, oid, hdr, &hdrlen);
 }
 
+void hash_object_file(const struct git_hash_algo *algo, const void *buf,
+		      unsigned long len, enum object_type type,
+		      struct object_id *oid)
+{
+	hash_object_file_literally(algo, buf, len, type_name(type), oid);
+}
+
 /* Finalize a file on disk, and close it. */
 static void close_loose_object(int fd)
 {
@@ -2161,9 +2170,7 @@ static int index_mem(struct index_state *istate,
 	if (write_object)
 		ret = write_object_file(buf, size, type, oid);
 	else
-		hash_object_file(the_hash_algo, buf, size, type_name(type),
-				 oid);
-
+		hash_object_file(the_hash_algo, buf, size, type, oid);
 	if (re_allocated)
 		free(buf);
 	return ret;
@@ -2189,8 +2196,8 @@ static int index_stream_convert_blob(struct index_state *istate,
 		ret = write_object_file(sbuf.buf, sbuf.len, OBJ_BLOB,
 					oid);
 	else
-		hash_object_file(the_hash_algo, sbuf.buf, sbuf.len,
-				 type_name(OBJ_BLOB), oid);
+		hash_object_file(the_hash_algo, sbuf.buf, sbuf.len, OBJ_BLOB,
+				 oid);
 	strbuf_release(&sbuf);
 	return ret;
 }
@@ -2309,7 +2316,7 @@ int index_path(struct index_state *istate, struct object_id *oid,
 			return error_errno("readlink(\"%s\")", path);
 		if (!(flags & HASH_WRITE_OBJECT))
 			hash_object_file(the_hash_algo, sb.buf, sb.len,
-					 blob_type, oid);
+					 OBJ_BLOB, oid);
 		else if (write_object_file(sb.buf, sb.len, OBJ_BLOB, oid))
 			rc = error(_("%s: failed to insert into database"), path);
 		strbuf_release(&sb);
@@ -2615,9 +2622,9 @@ int read_loose_object(const char *path,
 			goto out;
 		}
 
-		hash_object_file(the_repository->hash_algo,
-				 *contents, *size, oi->type_name->buf,
-				 real_oid);
+		hash_object_file_literally(the_repository->hash_algo,
+					   *contents, *size,
+					   oi->type_name->buf, real_oid);
 		if (!oideq(expected_oid, real_oid))
 			goto out;
 	}
diff --git a/object-store.h b/object-store.h
index 29169d117f7..bd2322ed8ce 100644
--- a/object-store.h
+++ b/object-store.h
@@ -246,7 +246,7 @@ static inline void *repo_read_object_file(struct repository *r,
 int oid_object_info(struct repository *r, const struct object_id *, unsigned long *);
 
 void hash_object_file(const struct git_hash_algo *algo, const void *buf,
-		      unsigned long len, const char *type,
+		      unsigned long len, enum object_type type,
 		      struct object_id *oid);
 
 int write_object_file_flags(const void *buf, unsigned long len,
diff --git a/object.c b/object.c
index b3f9cd5c8cd..2cc9edb7512 100644
--- a/object.c
+++ b/object.c
@@ -289,8 +289,7 @@ struct object *parse_object(struct repository *r, const struct object_id *oid)
 
 	buffer = repo_read_object_file(r, oid, &type, &size);
 	if (buffer) {
-		if (!check_object_signature(r, repl, buffer, size,
-					    type_name(type))) {
+		if (!check_object_signature(r, repl, buffer, size, type)) {
 			free(buffer);
 			error(_("hash mismatch %s"), oid_to_hex(repl));
 			return NULL;
diff --git a/pack-check.c b/pack-check.c
index 4a27e77704b..f1df16ef9a7 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -143,7 +143,7 @@ static int verify_packfile(struct repository *r,
 				    oid_to_hex(&oid), p->pack_name,
 				    (uintmax_t)entries[i].offset);
 		else if (data && !check_object_signature(r, &oid, data, size,
-							 type_name(type)))
+							 type))
 			err = error("packed %s from %s is corrupt",
 				    oid_to_hex(&oid), p->pack_name);
 		else if (!data && !stream_object_signature(r, &oid))
-- 
2.35.1.940.ge7a5b4b05f2

