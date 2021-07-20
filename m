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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A914DC07E9B
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 10:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FB0161019
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 10:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237141AbhGTJsI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 05:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237639AbhGTJqN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 05:46:13 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8770C0612E9
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 03:24:32 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id q18-20020a1ce9120000b02901f259f3a250so1723359wmc.2
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 03:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Oi1VeRUAlHt4mjCkCiIFPvQgA3VtFMWLSOPqWtrhkh4=;
        b=g4SsB0iHLi258rULNzYujDRxwLjsDEcjXPFxSvJyqnxtX1RW7cEE9/5wNxowCNILAZ
         q36JXUffN6fPj3vl5OCY61lm938D58HVbITcn9qiaEF+h/zTrqv+rJOGvg3tlmc0mITv
         RUaRSNUQWRheSc1qHQAtvYIwm4wuqPIIUkK8pvd7Z5TGkq1FdPTMek9pYQcwr+D2NKaa
         GuegQ/QbQpHo/uB8YYHPBpRAR8rTgh8VCbpT8XizAD9HCh/+TSE1b3Ic5TUvv0L1a6KD
         iTNLQbMWmPTkN8GOTEebWFba1HCVEESzC/q5AIQQcqj1wL7DcFpqRQ4MVIsmg4YKMEFL
         7avw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Oi1VeRUAlHt4mjCkCiIFPvQgA3VtFMWLSOPqWtrhkh4=;
        b=RDiPc3IXtNW0V1XjoVAk1vIz/PLhBPp+PRUA3pqzY72I4FCwR20h3iKHEn3ZEOjoWQ
         tdHPrlVovaBl4EdSg/rjpumv8rd0fJw+6L0yS4tsThTT5xz2UYWEkD10On6oUbddvn6n
         JAJH83oKO3VKMdTssBywR6+Jj2d+vXrrIGLdT2i7d7/qeXX5Vyz5iwaGEQhqLVLqy2pW
         lPXXk2L5dPLfL0S7TbIxFYr18eLgduqKJXbrPW8JBLVhju2Q/owrtHX8Ar4RV/T6l6db
         KhIeuYOHRogPydnaQ8M58+2iXBjhtllL2mceCKCaMAttNLAZNXHfB6JRAh1rRiKfmYtP
         44ww==
X-Gm-Message-State: AOAM5300txm9q3IYHuarJxpOsrsdcOo7flLsjlDtQbzu8baqE/FACmRQ
        aAaOH9vGJTHaeVoYeal68JCVqcnFAdERUg==
X-Google-Smtp-Source: ABdhPJw78ybiKysER3nWq3lr9PJTe/oX9QCw8eT1wD314HQXdTU1zJBzKQSgZJLqVHDlipcsNUrzTA==
X-Received: by 2002:a7b:cd15:: with SMTP id f21mr31488324wmj.148.1626776671323;
        Tue, 20 Jul 2021 03:24:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l23sm9684536wme.22.2021.07.20.03.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 03:24:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 10/12] refs/files: remove unused "oid" in lock_ref_oid_basic()
Date:   Tue, 20 Jul 2021 12:24:15 +0200
Message-Id: <patch-10.12-753c20f89bf-20210720T102051Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.874.ge7a9d58bfcf
In-Reply-To: <cover-00.12-00000000000-20210720T102051Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20210716T140631Z-avarab@gmail.com> <cover-00.12-00000000000-20210720T102051Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the preceding commit the last caller that passed a non-NULL OID was
changed to pass NULL to lock_ref_oid_basic(). As noted in preceding
commits use of this API has been going away (we should use ref
transactions, or lock_raw_ref()), so we're unlikely to gain new
callers that want to pass the "oid".

So let's remove it, doing so means we can remove the "mustexist"
condition, and therefore anything except the "flags =
RESOLVE_REF_NO_RECURSE" case.

Furthermore, since the verify_lock() function we called did most of
its work when the "oid" was passed (as "old_oid") we can inline the
trivial part of it that remains in its only remaining caller. Without
a NULL "oid" passed it was equivalent to calling refs_read_ref_full()
followed by oidclr().

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs/files-backend.c | 72 ++++++++------------------------------------
 1 file changed, 12 insertions(+), 60 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 819351c82fc..8bbabc140b2 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -852,42 +852,6 @@ static struct ref_iterator *files_ref_iterator_begin(
 	return ref_iterator;
 }
 
