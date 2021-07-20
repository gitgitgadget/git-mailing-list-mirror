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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28863C07E9B
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 10:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1102F610D2
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 10:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236973AbhGTJxc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 05:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237640AbhGTJw5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 05:52:57 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A372FC061762
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 03:33:35 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id n4so12008374wms.1
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 03:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4uz2KKn5sd/2X6wmQeTEAAQoEddd4k3jyWOUDlQXlFI=;
        b=d9ZHTEVSfA/VpvAQmJwHTH9RqX2cv8O9wGMlqVjIT1YTtbSPM4VAVKD72Bq0SYfbm0
         1x9AkUoicD2dV1IURoXkoRJqeq221/YK+HDX9bIhnU3rYUJxC8UHtVm3HUyoGVDm+Fp5
         tXHrzkQpvFmHyNZ2F+AvsbVRD6XuWBsdx5na4g14qnlk/DmlSndEfcG9EDtGzi/d1tlF
         cWchq4DAatAKQ/RTGuLzWClrKuH9WMMCe685F5eqZNP0fooOnYXhFAjyQN2Fg0JIZiDN
         Zehw5zyhgoIXX79GFnrErujyvnfjxVLSuzV6Vek2ohhpKX4XBWtnmVzn2GmaLy4SdXmD
         IAVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4uz2KKn5sd/2X6wmQeTEAAQoEddd4k3jyWOUDlQXlFI=;
        b=MbK3vNfSfrL8l2MPmAdBeRQKJikSDA3OaQKo1O7tfz0OOWY5O5jIB6ZnEZpzyqM1+N
         v9HC2HMC+h8WLatCeQU0S9P/dssqtuLBq0XK+9sVhFdQ6Yll/GvouIiymTWrgySy9ft7
         KDyMNlGr10pUemwJFE7GeeKgGv0igNtaN2Iyj4nkIJn0odzmPiE4Ns2z6HWzus3jeyaV
         fz9f+Ort5RTbf/LnjCGNoHr6vGOA9LJ80fFBBSeh1q8p0Bn11hJmEs1o9RvUSXRhbj8s
         YxQQkRBLiECJg9tSIEAtHqsJ+mEARYrrOoNTBBQyNihFZwD1VR8XkvmTiLxKEAPydeWE
         8bfg==
X-Gm-Message-State: AOAM533ay81kcFA/qt1ybokA0+Qj5W5dvyvRs09QfxuUlvCMSul5jRRM
        udzdHVfP2ZYGXcA2JgnjAyM8DrcOjYhSIg==
X-Google-Smtp-Source: ABdhPJwLfTczEwPqSSgobvaNl351Z4Ie2h1Mf5BeCh8EcinEThLxML/xt9U3Y69u1U1h6xuL1/3mXw==
X-Received: by 2002:a1c:9d16:: with SMTP id g22mr30732154wme.152.1626777213965;
        Tue, 20 Jul 2021 03:33:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l14sm22179852wrs.22.2021.07.20.03.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 03:33:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v9 1/7] refs file backend: move raceproof_create_file() here
Date:   Tue, 20 Jul 2021 12:33:24 +0200
Message-Id: <patch-1.7-b7063c5af89-20210720T102644Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.874.ge7a9d58bfcf
In-Reply-To: <cover-0.7-00000000000-20210720T102644Z-avarab@gmail.com>
References: <cover-0.7-00000000000-20210716T142032Z-avarab@gmail.com> <cover-0.7-00000000000-20210720T102644Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the raceproof_create_file() API added to cache.h and
object-file.c in 177978f56ad (raceproof_create_file(): new function,
2017-01-06) to its only user, refs/files-backend.c.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 cache.h              |  43 -----------------
 object-file.c        |  68 ---------------------------
 refs/files-backend.c | 109 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 109 insertions(+), 111 deletions(-)

diff --git a/cache.h b/cache.h
index ba04ff8bd36..eb4dfe6381f 100644
--- a/cache.h
+++ b/cache.h
@@ -1202,49 +1202,6 @@ enum scld_error safe_create_leading_directories(char *path);
 enum scld_error safe_create_leading_directories_const(const char *path);
 enum scld_error safe_create_leading_directories_no_share(char *path);
 
