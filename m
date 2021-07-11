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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A244C07E9C
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 16:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45AFD61182
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 16:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbhGKQdo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jul 2021 12:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232640AbhGKQdk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jul 2021 12:33:40 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5F5C0613E5
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 09:30:52 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso12553594wmh.4
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 09:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bPjsclnnKKfm4eVG4vfMZB0exx266GwZmnGqzPzs+JY=;
        b=abeatMbHvjrV3dHOVi94hSmwBp4YaW1X134LRx3S+uaxisZtFIP5SDlcrI+j6AAili
         Pp17ncmaZpCaF39DsXJq8NKn0E5m0GbzDQ4yYwaqznyehU3qWxFXM5Qr79Eh372SYo5z
         XJPvjb1xYkEW2tsp1BoJbUA+zY9vPcwbvDgYN6PrurPh81QNgC1CSqEHiHF+uN5myEkU
         Mj5zrVfBMsC02RF6ZV/+rDMeFqfFy8X3njQN7FgNfPStNG3Dv6roZSVcXmosoyK8FhQ2
         zVan86hli+kBL+B9r+DAfXE0RsVxPUHyUH8zWn6/mnKyH2PYdAH4K95KnVmnHvaOOnlm
         uBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bPjsclnnKKfm4eVG4vfMZB0exx266GwZmnGqzPzs+JY=;
        b=iJGCX8InR4zzSFsI6s2amCAGZoB2Dc5rE9t2dRGc3iG2aSd/l+IxfA4rmLekuYECjz
         pNVT25Y0N3j/+yeDM4REq37uMor9itFYulvT8xf17wB2H31uweMPBvlsFtsD/JJu1hHW
         tqUiBFsgaO5e31BfjkeG+ifP9kWTHfuDtRF94Yb3wYOdK/6oCGqaMES78pFhpW6aT3E/
         FT1K4b0+KvH884DQteGx5CoG7pXNLxQildfarJnbF9XEsRIR4RkDitaymCXh+zObs6Cs
         ywHd1eK8LPqpe5dAw9VUhYsBVnAUH3EjiPFijfa5uBqr+bhrTaAulbwMzoo24idlCVTB
         Ia4A==
X-Gm-Message-State: AOAM531/snUz1Rl0vjMFiflj7SPHbXBAzLpYu/Cku9Unrilx3Q0sO70I
        TDQQUvC0GXeZmJVddBEUx8AniEVrZ7RiGQ==
X-Google-Smtp-Source: ABdhPJzNvLq4dnpIb/IitEuTF190SZ8mGKhmq2y3Q2fFgU+v3FLUD6cmkmTDqaUoiaWAPRPHOvdFeg==
X-Received: by 2002:a05:600c:2197:: with SMTP id e23mr25600981wme.101.1626021050821;
        Sun, 11 Jul 2021 09:30:50 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w3sm678091wrt.55.2021.07.11.09.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 09:30:50 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6? 06/17] refs: make errno output explicit for refs_resolve_ref_unsafe
Date:   Sun, 11 Jul 2021 18:30:30 +0200
Message-Id: <patch-06.17-96689e523f1-20210711T162803Z-avarab@gmail.com>
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
 refs/files-backend.c | 14 ++++++++------
 3 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index af01a692cb9..1dacb5fe27b 100644
--- a/refs.c
+++ b/refs.c
@@ -1687,7 +1687,7 @@ int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
 					   type, failure_errno);
 }
 
-static const char *refs_resolve_ref_unsafe_with_errno(struct ref_store *refs,
+const char *refs_resolve_ref_unsafe_with_errno(struct ref_store *refs,
 					       const char *refname,
 					       int resolve_flags,
 					       struct object_id *oid,
diff --git a/refs.h b/refs.h
index 48970dfc7e0..344a3c51a8c 100644
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
index 702e38a2b06..d6ee7c1172f 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -935,6 +935,7 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 	int mustexist = (old_oid && !is_null_oid(old_oid));
 	int resolve_flags = RESOLVE_REF_NO_RECURSE;
 	int resolved;
+	int resolve_errno = 0;
 
 	files_assert_main_repository(refs, "lock_ref_oid_basic");
 	assert(err);
@@ -947,10 +948,11 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
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
@@ -970,14 +972,14 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 						     &lock->old_oid, type);
 	}
 	if (!resolved &&
-	    (errno != ENOTDIR ||
+	    (resolve_errno != ENOTDIR ||
 	     /* in case of D/F conflict, try to generate a better error
 	      * message. If that fails, fall back to strerror(ENOTDIR).
 	      */
 	     !refs_verify_refname_available(&refs->base, refname, extras,
 					    skip, err))) {
 		strbuf_addf(err, "unable to resolve reference '%s': %s",
-			    refname, strerror(errno));
+			    refname, strerror(resolve_errno));
 		goto error_return;
 	}
 
-- 
2.32.0-dev

