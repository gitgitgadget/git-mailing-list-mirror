Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB145C2BB55
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 21:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6D78221F4
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 21:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZtpU7jtF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729297AbgDPVS2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 17:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728720AbgDPVS0 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 16 Apr 2020 17:18:26 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD2CC061A0C
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 14:18:24 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id n205so4999229ybf.14
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 14:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pHXVx7heMiFh/UuvWD7sFgmkxFeXgOKDExum0QxHTNw=;
        b=ZtpU7jtFbiZqg8e0sfO0DzvJqiXC7uQgu9xEAUtyNpS9++X4qhdGJ8+PNiJX9n4yvw
         P9VgzKsPabhvxTtG0WgPkaOq8UR6fzC3NbaMVBwZC5lfVAojsV1UR8qM3RTxFefLB3/Y
         xoYB0V639/H1n0P7axB+NgOJuFBZ7TpFapiGll+0gAG+LCZxPckJIljjcFyhdkPYK/ag
         +I7DqpAXTp1MNN9IETneyeGBJ3XVmgCyDuXwzIgUu8IoELPU/bg5jXZcVM6G7LaR5+B1
         wcfxhdpHvujejHg6sJTVgOVGsXuTdjxChZPXr//XHixkFNkzGEr+c2vpGhwHjnwwn2pC
         HRQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pHXVx7heMiFh/UuvWD7sFgmkxFeXgOKDExum0QxHTNw=;
        b=gHU90MZYumAh7NUTXBxE+r8PbYY3fiXDJhnGG+rb4WL2QJN64wTTi2nkpMmD3J+lIz
         BeDYdj57fTknB/X7XBU36Bqw5JYUmc4EusKQFtaReZJh3lNx4VIO1yY/MNrh3Va02ab8
         VPkfv/uWUyToqCr50h59TvwJvd9bNGFsiZertUV36XPJ0r8xLbLcR3k3rNyiQlJBHr+q
         XTqc1ZY/HeSD8j0HZppamnVxuXR006wjHqXwMVbf8+LKMxa+hw+XcOxCZeMy8d4iFLuW
         mNl0XOI1YtJScTaAQRfB/l/V3xFu9Chw7+JfirFlPjcVtMPbYk1Z+vBHf9H2QsgMShPf
         O65g==
X-Gm-Message-State: AGi0PubCtc6TtsCvayda8ayxiiSf/3dJLzwA4Q4O0wVlLNbxAW8YW0eO
        SG7KfmKNB+5HmJ6w5r4rQQ6fZamdLzx2ZXHdz0qdSs2G3K5zWz4vbIfjG+9PL850ulnXPXelm48
        SAFKvGESUGPFKoLcgKwX1nbn7Jm2GpfTi479XXVs1gRqkZs+2FezioW/fN6RQRdEfhtoKyN5T2Q
        ==
X-Google-Smtp-Source: APiQypLUr5jR+sSMZGppVZCe0jlj08ZyWIShwDlr8gL/QD3nkZ9OsmQ7xtXRNl439WzTVTsxkUvN3zwoRE8twdaYx8E=
X-Received: by 2002:a25:d890:: with SMTP id p138mr459441ybg.477.1587071903952;
 Thu, 16 Apr 2020 14:18:23 -0700 (PDT)
Date:   Thu, 16 Apr 2020 14:18:05 -0700
In-Reply-To: <20200416211807.60811-1-emilyshaffer@google.com>
Message-Id: <20200416211807.60811-4-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200416211807.60811-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: [PATCH v13 3/5] bugreport: gather git version and build info
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Knowing which version of Git a user has and how it was built allows us
to more precisely pin down the circumstances when a certain issue
occurs, so teach bugreport how to tell us the same output as 'git
version --build-options'.

It's not ideal to directly call 'git version --build-options' because
that output goes to stdout. Instead, wrap the version string in a helper
within help.[ch] library, and call that helper from within the bugreport
library.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/git-bugreport.txt |  4 +++
 bugreport.c                     | 19 +++++++++++++-
 help.c                          | 46 ++++++++++++++++++++-------------
 help.h                          |  1 +
 4 files changed, 51 insertions(+), 19 deletions(-)

diff --git a/Documentation/git-bugreport.txt b/Documentation/git-bugreport.txt
index 1f9fde5cde..f44ae8cbe7 100644
--- a/Documentation/git-bugreport.txt
+++ b/Documentation/git-bugreport.txt
@@ -23,6 +23,10 @@ The following information is requested from the user:
  - Expected behavior
  - Actual behavior
 
+The following information is captured automatically:
+
+ - 'git version --build-options'
+
 This tool is invoked via the typical Git setup process, which means that in some
 cases, it might not be able to launch - for example, if a relevant config file
 is unreadable. In this kind of scenario, it may be helpful to manually gather
