Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB57C433DF
	for <git@archiver.kernel.org>; Mon, 18 May 2020 20:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEBB82081A
	for <git@archiver.kernel.org>; Mon, 18 May 2020 20:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u8TRIdMg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgERUb3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 16:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbgERUb3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 16:31:29 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8AFC061A0C
        for <git@vger.kernel.org>; Mon, 18 May 2020 13:31:29 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id f13so797502wmc.5
        for <git@vger.kernel.org>; Mon, 18 May 2020 13:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=52r6GOi4esQrwaK7fB49N4Lj/9j52h+KAqtmmANsiMc=;
        b=u8TRIdMgdLR+eTHeYJ2fj11ZTHJid0rm6zBPeJZeLx0q+mkjS/aWGgZgb/Hci/dEYv
         sbWjRe1qF0xxzE6JyPKlSQCuLXzggmCUSmKL3w23dBzxJmt7QK5ZYIar9CszUzjYP5SY
         2EX35Uq0qhDfKlqcJrVzpUcwjyf0wTagAF2sNXc5n6gIYSCrAiuX2GtyUDsWiUGNNFUr
         XN/SHS2GT0xRIRRIKGrkxGE3Fp/Sms2uouIORFfOxEylTkIHfCpYnu374TS4AEuCIJhT
         zrxfdlRh4fzY3Fw5n1akOdpMOCX9o7StiZ4lJ7kziZNrRFfCrE6F9lTcIm21R7+zcbWi
         EBqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=52r6GOi4esQrwaK7fB49N4Lj/9j52h+KAqtmmANsiMc=;
        b=Y039gwH8nwDJ2M9pLTD3gfiL2+fdzAd8usN1I4K7fpMqguKbxNCucPow/V0rUpRn74
         eZgZxDkynUpbRgqQoBdGllZvMmFTdxCibWKI/Bn8k+gx+uiDCN00pKC/yAB+G9JtX4JZ
         7OKebnAL4nrbblWdLbG3wNc9TeUtxGsxu2qMDijnafVI9uePMnCIx2QTccqlp9F+VsQd
         GnBJnIKtXZtv3BXiPk+zAZfbhwL8jKEwy9JMttrh+/60il0b8a23Ju06DufJS9WbvOgu
         YTbHcrbLuGDto+UZNoyy0sXhimC03oLjbZSVfKWo9Q1IOy2BhiNClhbzv+ZUhA7SB0M5
         /T3A==
X-Gm-Message-State: AOAM531q1rl2f6L7NCS8VD6KqVZQgWSlujTbauIGZeQXC91uQjghHf8n
        9k9o5ZnMNy89ZA+0t8TEVaWZp0Y8
X-Google-Smtp-Source: ABdhPJy9WT2q2El3qYKxNfSOyKHqA8Tg3s2LscswkAWSK5mbHFoPu6CHcldEgUYnkgDxLCeLDUvZig==
X-Received: by 2002:a1c:2843:: with SMTP id o64mr1207761wmo.158.1589833887355;
        Mon, 18 May 2020 13:31:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a13sm17458715wrv.67.2020.05.18.13.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 13:31:26 -0700 (PDT)
Message-Id: <46d04f6740ebd9cfe4f9127942d5ac6482c57550.1589833884.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v14.git.1589833884.gitgitgadget@gmail.com>
References: <pull.539.v13.git.1589226388.gitgitgadget@gmail.com>
        <pull.539.v14.git.1589833884.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 18 May 2020 20:31:16 +0000
Subject: [PATCH v14 1/9] Write pseudorefs through ref backends.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Pseudorefs store transient data in in the repository. Examples are HEAD,
CHERRY_PICK_HEAD, etc.

These refs have always been read through the ref backends, but they were written
in a one-off routine that wrote a object ID or symref directly wrote into
.git/<pseudo_ref_name>.

This causes problems when introducing a new ref storage backend. To remedy this,
extend the ref backend implementation with a write_pseudoref_fn and
update_pseudoref_fn.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs.c                | 114 +++++++-----------------------------------
 refs.h                |  11 ++++
 refs/files-backend.c  | 114 +++++++++++++++++++++++++++++++++++++++++-
 refs/packed-backend.c |  21 +++++++-
 refs/refs-internal.h  |  12 +++++
 5 files changed, 173 insertions(+), 99 deletions(-)

