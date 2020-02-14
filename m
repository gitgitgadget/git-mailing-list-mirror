Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3227C352A3
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 01:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C448A20848
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 01:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mNTaGuz7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbgBNByK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 20:54:10 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:42813 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728336AbgBNByJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 20:54:09 -0500
Received: by mail-pg1-f201.google.com with SMTP id 193so5030380pgh.9
        for <git@vger.kernel.org>; Thu, 13 Feb 2020 17:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tWVW7MwWFQo2xFCTRDNOgc7MoIj3aVwWJ38vvZ3cQpo=;
        b=mNTaGuz7RQa0qf2tHXm07GbwRDf5PRgrBiFJc1FfACbzfgS+lNBoLiyhzUEsfKFoYP
         FBqdtbrmCyHBQIZqe/L74uG4PrxDU2CYMFH65Q348Nqto8goOiU6L2/PVH2nKAMT/wSn
         o05MY7IMk2nhv2/K3XHm6r4Kiwgjaz2+hyJIolDJExvQViPZzMaecruv+TLrzOzWvZad
         HS1l81AZ2Ew+wcDFONYVRLy5PdrcKoEBcbQYXuOYFvISmHfUARllmF2p10WVsyjyez55
         A3W1cwS0O/JS1MeyX7VcP0El6mONKPsQXsjsAq7LFVTUidLYhpDPH4U5tawccriWq6Rk
         cOfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tWVW7MwWFQo2xFCTRDNOgc7MoIj3aVwWJ38vvZ3cQpo=;
        b=Jg0YbIioOKCuqI8eCDLKv2BibFzBYX30yHxGSkut6OJBMpvRuWRG51AC11jIUpNKVl
         uH50hF0G0ip7Fnin3csGI1P7o4cKUp2SC5/gLIStT2+wckozVK5J3/BIHtqRw2NZi8OK
         lYYzCFiYPRT2GcbJZ20C3Fo+6oFw+T5+eaH7cdNlCys+oazdgGmEsUYkDY22cPxl7Doi
         Evly2UCMgWXOfE9jWUtd7LECb+atnO8Ys9RrtX+sybPCzWmsWk3cCyqvRJBo2SdvFQQj
         o1aO7D7IcjskNQLih2HUhHpVhcHwUzTKwZV4rZUtezaK0X7gOyCwfHtNOhmmJCA2scQ/
         PDgA==
X-Gm-Message-State: APjAAAX6F1YrqRxOnLOu10wopannUgmFmDI/tnLGKS2vAJMbeH+OScCW
        8HMk3kZGN1UiyPuNuWaOwwNSZ/JFrOvC8N6p85FlDWGvfizA5iwYEeP8gHnsAPfgLN8Pp/mYkWk
        ah5qWGmEniHcmE2kIxxOvmP5Ki2QlrVhTuVQAihmKqm2V0mwM8K2XOXu8maH/NHUvSIPT17JnfQ
        ==
X-Google-Smtp-Source: APXvYqwml4N4ucHXDXx1HQIkUbytof8Jx9dnB0iblbf4MlPBiN2YyIWbIgW6mkR2JzQ3OCPZRr+cpE+NOZfVD9VaY8M=
X-Received: by 2002:a63:5512:: with SMTP id j18mr828363pgb.189.1581645248339;
 Thu, 13 Feb 2020 17:54:08 -0800 (PST)
Date:   Thu, 13 Feb 2020 17:53:35 -0800
In-Reply-To: <20200214015343.201946-1-emilyshaffer@google.com>
Message-Id: <20200214015343.201946-8-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200214015343.201946-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v7 07/15] bugreport: add git-remote-https version
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
index 8bbc4c960c..33df4dec7f 100644
--- a/Documentation/git-bugreport.txt
+++ b/Documentation/git-bugreport.txt
@@ -28,6 +28,7 @@ The following information is captured automatically:
  - 'git version --build-options'
  - uname sysname, release, version, and machine strings
  - Compiler-specific info string
+ - 'git remote-https --build-info'
 
 OPTIONS
 -------
diff --git a/bugreport.c b/bugreport.c
index 4f9101caeb..bfdff33368 100644
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
+	argv_array_push(&cp.args, "git");
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
index 350d92a074..c590fbfae3 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -17,6 +17,7 @@
 #include "protocol.h"
 #include "quote.h"
 #include "transport.h"
+#include "version.h"
 
 static struct remote *remote;
 /* always ends with a trailing slash */
@@ -1374,6 +1375,13 @@ int cmd_main(int argc, const char **argv)
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

