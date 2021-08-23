Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDEEC4320A
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 11:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D09261357
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 11:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236819AbhHWLxy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 07:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236760AbhHWLxp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 07:53:45 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0EFC0617AD
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 04:53:00 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id k29so25862375wrd.7
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 04:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ucrSFt1OnM/isq91yj9IogbAvkgZRJQrJyiE2R+YP40=;
        b=sFCaXIsjUOTtT0xJWK8OUIgsIjgRjtWC2bKe8vWRnKWK5CgPbAjHdy/XTgjvYfrCeY
         pISaSmjPXNT21Bf9hSu9Qg/qQpVmJHbYa9kOlEYauV80KfQyqyX+F4t2GlyavdUhfefw
         0m/z15GwR408M7pV3xwNeDlDcOwoEeAg30AuyomlLICfBzMGynGoya9UsElM6Q4orAP5
         Xj3S2cgUiVtb+CRKxCtW7bJ4g+T4oZoGrKuEvdMgcAQv6UDxbom7zFuf8svdmKWI2YAP
         Pnm3S09KAX7cuxt98xfePjdqe4EvvgyRvoahZmCRGE3ARnYGCNGCNOTN3Lwqw7dHzVoy
         egmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ucrSFt1OnM/isq91yj9IogbAvkgZRJQrJyiE2R+YP40=;
        b=LRP9ik/XqYM7ux5WLEpQNebtn2oPdIAQ8cxWVCykcVh/7eEv/BxWFJ0tSkbA3IM2Gh
         kvBweJ8oFvHmjId7PnDvFO+OEw2QCP8U948PWyyK7y/xfddMrHQPpQMTrVEoLEi9d24l
         +ZcfojP5pRwN3V0+T+4qXBhIHcilJ59bbnUFJc2ESbXFV4S0g+NeOuYkwbia1ISDmxA3
         UvhaBzohodY1N6oSrp7iSqqx04V6AbS9HKqVsmdWnZK5ZS/lu2ZBvC9/6CZZ8JgTMxCG
         H7GbhITs4GvfKkGpyO0dQRn/REsXRezQR4226+Ykzq57AcWCP+NDTnSb26amgfgPyT0D
         MUbA==
X-Gm-Message-State: AOAM533fmlc5Z9Kpf34f1E5VyquoZ0HSIUefQV00WXxQ5+2YUBTsmjAi
        nYU+bFLthVUdrhWXloAbQIX3xL+qtSniqUWJ
X-Google-Smtp-Source: ABdhPJzMFVUCYdxGnZ/yAYS0r3vYb49TNjgmzqTNI9DKHuFzJMsXhCROMIZY885agLl7pBdTGdAknw==
X-Received: by 2002:a5d:65cd:: with SMTP id e13mr13105383wrw.368.1629719578602;
        Mon, 23 Aug 2021 04:52:58 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l2sm12350713wmi.1.2021.08.23.04.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 04:52:58 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v10 8/8] refs: make errno output explicit for refs_resolve_ref_unsafe
Date:   Mon, 23 Aug 2021 13:52:44 +0200
Message-Id: <patch-v10-8.8-7d94a32af83-20210823T114712Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.662.g438caf9576d
In-Reply-To: <cover-v10-0.8-00000000000-20210823T114712Z-avarab@gmail.com>
References: <cover-0.7-00000000000-20210720T102644Z-avarab@gmail.com> <cover-v10-0.8-00000000000-20210823T114712Z-avarab@gmail.com>
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
index b83fd8c36b3..e3b6d8f8dc0 100644
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
index fda8aef1547..a5685c891a9 100644
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
index 41efe5352b5..a14bb6eb96e 100644
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
2.33.0.662.g438caf9576d

