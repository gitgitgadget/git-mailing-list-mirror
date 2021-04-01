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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E68C43461
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 18:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A83F06112E
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 18:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237575AbhDASD5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Apr 2021 14:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237017AbhDAR7U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Apr 2021 13:59:20 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77024C0225BE
        for <git@vger.kernel.org>; Thu,  1 Apr 2021 08:41:14 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id j7so2288683wrd.1
        for <git@vger.kernel.org>; Thu, 01 Apr 2021 08:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=j8mRvxrP6D8rCyINcmWGLVKTxfMVEXKp6wmZZ3hVF0I=;
        b=HYaMKjXWdJ2lvC/zfMxYmyw9tFa7hK/9DKNY+IBQgcrA/XO97kSISyo8G+gxrQNzYH
         fHBR+pnGyEtfKVM7XiGwG8ayS+RtsFIfxbSH2aFlmSJryiUmaQieD6sJWZzRdvGApO/G
         0ytukgUHQ/3xgoQnVZsszsOCJWozYQXGM+AAWE0TJWQt0nEXDbiG3y9l0ElrtanomIPl
         cz6bSgDzj/X3BzUfvgiAbUyFTbMtaTdE3Qlog/iodsUTdeXO/WVDH56FTMrYpczGajc9
         HYMc3nhbK40qbk+kMx+6RdwWsp4uU6WXRZ0R7sxaM+Jc5WtVIjR/6vWruJ3k3fDjQVGc
         XLEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=j8mRvxrP6D8rCyINcmWGLVKTxfMVEXKp6wmZZ3hVF0I=;
        b=RbcX+l9oZVCtrk1YfhMepADHCOF1+ALEA+Euis8AeFPJXfgpyFQkNJXDmqU8pxytIl
         e2wi7h7j8pvzss30X7pUesngYxjIG28kfw9UUC2QVoKrk8JC+iVwJ0ZPzD29QuPlvPS6
         LQPwG5N9b5CcPq7XrIp2I0PIPEZ0+BdthuxyzrsnjVPueDyXfuS1lCja7mVIebuqtRG7
         RmohdVxeuAmEWzuJPbkhoEl+ILkE4yN+ZFndfAQ9O3AXlU4hy1GBOB0LXtge9LLXLpDX
         f1u/dJehgchKvg+H8AuDCs9VGcLB5MhWmLwf/8LfTR+1t0wZXbTabtbQsrcF8IFoigf4
         anHg==
X-Gm-Message-State: AOAM533/69E8yuT7T3b+5kxJiyFeEe8M45g619j2UJdL9EF3cqkLVb3S
        69VTi6RQ4qwc3fcpod9xCZElKmxrXGQ=
X-Google-Smtp-Source: ABdhPJzXBTv90f/nvbEI/Ix9OsAoz5/Wm3O5NyOd/ZnhAmPVw70cgGi644ge4SLNkJzCuvHLpMeYFA==
X-Received: by 2002:adf:e4c7:: with SMTP id v7mr10527138wrm.245.1617291673224;
        Thu, 01 Apr 2021 08:41:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e13sm12546714wrg.72.2021.04.01.08.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 08:41:12 -0700 (PDT)
Message-Id: <a84dee24e13ebf93488a9258d7324387721f3833.1617291666.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.git.1617291666.gitgitgadget@gmail.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Apr 2021 15:40:50 +0000
Subject: [PATCH 08/23] fsmonitor-fs-listen-macos: stub in backend for MacOS
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

Stub in empty implementation of fsmonitor--daemon
backend for MacOS.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 compat/fsmonitor/fsmonitor-fs-listen-macos.c | 20 ++++++++++++++++++++
 config.mak.uname                             |  2 ++
 contrib/buildsystems/CMakeLists.txt          |  3 +++
 3 files changed, 25 insertions(+)
 create mode 100644 compat/fsmonitor/fsmonitor-fs-listen-macos.c

diff --git a/compat/fsmonitor/fsmonitor-fs-listen-macos.c b/compat/fsmonitor/fsmonitor-fs-listen-macos.c
new file mode 100644
index 000000000000..b91058d1c4f8
--- /dev/null
+++ b/compat/fsmonitor/fsmonitor-fs-listen-macos.c
@@ -0,0 +1,20 @@
+#include "cache.h"
+#include "fsmonitor.h"
+#include "fsmonitor-fs-listen.h"
+
+int fsmonitor_fs_listen__ctor(struct fsmonitor_daemon_state *state)
+{
+	return -1;
+}
+
+void fsmonitor_fs_listen__dtor(struct fsmonitor_daemon_state *state)
+{
+}
+
+void fsmonitor_fs_listen__stop_async(struct fsmonitor_daemon_state *state)
+{
+}
+
+void fsmonitor_fs_listen__loop(struct fsmonitor_daemon_state *state)
+{
+}
diff --git a/config.mak.uname b/config.mak.uname
index fcd88b60b14a..394355463e1e 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -147,6 +147,8 @@ ifeq ($(uname_S),Darwin)
 			MSGFMT = /usr/local/opt/gettext/bin/msgfmt
 		endif
 	endif
+	FSMONITOR_DAEMON_BACKEND = macos
+	BASIC_LDFLAGS += -framework CoreServices
 endif
 ifeq ($(uname_S),SunOS)
 	NEEDS_SOCKET = YesPlease
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 727cfd561169..341a85e7bfc9 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -255,6 +255,9 @@ endif()
 if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
 	add_compile_definitions(HAVE_FSMONITOR_DAEMON_BACKEND)
 	list(APPEND compat_SOURCES compat/fsmonitor/fsmonitor-fs-listen-win32.c)
+elseif(CMAKE_SYSTEM_NAME STREQUAL "Darwin")
+	add_compile_definitions(HAVE_FSMONITOR_DAEMON_BACKEND)
+	list(APPEND compat_SOURCES compat/fsmonitor/fsmonitor-fs-listen-macos.c)
 endif()
 
 set(EXE_EXTENSION ${CMAKE_EXECUTABLE_SUFFIX})
-- 
gitgitgadget

