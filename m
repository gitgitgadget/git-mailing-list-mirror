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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1197FC43461
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 15:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8E2A6141E
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 15:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240732AbhD2PdE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 11:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240635AbhD2PdC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 11:33:02 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEF4C06138C
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 08:32:14 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id n4-20020a05600c4f84b029013151278decso11071229wmq.4
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 08:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=B6vPGYhE7WWblxVkaqP7vVomN4+41Wr1mC37zr4MI5Y=;
        b=TKnMI5QssviebKz9WXpDFxzCDZ1ytlsgxFuIBSu7p9zlnFCfYyXYRURGfsNBl2siUt
         U2HmBXpG9FGD2f3ZBPHRLtlHw2lneJ5xYeHqUcu6U4GDs4KqAiHW//IX7qkCNuZpITie
         bh9g3ZC/SxNS5CH/QtSs9MTPcT5V35Y+VzDiKm3Z6AdLKxqGMks45B5LXMvhahpC5K+t
         Y3wQNfguinv7v39ODhVHsHAY0Oo3Jbucp8dlKlCDvLv8sRqZl79J7hdtc7bxNOwyjRpH
         vNCmJ/AoYDIvb4RdaMnrYh5tufabXLJ4DfFu6fqgXICndH92W060T99tTthq57B7k1zw
         pJyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=B6vPGYhE7WWblxVkaqP7vVomN4+41Wr1mC37zr4MI5Y=;
        b=j+zIEmKPiIgND/FHSKi56oWXnQ3n7EggMsuM3Pv74R6RF++FGLqaeRQmikqMdNNLsN
         D+jKy2MAdNO33KmhLkixdvCjP/c8Hrw6jzfb0PEiQWhiegekWcR7PrzkrdAGoY+RqVp6
         Bx4+oj1W1Cli4Fh21QpjEvCOKXnFYXaMLeCcmhQWUhGfFiiXl7NtoG89p3tbDHiEWLXG
         p+Rm4bM7gOkyJi6eQmEgo8sPok6j0c3eSHURL/u8F17Dmxoc2VgmCriYlsB7EtFhNwKj
         sQEa7+Ou+tKs+xRuBdct9qMG/651zGFe8kqDdJF5gs0IBj4AqlndIs7+f/kX+gHt1vol
         yufQ==
X-Gm-Message-State: AOAM532CL7W1fIagGQU3R+ERdWouCP9iNeX6oM6aHQ3e5oPS8FTpZVsE
        ZJoZakHEL9p2N2kUuuoRrpJ3nvt8FS0=
X-Google-Smtp-Source: ABdhPJyI4L4YEffPfZj82m5h9sV4kWKji+r+3jjqpD73M5T3p+roRIbh64Wc0i0mtoNrPEFc6rgM5g==
X-Received: by 2002:a7b:c05a:: with SMTP id u26mr10847200wmc.172.1619710333449;
        Thu, 29 Apr 2021 08:32:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y5sm5492945wrm.61.2021.04.29.08.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 08:32:13 -0700 (PDT)
Message-Id: <039fc4be4b901781bb5062cf63873a014a444e4c.1619710329.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1012.git.git.1619710329.gitgitgadget@gmail.com>
References: <pull.1012.git.git.1619710329.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 29 Apr 2021 15:32:05 +0000
Subject: [PATCH 5/8] refs: add failure_errno to refs_read_raw_ref() signature
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

This makes the errno output of refs_read_raw_ref explicit.
lock_raw_ref() now explicitly reads the errno output of refs_read_raw_ref.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs.c                | 26 ++++++++++++--------------
 refs/files-backend.c  |  8 ++++----
 refs/packed-backend.c | 10 ++++++----
 refs/refs-internal.h  |  6 +++---
 4 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/refs.c b/refs.c
index e8ce88040b3e..08f69e2a16f6 100644
--- a/refs.c
+++ b/refs.c
@@ -1671,20 +1671,17 @@ static int refs_read_special_head(struct ref_store *ref_store,
 	return result;
 }
 
-int refs_read_raw_ref(struct ref_store *ref_store,
-		      const char *refname, struct object_id *oid,
-		      struct strbuf *referent, unsigned int *type)
+int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
+		      struct object_id *oid, struct strbuf *referent,
+		      unsigned int *type, int *failure_errno)
 {
-	int result, failure;
 	if (!strcmp(refname, "FETCH_HEAD") || !strcmp(refname, "MERGE_HEAD")) {
 		return refs_read_special_head(ref_store, refname, oid, referent,
 					      type);
 	}
 
-	result = ref_store->be->read_raw_ref(ref_store, refname, oid, referent,
-					     type, &failure);
-	errno = failure;
-	return result;
+	return ref_store->be->read_raw_ref(ref_store, refname, oid, referent,
+					   type, failure_errno);
 }
 
 /* This function needs to return a meaningful errno on failure */
@@ -1725,9 +1722,10 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 
 	for (symref_count = 0; symref_count < SYMREF_MAXDEPTH; symref_count++) {
 		unsigned int read_flags = 0;
+		int read_failure = 0;
 
-		if (refs_read_raw_ref(refs, refname,
-				      oid, &sb_refname, &read_flags)) {
+		if (refs_read_raw_ref(refs, refname, oid, &sb_refname,
+				      &read_flags, &read_failure)) {
 			*flags |= read_flags;
 
 			/* In reading mode, refs must eventually resolve */
@@ -1739,9 +1737,8 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
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
@@ -2253,7 +2250,8 @@ int refs_verify_refname_available(struct ref_store *refs,
 		if (skip && string_list_has_string(skip, dirname.buf))
 			continue;
 
-		if (!refs_read_raw_ref(refs, dirname.buf, &oid, &referent, &type)) {
+		if (!refs_read_raw_ref(refs, dirname.buf, &oid, &referent,
+				       &type, NULL)) {
 			strbuf_addf(err, _("'%s' exists; cannot create '%s'"),
 				    dirname.buf, refname);
 			goto cleanup;
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 3ab09871db5e..b6dc1b36c752 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -383,8 +383,8 @@ static int files_read_raw_ref(struct ref_store *ref_store, const char *refname,
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
@@ -423,8 +423,8 @@ static int files_read_raw_ref(struct ref_store *ref_store, const char *refname,
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
index a457f18e93c8..03353ce48869 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -739,7 +739,8 @@ static int packed_read_raw_ref(struct ref_store *ref_store, const char *refname,
 
 	if (!rec) {
 		/* refname is not a packed reference. */
-		*failure_errno = ENOENT;
+		if (failure_errno)
+			*failure_errno = ENOENT;
 		return -1;
 	}
 
@@ -1347,6 +1348,7 @@ int is_packed_transaction_needed(struct ref_store *ref_store,
 	ret = 0;
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = transaction->updates[i];
+		int failure;
 		unsigned int type;
 		struct object_id oid;
 
@@ -1357,9 +1359,9 @@ int is_packed_transaction_needed(struct ref_store *ref_store,
 			 */
 			continue;
 
-		if (!refs_read_raw_ref(ref_store, update->refname,
-				       &oid, &referent, &type) ||
-		    errno != ENOENT) {
+		if (!refs_read_raw_ref(ref_store, update->refname, &oid,
+				       &referent, &type, &failure) ||
+		    failure != ENOENT) {
 			/*
 			 * We have to actually delete that reference
 			 * -> this transaction is needed.
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index b9f713b5acd6..6a0840e22772 100644
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
 
 /* Like refs_resolve_ref_unsafe, but provide access to errno code that lead to a
  * failure. */
-- 
gitgitgadget

