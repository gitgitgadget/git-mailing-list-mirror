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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99990C07E95
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 14:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FF44613EB
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 14:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240476AbhGPOQd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 10:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240478AbhGPOQX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 10:16:23 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6078C061767
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 07:13:26 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id f10-20020a05600c4e8ab029023e8d74d693so916208wmq.3
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 07:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mBqs5NI95VVCSW8XTC1DnIF5sVypYowl2/e4u47tQAU=;
        b=FLOmI66e/ZcD5hBfWutnJToyS/wTFeOpu2eCbA+PVS5BXtivQuEmqoffF1y6HN/Zzq
         3t1bqX8ZC33p96fl6Ep9wdv9GClITH9WoZsyI3BVzJHoDcKOOumh7masGPfHsBSBaAFA
         JrV63oLDhjJylLu1EXRxphre0BToVqMssuWdWjDHDp8u2P8AgYosEvRxhkGjTzTxW4zN
         yl2q7H0qCDopJBAsUrrvHC5Ud3y2n9O8MmPd+2RSe5EyOTuICel1WKqu0tRoctm0h5oh
         v40BaeAicUuDnwFHmSnG/4DZXIFzvn+h77yAxpYtuhZP0gHpehJiL6Il0y146TG9aiIH
         FN2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mBqs5NI95VVCSW8XTC1DnIF5sVypYowl2/e4u47tQAU=;
        b=MIEjVV6GqL1sc6pLchQ/d1/qZVTMOiNBRrqTFWELpRP+yJa9pm+iGdGDkDAlp2BYd6
         28ZiZ8P7zgU3Lktw7TcgBsjSDfsDziby0yWg/7uKQY42DZ7sngYfODASSZdxbxfTO546
         n/IhB2e7PNYYRWD6j25bXDI1Jyn0AScRn6M4Z2EfdoW0pYCoScVMDNpvH+yrTlRQSA11
         VRi5NWqFyIqDubtpyqh5srGO21ozZQkkJ1gFLUKEby2GsY/n4Qe9s6JGraj/qex1/TLA
         /6Qyko6+cIWsrGj1BLSdP6cHJJzHDieiGW3t4/wAaJNOQRLfGi+2k0rTyRbvigr1aoVo
         WBfQ==
X-Gm-Message-State: AOAM533+bg4LIVuyRUJQWKe4QBwtJEKTmr0/ptfUq0JHlwGbTC2DFb4+
        fuZivytM+Iz8Xp9J2urxx6UcHGJXA9GZ/Q==
X-Google-Smtp-Source: ABdhPJwmV+1f/cO8IxrYH29yAL2zu4p5V15dvsh/PzBJLv5jKO44ueiq/p3fzrei0cOK/NWNwa0cYw==
X-Received: by 2002:a05:600c:221a:: with SMTP id z26mr17161908wml.34.1626444805019;
        Fri, 16 Jul 2021 07:13:25 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a9sm10101363wrv.37.2021.07.16.07.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 07:13:24 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 10/11] refs/files: remove unused "oid" in lock_ref_oid_basic()
Date:   Fri, 16 Jul 2021 16:13:06 +0200
Message-Id: <patch-10.11-09dd8836437-20210716T140631Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.874.gfa1990a4f10
In-Reply-To: <cover-00.11-00000000000-20210716T140631Z-avarab@gmail.com>
References: <patch-1.1-de0838fe99-20210714T111351Z-avarab@gmail.com> <cover-00.11-00000000000-20210716T140631Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the preceding commit the last caller that passed a non-NULL OID was
changed to pass NULL to lock_ref_oid_basic(). As noted in preceding
commits use of this API has been going away (we should use ref
transactions, or lock_raw_rew()), so we're unlikely to gain new
callers that want to pass the "oid".

So let's remove it, doing so means we can remove the "mustexist"
condition, and therefore anything except the "flags =
RESOLVE_REF_NO_RECURSE" case. Furthermore, since the verify_lock()
function we called did most of its work when the "oid" was passed (as
"old_oid") we can inline the trivial part of it that remains in what's
now its only caller.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs/files-backend.c | 72 ++++++++------------------------------------
 1 file changed, 12 insertions(+), 60 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index cb8c64cffb5..3e7598cc86c 100644
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
2.32.0.873.gb6f2f696497

