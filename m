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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FADC433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 14:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B49656100A
	for <git@archiver.kernel.org>; Thu, 20 May 2021 14:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbhETOXx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 10:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbhETOXw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 10:23:52 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3F1C061574
        for <git@vger.kernel.org>; Thu, 20 May 2021 07:22:31 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id a4so17911318wrr.2
        for <git@vger.kernel.org>; Thu, 20 May 2021 07:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2Ig5KjX0GlEKL4ecNkTzcJAUQ5y8LbRj/GlkVLTEQBU=;
        b=pUYVYanSELzERwf4Q+E3PsOsvpq9sM3tbTrqqjL14gadM1+7njWEyCrdZsYRBMD4lm
         FNae5u+xkqZ3+nv3hLfyBix6AcPHICfG5nYVdz42g9RyvYeNzEh2kMKXm1afcu+McAo6
         QE7eJq0OIRP6X4gXeyCj+mPLHTz1RKcfmK18IcYJigtxp89w4Go9OIYG8CFbXN2osGOJ
         hVhU1Evd4RSEA8quz39PbZhWc3AiRWmFUHnLGvKCSryRRUfZA5Y6iU1U4QNHAEAmvA7g
         Lh4qg7YsIKd9Zdj6u7OUgegFR2eDIISrGrju+wmOjgUN5Ax02PtaWhZm4u0eZEdBp4D0
         Y1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2Ig5KjX0GlEKL4ecNkTzcJAUQ5y8LbRj/GlkVLTEQBU=;
        b=n5kXfTTw/b4h9mz4CUXe0+kZuh07ZcGJV2rpq7Wgfuz2l2X3gNODvHP9MASOC1ycAN
         uyGaYXNLStp9+JZ2E1sVrJSez10AHHVye+gSfXxClXSo7Z2o3dianH/Tofvm1wcFP/iB
         Og6IVgkk+XO3h1T1PHTSWsnD4HSTlDXYEhbz/O7eepeFa6WzB6hEmA/n2kLICWB9sXtU
         +P/LSazhtu8yiOBE5GPk1u4IsVQNlXJcChZ2we8yVQ6kiB0C7heprmCxWrvYWD7NaTff
         idLH1cfC0NSDDx35L/MWyE4tqzeRrJXy4s5rHuEFVVtDca7VjXLL5wNzkHB2irrSQGRF
         l4bg==
X-Gm-Message-State: AOAM532AKG0ga4KLJY6H5hfaqQVjHZ8Kn7IkuubmrN2iCCfjgpqoIqKK
        gv82rIEmX9HALx8didD/km5yYI5eR0Y=
X-Google-Smtp-Source: ABdhPJx/3uaI9+uC+jsoGBlyo1uRk7CtRC3lzlR5P+4eoujZbLN2Zgh00Hqm3Nyg7p55vrsO9xaOKQ==
X-Received: by 2002:adf:9c93:: with SMTP id d19mr1694879wre.17.1621520549680;
        Thu, 20 May 2021 07:22:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n189sm2851736wme.9.2021.05.20.07.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 07:22:28 -0700 (PDT)
Message-Id: <pull.955.v2.git.1621520547726.gitgitgadget@gmail.com>
In-Reply-To: <pull.955.git.1621352192238.gitgitgadget@gmail.com>
References: <pull.955.git.1621352192238.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 20 May 2021 14:22:27 +0000
Subject: [PATCH v2] simple-ipc: correct ifdefs when NO_PTHREADS is defined
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
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
    
    Here is V2 of this fixup. I've removed the whole file ifdefs and
    replaced them with a simple #ifndef/#error/#endif as a warning.
    
    Jeff

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-955%2Fjeffhostetler%2Ffixup-simple-ipc-no-pthreads-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-955/jeffhostetler/fixup-simple-ipc-no-pthreads-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/955

