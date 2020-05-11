Return-Path: <SRS0=tgTL=6Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76626C54E8D
	for <git@archiver.kernel.org>; Mon, 11 May 2020 19:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54DEB20752
	for <git@archiver.kernel.org>; Mon, 11 May 2020 19:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKhzTyFT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731555AbgEKTqn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 May 2020 15:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731531AbgEKTqj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 May 2020 15:46:39 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93D9C061A0C
        for <git@vger.kernel.org>; Mon, 11 May 2020 12:46:38 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id g12so20721625wmh.3
        for <git@vger.kernel.org>; Mon, 11 May 2020 12:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9Yl/LjsGyUaEen0/nXGmrI1YCKFIBy2XX89ifS653ng=;
        b=PKhzTyFTc8Kj3GyQbJiIyAe0bM3E5WsTWotqg/m+RgfIhCqfbp/kJqwni2qx2qYRfm
         YiokAsi+znQr/2e4gc6oyqc2sWdxqz5FzkSwX1cDvEHEqArQp1ORkmqmDqqMwklrG2QA
         /+/U0F33eddhx87nlppkk9EWrN/UTVl32ciAsPBmkPplT2dT+U58+74INOvtPhmmSTF8
         w68hRe/4x7S1HbX9VTWDivNSwBWCQwrhUy1+yzrpkaW5v1r5kZwIZQyMXcCImyjY1doG
         6uSmubijj4Ds4euN3s1KIA9KM+iFGMgxzMG3zevY4F1BBBkOmPMFzyOpOH7OW5CUYc1u
         7rkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9Yl/LjsGyUaEen0/nXGmrI1YCKFIBy2XX89ifS653ng=;
        b=kyGItb5O0B8pjLIORD+LdUIL1bRAkN/RXExJwEvAmXrPJXbpPTeSRrZyhqbseCCTtJ
         RNLd5BKu14J0yBbq3LWYOml0l1vdHmbBoTPLjVC+JejyJf+GxfsFEoyUPyyK2yPdqoA5
         i6XDXl/4fnr2xwtCcbrZBeJve+hFAkSyswjDpA+aLLGqaSeP8xBF69N2eMKutkR717/2
         dP5jrBHYOBxQWkNzx/vRkUjjQkY3lDxTwtY/baJ+qyBBl1sy0CWg5qanDKiRAFxmDw1K
         CXDmVh6P17YF4e23VWItyNMM6NT01LUF34fyG7beFKq+eEEisLN5DbsgoEGtL1FPpwlr
         yS1Q==
X-Gm-Message-State: AGi0PubULbWjnC5rsEO6Sjw7OJYjaxvgUubrmTV4DGaPxrunH/drrLfp
        wsu6K2sUR50Zjdt981EsjNY007RA
X-Google-Smtp-Source: APiQypJXZ8zyd1kSKSJukk7LFRm+1rzKBG+DwmpUTy8ttERhrkWLEcNLqVZV/mVz0XrZ3ygw3KtL+A==
X-Received: by 2002:a1c:9a88:: with SMTP id c130mr7558821wme.90.1589226396828;
        Mon, 11 May 2020 12:46:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n7sm10084609wro.94.2020.05.11.12.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 12:46:36 -0700 (PDT)
Message-Id: <2c2f94ddc0e77c8c70041a2a736e3a56698f058c.1589226388.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v13.git.1589226388.gitgitgadget@gmail.com>
References: <pull.539.v12.git.1588845585.gitgitgadget@gmail.com>
        <pull.539.v13.git.1589226388.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 11 May 2020 19:46:22 +0000
Subject: [PATCH v13 07/13] Write pseudorefs through ref backends.
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
 refs.c                | 115 +++++------------------------
 refs.h                |  11 +++
 refs/files-backend.c  | 164 +++++++++++++++++++++++++++++++++++-------
 refs/packed-backend.c |  40 ++++-------
 refs/refs-internal.h  |  12 ++++
 5 files changed, 192 insertions(+), 150 deletions(-)

