Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D5241F403
	for <e@80x24.org>; Wed, 13 Jun 2018 23:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935894AbeFMXF5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 19:05:57 -0400
Received: from mail-qt0-f202.google.com ([209.85.216.202]:38940 "EHLO
        mail-qt0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935432AbeFMXFx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 19:05:53 -0400
Received: by mail-qt0-f202.google.com with SMTP id c1-v6so3147525qtj.6
        for <git@vger.kernel.org>; Wed, 13 Jun 2018 16:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=LT6vJYqYzQdbqi0L4JCyJTNhj4n9KmzrqmLGpaI/xLY=;
        b=j3a8agMPVXF1jH5BqHDINZu+mtSoRdVDOqfqXul6zfbRxaGL/xalIvs8kQk0kZyzDo
         /O7bZd9jhM+2CL/aqEE+DnVN8DHpRrc/hAxGekbFrCygi8G+5GYioLkSBlYEJoKgFaRI
         f0MvMcEiUTZbOkzN1FxIT6zuobt2cLGlJXbJF/OGq25h+K06m8mjMfvEQusU60KdGqCR
         KuOsOdocWc7Sp4DTo62DxGOLuYXVWKDhCtCkzKHI3g1l75A6RfqW+Sb1+iPwj7D9FHaR
         4c7Lo/yug8U2ptr6T1d4/anGToiHF/BFKap2mJ+iBUqmlPjN2sx+e//FOOWs6xqoeJWO
         Zytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=LT6vJYqYzQdbqi0L4JCyJTNhj4n9KmzrqmLGpaI/xLY=;
        b=EBvy/yVTr1Nvd/XFThklcHNxYC653f6tVwiie6Vhhumhr9W4vZS6zv97aGi1owpNNd
         EETBHpycvuss/84vnxHWhrmHP7RH77LDbDu+H7ULu+epWKotbwQ3nVff4MSAyVR+UdqX
         Zday+4p7Wai9fpfgf+Vw6TX0Jk8/B7ZY8Owp5ME4FB55DiuyA3WaE7pDUxkn3l3NhFl8
         DYw8fp6Cmot31/gqtpLgxSbjh/j03WGPwsMrMpKTGyBK5i5z2e91O9XcKR9LYzEdFCsx
         8p/M/pGdTJl7gJrIogAFnZipATXyT+V3L8UI3HXWxc1YTn/S3eEzcJyoOuxCV2+8/6qF
         3pNw==
X-Gm-Message-State: APt69E33Saes8w6dB5ld4bqK+NrUxkR/JbgZfanIdsmEf7x8ij/BOjZw
        N8+wLODA+ERHCmmUlfhMPFJmY2AKzc2S7Akru11dM4lI7JReYfawGS358WLiR5RTfERMEXRiyBK
        qoQAyifa13FpVYB+gKZ/4/SZnvQFSB16hMy3yPrCrVsOItNgn2NZHzsJtvRS4
X-Google-Smtp-Source: ADUXVKIwYhn/NY674+rhkSDj+60efb+hKnZRBK8a5fIXkWyTRIHnAICSBpG8xkw4doYLXWMDAag2W2ToA8sF
MIME-Version: 1.0
X-Received: by 2002:ac8:2247:: with SMTP id p7-v6mr94445qtp.58.1528931153050;
 Wed, 13 Jun 2018 16:05:53 -0700 (PDT)
Date:   Wed, 13 Jun 2018 16:04:59 -0700
In-Reply-To: <20180613230522.55335-1-sbeller@google.com>
Message-Id: <20180613230522.55335-9-sbeller@google.com>
References: <20180530004810.30076-1-sbeller@google.com> <20180613230522.55335-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Subject: [PATCH v2 08/31] commit: add repository argument to lookup_commit
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow callers of lookup_commit to be more
specific about which repository to handle. This is a small mechanical
change; it doesn't change the implementation to handle repositories
other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/am.c            |  3 ++-
 builtin/commit-tree.c   |  4 +++-
 builtin/diff-tree.c     |  2 +-
 builtin/fast-export.c   |  2 +-
 builtin/fmt-merge-msg.c |  2 +-
 builtin/merge-base.c    |  2 +-
 builtin/verify-commit.c |  4 +++-
 commit-graph.c          | 10 +++++-----
 commit.c                |  7 ++++---
 commit.h                |  3 ++-
 fetch-pack.c            |  5 +++--
 log-tree.c              |  2 +-
 notes-utils.c           |  4 +++-
 object.c                |  2 +-
 sequencer.c             |  4 ++--
 sha1-name.c             |  2 +-
 shallow.c               | 17 ++++++++++-------
 tag.c                   |  2 +-
 tree.c                  |  2 +-
 19 files changed, 46 insertions(+), 33 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index f4b510bcc5f..fb7c21f7103 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1633,7 +1633,8 @@ static void do_commit(const struct am_state *state)
 
 	if (!get_oid_commit("HEAD", &parent)) {
 		old_oid = &parent;
-		commit_list_insert(lookup_commit(&parent), &parents);
+		commit_list_insert(lookup_commit(the_repository, &parent),
+				   &parents);
 	} else {
 		old_oid = NULL;
 		say(state, stderr, _("applying to an empty history"));
diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index 9fbd3529fb1..9ec36a82b63 100644
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
 			assert_oid_type(&oid, OBJ_COMMIT);
-			new_parent(lookup_commit(&oid), &parents);
+			new_parent(lookup_commit(the_repository, &oid),
+						 &parents);
 			continue;
 		}
 
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index a5718d96ee2..91ba67070e2 100644
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
index 23ca46e6008..bc837d2593c 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -964,7 +964,7 @@ static void import_marks(char *input_file)
 			/* only commits */
 			continue;
 
-		commit = lookup_commit(&oid);
+		commit = lookup_commit(the_repository, &oid);
 		if (!commit)
 			die("not a commit? can't happen: %s", oid_to_hex(&oid));
 
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 5e44589b545..36318ef46e7 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -572,7 +572,7 @@ static void find_merge_parents(struct merge_parents *result,
 		commit_list_insert(parent, &parents);
 		add_merge_parent(result, &obj->oid, &parent->object.oid);
 	}
-	head_commit = lookup_commit(head);
+	head_commit = lookup_commit(the_repository, head);
 	if (head_commit)
 		commit_list_insert(head_commit, &parents);
 	reduce_heads_replace(&parents);
diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index bbead6f33e5..08d91b1f0c0 100644
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
index f6922da16d6..7772c07ed7a 100644
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
diff --git a/commit-graph.c b/commit-graph.c
index 5345cc90ed1..6c08fc0a9ba 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -241,7 +241,7 @@ static struct commit_list **insert_parent_or_die(struct commit_graph *g,
 	struct commit *c;
 	struct object_id oid;
 	hashcpy(oid.hash, g->chunk_oid_lookup + g->hash_len * pos);
-	c = lookup_commit(&oid);
+	c = lookup_commit(the_repository, &oid);
 	if (!c)
 		die("could not find commit %s", oid_to_hex(&oid));
 	c->graph_pos = pos;
@@ -527,7 +527,7 @@ static void close_reachable(struct packed_oid_list *oids)
 	struct commit *commit;
 
 	for (i = 0; i < oids->nr; i++) {
-		commit = lookup_commit(&oids->list[i]);
+		commit = lookup_commit(the_repository, &oids->list[i]);
 		if (commit)
 			commit->object.flags |= UNINTERESTING;
 	}
@@ -538,14 +538,14 @@ static void close_reachable(struct packed_oid_list *oids)
 	 * closure.
 	 */
 	for (i = 0; i < oids->nr; i++) {
-		commit = lookup_commit(&oids->list[i]);
+		commit = lookup_commit(the_repository, &oids->list[i]);
 
 		if (commit && !parse_commit(commit))
 			add_missing_parents(oids, commit);
 	}
 
 	for (i = 0; i < oids->nr; i++) {
-		commit = lookup_commit(&oids->list[i]);
+		commit = lookup_commit(the_repository, &oids->list[i]);
 
 		if (commit)
 			commit->object.flags &= ~UNINTERESTING;
@@ -658,7 +658,7 @@ void write_commit_graph(const char *obj_dir,
 		if (i > 0 && !oidcmp(&oids.list[i-1], &oids.list[i]))
 			continue;
 
-		commits.list[commits.nr] = lookup_commit(&oids.list[i]);
+		commits.list[commits.nr] = lookup_commit(the_repository, &oids.list[i]);
 		parse_commit(commits.list[commits.nr]);
 
 		for (parent = commits.list[commits.nr]->parents;
diff --git a/commit.c b/commit.c
index e031a6c3175..5e3f18801a1 100644
--- a/commit.c
+++ b/commit.c
@@ -51,7 +51,7 @@ struct commit *lookup_commit_or_die(const struct object_id *oid, const char *ref
 	return c;
 }
 
-struct commit *lookup_commit(const struct object_id *oid)
+struct commit *lookup_commit_the_repository(const struct object_id *oid)
 {
 	struct object *obj = lookup_object(the_repository, oid->hash);
 	if (!obj)
@@ -373,7 +373,7 @@ int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long s
 		 */
 		if (graft && (graft->nr_parent < 0 || grafts_replace_parents))
 			continue;
-		new_parent = lookup_commit(&parent);
+		new_parent = lookup_commit(the_repository, &parent);
 		if (new_parent)
 			pptr = &commit_list_insert(new_parent, pptr)->next;
 	}
@@ -381,7 +381,8 @@ int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long s
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
index a5f84466efd..431a7d97a24 100644
--- a/commit.h
+++ b/commit.h
@@ -53,7 +53,8 @@ enum decoration_type {
 void add_name_decoration(enum decoration_type type, const char *name, struct object *obj);
 const struct name_decoration *get_name_decoration(const struct object *obj);
 
-struct commit *lookup_commit(const struct object_id *oid);
+#define lookup_commit(r, o) lookup_commit_##r(o)
+struct commit *lookup_commit_the_repository(const struct object_id *oid);
 #define lookup_commit_reference(r, o) \
 		lookup_commit_reference_##r(o)
 struct commit *lookup_commit_reference_the_repository(const struct object_id *oid);
diff --git a/fetch-pack.c b/fetch-pack.c
index 4523e25ff4e..74ac2977e85 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -498,7 +498,8 @@ static int find_common(struct fetch_pack_args *args,
 				case ACK_ready:
 				case ACK_continue: {
 					struct commit *commit =
-						lookup_commit(result_oid);
+						lookup_commit(the_repository,
+							      result_oid);
 					if (!commit)
 						die(_("invalid commit %s"), oid_to_hex(result_oid));
 					if (args->stateless_rpc
@@ -1256,7 +1257,7 @@ static int process_acks(struct packet_reader *reader, struct oidset *common)
 			if (!get_oid_hex(arg, &oid)) {
 				struct commit *commit;
 				oidset_insert(common, &oid);
-				commit = lookup_commit(&oid);
+				commit = lookup_commit(the_repository, &oid);
 				mark_common(commit, 0, 1);
 			}
 			continue;
diff --git a/log-tree.c b/log-tree.c
index e8d2857bf06..a47283eca64 100644
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
index 02407fe2a73..14ea03178e9 100644
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
index 1a67d6e341f..4eca16f4adb 100644
--- a/object.c
+++ b/object.c
@@ -212,7 +212,7 @@ struct object *parse_object_buffer_the_repository(const struct object_id *oid, e
 			}
 		}
 	} else if (type == OBJ_COMMIT) {
-		struct commit *commit = lookup_commit(oid);
+		struct commit *commit = lookup_commit(the_repository, oid);
 		if (commit) {
 			if (parse_commit_buffer(commit, buffer, size))
 				return NULL;
diff --git a/sequencer.c b/sequencer.c
index 8931c461f20..da6c9fc5511 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -543,7 +543,7 @@ static int is_index_unchanged(void)
 	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, &head_oid, NULL))
 		return error(_("could not resolve HEAD commit"));
 
-	head_commit = lookup_commit(&head_oid);
+	head_commit = lookup_commit(the_repository, &head_oid);
 
 	/*
 	 * If head_commit is NULL, check_commit, called from
@@ -972,7 +972,7 @@ void print_commit_summary(const char *prefix, const struct object_id *oid,
 	struct strbuf author_ident = STRBUF_INIT;
 	struct strbuf committer_ident = STRBUF_INIT;
 
-	commit = lookup_commit(oid);
+	commit = lookup_commit(the_repository, oid);
 	if (!commit)
 		die(_("couldn't look up newly created commit"));
 	if (parse_commit(commit))
diff --git a/sha1-name.c b/sha1-name.c
index d153d8c692b..5eef8ddd6d6 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -352,7 +352,7 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 
 	type = oid_object_info(the_repository, oid, NULL);
 	if (type == OBJ_COMMIT) {
-		struct commit *commit = lookup_commit(oid);
+		struct commit *commit = lookup_commit(the_repository, oid);
 		if (commit) {
 			struct pretty_print_context pp = {0};
 			pp.date_mode.type = DATE_SHORT;
diff --git a/shallow.c b/shallow.c
index 9bb07a56dca..60fe1fe1e58 100644
--- a/shallow.c
+++ b/shallow.c
@@ -31,7 +31,7 @@ int register_shallow(struct repository *r, const struct object_id *oid)
 {
 	struct commit_graft *graft =
 		xmalloc(sizeof(struct commit_graft));
-	struct commit *commit = lookup_commit(oid);
+	struct commit *commit = lookup_commit(the_repository, oid);
 
 	oidcpy(&graft->oid, oid);
 	graft->nr_parent = -1;
@@ -256,7 +256,7 @@ static int write_one_shallow(const struct commit_graft *graft, void *cb_data)
 	if (graft->nr_parent != -1)
 		return 0;
 	if (data->flags & SEEN_ONLY) {
-		struct commit *c = lookup_commit(&graft->oid);
+		struct commit *c = lookup_commit(the_repository, &graft->oid);
 		if (!c || !(c->object.flags & SEEN)) {
 			if (data->flags & VERBOSE)
 				printf("Removing %s from .git/shallow\n",
@@ -621,7 +621,8 @@ void assign_shallow_commits_to_refs(struct shallow_info *info,
 
 	/* Mark potential bottoms so we won't go out of bound */
 	for (i = 0; i < nr_shallow; i++) {
-		struct commit *c = lookup_commit(&oid[shallow[i]]);
+		struct commit *c = lookup_commit(the_repository,
+						 &oid[shallow[i]]);
 		c->object.flags |= BOTTOM;
 	}
 
@@ -632,7 +633,8 @@ void assign_shallow_commits_to_refs(struct shallow_info *info,
 		int bitmap_size = DIV_ROUND_UP(pi.nr_bits, 32) * sizeof(uint32_t);
 		memset(used, 0, sizeof(*used) * info->shallow->nr);
 		for (i = 0; i < nr_shallow; i++) {
-			const struct commit *c = lookup_commit(&oid[shallow[i]]);
+			const struct commit *c = lookup_commit(the_repository,
+							       &oid[shallow[i]]);
 			uint32_t **map = ref_bitmap_at(&pi.ref_bitmap, c);
 			if (*map)
 				used[shallow[i]] = xmemdupz(*map, bitmap_size);
@@ -702,7 +704,7 @@ static void post_assign_shallow(struct shallow_info *info,
 	for (i = dst = 0; i < info->nr_theirs; i++) {
 		if (i != dst)
 			info->theirs[dst] = info->theirs[i];
-		c = lookup_commit(&oid[info->theirs[i]]);
+		c = lookup_commit(the_repository, &oid[info->theirs[i]]);
 		bitmap = ref_bitmap_at(ref_bitmap, c);
 		if (!*bitmap)
 			continue;
@@ -723,7 +725,7 @@ static void post_assign_shallow(struct shallow_info *info,
 	for (i = dst = 0; i < info->nr_ours; i++) {
 		if (i != dst)
 			info->ours[dst] = info->ours[i];
-		c = lookup_commit(&oid[info->ours[i]]);
+		c = lookup_commit(the_repository, &oid[info->ours[i]]);
 		bitmap = ref_bitmap_at(ref_bitmap, c);
 		if (!*bitmap)
 			continue;
@@ -745,7 +747,8 @@ static void post_assign_shallow(struct shallow_info *info,
 int delayed_reachability_test(struct shallow_info *si, int c)
 {
 	if (si->need_reachability_test[c]) {
-		struct commit *commit = lookup_commit(&si->shallow->oid[c]);
+		struct commit *commit = lookup_commit(the_repository,
+						      &si->shallow->oid[c]);
 
 		if (!si->commits) {
 			struct commit_array ca;
diff --git a/tag.c b/tag.c
index 310102150ab..5dcdf7bf6f9 100644
--- a/tag.c
+++ b/tag.c
@@ -158,7 +158,7 @@ int parse_tag_buffer(struct tag *item, const void *data, unsigned long size)
 	} else if (!strcmp(type, tree_type)) {
 		item->tagged = (struct object *)lookup_tree(the_repository, &oid);
 	} else if (!strcmp(type, commit_type)) {
-		item->tagged = (struct object *)lookup_commit(&oid);
+		item->tagged = (struct object *)lookup_commit(the_repository, &oid);
 	} else if (!strcmp(type, tag_type)) {
 		item->tagged = (struct object *)lookup_tag(&oid);
 	} else {
diff --git a/tree.c b/tree.c
index fbc8d4bc653..33063b8dde0 100644
--- a/tree.c
+++ b/tree.c
@@ -101,7 +101,7 @@ static int read_tree_1(struct tree *tree, struct strbuf *base,
 		else if (S_ISGITLINK(entry.mode)) {
 			struct commit *commit;
 
-			commit = lookup_commit(entry.oid);
+			commit = lookup_commit(the_repository, entry.oid);
 			if (!commit)
 				die("Commit %s in submodule path %s%s not found",
 				    oid_to_hex(entry.oid),
-- 
2.18.0.rc1.244.gcf134e6275-goog

