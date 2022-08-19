Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFBCC32773
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 10:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348301AbiHSKIj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 06:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348205AbiHSKIg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 06:08:36 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6252B66A4C
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 03:08:33 -0700 (PDT)
Received: (qmail 17660 invoked by uid 109); 19 Aug 2022 10:08:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 Aug 2022 10:08:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 922 invoked by uid 111); 19 Aug 2022 10:08:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Aug 2022 06:08:35 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 19 Aug 2022 06:08:32 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 02/11] refs: mark unused each_ref_fn parameters
Message-ID: <Yv9hIG/TbBLdOAwa@coredump.intra.peff.net>
References: <Yv9gxqH6nK2KYnNj@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yv9gxqH6nK2KYnNj@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Functions used with for_each_ref(), etc, need to conform to the
each_ref_fn interface. But most of them don't need every parameter;
let's annotate the unused ones to quiet -Wunused-parameter.

Signed-off-by: Jeff King <peff@peff.net>
---
 bisect.c                    |  7 ++++---
 builtin/bisect--helper.c    | 12 +++++++-----
 builtin/checkout.c          |  2 +-
 builtin/describe.c          |  3 ++-
 builtin/fetch.c             |  7 ++++---
 builtin/fsck.c              |  7 ++++---
 builtin/gc.c                |  5 +++--
 builtin/name-rev.c          |  3 ++-
 builtin/pack-objects.c      | 12 +++++++-----
 builtin/receive-pack.c      |  2 +-
 builtin/reflog.c            |  3 ++-
 builtin/remote.c            | 12 ++++++++----
 builtin/repack.c            |  4 ++--
 builtin/rev-parse.c         |  6 ++++--
 builtin/show-branch.c       |  6 +++---
 builtin/show-ref.c          |  7 ++++---
 builtin/submodule--helper.c |  5 +++--
 commit-graph.c              |  4 ++--
 delta-islands.c             |  2 +-
 fetch-pack.c                | 12 ++++++++----
 help.c                      |  5 +++--
 http-backend.c              |  2 +-
 log-tree.c                  |  3 ++-
 negotiator/default.c        |  3 ++-
 negotiator/skipping.c       |  3 ++-
 notes.c                     |  5 +++--
 object-name.c               |  3 ++-
 reflog.c                    |  3 ++-
 refs.c                      | 11 +++++++----
 refs/files-backend.c        |  4 +++-
 remote.c                    |  3 ++-
 replace-object.c            |  3 ++-
 revision.c                  |  7 ++++---
 server-info.c               |  3 ++-
 shallow.c                   | 12 ++++++++----
 submodule.c                 | 10 ++++++----
 t/helper/test-ref-store.c   |  2 +-
 upload-pack.c               |  7 ++++---
 walker.c                    |  6 ++++--
 39 files changed, 132 insertions(+), 84 deletions(-)

diff --git a/bisect.c b/bisect.c
index 38b3891f3a..07ccd1bce6 100644
--- a/bisect.c
+++ b/bisect.c
@@ -441,7 +441,7 @@ void find_bisection(struct commit_list **commit_list, int *reaches,
 }
 
 static int register_ref(const char *refname, const struct object_id *oid,
-			int flags, void *cb_data)
+			int UNUSED(flags), void *UNUSED(cb_data))
 {
 	struct strbuf good_prefix = STRBUF_INIT;
 	strbuf_addstr(&good_prefix, term_good);
@@ -1160,8 +1160,9 @@ int estimate_bisect_steps(int all)
 	return (e < 3 * x) ? n : n - 1;
 }
 
-static int mark_for_removal(const char *refname, const struct object_id *oid,
-			    int flag, void *cb_data)
+static int mark_for_removal(const char *refname,
+			    const struct object_id *UNUSED(oid),
+			    int UNUSED(flag), void *cb_data)
 {
 	struct string_list *refs = cb_data;
 	char *ref = xstrfmt("refs/bisect%s", refname);
diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 8a052c7111..87c8b2d818 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -329,8 +329,9 @@ static int check_and_set_terms(struct bisect_terms *terms, const char *cmd)
 	return 0;
 }
 
