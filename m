Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4FDC6FD1D
	for <git@archiver.kernel.org>; Fri, 17 Mar 2023 15:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbjCQPgW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Mar 2023 11:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbjCQPgG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2023 11:36:06 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DF21F4AC
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 08:35:34 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id cy23so21880241edb.12
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 08:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679067331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lXCubYjaiaU0boWrOlZbPY4r2Bx7/jfuwkAl7/fO/ks=;
        b=kssNM64YSL2uIds3rm+1P1ukUBZvkP0SjNY4gvfniiPKsXjPdn337dURLtji7nQaEq
         Yxq15aK/dTiztw+RcOiC2UNxyxiTIqHtocK61KNaH1831wvGdWqkN68IakAsVKYpRBWI
         yVN5hNHIs4fK7HHPz9JzZdn8hWGQ64N/3tQqDIblEagNNgMoT2RbJMBRhVuznvzakoXK
         0Z0wqbiXE9VisPLWASp4c6X7myGH365O+omh9b6KgKHplZ1l0OMqnqa1uWbcHayijUZh
         ZHBn9FMwgSPN1VAIVg5yirDpJv8pUE6O8gSO4KFvaVSBgCQNJTgXxcKkI28gORQzYWtJ
         PoPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679067331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lXCubYjaiaU0boWrOlZbPY4r2Bx7/jfuwkAl7/fO/ks=;
        b=8LXFg/6JAZFICMSZERz3H2Z+L8ewEITYnrQLNz2u6HNclb4V/QbBK9dc4eSifbhFfc
         +MUskFJnWCCHUXDfbSKZ/xYE7lCCYWJy6nrzCqhGiuWPTCqofzauEb280N7pRYxxTbN4
         6dDWTgoR5OlGRmN0An/TWWmP4JzZ+EvAlsuw+GJNQsVNLIg0e2DS7qG0Pay+8GJP1cKa
         KPcbDhakKPmrk1VTWva6qVS8a1Cr0ECD3kEfcYKVVxsFa3eH/0iCGXZgThTaeF2XavUx
         CaUWe1pQKJbRWPjNEevZo+9QkAg5+vCbazUXXrx99KGazsZjzUHmr9/MZ4Bx32crx0hv
         K6eA==
X-Gm-Message-State: AO0yUKV0QpfgQ+FZg7CIl8xlTjxI3hHOyswJOwu35/9qTc8UwWgWeCoR
        JSUksaJ4GFjcyijfGr3+TrkaNy06h/4aiQ==
X-Google-Smtp-Source: AK7set//ynoBFDPR6Ob7FwET2E+IXoEHGyclssDIvRUyTPF+vxrW5V2w9t3GvUQw+1SgXc/9O72YTA==
X-Received: by 2002:a05:6402:1507:b0:4fa:4a27:adba with SMTP id f7-20020a056402150700b004fa4a27adbamr3285854edw.22.1679067330806;
        Fri, 17 Mar 2023 08:35:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v6-20020a50d086000000b004fb00831851sm1199232edd.66.2023.03.17.08.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 08:35:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 06/17] cocci: apply the "commit-reach.h" part of "the_repository.pending"
Date:   Fri, 17 Mar 2023 16:35:10 +0100
Message-Id: <patch-06.17-b06ea9861fd-20230317T152724Z-avarab@gmail.com>
X-Mailer: git-send-email 2.40.0.rc1.1034.g5867a1b10c5
In-Reply-To: <cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com>
References: <cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apply the part of "the_repository.pending.cocci" pertaining to
"commit-reach.h".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 bisect.c                                        |  3 ++-
 builtin/branch.c                                |  5 +++--
 builtin/fast-import.c                           |  2 +-
 builtin/fetch.c                                 |  3 ++-
 builtin/log.c                                   | 10 +++++++---
 builtin/merge-base.c                            |  5 +++--
 builtin/merge-tree.c                            |  3 ++-
 builtin/merge.c                                 |  7 +++++--
 builtin/rebase.c                                |  5 +++--
 builtin/receive-pack.c                          |  2 +-
 builtin/rev-parse.c                             |  2 +-
 commit-reach.c                                  |  3 ++-
 commit-reach.h                                  |  9 ---------
 commit.c                                        |  3 ++-
 contrib/coccinelle/the_repository.cocci         | 16 ++++++++++++++++
 contrib/coccinelle/the_repository.pending.cocci | 16 ----------------
 http-push.c                                     |  2 +-
 log-tree.c                                      |  2 +-
 merge-ort.c                                     |  2 +-
 merge-recursive.c                               |  2 +-
 notes-merge.c                                   |  2 +-
 remote.c                                        |  2 +-
 revision.c                                      |  4 ++--
 sequencer.c                                     |  3 ++-
 shallow.c                                       |  9 +++++----
 t/helper/test-reach.c                           | 10 +++++++---
 26 files changed, 72 insertions(+), 60 deletions(-)

