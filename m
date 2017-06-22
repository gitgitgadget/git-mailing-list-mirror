Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A8571FA7B
	for <e@80x24.org>; Thu, 22 Jun 2017 18:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753626AbdFVSoS (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 14:44:18 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35950 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753609AbdFVSoR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 14:44:17 -0400
Received: by mail-pf0-f179.google.com with SMTP id q86so12533237pfl.3
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 11:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kDDQbTe7QVFANIkBtK3z+kEvypa2IfCfrUDgqrOYkCk=;
        b=JzFghio/vtRuBA2X0sa/NjcUdyvNHjzpG19T85UWuTrKonj3CAMnYBuCKAx8YhtMbM
         nMVuhYZ8f/0TO+4hyJTSJhzbWTK7WZtBEyNOhtjs7fXgJSAZAbQXo2W7WtqV5mUCE112
         DddpkqWOlXVsXpXlToG1Uk1p4y0SBBn7ZGKEgFHCN6uBSfzCPXuoB87cqqRv3BFqlURK
         o+ytap+cYEt5taRRQVZ9OUyeDhVmCftafEv3n1oxHervRuNjVNWqGKiZyUyd/kgF5/jG
         LI9TIqKzAKyGCGEJm34yIXoaxyFkOs6uJAtMoXisml/AsvmdDGUs5CZDO8VQ4C/QNSir
         jAfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kDDQbTe7QVFANIkBtK3z+kEvypa2IfCfrUDgqrOYkCk=;
        b=dQI43Jhr7DeDX1u9kiLDZxof1+5RWu+B4NzHhObiBKK+JvdkseIOBwOnmnnu2pE1Y1
         lJuSRY+klGsrSQ3n48aLdHxO1eg5GHwPVH58AMNTGwPJeecFckU2ifpmeFXD1qGFW4qS
         SEjkI5eNR2su39AyvDefWqgMIrkECGsn6p2quwYKEL0AH0ry9WO+W/dGPb/fu8EavF+5
         lB0fpVTflu92IcrA6e+bfnHyDoS3XTyCvLR9SLxxSmjAUUU2qmxDVOgjz9oPxwO3aqom
         j42mippcPnXfH8QbbpumJriKN0ddPYGFyF+cbt/73vHs2WbdyALn+c2xR1YfAM7IDe76
         fbDg==
X-Gm-Message-State: AKS2vOwAG8sXp9QIyjc6ktQG6Zm8VIY281xi/R45BpKGRF3pqObBHO86
        ziSAE/jpqU4qe7yn73AS+Q==
X-Received: by 10.84.128.68 with SMTP id 62mr4533246pla.184.1498157056096;
        Thu, 22 Jun 2017 11:44:16 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id g78sm5222211pfb.122.2017.06.22.11.44.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 11:44:15 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v4 09/20] path: convert strbuf_git_common_path to take a 'struct repository'
Date:   Thu, 22 Jun 2017 11:43:37 -0700
Message-Id: <20170622184348.56497-10-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.704.gde00cce3c-goog
In-Reply-To: <20170622184348.56497-1-bmwill@google.com>
References: <20170620191951.84791-1-bmwill@google.com>
 <20170622184348.56497-1-bmwill@google.com>
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
2.13.1.704.gde00cce3c-goog

