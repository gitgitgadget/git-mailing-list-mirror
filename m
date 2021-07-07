Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E69C07E9B
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 19:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE63C61CCC
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 19:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbhGGTKh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jul 2021 15:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbhGGTKf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jul 2021 15:10:35 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF7BC06175F
        for <git@vger.kernel.org>; Wed,  7 Jul 2021 12:07:54 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id a13so4263160wrf.10
        for <git@vger.kernel.org>; Wed, 07 Jul 2021 12:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=bvUW0G4+ZOHhTiiIC/e71UTDkt5bfv+FBm5/WfeqzH4=;
        b=WXIAoggDgc7yKlqZC2XzRzSWCH/Z6+bkMaOsan91NUy48hJXJMI2jZ9OxkWgBfym9G
         ezBaDCwjUTOW4UXZwIxc0b7zQycIKGy9u+zhjKvrFEseFZAG7bvC9lIDp+zy6IWTt5Vb
         5nqQOmjV9VOa+2Kt4jROKnykIbJv5t8RavxNcCBXtlcnCWul9C6Vs9aUTvNGgCA9fVT4
         fphoQtLi8DsjsS7sUgpQdpJftMbUI1g1nY6pybfygQz3M0LrnGTjPimVpNIAY6zoFpuJ
         Bc6O+pXGT8HeO9OMblMvR6PFtFVqtZmJ1tl5rzz1+8zuYZ4pqZ2oFGAaeV2/rEOycYF7
         yw2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=bvUW0G4+ZOHhTiiIC/e71UTDkt5bfv+FBm5/WfeqzH4=;
        b=EK5gnNP6EvBjPLTWiJ3hrOuhN+QEcWrSF0l3NWd1lqqxuPD0rMU2cDZ5Ibw1BYxkk9
         utPaSoL3XCtPuSehg0eNckw9NmkcRwkP43+6yyz945M1CozBRTmkFMi23jOqkwAufG2c
         XJJV41EuZdGBpkht/J6yGt2RSYuJieCXmJp7ryHda/rG8UhJ1dP/4SzXR+GsTJrNVLs0
         fprFiV4rGrF37OIhcopMAvN7dzgZFR/0S8fpB8zG1SakyRcGnL7qmLAuYmXN9hWoh5M+
         A0XhnGxzQ7KhrwbV4xEk6yhLbPETnGgoRxRkcve8nVq3OtWID21XdHRZVbKakr5v9fUp
         sggQ==
X-Gm-Message-State: AOAM531AXYiK7TevtyNT6tjk+mGw7CzfLQ3YKAkOaYZkRQMxb1VlQ47Y
        DMqgoXxl6n24fi8Mmuq7vHSt9JFRr4Q=
X-Google-Smtp-Source: ABdhPJyqYjgbxEM2DSJ+D5T8K6MM3EuCkR9jzm0wcjjfNLGGWU/MtrqWsP6BDE5qRXlFcEoEVXMWVg==
X-Received: by 2002:a5d:4d4b:: with SMTP id a11mr5631747wru.325.1625684872589;
        Wed, 07 Jul 2021 12:07:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c9sm14394350wrx.22.2021.07.07.12.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 12:07:52 -0700 (PDT)
Message-Id: <95025080c16f535599826ed4f013845d712b0e8d.1625684869.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1012.v5.git.git.1625684869.gitgitgadget@gmail.com>
References: <pull.1012.v4.git.git.1625597757.gitgitgadget@gmail.com>
        <pull.1012.v5.git.git.1625684869.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 07 Jul 2021 19:07:45 +0000
Subject: [PATCH v5 2/6] refs/files-backend: stop setting errno from
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
Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
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

