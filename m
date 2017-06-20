Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A79A720D1D
	for <e@80x24.org>; Tue, 20 Jun 2017 19:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752059AbdFTTU3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 15:20:29 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:33306 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751036AbdFTTU0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 15:20:26 -0400
Received: by mail-pf0-f182.google.com with SMTP id 83so73770687pfr.0
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 12:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6RJ52kGmFmlOnLR9qHr4janv6TDUuMtrBLOYsxImisg=;
        b=Vq/OcK0hPq94Rook+hppRKWxaUQMfjJV/1t7Ngp9OgzVf8NLkKFib/Oa3Zkuu4N/SU
         ccJtfvOS9PGQvGlloWljIf6Yoy6XS7wsUy3T+Z0XSPQgs4oXNvsU5rxim2mlE09R40ZZ
         NTek1iZDtI4dEVdY9LM/4yBG2KvRyRwMu0+EdcnXeAum7UPxrJ56ry77VF4JbZwRrX64
         DOgVJ+CffiBmzMw8/H+7U6XSiR1pT9WpLRI0KO1yv7iyRUI3GaM4pdSFmkizw9+eyqOP
         NjlLJTePz3DXbGd7M/OEBf0hn1KOT9dtsjv8rQdUfr/zH2wnz0OFA91uaxoc8hu99CDK
         ZPsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6RJ52kGmFmlOnLR9qHr4janv6TDUuMtrBLOYsxImisg=;
        b=GmsgWvqE+0yVvLregBpLmTSIBcs/E/PnSXZ2C9vpmLHoXOMZAbEPQU1O1FfQsFS+iM
         K6GUsAMvMDM8UXQChzGamuH+fRT4LTEickCIAbokgs9/L2udxP4HfwhaM4Jf6zEUstKS
         nghL4XYUOfjgluk9mQSW1/kuOswol45luUo0WA0y4/RTdKwaOInW8VfHFnnDVOQJDQHR
         uoqnHbq6dW6wxPeLtDz6kqYNEBD3egE872mCM9pTWL3uc9tA+AE5wgl6tBqhgK3wiEA/
         df/k4n4k3zuuLEC/5Cub/AHG1tmcOWrniU9bYksbSAgD4yzFJ4bY70I8bO0NfwJtmYWE
         aq1Q==
X-Gm-Message-State: AKS2vOzVmaU5J7p3Ec+oiu/YPmeVoz1PsVr00gTrs+soQF0SwyuGXFK4
        qDIfMHx159bFfzk+BV+Hrg==
X-Received: by 10.99.165.17 with SMTP id n17mr31606864pgf.163.1497986425668;
        Tue, 20 Jun 2017 12:20:25 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id t6sm18680500pgs.33.2017.06.20.12.20.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 12:20:24 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 09/20] path: convert strbuf_git_common_path to take a 'struct repository'
Date:   Tue, 20 Jun 2017 12:19:40 -0700
Message-Id: <20170620191951.84791-10-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1-goog
In-Reply-To: <20170620191951.84791-1-bmwill@google.com>
References: <20170608234100.188529-1-bmwill@google.com>
 <20170620191951.84791-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 path.c     | 13 ++++++++-----
 path.h     |  8 ++++++--
 worktree.c |  3 ++-
 3 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/path.c b/path.c
index 2434921d8..9be6804a9 100644
--- a/path.c
+++ b/path.c
@@ -524,11 +524,12 @@ int strbuf_git_path_submodule(struct strbuf *buf, const char *path,
 	return err;
 }
 
-static void do_git_common_path(struct strbuf *buf,
+static void do_git_common_path(const struct repository *repo,
+			       struct strbuf *buf,
 			       const char *fmt,
 			       va_list args)
 {
-	strbuf_addstr(buf, get_git_common_dir());
+	strbuf_addstr(buf, repo->commondir);
 	if (buf->len && !is_dir_sep(buf->buf[buf->len - 1]))
 		strbuf_addch(buf, '/');
 	strbuf_vaddf(buf, fmt, args);
@@ -540,16 +541,18 @@ const char *git_common_path(const char *fmt, ...)
 	struct strbuf *pathname = get_pathname();
 	va_list args;
 	va_start(args, fmt);
-	do_git_common_path(pathname, fmt, args);
+	do_git_common_path(the_repository, pathname, fmt, args);
 	va_end(args);
 	return pathname->buf;
 }
 
-void strbuf_git_common_path(struct strbuf *sb, const char *fmt, ...)
+void strbuf_git_common_path(struct strbuf *sb,
+			    const struct repository *repo,
+			    const char *fmt, ...)
 {
 	va_list args;
 	va_start(args, fmt);
-	do_git_common_path(sb, fmt, args);
+	do_git_common_path(repo, sb, fmt, args);
 	va_end(args);
 }
 
diff --git a/path.h b/path.h
index 522cd029b..568d63be5 100644
--- a/path.h
+++ b/path.h
@@ -1,6 +1,8 @@
 #ifndef PATH_H
 #define PATH_H
 
+struct repository;
+
 /*
  * Return a statically allocated filename, either generically (mkpath), in
  * the repository directory (git_path), or in a submodule's repository
@@ -17,8 +19,10 @@ extern char *mksnpath(char *buf, size_t n, const char *fmt, ...)
 	__attribute__((format (printf, 3, 4)));
 extern void strbuf_git_path(struct strbuf *sb, const char *fmt, ...)
 	__attribute__((format (printf, 2, 3)));
-extern void strbuf_git_common_path(struct strbuf *sb, const char *fmt, ...)
-	__attribute__((format (printf, 2, 3)));
+extern void strbuf_git_common_path(struct strbuf *sb,
+				   const struct repository *repo,
+				   const char *fmt, ...)
+	__attribute__((format (printf, 3, 4)));
 extern char *git_path_buf(struct strbuf *buf, const char *fmt, ...)
 	__attribute__((format (printf, 2, 3)));
 extern int strbuf_git_path_submodule(struct strbuf *sb, const char *path,
diff --git a/worktree.c b/worktree.c
index 2801c6d52..e28ffbeb0 100644
--- a/worktree.c
+++ b/worktree.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "repository.h"
 #include "refs.h"
 #include "strbuf.h"
 #include "worktree.h"
@@ -76,7 +77,7 @@ static struct worktree *get_linked_worktree(const char *id)
 	if (!id)
 		die("Missing linked worktree name");
 
-	strbuf_git_common_path(&path, "worktrees/%s/gitdir", id);
+	strbuf_git_common_path(&path, the_repository, "worktrees/%s/gitdir", id);
 	if (strbuf_read_file(&worktree_path, path.buf, 0) <= 0)
 		/* invalid gitdir file */
 		goto done;
-- 
2.13.1.611.g7e3b11ae1-goog

