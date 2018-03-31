Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 243181F404
	for <e@80x24.org>; Sat, 31 Mar 2018 15:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752543AbeCaPOr (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Mar 2018 11:14:47 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:52850 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752423AbeCaPOp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Mar 2018 11:14:45 -0400
Received: by mail-wm0-f44.google.com with SMTP id l9so19376296wmh.2
        for <git@vger.kernel.org>; Sat, 31 Mar 2018 08:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MxiHMoG+KnVsijLH7W74qDLVP/Nh8QcF9/jT7TzZfdA=;
        b=rAmLKPuUPuQA7apEHlRlpPPG65i8o+u/j/+gj0x9FewSNuDzW5O6SMcWehIccoXkCx
         wlpJbGBNACCFagysNPXw3LU9qbH8ycr6V7pjkRnj2mPdJxETa41/6iekTJkzzP/l5twk
         VIMKz0twcu0oY2m3DiI9FsHWDs59SFeQ4nRaUhZMyNEBnhHRY8gWzGHdkY8A7e2aBJwG
         0NnMzaZYqKmBAxdnWBMCLk4GZ9IStgZ/6esXivmv9VP5Tofg8adCJuFOcCy8J1+1xybd
         FqPNiXzimGi/qoyO0VZEygKKrPLbFYf9IDM7cuP3jDEhW4feWHAYRuicKeDq+f90Wvxb
         CmWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MxiHMoG+KnVsijLH7W74qDLVP/Nh8QcF9/jT7TzZfdA=;
        b=Ns49Clh9MPf28RByYTw/RjVRprwp7/m8b7qwsLujtjNx/3m7zgsNeTtBTFEpcer/Sw
         oIR2YeaOr75PFPku7qBB7BOUl3ZQNuwA0mA28UFKbkoRXwxozhckq2HOwPkyyz0RN76v
         O6J5boXE9RQj7kZIRuKuNf9Hyk9giI87cbBoEXLAgb66jzN2kX1rAsX3hpbFju4wUJD6
         WNFi/zJES3ReK7QIdION/2rBNaU2CFsqO0FRnf2NeQ+CjW9I56xLpdm+/RGgBoM7Z1Je
         wJcNpQ82PFC0inBmE+WZnGwWwXVmyYaQo4SYh9ym0z0drSaqUidTzpMIIjG7jVotufr8
         w1wA==
X-Gm-Message-State: AElRT7GPM52cylAAzBK9dEUkNrXJis1CZUTbgEvX5TibB0qZbadpg1dD
        vbbT0e30I4CIow8VOV08fzhsOeNh
X-Google-Smtp-Source: AIpwx4+iw6bS0roIPHVSWYWy/HscwiKVpXnySoYnhQ9nA29kqYV1m+WEHisTIG7hoKeKXFnpa73DOQ==
X-Received: by 10.28.136.18 with SMTP id k18mr5294731wmd.111.1522509283676;
        Sat, 31 Mar 2018 08:14:43 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id r19sm10796132wmd.48.2018.03.31.08.14.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 31 Mar 2018 08:14:42 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v6 0/6] worktree: teach "add" to check out existing branches
Date:   Sat, 31 Mar 2018 16:17:58 +0100
Message-Id: <20180331151804.30380-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.16.1.78.ga2082135d8
In-Reply-To: <20180325134947.25828-1-t.gummerer@gmail.com>
References: <20180325134947.25828-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Eric for the review of the last round.

Previous rounds are at <20180121120208.12760-1-t.gummerer@gmail.com>,
<20180204221305.28300-1-t.gummerer@gmail.com>,
<20180317220830.30963-1-t.gummerer@gmail.com>,
<20180317222219.4940-1-t.gummerer@gmail.com> and
20180325134947.25828-1-t.gummerer@gmail.com.

This round should fix all the UI issues Eric found in the last round.

The changes I made in a bit more detail:

- in addition to removing the 'force_new_branch' flag from 'struct
  add_opts', also remove the 'new_branch' member, which is local to
  the 'add()' function.  The other four members are needed in the
  'worktree_add()' function, so I left them there.   This patch is now
  the first patch in the series.

- added a new commit introducing a new hidden --show-new-head-line
  flag in 'git reset'.  This is used to suppress the "HEAD is now at
  ..."  line that 'git reset --hard' usually prints, so we can replace
  it with our own "New worktree HEAD is now at ..." line instead,
  while keeping the progress indicator for larger repositories.

  I guess this may be the most controversial bit at this point, as
  we'd be adding an option for internal use only.  Not sure how we
  feel about that. But short of going back to the old output format, I
  don't see a good option to make this work otherwise.  I tried
  re-using internal functions for this, but until we have 'struct
  repository' everywhere, that's going to be quite hard.

