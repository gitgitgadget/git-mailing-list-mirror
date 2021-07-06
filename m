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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55ECDC07E9B
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 18:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3766761C6F
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 18:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbhGFS6p (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 14:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbhGFS6n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 14:58:43 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885BBC061762
        for <git@vger.kernel.org>; Tue,  6 Jul 2021 11:56:03 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id f17so166816wrt.6
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 11:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=krPWG5SqZmFOvLTDeEwUTlBu94EEk4+AwWkQSEtZKk8=;
        b=T91zd/B7olST55vjmHJksG1XXxX+h9xPFHQ7mvX6Hgt8keee6ou2+0LRlrIgBLSMxc
         nH2jlozXZ5Jtu6Yk5J2WEwP7zFsClNdMBDrtdxm0HblQIZB6xViD3qQkq2Zesj4lvAfB
         +kK/20kx834+3Bcd13LLwaOUm7HDpQCdIUtiFN5k7G+h2DQj4Vbe7rYurB6cl1BccCxa
         FBf5NgXPVpNxWojkenoXxaSVwxbMpDtmHNGFXQPqnUcsHSutbixLDKCPWopJpJ7UyHyi
         edils5bgML8HWC7QCcT8PnSjG9WKzWqHexDVLb1bymooNOCRTiuaMfxLMsBSJKI7YmEM
         8WmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=krPWG5SqZmFOvLTDeEwUTlBu94EEk4+AwWkQSEtZKk8=;
        b=fBBBfKTvgDdy+eu4sneV/jlLrUol1fEbDiKolMX7tIhVFoFnqcbj4z5tEIgQy2/bj8
         SX2eX5Jsyul5PaaSTtlVZ0sCiV7X1capViV0aEEF0JPyykP2EdVAY2aFcsANLdqkQ8hL
         1dEdeKCfZgOfgtRErVfMACM8e9Mc3y78LCfA4k1lFp1KtCl0S/ZFPLERF5oZd6Z0nNrS
         VUWvl2dCQFE4z8U/j+PaO/pgeQZKiGaiavP70b7u0rVjaW1YzlSPEpD66qRkJI2fqMiR
         nqBFOV7mCWWnUgyyxFZ70rU5Njao2uMWI81HrEXmZPYInR4Q0FCcZnvF0NFybEW9ahBI
         9cHg==
X-Gm-Message-State: AOAM5326Onz/ja1jpkw2BNOoUwlIeuVcZOFvn6le7o7/dR6c4lFVT4D3
        cT/IX7WQ05HgyNlS8jN7ERFrp41DK/Q=
X-Google-Smtp-Source: ABdhPJzHrbWUNUQBUSA/e0nMTixihjrn6xHpx4X5PQ9cQ6+DrSQzR1zPemsnlFVW5G1IGOvSpj1Wrg==
X-Received: by 2002:a5d:65d1:: with SMTP id e17mr22684046wrw.275.1625597762175;
        Tue, 06 Jul 2021 11:56:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j12sm17516269wro.82.2021.07.06.11.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 11:56:01 -0700 (PDT)
Message-Id: <0526a41b4b30cee67c6fea818202a106dbd66cb2.1625597757.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1012.v4.git.git.1625597757.gitgitgadget@gmail.com>
References: <pull.1012.v3.git.git.1625518566.gitgitgadget@gmail.com>
        <pull.1012.v4.git.git.1625597757.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 06 Jul 2021 18:55:57 +0000
Subject: [PATCH v4 6/6] refs: make errno output explicit for
 refs_resolve_ref_unsafe
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

This introduces refs_resolve_ref_unsafe_with_errno(), which makes the API
contract for the errno output explicit. The implementation still relies on
the global errno variable to ensure no side effects of this refactoring.

lock_ref_oid_basic() in files-backend.c is the only caller of refs_resolve_ref()
that needs error information to make logic decisions, so update that caller

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
Reviewed-By: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs/files-backend.c | 15 ++++++++-------
 refs/refs-internal.h |  8 ++++++++
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index b43ec4c66cb..d86893c6e0a 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -928,6 +928,7 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 	int mustexist = (old_oid && !is_null_oid(old_oid));
 	int resolve_flags = RESOLVE_REF_NO_RECURSE;
 	int resolved;
+	int resolve_errno = 0;
 
 	files_assert_main_repository(refs, "lock_ref_oid_basic");
 	assert(err);
@@ -940,10 +941,11 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 		resolve_flags |= RESOLVE_REF_ALLOW_BAD_NAME;
 
 	files_ref_path(refs, &ref_file, refname);
-	resolved = !!refs_resolve_ref_unsafe(&refs->base,
-					     refname, resolve_flags,
-					     &lock->old_oid, type);
-	if (!resolved && errno == EISDIR) {
+	resolved = !!refs_resolve_ref_unsafe_with_errno(&refs->base, refname,
+							resolve_flags,
+							&lock->old_oid, type,
+							&resolve_errno);
+	if (!resolved && resolve_errno == EISDIR) {
 		/*
 		 * we are trying to lock foo but we used to
 		 * have foo/bar which now does not exist;
@@ -963,15 +965,14 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 						     &lock->old_oid, type);
 	}
 	if (!resolved) {
-		int last_errno = errno;
-		if (last_errno != ENOTDIR ||
+		if (resolve_errno != ENOTDIR ||
 		    /* in case of D/F conflict, try to generate a better error
 		     * message. If that fails, fall back to strerror(ENOTDIR).
 		     */
 		    !refs_verify_refname_available(&refs->base, refname, extras,
 						   skip, err))
 			strbuf_addf(err, "unable to resolve reference '%s': %s",
-				    refname, strerror(last_errno));
+				    refname, strerror(resolve_errno));
 
 		goto error_return;
 	}
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index bf581e70cf6..df01d5dc8df 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -153,6 +153,14 @@ int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
 		      struct object_id *oid, struct strbuf *referent,
 		      unsigned int *type, int *failure_errno);
 
+/* Like refs_resolve_ref_unsafe, but provide access to errno code that lead to a
+ * failure. */
+const char *refs_resolve_ref_unsafe_with_errno(struct ref_store *refs,
+					       const char *refname,
+					       int resolve_flags,
+					       struct object_id *oid,
+					       int *flags, int *failure_errno);
+
 /*
  * Write an error to `err` and return a nonzero value iff the same
  * refname appears multiple times in `refnames`. `refnames` must be
-- 
gitgitgadget
