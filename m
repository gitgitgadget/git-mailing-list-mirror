Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BAAC433F5
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 09:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4918A6108E
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 09:39:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243988AbhJPJly (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Oct 2021 05:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244013AbhJPJlu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Oct 2021 05:41:50 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B63C06176E
        for <git@vger.kernel.org>; Sat, 16 Oct 2021 02:39:34 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id n40-20020a05600c3ba800b0030da2439b21so4958232wms.0
        for <git@vger.kernel.org>; Sat, 16 Oct 2021 02:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Za+FYkUyZbhvl2mb1QyuVCyVvHBId7fHHzDzgdX7ePQ=;
        b=NblJJE5NirJ/2OsEd4Ve60vVqe2rKBrWGGzE2K3L1Y9XmV8VMoGin78fiCnFqcPONP
         Yg4dVyY9uw5AiMcC5EZK4gjpFu2JQFnGwJNPbzUpKvktZj+XOey/cTcQzoPfcXCzbOgH
         fco+kuFEEgP2cBkjCIe3lnKXdmFMUNBFDdmlMrdV/QifEPQzTpF5w1WX9ZeoCjwaek4p
         GwnO+H5NtC3Uy3L0xT/gjv87wZVeMWTuQTU7OY1rTuYt5YhsZlE/2qOUS7eu1lbchQyq
         ynd5kHN/Gm84C80JKQCa+4PFzroOEVB8MIAhax7vOewXd5LL1SpzQ9Pz7L21/M8RdbW3
         rpDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Za+FYkUyZbhvl2mb1QyuVCyVvHBId7fHHzDzgdX7ePQ=;
        b=xl/ds68MPA0aqICmU1Z9dreUdEm+XmcC5Ha2toN50/qt4Bb7vjVMmddYAMBDQf/7Dk
         mZWLgceWX8wRlpY5pu066n4Qs7r+AyNglAvUcKODueYRcEO/sGXVWfpp2h0wURzGd6/E
         hbibJIQR8t4BO9hW6hHojTMb3QyoqqjRtnmJvheOkkqROAHXFDKbIF99+4NnX/dwhRwC
         9aYaE1u8ppJJGfuQv+4pbyPskoPP2JhZ4T4mBLGk9h6w/pb/Gdd5zAe8Qngjz9CXtPEy
         nadNOgtqHcZBXdZZ/T2jebzRGUHXP74gawKvS0AfdDkg2W7FkxvSw+P9VJule3NSborY
         5UbQ==
X-Gm-Message-State: AOAM531zmsewAslm2mVRJN6CvVjNyuVr9P9sSUh9t9R97CK6miwLnUwd
        N6P5ED4toJg5PBPlO173vgPKUrPgMOP+SQ==
X-Google-Smtp-Source: ABdhPJzje/pq8+Fz4SNgk0xCORwlpXB6xmXCRyPWwQFN0qewoD8AHvx1RaAwiGbC2KCNqsAYYa9jWg==
X-Received: by 2002:a1c:770b:: with SMTP id t11mr31951150wmi.19.1634377173053;
        Sat, 16 Oct 2021 02:39:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k22sm6993492wrd.59.2021.10.16.02.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 02:39:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 04/21] refs API: make parse_loose_ref_contents() not set errno
Date:   Sat, 16 Oct 2021 11:39:10 +0200
Message-Id: <patch-v2-04.21-988bf62b3f2-20211016T093845Z-avarab@gmail.com>
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

Change the parse_loose_ref_contents() function to stop setting "errno"
and failure, and to instead pass up a "failure_errno" via a
parameter. This requires changing its callers to do the same.

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
 refs/files-backend.c | 31 ++++++++++++++++++++-----------
 refs/refs-internal.h |  6 ++++--
 3 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/refs.c b/refs.c
index 200c44e6963..bb09993c2f9 100644
--- a/refs.c
+++ b/refs.c
@@ -1648,7 +1648,8 @@ int for_each_fullref_in_prefixes(const char *namespace,
 
 static int refs_read_special_head(struct ref_store *ref_store,
 				  const char *refname, struct object_id *oid,
-				  struct strbuf *referent, unsigned int *type)
+				  struct strbuf *referent, unsigned int *type,
+				  int *failure_errno)
 {
 	struct strbuf full_path = STRBUF_INIT;
 	struct strbuf content = STRBUF_INIT;
@@ -1658,7 +1659,8 @@ static int refs_read_special_head(struct ref_store *ref_store,
 	if (strbuf_read_file(&content, full_path.buf, 0) < 0)
 		goto done;
 
-	result = parse_loose_ref_contents(content.buf, oid, referent, type);
+	result = parse_loose_ref_contents(content.buf, oid, referent, type,
+					  failure_errno);
 
 done:
 	strbuf_release(&full_path);
@@ -1673,7 +1675,7 @@ int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
 	assert(failure_errno);
 	if (!strcmp(refname, "FETCH_HEAD") || !strcmp(refname, "MERGE_HEAD")) {
 		return refs_read_special_head(ref_store, refname, oid, referent,
-					      type);
+					      type, failure_errno);
 	}
 
 	return ref_store->be->read_raw_ref(ref_store, refname, oid, referent,
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 94c194665ed..c73ffd1ca33 100644
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
@@ -448,26 +454,29 @@ static int files_read_raw_ref(struct ref_store *ref_store, const char *refname,
 	}
 	strbuf_reset(&sb_contents);
 	if (strbuf_read(&sb_contents, fd, 256) < 0) {
-		int save_errno = errno;
+		myerr = errno;
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
@@ -486,7 +495,7 @@ int parse_loose_ref_contents(const char *buf, struct object_id *oid,
 	if (parse_oid_hex(buf, oid, &p) ||
 	    (*p != '\0' && !isspace(*p))) {
 		*type |= REF_ISBROKEN;
-		errno = EINVAL;
+		*failure_errno = EINVAL;
 		return -1;
 	}
 	return 0;
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index c87f1135e5b..121b8fdad08 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -706,10 +706,12 @@ struct ref_store {
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
2.33.1.1338.g20da966911a

