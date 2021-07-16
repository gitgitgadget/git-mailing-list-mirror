Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4154C636CB
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 14:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8CF9613F7
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 14:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240413AbhGPOZ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 10:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233122AbhGPOZk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 10:25:40 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3CDC061762
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 07:22:43 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id k4so12285994wrc.8
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 07:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9+mmuclnhrs765KxbdUjbayDT+Vmr9AVPFH4hv+TLbk=;
        b=Up8DOqhImzomR8/5ObWpqgf+0xOUNX982V9buhK87WiUq/eQ9bRPhtRK6kCvvN9zqi
         QdCxORMnPAF45yz4mcRMwbMcgjm67CEAeLoQkK5iu6KboGqCmzhD725oYDS1Zop2KdeF
         /I+90FZxnZF66tJuEUcnXT4M8PPmJ1HqSQWyhEqx41mKEv2N7Y5HTiSi6cSbjzr0WIPz
         KCAsD6TDYE8sTXOk608sqZOPQHRmcOIlSlL8BRe4lrckDS6lLxoBnoCxIdv1hBmliLBH
         W1s8Ja2rbOgIM/NT/Yvxs4aDnoXLGwpFj896BWIwlCa/HAAzUHjm4n764uIhAokzveHi
         aZrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9+mmuclnhrs765KxbdUjbayDT+Vmr9AVPFH4hv+TLbk=;
        b=WtVJn5UflydJJBvPnPu7FaCdqHVnPTKSYxudeLVuL/P+B3kSaLvWOa4pZ9+VNX4mpS
         KQVdMMjgBcN8LbGEyv6/uQWuINZANAw+310iCsq+EL+8br4/8IwLy2PmKzsAebaxQoVQ
         GyBOLPwdvpKJlA/xyDzSCrEtxssgL6GXkKvvalTzBwiMZyYKQr3IIySThhM+EWzXkMzS
         ktbHlOCvoh+mbcW7geGbkaOoB+n+sqJI6PIRmr2tq6t2Q2sgW3H4jLm/A0ldclZtAiqw
         PGyU8x4ZSoUJ6fNoL+Xjc8L+gIt8Caxqwfxt5tupcVa/eSoxy6KZeCqkqD48bJyaZObC
         yqEQ==
X-Gm-Message-State: AOAM531FPBaivgmTTOBiDHRMcfcRTOorvxJ2fHOq9WnyPXjNNNXudw9D
        SpBWJn1oNsNDTvn1N9L2DRQE1AzPlAxejQ==
X-Google-Smtp-Source: ABdhPJz5lqRFyEPHi7jSqDhPiqDWxljrG7ru7UBLaLKpbrRcFjdd2PQr+QYfSo30zaJkJGXrSuRm7g==
X-Received: by 2002:adf:ffcf:: with SMTP id x15mr12943237wrs.76.1626445361709;
        Fri, 16 Jul 2021 07:22:41 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z7sm7463236wmp.34.2021.07.16.07.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 07:22:41 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v8 7/7] refs: make errno output explicit for refs_resolve_ref_unsafe
Date:   Fri, 16 Jul 2021 16:22:32 +0200
Message-Id: <patch-7.7-cb32b5c0526-20210716T142032Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.874.gfa1990a4f10
In-Reply-To: <cover-0.7-00000000000-20210716T142032Z-avarab@gmail.com>
References: <cover-0.6-0000000000-20210714T114301Z-avarab@gmail.com> <cover-0.7-00000000000-20210716T142032Z-avarab@gmail.com>
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
 refs/files-backend.c | 12 +++++++-----
 3 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index ceaaccc1680..9e2592ee28a 100644
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
index 45d7c346dea..be5f386f64d 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1001,6 +1001,7 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 {
 	struct strbuf ref_file = STRBUF_INIT;
 	struct ref_lock *lock;
+	int resolve_errno = 0;
 
 	files_assert_main_repository(refs, "lock_ref_oid_basic");
 	assert(err);
@@ -1008,17 +1009,18 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 	CALLOC_ARRAY(lock, 1);
 
 	files_ref_path(refs, &ref_file, refname);
-	if (!refs_resolve_ref_unsafe(&refs->base, refname,
-				     RESOLVE_REF_NO_RECURSE,
-				     &lock->old_oid, type) &&
-	    (errno != ENOTDIR ||
+	if (!refs_resolve_ref_unsafe_with_errno(&refs->base, refname,
+						RESOLVE_REF_NO_RECURSE,
+						&lock->old_oid, type,
+						&resolve_errno) &&
+	    (resolve_errno != ENOTDIR ||
 	     /* in case of D/F conflict, try to generate a better error
 	      * message. If that fails, fall back to strerror(ENOTDIR).
 	      */
 	     !refs_verify_refname_available(&refs->base, refname, NULL,
 					    NULL, err))) {
 		strbuf_addf(err, "unable to resolve reference '%s': %s",
-			    refname, strerror(errno));
+			    refname, strerror(resolve_errno));
 		goto error_return;
 	}
 
-- 
2.32.0.874.gfa1990a4f10

