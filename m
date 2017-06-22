Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 326BB1FA7B
	for <e@80x24.org>; Thu, 22 Jun 2017 18:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753669AbdFVSo2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 14:44:28 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:35553 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753641AbdFVSoY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 14:44:24 -0400
Received: by mail-pf0-f178.google.com with SMTP id c73so12562607pfk.2
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 11:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g0vBOc8Ol+Woh73l5kMNQYCjKut5LLNId1/g2nyD/L4=;
        b=ncGSi7jszrHFcFpMb7ccZS86Nxg5P45LYWUf/rMp3rbT/GqSNYqujOpXW4GnPYy85r
         WWRcUB3INn2Ck2u3PEIOpoJ+oJYeUB/W8pxWo2O1NBTPBlmo+i/OI34m701jBqLApUsg
         OYIdtuskIQAYrmC2aKEJBg+mkgAMcJX7ve2YTWy6eNfV/63d6yiWGszkZuK9To/htQcS
         bnrlCadgu90bSnw9KayCB20pvaQ959E+VJnfKLvXnZuT8CEANjCmAq3u9IHIwW5MIVAI
         jrOD14H5dpH/UF6ZRcy4s5paYslm/3M2P47W89Fvm6ngPNARDaMKTmNvlrBOFQCzghql
         Xi8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=g0vBOc8Ol+Woh73l5kMNQYCjKut5LLNId1/g2nyD/L4=;
        b=moyZglfyKPFc6NiesWql7BPYRe7FZ+oflPfKMsbl4zz77gdAjb1/XRM8BljXKY/A6p
         /hX0kHubMqwhn3fO+hHeGY0wBzOFtkss5Pxy+h8caZf+OyekH/oyQ9rkzxmEn5E5zxvF
         CP/AxkxUZLPBp1FJZaObDVRLKMznA8LOiL/CUqB4H08jCRDdeJ0rGJMhPvdi+HJqc3W0
         Ok0KyRvDI40R9p7Q/3d3Md66shn4gnONZDKV5FLiAdJitmKG+LhFO5WpNuTqiFamhDa1
         u2VhPwCs1RZffM+h8lllBlFF4kLfzga8lXjyuTRycwIH6Lg4mh6f+H0XjL1LJgyWDNGS
         qzNQ==
X-Gm-Message-State: AKS2vOxklCu4mNwuRJeHd6WmcXM9Wz3neSeQ5tCbx4ArH37fadS5aZkK
        QE4PJJ4skdDfE5MN+WgQMw==
X-Received: by 10.98.149.12 with SMTP id p12mr4130348pfd.174.1498157063343;
        Thu, 22 Jun 2017 11:44:23 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id g78sm5222211pfb.122.2017.06.22.11.44.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 11:44:22 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v4 13/20] path: add repo_worktree_path and strbuf_repo_worktree_path
Date:   Thu, 22 Jun 2017 11:43:41 -0700
Message-Id: <20170622184348.56497-14-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.704.gde00cce3c-goog
In-Reply-To: <20170622184348.56497-1-bmwill@google.com>
References: <20170620191951.84791-1-bmwill@google.com>
 <20170622184348.56497-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce 'repo_worktree_path' and 'strbuf_repo_worktree_path' which
take a repository struct and constructs a path relative to the
repository's worktree.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 path.c | 41 +++++++++++++++++++++++++++++++++++++++++
 path.h |  8 ++++++++
 2 files changed, 49 insertions(+)

diff --git a/path.c b/path.c
index ffc0f10fd..e485f9f93 100644
--- a/path.c
+++ b/path.c
@@ -506,6 +506,47 @@ const char *worktree_git_path(const struct worktree *wt, const char *fmt, ...)
 	return pathname->buf;
 }
 
+static void do_worktree_path(const struct repository *repo,
+			     struct strbuf *buf,
+			     const char *fmt, va_list args)
+{
+	strbuf_addstr(buf, repo->worktree);
+	if(buf->len && !is_dir_sep(buf->buf[buf->len - 1]))
+		strbuf_addch(buf, '/');
+
+	strbuf_vaddf(buf, fmt, args);
+	strbuf_cleanup_path(buf);
+}
+
+char *repo_worktree_path(const struct repository *repo, const char *fmt, ...)
+{
+	struct strbuf path = STRBUF_INIT;
+	va_list args;
+
+	if (!repo->worktree)
+		return NULL;
+
+	va_start(args, fmt);
+	do_worktree_path(repo, &path, fmt, args);
+	va_end(args);
+
+	return strbuf_detach(&path, NULL);
+}
+
+void strbuf_repo_worktree_path(struct strbuf *sb,
+			       const struct repository *repo,
+			       const char *fmt, ...)
+{
+	va_list args;
+
+	if (!repo->worktree)
+		return;
+
+	va_start(args, fmt);
+	do_worktree_path(repo, sb, fmt, args);
+	va_end(args);
+}
+
 /* Returns 0 on success, negative on failure. */
 static int do_submodule_path(struct strbuf *buf, const char *path,
 			     const char *fmt, va_list args)
diff --git a/path.h b/path.h
index c779c4aa2..9541620c7 100644
--- a/path.h
+++ b/path.h
@@ -43,6 +43,14 @@ extern void strbuf_repo_git_path(struct strbuf *sb,
 				 const char *fmt, ...)
 	__attribute__((format (printf, 3, 4)));
 
+extern char *repo_worktree_path(const struct repository *repo,
+				const char *fmt, ...)
+	__attribute__((format (printf, 2, 3)));
+extern void strbuf_repo_worktree_path(struct strbuf *sb,
+				      const struct repository *repo,
+				      const char *fmt, ...)
+	__attribute__((format (printf, 3, 4)));
+
 extern void report_linked_checkout_garbage(void);
 
 /*
-- 
2.13.1.704.gde00cce3c-goog

