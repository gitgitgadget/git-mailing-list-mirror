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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F05C433FE
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 20:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2C7F22CE3
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 20:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387587AbgLDUtv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 15:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387533AbgLDUtv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 15:49:51 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86033C08ED7E
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 12:48:31 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id 23so6574622wrc.8
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 12:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4Ef3rtLqdQ3bkXPrtOa/AQcwQqh9txT9O5D8ylnCFp4=;
        b=nTRm+COIQmx6Ax3aJtnUm8SZ5GguKUEBfhI5edmexWYM+6u2+01sGEJfhGmbBn6u4L
         QV6C7icdmLV3RJhBx6aCAZ+Uz9sXg4R1Rga9MQHna4BMFNkq0gv6K9/16lf3SfHkaZxx
         4lWEDA8XmTcfjy4Ma2ItCIowIwF7562ntf35CV2BWMlU+A3vb4C+JQCtWaCnZXUjBmY1
         m7Z38GFBGQlDryOo7QtHGVHMN0mVUyZQdWBRZrAMEDdBB1CiALFpsdOYvhP9tZ8+Ngqm
         Z8CFRt0ouTK/ur6Ky293c/3nwlXQJZDQxRd9sXAjdpbqFlmZEdRAuLdaECXqRDpqOi3q
         Ai3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4Ef3rtLqdQ3bkXPrtOa/AQcwQqh9txT9O5D8ylnCFp4=;
        b=PkeE+t+N2B6DvnKVtc/AF9XONlXcxCC/k0UexCjmFLCowibwNysyjSPKuq0nsEFKo9
         0/isegWb4BXkSV3KdkUvhNVfuOJt6g818+ZFrNu0+2AppGnw6iHHBQfmrm9nEsGLgIh+
         6B0Er0IcsZhtWkAWMxz68FEKvxFTNoJTXiGcw7cCyhiSGu47akPtx4t1qX69AepIwZWc
         SZlmV9hqCPK2fOT6KGLWgRu7li7IiDopS1V3drJvuJjMdIC6MXGzoTtGXlINW8cWGEEs
         5fjI2VVKTqLbLYGkRs4rk4vcrRppRwaEpQZabyUDBpbx5I2dt885WJrWBhikfObiYH8V
         rY1g==
X-Gm-Message-State: AOAM530EM6TkbPlDyqlvFmp2SIKDm9GBu0I5u5wORUJByMMTZoo55AEa
        5nMCLB389LieQUDuGZXplRo4nD1UeJ0=
X-Google-Smtp-Source: ABdhPJyT7P4GS2wtLP5qcJXhHWPf3EJKF+qF0DLvR/bJK17yZDqlU3yb+HQte2+y+6SDo7A6266imA==
X-Received: by 2002:adf:f8d2:: with SMTP id f18mr6779749wrq.379.1607114910036;
        Fri, 04 Dec 2020 12:48:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a15sm5184089wrn.75.2020.12.04.12.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 12:48:29 -0800 (PST)
Message-Id: <61fada146cf26dd86705d6eeb375c28735f2364b.1607114891.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v2.git.git.1607114890.gitgitgadget@gmail.com>
References: <pull.923.git.git.1606635803.gitgitgadget@gmail.com>
        <pull.923.v2.git.git.1607114890.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 04 Dec 2020 20:48:07 +0000
Subject: [PATCH v2 17/20] merge-ort: add implementation of checkout()
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
index fe22751d22..ba62f80420 100644
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
 
 struct merge_options_internal {
@@ -948,7 +950,48 @@ static int checkout(struct merge_options *opt,
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

