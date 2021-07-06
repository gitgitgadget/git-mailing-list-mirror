Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F338C07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 18:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EBB761C6F
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 18:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbhGFS6m (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 14:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbhGFS6l (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 14:58:41 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B715C061760
        for <git@vger.kernel.org>; Tue,  6 Jul 2021 11:56:01 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id r9-20020a7bc0890000b02901f347b31d55so2521666wmh.2
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 11:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=ygRVoOEReud17UIg0l3csEnkpcJVCYXEmlyrC68IMgs=;
        b=LANv9KlMwPgtCYrBADho8EZ/K98VSrEsCh3StJycG0uDDCB2tGq07qFK83WZg2kHHk
         75QubojX+eiNXgxHpvlrJN8fZh7tHHPh8jNch3KwUGSxGRbEwxjLhCTOKRNuyFw2rO+8
         dw0kAj4JhntD4mrE3h42sTjQVn3wxkPrI9y3hVtkRv4qT12JB6h8maKzRcClf8VZnc4k
         DVsGeQZ54lfXg4Aw1WyNmzZI/qPev24OEcHFPNpeRD7uGPKpEA4L6Ygmh3fcLRgbfAQK
         S9hucaRG6JSl9C2FeCa26izyZi+VVntJ+qxg+ESWhuK75xSr+N7QjFFatwHVCpGvjCtj
         Agzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=ygRVoOEReud17UIg0l3csEnkpcJVCYXEmlyrC68IMgs=;
        b=WZgnmF8ojOgPRZAB1NrRcBb/UmGRC4DP7KQc910OmfOGdlPITRsTCTYYh1uyotpMyr
         Xzex7mZiFhGecsi2oCE6kOsDZflodU7M/yo3PvFAHvuUtjpxgRi4bWMke2K17yGFy9b8
         9GriCCsuXzfjDCW2+pLbMpjKT0tcgGotvhSc9CVbDk+A6c7v2EJuYUomnHmK4EwiIJHY
         hxpDbjmHlx7e/1lLlDXiZJe7lWsr1fuNIprKm3JnBz3+vzU1+VPwOC3GXrXkr4iis4Lf
         Gj2g5TUufmQRCMmt77qMNQS89UUrWxklbtTYJFzu3C415FjNor+SM8erdV+IqrJ9ZsRR
         me7A==
X-Gm-Message-State: AOAM532axgCY+ZRDNAQbjM+DSLlyMhjWCmhGG7GZiAX1EhqCffptNHd3
        4HzBRBE4rAwyxLh5KAHtYOH2SmjZjgk=
X-Google-Smtp-Source: ABdhPJz8fw4r6xuaa1KDtNoIsb7LGsl+M3Hja2FxDIIzlDidLMBkV4bW69kO63GGH0kh+FV0NhO4Jw==
X-Received: by 2002:a05:600c:3399:: with SMTP id o25mr22054761wmp.3.1625597759971;
        Tue, 06 Jul 2021 11:55:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r9sm12126042wmq.25.2021.07.06.11.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 11:55:59 -0700 (PDT)
Message-Id: <ff7ea6efcba07848077555a54cabb9eb67cb1d2f.1625597757.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1012.v4.git.git.1625597757.gitgitgadget@gmail.com>
References: <pull.1012.v3.git.git.1625518566.gitgitgadget@gmail.com>
        <pull.1012.v4.git.git.1625597757.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 06 Jul 2021 18:55:53 +0000
Subject: [PATCH v4 2/6] refs/files-backend: stop setting errno from
 lock_ref_oid_basic
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

refs/files-backend.c::lock_ref_oid_basic() tries to signal how it failed
to its callers using errno.

It is safe to stop setting errno here, because the callers of this
file-scope static function are

* files_copy_or_rename_ref()
* files_create_symref()
* files_reflog_expire()

None of them looks at errno after seeing a negative return from
lock_ref_oid_basic() to make any decision, and no caller of these three
functions looks at errno after they signal a failure by returning a
negative value. In particular,

* files_copy_or_rename_ref() - here, calls are followed by error()
(which performs I/O) or write_ref_to_lockfile() (which calls
parse_object() which may perform I/O)

* files_create_symref() - here, calls are followed by error() or
create_symref_locked() (which performs I/O and does not inspect
errno)

* files_reflog_expire() - here, calls are followed by error() or
refs_reflog_exists() (which calls a function in a vtable that is not
documented to use and/or preserve errno)

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
Reviewed-By: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs/files-backend.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 677b7e4cdd2..83ddfb3b627 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -910,7 +910,6 @@ static int create_reflock(const char *path, void *cb)
 
 /*
  * Locks a ref returning the lock on success and NULL on failure.
- * On failure errno is set to something meaningful.
  */
 static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 					   const char *refname,
@@ -922,7 +921,6 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 {
 	struct strbuf ref_file = STRBUF_INIT;
 	struct ref_lock *lock;
-	int last_errno = 0;
 	int mustexist = (old_oid && !is_null_oid(old_oid));
 	int resolve_flags = RESOLVE_REF_NO_RECURSE;
 	int resolved;
@@ -949,7 +947,6 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 		 * to remain.
 		 */
 		if (remove_empty_directories(&ref_file)) {
-			last_errno = errno;
 			if (!refs_verify_refname_available(
 					    &refs->base,
 					    refname, extras, skip, err))
@@ -962,10 +959,13 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 						     &lock->old_oid, type);
 	}
 	if (!resolved) {
-		last_errno = errno;
+		int last_errno = errno;
 		if (last_errno != ENOTDIR ||
-		    !refs_verify_refname_available(&refs->base, refname,
-						   extras, skip, err))
+		    /* in case of D/F conflict, try to generate a better error
+		     * message. If that fails, fall back to strerror(ENOTDIR).
+		     */
+		    !refs_verify_refname_available(&refs->base, refname, extras,
+						   skip, err))
 			strbuf_addf(err, "unable to resolve reference '%s': %s",
 				    refname, strerror(last_errno));
 
@@ -981,20 +981,17 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 	if (is_null_oid(&lock->old_oid) &&
 	    refs_verify_refname_available(refs->packed_ref_store, refname,
 					  extras, skip, err)) {
-		last_errno = ENOTDIR;
 		goto error_return;
 	}
 
 	lock->ref_name = xstrdup(refname);
 
 	if (raceproof_create_file(ref_file.buf, create_reflock, &lock->lk)) {
-		last_errno = errno;
 		unable_to_lock_message(ref_file.buf, errno, err);
 		goto error_return;
 	}
 
 	if (verify_lock(&refs->base, lock, old_oid, mustexist, err)) {
-		last_errno = errno;
 		goto error_return;
 	}
 	goto out;
@@ -1005,7 +1002,6 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 
  out:
 	strbuf_release(&ref_file);
-	errno = last_errno;
 	return lock;
 }
 
-- 
gitgitgadget

