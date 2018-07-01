Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B14821F516
	for <e@80x24.org>; Sun,  1 Jul 2018 01:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752130AbeGABZc (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Jun 2018 21:25:32 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:38358 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752072AbeGABZS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jun 2018 21:25:18 -0400
Received: by mail-oi0-f66.google.com with SMTP id v8-v6so11735307oie.5
        for <git@vger.kernel.org>; Sat, 30 Jun 2018 18:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HEAhxTUZR/B7RErcfkDJUMk2Yor9yLURcm6+bwX4Iik=;
        b=T3zCFsrQD/hlUNtz3LKPFF/aAy7jzWYzT4K/EsqBVJEW6bIwC04KX122LhU56j3WPi
         dI2Wh43YN6syltqXrrXlD99V6UtPUrlDrWyT0IDKbtleK4WZZ2mRdSIa53B5lUR6v9us
         JGgdIfUIAi1iiM0E3ej0xi/gE9XHp23Blqo8IyX2XK9GlrRDXw4jrH/7axWlYlSElh/8
         xxBGhz4n82tkJFI/3weV6jQcOf3gUX/yIWnBQGEbqyD1wW0KOLeg/pfSatMmM2/xaObq
         9MewzwbJDilAnkLaHTal+wz+Us/dQIAw0f06fILOk3vzti9s9J/EjYJSYbKmPZ8MJUrF
         mG/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HEAhxTUZR/B7RErcfkDJUMk2Yor9yLURcm6+bwX4Iik=;
        b=AAgM9Nt3vba7jOnYMrV5EsxdTuktXvAknURrDBYnygFjNjribYtYbrUjniLZg469ZT
         WmiPuS4RKx5216wmD4nt3FJIYVue/AGNZJoRzbK69k8UNufPEKSd1YIL6qMvWXFUKHSp
         N3R0cU1/FkD/w+NMuIesKITJ8dENdyrBTqFjeyDhn2GGl/ziDKkZ+o44DSBQm7mUiC6K
         7LW4xNpc1/Z7fkLYcAyBP48MUqp59AgY8IkQ6Y/eVZAWaPvEShwmqDXRnafYBREyK5d2
         1lFTiKflRm3tV7c0NZFbEa5Zpnj+FpK4y6Onc89hcP4vWHy7Wy9JXduVQF+7L8IYZFdC
         9gRQ==
X-Gm-Message-State: APt69E2MffSBDZn5bL+ulaVXdZnibBXeycWFHwXQnhbCPZSlzvPPFXDh
        GZPw9hIj+MoCsOxWVHVCB5l50Q==
X-Google-Smtp-Source: AAOMgpfofFF2BQu+WlAUEwmTvo4e8nk1zVqluThiRBQYAGdmem+a707ZMgRFFWYRJKUYVNMHPjNv5w==
X-Received: by 2002:aca:e142:: with SMTP id y63-v6mr12114307oig.128.1530408317542;
        Sat, 30 Jun 2018 18:25:17 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id g20-v6sm3509394ote.38.2018.06.30.18.25.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Jun 2018 18:25:17 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, pclouds@gmail.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 6/9] merge-recursive: fix assumption that head tree being merged is HEAD
Date:   Sat, 30 Jun 2018 18:25:00 -0700
Message-Id: <20180701012503.14382-7-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.137.g2a11d05a6.dirty
In-Reply-To: <20180701012503.14382-1-newren@gmail.com>
References: <20180603065810.23841-1-newren@gmail.com>
 <20180701012503.14382-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`git merge-recursive` does a three-way merge between user-specified trees
base, head, and remote.  Since the user is allowed to specify head, we can
not necesarily assume that head == HEAD.

Modify index_has_changes() to take an extra argument specifying the tree
to compare against.  If NULL, it will compare to HEAD.  We then use this
from merge-recursive to make sure we compare to the user-specified head.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/am.c                             |  7 ++++---
 cache.h                                  | 11 +++++++----
 merge-recursive.c                        |  2 +-
 read-cache.c                             | 12 ++++++++----
 t/t6044-merge-unrelated-index-changes.sh |  2 +-
 5 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 24ad3e435..cb8e2b960 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1763,7 +1763,7 @@ static void am_run(struct am_state *state, int resume)
 
 	refresh_and_write_cache();
 
