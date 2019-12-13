Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12120C2D0C9
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 00:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7F332173E
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 00:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SqAhNAUQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731734AbfLMAnr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:43:47 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:46874 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731736AbfLMAno (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Dec 2019 19:43:44 -0500
Received: by mail-pf1-f201.google.com with SMTP id w127so380197pfb.13
        for <git@vger.kernel.org>; Thu, 12 Dec 2019 16:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hZo1WEGhKd2nJ3J3y99keSOp82CsLSHX0LjnUgO7PZA=;
        b=SqAhNAUQq4+F3juxrsjv6R4Xguf6Q/2j6SUslRXqdnZPbvD6DnT3SkLgS5dfqdWukK
         d6MeT9Pm3V2o91Ub1zj7kg6lFAdq7NiXvHSqW3WtSfAxz079LN8Prj+khVkeC/AUDnUz
         apq5eRXLQfhVL69rEeUTjEXev2iGDz0ZAyXiENQQ3r3kN8CCNUAMWtKHfNtVz1DXO4zP
         +A8FuRcGhUOfl8lQosTwYgADgkahgSQMYrU/5Z9AjJx2jZO9N+1wHBvq3fXHrpLpqlXy
         BmpZ7JzI29/7Zobq/QmrRtZY1SIrYWMyHxLtM2riF8HFtl+fjhhfD12SGbhwytfWnuml
         oMkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hZo1WEGhKd2nJ3J3y99keSOp82CsLSHX0LjnUgO7PZA=;
        b=agMbzeRioBZJ4bogFWhHLTgqibOE76dPLd5No/y9aWVGRdzhx/vvsOfmm1/L8MbVvt
         MIimUhenALyvcHQz1SBcBLc0qmx5ekpWgHvzZm10ZXysPShEbFr5wCW4fAwn4frV5C4N
         MBl4I16Js8x9COdQbtlM4PA7UqA5tIdTCEDy2GU3OnQXcRELKbapA2H/rRu4hccDEJr/
         8mDkUb0+mUgXPlHSX3V/UeQ5uTwrlLIV8yETirRxLSpg6e0vsfUK3np1JOicJYQMIeNv
         nT8Cm+OV0dhFvw+F3tkDnA1Ts54bYd0mu+QfR4EGFH7RvZa7Z3SNLetp9B2AHquo8Wls
         Wbpw==
X-Gm-Message-State: APjAAAX5xtruj7Vvb0PYt52JASRyPh3Hg/ycSrNWRycyeNuT020z9AcH
        HfXb14HdNP19RUUf8CEQdOdZdOTv/O9PU1Pfhgb6spr076zQ9dQFXb3F1hiATX00syjT2XJZFMQ
        wgp9LQ4GYvRaEMpUE008ibwjOf87o0fWYhjekeuH6mzG4g49AOapZ2NKzkLoIg7j8zI9oR4bCJw
        ==
X-Google-Smtp-Source: APXvYqy+WFnDy0TDx1pj5khWXeLpxM0uzDPjFQREZYHBQXXedvUp9bCbt6s+NvMRrmx0JBLMYFEcQrFe0mY+2NWN6mI=
X-Received: by 2002:a65:4344:: with SMTP id k4mr13613479pgq.193.1576197823504;
 Thu, 12 Dec 2019 16:43:43 -0800 (PST)
Date:   Thu, 12 Dec 2019 16:43:04 -0800
In-Reply-To: <20191213004312.169753-1-emilyshaffer@google.com>
Message-Id: <20191213004312.169753-8-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20191213004312.169753-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v4 07/15] bugreport: add curl version
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's possible for git-http* to be built separately from git; in that
case we want to know what version of cURL is used by git-http*, not
necessarily which version was present at git-bugreport's build time.
So instead, ask git-http-fetch for the version information it knows
about.

git-http-fetch was chosen as git-http-backend was described as a
server-side implementation, and as an accidental fetch in case of
problems was considered less harmful than an accidental push.

Since it could have been built at a different time, also report the
version and built-from commit of git-http-fetch alongside the cURL info.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/git-http-fetch.txt |  5 +++++
 bugreport.c                      | 16 ++++++++++++++++
 http-fetch.c                     | 13 ++++++++++++-
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-http-fetch.txt b/Documentation/git-http-fetch.txt
index 666b042679..2894c5e82b 100644
--- a/Documentation/git-http-fetch.txt
+++ b/Documentation/git-http-fetch.txt
@@ -10,6 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git http-fetch' [-c] [-t] [-a] [-d] [-v] [-w filename] [--recover] [--stdin] <commit> <url>
+'git http-fetch' [-V]
 
 DESCRIPTION
 -----------
@@ -30,6 +31,10 @@ commit-id::
 -v::
 	Report what is downloaded.
 
+-V::
+	Report information about the version of git-http-fetch, including the
+	versions of its dependencies.
+
 -w <filename>::
         Writes the commit-id into the filename under $GIT_DIR/refs/<filename> on
         the local end after the transfer is complete.
diff --git a/bugreport.c b/bugreport.c
index af715dc157..f5598513d9 100644
--- a/bugreport.c
+++ b/bugreport.c
@@ -5,6 +5,18 @@
 #include "time.h"
 #include "help.h"
 #include <gnu/libc-version.h>
+#include "run-command.h"
+
+static void get_http_version_info(struct strbuf *http_info)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+
+	argv_array_push(&cp.args, "git");
+	argv_array_push(&cp.args, "http-fetch");
+	argv_array_push(&cp.args, "-V");
+	if (capture_command(&cp, http_info, 0))
+	    strbuf_addstr(http_info, "'git-http-fetch -V' not supported\n");
+}
 
 static void get_system_info(struct strbuf *sys_info)
 {
@@ -32,6 +44,10 @@ static void get_system_info(struct strbuf *sys_info)
 	strbuf_addstr(sys_info, "glibc version: ");
 	strbuf_addstr(sys_info, gnu_get_libc_version());
 	strbuf_complete_line(sys_info);
+
+	strbuf_addstr(sys_info, "git-http-fetch -V:\n");
+	get_http_version_info(sys_info);
+	strbuf_complete_line(sys_info);
 }
 
 static const char * const bugreport_usage[] = {
diff --git a/http-fetch.c b/http-fetch.c
index a32ac118d9..31844812a1 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -3,9 +3,18 @@
 #include "exec-cmd.h"
 #include "http.h"
 #include "walker.h"
+#include "version.h"
 
 static const char http_fetch_usage[] = "git http-fetch "
-"[-c] [-t] [-a] [-v] [--recover] [-w ref] [--stdin] commit-id url";
+"[-c] [-t] [-a] [-v] [-V] [--recover] [-w ref] [--stdin] commit-id url";
+
+void NORETURN version_info()
+{
+	printf("git-http-fetch version: %s\n", git_version_string);
+	printf("built from commit: %s\n", git_built_from_commit_string);
+	printf("curl version: %s\n", curl_version());
+	exit(0);
+}
 
 int cmd_main(int argc, const char **argv)
 {
@@ -26,6 +35,8 @@ int cmd_main(int argc, const char **argv)
 		} else if (argv[arg][1] == 'a') {
 		} else if (argv[arg][1] == 'v') {
 			get_verbosely = 1;
+		} else if (argv[arg][1] == 'V') {
+			version_info();
 		} else if (argv[arg][1] == 'w') {
 			write_ref = &argv[arg + 1];
 			arg++;
-- 
2.24.1.735.g03f4e72817-goog

