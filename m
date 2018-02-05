Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00EFE1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752196AbeBFANk (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:13:40 -0500
Received: from mail-pl0-f48.google.com ([209.85.160.48]:40012 "EHLO
        mail-pl0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752177AbeBFANa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:13:30 -0500
Received: by mail-pl0-f48.google.com with SMTP id g18so112605plo.7
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UW9A15UvvzhUBpMzOtTq+nxQAcHD1NbWXls9eWdXx/g=;
        b=ZCp1mZQzQFs7A74wEpGdcu02ZvmaqyD3RffarwsYXqkvU8QnRfY5c9fd8v/pBB65Ds
         yha3+9OkMKXBzy7Gshxox440JNalkqE7+QpLBVa3LFU4n+pB++N8I2l5rNTvCF5BojTc
         b37+HrvNxxJwK96D7etedznUh1K/NbPZXyYn/zeZdLEnSU67tHLkRBLnwAg9UZ/5kFqB
         WbXdKILDbmBT/vnlZYBcXLhFsbXkA/cK2DlbxDK+seLRpQzUtZEW0s7+CrFcjeWIKE3R
         a7AwYJwvudwu3VRONdwnlF20SEfgMlClKDmrjgFk9Ph7IIKYsZGUiCOn0dLHvGmXodei
         ZvHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UW9A15UvvzhUBpMzOtTq+nxQAcHD1NbWXls9eWdXx/g=;
        b=JvL9lMb0a1i76pFqzD/u8qUnWghKkHlLuYrpKahn/nfS7S2bSrf1wUbYjWBkH3CVRH
         VfHXCupjldbXawywTs4hPjD5ryE82v7mXoiP9p8iMbkA5zyeuyzLykrhtRSacBY75Luf
         JI2DxfhZ6M7S05q6hox33nKX7GavpJE6GuGN7ksKDCyK7/BF5OLFG9seUtPtLIc4Ok4f
         tqRIkPvsWeSXP4Sk0LR0eQz4dCNUnGMTWwmTLGXVn49hZmGCoCH0HOxi6ZUcxkpYe3VC
         ZUMNzAzwc2EMOLQAZCr+p+xGxyh9mXdOUhvs1tvuSAUqKMEnMhp92UGlO2B4EB3xJAY1
         DNuA==
X-Gm-Message-State: APf1xPC6nYsKC84fJGrGXlrYsw29Niyzb4ToZZO9mfQU+We3MpVJuUF2
        m+xmRxzHGYNDjFvSdmVRfNx+sBdrb54=
X-Google-Smtp-Source: AH8x225It2Hqx7fEkfVYNhZa+ZtXkw/zGW8oUWBI07WyJgXvdOxKO3Mm9xnYBimcvTLpuTGyO1fAPA==
X-Received: by 2002:a17:902:203:: with SMTP id 3-v6mr520596plc.413.1517876009447;
        Mon, 05 Feb 2018 16:13:29 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id l10sm17786282pff.64.2018.02.05.16.13.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:13:28 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 089/194] object: add repository argument to lookup_commit_reference_gently
Date:   Mon,  5 Feb 2018 15:55:50 -0800
Message-Id: <20180205235735.216710-69-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>

Add a repository argument to allow callers of
lookup_commit_reference_gently to be more specific about which
repository to handle. This is a small mechanical change; it doesn't
change the implementation to handle repositories other than
the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

The included coccinelle semantic patch will adapt any new callers in
the diff produced by `make coccicheck`.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 archive.c                              |  2 +-
 blame.c                                |  3 ++-
 builtin/checkout.c                     |  7 ++++---
 builtin/describe.c                     |  5 +++--
 builtin/fetch.c                        |  9 ++++++---
 builtin/reflog.c                       | 10 ++++++----
 builtin/show-branch.c                  |  3 ++-
 commit.c                               |  9 +++++----
 commit.h                               |  5 ++++-
 contrib/coccinelle/object_parser.cocci |  8 ++++++++
 fast-import.c                          |  6 ++++--
 notes-cache.c                          |  3 ++-
 ref-filter.c                           |  6 ++++--
 remote.c                               |  9 +++++----
 sequencer.c                            |  2 +-
 sha1_name.c                            |  4 ++--
 shallow.c                              |  9 ++++++---
 walker.c                               |  3 ++-
 wt-status.c                            |  2 +-
 19 files changed, 68 insertions(+), 37 deletions(-)

diff --git a/archive.c b/archive.c
index 9b47041a6c..2aeafe647d 100644
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
index 02cd0ba498..98761c32d5 100644
--- a/blame.c
+++ b/blame.c
@@ -1693,7 +1693,8 @@ static struct commit *dwim_reverse_initial(struct rev_info *revs,
 	/* Do we have HEAD? */
 	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, &head_oid, NULL))
 		return NULL;
