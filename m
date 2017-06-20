Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3567120D26
	for <e@80x24.org>; Tue, 20 Jun 2017 19:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752162AbdFTTVJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 15:21:09 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:35161 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751763AbdFTTUi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 15:20:38 -0400
Received: by mail-pg0-f50.google.com with SMTP id 132so33103760pgb.2
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 12:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+mws56sKN0X7A+3bDjvyU6Q1uNk7wvP2l2fgE8ETKyA=;
        b=YKxq10oRyZfn6ADGrIQsSKC5wcCYpaMykCoW/ZSYLnCAolhEFX5HG1h9FATPULxuyl
         4n9X7/tSNyD+s6PJ9aKvkjU0X87YNLFXEcwCbW22VDv4lTWFs6cQ/7OCTdMsnPh3nSq+
         CsW9tlK9NwtzRo5uqDUUVeCPSkqcz3V2vAtdrdzMxDmXLIlgotKMox5JLPWYZ7p1HLsk
         ZtFMd7jvuflE05OTdRu+X1PqCsGUJBIsAp6mrKQ5I07gKHSadJ6/xu/I9kSNc1DxA684
         L1CHa+fC4YzmJeKF2E2alLz4XwZdnDgkMzlNyJuu0vtGXcN6ZGaqovxQwl6fBrBvM8Ru
         Z1Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+mws56sKN0X7A+3bDjvyU6Q1uNk7wvP2l2fgE8ETKyA=;
        b=WgRnoTmW37GFb453SrTVY31/q+ndNhBSAFyyVytpEZJK3cUHiBWi64FNH6oE82qqv1
         teEk7NqCKETNsak1kP/6ZifFoLJuKcQRXlFMVDsE5MozXTvYHu+FyFK0tLkzQXfcPlvx
         PCrqsWGYA85VlPWimpeHoUhRyyNP1isGw2eS1RkVZkFvqWXwfTjBG+ryOEa3N0Ez+6Eq
         mSyURIwwus7qz8gROIb3sGEG7G0hIjDJBlSHsSMpswgtBSTdaZVPmIoQzdZTUrq6EmAL
         WLZQaPOcvShIOhWpkBH8y9NGHYAhQjQo6Z1j719/7yb7a0d5fQib6pKb84ltbO0LZjjE
         f/MA==
X-Gm-Message-State: AKS2vOzwzON74f3baaeAC2Uk2tRZbcwpg0bhYRMojqphjMnx+A2u34jk
        9LuY/wl585ySDUs1238W8Q==
X-Received: by 10.98.155.218 with SMTP id e87mr32576749pfk.24.1497986432345;
        Tue, 20 Jun 2017 12:20:32 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id t6sm18680500pgs.33.2017.06.20.12.20.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 12:20:31 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 13/20] path: add repo_worktree_path and strbuf_repo_worktree_path
Date:   Tue, 20 Jun 2017 12:19:44 -0700
Message-Id: <20170620191951.84791-14-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1-goog
In-Reply-To: <20170620191951.84791-1-bmwill@google.com>
References: <20170608234100.188529-1-bmwill@google.com>
 <20170620191951.84791-1-bmwill@google.com>
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
index 3d223e0b2..a32c19547 100644
--- a/path.c
+++ b/path.c
@@ -512,6 +512,47 @@ const char *worktree_git_path(const struct worktree *wt, const char *fmt, ...)
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
2.13.1.611.g7e3b11ae1-goog

