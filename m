Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73E431F42D
	for <e@80x24.org>; Sun, 15 Apr 2018 20:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752849AbeDOU3P (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Apr 2018 16:29:15 -0400
Received: from mail-wr0-f173.google.com ([209.85.128.173]:37636 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752493AbeDOU3O (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Apr 2018 16:29:14 -0400
Received: by mail-wr0-f173.google.com with SMTP id l49so20518847wrl.4
        for <git@vger.kernel.org>; Sun, 15 Apr 2018 13:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h203YP3N/6IFYuKWusQKnJIIZ3/urKJPBRd5fMszDQE=;
        b=kS62Z0IxcGVQ0vPJQboskMynDpo7Mx6EiiknsAMwy9qDNGH9JqKpzuq3/d2k2cffeF
         37qPIRJnSLBq8tiZ7vCV9lrLhduH+C/2TkP3VUCWGjnFWUU6jTKWrvEcnzleYiJaHf0Y
         2XSJgkwZPmZqJA+ZZhpJiv5GiGbfPB8GKeL8F3bjEZrJE1YZMBpCCes7kgefuB1aQJoE
         0oA8AdumpXjGXun0VoxYzpiuNMNBrp2GsmXOG+OWj7Cy1CCPuI2kGg5pyr8vltUMEKbh
         UF94Wsn9KlNUsCxWhWr5gTuKorLk8sNgIfOzOFqBNQQtvbUTRWcD9mDMzP7eckj6GnPg
         Ajqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h203YP3N/6IFYuKWusQKnJIIZ3/urKJPBRd5fMszDQE=;
        b=q7phCX33yCtcKHAyhiutIgtDzik+pusFJoWkFaX2HjiWsbBWMi8+zLttXRGCqZ88XJ
         C7XG1hHyX1z3HL0gPFlVVBBZMyklJ8dDEltg8NUC+zbNoueSyB0n6SY83V9nHyvyzEL5
         egfvgJkX3ZedxD0R4q/B6QFzT/AOvTGVD+lB5a/FOFq3LbyQ1Z5GzUtjrgKzpR9kgiUT
         B3TW49aF3cufVZg2Wm97Qm4uxHOndx1/7Fi9/6IIanik6iZ41vFncpAIMpwECXiCSn0Q
         hGC65UWvn1VJQFRCJtI/uVO8fsau7q2LilBbmUKOTxS3c/JSqp+P1jgxNkXQGqEYj1KS
         f98g==
X-Gm-Message-State: ALQs6tCJnmDNfyhEnLIMsHBzYFYsas8VCvQd9qN2PVGsKxnH8icy930L
        zAmbOuI+lyoZsYRUhHZCkdFol1+A
X-Google-Smtp-Source: AIpwx48sx6JU0z32FkpgAU59a9Flr4E5TD1uoIHlBxKbjtuHa9a4jYbULnKXhZfKCQRgUcaJSr1zyA==
X-Received: by 10.28.203.65 with SMTP id b62mr2563507wmg.83.1523824152575;
        Sun, 15 Apr 2018 13:29:12 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id 6sm7667913wmf.31.2018.04.15.13.29.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Apr 2018 13:29:11 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v7 0/4] worktree: teach "add" to check out existing branches
Date:   Sun, 15 Apr 2018 21:29:13 +0100
Message-Id: <20180415202917.4360-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.17.0.252.gfe0a9eaf31
In-Reply-To: <20180331151804.30380-1-t.gummerer@gmail.com>
References: <20180331151804.30380-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Eric for the review and all of the suggestions in the last
round.

Previous rounds are at <20180121120208.12760-1-t.gummerer@gmail.com>,
<20180204221305.28300-1-t.gummerer@gmail.com>,
<20180317220830.30963-1-t.gummerer@gmail.com>,
<20180317222219.4940-1-t.gummerer@gmail.com>,
<20180325134947.25828-1-t.gummerer@gmail.com> and
<20180331151804.30380-1-t.gummerer@gmail.com>.

The main change once again in this series is the user interface.  It
feels like we went in a complete circle here now, as this iteration is
bringing the "Preparing ..." line back (although in a slightly
different form than the original), and is moving away from printing
it's own "HEAD is now at..." line again.  This also means we don't
need the new hidden option to 'git reset' anymore, which is nice.

I do like the new UI more than what we had in the last round (which I
already liked more than the original UI) :)

Other than those changes, it also includes Eric's suggestion for a
better wording in the documentation, fixes the argument order to
test_cmd_rev in a test, and makes a test more robust.

To demonstrate the UI updates, let's compare the new UI and the old UI
again.  This is the same commands as used for the demonstration in the
last iteration, so please have a look at <20180331151804.30380-1-t.gummerer@gmail.com> 
for an example of what it looked like after the last round.

New UI:

 - guess-remote mode

    $ git worktree add --guess-remote ../next
    Preparing worktree (new branch 'next')
    Branch 'next' set up to track remote branch 'next' from 'origin'.
    HEAD is now at caa68db14 Merge branch 'sb/packfiles-in-repository' into next

 - original dwim (create a branch based on the current HEAD)

    $ git worktree add ../test
    Preparing worktree (new branch 'test')
    HEAD is now at c2a499e6c Merge branch 'jh/partial-clone'

 - new dwim (check out existing branch)

    $ git worktree add ../test
    Preparing worktree (checking out 'test')
    HEAD is now at c2a499e6c Merge branch 'jh/partial-clone'

 - detached HEAD

    $ git worktree add ../test2 origin/master
    Preparing worktree (detached HEAD c2a499e6c)
    HEAD is now at c2a499e6c Merge branch 'jh/partial-clone'

 - resetting existing branch

    $ git worktree add -B next ../test3 origin/master
    Preparing worktree (resetting branch 'next' (was at caa68db14))
    Branch 'next' set up to track remote branch 'master' from 'origin'.
    HEAD is now at c2a499e6c Merge branch 'jh/partial-clone'

    This output is new in this round and wasn't previously discussed.
    While working on the "Preparing ..." line I noticed this, and
    thought it would be a good idea.  I feel like this fits in the
    scope of the series quite well, as it's improving the UI, but I'm
    happy to split it out if that's preferred.

    It may also be worth displaying the title of the commit here, but
    at that point the line would get a bit long, so dunno.

 - large repository (with original dwim)

    $ git worktree add ../test
    Preparing worktree (new branch 'test')
    Checking out files: 100% (62915/62915), done.
    HEAD is now at c2a9838452a4 Merge tag 'for-4.16/dm-fixes-4' of git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm

 - error when directory already exists

    $ git worktree add ../test
    Preparing worktree (checking out 'test')
    fatal: '../test' already exists

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

 - error when directory already exists

    $ git worktree add ../test
    fatal: '../test' already exists

Interdiff below:

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index eaa6bf713f..5d54f36a71 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -61,13 +61,13 @@ $ git worktree add --track -b <branch> <path> <remote>/<branch>
 ------------
 +
 If `<commit-ish>` is omitted and neither `-b` nor `-B` nor `--detach` used,
-then, as a convenience, a worktree with a branch named after
-`$(basename <path>)` (call it `<branch>`) is created.  If `<branch>`
+then, as a convenience, the new worktree is associated with a branch
+(call it `<branch>`) named after `$(basename <path>)`.  If `<branch>`
 doesn't exist, a new branch based on HEAD is automatically created as
-if `-b <branch>` was given.  If `<branch>` exists in the repository,
-it will be checked out in the new worktree, if it's not checked out
-anywhere else, otherwise the command will refuse to create the
-worktree (unless `--force` is used).
+if `-b <branch>` was given.  If `<branch>` does exist, it will be
+checked out in the new worktree, if it's not checked out anywhere
+else, otherwise the command will refuse to create the worktree (unless
+`--force` is used).
 
 list::
 
diff --git a/builtin/reset.c b/builtin/reset.c
index 54b2576449..e15f595799 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -288,7 +288,6 @@ static int git_reset_config(const char *var, const char *value, void *cb)
 int cmd_reset(int argc, const char **argv, const char *prefix)
 {
 	int reset_type = NONE, update_ref_status = 0, quiet = 0;
-	int show_new_head_line = 1;
 	int patch_mode = 0, unborn;
 	const char *rev;
 	struct object_id oid;
@@ -311,7 +310,6 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		OPT_BOOL('p', "patch", &patch_mode, N_("select hunks interactively")),
 		OPT_BOOL('N', "intent-to-add", &intent_to_add,
 				N_("record only the fact that removed paths will be added later")),
-		OPT_HIDDEN_BOOL(0, "show-new-head-line", &show_new_head_line, N_("show information on the new HEAD")),
 		OPT_END()
 	};
 
@@ -405,8 +403,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		 * switched to, saving the previous head in ORIG_HEAD before. */
 		update_ref_status = reset_refs(rev, &oid);
 
-		if (reset_type == HARD && !update_ref_status && !quiet &&
-		    show_new_head_line)
+		if (reset_type == HARD && !update_ref_status && !quiet)
 			print_new_head_line(lookup_commit_reference(&oid));
 	}
 	if (!pathspec.nr)
