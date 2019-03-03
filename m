Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9128520248
	for <e@80x24.org>; Sun,  3 Mar 2019 10:37:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbfCCKh4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 05:37:56 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:32889 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfCCKh4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Mar 2019 05:37:56 -0500
Received: by mail-ed1-f67.google.com with SMTP id c55so1872781edb.0
        for <git@vger.kernel.org>; Sun, 03 Mar 2019 02:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=vr2hJxP9axuImoeEqVTLVbQGiGSrzM9F1JJ/oNwJgIk=;
        b=Y03ctp6J9FS7kKKOKA8oGSljNtFJHAMRr0mvD2wK2gkRKWNc1t2lMIvweWdaI0s4YM
         6MRV9pV/78yom43RorphBIJwiuWe04QyP+b0CnPn/K6q4k9Sl+ZrSBbFDcNTlXSDrGmP
         bRHJHj5eqgyDSZSGHUth/MTnyS1dOoUfYXEVxnt4Frdqe0sfCEHeCMxGqP7t3pBt7Uw7
         TVZ94eYIlfmImPxgIHfDd9rszBV+VK8vIK+Jazw7GH7Kwth1r+JgbtOiybartY3Ifako
         dQDhR6W6hWvYpkakjaz5pM4E2xrp0P9fEF93UAGaEK/ULCyw9vMFRgbINjof1Q88DjPp
         Clqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vr2hJxP9axuImoeEqVTLVbQGiGSrzM9F1JJ/oNwJgIk=;
        b=c4Fs+T8XIqnqejBXILC7+TSFB5UaLjZTHPoXqLlptjsFoUdKowKlil2aMGmqqgIPyv
         Du91xxSiY9A4ZtwjpTZ0gMbUmyOvLI4Ct5LHJR46HTvFDO1jJb+i2Nh23FxEMUa8qMS8
         dO5VBnZtEIDhqnkvr+ti1MoqulnOHvIDtP5i2kw/qtFxrGqK2STfV6dgGm1GpYHn0q4R
         ujv+DeHIUfILqA2/eCL6k7CAGl1Pa0Ky/cgAlWFr0SVP9z4PxN+Q0sxLmuX0CpkVfJNe
         PN+6Uchu4tvTOjZj8TU0DgYFYEfmDjoM6nTiA/sPeMgFhwuQWVaU2/CtO7JkkHRYIdwk
         SLGg==
X-Gm-Message-State: APjAAAVfM5CwecZE1aNU2RPH3BTWY6ZLr6KvHNZG6E6xnWiNsl7lKm0B
        8W2grfGt3efWYvcNzCYORaOXamx5
X-Google-Smtp-Source: APXvYqyUb+QCNdxATDPfBAiz+bm3lqiYECwH9cUnQyZRQzUsc+tKimRleLIK2ly998qdq+90VtH93Q==
X-Received: by 2002:a17:906:c286:: with SMTP id r6mr9117878ejz.7.1551609473796;
        Sun, 03 Mar 2019 02:37:53 -0800 (PST)
Received: from poppybee.home ([77.172.207.196])
        by smtp.gmail.com with ESMTPSA id h8sm1143681edk.21.2019.03.03.02.37.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 02:37:52 -0800 (PST)
From:   Micha Nelissen <nelissen.micha@gmail.com>
To:     git@vger.kernel.org
Cc:     Micha Nelissen <nelissen.micha@gmail.com>
Subject: [PATCH 1/1] Add feature to show log as a tree
Date:   Sun,  3 Mar 2019 11:37:51 +0100
Message-Id: <20190303103751.6523-1-nelissen.micha@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Modifies the topo-order code to keep track of the first child,
using a heuristic. The heuristic works by assigning a (depth)
level to all nodes. The first child is the node of which this
node is a parent of and has the lowest level. Then it cuts all
the links that are not the first child, resulting in a tree.

It also uses the level to sort the nodes: trying to keep
descendent line (of a merge) together as a group.

Add commandline option "--tree" to use this new feature.

Signed-off-by: Micha Nelissen <nelissen.micha@gmail.com>
---
 commit.c   | 136 +++++++++++++++++++++++++++++++++++++++++++++++------
 commit.h   |   1 +
 revision.c |   4 ++
 3 files changed, 127 insertions(+), 14 deletions(-)

diff --git commit.c commit.c
index a5333c7ac6..340757adc2 100644
--- commit.c
+++ commit.c
@@ -662,7 +662,12 @@ struct commit *pop_commit(struct commit_list **stack)
  */
 
 /* count number of children that have not been emitted */
