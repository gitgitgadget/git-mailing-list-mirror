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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36FAC07E99
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 20:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95D7B6197E
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 20:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhGEU7C (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 16:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbhGEU6s (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 16:58:48 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26790C061764
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 13:56:11 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id i2-20020a05600c3542b02902058529ea07so760487wmq.3
        for <git@vger.kernel.org>; Mon, 05 Jul 2021 13:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=7MAs9/ImzaSDp7H40v6Di3Mr2CST7fBQYzeJTwbpFg4=;
        b=AKQJBM0Kxn8FmSBPp0Z2G00qGHika31ACaQHuOoTTS4ZSdG5YFkxYg16Fakcx01pCm
         6xY7v2Yg3CWhQtv2ZE59583milTXWydWxaoofjjtICMgJt/O1V0L8VwmnwLBLwhPH/T4
         s9GLVFH/RY7wQAR1eFekPf3pMX49FbEY5C8ODcjF06AipmkgZXj3xk2SFWgn5xpg40oq
         4G+IIOobI1N2tgiRzlWWU6b88S4/ZXe+nmPRnzbVM5bf9nyHy0s0vQIcSwmAMJYLPBxE
         gqFsKB++MwNK0FwO9jPO3MUA0N3z7wdmqeV3ZncWSg0d/lnad0pEnYfqVZG7n5amlaRG
         AYpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=7MAs9/ImzaSDp7H40v6Di3Mr2CST7fBQYzeJTwbpFg4=;
        b=pB5ULjKnon5pvfjz8IDQ3Nqv5pX6VbgN90Lda61/7xL/E/IT/LIaHyfJIqbck/upyT
         eb7ESObMuAEcERSDXy7wRBDh7zVp1nIKjqoBvBQ1xj6c+i9nf4AjRs/sZ8Or20yGzl4Z
         6KV8b1F23tM3tsVlEqJ8z9hDCWzDOfzivDaX6QXVVzoWNBH+DeSprDUP5xiSY+H3I1jT
         xkTSIUt8fkEQqdh+3AJDt+nFsrF4yFWJ2L7ww4sxQUzIVMLcJXha5dZIjs7ij7Zank8e
         ZbG+rA6WRCva5bnIKsPToEubfumyPYf4Cdyf8UKBNMoHgcFHdPNbX2M5BUKjaoVB2foS
         V4uA==
X-Gm-Message-State: AOAM5329O7flQdQL0hlaMKBMEpOimY3Vdzs8VsMh3BY6Q2tnu+p72xko
        f5dwr3zItrX/HNHxnpKw+SIZtTK+zeU=
X-Google-Smtp-Source: ABdhPJwupsIWMPixWDIMGrOaCAuyanQgDQJE3g1GgeMlBqfqgDSkAwAq+3PTU2J1ubegLXmKTzdGlw==
X-Received: by 2002:a05:600c:4f81:: with SMTP id n1mr953754wmq.16.1625518569817;
        Mon, 05 Jul 2021 13:56:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y13sm14475673wrp.80.2021.07.05.13.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 13:56:09 -0700 (PDT)
Message-Id: <4aaa9d3bd6f01b83932b25a9ba18ec9c1106405a.1625518566.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1012.v3.git.git.1625518566.gitgitgadget@gmail.com>
References: <pull.1012.v2.git.git.1623329868.gitgitgadget@gmail.com>
        <pull.1012.v3.git.git.1625518566.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 05 Jul 2021 20:56:04 +0000
Subject: [PATCH v3 4/5] refs: add failure_errno to refs_read_raw_ref()
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
Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs.c                | 60 +++++++++++++++++++++++++++----------------
 refs/files-backend.c  |  8 +++---
 refs/packed-backend.c |  7 ++---
 refs/refs-internal.h  |  6 ++---
 4 files changed, 49 insertions(+), 32 deletions(-)

diff --git a/refs.c b/refs.c
index 5e5e3af8da0..25d80e544d0 100644
--- a/refs.c
+++ b/refs.c
@@ -1671,34 +1671,35 @@ done:
 	return result;
 }
 
-int refs_read_raw_ref(struct ref_store *ref_store,
-		      const char *refname, struct object_id *oid,
-		      struct strbuf *referent, unsigned int *type)
+int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
+		      struct object_id *oid, struct strbuf *referent,
+		      unsigned int *type, int *failure_errno)
 {
-	int result;
-	int failure_errno;
+	int ignore;
+	if (failure_errno)
+		*failure_errno = 0;
+	else
+		failure_errno = &ignore;
+
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
@@ -1707,6 +1708,9 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 		flags = &unused_flags;
 
 	*flags = 0;
+	if (!failure_errno)
+		failure_errno = &unused_errno;
+	*failure_errno = 0;
 
 	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
 		if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
@@ -1728,11 +1732,14 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 
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
@@ -1742,9 +1749,8 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
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
@@ -1783,6 +1789,15 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
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
@@ -2244,7 +2259,8 @@ int refs_verify_refname_available(struct ref_store *refs,
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

