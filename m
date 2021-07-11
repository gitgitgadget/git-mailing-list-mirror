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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BB1C07E96
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 16:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1518C61175
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 16:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbhGKQdi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jul 2021 12:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbhGKQdh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jul 2021 12:33:37 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0CBC0613DD
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 09:30:50 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id g16so11228190wrw.5
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 09:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fCG8q3upYBltskfBbQUSKYagc53c/mGirK1576W+rKQ=;
        b=W9+MyU4zGn/B3OSFStlqgqHrZWQ+jdf5IxmlbtkmhA92baAaCTlReXrxsQrTNVKb+u
         vfcaCfenMKCwq/Xwp0IYIoCO6r4B0b0loHaf1OaydFRq7bCP93+5pFJV3bS9Mmx6Uxbn
         JzhmnhKKVDXl87m/kJaFgusVxbmBROj9qrM83bNXXajZt9QAnr5KNCM+P2P7Pkqlwr9N
         ZM5pMRpJOmsqUE4SiN7MKmgxpTHKmLygmO8VV9BOa6oVBycMXRdlLOsCS1rylil4DjG5
         QuulvdU3oMLmdvBVMKErJmQer/IBlLTkaiNkVPk0XYuynn9dGBJSB4nOL+tJP+wOyM+z
         fCpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fCG8q3upYBltskfBbQUSKYagc53c/mGirK1576W+rKQ=;
        b=ntCSaHKPPbh6iRbixua9vSJaFR0FRghkm2Js7Uq++ekWXIiVGl51AJjTg5Jwe5ZJ7S
         npZKRKVmTxsjEEjKjVcTBPUNyrxgx+eZw2rRVi2nbF58XTUXFqOC+mYfuFO2t9GoTyKL
         iO/7GiSzK77lUuW/F7D94Wo07bZ4iga6XehzavnC+XNvHDmcMTNQa7ihob3q2qaewVBx
         tTj8QdzoCqGnPzda7USOVPvI6/o6O3tLGy+u6n+ZPzyN6qSAt6HF/eRtk/nvL5a6K6mi
         j/BXALrJZNddS2OyVYH2mMgeV4vMX+xeA/N7ZlQE88ZDhncmpMiNIXcUvuFunLHKKxuX
         wYWg==
X-Gm-Message-State: AOAM533EtYx4IvG/MMzIYIG8xq1fu+QB3inGPe+a4GcMn8/6nyShBVEm
        DVoQyAN8vgGK6J6ZY8y+1bG6q1xZOrNCQA==
X-Google-Smtp-Source: ABdhPJxL8HFjNAUXUMvSQs+3lYofix7FcW2ND6/5Ttuh9WbjTPiymmOIV1rDl+IGgnXBhp8WEh9tfw==
X-Received: by 2002:a5d:4402:: with SMTP id z2mr6449229wrq.44.1626021049060;
        Sun, 11 Jul 2021 09:30:49 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w3sm678091wrt.55.2021.07.11.09.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 09:30:48 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6? 04/17] refs: add failure_errno to refs_read_raw_ref() signature
Date:   Sun, 11 Jul 2021 18:30:28 +0200
Message-Id: <patch-04.17-270cda29c3a-20210711T162803Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0-dev
In-Reply-To: <cover-00.17-00000000000-20210711T162803Z-avarab@gmail.com>
References: <pull.1012.v5.git.git.1625684869.gitgitgadget@gmail.com> <cover-00.17-00000000000-20210711T162803Z-avarab@gmail.com>
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
index 7b3f05a66ff..406e27213b8 100644
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
index b9df7862e57..79f96ba1058 100644
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
index a457f18e93c..928e5d2a994 100644
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
2.32.0-dev

