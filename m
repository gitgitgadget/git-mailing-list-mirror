Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD4AC07E9C
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 16:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 201D661175
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 16:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbhGKQdh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jul 2021 12:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbhGKQdg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jul 2021 12:33:36 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A2FC0613DD
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 09:30:49 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id g12so1790307wme.2
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 09:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4NwDnpHX1EvhPI+J7A6xZVdtE8fDpZSpeWacgrJ7O5g=;
        b=NuBnquqha75s486GQnS88wSUtZ1ruJZV63qLmSQ56/OdbZij5IR0SG22ySEBS2kNZ+
         oNte/qrH9FkO0JWE+tI8A8KdysnNBv2QNpvUHE4GxpYy7X9UCza1l4DwNYESdabz5YEa
         dBEEN2xoUW3FXkzCDNQ3IujFJeRyrAcYemtkYX4ODM0W9W+lJIO12V/tj9e/zDzjs8/t
         cDtiqAjawa+SyBXKwqFDCWKZclHMH0JYD38n/2NJ4B6/CrEoo1U9dt+dnxh8oxZxsrac
         I/7VO+LAAdX3hLSbkLz+jWM++2XMV/oFONddu1urwxKDW5vi7Noaph8JNfZUPOiR56O8
         FUbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4NwDnpHX1EvhPI+J7A6xZVdtE8fDpZSpeWacgrJ7O5g=;
        b=K3DluSG0oCcxe5WfhGk7YlBy8tWT1M+OUzqh1l7PQY9ZUU4xYYG5WM9dobsCer0HL4
         8pnoMKIMupb8wdTH+EEVu12ezKwjgazflLbFWMdHByJtVGrFt5m1se9OsCNIr+DCf4oS
         36s/yF1iwqPYu45SUpZTJYW43Y7bNqzWvNP0TFXdYhwyuc+HhmgVOrKZAuYhQQeYNaN/
         A8JWxMx79HkP90nlWcxdjpdb2vVE2I3epn+ftxxu7qYXk8ml+YJib7fIJC+Kv6kuYFUU
         4psYCYi++bmZB+904d4RpRd6R1hHh8YcNZypSPPy+w27R3VUTEL4KoIGbpq7Td0APeKh
         mxMA==
X-Gm-Message-State: AOAM531+1EilqWb4EXuZ0dnI1c8l+86jNlwK810fHTXzTnfmo604mGT6
        YFKa2Dlc2kcWLb6akJHePEexmH/5tbM3HQ==
X-Google-Smtp-Source: ABdhPJzKh6SN2dpFfHBzGBqGVIeitR87vy2kjXrPa28Q07Q4WUWMfVJtd7vQo+gr50pZEfjVFpapoA==
X-Received: by 2002:a7b:ce05:: with SMTP id m5mr10271955wmc.64.1626021048200;
        Sun, 11 Jul 2021 09:30:48 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w3sm678091wrt.55.2021.07.11.09.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 09:30:47 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6? 03/17] refs: make errno output explicit for read_raw_ref_fn
Date:   Sun, 11 Jul 2021 18:30:27 +0200
Message-Id: <patch-03.17-a4e5f2d02fb-20210711T162803Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0-dev
In-Reply-To: <cover-00.17-00000000000-20210711T162803Z-avarab@gmail.com>
References: <pull.1012.v5.git.git.1625684869.gitgitgadget@gmail.com> <cover-00.17-00000000000-20210711T162803Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This makes it explicit how alternative ref backends should report errors in
read_raw_ref_fn.

read_raw_ref_fn needs to supply a credible errno for a number of cases. These
are primarily:

1) The files backend calls read_raw_ref from lock_raw_ref, and uses the
resulting error codes to create/remove directories as needed.

2) ENOENT should be translated in a zero OID, optionally with REF_ISBROKEN set,
returning the last successfully resolved symref. This is necessary so
read_raw_ref("HEAD") on an empty repo returns refs/heads/main (or the default branch
du-jour), and we know on which branch to create the first commit.

Make this information flow explicit by adding a failure_errno to the signature
of read_raw_ref. All errnos from the files backend are still propagated
unchanged, even though inspection suggests only ENOTDIR, EISDIR and ENOENT are
relevant.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs.c                |  2 +-
 refs/debug.c          |  4 ++--
 refs/files-backend.c  | 29 +++++++++++++++--------------
 refs/packed-backend.c |  8 ++++----
 refs/refs-internal.h  | 20 ++++++++++++--------
 5 files changed, 34 insertions(+), 29 deletions(-)

