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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E889BC07E95
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 14:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD270613E8
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 14:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240442AbhGPOQT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 10:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240345AbhGPOQQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 10:16:16 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE30C06175F
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 07:13:20 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id f17so12286569wrt.6
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 07:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CFcUnjPDZ7o3ewS/Gobz4606x19jZJaXfnETmgvRaPs=;
        b=smJTMHDMbKy43e36hXz0dkh6M4LtNUsLeWBUAQ5Js44JzHXT+o8xa4PUK0AORUcsuG
         /m8KCAowFtLLA1Tx4APbIkL35ujltHrMJF+ifR+DMDz0U0JgP1dbi/8jbnNqXs1rcnD6
         soucPuLHRgIIq+WcvWrRtCWu/590RelB2iBrwF0R9p3GhiYt1JvtbuitnETgKFPWBT6b
         VsB/AeshkdYP8xrjW4+gRIzDs31Knl54HZRhucsTU2j4st97SGuyaRhjjMs9LseUAQRi
         sLB4vSr4xyNYt3Jh0v1689tu9OjRlIypgln9b5/bRv4QopJLqc+yRF8Ch3pDO+Ip8J+a
         9pKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CFcUnjPDZ7o3ewS/Gobz4606x19jZJaXfnETmgvRaPs=;
        b=JlHdN+q/DN5t4vNE/FYkL55oG0YU4/OCu56MRdC//6FLoy7cF7kHTarGknbT+/3zcO
         hZhUxnD7UnRo6s+HA++YyFm3XilUrM6pWMArCA7R48qBMuzbcOF7W/F/zy4xB4JxDlCW
         c4vKZhLAKeT0oYaozxDiVCUNGNUE0qVEI5VTvvcG/nq/BwsdrdSxeT5yyNHmM8WEC3ZD
         qsxyihmc4Ony+B3FVTRqoHR/6s1hCdI44K66wjFxQzHi2j1pTrCPYFok4IvKg6e+PLcR
         lkxByqeawNMxrBdYem+8uhS3mKwrFd5SD1WjckDtdOBtE6q0XziFrP5mjDWuNEaU60di
         pOPA==
X-Gm-Message-State: AOAM533h65cuqNX9TUBxnny9t4OJj+lu6O7Vymhwc2MnDAOM/wMqolds
        yAXyXasIMhpz1WvQfFPb5dsaFnGmjGIBGA==
X-Google-Smtp-Source: ABdhPJwazC3j7fFCCQYFF2x54ymzLsjelA/5WJFDzXO9Q0VBCveuKpTdN7To3Ggnw/wgUzh0+u+qwQ==
X-Received: by 2002:a5d:5142:: with SMTP id u2mr12354414wrt.314.1626444799124;
        Fri, 16 Jul 2021 07:13:19 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a9sm10101363wrv.37.2021.07.16.07.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 07:13:18 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 03/11] refs/files: remove unused "extras/skip" in lock_ref_oid_basic()
Date:   Fri, 16 Jul 2021 16:12:59 +0200
Message-Id: <patch-03.11-94ffcd8cfda-20210716T140631Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.874.gfa1990a4f10
In-Reply-To: <cover-00.11-00000000000-20210716T140631Z-avarab@gmail.com>
References: <patch-1.1-de0838fe99-20210714T111351Z-avarab@gmail.com> <cover-00.11-00000000000-20210716T140631Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The lock_ref_oid_basic() function has gradually been replaced by use
of the file transaction API, there are only 4 remaining callers of
it.

None of those callers pass non-NULL "extras" and "skip" parameters,
the last such caller went away in 92b1551b1d4 (refs: resolve symbolic
refs first, 2016-04-25), so let's remove the parameters.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs/files-backend.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 326f0224218..a59823d667e 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -915,8 +915,6 @@ static int create_reflock(const char *path, void *cb)
 static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 					   const char *refname,
 					   const struct object_id *old_oid,
-					   const struct string_list *extras,
-					   const struct string_list *skip,
 					   unsigned int flags, int *type,
 					   struct strbuf *err)
 {
@@ -950,7 +948,7 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 			last_errno = errno;
 			if (!refs_verify_refname_available(
 					    &refs->base,
-					    refname, extras, skip, err))
+					    refname, NULL, NULL, err))
 				strbuf_addf(err, "there are still refs under '%s'",
 					    refname);
 			goto error_return;
@@ -963,7 +961,7 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 		last_errno = errno;
 		if (last_errno != ENOTDIR ||
 		    !refs_verify_refname_available(&refs->base, refname,
-						   extras, skip, err))
+						   NULL, NULL, err))
 			strbuf_addf(err, "unable to resolve reference '%s': %s",
 				    refname, strerror(last_errno));
 
@@ -978,7 +976,7 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 	 */
 	if (is_null_oid(&lock->old_oid) &&
 	    refs_verify_refname_available(refs->packed_ref_store, refname,
-					  extras, skip, err)) {
+					  NULL, NULL, err)) {
 		last_errno = ENOTDIR;
 		goto error_return;
 	}
@@ -1413,8 +1411,8 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 
 	logmoved = log;
 
-	lock = lock_ref_oid_basic(refs, newrefname, NULL, NULL, NULL,
-				  REF_NO_DEREF, NULL, &err);
+	lock = lock_ref_oid_basic(refs, newrefname, NULL, REF_NO_DEREF, NULL,
+				  &err);
 	if (!lock) {
 		if (copy)
 			error("unable to copy '%s' to '%s': %s", oldrefname, newrefname, err.buf);
@@ -1436,7 +1434,7 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 	goto out;
 
  rollback:
-	lock = lock_ref_oid_basic(refs, oldrefname, NULL, NULL, NULL,
+	lock = lock_ref_oid_basic(refs, oldrefname, NULL,
 				  REF_NO_DEREF, NULL, &err);
 	if (!lock) {
 		error("unable to lock %s for rollback: %s", oldrefname, err.buf);
@@ -1845,7 +1843,7 @@ static int files_create_symref(struct ref_store *ref_store,
 	int ret;
 
 	lock = lock_ref_oid_basic(refs, refname, NULL,
-				  NULL, NULL, REF_NO_DEREF, NULL,
+				  REF_NO_DEREF, NULL,
 				  &err);
 	if (!lock) {
 		error("%s", err.buf);
@@ -3064,7 +3062,7 @@ static int files_reflog_expire(struct ref_store *ref_store,
 	 * reference if --updateref was specified:
 	 */
 	lock = lock_ref_oid_basic(refs, refname, oid,
-				  NULL, NULL, REF_NO_DEREF,
+				  REF_NO_DEREF,
 				  &type, &err);
 	if (!lock) {
 		error("cannot lock ref '%s': %s", refname, err.buf);
-- 
2.32.0.873.gb6f2f696497

