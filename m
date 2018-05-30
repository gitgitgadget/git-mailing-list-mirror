Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E2051F42D
	for <e@80x24.org>; Wed, 30 May 2018 00:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968490AbeE3AuI (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 20:50:08 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:39392 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968387AbeE3Ast (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 20:48:49 -0400
Received: by mail-pf0-f195.google.com with SMTP id r11-v6so539620pfl.6
        for <git@vger.kernel.org>; Tue, 29 May 2018 17:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bqMLCY5nrqskP+qzIl+krD0h6GWCjTVHTe8maelVsis=;
        b=M0oez1h0k4g1GppGukyS9dnSJLB18LWB/0Rz/4uAeEPPbI2mnb6wvWN2CvD6A34Q9c
         RPBiTrllHNsHvylR+87BFxtbOLxXWvSH3TPNNNF26j0kZtMLXm2FAl7Jqs1e2R8/Q1cF
         U3Y6E9k8tQoagidbZs9YKIMRVmGp/ECBWyHVDy21hBO/qbprhU+lfgWNJMwJJ/88uYuK
         MUJ+HyqJWMzuC5IQ8kljZeCJBXUzxNP9TbrNWvzKqEk4d7xNJ7b1k34t5Qwp0AagrPyu
         khk0CBCp7z/jvU1iFRGbg2jEei+GoE/O3EwihaHkzYjnJ4wUtPzykeKRVVy/xVVHcAhD
         j6VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bqMLCY5nrqskP+qzIl+krD0h6GWCjTVHTe8maelVsis=;
        b=qBawqhoFLf5rAM3nu57146I71nMVbgWGl55fAfsKMDvHEWErtQkk/RVBfFjUsYBbKh
         ElFkrbpXdLyCzS7IFwnie4aakmTG2g1boQsL3txKlEQdBcUhj51zdpU/97NdkD4iEznI
         A+tmuQtd6HVKJA7UX4DiLYT/yuY4shtTy8vG8e0QqZ6fmEiqDB+UrUkJC1GdFhbeFjVI
         2lyvSJTzv0X0vEH+ILVvAae4Zi839svqgS74oiOAxsn22hYDBF8ELqOiGx2rsGIS7gbc
         kgU0mnTNIzzGtusRw8wG23H26W45scR3V22TBGWRT1PhA8B5lp1OFpgeP9bPoWK+WHS1
         3low==
X-Gm-Message-State: ALKqPwfF5wTJi7tsid9TxR85Fr8nzIkZBseKDGLpICj47KbsoLTtjjyF
        cBjYydRenQpG8nepdri4CwEJltD9Cys=
X-Google-Smtp-Source: ADUXVKJagxDss6YGoiJlk5iPOATg4I6t1YILzlfDSMgqqh9yQBiUdmka2U3AlT2orxSDYhL7F3443g==
X-Received: by 2002:a63:70a:: with SMTP id 10-v6mr501670pgh.216.1527641327823;
        Tue, 29 May 2018 17:48:47 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id r79-v6sm13362501pfe.115.2018.05.29.17.48.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 May 2018 17:48:47 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 18/35] commit: add repository argument to parse_commit
Date:   Tue, 29 May 2018 17:47:53 -0700
Message-Id: <20180530004810.30076-19-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180530004810.30076-1-sbeller@google.com>
References: <20180530004810.30076-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow callers of parse_commit to
be more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 blame.c               |  4 ++--
 builtin/checkout.c    |  4 ++--
 builtin/commit.c      |  2 +-
 builtin/describe.c    |  4 ++--
 builtin/merge-base.c  |  2 +-
 builtin/name-rev.c    |  2 +-
 builtin/notes.c       |  2 +-
 builtin/reflog.c      |  2 +-
 builtin/show-branch.c |  4 ++--
 commit-graph.c        |  6 +++---
 commit.c              | 18 +++++++++---------
 commit.h              |  3 ++-
 fetch-pack.c          |  6 +++---
 fsck.c                |  2 +-
 merge-recursive.c     |  4 ++--
 notes-utils.c         |  2 +-
 remote.c              |  2 +-
 revision.c            |  7 +++----
 sequencer.c           | 16 ++++++++--------
 sha1-name.c           |  4 ++--
 shallow.c             |  4 ++--
 tree.c                |  2 +-
 walker.c              |  2 +-
 23 files changed, 52 insertions(+), 52 deletions(-)

diff --git a/blame.c b/blame.c
index aad53c0f904..c82922506cc 100644
--- a/blame.c
+++ b/blame.c
@@ -1451,7 +1451,7 @@ static void pass_blame(struct blame_scoreboard *sb, struct blame_origin *origin,
 
 			if (sg_origin[i])
 				continue;
-			if (parse_commit(p))
+			if (parse_commit(the_repository, p))
 				continue;
 			porigin = find(p, origin);
 			if (!porigin)
@@ -1590,7 +1590,7 @@ void assign_blame(struct blame_scoreboard *sb, int opt)
 		 * so hold onto it in the meantime.
 		 */
 		blame_origin_incref(suspect);
-		parse_commit(commit);
+		parse_commit(the_repository, commit);
 		if (sb->reverse ||
 		    (!(commit->object.flags & UNINTERESTING) &&
 		     !(revs->max_age != -1 && commit->date < revs->max_age)))
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 31a71f75625..cf93a6e913d 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -402,7 +402,7 @@ static void describe_detached_head(const char *msg, struct commit *commit)
 {
 	struct strbuf sb = STRBUF_INIT;
 
-	if (!parse_commit(commit))
+	if (!parse_commit(the_repository, commit))
 		pp_commit_easy(CMIT_FMT_ONELINE, commit, &sb);
 	if (print_sha1_ellipsis()) {
 		fprintf(stderr, "%s %s... %s\n", msg,
@@ -723,7 +723,7 @@ static void describe_one_orphan(struct strbuf *sb, struct commit *commit)
 	strbuf_addstr(sb, "  ");
 	strbuf_add_unique_abbrev(sb, &commit->object.oid, DEFAULT_ABBREV);
 	strbuf_addch(sb, ' ');
-	if (!parse_commit(commit))
+	if (!parse_commit(the_repository, commit))
 		pp_commit_easy(CMIT_FMT_ONELINE, commit, sb);
 	strbuf_addch(sb, '\n');
 }
diff --git a/builtin/commit.c b/builtin/commit.c
index b6d130b8ff3..4957099080e 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1482,7 +1482,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		current_head = NULL;
 	else {
 		current_head = lookup_commit_or_die(&oid, "HEAD");
-		if (parse_commit(current_head))
+		if (parse_commit(the_repository, current_head))
 			die(_("could not parse HEAD commit"));
 	}
 	verbose = -1; /* unspecified */
diff --git a/builtin/describe.c b/builtin/describe.c
index 6fb713b6be1..7e4481947c1 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -254,7 +254,7 @@ static unsigned long finish_depth_computation(
 			best->depth++;
 		while (parents) {
 			struct commit *p = parents->item;
-			parse_commit(p);
+			parse_commit(the_repository, p);
 			if (!(p->object.flags & SEEN))
 				commit_list_insert_by_date(p, list);
 			p->object.flags |= c->object.flags;
@@ -381,7 +381,7 @@ static void describe_commit(struct object_id *oid, struct strbuf *dst)
 		}
 		while (parents) {
 			struct commit *p = parents->item;
-			parse_commit(p);
+			parse_commit(the_repository, p);
 			if (!(p->object.flags & SEEN))
 				commit_list_insert_by_date(p, &list);
 			p->object.flags |= c->object.flags;
diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index 08d91b1f0c0..426882818c8 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -127,7 +127,7 @@ static void add_one_commit(struct object_id *oid, struct rev_collect *revs)
 	commit = lookup_commit(the_repository, oid);
 	if (!commit ||
 	    (commit->object.flags & TMP_MARK) ||
-	    parse_commit(commit))
+	    parse_commit(the_repository, commit))
 		return;
 
 	ALLOC_GROW(revs->commit, revs->nr + 1, revs->alloc);
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index f1cb45c2274..bdeb3027179 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -87,7 +87,7 @@ static void name_rev(struct commit *commit,
 	int parent_number = 1;
 	char *to_free = NULL;
 
-	parse_commit(commit);
+	parse_commit(the_repository, commit);
 
 	if (commit->date < cutoff)
 		return;
diff --git a/builtin/notes.c b/builtin/notes.c
index 50963642075..0c558ab0702 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -714,7 +714,7 @@ static int merge_commit(struct notes_merge_options *o)
 		die(_("failed to read ref NOTES_MERGE_PARTIAL"));
 	else if (!(partial = lookup_commit_reference(the_repository, &oid)))
 		die(_("could not find commit from NOTES_MERGE_PARTIAL."));
-	else if (parse_commit(partial))
+	else if (parse_commit(the_repository, partial))
 		die(_("could not parse commit from NOTES_MERGE_PARTIAL."));
 
 	if (partial->parents)
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 6ff3c5abff0..c4e0ee7caad 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -235,7 +235,7 @@ static void mark_reachable(struct expire_reflog_policy_cb *cb)
 		struct commit *commit = pop_commit(&pending);
 		if (commit->object.flags & REACHABLE)
 			continue;
-		if (parse_commit(commit))
+		if (parse_commit(the_repository, commit))
 			continue;
 		commit->object.flags |= REACHABLE;
 		if (commit->date < expire_limit) {
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 4b9d3c0059b..98fb2cc2da3 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -238,7 +238,7 @@ static void join_revs(struct commit_list **list_p,
 			parents = parents->next;
 			if ((this_flag & flags) == flags)
 				continue;
-			parse_commit(p);
+			parse_commit(the_repository, p);
 			if (mark_seen(p, seen_p) && !still_interesting)
 				extra--;
 			p->object.flags |= flags;
@@ -835,7 +835,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 		if (!commit)
 			die(_("cannot find commit %s (%s)"),
 			    ref_name[num_rev], oid_to_hex(&revkey));
-		parse_commit(commit);
+		parse_commit(the_repository, commit);
 		mark_seen(commit, &seen);
 
 		/* rev#0 uses bit REV_SHIFT, rev#1 uses bit REV_SHIFT+1,
diff --git a/commit-graph.c b/commit-graph.c
index 6c08fc0a9ba..0e91d8f7139 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -371,7 +371,7 @@ static void write_graph_chunk_data(struct hashfile *f, int hash_len,
 		int edge_value;
 		uint32_t packedDate[2];
 
-		parse_commit(*list);
+		parse_commit(the_repository, *list);
 		hashwrite(f, (*list)->tree->object.oid.hash, hash_len);
 
 		parent = (*list)->parents;
@@ -540,7 +540,7 @@ static void close_reachable(struct packed_oid_list *oids)
 	for (i = 0; i < oids->nr; i++) {
 		commit = lookup_commit(the_repository, &oids->list[i]);
 
-		if (commit && !parse_commit(commit))
+		if (commit && !parse_commit(the_repository, commit))
 			add_missing_parents(oids, commit);
 	}
 
@@ -659,7 +659,7 @@ void write_commit_graph(const char *obj_dir,
 			continue;
 
 		commits.list[commits.nr] = lookup_commit(the_repository, &oids.list[i]);
-		parse_commit(commits.list[commits.nr]);
+		parse_commit(the_repository, commits.list[commits.nr]);
 
 		for (parent = commits.list[commits.nr]->parents;
 		     parent; parent = parent->next)
diff --git a/commit.c b/commit.c
index dcb32561275..8e7dfafe850 100644
--- a/commit.c
+++ b/commit.c
@@ -69,7 +69,7 @@ struct commit *lookup_commit_reference_by_name(const char *name)
 	if (get_oid_committish(name, &oid))
 		return NULL;
 	commit = lookup_commit_reference(the_repository, &oid);
-	if (parse_commit(commit))
+	if (parse_commit(the_repository, commit))
 		return NULL;
 	return commit;
 }
@@ -428,7 +428,7 @@ int parse_commit_gently_the_repository(struct commit *item, int quiet_on_missing
 
 void parse_commit_or_die(struct commit *item)
 {
-	if (parse_commit(item))
+	if (parse_commit(the_repository, item))
 		die("unable to parse commit %s",
 		    item ? oid_to_hex(&item->object.oid) : "(null)");
 }
@@ -533,7 +533,7 @@ struct commit *pop_most_recent_commit(struct commit_list **list,
 
 	while (parents) {
 		struct commit *commit = parents->item;
-		if (!parse_commit(commit) && !(commit->object.flags & mark)) {
+		if (!parse_commit(the_repository, commit) && !(commit->object.flags & mark)) {
 			commit->object.flags |= mark;
 			commit_list_insert_by_date(commit, list);
 		}
@@ -830,7 +830,7 @@ static struct commit_list *paint_down_to_common(struct commit *one, int n, struc
 			parents = parents->next;
 			if ((p->object.flags & flags) == flags)
 				continue;
-			if (parse_commit(p))
+			if (parse_commit(the_repository, p))
 				return NULL;
 			p->object.flags |= flags;
 			prio_queue_put(&queue, p);
@@ -856,10 +856,10 @@ static struct commit_list *merge_bases_many(struct commit *one, int n, struct co
 			return commit_list_insert(one, &result);
 	}
 
-	if (parse_commit(one))
+	if (parse_commit(the_repository, one))
 		return NULL;
 	for (i = 0; i < n; i++) {
-		if (parse_commit(twos[i]))
+		if (parse_commit(the_repository, twos[i]))
 			return NULL;
 	}
 
@@ -918,7 +918,7 @@ static int remove_redundant(struct commit **array, int cnt)
 	ALLOC_ARRAY(filled_index, cnt - 1);
 
 	for (i = 0; i < cnt; i++)
-		parse_commit(array[i]);
+		parse_commit(the_repository, array[i]);
 	for (i = 0; i < cnt; i++) {
 		struct commit_list *common;
 
@@ -1041,10 +1041,10 @@ int in_merge_bases_many(struct commit *commit, int nr_reference, struct commit *
 	struct commit_list *bases;
 	int ret = 0, i;
 
-	if (parse_commit(commit))
+	if (parse_commit(the_repository, commit))
 		return ret;
 	for (i = 0; i < nr_reference; i++)
-		if (parse_commit(reference[i]))
+		if (parse_commit(the_repository, reference[i]))
 			return ret;
 
 	bases = paint_down_to_common(commit, nr_reference, reference);
diff --git a/commit.h b/commit.h
index b1198ec2b77..c4d3033dc12 100644
--- a/commit.h
+++ b/commit.h
@@ -76,7 +76,8 @@ struct commit *lookup_commit_or_die(const struct object_id *oid, const char *ref
 int parse_commit_buffer_the_repository(struct commit *item, const void *buffer, unsigned long size);
 #define parse_commit_gently(r, i, q) parse_commit_gently_##r(i, q)
 int parse_commit_gently_the_repository(struct commit *item, int quiet_on_missing);
-static inline int parse_commit(struct commit *item)
+#define parse_commit(r, i) parse_commit_##r(i)
+static inline int parse_commit_the_repository(struct commit *item)
 {
 	return parse_commit_gently(the_repository, item, 0);
 }
diff --git a/fetch-pack.c b/fetch-pack.c
index 358d8421a8f..b551a7d921b 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -114,7 +114,7 @@ static void rev_list_push(struct commit *commit, int mark)
 	if (!(commit->object.flags & mark)) {
 		commit->object.flags |= mark;
 
-		if (parse_commit(commit))
+		if (parse_commit(the_repository, commit))
 			return;
 
 		prio_queue_put(&rev_list, commit);
@@ -178,7 +178,7 @@ static void mark_common(struct commit *commit,
 			if (!ancestors_only && !(o->flags & POPPED))
 				non_common_revs--;
 			if (!o->parsed && !dont_parse)
-				if (parse_commit(commit))
+				if (parse_commit(the_repository, commit))
 					return;
 
 			for (parents = commit->parents;
@@ -205,7 +205,7 @@ static const struct object_id *get_rev(void)
 			return NULL;
 
 		commit = prio_queue_get(&rev_list);
-		parse_commit(commit);
+		parse_commit(the_repository, commit);
 		parents = commit->parents;
 
 		commit->object.flags |= POPPED;
diff --git a/fsck.c b/fsck.c
index b07abb9796c..e8387e015c8 100644
--- a/fsck.c
+++ b/fsck.c
@@ -393,7 +393,7 @@ static int fsck_walk_commit(struct commit *commit, void *data, struct fsck_optio
 	int result;
 	const char *name;
 
-	if (parse_commit(commit))
+	if (parse_commit(the_repository, commit))
 		return -1;
 
 	name = get_object_name(options, &commit->object);
diff --git a/merge-recursive.c b/merge-recursive.c
index 9013aabed9a..bdbaff45fcf 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -236,7 +236,7 @@ static void output_commit_title(struct merge_options *o, struct commit *commit)
 		strbuf_add_unique_abbrev(&o->obuf, &commit->object.oid,
 					 DEFAULT_ABBREV);
 		strbuf_addch(&o->obuf, ' ');
-		if (parse_commit(commit) != 0)
+		if (parse_commit(the_repository, commit) != 0)
 			strbuf_addstr(&o->obuf, _("(bad commit)\n"));
 		else {
 			const char *title;
@@ -2193,7 +2193,7 @@ static struct commit *get_ref(const struct object_id *oid, const char *name)
 		return make_virtual_commit((struct tree*)object, name);
 	if (object->type != OBJ_COMMIT)
 		return NULL;
-	if (parse_commit((struct commit *)object))
+	if (parse_commit(the_repository, (struct commit *)object))
 		return NULL;
 	return (struct commit *)object;
 }
diff --git a/notes-utils.c b/notes-utils.c
index 14ea03178e9..8441ec46199 100644
--- a/notes-utils.c
+++ b/notes-utils.c
@@ -22,7 +22,7 @@ void create_notes_commit(struct notes_tree *t, struct commit_list *parents,
 		if (!read_ref(t->ref, &parent_oid)) {
 			struct commit *parent = lookup_commit(the_repository,
 							      &parent_oid);
-			if (parse_commit(parent))
+			if (parse_commit(the_repository, parent))
 				die("Failed to find/parse commit %s", t->ref);
 			commit_list_insert(parent, &parents);
 		}
diff --git a/remote.c b/remote.c
index 0bf5ce3e7ba..83a3d3ef649 100644
--- a/remote.c
+++ b/remote.c
@@ -2007,7 +2007,7 @@ int ref_newer(const struct object_id *new_oid, const struct object_id *old_oid)
 		return 0;
 	new_commit = (struct commit *) o;
 
-	if (parse_commit(new_commit) < 0)
+	if (parse_commit(the_repository, new_commit) < 0)
 		return 0;
 
 	used = list = NULL;
diff --git a/revision.c b/revision.c
index 33506faabda..6a3a73cc4ce 100644
--- a/revision.c
+++ b/revision.c
@@ -258,8 +258,7 @@ static struct commit *handle_commit(struct rev_info *revs,
 	 */
 	if (object->type == OBJ_COMMIT) {
 		struct commit *commit = (struct commit *)object;
-
-		if (parse_commit(commit) < 0)
+		if (parse_commit(the_repository, commit) < 0)
 			die("unable to parse commit %s", name);
 		if (flags & UNINTERESTING) {
 			mark_parents_uninteresting(commit);
@@ -673,7 +672,7 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 					ts->treesame[0] = 1;
 			}
 		}
-		if (parse_commit(p) < 0)
+		if (parse_commit(the_repository, p) < 0)
 			die("cannot simplify commit %s (because of %s)",
 			    oid_to_hex(&commit->object.oid),
 			    oid_to_hex(&p->object.oid));
@@ -706,7 +705,7 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 				 * IOW, we pretend this parent is a
 				 * "root" commit.
 				 */
-				if (parse_commit(p) < 0)
+				if (parse_commit(the_repository, p) < 0)
 					die("cannot simplify commit %s (invalid %s)",
 					    oid_to_hex(&commit->object.oid),
 					    oid_to_hex(&p->object.oid));
diff --git a/sequencer.c b/sequencer.c
index da6c9fc5511..d8ba41dc0c8 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -553,7 +553,7 @@ static int is_index_unchanged(void)
 	 * the commit is invalid, parse_commit() will complain.  So
 	 * there is nothing for us to say here.  Just return failure.
 	 */
-	if (parse_commit(head_commit))
+	if (parse_commit(the_repository, head_commit))
 		return -1;
 
 	if (!active_cache_tree)
@@ -975,7 +975,7 @@ void print_commit_summary(const char *prefix, const struct object_id *oid,
 	commit = lookup_commit(the_repository, oid);
 	if (!commit)
 		die(_("couldn't look up newly created commit"));
-	if (parse_commit(commit))
+	if (parse_commit(the_repository, commit))
 		die(_("could not parse newly created commit"));
 
 	strbuf_addstr(&format, "format:%h] %s");
@@ -1054,7 +1054,7 @@ static int parse_head(struct commit **head)
 			warning(_("HEAD %s is not a commit!"),
 				oid_to_hex(&oid));
 		}
-		if (parse_commit(current_head))
+		if (parse_commit(the_repository, current_head))
 			return error(_("could not parse HEAD commit"));
 	}
 	*head = current_head;
@@ -1213,12 +1213,12 @@ static int is_original_commit_empty(struct commit *commit)
 {
 	const struct object_id *ptree_oid;
 
-	if (parse_commit(commit))
+	if (parse_commit(the_repository, commit))
 		return error(_("could not parse commit %s"),
 			     oid_to_hex(&commit->object.oid));
 	if (commit->parents) {
 		struct commit *parent = commit->parents->item;
-		if (parse_commit(parent))
+		if (parse_commit(the_repository, parent))
 			return error(_("could not parse parent commit %s"),
 				oid_to_hex(&parent->object.oid));
 		ptree_oid = &parent->tree->object.oid;
@@ -1533,7 +1533,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 		msg_file = NULL;
 		goto fast_forward_edit;
 	}
-	if (parent && parse_commit(parent) < 0)
+	if (parent && parse_commit(the_repository, parent) < 0)
 		/* TRANSLATORS: The first %s will be a "todo" command like
 		   "revert" or "pick", the second %s a SHA1. */
 		return error(_("%s: cannot parse parent commit %s"),
@@ -3301,7 +3301,7 @@ int skip_unnecessary_picks(void)
 			continue;
 		if (item->command != TODO_PICK)
 			break;
-		if (parse_commit(item->commit)) {
+		if (parse_commit(the_repository, item->commit)) {
 			todo_list_release(&todo_list);
 			return error(_("could not parse commit '%s'"),
 				oid_to_hex(&item->commit->object.oid));
@@ -3429,7 +3429,7 @@ int rearrange_squash(void)
 
 		*commit_todo_item_at(&commit_todo, item->commit) = item;
 
-		parse_commit(item->commit);
+		parse_commit(the_repository, item->commit);
 		commit_buffer = get_commit_buffer(item->commit, NULL);
 		find_commit_subject(commit_buffer, &subject);
 		format_subject(&buf, subject, " ");
diff --git a/sha1-name.c b/sha1-name.c
index 27cf9cd916e..618fd1569f1 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -813,7 +813,7 @@ static int get_parent(const char *name, int len,
 	if (ret)
 		return ret;
 	commit = lookup_commit_reference(the_repository, &oid);
-	if (parse_commit(commit))
+	if (parse_commit(the_repository, commit))
 		return -1;
 	if (!idx) {
 		oidcpy(result, &commit->object.oid);
@@ -845,7 +845,7 @@ static int get_nth_ancestor(const char *name, int len,
 		return -1;
 
 	while (generation--) {
-		if (parse_commit(commit) || !commit->parents)
+		if (parse_commit(the_repository, commit) || !commit->parents)
 			return -1;
 		commit = commit->parents->item;
 	}
diff --git a/shallow.c b/shallow.c
index c65cb17195e..91d8da1917d 100644
--- a/shallow.c
+++ b/shallow.c
@@ -207,7 +207,7 @@ struct commit_list *get_shallow_commits_by_rev_list(int ac, const char **av,
 		struct commit *c = p->item;
 		struct commit_list *parent;
 
-		if (parse_commit(c))
+		if (parse_commit(the_repository, c))
 			die("unable to parse commit %s",
 			    oid_to_hex(&c->object.oid));
 
@@ -530,7 +530,7 @@ static void paint_down(struct paint_info *info, const struct object_id *oid,
 		if (c->object.flags & BOTTOM)
 			continue;
 
-		if (parse_commit(c))
+		if (parse_commit(the_repository, c))
 			die("unable to parse commit %s",
 			    oid_to_hex(&c->object.oid));
 
diff --git a/tree.c b/tree.c
index 33063b8dde0..6b83942e444 100644
--- a/tree.c
+++ b/tree.c
@@ -107,7 +107,7 @@ static int read_tree_1(struct tree *tree, struct strbuf *base,
 				    oid_to_hex(entry.oid),
 				    base->buf, entry.path);
 
-			if (parse_commit(commit))
+			if (parse_commit(the_repository, commit))
 				die("Invalid commit %s in submodule path %s%s",
 				    oid_to_hex(entry.oid),
 				    base->buf, entry.path);
diff --git a/walker.c b/walker.c
index c7c9db83df7..314f56e61ce 100644
--- a/walker.c
+++ b/walker.c
@@ -78,7 +78,7 @@ static int process_commit(struct walker *walker, struct commit *commit)
 {
 	struct commit_list *parents;
 
-	if (parse_commit(commit))
+	if (parse_commit(the_repository, commit))
 		return -1;
 
 	while (complete && complete->item->date >= commit->date) {
-- 
2.17.0.582.gccdcbd54c44.dirty

