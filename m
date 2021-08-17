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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B4CC4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 08:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6499460F41
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 08:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235048AbhHQIX5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 04:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234706AbhHQIXw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 04:23:52 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D38C061764
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 01:23:19 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id t66so22199991qkb.0
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 01:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PRSz4/DxAyBClWGxfeI4a88HBSljvVMGbkdUWujLKZ0=;
        b=muqLz3p60tPLgjRAAH05JKw2kuyt0oe0pJ4C3i/r6jU/nPxRXKbf3NuOWTjg7UIn57
         2SwJgQFvepxy+WvrqX06fiVP2YUDE7ISxCRcxw/RrCWslmQ5y82bP5bMOCPGSGd7ublI
         2TuNq+88ZHvUMWcRr9wFDxu7TEYD9cc6MX+4IjdRZYx2I1qwE/HcjQCFjlvmyqlvE1Oz
         +Oek4X9NmMQ+UM7UAZjRVETn4pabIl5kjXggYGf0YRqEZdG549EAWLrWI29cpssHl5wA
         6qMYY7RT9MFSmNr4ZV9VufiEB0B7H6+nErmlpJSx1z0qobMR97FLaMAsvlNC30AlXCbr
         O3rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PRSz4/DxAyBClWGxfeI4a88HBSljvVMGbkdUWujLKZ0=;
        b=Pkhib9ow3qdc4SWv88PBOADg4DOanhX5C+43IQfwThZYU65rYdzETWLCCFRRN6fNTM
         EhzMHebNjpAeyZLIMyv/8qKzgueYOXwxI09NsITT4dVRvfGYtSxZ3iTTvFKKy3qJEpge
         MkNmgKfP/TxuKDSn2dbjz/RO/zaG2X8FNzJRCxYUP8Daf5+tnyyWD0vjiEkmjb76EueG
         yv/ONqFZNQTUFexuZuyQgTWMhtwkFPajurHaUy7RcncHg74hyajD2GDmu39tG/ajd02G
         JZsEWobJ9nq9t4iwV+BM00+4L8ED3Tq6a6DwJwrBK2KLKzN1oYuAmuHnEZqLURxBm3XN
         WjMQ==
X-Gm-Message-State: AOAM531nCFnIcjGJYiFacJFdxiym4YyToZZWo7Ai1L55vGcOGIlUDAf4
        YrUvije5sykmL+sJWoE9yIpO7PNGF+0=
X-Google-Smtp-Source: ABdhPJz6Pf8KAutqLt0LaMDj1rAcJiF/EjEevjyTR+TQDN5BZzM4NgjAriN1q2NufVvABNGkxpwaDw==
X-Received: by 2002:a05:620a:811:: with SMTP id s17mr2566725qks.350.1629188598877;
        Tue, 17 Aug 2021 01:23:18 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id v7sm943454qkd.41.2021.08.17.01.23.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Aug 2021 01:23:18 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [RFC PATCH] fsmonitor: fix building with NO_PTHREADS
Date:   Tue, 17 Aug 2021 01:23:10 -0700
Message-Id: <20210817082310.2157-1-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.476.gf000ecbed9
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

something similar will be needed for the NO_UNIX_SOCKETS, since the
system setting for support of FSMONITOR_DAEMON_BACKEND is not enough
to cover for the code dependencies.

alternatively FSMONITOR_DAEMON_BACKEND could be used to imply support
was requested AND code dependencies are covered, but this setup at
least allows for building and uses the "mock" implementation.

since the enum is needed for the fallback code, had to be moved outside
of the #ifdef

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 Makefile     |  2 ++
 simple-ipc.h | 14 +++++++-------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index 987677e882..752ec7ccd9 100644
--- a/Makefile
+++ b/Makefile
@@ -1969,10 +1969,12 @@ ifdef NEED_ACCESS_ROOT_HANDLER
 	COMPAT_OBJS += compat/access.o
 endif
 
+ifndef NO_PTHREADS
 ifdef FSMONITOR_DAEMON_BACKEND
 	COMPAT_CFLAGS += -DHAVE_FSMONITOR_DAEMON_BACKEND
 	COMPAT_OBJS += compat/fsmonitor/fsmonitor-fs-listen-$(FSMONITOR_DAEMON_BACKEND).o
 endif
+endif
 
 ifeq ($(TCLTK_PATH),)
 NO_TCLTK = NoThanks
diff --git a/simple-ipc.h b/simple-ipc.h
index 9c7330fcda..b396293bdf 100644
--- a/simple-ipc.h
+++ b/simple-ipc.h
@@ -5,13 +5,6 @@
  * See Documentation/technical/api-simple-ipc.txt
  */
 
-#ifdef SUPPORTS_SIMPLE_IPC
-#include "pkt-line.h"
-
-/*
- * Simple IPC Client Side API.
- */
-
 enum ipc_active_state {
 	/*
 	 * The pipe/socket exists and the daemon is waiting for connections.
@@ -43,6 +36,13 @@ enum ipc_active_state {
 	IPC_STATE__OTHER_ERROR,
 };
 
+#ifdef SUPPORTS_SIMPLE_IPC
+#include "pkt-line.h"
+
+/*
+ * Simple IPC Client Side API.
+ */
+
 struct ipc_client_connect_options {
 	/*
 	 * Spin under timeout if the server is running but can't
-- 
2.33.0.476.gf000ecbed9

