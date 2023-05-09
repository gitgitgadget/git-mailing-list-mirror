Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85273C77B7C
	for <git@archiver.kernel.org>; Tue,  9 May 2023 17:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbjEIRy0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 13:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbjEIRyS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 13:54:18 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F8440E4
        for <git@vger.kernel.org>; Tue,  9 May 2023 10:54:16 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-2fe3fb8e25fso4104966f8f.0
        for <git@vger.kernel.org>; Tue, 09 May 2023 10:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683654854; x=1686246854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lAPrRWcxf0q/35zUwcOwD7im8RTwYTAsdeTqnoyyWF4=;
        b=Gd93xxHkEZ74WFC3QKXFixJ8CV2+eIaZbnuwoACMNaD0A8XKdrn9GVbWB/F0sQVByP
         kCN4fqoMxf4RDWmDfmPe78L+ZGlHNK+1mrotQ/sOG2FpxhUhM/CVR67P2QEVaAC7O3ws
         rg9PKNITpFqQZ8l3PoPPEenKgoXtXdFOzSQo5p+XSP9hmZsEDGKiiYxV0gjeJoxlh1PI
         DcaNiOOm2WJNVzosM1QxrWiCDvObDsxehXzAlu1lNAs/879JFP8XB3W39Z0/f1q82chz
         XqMjJ3Yr8c8OTOCo9+63GLO7kozsKrFcxJvsHlKN22i0ugO+O+cI4raKWmKlKsX01RsE
         PsKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683654854; x=1686246854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lAPrRWcxf0q/35zUwcOwD7im8RTwYTAsdeTqnoyyWF4=;
        b=IOOt2z/mEX3cZAUi2zwWwduaeiyo6ac1ESQsS0qkNMZoSkdJap65UHj4vj3fBJqxzq
         ee4yXD5pMo7ptTi7+oclxumpqLk3hnBdNcCZFbHjMwt/bNb63ehOzGu2PUcC+TrvRsSs
         ejnXj3JMnX4xwBW20wjq6nAP+yxVpixnIlFVZdXxSttq2hNz3E9/e04Nv082mf6II5Bq
         U6Z4bP3/duwCI7db1zSwbkM9d8pMgZV3NLK5elgjkVvdYGfIMhkKvO15dtr0R8l64GXp
         oCVYrqSEIQ0cJJ5tYeGkiSPIvOxNiRZaSHPeua1j+EzoegXa9BZlZshWTdkJBooFcNWS
         5ASA==
X-Gm-Message-State: AC+VfDzyq4uQ5f0VnYn2h+vtWqS70YpJT/8ivx8MB8EayW5khFyIAN3Z
        tQzpxGzFVRaehSgn1o8GAFZ9xifcZTs=
X-Google-Smtp-Source: ACHHUZ78lmsPYhQAnpbOL/o+S53Li2ZSc5v03tMyjX43zcQfh2DfqFcHxr6x0eLkn2hOeQcc2yow/g==
X-Received: by 2002:a5d:434c:0:b0:2fe:80b7:3527 with SMTP id u12-20020a5d434c000000b002fe80b73527mr8942541wrr.17.1683654854415;
        Tue, 09 May 2023 10:54:14 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:df87:46e2:83de:c1fa])
        by smtp.gmail.com with ESMTPSA id c3-20020a7bc843000000b003f42314832fsm8584435wml.18.2023.05.09.10.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 10:54:13 -0700 (PDT)
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
Subject: [PATCH v2 03/15] replay: start using parse_options API
Date:   Tue,  9 May 2023 19:53:35 +0200
Message-ID: <20230509175347.1714141-4-christian.couder@gmail.com>
X-Mailer: git-send-email 2.40.1.491.gbdd8a3b3e1
In-Reply-To: <20230509175347.1714141-1-christian.couder@gmail.com>
References: <20230407072415.1360068-1-christian.couder@gmail.com>
 <20230509175347.1714141-1-christian.couder@gmail.com>
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
index 9637c31da2..4644bee3cf 100644
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
@@ -89,6 +90,7 @@ static struct commit *create_commit(struct tree *tree,
 int cmd_replay(int argc, const char **argv, const char *prefix)
 {
 	struct commit *onto;
+	const char *onto_name = NULL;
 	struct commit *last_commit = NULL, *last_picked_commit = NULL;
 	struct object_id head;
 	struct lock_file lock = LOCK_INIT;
@@ -102,16 +104,32 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
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
@@ -123,6 +141,7 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 		BUG("Could not read index");
 
 	repo_init_revisions(the_repository, &revs, prefix);
+
 	revs.verbose_header = 1;
 	revs.max_parents = 1;
 	revs.cherry_mark = 1;
@@ -131,7 +150,8 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	revs.right_only = 1;
 	revs.sort_order = REV_SORT_IN_GRAPH_ORDER;
 	revs.topo_order = 1;
-	strvec_pushl(&rev_walk_args, "", argv[4], "--not", argv[3], NULL);
+
+	strvec_pushl(&rev_walk_args, "", argv[2], "--not", argv[1], NULL);
 
 	if (setup_revisions(rev_walk_args.nr, rev_walk_args.v, &revs, NULL) > 1) {
 		ret = error(_("unhandled options"));
@@ -194,8 +214,8 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
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
@@ -207,8 +227,8 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
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
2.40.1.491.gdff9a222ea

