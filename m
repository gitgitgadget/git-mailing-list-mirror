Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0862DC433F5
	for <git@archiver.kernel.org>; Sat, 29 Jan 2022 18:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352996AbiA2SH1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Jan 2022 13:07:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353001AbiA2SHT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jan 2022 13:07:19 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1350EC061714
        for <git@vger.kernel.org>; Sat, 29 Jan 2022 10:07:19 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id u15so17184906wrt.3
        for <git@vger.kernel.org>; Sat, 29 Jan 2022 10:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6oNLvE3Kf1AT5/coVfsEXJRsaPG9jKHHjbI8tr++geM=;
        b=lM6S5DkIYj/vABzYdlzp783hbErd2QQ7iHJ1hOulZAs+dAAYgXpReX6YuO9FDkoEfB
         l9ATUHl7BRjx1YXYYhu8gXwz8XYVwX4BrSWSPIdm1ThuInjcmnG6q3eEzMaGKzUtQuFk
         U50cIu92040pkV1dyn6BCuBTko9jaih/n69Tbixgi3jQrQKHUSUoH0OuazyWXs+a8RMM
         Noxp2y5CYcq7YvQdbeghULaesM93BCIi08yyhHoQPdF3RNMecKMCudNtchKs50eJ1AyM
         g1SXdZVvuIG38RoVHPulrxqSHJOnXUoPT1A4GqIqSwai1uUrrqfN5OeFbYwIF6hq6dr5
         qcow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6oNLvE3Kf1AT5/coVfsEXJRsaPG9jKHHjbI8tr++geM=;
        b=M8Wql7mtQ+rnquFDJApVc25NcinpibQLe3Xlk91jL3gtVOYgPtEnmKdzNIVkBvuFrv
         3lPxPoZUyZZjDcpxFkeu6V6wp9hKnL3i+2lGXr3HeGem+byt18fFGWGWkk+mUd/Y8X57
         jfe3cgMFVrzgXcoCZEjMqn6T8f61QPApZwozV14QpG0SEfGIdPMiDuabDUppUoCCwASj
         GZbSCi8vsiDqAoN69jfIW4sZSMJuZJH0HwGjO4idHKBepcMPqR4jCUhI8jTVAYLdpduW
         qDdzXKPWQuVf9bYzXEl3AK4RRGGk6uKFs+1f5HNkBT6LgZY7Cp2dxaleIaq37vfiHSgW
         XtBQ==
X-Gm-Message-State: AOAM530BEelkd1vSUGSvMzSfjmrDd6PpU2uJtfryVG+SWrdbVy4YWLkq
        4oCZ96nHKJ3MUdu4fklhO2fewBhpmWY=
X-Google-Smtp-Source: ABdhPJx5QLDQh+ei6d41SK0LZteLvZzOy1aKJM0sPK1ARVkruD8QvGANCpbKrXsGSkfSpy/s0dMNTQ==
X-Received: by 2002:a05:6000:186a:: with SMTP id d10mr10971228wri.621.1643479637521;
        Sat, 29 Jan 2022 10:07:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y15sm11242193wry.36.2022.01.29.10.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 10:07:17 -0800 (PST)
Message-Id: <63f42df21aec5bda50e4414493eb59dcb64e5558.1643479633.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
        <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 29 Jan 2022 18:07:03 +0000
Subject: [PATCH v2 03/13] merge-tree: add option parsing and initial shell for
 real merge function
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Let merge-tree accept a `--write-tree` parameter for choosing real
merges instead of trivial merges, and accept an optional
`--trivial-merge` option to get the traditional behavior.  Note that
these accept different numbers of arguments, though, so these names
need not actually be used.

Note that real merges differ from trivial merges in that they handle:
  - three way content merges
  - recursive ancestor consolidation
  - renames
  - proper directory/file conflict handling
  - etc.
Basically all the stuff you'd expect from `git merge`, just without
updating the index and working tree.  The initial shell added here does
nothing more than die with "real merges are not yet implemented", but
that will be fixed in subsequent commits.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/merge-tree.c | 61 +++++++++++++++++++++++++++++++++++++-------
 git.c                |  2 +-
 2 files changed, 53 insertions(+), 10 deletions(-)

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 914ec960b7e..e98ec8a9f1d 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -3,13 +3,12 @@
 #include "tree-walk.h"
 #include "xdiff-interface.h"
 #include "object-store.h"
