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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF216C07E9B
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 10:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D206161107
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 10:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237389AbhGTJx5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 05:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237714AbhGTJxA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 05:53:00 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B82C061768
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 03:33:38 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id a23-20020a05600c2257b0290236ec98bebaso1742018wmm.1
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 03:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=exCQ0t4cuYVrmo1Jt6usFhqFnku3z4Ti6De+emN/wZk=;
        b=auFlPMlaLjPsfrCGd3wb/uz56sF11nDmWQihRRQC5bIlvzrDz9azE5gfCkuCYCdItb
         PPrEM7MLmIhk2bl84ETwQ+Joban8g17zRHKkmoJ3UVJfGZ+DJivvthV7cDxTMyIUTLu/
         IBB2V+m9xwWRkbZT2H+vMRiYCfoP2XxnekaZWWaEMvgIiHu2MD82lCg+yKojzuEBdsea
         6gaY01x20DJko0JqPsW09ac1SK3EWLNmu4VkfGa4mOXR7tMNhB3wiPr/zNujglNX6wj2
         f5h+U1X3w37gF/6P5eOVJSj4gxMDWJi9DwhKgsbB41oG1RyY1nTy2g90shP2PA6nlhbg
         FG5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=exCQ0t4cuYVrmo1Jt6usFhqFnku3z4Ti6De+emN/wZk=;
        b=DWAtKhKRo5SjEmXoGbAds6aJ/Jefgpf6oUZXKxpVsdGYvkpQ9oQyp6DUyP8PyrPc0Z
         JNLGOqLzc/9IS49lISBlidKGAjvXpOkqUNUghu6CJP4jGg630Vy0lM4YfwvYkjzxILzy
         5kTtMu02r++0ssnSS101o4e0OmlQ3YTvsp27HGJZaRtEw89Rbs3zmznxMLtyB9XirnzA
         yVTWWR6+/jOsu/CHRw6li4gErUbyrjFHh/txLAGdsjJHuWb2t/Ut+WIJqXUng4RmB251
         rXMBGUn3UI8rnCwSeV4iZ3H2SHj/3Y6OidNpG3ULrh1v9GCKmJcRIsNK6JLmyfLAFLEG
         Z4+Q==
X-Gm-Message-State: AOAM53139asxHNgXnVKAIglrH4iCp0Cr19sH2buqxCcDZjpfoJpkNXrG
        GULLlbd2ydLp2TrES7Zt+9tQEdSaYYRRrg==
X-Google-Smtp-Source: ABdhPJyYkirWxrQR71v2t1Hmvs5tIWWnnk8XVplqjY9PmEvksljv3h0Tpowp0HS386l4rcUFSflC5g==
X-Received: by 2002:a1c:494:: with SMTP id 142mr31127756wme.60.1626777216846;
        Tue, 20 Jul 2021 03:33:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l14sm22179852wrs.22.2021.07.20.03.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 03:33:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v9 4/7] refs: make errno output explicit for read_raw_ref_fn
Date:   Tue, 20 Jul 2021 12:33:27 +0200
Message-Id: <patch-4.7-c54fb99714a-20210720T102644Z-avarab@gmail.com>
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

This makes it explicit how alternative ref backends should report errors in
read_raw_ref_fn.

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
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs.c                |  2 +-
 refs/debug.c          |  4 ++--
 refs/files-backend.c  | 29 +++++++++++++++--------------
 refs/packed-backend.c |  8 ++++----
 refs/refs-internal.h  | 20 ++++++++++++--------
 5 files changed, 34 insertions(+), 29 deletions(-)

diff --git a/refs.c b/refs.c
index d9635436759..fc6c0ddffae 100644
--- a/refs.c
+++ b/refs.c
@@ -1682,7 +1682,7 @@ int refs_read_raw_ref(struct ref_store *ref_store,
 	}
 
 	return ref_store->be->read_raw_ref(ref_store, refname, oid, referent,
-					   type);
+					   type, &errno);
 }
 
 /* This function needs to return a meaningful errno on failure */
