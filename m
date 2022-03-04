Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665D6C433EF
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 00:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237472AbiCDA66 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 19:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237470AbiCDA6x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 19:58:53 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C7EEB333
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 16:58:05 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id f18-20020a623812000000b004f6a259bbf4so1096316pfa.7
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 16:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=aOssmhGKMqvuCEnGwAoN+h487RwfIFQy76FMqS0oy1k=;
        b=YuR1plNjKnCRT++5KIknHlROQOnyR3u85fWnSrSlCZ6Jki6/66lbqCNaMiTxDNDVV+
         uAqu3FlKBozDO1s3J9wyugofu2PItjn4KjIy350bRkebVaS1jJjiJLjEFOlXhBnfz+zf
         MJJqF5rWwFHIxeUQfqY6OUWbaOdyKDF/eDnULrYZ/BLdxOkq3gFnztxoIUb5xQCmtj1d
         r4WPu7vCEAb0qU0bbf953CCwbL2nvDLxPKS9DZLKtGdtT7OWwtX8a75ZDNvjhRRZarw8
         bJ+yRUt/ckaY71NGMqkT/CPIBT/hnjK+oYwp4nhJyLIOxoantGTQd/BuOSxHESOoNEug
         o/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aOssmhGKMqvuCEnGwAoN+h487RwfIFQy76FMqS0oy1k=;
        b=Amu/TOJpIF5OXnv2QYgOoBRvPHGVVtogrsZRqCZvpqX5e2akfLdPRzspUaw82+QCTp
         lwMAxUdehd0mMdA0rKdOwlgOYW66U2QcUQ/vZenNGddXxUZo9D46Q984ocyvzVItMNL0
         9qXbiNeS0uCwG3vJw/SbCuKLqVJzUJyyzuGW9bcGMFJO1BMzgLNy+C2DbvNadJb8gIa9
         /5CnWDuqZgJ5gJWR4SMm/oRcFVUd0izH89RygtaNQcpiVezaLaeOzHnungPLNzO4vIBM
         NpyBcmFzmoxW+lBIrNhQ6PJ4VxvI5b6/qjGVUy35I+zS/ReFc9rMZiNCp/eoH2Mj+Tvj
         m4ew==
X-Gm-Message-State: AOAM5305Z1l0XVWt/UilJddyOjsO6P0KO9WA61F0pZzJr22RY7Dxf891
        yPLpt2d8C7stdqHFpJe+0i5fkNErYM7kydY4fgU7p0A5dyzf3IYseCcKd8UYFv4k6HOLG7B0c3D
        eSDb6PP59cAohUk88q9Df+EIfTrAg0QmMT3XUHqRP47PB3QtC8+6eUGYRPIS7Q60=
X-Google-Smtp-Source: ABdhPJwhYzDcjG89NliHjjDR8Ter7x7zhL4ULFycD3xsbfoGiUkCJRWJlVjFE1NvS9cs3LbsOKkGGXqRRtCt4w==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:2e04:b0:1bc:a5db:bcdb with SMTP
 id q4-20020a17090a2e0400b001bca5dbbcdbmr8201613pjd.116.1646355485029; Thu, 03
 Mar 2022 16:58:05 -0800 (PST)
Date:   Thu,  3 Mar 2022 16:57:47 -0800
In-Reply-To: <20220224100842.95827-1-chooglen@google.com>
Message-Id: <20220304005757.70107-1-chooglen@google.com>
Mime-Version: 1.0
References: <20220224100842.95827-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH v4 00/10] fetch --recurse-submodules: fetch unpopulated submodules
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Original cover letter: https://lore.kernel.org/git/20220210044152.78352-1-chooglen@google.com

This round of patches is now based on master - I prepared the previous
rounds on top of gc/branch-recurse-submodules, but now that's merged
onto master (and the actual branch for this series,
gc/recursive-fetch-with-unused-submodules, is based off master anyway).

This round fixes up the comments from the previous round (thanks
everyone!), all of which are fairly small.

= Patch organization

- Patches 1-3 are quality-of-life improvements to the test suite that
  make it easier to write the tests in patch 9.
- Patches 4-6 are preparation for "git fetch" to read .gitmodules from
  the superproject commit in patch 7.
