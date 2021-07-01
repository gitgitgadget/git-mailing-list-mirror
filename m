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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07726C11F67
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 14:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E994F6141C
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 14:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbhGAOue (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 10:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbhGAOuZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 10:50:25 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8F3C0613DD
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 07:47:54 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id u8-20020a7bcb080000b02901e44e9caa2aso4264355wmj.4
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 07:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pIwm/Gno09dspEBpdqAIIGCyt0/sJ9C5U74NilrVyV4=;
        b=ku0veBi14TP2PhJ5xq0vct6YMnKsbn5mz5RbSa9UjPZifnUO6DwVBr1hgDRaK+JaNs
         Y99i1udoya2PywH1jCxG9w0QqFr/C4dEwc+poEKYfiQ9pzrXrpePIV4hyvu1+XfaKvGu
         8Xh0Ixzfd+Q7DHMR7cW2VwpkVgq0m0eD8g6RuJsZpGPjuC31ZOaRcL0I1hcdX2x71AYT
         qNQIFVDUCpvv9sByxbT72z2FBTiH7a5s+cDS5MNWEFNEUwfcBR5e3BzBpVnO29RWhKCI
         DOY2/1Pks86Ms80fl/6VIy4KPfHlqz3hLpOsfYGPUl6CnAeDRqFdudi4jTmC947t7Q2L
         BWWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pIwm/Gno09dspEBpdqAIIGCyt0/sJ9C5U74NilrVyV4=;
        b=Jv+IHB+HCkc3BpW/cE0sq+hqsvGU7sGeb0ntnlQ64b1q/Enavc5WFj48gSJl6HBe4D
         l7KC/QAiqK+pfn/OYererduHeReJ4DbmmxIq3X1DNH2zzWIRpdOmlYuxlwLnqrr+DucC
         AHeDvUo7IFV06Mklx7bAvQ/ZuSr7hCQCI/qUE6i3XBVKf/aI8Ukikpop8a45YDn5lIEI
         WybiwrWq6pgn1xdmZcx4ZxtUbQVcRYH+/bfqcc5HXVfbGwkKt5ClQmxKgzPM6Qpz/uZC
         B8aX7xKDQ+9RdTvj1D0sDvZUXWI/EnZZ1/GGLMm2UpTps+DncCTPlx9pRCudZtv6cnSd
         c5mw==
X-Gm-Message-State: AOAM533/Nwkgfuvdv1hfK9C7HR+gsilcq5eZAZF2eFmFlAdAv/zn7xQo
        qTETlo3W4+FqlfJ9qbTVkQjdYvOU7gQ=
X-Google-Smtp-Source: ABdhPJz9bg5ihLnDgmE0EMtqJ0GHAXCDT7e5YwYWr5uLlPNSm1f82f0+QaGR9M65KJvHS3KTh6eU7w==
X-Received: by 2002:a7b:c0d6:: with SMTP id s22mr11149922wmh.52.1625150872730;
        Thu, 01 Jul 2021 07:47:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n29sm9382812wms.34.2021.07.01.07.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 07:47:52 -0700 (PDT)
Message-Id: <587580489473a7a2ad665bdf3c482ea5d2c54f61.1625150864.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
        <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Jul 2021 14:47:22 +0000
Subject: [PATCH v3 12/34] fsmonitor-fs-listen-macos: stub in backend for MacOS
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
index 00000000000..b91058d1c4f
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
index fcd88b60b14..394355463e1 100644
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
index 1ab94eb284f..aa80671045a 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -266,6 +266,9 @@ endif()
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

