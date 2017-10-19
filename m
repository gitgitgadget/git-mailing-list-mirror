Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 537F7202DD
	for <e@80x24.org>; Thu, 19 Oct 2017 18:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753628AbdJSSLV (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 14:11:21 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:52748 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753596AbdJSSLS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 14:11:18 -0400
Received: by mail-it0-f67.google.com with SMTP id j140so10774647itj.1
        for <git@vger.kernel.org>; Thu, 19 Oct 2017 11:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vI6/lLIdcw2DBPIF+v0rF5WUqWU971gf5O3Y6yJn5iQ=;
        b=GNWIadvgEJ6oODKaGV56PKOfU7MlgQIbYjFUDKh3lCVQcl52IQecXkNGpVgWK3OkCh
         jSBQn613BnddvMVlwxl+GVjX1g6VOVvRXER3lap0k6LeWC6wr20DoOufLTwSLxJg2c/d
         pOcmtok9tsE+WLOHrC5oCmNAyieVwuxcwcwCkRjoktEnwWsv5ZCjS3tghT8frdRkJ4Hg
         4kc3qKAFVghUR4Qplx68jhwK5U6/FmGI8Pnhp3sq0kQ4zi17W//TevnaB7Fkam4uT7uA
         SkIK/sIVZGGnwVzfPGC75WIUevIYoq/Jd4ItBtfbq+nKwGitgWRE51BOFDLse5XrfQko
         vCsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vI6/lLIdcw2DBPIF+v0rF5WUqWU971gf5O3Y6yJn5iQ=;
        b=WReuETW6ApRfyBgjSEMMDQCi6lXKbe36y3R/CwcbP0tTp6nuOsJ07AYqSKH3MySccF
         ILaCRYBv2WrgSBWHd2mp9ZAJLeAMCEYvX7Ow7kfubiu5FFcr7UgNzYl54EhG7d20HV3/
         BlzvNvvy3T5g2jR9O8/HPhdpb+0skZgUvIBKNJVhL+0lN/3dy9VkxI1gKIPF2aJkrt+d
         mf9YlT7qqkvO3IcNUeoAdBk+flMSeprbaYyOG2wFtMa+QwgAryQ0mNzttEnV+NiJsSwp
         F7M8nr0wg0MhFeGRltoTbh5/34OzVgBtm+y9f374/v9DRfoyXdjmyt12dZXFy3pPypha
         hmgA==
X-Gm-Message-State: AMCzsaVfQxghRAfFI7GQMQe378rhO39a+osgRo+v5qmw0dgUHd8/xSHB
        IClDUEKxjn6Go/QHjThTm2vVRw==
X-Google-Smtp-Source: ABhQp+SiU/CntRK52p4Cv1mL6C1epuHhpWlNrZ/nTI3yug8fMfpogOVm9+aaUAEg4BKV/VWpNsEoZA==
X-Received: by 10.36.23.215 with SMTP id 206mr3349397ith.62.1508436676713;
        Thu, 19 Oct 2017 11:11:16 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c825:6c3d:e3fe:7438])
        by smtp.gmail.com with ESMTPSA id y132sm5627694ioy.69.2017.10.19.11.11.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 19 Oct 2017 11:11:15 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     Jens.Lehmann@web.de, bmwill@google.com, git@vger.kernel.org,
        hvoigt@hvoigt.net, jrnieder@gmail.com, sbeller@google.com
Subject: [PATCH 2/2] fetch, push: keep separate lists of submodules and gitlinks
Date:   Thu, 19 Oct 2017 11:11:09 -0700
Message-Id: <20171019181109.27792-2-sbeller@google.com>
X-Mailer: git-send-email 2.14.0.rc0.3.g6c2e499285
In-Reply-To: <20171019181109.27792-1-sbeller@google.com>
References: <xmqqwp3sj7ov.fsf@gitster.mtv.corp.google.com>
 <20171019181109.27792-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently when fetching we collect the names of submodules to be fetched
in a list. As we also want to support fetching 'gitlinks, that happen to
have a repo checked out at the right place', we'll just pretend that these
are submodules. We do that by assuming their path is their name. This in
turn can yield collisions between the name-namespace and the
path-namespace. (See the previous test for a demonstration.)

This patch rewrites the code such that we treat the 'real submodule' case
differently from the 'gitlink, but ok' case. This introduces a bit
of code duplication, but gets rid of the confusing mapping between names
and paths.

