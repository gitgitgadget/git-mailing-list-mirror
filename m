Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE729C433DB
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 08:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FD4B2073C
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 08:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234669AbhA0INJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 03:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbhA0IEi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jan 2021 03:04:38 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A56C061788
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 00:03:47 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id g10so916302wrx.1
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 00:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RWps2UGHtioDtdFBm/FT1zznV77nX9NKQHzWKzynpLI=;
        b=JpCMBxn3puw54gML5i6qdpQtRnquEUkHeaddiq7mLH+GPIptVYdeZQtJ/fNotTdPDP
         yoz9bewJ6G7u/w3xAFGrjSZLCHE4HLS112gD5hxCudlijWhq7r1pNnbk/ZwsDOf1Wi7n
         Ui83C7vZgOQLK7BjJ3mkL+WYGdJYUropcsOToV4sjRi5qBPfdFnLzv/3e4Xza7sPUfW3
         93nKhp9zATFKn04uPpAu8cdxwx12SY+HCE9uf0ji8jMX6qfyL+BjarEswj9J3SQtiOXT
         MBmxHOKqvSFWn63mMM6PRC4bI3tYWY/BEeYfTk3F68VclmyEh1TPkcRCZdLQlouh7kNL
         Q6ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RWps2UGHtioDtdFBm/FT1zznV77nX9NKQHzWKzynpLI=;
        b=n0kCVCLFlccm4UI1B3vjhRruo1rqgrk2gZgDzID1YRJFom8e88YRqWavUj5kmLMf6m
         Nb0zkrb0L+SrLwSX5EDoL7on6CcvK0H2U1zQ1ziEdvTfs4J8I9rEtb+pjv4KZwwdCo6J
         p7If+anDzZM3VWc1dYZ88jNgsOBi/w6UFjXjPJpLbuC1cPRv2pJY6tMQv8sZxnpZUza4
         jwJar6kGYfM7qYCIdEGCTO5Ig8ExbNvEnqKcB1+cra+YLg5IxmKeIErJrpRHr4ujEx4l
         E/lDxBKAlFCFtLb3fY+L9qggo44qbq5OiycpISU9WpgqAxXH2L22+7n8FFPPUsO3CBKn
         HuUg==
X-Gm-Message-State: AOAM530xlVKBe0XD2U1lJCNEGQd7ZaNmoc3gnHW9rA5qMDFiUcU/OIvC
        dqojt1PJDdO6sk9kevp3P7MzuR52P2ur3NQS
X-Google-Smtp-Source: ABdhPJzxPB6Wjq7ZUkDw2NyxAaS6JLVDAsI0qfVi+E3ZlsGcza88gBRzpkez1RMONkO3eLS9TEYlcw==
X-Received: by 2002:a5d:55c6:: with SMTP id i6mr10181098wrw.145.1611734625394;
        Wed, 27 Jan 2021 00:03:45 -0800 (PST)
Received: from localhost.localdomain ([79.140.115.116])
        by smtp.gmail.com with ESMTPSA id m8sm1850237wrv.37.2021.01.27.00.03.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jan 2021 00:03:44 -0800 (PST)
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: [PATCH v4 1/7] worktree: libify should_prune_worktree()
Date:   Wed, 27 Jan 2021 09:03:04 +0100
Message-Id: <20210127080310.89639-2-rafaeloliveira.cs@gmail.com>
X-Mailer: git-send-email 2.30.0.395.g7821b4e95a
In-Reply-To: <20210127080310.89639-1-rafaeloliveira.cs@gmail.com>
References: <20210119212739.77882-1-rafaeloliveira.cs@gmail.com>
 <20210127080310.89639-1-rafaeloliveira.cs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As part of teaching "git worktree list" to annotate worktree that is a
candidate for pruning, let's move should_prune_worktree() from
builtin/worktree.c to worktree.c in order to make part of the worktree
public API.

should_prune_worktree() knows how to select the given worktree for
pruning based on an expiration date, however the expiration value is
stored in a static file-scope variable and it is not local to the
function. In order to move the function, teach should_prune_worktree()
to take the expiration date as an argument and document the new
parameter that is not immediately obvious.

Also, change the function comment to clearly state that the worktree's
path is returned in `wtpath` argument.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Rafael Silva <rafaeloliveira.cs@gmail.com>
---
 builtin/worktree.c | 75 +---------------------------------------------
 worktree.c         | 68 +++++++++++++++++++++++++++++++++++++++++
 worktree.h         | 14 +++++++++
 3 files changed, 83 insertions(+), 74 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 71287b2da6..dd886d5029 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -67,79 +67,6 @@ static void delete_worktrees_dir_if_empty(void)
 	rmdir(git_path("worktrees")); /* ignore failed removal */
 }
 
