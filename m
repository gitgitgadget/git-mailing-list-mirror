Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37778206A4
	for <e@80x24.org>; Mon, 12 Dec 2016 19:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753021AbcLLTEq (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 14:04:46 -0500
Received: from mail-pg0-f48.google.com ([74.125.83.48]:35714 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751816AbcLLTEo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 14:04:44 -0500
Received: by mail-pg0-f48.google.com with SMTP id p66so38159366pga.2
        for <git@vger.kernel.org>; Mon, 12 Dec 2016 11:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=021vT+6JnM/5P5Oz7+8yYIZS29aOF9BoYD6x8HwzuxQ=;
        b=aJoIT+EbeBriW0jMAMiSn+muhHRxZz3pEruM++7V9RHzBK4JJGCMntnZcTArJXerK8
         v9FvSjUTMyU024I1KY8juSUeGOCWSK/DdfUB0KXu64YGkMWo5mdFe628vz6jsmkIrYAd
         3TMld1uz39SzrvOxdYocqS8OXGIz/IVaW9nRa0PkF4ZxYLqnL0r5/fEmXJ5UbZ+vnGmz
         HujDSCSjZc81jOY0W7S6BezpsFPOEXmfNyy4C1JZASzchaQKLMFZcY4XbeGPII4OUiCf
         blasHuDW0nYVqUM6rAF6x/vCVgpBh6+qyn2zL4HSjS01Gu+PK9jOJn3DKC7R2FFlh72q
         1/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=021vT+6JnM/5P5Oz7+8yYIZS29aOF9BoYD6x8HwzuxQ=;
        b=RLBq5J8h6R7+KThSMRnQB4hMVJ91KJZoCqFkOEStq5Qt2LNdJvdlV+ugKEZZQJ+wFZ
         +vxaZCXB62FUayC8CUL55twRUh2vwg+jIZ+XYPp4zuhXaCAJWkUXbCPhzhwcJQ0sBWHU
         KJfJkrMCkDQX/yc59abpNUyGz+0WSLFPAmhcKwNgi5t8F3R1fFao2NxDsxiEYXV+nK5c
         L6IWYZ5p9b1OmclkmSfu6ycqOtOrzRbbDy8+Y6NhWRLDpQ9Mya44S8BuhAcmf3cRnNsd
         rAXp87oBAoOtt9lDmrxGixdJ+4+tUFTcpgM9i0WJQnzAfTKi9vAbAtwD/1wRkgKFV+mq
         7Gug==
X-Gm-Message-State: AKaTC003CTwA1R5vM3rJEywok75Hzos184kdAfYTICpJHHDoXWFHj+WHBMZlrGS1xAjyOb4+
X-Received: by 10.99.130.198 with SMTP id w189mr32097413pgd.172.1481569483456;
        Mon, 12 Dec 2016 11:04:43 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:642c:37a4:3709:a2b3])
        by smtp.gmail.com with ESMTPSA id i76sm77227453pfk.89.2016.12.12.11.04.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Dec 2016 11:04:42 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv8 2/6] submodule helper: support super prefix
Date:   Mon, 12 Dec 2016 11:04:31 -0800
Message-Id: <20161212190435.10358-3-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.49.ge1f3b0c.dirty
In-Reply-To: <20161212190435.10358-1-sbeller@google.com>
References: <20161212190435.10358-1-sbeller@google.com>
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
2.11.0.rc2.49.ge1f3b0c.dirty