-/*
- * Callback function for raceproof_create_file(). This function is
- * expected to do something that makes dirname(path) permanent despite
- * the fact that other processes might be cleaning up empty
- * directories at the same time. Usually it will create a file named
- * path, but alternatively it could create another file in that
- * directory, or even chdir() into that directory. The function should
- * return 0 if the action was completed successfully. On error, it
- * should return a nonzero result and set errno.
- * raceproof_create_file() treats two errno values specially:
- *
- * - ENOENT -- dirname(path) does not exist. In this case,
- *             raceproof_create_file() tries creating dirname(path)
- *             (and any parent directories, if necessary) and calls
- *             the function again.
- *
- * - EISDIR -- the file already exists and is a directory. In this
- *             case, raceproof_create_file() removes the directory if
- *             it is empty (and recursively any empty directories that
- *             it contains) and calls the function again.
- *
- * Any other errno causes raceproof_create_file() to fail with the
- * callback's return value and errno.
- *
- * Obviously, this function should be OK with being called again if it
- * fails with ENOENT or EISDIR. In other scenarios it will not be
- * called again.
- */
-typedef int create_file_fn(const char *path, void *cb);
-
-/*
- * Create a file in dirname(path) by calling fn, creating leading
- * directories if necessary. Retry a few times in case we are racing
- * with another process that is trying to clean up the directory that
- * contains path. See the documentation for create_file_fn for more
- * details.
- *
- * Return the value and set the errno that resulted from the most
- * recent call of fn. fn is always called at least once, and will be
- * called more than once if it returns ENOENT or EISDIR.
- */
-int raceproof_create_file(const char *path, create_file_fn fn, void *cb);
-
 int mkdir_in_gitdir(const char *path);
 char *expand_user_path(const char *path, int real_home);
 const char *enter_repo(const char *path, int strict);
diff --git a/object-file.c b/object-file.c
index ecca5a8da00..231a02997ba 100644
--- a/object-file.c
+++ b/object-file.c
@@ -414,74 +414,6 @@ enum scld_error safe_create_leading_directories_const(const char *path)
 	return result;
 }
 
