Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8A1C3B18F
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 01:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87F302168B
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 01:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vpwKV54t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbgBNByS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 20:54:18 -0500
Received: from mail-qk1-f201.google.com ([209.85.222.201]:36302 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728454AbgBNByQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 20:54:16 -0500
Received: by mail-qk1-f201.google.com with SMTP id r142so5102228qke.3
        for <git@vger.kernel.org>; Thu, 13 Feb 2020 17:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NmUjZIAliovE6D2f3OLHzof6gg4XCMhi7ZLvLLnkEdA=;
        b=vpwKV54tUoCF5YUSRXSDCYZuob97KgsDSgoFSUHWWxdrPTuXGZ4iO48dKsJWBOL3Vh
         5jQhpG+tOUREO/or4FYLKGakdK5QV3yvrIfpDSzNEtr+8A4PF99Oai9TygC2RROcVR9s
         w4WxDpgEa94B/FWioMY4WI+yLUzxhKl4RXeJ4lQV3xLQzLtfzNyBLlJC/jkKk4aTTyQF
         SaWC6m0NY9VyznTU1b46u7sUbfwJefeV3KJOisxdvo+5N7ZAbwZ0DPEqWltQeFXUlLrt
         L7uPjs5oN+cTreaPXc6NMQQN0aUFtbT9Dcxv4gdo7kyOzjUyL547bYbv55aXKFik3BHi
         FZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NmUjZIAliovE6D2f3OLHzof6gg4XCMhi7ZLvLLnkEdA=;
        b=TCyouUZvbvdPcTOEOOUkZ4OVKaZ1NEGDQo/cTez61tBSP9R+KHbHeAHvNpm1oN4kGw
         UFrk4QSvcD89s/aLHo0cUaPmcairtIgY7QVbyi6+I0EvtUBxOBW7TifjUyEdsLOqEPD0
         AkamHQYe4ix92ZQyDsXR8RQ8gOkCNCbnTpUJYBzCicfa4Y1cQxokFgRt+YHQVXbgBK9T
         eBJrdQ3yfS+bOX5PDb+TYpgCdtIvvj4oT28AU91Y3rwJZkZO0nqulVNFF1FH9XQ7nEFO
         8r9AgA+mq00K5F4vtocsdlJJb2rUatqIuQ5PeMWt/OySr3k6q/pFHxQOJKj8CzXI490p
         LDvg==
X-Gm-Message-State: APjAAAUQmKJ9ixXmIkTkgePTbgZb/VNHUnE9CbpdpIOM+3rHMlwEvIfw
        h185WqMz4grgkYCIs3JNHrdfD6pUjCFumFRQyBT6unrXhXqavq0pfF5t++GJX++B85ANqcelf+c
        waRucB+qHgK8tJM940rh7clJFcoLBG4BzOrXL1+PYgoB0eTsw+1TJb04QJ7d3yb9sdZllbT7I0w
        ==
X-Google-Smtp-Source: APXvYqyTJXJbOE6PVyLJh2reiHxSk3utqLaqeqEgMbKyE8uclePkDmlfrB/maBaaWWp/RnlvYUoGjJBy1G7c0VYqMyI=
X-Received: by 2002:a05:620a:2119:: with SMTP id l25mr463148qkl.248.1581645255611;
 Thu, 13 Feb 2020 17:54:15 -0800 (PST)
Date:   Thu, 13 Feb 2020 17:53:38 -0800
In-Reply-To: <20200214015343.201946-1-emilyshaffer@google.com>
Message-Id: <20200214015343.201946-11-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200214015343.201946-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v7 10/15] bugreport: add config values from safelist
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach bugreport to gather the values of config options which are present
in 'bugreport-config-safelist.h', and show their origin scope.

Many config options are sensitive, and many Git add-ons use config
options which git-core does not know about; it is better only to gather
config options which we know to be safe, rather than excluding options
which we know to be unsafe.