diff --git a/refs.c b/refs.c
index 224ff66c7bb..fc72211a36f 100644
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
@@ -844,8 +749,7 @@ int refs_delete_ref(struct ref_store *refs, const char *msg,
 	struct strbuf err = STRBUF_INIT;
 
 	if (ref_type(refname) == REF_TYPE_PSEUDOREF) {
-		assert(refs == get_main_ref_store(the_repository));
-		return delete_pseudoref(refname, old_oid);
+		return ref_store_delete_pseudoref(refs, refname, old_oid);
 	}
 
 	transaction = ref_store_transaction_begin(refs, &err);
@@ -1172,7 +1076,8 @@ int refs_update_ref(struct ref_store *refs, const char *msg,
 
 	if (ref_type(refname) == REF_TYPE_PSEUDOREF) {
 		assert(refs == get_main_ref_store(the_repository));
-		ret = write_pseudoref(refname, new_oid, old_oid, &err);
+		ret = ref_store_write_pseudoref(refs, refname, new_oid, old_oid,
+						&err);
 	} else {
 		t = ref_store_transaction_begin(refs, &err);
 		if (!t ||
@@ -1441,6 +1346,20 @@ int head_ref(each_ref_fn fn, void *cb_data)
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
index 6516c7bc8c8..53b891190be 100644
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
 
@@ -3173,30 +3282,31 @@ static int files_init_db(struct ref_store *ref_store, struct strbuf *err)
 	return 0;
 }
 
-struct ref_storage_be refs_be_files = {
-	NULL,
-	"files",
-	files_ref_store_create,
-	files_init_db,
-	files_transaction_prepare,
-	files_transaction_finish,
-	files_transaction_abort,
-	files_initial_transaction_commit,
-
-	files_pack_refs,
-	files_create_symref,
-	files_delete_refs,
-	files_rename_ref,
-	files_copy_ref,
-
-	files_ref_iterator_begin,
-	files_read_raw_ref,
-
-	files_reflog_iterator_begin,
-	files_for_each_reflog_ent,
-	files_for_each_reflog_ent_reverse,
-	files_reflog_exists,
-	files_create_reflog,
-	files_delete_reflog,
-	files_reflog_expire
-};
+struct ref_storage_be refs_be_files = { NULL,
+					"files",
+					files_ref_store_create,
+					files_init_db,
+					files_transaction_prepare,
+					files_transaction_finish,
+					files_transaction_abort,
+					files_initial_transaction_commit,
+
+					files_pack_refs,
+					files_create_symref,
+					files_delete_refs,
+					files_rename_ref,
+					files_copy_ref,
+
+					files_write_pseudoref,
+					files_delete_pseudoref,
+
+					files_ref_iterator_begin,
+					files_read_raw_ref,
+
+					files_reflog_iterator_begin,
+					files_for_each_reflog_ent,
+					files_for_each_reflog_ent_reverse,
+					files_reflog_exists,
+					files_create_reflog,
+					files_delete_reflog,
+					files_reflog_expire };
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 4458a0f69cc..8f9b85f0b0c 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1641,29 +1641,19 @@ static int packed_reflog_expire(struct ref_store *ref_store,
 }
 
 struct ref_storage_be refs_be_packed = {
-	NULL,
-	"packed",
-	packed_ref_store_create,
-	packed_init_db,
-	packed_transaction_prepare,
-	packed_transaction_finish,
-	packed_transaction_abort,
-	packed_initial_transaction_commit,
-
-	packed_pack_refs,
-	packed_create_symref,
-	packed_delete_refs,
-	packed_rename_ref,
-	packed_copy_ref,
-
-	packed_ref_iterator_begin,
-	packed_read_raw_ref,
-
-	packed_reflog_iterator_begin,
-	packed_for_each_reflog_ent,
-	packed_for_each_reflog_ent_reverse,
-	packed_reflog_exists,
-	packed_create_reflog,
-	packed_delete_reflog,
-	packed_reflog_expire
+	NULL, "packed", packed_ref_store_create, packed_init_db,
+	packed_transaction_prepare, packed_transaction_finish,
+	packed_transaction_abort, packed_initial_transaction_commit,
+
+	packed_pack_refs, packed_create_symref, packed_delete_refs,
+	packed_rename_ref, packed_copy_ref,
+
+	/* XXX */
+	NULL, NULL,
+
+	packed_ref_iterator_begin, packed_read_raw_ref,
+
+	packed_reflog_iterator_begin, packed_for_each_reflog_ent,
+	packed_for_each_reflog_ent_reverse, packed_reflog_exists,
+	packed_create_reflog, packed_delete_reflog, packed_reflog_expire
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

