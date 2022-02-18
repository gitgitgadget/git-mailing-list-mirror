Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D5FC433FE
	for <git@archiver.kernel.org>; Fri, 18 Feb 2022 18:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239350AbiBRSlP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 13:41:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239339AbiBRSlK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 13:41:10 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1592A0720
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 10:40:52 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id x3-20020a05600c21c300b0037c01ad715bso7049899wmj.2
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 10:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=7+G3UQB5ArRts9/+zdTC+pAq62GePXPnXgNfgsgT6D8=;
        b=HdekPZDog8wJbdPOnwYaWhkBJatORbtbq/3m73c94M1PrAtOFRlsF7jewIO5k0gnD0
         cu/slaAL4gj2hLpeQ3jWGcZdH3yGqR++RNr9H73EpPAQ3Fvr6DB4sZWpnBCHZLSQbvJ2
         AtIYbS040oHbjrr3MtVhqBsHHPSPALlaIqRCc4J7ukfGt3ecxGBKg0X/Z23zj59Azr1M
         ZcwLC+3bMOy1t6eq/z8vPg+zdoS1VgDF0mkOnfk0DCBRiBV68ZRcH6589IIOKhKHzo8r
         195kLG74CETE69yYJV6FtvymWSSkauwngrSdDUprOgvm8Mdqs+O/JA/4NNiA3Ik9LtEQ
         5yAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=7+G3UQB5ArRts9/+zdTC+pAq62GePXPnXgNfgsgT6D8=;
        b=SOcKG8BmOoIRrzkiz+64hcDQgkFiTP/BSEODUleA7Z6OJbbkn9m+8vtBKZJ+bPcZ5M
         aaXTq/RHM9cNqBaw7owC9ATZO/z5G+i9shk+mVjkQZRlcuaproMd2klJMQvCRKB72Bbi
         3p0rRC5MfWEEBoWgd7XclTkZXl+oBNDPLNv6EZBfdjWDNEFfVctoWqVIB/+aJLGWuhyA
         9u++GF8XiUzTTE+mPSVlF2AZnb+6213bfhwmvfLFQUapBuOWRr1wcUxdBACreTqqYb5W
         Ox6cR0A1iZdie5J1QxJd9HlIgkxb0R7du/dLvseZGiETT58HmEMKou950+cE1iZh1dC1
         mdnA==
X-Gm-Message-State: AOAM532oLP8BVyEJMHmxARlowAHq5pIBeJmwOAZeG6PeENbLQx8tTHMf
        rQ7g8x8ipARSEmB8NKCWiAD3IcCfy0U=
X-Google-Smtp-Source: ABdhPJxuW0lUwKM7nAqHeKphCksmtcjh3OgldEhhd269NA7NiVViLGcwj/iSHEEReNLm+Y+j1qNO5w==
X-Received: by 2002:a1c:4e08:0:b0:37b:ddc5:dca7 with SMTP id g8-20020a1c4e08000000b0037bddc5dca7mr8433911wmh.100.1645209649982;
        Fri, 18 Feb 2022 10:40:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l12sm153361wmd.44.2022.02.18.10.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 10:40:49 -0800 (PST)
Message-Id: <9e17ece8d8956c7fd41b7be2f5c0475b1f9af6ec.1645209647.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1218.git.git.1645209647.gitgitgadget@gmail.com>
References: <pull.1218.git.git.1645209647.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 18 Feb 2022 18:40:45 +0000
Subject: [PATCH 1/3] reflog: libify delete reflog function and helpers
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

Currently stash shells out to reflog in order to delete refs. In an
effort to reduce how much we shell out to a subprocess, libify the
functionality that stash needs into reflog.c.

Add a reflog_delete function that is pretty much the logic in the while
loop in builtin/reflog.c cmd_reflog_delete(). This is a function that
builtin/reflog.c and builtin/stash.c can both call.

Also move functions needed by reflog_delete and export them.

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: John Cai <johncai86@gmail.com>
---
 Makefile         |   1 +
 builtin/reflog.c | 409 +-------------------------------------------
 reflog.c         | 432 +++++++++++++++++++++++++++++++++++++++++++++++
 reflog.h         |  49 ++++++
 4 files changed, 484 insertions(+), 407 deletions(-)
 create mode 100644 reflog.c
 create mode 100644 reflog.h

diff --git a/Makefile b/Makefile
index 186f9ab6190..f1e295539ab 100644
--- a/Makefile
+++ b/Makefile
@@ -990,6 +990,7 @@ LIB_OBJS += rebase-interactive.o
 LIB_OBJS += rebase.o
 LIB_OBJS += ref-filter.o
 LIB_OBJS += reflog-walk.o