diff --git a/refs.c b/refs.c
index 224ff66c7bb..4acc22373e4 100644
--- a/refs.c
+++ b/refs.c
@@ -739,101 +739,6 @@ long get_files_ref_lock_timeout_ms(void)
 	return timeout_ms;
 }
 
-static int write_pseudoref(const char *pseudoref, const struct object_id *oid,
-			   const struct object_id *old_oid, struct strbuf *err)
-{
-	const char *filename;
-	int fd;
-	struct lock_file lock = LOCK_INIT;
-	struct strbuf buf = STRBUF_INIT;
-	int ret = -1;
-
-	if (!oid)
-		return 0;
-
-	strbuf_addf(&buf, "%s\n", oid_to_hex(oid));
-
-	filename = git_path("%s", pseudoref);
-	fd = hold_lock_file_for_update_timeout(&lock, filename, 0,
-					       get_files_ref_lock_timeout_ms());
-	if (fd < 0) {
-		strbuf_addf(err, _("could not open '%s' for writing: %s"),
-			    filename, strerror(errno));
-		goto done;
-	}
-
-	if (old_oid) {
-		struct object_id actual_old_oid;
-
-		if (read_ref(pseudoref, &actual_old_oid)) {
-			if (!is_null_oid(old_oid)) {
-				strbuf_addf(err, _("could not read ref '%s'"),
-					    pseudoref);
-				rollback_lock_file(&lock);
-				goto done;
-			}
-		} else if (is_null_oid(old_oid)) {
-			strbuf_addf(err, _("ref '%s' already exists"),
-				    pseudoref);
-			rollback_lock_file(&lock);
-			goto done;
-		} else if (!oideq(&actual_old_oid, old_oid)) {
-			strbuf_addf(err, _("unexpected object ID when writing '%s'"),
-				    pseudoref);
-			rollback_lock_file(&lock);
-			goto done;
-		}
-	}
-
-	if (write_in_full(fd, buf.buf, buf.len) < 0) {
-		strbuf_addf(err, _("could not write to '%s'"), filename);
-		rollback_lock_file(&lock);
-		goto done;
-	}
-
-	commit_lock_file(&lock);
-	ret = 0;
-done:
-	strbuf_release(&buf);
-	return ret;
-}
-
-static int delete_pseudoref(const char *pseudoref, const struct object_id *old_oid)
-{
-	const char *filename;
-
-	filename = git_path("%s", pseudoref);
-
-	if (old_oid && !is_null_oid(old_oid)) {
-		struct lock_file lock = LOCK_INIT;
-		int fd;
-		struct object_id actual_old_oid;
-
-		fd = hold_lock_file_for_update_timeout(
-				&lock, filename, 0,
-				get_files_ref_lock_timeout_ms());
-		if (fd < 0) {
-			error_errno(_("could not open '%s' for writing"),
-				    filename);
-			return -1;
-		}
-		if (read_ref(pseudoref, &actual_old_oid))
-			die(_("could not read ref '%s'"), pseudoref);
-		if (!oideq(&actual_old_oid, old_oid)) {
-			error(_("unexpected object ID when deleting '%s'"),
-			      pseudoref);
-			rollback_lock_file(&lock);
-			return -1;
-		}
-
-		unlink(filename);
-		rollback_lock_file(&lock);
-	} else {
-		unlink(filename);
-	}
-
-	return 0;
-}
 
 int refs_delete_ref(struct ref_store *refs, const char *msg,
 		    const char *refname,
@@ -845,7 +750,7 @@ int refs_delete_ref(struct ref_store *refs, const char *msg,
 
 	if (ref_type(refname) == REF_TYPE_PSEUDOREF) {
 		assert(refs == get_main_ref_store(the_repository));
-		return delete_pseudoref(refname, old_oid);
+		return ref_store_delete_pseudoref(refs, refname, old_oid);
 	}
 
 	transaction = ref_store_transaction_begin(refs, &err);
@@ -1172,7 +1077,8 @@ int refs_update_ref(struct ref_store *refs, const char *msg,
 
 	if (ref_type(refname) == REF_TYPE_PSEUDOREF) {
 		assert(refs == get_main_ref_store(the_repository));
-		ret = write_pseudoref(refname, new_oid, old_oid, &err);
+		ret = ref_store_write_pseudoref(refs, refname, new_oid, old_oid,
+						&err);
 	} else {
 		t = ref_store_transaction_begin(refs, &err);
 		if (!t ||
@@ -1441,6 +1347,20 @@ int head_ref(each_ref_fn fn, void *cb_data)
 	return refs_head_ref(get_main_ref_store(the_repository), fn, cb_data);
 }
 
+int ref_store_write_pseudoref(struct ref_store *refs, const char *pseudoref,
+			      const struct object_id *oid,
+			      const struct object_id *old_oid,
+			      struct strbuf *err)
+{
+	return refs->be->write_pseudoref(refs, pseudoref, oid, old_oid, err);
+}
+
+int ref_store_delete_pseudoref(struct ref_store *refs, const char *pseudoref,
+			       const struct object_id *old_oid)
+{
+	return refs->be->delete_pseudoref(refs, pseudoref, old_oid);
+}
+
 struct ref_iterator *refs_ref_iterator_begin(
 		struct ref_store *refs,
 		const char *prefix, int trim, int flags)
diff --git a/refs.h b/refs.h
index 99ba9e331e5..d1d9361441b 100644
--- a/refs.h
+++ b/refs.h
@@ -728,6 +728,17 @@ int update_ref(const char *msg, const char *refname,
 	       const struct object_id *new_oid, const struct object_id *old_oid,
 	       unsigned int flags, enum action_on_err onerr);
 
+/* Pseudorefs (eg. HEAD, CHERRY_PICK_HEAD) have a separate routines for updating
+   and deletion as they cannot take part in normal transactional updates.
+   Pseudorefs should only be written for the main repository.
+*/
+int ref_store_write_pseudoref(struct ref_store *refs, const char *pseudoref,
+			      const struct object_id *oid,
+			      const struct object_id *old_oid,
+			      struct strbuf *err);
+int ref_store_delete_pseudoref(struct ref_store *refs, const char *pseudoref,
+			       const struct object_id *old_oid);
+
 int parse_hide_refs_config(const char *var, const char *value, const char *);
 
 /*
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 6516c7bc8c8..df7553f4cc3 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -731,6 +731,115 @@ static int lock_raw_ref(struct files_ref_store *refs,
 	return ret;
 }
 
+static int files_write_pseudoref(struct ref_store *ref_store,
+				 const char *pseudoref,
+				 const struct object_id *oid,
+				 const struct object_id *old_oid,
+				 struct strbuf *err)
+{
+	struct files_ref_store *refs =
+		files_downcast(ref_store, REF_STORE_READ, "write_pseudoref");
+	int fd;
+	struct lock_file lock = LOCK_INIT;
+	struct strbuf filename = STRBUF_INIT;
+	struct strbuf buf = STRBUF_INIT;
+	int ret = -1;
+
+	if (!oid)
+		return 0;
+
+	strbuf_addf(&filename, "%s/%s", refs->gitdir, pseudoref);
+	fd = hold_lock_file_for_update_timeout(&lock, filename.buf, 0,
+					       get_files_ref_lock_timeout_ms());
+	if (fd < 0) {
+		strbuf_addf(err, _("could not open '%s' for writing: %s"),
+			    buf.buf, strerror(errno));
+		goto done;
+	}
+
+	if (old_oid) {
+		struct object_id actual_old_oid;
+
+		if (read_ref(pseudoref, &actual_old_oid)) {
+			if (!is_null_oid(old_oid)) {
+				strbuf_addf(err, _("could not read ref '%s'"),
+					    pseudoref);
+				rollback_lock_file(&lock);
+				goto done;
+			}
+		} else if (is_null_oid(old_oid)) {
+			strbuf_addf(err, _("ref '%s' already exists"),
+				    pseudoref);
+			rollback_lock_file(&lock);
+			goto done;
+		} else if (!oideq(&actual_old_oid, old_oid)) {
+			strbuf_addf(err,
+				    _("unexpected object ID when writing '%s'"),
+				    pseudoref);
+			rollback_lock_file(&lock);
+			goto done;
+		}
+	}
+
+	strbuf_addf(&buf, "%s\n", oid_to_hex(oid));
+	if (write_in_full(fd, buf.buf, buf.len) < 0) {
+		strbuf_addf(err, _("could not write to '%s'"), filename.buf);
+		rollback_lock_file(&lock);
+		goto done;
+	}
+
+	commit_lock_file(&lock);
+	ret = 0;
+done:
+	strbuf_release(&buf);
+	strbuf_release(&filename);
+	return ret;
+}
+
+static int files_delete_pseudoref(struct ref_store *ref_store,
+				  const char *pseudoref,
+				  const struct object_id *old_oid)
+{
+	struct files_ref_store *refs =
+		files_downcast(ref_store, REF_STORE_READ, "delete_pseudoref");
+	struct strbuf filename = STRBUF_INIT;
+	int ret = -1;
+
+	strbuf_addf(&filename, "%s/%s", refs->gitdir, pseudoref);
+
+	if (old_oid && !is_null_oid(old_oid)) {
+		struct lock_file lock = LOCK_INIT;
+		int fd;
+		struct object_id actual_old_oid;
+
+		fd = hold_lock_file_for_update_timeout(
+			&lock, filename.buf, 0,
+			get_files_ref_lock_timeout_ms());
+		if (fd < 0) {
+			error_errno(_("could not open '%s' for writing"),
+				    filename.buf);
+			goto done;
+		}
+		if (read_ref(pseudoref, &actual_old_oid))
+			die(_("could not read ref '%s'"), pseudoref);
+		if (!oideq(&actual_old_oid, old_oid)) {
+			error(_("unexpected object ID when deleting '%s'"),
+			      pseudoref);
+			rollback_lock_file(&lock);
+			goto done;
+		}
+
+		unlink(filename.buf);
+		rollback_lock_file(&lock);
+	} else {
+		unlink(filename.buf);
+	}
+	ret = 0;
+done:
+	strbuf_release(&filename);
+	return ret;
+}
+
 struct files_ref_iterator {
 	struct ref_iterator base;
 
@@ -3189,6 +3298,9 @@ struct ref_storage_be refs_be_files = {
 	files_rename_ref,
 	files_copy_ref,
 
+	files_write_pseudoref,
+	files_delete_pseudoref,
+
 	files_ref_iterator_begin,
 	files_read_raw_ref,
 
@@ -3198,5 +3310,5 @@ struct ref_storage_be refs_be_files = {
 	files_reflog_exists,
 	files_create_reflog,
 	files_delete_reflog,
-	files_reflog_expire
+	files_reflog_expire,
 };
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 4458a0f69cc..08e8253a893 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1590,6 +1590,22 @@ static int packed_copy_ref(struct ref_store *ref_store,
 	BUG("packed reference store does not support copying references");
 }
 
+static int packed_write_pseudoref(struct ref_store *ref_store,
+				  const char *pseudoref,
+				  const struct object_id *oid,
+				  const struct object_id *old_oid,
+				  struct strbuf *err)
+{
+	BUG("packed reference store does not support writing pseudo-references");
+}
+
+static int packed_delete_pseudoref(struct ref_store *ref_store,
+				   const char *pseudoref,
+				   const struct object_id *old_oid)
+{
+	BUG("packed reference store does not support deleting pseudo-references");
+}
+
 static struct ref_iterator *packed_reflog_iterator_begin(struct ref_store *ref_store)
 {
 	return empty_ref_iterator_begin();
@@ -1656,6 +1672,9 @@ struct ref_storage_be refs_be_packed = {
 	packed_rename_ref,
 	packed_copy_ref,
 
+	packed_write_pseudoref,
+	packed_delete_pseudoref,
+
 	packed_ref_iterator_begin,
 	packed_read_raw_ref,
 
@@ -1665,5 +1684,5 @@ struct ref_storage_be refs_be_packed = {
 	packed_reflog_exists,
 	packed_create_reflog,
 	packed_delete_reflog,
-	packed_reflog_expire
+	packed_reflog_expire,
 };
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 3490aac3a40..dabe18baea1 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -549,6 +549,15 @@ typedef int copy_ref_fn(struct ref_store *ref_store,
 			  const char *oldref, const char *newref,
 			  const char *logmsg);
 
+typedef int write_pseudoref_fn(struct ref_store *ref_store,
+			       const char *pseudoref,
+			       const struct object_id *oid,
+			       const struct object_id *old_oid,
+			       struct strbuf *err);
+typedef int delete_pseudoref_fn(struct ref_store *ref_store,
+				const char *pseudoref,
+				const struct object_id *old_oid);
+
 /*
  * Iterate over the references in `ref_store` whose names start with
  * `prefix`. `prefix` is matched as a literal string, without regard
@@ -648,6 +657,9 @@ struct ref_storage_be {
 	rename_ref_fn *rename_ref;
 	copy_ref_fn *copy_ref;
 
+	write_pseudoref_fn *write_pseudoref;
+	delete_pseudoref_fn *delete_pseudoref;
+
 	ref_iterator_begin_fn *iterator_begin;
 	read_raw_ref_fn *read_raw_ref;
 
-- 
gitgitgadget

