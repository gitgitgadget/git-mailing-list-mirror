Return-Path: <SRS0=KD4O=32=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535CEC352A2
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 00:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 126CB21775
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 00:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tfFXxZNE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbgBFAld (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 19:41:33 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:50671 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbgBFAlc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 19:41:32 -0500
Received: by mail-pl1-f201.google.com with SMTP id g5so2137997plq.17
        for <git@vger.kernel.org>; Wed, 05 Feb 2020 16:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CQZ2Bvrq0TpsF/pxowKghBdFuTljBZeQYUnQLxdO4bo=;
        b=tfFXxZNEXCzBuIU70U/9HjpbRMRcs0ni2Ta/QoH187BHOuWZW+xhANL4KU6lkcVVwm
         5xQzDt3Pay8uDsjMsM+Ddnhn/elg04+yYOUyyM5gW4djpkDEvF0tT/sv0Wudz3r0DIFb
         NirV12+Wk97zM0yyP62OqGdMDRFCt6JWjWS2BUyVghkM7PAXXxXhxARpzzBz/ecGTQIx
         jZC1zjcsgf9pYXCxRPskVk4036EFvHtnzt8bO6wssvKfMHbB7avsnkIxH4FEu5OHEE2k
         mUYsV7nTKwfsiv6kvlbfKLPGSYkZXbqyb1nT1WRoeemwpxgS3jW+PbUdxWcY6qrnSoJS
         9cfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CQZ2Bvrq0TpsF/pxowKghBdFuTljBZeQYUnQLxdO4bo=;
        b=e7ndFaB1WyfoldRE9gSH9IPq43DaaK+7TYfUjspwkx7Tf2vr0cVtV7GLL1frsmlm8q
         lUx+dbEGpFWO9UQXd8aq01Ismru0QogzhHXytJHJdQ+y/MnbmhLplmU16h0guOi/JdEh
         pxyoahloBLMkrESZ/72DE/cxXUFMKAzztxNILSr87/fQ7IGLfQFLAX7BmrzvgSfiE8Cr
         FprjRMfkC2iGiKW1r9U2/MqCHKycKjX6bLIgIC12Q4JT/I9WsTKYx7CTNv+L7gW0nWVj
         DWW1I/z1MWJyn361arQ7YEsuLwDUYqxJgR1GQkf+FiAEQDhf/oyb8C0MdHMRT+65vDvy
         R27w==
X-Gm-Message-State: APjAAAXUSX9K5xcWwdiowqLvE2l2Y8zbxsFfSXFuz4JoUMVPn76aH21D
        80Odqj8y7czBc9DcCjumUu+CXAR4yrNMXcxzM6b1DAzblwfXUP+NfKfA2rLDjlSdRQrGKWJgmTM
        ZHo46QKTa+ynhRoXVuvpOsicBSIZTvz2BgcTkqZCRLa3J67j71ga46cSAFh+r4liAL9UPM1eUPA
        ==
X-Google-Smtp-Source: APXvYqzsUoEcKlWoTjCqEwNMsPFh2krMZqUlZzTTYDk5FIhHyQgU3crIlwmJdcDYj6J79KxR3WcIaivVHlqq6MdU0D8=
X-Received: by 2002:a65:68ce:: with SMTP id k14mr638634pgt.336.1580949691425;
 Wed, 05 Feb 2020 16:41:31 -0800 (PST)
Date:   Wed,  5 Feb 2020 16:40:57 -0800
In-Reply-To: <20200206004108.261317-1-emilyshaffer@google.com>
Message-Id: <20200206004108.261317-5-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200206004108.261317-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v6 04/15] bugreport: gather git version and build info
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
index db46fb88be..dd21be9d68 100644
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
@@ -67,6 +81,9 @@ int cmd_main(int argc, const char **argv)
 
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
2.25.0.341.g760bfbb309-goog

