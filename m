Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058A0C433FE
	for <git@archiver.kernel.org>; Sun,  6 Nov 2022 21:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiKFVwB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Nov 2022 16:52:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbiKFVv7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Nov 2022 16:51:59 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F682D86
        for <git@vger.kernel.org>; Sun,  6 Nov 2022 13:51:58 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id h9so13820592wrt.0
        for <git@vger.kernel.org>; Sun, 06 Nov 2022 13:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yE0IaOGuxVohgc2FjIGW3VdqBfeEzAun4NH+kLEHcVU=;
        b=ARvgFWq5zdSeiPVuPp1Grm5GNfFAF0ZLZI2mPp0ZVrz24a0zMplT0coAhdxuDi5qt2
         zjhTiHnm7GxbFP7y2HpMlb1RhdfeRbOWcZ7Y0WDYp5dHcqtmSW8u0yutv7qV81nUHAGZ
         uVbDPMCFhgooKIlYpZOLwEMkcixTzC0iOpdrl4LlxRJcdmsWxUhlssplxWxLYDfiZArK
         sYaEgnUKuzAjYMSGGPXv8jgRJF9zl7XsZjKOHnuVYlTdtvCKnOk3zp3yYswL9Omfkm7X
         mRLUnYCnEBLhQNhQpucoJJlkQgSo/X9Pl1hOXDLPJZ5DIimS9NR1n+PI0IaSBTW0ik0s
         CSfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yE0IaOGuxVohgc2FjIGW3VdqBfeEzAun4NH+kLEHcVU=;
        b=HuHExHABM9Qidu0W+QyOcsLIqG1xKJi5C1hIy7YIRnqzkNEr9pKAzGRkhazMTh0heA
         /EBJJ3MBzCvryQ0XIS1OfVpe9i2DnYqIqltxltWJ3015ce7heIgvrtzLmnoe4rjKRzhF
         dnSbaHgMCJ+agmqJV17n0I0ZVBTvP7hYiOgCJuuVMVC5strhoQH54XDWKniPV4RZ6c+8
         DBh9TtCh5yaspN9ewx/wzbEPK2ztmMsd/lRMQczO7urwNArJ1espt2bpYuyrfBhqQXF8
         Cp85beQpMrTIt1JlcLkUNiBBms55Yt4L0eABa6bSstdgUF7+pReOdletZgEFnXTDsrp1
         g/GQ==
X-Gm-Message-State: ACrzQf0Ue/payl57lQNx8LrOf64madRmFZotrbkhz2kNV59707wltBh+
        fXec2Oxbu9/ulxbqES8eIXvsqFaVJIk=
X-Google-Smtp-Source: AMsMyM6LFYY25aJs52rwlAZdXk9sLLZ2dLzR5VC7sPURbamTVoDHDtgWzfJ7XN/AIOJpVMZTVNX0jw==
X-Received: by 2002:a5d:6da1:0:b0:231:c189:e077 with SMTP id u1-20020a5d6da1000000b00231c189e077mr29674544wrs.114.1667771516280;
        Sun, 06 Nov 2022 13:51:56 -0800 (PST)
Received: from [192.168.2.52] (203.85-84-12.dynamic.clientes.euskaltel.es. [85.84.12.203])
        by smtp.gmail.com with ESMTPSA id z14-20020adff74e000000b0022cdb687bf9sm6694150wrp.0.2022.11.06.13.51.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Nov 2022 13:51:55 -0800 (PST)
Subject: [PATCH v2] branch: error and informative messages
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <3f63d53d-2e14-ffe0-6263-2a15f83453ad@gmail.com>
Message-ID: <eb3c689e-efeb-4468-a10f-dd32bc0ee37b@gmail.com>
Date:   Sun, 6 Nov 2022 22:51:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <3f63d53d-2e14-ffe0-6263-2a15f83453ad@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Review die(), error() and warning() messages used in branch, following
the guidelines we have in Documentation/CodingGuideLines.

Mainly:
	Error messages
 	 - Do not end error messages with a full stop.
 	 - Do not capitalize the first word, ...

"%s" and "'%s'" was used to format a branch name in different messages.
"'%s'" has been used to normalize as it's the more frequently used in
this file and very common in the rest of the codebase.

