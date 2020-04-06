Return-Path: <SRS0=cWmm=5W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BE5C2BA1A
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 22:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A489720768
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 22:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B7rLKlNt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgDFWps (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 18:45:48 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:37880 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgDFWps (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Apr 2020 18:45:48 -0400
Received: by mail-pf1-f202.google.com with SMTP id n28so912935pfq.4
        for <git@vger.kernel.org>; Mon, 06 Apr 2020 15:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+baXNWTKW9hbg6uWr4aCoaog+o9GnOiC+rvOqzis9XE=;
        b=B7rLKlNtDaExloYFtVNeJ/QSz0VXHGLxqfHi5sbo1bF+IHuBu+ITpvAYUYFPFRrnM8
         HLg0kuiguuUOkTL14VTOKR0uL+jTw0xfi3A8L/Q4wfcrmKstw1wub1RVRnWzFsDX0Xc0
         wxCvyObRY2ahCO8N89WDaVlcx2E+B4v6qT1j9dALrb1/3w3kC40iczkmNCXuvkcJ4lWY
         4TW6tYcGK20Zga/CqaJstMiH1axRwYIeVLvyd9/9hy80DsgRdmS+Bvs1IEw8wXbvsSbq
         2BvGFCWwaIoXDZrziMJcSLSLyFG3L5/rBrcjnvP8xRsKR7Jds5Ber0b4aVaEcMsrKkaN
         bE0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+baXNWTKW9hbg6uWr4aCoaog+o9GnOiC+rvOqzis9XE=;
        b=nVv5ZZsy987i2hENpkuIj/tpY56gwqTWeC3p9mtb8EW+ag2wJDhr6s7xGlZ1l23jjn
         Y8ia4RU1DOSN4JKL0XCk3in7L3AF8N4yiidaAIsKWy7tnMEjxs1Oe6FCgc6Je/Kp87oz
         hLzMBL3Ht2mDOxP63RX30iE+3Awy4JujK7gGN6qByDlZtE97jchlix5BtTSerq8Xh/n9
         htvH9wsSpg6ULsrNGXisvPTuwQXdEvpZPHE2ixloiGbBycgknWIluK+qz2w/ALlM3SIK
         aFUqRdrFrLG6v8aP7v9udcESwFBbZ1Khthdu3x63kFC7puG3UqvFJsqS6MJnIoIIjiBG
         5Njg==
X-Gm-Message-State: AGi0PuYdq0aedBVrNArnS33lADweUm/2iP9vpNn+++6W+YtBcSYx0q3F
        JW+IiYwQN/cDGTGY/6GsqJXloSmUxt+wkspSK5uuB5EUK/myyHYnFGS4NDR7fKBPSUgy2T8Clge
        va2FR8WhR/NLcGPcv7ym0Zke9U/cNJl1aIhgB4rrBM4GFZVs1ehyFhTZjyvXzINym72Kak/djbg
        ==
X-Google-Smtp-Source: APiQypJYJ6OTPZ8OmDIlhXVQscvr+yczsomBl/GkaEjZTAQUCwOL0furh0rkRTqx9MDhwOhxQkl9oPZjkjbO3XdHX+Q=
X-Received: by 2002:a63:3602:: with SMTP id d2mr1335555pga.138.1586213145090;
 Mon, 06 Apr 2020 15:45:45 -0700 (PDT)
Date:   Mon,  6 Apr 2020 15:45:26 -0700
In-Reply-To: <20200406224526.256074-1-emilyshaffer@google.com>
Message-Id: <20200406224526.256074-6-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200406224526.256074-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
Subject: [PATCH v12 5/5] bugreport: add compiler info
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
2.26.0.292.g33ef6b2f38-goog

