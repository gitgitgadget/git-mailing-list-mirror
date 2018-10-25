Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B31801F453
	for <e@80x24.org>; Thu, 25 Oct 2018 23:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbeJZIHQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 04:07:16 -0400
Received: from mail-io1-f73.google.com ([209.85.166.73]:42126 "EHLO
        mail-io1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727487AbeJZIHP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 04:07:15 -0400
Received: by mail-io1-f73.google.com with SMTP id d4-v6so5334094ioh.9
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 16:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=zsUjZIfheHOh3VgeexGriwaQjuRs6nt6wn4Tsb5Igrk=;
        b=XAMdPGmA6QnF993xexOc6rLukXi1u3FqYO0oe5/Xzd9/pD19LvaPsO+IcwPkkPGQCe
         ohUkiJwfGx/GHxFyfQUTwSzpIpkiGADu5qoMXVzP54JOuMr6aB2hQa1sHebtAZ6SXnJp
         5MqucW9pmnEbY8+1EkvzsfqEZ2yOErCNqf6LevFjg3WhR1nrRifXm8lqFOvkgebpA4WL
         sUDqpJUxCOuszBCLBCkP8mYTr+BP55pRHN4rrUPq0nEodwJk4U8EHYpFJ2HMHLaiJ+uy
         LQv/gZtu+b8ndGZEO34QqOgWSA0h2F9luCole4oZyz17cFy2GcnDeEnjHNFea3Cc4L7q
         3awQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=zsUjZIfheHOh3VgeexGriwaQjuRs6nt6wn4Tsb5Igrk=;
        b=rj6YbhJOLbidg+CVxEk/8XTvG/hjHl/k3W1PA8P7Fq+L+xvsMKIyImMIqwB5QXtzQV
         8hfQL/fMRhoZrWHeiNP63PRbCeN+N45hrN9xxalGwSjgDVjBeJPlOdvAtzcwhRL+DA7W
         bwqRwWXxu0gIRQcSuAdFaRq/VaSHRM/YdvaKxNfDEqAwr+x8tRIE3sKNFOW5CKyx7i3x
         v2FKRdCWz6je3ajIxc3bjjwPaR8kr0i5h2pacSyP+0wR1diYX+/21xQEoefy7dihFsKr
         DwoFfA4UGcObmEvlI3aUU8Sp9gPdhP+XOOwV21/tgsQV3HY6BqCmZEtUm0GBPNaGFhJI
         1liw==
X-Gm-Message-State: AGRZ1gKPB7dngCzN+bEdMLNFgPMt5FkXOFLi5Ygh9CD1UNKs9T65mKdk
        9ebzoT1A01I9yMc61BVpAvmysbaNtkFn
X-Google-Smtp-Source: AJdET5fnTU5yREuy9XVdWp8CQ+S7dgezZ62Jo+Z4/+Mlh7kL/9PFll9vouyPrCHPHn5pDbr8A7t+voVTdPrH
X-Received: by 2002:a24:648e:: with SMTP id t136-v6mr995549itc.25.1540510356506;
 Thu, 25 Oct 2018 16:32:36 -0700 (PDT)
Date:   Thu, 25 Oct 2018 16:32:21 -0700
Message-Id: <20181025233231.102245-1-sbeller@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0
Subject: [PATCH 00/10] Resending sb/submodule-recursive-fetch-gets-the-tip
From:   Stefan Beller <sbeller@google.com>
To:     jonathantanmy@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Jonathan for your thoughtful comments,
here is the product of the discussion:
* I split up the patch to fetch in the worktree to be 2 patches,
  each giving motivation on its own.
* the last patch is vastly simplified in code, but takes an extra test
* in [1], you remark "commits" ought not to be a pointer, but I decided against
  that, as we keep the pointed-at value around for the same time span (until
  we're done with that submodule) and we don't need to copy over the pointed-at
  value into the new struct.

[1] https://public-inbox.org/git/20181018003954.139498-1-jonathantanmy@google.com/

This is still based on ao/submodule-wo-gitmodules-checked-out.
previous version
https://public-inbox.org/git/20181016181327.107186-1-sbeller@google.com/

Stefan Beller (10):
  sha1-array: provide oid_array_filter
  submodule.c: fix indentation
  submodule.c: sort changed_submodule_names before searching it
  submodule.c: tighten scope of changed_submodule_names struct
  submodule: store OIDs in changed_submodule_names
  repository: repo_submodule_init to take a submodule struct
  submodule: migrate get_next_submodule to use repository structs
  submodule.c: fetch in submodules git directory instead of in worktree
  fetch: try fetching submodules if needed objects were not fetched
  builtin/fetch: check for submodule updates in any ref update

 Documentation/technical/api-oid-array.txt    |   5 +
 builtin/fetch.c                              |  11 +-
 builtin/grep.c                               |  17 +-
 builtin/ls-files.c                           |  12 +-
 builtin/submodule--helper.c                  |   2 +-
 repository.c                                 |  27 +-
 repository.h                                 |  12 +-
 sha1-array.c                                 |  17 ++
 sha1-array.h                                 |   3 +
 submodule.c                                  | 265 ++++++++++++++++---
 t/helper/test-submodule-nested-repo-config.c |   8 +-
 t/t5526-fetch-submodules.sh                  |  55 ++++
 12 files changed, 346 insertions(+), 88 deletions(-)

  git range-diff origin/sb/submodule-recursive-fetch-gets-the-tip... 

1:  3fbb06aedd ! 1:  0fdb0e2ad9 submodule.c: move global changed_submodule_names into fetch submodule struct
    @@ -1,12 +1,11 @@
     Author: Stefan Beller <sbeller@google.com>
     
    -    submodule.c: move global changed_submodule_names into fetch submodule struct
    +    submodule.c: tighten scope of changed_submodule_names struct
     
         The `changed_submodule_names` are only used for fetching, so let's make it
         part of the struct that is passed around for fetching submodules.
     
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
     diff --git a/submodule.c b/submodule.c
     --- a/submodule.c
    @@ -16,7 +15,6 @@
      
      static int config_update_recurse_submodules = RECURSE_SUBMODULES_OFF;
     -static struct string_list changed_submodule_names = STRING_LIST_INIT_DUP;
    -+
      static int initialized_fetch_ref_tips;
      static struct oid_array ref_tips_before_fetch;
      static struct oid_array ref_tips_after_fetch;
    @@ -25,22 +23,8 @@
      }
      
     -static void calculate_changed_submodule_paths(void)
    -+struct submodule_parallel_fetch {
    -+	int count;
    -+	struct argv_array args;
    -+	struct repository *r;
    -+	const char *prefix;
    -+	int command_line_option;
    -+	int default_option;
    -+	int quiet;
    -+	int result;
    -+
    -+	struct string_list changed_submodule_names;
    -+};
    -+#define SPF_INIT {0, ARGV_ARRAY_INIT, NULL, NULL, 0, 0, 0, 0, STRING_LIST_INIT_DUP }
    -+
     +static void calculate_changed_submodule_paths(
    -+	struct submodule_parallel_fetch *spf)
    ++	struct string_list *changed_submodule_names)
      {
      	struct argv_array argv = ARGV_ARRAY_INIT;
      	struct string_list changed_submodules = STRING_LIST_INIT_DUP;
    @@ -49,30 +33,23 @@
      
      		if (!submodule_has_commits(path, commits))
     -			string_list_append(&changed_submodule_names, name->string);
    -+			string_list_append(&spf->changed_submodule_names,
    ++			string_list_append(changed_submodule_names,
     +					   name->string);
      	}
      
      	free_submodules_oids(&changed_submodules);
     @@
    - 	return ret;
    - }
    - 
    --struct submodule_parallel_fetch {
    --	int count;
    --	struct argv_array args;
    --	struct repository *r;
    --	const char *prefix;
    --	int command_line_option;
    --	int default_option;
    --	int quiet;
    --	int result;
    --};
    + 	int default_option;
    + 	int quiet;
    + 	int result;
    ++
    ++	struct string_list changed_submodule_names;
    + };
     -#define SPF_INIT {0, ARGV_ARRAY_INIT, NULL, NULL, 0, 0, 0, 0}
    --
    ++#define SPF_INIT {0, ARGV_ARRAY_INIT, NULL, NULL, 0, 0, 0, 0, STRING_LIST_INIT_DUP }
    + 
      static int get_fetch_recurse_config(const struct submodule *submodule,
      				    struct submodule_parallel_fetch *spf)
    - {
     @@
      		case RECURSE_SUBMODULES_ON_DEMAND:
      			if (!submodule ||
    @@ -88,7 +65,7 @@
      
     -	calculate_changed_submodule_paths();
     -	string_list_sort(&changed_submodule_names);
    -+	calculate_changed_submodule_paths(&spf);
    ++	calculate_changed_submodule_paths(&spf.changed_submodule_names);
     +	string_list_sort(&spf.changed_submodule_names);
      	run_processes_parallel(max_parallel_jobs,
      			       get_next_submodule,
2:  a64a8322a1 ! 2:  a11e6e39a2 submodule.c: do not copy around submodule list
    @@ -1,6 +1,6 @@
     Author: Stefan Beller <sbeller@google.com>
     
    -    submodule.c: do not copy around submodule list
    +    submodule: store OIDs in changed_submodule_names
     
         'calculate_changed_submodule_paths' uses a local list to compute the
         changed submodules, and then produces the result by copying appropriate
    @@ -14,13 +14,13 @@
         useful in a later patch.
     
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +    Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
     
     diff --git a/submodule.c b/submodule.c
     --- a/submodule.c
     +++ b/submodule.c
     @@
    - 	struct submodule_parallel_fetch *spf)
    + 	struct string_list *changed_submodule_names)
      {
      	struct argv_array argv = ARGV_ARRAY_INIT;
     -	struct string_list changed_submodules = STRING_LIST_INIT_DUP;
    @@ -34,10 +34,10 @@
      	 * commits have been recorded upstream in "changed_submodule_names".
      	 */
     -	collect_changed_submodules(&changed_submodules, &argv);
    -+	collect_changed_submodules(&spf->changed_submodule_names, &argv);
    ++	collect_changed_submodules(changed_submodule_names, &argv);
      
     -	for_each_string_list_item(name, &changed_submodules) {
    -+	for_each_string_list_item(name, &spf->changed_submodule_names) {
    ++	for_each_string_list_item(name, changed_submodule_names) {
      		struct oid_array *commits = name->util;
      		const struct submodule *submodule;
      		const char *path = NULL;
    @@ -46,7 +46,7 @@
      			continue;
      
     -		if (!submodule_has_commits(path, commits))
    --			string_list_append(&spf->changed_submodule_names,
    +-			string_list_append(changed_submodule_names,
     -					   name->string);
     +		if (submodule_has_commits(path, commits)) {
     +			oid_array_clear(commits);
    @@ -55,7 +55,7 @@
      	}
      
     -	free_submodules_oids(&changed_submodules);
    -+	string_list_remove_empty_items(&spf->changed_submodule_names, 1);
    ++	string_list_remove_empty_items(changed_submodule_names, 1);
     +
      	argv_array_clear(&argv);
      	oid_array_clear(&ref_tips_before_fetch);
3:  9341b92c83 ! 3:  3f4e0d4b8d repository: repo_submodule_init to take a submodule struct
    @@ -5,17 +5,19 @@
         When constructing a struct repository for a submodule for some revision
         of the superproject where the submodule is not contained in the index,
         it may not be present in the working tree currently either. In that
    -    siutation giving a 'path' argument is not useful. Upgrade the
    +    situation giving a 'path' argument is not useful. Upgrade the
         repo_submodule_init function to take a struct submodule instead.
    +    The submodule struct can be obtained via submodule_from_{path, name} or
    +    an artificial submodule struct can be passed in.
     
    -    While we are at it, overhaul the repo_submodule_init function by renaming
    -    the submodule repository struct, which is to be initialized, to a name
    -    that is not confused with the struct submodule as easily.
    +    While we are at it, rename the repository struct in the repo_submodule_init
    +    function, which is to be initialized, to a name that is not confused with
    +    the struct submodule as easily. Perform such renames in similar functions
    +    as well.
     
         Also move its documentation into the header file.
     
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
     diff --git a/builtin/grep.c b/builtin/grep.c
     --- a/builtin/grep.c
    @@ -104,6 +106,19 @@
      
      static void show_ce(struct repository *repo, struct dir_struct *dir,
     
    +diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
    +--- a/builtin/submodule--helper.c
    ++++ b/builtin/submodule--helper.c
    +@@
    + 	if (!sub)
    + 		BUG("We could get the submodule handle before?");
    + 
    +-	if (repo_submodule_init(&subrepo, the_repository, path))
    ++	if (repo_submodule_init(&subrepo, the_repository, sub))
    + 		die(_("could not get a repository handle for submodule '%s'"), path);
    + 
    + 	if (!repo_config_get_string(&subrepo, "core.worktree", &cw)) {
    +
     diff --git a/repository.c b/repository.c
     --- a/repository.c
     +++ b/repository.c
    @@ -178,7 +193,8 @@
     +/*
     + * Initialize the repository 'subrepo' as the submodule given by the
     + * struct submodule 'sub' in parent repository 'superproject'.
    -+ * Return 0 upon success and a non-zero value upon failure.
    ++ * Return 0 upon success and a non-zero value upon failure, which may happen
    ++ * if the submodule is not found, or 'sub' is NULL.
     + */
     +struct submodule;
     +int repo_submodule_init(struct repository *subrepo,
4:  cea909cbd4 ! 4:  b1566069e7 submodule: fetch in submodules git directory instead of in worktree
    @@ -1,44 +1,19 @@
     Author: Stefan Beller <sbeller@google.com>
     
    -    submodule: fetch in submodules git directory instead of in worktree
    +    submodule: migrate get_next_submodule to use repository structs
     
    -    This patch started as a refactoring to make 'get_next_submodule' more
    -    readable, but upon doing so, I realized that "git fetch" of the submodule
    -    actually doesn't need to be run in the submodules worktree. So let's run
    -    it in its git dir instead.
    +    We used to recurse into submodules, even if they were broken having
    +    only an objects directory. The child process executed in the submodule
    +    would fail though if the submodule was broken.
     
    -    That should pave the way towards fetching submodules that are currently
    -    not checked out.
    -
    -    This patch leaks the cp->dir in get_next_submodule, as any further
    -    callback in run_processes_parallel doesn't have access to the child
    -    process any more. In an early iteration of this patch, the function
    -    get_submodule_repo_for directly returned the string containing the
    -    git directory, which would be a better design choice for this patch.
    -
    -    However the next patch both fixes the memory leak of cp->dir and also has
    -    a use case for using the full repository handle of the submodule, so
    -    it makes sense to introduce the get_submodule_repo_for here already.
    +    This patch tightens the check upfront, such that we do not need
    +    to spawn a child process to find out if the submodule is broken.
     
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
     diff --git a/submodule.c b/submodule.c
     --- a/submodule.c
     +++ b/submodule.c
    -@@
    - 			 DEFAULT_GIT_DIR_ENVIRONMENT);
    - }
    - 
    -+static void prepare_submodule_repo_env_in_gitdir(struct argv_array *out)
    -+{
    -+	prepare_submodule_repo_env_no_git_dir(out);
    -+	argv_array_pushf(out, "%s=.", GIT_DIR_ENVIRONMENT);
    -+}
    -+
    - /* Helper function to display the submodule header line prior to the full
    -  * summary output. If it can locate the submodule objects directory it will
    -  * attempt to lookup both the left and right commits and put them into the
     @@
      	return spf->default_option;
      }
    @@ -99,9 +74,8 @@
     +		if (repo) {
      			child_process_init(cp);
     -			cp->dir = strbuf_detach(&submodule_path, NULL);
    --			prepare_submodule_repo_env(&cp->env_array);
    -+			prepare_submodule_repo_env_in_gitdir(&cp->env_array);
    -+			cp->dir = xstrdup(repo->gitdir);
    + 			prepare_submodule_repo_env(&cp->env_array);
    ++			cp->dir = xstrdup(repo->worktree);
      			cp->git_cmd = 1;
      			if (!spf->quiet)
      				strbuf_addf(err, "Fetching submodule %s%s\n",
    @@ -113,27 +87,17 @@
     +			repo_clear(repo);
     +			free(repo);
      			ret = 1;
    ++		} else {
    ++			/*
    ++			 * An empty directory is normal,
    ++			 * the submodule is not initialized
    ++			 */
    ++			if (S_ISGITLINK(ce->ce_mode) &&
    ++			    !is_empty_dir(ce->name))
    ++				die(_("Could not access submodule '%s'"), ce->name);
      		}
     -		strbuf_release(&submodule_path);
     -		strbuf_release(&submodule_git_dir);
      		strbuf_release(&submodule_prefix);
      		if (ret) {
      			spf->count++;
    -
    -diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
    ---- a/t/t5526-fetch-submodules.sh
    -+++ b/t/t5526-fetch-submodules.sh
    -@@
    - 
    - 	test_must_fail git -C dst status &&
    - 	test_must_fail git -C dst diff &&
    --	test_must_fail git -C dst fetch --recurse-submodules
    -+
    -+	# git-fetch cannot find the git directory of the submodule,
    -+	# so it will do nothing, successfully, as it cannot distinguish between
    -+	# this broken submodule and a submodule that was just set active but
    -+	# not cloned yet
    -+	git -C dst fetch --recurse-submodules
    - '
    - 
    - test_expect_success "fetch new commits when submodule got renamed" '
-:  ---------- > 5:  2d98ff1201 submodule.c: fetch in submodules git directory instead of in worktree
5:  9ad0125310 ! 6:  092b9cbcba fetch: retry fetching submodules if needed objects were not fetched
    @@ -1,25 +1,23 @@
     Author: Stefan Beller <sbeller@google.com>
     
    -    fetch: retry fetching submodules if needed objects were not fetched
    +    fetch: try fetching submodules if needed objects were not fetched
     
         Currently when git-fetch is asked to recurse into submodules, it dispatches
         a plain "git-fetch -C <submodule-dir>" (with some submodule related options
         such as prefix and recusing strategy, but) without any information of the
         remote or the tip that should be fetched.
     
    -    This works surprisingly well in some workflows (such as using submodules
    -    as a third party library), while not so well in other scenarios, such
    -    as in a Gerrit topic-based workflow, that can tie together changes
    -    (potentially across repositories) on the server side. One of the parts
    -    of such a Gerrit workflow is to download a change when wanting to examine
    -    it, and you'd want to have its submodule changes that are in the same
    -    topic downloaded as well. However these submodule changes reside in their
    -    own repository in their own ref (refs/changes/<int>).
    +    But this default fetch is not sufficient, as a newly fetched commit in
    +    the superproject could point to a commit in the submodule that is not
    +    in the default refspec. This is common in workflows like Gerrit's.
    +    When fetching a Gerrit change under review (from refs/changes/??), the
    +    commits in that change likely point to submodule commits that have not
    +    been merged to a branch yet.
     
    -    Retry fetching a submodule by object name if the object id that the
    +    Try fetching a submodule by object id if the object id that the
         superproject points to, cannot be found.
     
    -    This retrying does not happen when the "git fetch" done at the
    +    The try does not happen when the "git fetch" done at the
         superproject is not storing the fetched results in remote
         tracking branches (i.e. instead just recording them to
         FETCH_HEAD) in this step. A later patch will fix this.
    @@ -32,7 +30,6 @@
         in case the submodule recursion is set to "on".
     
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
     diff --git a/builtin/fetch.c b/builtin/fetch.c
     --- a/builtin/fetch.c
    @@ -75,16 +72,16 @@
      	int result;
      
      	struct string_list changed_submodule_names;
    -+	struct get_next_submodule_task **retry;
    -+	int retry_nr, retry_alloc;
    ++	struct get_next_submodule_task **fetch_specific_oids;
    ++	int fetch_specific_oids_nr, fetch_specific_oids_alloc;
      };
     -#define SPF_INIT {0, ARGV_ARRAY_INIT, NULL, NULL, 0, 0, 0, 0, STRING_LIST_INIT_DUP }
     +#define SPF_INIT {0, ARGV_ARRAY_INIT, NULL, NULL, 0, 0, 0, 0, \
     +		  STRING_LIST_INIT_DUP, \
     +		  NULL, 0, 0}
      
    - static void calculate_changed_submodule_paths(
    - 	struct submodule_parallel_fetch *spf)
    + static int get_fetch_recurse_config(const struct submodule *submodule,
    + 				    struct submodule_parallel_fetch *spf)
     @@
      	return spf->default_option;
      }
    @@ -93,6 +90,8 @@
     +	struct repository *repo;
     +	const struct submodule *sub;
     +	unsigned free_sub : 1; /* Do we need to free the submodule? */
    ++
    ++	/* fetch specific oids if set, otherwise fetch default refspec */
     +	struct oid_array *commits;
     +};
     +
    @@ -224,24 +223,29 @@
     -			repo_clear(repo);
     -			free(repo);
     -			ret = 1;
    --		}
    --		strbuf_release(&submodule_prefix);
    --		if (ret) {
    - 			spf->count++;
    ++			spf->count++;
     +			*task_cb = task;
     +
     +			strbuf_release(&submodule_prefix);
    - 			return 1;
    -+		} else {
    ++			return 1;
    + 		} else {
    ++
     +			get_next_submodule_task_release(task);
     +			free(task);
    ++
    + 			/*
    + 			 * An empty directory is normal,
    + 			 * the submodule is not initialized
    +@@
    + 			    !is_empty_dir(ce->name))
    + 				die(_("Could not access submodule '%s'"), ce->name);
      		}
    - 	}
    ++	}
     +
    -+	if (spf->retry_nr) {
    -+		struct get_next_submodule_task *task = spf->retry[spf->retry_nr - 1];
    ++	if (spf->fetch_specific_oids_nr) {
    ++		struct get_next_submodule_task *task = spf->fetch_specific_oids[spf->fetch_specific_oids_nr - 1];
     +		struct strbuf submodule_prefix = STRBUF_INIT;
    -+		spf->retry_nr--;
    ++		spf->fetch_specific_oids_nr--;
     +
     +		strbuf_addf(&submodule_prefix, "%s%s/", spf->prefix, task->sub->path);
     +
    @@ -262,9 +266,13 @@
     +					  append_oid_to_argv, &cp->args);
     +
     +		*task_cb = task;
    -+		strbuf_release(&submodule_prefix);
    + 		strbuf_release(&submodule_prefix);
    +-		if (ret) {
    +-			spf->count++;
    +-			return 1;
    +-		}
     +		return 1;
    -+	}
    + 	}
     +
      	return 0;
      }
    @@ -326,9 +334,11 @@
     +			return 0;
     +
     +		task->commits = commits;
    -+		ALLOC_GROW(spf->retry, spf->retry_nr + 1, spf->retry_alloc);
    -+		spf->retry[spf->retry_nr] = task;
    -+		spf->retry_nr++;
    ++		ALLOC_GROW(spf->fetch_specific_oids,
    ++			   spf->fetch_specific_oids_nr + 1,
    ++			   spf->fetch_specific_oids_alloc);
    ++		spf->fetch_specific_oids[spf->fetch_specific_oids_nr] = task;
    ++		spf->fetch_specific_oids_nr++;
     +		return 0;
     +	}
     +
    @@ -346,18 +356,33 @@
      	test_cmp expect actual
      '
      
    -+test_expect_success "fetch new commits on-demand when they are not reachable" '
    ++test_expect_success "fetch new submodule commits on-demand outside standard refspec" '
    ++	# add a second submodule and ensure it is around in downstream first
    ++	git clone submodule sub1 &&
    ++	git submodule add ./sub1 &&
    ++	git commit -m "adding a second submodule" &&
    ++	git -C downstream pull &&
    ++	git -C downstream submodule update --init --recursive &&
    ++
     +	git checkout --detach &&
    ++
     +	C=$(git -C submodule commit-tree -m "new change outside refs/heads" HEAD^{tree}) &&
     +	git -C submodule update-ref refs/changes/1 $C &&
     +	git update-index --cacheinfo 160000 $C submodule &&
    -+	git commit -m "updated submodule outside of refs/heads" &&
    -+	D=$(git rev-parse HEAD) &&
    -+	git update-ref refs/changes/2 $D &&
    ++	test_tick &&
    ++
    ++	D=$(git -C sub1 commit-tree -m "new change outside refs/heads" HEAD^{tree}) &&
    ++	git -C sub1 update-ref refs/changes/2 $D &&
    ++	git update-index --cacheinfo 160000 $D sub1 &&
    ++
    ++	git commit -m "updated submodules outside of refs/heads" &&
    ++	E=$(git rev-parse HEAD) &&
    ++	git update-ref refs/changes/2 $E &&
     +	(
     +		cd downstream &&
    -+		git fetch --recurse-submodules --recurse-submodules-default on-demand origin refs/changes/2:refs/heads/my_branch &&
    ++		git fetch --recurse-submodules origin refs/changes/2:refs/heads/my_branch &&
     +		git -C submodule cat-file -t $C &&
    ++		git -C sub1 cat-file -t $D &&
     +		git checkout --recurse-submodules FETCH_HEAD
     +	)
     +'
6:  b8db3b45bf < -:  ---------- builtin/fetch: check for submodule updates for non branch fetches
7:  905a4f0d4f < -:  ---------- fixup! repository: repo_submodule_init to take a submodule struct
-:  ---------- > 7:  11bf819782 builtin/fetch: check for submodule updates in any ref update
