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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2BFC2B9F2
	for <git@archiver.kernel.org>; Sat, 22 May 2021 13:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E4FE6115C
	for <git@archiver.kernel.org>; Sat, 22 May 2021 13:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbhEVN6w (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 May 2021 09:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbhEVN6o (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 May 2021 09:58:44 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF6CC0613ED
        for <git@vger.kernel.org>; Sat, 22 May 2021 06:57:19 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id r12so23725670wrp.1
        for <git@vger.kernel.org>; Sat, 22 May 2021 06:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MDWyQXyPSbGQR7L5DYZ6zArCYtfAnkfQdw8AWvttV1o=;
        b=NF7q99ILxmgYdpvhRaMJAOG5mD6IWkeSFrvsu4t7tQKqpeDmczdHRuf0OOk32tBGGF
         NMYGu/qWJfNJAp+p2tqzk4KYcniX1WeA2Gy9LYbN7TVC0BZCdGMSgN0k11wOQtAcMmaF
         L8Arts8LR41lIk6SpfVmsytfRAG4knZZM7N+diPcT6+eyutKJ4a+lgDJ7LEfEyLDHZke
         yy5kOuKc3qKld1MKN0NpRuihAnYzTT45l8RINOOEmNLiOP5PasLJhibkQfRflRboFdxM
         CwGCLbdt3e+8w+87WSlyGGHNjJXjfVFFiUBM+7kmDaJUJfIW+vyDmNLbER3DNB9BIKeo
         2QIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MDWyQXyPSbGQR7L5DYZ6zArCYtfAnkfQdw8AWvttV1o=;
        b=IZWrof77LYImudq4j2M9mEE0o1O17bIID+IwNoo/VYG5iQpZUBGcFQFo542PiSWlZS
         e+o7cdESr8IibcwmZBFO6cppUTUSLcdBp5gy9/ZiPKPd8HY+wZYMIp2CJEoGbZYOklrV
         Wu468vcweaw9KETMm7omDMMpJG061ERVRwPh9eh3zSkTK2LlcQKsoBt9IX9uKE5i0K52
         2GuvR9qWwn3charGra9LM922ljSGhxhOsjVTu+S5lql5FV71N1++qu+jXT6jMC2MQISv
         iG5k87CteZawI7IJ8tfk83Ecloj7UvQ5ImS/mPgMlwz6bXnk2/63xeS+q00b91fnRnj5
         2G4A==
X-Gm-Message-State: AOAM530g5uhVG8l80qXY9WA7kswPjcPigjzQtSbyfKafirYckB3HD0+q
        6PIX7+xrKVDDD9aHjBgvP+LbO8iLsiw=
X-Google-Smtp-Source: ABdhPJw6w5KGWfs8lRlVfARZtT3hlTrWESu30gCqS9dbcuctHNoe7Oe31GKLbRixefI8xeERvydQ6g==
X-Received: by 2002:adf:d20a:: with SMTP id j10mr13842963wrh.188.1621691838204;
        Sat, 22 May 2021 06:57:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v10sm6670768wrq.0.2021.05.22.06.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 May 2021 06:57:17 -0700 (PDT)
Message-Id: <2aa85151f03c31989e3b11979711220d05f42b1a.1621691828.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
        <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 22 May 2021 13:56:51 +0000
Subject: [PATCH v2 12/28] fsmonitor-fs-listen-macos: stub in backend for MacOS
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
index 4e812462d955..22dec4600431 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -259,6 +259,9 @@ endif()
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

