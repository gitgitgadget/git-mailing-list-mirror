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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCDBC433E0
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 23:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CDE4206ED
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 23:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730818AbhAQXoz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Jan 2021 18:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730773AbhAQXo3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jan 2021 18:44:29 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964E8C061574
        for <git@vger.kernel.org>; Sun, 17 Jan 2021 15:43:48 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id r12so9873049ejb.9
        for <git@vger.kernel.org>; Sun, 17 Jan 2021 15:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XJ7/M5veml/bhfAyzkj6s4ZZQ11MxuUob48zFnDpZg4=;
        b=Gj3fuiugaSjHxoEihVjk2wqlYIzZNUSM2VA0IQvSlFkcnxvmzudkA4oF03k14w9f25
         xAZ9CH5zFP1uA/Y4EtAlNzF1It43VoKTtaEmFq+bsT77Hf3R+jtpjy2U7GpluB3KWIiP
         traGcBZcuJ5PZxr7k/mZHJAwgQjhTqwBYozv3FIwmx51K5c5DyY31+YRidx+mtCqZFyO
         SXtE4gR065neiJoux6hYM+v1vZUJIpln2nltPyn0pZuqlXVOmwu9BD+e4ay9/T7PTAQd
         eCTsMZc6hfi/F4KdKTfZUF0Wb9z2JW2L069f9DKvSTvmYdTo6aBAoKoVmCXXSFWGZ06B
         TTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XJ7/M5veml/bhfAyzkj6s4ZZQ11MxuUob48zFnDpZg4=;
        b=cbMx5Z++X7R/6hphQFMtxxefUinP4sYJa6gFFpg36C0X3HqPwom40uNM8YmkdMLpJ9
         UlFtN5empT/GpD7o96b1oOmkGujIKjB5gpF2xnknNdlx77TsBKYA1boJeswpySUKkRVV
         PY7jF48CyicYq5f3IAT+z1tlBLK14816iwmrZgt57MhpMUvgmIn+sNcUUYhAGx1uVQtN
         yrM0fHzHGMfxHI67SVDTRtjssi9KWKMNFsT/Z90r8JbK0gzBTEues9iLC+IuoRjhYgQ/
         PMNZ+eH3BmQo+1t/CZ1y+yWas0edcd3GGfe0T36dI1sJA4gxDw4MNprSVAfrd2BFC0bt
         s4hw==
X-Gm-Message-State: AOAM5316E7rTvGPoT4e5VFCPMmuYFQOhH5Te5jwFLD+1UBZONuW4oxjD
        kqDH4EqcMN+nGc660vecM9++CBhYB2c=
X-Google-Smtp-Source: ABdhPJzkO1JIl+2bSIJUUoFMIYjbE8ozQ1H1UQxQgoGOppE2rgODtHVp2Ig3zQtouBSbEt5IegNCpw==
X-Received: by 2002:a17:906:369a:: with SMTP id a26mr14989498ejc.276.1610927026954;
        Sun, 17 Jan 2021 15:43:46 -0800 (PST)
Received: from localhost.localdomain ([79.140.114.246])
        by smtp.gmail.com with ESMTPSA id f13sm8639932ejf.42.2021.01.17.15.43.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jan 2021 15:43:46 -0800 (PST)
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: [PATCH v2 1/6] worktree: libify should_prune_worktree()
Date:   Mon, 18 Jan 2021 00:42:39 +0100
Message-Id: <20210117234244.95106-2-rafaeloliveira.cs@gmail.com>
X-Mailer: git-send-email 2.30.0.372.gbc7e965391
In-Reply-To: <20210117234244.95106-1-rafaeloliveira.cs@gmail.com>
References: <20210104162128.95281-1-rafaeloliveira.cs@gmail.com>
 <20210117234244.95106-1-rafaeloliveira.cs@gmail.com>
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
2.30.0.372.gbc7e965391

