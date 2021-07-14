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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5820C11F67
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 11:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 889FF613B2
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 11:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239222AbhGNLqe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 07:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239092AbhGNLqd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 07:46:33 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2018DC06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 04:43:41 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id a13so2803130wrf.10
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 04:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5oDThoYVkZB7BkYpI7BcLaXbdimnoSE/BTEhDelbPRQ=;
        b=jUyTa+GUJAurarZOXJw5x8sSwfO0SLxtS/n8hZjVh7E/yWQRFzLg+I8eZn2kKEDr3F
         8o1Zvk29NN9jko38DDPziMOTSFUxIeapZ0/RnSWICssoohP06CxDD6T0A4o9nCLPp5TL
         IYPcLCij4eMdKIjB3FxFNR/7W7KrC43zrDSm46RJ4Eu7bcZ4D2MlQs7j7sDyGS+kyTeC
         3i4Ih68DYIQVRaBenOUWUVAgKMEnQyDQG/RGy+0mW/rfXnvuM4n17beey46kjMSJV3nX
         pRTfMAI1Hcw7CP8RwF1jsqSxNLaOflp70DtsR6gDAT5YxVRQU+dT54WnpGTnduEeB/Gj
         1P8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5oDThoYVkZB7BkYpI7BcLaXbdimnoSE/BTEhDelbPRQ=;
        b=GZHNHZRpJWQIdMnd9csAdwC8K7vqEigaemnRZsqh2UarPDhoX23wbyjTFtkT8wgrGv
         TRzxrlj8WeVj50jPyIhH66tzwXa1S+aSeWX8LmGei9pPVjMs04E4mGDRKsppC0rKVhrl
         SV+aZmpQjFWsAImXLI8YnY0RE3WRCZJqEvA2NJPmvKwHnJ7EnLFFMvurWATRUPObEhrx
         oS2RUBexlZcJp/lOgQW1CqCdpgsnanfxGF60QUHogoRgkCNLPqRXgwcGcnYCDX3b0Mc5
         J1Yl3rs3VbZwz5tYJEFoP3Y5eLMOXHIxeGadOyTYzzbExbF/3iOLx8L/Ljkv/GDUoF6Y
         +KkA==
X-Gm-Message-State: AOAM533lSoyzK08LGEMnpZYODHMKwyktlbYOglRkd2RndyknIYHrBUIf
        6Loy+8Red5yiD6uGeeTw2nOD2KKjQwF9QHqD
X-Google-Smtp-Source: ABdhPJw/ZPk6vV3Lt53nKYk8pUy7yqeY46c6c77feCOTOIWNMsk7SRPaNbuB+MmmSxQSmTff3vt0Jg==
X-Received: by 2002:a05:6000:1a8b:: with SMTP id f11mr12449345wry.408.1626263019428;
        Wed, 14 Jul 2021 04:43:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a8sm2373626wrt.61.2021.07.14.04.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 04:43:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 2/6] refs/files-backend: stop setting errno from lock_ref_oid_basic
Date:   Wed, 14 Jul 2021 13:43:30 +0200
Message-Id: <patch-2.6-fd8e356185-20210714T114301Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.851.g0fc62a9785
In-Reply-To: <cover-0.6-0000000000-20210714T114301Z-avarab@gmail.com>
References: <cover-00.17-00000000000-20210711T162803Z-avarab@gmail.com> <cover-0.6-0000000000-20210714T114301Z-avarab@gmail.com>
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
 refs/files-backend.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 7e4963fd07..45f198c3fc 100644
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
@@ -941,13 +939,15 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 	resolved = !!refs_resolve_ref_unsafe(&refs->base,
 					     refname, resolve_flags,
 					     &lock->old_oid, type);
-	if (!resolved) {
-		last_errno = errno;
-		if (last_errno != ENOTDIR ||
-		    !refs_verify_refname_available(&refs->base, refname,
-						   extras, skip, err))
-			strbuf_addf(err, "unable to resolve reference '%s': %s",
-				    refname, strerror(last_errno));
+	if (!resolved &&
+	    (errno != ENOTDIR ||
+	     /* in case of D/F conflict, try to generate a better error
+	      * message. If that fails, fall back to strerror(ENOTDIR).
+	      */
+	     !refs_verify_refname_available(&refs->base, refname, extras,
+					    skip, err))) {
+		strbuf_addf(err, "unable to resolve reference '%s': %s",
+			    refname, strerror(errno));
 
 		goto error_return;
 	}
@@ -961,20 +961,17 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
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
@@ -985,7 +982,6 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 
  out:
 	strbuf_release(&ref_file);
-	errno = last_errno;
 	return lock;
 }
 
-- 
2.32.0.851.g0fc62a9785

