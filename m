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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8611C07E95
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 10:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF99461107
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 10:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237625AbhGTJyV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 05:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237352AbhGTJxI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 05:53:08 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2050AC0613DD
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 03:33:41 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id g8-20020a1c9d080000b02901f13dd1672aso1326743wme.0
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 03:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cog0ZtNZpMOyK/ahzkmspl6CXOBmDJRhbOcaYmSSGqY=;
        b=M9rAocSeb99YgvXxXqsMc47zluSImvBVtBGWKBQ/wbR9DI9ui+7g6v5en0KSdguMNT
         Q99+B/IrnIR52JDIcax1w6c1r9zl1sezB0uCWRFG6RRa3N9GFyqkFlzaCf4JiWAUwiYx
         Pv1ZfNR06i8lhJEJCJg9dPN0DrvsM9J96zlwgcg/wHtFvhVQsVDVvCOY4y5YhQlXdkeE
         9gRrIiyhMxoz3b/rhUGka06UvYOJb7lrhx/Gq022MNdaUq5vvvn4k8LBPI5CzkZfHWYY
         TN/w6s95aSlju2NLYK5P2efnoDDizTMGPyHDVUHAJ7LoQjX+IwyioLq0brhP2FB1iR9M
         Ah5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cog0ZtNZpMOyK/ahzkmspl6CXOBmDJRhbOcaYmSSGqY=;
        b=DM1m+mQXPE4PIQQBj/edJB6UzoB+WrehRoyUbKDMtjxJ7+1nY4QLJcKkB15XGSaICV
         k0UqZAu3q4c4JDqW4gUC8MKeInfuVS2urlUfw1tcuLKodKt0PcP87qSXkZ7AYTxNI1yH
         bdWH1URu769qx7VV56hZISg8+C5wthyGYvvp8cG70IrJvoykO4IldXrbD9GeS1uk9mJR
         a/HcPLjtsXHGvPLMr2azyeehR6fcHN7BxfXsv/f+r3VSD7TrXNrhvpeRizAhYBnjtvrT
         LrMaSOHh0hMu/JSASNFnwZ3915PmsSyg6DrRv4UluZfXiFzr9xPuR1oAI2D25m+n9+jw
         buDA==
X-Gm-Message-State: AOAM532IL8YfeEEc7QB2uMHyL1uesuoPXuKkx5Tr8i09vslBFcKN4aUc
        PkRTj84ZCekODfWJZ4XHseDGF/cum31dng==
X-Google-Smtp-Source: ABdhPJwNVsrN1P3Kg/hS7YzQCrGfk/tTU2JdLxtVy9jFEvaWy1CQoGagxWnHQH6t/HcgLjqxMa22NQ==
X-Received: by 2002:a1c:1bd4:: with SMTP id b203mr37259429wmb.171.1626777219531;
        Tue, 20 Jul 2021 03:33:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l14sm22179852wrs.22.2021.07.20.03.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 03:33:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v9 7/7] refs: make errno output explicit for refs_resolve_ref_unsafe
Date:   Tue, 20 Jul 2021 12:33:30 +0200
Message-Id: <patch-7.7-4b5e168b978-20210720T102644Z-avarab@gmail.com>
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

This introduces refs_resolve_ref_unsafe_with_errno(), which makes the API
contract for the errno output explicit. The implementation still relies on
the global errno variable to ensure no side effects of this refactoring.

lock_ref_oid_basic() in files-backend.c is the only caller of refs_resolve_ref()
that needs error information to make logic decisions, so update that caller

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs.c               |  2 +-
 refs.h               | 11 +++++++++++
 refs/files-backend.c | 10 ++++++----
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index b31dbdd0fa2..9497b51e0a1 100644
--- a/refs.c
+++ b/refs.c
@@ -1688,7 +1688,7 @@ int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
 					   type, failure_errno);
 }
 
-static const char *refs_resolve_ref_unsafe_with_errno(struct ref_store *refs,
+const char *refs_resolve_ref_unsafe_with_errno(struct ref_store *refs,
 					       const char *refname,
 					       int resolve_flags,
 					       struct object_id *oid,
diff --git a/refs.h b/refs.h
index c009707438d..ba09ba0687b 100644
--- a/refs.h
+++ b/refs.h
@@ -68,6 +68,17 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 				    int resolve_flags,
 				    struct object_id *oid,
 				    int *flags);
+/**
+ * refs_resolve_ref_unsafe_with_errno() is like
+ * refs_resolve_ref_unsafe(), but provide access to errno code that
+ * lead to a failure. We guarantee that errno is set to a meaningful
+ * value on non-zero return.
+ */
+const char *refs_resolve_ref_unsafe_with_errno(struct ref_store *refs,
+					       const char *refname,
+					       int resolve_flags,
+					       struct object_id *oid,
+					       int *flags, int *failure_errno);
 const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 			       struct object_id *oid, int *flags);
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 746831c86cb..68182296c1b 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1001,6 +1001,7 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 {
 	struct strbuf ref_file = STRBUF_INIT;
 	struct ref_lock *lock;
+	int resolve_errno = 0;
 
 	files_assert_main_repository(refs, "lock_ref_oid_basic");
 	assert(err);
@@ -1008,13 +1009,14 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 	CALLOC_ARRAY(lock, 1);
 
 	files_ref_path(refs, &ref_file, refname);
-	if (!refs_resolve_ref_unsafe(&refs->base, refname,
-				     RESOLVE_REF_NO_RECURSE,
-				     &lock->old_oid, type)) {
+	if (!refs_resolve_ref_unsafe_with_errno(&refs->base, refname,
+						RESOLVE_REF_NO_RECURSE,
+						&lock->old_oid, type,
+						&resolve_errno)) {
 		if (!refs_verify_refname_available(&refs->base, refname,
 						   NULL, NULL, err))
 			strbuf_addf(err, "unable to resolve reference '%s': %s",
-				    refname, strerror(errno));
+				    refname, strerror(resolve_errno));
 
 		goto error_return;
 	}
-- 
2.32.0.874.ge7a9d58bfcf