diff --git a/refs/debug.c b/refs/debug.c
index 18fd9bca595..d0aaea6d918 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -238,7 +238,7 @@ debug_ref_iterator_begin(struct ref_store *ref_store, const char *prefix,
 
 static int debug_read_raw_ref(struct ref_store *ref_store, const char *refname,
 			      struct object_id *oid, struct strbuf *referent,
-			      unsigned int *type)
+			      unsigned int *type, int *failure_errno)
 {
 	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
 	int res = 0;
@@ -246,7 +246,7 @@ static int debug_read_raw_ref(struct ref_store *ref_store, const char *refname,
 	oidcpy(oid, null_oid());
 	errno = 0;
 	res = drefs->refs->be->read_raw_ref(drefs->refs, refname, oid, referent,
-					    type);
+					    type, failure_errno);
 
 	if (res == 0) {
 		trace_printf_key(&trace_refs, "read_raw_ref: %s: %s (=> %s) type %x: %d\n",
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 9e00da76121..85b4d791444 100644
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
 
@@ -540,6 +538,7 @@ static int lock_raw_ref(struct files_ref_store *refs,
 	struct strbuf ref_file = STRBUF_INIT;
 	int attempts_remaining = 3;
 	int ret = TRANSACTION_GENERIC_ERROR;
+	int failure_errno;
 
 	assert(err);
 	files_assert_main_repository(refs, "lock_raw_ref");
@@ -610,7 +609,9 @@ static int lock_raw_ref(struct files_ref_store *refs,
 	if (hold_lock_file_for_update_timeout(
 			    &lock->lk, ref_file.buf, LOCK_NO_DEREF,
 			    get_files_ref_lock_timeout_ms()) < 0) {
-		if (errno == ENOENT && --attempts_remaining > 0) {
+		int myerr = errno;
+		errno = 0;
+		if (myerr == ENOENT && --attempts_remaining > 0) {
 			/*
 			 * Maybe somebody just deleted one of the
 			 * directories leading to ref_file.  Try
@@ -618,7 +619,7 @@ static int lock_raw_ref(struct files_ref_store *refs,
 			 */
 			goto retry;
 		} else {
-			unable_to_lock_message(ref_file.buf, errno, err);
+			unable_to_lock_message(ref_file.buf, myerr, err);
 			goto error_return;
 		}
 	}
@@ -628,9 +629,9 @@ static int lock_raw_ref(struct files_ref_store *refs,
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
@@ -654,7 +655,7 @@ static int lock_raw_ref(struct files_ref_store *refs,
 				 *   reference named "refs/foo/bar/baz".
 				 */
 			}
-		} else if (errno == EISDIR) {
+		} else if (failure_errno == EISDIR) {
 			/*
 			 * There is a directory in the way. It might have
 			 * contained references that have been deleted. If
@@ -692,13 +693,13 @@ static int lock_raw_ref(struct files_ref_store *refs,
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
index 24a360b719f..159ac776240 100644
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
index dc0d826c3ac..33a31d5c236 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -620,11 +620,15 @@ typedef int reflog_expire_fn(struct ref_store *ref_store,
  * properly-formatted or even safe reference name. NEITHER INPUT NOR
  * OUTPUT REFERENCE NAMES ARE VALIDATED WITHIN THIS FUNCTION.
  *
- * Return 0 on success. If the ref doesn't exist, set errno to ENOENT
- * and return -1. If the ref exists but is neither a symbolic ref nor
- * an object ID, it is broken; set REF_ISBROKEN in type, and return -1
- * (errno should not be ENOENT) If there is another error reading the
- * ref, set errno appropriately and return -1.
+ * Return 0 on success, or -1 on failure. If the ref exists but is neither a
+ * symbolic ref nor an object ID, it is broken. In this case set REF_ISBROKEN in
+ * type, and return -1 (failure_errno should not be ENOENT)
+ *
+ * failure_errno provides errno codes that are interpreted beyond error
+ * reporting. The following error codes have special meaning:
+ *    * ENOENT: the ref doesn't exist
+ *    * EISDIR: ref name is a directory
+ *    * ENOTDIR: ref prefix is not a directory
  *
  * Backend-specific flags might be set in type as well, regardless of
  * outcome.
@@ -638,9 +642,9 @@ typedef int reflog_expire_fn(struct ref_store *ref_store,
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
2.32.0.874.ge7a9d58bfcf

