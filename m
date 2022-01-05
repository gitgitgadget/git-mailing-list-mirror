Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478BEC433EF
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 17:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242220AbiAER1p (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 12:27:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242204AbiAER1k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 12:27:40 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BD3C0611FD
        for <git@vger.kernel.org>; Wed,  5 Jan 2022 09:27:40 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id r17so84481780wrc.3
        for <git@vger.kernel.org>; Wed, 05 Jan 2022 09:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=V8S8SjfTWGNwbuwmn14qUCAsI9OJQyegvG/CX1wq7fI=;
        b=kB1hYcbjIxJUECAZv/49cByIrysgITvCTzuGXfXEwcudZZlUINgQMmurrAaYI6sHor
         EzKAKkR5AEe7pY18jU2F4yXHQF5QImOXJd8I+BKFt1ZNkbVdzfPgZliy4eKLAFulssoZ
         NgOrmXwuWJMApDAWggx4+umVRaqz+JNfqBiBqyU7r4pr5cGDWQMBCpC+1IspUhGU0grI
         e4U4pvpgUlsO/VRlwsuR221tP42BwAbP/N/M4zEyvyvpjWHZ1fNHITwJ+5q7yGk3xG9R
         QwEwuE3+uqTbNCYBOclGl9xn3oaFke/ekBQY05FkQ1x4ADEZ1jpO/c4GfvCBkh8ADGcs
         iSKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=V8S8SjfTWGNwbuwmn14qUCAsI9OJQyegvG/CX1wq7fI=;
        b=ZWfQwDFWLWg+YSZeD9Ry5h7UJ0f3u2/HcBwemwEu/iMVPBUYAgclZnMZx37faCSKkb
         yalmeC6+RXw4QEyDUdF/XbTk4uZyG58gFp4swSubVJzedwbpVdKrLVD92MZT/gXAcgmP
         WTOLYjqi2iBlE5o3tx52KNm9GpQ/hAaHf0ecrIfgwsHO1DIJ391wFybGILgj89EnMNMB
         tuqadtuw5IllFiorrId1qBveRfHvcBX4Txj6mZf18jtmZvAT5yG8moittphb2Jm1ge/g
         KOWQ5OA8iK34WEI6LslDWsoA2wFqMcN0j6T7KAM7IKrDXfbU9XCx9+fQwNg6aFkQABM2
         Zn7g==
X-Gm-Message-State: AOAM530mEfNRgxqSQ3LdTeVqpfd7j+mFiZFBplnJ1bQ5opo13/NDg4BZ
        p2thFDIlfVauoubqDYcGQkI5GY5sI2s=
X-Google-Smtp-Source: ABdhPJwuBaaVW6SMEkCMfqLKvEvYrSHyAKuZhPZhwDd1nCm0J+dCkYRmfQG/0ePoQug/LWeBwAZdWw==
X-Received: by 2002:a05:6000:d0:: with SMTP id q16mr1546881wrx.600.1641403658696;
        Wed, 05 Jan 2022 09:27:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a24sm1569325wmj.42.2022.01.05.09.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 09:27:38 -0800 (PST)
Message-Id: <ee21aed01153aff39eef2398d32722c3e8cc426d.1641403655.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1114.v2.git.git.1641403655.gitgitgadget@gmail.com>
References: <pull.1114.git.git.1640927044.gitgitgadget@gmail.com>
        <pull.1114.v2.git.git.1641403655.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 05 Jan 2022 17:27:30 +0000
Subject: [PATCH v2 3/8] merge-tree: add option parsing and initial shell for
 real merge function
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Elijah Newren <newren@gmail.com>,
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
index 914ec960b7e..e1d2832c809 100644
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
@@ -384,9 +385,46 @@ static int trivial_merge(int argc, const char **argv)
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

