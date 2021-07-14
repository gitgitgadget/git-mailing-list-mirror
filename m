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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C5DC07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 11:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39A1A6128C
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 11:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239266AbhGNLqj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 07:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239252AbhGNLqg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 07:46:36 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA3CC06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 04:43:43 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id g12so1390458wme.2
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 04:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8xbb8649SL3ZXsjCcByuekdegm+ykA6gOkbkB5PJOYQ=;
        b=NBPnflKZDQfm1fLZSHrgwO3K1E/v0x4CKkQ7fvFlgeDkEZDVMtFu5pr1XXCBrlFZ5u
         slOtfJeEIf565ByD+8pHt5xdHxgXn0iKtsiFDiDh3oGn5hNaumOnGk33MJnI3ubKwxrv
         LLk6d3CadEdRz6PlqOBTHpjxi3lSX0CgyPGvIQeULsJFbs485IctBMc00GTE1+Y7DtDH
         bkUweC8Ug7oQTFqdMxXtwe/+I7vMf/jE2ZRJpOVNKv7J/3pVqSvx/jSPdSAyfr7axnGb
         iC9ljHQEETrcQOs5+Lk2pIvu70gGIj0lIbc3cuPui6fE8i4TlBo4Nv86nBxmMWUc1Do/
         Hajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8xbb8649SL3ZXsjCcByuekdegm+ykA6gOkbkB5PJOYQ=;
        b=XsrG3kI02JeT2h5z3Y5RaVkSPLwbBMdgQ7n1kyM1TDe07Znj3GX8KGugL0t2GihDk9
         VRXNFWbkl0fOnBaM+rz+k8L/cR4X+SMEf+lNU/Yi3MwTlFiX4XS1cCJvxGRtEaRaY0em
         +r8gOdagyzmi8gupCBEPhg/GjTwOEnVzAaxaQ29gQvs2AqdUuz6/9TddvTWLWpYqfBab
         TeHbz11Nvh2xG2rJPtW4863zP/rz3QxVeku7usjzD0Fsdrr/a/5BfNSsUOkMiyqgvAhI
         6SbuNK25bhtAoJoELvBWV/0UKBVGgERI7SOatZHQ045ipZ1EdV7L82qYTWZLFGvWi4qq
         Iu5g==
X-Gm-Message-State: AOAM530A4kGQBmCLbQ4pWUEHFeBeRw4LmOYOVybEmVvElsc0n7z+z2Oq
        hlZPL3/EuLC7NLOyW7cs1We6hDHO8IYEMSoS
X-Google-Smtp-Source: ABdhPJygQ9ibvAvhi4Kzge8Tf+alSjtsKvhdyrSTNtaLrXU1MDj7IA1wTgJJ1mlwESC/228ftlU38A==
X-Received: by 2002:a05:600c:2306:: with SMTP id 6mr3559578wmo.144.1626263021912;
        Wed, 14 Jul 2021 04:43:41 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a8sm2373626wrt.61.2021.07.14.04.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 04:43:41 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 5/6] refs: explicitly return failure_errno from parse_loose_ref_contents
Date:   Wed, 14 Jul 2021 13:43:33 +0200
Message-Id: <patch-5.6-77c53dc0d9-20210714T114301Z-avarab@gmail.com>
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

The EINVAL error from parse_loose_ref_contents is used in files-backend
to create a custom error message.

In untangling this we discovered a tricky edge case. The
refs_read_special_head() function was relying on
parse_loose_ref_contents() setting EINVAL.

By converting it to use "saved_errno" we can migrate away from "errno"
in this part of the code entirely, and do away with an existing
"save_errno" pattern, its only purpose was to not clobber the "errno"
we previously needed at the end of files_read_raw_ref().

Let's assert that we can do that by not having files_read_raw_ref()
itself operate on *failure_errno in addition to passing it on. Instead
we'll assert that if we return non-zero we actually do set errno, thus
assuring ourselves and callers that they can trust the resulting
"failure_errno".

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs.c               |  8 +++++---
 refs/files-backend.c | 30 +++++++++++++++++++-----------
 refs/refs-internal.h |  6 ++++--
 3 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/refs.c b/refs.c