+LIB_OBJS += reflog.o
 LIB_OBJS += refs.o
 LIB_OBJS += refs/debug.o
 LIB_OBJS += refs/files-backend.o
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 85b838720c3..65198320cd2 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -1,16 +1,13 @@
 #include "builtin.h"
 #include "config.h"
 #include "lockfile.h"
-#include "object-store.h"
 #include "repository.h"
-#include "commit.h"
-#include "refs.h"
 #include "dir.h"
-#include "tree-walk.h"
 #include "diff.h"
 #include "revision.h"
 #include "reachable.h"
 #include "worktree.h"
+#include "reflog.h"
 
 static const char reflog_exists_usage[] =
 N_("git reflog exists <ref>");
@@ -18,404 +15,11 @@ N_("git reflog exists <ref>");
 static timestamp_t default_reflog_expire;
 static timestamp_t default_reflog_expire_unreachable;
 
-struct cmd_reflog_expire_cb {
-	int stalefix;
-	int explicit_expiry;
-	timestamp_t expire_total;
-	timestamp_t expire_unreachable;
-	int recno;
-};
-
-struct expire_reflog_policy_cb {
-	enum {
-		UE_NORMAL,
-		UE_ALWAYS,
-		UE_HEAD
-	} unreachable_expire_kind;
-	struct commit_list *mark_list;
-	unsigned long mark_limit;
-	struct cmd_reflog_expire_cb cmd;
-	struct commit *tip_commit;
-	struct commit_list *tips;
-	unsigned int dry_run:1;
-};
-
 struct worktree_reflogs {
 	struct worktree *worktree;
 	struct string_list reflogs;
 };
 
