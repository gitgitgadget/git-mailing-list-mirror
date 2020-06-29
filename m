Return-Path: <SRS0=sGv9=AK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0EF9C433E2
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 21:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97CF1206A1
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 21:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ccy9Z3wy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390362AbgF2VOo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729127AbgF2S5F (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jun 2020 14:57:05 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E51EC031C45
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 11:57:05 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id f18so17140522wml.3
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 11:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XDT4y54KZEq/lnqVtqYMoIjih6IjPFtQieC0wcLCkJ4=;
        b=ccy9Z3wyJiGUFiT13NP5qtqIS0PBYIcpadFHpx14kW43IZItoTNa72RF4y9+q0Ac4f
         HDOURoYx7ZUe/B7C7msMJVmXAk/2Nqbby7nSVr8I410T3iavYduAEWmd2jXSS7sa0fFV
         R7nS82rPgxn2b6V7hyQ6WkIrK+qOEq4G3nbOxqP3Pe9sCavn0ft2R2chsGFZKN/XhbdE
         BJu0ITh58J4HiG6HhJqx2Vur8m3cTb7GR+ZqPNp8Zzp6gtOUjpvGqu4CyOyYhjE/A0Go
         3Fg7ZaKUAa3C/jBhXTJrD6WmfYRQQLXHvzMBNd1murC8x/1d1G0opFVL0CR1nTC5P1Ks
         A7xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XDT4y54KZEq/lnqVtqYMoIjih6IjPFtQieC0wcLCkJ4=;
        b=hCLj/F1vm5U4hdk4CGLrpGVdoaDh3S4wVE1Mt7SM8MfBULxdKnCGy0Mai3yKkbihdn
         XE0kBO8wuSf9eGTRSDbAoYL7w7dxODyf5oIa2HAVdjw7R2wCOHbvGWTnRrXkys44AI7a
         HgNiKzUC2WINunJObFyE/F8mB/TmU+XNR9DnlEIQadi9/Cv1ZDbN6Qy+uWEEsKQHhTfp
         qGiF3DKtPHSeeM0z9fjFtYsQESkCrIgmvwVOqeBPUCqKATxgGKU4thj8XH6aLXaIJ9w/
         fJDnFRmUdU95z3QfxZzGQ6wN0B10FB4McwgIPRbPk3OeavaxTkAHAkWpRPAmVhCbkzkM
         lmsQ==
X-Gm-Message-State: AOAM531+XAuexcBQcuOmk5U9vDc3n/F85tGJbiwYpRxRKpbds6JjkhOU
        NFahzboxgaQvoAepJR45w/+/ouwMZ3M=
X-Google-Smtp-Source: ABdhPJzv4YxgbMZ4h0bLlMf33r5iAERH2HCPe76uzIshCPyfNVQdNQg8Hqdp2JiG7uD7aRhVeopCLA==
X-Received: by 2002:a7b:c5d5:: with SMTP id n21mr17927866wmk.106.1593457023654;
        Mon, 29 Jun 2020 11:57:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m4sm725423wmi.48.2020.06.29.11.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 11:57:03 -0700 (PDT)
Message-Id: <5715681b3f0f423ee31710f957c0b649a591d3dc.1593457018.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v19.git.1593457018.gitgitgadget@gmail.com>
References: <pull.539.v18.git.1592862920.gitgitgadget@gmail.com>
        <pull.539.v19.git.1593457018.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Jun 2020 18:56:42 +0000
Subject: [PATCH v19 04/20] Write pseudorefs through ref backends.
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
in a one-off routine that wrote an object ID or symref directly into
.git/<pseudo_ref_name>.

This causes problems when introducing a new ref storage backend. To remedy this,
extend the ref backend implementation with a write_pseudoref_fn and
update_pseudoref_fn.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs.c                | 119 ++++++++----------------------------------
 refs.h                |  11 ++++
 refs/files-backend.c  | 114 +++++++++++++++++++++++++++++++++++++++-
 refs/packed-backend.c |  21 +++++++-
 refs/refs-internal.h  |  18 +++++++
 5 files changed, 184 insertions(+), 99 deletions(-)

diff --git a/refs.c b/refs.c
index 639cba93b4..1e9d893191 100644
--- a/refs.c
+++ b/refs.c
@@ -323,6 +323,12 @@ int ref_exists(const char *refname)
 	return refs_ref_exists(get_main_ref_store(the_repository), refname);
 }
 
