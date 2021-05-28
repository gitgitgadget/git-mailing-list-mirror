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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C24C4708C
	for <git@archiver.kernel.org>; Fri, 28 May 2021 12:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9C99611BD
	for <git@archiver.kernel.org>; Fri, 28 May 2021 12:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236328AbhE1MN0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 08:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbhE1MNV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 08:13:21 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C611C061574
        for <git@vger.kernel.org>; Fri, 28 May 2021 05:11:46 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id j14so3086225wrq.5
        for <git@vger.kernel.org>; Fri, 28 May 2021 05:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZG0nX+Dz+mc27CdfokQHJOZDnyQU+6jsvdsYO11XhGo=;
        b=RoWSAM42MrxyjSXuHGEVkxRAr++FRGxmvi2fF+s1rW2k6iivc5XVdzoliO7p2wPHPv
         j5ordgZGb975ON8KntqBtiUExDpucBRGeDBcX6ag4W/yYPT0rgVpkDeEZm+JdkERwUWx
         aS0v/lYODcE2fsHungakCt2whDK4YnTZ/t08hcdmgUkrbIHDJ0vUBBoA4lnvzDIIt0Ix
         AEwivGAC7smLk7ohrwBCXa5mayJpY/9G/cYPZGwqihduUiQo+Relt/XV7aOaTT8+w2z1
         3xyr3UBpD22PM4X7dLkPUHIAaRYfDv+wcfmkJ/9lMd+rklRPd2N8sCbfNUaeuGKcRj3l
         pyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZG0nX+Dz+mc27CdfokQHJOZDnyQU+6jsvdsYO11XhGo=;
        b=BPe0zQeQtFjDWtJUNit40pMiKxRUZSQla0Y4g4rUQTH+8gEnSWjvke8XwhEmtjl3kq
         5eAh6C7S/HIiEAeHlttPTPDw3Hh4YisoLUhn6m46Q9Tkau0Weq7bUMvtpHRSdVd/UKDu
         My/oV7wUwNm6jFzIvDjYdkmCjwhs46Eo8d/g9UMbsOKZvpQ7rjyvO5kNHJWli8L5omu8
         i8Ve6NEJVxH1mqlsdWMK84AMZ7abPm15XjTClJjmpsBkkHSbSmT554tXzC+XSLMvOSrF
         WamknyE9T8ZpBOmNspFcd6OM1IHBzBEtbjwz71TezrhRv9ZcadsFS03Qmx2eghuGu8WB
         z0Yw==
X-Gm-Message-State: AOAM533eOHG29GKiRH1jX97tPSh4CS2sEP1+LkcGo5XklnmkBf3BC7At
        sQ9mL6vVvi5Y77rZqWVhLFp++IxaA0j1Qg==
X-Google-Smtp-Source: ABdhPJwjrcZ9nz7UkQPQMd2Bc6hZkqfPEU5bfC1Tn8MN5gT9QO1MNXcjzC2y8sEBO5AaIqiY+OsN2A==
X-Received: by 2002:a5d:6109:: with SMTP id v9mr8567383wrt.0.1622203904147;
        Fri, 28 May 2021 05:11:44 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c15sm7372269wro.21.2021.05.28.05.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 05:11:43 -0700 (PDT)
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
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 04/31] run-command.h: move find_hook() to hook.h
Date:   Fri, 28 May 2021 14:11:06 +0200
Message-Id: <patch-04.31-1a67a1cc065-20210528T110515Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc1.460.g26a014da44c
In-Reply-To: <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com>
References: <87lf80l1m6.fsf@evledraar.gmail.com> <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the find_hook() command to hook.h. Eventually all the hook
related code will live there, let's move this function over as-is.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/am.c           |  1 +
 builtin/bugreport.c    |  2 +-
 builtin/commit.c       |  1 +
 builtin/merge.c        |  1 +
 builtin/receive-pack.c |  1 +
 builtin/worktree.c     |  1 +
 hook.c                 | 36 ++++++++++++++++++++++++++++++++++++
 hook.h                 |  7 +++++++
 refs.c                 |  1 +
 run-command.c          | 35 +----------------------------------
 run-command.h          |  7 -------
 sequencer.c            |  1 +
 transport.c            |  1 +
 13 files changed, 53 insertions(+), 42 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 0b2d886c81b..1c8a5489035 100644
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
index 190d215d43b..f1aafd67d46 100644
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
index eddb8ae70d6..5a10f6e3c96 100644
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
index a34742513ac..1e0e04c62fc 100644
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
index 976bf8ed063..b1350640fed 100644
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
index aa66c968186..06842f50e5c 100644
--- a/hook.c
+++ b/hook.c
@@ -2,6 +2,42 @@
 #include "hook.h"
 #include "run-command.h"
 
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
+
+
+
 void run_hooks_opt_clear(struct run_hooks_opt *o)
 {
 	strvec_clear(&o->env);
diff --git a/hook.h b/hook.h
index ebfee26bcf2..291ee19469a 100644
--- a/hook.h
+++ b/hook.h
@@ -37,6 +37,13 @@ struct hook_cb_data {
 	struct run_hooks_opt *options;
 };
 
+/*
+ * Returns the path to the hook file, or NULL if the hook is missing
+ * or disabled. Note that this points to static storage that will be
+ * overwritten by further calls to find_hook and run_hook_*.
+ */
+const char *find_hook(const char *name);
+
 void run_hooks_opt_clear(struct run_hooks_opt *o);
 
 /*
diff --git a/refs.c b/refs.c
index 8c9490235ea..59be29cf081 100644
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
index be6bc128cd9..82fdf296569 100644
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
index d08414a92e7..b58531a7eb3 100644
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
index 0bec01cf38e..3de479f90e1 100644
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
index 6cf3da19ebd..e6c46adf60c 100644
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
2.32.0.rc1.458.gd885d4f985c

