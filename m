Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDA6C388F9
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 03:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CF1C214DB
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 03:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eXvefOQh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgJ3Dmy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 23:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgJ3Dmg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 23:42:36 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82856C0613E2
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 20:42:01 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id k3so4469959otp.1
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 20:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hRM/UyOupsJLfM+8brweFn3i2Segwa0PDcUC6ikit7I=;
        b=eXvefOQhcPguNaAhXJl6ktEnwBbpyDvqmliTSuTuzPJXWYqoHL/jTk/MJYwxf3RMu0
         aRw3zH9PWdExig1VxbifCuMysE2zdTiF2bXooSQo9rm/YSpZjCbEm1rtoJIQxYKGruCH
         Q7g7i/pfEaObxBz6gnTRZkgs4OtQFk5y3B3WS4Of3In5ih1vBHWoiMDbIvkTIgexZ8t9
         ylUXFBqjiqW1qz8LsQnQ4CVa/t/Db1FkY2C3rA3xyPcMOzv7qRrdW4MIpLw9fvew9rxh
         uDMHqhwCNsJabkXo8A1hH9ShA1UDMk4+0YdwmKsJwBqboH7ndWGqTzZs5Vl/2ii7IkNL
         ZaxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hRM/UyOupsJLfM+8brweFn3i2Segwa0PDcUC6ikit7I=;
        b=cIpjuPeza/YQ/Qd7PiY5zYpc9Zi+f45a/WYL4RMD4KuklFedlFAnm7a7zBewwQkz6P
         Mi+rS9JcTg6H1r212YJVUqY8ao1fwvWz3TnYA+SaYGo8A/DaYGjgUPYQwXXhxXAbGjmW
         isizWtL0s2mgctkj4+Xy8HtziftN/g9uDl9paqU2hO+QfxaDzsngSvrrWQPZaIK5m9iL
         JwjX+nNGKzg+tWgGFbINoBUseyZko4JaZBnZzaDmykEg8OQNhP/p//FD75XLXC98w5cH
         E3AzUYripqlkgoNBElxssMXMvibB3wa+jV12kCxUzXIUmBMQgVs4R3Gf2YgXKKq45ksJ
         upeA==
X-Gm-Message-State: AOAM5320k26P2EsS5dCD/2xrD0S/AEKdnPy5CT4DqO7gNTPCzHt/ppO5
        QUOOtIaCcfr+jtwEYlQhFwKbiLVfj+ELVg==
X-Google-Smtp-Source: ABdhPJyeEGsMKKE7XokWeYb6j211wsSesM6T/LdxLum1CRYXlIFZ7T7A1HS5PsEWav3WXsQVqusZ4A==
X-Received: by 2002:a9d:6c1a:: with SMTP id f26mr177457otq.1.1604029320722;
        Thu, 29 Oct 2020 20:42:00 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id x13sm1047063otg.66.2020.10.29.20.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 20:42:00 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH 17/20] merge-ort: add implementation of checkout()
Date:   Thu, 29 Oct 2020 20:41:28 -0700
Message-Id: <20201030034131.1479968-18-newren@gmail.com>
X-Mailer: git-send-email 2.29.1.56.ga287c268e6.dirty
In-Reply-To: <20201030034131.1479968-1-newren@gmail.com>
References: <20201030034131.1479968-1-newren@gmail.com>
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
index a5b97adfc4..4da671d647 100644
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
@@ -663,7 +665,48 @@ static int checkout(struct merge_options *opt,
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
2.29.1.56.ga287c268e6.dirty