+int delete_pseudoref(const char *pseudoref, const struct object_id *old_oid)
+{
+	return refs_delete_pseudoref(get_main_ref_store(the_repository),
+				     pseudoref, old_oid);
+}
+
 static int filter_refs(const char *refname, const struct object_id *oid,
 			   int flags, void *data)
 {
@@ -771,101 +777,6 @@ long get_files_ref_lock_timeout_ms(void)
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
@@ -877,7 +788,7 @@ int refs_delete_ref(struct ref_store *refs, const char *msg,
 
 	if (ref_type(refname) == REF_TYPE_PSEUDOREF) {
 		assert(refs == get_main_ref_store(the_repository));
-		return delete_pseudoref(refname, old_oid);
+		return refs_delete_pseudoref(refs, refname, old_oid);
 	}
 
 	transaction = ref_store_transaction_begin(refs, &err);
@@ -1204,7 +1115,8 @@ int refs_update_ref(struct ref_store *refs, const char *msg,
 
 	if (ref_type(refname) == REF_TYPE_PSEUDOREF) {
 		assert(refs == get_main_ref_store(the_repository));
-		ret = write_pseudoref(refname, new_oid, old_oid, &err);
+		ret = refs_write_pseudoref(refs, refname, new_oid, old_oid,
+					   &err);
 	} else {
 		t = ref_store_transaction_begin(refs, &err);
 		if (!t ||
@@ -1473,6 +1385,19 @@ int head_ref(each_ref_fn fn, void *cb_data)
 	return refs_head_ref(get_main_ref_store(the_repository), fn, cb_data);
 }
 
+int refs_write_pseudoref(struct ref_store *refs, const char *pseudoref,
+			 const struct object_id *oid,
+			 const struct object_id *old_oid, struct strbuf *err)
+{
+	return refs->be->write_pseudoref(refs, pseudoref, oid, old_oid, err);
+}
+
+int refs_delete_pseudoref(struct ref_store *refs, const char *pseudoref,
+			  const struct object_id *old_oid)
+{
+	return refs->be->delete_pseudoref(refs, pseudoref, old_oid);
+}
+
 struct ref_iterator *refs_ref_iterator_begin(
 		struct ref_store *refs,
 		const char *prefix, int trim, int flags)
diff --git a/refs.h b/refs.h
index f212f8945e..9ad1400aab 100644
--- a/refs.h
+++ b/refs.h
@@ -741,6 +741,17 @@ int update_ref(const char *msg, const char *refname,
 	       const struct object_id *new_oid, const struct object_id *old_oid,
 	       unsigned int flags, enum action_on_err onerr);
 
+/* Pseudorefs (eg. HEAD, CHERRY_PICK_HEAD) have a separate routines for updating
+   and deletion as they cannot take part in normal transactional updates.
+   Pseudorefs should only be written for the main repository.
+*/
+int refs_write_pseudoref(struct ref_store *refs, const char *pseudoref,
+			 const struct object_id *oid,
+			 const struct object_id *old_oid, struct strbuf *err);
+int refs_delete_pseudoref(struct ref_store *refs, const char *pseudoref,
+			  const struct object_id *old_oid);
+int delete_pseudoref(const char *pseudoref, const struct object_id *old_oid);
+
 int parse_hide_refs_config(const char *var, const char *value, const char *);
 
 /*
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 6516c7bc8c..df7553f4cc 100644
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
index 4458a0f69c..08e8253a89 100644
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
index 4271362d26..59b053d53a 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -556,6 +556,21 @@ typedef int copy_ref_fn(struct ref_store *ref_store,
 			  const char *oldref, const char *newref,
 			  const char *logmsg);
 
+typedef int write_pseudoref_fn(struct ref_store *ref_store,
+			       const char *pseudoref,
+			       const struct object_id *oid,
+			       const struct object_id *old_oid,
+			       struct strbuf *err);
+
+/*
+ * Deletes a pseudoref. Deletion always succeeds (even if the pseudoref doesn't
+ * exist.), except if old_oid is specified. If it is, it can fail due to lock
+ * failure, failure reading the old OID, or an OID mismatch
+ */
+typedef int delete_pseudoref_fn(struct ref_store *ref_store,
+				const char *pseudoref,
+				const struct object_id *old_oid);
+
 /*
  * Iterate over the references in `ref_store` whose names start with
  * `prefix`. `prefix` is matched as a literal string, without regard
@@ -655,6 +670,9 @@ struct ref_storage_be {
 	rename_ref_fn *rename_ref;
 	copy_ref_fn *copy_ref;
 
+	write_pseudoref_fn *write_pseudoref;
+	delete_pseudoref_fn *delete_pseudoref;
+
 	ref_iterator_begin_fn *iterator_begin;
 	read_raw_ref_fn *read_raw_ref;
 
-- 
gitgitgadget

