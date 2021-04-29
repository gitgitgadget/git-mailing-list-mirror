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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E576C43460
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 15:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E516261441
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 15:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240709AbhD2PdD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 11:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234590AbhD2PdC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 11:33:02 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198B2C06138D
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 08:32:14 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id i21-20020a05600c3555b029012eae2af5d4so11622153wmq.4
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 08:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=motWb7AgM+z4fa0xx8tlWVIZx2sxIv6Xxt1snpqK8b0=;
        b=O5Oa6HB00lk1yF+4dgb9r/kH4saEK+iJKt0s9fDnk4WCCHKEw70DUl6st9zLHoDzHb
         vbVjDLRod7KYAzNwKie4198egZ7txWjxJYgXBbUkSYWKbevOID/8sO1TZgPpfRukcJg0
         O+SW8rhIYQMOuhU0EXsmPUsogmcCaJcRwn6f1ZCg48unkryrpmnkc46q3muMRmmcqYBF
         qRrERzpyarKwQtB5ysgjWylAEUsGfEUrvjGwipi5nitdjuLLpaqXLFl9LNkwoAsNw36q
         FA1dKHBdM/ZruMroCd4bqpfGo+7nciksKHU8LMaz8IQKn69iN3gM8fqYPXf1sr6InaOV
         im0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=motWb7AgM+z4fa0xx8tlWVIZx2sxIv6Xxt1snpqK8b0=;
        b=bGbP4RysSG3izNAsDWluZ+Bo2LQzIn+OX8PnYW0sgdAfb66UNbwgpo/cI3M/oQ1hxq
         YH2MTX0bfk+C5h2IVRSHttqfL3XxgwwL3oIk4jXCs8+ly1vWVhv+HaFhQ7RlQKh/059g
         hoNl1WiZc5E0gIPMofpQ7CJhlQKN4MEYqJKy1krFeP1kWFRjvOuDTSc3VS70/xYg+QkU
         IJSncX7Vv3BvHux7YozTul8Qn9zmpddiFz04OtZK4ri290rVfLITPfMhTc7RSrUDC4CA
         PTFsNv+KhAyOahIrZpOqM9+fK1GbSrTO9VUsGMS0Qasew32lTvRckajXtw73SrB1eEm3
         g/6g==
X-Gm-Message-State: AOAM533xylScF0mlihndbNcvls92xoM/glKvin171nXZu4Q4EkfnSJfW
        KY3H3NfEkC92cZcNrQFm9ySvmQhKwUI=
X-Google-Smtp-Source: ABdhPJzGKWqhJ3wmOguIvAEq5WZNx8FveNzvJZpICHg9FCyIF3ZoUtl3PK+CDmFIfCWhTN+PmauErw==
X-Received: by 2002:a7b:c017:: with SMTP id c23mr10902207wmb.175.1619710332909;
        Thu, 29 Apr 2021 08:32:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b8sm5708629wrx.15.2021.04.29.08.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 08:32:12 -0700 (PDT)
Message-Id: <dd3eceade4fcf09a679fdf20dddae247b4e0e879.1619710329.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1012.git.git.1619710329.gitgitgadget@gmail.com>
References: <pull.1012.git.git.1619710329.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 29 Apr 2021 15:32:04 +0000
Subject: [PATCH 4/8] refs: make errno output explicit for
 refs_resolve_ref_unsafe
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This introduces refs_resolve_ref_unsafe_with_errno(), which makes the API
contract for the errno output explicit. The implementation still relies on
the global errno variable to ensure no side effects.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs.c               | 12 ++++++++++++
 refs.h               |  1 +
 refs/files-backend.c | 19 ++++++++++---------
 refs/refs-internal.h |  8 ++++++++
 4 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index 43e2ad6b612a..e8ce88040b3e 100644
--- a/refs.c
+++ b/refs.c
@@ -1780,6 +1780,18 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 	return NULL;
 }
 
+const char *refs_resolve_ref_unsafe_with_errno(struct ref_store *refs,
+					       const char *refname,
+					       int resolve_flags,
+					       struct object_id *oid,
+					       int *flags, int *failure_errno)
+{
+	const char *result = refs_resolve_ref_unsafe(refs, refname,
+						     resolve_flags, oid, flags);
+	*failure_errno = errno;
+	return result;
+}
+
 /* backend functions */
 int refs_init_db(struct strbuf *err)
 {
diff --git a/refs.h b/refs.h
index 48970dfc7e0f..ede405ac3874 100644
--- a/refs.h
+++ b/refs.h
@@ -68,6 +68,7 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 				    int resolve_flags,
 				    struct object_id *oid,
 				    int *flags);
+
 const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 			       struct object_id *oid, int *flags);
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index efe493ca1425..3ab09871db5e 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -924,6 +924,7 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 	int mustexist = (old_oid && !is_null_oid(old_oid));
 	int resolve_flags = RESOLVE_REF_NO_RECURSE;
 	int resolved;
+	int resolve_errno;
 
 	files_assert_main_repository(refs, "lock_ref_oid_basic");
 	assert(err);
@@ -936,10 +937,11 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
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
@@ -959,12 +961,11 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 						     &lock->old_oid, type);
 	}
 	if (!resolved) {
-		int last_errno = errno;
-		if (last_errno != ENOTDIR ||
-		    !refs_verify_refname_available(&refs->base, refname,
-						   extras, skip, err))
+		if (resolve_errno != ENOTDIR ||
+		    !refs_verify_refname_available(&refs->base, refname, extras,
+						   skip, err))
 			strbuf_addf(err, "unable to resolve reference '%s': %s",
-				    refname, strerror(last_errno));
+				    refname, strerror(resolve_errno));
 
 		goto error_return;
 	}
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index ac8a14086724..b9f713b5acd6 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -153,6 +153,14 @@ int refs_read_raw_ref(struct ref_store *ref_store,
 		      const char *refname, struct object_id *oid,
 		      struct strbuf *referent, unsigned int *type);
 
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

