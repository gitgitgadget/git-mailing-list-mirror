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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD91C07E9E
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 16:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFE0E61182
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 16:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbhGKQdh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jul 2021 12:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhGKQdh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jul 2021 12:33:37 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151FFC0613E5
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 09:30:49 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id h18-20020a05600c3512b029020e4ceb9588so12575159wmq.5
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 09:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=za+jQ+6tQ/XAQO+SnRw8nPU+lR0oqLdGjG6IwOQMctw=;
        b=RogishPoqNEh6TB36sX3seBHp1Ng60khU5tY4NMWZoVLEMR8F0LgYcoMG6USVMtqD8
         dI/VKK2WSPrSfpss5F6G4k+L7eB24GrAVvXDGaQp26vKjbwJ71fNtih7GsamVGrt1qQy
         sYF53yivCsFdjRwGljoWtAUxBkh+OLH3OgwhSSas5pJ8j4meo6hp6Hr0cAqnnuwTTueZ
         JETIY6CnYTBIpjgMhzghvDAsjBbfG4Hbb/bqq3Io4PO3BbKyGIpMCtpYjuYN4mSensTz
         R88HVv3mjFic9vE+8VP/FtsQuGE3EB7rvqmLCwxEvseCQEh8Rf6xymBwFOHiU+yjlxo/
         B9aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=za+jQ+6tQ/XAQO+SnRw8nPU+lR0oqLdGjG6IwOQMctw=;
        b=SmAMJ2zBpHek975u17LcxCw4rpZGCKfuOuYUZU5olWjAUEyxue2xmLDPAaNHARAb56
         VOAiRIVIsxIWMAfR5DvWyFBmyubRbeEYMhLKvZQrmY7Fcz3HyDCETfeW4kJ9C+Bmk8Hk
         QKunFxtBLjUXOLGceWEgaIbEGoe+DGIbiBaju/+nGQbkF5vZOYzkX9co+GZMNYzn6D+C
         aaRFxj3QOp2IyPJ00uMxOpibe1g4x7agebYoAZY34+JOhHgyHGh9fKbn3hDG9vf9CGuN
         ibPKzAsZfjhJnZKeiQ5LgO34X1hMjMt/WTykmYq5NmyPlkoPwJrvpZ5cHRaAscNDKk0E
         lTzw==
X-Gm-Message-State: AOAM530Bbi/P9InsuDDWPxFqySFJ2ESXdl0F8l5t8jFt3TqlTLZnkVyh
        1DWzFpWO/5Q3QNeJmxGgEKmzlEGydUXtWA==
X-Google-Smtp-Source: ABdhPJxEwn2Um3fOEZBuI0/RleXgruW3dhwl6ZqA/g6xcLwa5MlSlNaXnLGJtZW+7teiT1BJFYoj7Q==
X-Received: by 2002:a05:600c:2a4b:: with SMTP id x11mr19150594wme.22.1626021047439;
        Sun, 11 Jul 2021 09:30:47 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w3sm678091wrt.55.2021.07.11.09.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 09:30:46 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6? 02/17] refs/files-backend: stop setting errno from lock_ref_oid_basic
Date:   Sun, 11 Jul 2021 18:30:26 +0200
Message-Id: <patch-02.17-61cf7611473-20210711T162803Z-avarab@gmail.com>
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
 refs/files-backend.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 677b7e4cdd2..f0ce0aac857 100644
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
@@ -961,14 +958,15 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 						     refname, resolve_flags,
 						     &lock->old_oid, type);
 	}
-	if (!resolved) {
-		last_errno = errno;
-		if (last_errno != ENOTDIR ||
-		    !refs_verify_refname_available(&refs->base, refname,
-						   extras, skip, err))
-			strbuf_addf(err, "unable to resolve reference '%s': %s",
-				    refname, strerror(last_errno));
-
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
 
@@ -981,20 +979,17 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
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
@@ -1005,7 +1000,6 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 
  out:
 	strbuf_release(&ref_file);
-	errno = last_errno;
 	return lock;
 }
 
-- 
2.32.0-dev