-define_commit_slab(indegree_slab, int);
+struct indegree {
+	unsigned short indegree;
+	unsigned short level;	  /* first level this commit has been seen at */
+};
+define_commit_slab(indegree_slab, struct indegree);
+define_commit_slab(first_child_slab, struct commit *);
 
 define_commit_slab(author_date_slab, timestamp_t);
 
@@ -708,6 +713,22 @@ int compare_commits_by_author_date(const void *a_, const void *b_,
 	return 0;
 }
 
+static int compare_commits_by_tree_level(const void *a_, const void *b_,
+					 void *cb_data)
+{
+	const struct commit *a = a_, *b = b_;
+	struct indegree_slab *indegree = cb_data;
+	unsigned short a_level = indegree_slab_at(indegree, a)->level;
+	unsigned short b_level = indegree_slab_at(indegree, b)->level;
+
+	/* deepest tree level commits first */
+	if (a_level < b_level)
+		return 1;
+	else if (a_level > b_level)
+		return -1;
+	return 0;
+}
+
 int compare_commits_by_gen_then_commit_date(const void *a_, const void *b_, void *unused)
 {
 	const struct commit *a = a_, *b = b_;
@@ -745,6 +766,7 @@ void sort_in_topological_order(struct commit_list **list, enum rev_sort_order so
 	struct commit_list *next, *orig = *list;
 	struct commit_list **pptr;
 	struct indegree_slab indegree;
+	struct first_child_slab first_child;
 	struct prio_queue queue;
 	struct commit *commit;
 	struct author_date_slab author_date;
@@ -760,6 +782,11 @@ void sort_in_topological_order(struct commit_list **list, enum rev_sort_order so
 	default: /* REV_SORT_IN_GRAPH_ORDER */
 		queue.compare = NULL;
 		break;
+	case REV_SORT_IN_TREE_ORDER:
+		init_first_child_slab(&first_child);
+		queue.compare = compare_commits_by_tree_level;
+		queue.cb_data = &indegree;
+		break;
 	case REV_SORT_BY_COMMIT_DATE:
 		queue.compare = compare_commits_by_commit_date;
 		break;
@@ -773,7 +800,8 @@ void sort_in_topological_order(struct commit_list **list, enum rev_sort_order so
 	/* Mark them and clear the indegree */
 	for (next = orig; next; next = next->next) {
 		struct commit *commit = next->item;
-		*(indegree_slab_at(&indegree, commit)) = 1;
+		struct indegree *pi = indegree_slab_at(&indegree, commit);
+		pi->indegree = 0, pi->level = 0;
 		/* also record the author dates, if needed */
 		if (sort_order == REV_SORT_BY_AUTHOR_DATE)
 			record_author_date(&author_date, commit);
@@ -782,13 +810,12 @@ void sort_in_topological_order(struct commit_list **list, enum rev_sort_order so
 	/* update the indegree */
 	for (next = orig; next; next = next->next) {
 		struct commit_list *parents = next->item->parents;
-		while (parents) {
+		for (; parents; parents = parents->next) {
 			struct commit *parent = parents->item;
-			int *pi = indegree_slab_at(&indegree, parent);
-
-			if (*pi)
-				(*pi)++;
-			parents = parents->next;
+			struct indegree *pi = indegree_slab_peek(&indegree, parent);
+			if (!pi)
+				continue;
+			pi->indegree++;
 		}
 	}
 
@@ -801,9 +828,12 @@ void sort_in_topological_order(struct commit_list **list, enum rev_sort_order so
 	 */
 	for (next = orig; next; next = next->next) {
 		struct commit *commit = next->item;
+		struct indegree *pi = indegree_slab_at(&indegree, commit);
 
-		if (*(indegree_slab_at(&indegree, commit)) == 1)
+		if (pi->indegree == 0) {
+			pi->level = 1;
 			prio_queue_put(&queue, commit);
+		}
 	}
 
 	/*
@@ -820,31 +850,109 @@ void sort_in_topological_order(struct commit_list **list, enum rev_sort_order so
 	*list = NULL;
 	while ((commit = prio_queue_get(&queue)) != NULL) {
 		struct commit_list *parents;
+		unsigned short commit_level, parent_level;
+		commit_level = parent_level = indegree_slab_at(&indegree, commit)->level;
 
-		for (parents = commit->parents; parents ; parents = parents->next) {
+		for (parents = commit->parents; parents; parents = parents->next) {
 			struct commit *parent = parents->item;
-			int *pi = indegree_slab_at(&indegree, parent);
+			struct indegree *pi = indegree_slab_peek(&indegree, parent);
 
-			if (!*pi)
+			if (!pi)
 				continue;
 
+			if (sort_order == REV_SORT_IN_TREE_ORDER) {
+				struct commit **pfirst_child =
+					first_child_slab_at(&first_child, parent);
+				if (*pfirst_child != NULL) {
+					/* already set a first child, if it is from higher
+					   level than we are, set ourselves as first */
+					struct indegree *old_pi =
+						indegree_slab_at(&indegree, *pfirst_child);
+					if (old_pi->level >= commit_level)
+						*pfirst_child = NULL;
+				}
+				if (*pfirst_child == NULL)
+					*pfirst_child = commit;
+
+				if (!pi->level || parent_level < pi->level) {
+					struct commit_list *gparent_list;
+					struct commit *gparent = parent;
+					struct indegree *gpi;
+					/* mark this 'branch' as this level */
+					pi->level = parent_level;
+					while ((gparent_list = gparent->parents) != NULL) {
+						gparent = gparent_list->item;
+						gpi = indegree_slab_peek(&indegree, gparent);
+						if (!gpi ||
+						    (gpi->level && gpi->level < parent_level))
+							break;
+						gpi->level = parent_level;
+					}
+				}
+				if (pi->level >= parent_level)
+					parent_level = pi->level + 1;
+			}
+
 			/*
 			 * parents are only enqueued for emission
 			 * when all their children have been emitted thereby
 			 * guaranteeing topological order.
 			 */
-			if (--(*pi) == 1)
+			if (--pi->indegree == 0)
 				prio_queue_put(&queue, parent);
 		}
 		/*
 		 * all children of commit have already been
 		 * emitted. we can emit it now.
 		 */
-		*(indegree_slab_at(&indegree, commit)) = 0;
+		indegree_slab_at(&indegree, commit)->indegree = 0;
 
 		pptr = &commit_list_insert(commit, pptr)->next;
 	}
 
+	if (sort_order == REV_SORT_IN_TREE_ORDER) {
+		struct commit *commit, *next_commit;
+		/*
+		 * go through the commit list to cut all the non-first
+		 * parent-child links, so we get a tree
+		 */
+		next = *list;
+		if (next) {
+			commit = next->item;
+			next = next->next;
+		}
+		for (next = *list; next; next = next->next, commit = next_commit) {
+			struct commit_list *parents, **pparents = &commit->parents;
+			next_commit = next->item;
+			for (parents = commit->parents; parents; parents = parents->next) {
+				/* leave link between sequential commits alone because
+				   the level is not 100% to column mapping. level might
+				   be higher due to merges of merges from the same
+				   origin; except if the next commit is on top level
+				   then for sure it's not the same column */
+				struct commit *parent = parents->item;
+				int cut = 1;
+				if (parent == next_commit) {
+					struct indegree *pi =
+						indegree_slab_peek(&indegree, parent);
+					/* cut as in, allow to cut */
+					cut = pi && pi->level == 1;
+				}
+				if (cut) {
+					struct commit **pfirst_child =
+						first_child_slab_at(&first_child, parent);
+					cut = commit != *pfirst_child;
+				}
+				if (cut)
+					*pparents = parents->next;
+				else
+					pparents = &parents->next;
+			}
+		}
+
+		clear_first_child_slab(&first_child);
+	}
+
 	clear_indegree_slab(&indegree);
 	clear_prio_queue(&queue);
 	if (sort_order == REV_SORT_BY_AUTHOR_DATE)
diff --git commit.h commit.h
index 42728c2906..25b236cb49 100644
--- commit.h
+++ commit.h
@@ -205,6 +205,7 @@ void clear_commit_marks_many(int nr, struct commit **commit, unsigned int mark);
 
 enum rev_sort_order {
 	REV_SORT_IN_GRAPH_ORDER = 0,
+	REV_SORT_IN_TREE_ORDER,
 	REV_SORT_BY_COMMIT_DATE,
 	REV_SORT_BY_AUTHOR_DATE
 };
diff --git revision.c revision.c
index 162d511d46..09074e2c08 100644
--- revision.c
+++ revision.c
@@ -2031,6 +2031,9 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--topo-order")) {
 		revs->sort_order = REV_SORT_IN_GRAPH_ORDER;
 		revs->topo_order = 1;
+	} else if (!strcmp(arg, "--tree")) {
+		revs->sort_order = REV_SORT_IN_TREE_ORDER;
+		goto graph;
 	} else if (!strcmp(arg, "--simplify-merges")) {
 		revs->simplify_merges = 1;
 		revs->topo_order = 1;
@@ -2227,6 +2230,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->pretty_given = 1;
 		revs->abbrev_commit = 1;
 	} else if (!strcmp(arg, "--graph")) {
+	    graph:
 		revs->topo_order = 1;
 		revs->rewrite_parents = 1;
 		revs->graph = graph_init(revs);
-- 
2.17.1

