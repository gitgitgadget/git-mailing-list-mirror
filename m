Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18221C11D40
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 01:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E22F921D56
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 01:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YpjdMwm6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgBTB7b (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 20:59:31 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:56580 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727874AbgBTB7a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 20:59:30 -0500
Received: by mail-pl1-f201.google.com with SMTP id 91so1302328plf.23
        for <git@vger.kernel.org>; Wed, 19 Feb 2020 17:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UtdpUwNkCRSn7wSPhXFJonZevlHj/8EUqs0eR5HfvPc=;
        b=YpjdMwm6yKx8sqN1xLDx290uJz3KPJpB3ED3zOKF697Qc3K1b+nFND2m4pOFd0ULFT
         CzbcE03Se++pB+fOhaL8R3TQxovrbNoTmbaRz/oC00YEQ3I4pUU2w0+InlLUwEiJ01RE
         of2gMB6Ey/OVwcfW8TjJJ1LpPsZTUwzux/ofXGFkXd0AQKA77ydd1m6dW/HnfQqDVsfW
         DR9h2eYlBvOtx3D/d2C/Mmii4cP6q67/xgoH9C80HQdrXx9SGbPsSuQgkaXSeelPwfI3
         5SnIaZu49oXfDxzbDDI+brsbDTnYahw8LTPEpoSTFxMOpPbADWVygTnfDCorcWCPFUx8
         Adeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UtdpUwNkCRSn7wSPhXFJonZevlHj/8EUqs0eR5HfvPc=;
        b=LvUaBVdjkJXUUPmM9Zbd3eXiGJlYPWh0dUWmE1O2ite07Yde8KwKtDFI/T3A5F1+q0
         +EOhg6OTA5oLuf8Yp2wtA8xsZIRoPW5+Nn7JX8XyRy4pr3ajTaMIF+fT0ig05FRQouVt
         PgMIROE92TuDCBoac7tjRXNQ/M6NRDT20dGrWUKEE93Bh95/z0p/5LOD5vYmfMM5lCTz
         fzI3zwnHDuelMqywY/iuHPaEhX0FVB5b/7nhEO5ZKWgYsEzeFma9sqZGAPEOYZYe0kCT
         Y5hgu29wUgZKoG91s54HvY7m9qA0AnZtpJy7HVzgQFMxXcew7Kci4HhCYT18xsLFXjJm
         8AEg==
X-Gm-Message-State: APjAAAWhdIDHG0mpWyYNn9KMVgGVXM1A0vBrXrcksqEV0QUfjzm6SCn4
        wDovhiFl0R2TNVAhEGXnyOojxaVts3Z8RW04SN10D5ujiIvhHOUcLxxqswiLwo9mJuNSv1vc8sI
        RYo0wpxVqrWVABWOAxmlCb67VJlHMqexq4j6dcHHe+jk81/t/GSjVKW7HLMHMvPUjUjKXmD8tiA
        ==
X-Google-Smtp-Source: APXvYqypMtNlnGwqgfR96QwkbOHywVtorLBff+46WIma5w3ki2aQLcwW/eNCe+XdNCwQxpaJjVG9Ahn8Mc26Y/toMNo=
X-Received: by 2002:a63:c64b:: with SMTP id x11mr30194504pgg.202.1582163969812;
 Wed, 19 Feb 2020 17:59:29 -0800 (PST)
Date:   Wed, 19 Feb 2020 17:58:53 -0800
In-Reply-To: <20200220015858.181086-1-emilyshaffer@google.com>
Message-Id: <20200220015858.181086-11-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200220015858.181086-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v8 10/15] bugreport: add config values from safelist
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
index f7a13c0374..efe9719ea4 100644
--- a/Documentation/git-bugreport.txt
+++ b/Documentation/git-bugreport.txt
@@ -30,6 +30,7 @@ The following information is captured automatically:
  - Compiler-specific info string
  - 'git remote-https --build-info'
  - $SHELL
+ - Selected config values
 
 This tool is invoked via the typical Git setup process, which means that in some
 cases, it might not be able to launch - for example, if a relevant config file
diff --git a/Makefile b/Makefile
index 6bdd3b9337..bf4f3ede2a 100644
--- a/Makefile
+++ b/Makefile
@@ -2135,6 +2135,8 @@ git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
 
 help.sp help.s help.o: command-list.h
 
+bugreport.sp bugreport.s bugreport.o: bugreport-config-safelist.h
+
 builtin/help.sp builtin/help.s builtin/help.o: config-list.h GIT-PREFIX
 builtin/help.sp builtin/help.s builtin/help.o: EXTRA_CPPFLAGS = \
 	'-DGIT_HTML_PATH="$(htmldir_relative_SQ)"' \
diff --git a/bugreport.c b/bugreport.c
index f143b9a8f8..70fb3b8fa6 100644
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