-	head_commit = lookup_commit_reference_gently(&head_oid, 1);
+	head_commit = lookup_commit_reference_gently(the_repository,
+						     &head_oid, 1);
 	if (!head_commit)
 		return NULL;
 
diff --git a/builtin/checkout.c b/builtin/checkout.c
index c7271ed43f..cef2b4f2ad 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -380,7 +380,7 @@ static int checkout_paths(const struct checkout_opts *opts,
 		die(_("unable to write new index file"));
 
 	read_ref_full("HEAD", 0, &rev, NULL);
-	head = lookup_commit_reference_gently(&rev, 1);
+	head = lookup_commit_reference_gently(the_repository, &rev, 1);
 
 	errs |= post_checkout_hook(head, head, 0);
 	return errs;
@@ -835,7 +835,8 @@ static int switch_branches(const struct checkout_opts *opts,
 	memset(&old, 0, sizeof(old));
 	old.path = path_to_free = resolve_refdup("HEAD", 0, &rev, &flag);
 	if (old.path)
-		old.commit = lookup_commit_reference_gently(&rev, 1);
+		old.commit = lookup_commit_reference_gently(the_repository,
+							    &rev, 1);
 	if (!(flag & REF_ISSYMREF))
 		old.path = NULL;
 
@@ -1009,7 +1010,7 @@ static int parse_branchname_arg(int argc, const char **argv,
 	else
 		new->path = NULL; /* not an existing branch */
 
-	new->commit = lookup_commit_reference_gently(rev, 1);
+	new->commit = lookup_commit_reference_gently(the_repository, rev, 1);
 	if (!new->commit) {
 		/* not a commit */
 		*source_tree = parse_tree_indirect(rev);
diff --git a/builtin/describe.c b/builtin/describe.c
index 2589872322..f1172a8bf0 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -320,7 +320,8 @@ static void describe_commit(struct object_id *oid, struct strbuf *dst)
 		struct commit *c;
 		struct commit_name *n = hashmap_iter_first(&names, &iter);
 		for (; n; n = hashmap_iter_next(&iter)) {
-			c = lookup_commit_reference_gently(&n->peeled, 1);
+			c = lookup_commit_reference_gently(the_repository,
+							   &n->peeled, 1);
 			if (c)
 				c->util = n;
 		}
@@ -495,7 +496,7 @@ static void describe(const char *arg, int last_one)
 
 	if (get_oid(arg, &oid))
 		die(_("Not a valid object name %s"), arg);
-	cmit = lookup_commit_reference_gently(&oid, 1);
+	cmit = lookup_commit_reference_gently(the_repository, &oid, 1);
 
 	if (cmit)
 		describe_commit(&oid, &sb);
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 276beebbb1..904496fa33 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -660,8 +660,10 @@ static int update_local_ref(struct ref *ref,
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
@@ -794,7 +796,8 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 				continue;
 			}
 
-			commit = lookup_commit_reference_gently(&rm->old_oid,
+			commit = lookup_commit_reference_gently(the_repository,
+								&rm->old_oid,
 								1);
 			if (!commit)
 				rm->fetch_head_status = FETCH_HEAD_NOT_FOR_MERGE;
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 335525bb15..e12b99e9cb 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -195,7 +195,7 @@ static int keep_entry(struct commit **it, struct object_id *oid)
 
 	if (is_null_oid(oid))
 		return 1;
-	commit = lookup_commit_reference_gently(oid, 1);
+	commit = lookup_commit_reference_gently(the_repository, oid, 1);
 	if (!commit)
 		return 0;
 
@@ -264,7 +264,8 @@ static int unreachable(struct expire_reflog_policy_cb *cb, struct commit *commit
 		if (is_null_oid(oid))
 			return 0;
 
-		commit = lookup_commit_reference_gently(oid, 1);
+		commit = lookup_commit_reference_gently(the_repository, oid,
+							1);
 
 		/* Not a commit -- keep it */
 		if (!commit)
@@ -321,7 +322,7 @@ static int push_tip_to_list(const char *refname, const struct object_id *oid,
 	struct commit *tip_commit;
 	if (flags & REF_ISSYMREF)
 		return 0;
-	tip_commit = lookup_commit_reference_gently(oid, 1);
+	tip_commit = lookup_commit_reference_gently(the_repository, oid, 1);
 	if (!tip_commit)
 		return 0;
 	commit_list_insert(tip_commit, list);
@@ -338,7 +339,8 @@ static void reflog_expiry_prepare(const char *refname,
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
index e8a4aa40cb..fb90c9ab3e 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -360,7 +360,8 @@ static void sort_ref_range(int bottom, int top)
 static int append_ref(const char *refname, const struct object_id *oid,
 		      int allow_dups)
 {
-	struct commit *commit = lookup_commit_reference_gently(oid, 1);
+	struct commit *commit = lookup_commit_reference_gently(the_repository,
+							       oid, 1);
 	int i;
 
 	if (!commit)
diff --git a/commit.c b/commit.c
index 1b0e37f6f0..b6e253f1af 100644
--- a/commit.c
+++ b/commit.c
@@ -20,8 +20,8 @@ int save_commit_buffer = 1;
 
 const char *commit_type = "commit";
 
-struct commit *lookup_commit_reference_gently(const struct object_id *oid,
-					      int quiet)
+struct commit *lookup_commit_reference_gently_the_repository(
+		const struct object_id *oid, int quiet)
 {
 	struct object *obj = deref_tag(the_repository,
 				       parse_object(the_repository, oid),
@@ -34,7 +34,7 @@ struct commit *lookup_commit_reference_gently(const struct object_id *oid,
 
 struct commit *lookup_commit_reference(const struct object_id *oid)
 {
-	return lookup_commit_reference_gently(oid, 0);
+	return lookup_commit_reference_gently(the_repository, oid, 0);
 }
 
 struct commit *lookup_commit_or_die(const struct object_id *oid, const char *ref_name)
@@ -571,7 +571,8 @@ void clear_commit_marks_for_object_array(struct object_array *a, unsigned mark)
 
 	for (i = 0; i < a->nr; i++) {
 		object = a->objects[i].item;
-		commit = lookup_commit_reference_gently(&object->oid, 1);
+		commit = lookup_commit_reference_gently(the_repository,
+							&object->oid, 1);
 		if (commit)
 			clear_commit_marks(commit, mark);
 	}
diff --git a/commit.h b/commit.h
index 8c68ca1a5a..2ce5597066 100644
--- a/commit.h
+++ b/commit.h
@@ -48,7 +48,10 @@ const struct name_decoration *get_name_decoration(const struct object *obj);
 
 struct commit *lookup_commit(const struct object_id *oid);
 struct commit *lookup_commit_reference(const struct object_id *oid);
-struct commit *lookup_commit_reference_gently(const struct object_id *oid,
+#define lookup_commit_reference_gently(r, o, q) \
+		lookup_commit_reference_gently_##r(o, q)
+struct commit *lookup_commit_reference_gently_the_repository(
+					      const struct object_id *oid,
 					      int quiet);
 struct commit *lookup_commit_reference_by_name(const char *name);
 
diff --git a/contrib/coccinelle/object_parser.cocci b/contrib/coccinelle/object_parser.cocci
index 7ddd9f11ce..7c1ef62e6d 100644
--- a/contrib/coccinelle/object_parser.cocci
+++ b/contrib/coccinelle/object_parser.cocci
@@ -59,3 +59,11 @@ expression E;
  lookup_object(
 +the_repository,
  E)
+
+@@
+expression E;
+expression F;
+@@
+ lookup_commit_reference_gently(
++the_repository,
+ E, F)
diff --git a/fast-import.c b/fast-import.c
index 5618087015..54c2e10656 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1765,8 +1765,10 @@ static int update_branch(struct branch *b)
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
index ee513e87a9..6348baeb07 100644
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
index 1d0bad5e36..b4b6f8801c 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1914,7 +1914,8 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 	 * non-commits early. The actual filtering is done later.
 	 */
 	if (filter->merge_commit || filter->with_commit || filter->no_commit || filter->verbose) {
-		commit = lookup_commit_reference_gently(oid, 1);
+		commit = lookup_commit_reference_gently(the_repository, oid,
+							1);
 		if (!commit)
 			return 0;
 		/* We perform the filtering for the '--contains' option... */
@@ -2251,7 +2252,8 @@ int parse_opt_merge_filter(const struct option *opt, const char *arg, int unset)
 	if (get_oid(arg, &oid))
 		die(_("malformed object name %s"), arg);
 
-	rf->merge_commit = lookup_commit_reference_gently(&oid, 0);
+	rf->merge_commit = lookup_commit_reference_gently(the_repository,
+							  &oid, 0);
 	if (!rf->merge_commit)
 		return opterror(opt, "must point to a commit", 0);
 
diff --git a/remote.c b/remote.c
index 8d84e26dd4..a9386476fe 100644
--- a/remote.c
+++ b/remote.c
@@ -1323,7 +1323,7 @@ static void add_to_tips(struct tips *tips, const struct object_id *oid)
 
 	if (is_null_oid(oid))
 		return;
-	commit = lookup_commit_reference_gently(oid, 1);
+	commit = lookup_commit_reference_gently(the_repository, oid, 1);
 	if (!commit || (commit->object.flags & TMP_MARK))
 		return;
 	commit->object.flags |= TMP_MARK;
@@ -1385,7 +1385,8 @@ static void add_missing_tags(struct ref *src, struct ref **dst, struct ref ***ds
 
 			if (is_null_oid(&ref->new_oid))
 				continue;
-			commit = lookup_commit_reference_gently(&ref->new_oid,
+			commit = lookup_commit_reference_gently(the_repository,
+								&ref->new_oid,
 								1);
 			if (!commit)
 				/* not pushing a commit, which is not an error */
@@ -1613,8 +1614,8 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
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
index 6533b97138..d0c3c808aa 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2347,7 +2347,7 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 			continue;
 
 		if (!get_oid(name, &oid)) {
-			if (!lookup_commit_reference_gently(&oid, 1)) {
+			if (!lookup_commit_reference_gently(the_repository, &oid, 1)) {
 				enum object_type type = sha1_object_info(the_repository,
 									 oid.hash,
 									 NULL);
diff --git a/sha1_name.c b/sha1_name.c
index 117c080fd4..160fec7062 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1257,13 +1257,13 @@ int get_oid_mb(const char *name, struct object_id *oid)
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
index aa6d04992c..b62dd2c5fb 100644
--- a/shallow.c
+++ b/shallow.c
@@ -474,7 +474,8 @@ static void paint_down(struct paint_info *info, const struct object_id *oid,
 	struct commit_list *head = NULL;
 	int bitmap_nr = DIV_ROUND_UP(info->nr_bits, 32);
 	size_t bitmap_size = st_mult(sizeof(uint32_t), bitmap_nr);
-	struct commit *c = lookup_commit_reference_gently(oid, 1);
+	struct commit *c = lookup_commit_reference_gently(the_repository, oid,
+							  1);
 	uint32_t *tmp; /* to be freed before return */
 	uint32_t *bitmap;
 
@@ -536,7 +537,8 @@ static void paint_down(struct paint_info *info, const struct object_id *oid,
 static int mark_uninteresting(const char *refname, const struct object_id *oid,
 			      int flags, void *cb_data)
 {
-	struct commit *commit = lookup_commit_reference_gently(oid, 1);
+	struct commit *commit = lookup_commit_reference_gently(the_repository,
+							       oid, 1);
 	if (!commit)
 		return 0;
 	commit->object.flags |= UNINTERESTING;
@@ -646,7 +648,8 @@ static int add_ref(const char *refname, const struct object_id *oid,
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
index 5cfd2316a8..2b6bd9da81 100644
--- a/walker.c
+++ b/walker.c
@@ -210,7 +210,8 @@ static int interpret_target(struct walker *walker, char *target, struct object_i
 static int mark_complete(const char *path, const struct object_id *oid,
 			 int flag, void *cb_data)
 {
-	struct commit *commit = lookup_commit_reference_gently(oid, 1);
+	struct commit *commit = lookup_commit_reference_gently(the_repository,
+							       oid, 1);
 
 	if (commit) {
 		commit->object.flags |= COMPLETE;
diff --git a/wt-status.c b/wt-status.c
index ef26f07446..6655bc6f67 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1458,7 +1458,7 @@ static void wt_status_get_detached_from(struct wt_status_state *state)
 	    /* sha1 is a commit? match without further lookup */
 	    (!oidcmp(&cb.noid, &oid) ||
 	     /* perhaps sha1 is a tag, try to dereference to a commit */
-	     ((commit = lookup_commit_reference_gently(&oid, 1)) != NULL &&
+	     ((commit = lookup_commit_reference_gently(the_repository, &oid, 1)) != NULL &&
 	      !oidcmp(&cb.noid, &commit->object.oid)))) {
 		const char *from = ref;
 		if (!skip_prefix(from, "refs/tags/", &from))
-- 
2.15.1.433.g936d1b9894.dirty

