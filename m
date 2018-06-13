Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C375B1F403
	for <e@80x24.org>; Wed, 13 Jun 2018 23:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935839AbeFMXFw (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 19:05:52 -0400
Received: from mail-oi0-f74.google.com ([209.85.218.74]:42241 "EHLO
        mail-oi0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935432AbeFMXFt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 19:05:49 -0400
Received: by mail-oi0-f74.google.com with SMTP id q129-v6so2697915oic.9
        for <git@vger.kernel.org>; Wed, 13 Jun 2018 16:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=cJf7ed6mSLsqyjofHGT+ANJ7yZeZlw4kLvv+EFJ/KkE=;
        b=R+vjMgo6NUR+3NKGUJGaQ821nkwj9Aoi/jX0Y8EshsR7a+UkCBwK8e8GKRAXjzmzAg
         ejaLarKdUt3yWaZwY2k0XsltwtQ6Ngy6uaEpjSoli7lo/JT7x8b9Z1zGUe6i3pXjz6Pq
         xhf8ix80RCogx9E4FVxVGi+aBAnPajxWj1pGy/0+BpQWZTYbMfwrpn/dp8TmHe2cQvVs
         KXbA/d0NP2dQ4VmrFr1Xh3fwiqqfe9fuPUd6QuUEYL2LJeEJlS/nmB03Y1UmeBKygd1+
         nMjBF+tGsy/dBDVNa4GTIB7ikMdf+UXYnbsjddlx8ft2Vdog/Z+MYISBVEyyagFQPSpX
         mIcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=cJf7ed6mSLsqyjofHGT+ANJ7yZeZlw4kLvv+EFJ/KkE=;
        b=mguRK0ArwcxkBB/rwIAUjyke/K1CEmZo7kHIaGVh4Na/4t/pzFjWx68hb1tumS2Lh4
         r0GSWKTyVrAjkJJMjukZygT3DGkujvWFZVbGNZWYODWGCyRkf6Wqi0BaAqxA3FysDOAT
         xnl5hD5kcEKwR+lOAJJQB/Zw4XE7cTHYDILhHu9W82u/1zBg5TaeAMEuzpCnGBvUqp87
         izCA0VQsPiVfIGRvUz8PvGNJoG3NA8shvZIomEHs2POQ4KmMKo0JBjqqK0BWRIsY2RTJ
         0ztwDQNKe/XALBwg2DugNpnaN9hQu6YoFxPIbY3KRi8EhZ0zrfPgrQsXOEvw2CqOdly2
         GbdQ==
X-Gm-Message-State: APt69E3LmL528guNcdxYY/5zXBvID7L50bhygt7XoTvv3BFuffShX+q9
        Ameg+luacLvO0rSVBzWd2zpuHVWdzcVxBfQ2KcU4d6JjzVMPabQ9nC1GpwciXgfjyZ0SG7Ptpne
        0IdzN5ktMl3XHHeScmrXtKbCBLcsoSVOceAL6O6+ejE9okLvymj0SZ/+8HVYm
X-Google-Smtp-Source: ADUXVKJWcEsdhJp03r1Cpf3D5WLABI++1HBMWvqcqjmm/DDd6At9cp/BRcpIOlkwpbOuVSDjZA1pVqaq7AFf
MIME-Version: 1.0
X-Received: by 2002:a9d:447c:: with SMTP id f57-v6mr76590otj.1.1528931148380;
 Wed, 13 Jun 2018 16:05:48 -0700 (PDT)
Date:   Wed, 13 Jun 2018 16:04:57 -0700
In-Reply-To: <20180613230522.55335-1-sbeller@google.com>
Message-Id: <20180613230522.55335-7-sbeller@google.com>
References: <20180530004810.30076-1-sbeller@google.com> <20180613230522.55335-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Subject: [PATCH v2 06/31] commit: add repository argument to lookup_commit_reference_gently
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow callers of
lookup_commit_reference_gently to be more specific about which
repository to handle. This is a small mechanical change; it doesn't
change the implementation to handle repositories other than
the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 archive.c             |  2 +-
 blame.c               |  3 ++-
 builtin/checkout.c    |  6 +++---
 builtin/describe.c    |  5 +++--
 builtin/fetch.c       |  9 ++++++---
 builtin/reflog.c      | 10 ++++++----
 builtin/show-branch.c |  3 ++-
 bundle.c              |  2 +-
 commit-graph.c        |  2 +-
 commit.c              |  6 +++---
 commit.h              |  5 ++++-
 fast-import.c         |  6 ++++--
 notes-cache.c         |  3 ++-
 ref-filter.c          |  6 ++++--
 remote.c              |  9 +++++----
 sequencer.c           |  2 +-
 sha1-name.c           |  4 ++--
 shallow.c             |  9 ++++++---
 walker.c              |  3 ++-
 wt-status.c           |  2 +-
 20 files changed, 59 insertions(+), 38 deletions(-)

diff --git a/archive.c b/archive.c
index 9da1e3664a6..983a45ba3e7 100644
--- a/archive.c
+++ b/archive.c
@@ -380,7 +380,7 @@ static void parse_treeish_arg(const char **argv,
 	if (get_oid(name, &oid))
 		die("Not a valid object name");
 
-	commit = lookup_commit_reference_gently(&oid, 1);
+	commit = lookup_commit_reference_gently(the_repository, &oid, 1);
 	if (commit) {
 		commit_sha1 = commit->object.oid.hash;
 		archive_time = commit->date;
diff --git a/blame.c b/blame.c
index 2904b0500d9..726a7a76f20 100644
--- a/blame.c
+++ b/blame.c
@@ -1712,7 +1712,8 @@ static struct commit *dwim_reverse_initial(struct rev_info *revs,
 	/* Do we have HEAD? */
 	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, &head_oid, NULL))
 		return NULL;
-	head_commit = lookup_commit_reference_gently(&head_oid, 1);
+	head_commit = lookup_commit_reference_gently(the_repository,
+						     &head_oid, 1);
 	if (!head_commit)
 		return NULL;
 
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 105e07981ff..31a71f75625 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -379,7 +379,7 @@ static int checkout_paths(const struct checkout_opts *opts,
 		die(_("unable to write new index file"));
 
 	read_ref_full("HEAD", 0, &rev, NULL);
-	head = lookup_commit_reference_gently(&rev, 1);
+	head = lookup_commit_reference_gently(the_repository, &rev, 1);
 
 	errs |= post_checkout_hook(head, head, 0);
 	return errs;
@@ -823,7 +823,7 @@ static int switch_branches(const struct checkout_opts *opts,
 	memset(&old_branch_info, 0, sizeof(old_branch_info));
 	old_branch_info.path = path_to_free = resolve_refdup("HEAD", 0, &rev, &flag);
 	if (old_branch_info.path)
-		old_branch_info.commit = lookup_commit_reference_gently(&rev, 1);
+		old_branch_info.commit = lookup_commit_reference_gently(the_repository, &rev, 1);
 	if (!(flag & REF_ISSYMREF))
 		old_branch_info.path = NULL;
 
@@ -997,7 +997,7 @@ static int parse_branchname_arg(int argc, const char **argv,
 	else
 		new_branch_info->path = NULL; /* not an existing branch */
 
-	new_branch_info->commit = lookup_commit_reference_gently(rev, 1);
+	new_branch_info->commit = lookup_commit_reference_gently(the_repository, rev, 1);
 	if (!new_branch_info->commit) {
 		/* not a commit */
 		*source_tree = parse_tree_indirect(rev);
diff --git a/builtin/describe.c b/builtin/describe.c
index 58341c6f9ed..f3dfd0228be 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -331,7 +331,8 @@ static void describe_commit(struct object_id *oid, struct strbuf *dst)
 		init_commit_names(&commit_names);
 		n = hashmap_iter_first(&names, &iter);
 		for (; n; n = hashmap_iter_next(&iter)) {
-			c = lookup_commit_reference_gently(&n->peeled, 1);
+			c = lookup_commit_reference_gently(the_repository,
+							   &n->peeled, 1);
 			if (c)
 				*commit_names_at(&commit_names, c) = n;
 		}
@@ -509,7 +510,7 @@ static void describe(const char *arg, int last_one)
 
 	if (get_oid(arg, &oid))
 		die(_("Not a valid object name %s"), arg);
-	cmit = lookup_commit_reference_gently(&oid, 1);
+	cmit = lookup_commit_reference_gently(the_repository, &oid, 1);
 
 	if (cmit)
 		describe_commit(&oid, &sb);
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 6ce11bfb094..499cf6fcf12 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -690,8 +690,10 @@ static int update_local_ref(struct ref *ref,
 		return r;
 	}
 
-	current = lookup_commit_reference_gently(&ref->old_oid, 1);
-	updated = lookup_commit_reference_gently(&ref->new_oid, 1);
+	current = lookup_commit_reference_gently(the_repository,
+						 &ref->old_oid, 1);
+	updated = lookup_commit_reference_gently(the_repository,
+						 &ref->new_oid, 1);
 	if (!current || !updated) {
 		const char *msg;
 		const char *what;
@@ -824,7 +826,8 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 				continue;
 			}
 
-			commit = lookup_commit_reference_gently(&rm->old_oid,
+			commit = lookup_commit_reference_gently(the_repository,
+								&rm->old_oid,
 								1);
 			if (!commit)
 				rm->fetch_head_status = FETCH_HEAD_NOT_FOR_MERGE;
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 93dabd7ce31..6ff3c5abff0 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -196,7 +196,7 @@ static int keep_entry(struct commit **it, struct object_id *oid)
 
 	if (is_null_oid(oid))
 		return 1;
-	commit = lookup_commit_reference_gently(oid, 1);
+	commit = lookup_commit_reference_gently(the_repository, oid, 1);
 	if (!commit)
 		return 0;
 
@@ -265,7 +265,8 @@ static int unreachable(struct expire_reflog_policy_cb *cb, struct commit *commit
 		if (is_null_oid(oid))
 			return 0;
 
-		commit = lookup_commit_reference_gently(oid, 1);
+		commit = lookup_commit_reference_gently(the_repository, oid,
+							1);
 
 		/* Not a commit -- keep it */
 		if (!commit)
@@ -322,7 +323,7 @@ static int push_tip_to_list(const char *refname, const struct object_id *oid,
 	struct commit *tip_commit;
 	if (flags & REF_ISSYMREF)
 		return 0;
-	tip_commit = lookup_commit_reference_gently(oid, 1);
+	tip_commit = lookup_commit_reference_gently(the_repository, oid, 1);
 	if (!tip_commit)
 		return 0;
 	commit_list_insert(tip_commit, list);
@@ -339,7 +340,8 @@ static void reflog_expiry_prepare(const char *refname,
 		cb->tip_commit = NULL;
 		cb->unreachable_expire_kind = UE_HEAD;
 	} else {
-		cb->tip_commit = lookup_commit_reference_gently(oid, 1);
+		cb->tip_commit = lookup_commit_reference_gently(the_repository,
+								oid, 1);
 		if (!cb->tip_commit)
 			cb->unreachable_expire_kind = UE_ALWAYS;
 		else
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index f2e985c00ab..2456b47d344 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -378,7 +378,8 @@ static void sort_ref_range(int bottom, int top)
 static int append_ref(const char *refname, const struct object_id *oid,
 		      int allow_dups)
 {
-	struct commit *commit = lookup_commit_reference_gently(oid, 1);
+	struct commit *commit = lookup_commit_reference_gently(the_repository,
+							       oid, 1);
 	int i;
 
 	if (!commit)
diff --git a/bundle.c b/bundle.c
index 9ef55f6bdb0..14a209ff149 100644
--- a/bundle.c
+++ b/bundle.c
@@ -180,7 +180,7 @@ int verify_bundle(struct bundle_header *header, int verbose)
 	/* Clean up objects used, as they will be reused. */
 	for (i = 0; i < p->nr; i++) {
 		struct ref_list_entry *e = p->list + i;
-		commit = lookup_commit_reference_gently(&e->oid, 1);
+		commit = lookup_commit_reference_gently(the_repository, &e->oid, 1);
 		if (commit)
 			clear_commit_marks(commit, ALL_REV_FLAGS);
 	}
diff --git a/commit-graph.c b/commit-graph.c
index 88a4b0d2a47..5345cc90ed1 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -622,7 +622,7 @@ void write_commit_graph(const char *obj_dir,
 			if (commit_hex[i] && parse_oid_hex(commit_hex[i], &oid, &end))
 				continue;
 
-			result = lookup_commit_reference_gently(&oid, 1);
+			result = lookup_commit_reference_gently(the_repository, &oid, 1);
 
 			if (result) {
 				ALLOC_GROW(oids.list, oids.nr + 1, oids.alloc);
diff --git a/commit.c b/commit.c
index 755b8b9d94f..b039444aa62 100644
--- a/commit.c
+++ b/commit.c
@@ -23,8 +23,8 @@ int save_commit_buffer = 1;
 
 const char *commit_type = "commit";
 
-struct commit *lookup_commit_reference_gently(const struct object_id *oid,
-					      int quiet)
+struct commit *lookup_commit_reference_gently_the_repository(
+		const struct object_id *oid, int quiet)
 {
 	struct object *obj = deref_tag(parse_object(the_repository, oid),
 				       NULL, 0);
@@ -36,7 +36,7 @@ struct commit *lookup_commit_reference_gently(const struct object_id *oid,
 
 struct commit *lookup_commit_reference(const struct object_id *oid)
 {
-	return lookup_commit_reference_gently(oid, 0);
+	return lookup_commit_reference_gently(the_repository, oid, 0);
 }
 
 struct commit *lookup_commit_or_die(const struct object_id *oid, const char *ref_name)
diff --git a/commit.h b/commit.h
index 9019652dbac..73ccdd8005b 100644
--- a/commit.h
+++ b/commit.h
@@ -55,7 +55,10 @@ const struct name_decoration *get_name_decoration(const struct object *obj);
 
 struct commit *lookup_commit(const struct object_id *oid);
 struct commit *lookup_commit_reference(const struct object_id *oid);
-struct commit *lookup_commit_reference_gently(const struct object_id *oid,
+#define lookup_commit_reference_gently(r, o, q) \
+		lookup_commit_reference_gently_##r(o, q)
+struct commit *lookup_commit_reference_gently_the_repository(
+					      const struct object_id *oid,
 					      int quiet);
 struct commit *lookup_commit_reference_by_name(const char *name);
 
diff --git a/fast-import.c b/fast-import.c
index b2338fa8eb2..fadc2c70021 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1724,8 +1724,10 @@ static int update_branch(struct branch *b)
 	if (!force_update && !is_null_oid(&old_oid)) {
 		struct commit *old_cmit, *new_cmit;
 
-		old_cmit = lookup_commit_reference_gently(&old_oid, 0);
-		new_cmit = lookup_commit_reference_gently(&b->oid, 0);
+		old_cmit = lookup_commit_reference_gently(the_repository,
+							  &old_oid, 0);
+		new_cmit = lookup_commit_reference_gently(the_repository,
+							  &b->oid, 0);
 		if (!old_cmit || !new_cmit)
 			return error("Branch %s is missing commits.", b->name);
 
diff --git a/notes-cache.c b/notes-cache.c
index d5770031776..d87e7ca91cd 100644
--- a/notes-cache.c
+++ b/notes-cache.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "notes-cache.h"
 #include "object-store.h"
+#include "repository.h"
 #include "commit.h"
 #include "refs.h"
 
@@ -15,7 +16,7 @@ static int notes_cache_match_validity(const char *ref, const char *validity)
 	if (read_ref(ref, &oid) < 0)
 		return 0;
 
-	commit = lookup_commit_reference_gently(&oid, 1);
+	commit = lookup_commit_reference_gently(the_repository, &oid, 1);
 	if (!commit)
 		return 0;
 
diff --git a/ref-filter.c b/ref-filter.c
index 7e57c07bf54..8133871e93d 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2010,7 +2010,8 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 	 * non-commits early. The actual filtering is done later.
 	 */
 	if (filter->merge_commit || filter->with_commit || filter->no_commit || filter->verbose) {
-		commit = lookup_commit_reference_gently(oid, 1);
+		commit = lookup_commit_reference_gently(the_repository, oid,
+							1);
 		if (!commit)
 			return 0;
 		/* We perform the filtering for the '--contains' option... */
@@ -2367,7 +2368,8 @@ int parse_opt_merge_filter(const struct option *opt, const char *arg, int unset)
 	if (get_oid(arg, &oid))
 		die(_("malformed object name %s"), arg);
 
-	rf->merge_commit = lookup_commit_reference_gently(&oid, 0);
+	rf->merge_commit = lookup_commit_reference_gently(the_repository,
+							  &oid, 0);
 	if (!rf->merge_commit)
 		return opterror(opt, "must point to a commit", 0);
 
diff --git a/remote.c b/remote.c
index 92a17828d25..956fd0fd923 100644
--- a/remote.c
+++ b/remote.c
@@ -1337,7 +1337,7 @@ static void add_to_tips(struct tips *tips, const struct object_id *oid)
 
 	if (is_null_oid(oid))
 		return;
-	commit = lookup_commit_reference_gently(oid, 1);
+	commit = lookup_commit_reference_gently(the_repository, oid, 1);
 	if (!commit || (commit->object.flags & TMP_MARK))
 		return;
 	commit->object.flags |= TMP_MARK;
@@ -1399,7 +1399,8 @@ static void add_missing_tags(struct ref *src, struct ref **dst, struct ref ***ds
 
 			if (is_null_oid(&ref->new_oid))
 				continue;
-			commit = lookup_commit_reference_gently(&ref->new_oid,
+			commit = lookup_commit_reference_gently(the_repository,
+								&ref->new_oid,
 								1);
 			if (!commit)
 				/* not pushing a commit, which is not an error */
@@ -1627,8 +1628,8 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 				reject_reason = REF_STATUS_REJECT_ALREADY_EXISTS;
 			else if (!has_object_file(&ref->old_oid))
 				reject_reason = REF_STATUS_REJECT_FETCH_FIRST;
-			else if (!lookup_commit_reference_gently(&ref->old_oid, 1) ||
-				 !lookup_commit_reference_gently(&ref->new_oid, 1))
+			else if (!lookup_commit_reference_gently(the_repository, &ref->old_oid, 1) ||
+				 !lookup_commit_reference_gently(the_repository, &ref->new_oid, 1))
 				reject_reason = REF_STATUS_REJECT_NEEDS_FORCE;
 			else if (!ref_newer(&ref->new_oid, &ref->old_oid))
 				reject_reason = REF_STATUS_REJECT_NONFASTFORWARD;
diff --git a/sequencer.c b/sequencer.c
index bf5620dff0c..4e89e2b1123 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2886,7 +2886,7 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 			continue;
 
 		if (!get_oid(name, &oid)) {
-			if (!lookup_commit_reference_gently(&oid, 1)) {
+			if (!lookup_commit_reference_gently(the_repository, &oid, 1)) {
 				enum object_type type = oid_object_info(the_repository,
 									&oid,
 									NULL);
diff --git a/sha1-name.c b/sha1-name.c
index 3e1c57e1539..412a5257d6f 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1217,13 +1217,13 @@ int get_oid_mb(const char *name, struct object_id *oid)
 	}
 	if (st)
 		return st;
-	one = lookup_commit_reference_gently(&oid_tmp, 0);
+	one = lookup_commit_reference_gently(the_repository, &oid_tmp, 0);
 	if (!one)
 		return -1;
 
 	if (get_oid_committish(dots[3] ? (dots + 3) : "HEAD", &oid_tmp))
 		return -1;
-	two = lookup_commit_reference_gently(&oid_tmp, 0);
+	two = lookup_commit_reference_gently(the_repository, &oid_tmp, 0);
 	if (!two)
 		return -1;
 	mbs = get_merge_bases(one, two);
diff --git a/shallow.c b/shallow.c
index 7cb893c3d94..9bb07a56dca 100644
--- a/shallow.c
+++ b/shallow.c
@@ -489,7 +489,8 @@ static void paint_down(struct paint_info *info, const struct object_id *oid,
 	struct commit_list *head = NULL;
 	int bitmap_nr = DIV_ROUND_UP(info->nr_bits, 32);
 	size_t bitmap_size = st_mult(sizeof(uint32_t), bitmap_nr);
-	struct commit *c = lookup_commit_reference_gently(oid, 1);
+	struct commit *c = lookup_commit_reference_gently(the_repository, oid,
+							  1);
 	uint32_t *tmp; /* to be freed before return */
 	uint32_t *bitmap;
 
@@ -551,7 +552,8 @@ static void paint_down(struct paint_info *info, const struct object_id *oid,
 static int mark_uninteresting(const char *refname, const struct object_id *oid,
 			      int flags, void *cb_data)
 {
-	struct commit *commit = lookup_commit_reference_gently(oid, 1);
+	struct commit *commit = lookup_commit_reference_gently(the_repository,
+							       oid, 1);
 	if (!commit)
 		return 0;
 	commit->object.flags |= UNINTERESTING;
@@ -661,7 +663,8 @@ static int add_ref(const char *refname, const struct object_id *oid,
 {
 	struct commit_array *ca = cb_data;
 	ALLOC_GROW(ca->commits, ca->nr + 1, ca->alloc);
-	ca->commits[ca->nr] = lookup_commit_reference_gently(oid, 1);
+	ca->commits[ca->nr] = lookup_commit_reference_gently(the_repository,
+							     oid, 1);
 	if (ca->commits[ca->nr])
 		ca->nr++;
 	return 0;
diff --git a/walker.c b/walker.c
index 07cecfda693..d3721349254 100644
--- a/walker.c
+++ b/walker.c
@@ -207,7 +207,8 @@ static int interpret_target(struct walker *walker, char *target, struct object_i
 static int mark_complete(const char *path, const struct object_id *oid,
 			 int flag, void *cb_data)
 {
-	struct commit *commit = lookup_commit_reference_gently(oid, 1);
+	struct commit *commit = lookup_commit_reference_gently(the_repository,
+							       oid, 1);
 
 	if (commit) {
 		commit->object.flags |= COMPLETE;
diff --git a/wt-status.c b/wt-status.c
index e35cdfeb4be..40ccf2dccb5 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1481,7 +1481,7 @@ static void wt_status_get_detached_from(struct wt_status_state *state)
 	    /* sha1 is a commit? match without further lookup */
 	    (!oidcmp(&cb.noid, &oid) ||
 	     /* perhaps sha1 is a tag, try to dereference to a commit */
-	     ((commit = lookup_commit_reference_gently(&oid, 1)) != NULL &&
+	     ((commit = lookup_commit_reference_gently(the_repository, &oid, 1)) != NULL &&
 	      !oidcmp(&cb.noid, &commit->object.oid)))) {
 		const char *from = ref;
 		if (!skip_prefix(from, "refs/tags/", &from))
-- 
2.18.0.rc1.244.gcf134e6275-goog

