Return-Path: <SRS0=ovBw=4T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0A2C3F2D1
	for <git@archiver.kernel.org>; Mon,  2 Mar 2020 23:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F94D21739
	for <git@archiver.kernel.org>; Mon,  2 Mar 2020 23:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="adFyJvE9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgCBXEU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Mar 2020 18:04:20 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:43802 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbgCBXEU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Mar 2020 18:04:20 -0500
Received: by mail-pg1-f202.google.com with SMTP id o7so838730pgk.10
        for <git@vger.kernel.org>; Mon, 02 Mar 2020 15:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CbySq5shLK4cH3Jor0njKSBxSdHRlDv3F5KvpxJ9aC0=;
        b=adFyJvE99ImpT90WPJvi+9zcySshD/S2JvKtUlrzYWlBhLWa+lBa6wN1+ka+xAKRqP
         spN7irBIuRD37QLHsZjD9tySNZn6o6UaZ4Tu5oYSMHyi9EDcKlDZA30QLcUhkWM7lUkU
         maaDrjy1Nul3gQEvvczqaSq0Tb83gyFJ/Adxp+3Ueo9Q4cup52kRRsP3D0YhWEnDdi5n
         8h3rWzoAVKtirv01UeQW9wBYEp8jIUYaA12xaCaSq97h0BnchZw3VMnioDiNuLY6V37b
         MqhG+0ltE+SO0i4xCAcjnf8I5p8taHVBegY+kz9kzHQoJTMAXvPn0aSO3SoKDdZ3R+k1
         EqvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CbySq5shLK4cH3Jor0njKSBxSdHRlDv3F5KvpxJ9aC0=;
        b=jmo0if6RP/kcbPKKtw+69jAXJCzDivLneJPsb+9658FzMopePT0uLtoSE8qbrly8HU
         w9LTElPyd9jnsGsXVbeBnZPIaEvIgZmLgyqfQnNhafmwedn55UtJnuWimM8KihZqBkiw
         pnqtuirtq2SlL4gtX473j+JLHsIXbbEl2/A05BKtjtB2cv8kl/43S7fPFpUcD+KLsB8y
         B7jdGpXR+grUvGpjtBwBuW4iTsUZh0jO7N1DSG/j+OX6I/uVP6ovfm6XnV7VhNFVUKZg
         ZgzBfbCnvtYWQp6NajTZzLfuJqA9kgODACy/b5Kb6zv/oNvrVARUuqMBkba/YsjOlKVR
         s7hQ==
X-Gm-Message-State: ANhLgQ3aZQ5aSB/u8iUDI4ZJA7ouRwPxu7/Yv6lSC43Lo9rqlXMVwsUs
        d8KCaSWYH2/KVk92l5J7++RpfnOt83JuhcuqYKk9bXvcK9PkXCJA1JliYSFBvEEO8fSX2AzUahG
        SFqfrBMFFsm3PFYxltxGARoSnlMqL9c0Cyt54YY1/Eo6YK54J+OG3xlWcDZGVkJ/Ex0sY8KEQHw
        ==
X-Google-Smtp-Source: ADFU+vuhegx7oT71DpC9VdSIjnmC1iePxoAH05ExPTkZWy+DhJy4NmSlqUqic3iVAQ/W3O6pKGBvLzQbTK8BRNunddU=
X-Received: by 2002:a63:b52:: with SMTP id a18mr1190689pgl.130.1583190259438;
 Mon, 02 Mar 2020 15:04:19 -0800 (PST)
Date:   Mon,  2 Mar 2020 15:04:00 -0800
In-Reply-To: <20200302230400.107428-1-emilyshaffer@google.com>
Message-Id: <20200302230400.107428-6-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200302230400.107428-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v9 5/5] bugreport: add compiler info
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
index 857b4f712c..5073c901cd 100644
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
index 0000000000..21f098e6a4
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
+		strbuf_addf(info, _("no compiler information available\n"));
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
+		strbuf_addf(info, _("no libc information available\n"));
+}
+
+#endif /* COMPILER_H */
-- 
2.25.0.265.gbab2e86ba0-goog

