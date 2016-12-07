Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCB751FF7F
	for <e@80x24.org>; Wed,  7 Dec 2016 21:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932989AbcLGVCF (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 16:02:05 -0500
Received: from mail-pg0-f49.google.com ([74.125.83.49]:33667 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932669AbcLGVCD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 16:02:03 -0500
Received: by mail-pg0-f49.google.com with SMTP id 3so165816872pgd.0
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 13:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NRkYE+lpz53wAZTzQknWoWbCefzoISCc7u2IqnSEfEQ=;
        b=ZRd/6Ka4JB78uU+xvWoqH/zuHvQaXhohfsiipOU76a6LnIKVuA7Oy+gVywKIM1uM/x
         5f/qPWueWOVzP4oFh/SyAWzbMY83lnS8Dzr5XIBC60f+n8GhiQooo0EDjfSpbbGfcDqV
         +dJ3QMVgqtdu3lnfVujNQBhnt5BwmMtybSD3IcuBheCPuymEGse2EgWHZiRhkbH9itOz
         nz5SEBRTzGnANy0N6qMddDRdc4WEoDpyuegMOJLGbLjhXLSZFmQ7rJirGhJ+5AepAVH0
         T0DOJqYlQiVuXAXlh0B/rzpa9+njC8fkfGT53f1nXSnzf8odIUR9ZtwVzmr/fK0Ww3NK
         mxhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NRkYE+lpz53wAZTzQknWoWbCefzoISCc7u2IqnSEfEQ=;
        b=IVjuQYPrCtth5j0F7jHD9u73v1UHVPa8jzoa5IULlJSCLv+5brcr6nkgHlawRsGQi/
         SiAXZNZ/1+PFnndRhO2kG0GZ7ef+94bFR6CzNEsUIYK3dwFFjeFvvzxXwBJxGSRbawmR
         ydr81OAikuL5w3o4swaWTp1aorSEMbRoQgTQ1N2sc7/gnZbIUzSVFVqbOglIFPQy3gTG
         MnKNpWbk2klMjOTe9s5UZjCojiVfTiUOXAYME+SsyUUzdUNiiLSqDDwSY+tHrvY/6Rzr
         DSViE8NNBSSfolSj43bbUjU0L+IIZ/As91pbxjwJnCP7+AKPuwrgmCtD7mrpBPaXFCrc
         q0FA==
X-Gm-Message-State: AKaTC004/vgvw2zluAgV8cytymILAMe5uOS+lLxYzy2iwqXfCAe2CNZrtSjB/EkRarR0/TKe
X-Received: by 10.84.174.129 with SMTP id r1mr151276853plb.19.1481144522963;
        Wed, 07 Dec 2016 13:02:02 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:2441:4f9a:ad0f:a8d7])
        by smtp.gmail.com with ESMTPSA id v76sm44587882pfk.77.2016.12.07.13.02.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 07 Dec 2016 13:02:02 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com
Cc:     git@vger.kernel.org, pclouds@gmail.com, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv5 2/5] submodule helper: support super prefix
Date:   Wed,  7 Dec 2016 13:01:54 -0800
Message-Id: <20161207210157.18932-3-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.28.g2af45f1.dirty
In-Reply-To: <20161207210157.18932-1-sbeller@google.com>
References: <20161207210157.18932-1-sbeller@google.com>
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
2.11.0.rc2.28.g2af45f1.dirty

