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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6F9C07E95
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 19:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95E1361CBE
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 19:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbhGGTKj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jul 2021 15:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbhGGTKg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jul 2021 15:10:36 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A590C061762
        for <git@vger.kernel.org>; Wed,  7 Jul 2021 12:07:55 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso5063386wmh.4
        for <git@vger.kernel.org>; Wed, 07 Jul 2021 12:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=GCfG8rTvAfcyfyyeaBKL658tAZ6pdhfGo5h/dqS0vGc=;
        b=CFw2/+YIrJCcaMy9tegAgAUX9I/MxijgRsV23Yii0xeSilUDSaH9xnajUDFmWzyanc
         hyu0LFfDFwMj5Rq9RAJ8rLT5dSVtEQ81T+mZ6WIwEeVlSxGNWkNEgcEBoy0kZda2qcKb
         4F7myf1vJDCl2VkTN/eyeqrSaoor7eO19/Na6cVQ7M6uCEIFYpIoutg8S9NabInpGLhY
         Wlk9K6GeDSZLC3x1xXaAar89PK4fX23SydtU5hLrDonejEKdLncfhFcvAE4sS8Eo9LJp
         FFfLm2l7+lTwvNhedJ3s3jkMxHW1NLthzD3oaZQgh2kTgydxbDTWDnEjESQPDtyqy2U/
         VB+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=GCfG8rTvAfcyfyyeaBKL658tAZ6pdhfGo5h/dqS0vGc=;
        b=GBlxVNxl/zgewYdE6/KTOIo6N2sM0WCcxVDCkUD6LgyGtoBXRx/apxzsUvMkOcbDTX
         8K7/8JGnGME1r4qN3/+4wJvcSspkcSucEq++rtwevRIH7U7/YOBUNRJBsrNbNAYdmI8T
         z5fo8sKiUax+iK11hZFBe1Ekn4hfkIV5CPVWJiQmBJocb8YaYN7gYyqZxc+QBpbW/xrv
         ENHhBlcvWPtoYKIQPYlmWY5rVN+V38rn/jtghCilzUGb9QUDTmwQQBNd2XwLOYmcFVcX
         My95SJVR2oLVbRT29XV1AocW6EBkX4w44Lj+7RlA6nCWSNbxT9smV7GifKaplQuZIL3v
         aKHA==
X-Gm-Message-State: AOAM533eaSsJNS7AsjhX3r1qLSNZED7T1QFPQgeBcw6cN4lvAFl1Ylok
        W11TJiHMw69zOa5C7dzIFvJE2G+SZRM=
X-Google-Smtp-Source: ABdhPJxiAvuqoo5eKeBAoR9ULgr9fHbMz2kSX2i9jSSbmz7HoBTp/Q98P13YSv2ETTujA6ka5Zqiqg==
X-Received: by 2002:a05:600c:4152:: with SMTP id h18mr65056wmm.94.1625684873736;
        Wed, 07 Jul 2021 12:07:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k5sm21733558wmk.11.2021.07.07.12.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 12:07:53 -0700 (PDT)
Message-Id: <ef91f5cee13b1153f597f31451460bba543a63c3.1625684869.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1012.v5.git.git.1625684869.gitgitgadget@gmail.com>
References: <pull.1012.v4.git.git.1625597757.gitgitgadget@gmail.com>
        <pull.1012.v5.git.git.1625684869.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 07 Jul 2021 19:07:47 +0000
Subject: [PATCH v5 4/6] refs: add failure_errno to refs_read_raw_ref()
 signature
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

This lets us use the explicit errno output parameter in refs_resolve_ref_unsafe.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs.c                | 60 ++++++++++++++++++++++++++-----------------
 refs/files-backend.c  |  8 +++---
 refs/packed-backend.c |  7 ++---
 refs/refs-internal.h  |  6 ++---
 4 files changed, 48 insertions(+), 33 deletions(-)

diff --git a/refs.c b/refs.c
index 5e5e3af8da0..de3826f60c9 100644
--- a/refs.c
+++ b/refs.c
@@ -1671,34 +1671,33 @@ done:
 	return result;
 }
 
-int refs_read_raw_ref(struct ref_store *ref_store,
-		      const char *refname, struct object_id *oid,
-		      struct strbuf *referent, unsigned int *type)
-{
-	int result;
-	int failure_errno;
+int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
+		      struct object_id *oid, struct strbuf *referent,
+		      unsigned int *type, int *failure_errno)
+{
+	int unused_errno;
+	if (!failure_errno)
+		failure_errno = &unused_errno;
+	*failure_errno = 0;
 	if (!strcmp(refname, "FETCH_HEAD") || !strcmp(refname, "MERGE_HEAD")) {
 		return refs_read_special_head(ref_store, refname, oid, referent,
 					      type);
 	}
 
-	failure_errno = 0;
-	result = ref_store->be->read_raw_ref(ref_store, refname, oid, referent,
-					     type, &failure_errno);
-	if (failure_errno)
-		errno = failure_errno;
-	return result;
+	return ref_store->be->read_raw_ref(ref_store, refname, oid, referent,
+					   type, failure_errno);
 }
 
