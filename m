Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BAC6C433F5
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 17:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242507AbiBORYW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 12:24:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242485AbiBORYO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 12:24:14 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC66DAAFA
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 09:24:03 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id j23-20020a17090a7e9700b001b8626c9170so2923306pjl.1
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 09:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vzrhPCJXUj1fOavLwHq12IVPyJwyXk3DJAKV0QcYVFU=;
        b=Yce0j/MYSforJEY/FdhK+0Z6XiJnDyDzesijpQL921mhbdxAdzRmzeuJFnNOnSltSS
         Q3Jg/3c7NPJpfGPhN4dAbZuL3x+OHkgRsXuyI9kWIN5v8SRbUyOeRYjmPAKjZemGO5D2
         Vkk9UOliRdDknaHAeg19MowhMkD2H0K6PZgrkqsoGn7h0O4IvqE841d1H2TkFj9ewF/A
         tCyC7SWS3Anl0xQtc4obYvBGkRLOQD1lXITNUh4vVryD4Z4rLf3dHVDHjq98Qk5CJ6ko
         /Rw4b0x11IWJ1JpZ2yZtU4Zeolv2x3NT4wyBNeGu6ls9M5RAPId3+sYZWe90202K/6c+
         sC3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vzrhPCJXUj1fOavLwHq12IVPyJwyXk3DJAKV0QcYVFU=;
        b=X1VxSloTdCx86mmtjti17/1/Kb85kCA8fl29X/xdeXm9PntpHK4R+giZpi0VWsEpXa
         Yw/KFK/cJS0gkOXf1ZjKBACU54DALbt8xHQ4iKTZWzmtl+2By8M/pW5t3O9LVKKROTqM
         vIbEBqzHxyxyUkI33GOtY6Z1gdFlbGvjDyQru8+YzkN6MJ5UEc+7f4JgXupVWCsss864
         fYLUDxZJ+LP91ftG9eTIUaPGuceSMj8f2G3tcTVCNelWtZ1d4e5gMOlIBP7la/kZb/dl
         bfXjkFgOyoZg5Vlqr1BO2sOuBBqQ6rrMJoS8zbrIPsVCyKusk9wRkoelqzUqRvsZ9eoU
         Kq7w==
X-Gm-Message-State: AOAM531JxgNCT9nr/vlpT8drAGw+ibAccxC5s9Vd6KfDnZ7oV7vVgAkM
        uyeCTPvK/hzMM4j7LYtS+BISsw/YIHMN+MSvVJQ36JmEXWZj9RjHt1HZWRGz5vVIQ9MbFyEo1i1
        4gNBR1kbmiPVQbU6RmupHbG4HHh7CnPKb5me0YsD9tN2zLmPDs0YnYHhewU+Jz14=
X-Google-Smtp-Source: ABdhPJyaehaWAuYwB8SihBXN64/1UlLg9+11CwQvDCfXLxCM1UEVoM/8ZEY6K89WNS+JfxD6MuO5HfZOhc9Qpw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:1ac9:: with SMTP id
 f9mr5351344pfv.65.1644945842594; Tue, 15 Feb 2022 09:24:02 -0800 (PST)
Date:   Wed, 16 Feb 2022 01:23:16 +0800
In-Reply-To: <20220215172318.73533-1-chooglen@google.com>
Message-Id: <20220215172318.73533-8-chooglen@google.com>
Mime-Version: 1.0
References: <20220210044152.78352-1-chooglen@google.com> <20220215172318.73533-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH v2 7/9] fetch: fetch unpopulated, changed submodules
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git fetch --recurse-submodules" only considers populated
submodules (i.e. submodules that can be found by iterating the index),
which makes "git fetch" behave differently based on which commit is
checked out. As a result, even if the user has initialized all submodules
correctly, they may not fetch the necessary submodule commits, and
commands like "git checkout --recurse-submodules" might fail.

Teach "git fetch" to fetch cloned, changed submodules regardless of
whether they are populated (this is in addition to the current behavior
of fetching populated submodules).

Since a submodule may be encountered multiple times (via the list of
populated submodules or via the list of changed submodules), maintain a
list of seen submodules to avoid fetching a submodule more than once.

Signed-off-by: Glen Choo <chooglen@google.com>
---
As I mentioned in the cover letter, I'm not entirely happy with the
name repo_has_absorbed_submodules() - it's not a standardized term AFAIK
and it's a little clunky.

