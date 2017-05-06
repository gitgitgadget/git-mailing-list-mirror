Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B36EF207F8
	for <e@80x24.org>; Sat,  6 May 2017 22:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754789AbdEFWMK (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 May 2017 18:12:10 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:37884 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754301AbdEFWLS (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 6 May 2017 18:11:18 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id E5B0E280C3;
        Sat,  6 May 2017 22:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1494108671;
        bh=v6xwWexKGhmRz5Dy2q9z+Ra/6szFUiqgf9ONPwqDW8M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JUbEp7x/fRkjDE8FqVPzv0koMyiOA4d091XlXQt3tK9jAuuJVDoDvrqpX1tc2NT8w
         PL9sxDgnnZEtEHoOcyZgrKosRjmD7/Qlin+wMcBpLUWwUEL7mEBLO3cDZv4KnX+iLz
         H5sTUoNXbw9tsqZ1tWe7i1qqLZqJX1bONbrFEmHRkehNG3QqF/P+hpfnTSamkdvgak
         OeCgKAxuDB3oaA40SSYmtq6E76fg/2hqI2SgJqj6F7ZnYsDiweEhwTURCUK8EFsY9n
         3vcqLXZQv6iTVbLRob27+aY1WdoOsRskfKQu9Dw6HZkE1clcCr9UBwpqrIXWAxC46N
         t1FrmqthY7kdLPWv9O2ynhfiwvM0ZLU8LQlt8m40M6VqC5BSqxKYhi2TECJdYxLSN7
         NTJCR/Qs30nEsTGjHiVHxYg62KMvqjtTC7shofrlDqxhFpsX7Fa070bZq1pMuPWcGf
         efOGXPFpIRR967vLoakaszuttZ1cwAyW/j2+MDdweWvea+e+AIj
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 24/53] Convert remaining callers of lookup_commit_reference* to object_id
Date:   Sat,  6 May 2017 22:10:09 +0000
Message-Id: <20170506221038.296722-25-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.0.rc1.294.g07d810a77f
In-Reply-To: <20170506221038.296722-1-sandals@crustytoothpaste.net>
References: <20170506221038.296722-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are a small number of remaining callers of lookup_commit_reference
and lookup_commit_reference_gently that still need to be converted to
struct object_id.  Convert these.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 notes-merge.c | 26 +++++++++++++-------------
 ref-filter.c  |  6 +++---
 sequencer.c   | 20 ++++++++++----------
 sha1_name.c   | 12 ++++++------
 shallow.c     |  6 +++---
 submodule.c   |  8 ++++----
 6 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/notes-merge.c b/notes-merge.c
index 32caaaff7..06d8be9cb 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -535,7 +535,7 @@ int notes_merge(struct notes_merge_options *o,
 		struct notes_tree *local_tree,
 		unsigned char *result_sha1)
 {
-	unsigned char local_sha1[20], remote_sha1[20];
+	struct object_id local_oid, remote_oid;
 	struct commit *local, *remote;
 	struct commit_list *bases = NULL;
 	const unsigned char *base_sha1, *base_tree_sha1;
@@ -549,46 +549,46 @@ int notes_merge(struct notes_merge_options *o,
 	       o->local_ref, o->remote_ref);
 
 	/* Dereference o->local_ref into local_sha1 */
-	if (read_ref_full(o->local_ref, 0, local_sha1, NULL))
+	if (read_ref_full(o->local_ref, 0, local_oid.hash, NULL))
 		die("Failed to resolve local notes ref '%s'", o->local_ref);
 	else if (!check_refname_format(o->local_ref, 0) &&
-		is_null_sha1(local_sha1))
+		is_null_oid(&local_oid))
 		local = NULL; /* local_sha1 == null_sha1 indicates unborn ref */
-	else if (!(local = lookup_commit_reference(local_sha1)))
+	else if (!(local = lookup_commit_reference(local_oid.hash)))
 		die("Could not parse local commit %s (%s)",
-		    sha1_to_hex(local_sha1), o->local_ref);
-	trace_printf("\tlocal commit: %.7s\n", sha1_to_hex(local_sha1));
+		    oid_to_hex(&local_oid), o->local_ref);
+	trace_printf("\tlocal commit: %.7s\n", oid_to_hex(&local_oid));
 
 	/* Dereference o->remote_ref into remote_sha1 */
-	if (get_sha1(o->remote_ref, remote_sha1)) {
+	if (get_oid(o->remote_ref, &remote_oid)) {
 		/*
 		 * Failed to get remote_sha1. If o->remote_ref looks like an
 		 * unborn ref, perform the merge using an empty notes tree.
 		 */
 		if (!check_refname_format(o->remote_ref, 0)) {
-			hashclr(remote_sha1);
+			oidclr(&remote_oid);
 			remote = NULL;
 		} else {
 			die("Failed to resolve remote notes ref '%s'",
 			    o->remote_ref);
 		}
-	} else if (!(remote = lookup_commit_reference(remote_sha1))) {
+	} else if (!(remote = lookup_commit_reference(remote_oid.hash))) {
 		die("Could not parse remote commit %s (%s)",
-		    sha1_to_hex(remote_sha1), o->remote_ref);
+		    oid_to_hex(&remote_oid), o->remote_ref);
 	}
