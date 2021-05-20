Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E19C433ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 18:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2CC2611AB
	for <git@archiver.kernel.org>; Thu, 20 May 2021 18:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbhETS3h (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 14:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbhETS3g (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 14:29:36 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48AEC061574
        for <git@vger.kernel.org>; Thu, 20 May 2021 11:28:14 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id f6-20020a1c1f060000b0290175ca89f698so5975790wmf.5
        for <git@vger.kernel.org>; Thu, 20 May 2021 11:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dBroGNjMwQdwvLt7THBO8SIRRNCTD0+KcEURDjAt/xQ=;
        b=b2xpK62Qs1kAT4VFSd5HZ33wiCpkZ1Uuf7wwu/D7qvUbL5n5mprOtLCO5pv8kIWkjy
         4escUVZFrlauljGbsYZZzGyGugrRdlgwY/zUAJpFKSqAqEL5tJeBxfIJtacgBBZTV1/7
         bdjmLhKT36VebW3dV3twVieSApSbJ6wt4hOqdZQfk1A7ob9u/afQE8lf757mzJJia06T
         jv7x+CtpbPuWqXQ7TY+Rx4AdRJkHYoMBz9l3dbwMVHx5X17U0YxEE8SBIjXGlBBvHxVK
         3LnAeLO/njLvCoaX4qPGoH7n6lYvnrAyuWUnLQcQMqiJNZRVxkN3hk4dvYTuccnvJ/HV
         EdRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dBroGNjMwQdwvLt7THBO8SIRRNCTD0+KcEURDjAt/xQ=;
        b=uoIBYxD0NdSbwHvUzwXKeeE5nJXl7WEhA7lSMOvpBhOrVeUeKgVg/vbT/um/oPWmD2
         qA2yJ9EvIqJRAp0t21oZU97fimusjKbltV3v4llpIVQvUj4iAZ8dDSlNuwDbMO3BoHpR
         zUIOyXbUrQxBjOHtgDAPqrni8VQ1AzO2jND/fYLCNDzHx/0nB7a8vhDg4+9u2tEgC3He
         K6GwUP+AHA4m/TCPwwqNWDKZpP00yP6g7ZCN7Ts7kuWVG4sQDfwUVeYisJysKBuqQM0s
         nsOeNIDkBhvKXeTfol+j8wTmOHv5dTqLGUSKnCNV8Mr5jyk0qpY4L/qG9+owVbmc3592
         csAA==
X-Gm-Message-State: AOAM5330XHZrMcRxs3DA5RFmpNWvppee72R3tLxQhrgr7s0VPqZ0rs3y
        FduBWszEqCNwBtPrO5awmscy2oOE4CE=
X-Google-Smtp-Source: ABdhPJyS2X48u/HWMusJrTgnP6oR4nwaNATPWLd5WA3B3Spte88rNp3MLxrQCO+y2w03BPHHtr1RuQ==
X-Received: by 2002:a05:600c:2dd7:: with SMTP id e23mr5398363wmh.186.1621535293335;
        Thu, 20 May 2021 11:28:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v12sm4048822wru.73.2021.05.20.11.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 11:28:12 -0700 (PDT)
Message-Id: <pull.955.v3.git.1621535291406.gitgitgadget@gmail.com>
In-Reply-To: <pull.955.v2.git.1621520547726.gitgitgadget@gmail.com>
References: <pull.955.v2.git.1621520547726.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 20 May 2021 18:28:10 +0000
Subject: [PATCH v3] simple-ipc: correct ifdefs when NO_PTHREADS is defined
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Simple IPC always requires threads (in addition to various
platform-specific IPC support).  Fix the ifdefs in the Makefile
to define SUPPORTS_SIMPLE_IPC when appropriate.

Previously, the Unix version of the code would only verify that
Unix domain sockets were available.

This problem was reported here:
https://lore.kernel.org/git/YKN5lXs4AoK%2FJFTO@coredump.intra.peff.net/T/#m08be8f1942ea8a2c36cfee0e51cdf06489fdeafc

Reported-by: Randall S. Becker <rsbecker@nexbridge.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
    simple-ipc: correct ifdefs when NO_PTHREADS is defined
    
    Here is V3 of this fixup. I've added fixups for the CMake builds.
    
    Jeff

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-955%2Fjeffhostetler%2Ffixup-simple-ipc-no-pthreads-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-955/jeffhostetler/fixup-simple-ipc-no-pthreads-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/955

Range-diff vs v2:

 1:  119412f52ff5 ! 1:  d4f4170414e3 simple-ipc: correct ifdefs when NO_PTHREADS is defined
     @@ compat/simple-ipc/ipc-win32.c
       
       static int initialize_pipe_name(const char *path, wchar_t *wpath, size_t alloc)
      
     + ## contrib/buildsystems/CMakeLists.txt ##
     +@@ contrib/buildsystems/CMakeLists.txt: endif()
     + 
     + if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
     + 	list(APPEND compat_SOURCES compat/simple-ipc/ipc-shared.c compat/simple-ipc/ipc-win32.c)
     ++	add_compile_definitions(SUPPORTS_SIMPLE_IPC)
     ++	set(SUPPORTS_SIMPLE_IPC 1)
     + else()
     +-	list(APPEND compat_SOURCES compat/simple-ipc/ipc-shared.c compat/simple-ipc/ipc-unix-socket.c)
     ++	# Simple IPC requires both Unix sockets and pthreads on Unix-based systems.
     ++	if(NOT NO_UNIX_SOCKETS AND NOT NO_PTHREADS)
     ++		list(APPEND compat_SOURCES compat/simple-ipc/ipc-shared.c compat/simple-ipc/ipc-unix-socket.c)
     ++		add_compile_definitions(SUPPORTS_SIMPLE_IPC)
     ++		set(SUPPORTS_SIMPLE_IPC 1)
     ++	endif()
     + endif()
     + 
     + set(EXE_EXTENSION ${CMAKE_EXECUTABLE_SUFFIX})
     +@@ contrib/buildsystems/CMakeLists.txt: file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "X='${EXE_EXTENSION}'\n")
     + file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_GETTEXT='${NO_GETTEXT}'\n")
     + file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "RUNTIME_PREFIX='${RUNTIME_PREFIX}'\n")
     + file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_PYTHON='${NO_PYTHON}'\n")
     ++file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "SUPPORTS_SIMPLE_IPC='${SUPPORTS_SIMPLE_IPC}'\n")
     + if(WIN32)
     + 	file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "PATH=\"$PATH:$TEST_DIRECTORY/../compat/vcbuild/vcpkg/installed/x64-windows/bin\"\n")
     + endif()
     +
       ## simple-ipc.h ##
      @@
        * See Documentation/technical/api-simple-ipc.txt


 Makefile                            | 22 ++++++++++++++++++++--
 compat/simple-ipc/ipc-shared.c      | 10 +++++++---
 compat/simple-ipc/ipc-unix-socket.c |  8 ++++++--
 compat/simple-ipc/ipc-win32.c       |  8 ++++++--
 contrib/buildsystems/CMakeLists.txt | 10 +++++++++-
 simple-ipc.h                        |  4 ----
 6 files changed, 48 insertions(+), 14 deletions(-)

