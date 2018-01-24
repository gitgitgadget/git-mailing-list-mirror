Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4A691F576
	for <e@80x24.org>; Wed, 24 Jan 2018 11:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933241AbeAXLMb (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 06:12:31 -0500
Received: from mail-lf0-f47.google.com ([209.85.215.47]:39523 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933233AbeAXLMZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 06:12:25 -0500
Received: by mail-lf0-f47.google.com with SMTP id w27so3455821lfd.6
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 03:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
         :references;
        bh=Lf/wxNLOaRIbjnJKLRPs2MnBVRuQP64PDjjKeP3YlOo=;
        b=RmLeYLrGpsTdTZiC+UPojVQox9e5H47yysllsn69ucWehnQQksJ8C0NWcknr7Pj0Dm
         bHI+C/+zfs+tSrLtmf3r90UmkA0QqY5D6WtiXKajM2XUBsq88WwKiKnFBnLfcEISYgE0
         1KPrbNax6hD5bUdThNjEfoxPd0yB6YE2YZWComwccI2mDXjJsT4i7wPLDxxViqTBV5IQ
         A2u4m09lrWwEskMQrt1O3y62O2Jc3GryXNWl4KmM4IyRKTON0JdaCp+Vq9FkyZII46Pk
         ozhPR+BytCyJ0YFZnVMZd8FPWcwVDLSzLt98pJc+l5iVRiV7Hij3f2OT9A3Zpbe4D21X
         vLMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Lf/wxNLOaRIbjnJKLRPs2MnBVRuQP64PDjjKeP3YlOo=;
        b=kvl/Ww1p3LyD1pNZ1stsv7GclJYaTG5VVWpKh3NJn7VPEzzdw1D9KB0jN04ib+kgOO
         ivuaHl0pVrxqWpZnj29krjeUC6xkLiFGNMTo17FUWIAeKIBvqDONiAxdzLOzydfxRyGM
         zijDb4JPRD3f0ivHdZ0tNw2iLLVgyB4BCTLu88mW+2+bJusyMzqBhkCK5oeTp5WNt+3E
         OjnrDaJfpttiKRSjvqsZ5q4qOlLyD1zljKDQAzHAJARQNV1BsPvWrdGKXlRmTYaZsgRu
         4HaAGLkQmN70SRek7rigRyPjcfuTo6W5Y0m8bK0QqMpKcA3LJNqTU+EzVXhzz2S9NSJ/
         nGLg==
X-Gm-Message-State: AKwxytf3X4PfsMF2NtrbzfG6oGpfQ1bvThxqT2LDAkW7D66noxN4TUKJ
        kbNZD3q7L1Em+vK8plm7tBOHYLvb
X-Google-Smtp-Source: AH8x227Suvz5qMApS8+PzxoUGZVbZQrbcoJjl8h6KmhQSF0KyxFYVw5k05VDq2UnysQbcDzO9t6pog==
X-Received: by 10.25.193.204 with SMTP id r195mr3207322lff.37.1516792343011;
        Wed, 24 Jan 2018 03:12:23 -0800 (PST)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id i18sm14426ljd.27.2018.01.24.03.12.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jan 2018 03:12:22 -0800 (PST)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v3 11/14] sha1_file: convert write_sha1_file to object_id
Date:   Wed, 24 Jan 2018 12:12:03 +0100
Message-Id: <dd0ead35f17d76f891f591ae9d15b75b711f6c7f.1516790478.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <cover.1516790478.git.patryk.obara@gmail.com>
References: <cover.1516617960.git.patryk.obara@gmail.com>
 <cover.1516790478.git.patryk.obara@gmail.com>
In-Reply-To: <cover.1516790478.git.patryk.obara@gmail.com>
References: <cover.1516790478.git.patryk.obara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the definition and declaration of write_sha1_file to
struct object_id and adjust usage of this function.

This commit also converts static function write_sha1_file_prepare, as it
is closely related.

Rename these functions to write_object_file and
write_object_file_prepare respectively.

Replace sha1_to_hex, hashcpy and hashclr with their oid equivalents
wherever possible.

Signed-off-by: Patryk Obara <patryk.obara@gmail.com>
---
 apply.c                  |  8 ++++----
 builtin/checkout.c       |  3 +--
 builtin/mktag.c          |  6 +++---
 builtin/mktree.c         | 10 +++++-----
 builtin/notes.c          |  8 ++++----
 builtin/receive-pack.c   | 11 ++++++-----
 builtin/replace.c        |  2 +-
 builtin/tag.c            |  2 +-
 builtin/unpack-objects.c |  9 ++++++---
 cache-tree.c             |  5 +++--
 cache.h                  |  4 +++-
 commit.c                 |  2 +-
 match-trees.c            |  2 +-
 merge-recursive.c        |  5 +++--
 notes-cache.c            |  2 +-
 notes.c                  |  9 ++++-----
 read-cache.c             |  6 +++---
 sha1_file.c              | 29 +++++++++++++++--------------
 18 files changed, 65 insertions(+), 58 deletions(-)

diff --git a/apply.c b/apply.c
index 57ab8a8a29..4cd4504008 100644
--- a/apply.c
+++ b/apply.c
@@ -3554,7 +3554,7 @@ static int try_threeway(struct apply_state *state,
 
 	/* Preimage the patch was prepared for */
 	if (patch->is_new)
-		write_sha1_file("", 0, blob_type, pre_oid.hash);
+		write_object_file("", 0, blob_type, &pre_oid);
 	else if (get_oid(patch->old_sha1_prefix, &pre_oid) ||
 		 read_blob_object(&buf, &pre_oid, patch->old_mode))
 		return error(_("repository lacks the necessary blob to fall back on 3-way merge."));
@@ -3570,7 +3570,7 @@ static int try_threeway(struct apply_state *state,
 		return -1;
 	}
 	/* post_oid is theirs */
-	write_sha1_file(tmp_image.buf, tmp_image.len, blob_type, post_oid.hash);
+	write_object_file(tmp_image.buf, tmp_image.len, blob_type, &post_oid);
 	clear_image(&tmp_image);
 
 	/* our_oid is ours */
@@ -3583,7 +3583,7 @@ static int try_threeway(struct apply_state *state,
 			return error(_("cannot read the current contents of '%s'"),
 				     patch->old_name);
 	}
-	write_sha1_file(tmp_image.buf, tmp_image.len, blob_type, our_oid.hash);
+	write_object_file(tmp_image.buf, tmp_image.len, blob_type, &our_oid);
 	clear_image(&tmp_image);
 
 	/* in-core three-way merge between post and our using pre as base */
@@ -4291,7 +4291,7 @@ static int add_index_file(struct apply_state *state,
 			}
 			fill_stat_cache_info(ce, &st);
 		}
-		if (write_sha1_file(buf, size, blob_type, ce->oid.hash) < 0) {
+		if (write_object_file(buf, size, blob_type, &ce->oid) < 0) {
 			free(ce);
 			return error(_("unable to create backing store "
 				       "for newly created file %s"), path);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index c54c78df54..191b96c49c 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -227,8 +227,7 @@ static int checkout_merged(int pos, const struct checkout *state)
 	 * (it also writes the merge result to the object database even
 	 * when it may contain conflicts).
 	 */
-	if (write_sha1_file(result_buf.ptr, result_buf.size,
-			    blob_type, oid.hash))
+	if (write_object_file(result_buf.ptr, result_buf.size, blob_type, &oid))
 		die(_("Unable to add merge result for '%s'"), path);
 	free(result_buf.ptr);
 	ce = make_cache_entry(mode, oid.hash, path, 2, 0);
diff --git a/builtin/mktag.c b/builtin/mktag.c
index 031b750f06..beb552847b 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -151,7 +151,7 @@ static int verify_tag(char *buffer, unsigned long size)
 int cmd_mktag(int argc, const char **argv, const char *prefix)
 {
 	struct strbuf buf = STRBUF_INIT;
-	unsigned char result_sha1[20];
+	struct object_id result;
 
 	if (argc != 1)
 		usage("git mktag");
@@ -165,10 +165,10 @@ int cmd_mktag(int argc, const char **argv, const char *prefix)
 	if (verify_tag(buf.buf, buf.len) < 0)
 		die("invalid tag signature file");
 
-	if (write_sha1_file(buf.buf, buf.len, tag_type, result_sha1) < 0)
+	if (write_object_file(buf.buf, buf.len, tag_type, &result) < 0)
 		die("unable to write tag file");
 
 	strbuf_release(&buf);
-	printf("%s\n", sha1_to_hex(result_sha1));
+	printf("%s\n", oid_to_hex(&result));
 	return 0;
 }
diff --git a/builtin/mktree.c b/builtin/mktree.c
index da0fd8cd70..8dd9f52f77 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -40,7 +40,7 @@ static int ent_compare(const void *a_, const void *b_)
 				 b->name, b->len, b->mode);
 }
 
-static void write_tree(unsigned char *sha1)
+static void write_tree(struct object_id *oid)
 {
 	struct strbuf buf;
 	size_t size;
@@ -57,7 +57,7 @@ static void write_tree(unsigned char *sha1)
 		strbuf_add(&buf, ent->sha1, 20);
 	}
 
-	write_sha1_file(buf.buf, buf.len, tree_type, sha1);
+	write_object_file(buf.buf, buf.len, tree_type, oid);
 	strbuf_release(&buf);
 }
 
