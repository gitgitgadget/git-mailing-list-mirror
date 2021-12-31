Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05A7C433FE
	for <git@archiver.kernel.org>; Fri, 31 Dec 2021 05:04:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbhLaFEO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Dec 2021 00:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbhLaFEJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Dec 2021 00:04:09 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D96C061574
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 21:04:09 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id a83-20020a1c9856000000b00344731e044bso14281025wme.1
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 21:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JONNambO6fwKGsod0dvRt6++LL+evrQZHssMu5CN+V8=;
        b=ejvU5BN8dzZjxDBVGrzoV6eShvX7+X61sI9HNSFObIXmHY3IPl3lJ7EWDmJAMf0gvy
         +YIWJkiPUi/Uq1Xm/4zwMXvffCgHL0lYTNvE1iM+x1/iqvydQBhgi7B4P3x31g4zJeW8
         J+/qypZZcriBlsqVbpZ/+ZgPQk0y3MoiOGGiMdWHFNAVXxl5bnd8Z52rGWr0QBg5MY3v
         nwzoC5P1a9EDyl4b/DtCbEN8r1nr8iKMOBdxe5idUd2h0a0F7LMnzdBNrRx+uTluBgxx
         /w7TgUgibxjAD+qeX3KzV1Q58kdfXDcfDqSGCzRq9QbvUvIK5pr87WAjtA2vv7Zk7rIX
         6FxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JONNambO6fwKGsod0dvRt6++LL+evrQZHssMu5CN+V8=;
        b=UOj3q/++wEGuJcntVulOOpuBAGwWkpN6zkiRmQg7ZoZ15FV84L8Yj2OFdwQK6sA5ta
         IO0un1emLP+D7Rz35yX5tKO36aEhsQaM3KtmDk2KgHT7m5HDJITOvubi7nmTmPQYs9Dd
         vd5BqLy+aOrSyCNl26q6w5v92ywqPgeJXZzz/KMv2lBMSPnc5LJpWDwX8nbH1rYp+c5a
         GXWzCfyjFblfoOETgH2CYLZ5USC71mWVXFfzBl2GliniKqgNC8fWVv+R2nSEQuIcRczB
         G5eGDgi/pUJ3M8qTiXUMXlPhVO0c/JZ+PMajdHvatpdpOkkitpexahGwh+xUTnfvlHON
         l6VQ==
X-Gm-Message-State: AOAM533xHRsplIEmEQNataHa1qQE2m7GoUApDAPqo/5ylzpUfG3pshIX
        5d9zAKSFX4t1hXCVf5Wr5DQwyDPMN88=
X-Google-Smtp-Source: ABdhPJy4vUEmuBGjqeV8VxJItLtFHUDVpgGpfbI8Ajt92IJHyI5HAC7dVjiQtxGHBUDC4cSs4hAjcA==
X-Received: by 2002:a7b:c087:: with SMTP id r7mr29008109wmh.17.1640927047804;
        Thu, 30 Dec 2021 21:04:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f6sm26340012wri.115.2021.12.30.21.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 21:04:07 -0800 (PST)
Message-Id: <9d03d3f56ab9ab01281b63cc2ecff195ab8089ae.1640927044.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1114.git.git.1640927044.gitgitgadget@gmail.com>
References: <pull.1114.git.git.1640927044.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 31 Dec 2021 05:03:59 +0000
Subject: [PATCH 3/8] merge-tree: add option parsing and initial shell for real
 merge function
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Let merge-tree accept a `--real` parameter for choosing real merges
instead of trivial merges.  Note that real merges differ from trivial
merges in that they handle:
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
 builtin/merge-tree.c | 56 +++++++++++++++++++++++++++++++++++++-------
 git.c                |  2 +-
 2 files changed, 48 insertions(+), 10 deletions(-)

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 9fe5b99f623..f04b1eaad0a 100644
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
@@ -366,14 +365,16 @@ static void *get_tree_descriptor(struct repository *r,
 	return buf;
 }
 
-static int trivial_merge(int argc, const char **argv) {
+static int trivial_merge(const char *base,
+			 const char *branch1,
+			 const char *branch2) {
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
@@ -383,9 +384,46 @@ static int trivial_merge(int argc, const char **argv) {
 	return 0;
 }
 
+struct merge_tree_options {
+	int real;
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
+		N_("git merge-tree --real <branch1> <branch2>"),
+		N_("git merge-tree <base-tree> <branch1> <branch2>"),
+		NULL
+	};
+	struct option mt_options[] = {
+		OPT_BOOL(0, "real", &o.real,
+			 N_("do a real merge instead of a trivial merge")),
+		OPT_END()
+	};
+
+	/* Check for a request for basic help */
+	if (argc == 2 && !strcmp(argv[1], "-h"))
+		usage_with_options(merge_tree_usage, mt_options);
+
+	/* Parse arguments */
+	argc = parse_options(argc, argv, prefix, mt_options,
+			     merge_tree_usage, 0);
+	expected_remaining_argc = (o.real ? 2 : 3);
+	if (argc != expected_remaining_argc)
+		usage_with_options(merge_tree_usage, mt_options);
+
+	/* Do the relevant type of merge */
+	if (o.real)
+		return real_merge(&o, argv[0], argv[1]);
+	else
+		return trivial_merge(argv[0], argv[1], argv[2]);
 }
diff --git a/git.c b/git.c
index 7edafd8ecff..0124c053878 100644
--- a/git.c
+++ b/git.c
@@ -561,7 +561,7 @@ static struct cmd_struct commands[] = {
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