diff --git a/Makefile b/Makefile
index 3a2d3c80a81a..ea4c0a77604d 100644
--- a/Makefile
+++ b/Makefile
@@ -1687,13 +1687,31 @@ ifdef NO_UNIX_SOCKETS
 else
 	LIB_OBJS += unix-socket.o
 	LIB_OBJS += unix-stream-server.o
-	LIB_OBJS += compat/simple-ipc/ipc-shared.o
-	LIB_OBJS += compat/simple-ipc/ipc-unix-socket.o
 endif
 
+# Simple IPC requires threads and platform-specific IPC support.
+# Only platforms that have both should include these source files
+# in the build.
+#
+# On Windows-based systems, Simple IPC requires threads and Windows
+# Named Pipes.  These are always available, so Simple IPC support
+# is optional.
+#
+# On Unix-based systems, Simple IPC requires pthreads and Unix
+# domain sockets.  So support is only enabled when both are present.
+#
 ifdef USE_WIN32_IPC
+	BASIC_CFLAGS += -DSUPPORTS_SIMPLE_IPC
 	LIB_OBJS += compat/simple-ipc/ipc-shared.o
 	LIB_OBJS += compat/simple-ipc/ipc-win32.o
+else
+ifndef NO_PTHREADS
+ifndef NO_UNIX_SOCKETS
+	BASIC_CFLAGS += -DSUPPORTS_SIMPLE_IPC
+	LIB_OBJS += compat/simple-ipc/ipc-shared.o
+	LIB_OBJS += compat/simple-ipc/ipc-unix-socket.o
+endif
+endif
 endif
 
 ifdef NO_ICONV
diff --git a/compat/simple-ipc/ipc-shared.c b/compat/simple-ipc/ipc-shared.c
index 1edec8159532..1b9d359ab681 100644
--- a/compat/simple-ipc/ipc-shared.c
+++ b/compat/simple-ipc/ipc-shared.c
@@ -4,7 +4,13 @@
 #include "pkt-line.h"
 #include "thread-utils.h"
 