- Patches 7-8 refactor out the logic of "finding which submodules to
  fetch" and "fetching the submodules", making it easier to tell "git
  fetch" to fetch unpopulated submodules.
- Patch 9 teaches "git fetch" to fetch changed, unpopulated submodules
  in addition to populated submodules.
- Patch 10 is an optional bugfix + cleanup of the "git fetch" code that
  removes the last caller of the deprecated "add_submodule_odb()".

= Changes 

== Since v3
- Numerous style fixes + improved comments.
- Fix sed portability issues.
- Fix failing test due to default branch name assumptions.
- Patch 3: change a test so that it no longer depends on state from the
  previous test.
- Patch 9: fix memory leak when recording super_oid and path + add
  explanatory comment.

== Since v2
- Numerous small fixes to the code and commit message (thanks to all who
  helped spot these :))
- In patch 2, use test_cmp + sed to assert on test output, effectively
  reverting the "use grep" approach of v1-2 (see patch 2's description).
- New patch 3: introduce a test helper that creates the expected
  superproject commit (instead of copy-pasting the code over and over).
  - I did not get rid of "git fetch" inside the test helper (as Jonathan
    suggested) though, because that requires a bigger change in the test
    setup, and I think the test helper makes the test straightforward
    enough.
- New patch 8: refactor some shared logic out into fetch_task_create().
  This reduces code duplication between the get_fetch_task_from_*
  functions.
- In patch 9, add additional tests for 'submodules with the same name'.
- In patch 9, handle a bug where a submodule that is unpopulated by "git
  rm" still has "core.worktree" set and cannot be fetched (see patch 9's
  description).
- Remove the "git fetch --update-shallow" patch (I'll try to send it
  separately).

== Since v1
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


Glen Choo (10):
  t5526: introduce test helper to assert on fetches
  t5526: stop asserting on stderr literally
  t5526: create superproject commits with test helper
  submodule: make static functions read submodules from commits
  submodule: inline submodule_commits() into caller
  submodule: store new submodule commits oid_array in a struct
  submodule: extract get_fetch_task()
  submodule: move logic into fetch_task_create()
  fetch: fetch unpopulated, changed submodules
  submodule: fix latent check_has_commit() bug

 Documentation/fetch-options.txt |  26 +-
 Documentation/git-fetch.txt     |  10 +-
 builtin/fetch.c                 |  14 +-
 submodule.c                     | 442 +++++++++++++++++---------
 submodule.h                     |  21 +-
 t/t5526-fetch-submodules.sh     | 539 ++++++++++++++++++++++++--------
 6 files changed, 740 insertions(+), 312 deletions(-)

