Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC13C10DCE
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 21:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88E5020780
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 21:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VI9Val5r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgCWVoC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 17:44:02 -0400
Received: from mail-qv1-f73.google.com ([209.85.219.73]:43189 "EHLO
        mail-qv1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbgCWVoA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 17:44:00 -0400
Received: by mail-qv1-f73.google.com with SMTP id h12so6153794qvx.10
        for <git@vger.kernel.org>; Mon, 23 Mar 2020 14:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NM4VxWFJxVfID7wVIFcg2NA8ECmuRaM6FxbEcYtXvyk=;
        b=VI9Val5rcazAVjukgZTBQVlWc5QRzC0LLTDmbYQnZYQtBzF2J7ZEBdZZp0ilgVZT64
         9H+ko57IFLWNjCGkSwz8mdwhJJjK72mNA9Z6D1AvPFxL0CMylO77qqC9QPMdf7GZ6wD7
         1QJF/myJv+X5GckYlTaMfyY8RXt+WYbfKC4p92Op6e2rEod4qMwtFWdOuXSFYp8u+cqb
         bYHp2rx0KIdROGmlSzmhKC2yzfZulGzJFERJr8t5yIP0W5jAzXhru5Kp/ucEYxU7PMDt
         nF7n4WuXRvrHFo221ocWdySJsjGXIWartVyMsfaxs7xGHVqotooryH+dImE49iL01rSs
         3IgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NM4VxWFJxVfID7wVIFcg2NA8ECmuRaM6FxbEcYtXvyk=;
        b=sUpPSHmpDhUXlKt3N8e7W4S79qgSvAu33A2UnQJlh9tQiHJNZ6hc9cFrfrDeX/3DoY
         ktHwUhUTgTz4nvAzY4n7yQ3GOuI3oo3KKqdafZWJcaXSUv3KlCjnTyVIJZYmA6Io+H+h
         cZRnq8xg4D4EkIfewHqx558imbpxu07dtGI+K0KNu/xk8ahiEQ23WSoUDKLtQ7l2kyHc
         FWZ+/khiQVPLwwzg3HOtCCGm2AsDeYc9iwQtsyGX7eWwHIvb5Pb8nCrFbSzB/4hWHBhv
         I65gOpZG3ApIzb7YDCwZlksilkiythmcvREEfpezo3tsJ0QVZGOcc7ju75W7ktOlltst
         lsNQ==
X-Gm-Message-State: ANhLgQ2pqoZNtsf7SXvG+peu4tW2MgXV1JhhYux5UofzDFoxUTaguox7
        BF3atlFwTYFeOclcvpcQp1vGsZEt92llTCQ2X1FfKe5pm6IrTx3FZrQp2PkCHxEEFUcxRoQ9bba
        qByFVKftBfvH7S5Qgxs1vUbKdilUCqqVcbV8kKz0jr5XbcJGr/6P679E8IQ3BEta50R5r3aosSg
        ==
X-Google-Smtp-Source: ADFU+vu9b30XLqCyfcV9AaO7QIdDb3DhId9zO/AsHDHhBy2MDSTG393RkGdHly6bsH+F5ywiNEmOF/8l2xAQw9RvalI=
X-Received: by 2002:a37:9ecc:: with SMTP id h195mr21285916qke.448.1584999839222;
 Mon, 23 Mar 2020 14:43:59 -0700 (PDT)
Date:   Mon, 23 Mar 2020 14:43:40 -0700
In-Reply-To: <20200323214340.182724-1-emilyshaffer@google.com>
Message-Id: <20200323214340.182724-6-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200323214340.182724-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH v10 5/5] bugreport: add compiler info
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To help pinpoint the source of a regression, it is useful to know some
info about the compiler which the user's Git client was built with. By
adding a generic get_compiler_info() in 'compat/' we can choose which
relevant information to share per compiler; to get started, let's
demonstrate the version of glibc if the user built with 'gcc'.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/git-bugreport.txt |  1 +
 bugreport.c                     |  6 ++++++
 compat/compiler.h               | 38 +++++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+)
 create mode 100644 compat/compiler.h

diff --git a/Documentation/git-bugreport.txt b/Documentation/git-bugreport.txt
index 17b0d14e8d..643d1b2884 100644
--- a/Documentation/git-bugreport.txt
+++ b/Documentation/git-bugreport.txt
@@ -27,6 +27,7 @@ The following information is captured automatically:
 
  - 'git version --build-options'
  - uname sysname, release, version, and machine strings
+ - Compiler-specific info string
 
 This tool is invoked via the typical Git setup process, which means that in some
 cases, it might not be able to launch - for example, if a relevant config file
diff --git a/bugreport.c b/bugreport.c
index 1a3172bcec..089b939a87 100644
--- a/bugreport.c
+++ b/bugreport.c
@@ -4,6 +4,7 @@
 #include "strbuf.h"
 #include "time.h"
 #include "help.h"
+#include "compat/compiler.h"
 
 static void get_system_info(struct strbuf *sys_info)
 {
@@ -25,6 +26,11 @@ static void get_system_info(struct strbuf *sys_info)
 			    uname_info.release,
 			    uname_info.version,
 			    uname_info.machine);
+
+	strbuf_addstr(sys_info, _("compiler info: "));
+	get_compiler_info(sys_info);
+	strbuf_addstr(sys_info, _("libc info: "));
+	get_libc_info(sys_info);
 }
 
 static const char * const bugreport_usage[] = {
diff --git a/compat/compiler.h b/compat/compiler.h
new file mode 100644
index 0000000000..ce6a7f6de9
--- /dev/null
+++ b/compat/compiler.h
@@ -0,0 +1,38 @@
+#ifndef COMPILER_H
+#define COMPILER_H
+
+#include "git-compat-util.h"
+#include "strbuf.h"
+
+#ifdef __GLIBC__
+#include <gnu/libc-version.h>
+#endif
+
+static inline void get_compiler_info(struct strbuf *info)
+{
+	int len = info->len;
+#ifdef __GNUC__
+	strbuf_addf(info, "gnuc: %d.%d\n", __GNUC__, __GNUC_MINOR__);
+#endif
+
+#ifdef _MSC_VER
+	strbuf_addf(info, "MSVC version: %s\n", _MSC_FULL_VER);
+#endif
+
+	if (len == info->len)
+		strbuf_addstr(info, _("no compiler information available\n"));
+}
+
+static inline void get_libc_info(struct strbuf *info)
+{
+	int len = info->len;
+
+#ifdef __GLIBC__
+	strbuf_addf(info, "glibc: %s\n", gnu_get_libc_version());
+#endif
+
+	if (len == info->len)
+		strbuf_addstr(info, _("no libc information available\n"));
+}
+
+#endif /* COMPILER_H */
-- 
2.25.1.696.g5e7596f4ac-goog

