Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E706CC433FE
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 23:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378332AbiBDXtG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 18:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378294AbiBDXs4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 18:48:56 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF43E009515
        for <git@vger.kernel.org>; Fri,  4 Feb 2022 15:48:50 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id l67-20020a1c2546000000b00353951c3f62so4115372wml.5
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 15:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A/NccoALfU0aKf22lxw9HdjbntTreN9FbZ+h+Lq/CeU=;
        b=juig7m8opwcSf9cEsMNeCqnxyqtm7cdqFyTcl9KluRUrnOj5q/0Z71U1lXpD5cWP+D
         1zR4A2//mG96hz8uuDg9AfNz+AHMgyUOwypHuYdK3PFD9bWRxuYgV9WmjDYcYFq38+Pe
         xPLsFvAxciBgzVq1GxvLABIR6Yzlp0ySX4x4ksSKtab8qC5Aw6hUFiahIxhvbGi3SqaX
         hwzna9T95OAuU0YotdAb8kf6jw2xBSWZ5QNbvKp1wDyvr2rPlp6fWLRnGacA5HFMgMJN
         uWrBrQArRSuEhZnLk2Z6FGD7OUNwziH1xGZ2z2xoCk+5vsIiN2LFCeMLRfTUkb/WmN0T
         btag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A/NccoALfU0aKf22lxw9HdjbntTreN9FbZ+h+Lq/CeU=;
        b=Rt4PohHbR4w7wy8a92Xpss2kXixZbCKjMc60mu2NMJGWb2mp/uqnkpkGlH4BifXc7g
         aL18zIcvcCSXvpDCMkW2McXuP8ZaBzz3ZKk18KyJLHcLzs95VddmGBxpIaDu4wKtYfuj
         Bm1rFOwk+C5qAjz6rQu3P2YtWlJ4TgxaG56m4XpXkPsqyRe/TPjmtQL+3wW3OaXFMNa8
         2J/bJYV3Qh/wh1WoV8ST/jA6PHRC3ve+NVT3kTLq4vBfYdn9wUu4Fjsij99T0NQIXQrd
         HPaS9FVU7Ti0749fxk3IncBuuAK72EmvrBLyMr56C/5Qp/0IKipCw1aHEWLpVwa+g9kA
         zblg==
X-Gm-Message-State: AOAM533qr8IqFJcGdh2EB9O0RW+JDFs3OnoV9zqW0WIbdpg18xufGStG
        RrmXpVbAwwBz3N0M7gIkvkbYY4jued/uyw==
X-Google-Smtp-Source: ABdhPJzDEPI4c/UqO6/yrzSAWnvRw0iT5SuoHN0SnF1al3gIG9q/vbyHrR59oUt1TIftWsek+nokcw==
X-Received: by 2002:a05:600c:28cd:: with SMTP id h13mr4248730wmd.54.1644018529161;
        Fri, 04 Feb 2022 15:48:49 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t16sm2724042wmq.21.2022.02.04.15.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 15:48:48 -0800 (PST)
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
Subject: [PATCH v3 10/12] object-file API: have hash_object_file() take "enum object_type"
Date:   Sat,  5 Feb 2022 00:48:32 +0100
Message-Id: <patch-v3-10.12-2c936c674d4-20220204T234435Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.940.ge7a5b4b05f2
In-Reply-To: <cover-v3-00.12-00000000000-20220204T234435Z-avarab@gmail.com>
References: <cover-v2-00.11-00000000000-20220204T135005Z-avarab@gmail.com> <cover-v3-00.12-00000000000-20220204T234435Z-avarab@gmail.com>
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
index 319859db30e..52aebeb5214 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -300,7 +300,7 @@ static void export_blob(const struct object_id *oid)
 		if (!buf)
 			die("could not read blob %s", oid_to_hex(oid));
 		if (check_object_signature(the_repository, oid, buf, size,
-					   type_name(type)) < 0)
+					   type) < 0)
 			die("oid mismatch in blob %s", oid_to_hex(oid));
 		object = parse_object_buffer(the_repository, oid, type,
 					     size, buf, &eaten);
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index e1927205a7b..d0c3e0966b7 100644
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
 
 		if (check_object_signature(the_repository, &d->oid, data, size,
-					   type_name(type)) < 0)
+					   type) < 0)
 			die(_("local object %s is corrupt"), oid_to_hex(&d->oid));
 
 		/*
diff --git a/builtin/mktag.c b/builtin/mktag.c
index 4d28eceeba6..14b9fe3bc0a 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -62,7 +62,7 @@ static int verify_object_in_tag(struct object_id *tagged_oid, int *tagged_type)
 
 	repl = lookup_replace_object(the_repository, tagged_oid);
 	ret = check_object_signature(the_repository, repl, buffer, size,
-				     type_name(*tagged_type));
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
index c068f99c793..2027803c49a 100644
--- a/cache.h
+++ b/cache.h
@@ -1327,7 +1327,8 @@ int parse_loose_header(const char *hdr, struct object_info *oi);
  * what we expected, but it might also indicate another error.
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
index 9e5b849693e..b1cb78c4419 100644
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
@@ -2614,9 +2621,9 @@ int read_loose_object(const char *path,
 			git_inflate_end(&stream);
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
index d07678ef6da..588b8156f1d 100644
--- a/object.c
+++ b/object.c
@@ -289,8 +289,7 @@ struct object *parse_object(struct repository *r, const struct object_id *oid)
 
 	buffer = repo_read_object_file(r, oid, &type, &size);
 	if (buffer) {
-		if (check_object_signature(r, repl, buffer, size,
-					   type_name(type)) < 0) {
+		if (check_object_signature(r, repl, buffer, size, type) < 0) {
 			free(buffer);
 			error(_("hash mismatch %s"), oid_to_hex(repl));
 			return NULL;
diff --git a/pack-check.c b/pack-check.c
index d8d8f91de6b..bfb593ba726 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -143,7 +143,7 @@ static int verify_packfile(struct repository *r,
 				    oid_to_hex(&oid), p->pack_name,
 				    (uintmax_t)entries[i].offset);
 		else if (data && check_object_signature(r, &oid, data, size,
-							type_name(type)) < 0)
+							type) < 0)
 			err = error("packed %s from %s is corrupt",
 				    oid_to_hex(&oid), p->pack_name);
 		else if (!data && stream_object_signature(r, &oid) < 0)
-- 
2.35.1.940.ge7a5b4b05f2

