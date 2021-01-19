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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6CDCC433E0
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 21:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A370322D08
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 21:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbhASV3S (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 16:29:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbhASV25 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 16:28:57 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF23C061573
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 13:28:17 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d26so21128451wrb.12
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 13:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LcLoWdyBRJser5fVuRzTvu6mdxMRojJEIbm/dV5XOBE=;
        b=RDTMcbQMFj62ETs38am1GM6r0I7RUAqSP9dj3YeLhMV1Fz+qaYPDlIINyib2239mOe
         gluqbjWKIG1SCjUypsentFimStjVCFcp5up3UcITishNm39brWI2IkPjRfW3TqurAOi6
         JcSzBxY2mi5hq6UsqP1t83ezVK1Y205IvFsy5T5xjEcrmzcJH2REpcS0yc3LQHKDlyX6
         EJhxQkPkmvF/x3ooLvUMv1DvxJ6uakMQz40suIgJp1T8sko1Sndg48aU+6oIMFOOnCbw
         QnHGhoaZjG4eCCZh3U28e1xk4Pl+CH96BpKs6627ZZ9xILMKDDIUkEIWBp0GOgt1/Lpg
         ZTLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LcLoWdyBRJser5fVuRzTvu6mdxMRojJEIbm/dV5XOBE=;
        b=alWR7kb5BME5fxF3SGpSue6EaZq1HmhgxAVdDjT48O3KSMQJHswbLeMtkhY/zFrU+/
         aZzcGy/P+nziBycI5IFUZGC+ROODWkZoP/RW7AtcWNVtDIxvN4e67OhOLncfVeqcjpnC
         ArPsc/06Z1VtF8XmWcAzltYebBOx0C5QFBBCQCobpIB3VyvzQoVfNj1KSMtWIK+2v88/
         wAMehEACBHbhKa38CEm11dyxkB6tC2qYdqJfDmt5HxglB63/G64nHgr2sxhCHqI+4ohB
         i6VaB06XgVlpvOTxBagxh0t0FFyjXDg5cGXA5ZD76blSYk0R/eXDmqDSp0lPfC0bPAEd
         9AmQ==
X-Gm-Message-State: AOAM53077f1c8q5sc5U5/+ZudjXoSmxE5upu3dhdqACANJE8HiR8GbcB
        eKY7IpFP5gHQF5EAr9QLSn018pTlq+Q=
X-Google-Smtp-Source: ABdhPJwcP1+xB0Nj8vjpWqgD8gKd6TGjJXhkU7wfK04TKcgPBAczvcbRHMNZLOUDCX+fgcIRwU3XvA==
X-Received: by 2002:a05:6000:124e:: with SMTP id j14mr6293938wrx.310.1611091695548;
        Tue, 19 Jan 2021 13:28:15 -0800 (PST)
Received: from localhost.localdomain ([212.86.35.161])
        by smtp.gmail.com with ESMTPSA id r2sm39448819wrn.83.2021.01.19.13.28.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jan 2021 13:28:14 -0800 (PST)
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: [PATCH v3 1/7] worktree: libify should_prune_worktree()
Date:   Tue, 19 Jan 2021 22:27:33 +0100
Message-Id: <20210119212739.77882-2-rafaeloliveira.cs@gmail.com>
X-Mailer: git-send-email 2.30.0.421.g32f838e276
In-Reply-To: <20210119212739.77882-1-rafaeloliveira.cs@gmail.com>
References: <20210117234244.95106-1-rafaeloliveira.cs@gmail.com>
 <20210119212739.77882-1-rafaeloliveira.cs@gmail.com>
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
2.30.0.421.g32f838e276

