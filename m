Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 452BC1F62D
	for <e@80x24.org>; Sun,  8 Jul 2018 18:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932436AbeGHSBm (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jul 2018 14:01:42 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38245 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932184AbeGHSBk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jul 2018 14:01:40 -0400
Received: by mail-pg1-f193.google.com with SMTP id k3-v6so803694pgq.5
        for <git@vger.kernel.org>; Sun, 08 Jul 2018 11:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VWunDpT5Sf11NMSdgI/VNK7W2+FmCmLXh9CUwTe0CRQ=;
        b=FEBeqRWPkTSet3TIulqrV6LYKoAAeXxgPBXBXeIGmQ3YIxh5/rrYeB6Bewgxi94o+J
         pTmXjToAVdYbsw0yPLLmupiZo14aZYpjwyS1OnqG90ZlwG510gsjyBEcHQKZfgtREyT3
         DEvGm9+6EWZh6GKk2XthULSTStNTstd4yYYh3HaY1V13cIEghOXiZM6sBYHhHhrsqoqu
         AS7IYUme8f5FUMaewxVFU62IoCxZ0LZdv2XkVNjaGPB1x+CS0CLW6/CBWlsyWL0WxAP7
         JHA6/+f/IA/D2HPySLlZJ8lb3Po/62HrYOCeL/2DClHDECejJH53q085qw5H6Dd75XmF
         OsEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VWunDpT5Sf11NMSdgI/VNK7W2+FmCmLXh9CUwTe0CRQ=;
        b=oE7bUvMteJ4ddtFhnNsO33N6itBiaRjFIhSU9dt9wf0KUnvx5OPGrtF11PNz15idn/
         Y/9rSWBtsMRZ74c5044Jn+ZLj1Kil6YxClgEtKllgyib78zbEBsMQOa0s2z5xDUB4fVp
         ZIcL6mgml9JNHssZoMHvdPODITXUmYdIpxd6AwtWxqDJInBxJau+hLKIrtnn52VLLqte
         wjNRM4cI2rPSOJd7ttNnTS3yY+8MDTBUO/d/DcD4sFzZKzc98MlyOjNODKs+Grlz8VO5
         xBfh0lwPdIAJX32z3wEMwvyZTexOhY54uQIRiGgPb0tlwh1/utqgPfWRgE9z6QhYZ7Fa
         UFjQ==
X-Gm-Message-State: APt69E0mMmQ9eB5zlhddJKB34LkupfBqPwakahhOVSV0RltASbUXBBPY
        dGGkA4OpaFRe6b0Y3YFr/J8hZYP6
X-Google-Smtp-Source: AAOMgpeZhRtt3yHvHl00s1ioY0shbNMJ0HEKPhpkOBXCa/IM/jt6aBCVzvLBgr3rTJjkfmm/pOzgNg==
X-Received: by 2002:a63:1844:: with SMTP id 4-v6mr10524296pgy.313.1531072899389;
        Sun, 08 Jul 2018 11:01:39 -0700 (PDT)
Received: from localhost.localdomain ([27.34.68.75])
        by smtp.gmail.com with ESMTPSA id u13-v6sm18019149pgr.36.2018.07.08.11.01.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Jul 2018 11:01:38 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git@vger.kernel.org
Cc:     Pratik Karki <predatoramigo@gmail.com>, christian.couder@gmail.com,
        Johannes.Schindelin@gmx.de, sbeller@google.com,
        alban.gruin@gmail.com, gitster@pobox.com
Subject: [PATCH v4 3/4] sequencer: refactor the code to detach HEAD to checkout.c
Date:   Sun,  8 Jul 2018 23:46:03 +0545
Message-Id: <20180708180104.17921-4-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180708180104.17921-1-predatoramigo@gmail.com>
References: <20180628074655.5756-1-predatoramigo@gmail.com>
 <20180708180104.17921-1-predatoramigo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the upcoming builtin rebase, we will have to start by detaching
the HEAD, just like shell script version does. Essentially, we have
to do the same thing as `git checkout -q <revision>^0 --`, in pure C.

The aforementioned functionality was already present in `sequencer.c`
in `do_reset()` function. But `do_reset()` performs more than detaching
the HEAD, and performs action specific to `sequencer.c`.

So this commit refactors out that part from `do_reset()`, and moves it
to a new function called `detach_head_to()`. As this function has
nothing to do with the sequencer, and everything to do with what `git
checkout -q <revision>^0 --` does, we move that function to checkout.c.

This refactoring actually introduces a slight change in behavior:
previously, the index was locked before parsing the argument to the
todo command `reset`, while it now gets locked *after* that, in the
`detach_head_to()` function.

It does not make a huge difference, and the upside is that this closes
a few (unlikely) code paths where the index would not be unlocked upon
error.

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
---
 checkout.c  | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 checkout.h  |  3 +++
 sequencer.c | 58 +++++-------------------------------------------
 3 files changed, 72 insertions(+), 53 deletions(-)

diff --git a/checkout.c b/checkout.c
index bdefc888ba..da68915fd7 100644
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
index 9980711179..6ce46cf4e8 100644
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
index 5354d4d51e..106d518f4d 100644
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