-	if (index_has_changes(&the_index, &sb)) {
+	if (index_has_changes(&the_index, NULL, &sb)) {
 		write_state_bool(state, "dirtyindex", 1);
 		die(_("Dirty index: cannot apply patches (dirty: %s)"), sb.buf);
 	}
@@ -1820,7 +1820,8 @@ static void am_run(struct am_state *state, int resume)
 			 * Applying the patch to an earlier tree and merging
 			 * the result may have produced the same tree as ours.
 			 */
-			if (!apply_status && !index_has_changes(&the_index, NULL)) {
+			if (!apply_status &&
+			    !index_has_changes(&the_index, NULL, NULL)) {
 				say(state, stdout, _("No changes -- Patch already applied."));
 				goto next;
 			}
@@ -1874,7 +1875,7 @@ static void am_resolve(struct am_state *state)
 
 	say(state, stdout, _("Applying: %.*s"), linelen(state->msg), state->msg);
 
-	if (!index_has_changes(&the_index, NULL)) {
+	if (!index_has_changes(&the_index, NULL, NULL)) {
 		printf_ln(_("No changes - did you forget to use 'git add'?\n"
 			"If there is nothing left to stage, chances are that something else\n"
 			"already introduced the same changes; you might want to skip this patch."));
diff --git a/cache.h b/cache.h
index 125f2767a..b5a75806e 100644
--- a/cache.h
+++ b/cache.h
@@ -218,6 +218,7 @@ struct cache_entry {
 /* Forward structure decls */
 struct pathspec;
 struct child_process;
+struct tree;
 
 /*
  * Copy the sha1 and stat state of a cache entry from one to
@@ -635,12 +636,14 @@ extern void move_index_extensions(struct index_state *dst, struct index_state *s
 extern int unmerged_index(const struct index_state *);
 
 /**
- * Returns 1 if istate differs from HEAD, 0 otherwise.  When on an unborn
- * branch, returns 1 if there are entries in istate, 0 otherwise.  If an
- * strbuf is provided, the space-separated list of files that differ will
- * be appended to it.
+ * Returns 1 if istate differs from tree, 0 otherwise.  If tree is NULL,
+ * compares istate to HEAD.  If tree is NULL and on an unborn branch,
+ * returns 1 if there are entries in istate, 0 otherwise.  If an strbuf is
+ * provided, the space-separated list of files that differ will be appended
+ * to it.
  */
 extern int index_has_changes(const struct index_state *istate,
+			     struct tree *tree,
 			     struct strbuf *sb);
 
 extern int verify_path(const char *path, unsigned mode);
diff --git a/merge-recursive.c b/merge-recursive.c
index 9c0699be5..855ca39ca 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3266,7 +3266,7 @@ int merge_trees(struct merge_options *o,
 	if (oid_eq(&common->object.oid, &merge->object.oid)) {
 		struct strbuf sb = STRBUF_INIT;
 
-		if (!o->call_depth && index_has_changes(&the_index, &sb)) {
+		if (!o->call_depth && index_has_changes(&the_index, head, &sb)) {
 			err(o, _("Your local changes to the following files would be overwritten by merge:\n  %s"),
 			    sb.buf);
 			return -1;
diff --git a/read-cache.c b/read-cache.c
index ad3102083..acc8c390a 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1986,22 +1986,26 @@ int unmerged_index(const struct index_state *istate)
 	return 0;
 }
 
-int index_has_changes(const struct index_state *istate, struct strbuf *sb)
+int index_has_changes(const struct index_state *istate,
+		      struct tree *tree,
+		      struct strbuf *sb)
 {
-	struct object_id head;
+	struct object_id cmp;
 	int i;
 
 	if (istate != &the_index) {
 		BUG("index_has_changes cannot yet accept istate != &the_index; do_diff_cache needs updating first.");
 	}
-	if (!get_oid_tree("HEAD", &head)) {
+	if (tree)
+		cmp = tree->object.oid;
+	if (tree || !get_oid_tree("HEAD", &cmp)) {
 		struct diff_options opt;
 
 		diff_setup(&opt);
 		opt.flags.exit_with_status = 1;
 		if (!sb)
 			opt.flags.quick = 1;
-		do_diff_cache(&head, &opt);
+		do_diff_cache(&cmp, &opt);
 		diffcore_std(&opt);
 		for (i = 0; sb && i < diff_queued_diff.nr; i++) {
 			if (i)
diff --git a/t/t6044-merge-unrelated-index-changes.sh b/t/t6044-merge-unrelated-index-changes.sh
index 3876cfa4f..1d43712c5 100755
--- a/t/t6044-merge-unrelated-index-changes.sh
+++ b/t/t6044-merge-unrelated-index-changes.sh
@@ -126,7 +126,7 @@ test_expect_success 'recursive, when merge branch matches merge base' '
 	test_path_is_missing .git/MERGE_HEAD
 '
 
-test_expect_failure 'merge-recursive, when index==head but head!=HEAD' '
+test_expect_success 'merge-recursive, when index==head but head!=HEAD' '
 	git reset --hard &&
 	git checkout C^0 &&
 
-- 
2.18.0.137.g2a11d05a6.dirty