The test is incomplete as the long term vision is not achieved yet.
(which would be fetching both the renamed submodule as well as
the gitlink thing, putting them in place via e.g. git-pull)

Signed-off-by: Stefan Beller <sbeller@google.com>
---

 Heiko,
 Junio,

 I assumed the code would ease up a lot more, but now I am undecided if
 I want to keep arguing as the code is not stopping to be ugly. :)
 
 The idea is to treat submodule and gitlinks separately, with submodules
 supporting renames, and gitlinks as a historic artefact.
 
 Sorry for the noise about code ugliness.
 
 Thanks,
 Stefan
 

 submodule.c                 | 168 +++++++++++++++++++++-----------------------
 t/t5526-fetch-submodules.sh |   1 -
 2 files changed, 81 insertions(+), 88 deletions(-)

diff --git a/submodule.c b/submodule.c
index 82d206eb65..115df82f32 100644
--- a/submodule.c
+++ b/submodule.c
@@ -22,6 +22,7 @@
 
 static int config_update_recurse_submodules = RECURSE_SUBMODULES_OFF;
 static struct string_list changed_submodule_names = STRING_LIST_INIT_DUP;
+static struct string_list changed_gitlink_paths = STRING_LIST_INIT_DUP;
 static int initialized_fetch_ref_tips;
 static struct oid_array ref_tips_before_fetch;
 static struct oid_array ref_tips_after_fetch;