-/*
- * Verify that the reference locked by lock has the value old_oid
- * (unless it is NULL).  Fail if the reference doesn't exist and
- * mustexist is set. Return 0 on success. On error, write an error
- * message to err, set errno, and return a negative value.
- */
-static int verify_lock(struct ref_store *ref_store, struct ref_lock *lock,
-		       const struct object_id *old_oid, int mustexist,
-		       struct strbuf *err)
-{
-	assert(err);
-
-	if (refs_read_ref_full(ref_store, lock->ref_name,
-			       mustexist ? RESOLVE_REF_READING : 0,
-			       &lock->old_oid, NULL)) {
-		if (old_oid) {
-			int save_errno = errno;
-			strbuf_addf(err, "can't verify ref '%s'", lock->ref_name);
-			errno = save_errno;
-			return -1;
-		} else {
-			oidclr(&lock->old_oid);
-			return 0;
-		}
-	}
-	if (old_oid && !oideq(&lock->old_oid, old_oid)) {
-		strbuf_addf(err, "ref '%s' is at %s but expected %s",
-			    lock->ref_name,
-			    oid_to_hex(&lock->old_oid),
-			    oid_to_hex(old_oid));
-		errno = EBUSY;
-		return -1;
-	}
-	return 0;
-}
-
 static int remove_empty_directories(struct strbuf *path)
 {
 	/*
@@ -913,15 +877,12 @@ static int create_reflock(const char *path, void *cb)
  */
 static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 					   const char *refname,
-					   const struct object_id *old_oid,
 					   unsigned int flags, int *type,
 					   struct strbuf *err)
 {
 	struct strbuf ref_file = STRBUF_INIT;
 	struct ref_lock *lock;
 	int last_errno = 0;
-	int mustexist = (old_oid && !is_null_oid(old_oid));
-	int resolve_flags = RESOLVE_REF_NO_RECURSE;
 	int resolved;
 
 	files_assert_main_repository(refs, "lock_ref_oid_basic");
@@ -929,12 +890,9 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 
 	CALLOC_ARRAY(lock, 1);
 
-	if (mustexist)
-		resolve_flags |= RESOLVE_REF_READING;
-
 	files_ref_path(refs, &ref_file, refname);
-	resolved = !!refs_resolve_ref_unsafe(&refs->base,
-					     refname, resolve_flags,
+	resolved = !!refs_resolve_ref_unsafe(&refs->base, refname,
+					     RESOLVE_REF_NO_RECURSE,
 					     &lock->old_oid, type);
 	if (!resolved && errno == EISDIR) {
 		/*
@@ -952,8 +910,8 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 					    refname);
 			goto error_return;
 		}
-		resolved = !!refs_resolve_ref_unsafe(&refs->base,
-						     refname, resolve_flags,
+		resolved = !!refs_resolve_ref_unsafe(&refs->base, refname,
+						     RESOLVE_REF_NO_RECURSE,
 						     &lock->old_oid, type);
 	}
 	if (!resolved) {
@@ -988,10 +946,10 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 		goto error_return;
 	}
 
-	if (verify_lock(&refs->base, lock, old_oid, mustexist, err)) {
-		last_errno = errno;
-		goto error_return;
-	}
+	if (refs_read_ref_full(&refs->base, lock->ref_name,
+			       0,
+			       &lock->old_oid, NULL))
+		oidclr(&lock->old_oid);
 	goto out;
 
  error_return:
@@ -1410,8 +1368,7 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 
 	logmoved = log;
 
-	lock = lock_ref_oid_basic(refs, newrefname, NULL, REF_NO_DEREF, NULL,
-				  &err);
+	lock = lock_ref_oid_basic(refs, newrefname, REF_NO_DEREF, NULL, &err);
 	if (!lock) {
 		if (copy)
 			error("unable to copy '%s' to '%s': %s", oldrefname, newrefname, err.buf);
@@ -1433,8 +1390,7 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 	goto out;
 
  rollback:
-	lock = lock_ref_oid_basic(refs, oldrefname, NULL,
-				  REF_NO_DEREF, NULL, &err);
+	lock = lock_ref_oid_basic(refs, oldrefname, REF_NO_DEREF, NULL, &err);
 	if (!lock) {
 		error("unable to lock %s for rollback: %s", oldrefname, err.buf);
 		strbuf_release(&err);
@@ -1841,9 +1797,7 @@ static int files_create_symref(struct ref_store *ref_store,
 	struct ref_lock *lock;
 	int ret;
 
-	lock = lock_ref_oid_basic(refs, refname, NULL,
-				  REF_NO_DEREF, NULL,
-				  &err);
+	lock = lock_ref_oid_basic(refs, refname, REF_NO_DEREF, NULL, &err);
 	if (!lock) {
 		error("%s", err.buf);
 		strbuf_release(&err);
@@ -3060,9 +3014,7 @@ static int files_reflog_expire(struct ref_store *ref_store,
 	 * reference itself, plus we might need to update the
 	 * reference if --updateref was specified:
 	 */
-	lock = lock_ref_oid_basic(refs, refname, NULL,
-				  REF_NO_DEREF,
-				  &type, &err);
+	lock = lock_ref_oid_basic(refs, refname, REF_NO_DEREF, &type, &err);
 	if (!lock) {
 		error("cannot lock ref '%s': %s", refname, err.buf);
 		strbuf_release(&err);
-- 
2.32.0.874.ge7a9d58bfcf

