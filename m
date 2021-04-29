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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FE0C433ED
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 15:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60D906141E
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 15:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240704AbhD2PdF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 11:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240633AbhD2PdC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 11:33:02 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB26C06138B
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 08:32:14 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 4-20020a05600c26c4b0290146e1feccd8so461347wmv.1
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 08:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vFNPC/ar/55c7fYck2p9D0HsDvz0YDdC5jhUU2AIqrk=;
        b=WEHGhaDKaDrar2gpEZFwkx/ElSBsgD2C1XBgKFuzkg2+tD2PKzsiL3RiZnuPedfdhG
         VXiV6HS+9qF4VYe0h6oiBRlKB/hJFl0x61p10fqF8hT3HQW3mXov5WateuUckTqy8UGP
         Oz4C2m07UKOTbm3ujgT0CshKU9VEZQYpvaVcNlRXd6L+PNqfPuXAsQIhwkKDBE67nAFx
         C7MYUg1+KAcIu9VuBfpsHqEyNilSY1Wx6E01NuGABIL99LiOWmN6Lyn7WIJSGmkQI6T9
         HH6qx0mCsKOCeG9HVuwfPikIhWP9LBjJ25mbASA3OgL7ePRHHz/L5B6eA51PnAQloqR9
         sohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vFNPC/ar/55c7fYck2p9D0HsDvz0YDdC5jhUU2AIqrk=;
        b=m7zQFd594fXfjyFDWfc5VmRhNFamxZMnQXc1UIVV81bG8DXmUo2OEyFEPLRneaen93
         7UMwjYgh8i+BF6HrsXP1SagC8iHvK9nVAZv6a6ZEDpKrD4GTyYyXVF/JtGarsNOrYCSF
         OIza5/hdRsKhe+h/SCm4dEuWyPI2Zaliat2LmUd4fQ0tSClspxucf5RvUBAG/Y2dWDcE
         GR+2hwgCrk9WhYLJ6sU95U12J6YFQahMQaE9/gaWbORZOY0JjQY9sqnC0Uj/rF4Xrq6g
         bi45R+T4vNe3YLNpGwYGmOxBlPizReXxQoQYx35QyFBxRKPZIOXrkul41vPoMaJ72Vh2
         X1wA==
X-Gm-Message-State: AOAM531rz12/I1d2UpWzX1p1mICuKNoajw7NN4FYwn4Jsrd+5AQYfjvf
        +GeahSB2I8se9K6/+eB/++Fl/IMu+34=
X-Google-Smtp-Source: ABdhPJw7GpkBYKZnUp04QvqIm5SWqYnvXZNBWkrh8Y6/wiwe8bOt2zMDy24/sCInUhB91XcpcMVWmw==
X-Received: by 2002:a7b:c248:: with SMTP id b8mr11445548wmj.150.1619710332238;
        Thu, 29 Apr 2021 08:32:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n8sm10026449wmq.12.2021.04.29.08.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 08:32:11 -0700 (PDT)
Message-Id: <ebd7b8380bf7aed84d23973a4809d1441aa21692.1619710329.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1012.git.git.1619710329.gitgitgadget@gmail.com>
References: <pull.1012.git.git.1619710329.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 29 Apr 2021 15:32:03 +0000
Subject: [PATCH 3/8] refs: make errno output explicit for read_raw_ref_fn
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
 refs/files-backend.c  | 24 ++++++++++++------------
 refs/packed-backend.c |  8 ++++----
 refs/refs-internal.h  | 16 +++++++++-------
 5 files changed, 32 insertions(+), 27 deletions(-)

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
index c9511da1d387..efe493ca1425 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -341,9 +341,9 @@ static struct ref_cache *get_loose_ref_cache(struct files_ref_store *refs)
 	return refs->loose;
 }
 
-static int files_read_raw_ref(struct ref_store *ref_store,
-			      const char *refname, struct object_id *oid,
-			      struct strbuf *referent, unsigned int *type)
+static int files_read_raw_ref(struct ref_store *ref_store, const char *refname,
+			      struct object_id *oid, struct strbuf *referent,
+			      unsigned int *type, int *failure_errno)
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
@@ -459,10 +458,10 @@ static int files_read_raw_ref(struct ref_store *ref_store,
 	ret = parse_loose_ref_contents(buf, oid, referent, type);
 
 out:
-	save_errno = errno;
+	if (failure_errno)
+		*failure_errno = errno;
 	strbuf_release(&sb_path);
 	strbuf_release(&sb_contents);
-	errno = save_errno;
 	return ret;
 }
 
