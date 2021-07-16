Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47496C636CA
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 14:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29466613F5
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 14:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240100AbhGPOZp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 10:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbhGPOZg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 10:25:36 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC78C061764
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 07:22:39 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id i94so12309280wri.4
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 07:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qGw4pF+/zu6oie8tEYy8CzZCe1JD3M57QqLH7HxpbdI=;
        b=tOk//XR0gfRV3Dlcu1pb/gb89OMLM9BGzUie6HcdSpDxtuKBk8IEY7CJCk1qxlKths
         XaKh33DMnSx5q3/p739/Ix8Wg5B0rnQio5BA+6rFXlETTKrXEsE2z/Rwctxuggu6dt1c
         wFe8K8FY3tgqKFi7qZBhosM6Sogxmm7cR2NIJc0pI3ZbeIAHO3+zPPTu0eqQRl49fUC4
         LJ0kzoNVyQ6M23RS9CtjMfWkXfED/K3wJUwe8+KqPylVMRJ0FTl0ZUPMbBHwND11KttV
         m/SjEjVp62tOXgzaZ/LxE9Q3CiFDakLSYSH/hFPinDsAs85GGhpCDl4Bk4mQERW2g2Ms
         4fFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qGw4pF+/zu6oie8tEYy8CzZCe1JD3M57QqLH7HxpbdI=;
        b=YIVeeaT+XP+iabRSmibqtrRlp1m2FGY32vTNIUh1Gdbna9G3k1ta2UEIIlFC7b//Wh
         tVYtwWyokgP75X/yoYEfmRwsy52LaR06PkONzWPJ97tMBqQFGZfYZM7FRvfciQxiW6MJ
         BrHNCc7sWLsgspTgi5aIJx61P4xcJu/y0q5nb8ztwcgpOZBuFgNb4AnCigpSzUC05Yv1
         tqWmiKKQh7dIAkrlCN3GhrHWJXQCNUvcwEJMwCNr059WJEZMOJuR+KMgxn+NNKdXvuIA
         I4LtGpXhsGsSzZA1x5icFVWv/PoSdt3jxFZv+uHVDoDIshnX8evZnwjle5gegmcGtBYw
         o0mQ==
X-Gm-Message-State: AOAM530XYBGwA+o+nET019tr7SoKHlAbUU/hDOM5VU29HwXOlMK4Zu+O
        xIz7dLbljRGj6+YUVMrrJfghumE9W+rD5A==
X-Google-Smtp-Source: ABdhPJyOzxVfAh/gI13eNIqx+QeeIqSOOBD84CDeTR8RZRUpIl8T0KnMIu0IP6Sk+ulLEEXa/I/93Q==
X-Received: by 2002:a5d:4bc4:: with SMTP id l4mr12594166wrt.67.1626445357674;
        Fri, 16 Jul 2021 07:22:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z7sm7463236wmp.34.2021.07.16.07.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 07:22:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v8 3/7] refs/files-backend: stop setting errno from lock_ref_oid_basic
Date:   Fri, 16 Jul 2021 16:22:28 +0200
Message-Id: <patch-3.7-a3f80c6d2f7-20210716T142032Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.874.gfa1990a4f10
In-Reply-To: <cover-0.7-00000000000-20210716T142032Z-avarab@gmail.com>
References: <cover-0.6-0000000000-20210714T114301Z-avarab@gmail.com> <cover-0.7-00000000000-20210716T142032Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

In the case of the "errno != ENOTDIR" case that originates in 5b2d8d6f218
(lock_ref_sha1_basic(): improve diagnostics for ref D/F conflicts,
2015-05-11), there the "last_errno" was saved away to return it from
lock_ref_oid_basic(), now that we're no longer doing that we can skip
that entirely and use "errno" directly. A follow-up change will
extract the specific errno we want earlier in this function.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs/files-backend.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 36af99af844..a6a9f2b99fa 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -982,7 +982,6 @@ static int create_reflock(const char *path, void *cb)
 
 /*
  * Locks a ref returning the lock on success and NULL on failure.
- * On failure errno is set to something meaningful.
  */
 static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 					   const char *refname,
@@ -991,7 +990,6 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 {
 	struct strbuf ref_file = STRBUF_INIT;
 	struct ref_lock *lock;
-	int last_errno = 0;
 
 	files_assert_main_repository(refs, "lock_ref_oid_basic");
 	assert(err);
@@ -1001,14 +999,15 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 	files_ref_path(refs, &ref_file, refname);
 	if (!refs_resolve_ref_unsafe(&refs->base, refname,
 				     RESOLVE_REF_NO_RECURSE,
-				     &lock->old_oid, type)) {
-		last_errno = errno;
-		if (last_errno != ENOTDIR ||
-		    !refs_verify_refname_available(&refs->base, refname,
-						   NULL, NULL, err))
-			strbuf_addf(err, "unable to resolve reference '%s': %s",
-				    refname, strerror(last_errno));
-
+				     &lock->old_oid, type) &&
+	    (errno != ENOTDIR ||
+	     /* in case of D/F conflict, try to generate a better error
+	      * message. If that fails, fall back to strerror(ENOTDIR).
+	      */
+	     !refs_verify_refname_available(&refs->base, refname, NULL,
+					    NULL, err))) {
+		strbuf_addf(err, "unable to resolve reference '%s': %s",
+			    refname, strerror(errno));
 		goto error_return;
 	}
 
@@ -1020,15 +1019,12 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 	 */
 	if (is_null_oid(&lock->old_oid) &&
 	    refs_verify_refname_available(refs->packed_ref_store, refname,
-					  NULL, NULL, err)) {
-		last_errno = ENOTDIR;
+					  NULL, NULL, err))
 		goto error_return;
-	}
 
 	lock->ref_name = xstrdup(refname);
 
 	if (raceproof_create_file(ref_file.buf, create_reflock, &lock->lk)) {
-		last_errno = errno;
 		unable_to_lock_message(ref_file.buf, errno, err);
 		goto error_return;
 	}
@@ -1045,7 +1041,6 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 
  out:
 	strbuf_release(&ref_file);
-	errno = last_errno;
 	return lock;
 }
 
-- 
2.32.0.874.gfa1990a4f10