-/* This function needs to return a meaningful errno on failure */
-const char *refs_resolve_ref_unsafe(struct ref_store *refs,
-				    const char *refname,
-				    int resolve_flags,
-				    struct object_id *oid, int *flags)
+const char *refs_resolve_ref_unsafe_with_errno(struct ref_store *refs,
+					       const char *refname,
+					       int resolve_flags,
+					       struct object_id *oid,
+					       int *flags, int *failure_errno)
 {
 	static struct strbuf sb_refname = STRBUF_INIT;
 	struct object_id unused_oid;
 	int unused_flags;
+	int unused_errno;
 	int symref_count;
 
 	if (!oid)
@@ -1707,6 +1706,9 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 		flags = &unused_flags;
 
 	*flags = 0;
+	if (!failure_errno)
+		failure_errno = &unused_errno;
+	*failure_errno = 0;
 
 	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
 		if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
@@ -1728,11 +1730,14 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 
 	for (symref_count = 0; symref_count < SYMREF_MAXDEPTH; symref_count++) {
 		unsigned int read_flags = 0;
+		int read_failure = 0;
 
-		if (refs_read_raw_ref(refs, refname,
-				      oid, &sb_refname, &read_flags)) {
+		if (refs_read_raw_ref(refs, refname, oid, &sb_refname,
+				      &read_flags, &read_failure)) {
 			*flags |= read_flags;
 
+			*failure_errno = read_failure;
+
 			/* In reading mode, refs must eventually resolve */
 			if (resolve_flags & RESOLVE_REF_READING)
 				return NULL;
@@ -1742,9 +1747,8 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 			 * may show errors besides ENOENT if there are
 			 * similarly-named refs.
 			 */
-			if (errno != ENOENT &&
-			    errno != EISDIR &&
-			    errno != ENOTDIR)
+			if (read_failure != ENOENT && read_failure != EISDIR &&
+			    read_failure != ENOTDIR)
 				return NULL;
 
 			oidclr(oid);
@@ -1783,6 +1787,15 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 	return NULL;
 }
 
+const char *refs_resolve_ref_unsafe(struct ref_store *refs, const char *refname,
+				    int resolve_flags, struct object_id *oid,
+				    int *flags)
+{
+	int ignore = 0;
+	return refs_resolve_ref_unsafe_with_errno(refs, refname, resolve_flags,
+						  oid, flags, &ignore);
+}
+
 /* backend functions */
 int refs_init_db(struct strbuf *err)
 {
@@ -2244,7 +2257,8 @@ int refs_verify_refname_available(struct ref_store *refs,
 		if (skip && string_list_has_string(skip, dirname.buf))
 			continue;
 
-		if (!refs_read_raw_ref(refs, dirname.buf, &oid, &referent, &type)) {
+		if (!refs_read_raw_ref(refs, dirname.buf, &oid, &referent,
+				       &type, NULL)) {
 			strbuf_addf(err, _("'%s' exists; cannot create '%s'"),
 				    dirname.buf, refname);
 			goto cleanup;
diff --git a/refs/files-backend.c b/refs/files-backend.c
index f98b1be9386..f38c9703504 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -383,8 +383,8 @@ stat_ref:
 	if (lstat(path, &st) < 0) {
 		if (errno != ENOENT)
 			goto out;
-		if (refs_read_raw_ref(refs->packed_ref_store, refname,
-				      oid, referent, type)) {
+		if (refs_read_raw_ref(refs->packed_ref_store, refname, oid,
+				      referent, type, NULL)) {
 			errno = ENOENT;
 			goto out;
 		}
@@ -423,8 +423,8 @@ stat_ref:
 		 * ref is supposed to be, there could still be a
 		 * packed ref:
 		 */
-		if (refs_read_raw_ref(refs->packed_ref_store, refname,
-				      oid, referent, type)) {
+		if (refs_read_raw_ref(refs->packed_ref_store, refname, oid,
+				      referent, type, NULL)) {
 			errno = EISDIR;
 			goto out;
 		}
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index a457f18e93c..530dba29788 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1347,6 +1347,7 @@ int is_packed_transaction_needed(struct ref_store *ref_store,
 	ret = 0;
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = transaction->updates[i];
+		int failure_errno = 0;
 		unsigned int type;
 		struct object_id oid;
 
@@ -1357,9 +1358,9 @@ int is_packed_transaction_needed(struct ref_store *ref_store,
 			 */
 			continue;
 
-		if (!refs_read_raw_ref(ref_store, update->refname,
-				       &oid, &referent, &type) ||
-		    errno != ENOENT) {
+		if (!refs_read_raw_ref(ref_store, update->refname, &oid,
+				       &referent, &type, &failure_errno) ||
+		    failure_errno != ENOENT) {
 			/*
 			 * We have to actually delete that reference
 			 * -> this transaction is needed.
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 79dfb3af484..54f57c6a2df 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -149,9 +149,9 @@ struct ref_update {
 	const char refname[FLEX_ARRAY];
 };
 
-int refs_read_raw_ref(struct ref_store *ref_store,
-		      const char *refname, struct object_id *oid,
-		      struct strbuf *referent, unsigned int *type);
+int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
+		      struct object_id *oid, struct strbuf *referent,
+		      unsigned int *type, int *failure_errno);
 
 /*
  * Write an error to `err` and return a nonzero value iff the same
-- 
gitgitgadget

