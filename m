Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA3CC11D42
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 01:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2459824672
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 01:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="REs6pN9Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgBTB7d (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 20:59:33 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:56581 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727749AbgBTB7c (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 20:59:32 -0500
Received: by mail-pl1-f202.google.com with SMTP id 91so1302372plf.23
        for <git@vger.kernel.org>; Wed, 19 Feb 2020 17:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3mXqx2Fz+k1LmCHJaevWcnvPCIb0FxBCTtPRU/FZmQc=;
        b=REs6pN9ZPDj2OEhg0Xz9RbFI2m3I6YkPdtkT5qKGAwgw6aDZZvDaLMJYeXtvZHE83G
         BdTKvD764bnoGY2+V4kiujgFexUpZpNhWmkKs1tUrbjt0gKtbjj6WcoVJGtolpB+c3GS
         RC7chuMB0fuAnHHAlbVckdEaZNhxTPEBB3Tyn9nkjjsGzQeLTRL1nUW3aeumToKVypFE
         lmoRAmxUnNWiH2j5PSWcJaY2GEuXuXcJHMnQupUEfZF4lwmHdB8Rx4DegH0TQxggVnVc
         +OKiEZXT164JS+ojKBguyPl5Mqmja82cHN/nB2V1lelseJvk9wCaaMIUnXZ1ipJGXbpO
         vb6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3mXqx2Fz+k1LmCHJaevWcnvPCIb0FxBCTtPRU/FZmQc=;
        b=nhNy6ocFE3atX664nMFOVndgYoXE/cdZaaxUm5/LW5xI+HcqpMwknvuCAP6OGVpJqC
         Uhe8pcUC5U5YpSPqQHd3YTWkUCW2WYjGpXFNugBUQvsxgHwNg1mIkHLZRVwx+q7Wa4IP
         ix1yYWPes5nBQEelpnhygpv3K50tsXbtEpRMZKl0Fi2Wt+1LlbWmjr0X4zTySzs7D9nw
         rYZfW3yhdKesn/W+N2Q0oBFs/X1rw2p9EQUYVdNHG059jkIYvTJEjsk5IbJDKpXhgGRB
         d+L70ZWTizXwc/6bwXCk5zx7TXd8NSQd1PbOyDVluinYMsRfuP69jpUh7aofkKMsFFgp
         uh+A==
X-Gm-Message-State: APjAAAWkr8qlFllZeNmSK1Ad1TekTjDHGy8UnHAcD2XHzUD9+t1bghuD
        OykMnznMv0U6dfhn3fc8DBkImNzLMVQynZ+PFbSuY2RsLW0Llwp404BKL8k1lpjnadL//xhnhq2
        yCvBwpmpjXCV+Ipzmf7nbbbM05fexZSt6fY+OR+aCjtItLoyj1H3iZtj7kkLGtot3Wv+mIUJl2w
        ==
X-Google-Smtp-Source: APXvYqzFTzr9D6VpaVkj1kANl16FYyT/PRapj2f8TEC6VV9VrLePdTgaRpFWqgDSwmsqhJZRfzQNZnBmov3GuBeblDY=
X-Received: by 2002:a63:be48:: with SMTP id g8mr31725889pgo.23.1582163972017;
 Wed, 19 Feb 2020 17:59:32 -0800 (PST)
Date:   Wed, 19 Feb 2020 17:58:54 -0800
In-Reply-To: <20200220015858.181086-1-emilyshaffer@google.com>
Message-Id: <20200220015858.181086-12-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200220015858.181086-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v8 11/15] bugreport: collect list of populated hooks
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
 Documentation/git-bugreport.txt |  1 +
 bugreport.c                     | 53 +++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/Documentation/git-bugreport.txt b/Documentation/git-bugreport.txt
index efe9719ea4..4d01528540 100644
--- a/Documentation/git-bugreport.txt
+++ b/Documentation/git-bugreport.txt
@@ -31,6 +31,7 @@ The following information is captured automatically:
  - 'git remote-https --build-info'
  - $SHELL
  - Selected config values
+ - A list of enabled hooks
 
 This tool is invoked via the typical Git setup process, which means that in some
 cases, it might not be able to launch - for example, if a relevant config file
diff --git a/bugreport.c b/bugreport.c
index 70fb3b8fa6..b5a0714a7f 100644
--- a/bugreport.c
+++ b/bugreport.c
@@ -9,6 +9,7 @@
 #include "config.h"
 #include "bugreport-config-safelist.h"
 #include "khash.h"
+#include "run-command.h"
 
 static void get_git_remote_https_version_info(struct strbuf *version_info)
 {
@@ -78,6 +79,55 @@ static void get_safelisted_config(struct strbuf *config_info)
 	}
 }
 
+static void get_populated_hooks(struct strbuf *hook_info, int nongit)
+{
+	/*
+	 * Doesn't look like there is a list of all possible hooks; so below is
+	 * a transcription of `git help hooks`.
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
 	N_("git bugreport [-o|--output-directory <file>] [-s|--suffix <format>]"),
 	NULL
@@ -166,6 +216,9 @@ int cmd_main(int argc, const char **argv)
 	get_header(&buffer, "Safelisted Config Info");
 	get_safelisted_config(&buffer);
 
+	get_header(&buffer, "Enabled Hooks");
+	get_populated_hooks(&buffer, nongit_ok);
+
 	report = fopen_for_writing(report_path.buf);
 
 	if (report == NULL) {
-- 
2.25.0.265.gbab2e86ba0-goog

