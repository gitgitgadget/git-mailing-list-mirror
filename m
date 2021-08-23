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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F343EC4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 11:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD4B761374
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 11:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236645AbhHWLhR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 07:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236603AbhHWLhK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 07:37:10 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9984AC061757
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 04:36:27 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id k29so25792415wrd.7
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 04:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xjnofT3qeKXtrhtcuHHTTgXHHktvE7xIs89nEW/5w1Q=;
        b=FHKyyOxucu3tfJIUgBizwxWsTAORtTDDORXdGVIkoTcN9E2EEN451KBzuBRCx20zCA
         tFAEc3nimqA/eVVPL2GnCrfemB4olhXELJq9BqjqeA9A4hR3lildVwBmcqjn4NA2rjiq
         Me54NVeZNT4I/wrv1/v3wybqMDhWBZ++goOJZ25VH95X/uf4H52xIy1+9LXcOyd0frhm
         8KCIJcjCUAFY78aHvNlM5S5TxcGDS0l87Yk/Cz/LCoSBTsyAs1bzuM1JU7OXEJPijLC6
         FXJaJMd3BHUuIE2u85YLHelLprbJPY8+XsZi1XKJKvWIp7TVcUsQgNEZi0ZPqWt1S1jW
         1/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xjnofT3qeKXtrhtcuHHTTgXHHktvE7xIs89nEW/5w1Q=;
        b=WKENuSqCCxgCnMH7+DIlB0hJfs9Z3MwA7UORfBwJZXp5yfLwfy7t2qWaBcCjPnhdul
         wFqg7rVfdsa5YQrvjgv/OF9Aqzlcwrexfr5rg8qQXIePQu8zN58XGIK+HegdaruY9WYT
         M0nEqWYVhPPQm1D0WC1zWGLEIGF0ZNpB8xtNzGH/J/q/1sRcWoDR2pOn5eN0iokb8Fmz
         k/Lk1X+LaYdhycsu3epqik4XIDAm88C/pwXQOR9o5UbnpWSWJiEkFFQ7/nFOpTBIO8E6
         hGG2Ie6cIWWsEnLl0E/tO7iLdCLAxds1f/7JaC/JKzNL1n4ba/dFAm4/JlA4MjvOgVG/
         oV6g==
X-Gm-Message-State: AOAM531hRy9gzx2e4mZFBJYwbe82pkWAAXxJ+NpWLmvs4ryBfDgBw549
        bDwvOw4lyPC18orEU1AVJOp66uL4kt5L2jnm
X-Google-Smtp-Source: ABdhPJx3AQziFlxk8SvxU1x/H2DY9nL10YCTIT6r5vFq4FuOoSNGzso5IKAvmAPpkS87cNkVVaojVg==
X-Received: by 2002:adf:dc0b:: with SMTP id t11mr12781022wri.259.1629718585956;
        Mon, 23 Aug 2021 04:36:25 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g35sm20555313wmp.9.2021.08.23.04.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 04:36:25 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 11/13] refs/files: remove unused "oid" in lock_ref_oid_basic()
Date:   Mon, 23 Aug 2021 13:36:12 +0200
Message-Id: <patch-v5-11.13-7712e29abe6-20210823T113115Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.662.g438caf9576d
In-Reply-To: <cover-v5-00.13-00000000000-20210823T113115Z-avarab@gmail.com>
References: <cover-00.11-0000000000-20210726T234237Z-avarab@gmail.com> <cover-v5-00.13-00000000000-20210823T113115Z-avarab@gmail.com>
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
 refs/files-backend.c | 70 +++++++++-----------------------------------
 1 file changed, 14 insertions(+), 56 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index a4adac46443..4f2d907597a 100644
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
@@ -912,15 +876,12 @@ static int create_reflock(const char *path, void *cb)
  * On failure errno is set to something meaningful.
  */
 static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
-					   const char *refname,
-					   const struct object_id *old_oid,
-					   int *type, struct strbuf *err)
+					   const char *refname, int *type,
+					   struct strbuf *err)
 {
 	struct strbuf ref_file = STRBUF_INIT;
 	struct ref_lock *lock;
 	int last_errno = 0;
-	int mustexist = (old_oid && !is_null_oid(old_oid));
-	int resolve_flags = RESOLVE_REF_NO_RECURSE;
 	int resolved;
 
 	files_assert_main_repository(refs, "lock_ref_oid_basic");
@@ -928,12 +889,9 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 
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
@@ -951,8 +909,8 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
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
@@ -987,10 +945,10 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
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
@@ -1409,7 +1367,7 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 
 	logmoved = log;
 
-	lock = lock_ref_oid_basic(refs, newrefname, NULL, NULL, &err);
+	lock = lock_ref_oid_basic(refs, newrefname, NULL, &err);
 	if (!lock) {
 		if (copy)
 			error("unable to copy '%s' to '%s': %s", oldrefname, newrefname, err.buf);
@@ -1431,7 +1389,7 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 	goto out;
 
  rollback:
-	lock = lock_ref_oid_basic(refs, oldrefname, NULL, NULL, &err);
+	lock = lock_ref_oid_basic(refs, oldrefname, NULL, &err);
 	if (!lock) {
 		error("unable to lock %s for rollback: %s", oldrefname, err.buf);
 		strbuf_release(&err);
@@ -1838,7 +1796,7 @@ static int files_create_symref(struct ref_store *ref_store,
 	struct ref_lock *lock;
 	int ret;
 
-	lock = lock_ref_oid_basic(refs, refname, NULL, NULL, &err);
+	lock = lock_ref_oid_basic(refs, refname, NULL, &err);
 	if (!lock) {
 		error("%s", err.buf);
 		strbuf_release(&err);
@@ -3056,7 +3014,7 @@ static int files_reflog_expire(struct ref_store *ref_store,
 	 * reference itself, plus we might need to update the
 	 * reference if --updateref was specified:
 	 */
-	lock = lock_ref_oid_basic(refs, refname, NULL, &type, &err);
+	lock = lock_ref_oid_basic(refs, refname, &type, &err);
 	if (!lock) {
 		error("cannot lock ref '%s': %s", refname, err.buf);
 		strbuf_release(&err);
-- 
2.33.0.662.g438caf9576d

