Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF54220489
	for <e@80x24.org>; Tue, 22 Nov 2016 19:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933491AbcKVTXT (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 14:23:19 -0500
Received: from mail-pf0-f182.google.com ([209.85.192.182]:35808 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933264AbcKVTXB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 14:23:01 -0500
Received: by mail-pf0-f182.google.com with SMTP id i88so5451632pfk.2
        for <git@vger.kernel.org>; Tue, 22 Nov 2016 11:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Qz0abPB7zt+p1eRqnKlhAuS8iRS4YhyWG/BXVVFRyU0=;
        b=JA1oOezF322+Jao2zljaPss4j1w3t8VhN25SRIRWFRYAl09LzU9eMEdO9UvyiMBG3X
         MvpWl49NJN50/MsMKCG5Y0fAMDkrCuiiXbGL2tvHAQwru+RR4v9EdydKQZyAfmD/tyK+
         JU1ESY3Zyu6NrWYXenCGBz46BdTIWa6IiuCkoq1RHv2vd5wVC0KTKMOhrIY8nyQjZFmR
         fryib/hOTKwwDpn8H9NH2riXzTgzgqROFGXDRFC/9UYyOXE0xOvFks/jN56KMb6ECK5u
         FxkOpgIBe+XgUvR2Q6WoW75pLXNVthQ2bOkx1qX7x0eLTWdZs86gWi6RHVnW5jA2MWaF
         nzqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Qz0abPB7zt+p1eRqnKlhAuS8iRS4YhyWG/BXVVFRyU0=;
        b=lcmbpmvu7BpYfcQ3Y0LJH9Gm0IfZckh2qlyGVbXyRVdUiTHs7wIaMQ0isvnLp2ruRG
         awFl6D97KaxsDngi/c+Pgg8nCV4+rcAuNv6LyE8QiW9A7nQxvPb4AnPrdWybeWjnSBQy
         8NEWGljqWs2IOmh1po9ast4iurB0BEJH4Y8rm5vwGM0Psb6bZlMYE1DFbUEW0v9KE9Gb
         R55JHrAUGK7jtF2lDUh8hyaQ85qKsoAl/WY12Da7UXtRO6KyYcKaTqooFpRrCLQTal8z
         bkTIE+zSQqWKWa1++nrbkotZ0Hph9YzRR9+OwT1p2jlpI3OYviLYyCHce5F9mie4sJgG
         CYaA==
X-Gm-Message-State: AKaTC02Op+gdfB6/X8kCcxJHJbMMdLZbAlDUnwiGAUVnT6dXCflzUjD0OP2+Cmi0Iy4pcdVF
X-Received: by 10.99.49.213 with SMTP id x204mr46047254pgx.92.1479842566392;
        Tue, 22 Nov 2016 11:22:46 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:3d4e:3f15:a371:dcb8])
        by smtp.gmail.com with ESMTPSA id q2sm29032855pga.8.2016.11.22.11.22.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 22 Nov 2016 11:22:45 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com, gitster@pobox.com
Cc:     git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de,
        hvoigt@hvoigt.net, Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 2/4] submodule helper: support super prefix
Date:   Tue, 22 Nov 2016 11:22:33 -0800
Message-Id: <20161122192235.6055-3-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.4.g3396b6f.dirty
In-Reply-To: <20161122192235.6055-1-sbeller@google.com>
References: <20161122192235.6055-1-sbeller@google.com>
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
2.11.0.rc2.4.g3396b6f.dirty

