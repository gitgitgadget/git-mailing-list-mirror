Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF6BC3F68F
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 01:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5697A2168B
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 01:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cyP07kSu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbgBNByE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 20:54:04 -0500
Received: from mail-pj1-f73.google.com ([209.85.216.73]:52323 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728300AbgBNByD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 20:54:03 -0500
Received: by mail-pj1-f73.google.com with SMTP id u10so4775884pjy.2
        for <git@vger.kernel.org>; Thu, 13 Feb 2020 17:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Iog73yocHVxDTujOdRes8en9G+RNUA1HswEzmsaeJck=;
        b=cyP07kSukMeZU5DP8aawFC37N5kgnjAbkNR0uQGUpjcGziW0mtoY8wdp3G4l86W+Or
         yPdvp0eLTJFI4eB6ed2Wi6fQ+kI3HtC9zq5SvIn83eTFS21IWhnfr7rhsXZDKnPTf17y
         OFp3PSbrkjJRFxAZqWxF0DTmP5ewHziQSGPYeQ3mn3c+0Xc7xf2SdPCNet1LkMx4ER/Y
         LF01yPjihg4JiU/qdhY9/RJOLXkqeK7xGDO031reeDCqPewKWseovvYQuPhQVfCjObAO
         sHXGhOG4TncoM2v7tMjWdBgukt/lxU40+LsAIy7wmvCZUtYTKcPC7kvNOPMcfyhpTnPU
         Dprg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Iog73yocHVxDTujOdRes8en9G+RNUA1HswEzmsaeJck=;
        b=SZHjJPSOT/HzcVmJM1+r+SpPtvzxiUOXFk9VoAvnEr/HqeoJFmZnKDpfYVBSlT3Zwf
         w7CN8jamKxcRlubz+ImEcPfJcfEJikAMyoFvQE2YJES6VfTA9l/jtwut8J6P73kpRDDH
         0FZXbBZChlK7H+P8L5BX+GS6x9s/JGaVsUdsqi2T8hT5ufOE6LieP2hU0YWqfXmUsHBy
         pWZxyihjC5aA+1t3rO0NrRaQ/KW3lYdZxomQ7otooGsc7PzfTt804X/eb7sX4H6j3pI3
         KbFgpORnABnUXqdjrIxMSKaaDncMauQIL138V8vvPYZixDt/lnXmRewc6npqebrEcsuw
         PJdw==
X-Gm-Message-State: APjAAAUxjVZdkaVgN8GQb3wOXd38SoMyiqf476eMIFg3dQGJ7flCR1uW
        +3hzhFGdoJHj/byQc5Zj23uU6xa1fOlgT2De0h6731HopZn7RTOVmqfZf9U+fvCNI6kNqCTNOtt
        BtCSjlHj74PMCKm+1/2612PqGQVqx48kJL5geLVSLtci4kcpDpAatWTHRSkMqIO02RZ6WRaxdCw
        ==
X-Google-Smtp-Source: APXvYqxBH7Hr5qAjiiybMo+tZOvcxzuo52QQsUk0UKQ3cuwCtkDNHouDzmwijcE9+QFd3kgd3QrySj8Ioox1kcFPRag=
X-Received: by 2002:a63:7412:: with SMTP id p18mr818419pgc.361.1581645241119;
 Thu, 13 Feb 2020 17:54:01 -0800 (PST)
Date:   Thu, 13 Feb 2020 17:53:32 -0800
In-Reply-To: <20200214015343.201946-1-emilyshaffer@google.com>
Message-Id: <20200214015343.201946-5-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200214015343.201946-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v7 04/15] bugreport: gather git version and build info
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
 bugreport.c                     | 19 ++++++++++++-
 help.c                          | 48 ++++++++++++++++++++-------------
 help.h                          |  1 +
 4 files changed, 52 insertions(+), 20 deletions(-)

diff --git a/Documentation/git-bugreport.txt b/Documentation/git-bugreport.txt
index 52d49ed7aa..6ce2ae2eff 100644
--- a/Documentation/git-bugreport.txt
+++ b/Documentation/git-bugreport.txt
@@ -23,6 +23,10 @@ The following information is requested from the user:
  - Expected behavior
  - Actual behavior
 
+The following information is captured automatically:
+
+ - 'git version --build-options'
+
 OPTIONS
 -------
 -o <path>::
diff --git a/bugreport.c b/bugreport.c
index a9398e6a2a..b7504fe322 100644
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
+	strbuf_addstr(sys_info, "git version:\n");
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
@@ -76,6 +90,9 @@ int cmd_main(int argc, const char **argv)
 
 	get_bug_template(&buffer);
 
+	get_header(&buffer, "System Info");
+	get_system_info(&buffer);
+
 	report = fopen_for_writing(report_path.buf);
 
 	if (report == NULL) {
diff --git a/help.c b/help.c
index 190722fb0a..44cee69c11 100644
--- a/help.c
+++ b/help.c
@@ -622,8 +622,33 @@ const char *help_unknown_cmd(const char *cmd)
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
+		strbuf_addf(buf, "shell-path: %s\n", SHELL_PATH);
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
@@ -637,26 +662,11 @@ int cmd_version(int argc, const char **argv, const char *prefix)
 
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
-		printf("shell-path: %s\n", SHELL_PATH);
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
2.25.0.265.gbab2e86ba0-goog

