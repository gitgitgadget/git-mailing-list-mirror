Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB04BC11D40
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 01:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A40D524672
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 01:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K22F3D2W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbgBTB7V (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 20:59:21 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:39499 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727723AbgBTB7V (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 20:59:21 -0500
Received: by mail-pg1-f202.google.com with SMTP id r192so1310422pgr.6
        for <git@vger.kernel.org>; Wed, 19 Feb 2020 17:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lnD1toCn+iOJUERHZpCUgmvnhHcVAtSQuMPI4z1CnBk=;
        b=K22F3D2Wzo7RjRbpDHtdA+bajGvWaGz+x20EnsvOzMFp1ZJQx7wf2yI6ShA5rKNkAi
         5Q9g5UwvAvbUiDuaIMV9EoJT+kHZiZEDMIzjyVRuSC8nzq0HkL50H6ugMf/jQ77olQ3J
         rsfE+dK/g56yO2lt+D0jR65aVnJ68nCThArklQg08kXw200X4gKJEULx930PStdq1CoX
         6sDrYphvRR56qByJjoUGVBasMAImAubZ9E4yKSSdcy4Tj4vpIt11TGHITJBztVIRdK1c
         f4O3Oa+jMZE5Mz3QMxRA1i3GcD0PzyKn/WGNne9QMZLt3cUI9SuqowwGuXi6uJOutN4v
         4mRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lnD1toCn+iOJUERHZpCUgmvnhHcVAtSQuMPI4z1CnBk=;
        b=oV+FLp5wkYPXEFMj0EjmyrdhozBor54yT8bWhDwC8wdrmmNKQBs+kv0ITwgOPITRqp
         rNbz9iJtJzYpKb6suVjdmurvmSPBUE2/boUyiQkv9ACz36CoA7uI3i140vOkFz2T+GnE
         jMayOuZtSqb+gWn6bJ9vyxMWp+wk3mG8Rn1z2Ft7nqH4tDSE6ZpX0VPoJQsrRuSZmG2o
         npi1YZKAPE+tm4O0udGwZluVwzp1C0rKZ9Z9Are/GdEjiNqUA8jQ2jklqHiscTncK0gL
         kp1xNskTK4CMYboz76CZYAV6FGDy/XQ9Vm1WI3NmPwD5TsCboj+2Pk7aZdTAVpFRqWRB
         lLcw==
X-Gm-Message-State: APjAAAWfHfyjuBWd8gkrrGSwYNQywCx5+aIZvghriryIsZ0YqSjrSWOx
        P6SyrT8zxE+nyc4PD7POKssfazU2txl+ChJj2Lwa1EFtOtUi+QyIz8m9qd2Vent7a/X8xdfGMTh
        JvsNUHrdh4KK2Xka62Of8PCkznQzGVss92sSnZ2ZSf1KArwtpig5BLm5RyTXpsSfACPFHjjKnBw
        ==
X-Google-Smtp-Source: APXvYqwEowKZTbUkO7ZJumJcr82yMS86/ZXmkvZbDI6cGiRSuy4Y4DCapldFD6eVHnWrmTZlFYSrrk8KA5Mf4LU0of0=
X-Received: by 2002:a63:7c4d:: with SMTP id l13mr30982788pgn.275.1582163960397;
 Wed, 19 Feb 2020 17:59:20 -0800 (PST)
Date:   Wed, 19 Feb 2020 17:58:49 -0800
In-Reply-To: <20200220015858.181086-1-emilyshaffer@google.com>
Message-Id: <20200220015858.181086-7-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200220015858.181086-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v8 06/15] bugreport: add compiler info
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
 compat/compiler.h               | 27 +++++++++++++++++++++++++++
 3 files changed, 33 insertions(+)
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
index 06a63cc283..9a470c5588 100644
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
index 0000000000..ef41177233
--- /dev/null
+++ b/compat/compiler.h
@@ -0,0 +1,27 @@
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
+	strbuf_addf(info, "glibc: %s\n", gnu_get_libc_version());
+#ifdef __GNUC__
+	strbuf_addf(info, "gnuc: %d.%d\n", __GNUC__, __GNUC_MINOR__);
+#endif
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
2.25.0.265.gbab2e86ba0-goog