diff --git a/builtin/worktree.c b/builtin/worktree.c
index ccc2e63e0f..f5a5283b39 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -27,7 +27,6 @@ struct add_opts {
 	int detach;
 	int checkout;
 	int keep_locked;
-	int checkout_existing_branch;
 };
 
 static int show_only;
@@ -317,28 +316,16 @@ static int add_worktree(const char *path, const char *refname,
 	if (ret)
 		goto done;
 
-	if (opts->checkout_existing_branch)
-		  fprintf_ln(stderr, _("Checking out branch '%s'"), refname);
 	if (opts->checkout) {
 		cp.argv = NULL;
 		argv_array_clear(&cp.args);
 		argv_array_pushl(&cp.args, "reset", "--hard", NULL);
-		argv_array_push(&cp.args, "--no-show-new-head-line");
 		cp.env = child_env.argv;
 		ret = run_command(&cp);
 		if (ret)
 			goto done;
 	}
 
-	fprintf(stderr, _("New worktree HEAD is now at %s"),
-		find_unique_abbrev(commit->object.oid.hash, DEFAULT_ABBREV));
-
-	strbuf_reset(&sb);
-	pp_commit_easy(CMIT_FMT_ONELINE, commit, &sb);
-	if (sb.len > 0)
-		fprintf(stderr, " %s", sb.buf);
-	fputc('\n', stderr);
-
 	is_junk = 0;
 	FREE_AND_NULL(junk_work_tree);
 	FREE_AND_NULL(junk_git_dir);
@@ -366,6 +353,34 @@ static int add_worktree(const char *path, const char *refname,
 	return ret;
 }
 
+static void print_preparing_worktree_line(const char *branch,
+					  const char *new_branch,
+					  const char *new_branch_force,
+					  int checkout_existing_branch)
+{
+	if (checkout_existing_branch) {
+		printf_ln(_("Preparing worktree (checking out '%s')"), branch);
+	} else if (new_branch_force) {
+		struct commit *commit = lookup_commit_reference_by_name(new_branch_force);
+		if (!commit)
+			printf_ln(_("Preparing worktree (new branch '%s')"), new_branch_force);
+		else
+			printf_ln(_("Preparing worktree (resetting branch '%s' (was at %s))"),
+				  new_branch_force,
+				  find_unique_abbrev(commit->object.oid.hash,
+						     DEFAULT_ABBREV));
+	} else if (new_branch) {
+		printf_ln(_("Preparing worktree (new branch '%s')"), new_branch);
+	} else {
+		struct commit *commit = lookup_commit_reference_by_name(branch);
+		if (!commit)
+			die(_("invalid reference: %s"), branch);
+		printf_ln(_("Preparing worktree (detached HEAD %s)"),
+			  find_unique_abbrev(commit->object.oid.hash,
+					     DEFAULT_ABBREV));
+	}
+}
+
 static const char *dwim_branch(const char *path, const char **new_branch,
 			       int *checkout_existing_branch)
 {
@@ -397,6 +412,7 @@ static int add(int ac, const char **av, const char *prefix)
 	struct add_opts opts;
 	const char *new_branch_force = NULL;
 	char *path;
+	int checkout_existing_branch = 0;
 	const char *branch;
 	const char *new_branch = NULL;
 	const char *opt_track = NULL;
@@ -445,7 +461,7 @@ static int add(int ac, const char **av, const char *prefix)
 
 	if (ac < 2 && !new_branch && !opts.detach) {
 		const char *s = dwim_branch(path, &new_branch,
-					    &opts.checkout_existing_branch);
+					    &checkout_existing_branch);
 		if (s)
 			branch = s;
 	}
@@ -465,10 +481,11 @@ static int add(int ac, const char **av, const char *prefix)
 		}
 	}
 
