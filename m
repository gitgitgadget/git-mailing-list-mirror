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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01631C43461
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 15:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C12C8611AE
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 15:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242861AbhDWPca (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 11:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbhDWPc2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 11:32:28 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E62C06174A
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 08:31:51 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id r7so36806655wrm.1
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 08:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=F4HOaeHIO7KS1k6ttHWwH5r5xh4Z26cSAfantBfReEo=;
        b=YfbfU0I5I+ZnQf8s3+gSHKplQPL2SbRZOmLn6cP9zH6hbfPPMlCSOrLwuobLr5qcGt
         pG3cVo2qAFMqpaLibkvB/ek4fvIUSQvRvmdt/dzAe3Ysw7hZwTd8ayoZ1kQiW5r+1lDR
         fIkA2PDbUMe107I4z+UjBiaYLCuxHmyUuC2WJ2GFjXqfH9q+kLuEmGcPPBLFZ9P7hiMT
         TaYVIvlpu6iUAEISqawiec++Kl4gdqHPiNjgEyzpxNkWe9bHpccBczAWcIPPBVtRPL98
         clOqixD9O0avznAFdnXahh8Lm47MCRsAisMaVQZCaKCTHxB0zyut4b2LH/z1llVgFDLs
         p4Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=F4HOaeHIO7KS1k6ttHWwH5r5xh4Z26cSAfantBfReEo=;
        b=RvGB2TUPzYOVazmNqAcGLro7LGOjdr2BPCD5PFPUqTTv8GFAwl+1O11eDoTHyM0i1B
         IkON+UJsGhFZLGImZCPTm/pA9q3wUtqXk1jMIxGHc2OhduhwZOyJtxqjiqGY224WQdCG
         KG9kRXFJ0cz9vSZ6N0ewzPwlIGtK7r5KXMuNEgeFmkSlSCDng3NUWZg2JBm92O8KQrDc
         fl0p5YNrltwYjWBIYDMud13mZxB0+P1d9LvmFdJ4EHKKeJQzQHXb8+SILRzscWBf8+H5
         YHRy2xzdXgjKcDNudg/s/9JsXsGpT6VMQ1wixrlKxlV6Pk+uXXdwSrh1MvRGh2I3/9PD
         kszA==
X-Gm-Message-State: AOAM530fhy0FNG0TA71CBgXOTn1+ekemTvNVMp/JbVBO+JKbLpE4esj9
        GG4MlYd7WKfGxl9NcjOtcsG3x792vtc=
X-Google-Smtp-Source: ABdhPJwxce8cL5JjCaHAmhYCxyw2xj0txGmMU21ccodkDh1FcQ4aAbTksB4QqKjj8/Bn73DkfL+mTg==
X-Received: by 2002:a5d:6d0a:: with SMTP id e10mr5561648wrq.161.1619191910397;
        Fri, 23 Apr 2021 08:31:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u4sm12608293wml.0.2021.04.23.08.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 08:31:50 -0700 (PDT)
Message-Id: <7fbc1c754f435c6d621734685ebee1bdc539c000.1619191907.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1011.v2.git.git.1619191907.gitgitgadget@gmail.com>
References: <pull.1011.git.git.1619173446857.gitgitgadget@gmail.com>
        <pull.1011.v2.git.git.1619191907.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 23 Apr 2021 15:31:47 +0000
Subject: [PATCH v2 3/3] refs: make errno output explicit for read_raw_ref_fn
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

read_raw_ref_fn needs to supply a credible errno for a number of cases. These
are primarily:

1) The files backend calls read_raw_ref from lock_raw_ref, and uses the
resulting error codes to create/remove directories as needed.

2) ENOENT should be translated in a zero OID, optionally with REF_ISBROKEN set,
returning the last successfully resolved symref. This is necessary so
read_raw_ref("HEAD") on an empty repo returns refs/heads/main (or the default branch
du-jour), and we know on which branch to create the first commit.

Make this information flow explicit by adding a failure_errno to the signature
of read_raw_ref. All errnos from the files backend are still propagated
unchanged, even though inspection suggests only ENOTDIR, EISDIR and ENOENT are
relevant.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs.c                |  7 +++++--
 refs/debug.c          |  4 ++--
 refs/files-backend.c  | 17 ++++++++---------
 refs/packed-backend.c |  5 +++--
 refs/refs-internal.h  |  9 ++++++---
 5 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/refs.c b/refs.c
index 261fd82beb98..43e2ad6b612a 100644
--- a/refs.c
+++ b/refs.c
@@ -1675,13 +1675,16 @@ int refs_read_raw_ref(struct ref_store *ref_store,
 		      const char *refname, struct object_id *oid,
 		      struct strbuf *referent, unsigned int *type)
 {
+	int result, failure;
 	if (!strcmp(refname, "FETCH_HEAD") || !strcmp(refname, "MERGE_HEAD")) {
 		return refs_read_special_head(ref_store, refname, oid, referent,
 					      type);
 	}
 
-	return ref_store->be->read_raw_ref(ref_store, refname, oid, referent,
-					   type);
+	result = ref_store->be->read_raw_ref(ref_store, refname, oid, referent,
+					     type, &failure);
+	errno = failure;
+	return result;
 }
 
 /* This function needs to return a meaningful errno on failure */
