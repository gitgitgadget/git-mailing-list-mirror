Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C7B51F516
	for <e@80x24.org>; Thu, 28 Jun 2018 07:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965101AbeF1Hsi (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 03:48:38 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:41318 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964960AbeF1Hsg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 03:48:36 -0400
Received: by mail-pl0-f67.google.com with SMTP id w8-v6so2365121ply.8
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 00:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Qpydg7CWh78GqR2EMuWijt+0xhI5TIHya0L7gGkkMqY=;
        b=g+FVp5MnRUCf/o1tGiD6TNRNQdBpS/v26Uv+IxeaqRMFsx/oVOJhvhbvCuHme+QOuH
         1MIi5hS6FC2Uk/VUPtVwdzuaC9UQ0advd0IXq7CeN8b/tQRY722aZlRVWzYnw3uPIuDi
         84br5Mg++x/ggW2bkGVrAySQxkolrRVF45HTgRrb4jtcdgR9DFVg9vgnkpqXdL97L6nJ
         ORwtXzIvU8BE8ha+AGghwClL8pHF3MrkH/JM8wKoOE3HRLbbRZDF/DUjz1I37JiAmD5+
         K1pPeBp2/cFWrULHE68BMnpocRNRYVjBDgVaZHUDeY+sby9ormAhN7WN5txusgJSz+E5
         Q/0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Qpydg7CWh78GqR2EMuWijt+0xhI5TIHya0L7gGkkMqY=;
        b=J9vxawz+Zk0wWUil0gw+eQiYfdBHQfCAHJxcT2idd8h0cVuvMT/Buo0+2xzcslp8Ds
         fc8YHw4q+7atstZ2QoP21Q+Tgy7/5wLr7Mk6q8MgvgWICY2MWhkf9y0B/3jc6yk5dNtW
         MwXRg8Fn2sC7W2BHsbhZ0Xgp2B3uKLxaYwtGe5xVF1Zi25HJpjIpw6XIjbsvoyGbjPWC
         O0CmeRYznUy5hbQHGynC9wTY+9dYWnbgXfiJQgEcPqXCWNpBfyKlD85eHyEaAFr9wf9I
         hDeg6juTBaoKbbaNoifd5EukX9WgLhGiSVhAxhqiuuUFxxoE+Usw5pgfBl5yTsyCIhMh
         tl5g==
X-Gm-Message-State: APt69E32xlFO+8NxpJyvFplykc/0ZXYHNbIu5Hx4Dz6c5njE8WkB9kZX
        8ypeSEr+UDDjUzszHhWPc5nMiMnZYRo=
X-Google-Smtp-Source: ADUXVKKqisRRdz9RD6yg7I/b3SGWtOjHUKoNAZAIx6dZD3TdzZiywsmDnzWT578h2xAMKMfvZRiXtg==
X-Received: by 2002:a17:902:2924:: with SMTP id g33-v6mr9667476plb.26.1530172116118;
        Thu, 28 Jun 2018 00:48:36 -0700 (PDT)
Received: from localhost.localdomain ([27.34.16.160])
        by smtp.gmail.com with ESMTPSA id x90-v6sm23416168pfk.151.2018.06.28.00.48.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 00:48:35 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, Johannes.Schindelin@gmx.de,
        sbeller@google.com, alban.gruin@gmail.com,
        Pratik Karki <predatoramigo@gmail.com>
Subject: [PATCH 4/5] sequencer: refactor the code to detach HEAD to checkout.c
Date:   Thu, 28 Jun 2018 13:31:54 +0545
Message-Id: <20180628074655.5756-5-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180628074655.5756-1-predatoramigo@gmail.com>
References: <20180628074655.5756-1-predatoramigo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The motivation behind this commit is to extract the core part of
do_reset() from sequencer.c and move it to a new detach_head_to()
function in checkout.c.

Here the index only gets locked after performing the first part of
`do_reset()` rather than before which essentially derives the `oid`
from the specified label/name passed to the `do_reset()` function.
It also fixes two bugs: there were two `return error()` statements in
the `[new root]` case that would have failed to unlock the index.

The new function will be used in the next commit by the builtin rebase,
to perform the initial checkout.

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
---
 checkout.c  | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 checkout.h  |  3 +++
 sequencer.c | 58 +++++-------------------------------------------
 3 files changed, 72 insertions(+), 53 deletions(-)

diff --git a/checkout.c b/checkout.c
index bdefc888b..da68915fd 100644
--- a/checkout.c
+++ b/checkout.c
@@ -2,6 +2,11 @@
 #include "remote.h"
 #include "refspec.h"
 #include "checkout.h"
+#include "unpack-trees.h"
+#include "lockfile.h"
+#include "refs.h"
+#include "tree.h"
+#include "cache-tree.h"
 
 struct tracking_name_data {
 	/* const */ char *src_ref;
@@ -42,3 +47,62 @@ const char *unique_tracking_name(const char *name, struct object_id *oid)
 	free(cb_data.dst_ref);
 	return NULL;
 }
+
+int detach_head_to(struct object_id *oid, const char *action,
+		   const char *reflog_message)
+{
+	struct strbuf ref_name = STRBUF_INIT;
+	struct tree_desc desc;
+	struct lock_file lock = LOCK_INIT;
+	struct unpack_trees_options unpack_tree_opts;
+	struct tree *tree;
+	int ret = 0;
+
+	if (hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0)
+		return -1;
+
+	memset(&unpack_tree_opts, 0, sizeof(unpack_tree_opts));
+	setup_unpack_trees_porcelain(&unpack_tree_opts, action);
+	unpack_tree_opts.head_idx = 1;
+	unpack_tree_opts.src_index = &the_index;
+	unpack_tree_opts.dst_index = &the_index;
+	unpack_tree_opts.fn = oneway_merge;
+	unpack_tree_opts.merge = 1;
+	unpack_tree_opts.update = 1;
+
+	if (read_cache_unmerged()) {
+		rollback_lock_file(&lock);
+		strbuf_release(&ref_name);
+		return error_resolve_conflict(_(action));
+	}
+
+	if (!fill_tree_descriptor(&desc, oid)) {
+		error(_("failed to find tree of %s"), oid_to_hex(oid));
+		rollback_lock_file(&lock);
+		free((void *)desc.buffer);
+		strbuf_release(&ref_name);
+		return -1;
+	}
+
+	if (unpack_trees(1, &desc, &unpack_tree_opts)) {
+		rollback_lock_file(&lock);
+		free((void *)desc.buffer);
+		strbuf_release(&ref_name);
+		return -1;
+	}
+
+	tree = parse_tree_indirect(oid);
+	prime_cache_tree(&the_index, tree);
+
+	if (write_locked_index(&the_index, &lock, COMMIT_LOCK) < 0)
+		ret = error(_("could not write index"));
+	free((void *)desc.buffer);
+
+	if (!ret)
+		ret = update_ref(reflog_message, "HEAD", oid,
+				 NULL, 0, UPDATE_REFS_MSG_ON_ERR);
+
+	strbuf_release(&ref_name);
+	return ret;
+
+}
diff --git a/checkout.h b/checkout.h
index 998071117..6ce46cf4e 100644
--- a/checkout.h
+++ b/checkout.h
@@ -10,4 +10,7 @@
  */
 extern const char *unique_tracking_name(const char *name, struct object_id *oid);
 
+int detach_head_to(struct object_id *oid, const char *action,
+		   const char *reflog_message);
+
 #endif /* CHECKOUT_H */
diff --git a/sequencer.c b/sequencer.c
index 5354d4d51..106d518f4 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -29,6 +29,7 @@
 #include "oidset.h"
 #include "commit-slab.h"
 #include "alias.h"
+#include "checkout.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -2756,14 +2757,7 @@ static int do_reset(const char *name, int len, struct replay_opts *opts)
 {
 	struct strbuf ref_name = STRBUF_INIT;
 	struct object_id oid;
-	struct lock_file lock = LOCK_INIT;
-	struct tree_desc desc;
-	struct tree *tree;
-	struct unpack_trees_options unpack_tree_opts;
-	int ret = 0, i;
-
-	if (hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0)
-		return -1;
+	int i;
 
 	if (len == 10 && !strncmp("[new root]", name, len)) {
 		if (!opts->have_squash_onto) {
@@ -2789,56 +2783,14 @@ static int do_reset(const char *name, int len, struct replay_opts *opts)
 		if (get_oid(ref_name.buf, &oid) &&
 		    get_oid(ref_name.buf + strlen("refs/rewritten/"), &oid)) {
 			error(_("could not read '%s'"), ref_name.buf);
-			rollback_lock_file(&lock);
 			strbuf_release(&ref_name);
 			return -1;
 		}
 	}
 
-	memset(&unpack_tree_opts, 0, sizeof(unpack_tree_opts));
-	setup_unpack_trees_porcelain(&unpack_tree_opts, "reset");
-	unpack_tree_opts.head_idx = 1;
-	unpack_tree_opts.src_index = &the_index;
-	unpack_tree_opts.dst_index = &the_index;
-	unpack_tree_opts.fn = oneway_merge;
-	unpack_tree_opts.merge = 1;
-	unpack_tree_opts.update = 1;
-
-	if (read_cache_unmerged()) {
-		rollback_lock_file(&lock);
-		strbuf_release(&ref_name);
-		return error_resolve_conflict(_(action_name(opts)));
-	}
-
-	if (!fill_tree_descriptor(&desc, &oid)) {
-		error(_("failed to find tree of %s"), oid_to_hex(&oid));
-		rollback_lock_file(&lock);
-		free((void *)desc.buffer);
-		strbuf_release(&ref_name);
-		return -1;
-	}
-
-	if (unpack_trees(1, &desc, &unpack_tree_opts)) {
-		rollback_lock_file(&lock);
-		free((void *)desc.buffer);
-		strbuf_release(&ref_name);
-		return -1;
-	}
-
-	tree = parse_tree_indirect(&oid);
-	prime_cache_tree(&the_index, tree);
-
-	if (write_locked_index(&the_index, &lock, COMMIT_LOCK) < 0)
-		ret = error(_("could not write index"));
-	free((void *)desc.buffer);
-
-	if (!ret)
-		ret = update_ref(reflog_message(opts, "reset", "'%.*s'",
-						len, name), "HEAD", &oid,
-				 NULL, 0, UPDATE_REFS_MSG_ON_ERR);
-
-	strbuf_release(&ref_name);
-	return ret;
+	return detach_head_to(&oid, action_name(opts),
+			      reflog_message(opts, "reset", "'%.*s'",
+					     len, name));
 }
 
 static int do_merge(struct commit *commit, const char *arg, int arg_len,
-- 
2.18.0

