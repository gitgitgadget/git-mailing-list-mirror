Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1EA3C76196
	for <git@archiver.kernel.org>; Fri,  7 Apr 2023 07:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237539AbjDGHZI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Apr 2023 03:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239571AbjDGHZG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2023 03:25:06 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39D5E56
        for <git@vger.kernel.org>; Fri,  7 Apr 2023 00:24:54 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id j11so1933913wrd.2
        for <git@vger.kernel.org>; Fri, 07 Apr 2023 00:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680852283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z46jcp9KTGA6+ezDSwyafz68Ve6a+SRUErWWbqC9IqE=;
        b=hAQgJppOHmjmnga1IT/61bTd5lCeWt5ppcZ6P5+Y/SrfvxELShGbUO5az34yDW+Kp/
         QuhlLxOjWNFUt4/EW/0SEQKzr1FR6uuyIZIFUgthN9eBEWyl5eFfJT4YqiFjiUD7R5Qh
         sgq+JvB80gNkAHSDDWMhEiiHBFbmo73P2KkyfhQdZHUSgGE6OOPKEQCdOAVj1+d0vRv0
         pfpQUnF6gpspho+k0qz3UrTXARh4EPLnDsdR5SDqc4PBYp9JJTqZYBwc27OjjcwEFgGg
         rdln7VKlNegUUkc4Jxf5Wvjp2g0sXwFycPTCeoc2cwlx6CIs9HelBuUIaujzFyk83s5F
         4WnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680852283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z46jcp9KTGA6+ezDSwyafz68Ve6a+SRUErWWbqC9IqE=;
        b=8IiKOwX103XOYl0dEM3dieuFXRznF4Sm9T1iZ7PJD1huh3uFHjlCym8bkIzpx0xzrq
         QST5X6PqruTL8oTTRBOkZ3MuPzSKaAJkU1Dg9mM8bU3Uf9WYugAliqTrD19XczHxMZfc
         U0JFqv6WbS5XvKBwrREm2Cr/b6U3Jgsm6vhB146CzXjSFrooGHwU8QpeVlMU1ADq8QIb
         jrBzLmsdLx3ke4eNyoc5tZynx9j8x4SAsfoX8voJE6FR5K2NoPXD0e3SJhS7ukDkvgqq
         2RZUJ07243lfT4xhnpyLNxZUgKUTf01nScBNK7s1GkhmsWndUbjGrL0OswTwxO4AI6r3
         y+7g==
X-Gm-Message-State: AAQBX9eylXcZHG4T3MpDpI8yfct589N4bhqrz2w35Q4r6CuyY+kLVNjM
        8v8mDjUHWiOdDqEmjH0kNI1cQbPPgz2cQg==
X-Google-Smtp-Source: AKy350brHbHO80E1++FckWM+C4ynFd8FWcgIeyJ16LiOeV4LlrfYMY9HyJMBltFnB3kk9CeWUHMbzw==
X-Received: by 2002:a5d:526b:0:b0:2ce:a835:83d4 with SMTP id l11-20020a5d526b000000b002cea83583d4mr641439wrc.27.1680852283434;
        Fri, 07 Apr 2023 00:24:43 -0700 (PDT)
Received: from christian-Precision-5550.lan ([2001:861:3f04:7ca0:90e:3fb7:fec2:981])
        by smtp.gmail.com with ESMTPSA id f7-20020a5d6647000000b002da1261aa44sm3782761wrw.48.2023.04.07.00.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 00:24:43 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 02/14] replay: start using parse_options API
Date:   Fri,  7 Apr 2023 09:24:03 +0200
Message-Id: <20230407072415.1360068-3-christian.couder@gmail.com>
X-Mailer: git-send-email 2.40.0.228.gb2eb5bb98e
In-Reply-To: <20230407072415.1360068-1-christian.couder@gmail.com>
References: <20230407072415.1360068-1-christian.couder@gmail.com>
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
index 154a976ca6..ca931dee41 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -11,6 +11,7 @@
 #include "hex.h"
 #include "lockfile.h"
 #include "merge-ort.h"
+#include "parse-options.h"
 #include "refs.h"
 #include "revision.h"
 #include "sequencer.h"
@@ -82,6 +83,7 @@ static struct commit *create_commit(struct tree *tree,
 int cmd_replay(int argc, const char **argv, const char *prefix)
 {
 	struct commit *onto;
+	const char *onto_name = NULL;
 	struct commit *last_commit = NULL, *last_picked_commit = NULL;
 	struct object_id head;
 	struct lock_file lock = LOCK_INIT;
@@ -95,16 +97,32 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
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
 	if (get_oid("HEAD", &head))
@@ -116,6 +134,7 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 		BUG("Could not read index");
 
 	repo_init_revisions(the_repository, &revs, prefix);
+
 	revs.verbose_header = 1;
 	revs.max_parents = 1;
 	revs.cherry_mark = 1;
@@ -124,7 +143,8 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	revs.right_only = 1;
 	revs.sort_order = REV_SORT_IN_GRAPH_ORDER;
 	revs.topo_order = 1;
-	strvec_pushl(&rev_walk_args, "", argv[4], "--not", argv[3], NULL);
+
+	strvec_pushl(&rev_walk_args, "", argv[2], "--not", argv[1], NULL);
 
 	if (setup_revisions(rev_walk_args.nr, rev_walk_args.v, &revs, NULL) > 1) {
 		ret = error(_("unhandled options"));
@@ -187,8 +207,8 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
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
@@ -203,8 +223,8 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 			       &last_commit->object.oid,
 			       &head,
 			       REF_NO_DEREF, UPDATE_REFS_MSG_ON_ERR)) {
-			error(_("could not update %s"), argv[4]);
-			die("Failed to update %s", argv[4]);
+			error(_("could not update %s"), argv[2]);
+			die("Failed to update %s", argv[2]);
 		}
 	}
 	if (write_locked_index(&the_index, &lock,
-- 
2.40.0.228.gb2eb5bb98e

