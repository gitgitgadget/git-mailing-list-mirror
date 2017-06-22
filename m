Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A97F81FA7B
	for <e@80x24.org>; Thu, 22 Jun 2017 18:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753700AbdFVSod (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 14:44:33 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:35957 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753683AbdFVSo3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 14:44:29 -0400
Received: by mail-pf0-f172.google.com with SMTP id q86so12533562pfl.3
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 11:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U1ffjvpobBhiauq/1bIJYsXpVT8C6umfRrSIPd3N0Mg=;
        b=Oz6mMVX4ipDbx1M5vvcIH3pINOALagWz5obMY7tHnAdbJ1Bz+jO+im7eW9Yxp8T1oh
         kE8etBUwlsJ3hjlTPCBi+u3/FMubAD7SthemAlQmD/TM9qWj7b4yeavAQwS81mCSNL7x
         Vj5Muef/LdygzKzjzPgaGzHMuhY5yvIU/tXg7du2GxiQZ8Fw9vZBdVIi/Tox83OYpyi3
         kWs8Qa37jV/xibDNiYzIJh3EmGQ2eRrtKqpTd/SN1kIA8NOYXpKXkFZkgQEH7PeBS2UV
         dmRU1Rf/aXjlSdJ+iqIcToucUnS8GQwp6u+0AdItfDUgfLYuGfjQMBTbST1Ib28NZPWQ
         se7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U1ffjvpobBhiauq/1bIJYsXpVT8C6umfRrSIPd3N0Mg=;
        b=gdJbnYTFVKXuaKSrjcCDlUD/V2YehT8aE+T6EWFGYXIX2b5gFKIYliTnJzsZZS8JJX
         4Nk1f9F7CRBuV61q8QfXRpfFwvtcoM5PLYsacGW5KVv54hqNK7qkPyk0lv4IX52PETyc
         lLf4EnpY4ZiwXnRG4jEEu5IMYO6Eiyx2OrA/RYczyYDOTj28Ls2ZMCxc5RTzMnbFAGaB
         U2iKsZI0PJ906m0V+TKaIyHGiU+l42e+l2mvbClLBsT0O70FJtffWKIG0NNjkIfZjjE/
         DCgxRP6Cnjc8mnVBp+r5M9Ef/4Qq64sPZSFfU+FnREjLfBmLR9hDdQNFpdpQ3T4C78gD
         bPfA==
X-Gm-Message-State: AKS2vOw+YV4Ni/kZkcgiifXKWjP5R7BKEX4EihQxNPjRAGlYNevMgUil
        DQ+mV9JWh0D92kMi0Zk3Ng==
X-Received: by 10.98.77.134 with SMTP id a128mr4036750pfb.119.1498157058237;
        Thu, 22 Jun 2017 11:44:18 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id g78sm5222211pfb.122.2017.06.22.11.44.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 11:44:16 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v4 10/20] path: convert do_git_path to take a 'struct repository'
Date:   Thu, 22 Jun 2017 11:43:38 -0700
Message-Id: <20170622184348.56497-11-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.704.gde00cce3c-goog
In-Reply-To: <20170622184348.56497-1-bmwill@google.com>
References: <20170620191951.84791-1-bmwill@google.com>
 <20170622184348.56497-1-bmwill@google.com>
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
2.13.1.704.gde00cce3c-goog

