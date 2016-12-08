Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D990120259
	for <e@80x24.org>; Thu,  8 Dec 2016 21:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753363AbcLHVEO (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 16:04:14 -0500
Received: from mail-pg0-f43.google.com ([74.125.83.43]:35563 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752319AbcLHVEF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 16:04:05 -0500
Received: by mail-pg0-f43.google.com with SMTP id p66so177696971pga.2
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 13:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U7j9yfaCd6iNJveTAwKgY2WHT/IRoC3y4r/O8vLZNJM=;
        b=I7CWoQ0sX5M0w93QLRkVzVyJEWqW94tjQbfAjFfaE4l2Pp/Kc2kM0SRJ8Z8P8Ncwf2
         3qTc9Ka4oI76ITc0xG3/Jm4mv7jfEJ5L+TVhSfGlH6Anp5HbIJTaZa4SBuoGLwGpptP3
         mEW82xy6cBfAq8jGf49t8bQYiz3WdPFha6vyLhW840E4hXXHr9GN+5TqOe2s7Ph61kbU
         ohf7zDT83XEv3CW6BsJx+suNpuiGJzVDX0sPpObgmcd41DAntq+QQ321MS2GmXpuRW2k
         ItAFp5OLMGHjCvG2qahwQAylxUnLPaGtKO6qQ6ri7W6ktXwSCfZjbpHTRNkaU6x3CXox
         cORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U7j9yfaCd6iNJveTAwKgY2WHT/IRoC3y4r/O8vLZNJM=;
        b=jwco5b3F/Kk1qvnYD4fbEt6UVARMKewpDD42yaaayOd/mH4UkuZ1rNCZoDr0on+CFP
         YrMko3Jv+NmRWC4HEa16A4jth9Yfhr/O1/TZoL3JJpluKDdblmIAkj8sjR5GCmNR610+
         JLFUyySaXhjhtRQO2GqaimK0vUbFvWDYC77l1VPeEgWElUnwoBMKGcl0N9sT/TVodQWq
         T1ZS5puWDIRnBTeWtPPrNrXPMihSHFNmXA+AMXT5oGeBWA154JrkunOznzhdQPHiBW1u
         SMBXntWnLyftZNz6wwID0bNMUisbf6AxLTIniwhiHGw2jRTksym/DVpbk4C5zSCHPRZW
         YpnQ==
X-Gm-Message-State: AKaTC03bt1QBANmpGBT8YxohJbAq04ANQ47mWWXprsyGexuo4MTK1qrKTqhk7dTvh7+dM14H
X-Received: by 10.99.24.84 with SMTP id 20mr136334881pgy.12.1481231015573;
        Thu, 08 Dec 2016 13:03:35 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:6884:a3d1:aaf8:234b])
        by smtp.gmail.com with ESMTPSA id c8sm52281396pfe.15.2016.12.08.13.03.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 08 Dec 2016 13:03:35 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com
Cc:     git@vger.kernel.org, pclouds@gmail.com, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv7 2/6] submodule helper: support super prefix
Date:   Thu,  8 Dec 2016 13:03:25 -0800
Message-Id: <20161208210329.12919-3-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.29.g7c00390.dirty
In-Reply-To: <20161208210329.12919-1-sbeller@google.com>
References: <20161208210329.12919-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just like main commands in Git, the submodule helper needs
access to the superproject prefix. Enable this in the git.c
but have its own fuse in the helper code by having a flag to
turn on the super prefix.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 31 ++++++++++++++++++++-----------
 git.c                       |  2 +-
 2 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 4beeda5f9f..5643848667 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1076,21 +1076,24 @@ static int resolve_remote_submodule_branch(int argc, const char **argv,
 	return 0;
 }
 
+#define SUPPORT_SUPER_PREFIX (1<<0)
+
 struct cmd_struct {
 	const char *cmd;
 	int (*fn)(int, const char **, const char *);
+	unsigned option;
 };
 
 static struct cmd_struct commands[] = {
-	{"list", module_list},
-	{"name", module_name},
-	{"clone", module_clone},
-	{"update-clone", update_clone},
-	{"relative-path", resolve_relative_path},
-	{"resolve-relative-url", resolve_relative_url},
-	{"resolve-relative-url-test", resolve_relative_url_test},
-	{"init", module_init},
-	{"remote-branch", resolve_remote_submodule_branch}
+	{"list", module_list, 0},
+	{"name", module_name, 0},
+	{"clone", module_clone, 0},
+	{"update-clone", update_clone, 0},
+	{"relative-path", resolve_relative_path, 0},
+	{"resolve-relative-url", resolve_relative_url, 0},
+	{"resolve-relative-url-test", resolve_relative_url_test, 0},
+	{"init", module_init, 0},
+	{"remote-branch", resolve_remote_submodule_branch, 0},
 };
 
 int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
@@ -1100,9 +1103,15 @@ int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
 		die(_("submodule--helper subcommand must be "
 		      "called with a subcommand"));
 
-	for (i = 0; i < ARRAY_SIZE(commands); i++)
-		if (!strcmp(argv[1], commands[i].cmd))
+	for (i = 0; i < ARRAY_SIZE(commands); i++) {
+		if (!strcmp(argv[1], commands[i].cmd)) {
+			if (get_super_prefix() &&
+			    !(commands[i].option & SUPPORT_SUPER_PREFIX))
+				die(_("%s doesn't support --super-prefix"),
+				    commands[i].cmd);
 			return commands[i].fn(argc - 1, argv + 1, prefix);
+		}
+	}
 
 	die(_("'%s' is not a valid submodule--helper "
 	      "subcommand"), argv[1]);
diff --git a/git.c b/git.c
index efa1059fe0..98dcf6c518 100644
--- a/git.c
+++ b/git.c
@@ -493,7 +493,7 @@ static struct cmd_struct commands[] = {
 	{ "stage", cmd_add, RUN_SETUP | NEED_WORK_TREE },
 	{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
 	{ "stripspace", cmd_stripspace },
-	{ "submodule--helper", cmd_submodule__helper, RUN_SETUP },
+	{ "submodule--helper", cmd_submodule__helper, RUN_SETUP | SUPPORT_SUPER_PREFIX},
 	{ "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },
 	{ "tag", cmd_tag, RUN_SETUP },
 	{ "unpack-file", cmd_unpack_file, RUN_SETUP },
-- 
2.11.0.rc2.29.g7c00390.dirty