-/*
- * Return true if worktree entry should be pruned, along with the reason for
- * pruning. Otherwise, return false and the worktree's path, or NULL if it
- * cannot be determined. Caller is responsible for freeing returned path.
- */
-static int should_prune_worktree(const char *id, struct strbuf *reason, char **wtpath)
-{
-	struct stat st;
-	char *path;
-	int fd;
-	size_t len;
-	ssize_t read_result;
-
-	*wtpath = NULL;
-	if (!is_directory(git_path("worktrees/%s", id))) {
-		strbuf_addstr(reason, _("not a valid directory"));
-		return 1;
-	}
-	if (file_exists(git_path("worktrees/%s/locked", id)))
-		return 0;
-	if (stat(git_path("worktrees/%s/gitdir", id), &st)) {
-		strbuf_addstr(reason, _("gitdir file does not exist"));
-		return 1;
-	}
-	fd = open(git_path("worktrees/%s/gitdir", id), O_RDONLY);
-	if (fd < 0) {
-		strbuf_addf(reason, _("unable to read gitdir file (%s)"),
-			    strerror(errno));
-		return 1;
-	}
-	len = xsize_t(st.st_size);
-	path = xmallocz(len);
-
-	read_result = read_in_full(fd, path, len);
-	if (read_result < 0) {
-		strbuf_addf(reason, _("unable to read gitdir file (%s)"),
-			    strerror(errno));
-		close(fd);
-		free(path);
-		return 1;
-	}
-	close(fd);
-
-	if (read_result != len) {
-		strbuf_addf(reason,
-			    _("short read (expected %"PRIuMAX" bytes, read %"PRIuMAX")"),
-			    (uintmax_t)len, (uintmax_t)read_result);
-		free(path);
-		return 1;
-	}
-	while (len && (path[len - 1] == '\n' || path[len - 1] == '\r'))
-		len--;
-	if (!len) {
-		strbuf_addstr(reason, _("invalid gitdir file"));
-		free(path);
-		return 1;
-	}
-	path[len] = '\0';
-	if (!file_exists(path)) {
-		if (stat(git_path("worktrees/%s/index", id), &st) ||
-		    st.st_mtime <= expire) {
-			strbuf_addstr(reason, _("gitdir file points to non-existent location"));
-			free(path);
-			return 1;
-		} else {
-			*wtpath = path;
-			return 0;
-		}
-	}
-	*wtpath = path;
-	return 0;
-}
-
 static void prune_worktree(const char *id, const char *reason)
 {
 	if (show_only || verbose)
@@ -195,7 +122,7 @@ static void prune_worktrees(void)
 		if (is_dot_or_dotdot(d->d_name))
 			continue;
 		strbuf_reset(&reason);
-		if (should_prune_worktree(d->d_name, &reason, &path))
+		if (should_prune_worktree(d->d_name, &reason, &path, expire))
 			prune_worktree(d->d_name, reason.buf);
 		else if (path)
 			string_list_append(&kept, path)->util = xstrdup(d->d_name);
diff --git a/worktree.c b/worktree.c
index 821b233479..8ae019af79 100644
--- a/worktree.c
+++ b/worktree.c
@@ -741,3 +741,71 @@ void repair_worktree_at_path(const char *path,
 	strbuf_release(&realdotgit);
 	strbuf_release(&dotgit);
 }
+
+int should_prune_worktree(const char *id, struct strbuf *reason, char **wtpath, timestamp_t expire)
+{
+	struct stat st;
+	char *path;
+	int fd;
+	size_t len;
+	ssize_t read_result;
+
+	*wtpath = NULL;
+	if (!is_directory(git_path("worktrees/%s", id))) {
+		strbuf_addstr(reason, _("not a valid directory"));
+		return 1;
+	}
+	if (file_exists(git_path("worktrees/%s/locked", id)))
+		return 0;
+	if (stat(git_path("worktrees/%s/gitdir", id), &st)) {
+		strbuf_addstr(reason, _("gitdir file does not exist"));
+		return 1;
+	}
+	fd = open(git_path("worktrees/%s/gitdir", id), O_RDONLY);
+	if (fd < 0) {
+		strbuf_addf(reason, _("unable to read gitdir file (%s)"),
+			    strerror(errno));
+		return 1;
+	}
+	len = xsize_t(st.st_size);
+	path = xmallocz(len);
+
+	read_result = read_in_full(fd, path, len);
+	if (read_result < 0) {
+		strbuf_addf(reason, _("unable to read gitdir file (%s)"),
+			    strerror(errno));
+		close(fd);
+		free(path);
+		return 1;
+	}
+	close(fd);
+
+	if (read_result != len) {
+		strbuf_addf(reason,
+			    _("short read (expected %"PRIuMAX" bytes, read %"PRIuMAX")"),
+			    (uintmax_t)len, (uintmax_t)read_result);
+		free(path);
+		return 1;
+	}
+	while (len && (path[len - 1] == '\n' || path[len - 1] == '\r'))
+		len--;
+	if (!len) {
+		strbuf_addstr(reason, _("invalid gitdir file"));
+		free(path);
+		return 1;
+	}
+	path[len] = '\0';
+	if (!file_exists(path)) {
+		if (stat(git_path("worktrees/%s/index", id), &st) ||
+		    st.st_mtime <= expire) {
+			strbuf_addstr(reason, _("gitdir file points to non-existent location"));
+			free(path);
+			return 1;
+		} else {
+			*wtpath = path;
+			return 0;
+		}
+	}
+	*wtpath = path;
+	return 0;
+}
diff --git a/worktree.h b/worktree.h
index f38e6fd5a2..818e1491c7 100644
--- a/worktree.h
+++ b/worktree.h
@@ -73,6 +73,20 @@ int is_main_worktree(const struct worktree *wt);
  */
 const char *worktree_lock_reason(struct worktree *wt);
 
+/*
+ * Return true if worktree entry should be pruned, along with the reason for
+ * pruning. Otherwise, return false and the worktree's path in `wtpath`, or
+ * NULL if it cannot be determined. Caller is responsible for freeing
+ * returned path.
+ *
+ * `expire` defines a grace period to prune the worktree when its path
+ * does not exist.
+ */
+int should_prune_worktree(const char *id,
+			  struct strbuf *reason,
+			  char **wtpath,
+			  timestamp_t expire);
+
 #define WT_VALIDATE_WORKTREE_MISSING_OK (1 << 0)
 
 /*
-- 
2.30.0.373.geade8fefe8

