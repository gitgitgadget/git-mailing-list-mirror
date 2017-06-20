Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88D6320D1F
	for <e@80x24.org>; Tue, 20 Jun 2017 19:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752081AbdFTTUf (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 15:20:35 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:33330 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752056AbdFTTU2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 15:20:28 -0400
Received: by mail-pg0-f53.google.com with SMTP id f185so66732953pgc.0
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 12:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JlP/W9UQc9pQSEiU/SpP+cao5HgyLfbr/6LdK199NAI=;
        b=XRUM/vL51ELBK4/Swn79oBlxbuUp8MSEDgTw2mTYbUWoxSwe+jSVFOxPLG0FXdnIjj
         VcJ7iF7PXEJbtiz2/M8zsQ3NWVipiZPBsKyJv4pq/Z5Qp0cYXi7jE6wPuxwDL4EXXz00
         6TheRLb/QTAFtUPUx4Vua4F0SwkiNvqNfgAdJ2b5dJh5eMuQptFgqfmUvkXAHCp7aWz7
         BfYSkG6oVjwCSghggqcuD9pgQUE+paTvFay8PtOowKyn3G4ll+YY/ztRGNyE4EJ9Y/ny
         UwBcbew8DBLmlyIdHyBgFRlExJkaXE5Z1Oid5qZ8rrqL5HXEtvl0q8I6kjnAudDkdxTR
         uWzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JlP/W9UQc9pQSEiU/SpP+cao5HgyLfbr/6LdK199NAI=;
        b=Ng0nDMZ0hcRE3ibwb1QmcCfqW7qFPEt7IyIZLOKnZrZ9PqNjrgLAnfrX6XUh4r/9aY
         hWEe6AKh9KjvAm7HD5durq1VFPukXWDs+mNRcKENRhAH8EfBqBM2Vtnfc7U9Cm1y5myE
         zAD8wFYJ5oy75gnBDFpLlcbQCAZF/L+FnM776jtJYfg1cWYITEBRYdr3jQ/+wz7EDuO+
         PJNQU2ZiEmoWtz76PjulSdFAp2yl6xNSFZBs8SjOwr1GJM31e1G+a6mk6Ft9mlFySukn
         CZZ0og0jXYkcxs//I3cAml9viHUbOoGvdvmxYfgiCP3hPB8NAJgT11uxleWhX4tZdz12
         1MsQ==
X-Gm-Message-State: AKS2vOzjj+FGEcnr4QLkwQGVkGr2BBey0VZY64xyZyH5MMgZWAwGC81J
        rwzd4UtVJHect4Gv1Bc3UQ==
X-Received: by 10.84.137.165 with SMTP id 34mr36962682pln.167.1497986427238;
        Tue, 20 Jun 2017 12:20:27 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id t6sm18680500pgs.33.2017.06.20.12.20.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 12:20:26 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 10/20] path: convert do_git_path to take a 'struct repository'
Date:   Tue, 20 Jun 2017 12:19:41 -0700
Message-Id: <20170620191951.84791-11-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1-goog
In-Reply-To: <20170620191951.84791-1-bmwill@google.com>
References: <20170608234100.188529-1-bmwill@google.com>
 <20170620191951.84791-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preparation to adding 'git_path' like functions which operate on a
'struct repository' convert 'do_git_path' to take a 'struct repository'.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 path.c | 42 ++++++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/path.c b/path.c
index 9be6804a9..76a872297 100644
--- a/path.c
+++ b/path.c
@@ -371,33 +371,47 @@ void report_linked_checkout_garbage(void)
 	strbuf_release(&sb);
 }
 
-static void adjust_git_path(struct strbuf *buf, int git_dir_len)
+static void adjust_git_path(const struct repository *repo,
+			    struct strbuf *buf, int git_dir_len)
 {
 	const char *base = buf->buf + git_dir_len;
 	if (is_dir_file(base, "info", "grafts"))
 		strbuf_splice(buf, 0, buf->len,
-			      get_graft_file(), strlen(get_graft_file()));
+			      repo->graft_file, strlen(repo->graft_file));
 	else if (!strcmp(base, "index"))
 		strbuf_splice(buf, 0, buf->len,
-			      get_index_file(), strlen(get_index_file()));
+			      repo->index_file, strlen(repo->index_file));
 	else if (dir_prefix(base, "objects"))