-int raceproof_create_file(const char *path, create_file_fn fn, void *cb)
-{
-	/*
-	 * The number of times we will try to remove empty directories
-	 * in the way of path. This is only 1 because if another
-	 * process is racily creating directories that conflict with
-	 * us, we don't want to fight against them.
-	 */
-	int remove_directories_remaining = 1;
-
-	/*
-	 * The number of times that we will try to create the
-	 * directories containing path. We are willing to attempt this
-	 * more than once, because another process could be trying to
-	 * clean up empty directories at the same time as we are
-	 * trying to create them.
-	 */
-	int create_directories_remaining = 3;
-
-	/* A scratch copy of path, filled lazily if we need it: */
-	struct strbuf path_copy = STRBUF_INIT;
-
-	int ret, save_errno;
-
-	/* Sanity check: */
-	assert(*path);
-
-retry_fn:
-	ret = fn(path, cb);
-	save_errno = errno;
-	if (!ret)
-		goto out;
-
-	if (errno == EISDIR && remove_directories_remaining-- > 0) {
-		/*
-		 * A directory is in the way. Maybe it is empty; try
-		 * to remove it:
-		 */
-		if (!path_copy.len)
-			strbuf_addstr(&path_copy, path);
-
-		if (!remove_dir_recursively(&path_copy, REMOVE_DIR_EMPTY_ONLY))
-			goto retry_fn;
-	} else if (errno == ENOENT && create_directories_remaining-- > 0) {
-		/*
-		 * Maybe the containing directory didn't exist, or
-		 * maybe it was just deleted by a process that is
-		 * racing with us to clean up empty directories. Try
-		 * to create it:
-		 */
-		enum scld_error scld_result;
-
-		if (!path_copy.len)
-			strbuf_addstr(&path_copy, path);
-
-		do {
-			scld_result = safe_create_leading_directories(path_copy.buf);
-			if (scld_result == SCLD_OK)
-				goto retry_fn;
-		} while (scld_result == SCLD_VANISHED && create_directories_remaining-- > 0);
-	}
-
-out:
-	strbuf_release(&path_copy);
-	errno = save_errno;
-	return ret;
-}
-
 static void fill_loose_path(struct strbuf *buf, const struct object_id *oid)
 {
 	int i;
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 443182da102..9fc596fc75a 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -852,6 +852,115 @@ static struct ref_iterator *files_ref_iterator_begin(
 	return ref_iterator;
 }
 
+/*
+ * Callback function for raceproof_create_file(). This function is
+ * expected to do something that makes dirname(path) permanent despite
+ * the fact that other processes might be cleaning up empty
+ * directories at the same time. Usually it will create a file named
+ * path, but alternatively it could create another file in that
+ * directory, or even chdir() into that directory. The function should
+ * return 0 if the action was completed successfully. On error, it
+ * should return a nonzero result and set errno.
+ * raceproof_create_file() treats two errno values specially:
+ *
+ * - ENOENT -- dirname(path) does not exist. In this case,
+ *             raceproof_create_file() tries creating dirname(path)
+ *             (and any parent directories, if necessary) and calls
+ *             the function again.
+ *
+ * - EISDIR -- the file already exists and is a directory. In this
+ *             case, raceproof_create_file() removes the directory if
+ *             it is empty (and recursively any empty directories that
+ *             it contains) and calls the function again.
+ *
+ * Any other errno causes raceproof_create_file() to fail with the
+ * callback's return value and errno.
+ *
+ * Obviously, this function should be OK with being called again if it
+ * fails with ENOENT or EISDIR. In other scenarios it will not be
+ * called again.
+ */
+typedef int create_file_fn(const char *path, void *cb);
+
+/*
+ * Create a file in dirname(path) by calling fn, creating leading
+ * directories if necessary. Retry a few times in case we are racing
+ * with another process that is trying to clean up the directory that
+ * contains path. See the documentation for create_file_fn for more
+ * details.
+ *
+ * Return the value and set the errno that resulted from the most
+ * recent call of fn. fn is always called at least once, and will be
+ * called more than once if it returns ENOENT or EISDIR.
+ */
+static int raceproof_create_file(const char *path, create_file_fn fn, void *cb)
+{
+	/*
+	 * The number of times we will try to remove empty directories
+	 * in the way of path. This is only 1 because if another
+	 * process is racily creating directories that conflict with
+	 * us, we don't want to fight against them.
+	 */
+	int remove_directories_remaining = 1;
+
+	/*
+	 * The number of times that we will try to create the
+	 * directories containing path. We are willing to attempt this
+	 * more than once, because another process could be trying to
+	 * clean up empty directories at the same time as we are
+	 * trying to create them.
+	 */
+	int create_directories_remaining = 3;
+
+	/* A scratch copy of path, filled lazily if we need it: */
+	struct strbuf path_copy = STRBUF_INIT;
+
+	int ret, save_errno;
+
+	/* Sanity check: */
+	assert(*path);
+
+retry_fn:
+	ret = fn(path, cb);
+	save_errno = errno;
+	if (!ret)
+		goto out;
+
+	if (errno == EISDIR && remove_directories_remaining-- > 0) {
+		/*
+		 * A directory is in the way. Maybe it is empty; try
+		 * to remove it:
+		 */
+		if (!path_copy.len)
+			strbuf_addstr(&path_copy, path);
+
+		if (!remove_dir_recursively(&path_copy, REMOVE_DIR_EMPTY_ONLY))
+			goto retry_fn;
+	} else if (errno == ENOENT && create_directories_remaining-- > 0) {
+		/*
+		 * Maybe the containing directory didn't exist, or
+		 * maybe it was just deleted by a process that is
+		 * racing with us to clean up empty directories. Try
+		 * to create it:
+		 */
+		enum scld_error scld_result;
+
+		if (!path_copy.len)
+			strbuf_addstr(&path_copy, path);
+
+		do {
+			scld_result = safe_create_leading_directories(path_copy.buf);
+			if (scld_result == SCLD_OK)
+				goto retry_fn;
+		} while (scld_result == SCLD_VANISHED && create_directories_remaining-- > 0);
+	}
+
+out:
+	strbuf_release(&path_copy);
+	errno = save_errno;
+	return ret;
+}
+
 static int remove_empty_directories(struct strbuf *path)
 {
 	/*
-- 
2.32.0.874.ge7a9d58bfcf

