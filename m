Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6628201CF
	for <e@80x24.org>; Thu, 18 May 2017 23:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932664AbdERXXJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 19:23:09 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36405 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754920AbdERXWd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 19:22:33 -0400
Received: by mail-pf0-f179.google.com with SMTP id m17so30750597pfg.3
        for <git@vger.kernel.org>; Thu, 18 May 2017 16:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M/t9sh2Jpj4YtQwnQmFFaOmWxCsWQhsPTuKw76CW0Kg=;
        b=a6BtV3T/colOjexTOyfg2IjfKGp5uuvBQ8BcOgTM9iUosI35Xyd2v9OHMbSYnTYgjY
         6Va0vgm6PR+te/ZOz1+4N0nuX6NPV7XplOUomxSNQ886xH5A+Tr5uP8LGOwp02QDggbO
         FRX4n8DQpuOju2bT3UMtdlif5GzJ++G/+tk+rupIAQ2bTp7WmOTDGYD5Ab3XYaPLN64E
         eesb/v/ywwdETmiEfrX+W8XLCpmqtPux/473XqTfFge6kjJK5LHJqDgpqj00NTNI0nNn
         vzJM6v6IvECmCgqfCW5tBCZo5FFOJnGBPx7iPnhEgEgoAtcEb9lPu8czYUHTNOszgmsh
         fR3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=M/t9sh2Jpj4YtQwnQmFFaOmWxCsWQhsPTuKw76CW0Kg=;
        b=GN1hZNVRxuQ7Jf2RdlHbg64mcoRJBLT44BDtVQYDeM1XHmC1ybRmlbSzc7HDOn1Sim
         +xb03qfo3tZPokG9KqrAkYDgu+2x7mnDHX53Uq6lcN0LQqN5z+NC39CNgGVqVOUWB45c
         8Vw3KUoyZvDZZF/BEr+fwtNmI6Ir8ihKs2+anJHqgGh38hXEZNSu2+VXgM7u20JWjffg
         9WGFzHkhRH1+XnGf8s5LCVuhNN36DJ2lSZZs6zBm1AuQoXxSe+upPMklY5TA/KuCEcav
         g00zIep9CU50Nlo60eNpvHYNEZm0U8PjhEvCdy0jLaGn4tH/tz1D1y/+ve9heKi4IXt9
         troQ==
X-Gm-Message-State: AODbwcC2MyFyXp5litRgjbK8zaJqeqHJGXIE9pDoLUlUey4FJt3Mvs9K
        FMwdjSYKtwer3IIg
X-Received: by 10.98.29.196 with SMTP id d187mr7247046pfd.68.1495149752460;
        Thu, 18 May 2017 16:22:32 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id d3sm12579575pfg.30.2017.05.18.16.22.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 May 2017 16:22:31 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, gitster@pobox.com, peff@peff.net,
        sbeller@google.com, jrnieder@gmail.com, pclouds@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [WIP/RFC 17/23] repo: introduce new repository object
Date:   Thu, 18 May 2017 16:21:28 -0700
Message-Id: <20170518232134.163059-18-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169-goog
In-Reply-To: <20170518232134.163059-1-bmwill@google.com>
References: <20170518232134.163059-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce 'struct repo' an object used to represent a repository.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 Makefile |  1 +
 repo.c   | 42 ++++++++++++++++++++++++++++++++++++++++++
 repo.h   | 15 +++++++++++++++
 3 files changed, 58 insertions(+)
 create mode 100644 repo.c
 create mode 100644 repo.h

diff --git a/Makefile b/Makefile
index e35542e63..a49d2f96a 100644
--- a/Makefile
+++ b/Makefile
@@ -821,6 +821,7 @@ LIB_OBJS += refs/ref-cache.o
 LIB_OBJS += ref-filter.o
 LIB_OBJS += remote.o
 LIB_OBJS += replace_object.o
+LIB_OBJS += repo.o
 LIB_OBJS += rerere.o
 LIB_OBJS += resolve-undo.o
 LIB_OBJS += revision.o
diff --git a/repo.c b/repo.c
new file mode 100644
index 000000000..d47e98d95
--- /dev/null
+++ b/repo.c
@@ -0,0 +1,42 @@
+#include "cache.h"
+#include "repo.h"
+
+int
+repo_init(struct repo *repo, const char *gitdir, const char *worktree)
+{
+	int error = 0;
+	char *abspath = real_pathdup(gitdir, 1);
+	char *suspect = xstrfmt("%s/.git", abspath);
+	const char *resolved_gitdir;
+
+	memset(repo, 0, sizeof(struct repo));
+
+	/* First assume 'gitdir' references the gitdir directly */
+	resolved_gitdir = resolve_gitdir_gently(abspath, &error);
+	/* otherwise; try 'gitdir'.git */
+	if (!resolved_gitdir) {
+		resolved_gitdir = resolve_gitdir_gently(suspect, &error);
+		if (!resolved_gitdir) {
+			die("'%s' is not a repository\n", abspath);
+			return error;
+		}
+	}
+
+	repo->gitdir = xstrdup(resolved_gitdir);
+	/* Maybe need a check to verify that a worktree is indeed a worktree? */
+	repo->worktree = xstrdup_or_null(worktree);
+
+	free(abspath);
+	free(suspect);
+
+	return error;
+}
+
+void
+repo_clear(struct repo *repo)
+{
+	free(repo->gitdir);
+	repo->gitdir = NULL;
+	free(repo->worktree);
+	repo->worktree = NULL;
+}
diff --git a/repo.h b/repo.h
new file mode 100644
index 000000000..55f2dbec6
--- /dev/null
+++ b/repo.h
@@ -0,0 +1,15 @@
+#ifndef REPO_H
+#define REPO_H
+
+struct index_state;
+
+struct repo {
+	char *gitdir;
+	char *worktree;
+	const char *submodule_prefix;
+};
+
+extern int repo_init(struct repo *repo, const char *gitdir, const char *worktree);
+extern void repo_clear(struct repo *repo);
+
+#endif /* REPO_H */
-- 
2.13.0.303.g4ebf302169-goog