@@ -674,11 +675,11 @@ const struct submodule *submodule_from_ce(const struct cache_entry *ce)
 }
 
 static struct oid_array *submodule_commits(struct string_list *submodules,
-					   const char *name)
+					   const char *key)
 {
 	struct string_list_item *item;
 
-	item = string_list_insert(submodules, name);
+	item = string_list_insert(submodules, key);
 	if (item->util)
 		return (struct oid_array *) item->util;
 
@@ -688,33 +689,20 @@ static struct oid_array *submodule_commits(struct string_list *submodules,
 }
 
 struct collect_changed_submodules_cb_data {
-	struct string_list *changed;
-	const struct object_id *commit_oid;
-};
+	/* used for submodules, supports renames: */
+	struct string_list *changed_by_name;
 
-/*
- * this would normally be two functions: default_name_from_path() and
- * path_from_default_name(). Since the default name is the same as
- * the submodule path we can get away with just one function which only
- * checks whether there is a submodule in the working directory at that
- * location.
- */
-static const char *default_name_or_path(const char *path_or_name)
-{
-	int error_code;
+	/* support old 'gitlink' with repo in-place, no rename support*/
+	struct string_list *changed_by_path;
 
-	if (!is_submodule_populated_gently(path_or_name, &error_code))
-		return NULL;
-
-	return path_or_name;
-}
+	const struct object_id *commit_oid;
+};
 
 static void collect_changed_submodules_cb(struct diff_queue_struct *q,
 					  struct diff_options *options,
 					  void *data)
 {
 	struct collect_changed_submodules_cb_data *me = data;
-	struct string_list *changed = me->changed;
 	const struct object_id *commit_oid = me->commit_oid;
 	int i;
 
@@ -722,42 +710,35 @@ static void collect_changed_submodules_cb(struct diff_queue_struct *q,
 		struct diff_filepair *p = q->queue[i];
 		struct oid_array *commits;
 		const struct submodule *submodule;
-		const char *name;
 
 		if (!S_ISGITLINK(p->two->mode))
 			continue;
 
 		submodule = submodule_from_path(commit_oid, p->two->path);
-		if (submodule)
-			name = submodule->name;
-		else {
-			name = default_name_or_path(p->two->path);
-			/* make sure name does not collide with existing one */
-			submodule = submodule_from_name(commit_oid, name);
-			if (submodule) {
-				warning("Submodule in commit %s at path: "
-					"'%s' collides with a submodule named "
-					"the same. Skipping it.",
-					oid_to_hex(commit_oid), name);
-				name = NULL;
-			}
+		if (submodule) {
+			commits = submodule_commits(me->changed_by_name, submodule->name);
+			oid_array_append(commits, &p->two->oid);
+		} else {
+			commits = submodule_commits(me->changed_by_path, p->two->path);
+			oid_array_append(commits, &p->two->oid);
 		}
-
-		if (!name)
-			continue;
-
-		commits = submodule_commits(changed, name);
-		oid_array_append(commits, &p->two->oid);
 	}
 }
 
 /*
- * Collect the paths of submodules in 'changed' which have changed based on
- * the revisions as specified in 'argv'.  Each entry in 'changed' will also
- * have a corresponding 'struct oid_array' (in the 'util' field) which lists
- * what the submodule pointers were updated to during the change.
+ * Collect the paths of submodules in 'changed_by_{name, path}' which have
+ * changed based on the revisions as specified in 'argv'.
+ *
+ * Each gitlink/submodule will occur in only one of the list. We'll prefer
+ * to give it by_name as that allows rename detection. We'll fall back to
+ * by_path to support gitlinks with no entry in '.gitmodules'.
+ *
+ * Each entry in 'changed_*' will also have a corresponding 'struct oid_array'
+ * (in the 'util' field) which lists what the submodule pointers were updated
+ * to during the change.
  */
-static void collect_changed_submodules(struct string_list *changed,
+static void collect_changed_submodules(struct string_list *changed_by_name,
+				       struct string_list *changed_by_path,
 				       struct argv_array *argv)
 {
 	struct rev_info rev;
@@ -771,7 +752,8 @@ static void collect_changed_submodules(struct string_list *changed,
 	while ((commit = get_revision(&rev))) {
 		struct rev_info diff_rev;
 		struct collect_changed_submodules_cb_data data;
-		data.changed = changed;
+		data.changed_by_name = changed_by_name;
+		data.changed_by_path = changed_by_path;
 		data.commit_oid = &commit->object.oid;
 
 		init_revisions(&diff_rev, NULL);
@@ -924,8 +906,9 @@ static int submodule_needs_pushing(const char *path, struct oid_array *commits)
 int find_unpushed_submodules(struct oid_array *commits,
 		const char *remotes_name, struct string_list *needs_pushing)
 {
-	struct string_list submodules = STRING_LIST_INIT_DUP;
-	struct string_list_item *name;
+	struct string_list submodules_by_name = STRING_LIST_INIT_DUP;
+	struct string_list gitlinks_by_path = STRING_LIST_INIT_DUP;
+	struct string_list_item *item;
 	struct argv_array argv = ARGV_ARRAY_INIT;
 
 	/* argv.argv[0] will be ignored by setup_revisions */
@@ -934,27 +917,33 @@ int find_unpushed_submodules(struct oid_array *commits,
 	argv_array_push(&argv, "--not");
 	argv_array_pushf(&argv, "--remotes=%s", remotes_name);
 
-	collect_changed_submodules(&submodules, &argv);
+	collect_changed_submodules(&submodules_by_name, &gitlinks_by_path, &argv);
 
-	for_each_string_list_item(name, &submodules) {
-		struct oid_array *commits = name->util;
+	for_each_string_list_item(item, &submodules_by_name) {
+		struct oid_array *commits = item->util;
+		const char *name = item->string;
 		const struct submodule *submodule;
-		const char *path = NULL;
+		const char *path;
 
-		submodule = submodule_from_name(&null_oid, name->string);
-		if (submodule)
-			path = submodule->path;
-		else
-			path = default_name_or_path(name->string);
+		submodule = submodule_from_name(&null_oid, name);
+		if (!submodule)
+			BUG("submodule name/path mapping corrupt");
+		path = submodule->path;
 
-		if (!path)
-			continue;
+		if (submodule_needs_pushing(path, commits))
+			string_list_insert(needs_pushing, path);
+	}
+
+	for_each_string_list_item(item, &gitlinks_by_path) {
+		struct oid_array *commits = item->util;
+		const char *path = item->string;
 
 		if (submodule_needs_pushing(path, commits))
 			string_list_insert(needs_pushing, path);
 	}
 
-	free_submodules_oids(&submodules);
+	free_submodules_oids(&submodules_by_name);
+	free_submodules_oids(&gitlinks_by_path);
 	argv_array_clear(&argv);
 
 	return needs_pushing->nr;
@@ -1106,7 +1095,8 @@ static void calculate_changed_submodule_paths(void)
 {
 	struct argv_array argv = ARGV_ARRAY_INIT;
 	struct string_list changed_submodules = STRING_LIST_INIT_DUP;
-	const struct string_list_item *name;
+	struct string_list changed_gitlinks = STRING_LIST_INIT_DUP;
+	const struct string_list_item *item;
 
 	/* No need to check if there are no submodules configured */
 	if (!submodule_from_path(NULL, NULL))
@@ -1123,27 +1113,32 @@ static void calculate_changed_submodule_paths(void)
 	 * Collect all submodules (whether checked out or not) for which new
 	 * commits have been recorded upstream in "changed_submodule_names".
 	 */
-	collect_changed_submodules(&changed_submodules, &argv);
+	collect_changed_submodules(&changed_submodules, &changed_gitlinks, &argv);
 
-	for_each_string_list_item(name, &changed_submodules) {
-		struct oid_array *commits = name->util;
-		const struct submodule *submodule;
-		const char *path = NULL;
+	for_each_string_list_item(item, &changed_submodules) {
+		struct oid_array *commits = item->util;
+		const char *name = item->string;
+		const struct submodule *sub =
+			submodule_from_name(&null_oid, name);
 
-		submodule = submodule_from_name(&null_oid, name->string);
-		if (submodule)
-			path = submodule->path;
-		else
-			path = default_name_or_path(name->string);
+		if (!sub)
+			BUG("cannot lookup submodule, but we could before?");
 
-		if (!path)
-			continue;
+		if (!submodule_has_commits(sub->path, commits))
+			string_list_append(&changed_submodule_names, name);
+	}
+
+	/* the same for gitnlinks, stored in 'changed_gitlink_paths' */
+	for_each_string_list_item(item, &changed_gitlinks) {
+		const char *path = item->string;
+		struct oid_array *commits = item->util;
 
 		if (!submodule_has_commits(path, commits))
-			string_list_append(&changed_submodule_names, name->string);
+			string_list_append(&changed_gitlink_paths, path);
 	}
 
 	free_submodules_oids(&changed_submodules);
+	free_submodules_oids(&changed_gitlinks);
 	argv_array_clear(&argv);
 	oid_array_clear(&ref_tips_before_fetch);
 	oid_array_clear(&ref_tips_after_fetch);
@@ -1154,6 +1149,7 @@ int submodule_touches_in_range(struct object_id *excl_oid,
 			       struct object_id *incl_oid)
 {
 	struct string_list subs = STRING_LIST_INIT_DUP;
+	struct string_list gitlinks = STRING_LIST_INIT_DUP;
 	struct argv_array args = ARGV_ARRAY_INIT;
 	int ret;
 
@@ -1166,8 +1162,8 @@ int submodule_touches_in_range(struct object_id *excl_oid,
 	argv_array_push(&args, "--not");
 	argv_array_push(&args, oid_to_hex(excl_oid));
 
-	collect_changed_submodules(&subs, &args);
-	ret = subs.nr;
+	collect_changed_submodules(&subs, &gitlinks, &args);
+	ret = subs.nr + gitlinks.nr;
 
 	argv_array_clear(&args);
 
@@ -1225,27 +1221,25 @@ static int get_next_submodule(struct child_process *cp,
 		const struct cache_entry *ce = active_cache[spf->count];
 		const char *git_dir, *default_argv;
 		const struct submodule *submodule;
-		struct submodule default_submodule = SUBMODULE_INIT;
+		int found = 0;
 
 		if (!S_ISGITLINK(ce->ce_mode))
 			continue;
 
 		submodule = submodule_from_path(&null_oid, ce->name);
-		if (!submodule) {
-			const char *name = default_name_or_path(ce->name);
-			if (name) {
-				default_submodule.path = default_submodule.name = name;
-				submodule = &default_submodule;
-			}
-		}
 
 		switch (get_fetch_recurse_config(submodule, spf))
 		{
 		default:
 		case RECURSE_SUBMODULES_DEFAULT:
 		case RECURSE_SUBMODULES_ON_DEMAND:
-			if (!submodule || !unsorted_string_list_lookup(&changed_submodule_names,
-							 submodule->name))
+
+			if (submodule)
+				found |= !!unsorted_string_list_lookup(&changed_submodule_names, submodule->name);
+
+			found |= !!unsorted_string_list_lookup(&changed_gitlink_paths, ce->name);
+
+			if (!found)
 				continue;
 			default_argv = "on-demand";
 			break;
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index c82d519e06..d6a6d6a4e1 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -638,7 +638,6 @@ test_expect_success "warn on submodule name/path clash, but new commits fetched
 	(
 		cd downstream &&
 		git fetch --recurse-submodules=on-demand 2>err &&
-		grep "collides with a submodule named" err &&
 		(
 			cd submodule &&
 			git rev-parse origin/rename_sub >../../actual
-- 
2.14.0.rc0.3.g6c2e499285

