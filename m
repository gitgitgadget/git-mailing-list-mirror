Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FAF1C4361B
	for <git@archiver.kernel.org>; Sun, 13 Dec 2020 08:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18C0622D72
	for <git@archiver.kernel.org>; Sun, 13 Dec 2020 08:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403970AbgLMIHb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Dec 2020 03:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393956AbgLMIGI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Dec 2020 03:06:08 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BABD6C0611CC
        for <git@vger.kernel.org>; Sun, 13 Dec 2020 00:04:45 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id 91so13250259wrj.7
        for <git@vger.kernel.org>; Sun, 13 Dec 2020 00:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oqhHjw6EdnqKcciqU2lQHITMJpUz2e2Y8szWZFVr6pQ=;
        b=QQ7H/6l4+i5IVkpdm9fPYmjyKMydxZ19BiHJ55hZojoNsEQy4dFK34v2XxKP/rKvjZ
         VaSqB7QYnKQwJXJiodZ09ZglMuftaYZmpnaO8Ud7kHvXIl9m7vP4k94sZa+2DkiBvNoW
         y+EpNDsNeiPXCS8KwVFyEseRJ8kjiAl0mvwIO4b/6pRGBguDWzBJShFwpgzpgz4u7xls
         IqKasWxrj1SHOHI6vewAmG0+5eST5HGvNHPdDfnzjSjd/TP0ANww5DKQqq6rmu25ieEW
         wxydT1DJ9w6CiDGWKgk7WG1ToyaNTeLQPFbn3Q3mPiOk9y6e71oDgISOjWXcs2K86Vk5
         McHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oqhHjw6EdnqKcciqU2lQHITMJpUz2e2Y8szWZFVr6pQ=;
        b=TL6tEzqhwrQKPf7i3ht6UzHaWak1g7dTv1T4NQjhk6ydpNzocwNIui5n7yNkFIpP1E
         U3rwAKFQTEFxVSJhAghSMuh8rlOpprGuD10cMQztstL+9HE13bCKOe8QzGf3c1Z9IQCm
         5a/lMEQO/N2lbj5yX6SzvMsfxb7UBj2iH7R8B+1TAp3qjw6MQV3rRWdqQpO/XzFqSjzJ
         cG7waUH87OalmkP8YrUqSMFrVq6GrPGe9uOmOyXCGjpAdZBUWneFsrMiNxtDceQ9CT1S
         Bxx8xubR5ZUlMkNE1KfsQzL2heCL6gigyBN/rzyFXJxsBeR9071XEVgr9c5Wj+32fMkD
         dQTQ==
X-Gm-Message-State: AOAM530yOEh6GdCLzP1rNkSK692jhRRY5dffxYrEukgKuU6+M55Q2Jo0
        feJDeKhhUiwZB03bkNJhsgSSgj2rcLE=
X-Google-Smtp-Source: ABdhPJw/mQGLEdCA4IOUScg4J8++9o05AAQ2YJ4OhOFrCwHEv/Fii2v/fMS9LIeYbo8YHJ1/ZLpETQ==
X-Received: by 2002:a5d:6909:: with SMTP id t9mr15791721wru.327.1607846684298;
        Sun, 13 Dec 2020 00:04:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s12sm2113767wmh.29.2020.12.13.00.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Dec 2020 00:04:43 -0800 (PST)
Message-Id: <119f40c77f8d44ff5d3a8b82d61678c06a690753.1607846667.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v3.git.git.1607846667.gitgitgadget@gmail.com>
References: <pull.923.v2.git.git.1607114890.gitgitgadget@gmail.com>
        <pull.923.v3.git.git.1607846667.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 13 Dec 2020 08:04:24 +0000
Subject: [PATCH v3 17/20] merge-ort: add implementation of checkout()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, dstolee@microsoft.com,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Since merge-ort creates a tree for its output, when there are no
conflicts, updating the working tree and index is as simple as using the
unpack_trees() machinery with a twoway_merge (i.e. doing the equivalent
of a "checkout" operation).

If there were conflicts in the merge, then since the tree we created
included all the conflict markers, then using the unpack_trees machinery
in this manner will still update the working tree correctly.  Further,
all index entries corresponding to cleanly merged files will also be
updated correctly by this procedure.  Index entries corresponding to
conflicted entries will appear as though the user had run "git add -u"
after the merge to accept all files as-is with conflict markers.

Thus, after running unpack_trees(), there needs to be a separate step
for updating the entries in the index corresponding to conflicted files.
This will be the job for the function record_conflicted_index_entris(),
which will be implemented in a subsequent commit.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index ee7fbe71404..3c4f64e2675 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -19,9 +19,11 @@
 
 #include "diff.h"
 #include "diffcore.h"
+#include "dir.h"
 #include "object-store.h"
 #include "strmap.h"
 #include "tree.h"
+#include "unpack-trees.h"
 #include "xdiff-interface.h"
 
 /*
@@ -975,7 +977,48 @@ static int checkout(struct merge_options *opt,
 		    struct tree *prev,
 		    struct tree *next)
 {
-	die("Not yet implemented.");
+	/* Switch the index/working copy from old to new */
+	int ret;
+	struct tree_desc trees[2];
+	struct unpack_trees_options unpack_opts;
+
+	memset(&unpack_opts, 0, sizeof(unpack_opts));
+	unpack_opts.head_idx = -1;
+	unpack_opts.src_index = opt->repo->index;
+	unpack_opts.dst_index = opt->repo->index;
+
+	setup_unpack_trees_porcelain(&unpack_opts, "merge");
+
+	/*
+	 * NOTE: if this were just "git checkout" code, we would probably
+	 * read or refresh the cache and check for a conflicted index, but
+	 * builtin/merge.c or sequencer.c really needs to read the index
+	 * and check for conflicted entries before starting merging for a
+	 * good user experience (no sense waiting for merges/rebases before
+	 * erroring out), so there's no reason to duplicate that work here.
+	 */
+
+	/* 2-way merge to the new branch */
+	unpack_opts.update = 1;
+	unpack_opts.merge = 1;
+	unpack_opts.quiet = 0; /* FIXME: sequencer might want quiet? */
+	unpack_opts.verbose_update = (opt->verbosity > 2);
+	unpack_opts.fn = twoway_merge;
+	if (1/* FIXME: opts->overwrite_ignore*/) {
+		unpack_opts.dir = xcalloc(1, sizeof(*unpack_opts.dir));
+		unpack_opts.dir->flags |= DIR_SHOW_IGNORED;
+		setup_standard_excludes(unpack_opts.dir);
+	}
+	parse_tree(prev);
+	init_tree_desc(&trees[0], prev->buffer, prev->size);
+	parse_tree(next);
+	init_tree_desc(&trees[1], next->buffer, next->size);
+
+	ret = unpack_trees(2, trees, &unpack_opts);
+	clear_unpack_trees_porcelain(&unpack_opts);
+	dir_clear(unpack_opts.dir);
+	FREE_AND_NULL(unpack_opts.dir);
+	return ret;
 }
 
 static int record_conflicted_index_entries(struct merge_options *opt,
-- 
gitgitgadget

