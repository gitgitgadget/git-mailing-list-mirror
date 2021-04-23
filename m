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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A137C43460
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 15:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECE4F613C9
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 15:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242689AbhDWPc2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 11:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbhDWPc1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 11:32:27 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303BBC061574
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 08:31:51 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id y5-20020a05600c3645b0290132b13aaa3bso1452415wmq.1
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 08:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=53/5RIkW7qI9pjwI746C+8SQCpV4VoLRFI66jslH+E0=;
        b=ikd/LxAGZbQ+HnSsHqfkLFUAbr29KIy6GbX/VX3v3Ncst7yhujehyvloBfDJIVtWB4
         9ZXw+4ig8P8cr2nGzu2um9uoWX4Fc6u1n2rYd8ruO/ewDJXQgL4PPxdWucRVuzJYZmx/
         C/LDIgqHlnhreawgBjWNjCvr+NxHLaZ5c0hYA41HVBZzU4lZv8W+aWCtC0ufZLAA2n6S
         iuR06bHbPgp2rjWoPB1BbSd0CVZqh9LzYYrqg0ACbpj1A5wG6tGQpym9WutWsqMp0Jep
         ai6Wp89BDykJ9i40MChuqOZaf5fR3eKIvjUq+MkLrOa6GpuAe/xGq8ht9WI3FMqR3Jhr
         XLFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=53/5RIkW7qI9pjwI746C+8SQCpV4VoLRFI66jslH+E0=;
        b=ToOx2wB7GrjHaOwPM5tgRCzv6kEsPMxqFFImuMZ0cQKjyywmolrgpYjdJRPcCZwLUL
         b2H0m6ogT54O9JDj4MRIVMAVVCDi+LlShf5e8dfpZzQP5Duvq3x+v99tgc1UbIHdp5eP
         A8cM7TA4wRh0ZD5rmY/DcKa8BCFCWA4+P3UdR6jWvA+EWhFjM2ZfOtbwIZHxLK2si96I
         wyCaDXmsJM0M3RUf6V+dgeMaBoNuIiQz4Rfyp4lkkzKbd92eYyz5P50IHYcMJhJEhcQa
         e1Zs5UXH7lMifMe3WoaXN0384PdphwnvuPVusuDHa+7wOTKg1F6r0teLICuOSFiBanDK
         6Hrw==
X-Gm-Message-State: AOAM532dre31MAzRMkHv7svesGA94QPI2pi+ucRlV5bLJTa33wn6o15N
        kM0PALiUSFxbwfcQjVPVL8Y+RJO97Q0=
X-Google-Smtp-Source: ABdhPJyge7FVLy8ExniKaIZgLZQSdwHcLl2kXD6eH93ZnpEkQ4neUO4tl9dKvdlkmGpnHlst8H9pag==
X-Received: by 2002:a05:600c:3545:: with SMTP id i5mr4714886wmq.121.1619191909819;
        Fri, 23 Apr 2021 08:31:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t17sm7903054wmq.12.2021.04.23.08.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 08:31:49 -0700 (PDT)
Message-Id: <db5da7d7fb5178c14c1f5733d35bb69813c9c644.1619191907.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1011.v2.git.git.1619191907.gitgitgadget@gmail.com>
References: <pull.1011.git.git.1619173446857.gitgitgadget@gmail.com>
        <pull.1011.v2.git.git.1619191907.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 23 Apr 2021 15:31:46 +0000
Subject: [PATCH v2 2/3] refs/files-backend: stop setting errno from
 lock_ref_oid_basic
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Errno is a global variable written by almost all system calls, and therefore it
is hard to reason about its state.

This is a functional noop, because calls to lock_ref_oid_basic() in this file
are followed by:

* lock_ref_oid_basic (copy/rename rollback error path)

* write_ref_to_lockfile (both in the rollback path and the success path of
  copy/rename)

* create_symref_locked (files_create_symref)

* refs_reflog_exists (reflog expiry)

These calls do I/O and therefore clobber errno. They are not inspecting the
incoming errno.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs/files-backend.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 119972ee16f8..c9511da1d387 100644
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
@@ -962,7 +959,7 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 						     &lock->old_oid, type);
 	}
 	if (!resolved) {
-		last_errno = errno;
+		int last_errno = errno;
 		if (last_errno != ENOTDIR ||
 		    !refs_verify_refname_available(&refs->base, refname,
 						   extras, skip, err))
@@ -981,20 +978,17 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
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
@@ -1005,7 +999,6 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 
  out:
 	strbuf_release(&ref_file);
-	errno = last_errno;
 	return lock;
 }
 
-- 
gitgitgadget

