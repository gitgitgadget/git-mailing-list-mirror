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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F62C4320A
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 19:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FB9360EE8
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 19:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240140AbhHCTjd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 15:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240160AbhHCTj2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 15:39:28 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79BBC0613D5
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 12:39:15 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id n12so26503474wrr.2
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 12:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6n9vsKuIaIWpG08Ft3EMnUp12AWDVPMX5xaYdaeiPec=;
        b=QrtnBX+JbDqO4Pg02PBUcIXFKsvio8rawS9gP2EpAQDGzkzzSteqNzb+1zNI1iZerp
         tSwpHPtp7dAdXJGRrHFvre2ghe2o5GSTKF3Qkzak05Uz0n+3BKZxvbN54oAfzRxr3+Nh
         SECX2cZZtt0Nxv4gxuydbb2Jsl188RoVXUjf84oY+Q9JAD9rQZE3jWzJhT0oxG/l+DAK
         I57gmNuPVHwY0Iwp3oMmmV9lKos1er4lWefDEvrcnLrssbtjsSEkghqSc6qg9lqukrhN
         2j9iyS5JpkeuIXbFpDJNyUXTYEgAZMhRP2SOp20qeE276CM3HDVHW7s3Xj3D+49IdbgC
         uc7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6n9vsKuIaIWpG08Ft3EMnUp12AWDVPMX5xaYdaeiPec=;
        b=aUOScueRg9u2RB9gX+1atqeic2ehTcIHDsuhGfZsXjFVxarBQdMdH6WuQiCIQEth8G
         qs0tcqNvzSsEN/zw9rhrwMvrF2ajkyFVArz86XXYCsON1CFnLv+xWxq0mc65WHtISq6J
         whtE8xfc8OkasJb3RmlWjOSGLUO89MZ6pgnccSyTdfPHnURfxuPqipcdhVodCRYAY0SN
         ejjvmXPpd8EiwR1K4IZadb2+Z13Rm8LJBS+qmD5A2k11RzShShyJQsbuwYr6sB2XUw0C
         q+Sw6SC3AeY1Y4OTFnRFE6Kz6ogPMbmnQZf/SxHHvW38Z2BIrCmymRypTZvN75LK+Bn2
         wsqg==
X-Gm-Message-State: AOAM533VeaS4zx2FYwXHEiM7k2VkQ3Jr2yXNeg6IfJNeNh9zEJcGDcBj
        U7U5CX8oQzbaiIvl3d8WXM8uHuENdAx95w==
X-Google-Smtp-Source: ABdhPJxPuE7GDAUq78llBk2gRHmEJ4UujTeZ0tZlTTl4raNELYaaavfMiIZ0Hgrii6PBrH0LoAhMKw==
X-Received: by 2002:a5d:504d:: with SMTP id h13mr22817344wrt.132.1628019554201;
        Tue, 03 Aug 2021 12:39:14 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n8sm15333562wrx.46.2021.08.03.12.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 12:39:13 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 04/36] hook.[ch]: move find_hook() to this new library
Date:   Tue,  3 Aug 2021 21:38:30 +0200
Message-Id: <patch-v4-04.36-89c4d44b0c3-20210803T191505Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.593.g54be4d223c3
In-Reply-To: <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com>
References: <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com> <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com>
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
index 0a540dcd34e..bc258886904 100644
--- a/Makefile
+++ b/Makefile
@@ -910,6 +910,7 @@ LIB_OBJS += hash-lookup.o
 LIB_OBJS += hashmap.o
 LIB_OBJS += help.o
 LIB_OBJS += hex.o
+LIB_OBJS += hook.o
 LIB_OBJS += ident.o
 LIB_OBJS += json-writer.o
 LIB_OBJS += kwset.o
diff --git a/builtin/am.c b/builtin/am.c
index 0c2ad96b70e..c603f3cebdf 100644
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
index 9915a5841de..596f079a7f9 100644
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
index 7436262aae2..51b07ee02ea 100644
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
index a8a843b1f54..be98d66b0a8 100644
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
index 2d1f97e1ca7..97aebdc15bd 100644
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
index 00000000000..c4dbef1d0ef
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
index f72e72cce73..352f5be1646 100644
--- a/run-command.c
+++ b/run-command.c
@@ -8,6 +8,7 @@
 #include "string-list.h"
 #include "quote.h"
 #include "config.h"
+#include "hook.h"
 
 void child_process_init(struct child_process *child)
 {
@@ -1319,40 +1320,6 @@ int async_with_fork(void)
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
index af1296769f9..f76b740f927 100644
--- a/run-command.h
+++ b/run-command.h
@@ -204,13 +204,6 @@ int finish_command_in_signal(struct child_process *);
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
index 7f07cd00f3f..ea4199d65a4 100644
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
index 17e9629710a..77e196f75f5 100644
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
2.33.0.rc0.595.ge31e012651d

