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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C39EC07E95
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 19:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 036DB61CCC
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 19:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbhGGTKp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jul 2021 15:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbhGGTKi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jul 2021 15:10:38 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687FAC061760
        for <git@vger.kernel.org>; Wed,  7 Jul 2021 12:07:57 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id t14-20020a05600c198eb029020c8aac53d4so14011322wmq.1
        for <git@vger.kernel.org>; Wed, 07 Jul 2021 12:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=UeWzuA2GPf46Kjx6p9Ss1NudAAoidr8Z9RGTJp2ICOs=;
        b=q/k/+ORSzlFRarkD0QlZ8LHmiYvMoXVXVYGbIfHS5er5ADJQB9dAQXY+FOSjP1H0Lj
         BFl7YmGIlhR82DmJVbo8V4a8m/QdL8w8mQyswmhl2drWuWW8MgKUJFaJ4L1kfxlT186K
         amJXi8JF4huYiSIsnG1bR09gW04PwQq2yVZAo6ppjZHIYsPcHqyy3Eb396yGdAugrLdR
         o8OKsUBAzcwQB6IUB1BJ5Q+pzy06R0sgjYMtkz/93NKH0cCbssp4fmb71GLFtrzsVIJd
         QflJ+lRfQ5j2anjSRloFfMTfUOxYxUVQ/BAkdGWjqXI4XInyv96XldIUY39sQ41QcbQZ
         XLZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=UeWzuA2GPf46Kjx6p9Ss1NudAAoidr8Z9RGTJp2ICOs=;
        b=Qj2/wMO3MHzRLABsLpV50Ensytc4VPv//qO1cXXA0TLWkA7vRmZf0ZXiPuQ2uf/8Nm
         w7stNCZL/aahv9RUBIdLzcjC1QSF8RSgtVZmdwFu3mhdL2Yq9lKV2uFim05fsO/4jDec
         eyzIf86Ft/ltQ0fEOa6T4OMImG0OkIcwbD1YXm0oor3RgT0zBM8DWD3QG6EOJ7rGq1yP
         dDlu5V6ZGaUZHRl7z84Cj4i7udyf6QrPBroAFV6F0XoXyYwqeCw/OMpWluvU2ht0BxYf
         oSfgibTqUQJVRb73JrHY0Q/b8smK9gheFPz/2+VOWEBA+drzLQ2hCCfsrlMqmcbJJ1uE
         r/rg==
X-Gm-Message-State: AOAM531HSLE0hHF5LLE+9gmPdSza9CWap3slbk/nuCnVTVCpqFxDvpoN
        D2rTLM02Q3DP3xbZILfl9HQISo231NQ=
X-Google-Smtp-Source: ABdhPJyvzPyjKRPBSoNAR7nmn8paBSQYXspt8u5jdpPL4yf6ThzZ/3ikS8FParyq1fkwis0cPgHgkg==
X-Received: by 2002:a1c:b457:: with SMTP id d84mr637356wmf.144.1625684875104;
        Wed, 07 Jul 2021 12:07:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u1sm17598000wmm.6.2021.07.07.12.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 12:07:54 -0700 (PDT)
Message-Id: <85a14bde90476bae765fe83edef414337fba377a.1625684869.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1012.v5.git.git.1625684869.gitgitgadget@gmail.com>
References: <pull.1012.v4.git.git.1625597757.gitgitgadget@gmail.com>
        <pull.1012.v5.git.git.1625684869.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 07 Jul 2021 19:07:49 +0000
Subject: [PATCH v5 6/6] refs: make errno output explicit for
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
Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs/files-backend.c | 15 ++++++++-------
 refs/refs-internal.h |  8 ++++++++
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 7aafdf2ce3d..d6a7a0ee919 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -929,6 +929,7 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 	int mustexist = (old_oid && !is_null_oid(old_oid));
 	int resolve_flags = RESOLVE_REF_NO_RECURSE;
 	int resolved;
+	int resolve_errno = 0;
 
 	files_assert_main_repository(refs, "lock_ref_oid_basic");
 	assert(err);
@@ -941,10 +942,11 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
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
@@ -964,15 +966,14 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
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