Range-diff vs v1:

 1:  4adcf35ea6e4 ! 1:  119412f52ff5 simple-ipc: correct ifdefs when NO_PTHREADS is defined
     @@ Makefile: ifdef NO_UNIX_SOCKETS
      -	LIB_OBJS += compat/simple-ipc/ipc-unix-socket.o
       endif
       
     -+# Simple-ipc requires threads and platform-specific IPC support.
     -+# (We group all Unix variants in the top-level else because Windows
     -+# also defines NO_UNIX_SOCKETS.)
     ++# Simple IPC requires threads and platform-specific IPC support.
     ++# Only platforms that have both should include these source files
     ++# in the build.
     ++#
     ++# On Windows-based systems, Simple IPC requires threads and Windows
     ++# Named Pipes.  These are always available, so Simple IPC support
     ++# is optional.
     ++#
     ++# On Unix-based systems, Simple IPC requires pthreads and Unix
     ++# domain sockets.  So support is only enabled when both are present.
     ++#
       ifdef USE_WIN32_IPC
      +	BASIC_CFLAGS += -DSUPPORTS_SIMPLE_IPC
       	LIB_OBJS += compat/simple-ipc/ipc-shared.o
     @@ Makefile: ifdef NO_UNIX_SOCKETS
       
       ifdef NO_ICONV
      
     + ## compat/simple-ipc/ipc-shared.c ##
     +@@
     + #include "pkt-line.h"
     + #include "thread-utils.h"
     + 
     +-#ifdef SUPPORTS_SIMPLE_IPC
     ++#ifndef SUPPORTS_SIMPLE_IPC
     ++/*
     ++ * This source file should only be compiled when Simple IPC is supported.
     ++ * See the top-level Makefile.
     ++ */
     ++#error SUPPORTS_SIMPLE_IPC not defined
     ++#endif
     + 
     + int ipc_server_run(const char *path, const struct ipc_server_opts *opts,
     + 		   ipc_server_application_cb *application_cb,
     +@@ compat/simple-ipc/ipc-shared.c: int ipc_server_run(const char *path, const struct ipc_server_opts *opts,
     + 
     + 	return ret;
     + }
     +-
     +-#endif /* SUPPORTS_SIMPLE_IPC */
     +
       ## compat/simple-ipc/ipc-unix-socket.c ##
      @@
       #include "unix-socket.h"
       #include "unix-stream-server.h"
       
     -+#ifdef SUPPORTS_SIMPLE_IPC
     -+
     - #ifdef NO_UNIX_SOCKETS
     - #error compat/simple-ipc/ipc-unix-socket.c requires Unix sockets
     +-#ifdef NO_UNIX_SOCKETS
     +-#error compat/simple-ipc/ipc-unix-socket.c requires Unix sockets
     ++#ifndef SUPPORTS_SIMPLE_IPC
     ++/*
     ++ * This source file should only be compiled when Simple IPC is supported.
     ++ * See the top-level Makefile.
     ++ */
     ++#error SUPPORTS_SIMPLE_IPC not defined
       #endif
       
     -+#ifdef NO_PTHREADS
     -+#error compat/simple-ipc/ipc-unix-socket.c requires pthreads
     -+#endif
     -+
       enum ipc_active_state ipc_get_active_state(const char *path)
     - {
     - 	enum ipc_active_state state = IPC_STATE__OTHER_ERROR;
     -@@ compat/simple-ipc/ipc-unix-socket.c: void ipc_server_free(struct ipc_server_data *server_data)
     - 	free(server_data->fifo_fds);
     - 	free(server_data);
     - }
     -+
     -+#endif /* SUPPORTS_SIMPLE_IPC */
      
       ## compat/simple-ipc/ipc-win32.c ##
      @@
       #include "pkt-line.h"
       #include "thread-utils.h"
       
     -+#ifdef SUPPORTS_SIMPLE_IPC
     -+
     - #ifndef GIT_WINDOWS_NATIVE
     - #error This file can only be compiled on Windows
     +-#ifndef GIT_WINDOWS_NATIVE
     +-#error This file can only be compiled on Windows
     ++#ifndef SUPPORTS_SIMPLE_IPC
     ++/*
     ++ * This source file should only be compiled when Simple IPC is supported.
     ++ * See the top-level Makefile.
     ++ */
     ++#error SUPPORTS_SIMPLE_IPC not defined
       #endif
     -@@ compat/simple-ipc/ipc-win32.c: void ipc_server_free(struct ipc_server_data *server_data)
       
     - 	free(server_data);
     - }
     -+
     -+#endif /* SUPPORTS_SIMPLE_IPC */
     + static int initialize_pipe_name(const char *path, wchar_t *wpath, size_t alloc)
      
       ## simple-ipc.h ##
      @@


 Makefile                            | 22 ++++++++++++++++++++--
 compat/simple-ipc/ipc-shared.c      | 10 +++++++---
 compat/simple-ipc/ipc-unix-socket.c |  8 ++++++--
 compat/simple-ipc/ipc-win32.c       |  8 ++++++--
 simple-ipc.h                        |  4 ----
 5 files changed, 39 insertions(+), 13 deletions(-)

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
