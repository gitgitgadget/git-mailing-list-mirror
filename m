Return-Path: <SRS0=KD4O=32=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2A5C35247
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 00:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C03412166E
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 00:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jIIeqdI7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbgBFAlj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 19:41:39 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:38728 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbgBFAli (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 19:41:38 -0500
Received: by mail-pl1-f202.google.com with SMTP id t17so2162926ply.5
        for <git@vger.kernel.org>; Wed, 05 Feb 2020 16:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dc1xnC2Yu5IrOpjcdoaBFZ2Zc8DG4O3aHKRqAb2kd3w=;
        b=jIIeqdI773ut41OopRPc6OAm2Y36vx22wtrfVpKgY5cYmn4BGLaYWOLT2dzW6sKyYH
         MBczLCzRROVDhaPtFrkNo0ppzxqAwHprENUkIduDLHiEnCv/2vnYkqUTYJlp4iWAYmJy
         GuokHrqs5l4Bmbv2Kbe5qbEihveQ/jrlxvXNAw3U4JWQi0PMyS1Qv5F/XbuH8qnp9zhj
         gjzIBRfPPqftI6uQWyr/tJtIDD0tqLwCgjObr6aPrE9SoBTFdkhc5gVoGWayQ8fpwe8f
         xvkjS3LVMFSmnI+PdVQnrSSbzN00JDPDiSeZuI+t61TRc9Knr71+QMS5wBW2jZax0vzf
         yG6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dc1xnC2Yu5IrOpjcdoaBFZ2Zc8DG4O3aHKRqAb2kd3w=;
        b=MKOK9dN8BXzAE5XLJC7NKy+M8LLtNhyqYgFzBuxNMo4/AaAxv/xmUYXYrxVTioWrOI
         645gMsM6L9nJCPsVf0Vz05lsYWNtPpYLXR2ujE9h/Q2392RRI0vtekljacsfFCG6vyQE
         ofFQRb6B5UZMkH2OW3JyL44NpsuTWKtoAhMcs+YxOEmYJ4uBXBdGNZnAshclDUZBGnIh
         grcO2mlIOv5BQmf6Rs7ITgBga6giV0mqktDvruVSkrDDvip4xbX1eE2TltCGGA5JWOwS
         osBEAVhvZ29zAcu+gZz095MBKuCsq9eXPGx0oXN8gfBFce7OHx8GNsOSFNV7I2W8NS+P
         iQaA==
X-Gm-Message-State: APjAAAW54Zb1LCFXiZ1wTEd+WGCFY90ppX1O0erG4bxuGRNpnqikXMql
        7rHwrHmZgkWkGi9fm5i9kP5Gjyi+OmOvB9//ZEi//elZrgGWhO2A4UT86MNQb1irTcP4pgk8g71
        Yh/G0twnEM2IqGRA1apBMW2Pgp+06MuWKuKRKDPgCIzPoPy3uPQxdOzdIV6BSN1TgO1GUSnRnEQ
        ==
X-Google-Smtp-Source: APXvYqy9pqk/gRrxfJEEU6mjyaU2oJJnQUyKhgnstvAN783SvJ77S0CfwhzCYtE3m8RJHJPgrKdlzz5W0C9vwpZEgMg=
X-Received: by 2002:a63:455c:: with SMTP id u28mr661340pgk.163.1580949696420;
 Wed, 05 Feb 2020 16:41:36 -0800 (PST)
Date:   Wed,  5 Feb 2020 16:40:59 -0800
In-Reply-To: <20200206004108.261317-1-emilyshaffer@google.com>
Message-Id: <20200206004108.261317-7-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200206004108.261317-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v6 06/15] bugreport: add compiler info
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
 bugreport.c                     |  5 +++++
 compat/compiler.h               | 24 ++++++++++++++++++++++++
 3 files changed, 30 insertions(+)
 create mode 100644 compat/compiler.h

diff --git a/Documentation/git-bugreport.txt b/Documentation/git-bugreport.txt
index 4dd72c60f5..8bbc4c960c 100644
--- a/Documentation/git-bugreport.txt
+++ b/Documentation/git-bugreport.txt
@@ -27,6 +27,7 @@ The following information is captured automatically:
 
  - 'git version --build-options'
  - uname sysname, release, version, and machine strings
+ - Compiler-specific info string
 
 OPTIONS
 -------
diff --git a/bugreport.c b/bugreport.c
index 4c4b877ea1..aaeb94c10c 100644
--- a/bugreport.c
+++ b/bugreport.c
@@ -4,6 +4,7 @@
 #include "strbuf.h"
 #include "time.h"
 #include "help.h"
+#include "compat/compiler.h"
 
 static void get_system_info(struct strbuf *sys_info)
 {
@@ -24,6 +25,10 @@ static void get_system_info(struct strbuf *sys_info)
 			    uname_info.release,
 			    uname_info.version,
 			    uname_info.machine);
+
+	strbuf_addstr(sys_info, "compiler info: ");
+	get_compiler_info(sys_info);
+	strbuf_complete_line(sys_info);
 }
 
 static const char * const bugreport_usage[] = {
diff --git a/compat/compiler.h b/compat/compiler.h
new file mode 100644
index 0000000000..bda5098e1b
--- /dev/null
+++ b/compat/compiler.h
@@ -0,0 +1,24 @@
+#ifndef COMPILER_H
+#define COMPILER_H
+
+#include "git-compat-util.h"
+#include "strbuf.h"
+
+#ifdef __GLIBC__
+#include <gnu/libc-version.h>
+
+static inline void get_compiler_info(struct strbuf *info)
+{
+	strbuf_addf(info, "glibc: %s", gnu_get_libc_version());
+}
+
+#else
+
+static inline void get_compiler_info(struct strbuf *info)
+{
+	strbuf_addstr(info, "get_compiler_info() not implemented");
+}
+
+#endif
+
+#endif /* COMPILER_H */
-- 
2.25.0.341.g760bfbb309-goog

