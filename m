Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE6AC43216
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05687610D0
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345076AbhIBNMy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 09:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345013AbhIBNMq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 09:12:46 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255D4C061575
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 06:11:47 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id b6so2851723wrh.10
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 06:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fSSia/gmx3cZomWwRZNJjezRyCHF5eUQp7+TVGkFYsU=;
        b=g2nyxnNVMnVeywWGoq80LjnbV3QiQwJunOx4iVtvTxYWF2jSR3gSeKSKxyR8wVL1F6
         YLDRxkCZNPkHdIZwwhqXHQ8PQ76OO+7i/IzXHIJN6gTlighp5XtuZGOn9OSCH/l9IIok
         kuYLLfd3A8thb6rP7reT//5QbYe3TBAv6wUaIgwHuiFRzlOijfSzaxgW9o7H1bObz5yF
         aoBu5650LbMmS74rxKv0XXca4ORnhOtBT1JMzC/Xw9MYqEpMPm2l+fX0/ViA2Phav+y/
         Caa6U0DPMG5kUkX5WPNEmvfMRwNOQnqjpCQHtf7gZM2X0cWjNKFgeo58Db4ldUkM/g8p
         oc+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fSSia/gmx3cZomWwRZNJjezRyCHF5eUQp7+TVGkFYsU=;
        b=IEbuLboWwvFpUUHe13d6Xguh5Y4znTDk7ciJsqEzoIoAPRc0qHkG+0NvsDG0sTz3yU
         CFrivvhcWIbEzlrML1rKLbK7l8s0QDVASIROwGx+XPaIWUcw4xNXCQ6azbjSKsG7z8yJ
         Lv0RjZTBxtlAxWsDHItncHRh4pBHIGf867MEDlpIDHk3cb/XHoIPIGrnc89auyhdaIky
         wEy92O42tcewYHZtD+Xycy5RUaM+u8VlzQ6xsZ4GZsQje5+XbgyiP8bxBZD+rIwKdCEH
         ame7M3bIA+AGbqLxJNi5mXVtF9RkzUDF9TA1PuoS8m2W0ZkEC0Q+E/dLgiDO9DQNdRWv
         WXxw==
X-Gm-Message-State: AOAM532wUXztZeuwaSK3lqE1T8y6SPH/NjCECrjyrcpPTP2SRJdCgJ8J
        ooV/iagr9G04s0EKTBqufNFkSzOLdJS9lw==
X-Google-Smtp-Source: ABdhPJwg9S24Ba+O2GlW7SQct2uKIVHjKFeo6oW8cv+O0FzRsEDZys+ah/8HkV/bzkUSAijFt7tPMg==
X-Received: by 2002:a5d:424c:: with SMTP id s12mr3753141wrr.268.1630588305425;
        Thu, 02 Sep 2021 06:11:45 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o7sm1479635wmq.36.2021.09.02.06.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 06:11:44 -0700 (PDT)
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
Subject: [PATCH v5 04/36] hook.[ch]: move find_hook() from run-command.c to hook.c
Date:   Thu,  2 Sep 2021 15:11:04 +0200
Message-Id: <patch-v5-04.36-545e16c6f04-20210902T125110Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.816.g1ba32acadee
In-Reply-To: <cover-v5-00.36-00000000000-20210902T125110Z-avarab@gmail.com>
References: <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com> <cover-v5-00.36-00000000000-20210902T125110Z-avarab@gmail.com>
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
index 53c67f4a726..ae256672780 100644
--- a/Makefile
+++ b/Makefile
@@ -911,6 +911,7 @@ LIB_OBJS += hash-lookup.o
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
index 243c626307c..26c8fad6366 100644
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
index febb0c99c93..2fc78f54e43 100644
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
index 00000000000..56a7b3c9164
--- /dev/null
+++ b/hook.h
@@ -0,0 +1,11 @@
+#ifndef HOOK_H
+#define HOOK_H
+
+/**
+ * Returns the path to the hook file, or NULL if the hook is missing
+ * or disabled. Note that this points to static storage that will be
+ * overwritten by further calls to find_hook().
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
index 1ceb4c0d7fd..3214f02f393 100644
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
2.33.0.816.g1ba32acadee

