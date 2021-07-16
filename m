Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB67C636CE
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 14:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 485F8613F2
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 14:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240389AbhGPOZx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 10:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233115AbhGPOZk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 10:25:40 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FF0C061760
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 07:22:42 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id w13so5956875wmc.3
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 07:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=be1m4K9hcVqyYA72w4nj+evRTQY5Fovx/babRobDhS8=;
        b=l0CQoB+OlojnIP+LmQeBKve7WUQt2JjSy3rJIuqo+xjPv6NACPSNgQy7axaOBRDoF6
         jsfI0G6PwCwb9se+Z3zZWCB6hpjW2jFIvDfCSWV51HDKTqWSE5z5d5sdcZJK08/71JpF
         FV/m8v+MvzAjTKdPI8tAd/8RGjzBXSJRvZJpp509qYzLrlNaNDW9JCMWgjj/20hwd1p7
         Dx7A5ZPX7b5DFpZ9zqMeSXgrgejfruLWatV7wii4In8pJ5UC/YhAP2vwNz4/tC9QDWBG
         rSAHXgsy/UoiWDbdFRSBd7NmdgrrPGBy859+29Wd35ms6Vx7SZbh5kaaCOJXVo3/Vjgp
         UyoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=be1m4K9hcVqyYA72w4nj+evRTQY5Fovx/babRobDhS8=;
        b=nxr45PsY75gleogLzsceltQfz7KvBBRAE4gq6ryf9i+R3Ep3WEoj10ScGcrruEleOQ
         v3iXHYiuVagXUBzEwanyVSQb7IAkbp7FCz8QWQFUTWuEwWvldptFtgjYLZOCGnbguBb3
         FEB7zetlhiSoYeKLQUB9C+yU7Iht1o6Fkfce37Nnd83ZjmfmVLSt0MBNiybRkac0NLK/
         1mvJswQUqYDtt6FTV5XvSl5ofzRnK2SFdPVsc+5tg/S1yHZZulWexgKOGgk5gKssxMNw
         CyfRBz8PFuBnkWY7enISMtPl/Ouojmj3OhhycSUcqsINvRrNdp2+Tajz59XuYTRuG8FP
         Z+jQ==
X-Gm-Message-State: AOAM533BQcgVZCUBAIL79EUHgPXERXvmE57QQN2/bdxlt8kRlBmSSazy
        exHsUi7AQnCWnkC4Besn4HbxDG+goRePog==
X-Google-Smtp-Source: ABdhPJxWwkYzp8NpBQEvk5eTL9/W8GGUuQUVUMqP7KU29CX12aUgnMhP8YpSwof0WTh/SrrOkSAP1w==
X-Received: by 2002:a05:600c:3201:: with SMTP id r1mr10868072wmp.41.1626445360735;
        Fri, 16 Jul 2021 07:22:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z7sm7463236wmp.34.2021.07.16.07.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 07:22:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v8 6/7] refs: explicitly return failure_errno from parse_loose_ref_contents
Date:   Fri, 16 Jul 2021 16:22:31 +0200
Message-Id: <patch-6.7-93b770c8bea-20210716T142032Z-avarab@gmail.com>
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
index b451f917d39..ceaaccc1680 100644
--- a/refs.c
+++ b/refs.c
@@ -1654,7 +1654,8 @@ int for_each_fullref_in_prefixes(const char *namespace,
 
 static int refs_read_special_head(struct ref_store *ref_store,
 				  const char *refname, struct object_id *oid,
-				  struct strbuf *referent, unsigned int *type)
+				  struct strbuf *referent, unsigned int *type,
+				  int *failure_errno)
 {
 	struct strbuf full_path = STRBUF_INIT;
 	struct strbuf content = STRBUF_INIT;
@@ -1664,7 +1665,8 @@ static int refs_read_special_head(struct ref_store *ref_store,
 	if (strbuf_read_file(&content, full_path.buf, 0) < 0)
 		goto done;
 
-	result = parse_loose_ref_contents(content.buf, oid, referent, type);
+	result = parse_loose_ref_contents(content.buf, oid, referent, type,
+					  failure_errno);
 
 done:
 	strbuf_release(&full_path);
@@ -1679,7 +1681,7 @@ int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
 	assert(failure_errno);
 	if (!strcmp(refname, "FETCH_HEAD") || !strcmp(refname, "MERGE_HEAD")) {
 		return refs_read_special_head(ref_store, refname, oid, referent,
-					      type);
+					      type, failure_errno);
 	}
 
 	return ref_store->be->read_raw_ref(ref_store, refname, oid, referent,
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 25bb225d92a..45d7c346dea 100644
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
index 54f57c6a2df..bf581e70cf6 100644
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
2.32.0.874.gfa1990a4f10

