Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00FBC388F9
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 20:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79DAB2071A
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 20:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8Q3tTE2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbgKBUoP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 15:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbgKBUoO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 15:44:14 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00F1C061A04
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 12:44:12 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id c80so4536965oib.2
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 12:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3NP2EgG/8B70Vbco8KEBwKH7RCWHLR+ikPArhSK0X9M=;
        b=W8Q3tTE2I7QNEwoBI320NxiBgg3rlUSURKlqmZIl9hhdTTds585VbLfMaH1z1xYBpK
         8iOpb4uYHnSF8gNu7hOO7sj/ZbUdvFoXeqUjJKjsmI6dqTaYmPm+yynHQoV2AZOdoRC1
         JFiZy9JWliflFqBooACgbvtETRpsb/PT7tNR2ElqK5nHwVsy+LIFpOhcsU91Qy113Cwb
         Xj4bDbMC6i5j4t2kxqCymQtyrBhz7nWU8DixIWf7ZXiZ8ZSav4iCmHfAC05SXn5vENSi
         S0UGpc7yYiCOWvugWPbATZAbOKRRJV60jbFJr4JL+WupG9TlNYy6k9zBSo8ghj/r7uxE
         Mnkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3NP2EgG/8B70Vbco8KEBwKH7RCWHLR+ikPArhSK0X9M=;
        b=Z6S41hfzofN/utjM1X4e+VaqDfNXSTmZ2kd9ftdopuiGjAGH15qEvul+j8s6zn5gu7
         C08x+W4b1W4VOO5qgSk8q5VrkpCjv8eyJ0/4iO9SNBJrFHMYUDv3oRWS+x+PN7nOHray
         AGFCfM1LqakvkOBql2brpp/fgFf5llUrBqc9meNt2dUrKnVbyxJ/kSKh6dwZk0rHzeGP
         KudHmZh3EbOL4y1aNzIN8goCdRdo7bOez9MnzPCZU5Mciu2dyzMmRnDgpvuYMJWrKA18
         MtuSpLkwmdPLyFO5msyBcuLAiFsKfy0yh/KbuXkY8n18ZL5oabMRmkq2OtdYCJm3Ddsr
         5N7g==
X-Gm-Message-State: AOAM531RAGeN7lvHUg5FN1pREQGHQp/mZ8X1FoAVlzT7EOw/HiTJbp4S
        iC/dYR/8lcOgLbjlHE2+Qp4p0zlzjvUKRA==
X-Google-Smtp-Source: ABdhPJwR8yl+Z7CJCgcrccRTLrNtiuOrzkMdJKz9hSV9KvoPL5FCUG1i0BeMzgKNYQFgGLh9wL+sRA==
X-Received: by 2002:aca:e0d7:: with SMTP id x206mr11667457oig.67.1604349852012;
        Mon, 02 Nov 2020 12:44:12 -0800 (PST)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id t27sm3848512otc.14.2020.11.02.12.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 12:44:11 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 17/20] merge-ort: add implementation of checkout()
Date:   Mon,  2 Nov 2020 12:43:41 -0800
Message-Id: <20201102204344.342633-18-newren@gmail.com>
X-Mailer: git-send-email 2.29.0.471.ga4f56089c0
In-Reply-To: <20201102204344.342633-1-newren@gmail.com>
References: <20201102204344.342633-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since merge-ort creates a tree for its output, when there are no
conflicts, updating the working tree and index is as simple as using the
unpack_trees() machinery with a twoway_merge (i.e. doing the equivalent
of a "checkout" operation).

If there were conflicts in the merge, then since the tree we created
included all the conflict markers, then using the unpack_trees machinery
in this manner will still update the working tree correctly.  Further,
all index entries corresponding to cleanly merged files will also be
updated correctly by this procedure.  Index entries corresponding to
unmerged entries will appear as though the user had run "git add -u"
after the merge to accept all files as-is with conflict markers.

Thus, after running unpack_trees(), there needs to be a separate step
for updating the entries in the index corresponding to unmerged files.
This will be the job for the function record_unmerged_index_entries(),
which will be implemented in a subsequent commit.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index 2a60d84f1d..b7c5973d4d 100644
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
@@ -662,7 +664,48 @@ static int checkout(struct merge_options *opt,
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
+	 * read or refresh the cache and check for an unmerged index, but
+	 * builtin/merge.c or sequencer.c really needs to read the index
+	 * and check for unmerged entries before starting merging for a
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
 
 static int record_unmerged_index_entries(struct merge_options *opt,
-- 
2.29.0.471.ga4f56089c0

