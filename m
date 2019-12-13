Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209BBC2D0CA
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 00:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA81821655
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 00:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rcpqoku/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731712AbfLMAnf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:43:35 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:38821 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731709AbfLMAnd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Dec 2019 19:43:33 -0500
Received: by mail-pg1-f201.google.com with SMTP id l13so350983pgt.5
        for <git@vger.kernel.org>; Thu, 12 Dec 2019 16:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tVVUHAlz5t2lfZHs7UHZfMcr2HaAk25GW3+M1vTrBPg=;
        b=Rcpqoku/ttoPoEV0+OoM1M0rOIyhV4ytkwNlZBgpJD8ruU2kdJEdscBJs4GwFp21Jy
         gtu5xL1dhi0dM4GCYYHbS49rqmPIqfptLNIurLxhH5P0xVMDxOREnk+4t1x7lKrXdnGq
         gW93Jh7clH2HYSE1G2xdUQeccgnVlzwn42bJS5xuQRX2Vegj6wg2yC+iu1QDUCjpCLGF
         Rygv8KjdIdv43isYwUW07B/l0KX808mkENEhRKa2RFa9Whshz8sRIrFPJQQy0Yj/4PWA
         pbevcYSzkzw9WCiWnS3QRqg4/8VWtfzJOeDHnLHwyjuUtYBg3kF+TXK6z0T3A2uKkJr7
         XCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tVVUHAlz5t2lfZHs7UHZfMcr2HaAk25GW3+M1vTrBPg=;
        b=QDHP2It3I3NYhxB0UwN8k+zhhfUN/QSK+VffaxazphqkRM6OLfDJEGYDostX5D/mqF
         o4w2rjhHa5CG1JFgdAQliqm5naKIH88KVB7cyFYSzYuiN2P4gzRowil0ScXz0HvBip6d
         qRPfE/8TIE854sJ1EPRhvHCRpuJG8kG5F+nH1ZvHt3i5mICqPZ0PRC9UzZ9tN0PZ31xz
         zfz6EvqsUUXqhREXk/mnDSzvBIrWXLuBe6mMkTWBU+vwdYYE2tASLEckbinB0pZ3lYlt
         KCWwWVK3JIGitWBJU5Q255t7J5UJCgvqzbzCkmOnshde09PeWcZk2/X+7az4FuKKDv9p
         FAsg==
X-Gm-Message-State: APjAAAUNOwIMPAfRjRXPTL3EgpjX0Mp3P2jC+0ULG70YqEnAAgvPjaP8
        h/ES3ifI5SCJVc/OdsMS/SaXIcMrUzNNZDS9o5GxhtiBKbMMKszrFn9v+GSiT65gzBFfw5oHJBu
        ZGgcpWSfdbWvCOHZAv9izPl65JnNk8UckULLuQW40nGJ0Onu6sOX7wlVr/Z8AIZTMS2ecTgTpYg
        ==
X-Google-Smtp-Source: APXvYqybGLa5zJ8tdwDp3krrCworTtvJl0cIg7WdNVawBudoEKtE08wNzo7H16qq5V62Swo0xVLRfLHkXnVSiGXWtVY=
X-Received: by 2002:a63:2063:: with SMTP id r35mr14289420pgm.120.1576197812389;
 Thu, 12 Dec 2019 16:43:32 -0800 (PST)
Date:   Thu, 12 Dec 2019 16:43:00 -0800
In-Reply-To: <20191213004312.169753-1-emilyshaffer@google.com>
Message-Id: <20191213004312.169753-4-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20191213004312.169753-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v4 03/15] bugreport: gather git version and build info
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
 bugreport.c | 23 ++++++++++++++++++++++-
 help.c      | 45 +++++++++++++++++++++++++++------------------
 help.h      |  1 +
 3 files changed, 50 insertions(+), 19 deletions(-)

diff --git a/bugreport.c b/bugreport.c
index 5495b31674..59d8b5a3af 100644
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
+	list_version_info(&version_info, 1);
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
@@ -60,6 +77,10 @@ int cmd_main(int argc, const char **argv)
 
 	get_bug_template(&buffer);
 
+	// add other contents
+	get_header(&buffer, "System Info");
+	get_system_info(&buffer);
+
 	report = fopen_for_writing(report_path.buf);
 	strbuf_write(&buffer, report);
 	fclose(report);
diff --git a/help.c b/help.c
index a21487db77..a43693fca5 100644
--- a/help.c
+++ b/help.c
@@ -622,8 +622,33 @@ const char *help_unknown_cmd(const char *cmd)
 	exit(1);
 }
 
+void list_version_info(struct strbuf *buf, int build_options)
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
+	if (build_options) {
+		strbuf_addf(buf, "cpu: %s\n", GIT_HOST_CPU);
+		if (git_built_from_commit_string[0])
+			strbuf_addf(buf, "built from commit: %s\n",
+			       git_built_from_commit_string);
+		else
+			strbuf_addf(buf, "no commit associated with this build\n");
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
@@ -637,25 +662,9 @@ int cmd_version(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
 
-	/*
-	 * The format of this string should be kept stable for compatibility
-	 * with external projects that rely on the output of "git version".
-	 *
-	 * Always show the version, even if other options are given.
-	 */
-	printf("git version %s\n", git_version_string);
+	list_version_info(&buf, build_options);
+	printf("%s", buf.buf);
 
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
index 9071894e8c..54f6b5f793 100644
--- a/help.h
+++ b/help.h
@@ -37,6 +37,7 @@ void add_cmdname(struct cmdnames *cmds, const char *name, int len);
 void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes);
 int is_in_cmdlist(struct cmdnames *cmds, const char *name);
 void list_commands(unsigned int colopts, struct cmdnames *main_cmds, struct cmdnames *other_cmds);
+void list_version_info(struct strbuf *buf, int build_options);
 
 /*
  * call this to die(), when it is suspected that the user mistyped a
-- 
2.24.1.735.g03f4e72817-goog

