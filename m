Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D47CD80C2
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 12:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbjJJMjP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 08:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbjJJMjM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 08:39:12 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F585A9
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 05:39:10 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50308217223so7032496e87.3
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 05:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696941548; x=1697546348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jtfjEzkcsd/s2TXPrVNa45PB+Jl1suIyO2dRL8DMcbM=;
        b=d9jYLd1TZGogmT/xSI1TvzTFIpIRmhKySsdYXC1PLkrnpVhjnrTb9zsnAiRpXv30TO
         ljdTlXzQW/k7oN2Ff/xS2ytXI0q/gy0FSr+N5cL1RUiUAnz/54Iq3lpeChTlbSHQP2Ep
         yDGRea9d0hqBmFeG+89V/d7hWjLwsh0fonDjSUBW0BxC/cfSlypav4cruWBp6X37bWr+
         F9bzqRk+o9WNLOHUWWUqf79hX2scarx0DlHppRluveRlSbYv67/rJo1BRxs/p2l5+s90
         iuNbJahK2SqG5AIICvMJGYvTRiA1XuyVUmMYh3ANYfgyYw7IRfcid6Xt6Kx6oqa/MQmT
         8a8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696941548; x=1697546348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jtfjEzkcsd/s2TXPrVNa45PB+Jl1suIyO2dRL8DMcbM=;
        b=ozUp1meCCnbI52i0jVWF/e8WOsJYS9++iOPqPNCibOE7HuNjWZdK+IbJT2qg+GjLSM
         lHUVKjbDaerNF5XnZnA5fdCq+JvQxHO/ff3qfTFbHWrNcO3J7Q0MRu+oLOp3KQJuJBwI
         OsNF9w8aUABxUxzcFu3/5KzYLDopC8V2FsuY+6K/FuD7qnDoIHtPOtjuX++f5nr1dSF1
         yITE87C3MFCulEWQD1JHQvs1rsikUNiUjFcq/Qgpw7v5dyXLd668jv1kKVOSBiUvJWDO
         gZf5H54M7E4fK8Aen7e4DNfGrk7AstHDIkN7zMlQF8BzL+2HwVCa43YHz0BuzaaSUjJC
         uyQQ==
X-Gm-Message-State: AOJu0Yy6OSIjbcBXYYrmTiJdFiXOvxaQq7viTCegqD1i8pR6DP5n7KHt
        B3wi5OOXv52fkRvbJQU6qYP0szvuGh3V1Q==
X-Google-Smtp-Source: AGHT+IEh0l2tj+BFhuasWDX0IBu7b1BudJyl/W7XvH6HmGLiRP61FxpPQZ0iZ/hyqa0p2GLbCBDmvA==
X-Received: by 2002:a05:6512:3246:b0:505:6fed:33a0 with SMTP id c6-20020a056512324600b005056fed33a0mr13295641lfr.34.1696941546525;
        Tue, 10 Oct 2023 05:39:06 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:516d:299b:cbff:be05])
        by smtp.gmail.com with ESMTPSA id p15-20020a7bcc8f000000b003fee6e170f9sm14071689wma.45.2023.10.10.05.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 05:39:06 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Toon Claes <toon@iotcl.com>,
        Dragan Simic <dsimic@manjaro.org>,
        Linus Arver <linusa@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 03/14] replay: start using parse_options API
Date:   Tue, 10 Oct 2023 14:38:36 +0200
Message-ID: <20231010123847.2777056-4-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.339.g663cbc8ab1
In-Reply-To: <20231010123847.2777056-1-christian.couder@gmail.com>
References: <20230907092521.733746-1-christian.couder@gmail.com>
 <20231010123847.2777056-1-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Instead of manually parsing arguments, let's start using the parse_options
API. This way this new builtin will look more standard, and in some
upcoming commits will more easily be able to handle more command line
options.

Note that we plan to later use standard revision ranges instead of
hardcoded "<oldbase> <branch>" arguments. When we will use standard
revision ranges, it will be easier to check if there are no spurious
arguments if we keep ARGV[0], so let's call parse_options() with
PARSE_OPT_KEEP_ARGV0 even if we don't need ARGV[0] right now to avoid
some useless code churn.

