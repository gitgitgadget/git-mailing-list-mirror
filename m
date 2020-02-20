Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD86C11D41
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 01:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7717C21D56
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 01:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pZEj8enD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbgBTB7Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 20:59:24 -0500
Received: from mail-ua1-f74.google.com ([209.85.222.74]:55670 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727723AbgBTB7Y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 20:59:24 -0500
Received: by mail-ua1-f74.google.com with SMTP id 71so354679uae.22
        for <git@vger.kernel.org>; Wed, 19 Feb 2020 17:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZayymgcPEffs+lFpPs+5gCaPklpmHgqLccRVAfxofaw=;
        b=pZEj8enDbYr/pMo32JBC/kacySJIe+/b7LL+rYE7ZR5dE2ku0srfIwZuUS6U6zDAzI
         fjhRQIqNueHC4zwnZApv4mjEgoi8sYAfUB9RyO3RW2b1Fwo9JclzojAq8yePTNPxjy7G
         nwg7bRaLbD2HTHgaKTDw13fLNpPlYevJAEzencLe4NYrF6Bnjtlcdyt6gL68hB7mx+3r
         8GCXF062EXFEYzdNaVjCZG6sbjON4D9TfDEdBPOTCU8Jy3QpkS6K+0ueScfERO4AXZce
         VDyiiTquez76Nwdu/0825ZBSYmQCodtTqFr6O1vkmt4vFc7gm3/obV+NT+gNiRpwtcE+
         7BuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZayymgcPEffs+lFpPs+5gCaPklpmHgqLccRVAfxofaw=;
        b=sQpBlufPaavfty9/kg4zwCS4UUbU+vjOLk5uRlOapGERfUf5njGt0mrsA3md9l1byW
         6HQB1OD7qpXY1DOxzuqiDeUTxeEueyJwW+AOOPlodaLlXMnpdV6PcOS/Zrdpael8hSZF
         ZF693Wwz/ytDNxCvnvxGdAEIjYUSmUpuUNd/dEXdON4vDISkYnJocn1SXxwNGqvIlCvM
         0TUWwD8Q5jzhMcrgAe4rx4MZ9OPvjkCSExGgB+vFSR/ryZ9WsJw6g9t/WekjGklohOce
         jap9vTfCWwRENVR+VWYa1xzznm+bimFIir7jq3VGBnsjzy9sKcg/M6YnIxN92BMOgbK9
         EYFw==
X-Gm-Message-State: APjAAAVoZpnQNIJThNnuJ6FhPOhLhi01eCH+e5CwlujnOpYl0XWF7Lqn
        clM0zdeIhPn7D5ijvExur7m8VpYaT6vpeVgIKxQonwHoXbESZGsGwdyGTyzN8rO2B/5Jr9PSyY5
        UOEW4n0/Ek/ISmU2YXoSUqWbY+LwhNMP4cCa2QiTiWqrzCpt6iscLxBOApO0HnPEZZcaaLqeUVg
        ==
X-Google-Smtp-Source: APXvYqwxKpGsxj3kfue/RkSkl7q3TGKs0NU3PHOSihULhEjTbru8CIf0xgSdsWn9Ta2JBmhe8rs6Z51t0bx4D22d3VE=
X-Received: by 2002:a9f:36ca:: with SMTP id p68mr15472244uap.112.1582163962912;
 Wed, 19 Feb 2020 17:59:22 -0800 (PST)
Date:   Wed, 19 Feb 2020 17:58:50 -0800
In-Reply-To: <20200220015858.181086-1-emilyshaffer@google.com>
Message-Id: <20200220015858.181086-8-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200220015858.181086-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v8 07/15] bugreport: add git-remote-https version
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's possible for git-remote-curl to be built separately from git; in that
case we want to know what version of cURL is used by git-remote-curl, not
necessarily which version was present at git-bugreport's build time.
So instead, ask git-remote-curl for the version information it knows
about.

Today, "git-remote-http" and "git-remote-https" are aliased to
"git-remote-curl"; but in case we rely on a different library than cURL
in the future, let's not explicitly reference cURL from bugreport.

For longevity purposes, invoke the alias "git-remote-https" instead of
"git-remote-http".

Since it could have been built at a different time, also report the
version and built-from commit of git-remote-curl alongside the cURL info.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/git-bugreport.txt |  1 +
 bugreport.c                     | 16 ++++++++++++++++
 remote-curl.c                   |  8 ++++++++
 3 files changed, 25 insertions(+)

diff --git a/Documentation/git-bugreport.txt b/Documentation/git-bugreport.txt
index 643d1b2884..8c7cb9a5d4 100644
--- a/Documentation/git-bugreport.txt
+++ b/Documentation/git-bugreport.txt
@@ -28,6 +28,7 @@ The following information is captured automatically:
  - 'git version --build-options'
  - uname sysname, release, version, and machine strings
  - Compiler-specific info string
+ - 'git remote-https --build-info'
 
 This tool is invoked via the typical Git setup process, which means that in some
 cases, it might not be able to launch - for example, if a relevant config file
diff --git a/bugreport.c b/bugreport.c
index 9a470c5588..fb2adfdf14 100644
--- a/bugreport.c
+++ b/bugreport.c
@@ -5,6 +5,18 @@
 #include "time.h"
 #include "help.h"
 #include "compat/compiler.h"
+#include "run-command.h"
+
+static void get_git_remote_https_version_info(struct strbuf *version_info)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+
+	cp.git_cmd = 1;
+	argv_array_push(&cp.args, "remote-https");
+	argv_array_push(&cp.args, "--build-info");
+	if (capture_command(&cp, version_info, 0))
+	    strbuf_addstr(version_info, "'git-remote-https --build-info' not supported\n");
+}
 
 static void get_system_info(struct strbuf *sys_info)
 {
@@ -29,6 +41,10 @@ static void get_system_info(struct strbuf *sys_info)
 	strbuf_addstr(sys_info, "compiler info: ");
 	get_compiler_info(sys_info);
 	strbuf_complete_line(sys_info);
+
+	strbuf_addstr(sys_info, "git-remote-https --build-info:\n");
+	get_git_remote_https_version_info(sys_info);
+	strbuf_complete_line(sys_info);
 }
 
 static const char * const bugreport_usage[] = {
diff --git a/remote-curl.c b/remote-curl.c
index 8eb96152f5..73e52175c0 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -17,6 +17,7 @@
 #include "protocol.h"
 #include "quote.h"
 #include "transport.h"
+#include "version.h"
 
 static struct remote *remote;
 /* always ends with a trailing slash */
@@ -1375,6 +1376,13 @@ int cmd_main(int argc, const char **argv)
 	string_list_init(&options.deepen_not, 1);
 	string_list_init(&options.push_options, 1);
 
+	if (!strcmp("--build-info", argv[1])) {
+		printf("git-http-fetch version: %s\n", git_version_string);
+		printf("built from commit: %s\n", git_built_from_commit_string);
+		printf("curl version: %s\n", curl_version());
+		return 0;
+	}
+
 	/*
 	 * Just report "remote-curl" here (folding all the various aliases
 	 * ("git-remote-http", "git-remote-https", and etc.) here since they
-- 
2.25.0.265.gbab2e86ba0-goog