-static int inc_nr(const char *refname, const struct object_id *oid,
-		  int flag, void *cb_data)
+static int inc_nr(const char *UNUSED(refname),
+		  const struct object_id *UNUSED(oid),
+		  int UNUSED(flag), void *cb_data)
 {
 	unsigned int *nr = (unsigned int *)cb_data;
 	(*nr)++;
@@ -518,7 +519,7 @@ static int bisect_append_log_quoted(const char **argv)
 }
 
 static int add_bisect_ref(const char *refname, const struct object_id *oid,
-			  int flags, void *cb)
+			  int UNUSED(flags), void *cb)
 {
 	struct add_bisect_ref_data *data = cb;
 
@@ -1134,8 +1135,9 @@ static int bisect_visualize(struct bisect_terms *terms, const char **argv, int a
 	return res;
 }
 
-static int get_first_good(const char *refname, const struct object_id *oid,
-			  int flag, void *cb_data)
+static int get_first_good(const char *UNUSED(refname),
+			  const struct object_id *oid,
+			  int UNUSED(flag), void *cb_data)
 {
 	oidcpy(cb_data, oid);
 	return 1;
diff --git a/builtin/checkout.c b/builtin/checkout.c
index f9d63d80b9..713410ce2c 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -990,7 +990,7 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 
 static int add_pending_uninteresting_ref(const char *refname,
 					 const struct object_id *oid,
-					 int flags, void *cb_data)
+					 int UNUSED(flags), void *cb_data)
 {
 	add_pending_oid(cb_data, refname, oid, UNINTERESTING);
 	return 0;
diff --git a/builtin/describe.c b/builtin/describe.c
index a76f1a1a7a..3af36483f2 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -140,7 +140,8 @@ static void add_to_known_names(const char *path,
 	}
 }
 
-static int get_name(const char *path, const struct object_id *oid, int flag, void *cb_data)
+static int get_name(const char *path, const struct object_id *oid,
+		    int UNUSED(flag), void *UNUSED(cb_data))
 {
 	int is_tag = 0;
 	struct object_id peeled;
diff --git a/builtin/fetch.c b/builtin/fetch.c
index fc5cecb483..9e7c8099fe 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -329,7 +329,7 @@ static struct refname_hash_entry *refname_hash_add(struct hashmap *map,
 
 static int add_one_refname(const char *refname,
 			   const struct object_id *oid,
-			   int flag, void *cbdata)
+			   int UNUSED(flag), void *cbdata)
 {
 	struct hashmap *refname_map = cbdata;
 
@@ -1462,8 +1462,9 @@ static void set_option(struct transport *transport, const char *name, const char
 }
 
 
-static int add_oid(const char *refname, const struct object_id *oid, int flags,
-		   void *cb_data)
+static int add_oid(const char *UNUSED(refname),
+		   const struct object_id *oid,
+		   int UNUSED(flags), void *cb_data)
 {
 	struct oid_array *oids = cb_data;
 
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 6c73092f10..36f1524614 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -502,8 +502,9 @@ static int fsck_handle_reflog_ent(struct object_id *ooid, struct object_id *noid
 	return 0;
 }
 
-static int fsck_handle_reflog(const char *logname, const struct object_id *oid,
-			      int flag, void *cb_data)
+static int fsck_handle_reflog(const char *logname,
+			      const struct object_id *UNUSED(oid),
+			      int UNUSED(flag), void *cb_data)
 {
 	struct strbuf refname = STRBUF_INIT;
 
@@ -514,7 +515,7 @@ static int fsck_handle_reflog(const char *logname, const struct object_id *oid,
 }
 
 static int fsck_handle_ref(const char *refname, const struct object_id *oid,
-			   int flag, void *cb_data)
+			   int UNUSED(flag), void *UNUSED(cb_data))
 {
 	struct object *obj;
 
diff --git a/builtin/gc.c b/builtin/gc.c
index eeff2b760e..e4ede128c9 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -782,8 +782,9 @@ struct cg_auto_data {
 	int limit;
 };
 
-static int dfs_on_ref(const char *refname,
-		      const struct object_id *oid, int flags,
+static int dfs_on_ref(const char *UNUSED(refname),
+		      const struct object_id *oid,
+		      int UNUSED(flags),
 		      void *cb_data)
 {
 	struct cg_auto_data *data = (struct cg_auto_data *)cb_data;
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 580b1eb170..c4dc143c4b 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -344,7 +344,8 @@ static int cmp_by_tag_and_age(const void *a_, const void *b_)
 	return a->taggerdate != b->taggerdate;
 }
 
-static int name_ref(const char *path, const struct object_id *oid, int flags, void *cb_data)
+static int name_ref(const char *path, const struct object_id *oid,
+		    int UNUSED(flags), void *cb_data)
 {
 	struct object *o = parse_object(the_repository, oid);
 	struct name_ref_data *data = cb_data;
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 39e28cfcaf..eb93e5c8fe 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -759,8 +759,8 @@ static enum write_one_status write_one(struct hashfile *f,
 	return WRITE_ONE_WRITTEN;
 }
 
-static int mark_tagged(const char *path, const struct object_id *oid, int flag,
-		       void *cb_data)
+static int mark_tagged(const char *UNUSED(path), const struct object_id *oid,
+		       int UNUSED(flag), void *UNUSED(cb_data))
 {
 	struct object_id peeled;
 	struct object_entry *entry = packlist_find(&to_pack, oid);
@@ -3035,7 +3035,8 @@ static void add_tag_chain(const struct object_id *oid)
 	}
 }
 
-static int add_ref_tag(const char *tag, const struct object_id *oid, int flag, void *cb_data)
+static int add_ref_tag(const char *UNUSED(tag), const struct object_id *oid,
+		       int UNUSED(flag), void *UNUSED(cb_data))
 {
 	struct object_id peeled;
 
@@ -3950,8 +3951,9 @@ static void record_recent_commit(struct commit *commit, void *data)
 }
 
 static int mark_bitmap_preferred_tip(const char *refname,
-				     const struct object_id *oid, int flags,
-				     void *_data)
+				     const struct object_id *oid,
+				     int UNUSED(flags),
+				     void *UNUSED(data))
 {
 	struct object_id peeled;
 	struct object *object;
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 31b48e728b..afd36c9c53 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -291,7 +291,7 @@ static void show_ref(const char *path, const struct object_id *oid)
 }
 
 static int show_ref_cb(const char *path_full, const struct object_id *oid,
-		       int flag, void *data)
+		       int UNUSED(flag), void *data)
 {
 	struct oidset *seen = data;
 	const char *path = strip_namespace(path_full);
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 8123956847..ab54d73611 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -56,7 +56,8 @@ struct worktree_reflogs {
 	struct string_list reflogs;
 };
 
-static int collect_reflog(const char *ref, const struct object_id *oid, int unused, void *cb_data)
+static int collect_reflog(const char *ref, const struct object_id *UNUSED(oid),
+			  int UNUSED(flags), void *cb_data)
 {
 	struct worktree_reflogs *cb = cb_data;
 	struct worktree *worktree = cb->worktree;
diff --git a/builtin/remote.c b/builtin/remote.c
index c713463d89..b390360f07 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -264,7 +264,8 @@ static const char *abbrev_ref(const char *name, const char *prefix)
 }
 #define abbrev_branch(name) abbrev_ref((name), "refs/heads/")
 
-static int config_read_branches(const char *key, const char *value, void *cb)
+static int config_read_branches(const char *key, const char *value,
+				void *UNUSED(data))
 {
 	const char *orig_key = key;
 	char *name;
@@ -538,7 +539,8 @@ struct branches_for_remote {
 };
 
 static int add_branch_for_removal(const char *refname,
-	const struct object_id *oid, int flags, void *cb_data)
+				  const struct object_id *UNUSED(oid),
+				  int UNUSED(flags), void *cb_data)
 {
 	struct branches_for_remote *branches = cb_data;
 	struct refspec_item refspec;
@@ -580,7 +582,8 @@ struct rename_info {
 };
 
 static int read_remote_branches(const char *refname,
-	const struct object_id *oid, int flags, void *cb_data)
+				const struct object_id *UNUSED(oid),
+				int UNUSED(flags), void *cb_data)
 {
 	struct rename_info *rename = cb_data;
 	struct strbuf buf = STRBUF_INIT;
@@ -953,7 +956,8 @@ static void free_remote_ref_states(struct ref_states *states)
 }
 
 static int append_ref_to_tracked_list(const char *refname,
-	const struct object_id *oid, int flags, void *cb_data)
+				      const struct object_id *UNUSED(oid),
+				      int flags, void *cb_data)
 {
 	struct ref_states *states = cb_data;
 	struct refspec_item refspec;
diff --git a/builtin/repack.c b/builtin/repack.c
index 482b66f57d..ff952dec48 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -514,9 +514,9 @@ struct midx_snapshot_ref_data {
 	int preferred;
 };
 
-static int midx_snapshot_ref_one(const char *refname,
+static int midx_snapshot_ref_one(const char *UNUSED(refname),
 				 const struct object_id *oid,
-				 int flag, void *_data)
+				 int UNUSED(flag), void *_data)
 {
 	struct midx_snapshot_ref_data *data = _data;
 	struct object_id peeled;
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index b259d8990a..3c448d438b 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -195,15 +195,17 @@ static int show_default(void)
 	return 0;
 }
 
-static int show_reference(const char *refname, const struct object_id *oid, int flag, void *cb_data)
+static int show_reference(const char *refname, const struct object_id *oid,
+			  int UNUSED(flag), void *UNUSED(cb_data))
 {
 	if (ref_excluded(ref_excludes, refname))
 		return 0;
 	show_rev(NORMAL, oid, refname);
 	return 0;
 }
 
-static int anti_reference(const char *refname, const struct object_id *oid, int flag, void *cb_data)
+static int anti_reference(const char *refname, const struct object_id *oid,
+			  int UNUSED(flag), void *UNUSED(cb_data))
 {
 	show_rev(REVERSED, oid, refname);
 	return 0;
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 64c649c6a2..3ec011bea4 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -404,7 +404,7 @@ static int append_ref(const char *refname, const struct object_id *oid,
 }
 
 static int append_head_ref(const char *refname, const struct object_id *oid,
-			   int flag, void *cb_data)
+			   int UNUSED(flag), void *UNUSED(cb_data))
 {
 	struct object_id tmp;
 	int ofs = 11;
@@ -419,7 +419,7 @@ static int append_head_ref(const char *refname, const struct object_id *oid,
 }
 
 static int append_remote_ref(const char *refname, const struct object_id *oid,
-			     int flag, void *cb_data)
+			     int UNUSED(flag), void *UNUSED(cb_data))
 {
 	struct object_id tmp;
 	int ofs = 13;
@@ -434,7 +434,7 @@ static int append_remote_ref(const char *refname, const struct object_id *oid,
 }
 
 static int append_tag_ref(const char *refname, const struct object_id *oid,
-			  int flag, void *cb_data)
+			  int UNUSED(flag), void *UNUSED(cb_data))
 {
 	if (!starts_with(refname, "refs/tags/"))
 		return 0;
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 5fa207a044..9746537220 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -47,7 +47,7 @@ static void show_one(const char *refname, const struct object_id *oid)
 }
 
 static int show_ref(const char *refname, const struct object_id *oid,
-		    int flag, void *cbdata)
+		    int UNUSED(flag), void *UNUSED(cbdata))
 {
 	if (show_head && !strcmp(refname, "HEAD"))
 		goto match;
@@ -77,8 +77,9 @@ static int show_ref(const char *refname, const struct object_id *oid,
 	return 0;
 }
 
-static int add_existing(const char *refname, const struct object_id *oid,
-			int flag, void *cbdata)
+static int add_existing(const char *refname,
+			const struct object_id *UNUSED(oid),
+			int UNUSED(flag), void *cbdata)
 {
 	struct string_list *list = (struct string_list *)cbdata;
 	string_list_insert(list, refname);
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index b63f420ece..e24e721458 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -622,8 +622,9 @@ static void print_status(unsigned int flags, char state, const char *path,
 	printf("\n");
 }
 
-static int handle_submodule_head_ref(const char *refname,
-				     const struct object_id *oid, int flags,
+static int handle_submodule_head_ref(const char *UNUSED(refname),
+				     const struct object_id *oid,
+				     int UNUSED(flags),
 				     void *cb_data)
 {
 	struct object_id *output = cb_data;
diff --git a/commit-graph.c b/commit-graph.c
index f2a36032f8..1ab5c3233f 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1639,9 +1639,9 @@ struct refs_cb_data {
 	struct progress *progress;
 };
 
-static int add_ref_to_set(const char *refname,
+static int add_ref_to_set(const char *UNUSED(refname),
 			  const struct object_id *oid,
-			  int flags, void *cb_data)
+			  int UNUSED(flags), void *cb_data)
 {
 	struct object_id peeled;
 	struct refs_cb_data *data = (struct refs_cb_data *)cb_data;
diff --git a/delta-islands.c b/delta-islands.c
index aa98b2e541..13eb96e0c4 100644
--- a/delta-islands.c
+++ b/delta-islands.c
@@ -365,7 +365,7 @@ static void add_ref_to_island(const char *island_name, const struct object_id *o
 }
 
 static int find_island_for_ref(const char *refname, const struct object_id *oid,
-			       int flags, void *data)
+			       int UNUSED(flags), void *UNUSED(data))
 {
 	/*
 	 * We should advertise 'ARRAY_SIZE(matches) - 2' as the max,
diff --git a/fetch-pack.c b/fetch-pack.c
index d35be4177b..bda9d0f433 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -176,8 +176,10 @@ static int rev_list_insert_ref(struct fetch_negotiator *negotiator,
 	return 0;
 }
 
-static int rev_list_insert_ref_oid(const char *refname, const struct object_id *oid,
-				   int flag, void *cb_data)
+static int rev_list_insert_ref_oid(const char *UNUSED(refname),
+				   const struct object_id *oid,
+				   int UNUSED(flag),
+				   void *cb_data)
 {
 	return rev_list_insert_ref(cb_data, oid);
 }
@@ -580,8 +582,10 @@ static int mark_complete(const struct object_id *oid)
 	return 0;
 }
 
-static int mark_complete_oid(const char *refname, const struct object_id *oid,
-			     int flag, void *cb_data)
+static int mark_complete_oid(const char *UNUSED(refname),
+			     const struct object_id *oid,
+			     int UNUSED(flag),
+			     void *UNUSED(cb_data))
 {
 	return mark_complete(oid);
 }
diff --git a/help.c b/help.c
index 991e33f8a6..c5b5848188 100644
--- a/help.c
+++ b/help.c
@@ -781,8 +781,9 @@ struct similar_ref_cb {
 	struct string_list *similar_refs;
 };
 
-static int append_similar_ref(const char *refname, const struct object_id *oid,
-			      int flags, void *cb_data)
+static int append_similar_ref(const char *refname,
+			      const struct object_id *UNUSED(oid),
+			      int UNUSED(flags), void *cb_data)
 {
 	struct similar_ref_cb *cb = (struct similar_ref_cb *)(cb_data);
 	char *branch = strrchr(refname, '/') + 1;
diff --git a/http-backend.c b/http-backend.c
index 58b83a9f66..20db0ea620 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -505,7 +505,7 @@ static void run_service(const char **argv, int buffer_input)
 }
 
 static int show_text_ref(const char *name, const struct object_id *oid,
-			 int flag, void *cb_data)
+			 int UNUSED(flag), void *cb_data)
 {
 	const char *name_nons = strip_namespace(name);
 	struct strbuf *buf = cb_data;
diff --git a/log-tree.c b/log-tree.c
index 82d9b5f650..4ca872eef4 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -135,7 +135,8 @@ static int ref_filter_match(const char *refname,
 }
 
 static int add_ref_decoration(const char *refname, const struct object_id *oid,
-			      int flags, void *cb_data)
+			      int UNUSED(flags),
+			      void *cb_data)
 {
 	struct object *obj;
 	enum object_type objtype;
diff --git a/negotiator/default.c b/negotiator/default.c
index 434189ae5d..10f0a46e62 100644
--- a/negotiator/default.c
+++ b/negotiator/default.c
@@ -36,7 +36,8 @@ static void rev_list_push(struct negotiation_state *ns,
 }
 
 static int clear_marks(const char *refname, const struct object_id *oid,
-		       int flag, void *cb_data)
+		       int UNUSED(flag),
+		       void *UNUSED(cb_data))
 {
 	struct object *o = deref_tag(the_repository, parse_object(the_repository, oid), refname, 0);
 
diff --git a/negotiator/skipping.c b/negotiator/skipping.c
index 1236e79224..f2aa58af92 100644
--- a/negotiator/skipping.c
+++ b/negotiator/skipping.c
@@ -72,7 +72,8 @@ static struct entry *rev_list_push(struct data *data, struct commit *commit, int
 }
 
 static int clear_marks(const char *refname, const struct object_id *oid,
-		       int flag, void *cb_data)
+		       int UNUSED(flag),
+		       void *UNUSED(cb_data))
 {
 	struct object *o = deref_tag(the_repository, parse_object(the_repository, oid), refname, 0);
 
diff --git a/notes.c b/notes.c
index 7452e71cc8..3be98e7085 100644
--- a/notes.c
+++ b/notes.c
@@ -924,8 +924,9 @@ int combine_notes_cat_sort_uniq(struct object_id *cur_oid,
 	return ret;
 }
 
-static int string_list_add_one_ref(const char *refname, const struct object_id *oid,
-				   int flag, void *cb)
+static int string_list_add_one_ref(const char *refname,
+				   const struct object_id *UNUSED(oid),
+				   int UNUSED(flag), void *cb)
 {
 	struct string_list *refs = cb;
 	if (!unsorted_string_list_has_string(refs, refname))
diff --git a/object-name.c b/object-name.c
index 4d2746574c..052644977e 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1306,7 +1306,8 @@ struct handle_one_ref_cb {
 };
 
 static int handle_one_ref(const char *path, const struct object_id *oid,
-			  int flag, void *cb_data)
+			  int UNUSED(flag),
+			  void *cb_data)
 {
 	struct handle_one_ref_cb *cb = cb_data;
 	struct commit_list **list = cb->list;
diff --git a/reflog.c b/reflog.c
index 135a1a6e41..ee8aaa78f5 100644
--- a/reflog.c
+++ b/reflog.c
@@ -294,7 +294,8 @@ int should_expire_reflog_ent_verbose(struct object_id *ooid,
 	return expire;
 }
 
-static int push_tip_to_list(const char *refname, const struct object_id *oid,
+static int push_tip_to_list(const char *UNUSED(refname),
+			    const struct object_id *oid,
 			    int flags, void *cb_data)
 {
 	struct commit_list **list = cb_data;
diff --git a/refs.c b/refs.c
index 90bcb27168..34373e8087 100644
--- a/refs.c
+++ b/refs.c
@@ -358,7 +358,8 @@ struct warn_if_dangling_data {
 	const char *msg_fmt;
 };
 
-static int warn_if_dangling_symref(const char *refname, const struct object_id *oid,
+static int warn_if_dangling_symref(const char *refname,
+				   const struct object_id *UNUSED(oid),
 				   int flags, void *cb_data)
 {
 	struct warn_if_dangling_data *d = cb_data;
@@ -934,9 +935,11 @@ static int read_ref_at_ent(struct object_id *ooid, struct object_id *noid,
 	return cb->found_it;
 }
 
-static int read_ref_at_ent_newest(struct object_id *ooid, struct object_id *noid,
-				  const char *email, timestamp_t timestamp,
-				  int tz, const char *message, void *cb_data)
+static int read_ref_at_ent_newest(struct object_id *UNUSED(ooid),
+				  struct object_id *noid,
+				  const char *UNUSED(email),
+				  timestamp_t timestamp, int tz,
+				  const char *message, void *cb_data)
 {
 	struct read_ref_at_cb *cb = cb_data;
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 8db7882aac..972701ce00 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2995,7 +2995,9 @@ static int files_transaction_abort(struct ref_store *ref_store,
 }
 
 static int ref_present(const char *refname,
-		       const struct object_id *oid, int flags, void *cb_data)
+		       const struct object_id *UNUSED(oid),
+		       int UNUSED(flags),
+		       void *cb_data)
 {
 	struct string_list *affected_refnames = cb_data;
 
diff --git a/remote.c b/remote.c
index 618ad5a0f1..723aa8841c 100644
--- a/remote.c
+++ b/remote.c
@@ -2320,7 +2320,8 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 }
 
 static int one_local_ref(const char *refname, const struct object_id *oid,
-			 int flag, void *cb_data)
+			 int UNUSED(flag),
+			 void *cb_data)
 {
 	struct ref ***local_tail = cb_data;
 	struct ref *ref;
diff --git a/replace-object.c b/replace-object.c
index 7bd9aba6ee..17810e5a3a 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -9,7 +9,8 @@
 static int register_replace_ref(struct repository *r,
 				const char *refname,
 				const struct object_id *oid,
-				int flag, void *cb_data)
+				int UNUSED(flag),
+				void *UNUSED(cb_data))
 {
 	/* Get sha1 from refname */
 	const char *slash = strrchr(refname, '/');
diff --git a/revision.c b/revision.c
index f4eee11cc8..23c2bba0d8 100644
--- a/revision.c
+++ b/revision.c
@@ -1543,7 +1543,8 @@ int ref_excluded(struct string_list *ref_excludes, const char *path)
 }
 
 static int handle_one_ref(const char *path, const struct object_id *oid,
-			  int flag, void *cb_data)
+			  int UNUSED(flag),
+			  void *cb_data)
 {
 	struct all_refs_cb *cb = cb_data;
 	struct object *object;
@@ -1627,8 +1628,8 @@ static int handle_one_reflog_ent(struct object_id *ooid, struct object_id *noid,
 }
 
 static int handle_one_reflog(const char *refname_in_wt,
-			     const struct object_id *oid,
-			     int flag, void *cb_data)
+			     const struct object_id *UNUSED(oid),
+			     int UNUSED(flag), void *cb_data)
 {
 	struct all_refs_cb *cb = cb_data;
 	struct strbuf refname = STRBUF_INIT;
diff --git a/server-info.c b/server-info.c
index 7701d7c20a..d99d9d5f61 100644
--- a/server-info.c
+++ b/server-info.c
@@ -147,7 +147,8 @@ static int update_info_file(char *path,
 }
 
 static int add_info_ref(const char *path, const struct object_id *oid,
-			int flag, void *cb_data)
+			int UNUSED(flag),
+			void *cb_data)
 {
 	struct update_info_ctx *uic = cb_data;
 	struct object *o = parse_object(the_repository, oid);
diff --git a/shallow.c b/shallow.c
index 8cb768ee5f..71ab04f935 100644
--- a/shallow.c
+++ b/shallow.c
@@ -604,8 +604,10 @@ static void paint_down(struct paint_info *info, const struct object_id *oid,
 	free(tmp);
 }
 
-static int mark_uninteresting(const char *refname, const struct object_id *oid,
-			      int flags, void *cb_data)
+static int mark_uninteresting(const char *UNUSED(refname),
+			      const struct object_id *oid,
+			      int UNUSED(flags),
+			      void *UNUSED(cb_data))
 {
 	struct commit *commit = lookup_commit_reference_gently(the_repository,
 							       oid, 1);
@@ -715,8 +717,10 @@ struct commit_array {
 	int nr, alloc;
 };
 
-static int add_ref(const char *refname, const struct object_id *oid,
-		   int flags, void *cb_data)
+static int add_ref(const char *UNUSED(refname),
+		   const struct object_id *oid,
+		   int UNUSED(flags),
+		   void *cb_data)
 {
 	struct commit_array *ca = cb_data;
 	ALLOC_GROW(ca->commits, ca->nr + 1, ca->alloc);
diff --git a/submodule.c b/submodule.c
index 3fa5db3ecd..d99c978fa5 100644
--- a/submodule.c
+++ b/submodule.c
@@ -940,8 +940,9 @@ static void free_submodules_data(struct string_list *submodules)
 	string_list_clear(submodules, 1);
 }
 
-static int has_remote(const char *refname, const struct object_id *oid,
-		      int flags, void *cb_data)
+static int has_remote(const char *UNUSED(refname),
+		      const struct object_id *UNUSED(oid),
+		      int UNUSED(flags), void *UNUSED(cb_data))
 {
 	return 1;
 }
@@ -1243,8 +1244,9 @@ int push_unpushed_submodules(struct repository *r,
 	return ret;
 }
 
-static int append_oid_to_array(const char *ref, const struct object_id *oid,
-			       int flags, void *data)
+static int append_oid_to_array(const char *UNUSED(ref),
+			       const struct object_id *oid,
+			       int UNUSED(flags), void *data)
 {
 	struct oid_array *array = data;
 	oid_array_append(array, oid);
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 4d18bfb1ca..a98775d1a6 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -161,7 +161,7 @@ static int cmd_rename_ref(struct ref_store *refs, const char **argv)
 }
 
 static int each_ref(const char *refname, const struct object_id *oid,
-		    int flags, void *cb_data)
+		    int flags, void *UNUSED(cb_data))
 {
 	printf("%s %s 0x%x\n", oid_to_hex(oid), refname, flags);
 	return 0;
diff --git a/upload-pack.c b/upload-pack.c
index b217a1f469..b2cbca1e8b 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1170,7 +1170,7 @@ static int mark_our_ref(const char *refname, const char *refname_full,
 }
 
 static int check_ref(const char *refname_full, const struct object_id *oid,
-		     int flag, void *cb_data)
+		     int UNUSED(flag), void *UNUSED(cb_data))
 {
 	const char *refname = strip_namespace(refname_full);
 
@@ -1194,7 +1194,7 @@ static void format_session_id(struct strbuf *buf, struct upload_pack_data *d) {
 }
 
 static int send_ref(const char *refname, const struct object_id *oid,
-		    int flag, void *cb_data)
+		    int UNUSED(flag), void *cb_data)
 {
 	static const char *capabilities = "multi_ack thin-pack side-band"
 		" side-band-64k ofs-delta shallow deepen-since deepen-not"
@@ -1236,7 +1236,8 @@ static int send_ref(const char *refname, const struct object_id *oid,
 	return 0;
 }
 
-static int find_symref(const char *refname, const struct object_id *oid,
+static int find_symref(const char *refname,
+		       const struct object_id *UNUSED(oid),
 		       int flag, void *cb_data)
 {
 	const char *symref_target;
diff --git a/walker.c b/walker.c
index c5e2921979..f945d021f8 100644
--- a/walker.c
+++ b/walker.c
@@ -215,8 +215,10 @@ static int interpret_target(struct walker *walker, char *target, struct object_i
 	return -1;
 }
 
-static int mark_complete(const char *path, const struct object_id *oid,
-			 int flag, void *cb_data)
+static int mark_complete(const char *UNUSED(path),
+			 const struct object_id *oid,
+			 int UNUSED(flag),
+			 void *UNUSED(cb_data))
 {
 	struct commit *commit = lookup_commit_reference_gently(the_repository,
 							       oid, 1);
-- 
2.37.2.928.g0821088f4a