- Print the "Creating branch ..." and "Checking out branch ..."
  messages earlier in the process.  This is mainly to avoid the out of
  order "Branch '...' now set up to track ..." message.

- Various commit message and style cleanups

Note that these fixes are quite differently executed than I had
imagined them in the reply to the review comments, as things didn't
work as I had imagined.  The UI problems should be fixed now
nonetheless :)

Some examples of the new UI behaviour here for reference:

 - guess-remote mode

    $ git worktree add --guess-remote ../next
    Creating branch 'next'
    Branch 'next' set up to track remote branch 'next' from 'origin'.
    New worktree HEAD is now at caa68db14 Merge branch 'sb/packfiles-in-repository' into next

 - original dwim (create a branch based on the current HEAD)

    $ git worktree add ../test
    Creating branch 'test'
    New worktree HEAD is now at c2a499e6c Merge branch 'jh/partial-clone'

 - new dwim (check out existing branch)

    $ git worktree add ../test
    Checking out branch 'test'
    New worktree HEAD is now at c2a499e6c Merge branch 'jh/partial-clone'

 - no new branch created
 
    $ git worktree add ../test2 origin/master
    New worktree HEAD is now at c2a499e6c Merge branch 'jh/partial-clone'

 - large repository (with original dwim)

    $ g worktree add ../test
    Creating branch 'test'
    Checking out files: 100% (62915/62915), done.
    New worktree HEAD is now at c2a9838452a4 Merge tag 'for-4.16/dm-fixes-4' of git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm

Compare this to the old UI (new dwim omitted, as there's no old
version of that):

 - guess-remote mode

    $ git worktree add --guess-remote ../next
    Branch 'next' set up to track remote branch 'next' from 'origin'.
    Preparing ../next (identifier next)
    HEAD is now at caa68db14 Merge branch 'sb/packfiles-in-repository' into next

 - original dwim (create a branch based on the current HEAD)

    $ git worktree add ../test
    Preparing ../test (identifier test)
    HEAD is now at c2a499e6c Merge branch 'jh/partial-clone'

 - no new branch created

    $ git worktree add ../test2 origin/master
    Preparing ../test2 (identifier test2)
    HEAD is now at c2a499e6c Merge branch 'jh/partial-clone'

 - large repository

    $ git worktree add ../test
    Preparing ../test (identifier test)
    Checking out files: 100% (62915/62915), done.
    HEAD is now at c2a9838452a4 Merge tag 'for-4.16/dm-fixes-4' of git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm

The one thing we are loosing is a context line before "Checking out
files:", if no new branch is created.  Personally I feel like that's
acceptable, as the user just used the 'git worktree add' command, so
it should be intuitive where those files are being checked out.

We could also print "Preparing worktree <path>" as a line in the
beginning (without mentioning the identifier, so we can print it in
the 'add()' function), but I don't feel like that's worth spending the
extra screen estate.  I don't feel strongly about that though, so if
someone has a moderately strong preference for that line being there,
I'm happy to add it.

Interdiff below:

diff --git a/builtin/reset.c b/builtin/reset.c
index e15f595799..54b2576449 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -288,6 +288,7 @@ static int git_reset_config(const char *var, const char *value, void *cb)
 int cmd_reset(int argc, const char **argv, const char *prefix)
 {
 	int reset_type = NONE, update_ref_status = 0, quiet = 0;
+	int show_new_head_line = 1;
 	int patch_mode = 0, unborn;
 	const char *rev;
 	struct object_id oid;
@@ -310,6 +311,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		OPT_BOOL('p', "patch", &patch_mode, N_("select hunks interactively")),
 		OPT_BOOL('N', "intent-to-add", &intent_to_add,
 				N_("record only the fact that removed paths will be added later")),
+		OPT_HIDDEN_BOOL(0, "show-new-head-line", &show_new_head_line, N_("show information on the new HEAD")),
 		OPT_END()
 	};
 
@@ -403,7 +405,8 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		 * switched to, saving the previous head in ORIG_HEAD before. */
 		update_ref_status = reset_refs(rev, &oid);
 