-	trace_printf("\tremote commit: %.7s\n", sha1_to_hex(remote_sha1));
+	trace_printf("\tremote commit: %.7s\n", oid_to_hex(&remote_oid));
 
 	if (!local && !remote)
 		die("Cannot merge empty notes ref (%s) into empty notes ref "
 		    "(%s)", o->remote_ref, o->local_ref);
 	if (!local) {
 		/* result == remote commit */
-		hashcpy(result_sha1, remote_sha1);
+		hashcpy(result_sha1, remote_oid.hash);
 		goto found_result;
 	}
 	if (!remote) {
 		/* result == local commit */
-		hashcpy(result_sha1, local_sha1);
+		hashcpy(result_sha1, local_oid.hash);
 		goto found_result;
 	}
 	assert(local && remote);
diff --git a/ref-filter.c b/ref-filter.c
index 3a640448f..47cce0a18 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2090,7 +2090,7 @@ int parse_opt_ref_sorting(const struct option *opt, const char *arg, int unset)
 int parse_opt_merge_filter(const struct option *opt, const char *arg, int unset)
 {
 	struct ref_filter *rf = opt->value;
-	unsigned char sha1[20];
+	struct object_id oid;
 	int no_merged = starts_with(opt->long_name, "no");
 
 	if (rf->merge) {
@@ -2105,10 +2105,10 @@ int parse_opt_merge_filter(const struct option *opt, const char *arg, int unset)
 		? REF_FILTER_MERGED_OMIT
 		: REF_FILTER_MERGED_INCLUDE;
 
-	if (get_sha1(arg, sha1))
+	if (get_oid(arg, &oid))
 		die(_("malformed object name %s"), arg);
 
-	rf->merge_commit = lookup_commit_reference_gently(sha1, 0);
+	rf->merge_commit = lookup_commit_reference_gently(oid.hash, 0);
 	if (!rf->merge_commit)
 		return opterror(opt, "must point to a commit", 0);
 
diff --git a/sequencer.c b/sequencer.c
index b94830cf9..e44c015b2 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1222,7 +1222,7 @@ static struct todo_item *append_new_todo(struct todo_list *todo_list)
 
 static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
 {
-	unsigned char commit_sha1[20];
+	struct object_id commit_oid;
 	char *end_of_object_name;
 	int i, saved, status, padding;
 
@@ -1271,7 +1271,7 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
 	end_of_object_name = (char *) bol + strcspn(bol, " \t\n");
 	saved = *end_of_object_name;
 	*end_of_object_name = '\0';
-	status = get_sha1(bol, commit_sha1);
+	status = get_oid(bol, &commit_oid);
 	*end_of_object_name = saved;
 
 	item->arg = end_of_object_name + strspn(end_of_object_name, " \t");
@@ -1280,7 +1280,7 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
 	if (status < 0)
 		return -1;
 
-	item->commit = lookup_commit_reference(commit_sha1);
+	item->commit = lookup_commit_reference(commit_oid.hash);
 	return !item->commit;
 }
 
@@ -2281,7 +2281,7 @@ static int single_pick(struct commit *cmit, struct replay_opts *opts)
 int sequencer_pick_revisions(struct replay_opts *opts)
 {
 	struct todo_list todo_list = TODO_LIST_INIT;
-	unsigned char sha1[20];
+	struct object_id oid;
 	int i, res;
 
 	assert(opts->revs);
@@ -2289,16 +2289,16 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 		return -1;
 
 	for (i = 0; i < opts->revs->pending.nr; i++) {
-		unsigned char sha1[20];
+		struct object_id oid;
 		const char *name = opts->revs->pending.objects[i].name;
 
 		/* This happens when using --stdin. */
 		if (!strlen(name))
 			continue;
 
-		if (!get_sha1(name, sha1)) {
-			if (!lookup_commit_reference_gently(sha1, 1)) {
-				enum object_type type = sha1_object_info(sha1, NULL);
+		if (!get_oid(name, &oid)) {
+			if (!lookup_commit_reference_gently(oid.hash, 1)) {
+				enum object_type type = sha1_object_info(oid.hash, NULL);
 				return error(_("%s: can't cherry-pick a %s"),
 					name, typename(type));
 			}
@@ -2335,9 +2335,9 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 	if (walk_revs_populate_todo(&todo_list, opts) ||
 			create_seq_dir() < 0)
 		return -1;
-	if (get_sha1("HEAD", sha1) && (opts->action == REPLAY_REVERT))
+	if (get_oid("HEAD", &oid) && (opts->action == REPLAY_REVERT))
 		return error(_("can't revert as initial commit"));
-	if (save_head(sha1_to_hex(sha1)))
+	if (save_head(oid_to_hex(&oid)))
 		return -1;
 	if (save_opts(opts))
 		return -1;
diff --git a/sha1_name.c b/sha1_name.c
index 8eec9f7c1..8889190a9 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -722,14 +722,14 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1,
 static int get_parent(const char *name, int len,
 		      unsigned char *result, int idx)
 {
-	unsigned char sha1[20];
-	int ret = get_sha1_1(name, len, sha1, GET_SHA1_COMMITTISH);
+	struct object_id oid;
+	int ret = get_sha1_1(name, len, oid.hash, GET_SHA1_COMMITTISH);
 	struct commit *commit;
 	struct commit_list *p;
 
 	if (ret)
 		return ret;
-	commit = lookup_commit_reference(sha1);
+	commit = lookup_commit_reference(oid.hash);
 	if (parse_commit(commit))
 		return -1;
 	if (!idx) {
@@ -750,14 +750,14 @@ static int get_parent(const char *name, int len,
 static int get_nth_ancestor(const char *name, int len,
 			    unsigned char *result, int generation)
 {
-	unsigned char sha1[20];
+	struct object_id oid;
 	struct commit *commit;
 	int ret;
 
-	ret = get_sha1_1(name, len, sha1, GET_SHA1_COMMITTISH);
+	ret = get_sha1_1(name, len, oid.hash, GET_SHA1_COMMITTISH);
 	if (ret)
 		return ret;
-	commit = lookup_commit_reference(sha1);
+	commit = lookup_commit_reference(oid.hash);
 	if (!commit)
 		return -1;
 
diff --git a/shallow.c b/shallow.c
index c520ae3ae..1327ee16f 100644
--- a/shallow.c
+++ b/shallow.c
@@ -466,7 +466,7 @@ static uint32_t *paint_alloc(struct paint_info *info)
  * UNINTERESTING or BOTTOM is hit. Set the id-th bit in ref_bitmap for
  * all walked commits.
  */
-static void paint_down(struct paint_info *info, const unsigned char *sha1,
+static void paint_down(struct paint_info *info, const struct object_id *oid,
 		       unsigned int id)
 {
 	unsigned int i, nr;
@@ -475,7 +475,7 @@ static void paint_down(struct paint_info *info, const unsigned char *sha1,
 	size_t bitmap_size = st_mult(sizeof(uint32_t), bitmap_nr);
 	uint32_t *tmp = xmalloc(bitmap_size); /* to be freed before return */
 	uint32_t *bitmap = paint_alloc(info);
-	struct commit *c = lookup_commit_reference_gently(sha1, 1);
+	struct commit *c = lookup_commit_reference_gently(oid->hash, 1);
 	if (!c)
 		return;
 	memset(bitmap, 0, bitmap_size);
@@ -604,7 +604,7 @@ void assign_shallow_commits_to_refs(struct shallow_info *info,
 	}
 
 	for (i = 0; i < ref->nr; i++)
-		paint_down(&pi, ref->oid[i].hash, i);
+		paint_down(&pi, ref->oid + i, i);
 
 	if (used) {
 		int bitmap_size = ((pi.nr_bits + 31) / 32) * sizeof(uint32_t);
diff --git a/submodule.c b/submodule.c
index 9bdd5f605..d5c28b9f1 100644
--- a/submodule.c
+++ b/submodule.c
@@ -896,17 +896,17 @@ int push_unpushed_submodules(struct oid_array *commits,
 	return ret;
 }
 
-static int is_submodule_commit_present(const char *path, unsigned char sha1[20])
+static int is_submodule_commit_present(const char *path, struct object_id *oid)
 {
 	int is_present = 0;
-	if (!add_submodule_odb(path) && lookup_commit_reference(sha1)) {
+	if (!add_submodule_odb(path) && lookup_commit_reference(oid->hash)) {
 		/* Even if the submodule is checked out and the commit is
 		 * present, make sure it is reachable from a ref. */
 		struct child_process cp = CHILD_PROCESS_INIT;
 		const char *argv[] = {"rev-list", "-n", "1", NULL, "--not", "--all", NULL};
 		struct strbuf buf = STRBUF_INIT;
 
-		argv[3] = sha1_to_hex(sha1);
+		argv[3] = oid_to_hex(oid);
 		cp.argv = argv;
 		prepare_submodule_repo_env(&cp.env_array);
 		cp.git_cmd = 1;
@@ -937,7 +937,7 @@ static void submodule_collect_changed_cb(struct diff_queue_struct *q,
 			 * being moved around. */
 			struct string_list_item *path;
 			path = unsorted_string_list_lookup(&changed_submodule_paths, p->two->path);
-			if (!path && !is_submodule_commit_present(p->two->path, p->two->oid.hash))
+			if (!path && !is_submodule_commit_present(p->two->path, &p->two->oid))
 				string_list_append(&changed_submodule_paths, xstrdup(p->two->path));
 		} else {
 			/* Submodule is new or was moved here */