The tests affected by the modified messages have been updated.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---

From v1, many changes, non substantial for the objective of the patch,
has been left out.

This is a minor patch, but I don't want to leave it behind as I have
been delaying this in my previous patches for branch.c, so as not to mix
those changes with this, but this needs to be done.

Some future work might be done, maybe after some new guidelines be
defined.  I leave here some quick notes related that might be useful to
that possible discussion:
	- quoting related to values: branches, refs, hashes, ...
	- quoting related to literals: HEAD, options, commands, config, ...
	- informative messages going to stdin or stderr
	- capitalize informative or advice messages
	- full stop on informative messages 
	- pool of frequent common errors (ie: no branch named...)


--word-diff can be useful to review this patch.

Un saludo.

 builtin/branch.c          | 71 ++++++++++++++++++++-------------------
 t/t2407-worktree-heads.sh |  2 +-
 t/t3200-branch.sh         | 12 +++----
 t/t3202-show-branch.sh    |  8 ++---
 4 files changed, 47 insertions(+), 46 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 15be0c03ef..abef1e1a66 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -163,11 +163,11 @@ static int branch_merged(int kind, const char *name,
 	    in_merge_bases(rev, head_rev) != merged) {
 		if (merged)
 			warning(_("deleting branch '%s' that has been merged to\n"
-				"         '%s', but not yet merged to HEAD."),
+				"         '%s', but not yet merged to HEAD"),
 				name, reference_name);
 		else
 			warning(_("not deleting branch '%s' that is not yet merged to\n"
-				"         '%s', even though it is merged to HEAD."),
+				"         '%s', even though it is merged to HEAD"),
 				name, reference_name);
 	}
 	free(reference_name_to_free);
