Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E9331F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752213AbeBFAOB (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:14:01 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:38298 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752203AbeBFAN7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:13:59 -0500
Received: by mail-pl0-f66.google.com with SMTP id 13so114391plb.5
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OaZR5A1rKwRWxbjRp50jUbzmqsJaloc9k9jHsjUh9cg=;
        b=EZCmHJJy0/seDzkDLmHKRjKHpMxnWocyTFW+42OeUIaZTfuIhThv63MYivzJtE93qq
         8yxRnx6RT9e41/UDAEepUMo8i9VXputScFBdHAbFyqfWirZ9QsY0e5YQ8jXZ588IwCNC
         /VYuztaEyxf8mJnj7FIAwvU0sXktcu91phpUo/KJqZuHeNy/U253E4wSoQafnEqyRTmA
         yeKXKcuQkbu4W0iuPv2V1tqeRdnnywpkWKg8pkK92i/0dxODlGPfvG57qa5B8T3TZvFI
         tQFa7DAJbhodF1pHn+s2D724FUdlJdC1zsqhkmhDfzGap1w1h8XFF2N/SUoaXSPtvet9
         1zlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OaZR5A1rKwRWxbjRp50jUbzmqsJaloc9k9jHsjUh9cg=;
        b=UG+eUaBhTo7piuKqVRfAr/UsK7i6uVoiyGr4wyyDKidHL8TPY6wUfRj4kepHp4HGWv
         O9T+LnX+IiU6XV15iusP5WPIkJdcV7qvccHi3z46Pt14GIVsC/t6fO7f5HPuELhFhVRa
         ESMEJTe98AKP9KGaDy0T/ANil63Fvc8qYw6LxVScVF/6zw33d0FQ4G3hJKjV12QeYaRp
         i6Eij8k9VxzI40YMA4vDv2thaZgymealz6rOwYAKl+C6DIiGnha8u9ldCIElGKvctP4V
         29ZDpoq6bZfii5l7RgRPFQ63qkHoFByvxD0H1Jg9RsKMRycIfm2KuowYsPtd1lq4MxCi
         8vhw==
X-Gm-Message-State: APf1xPAS4rCcjNeSAqwNO+qB/8BkEnfp/MY9ro+4hZSQHbwiuZiQ/Xr6
        2Ag07OamcFFuEHt8yYtmnQxoRq3QiKUVZXnN0VR2BmunDYli7yzOIe6+1DGeImX1tvmoebEc9ay
        yJf1ShbMK
X-Google-Smtp-Source: AH8x22624KdHrPfgbNXbwPRIyZC+ZcuX96JVrGLAV/MdTaCHKdvm/9D+5NZXIAbufjSQaBSjiUMR+A==
X-Received: by 2002:a17:902:5303:: with SMTP id b3-v6mr512404pli.133.1517876037885;
        Mon, 05 Feb 2018 16:13:57 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id k195sm13737675pgc.61.2018.02.05.16.13.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:13:57 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 091/194] object: add repository argument to lookup_commit
Date:   Mon,  5 Feb 2018 15:55:52 -0800
Message-Id: <20180205235735.216710-71-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
X-ccpol: medium
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>

Add a repository argument to allow callers of lookup_commit to be more
specific about which repository to handle. This is a small mechanical
change; it doesn't change the implementation to handle repositories
other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

