Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FA0EC874C
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 17:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242888AbjIGRSs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 13:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242882AbjIGRSo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 13:18:44 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7A91FE5
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 10:18:21 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-31dca134c83so1129039f8f.3
        for <git@vger.kernel.org>; Thu, 07 Sep 2023 10:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694107038; x=1694711838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WE8CWPu3mKNRmlD8NSJkLx+RsB8YQ1QcZnq8i2OeuH4=;
        b=Yc5Hl/VOUvzUZ5kJ5DTHmE2TpHEOoFgtqvcRgUv4wan3duxo23aCHJUu8yRIbFA3nr
         S+fbcemxkOAYgCXIUAnT8wquI/s8AP1xaK7dmZWhnhaGjL4QNYVDLffzws3eguml8gJv
         i5axtVDM6b0wV2nhonMFv1PKPrccqZ8Dcb2fdewXOvB5Glbr+iBAelJ2cGPnUtJJJOzu
         cJN0XHT0A/1ZHnnVp5yug1Mb0tsqO3rHMBj4hpoYeyKy7ZDSB4779nb3rI40iqxb/hUe
         wc4Wv7HGhtWfd5AHT/YPjEPevE60Bm5VAA4Qg3xHwCvBVQr77s4zQd96GjX2QJrSwSkP
         zeZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694107038; x=1694711838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WE8CWPu3mKNRmlD8NSJkLx+RsB8YQ1QcZnq8i2OeuH4=;
        b=T/cMmMUF6Er0qC/NLxDkfZdsckugpku2WwZzGTo6jtwB+Xjkk/T5lRDuOFFVD7H31B
         zV7F/iWvIyuqmBWHLFU7NoboYfEA/yePATAFKf3em7MAYAeI8AeNVCV1pnjonN8FP3bV
         hEhBwNH4/v7I1iz/LK6EJJk2BoOx+3bFNMbTPtdB0WpNr9xouV9CDinRlST3U8Z5XuSl
         /61LG7kgrQ91d/XLQ+06bAcAT3H4ehV0HQfg6yIBI8xBaaljcs7DYeBrI2YQfs9yOYDX
         0RbWxnv2Q2M/PvYwG2kK9yfUbrttySllPjUWAFGPQVJAX12tQuaEpTn8MkyNEYVgkt61
         xcwA==
X-Gm-Message-State: AOJu0YznpuRh26CweSUL14OJhCmpvCwedsXMtD8V0eFC+SJVCuyKEpED
        rcFXXxLJR650V4oAkDUYUWX4Rcskk0c=
X-Google-Smtp-Source: AGHT+IHCOX7l6MDdZNG8UWHPd5vMcXj5u4xbA01f3gnCO2AqWQf4yEK0z9tSAlfd3T3K8OxIIErcYw==
X-Received: by 2002:a2e:870d:0:b0:2bc:b9c7:7ba8 with SMTP id m13-20020a2e870d000000b002bcb9c77ba8mr4241648lji.43.1694078800122;
        Thu, 07 Sep 2023 02:26:40 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:3385:ce2d:69dd:303e])
        by smtp.gmail.com with ESMTPSA id y8-20020adff148000000b00317c742ca9asm22491522wro.43.2023.09.07.02.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 02:26:39 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Toon Claes <toon@iotcl.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 03/15] replay: start using parse_options API
Date:   Thu,  7 Sep 2023 11:25:09 +0200
Message-ID: <20230907092521.733746-4-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.126.gcf8c984877
In-Reply-To: <20230907092521.733746-1-christian.couder@gmail.com>
References: <20230602102533.876905-1-christian.couder@gmail.com>
 <20230907092521.733746-1-christian.couder@gmail.com>
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
2.42.0.126.gcf8c984877

