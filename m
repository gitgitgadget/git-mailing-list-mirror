Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0E4C433F5
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 23:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377224AbiBDXs4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 18:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351100AbiBDXsr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 18:48:47 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9FAE0090B1
        for <git@vger.kernel.org>; Fri,  4 Feb 2022 15:48:45 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id l123-20020a1c2581000000b0037b9d960079so1666533wml.0
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 15:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JJUmZO49zgHQgY+LpR9d0XtVrDmLVgJw6KSGSe73hTM=;
        b=KZN5/MPbagJpGkkeA+TXHDSQgRwdreh72aYz5JU309bCYdmargdHPPwVWPow91bfdA
         SMSeC0hq64j23ZVwHStUJ/Nxq5Cvb7lfDdEP8xAshmjaUzf/P+b1SNA5Cm8ka8aTJR/8
         kSKCwiZ8HUZNuUuT34gCzBZjYDfZI1ZaMpnGujnkAAIAiTaJ1lupnAe5FpW9cPa3ti8t
         jbgcD6gKuTVafsCtnVo09JT4vkg/VjGjikJqfDUmaUX/VyRmLN6bCRaell2Q73NM/U7D
         Eoy09jegtF1vgYPhEP0jhDb/+7H2eD2qCvBE8I812faxnBc3XVNiUeBYl3ezH42R4cbq
         n1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JJUmZO49zgHQgY+LpR9d0XtVrDmLVgJw6KSGSe73hTM=;
        b=RKmXeJru3NgihsA4e6KVdrbNW911Z18IOJny+TYTSX8LQx99RkMorwzGbg6Iirhwlw
         c4vLaZbqN/lSWXfKODcYf5LZyV2+cm6RmWPD3JQX6PCHsLeTTE31m1DWvcqK16G0aags
         FqOQiQTsH24MhTVUyeTwA0wtCKaliWSkipGY9W4O9BsFsoApjhRiKu64FL1kZ4wJHk29
         Q/LPgy+0MUhs2nYP1Ddbx949EFX0zwrHp7chMNsCJ8L/+1APrsbzhR5d4rDsyQ/fS9kD
         25UdSc2nwNVu1fnR7ugo9KjIRTMeq9wJ9YhW47IIZfRG/mgghO16YAO+yqc1+2K5WZuW
         ULvw==
X-Gm-Message-State: AOAM530HsFOQGTJ5EoINTFS/88lxA+YoGzblNtY0GCxWbRTGoA/KKsuQ
        3O+OxNVXoDyCne7RzcZ9HUx36W31Ghmb6A==
X-Google-Smtp-Source: ABdhPJxLRSV+bsYNiiXt5c/p0WFyqom9PqPfZbinbGo7/mW5YY9q1vi2ly+K+REK5Dl0yhSvBaOeqA==
X-Received: by 2002:a05:600c:3c9:: with SMTP id z9mr887623wmd.148.1644018523916;
        Fri, 04 Feb 2022 15:48:43 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t16sm2724042wmq.21.2022.02.04.15.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 15:48:43 -0800 (PST)
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
Subject: [PATCH v3 04/12] object-file API: have write_object_file() take "enum object_type"
Date:   Sat,  5 Feb 2022 00:48:26 +0100
Message-Id: <patch-v3-04.12-795ac3dea2a-20220204T234435Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.940.ge7a5b4b05f2
In-Reply-To: <cover-v3-00.12-00000000000-20220204T234435Z-avarab@gmail.com>
References: <cover-v2-00.11-00000000000-20220204T135005Z-avarab@gmail.com> <cover-v3-00.12-00000000000-20220204T234435Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the write_object_file() function to take an "enum object_type"
instead of a "const char *type". Its callers either passed
{commit,tree,blob,tag}_type and can pass the corresponding OBJ_* type
instead, or were hardcoding strings like "blob".

