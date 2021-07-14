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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF84C07E9C
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 11:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05E9D613B6
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 11:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239246AbhGNLqf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 07:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239092AbhGNLqe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 07:46:34 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9390C06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 04:43:42 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id g12so1390421wme.2
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 04:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sc2xgR4NAVG++AYv+xW8OLDr3oGrKjU8CkZsZ2y/Z/Q=;
        b=lXADObE4GTseEeKTqGghyP1i55vY6ve39WGxA/chNQnfpeO9iQ5vnlz+9Nw0jCyI8s
         4t77quLImEtkFfvyX/cGJ8vpBqyOpAtn1rHFQ7I9z9qTz0ckX14JCE9v+VYmA5xhOB1M
         NhPOezqmQG3ZibEOyCT8xlooXFjWL5BnviL4V8M0UPlWU+nWaYjRRl+s5vaxxnvDQl0h
         99NMn+6jVIz9JWVuu/ci/w+f5+cbvwvk0HKirqHJmKrVnMAEtc0PDndNsvQ9iyHoiUhL
         DfOrX8Hnxk6Nv96mndXUJktA1hcDDw/3jY+6wy3+mi020/9wopaTGdHHPY9Fnd0EcBCF
         1sJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sc2xgR4NAVG++AYv+xW8OLDr3oGrKjU8CkZsZ2y/Z/Q=;
        b=RRGKapsdlqgEJXje3tqAqL0y0I4dxYjj0gSkG/HnkNGohvbIozhOn0glgSWjw3qVz6
         tkXO89WVOopwXY0ow8ZsgmDafzMYLAEdwfnIr8T81LcVXx2gq0NutC4rgB3OpYZdG0Na
         ac+uC4JKsrgyeclxlo1B7CwuZEwBzpXPboqgnX600/Soox7sBhZVyNrLxMrG0UohuQOH
         1MqeqYO7ZymHkWvtjQcTrynwxvyYaLHFw0fHCq8NZCXPStBdsgdkNATS1KSxCrkveWQD
         5yDCKxmy9WGS694OF2TulvVVBDbilk8O9FO2qM/hPEhUgwSPuDGrlavenguXiFhjd+T8
         QQ3Q==
X-Gm-Message-State: AOAM530gclf2fYiZI/ZDz+y7JVsqjhaz7Kj3fq3qrw8zoZFALbZcMlWe
        Rn1cOvjuGpqxJQHSYeEJ2a2d+JikXR2Fnkj5
X-Google-Smtp-Source: ABdhPJwwO9B7F2GULao1LWNUfNfpuqup8tvmxUnqt6ri0JJv+fEPxxp6X5Ka1iIRGzhK7ONGpKGFFg==
X-Received: by 2002:a7b:c452:: with SMTP id l18mr3534825wmi.164.1626263021057;
        Wed, 14 Jul 2021 04:43:41 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a8sm2373626wrt.61.2021.07.14.04.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 04:43:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 4/6] refs: add failure_errno to refs_read_raw_ref() signature
Date:   Wed, 14 Jul 2021 13:43:32 +0200
Message-Id: <patch-4.6-dd191768f6-20210714T114301Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.851.g0fc62a9785
In-Reply-To: <cover-0.6-0000000000-20210714T114301Z-avarab@gmail.com>
References: <cover-00.17-00000000000-20210711T162803Z-avarab@gmail.com> <cover-0.6-0000000000-20210714T114301Z-avarab@gmail.com>
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
index 7b3f05a66f..406e27213b 100644
--- a/refs.c
+++ b/refs.c
@@ -1671,30 +1671,33 @@ static int refs_read_special_head(struct ref_store *ref_store,
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
@@ -1705,7 +1708,7 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
 		if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
 		    !refname_is_safe(refname)) {
-			errno = EINVAL;
+			*failure_errno = EINVAL;
 			return NULL;
 		}
 
@@ -1723,8 +1726,8 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 	for (symref_count = 0; symref_count < SYMREF_MAXDEPTH; symref_count++) {
 		unsigned int read_flags = 0;
 
-		if (refs_read_raw_ref(refs, refname,
-				      oid, &sb_refname, &read_flags)) {
+		if (refs_read_raw_ref(refs, refname, oid, &sb_refname,
+				      &read_flags, failure_errno)) {
 			*flags |= read_flags;
 
 			/* In reading mode, refs must eventually resolve */
@@ -1736,9 +1739,9 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
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
@@ -1765,7 +1768,7 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 		if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
 			if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
 			    !refname_is_safe(refname)) {
-				errno = EINVAL;
+				*failure_errno = EINVAL;
 				return NULL;
 			}
 
@@ -1773,10 +1776,24 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
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
@@ -2227,6 +2244,13 @@ int refs_verify_refname_available(struct ref_store *refs,
 
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
 
@@ -2238,7 +2262,8 @@ int refs_verify_refname_available(struct ref_store *refs,
 		if (skip && string_list_has_string(skip, dirname.buf))
 			continue;
 
-		if (!refs_read_raw_ref(refs, dirname.buf, &oid, &referent, &type)) {
+		if (!refs_read_raw_ref(refs, dirname.buf, &oid, &referent,
+				       &type, &ignore_errno)) {
 			strbuf_addf(err, _("'%s' exists; cannot create '%s'"),
 				    dirname.buf, refname);
 			goto cleanup;
diff --git a/refs/files-backend.c b/refs/files-backend.c
index c4b5b70c53..3eef442c24 100644
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
index a457f18e93..928e5d2a99 100644
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
index 79dfb3af48..54f57c6a2d 100644
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
2.32.0.851.g0fc62a9785