diff --git a/bisect.c b/bisect.c
index ef5ee5a6436..3088516e174 100644
--- a/bisect.c
+++ b/bisect.c
@@ -846,7 +846,8 @@ static enum bisect_error check_merge_bases(int rev_nr, struct commit **rev, int
 	enum bisect_error res = BISECT_OK;
 	struct commit_list *result;
 
-	result = get_merge_bases_many(rev[0], rev_nr - 1, rev + 1);
+	result = repo_get_merge_bases_many(the_repository, rev[0], rev_nr - 1,
+					   rev + 1);
 
 	for (; result; result = result->next) {
 		const struct object_id *mb = &result->item->object.oid;
diff --git a/builtin/branch.c b/builtin/branch.c
index 968ea03c059..bbcfb34b3c6 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -150,7 +150,8 @@ static int branch_merged(int kind, const char *name,
 	if (!reference_rev)
 		reference_rev = head_rev;
 
-	merged = reference_rev ? in_merge_bases(rev, reference_rev) : 0;
+	merged = reference_rev ? repo_in_merge_bases(the_repository, rev,
+						     reference_rev) : 0;
 
 	/*
 	 * After the safety valve is fully redefined to "check with
@@ -160,7 +161,7 @@ static int branch_merged(int kind, const char *name,
 	 * a gentle reminder is in order.
 	 */
 	if ((head_rev != reference_rev) &&
-	    (head_rev ? in_merge_bases(rev, head_rev) : 0) != merged) {
+	    (head_rev ? repo_in_merge_bases(the_repository, rev, head_rev) : 0) != merged) {
 		if (merged)
 			warning(_("deleting branch '%s' that has been merged to\n"
 				"         '%s', but not yet merged to HEAD."),
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index f533b768efb..2098c0c5a37 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -1625,7 +1625,7 @@ static int update_branch(struct branch *b)
 		if (!old_cmit || !new_cmit)
 			return error("Branch %s is missing commits.", b->name);
 
-		if (!in_merge_bases(old_cmit, new_cmit)) {
+		if (!repo_in_merge_bases(the_repository, old_cmit, new_cmit)) {
 			warning("Not updating %s"
 				" (new tip %s does not contain %s)",
 				b->name, oid_to_hex(&b->oid),
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 80cf1d01583..db8815032fc 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -965,7 +965,8 @@ static int update_local_ref(struct ref *ref,
 
 	if (fetch_show_forced_updates) {
 		uint64_t t_before = getnanotime();
-		fast_forward = in_merge_bases(current, updated);
+		fast_forward = repo_in_merge_bases(the_repository, current,
+						   updated);
 		forced_updates_ms += (getnanotime() - t_before) / 1000000;
 	} else {
 		fast_forward = 1;
diff --git a/builtin/log.c b/builtin/log.c
index b4c38f6ad87..5604b4b5f05 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1649,7 +1649,9 @@ static struct commit *get_base_commit(const char *base_commit,
 					return NULL;
 			}
 			commit = lookup_commit_or_die(&oid, "upstream base");
-			base_list = get_merge_bases_many(commit, total, list);
+			base_list = repo_get_merge_bases_many(the_repository,
+							      commit, total,
+							      list);
 			/* There should be one and only one merge base. */
 			if (!base_list || base_list->next) {
 				if (die_on_failure) {
@@ -1683,7 +1685,9 @@ static struct commit *get_base_commit(const char *base_commit,
 	while (rev_nr > 1) {
 		for (i = 0; i < rev_nr / 2; i++) {
 			struct commit_list *merge_base;
-			merge_base = get_merge_bases(rev[2 * i], rev[2 * i + 1]);
+			merge_base = repo_get_merge_bases(the_repository,
+							  rev[2 * i],
+							  rev[2 * i + 1]);
 			if (!merge_base || merge_base->next) {
 				if (die_on_failure) {
 					die(_("failed to find exact merge base"));
@@ -1701,7 +1705,7 @@ static struct commit *get_base_commit(const char *base_commit,
 		rev_nr = DIV_ROUND_UP(rev_nr, 2);
 	}
 
-	if (!in_merge_bases(base, rev[0])) {
+	if (!repo_in_merge_bases(the_repository, base, rev[0])) {
 		if (die_on_failure) {
 			die(_("base commit should be the ancestor of revision list"));
 		} else {
diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index 688d5c29b76..64d29136d16 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -13,7 +13,8 @@ static int show_merge_base(struct commit **rev, int rev_nr, int show_all)
 {
 	struct commit_list *result, *r;
 
-	result = get_merge_bases_many_dirty(rev[0], rev_nr - 1, rev + 1);
+	result = repo_get_merge_bases_many_dirty(the_repository, rev[0],
+						 rev_nr - 1, rev + 1);
 
 	if (!result)
 		return 1;
@@ -105,7 +106,7 @@ static int handle_is_ancestor(int argc, const char **argv)
 		die("--is-ancestor takes exactly two commits");
 	one = get_commit_reference(argv[0]);
 	two = get_commit_reference(argv[1]);
-	if (in_merge_bases(one, two))
+	if (repo_in_merge_bases(the_repository, one, two))
 		return 0;
 	else
 		return 1;
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 828dc81c426..4e4a9d6ba17 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -452,7 +452,8 @@ static int real_merge(struct merge_tree_options *o,
 		 * Get the merge bases, in reverse order; see comment above
 		 * merge_incore_recursive in merge-ort.h
 		 */
-		merge_bases = get_merge_bases(parent1, parent2);
+		merge_bases = repo_get_merge_bases(the_repository, parent1,
+						   parent2);
 		if (!merge_bases && !o->allow_unrelated_histories)
 			die(_("refusing to merge unrelated histories"));
 		merge_bases = reverse_commit_list(merge_bases);
diff --git a/builtin/merge.c b/builtin/merge.c
index 7331a0cd911..c5a9321806d 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1531,7 +1531,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	if (!remoteheads)
 		; /* already up-to-date */
 	else if (!remoteheads->next)
-		common = get_merge_bases(head_commit, remoteheads->item);
+		common = repo_get_merge_bases(the_repository, head_commit,
+					      remoteheads->item);
 	else {
 		struct commit_list *list = remoteheads;
 		commit_list_insert(head_commit, &list);
@@ -1649,7 +1650,9 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			 * merge_bases again, otherwise "git merge HEAD^
 			 * HEAD^^" would be missed.
 			 */
-			common_one = get_merge_bases(head_commit, j->item);
+			common_one = repo_get_merge_bases(the_repository,
+							  head_commit,
+							  j->item);
 			if (!oideq(&common_one->item->object.oid, &j->item->object.oid)) {
 				up_to_date = 0;
 				break;
diff --git a/builtin/rebase.c b/builtin/rebase.c
index d5358ca89d2..5fd7bfb4860 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -882,7 +882,7 @@ static int can_fast_forward(struct commit *onto, struct commit *upstream,
 	if (!upstream)
 		goto done;
 
-	merge_bases = get_merge_bases(upstream, head);
+	merge_bases = repo_get_merge_bases(the_repository, upstream, head);
 	if (!merge_bases || merge_bases->next)
 		goto done;
 
@@ -901,7 +901,8 @@ static void fill_branch_base(struct rebase_options *options,
 {
 	struct commit_list *merge_bases = NULL;
 
-	merge_bases = get_merge_bases(options->onto, options->orig_head);
+	merge_bases = repo_get_merge_bases(the_repository, options->onto,
+					   options->orig_head);
 	if (!merge_bases || merge_bases->next)
 		oidcpy(branch_base, null_oid());
 	else
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index b5816624d25..6d4fc1368a4 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1548,7 +1548,7 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 		}
 		old_commit = (struct commit *)old_object;
 		new_commit = (struct commit *)new_object;
-		if (!in_merge_bases(old_commit, new_commit)) {
+		if (!repo_in_merge_bases(the_repository, old_commit, new_commit)) {
 			rp_error("denying non-fast-forward %s"
 				 " (you should pull first)", name);
 			ret = "non-fast-forward";
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index eb53a303de6..5685cf0ea7d 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -292,7 +292,7 @@ static int try_difference(const char *arg)
 				*dotdot = '.';
 				return 0;
 			}
-			exclude = get_merge_bases(a, b);
+			exclude = repo_get_merge_bases(the_repository, a, b);
 			while (exclude) {
 				struct commit *commit = pop_commit(&exclude);
 				show_rev(REVERSED, &commit->object.oid, NULL);
diff --git a/commit-reach.c b/commit-reach.c
index 2e33c599a82..a4b9eda723f 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -162,7 +162,8 @@ struct commit_list *get_octopus_merge_bases(struct commit_list *in)
 
 		for (j = ret; j; j = j->next) {
 			struct commit_list *bases;
-			bases = get_merge_bases(i->item, j->item);
+			bases = repo_get_merge_bases(the_repository, i->item,
+						     j->item);
 			if (!new_commits)
 				new_commits = bases;
 			else
diff --git a/commit-reach.h b/commit-reach.h
index 148b56fea50..94a96e03299 100644
--- a/commit-reach.h
+++ b/commit-reach.h
@@ -19,11 +19,6 @@ struct commit_list *repo_get_merge_bases_many(struct repository *r,
 struct commit_list *repo_get_merge_bases_many_dirty(struct repository *r,
 						    struct commit *one, int n,
 						    struct commit **twos);
-#ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
-#define get_merge_bases(r1, r2)           repo_get_merge_bases(the_repository, r1, r2)
-#define get_merge_bases_many(one, n, two) repo_get_merge_bases_many(the_repository, one, n, two)
-#define get_merge_bases_many_dirty(one, n, twos) repo_get_merge_bases_many_dirty(the_repository, one, n, twos)
-#endif
 
 struct commit_list *get_octopus_merge_bases(struct commit_list *in);
 
@@ -36,10 +31,6 @@ int repo_in_merge_bases(struct repository *r,
 int repo_in_merge_bases_many(struct repository *r,
 			     struct commit *commit,
 			     int nr_reference, struct commit **reference);
-#ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
-#define in_merge_bases(c1, c2) repo_in_merge_bases(the_repository, c1, c2)
-#define in_merge_bases_many(c1, n, cs) repo_in_merge_bases_many(the_repository, c1, n, cs)
-#endif
 
 /*
  * Takes a list of commits and returns a new list where those
diff --git a/commit.c b/commit.c
index 06a7c728e80..62682f55643 100644
--- a/commit.c
+++ b/commit.c
@@ -1014,7 +1014,8 @@ struct commit *get_fork_point(const char *refname, struct commit *commit)
 	for (i = 0; i < revs.nr; i++)
 		revs.commit[i]->object.flags &= ~TMP_MARK;
 
-	bases = get_merge_bases_many(commit, revs.nr, revs.commit);
+	bases = repo_get_merge_bases_many(the_repository, commit, revs.nr,
+					  revs.commit);
 
 	/*
 	 * There should be one and only one merge base, when we found
diff --git a/contrib/coccinelle/the_repository.cocci b/contrib/coccinelle/the_repository.cocci
index dcdba314fc2..1ab63f0196b 100644
--- a/contrib/coccinelle/the_repository.cocci
+++ b/contrib/coccinelle/the_repository.cocci
@@ -38,6 +38,22 @@
 |
 - peel_to_type
 + repo_peel_to_type
+// commit-reach.h
+|
+- get_merge_bases
++ repo_get_merge_bases
+|
+- get_merge_bases_many
++ repo_get_merge_bases_many
+|
+- get_merge_bases_many_dirty
++ repo_get_merge_bases_many_dirty
+|
+- in_merge_bases
++ repo_in_merge_bases
+|
+- in_merge_bases_many
++ repo_in_merge_bases_many
 )
   (
 + the_repository,
diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contrib/coccinelle/the_repository.pending.cocci
index 2d200ab83e7..e9209fc0cc4 100644
--- a/contrib/coccinelle/the_repository.pending.cocci
+++ b/contrib/coccinelle/the_repository.pending.cocci
@@ -5,23 +5,7 @@
 @@
 @@
 (
-// commit-reach.h
-- get_merge_bases
-+ repo_get_merge_bases
-|
-- get_merge_bases_many
-+ repo_get_merge_bases_many
-|
-- get_merge_bases_many_dirty
-+ repo_get_merge_bases_many_dirty
-|
-- in_merge_bases
-+ repo_in_merge_bases
-|
-- in_merge_bases_many
-+ repo_in_merge_bases_many
 // commit.h
-|
 - parse_commit_internal
 + repo_parse_commit_internal
 |
diff --git a/http-push.c b/http-push.c
index 7f71316456c..ceab00bd901 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1570,7 +1570,7 @@ static int verify_merge_base(struct object_id *head_oid, struct ref *remote)
 	struct commit *branch = lookup_commit_or_die(&remote->old_oid,
 						     remote->name);
 
-	return in_merge_bases(branch, head);
+	return repo_in_merge_bases(the_repository, branch, head);
 }
 
 static int delete_remote_branch(const char *pattern, int force)
diff --git a/log-tree.c b/log-tree.c
index f36adb947e8..4bebb86ecac 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -993,7 +993,7 @@ static int do_remerge_diff(struct rev_info *opt,
 	/* Parse the relevant commits and get the merge bases */
 	parse_commit_or_die(parent1);
 	parse_commit_or_die(parent2);
-	bases = get_merge_bases(parent1, parent2);
+	bases = repo_get_merge_bases(the_repository, parent1, parent2);
 
 	/* Re-merge the parents */
 	merge_incore_recursive(&o, bases, parent1, parent2, &res);
diff --git a/merge-ort.c b/merge-ort.c
index d1611ca400a..e9f8bd15982 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -5017,7 +5017,7 @@ static void merge_ort_internal(struct merge_options *opt,
 	struct strbuf merge_base_abbrev = STRBUF_INIT;
 
 	if (!merge_bases) {
-		merge_bases = get_merge_bases(h1, h2);
+		merge_bases = repo_get_merge_bases(the_repository, h1, h2);
 		/* See merge-ort.h:merge_incore_recursive() declaration NOTE */
 		merge_bases = reverse_commit_list(merge_bases);
 	}
diff --git a/merge-recursive.c b/merge-recursive.c
index ae469f8cc81..9771ef540c4 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3592,7 +3592,7 @@ static int merge_recursive_internal(struct merge_options *opt,
 	}
 
 	if (!merge_bases) {
-		merge_bases = get_merge_bases(h1, h2);
+		merge_bases = repo_get_merge_bases(the_repository, h1, h2);
 		merge_bases = reverse_commit_list(merge_bases);
 	}
 
diff --git a/notes-merge.c b/notes-merge.c
index d290c7478e2..fca9422a294 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -600,7 +600,7 @@ int notes_merge(struct notes_merge_options *o,
 	assert(local && remote);
 
 	/* Find merge bases */
-	bases = get_merge_bases(local, remote);
+	bases = repo_get_merge_bases(the_repository, local, remote);
 	if (!bases) {
 		base_oid = null_oid();
 		base_tree_oid = the_hash_algo->empty_tree;
diff --git a/remote.c b/remote.c
index ff9b0238318..71b1ae2db05 100644
--- a/remote.c
+++ b/remote.c
@@ -2662,7 +2662,7 @@ static int is_reachable_in_reflog(const char *local, const struct ref *remote)
 		if (MERGE_BASES_BATCH_SIZE < size)
 			size = MERGE_BASES_BATCH_SIZE;
 
-		if ((ret = in_merge_bases_many(commit, size, chunk)))
+		if ((ret = repo_in_merge_bases_many(the_repository, commit, size, chunk)))
 			break;
 	}
 
diff --git a/revision.c b/revision.c
index 0f775ee2e90..c2b7b2f1073 100644
--- a/revision.c
+++ b/revision.c
@@ -1957,7 +1957,7 @@ static void prepare_show_merge(struct rev_info *revs)
 	other = lookup_commit_or_die(&oid, "MERGE_HEAD");
 	add_pending_object(revs, &head->object, "HEAD");
 	add_pending_object(revs, &other->object, "MERGE_HEAD");
-	bases = get_merge_bases(head, other);
+	bases = repo_get_merge_bases(the_repository, head, other);
 	add_rev_cmdline_list(revs, bases, REV_CMD_MERGE_BASE, UNINTERESTING | BOTTOM);
 	add_pending_commit_list(revs, bases, UNINTERESTING | BOTTOM);
 	free_commit_list(bases);
@@ -2052,7 +2052,7 @@ static int handle_dotdot_1(const char *arg, char *dotdot,
 		if (!a || !b)
 			return dotdot_missing(arg, dotdot, revs, symmetric);
 
-		exclude = get_merge_bases(a, b);
+		exclude = repo_get_merge_bases(the_repository, a, b);
 		add_rev_cmdline_list(revs, exclude, REV_CMD_MERGE_BASE,
 				     flags_exclude);
 		add_pending_commit_list(revs, exclude, flags_exclude);
diff --git a/sequencer.c b/sequencer.c
index 818932a630a..d97923883ff 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4102,7 +4102,8 @@ static int do_merge(struct repository *r,
 	}
 
 	merge_commit = to_merge->item;
-	bases = get_merge_bases(head_commit, merge_commit);
+	bases = repo_get_merge_bases(the_repository, head_commit,
+				     merge_commit);
 	if (bases && oideq(&merge_commit->object.oid,
 			   &bases->item->object.oid)) {
 		ret = 0;
diff --git a/shallow.c b/shallow.c
index 17f9bcdb5f3..0fcdfd7d35a 100644
--- a/shallow.c
+++ b/shallow.c
@@ -791,7 +791,7 @@ static void post_assign_shallow(struct shallow_info *info,
 		for (j = 0; j < bitmap_nr; j++)
 			if (bitmap[0][j] &&
 			    /* Step 7, reachability test at commit level */
-			    !in_merge_bases_many(c, ca.nr, ca.commits)) {
+			    !repo_in_merge_bases_many(the_repository, c, ca.nr, ca.commits)) {
 				update_refstatus(ref_status, info->ref->nr, *bitmap);
 				dst++;
 				break;
@@ -819,9 +819,10 @@ int delayed_reachability_test(struct shallow_info *si, int c)
 			si->nr_commits = ca.nr;
 		}
 
-		si->reachable[c] = in_merge_bases_many(commit,
-						       si->nr_commits,
-						       si->commits);
+		si->reachable[c] = repo_in_merge_bases_many(the_repository,
+							    commit,
+							    si->nr_commits,
+							    si->commits);
 		si->need_reachability_test[c] = 0;
 	}
 	return si->reachable[c];
diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
index 00f0f29a6a6..b6d197722f0 100644
--- a/t/helper/test-reach.c
+++ b/t/helper/test-reach.c
@@ -106,13 +106,17 @@ int cmd__reach(int ac, const char **av)
 	if (!strcmp(av[1], "ref_newer"))
 		printf("%s(A,B):%d\n", av[1], ref_newer(&oid_A, &oid_B));
 	else if (!strcmp(av[1], "in_merge_bases"))
-		printf("%s(A,B):%d\n", av[1], in_merge_bases(A, B));
+		printf("%s(A,B):%d\n", av[1],
+		       repo_in_merge_bases(the_repository, A, B));
 	else if (!strcmp(av[1], "in_merge_bases_many"))
-		printf("%s(A,X):%d\n", av[1], in_merge_bases_many(A, X_nr, X_array));
+		printf("%s(A,X):%d\n", av[1],
+		       repo_in_merge_bases_many(the_repository, A, X_nr, X_array));
 	else if (!strcmp(av[1], "is_descendant_of"))
 		printf("%s(A,X):%d\n", av[1], repo_is_descendant_of(r, A, X));
 	else if (!strcmp(av[1], "get_merge_bases_many")) {
-		struct commit_list *list = get_merge_bases_many(A, X_nr, X_array);
+		struct commit_list *list = repo_get_merge_bases_many(the_repository,
+								     A, X_nr,
+								     X_array);
 		printf("%s(A,X):\n", av[1]);
 		print_sorted_commit_ids(list);
 	} else if (!strcmp(av[1], "reduce_heads")) {
-- 
2.40.0.rc1.1034.g5867a1b10c5

