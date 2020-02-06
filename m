Return-Path: <SRS0=KD4O=32=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFAA1C35247
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 00:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3AEE2166E
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 00:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sNIMidWL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbgBFAlr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 19:41:47 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:37980 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727634AbgBFAlr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 19:41:47 -0500
Received: by mail-pg1-f201.google.com with SMTP id q3so2171954pgj.5
        for <git@vger.kernel.org>; Wed, 05 Feb 2020 16:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Xn7vYQZm56gxEnLr9PuWecj9e7cLoJ7hhpV54aYx100=;
        b=sNIMidWLrYoZu2Vd3ZC1exf4h1JfdG16QLuOVbiEkVURb3levGbWUxDG4ybDxw7IaW
         yjAHdjJJx4g53vb3FDlBCjES99bsrrLYhB3JAlpiFc3gl+J0t0mRIZbjEFm4cijpJG6e
         ibV/LolxLkBVplaCFaOlKBBbfwmZVWlwp3+6+0LLs8sZCVVVSQd4Eam5h6gacpzcILc+
         SzqJ2AaWzLZVRsnZPc3ZZ3kty0b6ZcuiyDLjyElih0rGxD3Ph/61DDqmgnbJrb0XW7kG
         Xw7AK7vuI0ODYDyNgHEysu6cDp65cVTltfUg2J0XpzCuiT97O9tN5KHYQ40M7oEadron
         MOZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Xn7vYQZm56gxEnLr9PuWecj9e7cLoJ7hhpV54aYx100=;
        b=fNVWTOi0tTym+W2TAK9y1knuo0pLJNMfVK0I2V60P1NljJWTzUvu05G1c9il6ldFFT
         Y7dNd7eYwE84OLZZcHherLXb2klLSDfgMHHthATk+92RoBJaCnou4L4RwCNXBBQKYtn8
         1LLVj09ljKry31dyTViWgoLxFwGmH13a+y/lkF0JYQy/+BVuXVYMp9dS+VcoEdMOxwGf
         rsXiNhZ//w9a27GnNe5hWBmCjmuWp7juKgSlb7pEks9DXIzrAF3l4/+6WavDFXSiNml9
         3bqZJ3bQpWZNNhfEgti2JSikLysemN8HJEuZHkGwHOtnMBfS6OcvFY7K38Ks9WjPJ8rA
         H+AA==
X-Gm-Message-State: APjAAAUYD4iewo7ahXNupYtfBpp5Q1+SRALhr4OGlQ7IXDaK1cTHjwDc
        qFi6IsfjDR1t56MvNmlL+6t7btWZN83n73AHtLXGsTxgbUIKfTWIZlo8irA6R01r6bcPd7yty0x
        V2nd7O/jNUEfJc+h40y+xf+mrFUwgnqgQvpi3O9i7/GDOG8tkaM/VySn5NGngWmX9t2Zep+C5WA
        ==
X-Google-Smtp-Source: APXvYqyQamB6qh/UhLDZI+QRdPGApI99XeT6DXSHa+D82casxqM0zKDgwCrRKJt2NadMulK5hpQmNB450VVdP84c02w=
X-Received: by 2002:a63:a807:: with SMTP id o7mr595336pgf.407.1580949706144;
 Wed, 05 Feb 2020 16:41:46 -0800 (PST)
Date:   Wed,  5 Feb 2020 16:41:03 -0800
In-Reply-To: <20200206004108.261317-1-emilyshaffer@google.com>
Message-Id: <20200206004108.261317-11-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200206004108.261317-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v6 10/15] bugreport: add config values from safelist
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
index 9b51250155..16216bff8e 100644
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
 
@@ -123,6 +154,9 @@ int cmd_main(int argc, const char **argv)
 	get_header(&buffer, "System Info");
 	get_system_info(&buffer);
 
+	get_header(&buffer, "Safelisted Config Info");
+	get_safelisted_config(&buffer);
+
 	report = fopen_for_writing(report_path.buf);
 
 	if (report == NULL) {
-- 
2.25.0.341.g760bfbb309-goog

