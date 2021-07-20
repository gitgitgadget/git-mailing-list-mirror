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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBC3C07E95
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 10:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB0A661003
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 10:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234146AbhGTJxs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 05:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237882AbhGTJw7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 05:52:59 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF62C061767
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 03:33:37 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id g8-20020a1c9d080000b02901f13dd1672aso1326671wme.0
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 03:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=304iIfSiGLscPNtKwb+exyYfNv+ZazXaWiDUM5C6rP4=;
        b=jqi/deN+TLx0cNDvVA24/iv6TRnCueQ+scSGAqumxOtSfTHtKIQ7lLqbp4YZhXym2S
         td0NCcH4BOhoKm7fsny/Mq8D3KpGQ9Lk9dKTU6YebyVS02jz09c3ZZQWooiCUysnTdHY
         RkYZKeBI0y3jLQjkt8xOEWZ3X9EeGNiedHBkIJdtGeUixtFvY5DHVv2fTpIouBSZ6EIf
         iNNKsjxzalgatDUV01fvG0wrmV21OsRRtLjrdPT59lnxTWnTtZNqMcFovjmtJqEIf1Hd
         3uOiWnMFCvMSiHwpLxn5rMnrtn7ewucL3MidIas3IWbSWskjNO89KjH3/y/LIr67NgbF
         NHyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=304iIfSiGLscPNtKwb+exyYfNv+ZazXaWiDUM5C6rP4=;
        b=g/D7xMICTRq0rY09QAj4OfcEi/mHEU6quZ35eYJEgNLMcLSHW6MJktmIedXS86/UML
         NtO8eaUYT0VuCwvWupuUn+XUUZqsYemQhdMKCYmXV3A8+LITam7wp2uvCzoBWc2iiUM1
         DHT5Ft/+W9jsJVBq7RQ5Pc3sYd6g0Fux8j0xdezBzhOiF93ogy7YRjgEhilB4qOzGJEw
         lAKqBVU+4U/Y0jftm/uf3N9Xp5nmf5aZovgZCHOoikucWhpOCN5KzOMDRaytbC4lZJ5E
         WxpGsXw9pILe6r0TJFVpoOZDI1UVPG+ZyiZXHklaPfd0z3ha8MtvO3t6UBAQQc4e6yGF
         EeBA==
X-Gm-Message-State: AOAM533JNW/4uUToFRw5x2I8EO0SP7EbPMrFWrO1hJsNXWsJRM4pxlJU
        X08Tk/9VTk/8OXRah8VvRt+CrJCtrqt+iQ==
X-Google-Smtp-Source: ABdhPJy+V5KaGLsqajTHLAbRoAo9imp9s3sVLQUz+hzeh3rCIS09BK1yAe9uGk5yBS6t0GkaodklWg==
X-Received: by 2002:a7b:cb13:: with SMTP id u19mr30363568wmj.122.1626777216030;
        Tue, 20 Jul 2021 03:33:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l14sm22179852wrs.22.2021.07.20.03.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 03:33:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v9 3/7] refs/files-backend: stop setting errno from lock_ref_oid_basic
Date:   Tue, 20 Jul 2021 12:33:26 +0200
Message-Id: <patch-3.7-0dd8a4c1209-20210720T102644Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.874.ge7a9d58bfcf
In-Reply-To: <cover-0.7-00000000000-20210720T102644Z-avarab@gmail.com>
References: <cover-0.7-00000000000-20210716T142032Z-avarab@gmail.com> <cover-0.7-00000000000-20210720T102644Z-avarab@gmail.com>
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

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs/files-backend.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 9fc596fc75a..9e00da76121 100644
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
@@ -1002,11 +1000,10 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 	if (!refs_resolve_ref_unsafe(&refs->base, refname,
 				     RESOLVE_REF_NO_RECURSE,
 				     &lock->old_oid, type)) {
-		last_errno = errno;
 		if (!refs_verify_refname_available(&refs->base, refname,
 						   NULL, NULL, err))
 			strbuf_addf(err, "unable to resolve reference '%s': %s",
-				    refname, strerror(last_errno));
+				    refname, strerror(errno));
 
 		goto error_return;
 	}
@@ -1019,15 +1016,12 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
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
@@ -1044,7 +1038,6 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 
  out:
 	strbuf_release(&ref_file);
-	errno = last_errno;
 	return lock;
 }
 
-- 
2.32.0.874.ge7a9d58bfcf