"absorbed submodule" is just a stand-in for "submodule in .git/modules",
so if we have a better term for "submodule in .git/modules", let's use
that instead.

 Documentation/fetch-options.txt |  26 +++--
 Documentation/git-fetch.txt     |  10 +-
 builtin/fetch.c                 |  14 +--
 submodule.c                     | 134 +++++++++++++++++++---
 submodule.h                     |  12 +-
 t/t5526-fetch-submodules.sh     | 195 ++++++++++++++++++++++++++++++++
 6 files changed, 349 insertions(+), 42 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index e967ff1874..38dad13683 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -185,15 +185,23 @@ endif::git-pull[]
 ifndef::git-pull[]
 --recurse-submodules[=yes|on-demand|no]::
 	This option controls if and under what conditions new commits of
-	populated submodules should be fetched too. It can be used as a
-	boolean option to completely disable recursion when set to 'no' or to
-	unconditionally recurse into all populated submodules when set to
-	'yes', which is the default when this option is used without any
-	value. Use 'on-demand' to only recurse into a populated submodule
-	when the superproject retrieves a commit that updates the submodule's
-	reference to a commit that isn't already in the local submodule
-	clone. By default, 'on-demand' is used, unless
-	`fetch.recurseSubmodules` is set (see linkgit:git-config[1]).
+	submodules should be fetched too. When recursing through submodules,
+	`git fetch` always attempts to fetch "changed" submodules, that is, a
+	submodule that has commits that are referenced by a newly fetched
+	superproject commit but are missing in the local submodule clone. A
+	changed submodule can be fetched as long as it is present locally e.g.
+	in `$GIT_DIR/modules/` (see linkgit:gitsubmodules[7]); if the upstream
+	adds a new submodule, that submodule cannot be fetched until it is
+	cloned e.g. by `git submodule update`.
++
+When set to 'on-demand', only changed submodules are fetched. When set
+to 'yes', all populated submodules are fetched and submodules that are
+both unpopulated and changed are fetched. When set to 'no', submodules
+are never fetched.
++
+When unspecified, this uses the value of `fetch.recurseSubmodules` if it
+is set (see linkgit:git-config[1]), defaulting to 'on-demand' if unset.
+When this option is used without any value, it defaults to 'yes'.
 endif::git-pull[]
 
 -j::
diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index 550c16ca61..e9d364669a 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -287,12 +287,10 @@ include::transfer-data-leaks.txt[]
 
 BUGS
 ----
-Using --recurse-submodules can only fetch new commits in already checked
-out submodules right now. When e.g. upstream added a new submodule in the
-just fetched commits of the superproject the submodule itself cannot be
-fetched, making it impossible to check out that submodule later without
-having to do a fetch again. This is expected to be fixed in a future Git
-version.
+Using --recurse-submodules can only fetch new commits in submodules that are
+present locally e.g. in `$GIT_DIR/modules/`. If the upstream adds a new
+submodule, that submodule cannot be fetched until it is cloned e.g. by `git
+submodule update`. This is expected to be fixed in a future Git version.
 
 SEE ALSO
 --------
diff --git a/builtin/fetch.c b/builtin/fetch.c
index f7abbc31ff..faaf89f637 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2122,13 +2122,13 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 			max_children = fetch_parallel_config;
 
 		add_options_to_argv(&options);
-		result = fetch_populated_submodules(the_repository,
-						    &options,
-						    submodule_prefix,
-						    recurse_submodules,
-						    recurse_submodules_default,
-						    verbosity < 0,
-						    max_children);
+		result = fetch_submodules(the_repository,
+					  &options,
+					  submodule_prefix,
+					  recurse_submodules,
+					  recurse_submodules_default,
+					  verbosity < 0,
+					  max_children);
 		strvec_clear(&options);
 	}
 
diff --git a/submodule.c b/submodule.c
index 22d8a1ca12..3558fddeb7 100644
--- a/submodule.c
+++ b/submodule.c
@@ -811,6 +811,16 @@ static const char *default_name_or_path(const char *path_or_name)
  * member of the changed submodule string_list_item.
  */
 struct changed_submodule_data {
+	/*
+	 * The first superproject commit in the rev walk that points to the
+	 * submodule.
+	 */
+	const struct object_id *super_oid;
+	/*
+	 * Path to the submodule in the superproject commit referenced
+	 * by 'super_oid'.
+	 */
+	char *path;
 	/* The submodule commits that have changed in the rev walk. */
 	struct oid_array new_commits;
 };