The included coccinelle semantic patch will adapt any new callers in
the diff produced by `make coccicheck`.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/am.c                           |  3 ++-
 builtin/commit-tree.c                  |  4 +++-
 builtin/commit.c                       |  2 +-
 builtin/diff-tree.c                    |  2 +-
 builtin/fast-export.c                  |  2 +-
 builtin/fmt-merge-msg.c                |  2 +-
 builtin/merge-base.c                   |  2 +-
 builtin/verify-commit.c                |  4 +++-
 commit.c                               |  7 ++++---
 commit.h                               |  3 ++-
 contrib/coccinelle/object_parser.cocci |  7 +++++++
 fetch-pack.c                           |  3 ++-
 log-tree.c                             |  2 +-
 notes-utils.c                          |  4 +++-
 object.c                               |  2 +-
 sequencer.c                            |  2 +-
 sha1_name.c                            |  2 +-
 shallow.c                              | 17 ++++++++++-------
 tag.c                                  |  2 +-
 tree.c                                 |  2 +-
 20 files changed, 47 insertions(+), 27 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 32002a8661..83bc22649e 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1629,7 +1629,8 @@ static void do_commit(const struct am_state *state)
 
 	if (!get_oid_commit("HEAD", &parent)) {
 		old_oid = &parent;
-		commit_list_insert(lookup_commit(&parent), &parents);
+		commit_list_insert(lookup_commit(the_repository, &parent),
+				   &parents);
 	} else {
 		old_oid = NULL;
 		say(state, stderr, _("applying to an empty history"));
diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index a54fb362ce..4f4fcace3b 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -6,6 +6,7 @@
 #include "cache.h"
 #include "config.h"
 #include "object-store.h"
+#include "repository.h"
 #include "commit.h"
 #include "tree.h"
 #include "builtin.h"
@@ -60,7 +61,8 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 			if (get_oid_commit(argv[i], &oid))
 				die("Not a valid object name %s", argv[i]);
 			assert_sha1_type(oid.hash, OBJ_COMMIT);
-			new_parent(lookup_commit(&oid), &parents);
+			new_parent(lookup_commit(the_repository, &oid),
+				   &parents);
 			continue;
 		}
 
