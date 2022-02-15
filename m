Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40B4C433F5
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 17:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242468AbiBORYB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 12:24:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235185AbiBORX7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 12:23:59 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3340FD3AD7
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 09:23:48 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id d16-20020a056a0010d000b004e0204c9753so14468995pfu.7
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 09:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wAJZhxd70yD7ig7iRAtOSfDAtldOuxVOBHOYImNpJb4=;
        b=TgbG9hG8tAgDOMR4pOr9TIwT3j0eK2Hfuvu4JYDBbeSqjAUZzAkZ3sO2Hya4cr1Iqf
         ubgi9O3WvU34Kn9qGkEib1gnVqpbpKklnWJCTjiN4xV6N6kL5Hq03qyrT7Vr2n980KDK
         5x3I64XT/XMKSzKM79thEVHi9/g+BTxADwd71pfrKtwK5LlWpYlqVnFd8EcDprnkyn4J
         xk1okGdygAcBda83eddkCphQhO1vUpwdhY9qxhPkxhO3hc83/w0xfk1d4Vq4BIPo/bil
         AGWNyq7ICXdqhC6vNw1GMWQQa553IZKju0St1lbC7GoFAVUCfVyY9X2W9i7r1ykrhRqD
         isHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wAJZhxd70yD7ig7iRAtOSfDAtldOuxVOBHOYImNpJb4=;
        b=1+S4ifx/WjXf50kW9wFAJ0W4FLtcgXH0rlcep+7X3ch36x8nMWOOsXFgArg0WCZqXr
         DjI/T22tjjNIScGqDXWFaijZJEc6alEQfqLqXUMR28X8orKtL0ztJ/VAj12T8Ljxv/JD
         txdu7xxMu3uz0F/HhFRrRq5nOwSznfsBIkl61F+hlc/6abG3zZiy/H0+/IviHwVO+xRG
         CS6YiPjdGo0tIfz/zdFYbekV0/eU2JgvRedrcNPxEz75neDycJc8/a13ZD35detybGDx
         DFlA324vq5pOdxNqhTlg7Odt9w9Oh8FAZs1Z0Cf6JpiFhEtCdSAqvc7Do239zbHNQSEc
         DOfw==
X-Gm-Message-State: AOAM532ZFv+ft2PXZ2xEkebMCp2WwxVsvqaK8g3y9ukkRzsNu8+oQaFg
        x4EAZn6R/JiQdex1kOQwgy+grMxIcPBDL5s3jNCEH+w1+iR1mOrOlwcPPnXxIGCxH2EkbjpH9qZ
        sRVYL6NLgFdUSl3/tF1nt5cWXpXO4t8KNyIKtr2+yulokAPf2IbjqxgZdmpchDV0=
X-Google-Smtp-Source: ABdhPJzvKE9f62rWxZtKjOmVKRl86t0vUsVq8BAIoihm+nZdYO54Oeb7n7xcOtNVpkqCUlQGebNTomywW4VJgA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:d4c2:: with SMTP id
 o2mr53929plg.14.1644945826817; Tue, 15 Feb 2022 09:23:46 -0800 (PST)
Date:   Wed, 16 Feb 2022 01:23:09 +0800
In-Reply-To: <20220210044152.78352-1-chooglen@google.com>
Message-Id: <20220215172318.73533-1-chooglen@google.com>
Mime-Version: 1.0
References: <20220210044152.78352-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH v2 0/9] fetch --recurse-submodules: fetch unpopulated submodules
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Original cover letter: https://lore.kernel.org/git/20220210044152.78352-1-chooglen@google.com

This series is based on gc/branch-recurse-submodules.

Thanks for the kind feedback :) I believe this version addresses all of
the feedback, though I suspect that I might not have given clear-enough
answers to all of the questions. Let me know if more clarification is
needed.

= Patch organization

The patches are organized somewhat differently vs v1. During review of
v1, I realized that it didn't make sense to read submodules from the
superproject commit until we actually fetch unpopulated submodules. So
this version just has all of the C patches together, instead of
putting the test suite patches after "read submodules from the
superproject commit".

- Patches 1-2 are quality-of-life improvements to the test suite that
  make it easier to write the tests in patch 7.
- Patches 3-5 are preparation for "git fetch" to read .gitmodules from
  the superproject commit in patch 7.
- Patch 6 separates the steps of "finding which submodules to fetch" and
  "fetching the submodules", making it easier to tell "git fetch" to
  fetch unpopulated submodules.
- Patch 7 teaches "git fetch" to fetch changed, unpopulated submodules
  in addition to populated submodules.
