Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FAE0208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 13:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbeHHQLA (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 12:11:00 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:47050 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727251AbeHHQLA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 12:11:00 -0400
Received: by mail-ed1-f67.google.com with SMTP id o8-v6so1274047edt.13
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 06:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NRwUxYF0OT/c+4KUQieDDAx3+4pbyqoI43a7cReqxYU=;
        b=OGEdeNm63L0btwXrzuz/LBkYmlI4JQChMUJHALpUKzD+dc2uV0aTZOuHOXY4gMpoNn
         KnuyoBI9sqpbr1btLAeblIRanyTuMJTXb7Y+bfx/Inb5QwJBMLqU2MlXiJkIbyv4IyM/
         b82kkr9aO9q1nJM4pfG+NuUA66CJgj4/6go5zQr1RM6x+fIyO+020aETYb0p1Quhoc1V
         s0daAE1E2CVNQ20fp77D/14rPTZPbeprLbvL5tbhKHwKnRXD8rR/fC9u/6bpFFc+w1MA
         Tnn5ICUJqjWtBqPSZWAHR4966vbscZBnvorcozlT452EXwbjZvZP0DNl0CLfqAx9uxKB
         2lYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NRwUxYF0OT/c+4KUQieDDAx3+4pbyqoI43a7cReqxYU=;
        b=QepEoa8f8O8eNowy1bq3+Q0CDCvxg1Q3EQDdB7HSZsfsDFa8oWsxTNUM6PYQEIOOcr
         VWX6lhtOeyqcUZO19l8AsOL5JVqYNTgjXvTp1zK14QU2u/m4hP3oUKGVPzwl02QdJhsD
         DpboveBzZaNmuzgsftbbOarfWY2d/fc5pxGmNIKLmthrYR28utLOg6WGYAKy0d/XbPkP
         tNaJ9rzMtyebbYXKwyx31ryl2QqY4HlY4phc8KmJ8AysQW6vaM2qUpgAzAWhD4E1insI
         LHcPNmoMsMCZ6lOl06J+FkPaMe8FPOxbdQeBfh0Dkw9FTXKXaD4NoQwh/CzNVMOX/MXC
         H8HA==
X-Gm-Message-State: AOUpUlHnlvZb3Nl4vD+7leNmRSS37FU0ac4tGSqLDTDcZEr/AvafkDH7
        7gECGaS8Ofka5Xu4Kd2Q/gJarszb
X-Google-Smtp-Source: AA+uWPzH9fVy9D0bUPlSCS9gAvGRZ6nU/kw7fcBEFbLv0Myyk1L+xIAz+i4Y/lQVXiZgrTkoXUvejw==
X-Received: by 2002:a50:b642:: with SMTP id c2-v6mr3357672ede.288.1533736272986;
        Wed, 08 Aug 2018 06:51:12 -0700 (PDT)
Received: from localhost.localdomain ([27.34.16.181])
        by smtp.gmail.com with ESMTPSA id u3-v6sm1619420edo.44.2018.08.08.06.51.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 06:51:12 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, Johannes.Schindelin@gmx.de,
        sbeller@google.com, alban.gruin@gmail.com, gitster@pobox.com,
        Pratik Karki <predatoramigo@gmail.com>
Subject: [PATCH 01/11] builtin rebase: support --onto
Date:   Wed,  8 Aug 2018 19:33:20 +0545
Message-Id: <20180808134830.19949-2-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808134830.19949-1-predatoramigo@gmail.com>
References: <20180808134830.19949-1-predatoramigo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `--onto` option is important, as it allows to rebase a range of
commits onto a different base commit (which gave the command its odd
name: "rebase").

This commit introduces options parsing so that different options can
be added in future commits.

Note: As this commit introduces to the parse_options() call (which
"eats" argv[0]), the argc is now expected to be lower by one after this
patch, compared to before this patch: argv[0] no longer refers to the
command name, but to the first (non-option) command-line parameter.

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
---
 builtin/rebase.c | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index e695d8a430..742ed31498 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -16,6 +16,16 @@
 #include "cache-tree.h"
 #include "unpack-trees.h"
 #include "lockfile.h"
+#include "parse-options.h"
+
+static char const * const builtin_rebase_usage[] = {
+	N_("git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] "
+		"[<upstream>] [<branch>]"),
+	N_("git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] "
+		"--root [<branch>]"),
+	N_("git rebase --continue | --abort | --skip | --edit-todo"),
+	NULL
+};
 
 static GIT_PATH_FUNC(apply_dir, "rebase-apply")
 static GIT_PATH_FUNC(merge_dir, "rebase-merge")
@@ -301,6 +311,12 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	int ret, flags;
 	struct strbuf msg = STRBUF_INIT;
 	struct strbuf revisions = STRBUF_INIT;
+	struct option builtin_rebase_options[] = {
+		OPT_STRING(0, "onto", &options.onto_name,
+			   N_("revision"),
+			   N_("rebase onto given branch instead of upstream")),
+		OPT_END(),
+	};
 
 	/*
 	 * NEEDSWORK: Once the builtin rebase has been tested enough
@@ -318,13 +334,22 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			BUG("sane_execvp() returned???");
 	}
 
-	if (argc != 2)
-		die(_("Usage: %s <base>"), argv[0]);
+	if (argc == 2 && !strcmp(argv[1], "-h"))
+		usage_with_options(builtin_rebase_usage,
+				   builtin_rebase_options);
+
 	prefix = setup_git_directory();
 	trace_repo_setup(prefix);
 	setup_work_tree();
 
 	git_config(git_default_config, NULL);
+	argc = parse_options(argc, argv, prefix,
+			     builtin_rebase_options,
+			     builtin_rebase_usage, 0);
+
+	if (argc > 2)
+		usage_with_options(builtin_rebase_usage,
+				   builtin_rebase_options);
 
 	switch (options.type) {
 	case REBASE_MERGE:
@@ -343,10 +368,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	}
 
 	if (!options.root) {
-		if (argc < 2)
+		if (argc < 1)
 			die("TODO: handle @{upstream}");
 		else {
-			options.upstream_name = argv[1];
+			options.upstream_name = argv[0];
 			argc--;
 			argv++;
 			if (!strcmp(options.upstream_name, "-"))
@@ -377,7 +402,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	 * orig_head -- commit object name of tip of the branch before rebasing
 	 * head_name -- refs/heads/<that-branch> or "detached HEAD"
 	 */
-	if (argc > 1)
+	if (argc > 0)
 		 die("TODO: handle switch_to");
 	else {
 		/* Do not need to switch branches, we are already on it. */
-- 
2.18.0