diff --git a/builtin/commit.c b/builtin/commit.c
index 8a87701414..cd3144f9f4 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1464,7 +1464,7 @@ static void print_summary(const char *prefix, const struct object_id *oid,
 	struct strbuf author_ident = STRBUF_INIT;
 	struct strbuf committer_ident = STRBUF_INIT;
 
-	commit = lookup_commit(oid);
+	commit = lookup_commit(the_repository, oid);
 	if (!commit)
 		die(_("couldn't look up newly created commit"));
 	if (parse_commit(commit))
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 603f619532..62c435a65f 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -25,7 +25,7 @@ static int stdin_diff_commit(struct commit *commit, const char *p)
 
 	/* Graft the fake parents locally to the commit */
 	while (isspace(*p++) && !parse_oid_hex(p, &oid, &p)) {
-		struct commit *parent = lookup_commit(&oid);
+		struct commit *parent = lookup_commit(the_repository, &oid);
 		if (!pptr) {
 			/* Free the real parent list */
 			free_commit_list(commit->parents);
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 14a27d539f..322adfd408 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -958,7 +958,7 @@ static void import_marks(char *input_file)
 			/* only commits */
 			continue;
 
-		commit = lookup_commit(&oid);
+		commit = lookup_commit(the_repository, &oid);
 		if (!commit)
 			die("not a commit? can't happen: %s", oid_to_hex(&oid));
 
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 49fd7ea1d2..3e99d10218 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -573,7 +573,7 @@ static void find_merge_parents(struct merge_parents *result,
 		commit_list_insert(parent, &parents);
 		add_merge_parent(result, &obj->oid, &parent->object.oid);
 	}
-	head_commit = lookup_commit(head);
+	head_commit = lookup_commit(the_repository, head);
 	if (head_commit)
 		commit_list_insert(head_commit, &parents);
 	reduce_heads_replace(&parents);
diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index bbead6f33e..08d91b1f0c 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -124,7 +124,7 @@ static void add_one_commit(struct object_id *oid, struct rev_collect *revs)
 	if (is_null_oid(oid))
 		return;
 
-	commit = lookup_commit(oid);
+	commit = lookup_commit(the_repository, oid);
 	if (!commit ||
 	    (commit->object.flags & TMP_MARK) ||
 	    parse_commit(commit))
diff --git a/builtin/verify-commit.c b/builtin/verify-commit.c
index 29f5e5507c..b0ae18ec33 100644
--- a/builtin/verify-commit.c
+++ b/builtin/verify-commit.c
@@ -9,6 +9,7 @@
 #include "config.h"
 #include "builtin.h"
 #include "object-store.h"
+#include "repository.h"
 #include "commit.h"
 #include "run-command.h"
 #include <signal.h>
@@ -27,7 +28,8 @@ static int run_gpg_verify(const struct object_id *oid, const char *buf, unsigned
 
 	memset(&signature_check, 0, sizeof(signature_check));
 
-	ret = check_commit_signature(lookup_commit(oid), &signature_check);
+	ret = check_commit_signature(lookup_commit(the_repository, oid),
+				     &signature_check);
 	print_signature_buffer(&signature_check, flags);
 
 	signature_check_clear(&signature_check);
diff --git a/commit.c b/commit.c
index b943b97aee..2137a0b9c6 100644
--- a/commit.c
+++ b/commit.c
@@ -49,7 +49,7 @@ struct commit *lookup_commit_or_die(const struct object_id *oid, const char *ref
 	return c;
 }
 
-struct commit *lookup_commit(const struct object_id *oid)
+struct commit *lookup_commit_the_repository(const struct object_id *oid)
 {
 	struct object *obj = lookup_object(the_repository, oid->hash);
 	if (!obj)
@@ -359,7 +359,7 @@ int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long s
 		 */
 		if (graft && (graft->nr_parent < 0 || grafts_replace_parents))
 			continue;
-		new_parent = lookup_commit(&parent);
+		new_parent = lookup_commit(the_repository, &parent);
 		if (new_parent)
 			pptr = &commit_list_insert(new_parent, pptr)->next;
 	}
@@ -367,7 +367,8 @@ int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long s
 		int i;
 		struct commit *new_parent;
 		for (i = 0; i < graft->nr_parent; i++) {
-			new_parent = lookup_commit(&graft->parent[i]);
+			new_parent = lookup_commit(the_repository,
+						   &graft->parent[i]);
 			if (!new_parent)
 				continue;
 			pptr = &commit_list_insert(new_parent, pptr)->next;
diff --git a/commit.h b/commit.h
index 9159165fde..61e01112eb 100644
--- a/commit.h
+++ b/commit.h
@@ -46,7 +46,8 @@ enum decoration_type {
 void add_name_decoration(enum decoration_type type, const char *name, struct object *obj);
 const struct name_decoration *get_name_decoration(const struct object *obj);
 
-struct commit *lookup_commit(const struct object_id *oid);
+#define lookup_commit(r, o) lookup_commit_##r(o)
+struct commit *lookup_commit_the_repository(const struct object_id *oid);
 #define lookup_commit_reference(r, o) \
 		lookup_commit_reference_##r(o)
 struct commit *lookup_commit_reference_the_repository(const struct object_id *oid);
diff --git a/contrib/coccinelle/object_parser.cocci b/contrib/coccinelle/object_parser.cocci
index bc00029f8c..c3cc4dfc9e 100644
--- a/contrib/coccinelle/object_parser.cocci
+++ b/contrib/coccinelle/object_parser.cocci
@@ -74,3 +74,10 @@ expression E;
  lookup_commit_reference(
 +the_repository,
  E)
+
+@@
+expression E;
+@@
+ lookup_commit(
++the_repository,
+ E)
diff --git a/fetch-pack.c b/fetch-pack.c
index ee1e65688a..f38beea6a3 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -491,7 +491,8 @@ static int find_common(struct fetch_pack_args *args,
 				case ACK_ready:
 				case ACK_continue: {
 					struct commit *commit =
-						lookup_commit(result_oid);
+						lookup_commit(the_repository,
+							      result_oid);
 					if (!commit)
 						die(_("invalid commit %s"), oid_to_hex(result_oid));
 					if (args->stateless_rpc
diff --git a/log-tree.c b/log-tree.c
index 1137506884..9fb333605b 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -147,7 +147,7 @@ static int add_ref_decoration(const char *refname, const struct object_id *oid,
 
 static int add_graft_decoration(const struct commit_graft *graft, void *cb_data)
 {
-	struct commit *commit = lookup_commit(&graft->oid);
+	struct commit *commit = lookup_commit(the_repository, &graft->oid);
 	if (!commit)
 		return 0;
 	add_name_decoration(DECORATION_GRAFTED, "grafted", &commit->object);
diff --git a/notes-utils.c b/notes-utils.c
index 5c8e70c98f..3ef5340c6e 100644
--- a/notes-utils.c
+++ b/notes-utils.c
@@ -3,6 +3,7 @@
 #include "commit.h"
 #include "refs.h"
 #include "notes-utils.h"
+#include "repository.h"
 
 void create_notes_commit(struct notes_tree *t, struct commit_list *parents,
 			 const char *msg, size_t msg_len,
@@ -19,7 +20,8 @@ void create_notes_commit(struct notes_tree *t, struct commit_list *parents,
 		/* Deduce parent commit from t->ref */
 		struct object_id parent_oid;
 		if (!read_ref(t->ref, &parent_oid)) {
-			struct commit *parent = lookup_commit(&parent_oid);
+			struct commit *parent = lookup_commit(the_repository,
+							      &parent_oid);
 			if (parse_commit(parent))
 				die("Failed to find/parse commit %s", t->ref);
 			commit_list_insert(parent, &parents);
diff --git a/object.c b/object.c
index c9ce89cf37..6676887315 100644
--- a/object.c
+++ b/object.c
@@ -209,7 +209,7 @@ struct object *parse_object_buffer(const struct object_id *oid, enum object_type
 			}
 		}
 	} else if (type == OBJ_COMMIT) {
-		struct commit *commit = lookup_commit(oid);
+		struct commit *commit = lookup_commit(the_repository, oid);
 		if (commit) {
 			if (parse_commit_buffer(commit, buffer, size))
 				return NULL;
diff --git a/sequencer.c b/sequencer.c
index d24586bc6f..4d259d9ae4 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -497,7 +497,7 @@ static int is_index_unchanged(void)
 	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, &head_oid, NULL))
 		return error(_("could not resolve HEAD commit"));
 
-	head_commit = lookup_commit(&head_oid);
+	head_commit = lookup_commit(the_repository, &head_oid);
 
 	/*
 	 * If head_commit is NULL, check_commit, called from
diff --git a/sha1_name.c b/sha1_name.c
index ea169a28c1..45b7d6be91 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -374,7 +374,7 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 
 	type = sha1_object_info(the_repository, oid->hash, NULL);
 	if (type == OBJ_COMMIT) {
-		struct commit *commit = lookup_commit(oid);
+		struct commit *commit = lookup_commit(the_repository, oid);
 		if (commit) {
 			struct pretty_print_context pp = {0};
 			pp.date_mode.type = DATE_SHORT;
diff --git a/shallow.c b/shallow.c
index b62dd2c5fb..97c483239a 100644
--- a/shallow.c
+++ b/shallow.c
@@ -32,7 +32,7 @@ int register_shallow(const struct object_id *oid)
 {
 	struct commit_graft *graft =
 		xmalloc(sizeof(struct commit_graft));
-	struct commit *commit = lookup_commit(oid);
+	struct commit *commit = lookup_commit(the_repository, oid);
 
 	oidcpy(&graft->oid, oid);
 	graft->nr_parent = -1;
@@ -244,7 +244,7 @@ static int write_one_shallow(const struct commit_graft *graft, void *cb_data)
 	if (graft->nr_parent != -1)
 		return 0;
 	if (data->flags & SEEN_ONLY) {
-		struct commit *c = lookup_commit(&graft->oid);
+		struct commit *c = lookup_commit(the_repository, &graft->oid);
 		if (!c || !(c->object.flags & SEEN)) {
 			if (data->flags & VERBOSE)
 				printf("Removing %s from .git/shallow\n",
@@ -606,7 +606,8 @@ void assign_shallow_commits_to_refs(struct shallow_info *info,
 
 	/* Mark potential bottoms so we won't go out of bound */
 	for (i = 0; i < nr_shallow; i++) {
-		struct commit *c = lookup_commit(&oid[shallow[i]]);
+		struct commit *c = lookup_commit(the_repository,
+						 &oid[shallow[i]]);
 		c->object.flags |= BOTTOM;
 	}
 
@@ -617,7 +618,8 @@ void assign_shallow_commits_to_refs(struct shallow_info *info,
 		int bitmap_size = DIV_ROUND_UP(pi.nr_bits, 32) * sizeof(uint32_t);
 		memset(used, 0, sizeof(*used) * info->shallow->nr);
 		for (i = 0; i < nr_shallow; i++) {
-			const struct commit *c = lookup_commit(&oid[shallow[i]]);
+			const struct commit *c = lookup_commit(the_repository,
+							       &oid[shallow[i]]);
 			uint32_t **map = ref_bitmap_at(&pi.ref_bitmap, c);
 			if (*map)
 				used[shallow[i]] = xmemdupz(*map, bitmap_size);
@@ -687,7 +689,7 @@ static void post_assign_shallow(struct shallow_info *info,
 	for (i = dst = 0; i < info->nr_theirs; i++) {
 		if (i != dst)
 			info->theirs[dst] = info->theirs[i];
-		c = lookup_commit(&oid[info->theirs[i]]);
+		c = lookup_commit(the_repository, &oid[info->theirs[i]]);
 		bitmap = ref_bitmap_at(ref_bitmap, c);
 		if (!*bitmap)
 			continue;
@@ -708,7 +710,7 @@ static void post_assign_shallow(struct shallow_info *info,
 	for (i = dst = 0; i < info->nr_ours; i++) {
 		if (i != dst)
 			info->ours[dst] = info->ours[i];
-		c = lookup_commit(&oid[info->ours[i]]);
+		c = lookup_commit(the_repository, &oid[info->ours[i]]);
 		bitmap = ref_bitmap_at(ref_bitmap, c);
 		if (!*bitmap)
 			continue;
@@ -730,7 +732,8 @@ static void post_assign_shallow(struct shallow_info *info,
 int delayed_reachability_test(struct shallow_info *si, int c)
 {
 	if (si->need_reachability_test[c]) {
-		struct commit *commit = lookup_commit(&si->shallow->oid[c]);
+		struct commit *commit = lookup_commit(the_repository,
+						      &si->shallow->oid[c]);
 
 		if (!si->commits) {
 			struct commit_array ca;
diff --git a/tag.c b/tag.c
index d8174e0405..da2fe4f2ee 100644
--- a/tag.c
+++ b/tag.c
@@ -150,7 +150,7 @@ int parse_tag_buffer_the_repository(struct tag *item, const void *data, unsigned
 	} else if (!strcmp(type, tree_type)) {
 		item->tagged = (struct object *)lookup_tree(the_repository, &oid);
 	} else if (!strcmp(type, commit_type)) {
-		item->tagged = (struct object *)lookup_commit(&oid);
+		item->tagged = (struct object *)lookup_commit(the_repository, &oid);
 	} else if (!strcmp(type, tag_type)) {
 		item->tagged = (struct object *)lookup_tag(the_repository, &oid);
 	} else {
diff --git a/tree.c b/tree.c
index b0d8610c41..6e0aafa805 100644
--- a/tree.c
+++ b/tree.c
@@ -100,7 +100,7 @@ static int read_tree_1(struct tree *tree, struct strbuf *base,
 		else if (S_ISGITLINK(entry.mode)) {
 			struct commit *commit;
 
-			commit = lookup_commit(entry.oid);
+			commit = lookup_commit(the_repository, entry.oid);
 			if (!commit)
 				die("Commit %s in submodule path %s%s not found",
 				    oid_to_hex(entry.oid),
-- 
2.15.1.433.g936d1b9894.dirty

