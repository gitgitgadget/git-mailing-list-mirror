Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC1CC35240
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 03:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31F5C22522
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 03:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sUqPMLnM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729970AbgAXDfi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 22:35:38 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:38833 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729880AbgAXDfh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 22:35:37 -0500
Received: by mail-pl1-f201.google.com with SMTP id t17so447056ply.5
        for <git@vger.kernel.org>; Thu, 23 Jan 2020 19:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oFR7nJWhTF5N+cLtzN0uc/ITeUuxrT/RCmci3iWfKyE=;
        b=sUqPMLnM77ZRAjC0Kja3tg6/WzAiR/bx7Pu+TWDSzxbj3GFfQfY53eJLIea5Qy27K9
         WfaGk219AqiZ05CkJ0KZ20ZvRROp4Mvi8EWlHebVyJtY8So9Q8LYKhW8iSVGTnwuvxkd
         induRO0v0HlRVcqh03hVLF6KfwdpKoavmxk/8D9jPSo6WXi1tBN45YCLMCb7IvNrsazY
         wkXqqbfjeKi6lmpOC705LK4Q52CSAlLFsc2T5sgYmHw7r8pia98n6fBiYpkfmoWozH6F
         gKN/FYR6y526AgBZyXgxejcfph1j6lm0Q9CvW0ymgyka1lbQ7K4OrOwvEXVuw2VsSHq2
         8W3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oFR7nJWhTF5N+cLtzN0uc/ITeUuxrT/RCmci3iWfKyE=;
        b=d+l8DhaYucdIGQt1KSuvURvaZLNzKuZ989UphVisvBGW7GRQRRFtRUUk7yfjaK/FQv
         9QdUYAsTE9/5NbYAXUZY6SYEwMwNTwxryr/byjE4KT1LDM4NXeZl4DwnQvGkFo6sOEKt
         qLOBH4EdLWNWz1cPDaoi/9oTAKW1fkd+HNE+K+jyIeXPGlHJImjySKpuQVTy5oFbCGfV
         GGoIhtBejgsa3vgFlRIvsYND2dK+vCczJQPPFRJ4jD10DFL6moFE9VCH8tQluLpoVRkL
         uj6K/QUYD2YWh9h9nVwbjerHII2KliLRugfH7d3rL7QBEJQ3h2V/qPxqG6sSFJTlPUjb
         xOgA==
X-Gm-Message-State: APjAAAUVYGVgXnWDJ2TZuo5CEXx4Kig/VDZBA84JUBUWGOUuMQN7/PWu
        /a/LidYx2MXQsNQ63J6bC2qqpfim9tWytezIkhwxpsqQ+xi0edfvT/Gi07se7V6GX1lkBTRQ9kA
        OK828h/kYUaX+Ot1uB4naHYGZB631Dv/Xl7t5rb68vUgjHdwoj1nMpDsvmFBrxi8mfUI2tZJiqw
        ==
X-Google-Smtp-Source: APXvYqw3zZECaFEYMbX+HfsENPEX6hBIKGK17awcgyGWe0qpzRr4UHfjH9OTvjFN3PYnKzUk/21CO58bfd5cl3Erd/E=
X-Received: by 2002:a63:1853:: with SMTP id 19mr1764801pgy.170.1579836936318;
 Thu, 23 Jan 2020 19:35:36 -0800 (PST)
Date:   Thu, 23 Jan 2020 19:34:32 -0800
In-Reply-To: <20200124033436.81097-1-emilyshaffer@google.com>
Message-Id: <20200124033436.81097-12-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200124033436.81097-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v5 11/15] bugreport: collect list of populated hooks
From:   emilyshaffer@google.com
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

Occasionally a failure a user is seeing may be related to a specific
hook which is being run, perhaps without the user realizing. While the
contents of hooks can be sensitive - containing user data or process
information specific to the user's organization - simply knowing that a
hook is being run at a certain stage can help us to understand whether
something is going wrong.

Without a definitive list of hook names within the code, we compile our
own list from the documentation. This is likely prone to bitrot. To
reduce the amount of code humans need to read, we turn the list into a
string_list and iterate over it (as we are calling the same find_hook
operation on each string). However, since bugreport should primarily be
called by the user, the performance loss from massaging the string
seems acceptable.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 bugreport.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/bugreport.c b/bugreport.c
index 7a9fd36b60..4c77009f1b 100644
--- a/bugreport.c
+++ b/bugreport.c
@@ -9,6 +9,7 @@
 #include "config.h"
 #include "bugreport-config-safelist.h"
 #include "khash.h"
+#include "run-command.h"
 
 static void get_curl_version_info(struct strbuf *curl_info)
 {
@@ -121,6 +122,55 @@ static void get_safelisted_config(struct strbuf *config_info)
 	cfgset_clear(&safelist);
 }
 
+static void get_populated_hooks(struct strbuf *hook_info, int nongit)
+{
+	/*
+	 * Doesn't look like there is a list of all possible hooks; so below is
+	 * a transcription of `git help hook`.
+	 */
+	const char *hooks = "applypatch-msg,"
+			    "pre-applypatch,"
+			    "post-applypatch,"
+			    "pre-commit,"
+			    "pre-merge-commit,"
+			    "prepare-commit-msg,"
+			    "commit-msg,"
+			    "post-commit,"
+			    "pre-rebase,"
+			    "post-checkout,"
+			    "post-merge,"
+			    "pre-push,"
+			    "pre-receive,"
+			    "update,"
+			    "post-receive,"
+			    "post-update,"
+			    "push-to-checkout,"
+			    "pre-auto-gc,"
+			    "post-rewrite,"
+			    "sendemail-validate,"
+			    "fsmonitor-watchman,"
+			    "p4-pre-submit,"
+			    "post-index-changex";
+	struct string_list hooks_list = STRING_LIST_INIT_DUP;
+	struct string_list_item *iter = NULL;
+
+
+	if (nongit) {
+		strbuf_addstr(hook_info,
+			"not run from a git repository - no hooks to show\n");
+		return;
+	}
+
+	string_list_split(&hooks_list, hooks, ',', -1);
+
+	for_each_string_list_item(iter, &hooks_list) {
+		if (find_hook(iter->string)) {
+			strbuf_addstr(hook_info, iter->string);
+			strbuf_complete_line(hook_info);
+		}
+	}
+}
+
 static const char * const bugreport_usage[] = {
 	N_("git bugreport [-o|--output <file>]"),
 	NULL
@@ -193,6 +243,9 @@ int cmd_main(int argc, const char **argv)
 	get_header(&buffer, "Safelisted Config Info");
 	get_safelisted_config(&buffer);
 
+	get_header(&buffer, "Configured Hooks");
+	get_populated_hooks(&buffer, nongit_ok);
+
 	report = fopen_for_writing(report_path.buf);
 	strbuf_write(&buffer, report);
 	fclose(report);
-- 
2.25.0.341.g760bfbb309-goog

