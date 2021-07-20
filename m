Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1261C6377C
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 10:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B563E61221
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 10:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237839AbhGTJuJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 05:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237665AbhGTJqO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 05:46:14 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C521FC0613B4
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 03:24:26 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id l7so25402105wrv.7
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 03:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZfM4QF8THUoYTTDvmBhCmR4GPrCTFDwxvRw2PaS2nSM=;
        b=iHQvBV3Tqsx0EY0KbW/oNeUVBJWJsozMFTZYLW0HqP3zW8/OEN/FEWaNxNmBDgUrRc
         GKN5Gk6q6trPsuTD3vEMsGupKG4rKa42TEJ1LSShfHKHl00fe4RFj3Mbf1ovIaEJ3g23
         M4TQV5icNfezz9tViNLlpoxf7oi25ZS/MpL/DbM/Ydte9jA24J8v9Hii21HiFg42qsY7
         Rk3lODeTaxIMP81CXUKMpyNyEt8hICce+PbDWprnkXSUHe0gSvzCPLcGWgNCX9qdTNHe
         GutLZT07DYQJBAo/5USbXLGZHfagmJGnmWglYu3jqbsTEz1jqmTdro/rnE49NuJBk9Lg
         amBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZfM4QF8THUoYTTDvmBhCmR4GPrCTFDwxvRw2PaS2nSM=;
        b=Vc1ffOGYjNKwNzRsPDHSImbz3uUxBQdc8ajDISFn/tP8Fu6nM+hYjX6cgXdAJJ6rVh
         FGndoT+CdkfOUTUmSu2Om7gCRU0LlnyF8vl52RgmiJJsTFl/BEKah8eMIVpWaCBx1zf9
         tXmblw8FE7sVpcOG4dexwbgoRl3LTtNy2SuXjCsUFDrCEgx+nKOktf6dbFkmokAuKaiK
         sM1GxxZGG04qHnxq+tEhNoOjWEMG0WK5k9Vm7yRdI072Hhwv1o7FDzMjNKCuIOBYKaUG
         rIVzQVbwD8z4on23Ed/N0j+ElEp2gaEY8mqKREdRsNESwD6tPrVAdnz6qte5k7amtagf
         iRBQ==
X-Gm-Message-State: AOAM533tEL9+Ju6jy9/084nExS0xrrN9UijkKfIvk2y2/R6ICGPV136Y
        OucIYgRddVsBAmeS+x3A3VbEiJeYsWkgMA==
X-Google-Smtp-Source: ABdhPJzkkrdfvW/smDFOmMPyeLaJSlvmB21h2Ego/Yz85iPZYgbbK8XH4v/w5yqJuZm2icdvxR83aQ==
X-Received: by 2002:a5d:528d:: with SMTP id c13mr35420853wrv.343.1626776665072;
        Tue, 20 Jul 2021 03:24:25 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l23sm9684536wme.22.2021.07.20.03.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 03:24:24 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 03/12] refs/files: remove unused "extras/skip" in lock_ref_oid_basic()
Date:   Tue, 20 Jul 2021 12:24:08 +0200
Message-Id: <patch-03.12-0f2262fec69-20210720T102051Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.874.ge7a9d58bfcf
In-Reply-To: <cover-00.12-00000000000-20210720T102051Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20210716T140631Z-avarab@gmail.com> <cover-00.12-00000000000-20210720T102051Z-avarab@gmail.com>
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
2.32.0.874.ge7a9d58bfcf

