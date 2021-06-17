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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF6EC2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D01B361245
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbhFQKLv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 06:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbhFQKLt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 06:11:49 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A38CC061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:09:41 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id i94so6087210wri.4
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gh+VVtXcUje9hPh4kMyyN22UheGa/4QgaSimbtcwxbE=;
        b=ViKXHf2M3PtImOoca9CXuMbyxVBpMaQrAyX8yJw9tXsobPtcg4MaadvGpjUiMmOvPH
         WcjPReV2PqgvMFPcehnrUDK8a0OFEuLoqUuvmm3QRSFEe75f1u7h+JxeMy+QLWMVhbLL
         lJ4lZljssa3USQD3wdG8Un1jAg5aYMwG/j6LeXSBfaJ0BGu14RJjwVW7MZqPbs+Y3MKL
         LHwlwhyQgBZFMpRYQZ0qfrSzDiKeO1BN7co9n0gjMwEiG+7G58nfxRwZ/4Wi3t8rm2dk
         O2e67mbOb6EgUR1bHaO1zhDddcqAEJcWJT+2/9RF6nyGefadV/lLzC+Mdu9clO8tvzk3
         YM3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gh+VVtXcUje9hPh4kMyyN22UheGa/4QgaSimbtcwxbE=;
        b=ZxAST5iTgFfrPIa9qsswdXKD7ylneT49WZ2KqCx3aB/7Pxte0mGrreqBSegx04dyMJ
         5HjID0hNnlv6WLktbmZBLdHK/AZnILA60/nAJ0KOGdCNWe1SUsvTpbyi/lgCpaCQk90y
         DL4yjm4sl9dPMA2jrEjn5eSWBbZSrrvT1BLTzB5+VZ4CiEqMqq3o/fF2ZbquNmSzJeTG
         m65XICrULo0VPS5kxQRXio6uYzaRkxOij3TJM7z+hzACetjh01O3/311dlV13G898E3m
         eRdRjS4Kw2eD7Jk/B4wv0a7P//WXdpySZOXKNFF0aby9r3448YyYLji4djYc2Bwb+8Kz
         bwEA==
X-Gm-Message-State: AOAM532ZOqSe3ZSVPLskttnGkFuE+gb+LinPIPJzBsLZFlojk+B7jotj
        TsA3MEQuYBcbnh0MvZ9WOHfe/AJ2AWzaHQ==
X-Google-Smtp-Source: ABdhPJxQBif0D+m72ykFo6mkwaxegTcjLjDUw/Lw7G+sO0lPq43FowX3m/jBnDKLBQUKODaKxSWqbQ==
X-Received: by 2002:adf:ed03:: with SMTP id a3mr4789536wro.166.1623924579350;
        Thu, 17 Jun 2021 03:09:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h9sm7348425wmm.33.2021.06.17.03.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 03:09:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/3] hook.[ch]: move find_hook() to this new library
Date:   Thu, 17 Jun 2021 12:09:34 +0200
Message-Id: <patch-1.3-58c37e4f06-20210617T100239Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.576.g59759b6ca7d
In-Reply-To: <cover-0.3-0000000000-20210617T100239Z-avarab@gmail.com>
References: <cover-0.3-0000000000-20210617T100239Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the find_hook() function from run-command.c to a new hook.c
library. This change establishes a stub library that's pretty
pointless right now, but will see much wider use with Emily Shaffer's
upcoming "configuration-based hooks" series.

Eventually all the hook related code will live in hook.[ch]. Let's
start that process by moving the simple find_hook() function over
as-is.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile               |  1 +
 builtin/am.c           |  1 +
 builtin/bugreport.c    |  2 +-
 builtin/commit.c       |  1 +
 builtin/merge.c        |  1 +
 builtin/receive-pack.c |  1 +
 builtin/worktree.c     |  1 +
 hook.c                 | 37 +++++++++++++++++++++++++++++++++++++
 hook.h                 | 11 +++++++++++
 refs.c                 |  1 +
 run-command.c          | 35 +----------------------------------
 run-command.h          |  7 -------
 sequencer.c            |  1 +
 transport.c            |  1 +
 14 files changed, 59 insertions(+), 42 deletions(-)
 create mode 100644 hook.c
 create mode 100644 hook.h

