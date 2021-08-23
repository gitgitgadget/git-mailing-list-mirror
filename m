Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C93C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 11:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AE526138E
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 11:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236802AbhHWLxx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 07:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236754AbhHWLxn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 07:53:43 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF99C061796
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 04:52:59 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id z4so10253206wrr.6
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 04:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yZU4BYN9oegfLYIv6gT1VoAXcVa2Tk1DqvY95ZR0pQQ=;
        b=tlMdlbDgHkaoHPykFOVZuNMF1YnkcpIsFImY6tKulCQBwEjGChJGeUVOGt2q1Xg5ZM
         TbAZ6ccWWRXJdLHEKCCTpm2ecnGE0Jogr7UIeVOHVV+Z7+zrqYxDrOg+6hiaecWqH09v
         8KdZE685UV9TgJWjYCm50b2ux3qSzrCjYI/UDLm/zpISfJ/Gqex6Lz4kQajOfqbwHXAN
         tjImKUsM0I0RaehgoJnCeEtkXgze+2zn4sELOYZ8+IlVspqtRXCM3Iy5xVsacsp0ir2+
         +EIYljZfI8AdzqAVC1V99+s1/zlzHbv2A4s07MUxk9qVSM+/WIfXmITCGKNeS7PHU8om
         fKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yZU4BYN9oegfLYIv6gT1VoAXcVa2Tk1DqvY95ZR0pQQ=;
        b=mdTpo/BRDUYm09/j7GrBPLocLrBh9eJdZ54ROSZ0qDQBSzUBN9AxGmrM1UeHw1qFYz
         M2IYev/ypvx/A/Gt3rgLPGc9D30rmhbn67UpWkC3TMRYCV5n2H6YF1fODfLZnxXTDHK1
         ulpAiTCC7hhxSbGYEvt1mMkFvV7fDbBbDK8F7xzISD9bAKuDXvJ4o5UhreCUoQxUo+7G
         Urq8MBEnS4GWoLgqZL4No/qLPZHWD0OuwibTLrpGPm3zJlk14Dzi7rFCLgZ/oIDtmwcS
         NutZNlhuw36rOqtBvUhzIlqXUGJdD5jEov6YvG86/8vP3WWj+FqdUel+SkWw/6Lyy+ar
         kOOg==
X-Gm-Message-State: AOAM531Xv+xxoav7MWqAG++uW2THv2PakwLzQKwzREUWDEPNSK8bTMeP
        ooDMZZPNASgmm6jrxq+QYkU92ABUfOd6Eivq
X-Google-Smtp-Source: ABdhPJzTJ4rJWcWMu+7RN/ggHc12hsA2P/ApBuC2wOKg9okRlMYfrzGr0vKvi2CoeWK8d1lZ321DKA==
X-Received: by 2002:adf:d4c7:: with SMTP id w7mr13261183wrk.301.1629719577791;
        Mon, 23 Aug 2021 04:52:57 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l2sm12350713wmi.1.2021.08.23.04.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 04:52:57 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v10 7/8] refs: explicitly return failure_errno from parse_loose_ref_contents
Date:   Mon, 23 Aug 2021 13:52:43 +0200
Message-Id: <patch-v10-7.8-18bf4a0e97c-20210823T114712Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.662.g438caf9576d
In-Reply-To: <cover-v10-0.8-00000000000-20210823T114712Z-avarab@gmail.com>
References: <cover-0.7-00000000000-20210720T102644Z-avarab@gmail.com> <cover-v10-0.8-00000000000-20210823T114712Z-avarab@gmail.com>
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
 refs/files-backend.c | 31 ++++++++++++++++++++-----------
 refs/refs-internal.h |  6 ++++--
 t/t3200-branch.sh    |  1 +
 4 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/refs.c b/refs.c
index 4c782fa2978..b83fd8c36b3 100644
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
index f962495e456..41efe5352b5 100644
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
index 7ade286260c..7a3a61ac22f 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -692,10 +692,12 @@ struct ref_store {
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
index 9fae13c2dea..63fbd71dc5c 100755
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
2.33.0.662.g438caf9576d

