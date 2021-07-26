Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E41C432BE
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 23:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DD6960F5D
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 23:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbhGZXEQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 19:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233809AbhGZXEM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 19:04:12 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C349BC061760
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 16:44:39 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id c16so3145754wrp.13
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 16:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HNxVXXRDyI4L8G5q6ZN0S8Pzigq9Pz5EPYOqEs4g9BA=;
        b=g8ax7pwG8mAqtbaJn7UkR39rnSYqF842wQ+NCKP0/sePJyXZaxwoLNJfMBm20mzFtO
         YdcVuDH9V5iVz8lDfhm+wisFvRRVsp+ViSU9UGSz6NY521PoBC+oDBiJH73Kj2c+PXQK
         5D4jrN6KNHm22yesxVQZNnArXnfXBV8Mk+ie/poxCLn645F8PV8q+ljFhDuRFpi/crf6
         DYliCk6GCVFKQQZ9WcvgpEbRuFDvkFTYKbDvTO5yQmsgBOZJzr1VW8ZmWWWkmTVHyP4x
         CxbKcjPam+1F9pWYaokcgxJnericKo3SvY232MvIcfeBP3+COW6XrcmaCn3wjy1pTa24
         rQEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HNxVXXRDyI4L8G5q6ZN0S8Pzigq9Pz5EPYOqEs4g9BA=;
        b=cAS7tASVnRoW62DNLRZCG/yj7GYmUjjtZFwuQR/8O+jWTCv6k3t6FTWU7U7IHpVEQV
         KumgSh6o/amBWn3rXTz4PIaumyDMl5h1jMS4rmffTu0zStmYhBwj/DKX0hfJJLz1FRiW
         O4Ybd0FYoqX1goA0AaISgJ15tyfSSnhrIe3SX54USpnCWEdjo6afvlE0nDxCR22sBFpi
         Fbd4y7mWg+PjOx4McmeeMNFTEi11Dq9C6CV+czI+pIv0g+28s58uM/GZflLC+w7RsKE7
         oveRszggShBXcEJA6CXvRqjbdgt/0AIyLFXvkZQd0p6qqtXZaDE9yNrwuBSWXjFAr5xF
         ApWw==
X-Gm-Message-State: AOAM5325rJaMnsqTRTBjMU/dbKT7h17jlrhtWFtZucFy3728L8twUKSw
        YPOqEWTZucfxHQlQSea5gKiM6y1/ya2nBw==
X-Google-Smtp-Source: ABdhPJybHuDxEyCUqvARf3UO04f+k+RpfJh9OQJSNl93AzMG4P0A+nv1cAsFnDO3g9fA1A93Uqksww==
X-Received: by 2002:a05:6000:1c4:: with SMTP id t4mr21813217wrx.181.1627343078202;
        Mon, 26 Jul 2021 16:44:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n18sm1214545wrt.89.2021.07.26.16.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 16:44:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 09/11] refs/files: remove unused "oid" in lock_ref_oid_basic()
Date:   Tue, 27 Jul 2021 01:44:25 +0200
Message-Id: <patch-09.11-b61c734cf5-20210726T234237Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.988.g1a6a4b2c5f
In-Reply-To: <cover-00.11-0000000000-20210726T234237Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20210720T102051Z-avarab@gmail.com> <cover-00.11-0000000000-20210726T234237Z-avarab@gmail.com>
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
index ccdf455049..98d9aa1601 100644
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
@@ -3061,9 +3015,7 @@ static int files_reflog_expire(struct ref_store *ref_store,
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
2.32.0.956.g6b0c84ceda8