This avoids the back & forth fragility where the callers of
write_object_file() would have the enum type, and convert it
themselves via type_name(). We do have to now do that conversion
ourselves before calling write_object_file_prepare(), but those
codepaths will be similarly adjusted in subsequent commits.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 apply.c                  |  8 ++++----
 builtin/checkout.c       |  2 +-
 builtin/mktag.c          |  2 +-
 builtin/mktree.c         |  2 +-
 builtin/notes.c          |  2 +-
 builtin/receive-pack.c   |  2 +-
 builtin/replace.c        |  2 +-
 builtin/tag.c            |  2 +-
 builtin/unpack-objects.c |  6 +++---
 cache-tree.c             |  2 +-
 commit.c                 |  2 +-
 match-trees.c            |  2 +-
 merge-ort.c              |  4 ++--
 merge-recursive.c        |  2 +-
 notes-cache.c            |  2 +-
 notes.c                  |  8 ++++----
 object-file.c            | 10 +++++-----
 object-store.h           |  4 ++--
 read-cache.c             |  2 +-
 19 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/apply.c b/apply.c
index 7ffadc3b17a..e82a7c30f01 100644
--- a/apply.c
+++ b/apply.c
@@ -3589,7 +3589,7 @@ static int try_threeway(struct apply_state *state,
 
 	/* Preimage the patch was prepared for */
 	if (patch->is_new)
-		write_object_file("", 0, blob_type, &pre_oid);
+		write_object_file("", 0, OBJ_BLOB, &pre_oid);
 	else if (get_oid(patch->old_oid_prefix, &pre_oid) ||
 		 read_blob_object(&buf, &pre_oid, patch->old_mode))
 		return error(_("repository lacks the necessary blob to perform 3-way merge."));
@@ -3605,7 +3605,7 @@ static int try_threeway(struct apply_state *state,
 		return -1;
 	}
 	/* post_oid is theirs */
-	write_object_file(tmp_image.buf, tmp_image.len, blob_type, &post_oid);
+	write_object_file(tmp_image.buf, tmp_image.len, OBJ_BLOB, &post_oid);
 	clear_image(&tmp_image);
 
 	/* our_oid is ours */
@@ -3618,7 +3618,7 @@ static int try_threeway(struct apply_state *state,
 			return error(_("cannot read the current contents of '%s'"),
 				     patch->old_name);
 	}
-	write_object_file(tmp_image.buf, tmp_image.len, blob_type, &our_oid);
+	write_object_file(tmp_image.buf, tmp_image.len, OBJ_BLOB, &our_oid);
 	clear_image(&tmp_image);
 
 	/* in-core three-way merge between post and our using pre as base */
@@ -4346,7 +4346,7 @@ static int add_index_file(struct apply_state *state,
 			}
 			fill_stat_cache_info(state->repo->index, ce, &st);
 		}
