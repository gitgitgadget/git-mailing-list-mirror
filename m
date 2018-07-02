Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 769451F516
	for <e@80x24.org>; Mon,  2 Jul 2018 09:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965007AbeGBJQp (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jul 2018 05:16:45 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:42974 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933108AbeGBJQn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jul 2018 05:16:43 -0400
Received: by mail-pg0-f68.google.com with SMTP id c10-v6so6866988pgu.9
        for <git@vger.kernel.org>; Mon, 02 Jul 2018 02:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Qpydg7CWh78GqR2EMuWijt+0xhI5TIHya0L7gGkkMqY=;
        b=kfB8iBFJr+vqlZskT3+cnzs8ETi/eTuMAHnYVGL9LN7LL5oZ1n4Y/xLxvajrUwgoHb
         6toJ/eINEc5334rZoBBGeps4ekiIi2iByr5FEF+CSPtCuO9kkmADfEL0IOLv3LJZtYKT
         namoXWjLSVcw3SeetIITTxItQ6VLrJAdg4ytF7tjb7GvdanSJkRLIbZIXXNDHHCKKCNn
         KHRYsioPKhDCHhJ+5qUf7Cruvq3VWACgm7nkP8wYWQCyIpoWhEjJVk3gWhphEmqgnrUo
         YG9RwFe4iFk8dLuSTW9JZYA4zGMnPUVagg9Bj6XiSEkO9Q2iM4p9tvbsGxC2o2guTsaY
         Qg0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Qpydg7CWh78GqR2EMuWijt+0xhI5TIHya0L7gGkkMqY=;
        b=g76M3mIKvxgfZoHNYqpXGmSLkYdCgqFHl/YHbEM5qPOfGoi1xGO516zSTtdn3NEGSF
         6Xn05Rbc8C1+rr692P7a6EJqqlRmc/ErQp+A0YZjc9iKeibT4mGMpcl5/kM8uk9cH7r3
         vqm9EWSeDOZgRoJVIq8kYjIbo22AucYUfzt85aTMgW5WUB4P7r8hcHX6Ch/cO4EtKQ8S
         lcaVEKas7/dPe0RvgXuXdHiK+Mbod/plAaqcI52LGkZHpqDiw0jJz3z9cxptJN+4fT59
         Cx2QkBze4DH4hZHrBED8J5ftcFCA+VCI0XroNOyl9EE+XwAOLfaRfGN0/aV8XQ325uuo
         fO3A==
X-Gm-Message-State: APt69E1y3FBzr/VqLHvgVWog615eiKu93X0wl80hD/73WWN1/i4ZnLCY
        CEb7ISmThruVBDrLkJj961cPqPseRHk=
X-Google-Smtp-Source: AAOMgpezyHTv7bmfK2WgVxor8ormYBFnau2aPU6t8QJ7P4OSVDyq0qxV10WovKr/VKKrtGiJogpnPg==
X-Received: by 2002:a65:4d05:: with SMTP id i5-v6mr16682188pgt.58.1530523002341;
        Mon, 02 Jul 2018 02:16:42 -0700 (PDT)
Received: from localhost.localdomain ([27.34.68.63])
        by smtp.gmail.com with ESMTPSA id y2-v6sm35961795pfk.82.2018.07.02.02.16.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 02:16:41 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, Johannes.Schindelin@gmx.de,
        sbeller@google.com, alban.gruin@gmail.com,
        Pratik Karki <predatoramigo@gmail.com>
Subject: [PATCH v2 3/4] sequencer: refactor the code to detach HEAD to checkout.c
Date:   Mon,  2 Jul 2018 15:00:08 +0545
Message-Id: <20180702091509.15950-4-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180702091509.15950-1-predatoramigo@gmail.com>
References: <20180628074655.5756-1-predatoramigo@gmail.com>
 <20180702091509.15950-1-predatoramigo@gmail.com>
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