-/* Remember to update object flag allocation in object.h */
-#define INCOMPLETE	(1u<<10)
-#define STUDYING	(1u<<11)
-#define REACHABLE	(1u<<12)
-
-static int tree_is_complete(const struct object_id *oid)
-{
-	struct tree_desc desc;
-	struct name_entry entry;
-	int complete;
-	struct tree *tree;
-
-	tree = lookup_tree(the_repository, oid);
-	if (!tree)
-		return 0;
-	if (tree->object.flags & SEEN)
-		return 1;
-	if (tree->object.flags & INCOMPLETE)
-		return 0;
-
-	if (!tree->buffer) {
-		enum object_type type;
-		unsigned long size;
-		void *data = read_object_file(oid, &type, &size);
-		if (!data) {
-			tree->object.flags |= INCOMPLETE;
-			return 0;
-		}
-		tree->buffer = data;
-		tree->size = size;
-	}
-	init_tree_desc(&desc, tree->buffer, tree->size);
-	complete = 1;
-	while (tree_entry(&desc, &entry)) {
-		if (!has_object_file(&entry.oid) ||
-		    (S_ISDIR(entry.mode) && !tree_is_complete(&entry.oid))) {
-			tree->object.flags |= INCOMPLETE;
-			complete = 0;
-		}
-	}
-	free_tree_buffer(tree);
-
-	if (complete)
-		tree->object.flags |= SEEN;
-	return complete;
-}
-
-static int commit_is_complete(struct commit *commit)
-{
-	struct object_array study;
-	struct object_array found;
-	int is_incomplete = 0;
-	int i;
-
-	/* early return */
-	if (commit->object.flags & SEEN)
-		return 1;
-	if (commit->object.flags & INCOMPLETE)
-		return 0;
-	/*
-	 * Find all commits that are reachable and are not marked as
-	 * SEEN.  Then make sure the trees and blobs contained are
-	 * complete.  After that, mark these commits also as SEEN.
-	 * If some of the objects that are needed to complete this
-	 * commit are missing, mark this commit as INCOMPLETE.
-	 */
-	memset(&study, 0, sizeof(study));
-	memset(&found, 0, sizeof(found));
-	add_object_array(&commit->object, NULL, &study);
-	add_object_array(&commit->object, NULL, &found);
-	commit->object.flags |= STUDYING;
-	while (study.nr) {
-		struct commit *c;
-		struct commit_list *parent;
-
-		c = (struct commit *)object_array_pop(&study);
-		if (!c->object.parsed && !parse_object(the_repository, &c->object.oid))
-			c->object.flags |= INCOMPLETE;
-
-		if (c->object.flags & INCOMPLETE) {
-			is_incomplete = 1;
-			break;
-		}
-		else if (c->object.flags & SEEN)
-			continue;
-		for (parent = c->parents; parent; parent = parent->next) {
-			struct commit *p = parent->item;
-			if (p->object.flags & STUDYING)
-				continue;
-			p->object.flags |= STUDYING;
-			add_object_array(&p->object, NULL, &study);
-			add_object_array(&p->object, NULL, &found);
-		}
-	}
-	if (!is_incomplete) {
-		/*
-		 * make sure all commits in "found" array have all the
-		 * necessary objects.
-		 */
-		for (i = 0; i < found.nr; i++) {
-			struct commit *c =
-				(struct commit *)found.objects[i].item;
-			if (!tree_is_complete(get_commit_tree_oid(c))) {
-				is_incomplete = 1;
-				c->object.flags |= INCOMPLETE;
-			}
-		}
-		if (!is_incomplete) {
-			/* mark all found commits as complete, iow SEEN */
-			for (i = 0; i < found.nr; i++)
-				found.objects[i].item->flags |= SEEN;
-		}
-	}
-	/* clear flags from the objects we traversed */
-	for (i = 0; i < found.nr; i++)
-		found.objects[i].item->flags &= ~STUDYING;
-	if (is_incomplete)
-		commit->object.flags |= INCOMPLETE;
-	else {
-		/*
-		 * If we come here, we have (1) traversed the ancestry chain
-		 * from the "commit" until we reach SEEN commits (which are
-		 * known to be complete), and (2) made sure that the commits
-		 * encountered during the above traversal refer to trees that
-		 * are complete.  Which means that we know *all* the commits
-		 * we have seen during this process are complete.
-		 */
-		for (i = 0; i < found.nr; i++)
-			found.objects[i].item->flags |= SEEN;
-	}
-	/* free object arrays */
-	object_array_clear(&study);
-	object_array_clear(&found);
-	return !is_incomplete;
-}
-
-static int keep_entry(struct commit **it, struct object_id *oid)
-{
-	struct commit *commit;
-
-	if (is_null_oid(oid))
-		return 1;
-	commit = lookup_commit_reference_gently(the_repository, oid, 1);
-	if (!commit)
-		return 0;
-
-	/*
-	 * Make sure everything in this commit exists.
-	 *
-	 * We have walked all the objects reachable from the refs
-	 * and cache earlier.  The commits reachable by this commit
-	 * must meet SEEN commits -- and then we should mark them as
-	 * SEEN as well.
-	 */
-	if (!commit_is_complete(commit))
-		return 0;
-	*it = commit;
-	return 1;
-}
-
-/*
- * Starting from commits in the cb->mark_list, mark commits that are
- * reachable from them.  Stop the traversal at commits older than
- * the expire_limit and queue them back, so that the caller can call
- * us again to restart the traversal with longer expire_limit.
- */
-static void mark_reachable(struct expire_reflog_policy_cb *cb)
-{
-	struct commit_list *pending;
-	timestamp_t expire_limit = cb->mark_limit;
-	struct commit_list *leftover = NULL;
-
-	for (pending = cb->mark_list; pending; pending = pending->next)
-		pending->item->object.flags &= ~REACHABLE;
-
-	pending = cb->mark_list;
-	while (pending) {
-		struct commit_list *parent;
-		struct commit *commit = pop_commit(&pending);
-		if (commit->object.flags & REACHABLE)
-			continue;
-		if (parse_commit(commit))
-			continue;
-		commit->object.flags |= REACHABLE;
-		if (commit->date < expire_limit) {
-			commit_list_insert(commit, &leftover);
-			continue;
-		}
-		commit->object.flags |= REACHABLE;
-		parent = commit->parents;
-		while (parent) {
-			commit = parent->item;
-			parent = parent->next;
-			if (commit->object.flags & REACHABLE)
-				continue;
-			commit_list_insert(commit, &pending);
-		}
-	}
-	cb->mark_list = leftover;
-}
-
-static int unreachable(struct expire_reflog_policy_cb *cb, struct commit *commit, struct object_id *oid)
-{
-	/*
-	 * We may or may not have the commit yet - if not, look it
-	 * up using the supplied sha1.
-	 */
-	if (!commit) {
-		if (is_null_oid(oid))
-			return 0;
-
-		commit = lookup_commit_reference_gently(the_repository, oid,
-							1);
-
-		/* Not a commit -- keep it */
-		if (!commit)
-			return 0;
-	}
-
-	/* Reachable from the current ref?  Don't prune. */
-	if (commit->object.flags & REACHABLE)
-		return 0;
-
-	if (cb->mark_list && cb->mark_limit) {
-		cb->mark_limit = 0; /* dig down to the root */
-		mark_reachable(cb);
-	}
-
-	return !(commit->object.flags & REACHABLE);
-}
-
-/*
- * Return true iff the specified reflog entry should be expired.
- */
-static int should_expire_reflog_ent(struct object_id *ooid, struct object_id *noid,
-				    const char *email, timestamp_t timestamp, int tz,
-				    const char *message, void *cb_data)
-{
-	struct expire_reflog_policy_cb *cb = cb_data;
-	struct commit *old_commit, *new_commit;
-
-	if (timestamp < cb->cmd.expire_total)
-		return 1;
-
-	old_commit = new_commit = NULL;
-	if (cb->cmd.stalefix &&
-	    (!keep_entry(&old_commit, ooid) || !keep_entry(&new_commit, noid)))
-		return 1;
-
-	if (timestamp < cb->cmd.expire_unreachable) {
-		switch (cb->unreachable_expire_kind) {
-		case UE_ALWAYS:
-			return 1;
-		case UE_NORMAL:
-		case UE_HEAD:
-			if (unreachable(cb, old_commit, ooid) || unreachable(cb, new_commit, noid))
-				return 1;
-			break;
-		}
-	}
-
-	if (cb->cmd.recno && --(cb->cmd.recno) == 0)
-		return 1;
-
-	return 0;
-}
-
-static int should_expire_reflog_ent_verbose(struct object_id *ooid,
-					    struct object_id *noid,
-					    const char *email,
-					    timestamp_t timestamp, int tz,
-					    const char *message, void *cb_data)
-{
-	struct expire_reflog_policy_cb *cb = cb_data;
-	int expire;
-
-	expire = should_expire_reflog_ent(ooid, noid, email, timestamp, tz,
-					  message, cb);
-
-	if (!expire)
-		printf("keep %s", message);
-	else if (cb->dry_run)
-		printf("would prune %s", message);
-	else
-		printf("prune %s", message);
-
-	return expire;
-}
-
-static int push_tip_to_list(const char *refname, const struct object_id *oid,
-			    int flags, void *cb_data)
-{
-	struct commit_list **list = cb_data;
-	struct commit *tip_commit;
-	if (flags & REF_ISSYMREF)
-		return 0;
-	tip_commit = lookup_commit_reference_gently(the_repository, oid, 1);
-	if (!tip_commit)
-		return 0;
-	commit_list_insert(tip_commit, list);
-	return 0;
-}
-
-static int is_head(const char *refname)
-{
-	switch (ref_type(refname)) {
-	case REF_TYPE_OTHER_PSEUDOREF:
-	case REF_TYPE_MAIN_PSEUDOREF:
-		if (parse_worktree_ref(refname, NULL, NULL, &refname))
-			BUG("not a worktree ref: %s", refname);
-		break;
-	default:
-		break;
-	}
-	return !strcmp(refname, "HEAD");
-}
-
-static void reflog_expiry_prepare(const char *refname,
-				  const struct object_id *oid,
-				  void *cb_data)
-{
-	struct expire_reflog_policy_cb *cb = cb_data;
-	struct commit_list *elem;
-	struct commit *commit = NULL;
-
-	if (!cb->cmd.expire_unreachable || is_head(refname)) {
-		cb->unreachable_expire_kind = UE_HEAD;
-	} else {
-		commit = lookup_commit(the_repository, oid);
-		cb->unreachable_expire_kind = commit ? UE_NORMAL : UE_ALWAYS;
-	}
-
-	if (cb->cmd.expire_unreachable <= cb->cmd.expire_total)
-		cb->unreachable_expire_kind = UE_ALWAYS;
-
-	switch (cb->unreachable_expire_kind) {
-	case UE_ALWAYS:
-		return;
-	case UE_HEAD:
-		for_each_ref(push_tip_to_list, &cb->tips);
-		for (elem = cb->tips; elem; elem = elem->next)
-			commit_list_insert(elem->item, &cb->mark_list);
-		break;
-	case UE_NORMAL:
-		commit_list_insert(commit, &cb->mark_list);
-		/* For reflog_expiry_cleanup() below */
-		cb->tip_commit = commit;
-	}
-	cb->mark_limit = cb->cmd.expire_total;
-	mark_reachable(cb);
-}
-
-static void reflog_expiry_cleanup(void *cb_data)
-{
-	struct expire_reflog_policy_cb *cb = cb_data;
-	struct commit_list *elem;
-
-	switch (cb->unreachable_expire_kind) {
-	case UE_ALWAYS:
-		return;
-	case UE_HEAD:
-		for (elem = cb->tips; elem; elem = elem->next)
-			clear_commit_marks(elem->item, REACHABLE);
-		free_commit_list(cb->tips);
-		break;
-	case UE_NORMAL:
-		clear_commit_marks(cb->tip_commit, REACHABLE);
-		break;
-	}
-}
-
 static int collect_reflog(const char *ref, const struct object_id *oid, int unused, void *cb_data)
 {
 	struct worktree_reflogs *cb = cb_data;
@@ -704,16 +308,6 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 	return status;
 }
 