@@ -142,7 +142,7 @@ static void mktree_line(char *buf, size_t len, int nul_term_line, int allow_miss
 int cmd_mktree(int ac, const char **av, const char *prefix)
 {
 	struct strbuf sb = STRBUF_INIT;
-	unsigned char sha1[20];
+	struct object_id oid;
 	int nul_term_line = 0;
 	int allow_missing = 0;
 	int is_batch_mode = 0;
@@ -181,8 +181,8 @@ int cmd_mktree(int ac, const char **av, const char *prefix)
 			 */
 			; /* skip creating an empty tree */
 		} else {
-			write_tree(sha1);
-			puts(sha1_to_hex(sha1));
+			write_tree(&oid);
+			puts(oid_to_hex(&oid));
 			fflush(stdout);
 		}
 		used=0; /* reset tree entry buffer for re-use in batch mode */
diff --git a/builtin/notes.c b/builtin/notes.c
index 7c81761645..39304ba743 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -198,9 +198,9 @@ static void prepare_note_data(const struct object_id *object, struct note_data *
 	}
 }
 
-static void write_note_data(struct note_data *d, unsigned char *sha1)
+static void write_note_data(struct note_data *d, struct object_id *oid)
 {
-	if (write_sha1_file(d->buf.buf, d->buf.len, blob_type, sha1)) {
+	if (write_object_file(d->buf.buf, d->buf.len, blob_type, oid)) {
 		error(_("unable to write note object"));
 		if (d->edit_path)
 			error(_("the note contents have been left in %s"),
@@ -459,7 +459,7 @@ static int add(int argc, const char **argv, const char *prefix)
 
 	prepare_note_data(&object, &d, note ? note->hash : NULL);
 	if (d.buf.len || allow_empty) {
-		write_note_data(&d, new_note.hash);
+		write_note_data(&d, &new_note);
 		if (add_note(t, &object, &new_note, combine_notes_overwrite))
 			die("BUG: combine_notes_overwrite failed");
 		commit_notes(t, "Notes added by 'git notes add'");
@@ -619,7 +619,7 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 	}
 
 	if (d.buf.len || allow_empty) {
-		write_note_data(&d, new_note.hash);
+		write_note_data(&d, &new_note);
 		if (add_note(t, &object, &new_note, combine_notes_overwrite))
 			die("BUG: combine_notes_overwrite failed");
 		logmsg = xstrfmt("Notes added by 'git notes %s'", argv[0]);
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index b7ce7c7f52..75e7f18ace 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -69,7 +69,7 @@ static int sent_capabilities;
 static int shallow_update;
 static const char *alt_shallow_file;
 static struct strbuf push_cert = STRBUF_INIT;
-static unsigned char push_cert_sha1[20];
+static struct object_id push_cert_oid;
 static struct signature_check sigcheck;
 static const char *push_cert_nonce;
 static const char *cert_nonce_seed;
@@ -633,8 +633,9 @@ static void prepare_push_cert_sha1(struct child_process *proc)
 		int bogs /* beginning_of_gpg_sig */;
 
 		already_done = 1;
-		if (write_sha1_file(push_cert.buf, push_cert.len, "blob", push_cert_sha1))
-			hashclr(push_cert_sha1);
+		if (write_object_file(push_cert.buf, push_cert.len, "blob",
+				      &push_cert_oid))
+			oidclr(&push_cert_oid);
 
 		memset(&sigcheck, '\0', sizeof(sigcheck));
 		sigcheck.result = 'N';
@@ -655,9 +656,9 @@ static void prepare_push_cert_sha1(struct child_process *proc)
 		strbuf_release(&gpg_status);
 		nonce_status = check_nonce(push_cert.buf, bogs);
 	}
-	if (!is_null_sha1(push_cert_sha1)) {
+	if (!is_null_oid(&push_cert_oid)) {
 		argv_array_pushf(&proc->env_array, "GIT_PUSH_CERT=%s",
-				 sha1_to_hex(push_cert_sha1));
+				 oid_to_hex(&push_cert_oid));
 		argv_array_pushf(&proc->env_array, "GIT_PUSH_CERT_SIGNER=%s",
 				 sigcheck.signer ? sigcheck.signer : "");
 		argv_array_pushf(&proc->env_array, "GIT_PUSH_CERT_KEY=%s",
diff --git a/builtin/replace.c b/builtin/replace.c
index 814bf6bfde..83d3235721 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -410,7 +410,7 @@ static int create_graft(int argc, const char **argv, int force)
 
 	check_mergetags(commit, argc, argv);
 
-	if (write_sha1_file(buf.buf, buf.len, commit_type, new.hash))
+	if (write_object_file(buf.buf, buf.len, commit_type, &new))
 		die(_("could not write replacement commit for: '%s'"), old_ref);
 
 	strbuf_release(&buf);
diff --git a/builtin/tag.c b/builtin/tag.c
index a7e6a5b0f2..8885e21ddc 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -187,7 +187,7 @@ static int build_tag_object(struct strbuf *buf, int sign, struct object_id *resu
 {
 	if (sign && do_sign(buf) < 0)
 		return error(_("unable to sign the tag"));
-	if (write_sha1_file(buf->buf, buf->len, tag_type, result->hash) < 0)
+	if (write_object_file(buf->buf, buf->len, tag_type, result) < 0)
 		return error(_("unable to write tag file"));
 	return 0;
 }
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 85a40d1af7..397371eb3d 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -172,7 +172,8 @@ static void write_cached_object(struct object *obj, struct obj_buffer *obj_buf)
 {
 	struct object_id oid;
 
-	if (write_sha1_file(obj_buf->buffer, obj_buf->size, typename(obj->type), oid.hash) < 0)
+	if (write_object_file(obj_buf->buffer, obj_buf->size,
+			      typename(obj->type), &oid) < 0)
 		die("failed to write object %s", oid_to_hex(&obj->oid));
 	obj->flags |= FLAG_WRITTEN;
 }
@@ -237,14 +238,16 @@ static void write_object(unsigned nr, enum object_type type,
 			 void *buf, unsigned long size)
 {
 	if (!strict) {
-		if (write_sha1_file(buf, size, typename(type), obj_list[nr].oid.hash) < 0)
+		if (write_object_file(buf, size, typename(type),
+				      &obj_list[nr].oid) < 0)
 			die("failed to write object");
 		added_object(nr, type, buf, size);
 		free(buf);
 		obj_list[nr].obj = NULL;
 	} else if (type == OBJ_BLOB) {
 		struct blob *blob;
-		if (write_sha1_file(buf, size, typename(type), obj_list[nr].oid.hash) < 0)
+		if (write_object_file(buf, size, typename(type),
+				      &obj_list[nr].oid) < 0)
 			die("failed to write object");
 		added_object(nr, type, buf, size);
 		free(buf);
diff --git a/cache-tree.c b/cache-tree.c
index 6574eeb80d..597114f604 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -406,9 +406,10 @@ static int update_one(struct cache_tree *it,
 			oidcpy(&it->oid, &oid);
 		else
 			to_invalidate = 1;
-	} else if (dryrun)
+	} else if (dryrun) {
 		hash_object_file(buffer.buf, buffer.len, tree_type, &it->oid);
-	else if (write_sha1_file(buffer.buf, buffer.len, tree_type, it->oid.hash)) {
+	} else if (write_object_file(buffer.buf, buffer.len, tree_type,
+				     &it->oid)) {
 		strbuf_release(&buffer);
 		return -1;
 	}
diff --git a/cache.h b/cache.h
index d5d78d6a51..d80141eb64 100644
--- a/cache.h
+++ b/cache.h
@@ -1240,7 +1240,9 @@ extern int sha1_object_info(const unsigned char *, unsigned long *);
 extern int hash_object_file(const void *buf, unsigned long len,
 			    const char *type, struct object_id *oid);
 
-extern int write_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *return_sha1);
+extern int write_object_file(const void *buf, unsigned long len,
+			     const char *type, struct object_id *oid);
+
 extern int hash_sha1_file_literally(const void *buf, unsigned long len, const char *type, struct object_id *oid, unsigned flags);
 
 extern int pretend_object_file(void *, unsigned long, enum object_type,
diff --git a/commit.c b/commit.c
index 643f3daec3..0d32532872 100644
--- a/commit.c
+++ b/commit.c
@@ -1567,7 +1567,7 @@ int commit_tree_extended(const char *msg, size_t msg_len,
 		goto out;
 	}
 
-	result = write_sha1_file(buffer.buf, buffer.len, commit_type, ret->hash);
+	result = write_object_file(buffer.buf, buffer.len, commit_type, ret);
 out:
 	strbuf_release(&buffer);
 	return result;
diff --git a/match-trees.c b/match-trees.c
index afb771c4f5..0ca99d5162 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -214,7 +214,7 @@ static int splice_tree(const struct object_id *oid1, const char *prefix,
 		rewrite_with = oid2;
 	}
 	oidcpy(rewrite_here, rewrite_with);
-	status = write_sha1_file(buf, sz, tree_type, result->hash);
+	status = write_object_file(buf, sz, tree_type, result);
 	free(buf);
 	return status;
 }
diff --git a/merge-recursive.c b/merge-recursive.c
index cc5fa0a949..fe3c0c8076 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1009,8 +1009,9 @@ static int merge_file_1(struct merge_options *o,
 			if ((merge_status < 0) || !result_buf.ptr)
 				ret = err(o, _("Failed to execute internal merge"));
 
-			if (!ret && write_sha1_file(result_buf.ptr, result_buf.size,
-						    blob_type, result->oid.hash))
+			if (!ret &&
+			    write_object_file(result_buf.ptr, result_buf.size,
+					      blob_type, &result->oid))
 				ret = err(o, _("Unable to add %s to database"),
 					  a->path);
 
diff --git a/notes-cache.c b/notes-cache.c
index 010ad236cb..398e61d5e9 100644
--- a/notes-cache.c
+++ b/notes-cache.c
@@ -88,7 +88,7 @@ int notes_cache_put(struct notes_cache *c, struct object_id *key_oid,
 {
 	struct object_id value_oid;
 
-	if (write_sha1_file(data, size, "blob", value_oid.hash) < 0)
+	if (write_object_file(data, size, "blob", &value_oid) < 0)
 		return -1;
 	return add_note(&c->tree, key_oid, &value_oid, NULL);
 }
diff --git a/notes.c b/notes.c
index 09ef1ce33a..ce9a8f53f8 100644
--- a/notes.c
+++ b/notes.c
@@ -667,7 +667,7 @@ static int tree_write_stack_finish_subtree(struct tree_write_stack *tws)
 		ret = tree_write_stack_finish_subtree(n);
 		if (ret)
 			return ret;
-		ret = write_sha1_file(n->buf.buf, n->buf.len, tree_type, s.hash);
+		ret = write_object_file(n->buf.buf, n->buf.len, tree_type, &s);
 		if (ret)
 			return ret;
 		strbuf_release(&n->buf);
@@ -825,7 +825,7 @@ int combine_notes_concatenate(struct object_id *cur_oid,
 	free(new_msg);
 
 	/* create a new blob object from buf */
-	ret = write_sha1_file(buf, buf_len, blob_type, cur_oid->hash);
+	ret = write_object_file(buf, buf_len, blob_type, cur_oid);
 	free(buf);
 	return ret;
 }
@@ -905,7 +905,7 @@ int combine_notes_cat_sort_uniq(struct object_id *cur_oid,
 				 string_list_join_lines_helper, &buf))
 		goto out;
 
-	ret = write_sha1_file(buf.buf, buf.len, blob_type, cur_oid->hash);
+	ret = write_object_file(buf.buf, buf.len, blob_type, cur_oid);
 
 out:
 	strbuf_release(&buf);
@@ -1147,8 +1147,7 @@ int write_notes_tree(struct notes_tree *t, struct object_id *result)
 	ret = for_each_note(t, flags, write_each_note, &cb_data) ||
 	      write_each_non_note_until(NULL, &cb_data) ||
 	      tree_write_stack_finish_subtree(&root) ||
-	      write_sha1_file(root.buf.buf, root.buf.len, tree_type,
-			      result->hash);
+	      write_object_file(root.buf.buf, root.buf.len, tree_type, result);
 	strbuf_release(&root.buf);
 	return ret;
 }
diff --git a/read-cache.c b/read-cache.c
index 2eb81a66b9..01bcf7dd84 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -631,10 +631,10 @@ static struct cache_entry *create_alias_ce(struct index_state *istate,
 
 void set_object_name_for_intent_to_add_entry(struct cache_entry *ce)
 {
-	unsigned char sha1[20];
-	if (write_sha1_file("", 0, blob_type, sha1))
+	struct object_id oid;
+	if (write_object_file("", 0, blob_type, &oid))
 		die("cannot create an empty blob in the object database");
-	hashcpy(ce->oid.hash, sha1);
+	oidcpy(&ce->oid, &oid);
 }
 
 int add_to_index(struct index_state *istate, const char *path, struct stat *st, int flags)
diff --git a/sha1_file.c b/sha1_file.c
index 4c44c60cec..d1569b1b96 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1419,9 +1419,9 @@ void *read_object_with_reference(const unsigned char *sha1,
 	}
 }
 
-static void write_sha1_file_prepare(const void *buf, unsigned long len,
-                                    const char *type, unsigned char *sha1,
-                                    char *hdr, int *hdrlen)
+static void write_object_file_prepare(const void *buf, unsigned long len,
+				      const char *type, struct object_id *oid,
+				      char *hdr, int *hdrlen)
 {
 	git_SHA_CTX c;
 
@@ -1432,7 +1432,7 @@ static void write_sha1_file_prepare(const void *buf, unsigned long len,
 	git_SHA1_Init(&c);
 	git_SHA1_Update(&c, hdr, *hdrlen);
 	git_SHA1_Update(&c, buf, len);
-	git_SHA1_Final(sha1, &c);
+	git_SHA1_Final(oid->hash, &c);
 }
 
 /*
@@ -1490,7 +1490,7 @@ int hash_object_file(const void *buf, unsigned long len, const char *type,
 {
 	char hdr[32];
 	int hdrlen = sizeof(hdr);
-	write_sha1_file_prepare(buf, len, type, oid->hash, hdr, &hdrlen);
+	write_object_file_prepare(buf, len, type, oid, hdr, &hdrlen);
 	return 0;
 }
 
@@ -1633,7 +1633,8 @@ static int freshen_packed_object(const unsigned char *sha1)
 	return 1;
 }
 
-int write_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *sha1)
+int write_object_file(const void *buf, unsigned long len, const char *type,
+		      struct object_id *oid)
 {
 	char hdr[32];
 	int hdrlen = sizeof(hdr);
@@ -1641,10 +1642,10 @@ int write_sha1_file(const void *buf, unsigned long len, const char *type, unsign
 	/* Normally if we have it in the pack then we do not bother writing
 	 * it out into .git/objects/??/?{38} file.
 	 */
-	write_sha1_file_prepare(buf, len, type, sha1, hdr, &hdrlen);
-	if (freshen_packed_object(sha1) || freshen_loose_object(sha1))
+	write_object_file_prepare(buf, len, type, oid, hdr, &hdrlen);
+	if (freshen_packed_object(oid->hash) || freshen_loose_object(oid->hash))
 		return 0;
-	return write_loose_object(sha1, hdr, hdrlen, buf, len, 0);
+	return write_loose_object(oid->hash, hdr, hdrlen, buf, len, 0);
 }
 
 int hash_sha1_file_literally(const void *buf, unsigned long len, const char *type,
@@ -1656,7 +1657,7 @@ int hash_sha1_file_literally(const void *buf, unsigned long len, const char *typ
 	/* type string, SP, %lu of the length plus NUL must fit this */
 	hdrlen = strlen(type) + 32;
 	header = xmalloc(hdrlen);
-	write_sha1_file_prepare(buf, len, type, oid->hash, header, &hdrlen);
+	write_object_file_prepare(buf, len, type, oid, header, &hdrlen);
 
 	if (!(flags & HASH_WRITE_OBJECT))
 		goto cleanup;
@@ -1767,7 +1768,7 @@ static int index_mem(struct object_id *oid, void *buf, size_t size,
 	}
 
 	if (write_object)
-		ret = write_sha1_file(buf, size, typename(type), oid->hash);
+		ret = write_object_file(buf, size, typename(type), oid);
 	else
 		ret = hash_object_file(buf, size, typename(type), oid);
 	if (re_allocated)
@@ -1789,8 +1790,8 @@ static int index_stream_convert_blob(struct object_id *oid, int fd,
 				 get_safe_crlf(flags));
 
 	if (write_object)
-		ret = write_sha1_file(sbuf.buf, sbuf.len, typename(OBJ_BLOB),
-				      oid->hash);
+		ret = write_object_file(sbuf.buf, sbuf.len, typename(OBJ_BLOB),
+					oid);
 	else
 		ret = hash_object_file(sbuf.buf, sbuf.len, typename(OBJ_BLOB),
 				       oid);
@@ -1908,7 +1909,7 @@ int index_path(struct object_id *oid, const char *path, struct stat *st, unsigne
 			return error_errno("readlink(\"%s\")", path);
 		if (!(flags & HASH_WRITE_OBJECT))
 			hash_object_file(sb.buf, sb.len, blob_type, oid);
-		else if (write_sha1_file(sb.buf, sb.len, blob_type, oid->hash))
+		else if (write_object_file(sb.buf, sb.len, blob_type, oid))
 			rc = error("%s: failed to insert into database", path);
 		strbuf_release(&sb);
 		break;
-- 
2.14.3

