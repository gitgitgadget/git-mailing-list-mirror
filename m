Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C575C11D42
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 01:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47F1C24671
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 01:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d3qJSF5l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbgBTB7T (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 20:59:19 -0500
Received: from mail-pj1-f73.google.com ([209.85.216.73]:34591 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727338AbgBTB7Q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 20:59:16 -0500
Received: by mail-pj1-f73.google.com with SMTP id v8so852582pju.1
        for <git@vger.kernel.org>; Wed, 19 Feb 2020 17:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PPv7++FpeksN7EXMu0/NkT5FBZuOUS9HjZTLmuUSToA=;
        b=d3qJSF5ljd529rVyytAoUF8kLKHTgO3/A9yGfAEqMdNtaLzKIY4y8GrxVZ8zmUTwg2
         p5XTQjB5XiCQqZuChmr4DZNxkI6y3Alaert9FqWFLpg0R0icR27X0pQUkkb9ZwtCGa/g
         qd1hDy7KNF1RLJXyDJ6+4hzKbxxAnWlyNFT24RAuhGdrpYVp19muiGUZKn6WyQcwRzkI
         cWAw4rqp/xpW3XVKPEBTrz3fL92Xvrb9lUhiButcBZPJ1mwgU8ijAJ1OWfabkUSJzJjy
         SEi0mUbXHl7MH4Kf75aRpTTNZCX7Za6dlcXOckGXvScPyq2Oj9yZx+BoSs7AvbWnmGfi
         Pgzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PPv7++FpeksN7EXMu0/NkT5FBZuOUS9HjZTLmuUSToA=;
        b=B4AbjmHgaY29erkAk1Oru9z4HsPGPRLbSBtEUg5Pbog6fMkWx8mJXlg2+Mmthu6zPo
         a0gkUs985caGTLBfZ4+5A/IdJ7xay+8sx0i8nUOXOX43iqd/fGZPExCa+sh54NdfRQUL
         6HWpb7/QT5/VjBbVZ7HvXgWO4YktQIgUDhuUlcuRaRrTGYqVsx7c6qeCohv3CQuzt+lm
         GYauzi3XJPEKY1s7I9pnFQhcpjxZTFUSnwGYW3LLNJwPxXkDZawVfNtE12uXjSx2TQOc
         KinxxrflYDflBKy7lU3B9tzq72JYwc+r5PdxY3SXz5yzi0pv3d00TlXXVHEZG6/riqok
         Oxqg==
X-Gm-Message-State: APjAAAWg7jw2GoIxZYa3g5JmGOEXw6pS6ckrjFrOcej1qTQ5SFMu9quk
        62AZVqUC1D90WDkNdNsZTvs0OBlrp9i6sGMIEb9DzpJTTSOmq+OdplHEu6r5QJCqLBshcretGqH
        AKNDaMDYI+yw77TNO9ZppmuJXZjpc8tiDJKTNSqhzzZxCO/WClYHu2yVye2sQ62WYXVigRbqEAQ
        ==
X-Google-Smtp-Source: APXvYqxGnPvwud3Ch9bzFj1ivFI7eCOkCHkaTz3Pq3rVmG7qEXi2hySj5yKzIrryxrku0UYueEPr72ON8ymYsniQIvA=
X-Received: by 2002:a63:78c4:: with SMTP id t187mr27922321pgc.88.1582163955953;
 Wed, 19 Feb 2020 17:59:15 -0800 (PST)
Date:   Wed, 19 Feb 2020 17:58:47 -0800
In-Reply-To: <20200220015858.181086-1-emilyshaffer@google.com>
Message-Id: <20200220015858.181086-5-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200220015858.181086-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v8 04/15] bugreport: gather git version and build info
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
index 8d4a76fdac..27f813643d 100644
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

