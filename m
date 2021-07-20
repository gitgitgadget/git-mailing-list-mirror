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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B47C636C8
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 10:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE0C561164
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 10:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237588AbhGTJyH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 05:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237496AbhGTJxC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 05:53:02 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7191AC0613DB
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 03:33:39 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id n4so12008466wms.1
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 03:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MPe3T+8UKpLqrbwKgF9DA/IbxEzVKaLF5pi9KCJ0qgs=;
        b=ttADS1tX0JTKUzUkeawfHxaNdy9zacmuRI5B9e7UQPdLvUBQi9kM6AqizwisHnxvK5
         wKQO1A48SvxYorMtN4NoJBDP1KKgh2yf141CTdRiECGfOcHhO6pip4rQIzSCOHRs4SKS
         0ze/Jb7x2/MfJeq4+pZ4N467a3fH9w9zKT4w4aPwKKVDZlNIymaqbALWqJZ0jC5cauxS
         MzmD+xQTA80zfAlQYTNx0hNvpCd9S7+PN/xsSSaRWT/opcCAivvuyi0Np+psWSRNP/vX
         4wKwhTqj29jfVq0pQPjTpJjPH1w335MJ5wnnAPSuDTGtGlHX2O8SVnCF/FV9X9FLiwJd
         u87w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MPe3T+8UKpLqrbwKgF9DA/IbxEzVKaLF5pi9KCJ0qgs=;
        b=HuW11XLp4QTkGQl0Qs3pqvTjmW7Wr1Zfsr3Jugzybt780560I9Ymn6ppR99OexgtfB
         FdzOUfqZcOoyeQtRQOxWejiau2Ms4Y9Q1Sk18ztjQd219U8Q+DRNAFMcSN6n0yQysTal
         Viu92HcjObrC+ZNg/wtjsE3MWOKZnVtncbH9siAD4Idds9DC+C39/SIh4BMLxZMaacv2
         yuqX4ezSeC2rn+6WJe0rkNfc0X+Fb1PmV38SCjc0pzAe2EvzNQhj6nZUpgBnEQuM+mWl
         FCAfNwyNTxhce804+k0Qqdg+3pyyhvg6KMC8x3PJMw3IV9JAyh1sRwbCue825O+S6U91
         n1Mw==
X-Gm-Message-State: AOAM532RxVbKkDiA+DL7A6j0jkHLD9QGUHzTAFVsdfKrHH1vD1qLnSqn
        Rzvs9tqogjJuzU3hdq7GCjirdi+Fq5VEUw==
X-Google-Smtp-Source: ABdhPJxqLNQptpcRqJNbB1IP2iLSaTrEnlSqYdQT8lSQ/N7Nv6S9h4rdFKFZ+prKUOKiRDCzTTAnuQ==
X-Received: by 2002:a05:600c:cc:: with SMTP id u12mr37279419wmm.19.1626777217804;
        Tue, 20 Jul 2021 03:33:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l14sm22179852wrs.22.2021.07.20.03.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 03:33:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v9 5/7] refs: add failure_errno to refs_read_raw_ref() signature
Date:   Tue, 20 Jul 2021 12:33:28 +0200
Message-Id: <patch-5.7-18825efce7d-20210720T102644Z-avarab@gmail.com>
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
index fc6c0ddffae..728285c9220 100644
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
index 85b4d791444..bbd8caec624 100644
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
index 159ac776240..923b9ad89de 100644
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
index 33a31d5c236..7beb38f79cc 100644
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
2.32.0.874.ge7a9d58bfcf

