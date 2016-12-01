Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 368CE1FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 20:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753553AbcLAU0N (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 15:26:13 -0500
Received: from mail-pf0-f171.google.com ([209.85.192.171]:33462 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752008AbcLAU0L (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 15:26:11 -0500
Received: by mail-pf0-f171.google.com with SMTP id d2so47875459pfd.0
        for <git@vger.kernel.org>; Thu, 01 Dec 2016 12:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kh6SmDiGS4Kl9EKxzUXwtM3o4AM1GGKy3p9lp7ct/AU=;
        b=LYCS7YqfMIwg69kAb7ntRHBO+fMTY0zG3oagIIEMk5YAKkv/VBwfZfBnlFyR10Ihif
         qDUC4BVutHLtW2dUiRq1snjoGA9NPkhoRCpZEP2z7CcDqIIQl0PbLvTrkvrHSspelX9V
         gqyj6m5cqveH79Kjp1WDJevVEUJLrtbdeuts4ethIliLpPhwBaULK0XPbpNM/uTrfNId
         ma1lTYIXJM40j+F9ufxh0UB8oqG7hKFxNtq9XPFyttvihnXyHc5uMs0oMTsORk4LuGed
         n6J40v6jfOjFpP3RAsFXHqEJLNe29cENbAlbPcGbgIwCqYbHkJrIduRpxS9VCaXvG2sq
         4/MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kh6SmDiGS4Kl9EKxzUXwtM3o4AM1GGKy3p9lp7ct/AU=;
        b=QYn8YP7K4Zx01IrBzMZskFYekogpWcDjAtm66lnGf5BzPVghB3Wq157Pu3TORTPKXk
         mQqq31xdMr5gjCCR3z+Othhi3gAIofYsL1Fw+q+q+jOUiH+0kZBYLIzyDngJ3PSfBbBY
         /Luy3ik5LUguK63nFm0DPH+SGQxq0IzRkBTSZqoHG6Ue6+EeM4a2EA19BoB3l+wu/Jak
         ekeHMxaQ3QKO7IqpvgcqI7ZE1TUxZ6I3UhkypH0oECc6FRlQF0Tnhe56QmTz4zxqHFOF
         qcnyWc6K/bgTJe4xv24+j4MhuvGY1u+Bkt6xKnjlODV5forrxQJaBr10XCiaHYKW1Zrv
         WN/g==
X-Gm-Message-State: AKaTC03GrQIgd515Ckfg8wXbfiEv74qE+4RRj1pqSGEXrCSf162RIQ5OfztAtgoEqEZXbM06
X-Received: by 10.84.164.231 with SMTP id l36mr88381920plg.33.1480623971031;
        Thu, 01 Dec 2016 12:26:11 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:18d1:181b:bbf2:e96f])
        by smtp.gmail.com with ESMTPSA id n25sm2169864pfi.33.2016.12.01.12.26.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 01 Dec 2016 12:26:10 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, bmwill@google.com, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 2/5] submodule helper: support super prefix
Date:   Thu,  1 Dec 2016 12:25:51 -0800
Message-Id: <20161201202554.19944-3-sbeller@google.com>
X-Mailer: git-send-email 2.10.2.613.g22f2156
In-Reply-To: <20161201202554.19944-1-sbeller@google.com>
References: <20161201202554.19944-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just like main commands in Git, the submodule helper needs
access to the superproject prefix. Enable this in the git.c
but have its own fuse in the helper code by having a flag to
turn on the super prefix.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/submodule--helper.c | 31 ++++++++++++++++++++-----------
 git.c                       |  2 +-
 2 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 4beeda5f9f..806e29ce4e 100644
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
+	int option;
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
+	{"remote-branch", resolve_remote_submodule_branch, 0}
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
+				die("%s doesn't support --super-prefix",
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
2.10.2.613.g22f2156

