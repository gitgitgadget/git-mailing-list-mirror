Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D4FC3B195
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 01:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74E1D20848
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 01:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nsbrRUsG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbgBNByT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 20:54:19 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:33630 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728467AbgBNByS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 20:54:18 -0500
Received: by mail-pf1-f202.google.com with SMTP id c72so4974972pfc.0
        for <git@vger.kernel.org>; Thu, 13 Feb 2020 17:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KtQc2NqQlhwB5rQ3CSYNZW6h8xao3iiZQNiOwbO0syc=;
        b=nsbrRUsGf9cYXjUqBd7VTIBPv214mWQNRdQoLea8UNcmMGu67GqVzST7WXlP3WcriK
         avFdRxJPDJ1DPcLQBt3SF+t2Qqt9/sXqM0wF7eCUjrX3vCwjiDZ7aa/mVO1sZwVIVJ1M
         mf2OliT/1vlRkFoWzhCtCyD1N9eOiwVReOP3CTumLJYp//KuBZrXEqW0tCIVC1Zfakr3
         FeAv97C2Okvu/FWiqLDk+BFSYFdQiCafcZta5X1vw4h+HhUbxu8sldB/PP6pcu2PsRfF
         QgZGh6db2jB8ulVooIzgq4JuLgPB4go7K6I4zSySB01Pkb2oK6Vi/W80tnYL5a0rZaUM
         Uc/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KtQc2NqQlhwB5rQ3CSYNZW6h8xao3iiZQNiOwbO0syc=;
        b=ap0zcwQDMdgrV9bPfMnnB/h8TFedwmdRECg+VIA8IfE64TTfTMO04yjG6UAawRIuTS
         foDUDldztk1Y6Bq59joENaokFgzDzMn/HdxC9xyojzcON66BQMA4SpBY+wqFYPy61M5y
         P8MDW3cP8OxVHcI9Y+jJdR0LclxgY4dgSBMXnOruDFRBdW3frxk16LLo365zfsWiR4QM
         mWXPd0LypO5Opgqb/Xhv/2iPUL0NYGE1gR4gqOsFWRZQB2ANPuby67em5/GgvFEkKFG/
         bm1tahHlxwbJ4o5c0Drf4nwrCZL6TIxikY43sO98VBWWFLg0eYRHQPk7spYS64ZUthQQ
         3GHw==
X-Gm-Message-State: APjAAAU4HedRNja1wcYmViTlc2XnS8mxLOReyWuE9EVIpynsQz42qdKa
        OyziRRreYyrzIOtKsDLRNq8uZqub6i/06N8yXAFvtUA063bCUrg51SGagbDDNODk15yRK/kXoVX
        wn5XOp68YYJT4A+hllKzcg1wyWaoVv0R1K2iamJDl92/LWR28mgeR+OlnXiIREZmgg8PAMJXvdw
        ==
X-Google-Smtp-Source: APXvYqwAFPoWMDEN6eo8zFJCCE8yNrNiX7MT6aT1HbyR2fyuCC31aR8L6tA9N6ErFkWY1cHbBJenjF8CHwTuMLemA6A=
X-Received: by 2002:a63:cb11:: with SMTP id p17mr935226pgg.42.1581645257911;
 Thu, 13 Feb 2020 17:54:17 -0800 (PST)
Date:   Thu, 13 Feb 2020 17:53:39 -0800
In-Reply-To: <20200214015343.201946-1-emilyshaffer@google.com>
Message-Id: <20200214015343.201946-12-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200214015343.201946-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v7 11/15] bugreport: collect list of populated hooks
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
index 1a9430a857..7e6147a935 100644
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