- Patch 8 is an optional bugfix that fixes a bug with "git fetch
  --update-shallow" in a repository with submodules. This was discovered
  in v1 but is no longer necessary for tests to pass.
- Patch 9 is an optional bugfix + cleanup of the "git fetch" code that
  removes the last caller of the deprecated "add_submodule_odb()".

= Changes

Since v1:
- Numerous style fixes suggested by Jonathan (thanks!)
- In patch 3, don't prematurely read submodules from the superproject
  commit (see:
  <kl6l5yplyat6.fsf@chooglen-macbookpro.roam.corp.google.com>).
- In patch 7, stop using "git checkout" and "! grep" in tests.
- In patch 7, stop doing the "find changed submodules" rev walk
  unconditionally. Instead, continue to check for .gitmodules, but also
  check for submodules in $GIT_DIR/modules.
  - I'm not entirely happy with the helper function name, see "---" for
    details.
- Move "git fetch --update-shallow" bugfix to patch 8.
  - Because the "find changed submodules" rev walk is no longer
    unconditional, this fix is no longer needed for tests to pass.
- Rename fetch_populated_submodules() to fetch_submodules().

Glen Choo (9):
  t5526: introduce test helper to assert on fetches
  t5526: use grep to assert on fetches
  submodule: make static functions read submodules from commits
  submodule: inline submodule_commits() into caller
  submodule: store new submodule commits oid_array in a struct
  submodule: extract get_fetch_task()
  fetch: fetch unpopulated, changed submodules
  submodule: read shallows when finding changed submodules
  submodule: fix latent check_has_commit() bug

 Documentation/fetch-options.txt |  26 ++-
 Documentation/git-fetch.txt     |  10 +-
 builtin/fetch.c                 |  14 +-
 submodule.c                     | 321 +++++++++++++++++----------
 submodule.h                     |  21 +-
 t/t5526-fetch-submodules.sh     | 374 ++++++++++++++++++++++++--------
 6 files changed, 534 insertions(+), 232 deletions(-)