diff --git a/Makefile b/Makefile
index 29a152cd4f..d155b7be21 100644
--- a/Makefile
+++ b/Makefile
@@ -903,6 +903,7 @@ LIB_OBJS += hash-lookup.o
 LIB_OBJS += hashmap.o
 LIB_OBJS += help.o
 LIB_OBJS += hex.o
+LIB_OBJS += hook.o
 LIB_OBJS += ident.o
 LIB_OBJS += json-writer.o
 LIB_OBJS += kwset.o
diff --git a/builtin/am.c b/builtin/am.c
index 0b2d886c81..1c8a548903 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -11,6 +11,7 @@
 #include "parse-options.h"
 #include "dir.h"
 #include "run-command.h"
+#include "hook.h"
 #include "quote.h"
 #include "tempfile.h"
 #include "lockfile.h"
diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index 9915a5841d..596f079a7f 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -3,7 +3,7 @@
 #include "strbuf.h"
 #include "help.h"
 #include "compat/compiler.h"
-#include "run-command.h"
+#include "hook.h"
 
 
 static void get_system_info(struct strbuf *sys_info)
diff --git a/builtin/commit.c b/builtin/commit.c
index 190d215d43..f1aafd67d4 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -19,6 +19,7 @@
 #include "revision.h"
 #include "wt-status.h"
 #include "run-command.h"
+#include "hook.h"
 #include "refs.h"
 #include "log-tree.h"
 #include "strbuf.h"
diff --git a/builtin/merge.c b/builtin/merge.c
index a8a843b1f5..be98d66b0a 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -13,6 +13,7 @@
 #include "builtin.h"
 #include "lockfile.h"
 #include "run-command.h"
+#include "hook.h"
 #include "diff.h"
 #include "diff-merges.h"
 #include "refs.h"
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index a34742513a..1e0e04c62f 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -7,6 +7,7 @@
 #include "pkt-line.h"
 #include "sideband.h"
 #include "run-command.h"
+#include "hook.h"
 #include "exec-cmd.h"
 #include "commit.h"
 #include "object.h"
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 976bf8ed06..b1350640fe 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -8,6 +8,7 @@
 #include "branch.h"
 #include "refs.h"
 #include "run-command.h"
+#include "hook.h"
 #include "sigchain.h"
 #include "submodule.h"
 #include "utf8.h"
diff --git a/hook.c b/hook.c
new file mode 100644
index 0000000000..c4dbef1d0e
--- /dev/null
+++ b/hook.c
@@ -0,0 +1,37 @@
+#include "cache.h"
+#include "hook.h"
+#include "run-command.h"
+
+const char *find_hook(const char *name)
+{
+	static struct strbuf path = STRBUF_INIT;
+
+	strbuf_reset(&path);
+	strbuf_git_path(&path, "hooks/%s", name);
+	if (access(path.buf, X_OK) < 0) {
+		int err = errno;
+
+#ifdef STRIP_EXTENSION
+		strbuf_addstr(&path, STRIP_EXTENSION);
+		if (access(path.buf, X_OK) >= 0)
+			return path.buf;
+		if (errno == EACCES)
+			err = errno;
+#endif
+
+		if (err == EACCES && advice_ignored_hook) {
+			static struct string_list advise_given = STRING_LIST_INIT_DUP;
+
+			if (!string_list_lookup(&advise_given, name)) {
+				string_list_insert(&advise_given, name);
+				advise(_("The '%s' hook was ignored because "
+					 "it's not set as executable.\n"
+					 "You can disable this warning with "
+					 "`git config advice.ignoredHook false`."),
+				       path.buf);
+			}
+		}
+		return NULL;
+	}
+	return path.buf;
+}
diff --git a/hook.h b/hook.h
new file mode 100644
index 0000000000..68624f1605
--- /dev/null
+++ b/hook.h
@@ -0,0 +1,11 @@
+#ifndef HOOK_H
+#define HOOK_H
+
+/*
+ * Returns the path to the hook file, or NULL if the hook is missing
+ * or disabled. Note that this points to static storage that will be
+ * overwritten by further calls to find_hook and run_hook_*.
+ */
+const char *find_hook(const char *name);
+
+#endif
diff --git a/refs.c b/refs.c
index 8c9490235e..59be29cf08 100644
--- a/refs.c
+++ b/refs.c
@@ -10,6 +10,7 @@
 #include "refs.h"
 #include "refs/refs-internal.h"
 #include "run-command.h"
