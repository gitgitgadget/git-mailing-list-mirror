Return-Path: <SRS0=KD4O=32=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC4AC35247
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 00:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12925217BA
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 00:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DNFn9ujg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbgBFAll (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 19:41:41 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:43484 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727594AbgBFAlj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 19:41:39 -0500
Received: by mail-pl1-f202.google.com with SMTP id n17so2153419plp.10
        for <git@vger.kernel.org>; Wed, 05 Feb 2020 16:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ujjBNDyfw7GCLR2oiVSm8ReAAGWWdvXUt3+varUUjp4=;
        b=DNFn9ujg8cSIz3eg2QuZ7BKh/t2qx+dSFhNcSi9ubplihN3Q8pzN9nc1O+5DZh70og
         IRaz7/DTpilyjJfI2ckfxfd055X9CW1aM6DQXSCnbkGgjN+Hzrrg3BDOpg5aNnWhLHGn
         lqPfC+WaHa+cHfNqvilNUjX8Np025CYRRjzLUw6h9lO7kAE9o9fCRT9sjQvYgKqp1DiC
         YD6Vo0iGcKmky2gp8hIedIF8KQHVj9fQzaOg3M7wLAodwcZ7HmWZn/P3WK0jaTQRKQUF
         d54sgajhoznjnzHHzTgIAxCKoVrZqbJO5hajuVrEXJ9L6NtTNbmzwytjWdLC/vt2lXJk
         juww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ujjBNDyfw7GCLR2oiVSm8ReAAGWWdvXUt3+varUUjp4=;
        b=tEUOnBR4xnT39HyeUlcndNEFBBx6ulCmmRq4AU19NeIKykhGDflJlUqqfy+LLdWLz9
         TyGfv/PPUeToUHVoJ/rFlcygPqhpa4RXl5cI5Jv2M5shJMWTqKd7vMpRTTiyRWyB36BT
         XSicT9z5Z2XXVD43htmU1pufOzX5fDKXf00WsxUJrc0M4PAmrcv5VONJR2fdb6Q9IUbu
         ssNJh8Tv43DJ1T05lGbSgkGOR2iDVfhvSeoB+drCYmaWbya4emDL0mhuaRJYIyUgOrb/
         D5/Cy42jwLKqYkK70zJSZnxYIt3Z1fiZU5gvoO5NviV0JXJgYCBzrHyO7E1LdwoDBpNe
         G5oQ==
X-Gm-Message-State: APjAAAUwgsSms7iwIWH7oFdKze/UyRJ9VANnw0tt7eMfG/swXDIP3Jmm
        mCXJcUzhu3bxFq8OFTpIDQ3U+AqEBL+rEqmfoNJ+B2xH67+4LoSCq8HMhCqgp0NFRUdCtfzVRcG
        3s/2ZQvlFsp50heYa/4QD0DKoxKGAZkrlSs+hvnsgzi7AJLKFQJ11LpJYzVwr+eX1Fy/+P4JRhg
        ==
X-Google-Smtp-Source: APXvYqxessZrdtac2NVR/uRl/v6+PHOAUBdGn2+Exd4PC9KKtBMLmQ6L1dym7DZv2v67ZOwkC0yhVGQqbSwhEEMpHkA=
X-Received: by 2002:a63:515d:: with SMTP id r29mr611460pgl.265.1580949698874;
 Wed, 05 Feb 2020 16:41:38 -0800 (PST)
Date:   Wed,  5 Feb 2020 16:41:00 -0800
In-Reply-To: <20200206004108.261317-1-emilyshaffer@google.com>
Message-Id: <20200206004108.261317-8-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200206004108.261317-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v6 07/15] bugreport: add git-remote-https version
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's possible for git-remote-curl to be built separately from git; in that
case we want to know what version of cURL is used by git-remote-curl, not
necessarily which version was present at git-bugreport's build time.
So instead, ask git-remote-curl for the version information it knows
about.

Today, "git-remote-http" and "git-remote-https" are aliased to
"git-remote-curl"; but in case we rely on a different library than cURL
in the future, let's not explicitly reference cURL from bugreport.

For longevity purposes, invoke the alias "git-remote-https" instead of
"git-remote-http".

Since it could have been built at a different time, also report the
version and built-from commit of git-remote-curl alongside the cURL info.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/git-bugreport.txt |  1 +
 bugreport.c                     | 16 ++++++++++++++++
 remote-curl.c                   |  8 ++++++++
 3 files changed, 25 insertions(+)

diff --git a/Documentation/git-bugreport.txt b/Documentation/git-bugreport.txt
index 8bbc4c960c..33df4dec7f 100644
--- a/Documentation/git-bugreport.txt
+++ b/Documentation/git-bugreport.txt
@@ -28,6 +28,7 @@ The following information is captured automatically:
  - 'git version --build-options'
  - uname sysname, release, version, and machine strings
  - Compiler-specific info string
+ - 'git remote-https --build-info'
 
 OPTIONS
 -------
diff --git a/bugreport.c b/bugreport.c
index aaeb94c10c..da5859c131 100644
--- a/bugreport.c
+++ b/bugreport.c
@@ -5,6 +5,18 @@
 #include "time.h"
 #include "help.h"
 #include "compat/compiler.h"
+#include "run-command.h"
+
+static void get_git_remote_https_version_info(struct strbuf *version_info)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+
+	argv_array_push(&cp.args, "git");
+	argv_array_push(&cp.args, "remote-https");
+	argv_array_push(&cp.args, "--build-info");
+	if (capture_command(&cp, version_info, 0))
+	    strbuf_addstr(version_info, "'git-remote-https --build-info' not supported\n");
+}
 
 static void get_system_info(struct strbuf *sys_info)
 {
@@ -29,6 +41,10 @@ static void get_system_info(struct strbuf *sys_info)
 	strbuf_addstr(sys_info, "compiler info: ");
 	get_compiler_info(sys_info);
 	strbuf_complete_line(sys_info);
+
+	strbuf_addstr(sys_info, "git-remote-https --build-info:\n");
+	get_git_remote_https_version_info(sys_info);
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