+#include "parse-options.h"
 #include "repository.h"
 #include "blob.h"
 #include "exec-cmd.h"
 #include "merge-blobs.h"
 
-static const char merge_tree_usage[] = "git merge-tree <base-tree> <branch1> <branch2>";
-
 struct merge_list {
 	struct merge_list *next;
 	struct merge_list *link;	/* other stages for this object */
@@ -366,15 +365,17 @@ static void *get_tree_descriptor(struct repository *r,
 	return buf;
 }
 
-static int trivial_merge(int argc, const char **argv)
+static int trivial_merge(const char *base,
+			 const char *branch1,
+			 const char *branch2)
 {
 	struct repository *r = the_repository;
 	struct tree_desc t[3];
 	void *buf1, *buf2, *buf3;
 
-	buf1 = get_tree_descriptor(r, t+0, argv[1]);
-	buf2 = get_tree_descriptor(r, t+1, argv[2]);
-	buf3 = get_tree_descriptor(r, t+2, argv[3]);
+	buf1 = get_tree_descriptor(r, t+0, base);
+	buf2 = get_tree_descriptor(r, t+1, branch1);
+	buf3 = get_tree_descriptor(r, t+2, branch2);
 	trivial_merge_trees(t, "");
 	free(buf1);
 	free(buf2);
@@ -384,9 +385,51 @@ static int trivial_merge(int argc, const char **argv)
 	return 0;
 }
 
+struct merge_tree_options {
+	int mode;
+};
+
+static int real_merge(struct merge_tree_options *o,
+		      const char *branch1, const char *branch2)
+{
+	die(_("real merges are not yet implemented"));
+}
+
 int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 {
-	if (argc != 4)
-		usage(merge_tree_usage);
-	return trivial_merge(argc, argv);
+	struct merge_tree_options o = { 0 };
+	int expected_remaining_argc;
+
+	const char * const merge_tree_usage[] = {
+		N_("git merge-tree [--write-tree] <branch1> <branch2>"),
+		N_("git merge-tree [--trivial-merge] <base-tree> <branch1> <branch2>"),
+		NULL
+	};
+	struct option mt_options[] = {
+		OPT_CMDMODE(0, "write-tree", &o.mode,
+			    N_("do a real merge instead of a trivial merge"),
+			    'w'),
+		OPT_CMDMODE(0, "trivial-merge", &o.mode,
+			    N_("do a trivial merge only"), 't'),
+		OPT_END()
+	};
+
+	/* Parse arguments */
+	argc = parse_options(argc, argv, prefix, mt_options,
+			     merge_tree_usage, PARSE_OPT_STOP_AT_NON_OPTION);
+	if (o.mode) {
+		expected_remaining_argc = (o.mode == 'w' ? 2 : 3);
+		if (argc != expected_remaining_argc)
+			usage_with_options(merge_tree_usage, mt_options);
+	} else {
+		if (argc < 2 || argc > 3)
+			usage_with_options(merge_tree_usage, mt_options);
+		o.mode = (argc == 2 ? 'w' : 't');
+	}
+
+	/* Do the relevant type of merge */
+	if (o.mode == 'w')
+		return real_merge(&o, argv[0], argv[1]);
+	else
+		return trivial_merge(argv[0], argv[1], argv[2]);
 }
diff --git a/git.c b/git.c
index 5ff21be21f3..6090a1289db 100644
--- a/git.c
+++ b/git.c
@@ -558,7 +558,7 @@ static struct cmd_struct commands[] = {
 	{ "merge-recursive-ours", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
 	{ "merge-recursive-theirs", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
 	{ "merge-subtree", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
-	{ "merge-tree", cmd_merge_tree, RUN_SETUP | NO_PARSEOPT },
+	{ "merge-tree", cmd_merge_tree, RUN_SETUP },
 	{ "mktag", cmd_mktag, RUN_SETUP | NO_PARSEOPT },
 	{ "mktree", cmd_mktree, RUN_SETUP },
 	{ "multi-pack-index", cmd_multi_pack_index, RUN_SETUP },
-- 
gitgitgadget