Range-diff against v1:
 4:  432aa60296 =  1:  a159cdaabb t5526: introduce test helper to assert on fetches
 5:  9515d22804 =  2:  48894c6c43 t5526: use grep to assert on fetches
 3:  3c28ea743c !  3:  6cf5e76d62 submodule: make static functions read submodules from commits
    @@ Commit message
         submodule: make static functions read submodules from commits
     
         A future commit will teach "fetch --recurse-submodules" to fetch
    -    unpopulated submodules. Prepare for this by teaching the necessary
    -    static functions to read submodules from superproject commits instead of
    -    the index and filesystem. Then, store the necessary fields (path and
    -    super_oid), and use them in "fetch --recurse-submodules" where possible.
    +    unpopulated submodules. To prepare for this, teach the necessary static
    +    functions how to read submodules from superproject commits using a
    +    "treeish_name" argument (instead of always reading from the index and
    +    filesystem) but do not actually change where submodules are read from.
    +    Submodules will be read from commits when we fetch unpopulated
    +    submodules.
     
    -    As a result, "git fetch" now reads changed submodules using the
    -    `.gitmodules` and path from super_oid's tree (which is where "git fetch"
    -    actually noticed the changed submodule) instead of the filesystem.
    +    The changed function signatures follow repo_submodule_init()'s argument
    +    order, i.e. "path" then "treeish_name". Where needed, reorder the
    +    arguments of functions that already take "path" and "treeish_name" to be
    +    consistent with this convention.
     
         Signed-off-by: Glen Choo <chooglen@google.com>
     
      ## submodule.c ##
    -@@ submodule.c: static const char *default_name_or_path(const char *path_or_name)
    -  * member of the changed submodule string_list_item.
    -  */
    - struct changed_submodule_data {
    -+	/*
    -+	 * The first superproject commit in the rev walk that points to the
    -+	 * submodule.
    -+	 */
    -+	const struct object_id *super_oid;
    -+	/*
    -+	 * Path to the submodule in the superproject commit referenced
    -+	 * by 'super_oid'.
    -+	 */
    -+	char *path;
    - 	/* The submodule commits that have changed in the rev walk. */
    - 	struct oid_array *new_commits;
    - };
    -@@ submodule.c: static void changed_submodule_data_clear(struct changed_submodule_data *cs_data)
    - {
    - 	oid_array_clear(cs_data->new_commits);
    - 	free(cs_data->new_commits);
    -+	free(cs_data->path);
    - }
    - 
    - static void collect_changed_submodules_cb(struct diff_queue_struct *q,
    -@@ submodule.c: static void collect_changed_submodules_cb(struct diff_queue_struct *q,
    - 			cs_data = xcalloc(1, sizeof(struct changed_submodule_data));
    - 			/* NEEDSWORK: should we have oid_array_init()? */
    - 			cs_data->new_commits = xcalloc(1, sizeof(struct oid_array));
    -+			cs_data->super_oid = commit_oid;
    -+			cs_data->path = xstrdup(p->two->path);
    - 			item->util = cs_data;
    - 		}
    - 		oid_array_append(cs_data->new_commits, &p->two->oid);
     @@ submodule.c: struct has_commit_data {
      	struct repository *repo;
      	int result;
    @@ submodule.c: static int submodule_needs_pushing(struct repository *r,
      		/*
      		 * NOTE: We do consider it safe to return "no" here. The
      		 * correct answer would be "We do not know" instead of
    -@@ submodule.c: static void calculate_changed_submodule_paths(struct repository *r,
    - 		const struct submodule *submodule;
    - 		const char *path = NULL;
    - 
    --		submodule = submodule_from_name(r, null_oid(), name->string);
    -+		submodule = submodule_from_name(r, cs_data->super_oid, name->string);
    - 		if (submodule)
    - 			path = submodule->path;
    - 		else
     @@ submodule.c: static void calculate_changed_submodule_paths(struct repository *r,
      		if (!path)
      			continue;
      
    --		if (submodule_has_commits(r, path, cs_data->new_commits)) {
    -+		if (submodule_has_commits(r, path, cs_data->super_oid, cs_data->new_commits)) {
    - 			oid_array_clear(cs_data->new_commits);
    +-		if (submodule_has_commits(r, path, commits)) {
    ++		if (submodule_has_commits(r, path, null_oid(), commits)) {
    + 			oid_array_clear(commits);
      			*name->string = '\0';
      		}
     @@ submodule.c: static const struct submodule *get_non_gitmodules_submodule(const char *path)
 1:  a8ef64d16c !  4:  07fd4ff0a9 submodule: inline submodule_commits() into caller
    @@ Commit message
     
         Prepare for this change by inlining submodule_commits() (which inserts
         into the string_list and initializes the string_list_item.util) into its
    -    only caller. This simplifies the code and makes it easier for the caller
    -    to add information to the string_list_item.util.
    +    only caller so that the code is easier to refactor later.
     
         Signed-off-by: Glen Choo <chooglen@google.com>
     
 2:  11e48fbd41 !  5:  f049cb231b submodule: store new submodule commits oid_array in a struct
    @@ submodule.c: static const char *default_name_or_path(const char *path_or_name)
     + */
     +struct changed_submodule_data {
     +	/* The submodule commits that have changed in the rev walk. */
    -+	struct oid_array *new_commits;
    ++	struct oid_array new_commits;
     +};
     +
     +static void changed_submodule_data_clear(struct changed_submodule_data *cs_data)
     +{
    -+	oid_array_clear(cs_data->new_commits);
    -+	free(cs_data->new_commits);
    ++	oid_array_clear(&cs_data->new_commits);
     +}
     +
      static void collect_changed_submodules_cb(struct diff_queue_struct *q,
    @@ submodule.c: static void collect_changed_submodules_cb(struct diff_queue_struct
      		if (!S_ISGITLINK(p->two->mode))
      			continue;
     @@ submodule.c: static void collect_changed_submodules_cb(struct diff_queue_struct *q,
    - 			continue;
      
      		item = string_list_insert(changed, name);
    --		if (!item->util)
    -+		if (item->util)
    -+			cs_data = item->util;
    -+		else {
    -+			cs_data = xcalloc(1, sizeof(struct changed_submodule_data));
    - 			/* NEEDSWORK: should we have oid_array_init()? */
    + 		if (!item->util)
    +-			/* NEEDSWORK: should we have oid_array_init()? */
     -			item->util = xcalloc(1, sizeof(struct oid_array));
     -		oid_array_append(item->util, &p->two->oid);
    -+			cs_data->new_commits = xcalloc(1, sizeof(struct oid_array));
    -+			item->util = cs_data;
    -+		}
    -+		oid_array_append(cs_data->new_commits, &p->two->oid);
    ++			item->util = xcalloc(1, sizeof(struct changed_submodule_data));
    ++		cs_data = item->util;
    ++		oid_array_append(&cs_data->new_commits, &p->two->oid);
      	}
      }
      
    @@ submodule.c: int find_unpushed_submodules(struct repository *r,
      			continue;
      
     -		if (submodule_needs_pushing(r, path, commits))
    -+		if (submodule_needs_pushing(r, path, cs_data->new_commits))
    ++		if (submodule_needs_pushing(r, path, &cs_data->new_commits))
      			string_list_insert(needs_pushing, path);
      	}
      
    @@ submodule.c: static void calculate_changed_submodule_paths(struct repository *r,
      		if (!path)
      			continue;
      
    --		if (submodule_has_commits(r, path, commits)) {
    +-		if (submodule_has_commits(r, path, null_oid(), commits)) {
     -			oid_array_clear(commits);
    -+		if (submodule_has_commits(r, path, cs_data->new_commits)) {
    -+			oid_array_clear(cs_data->new_commits);
    ++		if (submodule_has_commits(r, path, null_oid(), &cs_data->new_commits)) {
    ++			changed_submodule_data_clear(cs_data);
      			*name->string = '\0';
      		}
      	}
    @@ submodule.c: static int fetch_finish(int retvalue, struct strbuf *err,
     -	commits = it->util;
     -	oid_array_filter(commits,
     +	cs_data = it->util;
    -+	oid_array_filter(cs_data->new_commits,
    ++	oid_array_filter(&cs_data->new_commits,
      			 commit_missing_in_sub,
      			 task->repo);
      
      	/* Are there commits we want, but do not exist? */
     -	if (commits->nr) {
     -		task->commits = commits;
    -+	if (cs_data->new_commits->nr) {
    -+		task->commits = cs_data->new_commits;
    ++	if (cs_data->new_commits.nr) {
    ++		task->commits = &cs_data->new_commits;
      		ALLOC_GROW(spf->oid_fetch_tasks,
      			   spf->oid_fetch_tasks_nr + 1,
      			   spf->oid_fetch_tasks_alloc);
 6:  db6de6617b !  6:  814073eecc submodule: extract get_fetch_task()
    @@ submodule.c: static int get_next_submodule(struct child_process *cp,
      			break;
      		case RECURSE_SUBMODULES_OFF:
      			continue;
    - 		}
    +@@ submodule.c: static int get_next_submodule(struct child_process *cp,
      
      		task->repo = get_submodule_repo_for(spf->r, task->sub->path, null_oid());
    --		if (task->repo) {
    + 		if (task->repo) {
     -			struct strbuf submodule_prefix = STRBUF_INIT;
     -			child_process_init(cp);
     -			cp->dir = task->repo->gitdir;
     -			prepare_submodule_repo_env_in_gitdir(&cp->env_array);
     -			cp->git_cmd = 1;
    --			if (!spf->quiet)
    --				strbuf_addf(err, _("Fetching submodule %s%s\n"),
    --					    spf->prefix, ce->name);
    + 			if (!spf->quiet)
    + 				strbuf_addf(err, _("Fetching submodule %s%s\n"),
    + 					    spf->prefix, ce->name);
     -			strvec_init(&cp->args);
     -			strvec_pushv(&cp->args, spf->args.v);
     -			strvec_push(&cp->args, default_argv);
    @@ submodule.c: static int get_next_submodule(struct child_process *cp,
     -						       spf->prefix,
     -						       task->sub->path);
     -			strvec_push(&cp->args, submodule_prefix.buf);
    --
    --			spf->count++;
    + 
    + 			spf->count++;
     -			*task_cb = task;
     -
     -			strbuf_release(&submodule_prefix);
     -			return 1;
    --		} else {
    -+		if (!task->repo) {
    ++			return task;
    + 		} else {
      			struct strbuf empty_submodule_path = STRBUF_INIT;
      
    - 			fetch_task_release(task);
     @@ submodule.c: static int get_next_submodule(struct child_process *cp,
    - 					    ce->name);
    - 			}
      			strbuf_release(&empty_submodule_path);
    -+			continue;
      		}
    -+		if (!spf->quiet)
    -+			strbuf_addf(err, _("Fetching submodule %s%s\n"),
    -+				    spf->prefix, ce->name);
    -+
    -+		spf->count++;
    -+		return task;
    -+	}
    + 	}
     +	return NULL;
     +}
     +
    @@ submodule.c: static int get_next_submodule(struct child_process *cp,
     +		strvec_push(&cp->args, default_argv);
     +		strvec_push(&cp->args, "--submodule-prefix");
     +
    -+		strbuf_addf(&submodule_prefix, "%s%s/", spf->prefix,
    -+			    task->sub->path);
    ++		strbuf_addf(&submodule_prefix, "%s%s/",
    ++						spf->prefix,
    ++						task->sub->path);
     +		strvec_push(&cp->args, submodule_prefix.buf);
     +		*task_cb = task;
     +
     +		strbuf_release(&submodule_prefix);
     +		return 1;
    - 	}
    ++	}
      
      	if (spf->oid_fetch_tasks_nr) {
    + 		struct fetch_task *task =
 7:  1737338380 !  7:  10fd5bf921 fetch: fetch unpopulated, changed submodules
    @@ Documentation/git-fetch.txt: include::transfer-data-leaks.txt[]
      SEE ALSO
      --------
     
    + ## builtin/fetch.c ##
    +@@ builtin/fetch.c: int cmd_fetch(int argc, const char **argv, const char *prefix)
    + 			max_children = fetch_parallel_config;
    + 
    + 		add_options_to_argv(&options);
    +-		result = fetch_populated_submodules(the_repository,
    +-						    &options,
    +-						    submodule_prefix,
    +-						    recurse_submodules,
    +-						    recurse_submodules_default,
    +-						    verbosity < 0,
    +-						    max_children);
    ++		result = fetch_submodules(the_repository,
    ++					  &options,
    ++					  submodule_prefix,
    ++					  recurse_submodules,
    ++					  recurse_submodules_default,
    ++					  verbosity < 0,
    ++					  max_children);
    + 		strvec_clear(&options);
    + 	}
    + 
    +
      ## submodule.c ##
    -@@
    - #include "parse-options.h"
    - #include "object-store.h"
    - #include "commit-reach.h"
    -+#include "shallow.h"
    +@@ submodule.c: static const char *default_name_or_path(const char *path_or_name)
    +  * member of the changed submodule string_list_item.
    +  */
    + struct changed_submodule_data {
    ++	/*
    ++	 * The first superproject commit in the rev walk that points to the
    ++	 * submodule.
    ++	 */
    ++	const struct object_id *super_oid;
    ++	/*
    ++	 * Path to the submodule in the superproject commit referenced
    ++	 * by 'super_oid'.
    ++	 */
    ++	char *path;
    + 	/* The submodule commits that have changed in the rev walk. */
    + 	struct oid_array new_commits;
    + };
    +@@ submodule.c: struct changed_submodule_data {
    + static void changed_submodule_data_clear(struct changed_submodule_data *cs_data)
    + {
    + 	oid_array_clear(&cs_data->new_commits);
    ++	free(cs_data->path);
    + }
      
    - static int config_update_recurse_submodules = RECURSE_SUBMODULES_OFF;
    - static int initialized_fetch_ref_tips;
    -@@ submodule.c: static void collect_changed_submodules(struct repository *r,
    + static void collect_changed_submodules_cb(struct diff_queue_struct *q,
    +@@ submodule.c: static void collect_changed_submodules_cb(struct diff_queue_struct *q,
    + 		if (!item->util)
    + 			item->util = xcalloc(1, sizeof(struct changed_submodule_data));
    + 		cs_data = item->util;
    ++		cs_data->super_oid = commit_oid;
    ++		cs_data->path = xstrdup(p->two->path);
    + 		oid_array_append(&cs_data->new_commits, &p->two->oid);
    + 	}
    + }
    +@@ submodule.c: void check_for_new_submodule_commits(struct object_id *oid)
    + 	oid_array_append(&ref_tips_after_fetch, oid);
    + }
      
    - 	save_warning = warn_on_object_refname_ambiguity;
    - 	warn_on_object_refname_ambiguity = 0;
    -+	/* make sure shallows are read */
    -+	is_repository_shallow(the_repository);
    ++/*
    ++ * Returns 1 if the repo has absorbed submodule gitdirs, and 0
    ++ * otherwise. Like submodule_name_to_gitdir(), this checks
    ++ * $GIT_DIR/modules, not $GIT_COMMON_DIR.
    ++ */
    ++static int repo_has_absorbed_submodules(struct repository *r)
    ++{
    ++	struct strbuf buf = STRBUF_INIT;
     +
    - 	repo_init_revisions(r, &rev, NULL);
    - 	setup_revisions(argv->nr, argv->v, &rev, &s_r_opt);
    - 	warn_on_object_refname_ambiguity = save_warning;
    -@@ submodule.c: static void calculate_changed_submodule_paths(struct repository *r,
    ++	strbuf_repo_git_path(&buf, r, "modules/");
    ++	return file_exists(buf.buf) && !is_empty_dir(buf.buf);
    ++}
    ++
    + static void calculate_changed_submodule_paths(struct repository *r,
    + 		struct string_list *changed_submodule_names)
    + {
      	struct strvec argv = STRVEC_INIT;
      	struct string_list_item *name;
      
     -	/* No need to check if there are no submodules configured */
     -	if (!submodule_from_path(r, NULL, NULL))
    --		return;
    --
    ++	/* No need to check if no submodules would be fetched */
    ++	if (!submodule_from_path(r, NULL, NULL) &&
    ++	    !repo_has_absorbed_submodules(r))
    + 		return;
    + 
      	strvec_push(&argv, "--"); /* argv[0] program name */
    - 	oid_array_for_each_unique(&ref_tips_after_fetch,
    - 				   append_oid_to_argv, &argv);
     @@ submodule.c: int submodule_touches_in_range(struct repository *r,
      }
      
    @@ submodule.c: get_fetch_task(struct submodule_parallel_fetch *spf,
      		{
      		default:
     @@ submodule.c: get_fetch_task(struct submodule_parallel_fetch *spf,
    - 			strbuf_addf(err, _("Fetching submodule %s%s\n"),
    - 				    spf->prefix, ce->name);
    + 				strbuf_addf(err, _("Fetching submodule %s%s\n"),
    + 					    spf->prefix, ce->name);
    + 
    +-			spf->count++;
    ++			spf->index_count++;
    + 			return task;
    + 		} else {
    + 			struct strbuf empty_submodule_path = STRBUF_INIT;
    +@@ submodule.c: get_fetch_task(struct submodule_parallel_fetch *spf,
    + 	return NULL;
    + }
      
    --		spf->count++;
    -+		spf->index_count++;
    -+		return task;
    -+	}
    -+	return NULL;
    -+}
    -+
     +static struct fetch_task *
     +get_fetch_task_from_changed(struct submodule_parallel_fetch *spf,
     +			    const char **default_argv, struct strbuf *err)
    @@ submodule.c: get_fetch_task(struct submodule_parallel_fetch *spf,
     +				    find_unique_abbrev(cs_data->super_oid,
     +						       DEFAULT_ABBREV));
     +		spf->changed_count++;
    - 		return task;
    - 	}
    - 	return NULL;
    -@@ submodule.c: static int get_next_submodule(struct child_process *cp, struct strbuf *err,
    ++		return task;
    ++	}
    ++	return NULL;
    ++}
    ++
    + static int get_next_submodule(struct child_process *cp, struct strbuf *err,
    + 			      void *data, void **task_cb)
      {
      	struct submodule_parallel_fetch *spf = data;
      	const char *default_argv = NULL;
    @@ submodule.c: static int get_next_submodule(struct child_process *cp, struct strb
      		return 1;
      	}
      
    +@@ submodule.c: static int fetch_finish(int retvalue, struct strbuf *err,
    + 	return 0;
    + }
    + 
    +-int fetch_populated_submodules(struct repository *r,
    +-			       const struct strvec *options,
    +-			       const char *prefix, int command_line_option,
    +-			       int default_option,
    +-			       int quiet, int max_parallel_jobs)
    ++int fetch_submodules(struct repository *r,
    ++		     const struct strvec *options,
    ++		     const char *prefix, int command_line_option,
    ++		     int default_option,
    ++		     int quiet, int max_parallel_jobs)
    + {
    + 	int i;
    + 	struct submodule_parallel_fetch spf = SPF_INIT;
    +
    + ## submodule.h ##
    +@@ submodule.h: int should_update_submodules(void);
    +  */
    + const struct submodule *submodule_from_ce(const struct cache_entry *ce);
    + void check_for_new_submodule_commits(struct object_id *oid);
    +-int fetch_populated_submodules(struct repository *r,
    +-			       const struct strvec *options,
    +-			       const char *prefix,
    +-			       int command_line_option,
    +-			       int default_option,
    +-			       int quiet, int max_parallel_jobs);
    ++int fetch_submodules(struct repository *r,
    ++		     const struct strvec *options,
    ++		     const char *prefix,
    ++		     int command_line_option,
    ++		     int default_option,
    ++		     int quiet, int max_parallel_jobs);
    + unsigned is_submodule_modified(const char *path, int ignore_untracked);
    + int submodule_uses_gitfile(const char *path);
    + 
     
      ## t/t5526-fetch-submodules.sh ##
     @@ t/t5526-fetch-submodules.sh: test_expect_success "'--recurse-submodules=on-demand' recurses as deep as necess
      	verify_fetch_result actual.err
      '
      
    -+# Cleans up after tests that checkout branches other than the main ones
    -+# in the tests.
    -+checkout_main_branches() {
    -+	git -C downstream checkout --recurse-submodules super &&
    -+	git -C downstream/submodule checkout --recurse-submodules sub &&
    -+	git -C downstream/submodule/subdir/deepsubmodule checkout --recurse-submodules deep
    -+}
    -+
     +# Test that we can fetch submodules in other branches by running fetch
    -+# in a branch that has no submodules.
    ++# in a commit that has no submodules.
     +test_expect_success 'setup downstream branch without submodules' '
     +	(
     +		cd downstream &&
    @@ t/t5526-fetch-submodules.sh: test_expect_success "'--recurse-submodules=on-deman
     +'
     +
     +test_expect_success "'--recurse-submodules=on-demand' should fetch submodule commits if the submodule is changed but the index has no submodules" '
    -+	test_when_finished "checkout_main_branches" &&
     +	git -C downstream fetch --recurse-submodules &&
     +	# Create new superproject commit with updated submodules
     +	add_upstream_commit &&
    @@ t/t5526-fetch-submodules.sh: test_expect_success "'--recurse-submodules=on-deman
     +	(
     +		cd downstream &&
     +		git switch --recurse-submodules no-submodules &&
    -+		git fetch --recurse-submodules=on-demand >../actual.out 2>../actual.err &&
    -+		git checkout --recurse-submodules origin/super 2>../actual-checkout.err
    ++		git fetch --recurse-submodules=on-demand >../actual.out 2>../actual.err
     +	) &&
     +	test_must_be_empty actual.out &&
     +	git rev-parse --short HEAD >superhead &&
    @@ t/t5526-fetch-submodules.sh: test_expect_success "'--recurse-submodules=on-deman
     +
     +	# Assert that the fetch happened at the non-HEAD commits
     +	grep "Fetching submodule submodule at commit $superhead" actual.err &&
    -+	grep "Fetching submodule submodule/subdir/deepsubmodule at commit $subhead" actual.err &&
    -+
    -+	# Assert that we can checkout the superproject commit with --recurse-submodules
    -+	! grep -E "error: Submodule .+ could not be updated" actual-checkout.err
    ++	grep "Fetching submodule submodule/subdir/deepsubmodule at commit $subhead" actual.err
     +'
     +
     +test_expect_success "'--recurse-submodules' should fetch submodule commits if the submodule is changed but the index has no submodules" '
    -+	test_when_finished "checkout_main_branches" &&
     +	# Fetch any leftover commits from other tests.
     +	git -C downstream fetch --recurse-submodules &&
     +	# Create new superproject commit with updated submodules
    @@ t/t5526-fetch-submodules.sh: test_expect_success "'--recurse-submodules=on-deman
     +	(
     +		cd downstream &&
     +		git switch --recurse-submodules no-submodules &&
    -+		git fetch --recurse-submodules >../actual.out 2>../actual.err &&
    -+		git checkout --recurse-submodules origin/super 2>../actual-checkout.err
    ++		git fetch --recurse-submodules >../actual.out 2>../actual.err
     +	) &&
     +	test_must_be_empty actual.out &&
     +	git rev-parse --short HEAD >superhead &&
    @@ t/t5526-fetch-submodules.sh: test_expect_success "'--recurse-submodules=on-deman
     +
     +	# Assert that the fetch happened at the non-HEAD commits
     +	grep "Fetching submodule submodule at commit $superhead" actual.err &&
    -+	grep "Fetching submodule submodule/subdir/deepsubmodule at commit $subhead" actual.err &&
    -+
    -+	# Assert that we can checkout the superproject commit with --recurse-submodules
    -+	! grep -E "error: Submodule .+ could not be updated" actual-checkout.err
    ++	grep "Fetching submodule submodule/subdir/deepsubmodule at commit $subhead" actual.err
     +'
     +
     +test_expect_success "'--recurse-submodules' should ignore changed, inactive submodules" '
    -+	test_when_finished "checkout_main_branches" &&
     +	# Fetch any leftover commits from other tests.
     +	git -C downstream fetch --recurse-submodules &&
     +	# Create new superproject commit with updated submodules
    @@ t/t5526-fetch-submodules.sh: test_expect_success "'--recurse-submodules=on-deman
     +	verify_fetch_result actual.err
     +'
     +
    -+# Test that we properly fetch the submodules in the index as well as
    -+# submodules in other branches.
    ++# In downstream, init "submodule2", but do not check it out while
    ++# fetching. This lets us assert that unpopulated submodules can be
    ++# fetched.
     +test_expect_success 'setup downstream branch with other submodule' '
     +	mkdir submodule2 &&
     +	(
    @@ t/t5526-fetch-submodules.sh: test_expect_success "'--recurse-submodules=on-deman
     +'
     +
     +test_expect_success "'--recurse-submodules' should fetch submodule commits in changed submodules and the index" '
    -+	test_when_finished "checkout_main_branches" &&
     +	# Fetch any leftover commits from other tests.
     +	git -C downstream fetch --recurse-submodules &&
     +	# Create new commit in origin/super
    @@ t/t5526-fetch-submodules.sh: test_expect_success "'--recurse-submodules=on-deman
     +	git checkout super &&
     +	(
     +		cd downstream &&
    -+		git fetch --recurse-submodules >../actual.out 2>../actual.err &&
    -+		git checkout --recurse-submodules origin/super-sub2-only 2>../actual-checkout.err
    ++		git fetch --recurse-submodules >../actual.out 2>../actual.err
     +	) &&
     +	test_must_be_empty actual.out &&
     +
    @@ t/t5526-fetch-submodules.sh: test_expect_success "'--recurse-submodules=on-deman
     +	git -C submodule rev-parse --short HEAD >subhead &&
     +	git -C deepsubmodule rev-parse --short HEAD >deephead &&
     +	verify_fetch_result actual.err &&
    -+	# Assert that submodule is read from the index, not from a commit
    -+	! grep "Fetching submodule submodule at commit" actual.err &&
    ++	# grep for the exact line to check that the submodule is read
    ++	# from the index, not from a commit
    ++	grep "^Fetching submodule submodule\$" actual.err &&
     +
     +	# Assert that super-sub2-only and submodule2 were fetched even
     +	# though another branch is checked out
    @@ t/t5526-fetch-submodules.sh: test_expect_success "'--recurse-submodules=on-deman
     +	grep -E "\.\.${super_sub2_only_head}\s+super-sub2-only\s+-> origin/super-sub2-only" actual.err &&
     +	grep "Fetching submodule submodule2 at commit $super_sub2_only_head" actual.err &&
     +	sub2head=$(git -C submodule2 rev-parse --short HEAD) &&
    -+	grep -E "\.\.${sub2head}\s+sub2\s+-> origin/sub2" actual.err &&
    -+
    -+	# Assert that we can checkout the superproject commit with --recurse-submodules
    -+	! grep -E "error: Submodule .+ could not be updated" actual-checkout.err
    ++	grep -E "\.\.${sub2head}\s+sub2\s+-> origin/sub2" actual.err
     +'
     +
      test_expect_success "'--recurse-submodules=on-demand' stops when no new submodule commits are found in the superproject (and ignores config)" '
 -:  ---------- >  8:  8aa68111b0 submodule: read shallows when finding changed submodules
 8:  e44bb1560e !  9:  05a8b93154 submodule: fix bug and remove add_submodule_odb()
    @@ Metadata
     Author: Glen Choo <chooglen@google.com>
     
      ## Commit message ##
    -    submodule: fix bug and remove add_submodule_odb()
    +    submodule: fix latent check_has_commit() bug
     
    -    add_submodule_odb() is a hack - it adds a submodule's odb as an
    -    alternate, allowing the submodule's objects to be read via
    -    the_repository. Its last caller is submodule_has_commits(), which calls
    -    add_submodule_odb() to prepare for check_has_commit(). This used to be
    -    necessary because check_has_commit() used the_repository's odb, but this
    -    is longer true as of 13a2f620b2 (submodule: pass repo to
    -    check_has_commit(), 2021-10-08).
    +    When check_has_commit() is called on a missing submodule, initialization
    +    of the struct repository fails, but it attempts to clear the struct
    +    anyway (which is a fatal error). This bug is masked by its only caller,
    +    submodule_has_commits(), first calling add_submodule_odb(). The latter
    +    fails if the submodule does not exist, making submodule_has_commits()
    +    exit early and not invoke check_has_commit().
     
    -    Removing add_submodule_odb() reveals a bug in check_has_commit(), where
    -    check_has_commit() will segfault if the submodule is missing (e.g. the
    -    user has not init-ed the submodule). This happens because the submodule
    -    struct cannot be initialized, but check_has_commit() tries to cleanup
    -    the uninitialized struct anyway. This was masked by add_submodule_odb(),
    -    because add_submodule_odb() fails when the submodule is missing, causing
    -    the caller to return early and avoid calling check_has_commit().
    +    Fix this bug, and because calling add_submodule_odb() is no longer
    +    necessary as of 13a2f620b2 (submodule: pass repo to
    +    check_has_commit(), 2021-10-08), remove that call too.
     
    -    Fix the bug and remove the call to add_submodule_odb(). Since
    -    add_submodule_odb() has no more callers, remove it too.
    -
    -    Note that submodule odbs can still by added as alternates via
    -    add_submodule_odb_by_path().
    +    This is the last caller of add_submodule_odb(), so remove that
    +    function. (Submodule ODBs are still added as alternates via
    +    add_submodule_odb_by_path().)
     
         Signed-off-by: Glen Choo <chooglen@google.com>
     

base-commit: 679e3693aba0c17af60c031f7eef68f2296b8dad
-- 
2.33.GIT