-		if (write_object_file(buf, size, blob_type, &ce->oid) < 0) {
+		if (write_object_file(buf, size, OBJ_BLOB, &ce->oid) < 0) {
 			discard_cache_entry(ce);
 			return error(_("unable to create backing store "
 				       "for newly created file %s"), path);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index cc804ba8e1e..24cc235939f 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -298,7 +298,7 @@ static int checkout_merged(int pos, const struct checkout *state,
 	 * (it also writes the merge result to the object database even
 	 * when it may contain conflicts).
 	 */
-	if (write_object_file(result_buf.ptr, result_buf.size, blob_type, &oid))
+	if (write_object_file(result_buf.ptr, result_buf.size, OBJ_BLOB, &oid))
 		die(_("Unable to add merge result for '%s'"), path);
 	free(result_buf.ptr);
 	ce = make_transient_cache_entry(mode, &oid, path, 2, ce_mem_pool);
diff --git a/builtin/mktag.c b/builtin/mktag.c
index 3b2dbbb37e6..96a3686af53 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -100,7 +100,7 @@ int cmd_mktag(int argc, const char **argv, const char *prefix)
 	if (verify_object_in_tag(&tagged_oid, &tagged_type))
 		die(_("tag on stdin did not refer to a valid object"));
 
-	if (write_object_file(buf.buf, buf.len, tag_type, &result) < 0)
+	if (write_object_file(buf.buf, buf.len, OBJ_TAG, &result) < 0)
 		die(_("unable to write tag file"));
 
 	strbuf_release(&buf);
diff --git a/builtin/mktree.c b/builtin/mktree.c
index ae78ca1c029..a1213aaa961 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -58,7 +58,7 @@ static void write_tree(struct object_id *oid)
 		strbuf_add(&buf, ent->oid.hash, the_hash_algo->rawsz);
 	}
 
-	write_object_file(buf.buf, buf.len, tree_type, oid);
+	write_object_file(buf.buf, buf.len, OBJ_TREE, oid);
 	strbuf_release(&buf);
 }
 
diff --git a/builtin/notes.c b/builtin/notes.c
index 05d60483e82..4cc84dfa768 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -199,7 +199,7 @@ static void prepare_note_data(const struct object_id *object, struct note_data *
 
 static void write_note_data(struct note_data *d, struct object_id *oid)
 {
-	if (write_object_file(d->buf.buf, d->buf.len, blob_type, oid)) {
+	if (write_object_file(d->buf.buf, d->buf.len, OBJ_BLOB, oid)) {
 		int status = die_message(_("unable to write note object"));
 
 		if (d->edit_path)
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 9f4a0b816cf..231d576927b 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -762,7 +762,7 @@ static void prepare_push_cert_sha1(struct child_process *proc)
 		int bogs /* beginning_of_gpg_sig */;
 
 		already_done = 1;
-		if (write_object_file(push_cert.buf, push_cert.len, "blob",
+		if (write_object_file(push_cert.buf, push_cert.len, OBJ_BLOB,
 				      &push_cert_oid))
 			oidclr(&push_cert_oid);
 
diff --git a/builtin/replace.c b/builtin/replace.c
index 6ff1734d587..995ca683302 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -474,7 +474,7 @@ static int create_graft(int argc, const char **argv, int force, int gentle)
 		return -1;
 	}
 
-	if (write_object_file(buf.buf, buf.len, commit_type, &new_oid)) {
+	if (write_object_file(buf.buf, buf.len, OBJ_COMMIT, &new_oid)) {
 		strbuf_release(&buf);
 		return error(_("could not write replacement commit for: '%s'"),
 			     old_ref);
diff --git a/builtin/tag.c b/builtin/tag.c
index 134b3f1edf0..31e6b155c04 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -238,7 +238,7 @@ static int build_tag_object(struct strbuf *buf, int sign, struct object_id *resu
 {
 	if (sign && do_sign(buf) < 0)
 		return error(_("unable to sign the tag"));
-	if (write_object_file(buf->buf, buf->len, tag_type, result) < 0)
+	if (write_object_file(buf->buf, buf->len, OBJ_TAG, result) < 0)
 		return error(_("unable to write tag file"));
 	return 0;
 }
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 4a9466295ba..808041551fd 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -177,7 +177,7 @@ static void write_cached_object(struct object *obj, struct obj_buffer *obj_buf)
 	struct object_id oid;
 
 	if (write_object_file(obj_buf->buffer, obj_buf->size,
-			      type_name(obj->type), &oid) < 0)
+			      obj->type, &oid) < 0)
 		die("failed to write object %s", oid_to_hex(&obj->oid));
 	obj->flags |= FLAG_WRITTEN;
 }
@@ -243,7 +243,7 @@ static void write_object(unsigned nr, enum object_type type,
 			 void *buf, unsigned long size)
 {
 	if (!strict) {
-		if (write_object_file(buf, size, type_name(type),
+		if (write_object_file(buf, size, type,
 				      &obj_list[nr].oid) < 0)
 			die("failed to write object");
 		added_object(nr, type, buf, size);
@@ -251,7 +251,7 @@ static void write_object(unsigned nr, enum object_type type,
 		obj_list[nr].obj = NULL;
 	} else if (type == OBJ_BLOB) {
 		struct blob *blob;
-		if (write_object_file(buf, size, type_name(type),
+		if (write_object_file(buf, size, type,
 				      &obj_list[nr].oid) < 0)
 			die("failed to write object");
 		added_object(nr, type, buf, size);
diff --git a/cache-tree.c b/cache-tree.c
index 65ca9933613..fdbbd191d22 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -440,7 +440,7 @@ static int update_one(struct cache_tree *it,
 	} else if (dryrun) {
 		hash_object_file(the_hash_algo, buffer.buf, buffer.len,
 				 tree_type, &it->oid);
-	} else if (write_object_file_flags(buffer.buf, buffer.len, tree_type,
+	} else if (write_object_file_flags(buffer.buf, buffer.len, OBJ_TREE,
 					   &it->oid, flags & WRITE_TREE_SILENT
 					   ? HASH_SILENT : 0)) {
 		strbuf_release(&buffer);
diff --git a/commit.c b/commit.c
index a348f085b2b..6cc0ba9c11b 100644
--- a/commit.c
+++ b/commit.c
@@ -1567,7 +1567,7 @@ int commit_tree_extended(const char *msg, size_t msg_len,
 		goto out;
 	}
 
-	result = write_object_file(buffer.buf, buffer.len, commit_type, ret);
+	result = write_object_file(buffer.buf, buffer.len, OBJ_COMMIT, ret);
 out:
 	strbuf_release(&buffer);
 	return result;
diff --git a/match-trees.c b/match-trees.c
index df413989fa8..49398e599fe 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -235,7 +235,7 @@ static int splice_tree(const struct object_id *oid1, const char *prefix,
 		rewrite_with = oid2;
 	}
 	hashcpy(rewrite_here, rewrite_with->hash);
-	status = write_object_file(buf, sz, tree_type, result);
+	status = write_object_file(buf, sz, OBJ_TREE, result);
 	free(buf);
 	return status;
 }
diff --git a/merge-ort.c b/merge-ort.c
index c3197970219..d4ba2955f11 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1888,7 +1888,7 @@ static int handle_content_merge(struct merge_options *opt,
 
 		if (!ret &&
 		    write_object_file(result_buf.ptr, result_buf.size,
-				      blob_type, &result->oid))
+				      OBJ_BLOB, &result->oid))
 			ret = err(opt, _("Unable to add %s to database"),
 				  path);
 
@@ -3343,7 +3343,7 @@ static void write_tree(struct object_id *result_oid,
 	}
 
 	/* Write this object file out, and record in result_oid */
-	write_object_file(buf.buf, buf.len, tree_type, result_oid);
+	write_object_file(buf.buf, buf.len, OBJ_TREE, result_oid);
 	strbuf_release(&buf);
 }
 
diff --git a/merge-recursive.c b/merge-recursive.c
index d9457797dbb..e0cbbf2d022 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1373,7 +1373,7 @@ static int merge_mode_and_contents(struct merge_options *opt,
 
 			if (!ret &&
 			    write_object_file(result_buf.ptr, result_buf.size,
-					      blob_type, &result->blob.oid))
+					      OBJ_BLOB, &result->blob.oid))
 				ret = err(opt, _("Unable to add %s to database"),
 					  a->path);
 
diff --git a/notes-cache.c b/notes-cache.c
index 2473314d686..9dfd251a815 100644
--- a/notes-cache.c
+++ b/notes-cache.c
@@ -92,7 +92,7 @@ int notes_cache_put(struct notes_cache *c, struct object_id *key_oid,
 {
 	struct object_id value_oid;
 
-	if (write_object_file(data, size, "blob", &value_oid) < 0)
+	if (write_object_file(data, size, OBJ_BLOB, &value_oid) < 0)
 		return -1;
 	return add_note(&c->tree, key_oid, &value_oid, NULL);
 }
diff --git a/notes.c b/notes.c
index f87dac40684..7452e71cc8d 100644
--- a/notes.c
+++ b/notes.c
@@ -675,7 +675,7 @@ static int tree_write_stack_finish_subtree(struct tree_write_stack *tws)
 		ret = tree_write_stack_finish_subtree(n);
 		if (ret)
 			return ret;
-		ret = write_object_file(n->buf.buf, n->buf.len, tree_type, &s);
+		ret = write_object_file(n->buf.buf, n->buf.len, OBJ_TREE, &s);
 		if (ret)
 			return ret;
 		strbuf_release(&n->buf);
@@ -836,7 +836,7 @@ int combine_notes_concatenate(struct object_id *cur_oid,
 	free(new_msg);
 
 	/* create a new blob object from buf */
-	ret = write_object_file(buf, buf_len, blob_type, cur_oid);
+	ret = write_object_file(buf, buf_len, OBJ_BLOB, cur_oid);
 	free(buf);
 	return ret;
 }
@@ -916,7 +916,7 @@ int combine_notes_cat_sort_uniq(struct object_id *cur_oid,
 				 string_list_join_lines_helper, &buf))
 		goto out;
 
-	ret = write_object_file(buf.buf, buf.len, blob_type, cur_oid);
+	ret = write_object_file(buf.buf, buf.len, OBJ_BLOB, cur_oid);
 
 out:
 	strbuf_release(&buf);
@@ -1192,7 +1192,7 @@ int write_notes_tree(struct notes_tree *t, struct object_id *result)
 	ret = for_each_note(t, flags, write_each_note, &cb_data) ||
 	      write_each_non_note_until(NULL, &cb_data) ||
 	      tree_write_stack_finish_subtree(&root) ||
-	      write_object_file(root.buf.buf, root.buf.len, tree_type, result);
+	      write_object_file(root.buf.buf, root.buf.len, OBJ_TREE, result);
 	strbuf_release(&root.buf);
 	return ret;
 }
diff --git a/object-file.c b/object-file.c
index 3fcd46cf9ed..59eb793e0ac 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2014,7 +2014,7 @@ static int freshen_packed_object(const struct object_id *oid)
 }
 
 int write_object_file_flags(const void *buf, unsigned long len,
-			    const char *type, struct object_id *oid,
+			    enum object_type type, struct object_id *oid,
 			    unsigned flags)
 {
 	char hdr[MAX_HEADER_LEN];
@@ -2023,7 +2023,7 @@ int write_object_file_flags(const void *buf, unsigned long len,
 	/* Normally if we have it in the pack then we do not bother writing
 	 * it out into .git/objects/??/?{38} file.
 	 */
-	write_object_file_prepare(the_hash_algo, buf, len, type, oid, hdr,
+	write_object_file_prepare(the_hash_algo, buf, len, type_name(type), oid, hdr,
 				  &hdrlen);
 	if (freshen_packed_object(oid) || freshen_loose_object(oid))
 		return 0;
@@ -2162,7 +2162,7 @@ static int index_mem(struct index_state *istate,
 	}
 
 	if (write_object)
-		ret = write_object_file(buf, size, type_name(type), oid);
+		ret = write_object_file(buf, size, type, oid);
 	else
 		hash_object_file(the_hash_algo, buf, size, type_name(type),
 				 oid);
@@ -2189,7 +2189,7 @@ static int index_stream_convert_blob(struct index_state *istate,
 				 get_conv_flags(flags));
 
 	if (write_object)
-		ret = write_object_file(sbuf.buf, sbuf.len, type_name(OBJ_BLOB),
+		ret = write_object_file(sbuf.buf, sbuf.len, OBJ_BLOB,
 					oid);
 	else
 		hash_object_file(the_hash_algo, sbuf.buf, sbuf.len,
@@ -2313,7 +2313,7 @@ int index_path(struct index_state *istate, struct object_id *oid,
 		if (!(flags & HASH_WRITE_OBJECT))
 			hash_object_file(the_hash_algo, sb.buf, sb.len,
 					 blob_type, oid);
-		else if (write_object_file(sb.buf, sb.len, blob_type, oid))
+		else if (write_object_file(sb.buf, sb.len, OBJ_BLOB, oid))
 			rc = error(_("%s: failed to insert into database"), path);
 		strbuf_release(&sb);
 		break;
diff --git a/object-store.h b/object-store.h
index 8b4413d0ce7..eab1e2a967e 100644
--- a/object-store.h
+++ b/object-store.h
@@ -250,10 +250,10 @@ void hash_object_file(const struct git_hash_algo *algo, const void *buf,
 		      struct object_id *oid);
 
 int write_object_file_flags(const void *buf, unsigned long len,
-			    const char *type, struct object_id *oid,
+			    enum object_type type, struct object_id *oid,
 			    unsigned flags);
 static inline int write_object_file(const void *buf, unsigned long len,
-				    const char *type, struct object_id *oid)
+				    enum object_type type, struct object_id *oid)
 {
 	return write_object_file_flags(buf, len, type, oid, 0);
 }
diff --git a/read-cache.c b/read-cache.c
index cbe73f14e5e..b8ae30a0e71 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -735,7 +735,7 @@ static struct cache_entry *create_alias_ce(struct index_state *istate,
 void set_object_name_for_intent_to_add_entry(struct cache_entry *ce)
 {
 	struct object_id oid;
-	if (write_object_file("", 0, blob_type, &oid))
+	if (write_object_file("", 0, OBJ_BLOB, &oid))
 		die(_("cannot create an empty blob in the object database"));
 	oidcpy(&ce->oid, &oid);
 }
-- 
2.35.1.940.ge7a5b4b05f2

