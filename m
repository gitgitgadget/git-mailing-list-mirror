Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E285C2B9F2
	for <git@archiver.kernel.org>; Sat, 22 May 2021 13:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FE076128A
	for <git@archiver.kernel.org>; Sat, 22 May 2021 13:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbhEVN64 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 May 2021 09:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbhEVN6o (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 May 2021 09:58:44 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065C9C06174A
        for <git@vger.kernel.org>; Sat, 22 May 2021 06:57:19 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id z17so23709582wrq.7
        for <git@vger.kernel.org>; Sat, 22 May 2021 06:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2WmMYUW0ToM7xwCC94wDRArWmCNFqsAQ9TSII3wBlas=;
        b=FdTcn8szWGrMapSP0h/YcmUssgMNstpUA2Z0gJpgYs3LTvU4zfxGyt0n1ug2OaOrE5
         G+Y49CmmnMDHgrUoOJgUxVn9i39s5i3GrzBBqsQLPbiyrhEhRdrI/qQQ2wN+h0otrp34
         y6iWnw95b82q6TRkC34YH7yL2vKghGz0VWbC9w2yam69lpU9bNPYAuAKdJyGtDz27Fvh
         cWwc3+WsCs+2YdasUQnde0V8j3+tmnGL6IwHIRTGBCwSuXCFGEx+NiJA20ZqiHWHvA8s
         Fyl08r8unGoTFkHc7CO5drSK4xxGx0PJ0/jDqq0VYzSv2XhnJBN35pN4iN+UIIilAFXI
         kn6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2WmMYUW0ToM7xwCC94wDRArWmCNFqsAQ9TSII3wBlas=;
        b=rA166/ALLklVUP5lQfP+B5LsU0HTzY4XRa3RxCNNiLGVR4kHwpPdgwvZlIUALKJRZW
         UBUNmArgp0uXnTt76MB9iETgW/vPEsrMtWebzboBAcp4QiNYTccB8e4hqbLkMemr+Um2
         9ZVC9p8GusNB6gnfU7OkU5NM0ZdvWhSOy9QW7eImiQQguUBo53HRMDv2csylkojIdmMo
         yi5MqTQEnED2eLfG3Q3dyrLpI8nloUa2dHeBqF8/dllQXr7NJcGZUV0KxAHJ42KGvidE
         7ofnLmI4T/YQZm8wcSXFJTm86aDt0ofHV13+LLm4QTM1qiFWKhWdQOR4DsgXQoh/ibfH
         foCg==
X-Gm-Message-State: AOAM532GC5cpomglDTX17SzNAx/lp/t6VAzAVX1fSpGJA3HQXfnNYwbm
        qXZpgsFQcWWtwVKiFfpKbjmDhx1DXWw=
X-Google-Smtp-Source: ABdhPJzSZMBY/zfmN4e7f7iX/BvrLUm4BG35Yb1mcCU0c6IIKr9fMBUkpvtJ5s+IJdf6zs7p2TjWrw==
X-Received: by 2002:a5d:4744:: with SMTP id o4mr13677238wrs.86.1621691837586;
        Sat, 22 May 2021 06:57:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 198sm2148278wme.15.2021.05.22.06.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 May 2021 06:57:17 -0700 (PDT)
Message-Id: <49f9e2e3d49ce6e7b56839bf44535f271216abeb.1621691828.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
        <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 22 May 2021 13:56:50 +0000
Subject: [PATCH v2 11/28] fsmonitor-fs-listen-win32: stub in backend for
 Windows
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Stub in empty backend for fsmonitor--daemon on Windows.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Makefile                                     | 13 ++++++
 compat/fsmonitor/fsmonitor-fs-listen-win32.c | 21 +++++++++
 compat/fsmonitor/fsmonitor-fs-listen.h       | 49 ++++++++++++++++++++
 config.mak.uname                             |  2 +
 contrib/buildsystems/CMakeLists.txt          |  5 ++
 5 files changed, 90 insertions(+)
 create mode 100644 compat/fsmonitor/fsmonitor-fs-listen-win32.c
 create mode 100644 compat/fsmonitor/fsmonitor-fs-listen.h

diff --git a/Makefile b/Makefile
index 80059032c4e3..3f31adfd135c 100644
--- a/Makefile
+++ b/Makefile
@@ -467,6 +467,11 @@ all::
 # directory, and the JSON compilation database 'compile_commands.json' will be
 # created at the root of the repository.
 #
+# If your platform supports a built-in fsmonitor backend, set
+# FSMONITOR_DAEMON_BACKEND to the "<name>" of the corresponding
+# `compat/fsmonitor/fsmonitor-fs-listen-<name>.c` that implements the
+# `fsmonitor_fs_listen__*()` routines.
+#
 # Define DEVELOPER to enable more compiler warnings. Compiler version
 # and family are auto detected, but could be overridden by defining
 # COMPILER_FEATURES (see config.mak.dev). You can still set
@@ -1906,6 +1911,11 @@ ifdef NEED_ACCESS_ROOT_HANDLER
 	COMPAT_OBJS += compat/access.o
 endif
 
+ifdef FSMONITOR_DAEMON_BACKEND
+	COMPAT_CFLAGS += -DHAVE_FSMONITOR_DAEMON_BACKEND
+	COMPAT_OBJS += compat/fsmonitor/fsmonitor-fs-listen-$(FSMONITOR_DAEMON_BACKEND).o
+endif
+
 ifeq ($(TCLTK_PATH),)
 NO_TCLTK = NoThanks
 endif
@@ -2765,6 +2775,9 @@ GIT-BUILD-OPTIONS: FORCE
 	@echo PAGER_ENV=\''$(subst ','\'',$(subst ','\'',$(PAGER_ENV)))'\' >>$@+
 	@echo DC_SHA1=\''$(subst ','\'',$(subst ','\'',$(DC_SHA1)))'\' >>$@+
 	@echo X=\'$(X)\' >>$@+
+ifdef FSMONITOR_DAEMON_BACKEND
+	@echo FSMONITOR_DAEMON_BACKEND=\''$(subst ','\'',$(subst ','\'',$(FSMONITOR_DAEMON_BACKEND)))'\' >>$@+
+endif
 ifdef TEST_OUTPUT_DIRECTORY
 	@echo TEST_OUTPUT_DIRECTORY=\''$(subst ','\'',$(subst ','\'',$(TEST_OUTPUT_DIRECTORY)))'\' >>$@+
 endif
diff --git a/compat/fsmonitor/fsmonitor-fs-listen-win32.c b/compat/fsmonitor/fsmonitor-fs-listen-win32.c
new file mode 100644
index 000000000000..880446b49e35
--- /dev/null
+++ b/compat/fsmonitor/fsmonitor-fs-listen-win32.c
@@ -0,0 +1,21 @@
+#include "cache.h"
+#include "config.h"
+#include "fsmonitor.h"
+#include "fsmonitor-fs-listen.h"
+
+void fsmonitor_fs_listen__stop_async(struct fsmonitor_daemon_state *state)
+{
+}
+
+void fsmonitor_fs_listen__loop(struct fsmonitor_daemon_state *state)
+{
+}
+
+int fsmonitor_fs_listen__ctor(struct fsmonitor_daemon_state *state)
+{
+	return -1;
+}
+
+void fsmonitor_fs_listen__dtor(struct fsmonitor_daemon_state *state)
+{
+}
diff --git a/compat/fsmonitor/fsmonitor-fs-listen.h b/compat/fsmonitor/fsmonitor-fs-listen.h
new file mode 100644
index 000000000000..c7b5776b3b60
--- /dev/null
+++ b/compat/fsmonitor/fsmonitor-fs-listen.h
@@ -0,0 +1,49 @@
+#ifndef FSMONITOR_FS_LISTEN_H
+#define FSMONITOR_FS_LISTEN_H
+
+/* This needs to be implemented by each backend */
+
+#ifdef HAVE_FSMONITOR_DAEMON_BACKEND
+
+struct fsmonitor_daemon_state;
+
+/*
+ * Initialize platform-specific data for the fsmonitor listener thread.
+ * This will be called from the main thread PRIOR to staring the
+ * fsmonitor_fs_listener thread.
+ *
+ * Returns 0 if successful.
+ * Returns -1 otherwise.
+ */
+int fsmonitor_fs_listen__ctor(struct fsmonitor_daemon_state *state);
+
+/*
+ * Cleanup platform-specific data for the fsmonitor listener thread.
+ * This will be called from the main thread AFTER joining the listener.
+ */
+void fsmonitor_fs_listen__dtor(struct fsmonitor_daemon_state *state);
+
+/*
+ * The main body of the platform-specific event loop to watch for
+ * filesystem events.  This will run in the fsmonitor_fs_listen thread.
+ *
+ * It should call `ipc_server_stop_async()` if the listener thread
+ * prematurely terminates (because of a filesystem error or if it
+ * detects that the .git directory has been deleted).  (It should NOT
+ * do so if the listener thread receives a normal shutdown signal from
+ * the IPC layer.)
+ *
+ * It should set `state->error_code` to -1 if the daemon should exit
+ * with an error.
+ */
+void fsmonitor_fs_listen__loop(struct fsmonitor_daemon_state *state);
+
+/*
+ * Gently request that the fsmonitor listener thread shutdown.
+ * It does not wait for it to stop.  The caller should do a JOIN
+ * to wait for it.
+ */
+void fsmonitor_fs_listen__stop_async(struct fsmonitor_daemon_state *state);
+
+#endif /* HAVE_FSMONITOR_DAEMON_BACKEND */
+#endif /* FSMONITOR_FS_LISTEN_H */
diff --git a/config.mak.uname b/config.mak.uname
index cb443b4e023a..fcd88b60b14a 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -420,6 +420,7 @@ ifeq ($(uname_S),Windows)
 	# so we don't need this:
 	#
 	#   SNPRINTF_RETURNS_BOGUS = YesPlease
+	FSMONITOR_DAEMON_BACKEND = win32
 	NO_SVN_TESTS = YesPlease
 	RUNTIME_PREFIX = YesPlease
 	HAVE_WPGMPTR = YesWeDo
@@ -598,6 +599,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_STRTOUMAX = YesPlease
 	NO_MKDTEMP = YesPlease
 	NO_SVN_TESTS = YesPlease
+	FSMONITOR_DAEMON_BACKEND = win32
 	RUNTIME_PREFIX = YesPlease
 	HAVE_WPGMPTR = YesWeDo
 	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 75ed198a6a36..4e812462d955 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -256,6 +256,11 @@ else()
 	list(APPEND compat_SOURCES compat/simple-ipc/ipc-shared.c compat/simple-ipc/ipc-unix-socket.c)
 endif()
 
+if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
+	add_compile_definitions(HAVE_FSMONITOR_DAEMON_BACKEND)
+	list(APPEND compat_SOURCES compat/fsmonitor/fsmonitor-fs-listen-win32.c)
+endif()
+
 set(EXE_EXTENSION ${CMAKE_EXECUTABLE_SUFFIX})
 
 #header checks
-- 
gitgitgadget

