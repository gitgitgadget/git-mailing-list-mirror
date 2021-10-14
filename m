Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C16BC433F5
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 00:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64D5461152
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 00:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbhJNAIr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 20:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbhJNAIn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 20:08:43 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CADC061749
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 17:06:39 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id o20so13858630wro.3
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 17:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RuCoCy3aAtEK5argRboSpqI+1CTSCPfqbTNlqC3tJg0=;
        b=bzchS8x4Ilti/g0+jPyben9okUfP40/ju4OeIXMiLC/xJF7cjh+W3lFUW26xocvMSt
         tBzkrPWzJBojUZFcpFJOjzwjlTX36vvKuqilBXox9z6MgtlSBNFD35j9NrJgx/rOJEFg
         nLJ433aGDkWznNIemC0MZeEBK7Ls4Dut9TyUqJ9RhcdRgi6Xz/2mNS3rs00RTUX0hZcH
         YCAwxPInaaTjGSdGY6QtYRo+tF9NPzsHOfw2ImGlikR7h1iQbVuAEZ3Hq+BbT21o3zGf
         o/Qg0qNftkd8/4kIiUjClIli5x4gDJ77ijusxdhf8ojsL2HQf+rYQx9WGTt4LwAJ4DXO
         LSzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RuCoCy3aAtEK5argRboSpqI+1CTSCPfqbTNlqC3tJg0=;
        b=P3tPDUGmVcMB65mC9KinXxxjj6CJ6wETOkVjho4E+WQ3ETNlopc186W/s9gkquuibH
         w9dqc8gvwkmqMyvVqcKlip+mysWa+t20Nqm1rRAvY3GneD22KG78JjJLX5VIK0+AikE+
         INHNQ7fQ9IOXtotOoDEyzaB6L4lgwpQ7R2a2a1jYrFK5WtrVAnFYD2bndmRfvK1v9qqe
         RE1H3UNOK5mZw+UrY+JgFn2K4eRoG+ZWjFTD1yoq7QU5QRWdaGMNKw6apZYU++V5f1Rh
         QjrsJJOageUVe8ucza0R2wVo9qRUrczAysr6FmXL9r3pxIqVFCq/0xcgGB22i8VPXfYC
         EEBw==
X-Gm-Message-State: AOAM532XbEOjfGvxTaKFT6pULBJ4AoRkcsGDCqGo71v4k1gr+4lKsThm
        zIZj5tbRfUtGgZtmCvYY9naExG0rnpC1cA==
X-Google-Smtp-Source: ABdhPJxKpQPX7ZNEFz9y9B09KAGVIH5Wf+kkVDHJXnK9qPfwSd9ZSWb76qFeo4DXlKDX4NiW7wfWcA==
X-Received: by 2002:a5d:45c9:: with SMTP id b9mr2592691wrs.365.1634169997505;
        Wed, 13 Oct 2021 17:06:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y8sm670711wmi.43.2021.10.13.17.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 17:06:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 04/20] refs API: make parse_loose_ref_contents() not set errno
Date:   Thu, 14 Oct 2021 02:06:16 +0200
Message-Id: <patch-04.20-758c761abcf-20211013T235900Z-avarab@gmail.com>
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
 t/t3200-branch.sh    |  1 +
 4 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/refs.c b/refs.c
index acc5d5fa578..b1640b5d582 100644
--- a/refs.c
+++ b/refs.c
@@ -1647,7 +1647,8 @@ int for_each_fullref_in_prefixes(const char *namespace,
 
 static int refs_read_special_head(struct ref_store *ref_store,
 				  const char *refname, struct object_id *oid,
-				  struct strbuf *referent, unsigned int *type)
+				  struct strbuf *referent, unsigned int *type,
+				  int *failure_errno)
 {
 	struct strbuf full_path = STRBUF_INIT;
 	struct strbuf content = STRBUF_INIT;
@@ -1657,7 +1658,8 @@ static int refs_read_special_head(struct ref_store *ref_store,
 	if (strbuf_read_file(&content, full_path.buf, 0) < 0)
 		goto done;
 
-	result = parse_loose_ref_contents(content.buf, oid, referent, type);
+	result = parse_loose_ref_contents(content.buf, oid, referent, type,
+					  failure_errno);
 
 done:
 	strbuf_release(&full_path);
@@ -1672,7 +1674,7 @@ int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
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
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index b5242719159..7486688d292 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -745,6 +745,7 @@ test_expect_success SYMLINKS 'git branch -m with symlinked .git/refs' '
 	) &&
 	git --git-dir subdir/.git/ branch rename-src &&
 	git rev-parse rename-src >expect &&
+	# Tests a BUG() assertion in files_read_raw_ref()
 	git --git-dir subdir/.git/ branch -m rename-src rename-dest &&
 	git rev-parse rename-dest >actual &&
 	test_cmp expect actual &&
-- 
2.33.1.1346.g48288c3c089