diff --git a/refs/debug.c b/refs/debug.c
index 922e64fa6ad9..887dbb14be6e 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -238,14 +238,14 @@ debug_ref_iterator_begin(struct ref_store *ref_store, const char *prefix,
 
 static int debug_read_raw_ref(struct ref_store *ref_store, const char *refname,
 			      struct object_id *oid, struct strbuf *referent,
-			      unsigned int *type)
+			      unsigned int *type, int *failure_errno)
 {
 	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
 	int res = 0;
 
 	oidcpy(oid, &null_oid);
 	res = drefs->refs->be->read_raw_ref(drefs->refs, refname, oid, referent,
-					    type);
+					    type, failure_errno);
 
 	if (res == 0) {
 		trace_printf_key(&trace_refs, "read_raw_ref: %s: %s (=> %s) type %x: %d\n",
diff --git a/refs/files-backend.c b/refs/files-backend.c
index c9511da1d387..3ba3a96e1c6b 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -343,7 +343,7 @@ static struct ref_cache *get_loose_ref_cache(struct files_ref_store *refs)
 
 static int files_read_raw_ref(struct ref_store *ref_store,
 			      const char *refname, struct object_id *oid,
-			      struct strbuf *referent, unsigned int *type)
+			      struct strbuf *referent, unsigned int *type, int *failure_errno)
 {
 	struct files_ref_store *refs =
 		files_downcast(ref_store, REF_STORE_READ, "read_raw_ref");
@@ -354,7 +354,6 @@ static int files_read_raw_ref(struct ref_store *ref_store,
 	struct stat st;
 	int fd;
 	int ret = -1;
-	int save_errno;
 	int remaining_retries = 3;
 
 	*type = 0;
@@ -459,10 +458,9 @@ static int files_read_raw_ref(struct ref_store *ref_store,
 	ret = parse_loose_ref_contents(buf, oid, referent, type);
 
 out:
-	save_errno = errno;
+	*failure_errno = errno;
 	strbuf_release(&sb_path);
 	strbuf_release(&sb_contents);
-	errno = save_errno;
 	return ret;
 }
 
@@ -541,6 +539,7 @@ static int lock_raw_ref(struct files_ref_store *refs,
 	struct strbuf ref_file = STRBUF_INIT;
 	int attempts_remaining = 3;
 	int ret = TRANSACTION_GENERIC_ERROR;
+	int failure_errno = 0;
 
 	assert(err);
 	files_assert_main_repository(refs, "lock_raw_ref");
@@ -630,8 +629,8 @@ static int lock_raw_ref(struct files_ref_store *refs,
 	 */
 
 	if (files_read_raw_ref(&refs->base, refname,
-			       &lock->old_oid, referent, type)) {
-		if (errno == ENOENT) {
+			       &lock->old_oid, referent, type, &failure_errno)) {
+		if (failure_errno == ENOENT) {
 			if (mustexist) {
 				/* Garden variety missing reference. */
 				strbuf_addf(err, "unable to resolve reference '%s'",
@@ -655,7 +654,7 @@ static int lock_raw_ref(struct files_ref_store *refs,
 				 *   reference named "refs/foo/bar/baz".
 				 */
 			}
-		} else if (errno == EISDIR) {
+		} else if (failure_errno == EISDIR) {
 			/*
 			 * There is a directory in the way. It might have
 			 * contained references that have been deleted. If
@@ -693,13 +692,13 @@ static int lock_raw_ref(struct files_ref_store *refs,
 					goto error_return;
 				}
 			}
-		} else if (errno == EINVAL && (*type & REF_ISBROKEN)) {
+		} else if (failure_errno == EINVAL && (*type & REF_ISBROKEN)) {
 			strbuf_addf(err, "unable to resolve reference '%s': "
 				    "reference broken", refname);
 			goto error_return;
 		} else {
 			strbuf_addf(err, "unable to resolve reference '%s': %s",
-				    refname, strerror(errno));
+				    refname, strerror(failure_errno));
 			goto error_return;
 		}
 
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index dfecdbc1db60..9a09ad7f5f29 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -726,7 +726,8 @@ static struct snapshot *get_snapshot(struct packed_ref_store *refs)
 
 static int packed_read_raw_ref(struct ref_store *ref_store,
 			       const char *refname, struct object_id *oid,
-			       struct strbuf *referent, unsigned int *type)
+			       struct strbuf *referent, unsigned int *type,
+			       int *failure_errno)
 {
 	struct packed_ref_store *refs =
 		packed_downcast(ref_store, REF_STORE_READ, "read_raw_ref");
@@ -739,7 +740,7 @@ static int packed_read_raw_ref(struct ref_store *ref_store,
 
 	if (!rec) {
 		/* refname is not a packed reference. */
-		errno = ENOENT;
+		*failure_errno = ENOENT;
 		return -1;
 	}
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 29728a339fed..15cc0ddd68ab 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -617,9 +617,11 @@ typedef int reflog_expire_fn(struct ref_store *ref_store,
  * properly-formatted or even safe reference name. NEITHER INPUT NOR
  * OUTPUT REFERENCE NAMES ARE VALIDATED WITHIN THIS FUNCTION.
  *
- * Return 0 on success. If the ref doesn't exist, set errno to ENOENT and return
+ * Return 0 on success. If the ref doesn't exist, set failure_errno to ENOENT and return
  * -1. If the ref exists but is neither a symbolic ref nor an object ID, it is
- * broken; set REF_ISBROKEN in type, and return -1. If there is another error
+ * broken; set REF_ISBROKEN in type, and return -1. For the files backend, EISDIR and ENOTDIR
+ * may be set if the ref name is a directory
+ * If there is another error
  * reading the ref, set errno appropriately and return -1.
  *
  * Backend-specific flags might be set in type as well, regardless of
@@ -636,7 +638,8 @@ typedef int reflog_expire_fn(struct ref_store *ref_store,
  */
 typedef int read_raw_ref_fn(struct ref_store *ref_store,
 			    const char *refname, struct object_id *oid,
-			    struct strbuf *referent, unsigned int *type);
+			    struct strbuf *referent, unsigned int *type,
+			    int *failure_errno);
 
 struct ref_storage_be {
 	struct ref_storage_be *next;
-- 
gitgitgadget
