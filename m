Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39D1C433FE
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 00:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC03561152
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 00:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbhJNAIq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 20:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbhJNAIm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 20:08:42 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5F9C061746
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 17:06:38 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id o20so13858565wro.3
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 17:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kl9dXg+E8VgirTawpUZoZT1wEwhd49b+/11me4RFFS4=;
        b=m+Zb4T3vz3si8Hli/cQcv4TRaDfzSiujh+0HERq37H0DD4mxt0Zr6tArbvbBngDsWb
         yfYdPV1sthGDTRBaneCNPzjFzuz1oa/1o8gX82xJupL6zVRrDTePMTI9T+bMHs1mHu5t
         sT1ssrXfNXnIwG9Y/dMS/+XOegwj9WekFAmos2rmu+vS32S9o/RFAi+TwZsTczLN1q/P
         O9t+i4sthNL8PfF2ptKDPTlj4kejqEXQ/FWifp5BFoILcXsmNBtJ/1XBjFOUmf2lV09G
         tD7ELRNqwtLxPCU5NmVe9r82Kt1BMZwLJnB0feRXxEJ36VdV13ZWvCX3Brul/oFBVw/M
         tfeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kl9dXg+E8VgirTawpUZoZT1wEwhd49b+/11me4RFFS4=;
        b=Qcm3Qqw2XucMiFULEtoR0k39zFJLdd+31m/J341IA3bd0R6LTUuq/4FGfqneGDlb4Z
         lQFctprO6xAWCSAM+esqj6UrfIcYJhDKeocedAe/IP9BfqXJz3fSFV5a4XdGcfNZdagi
         ++Gq7+u9rKmgeHltttXeC70Y9F5pJZJZCl7D/jGYOQuV6cIyPhS85lQONLhGUEJ1JPfr
         8xU842HErw6dpPNIP2O/ZdYIOoclwGPbYSuhc4B434p+1qTE1lCrIELomj21aYTNV6GC
         3J5YT81YZI0ReOehv7I1ti11kfSlULwf1PdBf91sHR/9tUPLlUKKVrIeuaYkSW6KZahj
         OETw==
X-Gm-Message-State: AOAM531PG4SOCu1RH6Mpq+fr8noDAT8SVc+EMb7WDOohmT2Ym3RZWd1F
        cY0W35Ly17DHhhBLLPwQN1XYn74S5zR15A==
X-Google-Smtp-Source: ABdhPJz7E4YGg4F0zdn/46OQGBqWIDqtWBUX6+5owYRGNn5JxWNisgOutASD12pOUITegeh/FfwEvA==
X-Received: by 2002:a1c:9a4d:: with SMTP id c74mr2295505wme.139.1634169996805;
        Wed, 13 Oct 2021 17:06:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y8sm670711wmi.43.2021.10.13.17.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 17:06:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 03/20] refs API: make refs_read_raw_ref() not set errno
Date:   Thu, 14 Oct 2021 02:06:15 +0200
Message-Id: <patch-03.20-a1a80715ffe-20211013T235900Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1346.g48288c3c089
In-Reply-To: <cover-00.20-00000000000-20211013T235900Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20211013T235900Z-avarab@gmail.com>
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
index 46e3c785016..acc5d5fa578 100644
--- a/refs.c
+++ b/refs.c
@@ -1665,17 +1665,18 @@ static int refs_read_special_head(struct ref_store *ref_store,
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
@@ -1719,9 +1720,8 @@ const char *refs_werrres_ref_unsafe(struct ref_store *refs,
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
@@ -2239,6 +2239,13 @@ int refs_verify_refname_available(struct ref_store *refs,
 
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
 
@@ -2250,7 +2257,8 @@ int refs_verify_refname_available(struct ref_store *refs,
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
2.33.1.1346.g48288c3c089

