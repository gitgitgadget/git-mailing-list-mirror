Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8562FC43603
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 00:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59AB32253D
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 00:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CFFrXenE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731762AbfLMAnz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:43:55 -0500
Received: from mail-vk1-f202.google.com ([209.85.221.202]:49511 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731745AbfLMAnz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Dec 2019 19:43:55 -0500
Received: by mail-vk1-f202.google.com with SMTP id k4so294932vkh.16
        for <git@vger.kernel.org>; Thu, 12 Dec 2019 16:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pPwKYO4OFf6PjcDKaM3OUDjjtUpTYBkjNIA6p+i+5f0=;
        b=CFFrXenEPBVCqDspJebES1qAtN4tqoT3f8NNrnOTLR/r2wfhWRrF3IVomRsJTfi6P2
         xmwWemCCEaEcIOSl6IhXogcr3MfjY+bg2l8mdssx6CiH+Tehs06LzZBwWsZLKBx79f2l
         8an1tmNgeOZwSxxBD3REDp+VB6WUM1c6GNGdO/wIPYdwSbKu97s56oNP+mpqyT2KPHLD
         TTayOBs7ihFLtIn64r97UhOOrAakOfdbdeMgL9WwmAy7UiQddgbXo+1hVOHiSxPzMHXQ
         47EHM8CQ+7nMc4X0K6xomCg1WnzBiA3IbUGbU+dlzS6MJELoZAZO6MPo1IDXdj1pYCNX
         a9CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pPwKYO4OFf6PjcDKaM3OUDjjtUpTYBkjNIA6p+i+5f0=;
        b=DE/jPhILQf2CWR9x+kRFcEfKeGk3hptOeJekU6NLDaDZ5SCBXPj+jHN3LST8y6uqyD
         hGs6aLzrOf5jxAFMlMjtgEgvvQbQh7KZfuM5QO2bHmrMOH5qqQjV/GP9TTVoanCYZnVA
         jIvpohz+Dx663T0j0Vq2Y4Gk38I+d21kH2ss/kLfEpabBD0n4rQahbYmo00wQgEMSRP6
         2tRQmO7JV85vTJ5QlF21kKEmKzAWeKYeGWYjNcr53+aIurUgjBEikirPkZUbDrmQLGqw
         fzehc98iyRpSirn0rt+EqqFGZTM28QqAE/And1tkMR/EyCb3ZG3VM4vw6+fWhJk8Jetc
         IR6w==
X-Gm-Message-State: APjAAAXkaGr8VxMRpJksKX1PhrAxOjRyftyXTeXRVJ+LAsLLLiUuAD9v
        qre73Y2XHZC44SvjZmawYpcSUvCHBYXBx5Jw7K3b8A8DMnsuB8Ccq0TJnq/7+oQS5zCqT9ipZD6
        Hbjb2tB2Ehr/Uw8dzamwpctO6Xc+LNVqHj8F0sUR6JCWXUjPzvXEZq0EcvLTFCu1UjK3/S2S8Ag
        ==
X-Google-Smtp-Source: APXvYqxxcifKJAMiX7QEsgf9LR267bkZo6YvOX+3AXPd5l8polh+UvjHjxDetye1pD7CaeawXzOYM0Qo/RJPPpAW8wU=
X-Received: by 2002:ab0:3387:: with SMTP id y7mr10662423uap.99.1576197833839;
 Thu, 12 Dec 2019 16:43:53 -0800 (PST)
Date:   Thu, 12 Dec 2019 16:43:08 -0800
In-Reply-To: <20191213004312.169753-1-emilyshaffer@google.com>
Message-Id: <20191213004312.169753-12-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20191213004312.169753-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v4 11/15] bugreport: collect list of populated hooks
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
 bugreport.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/bugreport.c b/bugreport.c
index 1fca28f0b9..f89cb8d754 100644
--- a/bugreport.c
+++ b/bugreport.c
@@ -9,6 +9,7 @@
 #include "config.h"
 #include "bugreport-config-safelist.h"
 #include "khash.h"
+#include "run-command.h"
 
 static void get_http_version_info(struct strbuf *http_info)
 {
@@ -121,6 +122,57 @@ static void get_safelisted_config(struct strbuf *config_info)
 	cfgset_clear(&safelist);
 }
 
+static void get_populated_hooks(struct strbuf *hook_info)
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
+	int nongit_ok;
+
+	setup_git_directory_gently(&nongit_ok);
+
+	if (nongit_ok) {
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
@@ -188,6 +240,9 @@ int cmd_main(int argc, const char **argv)
 	get_header(&buffer, "Safelisted Config Info");
 	get_safelisted_config(&buffer);
 
+	get_header(&buffer, "Configured Hooks");
+	get_populated_hooks(&buffer);
+
 	report = fopen_for_writing(report_path.buf);
 	strbuf_write(&buffer, report);
 	fclose(report);
-- 
2.24.1.735.g03f4e72817-goog

