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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557D3C07E95
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 14:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38A0D613F2
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 14:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbhGPOZj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 10:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232990AbhGPOZe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 10:25:34 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7934AC061760
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 07:22:37 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id d12so12262415wre.13
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 07:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wqbySUk+au2MN4TlNHME//yBXenwBCjbMsFq0YaE7O8=;
        b=Qjn8VEkO/nquX6DN9AimTthUdElmZoFI73mTrvPHn4RYmg2V7QuvUxgXkzCWNzpH4B
         +9CzpX4QnP+QafLC+5EcPGw6qj7yfhY8ZhzFyH5Ui6LtfmGzs4MJVZ0uJ+rektWytGqF
         mHDibI9AHP2Qwz2dvb9rS60YV49E4725kegxOyyT52cHgyIDPPeU6reLfcAd57w1xYFe
         riuySEc6qIFA8GHM2I5f6KTcWlFYd2cr5xgHQMXAY/P7i4qdYNBmeMHz0pM627sC4jIr
         k4DJvUDKyil/b/9vhJ1YxM3I7jGx+WOgmO25SMco8Ezkk73HosNUtJLo5XZyAGp5U/2M
         VhPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wqbySUk+au2MN4TlNHME//yBXenwBCjbMsFq0YaE7O8=;
        b=nEueyR9uxU3gcicfhZCc3v7h4rEfvia/PeaEZlOPReUf81A+4Eyo8nYkxTH16ACpaS
         fydfIW+xhDdDmVFmbnfmlKDwno9Fff4r4y0F2j5AUaGXq5Af8Ka/9qrwBNimNL8p0vEo
         FdwgOZ9okmQNWBzplxm5MMiVTzQkZ8TvBArHaO83gKLeaEQ2+D7c98lomhlcqDIxz5av
         mB7Cv18ePkU1VS2D4fqjZQ3FIjTN5qo9cSWoiIUdcdXbvfoBXaCihgclyDS5xOgr5C4H
         lZKBCbWS5pEsTcvkzIDz/whawNd/D+J2aVXhmJ+tXO5hVNZjV2qtGfJiGXCgoxc0Vf4J
         wvTA==
X-Gm-Message-State: AOAM5312KjX1d64yIVBkQax9PdqgLY85GNaWWHUx9By2EiP0E/geFrih
        KWBdZKdldcH906WYthouB8olCetPfHJDjw==
X-Google-Smtp-Source: ABdhPJyJX0V2e6QM58d3zQulw0wmPwsJHIsCNWjjcpLgKcRv6ab4PmX7OnFYnN0AUX7fIurGc/rsPg==
X-Received: by 2002:a5d:6189:: with SMTP id j9mr12963121wru.196.1626445355712;
        Fri, 16 Jul 2021 07:22:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z7sm7463236wmp.34.2021.07.16.07.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 07:22:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v8 1/7] refs file backend: move raceproof_create_file() here
Date:   Fri, 16 Jul 2021 16:22:26 +0200
Message-Id: <patch-1.7-ce1ca2cf30f-20210716T142032Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.874.gfa1990a4f10
In-Reply-To: <cover-0.7-00000000000-20210716T142032Z-avarab@gmail.com>
References: <cover-0.6-0000000000-20210714T114301Z-avarab@gmail.com> <cover-0.7-00000000000-20210716T142032Z-avarab@gmail.com>
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
index f233b440b22..ae766e18b4e 100644
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
index bd99bc570de..36af99af844 100644
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
2.32.0.874.gfa1990a4f10