+	print_preparing_worktree_line(branch, new_branch, new_branch_force,
+				      checkout_existing_branch);
+
 	if (new_branch) {
 		struct child_process cp = CHILD_PROCESS_INIT;
-
-		fprintf_ln(stderr, _("Creating branch '%s'"), new_branch);
 		cp.git_cmd = 1;
 		argv_array_push(&cp.args, "branch");
 		if (new_branch_force)
diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index f72cb0eb0b..ad38507d00 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -204,7 +204,7 @@ test_expect_success '"add" checks out existing branch of dwimd name' '
 	test_cmp_rev HEAD~1 dwim &&
 	(
 		cd dwim &&
-		test_cmp_rev dwim HEAD
+		test_cmp_rev HEAD dwim
 	)
 '
 
@@ -215,6 +215,7 @@ test_expect_success '"add <path>" dwim fails with checked out branch' '
 '
 
 test_expect_success '"add --force" with existing dwimd name doesnt die' '
+	git checkout test-branch &&
 	git worktree add --force test-branch
 '
 
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index a160f78aba..95653a08ca 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -568,9 +568,4 @@ test_expect_success 'reset --mixed sets up work tree' '
 	test_cmp expect actual
 '
 
-test_expect_success 'reset --no-show-new-head-line suppresses "HEAD is now at" output' '
-	git reset --hard --no-show-new-head-line HEAD >actual &&
-	! grep "HEAD is now at" <actual
-'
-
 test_done

Thomas Gummerer (4):
  worktree: remove extra members from struct add_opts
  worktree: improve message when creating a new worktree
  worktree: factor out dwim_branch function
  worktree: teach "add" to check out existing branches

 Documentation/git-worktree.txt |   9 +++-
 builtin/worktree.c             | 101 ++++++++++++++++++++++++++++++-----------
 t/t2025-worktree-add.sh        |  26 ++++++++---
 3 files changed, 100 insertions(+), 36 deletions(-)

-- 
2.16.1.74.g6cd9b6cbe3

