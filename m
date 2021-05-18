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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51435C433B4
	for <git@archiver.kernel.org>; Tue, 18 May 2021 15:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B0D4600EF
	for <git@archiver.kernel.org>; Tue, 18 May 2021 15:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350218AbhERPhz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 11:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350164AbhERPhz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 11:37:55 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB144C061573
        for <git@vger.kernel.org>; Tue, 18 May 2021 08:36:34 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id b19-20020a05600c06d3b029014258a636e8so1718232wmn.2
        for <git@vger.kernel.org>; Tue, 18 May 2021 08:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=MJHleCLYhnNWHRsQPADJ0ZmLZbdvap8Ocm/r43IT3WQ=;
        b=HPzmXY3BEfCmgplIH8k5Tss4Do18wMH7TuEc0sB/hEuxvD/sp6NmZRTZEDCjMNKFBL
         NwXqS8qQ6PxSQknr0EQovnCsuIvll9e49/FMcyEPuInw0ogZwM5sE1j4CdXgT29nHVKF
         Ah6bhr64/yRnJQGXhv3PGNjZHjVxSwiA6BpWroTk8GXnWtMaQN5t8D/YQVtJf7+TSION
         DMPJAt9w+eKb5wdew1s0M5ky6i3GMpxtSXeainKZB830dbH0hnm0byn66hheZA7GTTFF
         FlK+7fAxNwgxigFxcc1vKc9flp75EBhNnpsPhS+6d5rPrnD2MkgVkfGvPuUhg600IQ+c
         dfeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MJHleCLYhnNWHRsQPADJ0ZmLZbdvap8Ocm/r43IT3WQ=;
        b=LAU4Esx512c3nM6OeUdShY8kUHlUkUavxB8+s7xHYpDMoPVkhfl2BIbVKQBDxu8ZkV
         xF5dIgiRgSABybGgUY394CAzgMHZjJ+70R+HerWspoh44vl8cUenWNpj6iQB4m6i6493
         aX+qZZbcA5NRXysIEpDJV4C4aZs92ZfWPDSnakaEH8ixhNsw5gOe00BEUXkAX9xstCWs
         +nZo0lf6nnECMkENzPADXEjZeVaDBxSnkep9wEks2NBn+iqvRH4zrVxAJnOFc+88RwVr
         ozen1TyloHhl5XMqcfnDiOQX8ExtGXX75zxpPpexDNmrSllVVrZYS+rc9NTxIZujzTP0
         2AHA==
X-Gm-Message-State: AOAM530Z4E29cy/aw4SYL9eovxls2lgFRk0shGvjAJibhRHf6vfDc/KE
        OPM6kQ1Iif9zy8IMnQH3coOTZoJXjqY=
X-Google-Smtp-Source: ABdhPJwrChLQVCtZWFRS2yqwuDMJX6lW9VepVErrdBvnG2Z6coHQibA0saJCQCr7aQ+XWjK8z5XQ9A==
X-Received: by 2002:a05:600c:2e42:: with SMTP id q2mr6301667wmf.64.1621352193480;
        Tue, 18 May 2021 08:36:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a17sm14049656wrt.53.2021.05.18.08.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 08:36:32 -0700 (PDT)
Message-Id: <pull.955.git.1621352192238.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 18 May 2021 15:36:31 +0000
Subject: [PATCH] simple-ipc: correct ifdefs when NO_PTHREADS is defined
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
    
    Simple IPC always requires threads (in addition to various
    platform-specific IPC support). Fix the ifdefs in the Makefile to define
    SUPPORTS_SIMPLE_IPC when appropriate.
    
    Previously, the Unix version of the code would only verify that Unix
    domain sockets were available.
    
    This problem was reported here:
    https://lore.kernel.org/git/YKN5lXs4AoK%2FJFTO@coredump.intra.peff.net/T/#m08be8f1942ea8a2c36cfee0e51cdf06489fdeafc
    
    Reported-by: Randall S. Becker rsbecker@nexbridge.com Helped-by: Jeff
    King peff@peff.net Signed-off-by: Jeff Hostetler jeffhost@microsoft.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-955%2Fjeffhostetler%2Ffixup-simple-ipc-no-pthreads-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-955/jeffhostetler/fixup-simple-ipc-no-pthreads-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/955

 Makefile                            | 14 ++++++++++++--
 compat/simple-ipc/ipc-unix-socket.c |  8 ++++++++
 compat/simple-ipc/ipc-win32.c       |  4 ++++
 simple-ipc.h                        |  4 ----
 4 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 3a2d3c80a81a..30df67fd62eb 100644
--- a/Makefile
+++ b/Makefile
@@ -1687,13 +1687,23 @@ ifdef NO_UNIX_SOCKETS
 else
 	LIB_OBJS += unix-socket.o
 	LIB_OBJS += unix-stream-server.o
-	LIB_OBJS += compat/simple-ipc/ipc-shared.o
-	LIB_OBJS += compat/simple-ipc/ipc-unix-socket.o
 endif
 
+# Simple-ipc requires threads and platform-specific IPC support.
+# (We group all Unix variants in the top-level else because Windows
+# also defines NO_UNIX_SOCKETS.)
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
diff --git a/compat/simple-ipc/ipc-unix-socket.c b/compat/simple-ipc/ipc-unix-socket.c
index 38689b278df3..c23b17973983 100644
--- a/compat/simple-ipc/ipc-unix-socket.c
+++ b/compat/simple-ipc/ipc-unix-socket.c
@@ -6,10 +6,16 @@
 #include "unix-socket.h"
 #include "unix-stream-server.h"
 
+#ifdef SUPPORTS_SIMPLE_IPC
+
 #ifdef NO_UNIX_SOCKETS
 #error compat/simple-ipc/ipc-unix-socket.c requires Unix sockets
 #endif
 
+#ifdef NO_PTHREADS
+#error compat/simple-ipc/ipc-unix-socket.c requires pthreads
+#endif
+
 enum ipc_active_state ipc_get_active_state(const char *path)
 {
 	enum ipc_active_state state = IPC_STATE__OTHER_ERROR;
@@ -997,3 +1003,5 @@ void ipc_server_free(struct ipc_server_data *server_data)
 	free(server_data->fifo_fds);
 	free(server_data);
 }
+
+#endif /* SUPPORTS_SIMPLE_IPC */
diff --git a/compat/simple-ipc/ipc-win32.c b/compat/simple-ipc/ipc-win32.c
index 8f89c02037e3..958bb562ebb6 100644
--- a/compat/simple-ipc/ipc-win32.c
+++ b/compat/simple-ipc/ipc-win32.c
@@ -4,6 +4,8 @@
 #include "pkt-line.h"
 #include "thread-utils.h"
 
+#ifdef SUPPORTS_SIMPLE_IPC
+
 #ifndef GIT_WINDOWS_NATIVE
 #error This file can only be compiled on Windows
 #endif
@@ -749,3 +751,5 @@ void ipc_server_free(struct ipc_server_data *server_data)
 
 	free(server_data);
 }
+
+#endif /* SUPPORTS_SIMPLE_IPC */
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