@@ -541,6 +540,7 @@ static int lock_raw_ref(struct files_ref_store *refs,
 	struct strbuf ref_file = STRBUF_INIT;
 	int attempts_remaining = 3;
 	int ret = TRANSACTION_GENERIC_ERROR;
+	int failure_errno = 0;
 
 	assert(err);
 	files_assert_main_repository(refs, "lock_raw_ref");
@@ -629,9 +629,9 @@ static int lock_raw_ref(struct files_ref_store *refs,
 	 * fear that its value will change.
 	 */
 
-	if (files_read_raw_ref(&refs->base, refname,
-			       &lock->old_oid, referent, type)) {
-		if (errno == ENOENT) {
+	if (files_read_raw_ref(&refs->base, refname, &lock->old_oid, referent,
+			       type, &failure_errno)) {
+		if (failure_errno == ENOENT) {
 			if (mustexist) {
 				/* Garden variety missing reference. */
 				strbuf_addf(err, "unable to resolve reference '%s'",
@@ -655,7 +655,7 @@ static int lock_raw_ref(struct files_ref_store *refs,
 				 *   reference named "refs/foo/bar/baz".
 				 */
 			}
-		} else if (errno == EISDIR) {
+		} else if (failure_errno == EISDIR) {
 			/*
 			 * There is a directory in the way. It might have
 			 * contained references that have been deleted. If
@@ -693,13 +693,13 @@ static int lock_raw_ref(struct files_ref_store *refs,
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
index dfecdbc1db60..a457f18e93c8 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -724,9 +724,9 @@ static struct snapshot *get_snapshot(struct packed_ref_store *refs)
 	return refs->snapshot;
 }
 
-static int packed_read_raw_ref(struct ref_store *ref_store,
-			       const char *refname, struct object_id *oid,
-			       struct strbuf *referent, unsigned int *type)
+static int packed_read_raw_ref(struct ref_store *ref_store, const char *refname,
+			       struct object_id *oid, struct strbuf *referent,
+			       unsigned int *type, int *failure_errno)
 {
 	struct packed_ref_store *refs =
 		packed_downcast(ref_store, REF_STORE_READ, "read_raw_ref");
@@ -739,7 +739,7 @@ static int packed_read_raw_ref(struct ref_store *ref_store,
 
 	if (!rec) {
 		/* refname is not a packed reference. */
-		errno = ENOENT;
+		*failure_errno = ENOENT;
 		return -1;
 	}
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 29728a339fed..ac8a14086724 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -617,10 +617,12 @@ typedef int reflog_expire_fn(struct ref_store *ref_store,
  * properly-formatted or even safe reference name. NEITHER INPUT NOR
  * OUTPUT REFERENCE NAMES ARE VALIDATED WITHIN THIS FUNCTION.
  *
- * Return 0 on success. If the ref doesn't exist, set errno to ENOENT and return
- * -1. If the ref exists but is neither a symbolic ref nor an object ID, it is
- * broken; set REF_ISBROKEN in type, and return -1. If there is another error
- * reading the ref, set errno appropriately and return -1.
+ * Return 0 on success. If the ref doesn't exist, set failure_errno to ENOENT
+ * and return -1. If the ref exists but is neither a symbolic ref nor an object
+ * ID, it is broken; set REF_ISBROKEN in type, and return -1. For the files
+ * backend, EISDIR and ENOTDIR may be set if the ref name is a directory. If
+ * there is another error reading the ref, set failure_errno appropriately and
+ * return -1.
  *
  * Backend-specific flags might be set in type as well, regardless of
  * outcome.
@@ -634,9 +636,9 @@ typedef int reflog_expire_fn(struct ref_store *ref_store,
  * - in all other cases, referent will be untouched, and therefore
  *   refname will still be valid and unchanged.
  */
-typedef int read_raw_ref_fn(struct ref_store *ref_store,
-			    const char *refname, struct object_id *oid,
-			    struct strbuf *referent, unsigned int *type);
+typedef int read_raw_ref_fn(struct ref_store *ref_store, const char *refname,
+			    struct object_id *oid, struct strbuf *referent,
+			    unsigned int *type, int *failure_errno);
 
 struct ref_storage_be {
 	struct ref_storage_be *next;
-- 
gitgitgadget