Range-diff against v3:
 1:  b6d34b0f5c !  1:  57cd31afc2 t5526: introduce test helper to assert on fetches
    @@ t/t5526-fetch-submodules.sh: add_upstream_commit() {
     +verify_fetch_result() {
     +	ACTUAL_ERR=$1 &&
     +	rm -f expect.err.combined &&
    -+	if [ -f expect.err.super ]; then
    ++	if test -f expect.err.super
    ++	then
     +		cat expect.err.super >>expect.err.combined
     +	fi &&
    -+	if [ -f expect.err.sub ]; then
    ++	if test -f expect.err.sub
    ++	then
     +		cat expect.err.sub >>expect.err.combined
     +	fi &&
    -+	if [ -f expect.err.deep ]; then
    ++	if test -f expect.err.deep
    ++	then
     +		cat expect.err.deep >>expect.err.combined
     +	fi &&
     +	test_cmp expect.err.combined $ACTUAL_ERR
 2:  0b85fa35c2 !  2:  b70c894cff t5526: stop asserting on stderr literally
    @@ t/t5526-fetch-submodules.sh: export GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB
      
      pwd=$(pwd)
      
    -+check_sub() {
    ++check_sub () {
     +	NEW_HEAD=$1 &&
    -+	cat <<-EOF >$pwd/expect.err.sub
    ++	cat >$pwd/expect.err.sub <<-EOF
     +	Fetching submodule submodule
     +	From $pwd/submodule
     +	   OLD_HEAD..$NEW_HEAD  sub        -> origin/sub
     +	EOF
     +}
     +
    -+check_deep() {
    ++check_deep () {
     +	NEW_HEAD=$1 &&
    -+	cat <<-EOF >$pwd/expect.err.deep
    ++	cat >$pwd/expect.err.deep <<-EOF
     +	Fetching submodule submodule/subdir/deepsubmodule
     +	From $pwd/deepsubmodule
     +	   OLD_HEAD..$NEW_HEAD  deep       -> origin/deep
     +	EOF
     +}
     +
    -+check_super() {
    ++check_super () {
     +	NEW_HEAD=$1 &&
    -+	cat <<-EOF >$pwd/expect.err.super
    ++	cat >$pwd/expect.err.super <<-EOF
     +	From $pwd/.
     +	   OLD_HEAD..$NEW_HEAD  super      -> origin/super
     +	EOF
    @@ t/t5526-fetch-submodules.sh: pwd=$(pwd)
      	)
      }
      
    +@@ t/t5526-fetch-submodules.sh: add_upstream_commit() {
    + #
    + # If a repo should not be fetched in the test, its corresponding
    + # expect.err file should be rm-ed.
    +-verify_fetch_result() {
    ++verify_fetch_result () {
    + 	ACTUAL_ERR=$1 &&
    + 	rm -f expect.err.combined &&
    + 	if test -f expect.err.super
     @@ t/t5526-fetch-submodules.sh: verify_fetch_result() {
    - 	if [ -f expect.err.deep ]; then
    + 	then
      		cat expect.err.deep >>expect.err.combined
      	fi &&
     -	test_cmp expect.err.combined $ACTUAL_ERR
    -+	sed -E 's/[0-9a-f]+\.\./OLD_HEAD\.\./' $ACTUAL_ERR >actual.err.cmp &&
    ++	sed -e 's/[0-9a-f][0-9a-f]*\.\./OLD_HEAD\.\./' "$ACTUAL_ERR" >actual.err.cmp &&
     +	test_cmp expect.err.combined actual.err.cmp
      }
      
 3:  bb8ef6094a !  3:  7e2a01164e t5526: create superproject commits with test helper
    @@ Commit message
         Signed-off-by: Glen Choo <chooglen@google.com>
     
      ## t/t5526-fetch-submodules.sh ##
    -@@ t/t5526-fetch-submodules.sh: check_super() {
    +@@ t/t5526-fetch-submodules.sh: check_super () {
      # a file that contains the expected err if that new commit were fetched.
      # These output files get concatenated in the right order by
      # verify_fetch_result().
     -add_upstream_commit() {
    -+add_submodule_commits() {
    ++add_submodule_commits () {
      	(
      		cd submodule &&
      		echo new >> subfile &&
    @@ t/t5526-fetch-submodules.sh: add_upstream_commit() {
     +#
     +# This requires add_submodule_commits() to be called first, otherwise
     +# the submodules will not have changed and cannot be "git add"-ed.
    -+add_superproject_commits() {
    -+(
    -+	cd submodule &&
    ++add_superproject_commits () {
     +	(
    -+		cd subdir/deepsubmodule &&
    -+		git fetch &&
    -+		git checkout -q FETCH_HEAD
    -+	) &&
    ++		cd submodule &&
    ++		(
    ++			cd subdir/deepsubmodule &&
    ++			git fetch &&
    ++			git checkout -q FETCH_HEAD
    ++		) &&
     +		git add subdir/deepsubmodule &&
     +		git commit -m "new deep submodule"
     +	) &&
 4:  e83a1713c4 =  4:  88112ee225 submodule: make static functions read submodules from commits
 5:  e27d402b9a =  5:  007cd97aba submodule: inline submodule_commits() into caller
 6:  1c7c8218b8 =  6:  f34ea88fe9 submodule: store new submodule commits oid_array in a struct
 7:  80cf317722 !  7:  f66ab663c5 submodule: extract get_fetch_task()
    @@ submodule.c: struct fetch_task {
      	struct repository *repo;
      	const struct submodule *sub;
      	unsigned free_sub : 1; /* Do we need to free the submodule? */
    -+	const char *default_argv;
    ++	const char *default_argv; /* The default fetch mode. */
      
      	struct oid_array *commits; /* Ensure these commits are fetched */
      };
 8:  bf9cfa7054 =  8:  4e3db1bc9d submodule: move logic into fetch_task_create()
 9:  c7c2ff71b6 !  9:  9e7b1c1bbe fetch: fetch unpopulated, changed submodules
    @@ builtin/fetch.c: int cmd_fetch(int argc, const char **argv, const char *prefix)
     
      ## submodule.c ##
     @@ submodule.c: static const char *default_name_or_path(const char *path_or_name)
    -  * member of the changed submodule string_list_item.
    + 
    + /*
    +  * Holds relevant information for a changed submodule. Used as the .util
    +- * member of the changed submodule string_list_item.
    ++ * member of the changed submodule name string_list_item.
    ++ *
    ++ * (super_oid, path) allows the submodule config to be read from _some_
    ++ * .gitmodules file. We store this information the first time we find a
    ++ * superproject commit that points to the submodule, but this is
    ++ * arbitrary - we can choose any (super_oid, path) that matches the
    ++ * submodule's name.
       */
      struct changed_submodule_data {
     +	/*
    -+	 * The first superproject commit in the rev walk that points to the
    -+	 * submodule.
    ++	 * The first superproject commit in the rev walk that points to
    ++	 * the submodule.
     +	 */
     +	const struct object_id *super_oid;
     +	/*
    @@ submodule.c: struct changed_submodule_data {
      
      static void collect_changed_submodules_cb(struct diff_queue_struct *q,
     @@ submodule.c: static void collect_changed_submodules_cb(struct diff_queue_struct *q,
    - 		if (!item->util)
    + 			continue;
    + 
    + 		item = string_list_insert(changed, name);
    +-		if (!item->util)
    ++		if (item->util)
    ++			cs_data = item->util;
    ++		else {
      			item->util = xcalloc(1, sizeof(struct changed_submodule_data));
    - 		cs_data = item->util;
    -+		cs_data->super_oid = commit_oid;
    -+		cs_data->path = xstrdup(p->two->path);
    +-		cs_data = item->util;
    ++			cs_data = item->util;
    ++			cs_data->super_oid = commit_oid;
    ++			cs_data->path = xstrdup(p->two->path);
    ++		}
      		oid_array_append(&cs_data->new_commits, &p->two->oid);
      	}
      }
    @@ submodule.c: void check_for_new_submodule_commits(struct object_id *oid)
     + */
     +static int repo_has_absorbed_submodules(struct repository *r)
     +{
    ++	int ret;
     +	struct strbuf buf = STRBUF_INIT;
     +
     +	strbuf_repo_git_path(&buf, r, "modules/");
    -+	return file_exists(buf.buf) && !is_empty_dir(buf.buf);
    ++	ret = file_exists(buf.buf) && !is_empty_dir(buf.buf);
    ++	strbuf_release(&buf);
    ++	return ret;
     +}
     +
      static void calculate_changed_submodule_paths(struct repository *r,
    @@ submodule.c: int submodule_touches_in_range(struct repository *r,
      
      struct submodule_parallel_fetch {
     -	int count;
    ++	/*
    ++	 * The index of the last index entry processed by
    ++	 * get_fetch_task_from_index().
    ++	 */
     +	int index_count;
    ++	/*
    ++	 * The index of the last string_list entry processed by
    ++	 * get_fetch_task_from_changed().
    ++	 */
     +	int changed_count;
      	struct strvec args;
      	struct repository *r;
      	const char *prefix;
     @@ submodule.c: struct submodule_parallel_fetch {
    + 	int quiet;
      	int result;
      
    ++	/*
    ++	 * Names of submodules that have new commits. Generated by
    ++	 * walking the newly fetched superproject commits.
    ++	 */
      	struct string_list changed_submodule_names;
    ++	/*
    ++	 * Names of submodules that have already been processed. Lets us
    ++	 * avoid fetching the same submodule more than once.
    ++	 */
     +	struct string_list seen_submodule_names;
      
      	/* Pending fetches by OIDs */
    @@ submodule.c: struct submodule_parallel_fetch {
     @@ submodule.c: struct fetch_task {
      	const struct submodule *sub;
      	unsigned free_sub : 1; /* Do we need to free the submodule? */
    - 	const char *default_argv;
    -+	struct strvec git_args;
    + 	const char *default_argv; /* The default fetch mode. */
    ++	struct strvec git_args; /* Args for the child git process. */
      
      	struct oid_array *commits; /* Ensure these commits are fetched */
      };
    @@ submodule.c: get_fetch_task(struct submodule_parallel_fetch *spf, struct strbuf
     +
     +		spf->changed_count++;
     +		/*
    -+		 * NEEDSWORK: A submodule unpopulated by "git rm" will
    -+		 * have core.worktree set, but the actual core.worktree
    -+		 * directory won't exist, causing the child process to
    -+		 * fail. Forcibly set --work-tree until we get smarter
    -+		 * handling for core.worktree in unpopulated submodules.
    ++		 * NEEDSWORK: Submodules set/unset a value for
    ++		 * core.worktree when they are populated/unpopulated by
    ++		 * "git checkout" (and similar commands, see
    ++		 * submodule_move_head() and
    ++		 * connect_work_tree_and_git_dir()), but if the
    ++		 * submodule is unpopulated in another way (e.g. "git
    ++		 * rm", "rm -r"), core.worktree will still be set even
    ++		 * though the directory doesn't exist, and the child
    ++		 * process will crash while trying to chdir into the
    ++		 * nonexistent directory.
    ++		 *
    ++		 * In this case, we know that the submodule has no
    ++		 * working tree, so we can work around this by
    ++		 * setting "--work-tree=." (--bare does not work because
    ++		 * worktree settings take precedence over bare-ness).
    ++		 * However, this is not necessarily true in other cases,
    ++		 * so a generalized solution is still necessary.
    ++		 *
    ++		 * Possible solutions:
    ++		 * - teach "git [add|rm]" to unset core.worktree and
    ++		 *   discourage users from removing submodules without
    ++		 *   using a Git command.
    ++		 * - teach submodule child processes to ignore stale
    ++		 *   core.worktree values.
     +		 */
     +		strvec_push(&task->git_args, "--work-tree=.");
     +		return task;
    @@ submodule.h: int should_update_submodules(void);
      ## t/t5526-fetch-submodules.sh ##
     @@ t/t5526-fetch-submodules.sh: pwd=$(pwd)
      
    - check_sub() {
    + check_sub () {
      	NEW_HEAD=$1 &&
     +	SUPER_HEAD=$2 &&
    - 	cat <<-EOF >$pwd/expect.err.sub
    + 	cat >$pwd/expect.err.sub <<-EOF
     -	Fetching submodule submodule
     +	Fetching submodule submodule${SUPER_HEAD:+ at commit $SUPER_HEAD}
      	From $pwd/submodule
      	   OLD_HEAD..$NEW_HEAD  sub        -> origin/sub
      	EOF
    -@@ t/t5526-fetch-submodules.sh: check_sub() {
    +@@ t/t5526-fetch-submodules.sh: check_sub () {
      
    - check_deep() {
    + check_deep () {
      	NEW_HEAD=$1 &&
     +	SUB_HEAD=$2 &&
    - 	cat <<-EOF >$pwd/expect.err.deep
    + 	cat >$pwd/expect.err.deep <<-EOF
     -	Fetching submodule submodule/subdir/deepsubmodule
     +	Fetching submodule submodule/subdir/deepsubmodule${SUB_HEAD:+ at commit $SUB_HEAD}
      	From $pwd/deepsubmodule
      	   OLD_HEAD..$NEW_HEAD  deep       -> origin/deep
      	EOF
    +@@ t/t5526-fetch-submodules.sh: test_expect_success "'--recurse-submodules=on-demand' doesn't recurse when no ne
    + '
    + 
    + test_expect_success "'--recurse-submodules=on-demand' recurses as deep as necessary (and ignores config)" '
    ++	add_submodule_commits &&
    + 	add_superproject_commits &&
    + 	(
    + 		cd downstream &&
     @@ t/t5526-fetch-submodules.sh: test_expect_success "'--recurse-submodules=on-demand' recurses as deep as necess
      	verify_fetch_result actual.err
      '
    @@ t/t5526-fetch-submodules.sh: test_expect_success "'--recurse-submodules=on-deman
     +	# Use test_cmp manually because verify_fetch_result does not
     +	# consider submodule2. All the repos should be fetched, but only
     +	# submodule2 should be read from a commit
    -+	cat <<-EOF > expect.err.combined &&
    ++	cat > expect.err.combined <<-EOF &&
     +	From $pwd/.
     +	   OLD_HEAD..$super_head  super           -> origin/super
     +	   OLD_HEAD..$super_sub2_only_head  super-sub2-only -> origin/super-sub2-only
    @@ t/t5526-fetch-submodules.sh: test_expect_success "'--recurse-submodules=on-deman
     +	From $pwd/submodule2
     +	   OLD_HEAD..$sub2_head  sub2       -> origin/sub2
     +	EOF
    -+	sed -E "s/[0-9a-f]+\.\./OLD_HEAD\.\./" actual.err >actual.err.cmp &&
    ++	sed -e "s/[0-9a-f][0-9a-f]*\.\./OLD_HEAD\.\./" actual.err >actual.err.cmp &&
     +	test_cmp expect.err.combined actual.err.cmp
     +'
     +
    @@ t/t5526-fetch-submodules.sh: test_expect_success 'recursive fetch after deinit a
     +	mkdir same-name-1 &&
     +	(
     +		cd same-name-1 &&
    -+		git init &&
    ++		git init -b main &&
     +		test_commit --no-tag a
     +	) &&
     +	git clone same-name-1 same-name-2 &&
    @@ t/t5526-fetch-submodules.sh: test_expect_success 'recursive fetch after deinit a
     +	(
     +		cd same-name-1 &&
     +		mkdir submodule &&
    -+		git -C submodule init &&
    ++		git -C submodule init -b main &&
     +		test_commit -C submodule --no-tag a1 &&
     +		git submodule add "$pwd/same-name-1/submodule" &&
     +		git add submodule &&
    @@ t/t5526-fetch-submodules.sh: test_expect_success 'recursive fetch after deinit a
     +	(
     +		cd same-name-2 &&
     +		mkdir submodule &&
    -+		git -C submodule init &&
    ++		git -C submodule init -b main &&
     +		test_commit -C submodule --no-tag a2 &&
     +		git submodule add "$pwd/same-name-2/submodule" &&
     +		git add submodule &&
    @@ t/t5526-fetch-submodules.sh: test_expect_success 'recursive fetch after deinit a
     +'
     +
     +test_expect_success 'fetch --recurse-submodules updates name-conflicted, populated submodule' '
    -+	test_when_finished "git -C same-name-downstream checkout master" &&
    ++	test_when_finished "git -C same-name-downstream checkout main" &&
     +	(
     +		cd same-name-1 &&
     +		test_commit -C submodule --no-tag b1 &&
    @@ t/t5526-fetch-submodules.sh: test_expect_success 'recursive fetch after deinit a
     +		cd same-name-downstream &&
     +		# even though the .gitmodules is correct, we cannot
     +		# fetch from same-name-2
    -+		git checkout same-name-2/master &&
    ++		git checkout same-name-2/main &&
     +		git fetch --recurse-submodules same-name-1 &&
     +		test_must_fail git fetch --recurse-submodules same-name-2
     +	) &&
    @@ t/t5526-fetch-submodules.sh: test_expect_success 'recursive fetch after deinit a
     +	) &&
     +	(
     +		cd same-name-downstream &&
    -+		git checkout master &&
    ++		git checkout main &&
     +		git rm .gitmodules &&
     +		git rm submodule &&
     +		git commit -m "no submodules" &&
    @@ t/t5526-fetch-submodules.sh: test_expect_success 'recursive fetch after deinit a
     +	(
     +		cd same-name-downstream/.git/modules/submodule &&
     +		# The submodule has core.worktree pointing to the "git
    -+		# rm"-ed directory, overwrite the invalid value.
    ++		# rm"-ed directory, overwrite the invalid value. See
    ++		# comment in get_fetch_task_from_changed() for more
    ++		# information.
     +		git --work-tree=. cat-file -e $head1 &&
     +		test_must_fail git --work-tree=. cat-file -e $head2
     +	)
10:  e1ac74eee4 = 10:  362ce3c7f8 submodule: fix latent check_has_commit() bug

base-commit: 715d08a9e51251ad8290b181b6ac3b9e1f9719d7
-- 
2.33.GIT