Co-authored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/replay.c | 45 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 32 insertions(+), 13 deletions(-)

diff --git a/builtin/replay.c b/builtin/replay.c
index e102749ab6..d6dec7c866 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -15,7 +15,7 @@
 #include "lockfile.h"
 #include "merge-ort.h"
 #include "object-name.h"
-#include "read-cache-ll.h"
+#include "parse-options.h"
 #include "refs.h"
 #include "revision.h"
 #include "sequencer.h"
@@ -92,6 +92,7 @@ static struct commit *create_commit(struct tree *tree,
 int cmd_replay(int argc, const char **argv, const char *prefix)
 {
 	struct commit *onto;
+	const char *onto_name = NULL;
 	struct commit *last_commit = NULL, *last_picked_commit = NULL;
 	struct object_id head;
 	struct lock_file lock = LOCK_INIT;
@@ -105,16 +106,32 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	struct strbuf branch_name = STRBUF_INIT;
 	int ret = 0;
 
-	if (argc == 2 && !strcmp(argv[1], "-h")) {
-		printf("Sorry, I am not a psychiatrist; I can not give you the help you need.  Oh, you meant usage...\n");
-		exit(129);
+	const char * const replay_usage[] = {
+		N_("git replay --onto <newbase> <oldbase> <branch>"),
+		NULL
+	};
+	struct option replay_options[] = {
+		OPT_STRING(0, "onto", &onto_name,
+			   N_("revision"),
+			   N_("replay onto given commit")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, replay_options, replay_usage,
+			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN_OPT);
+
+	if (!onto_name) {
+		error(_("option --onto is mandatory"));
+		usage_with_options(replay_usage, replay_options);
 	}
 
-	if (argc != 5 || strcmp(argv[1], "--onto"))
-		die("usage: read the code, figure out how to use it, then do so");
+	if (argc != 3) {
+		error(_("bad number of arguments"));
+		usage_with_options(replay_usage, replay_options);
+	}
 
-	onto = peel_committish(argv[2]);
-	strbuf_addf(&branch_name, "refs/heads/%s", argv[4]);
+	onto = peel_committish(onto_name);
+	strbuf_addf(&branch_name, "refs/heads/%s", argv[2]);
 
 	/* Sanity check */
 	if (repo_get_oid(the_repository, "HEAD", &head))
@@ -126,6 +143,7 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 		BUG("Could not read index");
 
 	repo_init_revisions(the_repository, &revs, prefix);
+
 	revs.verbose_header = 1;
 	revs.max_parents = 1;
 	revs.cherry_mark = 1;
@@ -134,7 +152,8 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	revs.right_only = 1;
 	revs.sort_order = REV_SORT_IN_GRAPH_ORDER;
 	revs.topo_order = 1;
-	strvec_pushl(&rev_walk_args, "", argv[4], "--not", argv[3], NULL);
+
+	strvec_pushl(&rev_walk_args, "", argv[2], "--not", argv[1], NULL);
 
 	if (setup_revisions(rev_walk_args.nr, rev_walk_args.v, &revs, NULL) > 1) {
 		ret = error(_("unhandled options"));
@@ -197,8 +216,8 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 			       &last_commit->object.oid,
 			       &last_picked_commit->object.oid,
 			       REF_NO_DEREF, UPDATE_REFS_MSG_ON_ERR)) {
-			error(_("could not update %s"), argv[4]);
-			die("Failed to update %s", argv[4]);
+			error(_("could not update %s"), argv[2]);
+			die("Failed to update %s", argv[2]);
 		}
 		if (create_symref("HEAD", branch_name.buf, reflog_msg.buf) < 0)
 			die(_("unable to update HEAD"));
@@ -210,8 +229,8 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 			       &last_commit->object.oid,
 			       &head,
 			       REF_NO_DEREF, UPDATE_REFS_MSG_ON_ERR)) {
-			error(_("could not update %s"), argv[4]);
-			die("Failed to update %s", argv[4]);
+			error(_("could not update %s"), argv[2]);
+			die("Failed to update %s", argv[2]);
 		}
 	}
 	ret = (result.clean == 0);
-- 
2.42.0.339.g663cbc8ab1

