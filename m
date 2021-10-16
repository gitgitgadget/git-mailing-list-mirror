Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179BFC433F5
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 09:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED70761073
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 09:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244003AbhJPJl5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Oct 2021 05:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244012AbhJPJlu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Oct 2021 05:41:50 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F304BC06176D
        for <git@vger.kernel.org>; Sat, 16 Oct 2021 02:39:33 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 67-20020a1c1946000000b0030d4c90fa87so4056101wmz.2
        for <git@vger.kernel.org>; Sat, 16 Oct 2021 02:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dygm4lUp7okJ2v21gbn/QbIlCNCxJKXdSLwAW/VgnIU=;
        b=QL1QQ7/sFKrTKe8S4TWfQfnPYyjzevSvNS3+3sAmzVMeg2LUUrpG++xquUY5wSkDvF
         QOJRS2VGR2k2JD2S4rHr/GKfTWzxiIHcijxHUqD7ZtZw1vGLivAdfueBqh0zETHskRzV
         Ch2IVit8KT4iFLzumvggDUdJTmtDdfxXkacMuO6R4cbW5lGWwUGKx99RVgPZSUfDX2vS
         y66apeHCUTu4MrF8p52cow76SPywKHgaup/zvYY7E0r8VH+clJz/1IR1Na15kRsaE/28
         AYNfD9t30QHgfaPys8p1Pyl7TJN8se/UrHc/D0ZGNxM8Bb7BSCFoqpsVsfTp9lFPk+c4
         S2RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dygm4lUp7okJ2v21gbn/QbIlCNCxJKXdSLwAW/VgnIU=;
        b=SUH/kq0LKHoxxgXLJvVbTH9WmxBuKdc/QBGtRSgQ8B27lYsdPok9WgSu2YDBrEKGzb
         FqIbiQms0r3nZ7aX28kvnmbwU7tATzegUzb79ggLCLRgdmPx+bPb2ltvEv2TthmuGyIt
         YZDJ7vvHIn1Qy3JWsHONhHBlnH6DBV16bGF1Q1q8Co/q8Lr8Yu3eS+T86VxYV2w+luVm
         +Ljl10FP2fxXvYBcMjOvaxM8aWLg4kFKE6qwUwmFh32RerRIh9QiC4FNxRFwDX2l7pql
         d01TP7joT++f1FcaeFO8jmUOREOL8Rbu24ncaoQMj4gntK3JwDremvYdBRZtsJbV0//C
         zk+w==
X-Gm-Message-State: AOAM530/W0ag2g+D8snnDzuMhBUzVoGW0x1vJ+Z6IPunUgf76NQmkiW4
        IIEuTE43mcxUPeIBAbDsHRREuG1Zpms+KA==
X-Google-Smtp-Source: ABdhPJwKgJXCbKQbU6dkAWIMtLarSLA39CWWsSllDoIu2eb+7D0PQVo3csK6ZM4tgeTaT50424beJg==
X-Received: by 2002:a1c:3586:: with SMTP id c128mr31792605wma.78.1634377172314;
        Sat, 16 Oct 2021 02:39:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k22sm6993492wrd.59.2021.10.16.02.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 02:39:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 03/21] refs API: make refs_read_raw_ref() not set errno
Date:   Sat, 16 Oct 2021 11:39:09 +0200
Message-Id: <patch-v2-03.21-8932b109087-20211016T093845Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <cover-v2-00.21-00000000000-20211016T093845Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20211013T235900Z-avarab@gmail.com> <cover-v2-00.21-00000000000-20211016T093845Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Add a "failure_errno" to refs_read_raw_ref(), his allows
refs_werrres_ref_unsafe() to pass along its "failure_errno", as a
first step before its own callers are migrated to pass it further up
the chain.

We are leaving out out the refs_read_special_head() in
refs_read_raw_ref() for now, as noted in a subsequent commit moving it
to "failure_errno" will require some special consideration.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs.c                | 24 ++++++++++++++++--------
 refs/files-backend.c  | 10 ++++++----
 refs/packed-backend.c |  7 ++++---
 refs/refs-internal.h  |  6 +++---
 4 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/refs.c b/refs.c
index ad56dbb0125..200c44e6963 100644
--- a/refs.c
+++ b/refs.c
@@ -1666,17 +1666,18 @@ static int refs_read_special_head(struct ref_store *ref_store,
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
 
 const char *refs_werrres_ref_unsafe(struct ref_store *refs,
@@ -1720,9 +1721,8 @@ const char *refs_werrres_ref_unsafe(struct ref_store *refs,
 	for (symref_count = 0; symref_count < SYMREF_MAXDEPTH; symref_count++) {
 		unsigned int read_flags = 0;
 
-		errno = 0;
-		if (refs_read_raw_ref(refs, refname,
-				      oid, &sb_refname, &read_flags)) {
+		if (refs_read_raw_ref(refs, refname, oid, &sb_refname,
+				      &read_flags, failure_errno)) {
 			*flags |= read_flags;
 			if (errno)
 				*failure_errno = errno;
@@ -2240,6 +2240,13 @@ int refs_verify_refname_available(struct ref_store *refs,
 
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
 
@@ -2251,7 +2258,8 @@ int refs_verify_refname_available(struct ref_store *refs,
 		if (skip && string_list_has_string(skip, dirname.buf))
 			continue;
 
-		if (!refs_read_raw_ref(refs, dirname.buf, &oid, &referent, &type)) {
+		if (!refs_read_raw_ref(refs, dirname.buf, &oid, &referent,
+				       &type, &ignore_errno)) {
 			strbuf_addf(err, _("'%s' exists; cannot create '%s'"),
 				    dirname.buf, refname);
 			goto cleanup;
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 6a6ead0b99b..94c194665ed 100644
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
index 47247a14917..52cdc94a26e 100644
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
index 72746407fc3..c87f1135e5b 100644
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
2.33.1.1338.g20da966911a

