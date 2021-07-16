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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 861AAC636CD
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 14:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72F27613F2
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 14:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240366AbhGPOZw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 10:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233094AbhGPOZi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 10:25:38 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFA0C06175F
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 07:22:41 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id v5so12340576wrt.3
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 07:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IFNYfMMsu6uaXzykxi5NAUTZugtCJzZEgDy9xX1ajjo=;
        b=KXQNvLmTkyuwo79PAqN71ISy52wisJ9nKiFCUOTLhiR8N4cTDyxoBB2wvaAdR8Ark2
         nUm3pGaUYVENcIMBJBcJ3lrQSwePI1BiVObSt9CNRkDUcQ6gCSQpZyWaOGx4OJGDd83P
         TbY30pUHXG8m6Mj86a1zChY+yewm04mnlekKoBCDuZHc1rUWYRkBZwGOa2+3fdwghM6A
         Wko4+C2fEeT+W/ltS46+FFwoyo7ksbb/RJjCA/mAk3DJr2HxtGwBIltyAOmQ67BvlI8X
         d2FcPQ+7YnGxMy20tcAQT4nHZ+PxpSVDvQlRlUu15NQ27bFMeIhyRCi3iCdnGAKGlAw8
         fYzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IFNYfMMsu6uaXzykxi5NAUTZugtCJzZEgDy9xX1ajjo=;
        b=SYkSHvavcwgx56tXCq5dqSoA1aP23AUcNqDd8+QPMrJXHdosWIuVuPHpdl9RZ83VBj
         ulGCogq3UJVRAACweP7YZy0NCNNSsJWqULLoCPoIHj7gi9dxUctaC1+9D0JhihPzEAaA
         xKzYTi1rMHDPHfBE6ztoY12DnPvKtsgAQZRmMReTLYDHCO+mNHWbaHGcuWYyOeyTHRz4
         7ICKuQHxcJT1TvKrvwcsgRY/3nvBaHmJUBQDU5pJD0e8x7vpipP4cwjYMlEypGF+1ges
         n5tumuftWIyXh9urR+sVxeNqJXw9E961tbqYDESHTH1L5z2yIPn685YpzqfV4wT+vnEo
         1PeQ==
X-Gm-Message-State: AOAM531IO46jsOXfzgxZx3j+a56LJi31s68JQ5z8KfhoQnye1o/uoVDj
        QJRDkcmuKiBFGQ8BUxnHzssF4OE0QSqH9Q==
X-Google-Smtp-Source: ABdhPJwcICdNqe8seILRL0wHXDp0cu96aMDVkTg+LkmI9ZgbGmmIo6bpxN9q9GpWmRX89o2ICZacgA==
X-Received: by 2002:a5d:6841:: with SMTP id o1mr12745789wrw.370.1626445359791;
        Fri, 16 Jul 2021 07:22:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z7sm7463236wmp.34.2021.07.16.07.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 07:22:39 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v8 5/7] refs: add failure_errno to refs_read_raw_ref() signature
Date:   Fri, 16 Jul 2021 16:22:30 +0200
Message-Id: <patch-5.7-b42a7474f18-20210716T142032Z-avarab@gmail.com>
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

This lets us use the explicit errno output parameter in refs_resolve_ref_unsafe.

Some of our callers explicitly do not care about the errno, rather
than understanding NULL let's have them declare that they don't care
by passing in an "ignore_errno". There's only three of them, and using
that pattern will make it more obvious that they want to throw away
data, let's also add a comment to one of the callers about why we'd
like to ignore the errno.

Let's not extend that to refs_resolve_ref_unsafe() itself for now, it
has a large set of legacy callers, so we're faking up the old "errno"
behavior for it. We can convert those callers to
refs_resolve_ref_unsafe_with_errno() later.

We are leaving out out the refs_read_special_head() in
refs_read_raw_ref() for now, as noted in the next commit moving it to
"failure_errno" will require some special consideration.

We're intentionally mis-indenting the argument list of the new
refs_resolve_ref_unsafe_with_errno(), it will be non-static in a
subsequent commit, doing it this way makes that diff smaller.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs.c                | 61 ++++++++++++++++++++++++++++++-------------
 refs/files-backend.c  | 10 ++++---
 refs/packed-backend.c |  7 ++---
 refs/refs-internal.h  |  6 ++---
 4 files changed, 56 insertions(+), 28 deletions(-)

diff --git a/refs.c b/refs.c
index 136e2e4c78a..b451f917d39 100644
--- a/refs.c
+++ b/refs.c
@@ -1672,30 +1672,33 @@ static int refs_read_special_head(struct ref_store *ref_store,
 	return result;
 }
 
-int refs_read_raw_ref(struct ref_store *ref_store,
-		      const char *refname, struct object_id *oid,
-		      struct strbuf *referent, unsigned int *type)
+int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
+		      struct object_id *oid, struct strbuf *referent,
+		      unsigned int *type, int *failure_errno)
 {
+	assert(failure_errno);
 	if (!strcmp(refname, "FETCH_HEAD") || !strcmp(refname, "MERGE_HEAD")) {
 		return refs_read_special_head(ref_store, refname, oid, referent,
 					      type);
 	}
 
 	return ref_store->be->read_raw_ref(ref_store, refname, oid, referent,
-					   type, &errno);
+					   type, failure_errno);
 }
 