@@ -818,6 +828,7 @@ struct changed_submodule_data {
 static void changed_submodule_data_clear(struct changed_submodule_data *cs_data)
 {
 	oid_array_clear(&cs_data->new_commits);
+	free(cs_data->path);
 }
 
 static void collect_changed_submodules_cb(struct diff_queue_struct *q,
@@ -865,6 +876,8 @@ static void collect_changed_submodules_cb(struct diff_queue_struct *q,
 		if (!item->util)
 			item->util = xcalloc(1, sizeof(struct changed_submodule_data));
 		cs_data = item->util;
+		cs_data->super_oid = commit_oid;
+		cs_data->path = xstrdup(p->two->path);
 		oid_array_append(&cs_data->new_commits, &p->two->oid);
 	}
 }
@@ -1248,14 +1261,28 @@ void check_for_new_submodule_commits(struct object_id *oid)
 	oid_array_append(&ref_tips_after_fetch, oid);
 }
 
+/*
+ * Returns 1 if the repo has absorbed submodule gitdirs, and 0
+ * otherwise. Like submodule_name_to_gitdir(), this checks
+ * $GIT_DIR/modules, not $GIT_COMMON_DIR.
+ */
+static int repo_has_absorbed_submodules(struct repository *r)
+{
+	struct strbuf buf = STRBUF_INIT;
+
+	strbuf_repo_git_path(&buf, r, "modules/");
+	return file_exists(buf.buf) && !is_empty_dir(buf.buf);
+}
+
 static void calculate_changed_submodule_paths(struct repository *r,
 		struct string_list *changed_submodule_names)
 {
 	struct strvec argv = STRVEC_INIT;
 	struct string_list_item *name;
 
-	/* No need to check if there are no submodules configured */
-	if (!submodule_from_path(r, NULL, NULL))
+	/* No need to check if no submodules would be fetched */
+	if (!submodule_from_path(r, NULL, NULL) &&
+	    !repo_has_absorbed_submodules(r))
 		return;
 
 	strvec_push(&argv, "--"); /* argv[0] program name */
@@ -1328,7 +1355,8 @@ int submodule_touches_in_range(struct repository *r,
 }
 
 struct submodule_parallel_fetch {
-	int count;
+	int index_count;
+	int changed_count;
 	struct strvec args;
 	struct repository *r;
 	const char *prefix;
@@ -1338,6 +1366,7 @@ struct submodule_parallel_fetch {
 	int result;
 
 	struct string_list changed_submodule_names;
+	struct string_list seen_submodule_names;
 
 	/* Pending fetches by OIDs */
 	struct fetch_task **oid_fetch_tasks;
@@ -1348,6 +1377,7 @@ struct submodule_parallel_fetch {
 #define SPF_INIT { \
 	.args = STRVEC_INIT, \
 	.changed_submodule_names = STRING_LIST_INIT_DUP, \
+	.seen_submodule_names = STRING_LIST_INIT_DUP, \
 	.submodules_with_errors = STRBUF_INIT, \
 }
 
@@ -1462,11 +1492,12 @@ static struct repository *get_submodule_repo_for(struct repository *r,
 }
 
 static struct fetch_task *
-get_fetch_task(struct submodule_parallel_fetch *spf,
-	       const char **default_argv, struct strbuf *err)
+get_fetch_task_from_index(struct submodule_parallel_fetch *spf,
+			  const char **default_argv, struct strbuf *err)
 {
-	for (; spf->count < spf->r->index->cache_nr; spf->count++) {
-		const struct cache_entry *ce = spf->r->index->cache[spf->count];
+	for (; spf->index_count < spf->r->index->cache_nr; spf->index_count++) {
+		const struct cache_entry *ce =
+			spf->r->index->cache[spf->index_count];
 		struct fetch_task *task;
 
 		if (!S_ISGITLINK(ce->ce_mode))
@@ -1476,6 +1507,15 @@ get_fetch_task(struct submodule_parallel_fetch *spf,
 		if (!task)
 			continue;
 
+		/*
+		 * We might have already considered this submodule
+		 * because we saw it when iterating the changed
+		 * submodule names.
+		 */
+		if (string_list_lookup(&spf->seen_submodule_names,
+				       task->sub->name))
+			continue;
+
 		switch (get_fetch_recurse_config(task->sub, spf))
 		{
 		default:
@@ -1501,7 +1541,7 @@ get_fetch_task(struct submodule_parallel_fetch *spf,
 				strbuf_addf(err, _("Fetching submodule %s%s\n"),
 					    spf->prefix, ce->name);
 
-			spf->count++;
+			spf->index_count++;
 			return task;
 		} else {
 			struct strbuf empty_submodule_path = STRBUF_INIT;
@@ -1529,12 +1569,77 @@ get_fetch_task(struct submodule_parallel_fetch *spf,
 	return NULL;
 }
 
+static struct fetch_task *
+get_fetch_task_from_changed(struct submodule_parallel_fetch *spf,
+			    const char **default_argv, struct strbuf *err)
+{
+	for (; spf->changed_count < spf->changed_submodule_names.nr;
+	     spf->changed_count++) {
+		struct string_list_item item =
+			spf->changed_submodule_names.items[spf->changed_count];
+		struct changed_submodule_data *cs_data = item.util;
+		struct fetch_task *task;
+
+		/*
+		 * We might have already considered this submodule
+		 * because we saw it in the index.
+		 */
+		if (string_list_lookup(&spf->seen_submodule_names, item.string))
+			continue;
+
+		task = fetch_task_create(spf->r, cs_data->path,
+					 cs_data->super_oid);
+		if (!task)
+			continue;
+
+		switch (get_fetch_recurse_config(task->sub, spf)) {
+		default:
+		case RECURSE_SUBMODULES_DEFAULT:
+		case RECURSE_SUBMODULES_ON_DEMAND:
+			*default_argv = "on-demand";
+			break;
+		case RECURSE_SUBMODULES_ON:
+			*default_argv = "yes";
+			break;
+		case RECURSE_SUBMODULES_OFF:
+			continue;
+		}
+
+		task->repo = get_submodule_repo_for(spf->r, task->sub->path,
+						    cs_data->super_oid);
+		if (!task->repo) {
+			fetch_task_release(task);
+			free(task);
+
+			strbuf_addf(err, _("Could not access submodule '%s'\n"),
+				    cs_data->path);
+			continue;
+		}
+		if (!is_tree_submodule_active(spf->r, cs_data->super_oid,
+					      task->sub->path))
+			continue;
+
+		if (!spf->quiet)
+			strbuf_addf(err,
+				    _("Fetching submodule %s%s at commit %s\n"),
+				    spf->prefix, task->sub->path,
+				    find_unique_abbrev(cs_data->super_oid,
+						       DEFAULT_ABBREV));
+		spf->changed_count++;
+		return task;
+	}
+	return NULL;
+}
+
 static int get_next_submodule(struct child_process *cp, struct strbuf *err,
 			      void *data, void **task_cb)
 {
 	struct submodule_parallel_fetch *spf = data;
 	const char *default_argv = NULL;
-	struct fetch_task *task = get_fetch_task(spf, &default_argv, err);
+	struct fetch_task *task =
+		get_fetch_task_from_index(spf, &default_argv, err);
+	if (!task)
+		task = get_fetch_task_from_changed(spf, &default_argv, err);
 
 	if (task) {
 		struct strbuf submodule_prefix = STRBUF_INIT;
@@ -1555,6 +1660,7 @@ static int get_next_submodule(struct child_process *cp, struct strbuf *err,
 		*task_cb = task;
 
 		strbuf_release(&submodule_prefix);
+		string_list_insert(&spf->seen_submodule_names, task->sub->name);
 		return 1;
 	}
 
@@ -1669,11 +1775,11 @@ static int fetch_finish(int retvalue, struct strbuf *err,
 	return 0;
 }
 
-int fetch_populated_submodules(struct repository *r,
-			       const struct strvec *options,
-			       const char *prefix, int command_line_option,
-			       int default_option,
-			       int quiet, int max_parallel_jobs)
+int fetch_submodules(struct repository *r,
+		     const struct strvec *options,
+		     const char *prefix, int command_line_option,
+		     int default_option,
+		     int quiet, int max_parallel_jobs)
 {
 	int i;
 	struct submodule_parallel_fetch spf = SPF_INIT;
diff --git a/submodule.h b/submodule.h
index 784ceffc0e..61bebde319 100644
--- a/submodule.h
+++ b/submodule.h
@@ -88,12 +88,12 @@ int should_update_submodules(void);
  */
 const struct submodule *submodule_from_ce(const struct cache_entry *ce);
 void check_for_new_submodule_commits(struct object_id *oid);
-int fetch_populated_submodules(struct repository *r,
-			       const struct strvec *options,
-			       const char *prefix,
-			       int command_line_option,
-			       int default_option,
-			       int quiet, int max_parallel_jobs);
+int fetch_submodules(struct repository *r,
+		     const struct strvec *options,
+		     const char *prefix,
+		     int command_line_option,
+		     int default_option,
+		     int quiet, int max_parallel_jobs);
 unsigned is_submodule_modified(const char *path, int ignore_untracked);
 int submodule_uses_gitfile(const char *path);
 
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index cb18f0ac21..df44757468 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -399,6 +399,201 @@ test_expect_success "'--recurse-submodules=on-demand' recurses as deep as necess
 	verify_fetch_result actual.err
 '
 
+# Test that we can fetch submodules in other branches by running fetch
+# in a commit that has no submodules.
+test_expect_success 'setup downstream branch without submodules' '
+	(
+		cd downstream &&
+		git checkout --recurse-submodules -b no-submodules &&
+		rm .gitmodules &&
+		git rm submodule &&
+		git add .gitmodules &&
+		git commit -m "no submodules" &&
+		git checkout --recurse-submodules super
+	)
+'
+
+test_expect_success "'--recurse-submodules=on-demand' should fetch submodule commits if the submodule is changed but the index has no submodules" '
+	git -C downstream fetch --recurse-submodules &&
+	# Create new superproject commit with updated submodules
+	add_upstream_commit &&
+	(
+		cd submodule &&
+		(
+			cd subdir/deepsubmodule &&
+			git fetch &&
+			git checkout -q FETCH_HEAD
+		) &&
+		git add subdir/deepsubmodule &&
+		git commit -m "new deep submodule"
+	) &&
+	git add submodule &&
+	git commit -m "new submodule" &&
+
+	# Fetch the new superproject commit
+	(
+		cd downstream &&
+		git switch --recurse-submodules no-submodules &&
+		git fetch --recurse-submodules=on-demand >../actual.out 2>../actual.err
+	) &&
+	test_must_be_empty actual.out &&
+	git rev-parse --short HEAD >superhead &&
+	git -C submodule rev-parse --short HEAD >subhead &&
+	git -C deepsubmodule rev-parse --short HEAD >deephead &&
+	verify_fetch_result actual.err &&
+
+	# Assert that the fetch happened at the non-HEAD commits
+	grep "Fetching submodule submodule at commit $superhead" actual.err &&
+	grep "Fetching submodule submodule/subdir/deepsubmodule at commit $subhead" actual.err
+'
+
+test_expect_success "'--recurse-submodules' should fetch submodule commits if the submodule is changed but the index has no submodules" '
+	# Fetch any leftover commits from other tests.
+	git -C downstream fetch --recurse-submodules &&
+	# Create new superproject commit with updated submodules
+	add_upstream_commit &&
+	(
+		cd submodule &&
+		(
+			cd subdir/deepsubmodule &&
+			git fetch &&
+			git checkout -q FETCH_HEAD
+		) &&
+		git add subdir/deepsubmodule &&
+		git commit -m "new deep submodule"
+	) &&
+	git add submodule &&
+	git commit -m "new submodule" &&
+
+	# Fetch the new superproject commit
+	(
+		cd downstream &&
+		git switch --recurse-submodules no-submodules &&
+		git fetch --recurse-submodules >../actual.out 2>../actual.err
+	) &&
+	test_must_be_empty actual.out &&
+	git rev-parse --short HEAD >superhead &&
+	git -C submodule rev-parse --short HEAD >subhead &&
+	git -C deepsubmodule rev-parse --short HEAD >deephead &&
+	verify_fetch_result actual.err &&
+
+	# Assert that the fetch happened at the non-HEAD commits
+	grep "Fetching submodule submodule at commit $superhead" actual.err &&
+	grep "Fetching submodule submodule/subdir/deepsubmodule at commit $subhead" actual.err
+'
+
+test_expect_success "'--recurse-submodules' should ignore changed, inactive submodules" '
+	# Fetch any leftover commits from other tests.
+	git -C downstream fetch --recurse-submodules &&
+	# Create new superproject commit with updated submodules
+	add_upstream_commit &&
+	(
+		cd submodule &&
+		(
+			cd subdir/deepsubmodule &&
+			git fetch &&
+			git checkout -q FETCH_HEAD
+		) &&
+		git add subdir/deepsubmodule &&
+		git commit -m "new deep submodule"
+	) &&
+	git add submodule &&
+	git commit -m "new submodule" &&
+
+	# Fetch the new superproject commit
+	(
+		cd downstream &&
+		git switch --recurse-submodules no-submodules &&
+		git -c submodule.submodule.active=false fetch --recurse-submodules >../actual.out 2>../actual.err
+	) &&
+	test_must_be_empty actual.out &&
+	git rev-parse --short HEAD >superhead &&
+	# Neither should be fetched because the submodule is inactive
+	rm subhead &&
+	rm deephead &&
+	verify_fetch_result actual.err
+'
+
+# In downstream, init "submodule2", but do not check it out while
+# fetching. This lets us assert that unpopulated submodules can be
+# fetched.
+test_expect_success 'setup downstream branch with other submodule' '
+	mkdir submodule2 &&
+	(
+		cd submodule2 &&
+		git init &&
+		echo sub2content >sub2file &&
+		git add sub2file &&
+		git commit -a -m new &&
+		git branch -M sub2
+	) &&
+	git checkout -b super-sub2-only &&
+	git submodule add "$pwd/submodule2" submodule2 &&
+	git commit -m "add sub2" &&
+	git checkout super &&
+	(
+		cd downstream &&
+		git fetch --recurse-submodules origin &&
+		git checkout super-sub2-only &&
+		# Explicitly run "git submodule update" because sub2 is new
+		# and has not been cloned.
+		git submodule update --init &&
+		git checkout --recurse-submodules super
+	)
+'
+
+test_expect_success "'--recurse-submodules' should fetch submodule commits in changed submodules and the index" '
+	# Fetch any leftover commits from other tests.
+	git -C downstream fetch --recurse-submodules &&
+	# Create new commit in origin/super
+	add_upstream_commit &&
+	(
+		cd submodule &&
+		(
+			cd subdir/deepsubmodule &&
+			git fetch &&
+			git checkout -q FETCH_HEAD
+		) &&
+		git add subdir/deepsubmodule &&
+		git commit -m "new deep submodule"
+	) &&
+	git add submodule &&
+	git commit -m "new submodule" &&
+
+	# Create new commit in origin/super-sub2-only
+	git checkout super-sub2-only &&
+	(
+		cd submodule2 &&
+		test_commit --no-tag foo
+	) &&
+	git add submodule2 &&
+	git commit -m "new submodule2" &&
+
+	git checkout super &&
+	(
+		cd downstream &&
+		git fetch --recurse-submodules >../actual.out 2>../actual.err
+	) &&
+	test_must_be_empty actual.out &&
+
+	# Assert that the submodules in the super branch are fetched
+	git rev-parse --short HEAD >superhead &&
+	git -C submodule rev-parse --short HEAD >subhead &&
+	git -C deepsubmodule rev-parse --short HEAD >deephead &&
+	verify_fetch_result actual.err &&
+	# grep for the exact line to check that the submodule is read
+	# from the index, not from a commit
+	grep "^Fetching submodule submodule\$" actual.err &&
+
+	# Assert that super-sub2-only and submodule2 were fetched even
+	# though another branch is checked out
+	super_sub2_only_head=$(git rev-parse --short super-sub2-only) &&
+	grep -E "\.\.${super_sub2_only_head}\s+super-sub2-only\s+-> origin/super-sub2-only" actual.err &&
+	grep "Fetching submodule submodule2 at commit $super_sub2_only_head" actual.err &&
+	sub2head=$(git -C submodule2 rev-parse --short HEAD) &&
+	grep -E "\.\.${sub2head}\s+sub2\s+-> origin/sub2" actual.err
+'
+
 test_expect_success "'--recurse-submodules=on-demand' stops when no new submodule commits are found in the superproject (and ignores config)" '
 	add_upstream_commit &&
 	echo a >> file &&
-- 
2.33.GIT

