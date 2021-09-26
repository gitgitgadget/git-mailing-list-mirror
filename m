Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957B7C433F5
	for <git@archiver.kernel.org>; Sun, 26 Sep 2021 19:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CA2460F12
	for <git@archiver.kernel.org>; Sun, 26 Sep 2021 19:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbhIZTFU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Sep 2021 15:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbhIZTFP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Sep 2021 15:05:15 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1964BC061714
        for <git@vger.kernel.org>; Sun, 26 Sep 2021 12:03:38 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id s21so5406353wra.7
        for <git@vger.kernel.org>; Sun, 26 Sep 2021 12:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tP3nIRkFx66M+sMVZPmffTRNb5/BBU5yc8/EYUZ8LRQ=;
        b=S6avZ1s7t8Cq+PD07HgekK9IFUkp+rqm83MrMOQNdU4apTPchLO0823FRL5oxPx7cx
         +cgxaeMC8o2YG1mRzQP5qDgUQ3CGx7xDMSKbWt5BXWu1vtiBVHWx+s59yG9hyXNvs97/
         dTD22wLZAl+1oQk/8O7Fg6zgeNCup1zUgFDBZZXHhVrKfieg36bM8q1f1mevKzfT5UqD
         +zKajE0c3wQ/f4Dayw3j2j3rAvayzk6pGQ3l3vJirwOK09tP/CL3bnrOr8bsZ0PKmqm6
         I30gLdT4MiKtP1RnKqZhihW/ywnKqHBDVnXGEBmn4jRIRdqZ0bUkP4Q5s7ibQClk5VQG
         /YqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tP3nIRkFx66M+sMVZPmffTRNb5/BBU5yc8/EYUZ8LRQ=;
        b=It7fXVHakg/8S57EwxVsGwldTklJk/lSkKNd0V8OfCfsDVEAvk+TkjvSTD/k3QBOpa
         sYBAACzK5HJ18/udIPOCiZcYM2LnJDvd2IID2K1Aj8fXuMp5oJLgdGNebbAm3vWItOUl
         2v6VQMM9yN4G9ckcbL0zPRno55ji2HRbtUh5/MCBM9z30pnigBAqz4O/bhrbM70FvoyB
         nlWbIjbAgFbskaE6nS2v1MnABgUIEk6UUCUqajDMeilbM6weS3emQL1vBQyH7V8QyeIE
         QtThiu3Ui47k4eODuoqUT3zGchIS5cGHEPH3Ou/setq9NizaMUAMd24hsfYELeiWWG/F
         LbDA==
X-Gm-Message-State: AOAM532sD7AbIJMT62H00djOf3iD0PLq1AM8zNY6q96MGl32AJBVfP9i
        w1uJxT6hfMLgK3wjdvBzqdvs0QouCUmM8g==
X-Google-Smtp-Source: ABdhPJyG4YSOYjikRhQAE2aDKsd2S9GLSpnvNGfBlntIhS6XttGwZ4hjj1Sa6MQRLQRG5QDR2E5XPg==
X-Received: by 2002:a05:6000:8f:: with SMTP id m15mr2206277wrx.174.1632683016354;
        Sun, 26 Sep 2021 12:03:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v20sm14691523wra.73.2021.09.26.12.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 12:03:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 5/8] hook.[ch]: move find_hook() from run-command.c to hook.c
Date:   Sun, 26 Sep 2021 21:03:26 +0200
Message-Id: <patch-v2-5.8-64f3af94161-20210926T185800Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1291.g8857a6a91ac
In-Reply-To: <cover-v2-0.8-00000000000-20210926T185800Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20210923T095326Z-avarab@gmail.com> <cover-v2-0.8-00000000000-20210926T185800Z-avarab@gmail.com>
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
 transport.c            |  2 +-
 14 files changed, 59 insertions(+), 43 deletions(-)
 create mode 100644 hook.c
 create mode 100644 hook.h

diff --git a/Makefile b/Makefile
index b9bf13239d0..1f2b0205da5 100644
--- a/Makefile
+++ b/Makefile
@@ -904,6 +904,7 @@ LIB_OBJS += hash-lookup.o
 LIB_OBJS += hashmap.o
 LIB_OBJS += help.o
 LIB_OBJS += hex.o
+LIB_OBJS += hook.o
 LIB_OBJS += ident.o
 LIB_OBJS += json-writer.o
 LIB_OBJS += kwset.o
diff --git a/builtin/am.c b/builtin/am.c
index e4a0ff9cd7c..3527945a467 100644
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
index 06ed10dc92d..c30a360d695 100644
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
index e7320f66f95..5359d961d22 100644
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
index 3fbdacc7db4..fe664f6a863 100644
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
index 48960a9575b..e3895aec622 100644
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
index 0d0a80da61f..d22ece93e1a 100644
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
index 00000000000..ba70b314718
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
+		if (err == EACCES && advice_enabled(ADVICE_IGNORED_HOOK)) {
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
index 00000000000..68624f16059
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
index 8b9f7c3a80a..6211692eaae 100644
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
index 04a07e6366e..e4862b8f46d 100644
--- a/run-command.c
+++ b/run-command.c
@@ -9,6 +9,7 @@
 #include "quote.h"
 #include "config.h"
 #include "packfile.h"
+#include "hook.h"
 
 void child_process_init(struct child_process *child)
 {
@@ -1322,40 +1323,6 @@ int async_with_fork(void)
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
-		if (err == EACCES && advice_enabled(ADVICE_IGNORED_HOOK)) {
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
index b9aff74914d..5e544acf4bc 100644
--- a/run-command.h
+++ b/run-command.h
@@ -224,13 +224,6 @@ int finish_command_in_signal(struct child_process *);
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
index 614d56f5e21..8ee6c4ac240 100644
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
index b37664ba870..e4f1decae20 100644
--- a/transport.c
+++ b/transport.c
@@ -1,7 +1,7 @@
 #include "cache.h"
 #include "config.h"
 #include "transport.h"
-#include "run-command.h"
+#include "hook.h"
 #include "pkt-line.h"
 #include "fetch-pack.h"
 #include "remote.h"
-- 
2.33.0.1291.g8857a6a91ac