-#ifdef SUPPORTS_SIMPLE_IPC
+#ifndef SUPPORTS_SIMPLE_IPC
+/*
+ * This source file should only be compiled when Simple IPC is supported.
+ * See the top-level Makefile.
+ */
+#error SUPPORTS_SIMPLE_IPC not defined
+#endif
 
 int ipc_server_run(const char *path, const struct ipc_server_opts *opts,
 		   ipc_server_application_cb *application_cb,
@@ -24,5 +30,3 @@ int ipc_server_run(const char *path, const struct ipc_server_opts *opts,
 
 	return ret;
 }
-
-#endif /* SUPPORTS_SIMPLE_IPC */
diff --git a/compat/simple-ipc/ipc-unix-socket.c b/compat/simple-ipc/ipc-unix-socket.c
index 38689b278df3..1927e6ef4bca 100644
--- a/compat/simple-ipc/ipc-unix-socket.c
+++ b/compat/simple-ipc/ipc-unix-socket.c
@@ -6,8 +6,12 @@
 #include "unix-socket.h"
 #include "unix-stream-server.h"
 
-#ifdef NO_UNIX_SOCKETS
-#error compat/simple-ipc/ipc-unix-socket.c requires Unix sockets
+#ifndef SUPPORTS_SIMPLE_IPC
+/*
+ * This source file should only be compiled when Simple IPC is supported.
+ * See the top-level Makefile.
+ */
+#error SUPPORTS_SIMPLE_IPC not defined
 #endif
 
 enum ipc_active_state ipc_get_active_state(const char *path)
diff --git a/compat/simple-ipc/ipc-win32.c b/compat/simple-ipc/ipc-win32.c
index 8f89c02037e3..8dc7bda087da 100644
--- a/compat/simple-ipc/ipc-win32.c
+++ b/compat/simple-ipc/ipc-win32.c
@@ -4,8 +4,12 @@
 #include "pkt-line.h"
 #include "thread-utils.h"
 
-#ifndef GIT_WINDOWS_NATIVE
-#error This file can only be compiled on Windows
+#ifndef SUPPORTS_SIMPLE_IPC
+/*
+ * This source file should only be compiled when Simple IPC is supported.
+ * See the top-level Makefile.
+ */
+#error SUPPORTS_SIMPLE_IPC not defined
 #endif
 
 static int initialize_pipe_name(const char *path, wchar_t *wpath, size_t alloc)
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 75ed198a6a36..a87841340e6a 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -252,8 +252,15 @@ endif()
 
 if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
 	list(APPEND compat_SOURCES compat/simple-ipc/ipc-shared.c compat/simple-ipc/ipc-win32.c)
+	add_compile_definitions(SUPPORTS_SIMPLE_IPC)
+	set(SUPPORTS_SIMPLE_IPC 1)
 else()
-	list(APPEND compat_SOURCES compat/simple-ipc/ipc-shared.c compat/simple-ipc/ipc-unix-socket.c)
+	# Simple IPC requires both Unix sockets and pthreads on Unix-based systems.
+	if(NOT NO_UNIX_SOCKETS AND NOT NO_PTHREADS)
+		list(APPEND compat_SOURCES compat/simple-ipc/ipc-shared.c compat/simple-ipc/ipc-unix-socket.c)
+		add_compile_definitions(SUPPORTS_SIMPLE_IPC)
+		set(SUPPORTS_SIMPLE_IPC 1)
+	endif()
 endif()
 
 set(EXE_EXTENSION ${CMAKE_EXECUTABLE_SUFFIX})
@@ -974,6 +981,7 @@ file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "X='${EXE_EXTENSION}'\n")
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_GETTEXT='${NO_GETTEXT}'\n")
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "RUNTIME_PREFIX='${RUNTIME_PREFIX}'\n")
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_PYTHON='${NO_PYTHON}'\n")
+file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "SUPPORTS_SIMPLE_IPC='${SUPPORTS_SIMPLE_IPC}'\n")
 if(WIN32)
 	file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "PATH=\"$PATH:$TEST_DIRECTORY/../compat/vcbuild/vcpkg/installed/x64-windows/bin\"\n")
 endif()
diff --git a/simple-ipc.h b/simple-ipc.h
index dc3606e30bd6..2c48a5ee0047 100644
--- a/simple-ipc.h
+++ b/simple-ipc.h
@@ -5,10 +5,6 @@
  * See Documentation/technical/api-simple-ipc.txt
  */
 
-#if defined(GIT_WINDOWS_NATIVE) || !defined(NO_UNIX_SOCKETS)
-#define SUPPORTS_SIMPLE_IPC
-#endif
-
 #ifdef SUPPORTS_SIMPLE_IPC
 #include "pkt-line.h"
 

base-commit: bf949ade81106fbda068c1fdb2c6fd1cb1babe7e
-- 
gitgitgadget
