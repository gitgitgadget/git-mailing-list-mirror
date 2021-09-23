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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74871C433EF
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 10:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59C446103D
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 10:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240402AbhIWKcy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 06:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240400AbhIWKcr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 06:32:47 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D467C061760
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 03:31:16 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id d21so15641601wra.12
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 03:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mf+l2xdsf3K8MH03KQ93hCKabkrr225u41iX2Wa842U=;
        b=QsAMlhcaKL2XsLRGuMmH2c5HN9uFAS0Be9tEqiXX4SVgnXr0yEdRIG4/yQLW43VXYh
         AJ5rJQR0Jj0L0wlqMz28mkv52oebcKJXD/JDWit9BpifU7CRNEG5x6A82Wm/e8hCrcuB
         e4riK2AL8KhzUkjCx4j6QD8lJ9vq0vZym1bKrfKSp8pezPbxsDHRRupDZnzIBmP089a/
         oxao1B8/+if1lyU5eiXxSjxXURKzPjjcjGF8oxcx5eIh1ivuBd1VK/p+xmcp6xunntgC
         701rIEn2HiEpPtgaui9l+Smp1AEWFq2F5pXL+AYlD+whCOOBavZIrg6TGRW12isQpGVG
         5zQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mf+l2xdsf3K8MH03KQ93hCKabkrr225u41iX2Wa842U=;
        b=S12cDsUfOTLpiQTH/PAclQk9m7c9HgF1MfLORcoMP40gsg78AVE9cm9X2lNkpHDH1k
         KmWsV6+8McR4mMiHIXhF/MxEF7O6Mo/VMqBCA0YtDKCgUBxjWta3riUngT8IdIicRgT1
         CyIMxCDhxQVHkAIfP6X69IkxbEBaBfY79Xg8a7HlzHqJaFBdT0QOK88tuRv2xpL3kfXg
         UaChxyKzUHy5RxkovXrKHubx4jq26AoB5GnJYpaGUrMZwsbOv5sa786IaxAk9V0Grlyr
         5NSib6H9IqPDUGd8eltUYN1UzTeM5H4g8jletW2EpcYCGywcLcgXyOzcDp7KXptWmqsK
         NUUQ==
X-Gm-Message-State: AOAM530o1NcA6oFrLPE64cjrU5uczNLZeLdjngXOoU2tcDzUg1ZmbJo1
        OcbCCaaKzuJawoQlFD3kSfdtj1bUZkEgYg==
X-Google-Smtp-Source: ABdhPJxYbTcTGygYvoEUEBecQ8WNtT0R9PEoGwrJEn+sex4lB2cYqRtGYCJ/12+08brNwrdCpZMY1Q==
X-Received: by 2002:adf:d1c4:: with SMTP id b4mr4256220wrd.356.1632393074411;
        Thu, 23 Sep 2021 03:31:14 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b187sm9027312wmd.33.2021.09.23.03.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 03:31:13 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/8] hook.[ch]: move find_hook() from run-command.c to hook.c
Date:   Thu, 23 Sep 2021 12:30:00 +0200
Message-Id: <patch-5.8-7dd874d50ec-20210923T095326Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1229.g50d2591fb53
In-Reply-To: <cover-0.8-00000000000-20210923T095326Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20210923T095326Z-avarab@gmail.com>
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
index c50115cd565..ad2aeff68f0 100644
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
index 60f3737f99c..85e3d92376b 100644
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
index 821245672d6..222a48e1400 100644
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
index ad207daced7..a9fd2d24f00 100644
--- a/run-command.h
+++ b/run-command.h
@@ -212,13 +212,6 @@ int finish_command_in_signal(struct child_process *);
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
index b37664ba870..5d31f7cc131 100644
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
2.33.0.1229.g0a86d28df49

