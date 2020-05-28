Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75507C433DF
	for <git@archiver.kernel.org>; Thu, 28 May 2020 19:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4037F207BC
	for <git@archiver.kernel.org>; Thu, 28 May 2020 19:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dgzaklrn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406737AbgE1Tr7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 15:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728770AbgE1Tqz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 15:46:55 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD58C08C5C6
        for <git@vger.kernel.org>; Thu, 28 May 2020 12:46:54 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id f185so327957wmf.3
        for <git@vger.kernel.org>; Thu, 28 May 2020 12:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LxRbST36Hio6hjohSw+fhIORIm3eA2pGBZzDuiVuoMs=;
        b=DgzaklrnBQjYr85YDUJD2McmIeuqFsCkNHG4QXx8Hv4/oyRHP8jOChHl4Pa3BJ9cTc
         XXYTddYmvdI+FktAi7I56TSsWB0uFNzEZjerWmDLkcb0datHDXCC0JYyXg+HB+/bHAYn
         9v92CamvzAGsxI1KKwDS06fiJUkfzJwbqTY0b2nBKi0kVzryxAiVQW4geSyrNE5ur01M
         O9QlWfv399gSb7vDyKmEbzFZ0Dn/5khWPM1Dqvhjvb5fvVSjg02sL1qn/C6QgZbSEteo
         L8k1MNbzK+GBB3n0Fz9p3QmggcAY3eD0reZwbawYLD5IAFkxNo3CoLTkZmtBZ5ULMmST
         jwyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LxRbST36Hio6hjohSw+fhIORIm3eA2pGBZzDuiVuoMs=;
        b=fac44StkDhQNtjsuVsr2QECGHl1X46ZBa4zR054JpncGwbah3dat21HD70Dl35uaPT
         ml6sTxpOokvSXmLW5sPC9JGLDu3cXnBa7Q+6z0nSVOuuXeCBQbIrfBKM4Ipn/atcy6b2
         U5q+IxDdrHLUKtDGX5UfQiMLfYEVWnvRV7GV0u4Y5lgYSR7xhA169pXBiZYahuY4Rz8L
         /Xjkx4rqCi4SPHkrKhnZcn+BorZE5MTNdfSTkOS6KUowNeEGfkBK3ypHzJxYQc92EULj
         /umQv9CEDoPO1iiN+d3YkRaqyaaKoX/qiNiN2nwqJZjHxub2BtQjDITvrG90nuxlmn9g
         j+Ug==
X-Gm-Message-State: AOAM530fNCo+MlEl6GJx2XOuDed7ejPiG7k0EctnV2USrpzVVuhqeyhP
        XcOltdiMdMnq/sLz04L6+JrLumqU
X-Google-Smtp-Source: ABdhPJzKMwPmYE1n2U6TeLnx0hEIlD317cs8gKJplzaeuVdqRhsjMAhMdPF7I/Y2mfUhE+tswOOWEg==
X-Received: by 2002:a1c:b7d5:: with SMTP id h204mr5129887wmf.39.1590695213000;
        Thu, 28 May 2020 12:46:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b8sm7400946wrs.36.2020.05.28.12.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 12:46:52 -0700 (PDT)
Message-Id: <9bb64f748dcf04fdee762a6dcc696ac0d9a5c769.1590695210.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v15.git.1590695209.gitgitgadget@gmail.com>
References: <pull.539.v14.git.1589833884.gitgitgadget@gmail.com>
        <pull.539.v15.git.1590695209.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 28 May 2020 19:46:37 +0000
Subject: [PATCH v15 01/13] Write pseudorefs through ref backends.
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
 refs/refs-internal.h  |  12 +++++
 5 files changed, 178 insertions(+), 99 deletions(-)

diff --git a/refs.c b/refs.c
index 224ff66c7bb..12908066b13 100644
--- a/refs.c
+++ b/refs.c
@@ -321,6 +321,12 @@ int ref_exists(const char *refname)
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
@@ -739,101 +745,6 @@ long get_files_ref_lock_timeout_ms(void)
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
@@ -845,7 +756,7 @@ int refs_delete_ref(struct ref_store *refs, const char *msg,
 
 	if (ref_type(refname) == REF_TYPE_PSEUDOREF) {
 		assert(refs == get_main_ref_store(the_repository));
-		return delete_pseudoref(refname, old_oid);
+		return refs_delete_pseudoref(refs, refname, old_oid);
 	}
 
 	transaction = ref_store_transaction_begin(refs, &err);
@@ -1172,7 +1083,8 @@ int refs_update_ref(struct ref_store *refs, const char *msg,
 
 	if (ref_type(refname) == REF_TYPE_PSEUDOREF) {
 		assert(refs == get_main_ref_store(the_repository));
-		ret = write_pseudoref(refname, new_oid, old_oid, &err);
+		ret = refs_write_pseudoref(refs, refname, new_oid, old_oid,
+					   &err);
 	} else {
 		t = ref_store_transaction_begin(refs, &err);
 		if (!t ||
@@ -1441,6 +1353,19 @@ int head_ref(each_ref_fn fn, void *cb_data)
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
index e010f8aec28..4dad8f24914 100644
--- a/refs.h
+++ b/refs.h
@@ -732,6 +732,17 @@ int update_ref(const char *msg, const char *refname,
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
index 4271362d264..4c6d77898aa 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -556,6 +556,15 @@ typedef int copy_ref_fn(struct ref_store *ref_store,
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
@@ -655,6 +664,9 @@ struct ref_storage_be {
 	rename_ref_fn *rename_ref;
 	copy_ref_fn *copy_ref;
 
+	write_pseudoref_fn *write_pseudoref;
+	delete_pseudoref_fn *delete_pseudoref;
+
 	ref_iterator_begin_fn *iterator_begin;
 	read_raw_ref_fn *read_raw_ref;
 
-- 
gitgitgadget

