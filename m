Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B029BC35241
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 03:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81E0524125
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 03:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oHdOIjMd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729624AbgAXDfS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 22:35:18 -0500
Received: from mail-vs1-f74.google.com ([209.85.217.74]:54682 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728655AbgAXDfS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 22:35:18 -0500
Received: by mail-vs1-f74.google.com with SMTP id l1so45966vsr.21
        for <git@vger.kernel.org>; Thu, 23 Jan 2020 19:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7hnJFTXG0VTuFPNr3IRwCWsuYdQmVj8ZgovBHCF4rWw=;
        b=oHdOIjMdmJ1D70WV72FOLxsQ4NSyjxVrhyfLJC6iVA9UN5sZofYPf5eU2h7wm1U+8S
         AuiDILosKMMP/y+GdA9+zrCg3i9LK40VBfhNPHVUH08tSuxz0ypWc8csZ335kAeT0Ggk
         de0Cw+nbuGZ8zFXwzvlzx2QLNIKJdLqByZCAqXJ+v0duWHAoFyM8e/WxpvMNRLYmbvpW
         w9c20HqIvsq4Wb1lkmiS9MmhlrHI8hS7btKf/RL6PXMCCSpxTnEvgfi7ysd16b+Snejk
         CkRPgJNHz+IYgg+2oQG1Bf7895ymymLACgbJG0O7/KzzwEp1QRjAAbVRj3AsiR0uW+NR
         dcEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7hnJFTXG0VTuFPNr3IRwCWsuYdQmVj8ZgovBHCF4rWw=;
        b=fKI0YVUAGJb1C7AjsuP46azZIwwEP4c+ma7JrcND0epbc4tZkeAgFPCVx8CP/d3767
         tj3MOBNYtMbXmH64VkIkCWf1Ky5bm2rcvHoVrfRypVRECQl6ft/k2OENP2VFWpAYPAiF
         Mn6uOCFK73kLKcIZPh9OklToQL+arPMqoRIIKdhoK874hmVlZq5FCWjCNMb6EioCGe/r
         MiIqNEh71DRoXguqTTRTxyDB4ER7mkq1peWJqyHwzT851FuKlB9JLvgk3/TNdyoqXmJr
         +WnW5mat0RZon7nWD+/J2ncKzMZJokUMRMqcoSyVcoKNOSA3+QZYzkkAlL3/BCJv7A0G
         kVlg==
X-Gm-Message-State: APjAAAVz0ZqBO4EB4i/bzMrAOB8GJhj11/KzyKvEXCd6y6WnA7P/nesJ
        Cy22aCXqYgtfs/9xAHYjh3LwFWDmq/7EJ2Mr9AZoUP0FCfEKy/kQ3rpYEZJYBroOPD0012mXmmg
        j02RjbA+AP08vMYf49ufgdriZP567CEJKKRnBcM5u90N73DDLP00q8UDr7XkVwrcvBscJeF67vQ
        ==
X-Google-Smtp-Source: APXvYqxPOH3S00jwL4w6c1BVRg1aH8i9UOrt1ftZUbiqApde8BakTbHKEfrfbG56+Vd8oG7lE01SS1u803nRvtvx+XA=
X-Received: by 2002:a67:fa51:: with SMTP id j17mr982156vsq.59.1579836916944;
 Thu, 23 Jan 2020 19:35:16 -0800 (PST)
Date:   Thu, 23 Jan 2020 19:34:24 -0800
In-Reply-To: <20200124033436.81097-1-emilyshaffer@google.com>
Message-Id: <20200124033436.81097-4-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200124033436.81097-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v5 03/15] bugreport: gather git version and build info
From:   emilyshaffer@google.com
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

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
 bugreport.c | 22 +++++++++++++++++++++-
 help.c      | 47 +++++++++++++++++++++++++++++------------------
 help.h      |  1 +
 3 files changed, 51 insertions(+), 19 deletions(-)

diff --git a/bugreport.c b/bugreport.c
index 5495b31674..b1a5a279ac 100644
--- a/bugreport.c
+++ b/bugreport.c
@@ -1,8 +1,20 @@
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
+	struct strbuf version_info = STRBUF_INIT;
+
+	/* get git version from native cmd */
+	strbuf_addstr(sys_info, "git version:\n");
+	get_version_info(&version_info, 1);
+	strbuf_addbuf(sys_info, &version_info);
+	strbuf_complete_line(sys_info);
+}
 
 static const char * const bugreport_usage[] = {
 	N_("git bugreport [-o|--output <file>]"),
@@ -32,6 +44,11 @@ static int get_bug_template(struct strbuf *template)
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
@@ -60,6 +77,9 @@ int cmd_main(int argc, const char **argv)
 
 	get_bug_template(&buffer);
 
+	get_header(&buffer, "System Info");
+	get_system_info(&buffer);
+
 	report = fopen_for_writing(report_path.buf);
 	strbuf_write(&buffer, report);
 	fclose(report);
diff --git a/help.c b/help.c
index a21487db77..156a6cdea3 100644
--- a/help.c
+++ b/help.c
@@ -622,8 +622,33 @@ const char *help_unknown_cmd(const char *cmd)
 	exit(1);
 }
 
+void get_version_info(struct strbuf *buf, int show_build_options)
+{
+	strbuf_reset(buf);
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
@@ -637,25 +662,11 @@ int cmd_version(int argc, const char **argv, const char *prefix)
 
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
2.25.0.341.g760bfbb309-goog

