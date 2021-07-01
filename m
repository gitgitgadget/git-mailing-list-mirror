Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04262C11F67
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 14:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDAFF61414
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 14:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbhGAOua (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 10:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232855AbhGAOuY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 10:50:24 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACCBC0613DC
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 07:47:53 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id f14so8218939wrs.6
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 07:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UgqoBQFqZt7+8MK/XFDvVVK3eW1rSdtiaAl9JpmaH1w=;
        b=gYozgeQhcdNuD+8Hx5lt0HJHJRiFKE5fkFzQQPNmdeZrdIEXwFjzRZEB6ByEDBqRTF
         MfirajIpEVwXuOZ3a/JjVlQVZvuF60Ola0LK8k1VkawiFQ4ypo4iM6Ks7FYks4I4TRpX
         9TF/TljeQgiAxEM35gYw7d2EGUNnDHOeDR/flhRlyz7FdntbJZrgGlOopOGN+KjVKn1a
         wX8JOEeXlbZbUMeKymQP2M/Kf9lJQVk7mVlOKDh4jKe+ELobMyHr+gUa/os6I/Zl6uuS
         OylFrW1gFBiJtA0f1sDRpFBlKyvnOge9GeF7xM60MwYibIlBrz6fviFDII5czztUmgqk
         BSAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UgqoBQFqZt7+8MK/XFDvVVK3eW1rSdtiaAl9JpmaH1w=;
        b=RRQqo5zObOigAUN3xmZeZIkQ9ksIGvbg+X92of7pnSwioBeeP4OSLebEsQrxO3SmJy
         4jpruW84n621W6GmCfAQt1zKrG9IU5h/J00nQJMPSbw5rqKNXQshj01otYClx5iPIh5w
         rbk9iRd4MdYxlysOvnP7/8jEP5AEbmeNAASjWAuILjV5H4tiLJ74U3qBwFydV/qN5BND
         TF0Hsh0kardbE9E0ftljHvq979vTcZqvXhBiSCEW9y6hFBHo1bY+cywFxys9v2DkUO14
         XZN6CGCYrjm/SZRV33AnrmaTKDDeZLKaP78ZbXkC3k+FpR2JelKKWDxZi7xEeG8qqHvU
         cuyQ==
X-Gm-Message-State: AOAM530anFfvOjzhMxgvX2lFRu04pn0j60lv2lnDJ0nhYipD1QaMtEcD
        9i+Qea3m+hclRzWZUYGQl4V/cxDHMiY=
X-Google-Smtp-Source: ABdhPJw2BzO9JrpWX1TibQljWgCy+ZKIX4sM+ZpuMkWZ9RMqANYUnJPTfdakc3E1S4WY6fVcHIyNhg==
X-Received: by 2002:a5d:5405:: with SMTP id g5mr50155wrv.12.1625150872128;
        Thu, 01 Jul 2021 07:47:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c1sm120094wrp.94.2021.07.01.07.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 07:47:51 -0700 (PDT)
Message-Id: <5a9bda7220356ebf0689bb6aaa9068520dc6e33b.1625150864.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
        <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Jul 2021 14:47:21 +0000
Subject: [PATCH v3 11/34] fsmonitor-fs-listen-win32: stub in backend for
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
index c45caacf2c3..a2a6e1f20f6 100644
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
@@ -1929,6 +1934,11 @@ ifdef NEED_ACCESS_ROOT_HANDLER
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
@@ -2793,6 +2803,9 @@ GIT-BUILD-OPTIONS: FORCE
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
index 00000000000..880446b49e3
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
index 00000000000..c7b5776b3b6
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
index cb443b4e023..fcd88b60b14 100644
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
index a87841340e6..1ab94eb284f 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -263,6 +263,11 @@ else()
 	endif()
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