-		if (reset_type == HARD && !update_ref_status && !quiet)
+		if (reset_type == HARD && !update_ref_status && !quiet &&
+		    show_new_head_line)
 			print_new_head_line(lookup_commit_reference(&oid));
 	}
 	if (!pathspec.nr)
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 895838b943..511d0aa370 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -27,8 +27,6 @@ struct add_opts {
 	int detach;
 	int checkout;
 	int keep_locked;
-	const char *new_branch;
-	int checkout_existing_branch;
 };
 
 static int show_only;
@@ -318,31 +316,26 @@ static int add_worktree(const char *path, const char *refname,
 	if (ret)
 		goto done;
 
-	if (opts->checkout_existing_branch)
-		fprintf_ln(stderr, _("checking out branch '%s'"),
-			   refname);
-	else if (opts->new_branch)
-		fprintf_ln(stderr, _("creating branch '%s'"), opts->new_branch);
-
-	fprintf(stderr, _("new worktree HEAD is now at %s"),
-		find_unique_abbrev(commit->object.oid.hash, DEFAULT_ABBREV));
-
-	strbuf_reset(&sb);
-	pp_commit_easy(CMIT_FMT_ONELINE, commit, &sb);
-	if (sb.len > 0)
-		fprintf(stderr, " %s", sb.buf);
-	fputc('\n', stderr);
-
 	if (opts->checkout) {
 		cp.argv = NULL;
 		argv_array_clear(&cp.args);
-		argv_array_pushl(&cp.args, "reset", "--hard", "--quiet", NULL);
+		argv_array_pushl(&cp.args, "reset", "--hard", NULL);
+		argv_array_push(&cp.args, "--no-show-new-head-line");
 		cp.env = child_env.argv;
 		ret = run_command(&cp);
 		if (ret)
 			goto done;
 	}
 
+	fprintf(stderr, _("New worktree HEAD is now at %s"),
+		find_unique_abbrev(commit->object.oid.hash, DEFAULT_ABBREV));
+
+	strbuf_reset(&sb);
+	pp_commit_easy(CMIT_FMT_ONELINE, commit, &sb);
+	if (sb.len > 0)
+		fprintf(stderr, " %s", sb.buf);
+	fputc('\n', stderr);
+
 	is_junk = 0;
 	FREE_AND_NULL(junk_work_tree);
 	FREE_AND_NULL(junk_git_dir);
@@ -370,7 +363,8 @@ static int add_worktree(const char *path, const char *refname,
 	return ret;
 }
 
-static const char *dwim_branch(const char *path, struct add_opts *opts)
+static const char *dwim_branch(const char *path, const char **new_branch,
+			       int *checkout_existing_branch)
 {
 	int n;
 	const char *s = worktree_basename(path, &n);
@@ -379,17 +373,17 @@ static const char *dwim_branch(const char *path, struct add_opts *opts)
 
 	if (!strbuf_check_branch_ref(&ref, branchname) &&
 	    ref_exists(ref.buf)) {
-		opts->checkout_existing_branch = 1;
+		*checkout_existing_branch = 1;
 		strbuf_release(&ref);
 		UNLEAK(branchname);
 		return branchname;
 	}
 
-	opts->new_branch = branchname;
+	*new_branch = branchname;
 	if (guess_remote) {
 		struct object_id oid;
 		const char *remote =
-			unique_tracking_name(opts->new_branch, &oid);
+			unique_tracking_name(*new_branch, &oid);
 		return remote;
 	}
 	return NULL;
@@ -401,10 +395,12 @@ static int add(int ac, const char **av, const char *prefix)
 	const char *new_branch_force = NULL;
 	char *path;
 	const char *branch;
+	const char *new_branch = NULL;
 	const char *opt_track = NULL;
+	int checkout_existing_branch = 0;
 	struct option options[] = {
 		OPT__FORCE(&opts.force, N_("checkout <branch> even if already checked out in other worktree")),
-		OPT_STRING('b', NULL, &opts.new_branch, N_("branch"),
+		OPT_STRING('b', NULL, &new_branch, N_("branch"),
 			   N_("create a new branch")),
 		OPT_STRING('B', NULL, &new_branch_force, N_("branch"),
 			   N_("create or reset a branch")),
@@ -422,7 +418,7 @@ static int add(int ac, const char **av, const char *prefix)
 	memset(&opts, 0, sizeof(opts));
 	opts.checkout = 1;
 	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
-	if (!!opts.detach + !!opts.new_branch + !!new_branch_force > 1)
+	if (!!opts.detach + !!new_branch + !!new_branch_force > 1)
 		die(_("-b, -B, and --detach are mutually exclusive"));
 	if (ac < 1 || ac > 2)
 		usage_with_options(worktree_usage, options);
@@ -436,22 +432,23 @@ static int add(int ac, const char **av, const char *prefix)
 	if (new_branch_force) {
 		struct strbuf symref = STRBUF_INIT;
 
-		opts.new_branch = new_branch_force;
+		new_branch = new_branch_force;
 
 		if (!opts.force &&
-		    !strbuf_check_branch_ref(&symref, opts.new_branch) &&
+		    !strbuf_check_branch_ref(&symref, new_branch) &&
 		    ref_exists(symref.buf))
 			die_if_checked_out(symref.buf, 0);
 		strbuf_release(&symref);
 	}
 
-	if (ac < 2 && !opts.new_branch && !opts.detach) {
-		const char *dwim_branchname = dwim_branch(path, &opts);
-		if (dwim_branchname)
-			branch = dwim_branchname;
+	if (ac < 2 && !new_branch && !opts.detach) {
+		const char *s = dwim_branch(path, &new_branch,
+					    &checkout_existing_branch);
+		if (s)
+			branch = s;
 	}
 
-	if (ac == 2 && !opts.new_branch && !opts.detach) {
+	if (ac == 2 && !new_branch && !opts.detach) {
 		struct object_id oid;
 		struct commit *commit;
 		const char *remote;
@@ -460,25 +457,29 @@ static int add(int ac, const char **av, const char *prefix)
 		if (!commit) {
 			remote = unique_tracking_name(branch, &oid);
 			if (remote) {
-				opts.new_branch = branch;
+				new_branch = branch;
 				branch = remote;
 			}
 		}
 	}
 
-	if (opts.new_branch) {
+	if (new_branch) {
 		struct child_process cp = CHILD_PROCESS_INIT;
+
+		fprintf_ln(stderr, _("Creating branch '%s'"), new_branch);
 		cp.git_cmd = 1;
 		argv_array_push(&cp.args, "branch");
 		if (new_branch_force)
 			argv_array_push(&cp.args, "--force");
-		argv_array_push(&cp.args, opts.new_branch);
+		argv_array_push(&cp.args, new_branch);
 		argv_array_push(&cp.args, branch);
 		if (opt_track)
 			argv_array_push(&cp.args, opt_track);
 		if (run_command(&cp))
 			return -1;
-		branch = opts.new_branch;
+		branch = new_branch;
+	} else if (checkout_existing_branch) {
+		  fprintf_ln(stderr, _("Checking out branch '%s'"), branch);
 	} else if (opt_track) {
 		die(_("--[no-]track can only be used if a new branch is created"));
 	}
diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index fb99f4c46f..f72cb0eb0b 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -199,8 +199,6 @@ test_expect_success '"add" with <branch> omitted' '
 '
 
 test_expect_success '"add" checks out existing branch of dwimd name' '
-	test_commit c1 &&
-	test_commit c2 &&
 	git branch dwim HEAD~1 &&
 	git worktree add dwim &&
 	test_cmp_rev HEAD~1 dwim &&
@@ -210,7 +208,7 @@ test_expect_success '"add" checks out existing branch of dwimd name' '
 	)
 '
 
-test_expect_success '"add" auto-vivify fails with checked out branch' '
+test_expect_success '"add <path>" dwim fails with checked out branch' '
 	git checkout -b test-branch &&
 	test_must_fail git worktree add test-branch &&
 	test_path_is_missing test-branch
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index 95653a08ca..a160f78aba 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -568,4 +568,9 @@ test_expect_success 'reset --mixed sets up work tree' '
 	test_cmp expect actual
 '
 
+test_expect_success 'reset --no-show-new-head-line suppresses "HEAD is now at" output' '
+	git reset --hard --no-show-new-head-line HEAD >actual &&
+	! grep "HEAD is now at" <actual
+'
+
 test_done

Thomas Gummerer (6):
  worktree: remove extra members from struct add_opts
  reset: introduce show-new-head-line option
  worktree: improve message when creating a new worktree
  worktree: be clearer when "add" dwim-ery kicks in
  worktree: factor out dwim_branch function
  worktree: teach "add" to check out existing branches

 Documentation/git-worktree.txt |  9 ++++-
 builtin/reset.c                |  5 ++-
 builtin/worktree.c             | 85 ++++++++++++++++++++++++++++--------------
 t/t2025-worktree-add.sh        | 25 +++++++++----
 t/t7102-reset.sh               |  5 +++
 5 files changed, 92 insertions(+), 37 deletions(-)

-- 
2.16.1.78.g383dce0c66