-static int count_reflog_ent(struct object_id *ooid, struct object_id *noid,
-		const char *email, timestamp_t timestamp, int tz,
-		const char *message, void *cb_data)
-{
-	struct cmd_reflog_expire_cb *cb = cb_data;
-	if (!cb->expire_total || timestamp < cb->expire_total)
-		cb->recno++;
-	return 0;
-}
-
 static const char * reflog_delete_usage[] = {
 	N_("git reflog delete [--rewrite] [--updateref] "
 	   "[--dry-run | -n] [--verbose] <refs>..."),
@@ -726,6 +320,7 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 	int i, status = 0;
 	unsigned int flags = 0;
 	int verbose = 0;
+
 	reflog_expiry_should_prune_fn *should_prune_fn = should_expire_reflog_ent;
 	const struct option options[] = {
 		OPT_BIT(0, "dry-run", &flags, N_("do not actually prune any entries"),
diff --git a/reflog.c b/reflog.c
new file mode 100644
index 00000000000..227ed83b3da
--- /dev/null
+++ b/reflog.c
@@ -0,0 +1,432 @@
+#include "cache.h"
+#include "commit.h"
+#include "object-store.h"
+#include "reachable.h"
+#include "reflog.h"
+#include "refs.h"
+#include "revision.h"
+#include "tree-walk.h"
+#include "worktree.h"
+
+static int tree_is_complete(const struct object_id *oid)
+{
+	struct tree_desc desc;
+	struct name_entry entry;
+	int complete;
+	struct tree *tree;
+
+	tree = lookup_tree(the_repository, oid);
+	if (!tree)
+		return 0;
+	if (tree->object.flags & SEEN)
+		return 1;
+	if (tree->object.flags & INCOMPLETE)
+		return 0;
+
+	if (!tree->buffer) {
+		enum object_type type;
+		unsigned long size;
+		void *data = read_object_file(oid, &type, &size);
+		if (!data) {
+			tree->object.flags |= INCOMPLETE;
+			return 0;
+		}
+		tree->buffer = data;
+		tree->size = size;
+	}
+	init_tree_desc(&desc, tree->buffer, tree->size);
+	complete = 1;
+	while (tree_entry(&desc, &entry)) {
+		if (!has_object_file(&entry.oid) ||
+		    (S_ISDIR(entry.mode) && !tree_is_complete(&entry.oid))) {
+			tree->object.flags |= INCOMPLETE;
+			complete = 0;
+		}
+	}
+	free_tree_buffer(tree);
+
+	if (complete)
+		tree->object.flags |= SEEN;
+	return complete;
+}
+
+static int commit_is_complete(struct commit *commit)
+{
+	struct object_array study;
+	struct object_array found;
+	int is_incomplete = 0;
+	int i;
+
+	/* early return */
+	if (commit->object.flags & SEEN)
+		return 1;
+	if (commit->object.flags & INCOMPLETE)
+		return 0;
+	/*
+	 * Find all commits that are reachable and are not marked as
+	 * SEEN.  Then make sure the trees and blobs contained are
+	 * complete.  After that, mark these commits also as SEEN.
+	 * If some of the objects that are needed to complete this
+	 * commit are missing, mark this commit as INCOMPLETE.
+	 */
+	memset(&study, 0, sizeof(study));
+	memset(&found, 0, sizeof(found));
+	add_object_array(&commit->object, NULL, &study);
+	add_object_array(&commit->object, NULL, &found);
+	commit->object.flags |= STUDYING;
+	while (study.nr) {
+		struct commit *c;
+		struct commit_list *parent;
+
+		c = (struct commit *)object_array_pop(&study);
+		if (!c->object.parsed && !parse_object(the_repository, &c->object.oid))
+			c->object.flags |= INCOMPLETE;
+
+		if (c->object.flags & INCOMPLETE) {
+			is_incomplete = 1;
+			break;
+		}
+		else if (c->object.flags & SEEN)
+			continue;
+		for (parent = c->parents; parent; parent = parent->next) {
+			struct commit *p = parent->item;
+			if (p->object.flags & STUDYING)
+				continue;
+			p->object.flags |= STUDYING;
+			add_object_array(&p->object, NULL, &study);
+			add_object_array(&p->object, NULL, &found);
+		}
+	}
+	if (!is_incomplete) {
+		/*
+		 * make sure all commits in "found" array have all the
+		 * necessary objects.
+		 */
+		for (i = 0; i < found.nr; i++) {
+			struct commit *c =
+				(struct commit *)found.objects[i].item;
+			if (!tree_is_complete(get_commit_tree_oid(c))) {
+				is_incomplete = 1;
+				c->object.flags |= INCOMPLETE;
+			}
+		}
+		if (!is_incomplete) {
+			/* mark all found commits as complete, iow SEEN */
+			for (i = 0; i < found.nr; i++)
+				found.objects[i].item->flags |= SEEN;
+		}
+	}
+	/* clear flags from the objects we traversed */
+	for (i = 0; i < found.nr; i++)
+		found.objects[i].item->flags &= ~STUDYING;
+	if (is_incomplete)
+		commit->object.flags |= INCOMPLETE;
+	else {
+		/*
+		 * If we come here, we have (1) traversed the ancestry chain
+		 * from the "commit" until we reach SEEN commits (which are
+		 * known to be complete), and (2) made sure that the commits
+		 * encountered during the above traversal refer to trees that
+		 * are complete.  Which means that we know *all* the commits
+		 * we have seen during this process are complete.
+		 */
+		for (i = 0; i < found.nr; i++)
+			found.objects[i].item->flags |= SEEN;
+	}
+	/* free object arrays */
+	object_array_clear(&study);
+	object_array_clear(&found);
+	return !is_incomplete;
+}
+
+static int keep_entry(struct commit **it, struct object_id *oid)
+{
+	struct commit *commit;
+
+	if (is_null_oid(oid))
+		return 1;
+	commit = lookup_commit_reference_gently(the_repository, oid, 1);
+	if (!commit)
+		return 0;
+
+	/*
+	 * Make sure everything in this commit exists.
+	 *
+	 * We have walked all the objects reachable from the refs
+	 * and cache earlier.  The commits reachable by this commit
+	 * must meet SEEN commits -- and then we should mark them as
+	 * SEEN as well.
+	 */
+	if (!commit_is_complete(commit))
+		return 0;
+	*it = commit;
+	return 1;
+}
+
+/*
+ * Starting from commits in the cb->mark_list, mark commits that are
+ * reachable from them.  Stop the traversal at commits older than
+ * the expire_limit and queue them back, so that the caller can call
+ * us again to restart the traversal with longer expire_limit.
+ */
+static void mark_reachable(struct expire_reflog_policy_cb *cb)
+{
+	struct commit_list *pending;
+	timestamp_t expire_limit = cb->mark_limit;
+	struct commit_list *leftover = NULL;
+
+	for (pending = cb->mark_list; pending; pending = pending->next)
+		pending->item->object.flags &= ~REACHABLE;
+
+	pending = cb->mark_list;
+	while (pending) {
+		struct commit_list *parent;
+		struct commit *commit = pop_commit(&pending);
+		if (commit->object.flags & REACHABLE)
+			continue;
+		if (parse_commit(commit))
+			continue;
+		commit->object.flags |= REACHABLE;
+		if (commit->date < expire_limit) {
+			commit_list_insert(commit, &leftover);
+			continue;
+		}
+		commit->object.flags |= REACHABLE;
+		parent = commit->parents;
+		while (parent) {
+			commit = parent->item;
+			parent = parent->next;
+			if (commit->object.flags & REACHABLE)
+				continue;
+			commit_list_insert(commit, &pending);
+		}
+	}
+	cb->mark_list = leftover;
+}
+
+static int unreachable(struct expire_reflog_policy_cb *cb, struct commit *commit, struct object_id *oid)
+{
+	/*
+	 * We may or may not have the commit yet - if not, look it
+	 * up using the supplied sha1.
+	 */
+	if (!commit) {
+		if (is_null_oid(oid))
+			return 0;
+
+		commit = lookup_commit_reference_gently(the_repository, oid,
+							1);
+
+		/* Not a commit -- keep it */
+		if (!commit)
+			return 0;
+	}
+
+	/* Reachable from the current ref?  Don't prune. */
+	if (commit->object.flags & REACHABLE)
+		return 0;
+
+	if (cb->mark_list && cb->mark_limit) {
+		cb->mark_limit = 0; /* dig down to the root */
+		mark_reachable(cb);
+	}
+
+	return !(commit->object.flags & REACHABLE);
+}
+
+/*
+ * Return true iff the specified reflog entry should be expired.
+ */
+int should_expire_reflog_ent(struct object_id *ooid, struct object_id *noid,
+				    const char *email, timestamp_t timestamp, int tz,
+				    const char *message, void *cb_data)
+{
+	struct expire_reflog_policy_cb *cb = cb_data;
+	struct commit *old_commit, *new_commit;
+
+	if (timestamp < cb->cmd.expire_total)
+		return 1;
+
+	old_commit = new_commit = NULL;
+	if (cb->cmd.stalefix &&
+	    (!keep_entry(&old_commit, ooid) || !keep_entry(&new_commit, noid)))
+		return 1;
+
+	if (timestamp < cb->cmd.expire_unreachable) {
+		switch (cb->unreachable_expire_kind) {
+		case UE_ALWAYS:
+			return 1;
+		case UE_NORMAL:
+		case UE_HEAD:
+			if (unreachable(cb, old_commit, ooid) || unreachable(cb, new_commit, noid))
+				return 1;
+			break;
+		}
+	}
+
+	if (cb->cmd.recno && --(cb->cmd.recno) == 0)
+		return 1;
+
+	return 0;
+}
+
+int should_expire_reflog_ent_verbose(struct object_id *ooid,
+					    struct object_id *noid,
+					    const char *email,
+					    timestamp_t timestamp, int tz,
+					    const char *message, void *cb_data)
+{
+	struct expire_reflog_policy_cb *cb = cb_data;
+	int expire;
+
+	expire = should_expire_reflog_ent(ooid, noid, email, timestamp, tz,
+					  message, cb);
+
+	if (!expire)
+		printf("keep %s", message);
+	else if (cb->dry_run)
+		printf("would prune %s", message);
+	else
+		printf("prune %s", message);
+
+	return expire;
+}
+
+static int push_tip_to_list(const char *refname, const struct object_id *oid,
+			    int flags, void *cb_data)
+{
+	struct commit_list **list = cb_data;
+	struct commit *tip_commit;
+	if (flags & REF_ISSYMREF)
+		return 0;
+	tip_commit = lookup_commit_reference_gently(the_repository, oid, 1);
+	if (!tip_commit)
+		return 0;
+	commit_list_insert(tip_commit, list);
+	return 0;
+}
+
+static int is_head(const char *refname)
+{
+	switch (ref_type(refname)) {
+	case REF_TYPE_OTHER_PSEUDOREF:
+	case REF_TYPE_MAIN_PSEUDOREF:
+		if (parse_worktree_ref(refname, NULL, NULL, &refname))
+			BUG("not a worktree ref: %s", refname);
+		break;
+	default:
+		break;
+	}
+	return !strcmp(refname, "HEAD");
+}
+
+void reflog_expiry_prepare(const char *refname,
+				  const struct object_id *oid,
+				  void *cb_data)
+{
+	struct expire_reflog_policy_cb *cb = cb_data;
+	struct commit_list *elem;
+	struct commit *commit = NULL;
+
+	if (!cb->cmd.expire_unreachable || is_head(refname)) {
+		cb->unreachable_expire_kind = UE_HEAD;
+	} else {
+		commit = lookup_commit(the_repository, oid);
+		cb->unreachable_expire_kind = commit ? UE_NORMAL : UE_ALWAYS;
+	}
+
+	if (cb->cmd.expire_unreachable <= cb->cmd.expire_total)
+		cb->unreachable_expire_kind = UE_ALWAYS;
+
+	switch (cb->unreachable_expire_kind) {
+	case UE_ALWAYS:
+		return;
+	case UE_HEAD:
+		for_each_ref(push_tip_to_list, &cb->tips);
+		for (elem = cb->tips; elem; elem = elem->next)
+			commit_list_insert(elem->item, &cb->mark_list);
+		break;
+	case UE_NORMAL:
+		commit_list_insert(commit, &cb->mark_list);
+		/* For reflog_expiry_cleanup() below */
+		cb->tip_commit = commit;
+	}
+	cb->mark_limit = cb->cmd.expire_total;
+	mark_reachable(cb);
+}
+
+void reflog_expiry_cleanup(void *cb_data)
+{
+	struct expire_reflog_policy_cb *cb = cb_data;
+	struct commit_list *elem;
+
+	switch (cb->unreachable_expire_kind) {
+	case UE_ALWAYS:
+		return;
+	case UE_HEAD:
+		for (elem = cb->tips; elem; elem = elem->next)
+			clear_commit_marks(elem->item, REACHABLE);
+		free_commit_list(cb->tips);
+		break;
+	case UE_NORMAL:
+		clear_commit_marks(cb->tip_commit, REACHABLE);
+		break;
+	}
+}
+
+int count_reflog_ent(struct object_id *ooid, struct object_id *noid,
+		const char *email, timestamp_t timestamp, int tz,
+		const char *message, void *cb_data)
+{
+	struct cmd_reflog_expire_cb *cb = cb_data;
+	if (!cb->expire_total || timestamp < cb->expire_total)
+		cb->recno++;
+	return 0;
+}
+
+int reflog_delete(const char *rev, int flags, int verbose)
+{
+	struct cmd_reflog_expire_cb cmd = { 0 };
+	int status = 0;
+	reflog_expiry_should_prune_fn *should_prune_fn = should_expire_reflog_ent;
+	const char *spec = strstr(rev, "@{");
+	char *ep, *ref;
+	int recno;
+	struct expire_reflog_policy_cb cb = {
+		.dry_run = !!(flags & EXPIRE_REFLOGS_DRY_RUN),
+	};
+
+	if (verbose)
+		should_prune_fn = should_expire_reflog_ent_verbose;
+
+	if (!spec) {
+		status |= error(_("not a reflog: %s"), rev);
+	}
+
+	if (!dwim_log(rev, spec - rev, NULL, &ref)) {
+		status |= error(_("no reflog for '%s'"), rev);
+	}
+
+	if (status)
+		return status;
+
+	recno = strtoul(spec + 2, &ep, 10);
+	if (*ep == '}') {
+		cmd.recno = -recno;
+		for_each_reflog_ent(ref, count_reflog_ent, &cmd);
+	} else {
+		cmd.expire_total = approxidate(spec + 2);
+		for_each_reflog_ent(ref, count_reflog_ent, &cmd);
+		cmd.expire_total = 0;
+	}
+
+	cb.cmd = cmd;
+	status |= reflog_expire(ref, flags,
+				reflog_expiry_prepare,
+				should_prune_fn,
+				reflog_expiry_cleanup,
+				&cb);
+	free(ref);
+
+	return status;
+}
diff --git a/reflog.h b/reflog.h
new file mode 100644
index 00000000000..e4a8a104f45
--- /dev/null
+++ b/reflog.h
@@ -0,0 +1,49 @@
+#ifndef REFLOG_H
+#define REFLOG_H
+
+#include "cache.h"
+#include "commit.h"
+
+/* Remember to update object flag allocation in object.h */
+#define INCOMPLETE	(1u<<10)
+#define STUDYING	(1u<<11)
+#define REACHABLE	(1u<<12)
+
+struct cmd_reflog_expire_cb {
+	int stalefix;
+	int explicit_expiry;
+	timestamp_t expire_total;
+	timestamp_t expire_unreachable;
+	int recno;
+};
+
+struct expire_reflog_policy_cb {
+	enum {
+		UE_NORMAL,
+		UE_ALWAYS,
+		UE_HEAD
+	} unreachable_expire_kind;
+	struct commit_list *mark_list;
+	unsigned long mark_limit;
+	struct cmd_reflog_expire_cb cmd;
+	struct commit *tip_commit;
+	struct commit_list *tips;
+	unsigned int dry_run:1;
+};
+
+int reflog_delete(const char*, int, int);
+void reflog_expiry_cleanup(void *);
+void reflog_expiry_prepare(const char*, const struct object_id*,
+			   void *);
+int should_expire_reflog_ent(struct object_id *, struct object_id*,
+				    const char *, timestamp_t, int,
+				    const char *, void *);
+int count_reflog_ent(struct object_id *ooid, struct object_id *noid,
+		const char *email, timestamp_t timestamp, int tz,
+		const char *message, void *cb_data);
+int should_expire_reflog_ent_verbose(struct object_id *,
+				     struct object_id *,
+				     const char *,
+				     timestamp_t, int,
+				     const char *, void *);
+#endif /* REFLOG_H */
-- 
gitgitgadget

