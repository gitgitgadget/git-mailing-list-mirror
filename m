Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F7CC7EE29
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 10:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235700AbjFBK21 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 06:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235425AbjFBK16 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 06:27:58 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECC5268B
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 03:26:12 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-30ae69ef78aso2459957f8f.1
        for <git@vger.kernel.org>; Fri, 02 Jun 2023 03:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685701555; x=1688293555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QHE5OnrTCyTOspyTEGRV/FXxpuPMNE2g5IzgoBIA704=;
        b=YxmBIl7c0Rptj8CYrQ13ZxGEGpgCRlLhduu8gZRJj3UVTp9oG3TftJ3HTdciTXKPo4
         bJM5F9UIQCj6AjRYrD8yUf1GYMIzo2Javrk1iGWAbFoJ7j4RlqG/0xrFpWx4yDZ/StJh
         ntLdvtZOa2L0OH1Dc/xyLLMAZFTejQIEeMC5I3a/SAXRlsdsMahGmTTw7+z8o2vLixa5
         JVsKefrtD50eb2QQ02DAXv3gV4MMQWPAui8VN7hgrl2AnBEUEqAwK09E1sK+oTA80jJC
         HFfSaZuHveCgvFwg2EeZFM5aWqB0NwR/UfaxNeLEGW/bXz4JdBdqhGoILCOW2d2n+5YY
         n8xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685701555; x=1688293555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QHE5OnrTCyTOspyTEGRV/FXxpuPMNE2g5IzgoBIA704=;
        b=Y27eA5zC6sr99y2wCEtcKLVZ48gILEzOcrgRaQcKhmO8NgXuhBGNHM/VnyQjHMv4TR
         f00XIUVAcrShkEPkjHLW+Y7fC60g2DQVVxvy8qnB+18DBvuVAhSGTg+vunoUB2iCVh7W
         Xz3RQSUvN/UHLEy+YR937oc2ezVqLx0nnFva4+My8Vu58tLkKm+1Kp1rLRPJNJVa9TwN
         nt33bGDqotrdWqfcGckPjNoX5bpIFp9acfyVrLGIM1nKuDu5TVaQPil2rIAg7aeM7ufy
         FOu23MUag6F864K0VDaAN6OkEJyD4ZnRxVhwXmfhFm2BXEncQ8suMq+TWgWBmgLc3o7N
         /bog==
X-Gm-Message-State: AC+VfDzx3HzJD6j3OGgPNK0pNopeV54evE6RD2UcnDFcFdBWbapi3uJa
        hvqh7hmjtYCsj/TPYz1O0/CcaykmfbLReg==
X-Google-Smtp-Source: ACHHUZ6xZLfFY51t5I5loTipSqdJLg51wvQg8kv3uYPubfTmGIrNwcMRMIQeJU3Wr3bilBdtpZ8JUg==
X-Received: by 2002:a5d:53d0:0:b0:30a:e63b:950 with SMTP id a16-20020a5d53d0000000b0030ae63b0950mr3829081wrw.31.1685701554976;
        Fri, 02 Jun 2023 03:25:54 -0700 (PDT)
Received: from christian-Precision-5550.. ([2a04:cec0:1169:70dc:520b:5de9:c23d:7cde])
        by smtp.gmail.com with ESMTPSA id 18-20020a05600c029200b003f601a31ca2sm1468035wmk.33.2023.06.02.03.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 03:25:54 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 03/15] replay: start using parse_options API
Date:   Fri,  2 Jun 2023 12:25:21 +0200
Message-ID: <20230602102533.876905-4-christian.couder@gmail.com>
X-Mailer: git-send-email 2.41.0.15.ga6d88fc8f0
In-Reply-To: <20230602102533.876905-1-christian.couder@gmail.com>
References: <20230509175347.1714141-1-christian.couder@gmail.com>
 <20230602102533.876905-1-christian.couder@gmail.com>
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
 builtin/replay.c | 44 ++++++++++++++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 12 deletions(-)

diff --git a/builtin/replay.c b/builtin/replay.c
index 252af62d12..7eb05048a5 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -14,6 +14,7 @@
 #include "lockfile.h"
 #include "merge-ort.h"
 #include "object-name.h"
+#include "parse-options.h"
 #include "refs.h"
 #include "revision.h"
 #include "sequencer.h"
@@ -90,6 +91,7 @@ static struct commit *create_commit(struct tree *tree,
 int cmd_replay(int argc, const char **argv, const char *prefix)
 {
 	struct commit *onto;
+	const char *onto_name = NULL;
 	struct commit *last_commit = NULL, *last_picked_commit = NULL;
 	struct object_id head;
 	struct lock_file lock = LOCK_INIT;
@@ -103,16 +105,32 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
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
@@ -124,6 +142,7 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 		BUG("Could not read index");
 
 	repo_init_revisions(the_repository, &revs, prefix);
+
 	revs.verbose_header = 1;
 	revs.max_parents = 1;
 	revs.cherry_mark = 1;
@@ -132,7 +151,8 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	revs.right_only = 1;
 	revs.sort_order = REV_SORT_IN_GRAPH_ORDER;
 	revs.topo_order = 1;
-	strvec_pushl(&rev_walk_args, "", argv[4], "--not", argv[3], NULL);
+
+	strvec_pushl(&rev_walk_args, "", argv[2], "--not", argv[1], NULL);
 
 	if (setup_revisions(rev_walk_args.nr, rev_walk_args.v, &revs, NULL) > 1) {
 		ret = error(_("unhandled options"));
@@ -195,8 +215,8 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
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
@@ -208,8 +228,8 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
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
2.41.0.15.ga6d88fc8f0

