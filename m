Return-Path: <SRS0=cWmm=5W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3869EC2BA2B
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 22:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04F1F2072A
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 22:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A3yZhJp6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgDFWpo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 18:45:44 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:39338 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgDFWpn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Apr 2020 18:45:43 -0400
Received: by mail-pl1-f202.google.com with SMTP id d11so912854pll.6
        for <git@vger.kernel.org>; Mon, 06 Apr 2020 15:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=aw1WoGWu0MS7Y4dR0L6/dxci3fV8LP1WJf8EDxVPStA=;
        b=A3yZhJp6JU9OncbN+wzvsDXSLd288K+ffJI7VjY/UsyLOZvGOM85wDKIJVLMhjhrm8
         809z7EeYkJZNAZZwc1ulF//c7OJVs0nPS7STP7BeQkxfc9SnovlhCXmF+MVshrjoFm0M
         E3IEEuc927wlrfRYJ03D/yzoR6tRdl36VDRkochVfhsTUXea2bxNuNsjIIQlVrwo2UNI
         ycvP1Ffl0m0SJELUM6/LV/kmgevtKirXTzcLXA7OVg8nBpMODer+rqdwkJdMrD09c48e
         IKVxwYovGLFVqvdAHKlL3GbKIq5kSgDMUzadMZ6S2mmoYsj3eBDzYcaMlpPXnZNwufmk
         YbOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aw1WoGWu0MS7Y4dR0L6/dxci3fV8LP1WJf8EDxVPStA=;
        b=DfLd9QPepjBPyEWR6GD1YOnlzLmR2TSsQPsI+UAAtn4JUDEtnKQeU3QofmhjblOhCI
         DC/2OMqIvPIQNmXOIPMVdwMIhlCw34ieJcA2EEI4PML1x/85MfFYHlFXQm7He2Mbu4Va
         d3xnYFAi88PZWc78JV8DI/l5VpZ4977sqCMQM9w/tP8yI1H7NtxUmOaW7mebEcMntjUr
         iLFm7jWY3JYX7Zgh0XvqyvTCczHS4+sFcO0fcQijD+jioztC16NY9BLx6AnQjM7h7h54
         4bCrWeOnBpJU8aUQRJNTfhKKwpePduIq9lEbkvWNo4UZfz9pPU9Y5yae8bdUSoWZrra5
         8YaQ==
X-Gm-Message-State: AGi0Pub0Z4MqDVFDJIdZ8sAtF9/+nEYH5zV/HqWJgW7Oo6amFV+3p3Om
        rbbTpvtq/7Hs9QQjt/oneMEppmva3hY3NBs1dAZ1HYK7quxtyxIkGrwQg/SQBYNOWO6A79AsH2s
        GgekuW8d8IAeNbdAKRC6TS4ZcByD7Uwr20CSgfEJcb/nw7KQhVmrlR2nOmHhqM30k5BelPp+iKA
        ==
X-Google-Smtp-Source: APiQypLqmbTiSPtdQH6t/LBMJ2z5jYwRhW4Kwd3OOQAtwVjyJAjPbs23URw+ihdfp1m6uWtxO2R0AZmT1TS+49k7tS8=
X-Received: by 2002:a65:568a:: with SMTP id v10mr1339206pgs.215.1586213140446;
 Mon, 06 Apr 2020 15:45:40 -0700 (PDT)
Date:   Mon,  6 Apr 2020 15:45:24 -0700
In-Reply-To: <20200406224526.256074-1-emilyshaffer@google.com>
Message-Id: <20200406224526.256074-4-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200406224526.256074-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
Subject: [PATCH v12 3/5] bugreport: gather git version and build info
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
2.26.0.292.g33ef6b2f38-goog