Rather than including the path to someone's config, which can reveal
filesystem layout and project names, just name the scope (e.g. system,
global, local) of the config source.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/git-bugreport.txt |  1 +
 Makefile                        |  2 ++
 bugreport.c                     | 34 +++++++++++++++++++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/Documentation/git-bugreport.txt b/Documentation/git-bugreport.txt
index 23265b0d74..4e9171d1bd 100644
--- a/Documentation/git-bugreport.txt
+++ b/Documentation/git-bugreport.txt
@@ -30,6 +30,7 @@ The following information is captured automatically:
  - Compiler-specific info string
  - 'git remote-https --build-info'
  - $SHELL
+ - Selected config values
 
 OPTIONS
 -------
diff --git a/Makefile b/Makefile
index 2bc9f112ea..7b139230ae 100644
--- a/Makefile
+++ b/Makefile
@@ -2131,6 +2131,8 @@ git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
 
 help.sp help.s help.o: command-list.h
 
+bugreport.sp bugreport.s bugreport.o: bugreport-config-safelist.h
+
 builtin/help.sp builtin/help.s builtin/help.o: config-list.h GIT-PREFIX
 builtin/help.sp builtin/help.s builtin/help.o: EXTRA_CPPFLAGS = \
 	'-DGIT_HTML_PATH="$(htmldir_relative_SQ)"' \
diff --git a/bugreport.c b/bugreport.c
index c1475601bf..1a9430a857 100644
--- a/bugreport.c
+++ b/bugreport.c
@@ -6,6 +6,9 @@
 #include "help.h"
 #include "compat/compiler.h"
 #include "run-command.h"
+#include "config.h"
+#include "bugreport-config-safelist.h"
+#include "khash.h"
 
 static void get_git_remote_https_version_info(struct strbuf *version_info)
 {
@@ -52,6 +55,29 @@ static void get_system_info(struct strbuf *sys_info)
 	strbuf_complete_line(sys_info);
 }
 
+static void get_safelisted_config(struct strbuf *config_info)
+{
+	size_t idx;
+	struct string_list_item *it = NULL;
+	struct key_value_info *kv_info = NULL;
+
+	for (idx = 0; idx < ARRAY_SIZE(bugreport_config_safelist); idx++) {
+		const struct string_list *list =
+			git_config_get_value_multi(bugreport_config_safelist[idx]);
+
+		if (!list)
+			continue;
+
+		strbuf_addf(config_info, "%s:\n", bugreport_config_safelist[idx]);
+		for_each_string_list_item(it, list) {
+			kv_info = it->util;
+			strbuf_addf(config_info, "  %s (%s)\n", it->string,
+				    kv_info ? config_scope_name(kv_info->scope)
+					    : "source unknown");
+		}
+	}
+}
+
 static const char * const bugreport_usage[] = {
 	N_("git bugreport [-o|--output-directory <file>] [-s|--suffix <format>]"),
 	NULL
@@ -94,6 +120,7 @@ int cmd_main(int argc, const char **argv)
 	char *option_output = NULL;
 	char *option_suffix = "%F-%H%M";
 	struct stat statbuf;
+	int nongit_ok = 0;
 
 	const struct option bugreport_options[] = {
 		OPT_STRING('o', "output-directory", &option_output, N_("path"),
@@ -102,6 +129,10 @@ int cmd_main(int argc, const char **argv)
 			   N_("specify a strftime format suffix for the filename")),
 		OPT_END()
 	};
+
+	/* Prerequisite for hooks and config checks */
+	setup_git_directory_gently(&nongit_ok);
+
 	argc = parse_options(argc, argv, "", bugreport_options,
 			     bugreport_usage, 0);
 
@@ -132,6 +163,9 @@ int cmd_main(int argc, const char **argv)
 	get_header(&buffer, "System Info");
 	get_system_info(&buffer);
 
+	get_header(&buffer, "Safelisted Config Info");
+	get_safelisted_config(&buffer);
+
 	report = fopen_for_writing(report_path.buf);
 
 	if (report == NULL) {
-- 
2.25.0.265.gbab2e86ba0-goog