diff --git a/bugreport.c b/bugreport.c
index f6f53a5e8e..4cdb58bbaa 100644
--- a/bugreport.c
+++ b/bugreport.c
@@ -1,8 +1,17 @@
-#include "builtin.h"
+#include "cache.h"
 #include "parse-options.h"
 #include "stdio.h"
 #include "strbuf.h"
 #include "time.h"
+#include "help.h"
+
+static void get_system_info(struct strbuf *sys_info)
+{
+	/* get git version from native cmd */
+	strbuf_addstr(sys_info, _("git version:\n"));
+	get_version_info(sys_info, 1);
+	strbuf_complete_line(sys_info);
+}
 
 static const char * const bugreport_usage[] = {
 	N_("git bugreport [-o|--output-directory <file>] [-s|--suffix <format>]"),
@@ -32,6 +41,11 @@ static int get_bug_template(struct strbuf *template)
 	return 0;
 }
 
+static void get_header(struct strbuf *buf, const char *title)
+{
+	strbuf_addf(buf, "\n\n[%s]\n", title);
+}
+
 int cmd_main(int argc, const char **argv)
 {
 	struct strbuf buffer = STRBUF_INIT;
@@ -79,6 +93,9 @@ int cmd_main(int argc, const char **argv)
 	/* Prepare the report contents */
 	get_bug_template(&buffer);
 
+	get_header(&buffer, _("System Info"));
+	get_system_info(&buffer);
+
 	/* fopen doesn't offer us an O_EXCL alternative, except with glibc. */
 	report = open(report_path.buf, O_CREAT | O_EXCL | O_WRONLY, 0666);
 
diff --git a/help.c b/help.c
index a21487db77..1de9c0d589 100644
--- a/help.c
+++ b/help.c
@@ -622,8 +622,32 @@ const char *help_unknown_cmd(const char *cmd)
 	exit(1);
 }
 
+void get_version_info(struct strbuf *buf, int show_build_options)
+{
+	/*
+	 * The format of this string should be kept stable for compatibility
+	 * with external projects that rely on the output of "git version".
+	 *
+	 * Always show the version, even if other options are given.
+	 */
+	strbuf_addf(buf, "git version %s\n", git_version_string);
+
+	if (show_build_options) {
+		strbuf_addf(buf, "cpu: %s\n", GIT_HOST_CPU);
+		if (git_built_from_commit_string[0])
+			strbuf_addf(buf, "built from commit: %s\n",
+			       git_built_from_commit_string);
+		else
+			strbuf_addstr(buf, "no commit associated with this build\n");
+		strbuf_addf(buf, "sizeof-long: %d\n", (int)sizeof(long));
+		strbuf_addf(buf, "sizeof-size_t: %d\n", (int)sizeof(size_t));
+		/* NEEDSWORK: also save and output GIT-BUILD_OPTIONS? */
+	}
+}
+
 int cmd_version(int argc, const char **argv, const char *prefix)
 {
+	struct strbuf buf = STRBUF_INIT;
 	int build_options = 0;
 	const char * const usage[] = {
 		N_("git version [<options>]"),
@@ -637,25 +661,11 @@ int cmd_version(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
 
-	/*
-	 * The format of this string should be kept stable for compatibility
-	 * with external projects that rely on the output of "git version".
-	 *
-	 * Always show the version, even if other options are given.
-	 */
-	printf("git version %s\n", git_version_string);
+	get_version_info(&buf, build_options);
+	printf("%s", buf.buf);
+
+	strbuf_release(&buf);
 
-	if (build_options) {
-		printf("cpu: %s\n", GIT_HOST_CPU);
-		if (git_built_from_commit_string[0])
-			printf("built from commit: %s\n",
-			       git_built_from_commit_string);
-		else
-			printf("no commit associated with this build\n");
-		printf("sizeof-long: %d\n", (int)sizeof(long));
-		printf("sizeof-size_t: %d\n", (int)sizeof(size_t));
-		/* NEEDSWORK: also save and output GIT-BUILD_OPTIONS? */
-	}
 	return 0;
 }
 
diff --git a/help.h b/help.h
index 9071894e8c..500521b908 100644
--- a/help.h
+++ b/help.h
@@ -37,6 +37,7 @@ void add_cmdname(struct cmdnames *cmds, const char *name, int len);
 void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes);
 int is_in_cmdlist(struct cmdnames *cmds, const char *name);
 void list_commands(unsigned int colopts, struct cmdnames *main_cmds, struct cmdnames *other_cmds);
+void get_version_info(struct strbuf *buf, int show_build_options);
 
 /*
  * call this to die(), when it is suspected that the user mistyped a
-- 
2.26.1.301.g55bc3eb7cb9-goog