index 406e27213b..af01a692cb 100644
--- a/refs.c
+++ b/refs.c
@@ -1653,7 +1653,8 @@ int for_each_fullref_in_prefixes(const char *namespace,
 
 static int refs_read_special_head(struct ref_store *ref_store,
 				  const char *refname, struct object_id *oid,
-				  struct strbuf *referent, unsigned int *type)
+				  struct strbuf *referent, unsigned int *type,
+				  int *failure_errno)
 {
 	struct strbuf full_path = STRBUF_INIT;
 	struct strbuf content = STRBUF_INIT;
@@ -1663,7 +1664,8 @@ static int refs_read_special_head(struct ref_store *ref_store,
 	if (strbuf_read_file(&content, full_path.buf, 0) < 0)
 		goto done;
 
-	result = parse_loose_ref_contents(content.buf, oid, referent, type);
+	result = parse_loose_ref_contents(content.buf, oid, referent, type,
+					  failure_errno);
 
 done:
 	strbuf_release(&full_path);
@@ -1678,7 +1680,7 @@ int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
 	assert(failure_errno);
 	if (!strcmp(refname, "FETCH_HEAD") || !strcmp(refname, "MERGE_HEAD")) {
 		return refs_read_special_head(ref_store, refname, oid, referent,
-					      type);
+					      type, failure_errno);
 	}
 
 	return ref_store->be->read_raw_ref(ref_store, refname, oid, referent,
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 3eef442c24..e6b1cd9ff7 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -355,6 +355,7 @@ static int files_read_raw_ref(struct ref_store *ref_store, const char *refname,
 	int fd;
 	int ret = -1;
 	int remaining_retries = 3;
+	int myerr = 0;
 
 	*type = 0;
 	strbuf_reset(&sb_path);
@@ -382,11 +383,13 @@ static int files_read_raw_ref(struct ref_store *ref_store, const char *refname,
 
 	if (lstat(path, &st) < 0) {
 		int ignore_errno;
-		if (errno != ENOENT)
+		myerr = errno;
+		errno = 0;
+		if (myerr != ENOENT)
 			goto out;
 		if (refs_read_raw_ref(refs->packed_ref_store, refname, oid,
 				      referent, type, &ignore_errno)) {
-			errno = ENOENT;
+			myerr = ENOENT;
 			goto out;
 		}
 		ret = 0;
@@ -397,7 +400,9 @@ static int files_read_raw_ref(struct ref_store *ref_store, const char *refname,
 	if (S_ISLNK(st.st_mode)) {
 		strbuf_reset(&sb_contents);
 		if (strbuf_readlink(&sb_contents, path, st.st_size) < 0) {
-			if (errno == ENOENT || errno == EINVAL)
+			myerr = errno;
+			errno = 0;
+			if (myerr == ENOENT || myerr == EINVAL)
 				/* inconsistent with lstat; retry */
 				goto stat_ref;
 			else
@@ -427,7 +432,7 @@ static int files_read_raw_ref(struct ref_store *ref_store, const char *refname,
 		 */
 		if (refs_read_raw_ref(refs->packed_ref_store, refname, oid,
 				      referent, type, &ignore_errno)) {
-			errno = EISDIR;
+			myerr = EISDIR;
 			goto out;
 		}
 		ret = 0;
@@ -440,7 +445,8 @@ static int files_read_raw_ref(struct ref_store *ref_store, const char *refname,
 	 */
 	fd = open(path, O_RDONLY);
 	if (fd < 0) {
-		if (errno == ENOENT && !S_ISLNK(st.st_mode))
+		myerr = errno;
+		if (myerr == ENOENT && !S_ISLNK(st.st_mode))
 			/* inconsistent with lstat; retry */
 			goto stat_ref;
 		else
@@ -448,26 +454,28 @@ static int files_read_raw_ref(struct ref_store *ref_store, const char *refname,
 	}
 	strbuf_reset(&sb_contents);
 	if (strbuf_read(&sb_contents, fd, 256) < 0) {
-		int save_errno = errno;
 		close(fd);
-		errno = save_errno;
 		goto out;
 	}
 	close(fd);
 	strbuf_rtrim(&sb_contents);
 	buf = sb_contents.buf;
 
-	ret = parse_loose_ref_contents(buf, oid, referent, type);
+	ret = parse_loose_ref_contents(buf, oid, referent, type, &myerr);
 
 out:
-	*failure_errno = errno;
+	if (ret && !myerr)
+		BUG("returning non-zero %d, should have set myerr!", ret);
+	*failure_errno = myerr;
+
 	strbuf_release(&sb_path);
 	strbuf_release(&sb_contents);
 	return ret;
 }
 
 int parse_loose_ref_contents(const char *buf, struct object_id *oid,
-			     struct strbuf *referent, unsigned int *type)
+			     struct strbuf *referent, unsigned int *type,
+			     int *failure_errno)
 {
 	const char *p;
 	if (skip_prefix(buf, "ref:", &buf)) {
@@ -486,7 +494,7 @@ int parse_loose_ref_contents(const char *buf, struct object_id *oid,
 	if (parse_oid_hex(buf, oid, &p) ||
 	    (*p != '\0' && !isspace(*p))) {
 		*type |= REF_ISBROKEN;
-		errno = EINVAL;
+		*failure_errno = EINVAL;
 		return -1;
 	}
 	return 0;
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 54f57c6a2d..bf581e70cf 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -689,10 +689,12 @@ struct ref_store {
 };
 
 /*
- * Parse contents of a loose ref file.
+ * Parse contents of a loose ref file. *failure_errno maybe be set to EINVAL for
+ * invalid contents.
  */
 int parse_loose_ref_contents(const char *buf, struct object_id *oid,
-			     struct strbuf *referent, unsigned int *type);
+			     struct strbuf *referent, unsigned int *type,
+			     int *failure_errno);
 
 /*
  * Fill in the generic part of refs and add it to our collection of
-- 
2.32.0.851.g0fc62a9785

