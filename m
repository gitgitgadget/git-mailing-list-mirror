Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A4CC3B194
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 01:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4998E222C2
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 01:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Oq2EixUA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbgBNByH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 20:54:07 -0500
Received: from mail-vk1-f202.google.com ([209.85.221.202]:50141 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728193AbgBNByH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 20:54:07 -0500
Received: by mail-vk1-f202.google.com with SMTP id v134so2719094vkd.16
        for <git@vger.kernel.org>; Thu, 13 Feb 2020 17:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=I3RloJdvp1spyqvHvZLdZ6xHw0Qu5/WY3tHVJyxBInE=;
        b=Oq2EixUAwpIjwuf480Nbf7A0yAMTf8mm9botAVw1KOuAupkrj4ImzaQNpCRUpqym9r
         V8Q5wk9MFp52h6+14tNawPaBNshiBykjNKS/WGna39wotFYsL1hF3aId/HfrweM4fS5K
         1SoyA4+v9LpqDjtaVWck/GjuBFW3AUsCbgbQTNmL0MuI3Zdr9Uy3YalsDrG5FXw0KUSX
         TEpaq3eiuYrqbmX7/vh5k7kztmqD3IJUxwDo36nPufrYg+Jl34OWizcnqLsmrDzSEzvu
         U/ZR1F4uY6AnCBubgPcoxG1kP3wz29wiemzaHhlcd9UVT/jsll0OTjbn3OokDgLbgFQK
         Wu2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=I3RloJdvp1spyqvHvZLdZ6xHw0Qu5/WY3tHVJyxBInE=;
        b=Dk/lvGijmPtNNi7eHKUXHijbo0f8qHSrW2Z7PFcJDxfkqfGfYBTuV+l16U6xbaHn3E
         0R4q4zOCtGtmIDkkhmTLS4R4q9IDUeKONlkmbV9ThA/6CdJXTh2fBBI3zjedFwtcBYqP
         fGyrGW8SLytw6PNGHz1tHsxCnj6xvmuRDoMg20MTsOPMzoK9c7QaaVPbDc3IW/4rjzjf
         VyWstY8cloKAiCLi93eWByTEWi13eFQKgKTDVQihGvBW4MYpf+by/zwwsV6cMGw6zFKS
         nDeQy0U3ZE+qDcluK7vHoPukSJoZmfoDJkxdRwQxc7Gn5GeWiZQcGUMbLqB283FoX3Rx
         kkEw==
X-Gm-Message-State: APjAAAVw/+8kToQ5gAOP/dcIF2PcdV/s5uIhAIvC7kyPQjXzy82cbkvh
        qED6uZt3+WfhrLV+lxDh1kkUreTDTDlLDaKfzhvH1CaZpZVVCP/hm0Y5R+hPxBuVL3ryOdUm/x+
        2D0/mQo/JxRolxDjhkADzmflzqauzxulrnYb2JRgyxJLiajMcoD7uRe1En89u/tZWUpo83nZd+A
        ==
X-Google-Smtp-Source: APXvYqxoBpAau5vC5CHLtj+OAmOBKrctD2sCGZ23WG2nlUzJV3ChFyFbhIHAZvjsRxtEwD9krOzhCvbAWXXeIW6kjnU=
X-Received: by 2002:ab0:4aca:: with SMTP id t10mr425670uae.89.1581645246122;
 Thu, 13 Feb 2020 17:54:06 -0800 (PST)
Date:   Thu, 13 Feb 2020 17:53:34 -0800
In-Reply-To: <20200214015343.201946-1-emilyshaffer@google.com>
Message-Id: <20200214015343.201946-7-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200214015343.201946-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v7 06/15] bugreport: add compiler info
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
index b76a1dfb2a..4f9101caeb 100644
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
2.25.0.265.gbab2e86ba0-goog