+#include "hook.h"
 #include "object-store.h"
 #include "object.h"
 #include "tag.h"
diff --git a/run-command.c b/run-command.c
index be6bc128cd..82fdf29656 100644
--- a/run-command.c
+++ b/run-command.c
@@ -8,6 +8,7 @@
 #include "string-list.h"
 #include "quote.h"
 #include "config.h"
+#include "hook.h"
 
 void child_process_init(struct child_process *child)
 {
@@ -1320,40 +1321,6 @@ int async_with_fork(void)
 #endif
 }
 
-const char *find_hook(const char *name)
-{
-	static struct strbuf path = STRBUF_INIT;
-
-	strbuf_reset(&path);
-	strbuf_git_path(&path, "hooks/%s", name);
-	if (access(path.buf, X_OK) < 0) {
-		int err = errno;
-
-#ifdef STRIP_EXTENSION
-		strbuf_addstr(&path, STRIP_EXTENSION);
-		if (access(path.buf, X_OK) >= 0)
-			return path.buf;
-		if (errno == EACCES)
-			err = errno;
-#endif
-
-		if (err == EACCES && advice_ignored_hook) {
-			static struct string_list advise_given = STRING_LIST_INIT_DUP;
-
-			if (!string_list_lookup(&advise_given, name)) {
-				string_list_insert(&advise_given, name);
-				advise(_("The '%s' hook was ignored because "
-					 "it's not set as executable.\n"
-					 "You can disable this warning with "
-					 "`git config advice.ignoredHook false`."),
-				       path.buf);
-			}
-		}
-		return NULL;
-	}
-	return path.buf;
-}
-
 int run_hook_ve(const char *const *env, const char *name, va_list args)
 {
 	struct child_process hook = CHILD_PROCESS_INIT;
diff --git a/run-command.h b/run-command.h
index d08414a92e..b58531a7eb 100644
--- a/run-command.h
+++ b/run-command.h
@@ -201,13 +201,6 @@ int finish_command_in_signal(struct child_process *);
  */
 int run_command(struct child_process *);
 
-/*
- * Returns the path to the hook file, or NULL if the hook is missing
- * or disabled. Note that this points to static storage that will be
- * overwritten by further calls to find_hook and run_hook_*.
- */
-const char *find_hook(const char *name);
-
 /**
  * Run a hook.
  * The first argument is a pathname to an index file, or NULL
diff --git a/sequencer.c b/sequencer.c
index 0bec01cf38..3de479f90e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -8,6 +8,7 @@
 #include "sequencer.h"
 #include "tag.h"
 #include "run-command.h"
+#include "hook.h"
 #include "exec-cmd.h"
 #include "utf8.h"
 #include "cache-tree.h"
diff --git a/transport.c b/transport.c
index 50f5830eb6..2ed270171f 100644
--- a/transport.c
+++ b/transport.c
@@ -2,6 +2,7 @@
 #include "config.h"
 #include "transport.h"
 #include "run-command.h"
+#include "hook.h"
 #include "pkt-line.h"
 #include "fetch-pack.h"
 #include "remote.h"
-- 
2.32.0.576.g59759b6ca7d

