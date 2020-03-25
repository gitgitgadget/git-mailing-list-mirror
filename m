Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1353EC43331
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 21:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5B872082D
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 21:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RDhcctfK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbgCYVZW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 17:25:22 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:50653 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727406AbgCYVZV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 17:25:21 -0400
Received: by mail-pf1-f201.google.com with SMTP id r13so3273183pfr.17
        for <git@vger.kernel.org>; Wed, 25 Mar 2020 14:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cOcOWx/TGBbCwNH722vWiHG74pNEE+TGR9lWvLDDMic=;
        b=RDhcctfKgTb1o3J1e8SUmc3fHaT+JqB1UfXQMj1juqOMB27uoz3LotnNdx53aVkXZj
         2a/waHGXO+PYBERUsmPXr+Pq+EwFUsvxcstVAQ5cSpnkzD4gxWsC3jALK3zuuqGlZySb
         01tW6aBeru2IZwVjgdk8pW6v6SK8Au8B2fYZIXNUsN2U5hmwMoCfRKU+VN3g9mXv8Cv4
         olP50MRJWEpGOqg4pI9HZT4CWtLO+jy90sG4Ciky/62e+8uzXd0x/2mNj49xNuselG/x
         hRR2LdxSFiwwvzjdTAarsVIxCYJktMPJtIeWrvnD2+g0Hr07OLA8e6mXIDS/gNR86z3z
         bIPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cOcOWx/TGBbCwNH722vWiHG74pNEE+TGR9lWvLDDMic=;
        b=EI2VTiXi6P7p73WbtuJD5Kbba4s6uwTDBRDN7PhxosJZ5xuiyRrCaPnWoZpDjo96LT
         LHKFS4S01hYGEAXpIbHXxosTFw/eLlrf7h6VjRKM4JcPG5XPDpn+E4Mrlz4QiUJ7foVJ
         P+cLKMast/HIfdVLlrib/2nnX/0MxCYfXqLN4bXvSOIMDRFAihDZjrYYtzLKLZ8k9+TC
         XD2xuih31cphpI+QuLoixUhc1b/WWV1cL7/A0HBzxv7Ern3oDiqOak7uIf2mqGEyhFLU
         7x6GuJg6ogX8IYgNCPtRMuIgFKY51xOp+0zMh8Nsa7/XsKAh8+RZ20XugD/2l/rQyADV
         J3fw==
X-Gm-Message-State: ANhLgQ3+zLrMHVLdMVlZ8CyWapMfhOj3hty67KFpwD/Q6p4TyYQ85Sbk
        2D6Xncie+UyeCPK54H5z8ySWX0Ed2QSgYzw2njtbGJjzH1W7wi0HTMgQ9Jm0rKKPn451qZeNjuq
        0Rbu7m6mZr3np3opoHVVVdctLgjA6PEmlkBO5pM93uyRaLdl+Kadt7j4OSs9q6cwXZ6T204aQPQ
        ==
X-Google-Smtp-Source: ADFU+vtQpP4C354LdyIU9+7rg51bDGy9WT6UOPDnI2x4E5wogVtwvv4rC5WSshA+ptX9hbAiKr4Wo9eac/x8bTbCe1I=
X-Received: by 2002:a17:90a:2109:: with SMTP id a9mr5866564pje.12.1585171519367;
 Wed, 25 Mar 2020 14:25:19 -0700 (PDT)
Date:   Wed, 25 Mar 2020 14:24:58 -0700
In-Reply-To: <20200325212500.135046-1-emilyshaffer@google.com>
Message-Id: <20200325212500.135046-4-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200325212500.135046-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH v11 3/5] bugreport: gather git version and build info
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
2.25.1.696.g5e7596f4ac-goog