-/* This function needs to return a meaningful errno on failure */
-const char *refs_resolve_ref_unsafe(struct ref_store *refs,
-				    const char *refname,
-				    int resolve_flags,
-				    struct object_id *oid, int *flags)
+static const char *refs_resolve_ref_unsafe_with_errno(struct ref_store *refs,
+					       const char *refname,
+					       int resolve_flags,
+					       struct object_id *oid,
+					       int *flags, int *failure_errno)
 {
 	static struct strbuf sb_refname = STRBUF_INIT;
 	struct object_id unused_oid;
 	int unused_flags;
 	int symref_count;
 
+	assert(failure_errno);
+
 	if (!oid)
 		oid = &unused_oid;
 	if (!flags)
@@ -1706,7 +1709,7 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
 		if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
 		    !refname_is_safe(refname)) {
-			errno = EINVAL;
+			*failure_errno = EINVAL;
 			return NULL;
 		}
 
@@ -1724,8 +1727,8 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 	for (symref_count = 0; symref_count < SYMREF_MAXDEPTH; symref_count++) {
 		unsigned int read_flags = 0;
 
-		if (refs_read_raw_ref(refs, refname,
-				      oid, &sb_refname, &read_flags)) {
+		if (refs_read_raw_ref(refs, refname, oid, &sb_refname,
+				      &read_flags, failure_errno)) {
 			*flags |= read_flags;
 
 			/* In reading mode, refs must eventually resolve */
@@ -1737,9 +1740,9 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 			 * may show errors besides ENOENT if there are
 			 * similarly-named refs.
 			 */
-			if (errno != ENOENT &&
-			    errno != EISDIR &&
-			    errno != ENOTDIR)
+			if (*failure_errno != ENOENT &&
+			    *failure_errno != EISDIR &&
+			    *failure_errno != ENOTDIR)
 				return NULL;
 
 			oidclr(oid);
@@ -1766,7 +1769,7 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 		if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
 			if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
 			    !refname_is_safe(refname)) {
-				errno = EINVAL;
+				*failure_errno = EINVAL;
 				return NULL;
 			}
 
@@ -1774,10 +1777,24 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 		}
 	}
 
-	errno = ELOOP;
+	*failure_errno = ELOOP;
 	return NULL;
 }
 
+const char *refs_resolve_ref_unsafe(struct ref_store *refs, const char *refname,
+				    int resolve_flags, struct object_id *oid,
+				    int *flags)
+{
+	int failure_errno = 0;
+	const char *refn;
+	refn = refs_resolve_ref_unsafe_with_errno(refs, refname, resolve_flags,
+						  oid, flags, &failure_errno);
+	if (!refn)
+		/* For unmigrated legacy callers */
+		errno = failure_errno;
+	return refn;
+}
+
 /* backend functions */
 int refs_init_db(struct strbuf *err)
 {
@@ -2228,6 +2245,13 @@ int refs_verify_refname_available(struct ref_store *refs,
 
 	strbuf_grow(&dirname, strlen(refname) + 1);
 	for (slash = strchr(refname, '/'); slash; slash = strchr(slash + 1, '/')) {
+		/*
+		 * Just saying "Is a directory" when we e.g. can't
+		 * lock some multi-level ref isn't very informative,
+		 * the user won't be told *what* is a directory, so
+		 * let's not use strerror() below.
+		 */
+		int ignore_errno;
 		/* Expand dirname to the new prefix, not including the trailing slash: */
 		strbuf_add(&dirname, refname + dirname.len, slash - refname - dirname.len);
 
@@ -2239,7 +2263,8 @@ int refs_verify_refname_available(struct ref_store *refs,
 		if (skip && string_list_has_string(skip, dirname.buf))
 			continue;
 
-		if (!refs_read_raw_ref(refs, dirname.buf, &oid, &referent, &type)) {
+		if (!refs_read_raw_ref(refs, dirname.buf, &oid, &referent,
+				       &type, &ignore_errno)) {
 			strbuf_addf(err, _("'%s' exists; cannot create '%s'"),
 				    dirname.buf, refname);
 			goto cleanup;
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 70970f6f770..25bb225d92a 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -381,10 +381,11 @@ static int files_read_raw_ref(struct ref_store *ref_store, const char *refname,
 		goto out;
 
 	if (lstat(path, &st) < 0) {
+		int ignore_errno;
 		if (errno != ENOENT)
 			goto out;
-		if (refs_read_raw_ref(refs->packed_ref_store, refname,
-				      oid, referent, type)) {
+		if (refs_read_raw_ref(refs->packed_ref_store, refname, oid,
+				      referent, type, &ignore_errno)) {
 			errno = ENOENT;
 			goto out;
 		}
@@ -418,13 +419,14 @@ static int files_read_raw_ref(struct ref_store *ref_store, const char *refname,
 
 	/* Is it a directory? */
 	if (S_ISDIR(st.st_mode)) {
+		int ignore_errno;
 		/*
 		 * Even though there is a directory where the loose
 		 * ref is supposed to be, there could still be a
 		 * packed ref:
 		 */
-		if (refs_read_raw_ref(refs->packed_ref_store, refname,
-				      oid, referent, type)) {
+		if (refs_read_raw_ref(refs->packed_ref_store, refname, oid,
+				      referent, type, &ignore_errno)) {
 			errno = EISDIR;
 			goto out;
 		}
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 1cb7f8e8f70..a4bf3d22d77 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1347,6 +1347,7 @@ int is_packed_transaction_needed(struct ref_store *ref_store,
 	ret = 0;
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = transaction->updates[i];
+		int failure_errno;
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
2.32.0.874.gfa1990a4f10

