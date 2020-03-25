Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537D7C43331
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 21:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BA1820719
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 21:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S4NDdR5Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbgCYVZ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 17:25:26 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:32977 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727384AbgCYVZZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 17:25:25 -0400
Received: by mail-pg1-f202.google.com with SMTP id 33so2887832pgn.0
        for <git@vger.kernel.org>; Wed, 25 Mar 2020 14:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=N3pZla9aBbZ6D9pNUDwjw2gRD2aRL0fqGUvgcrhCMDY=;
        b=S4NDdR5Y6F6rHr3WOL/y5rt1Qkn/LiixycI5+lLts4KuDhWaMW0sdloNqEHtK0uLRI
         Vmel2JeeYdo29/BdqCGfBVaDLNVYsRXSy7+BMIFzxBiOpbONvn5aKZCpqpZmu5cuERTq
         m66NPv61szLIrRZpPqdB4oDbilduhi4bb0JugVYUkQepP0nYd0Mkte66+ADNY99sWLRQ
         w8keSMWs+ioB21Hbou/b0EmbLmZI+jVFG+virtH+ln5GwKbR6KXZKmhpvknLFU48jrot
         FZ1ESKgM1HQHuE7dtbkejYYsFYaXuCuTOOsVE0WxbrFJAQnOdYlbalHvqMuG++OHP89l
         aUYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=N3pZla9aBbZ6D9pNUDwjw2gRD2aRL0fqGUvgcrhCMDY=;
        b=kEXcjLd1DAvmWZuD1fo3mK1v7Qg2o0+pr5f32Piq1jRP/VlD9CGAd9Uu2sa62Lrqqb
         eNRbWHrhXSxfrho/AL1O1lpR7mWYLN/p9ntDnU6Ll1sXJ+UxRGa6659nsEKVeRkSW99Z
         UrnrIEXXcrt2+EqXzz6XEwGCow9rg8xtn+ABni3bXS6ZNHv1qHGIIlGhphBpY9ZaikrO
         hAokkPWQymP335GL2uwE8xkDfxgVKaE3k+2jobu5nCbO/SSz8zsVZSYDzG5zy8Ku8ebw
         1ptXJGbEE/8dLPtNTd58+r0/8+ibCo/RJQrN0z+WMDjb1THrNsYJd8jWaNN0EZBqb3SA
         2gJw==
X-Gm-Message-State: ANhLgQ3xcjshX8GveUt0gsp0jWX6QaaUB8nJzZbLQRCjy5IvX0CcVV6Z
        Fstnu5IAuZyd/c5cMcXdhOMsHaja0pzMDJ1nn+/RRz/IbMXWmfaq+V6fwV1o1kD0f7ZY0JR98ON
        BQy7d7V0FDX9zCUfZsLpCn3SFShOKigw3zQ+x89fKLnVRt5LPDUN9425wWrX6Qfutr3MZx0dS9w
        ==
X-Google-Smtp-Source: ADFU+vtgC9MJuP6wkSTZLQaoDyDtBTZnIrBAI53Jh94EpWnkSAlYB712c/3i8/VU0XZbo/a2g/y5EhfOHnLU9Q6sRrA=
X-Received: by 2002:a17:90a:9e9:: with SMTP id 96mr5836242pjo.168.1585171524131;
 Wed, 25 Mar 2020 14:25:24 -0700 (PDT)
Date:   Wed, 25 Mar 2020 14:25:00 -0700
In-Reply-To: <20200325212500.135046-1-emilyshaffer@google.com>
Message-Id: <20200325212500.135046-6-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200325212500.135046-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH v11 5/5] bugreport: add compiler info
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Danh Doan <congdanhqx@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
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
Helped-by: Danh Doan <congdanhqx@gmail.com>
Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 Documentation/git-bugreport.txt |  1 +
 bugreport.c                     |  6 +++++
 compat/compiler.h               | 41 +++++++++++++++++++++++++++++++++
 3 files changed, 48 insertions(+)
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
index 0000000000..10dbb65937
--- /dev/null
+++ b/compat/compiler.h
@@ -0,0 +1,41 @@
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
+#ifdef __clang__
+	strbuf_addf(info, "clang: %s\n", __clang_version__);
+#elif defined(__GNUC__)
+	strbuf_addf(info, "gnuc: %d.%d\n", __GNUC__, __GNUC_MINOR__);
+#endif
+
+#ifdef _MSC_VER
+	strbuf_addf(info, "MSVC version: %02d.%02d.%05d\n",
+		    _MSC_VER / 100, _MSC_VER % 100, _MSC_FULL_VER % 100000);
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