diff --git a/refs.c b/refs.c
index 8c9490235ea..7b3f05a66ff 100644
--- a/refs.c
+++ b/refs.c
@@ -1681,7 +1681,7 @@ int refs_read_raw_ref(struct ref_store *ref_store,
 	}
 
 	return ref_store->be->read_raw_ref(ref_store, refname, oid, referent,
-					   type);
+					   type, &errno);
 }
 
 /* This function needs to return a meaningful errno on failure */
diff --git a/refs/debug.c b/refs/debug.c
index 7db4abccc34..f12413a9bc0 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -238,7 +238,7 @@ debug_ref_iterator_begin(struct ref_store *ref_store, const char *prefix,
 
 static int debug_read_raw_ref(struct ref_store *ref_store, const char *refname,
 			      struct object_id *oid, struct strbuf *referent,
-			      unsigned int *type)
+			      unsigned int *type, int *failure_errno)
 {
 	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
 	int res = 0;
@@ -246,7 +246,7 @@ static int debug_read_raw_ref(struct ref_store *ref_store, const char *refname,
 	oidcpy(oid, null_oid());
 	errno = 0;
 	res = drefs->refs->be->read_raw_ref(drefs->refs, refname, oid, referent,
-					    type);
+					    type, failure_errno);
 
 	if (res == 0) {
 		trace_printf_key(&trace_refs, "read_raw_ref: %s: %s (=> %s) type %x: %d\n",
diff --git a/refs/files-backend.c b/refs/files-backend.c
index f0ce0aac857..b9df7862e57 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -341,9 +341,9 @@ static struct ref_cache *get_loose_ref_cache(struct files_ref_store *refs)
 	return refs->loose;
 }
 
-static int files_read_raw_ref(struct ref_store *ref_store,
-			      const char *refname, struct object_id *oid,
-			      struct strbuf *referent, unsigned int *type)
+static int files_read_raw_ref(struct ref_store *ref_store, const char *refname,
+			      struct object_id *oid, struct strbuf *referent,
+			      unsigned int *type, int *failure_errno)
 {
 	struct files_ref_store *refs =
 		files_downcast(ref_store, REF_STORE_READ, "read_raw_ref");
@@ -354,7 +354,6 @@ static int files_read_raw_ref(struct ref_store *ref_store,
 	struct stat st;
 	int fd;
 	int ret = -1;
-	int save_errno;
 	int remaining_retries = 3;
 
 	*type = 0;
@@ -459,10 +458,9 @@ static int files_read_raw_ref(struct ref_store *ref_store,
 	ret = parse_loose_ref_contents(buf, oid, referent, type);
 
 out:
-	save_errno = errno;
+	*failure_errno = errno;
 	strbuf_release(&sb_path);
 	strbuf_release(&sb_contents);
-	errno = save_errno;
 	return ret;
 }
 
@@ -541,6 +539,7 @@ static int lock_raw_ref(struct files_ref_store *refs,
 	struct strbuf ref_file = STRBUF_INIT;
 	int attempts_remaining = 3;
 	int ret = TRANSACTION_GENERIC_ERROR;
+	int failure_errno;
 
 	assert(err);
 	files_assert_main_repository(refs, "lock_raw_ref");
@@ -611,7 +610,9 @@ static int lock_raw_ref(struct files_ref_store *refs,
 	if (hold_lock_file_for_update_timeout(
 			    &lock->lk, ref_file.buf, LOCK_NO_DEREF,
 			    get_files_ref_lock_timeout_ms()) < 0) {
-		if (errno == ENOENT && --attempts_remaining > 0) {
+		int myerr = errno;
+		errno = 0;
+		if (myerr == ENOENT && --attempts_remaining > 0) {
 			/*
 			 * Maybe somebody just deleted one of the
 			 * directories leading to ref_file.  Try
@@ -619,7 +620,7 @@ static int lock_raw_ref(struct files_ref_store *refs,
 			 */
 			goto retry;
 		} else {
-			unable_to_lock_message(ref_file.buf, errno, err);
+			unable_to_lock_message(ref_file.buf, myerr, err);
 			goto error_return;
 		}
 	}
@@ -629,9 +630,9 @@ static int lock_raw_ref(struct files_ref_store *refs,
 	 * fear that its value will change.
 	 */
 
-	if (files_read_raw_ref(&refs->base, refname,
-			       &lock->old_oid, referent, type)) {
-		if (errno == ENOENT) {
+	if (files_read_raw_ref(&refs->base, refname, &lock->old_oid, referent,
+			       type, &failure_errno)) {
+		if (failure_errno == ENOENT) {
 			if (mustexist) {
 				/* Garden variety missing reference. */
 				strbuf_addf(err, "unable to resolve reference '%s'",
@@ -655,7 +656,7 @@ static int lock_raw_ref(struct files_ref_store *refs,
 				 *   reference named "refs/foo/bar/baz".
 				 */
 			}
-		} else if (errno == EISDIR) {
+		} else if (failure_errno == EISDIR) {
 			/*
 			 * There is a directory in the way. It might have
 			 * contained references that have been deleted. If
@@ -693,13 +694,13 @@ static int lock_raw_ref(struct files_ref_store *refs,
 					goto error_return;
 				}
 			}
-		} else if (errno == EINVAL && (*type & REF_ISBROKEN)) {
+		} else if (failure_errno == EINVAL && (*type & REF_ISBROKEN)) {
 			strbuf_addf(err, "unable to resolve reference '%s': "
 				    "reference broken", refname);
 			goto error_return;
 		} else {
 			strbuf_addf(err, "unable to resolve reference '%s': %s",
-				    refname, strerror(errno));
+				    refname, strerror(failure_errno));
 			goto error_return;
 		}
 
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index dfecdbc1db6..a457f18e93c 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -724,9 +724,9 @@ static struct snapshot *get_snapshot(struct packed_ref_store *refs)
 	return refs->snapshot;
 }
 
-static int packed_read_raw_ref(struct ref_store *ref_store,
-			       const char *refname, struct object_id *oid,
-			       struct strbuf *referent, unsigned int *type)
+static int packed_read_raw_ref(struct ref_store *ref_store, const char *refname,
+			       struct object_id *oid, struct strbuf *referent,
+			       unsigned int *type, int *failure_errno)
 {
 	struct packed_ref_store *refs =
 		packed_downcast(ref_store, REF_STORE_READ, "read_raw_ref");
@@ -739,7 +739,7 @@ static int packed_read_raw_ref(struct ref_store *ref_store,
 
 	if (!rec) {
 		/* refname is not a packed reference. */
-		errno = ENOENT;
+		*failure_errno = ENOENT;
 		return -1;
 	}
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index f4445e32904..79dfb3af484 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -617,11 +617,15 @@ typedef int reflog_expire_fn(struct ref_store *ref_store,
  * properly-formatted or even safe reference name. NEITHER INPUT NOR
  * OUTPUT REFERENCE NAMES ARE VALIDATED WITHIN THIS FUNCTION.
  *
- * Return 0 on success. If the ref doesn't exist, set errno to ENOENT
- * and return -1. If the ref exists but is neither a symbolic ref nor
- * an object ID, it is broken; set REF_ISBROKEN in type, and return -1
- * (errno should not be ENOENT) If there is another error reading the
- * ref, set errno appropriately and return -1.
+ * Return 0 on success, or -1 on failure. If the ref exists but is neither a
+ * symbolic ref nor an object ID, it is broken. In this case set REF_ISBROKEN in
+ * type, and return -1 (failure_errno should not be ENOENT)
+ *
+ * failure_errno provides errno codes that are interpreted beyond error
+ * reporting. The following error codes have special meaning:
+ *    * ENOENT: the ref doesn't exist
+ *    * EISDIR: ref name is a directory
+ *    * ENOTDIR: ref prefix is not a directory
  *
  * Backend-specific flags might be set in type as well, regardless of
  * outcome.
@@ -635,9 +639,9 @@ typedef int reflog_expire_fn(struct ref_store *ref_store,
  * - in all other cases, referent will be untouched, and therefore
  *   refname will still be valid and unchanged.
  */
-typedef int read_raw_ref_fn(struct ref_store *ref_store,
-			    const char *refname, struct object_id *oid,
-			    struct strbuf *referent, unsigned int *type);
+typedef int read_raw_ref_fn(struct ref_store *ref_store, const char *refname,
+			    struct object_id *oid, struct strbuf *referent,
+			    unsigned int *type, int *failure_errno);
 
 struct ref_storage_be {
 	struct ref_storage_be *next;
-- 
2.32.0-dev

