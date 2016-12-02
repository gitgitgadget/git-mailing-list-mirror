Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51EE51FC96
	for <e@80x24.org>; Fri,  2 Dec 2016 23:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755585AbcLBXn1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Dec 2016 18:43:27 -0500
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34094 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752731AbcLBXnR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2016 18:43:17 -0500
Received: by mail-pf0-f169.google.com with SMTP id c4so54958459pfb.1
        for <git@vger.kernel.org>; Fri, 02 Dec 2016 15:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NmJFitmKxLnxhnIL/MScg4zowf5Q7Q5JMTpxqlblDF0=;
        b=jGoTUyLfSitBQDdS4a2wRQOZRQLV9oKKRUHasjEDuM/wHtkhLXf3+e1K1Ejwj3yUtI
         g/GFnKWxzzwVb0/fvuvhl+dczqDnUeQ+nWMFtkqp1aqpkZPkZGFslwQsLs7/0M9XLYKT
         7ovf3IeJotNHpNXHmtEfcu8IQmJ+mWttBDBqVzHlNwAPZrhw2c54/Ipi4sKVY1U7DCfd
         eMe+KQbwejt3Ngqwv6atVjs8L4vEMsgZ1Hm7Q0/2HncP1OrCKqjrttfP8/remT5dRPJl
         jyrkhW0X3Dto6dr6m2jxyUoSArnKKT9z7Am3H9BmIa/timKiAMg4T1mPlbYtYqcBdbLG
         91Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NmJFitmKxLnxhnIL/MScg4zowf5Q7Q5JMTpxqlblDF0=;
        b=fqCApFiY1Ml2GK2GWbzO3H7+FiU3SCZRswAyWBUjK/19US+giyp48qQ4MekqZLDJ8I
         6m8wtFhRfawMsD8XCXNmRFaZxH/xEYBxV71abEh5MYlrat87ThPJ7kVR0tcAQxK7oLbG
         iN0OVPnhiYfsV+FrHSw2E+0/+2n7VcNZlSMzLyfiUUKLO+GiPck6hnvxucL2XjJ6UeTR
         zs5BrFpVdh9ENJxWZJURBUY2Dkr1Zd5Bgo/vHMnDZgfc6qRqoOOyHyOKh2tXtq+430HR
         G6BQTqyrI5JXN//kr75GtvQ35JhegrGACdXsAekyzb6FhxBf2z+V9/C5lid5eEczWYdk
         b7aA==
X-Gm-Message-State: AKaTC029BMBI8N2NqOfllHBlA7hCNiK+A4UZw6zgXaUKG1F2qy8IQuiC+Rodf4yUgxYBImHn
X-Received: by 10.99.153.26 with SMTP id d26mr84299539pge.44.1480722146344;
        Fri, 02 Dec 2016 15:42:26 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:99ac:e2be:c532:3e35])
        by smtp.gmail.com with ESMTPSA id l69sm10156983pfk.34.2016.12.02.15.42.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 02 Dec 2016 15:42:25 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     pclouds@gmail.com, bmwill@google.com, gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 2/5] submodule helper: support super prefix
Date:   Fri,  2 Dec 2016 15:42:17 -0800
Message-Id: <20161202234220.24664-3-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.28.g2673dad
In-Reply-To: <20161202234220.24664-1-sbeller@google.com>
References: <20161202234220.24664-1-sbeller@google.com>
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
2.11.0.rc2.28.g2673dad

