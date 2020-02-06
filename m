Return-Path: <SRS0=KD4O=32=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A04C35247
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 00:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D71BB2166E
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 00:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NT+MbDxH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbgBFAlt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 19:41:49 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:36906 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727605AbgBFAlt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 19:41:49 -0500
Received: by mail-pf1-f201.google.com with SMTP id x10so2680408pfn.4
        for <git@vger.kernel.org>; Wed, 05 Feb 2020 16:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Xpqvzge8j5/JAisopm62IeoSPFDy2qY2aFrtcninBJY=;
        b=NT+MbDxH+mtToZy/nL8AnhRh2xKk9ykjRwXzxRkabUXgHdSrjR+CDvPMyxbwlcZB2X
         GvrA1tJ7V9b9mIzUB5blngEVMavIw5J6LBvi9JGa47BlU7uwDGYw7H3txZcJpoYNDF8X
         1ZhAd+O5vlep35fTS1A4unrv1p/4iiVP4o3T3zxIrJI9B0aeEf4CCpVjMoET7cXP/x4o
         cRG9j5pTeUj7ZMXtBNn4Rv0u+19Op5li6PXeqIyoKayOMEqPRd57WDP6hDfoQRqe/DFy
         fAHFPWPoGDkToyOOIYASwGIunHiEkvwJ1SbhgS3HgiXprrJzjkCI81wLjHX+Uf13rih+
         u9Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Xpqvzge8j5/JAisopm62IeoSPFDy2qY2aFrtcninBJY=;
        b=Bn+I6EYj8ngQBAn8SafC99xg1C+T2bDUsiJs5bXQzfcnrhrNKSwIFl7kBw/A+3XRen
         PErfWmlxs1B4SqojVTS7fjWTqRRBA67s1K2yiybtyezamD4eaDgg/JHXHrb5UXIdyGyT
         SnwOYvNqH7LUxei5YaFr9zUvwsrRGbKy2WUDjvUc0LA67wVuJsty0d4WfgTUJT/sG/Ev
         4o4SqkA9aZKZkXD0Mq2ADmFtfWZu4FKy032oudhGQMQfNBrPM0gdnTScHS31NPAlfk4s
         +heEvVYJuqFeLRJSIvOudvvXx7ZeCdWRWxjCWXVWh7fTLbcw5RbEI/yQ+w7jivBI7DDl
         p6cw==
X-Gm-Message-State: APjAAAXYtpRdj2bJJKsELs0LtdFYHgUvU3ioT4NLRNXbDQtQezT87wsV
        5dTc8b+enoh50NNLNDRCobQ4JIO2oLsKbHMzGJqSoTomTzQZOXJ9Hb0bl/OV6MN13Xsy3e+n3ps
        Bdt7NS5thXwEhtuZCAtIRnre+rkI0tnT0RGlTGtAMzZJfzqdS+/Dgfpp4r6yIKfy3ozy/Ent2Hw
        ==
X-Google-Smtp-Source: APXvYqyjBzM8wz48NZ/T82YODHBPLIGH5oyxKikpljmCY17Dnft6LytESTGjIsP3eKn/dMFlkVJp6KyYsPzjiv6TDag=
X-Received: by 2002:a63:6ac1:: with SMTP id f184mr628041pgc.133.1580949708557;
 Wed, 05 Feb 2020 16:41:48 -0800 (PST)
Date:   Wed,  5 Feb 2020 16:41:04 -0800
In-Reply-To: <20200206004108.261317-1-emilyshaffer@google.com>
Message-Id: <20200206004108.261317-12-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200206004108.261317-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v6 11/15] bugreport: collect list of populated hooks
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
index 4e9171d1bd..779c9c7fd9 100644
--- a/Documentation/git-bugreport.txt
+++ b/Documentation/git-bugreport.txt
@@ -31,6 +31,7 @@ The following information is captured automatically:
  - 'git remote-https --build-info'
  - $SHELL
  - Selected config values
+ - A list of enabled hooks
 
 OPTIONS
 -------
diff --git a/bugreport.c b/bugreport.c
index 16216bff8e..3b0a2b12cc 100644
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
@@ -157,6 +207,9 @@ int cmd_main(int argc, const char **argv)
 	get_header(&buffer, "Safelisted Config Info");
 	get_safelisted_config(&buffer);
 
+	get_header(&buffer, "Enabled Hooks");
+	get_populated_hooks(&buffer, nongit_ok);
+
 	report = fopen_for_writing(report_path.buf);
 
 	if (report == NULL) {
-- 
2.25.0.341.g760bfbb309-goog