@@ -180,13 +180,13 @@ static int check_branch_commit(const char *branchname, const char *refname,
 {
 	struct commit *rev = lookup_commit_reference(the_repository, oid);
 	if (!force && !rev) {
-		error(_("Couldn't look up commit object for '%s'"), refname);
+		error(_("couldn't look up commit object for '%s'"), refname);
 		return -1;
 	}
 	if (!force && !branch_merged(kinds, branchname, rev, head_rev)) {
-		error(_("The branch '%s' is not fully merged.\n"
+		error(_("the branch '%s' is not fully merged\n"
 		      "If you are sure you want to delete it, "
-		      "run 'git branch -D %s'."), branchname, branchname);
+		      "run 'git branch -D %s'"), branchname, branchname);
 		return -1;
 	}
 	return 0;
@@ -197,7 +197,7 @@ static void delete_branch_config(const char *branchname)
 	struct strbuf buf = STRBUF_INIT;
 	strbuf_addf(&buf, "branch.%s", branchname);
 	if (git_config_rename_section(buf.buf, NULL) < 0)
-		warning(_("Update of config-file failed"));
+		warning(_("update of config-file failed"));
 	strbuf_release(&buf);
 }
 
@@ -238,7 +238,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 	if (!force) {
 		head_rev = lookup_commit_reference(the_repository, &head_oid);
 		if (!head_rev)
-			die(_("Couldn't look up commit object for HEAD"));
+			die(_("couldn't look up commit object for HEAD"));
 	}
 
 	for (i = 0; i < argc; i++, strbuf_reset(&bname)) {
@@ -252,7 +252,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 		if (kinds == FILTER_REFS_BRANCHES) {
 			const char *path;
 			if ((path = branch_checked_out(name))) {
-				error(_("Cannot delete branch '%s' "
+				error(_("cannot delete branch '%s' "
 					"checked out at '%s'"),
 				      bname.buf, path);
 				ret = 1;
@@ -267,8 +267,8 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 					&oid, &flags);
 		if (!target) {
 			error(remote_branch
-			      ? _("remote-tracking branch '%s' not found.")
-			      : _("branch '%s' not found."), bname.buf);
+			      ? _("remote-tracking branch '%s' not found")
+			      : _("branch '%s' not found"), bname.buf);
 			ret = 1;
 			continue;
 		}
@@ -501,11 +501,11 @@ static void reject_rebase_or_bisect_branch(const char *target)
 			continue;
 
 		if (is_worktree_being_rebased(wt, target))
-			die(_("Branch %s is being rebased at %s"),
+			die(_("branch '%s' is being rebased at %s"),
 			    target, wt->path);
 
 		if (is_worktree_being_bisected(wt, target))
-			die(_("Branch %s is being bisected at %s"),
+			die(_("branch '%s' is being bisected at %s"),
 			    target, wt->path);
 	}
 
@@ -528,14 +528,14 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 		if (ref_exists(oldref.buf))
 			recovery = 1;
 		else
-			die(_("Invalid branch name: '%s'"), oldname);
+			die(_("invalid branch name: '%s'"), oldname);
 	}
 
 	if ((copy || strcmp(head, oldname)) && !ref_exists(oldref.buf)) {
 		if (copy && !strcmp(head, oldname))
-			die(_("No commit on branch '%s' yet."), oldname);
+			die(_("no commit on branch '%s' yet"), oldname);
 		else
-			die(_("No branch named '%s'."), oldname);
+			die(_("no branch named '%s'"), oldname);
 	}
 
 	/*
@@ -564,22 +564,22 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 	if (!copy &&
 	    (!head || strcmp(oldname, head) || !is_null_oid(&head_oid)) &&
 	    rename_ref(oldref.buf, newref.buf, logmsg.buf))
-		die(_("Branch rename failed"));
+		die(_("branch rename failed"));
 	if (copy && copy_existing_ref(oldref.buf, newref.buf, logmsg.buf))
-		die(_("Branch copy failed"));
+		die(_("branch copy failed"));
 
 	if (recovery) {
 		if (copy)
-			warning(_("Created a copy of a misnamed branch '%s'"),
+			warning(_("created a copy of a misnamed branch '%s'"),
 				interpreted_oldname);
 		else
-			warning(_("Renamed a misnamed branch '%s' away"),
+			warning(_("renamed a misnamed branch '%s' away"),
 				interpreted_oldname);
 	}
 
 	if (!copy &&
 	    replace_each_worktree_head_symref(oldref.buf, newref.buf, logmsg.buf))
-		die(_("Branch renamed to %s, but HEAD is not updated!"), newname);
+		die(_("branch renamed to '%s', but HEAD is not updated"), newname);
 
 	strbuf_release(&logmsg);
 
@@ -588,9 +588,9 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 	strbuf_addf(&newsection, "branch.%s", interpreted_newname);
 	strbuf_release(&newref);
 	if (!copy && git_config_rename_section(oldsection.buf, newsection.buf) < 0)
-		die(_("Branch is renamed, but update of config-file failed"));
+		die(_("branch is renamed, but update of config-file failed"));
 	if (copy && strcmp(oldname, newname) && git_config_copy_section(oldsection.buf, newsection.buf) < 0)
-		die(_("Branch is copied, but update of config-file failed"));
+		die(_("branch is copied, but update of config-file failed"));
 	strbuf_release(&oldsection);
 	strbuf_release(&newsection);
 }
@@ -708,11 +708,11 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 
 	head = resolve_refdup("HEAD", 0, &head_oid, NULL);
 	if (!head)
-		die(_("Failed to resolve HEAD as a valid ref."));
+		die(_("failed to resolve HEAD as a valid ref"));
 	if (!strcmp(head, "HEAD"))
 		filter.detached = 1;
 	else if (!skip_prefix(head, "refs/heads/", &head))
-		die(_("HEAD not found below refs/heads!"));
+		die(_("HEAD not found below refs/heads"));
 
 	argc = parse_options(argc, argv, prefix, options, builtin_branch_usage,
 			     0);
@@ -798,7 +798,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 
 		if (!argc) {
 			if (filter.detached)
-				die(_("Cannot give description to detached HEAD"));
+				die(_("cannot give description to detached HEAD"));
 			branch_name = head;
 		} else if (argc == 1) {
 			strbuf_branchname(&buf, argv[0], INTERPRET_BRANCH_LOCAL);
@@ -810,8 +810,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		strbuf_addf(&branch_ref, "refs/heads/%s", branch_name);
 		if (!ref_exists(branch_ref.buf))
 			error((!argc || !strcmp(head, branch_name))
-			      ? _("No commit on branch '%s' yet.")
-			      : _("No branch named '%s'."),
+			      ? _("no commit on branch '%s' yet")
+			      : _("no branch named '%s'"),
 			      branch_name);
 		else if (!edit_branch_description(branch_name))
 			ret = 0; /* happy */
@@ -824,8 +824,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		if (!argc)
 			die(_("branch name required"));
 		else if ((argc == 1) && filter.detached)
-			die(copy? _("cannot copy the current branch while not on any.")
-				: _("cannot rename the current branch while not on any."));
+			die(copy? _("cannot copy the current branch while not on any")
+				: _("cannot rename the current branch while not on any"));
 		else if (argc == 1)
 			copy_or_rename_branch(head, argv[0], copy, copy + rename > 1);
 		else if (argc == 2)
@@ -848,14 +848,14 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		if (!branch) {
 			if (!argc || !strcmp(argv[0], "HEAD"))
 				die(_("could not set upstream of HEAD to %s when "
-				      "it does not point to any branch."),
+				      "it does not point to any branch"),
 				    new_upstream);
 			die(_("no such branch '%s'"), argv[0]);
 		}
 
 		if (!ref_exists(branch->refname)) {
 			if (!argc || !strcmp(head, branch->name))
-				die(_("No commit on branch '%s' yet."), branch->name);
+				die(_("no commit on branch '%s' yet"), branch->name);
 			die(_("branch '%s' does not exist"), branch->name);
 		}
 
@@ -878,12 +878,12 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		if (!branch) {
 			if (!argc || !strcmp(argv[0], "HEAD"))
 				die(_("could not unset upstream of HEAD when "
-				      "it does not point to any branch."));
+				      "it does not point to any branch"));
 			die(_("no such branch '%s'"), argv[0]);
 		}
 
 		if (!branch_has_merge_config(branch))
-			die(_("Branch '%s' has no upstream information"), branch->name);
+			die(_("branch '%s' has no upstream information"), branch->name);
 
 		strbuf_reset(&buf);
 		strbuf_addf(&buf, "branch.%s.remote", branch->name);
@@ -897,11 +897,12 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		const char *start_name = argc == 2 ? argv[1] : head;
 
 		if (filter.kind != FILTER_REFS_BRANCHES)
-			die(_("The -a, and -r, options to 'git branch' do not take a branch name.\n"
+			die(_("the -a, and -r, options to 'git branch' do not take a branch name\n"
 				  "Did you mean to use: -a|-r --list <pattern>?"));
 
 		if (track == BRANCH_TRACK_OVERRIDE)
-			die(_("the '--set-upstream' option is no longer supported. Please use '--track' or '--set-upstream-to' instead."));
+			die(_("the '--set-upstream' option is no longer supported\n"
+				  "Please use '--track' or '--set-upstream-to' instead"));
 
 		if (recurse_submodules) {
 			create_branches_recursively(the_repository, branch_name,
diff --git a/t/t2407-worktree-heads.sh b/t/t2407-worktree-heads.sh
index 019a40df2c..b0992d5f91 100755
--- a/t/t2407-worktree-heads.sh
+++ b/t/t2407-worktree-heads.sh
@@ -45,7 +45,7 @@ test_expect_success 'refuse to overwrite: checked out in worktree' '
 		grep "cannot force update the branch" err &&
 
 		test_must_fail git branch -D wt-$i 2>err &&
-		grep "Cannot delete branch" err || return 1
+		grep "cannot delete branch" err || return 1
 	done
 '
 
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 7f605f865b..8cfdc14b99 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -271,10 +271,10 @@ test_expect_success 'git branch -M topic topic should work when main is checked
 test_expect_success 'git branch -M and -C fail on detached HEAD' '
 	git checkout HEAD^{} &&
 	test_when_finished git checkout - &&
-	echo "fatal: cannot rename the current branch while not on any." >expect &&
+	echo "fatal: cannot rename the current branch while not on any" >expect &&
 	test_must_fail git branch -M must-fail 2>err &&
 	test_cmp expect err &&
-	echo "fatal: cannot copy the current branch while not on any." >expect &&
+	echo "fatal: cannot copy the current branch while not on any" >expect &&
 	test_must_fail git branch -C must-fail 2>err &&
 	test_cmp expect err
 '
@@ -942,7 +942,7 @@ test_expect_success '--set-upstream-to fails on multiple branches' '
 test_expect_success '--set-upstream-to fails on detached HEAD' '
 	git checkout HEAD^{} &&
 	test_when_finished git checkout - &&
-	echo "fatal: could not set upstream of HEAD to main when it does not point to any branch." >expect &&
+	echo "fatal: could not set upstream of HEAD to main when it does not point to any branch" >expect &&
 	test_must_fail git branch --set-upstream-to main 2>err &&
 	test_cmp expect err
 '
@@ -990,7 +990,7 @@ test_expect_success 'use --set-upstream-to modify a particular branch' '
 '
 
 test_expect_success '--unset-upstream should fail if given a non-existent branch' '
-	echo "fatal: Branch '"'"'i-dont-exist'"'"' has no upstream information" >expect &&
+	echo "fatal: branch '"'"'i-dont-exist'"'"' has no upstream information" >expect &&
 	test_must_fail git branch --unset-upstream i-dont-exist 2>err &&
 	test_cmp expect err
 '
@@ -1012,7 +1012,7 @@ test_expect_success 'test --unset-upstream on HEAD' '
 	test_must_fail git config branch.main.remote &&
 	test_must_fail git config branch.main.merge &&
 	# fail for a branch without upstream set
-	echo "fatal: Branch '"'"'main'"'"' has no upstream information" >expect &&
+	echo "fatal: branch '"'"'main'"'"' has no upstream information" >expect &&
 	test_must_fail git branch --unset-upstream 2>err &&
 	test_cmp expect err
 '
@@ -1026,7 +1026,7 @@ test_expect_success '--unset-upstream should fail on multiple branches' '
 test_expect_success '--unset-upstream should fail on detached HEAD' '
 	git checkout HEAD^{} &&
 	test_when_finished git checkout - &&
-	echo "fatal: could not unset upstream of HEAD when it does not point to any branch." >expect &&
+	echo "fatal: could not unset upstream of HEAD when it does not point to any branch" >expect &&
 	test_must_fail git branch --unset-upstream 2>err &&
 	test_cmp expect err
 '
diff --git a/t/t3202-show-branch.sh b/t/t3202-show-branch.sh
index ea7cfd1951..23cf87e550 100755
--- a/t/t3202-show-branch.sh
+++ b/t/t3202-show-branch.sh
@@ -10,7 +10,7 @@ GIT_TEST_DATE_NOW=1251660000; export GIT_TEST_DATE_NOW
 test_expect_success 'error descriptions on empty repository' '
 	current=$(git branch --show-current) &&
 	cat >expect <<-EOF &&
-	error: No commit on branch '\''$current'\'' yet.
+	error: no commit on branch '\''$current'\'' yet
 	EOF
 	test_must_fail git branch --edit-description 2>actual &&
 	test_cmp expect actual &&
@@ -21,7 +21,7 @@ test_expect_success 'error descriptions on empty repository' '
 test_expect_success 'fatal descriptions on empty repository' '
 	current=$(git branch --show-current) &&
 	cat >expect <<-EOF &&
-	fatal: No commit on branch '\''$current'\'' yet.
+	fatal: no commit on branch '\''$current'\'' yet
 	EOF
 	test_must_fail git branch --set-upstream-to=non-existent 2>actual &&
 	test_cmp expect actual &&
@@ -199,7 +199,7 @@ EOF
 
 test_expect_success 'error descriptions on non-existent branch' '
 	cat >expect <<-EOF &&
-	error: No branch named '\''non-existent'\'.'
+	error: no branch named '\''non-existent'\''
 	EOF
 	test_must_fail git branch --edit-description non-existent 2>actual &&
 	test_cmp expect actual
@@ -213,7 +213,7 @@ test_expect_success 'fatal descriptions on non-existent branch' '
 	test_cmp expect actual &&
 
 	cat >expect <<-EOF &&
-	fatal: No branch named '\''non-existent'\''.
+	fatal: no branch named '\''non-existent'\''
 	EOF
 	test_must_fail git branch -c non-existent new-branch 2>actual &&
 	test_cmp expect actual &&
-- 
2.38.1.432.ga6559ae16c