-		replace_dir(buf, git_dir_len + 7, get_object_directory());
+		replace_dir(buf, git_dir_len + 7, repo->objectdir);
 	else if (git_hooks_path && dir_prefix(base, "hooks"))
 		replace_dir(buf, git_dir_len + 5, git_hooks_path);
-	else if (the_repository->different_commondir)
-		update_common_dir(buf, git_dir_len, get_git_common_dir());
+	else if (repo->different_commondir)
+		update_common_dir(buf, git_dir_len, repo->commondir);
 }
 
-static void do_git_path(const struct worktree *wt, struct strbuf *buf,
+static void strbuf_worktree_gitdir(struct strbuf *buf,
+				   const struct repository *repo,
+				   const struct worktree *wt)
+{
+	if (!wt)
+		strbuf_addstr(buf, repo->gitdir);
+	else if (!wt->id)
+		strbuf_addstr(buf, repo->commondir);
+	else
+		strbuf_git_common_path(buf, repo, "worktrees/%s", wt->id);
+}
+
+static void do_git_path(const struct repository *repo,
+			const struct worktree *wt, struct strbuf *buf,
 			const char *fmt, va_list args)
 {
 	int gitdir_len;
-	strbuf_addstr(buf, get_worktree_git_dir(wt));
+	strbuf_worktree_gitdir(buf, repo, wt);
 	if (buf->len && !is_dir_sep(buf->buf[buf->len - 1]))
 		strbuf_addch(buf, '/');
 	gitdir_len = buf->len;
 	strbuf_vaddf(buf, fmt, args);
-	adjust_git_path(buf, gitdir_len);
+	adjust_git_path(repo, buf, gitdir_len);
 	strbuf_cleanup_path(buf);
 }
 
@@ -406,7 +420,7 @@ char *git_path_buf(struct strbuf *buf, const char *fmt, ...)
 	va_list args;
 	strbuf_reset(buf);
 	va_start(args, fmt);
-	do_git_path(NULL, buf, fmt, args);
+	do_git_path(the_repository, NULL, buf, fmt, args);
 	va_end(args);
 	return buf->buf;
 }
@@ -415,7 +429,7 @@ void strbuf_git_path(struct strbuf *sb, const char *fmt, ...)
 {
 	va_list args;
 	va_start(args, fmt);
-	do_git_path(NULL, sb, fmt, args);
+	do_git_path(the_repository, NULL, sb, fmt, args);
 	va_end(args);
 }
 
@@ -424,7 +438,7 @@ const char *git_path(const char *fmt, ...)
 	struct strbuf *pathname = get_pathname();
 	va_list args;
 	va_start(args, fmt);
-	do_git_path(NULL, pathname, fmt, args);
+	do_git_path(the_repository, NULL, pathname, fmt, args);
 	va_end(args);
 	return pathname->buf;
 }
@@ -434,7 +448,7 @@ char *git_pathdup(const char *fmt, ...)
 	struct strbuf path = STRBUF_INIT;
 	va_list args;
 	va_start(args, fmt);
-	do_git_path(NULL, &path, fmt, args);
+	do_git_path(the_repository, NULL, &path, fmt, args);
 	va_end(args);
 	return strbuf_detach(&path, NULL);
 }
@@ -465,7 +479,7 @@ const char *worktree_git_path(const struct worktree *wt, const char *fmt, ...)
 	struct strbuf *pathname = get_pathname();
 	va_list args;
 	va_start(args, fmt);
-	do_git_path(wt, pathname, fmt, args);
+	do_git_path(the_repository, wt, pathname, fmt, args);
 	va_end(args);
 	return pathname->buf;
 }
-- 
2.13.1.611.g7e3b11ae1-goog

