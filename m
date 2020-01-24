Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24D0C35240
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 03:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1FC324125
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 03:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l84pa+qX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729875AbgAXDf1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 22:35:27 -0500
Received: from mail-pj1-f73.google.com ([209.85.216.73]:34777 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728655AbgAXDf1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 22:35:27 -0500
Received: by mail-pj1-f73.google.com with SMTP id c67so2121377pje.1
        for <git@vger.kernel.org>; Thu, 23 Jan 2020 19:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8qKWsQsM+MgWbCv7TZB90oKew/yDE6OgybJU0YT4zA0=;
        b=l84pa+qXrjZ3m+MCGKf1orAb2HYkWPYiE8NQKKPI2nBWKu7P5hXqb5nwRuDHdTZ8RD
         w7bEjavPqN86H4jN6Vr4KqlFngCyyJ8pp64ezR0ijderM9iJZV37DhIuEGVfNFc7Zs7Y
         /O/uqa7ZTSkiXDWKGe+H2m0wNzQstSprNqpwzAhgZX8f46EAMeL6a266OV6O3EEHknWv
         Caa1P/kfCAjezKR4whepQLuClB5Pt2G1K3qQ6V026I9IwzsY4OwR+QlEnWfkfuWpHAbh
         9XgHD/OutSnOybutWbJD2jroqLaOx3ueFVK+usAZU5/1w5a7IgtmgIruV9bteiQn9+AF
         +Jmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8qKWsQsM+MgWbCv7TZB90oKew/yDE6OgybJU0YT4zA0=;
        b=Oo8EXQR/mPR9U8/vJ9CG89W+i1sKSaIxpfiJS7g+Gxykd+6RJEKemD7zI0y08hSRVm
         VSLUthjmE6ujZmtgs+bv2Nxnq7HcSrOoEJWtzFbRlFrrOxvw6XAKfTnLOHUHgfWrmj57
         2nZJxQYhn6yFxRerwWjSthYVIVUfkr7n+Dn5NGZobjDmuYfRNdoD4mxOnrc3SukwEnPt
         dmoggrq8GcYtov5naskvDOjMkZMmZJwhtSR1g968/SFMsmGiqJyilb1F8u2z2zcMnrh0
         Txkwajps5DWe2BK3UqkJ15Hba1odwUDhHFYdo8aQjIGODrpTZg+rRPRsY2/7IZSvJyGA
         lZUA==
X-Gm-Message-State: APjAAAWsMey1uTW65CS4KPcnG8ekiDLeSBpv0pTpghInUlQJ54seCxOo
        3SeVZrjm3ZH1DRRgg6gWy1m5VKKG4fdXB0f4R1bV9tp9RAx3+/vVjiVz0kJrwfqmS/DupRJ6c7j
        9ebHCL2C2C2jtuM3jHg36qRJLTzShccRvfYBmTAt9bnQevk7ekmfYmdvuTvu+3eYpIvVJ3ftYSg
        ==
X-Google-Smtp-Source: APXvYqyCADK9jdLG+1FqU0S2ZokYXtbcO7T/J9Ak1lVCwcHftMQWeuhK1VtqutpAS76AxRBRI3PVl/t+IxFXqFhr7i4=
X-Received: by 2002:a63:2808:: with SMTP id o8mr1788141pgo.39.1579836926505;
 Thu, 23 Jan 2020 19:35:26 -0800 (PST)
Date:   Thu, 23 Jan 2020 19:34:28 -0800
In-Reply-To: <20200124033436.81097-1-emilyshaffer@google.com>
Message-Id: <20200124033436.81097-8-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200124033436.81097-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v5 07/15] bugreport: add curl version
From:   emilyshaffer@google.com
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

It's possible for git-remote-curl to be built separately from git; in that
case we want to know what version of cURL is used by git-remote-curl, not
necessarily which version was present at git-bugreport's build time.
So instead, ask git-remote-curl for the version information it knows
about.

For longevity purposes, invoke the alias "git-remote-https" instead of
"git-remote-http".

Since it could have been built at a different time, also report the
version and built-from commit of git-remote-curl alongside the cURL info.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 bugreport.c   | 16 ++++++++++++++++
 remote-curl.c |  8 ++++++++
 2 files changed, 24 insertions(+)

diff --git a/bugreport.c b/bugreport.c
index 818ccb385c..73f6d39517 100644
--- a/bugreport.c
+++ b/bugreport.c
@@ -5,6 +5,18 @@
 #include "time.h"
 #include "help.h"
 #include "compat/compiler.h"
+#include "run-command.h"
+
+static void get_curl_version_info(struct strbuf *curl_info)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+
+	argv_array_push(&cp.args, "git");
+	argv_array_push(&cp.args, "remote-https");
+	argv_array_push(&cp.args, "--build-info");
+	if (capture_command(&cp, curl_info, 0))
+	    strbuf_addstr(curl_info, "'git-remote-https --build-info' not supported\n");
+}
 
 static void get_system_info(struct strbuf *sys_info)
 {
@@ -31,6 +43,10 @@ static void get_system_info(struct strbuf *sys_info)
 	strbuf_addstr(sys_info, "compiler info: ");
 	get_compiler_info(sys_info);
 	strbuf_complete_line(sys_info);
+
+	strbuf_addstr(sys_info, "git-remote-https --build-info:\n");
+	get_curl_version_info(sys_info);
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
2.25.0.341.g760bfbb309-goog

