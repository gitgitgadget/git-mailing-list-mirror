Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9232BC433FE
	for <git@archiver.kernel.org>; Sun, 23 Oct 2022 22:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiJWW3u (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Oct 2022 18:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJWW3s (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Oct 2022 18:29:48 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A32424F24
        for <git@vger.kernel.org>; Sun, 23 Oct 2022 15:29:44 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id bk15so13339435wrb.13
        for <git@vger.kernel.org>; Sun, 23 Oct 2022 15:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:subject:from:cc:to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jLmCjE6oHl2Tt7OJ1/HrWwxpSgPLEBkTHhnckzg4qJQ=;
        b=oDtCuDnM0MfBPkTcQhESo4ZEk6C3Eq3xHSuxNL/2EUq5V7R11ZhCc7ex5XdOyddL+s
         44TjC3v128mEan00JkQntCJOTPyrQWKP23z+w3qULTTbDPs5DHzi9f3nlKopJUeW8Ut/
         hIJ2OVrN1h4na+bEqH+KrlMgOqAPqrb1PN0zka5aAUTEiqiSzO8088uDr8XSP+SIILq3
         DsJO36IaGU8vY6hyDmCD91tgHvDvPhjlONXcEWgAsDLsZ8eth3Bl+LDVzh77iRnTGFby
         1SSvk85tQrtHP2oXWynSeRo1Sia0fH6SuZl8rC5N8pB4v5C4oUGqSY72iBoUkOGis/AG
         oNtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:subject:from:cc:to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jLmCjE6oHl2Tt7OJ1/HrWwxpSgPLEBkTHhnckzg4qJQ=;
        b=FhltPkmSusAYOVKcIY6sieL9isSVT9ADiBDEIGuNmOTaNZ1g54jI/IhqBeJnmkYIbr
         PfzEt66ezicP6VNL8frQaEbDqp67xvixYIXL/RNEWu9QpBLYA5BWtoUvrvPea6CEsE8K
         bCvHI31squoewrdQt43z/kOf6/NBtrcGIWWmeiK+9zUiySEpTUKk25C8VuaqhIJp/Oou
         4DUyEsuadYYRdxPb/ihOdNAHO9WHRmjqGlEFNG6CaBZpPGCFoOye4A/2XZ2nGhAOFJaT
         eWJkgoOAc/rp/CzzTeERF/Wpp1aIs319DQDBdtscsTe0II0hU4ng4KucuRrLmfiswN02
         j8aQ==
X-Gm-Message-State: ACrzQf1ifH7lhf7+6xXDapVN39bU4p/9f0gyKSMwVa/7NrubN616ayx7
        byEjWR3n+Z7Jc4H8m0cWDU4=
X-Google-Smtp-Source: AMsMyM45WJuip4Z9pqUBAMZYow6xx8YsCyCKUmH8uUIsHmUou8U1XtqeMeKaFJWYz+tRYZm7mb1VOQ==
X-Received: by 2002:a05:6000:170e:b0:22f:7c62:6251 with SMTP id n14-20020a056000170e00b0022f7c626251mr19012339wrc.679.1666564182245;
        Sun, 23 Oct 2022 15:29:42 -0700 (PDT)
Received: from [192.168.2.52] (138.83-213-116.dynamic.clientes.euskaltel.es. [83.213.116.138])
        by smtp.gmail.com with ESMTPSA id g11-20020a5d488b000000b0022eafed36ebsm24714698wrq.73.2022.10.23.15.29.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Oct 2022 15:29:41 -0700 (PDT)
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Subject: [PATCH] branch: error and informative messages
Message-ID: <3f63d53d-2e14-ffe0-6263-2a15f83453ad@gmail.com>
Date:   Mon, 24 Oct 2022 00:29:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Review die(), error(), warning() and output messages used in branch,
following the guidelines we have in Documentation/CodingGuideLines.
Mainly:
	Error messages

 	 - Do not end error messages with a full stop.

 	 - Do not capitalize the first word, ...

Beside applying this rules, some unneeded messages have been removed and
others reworded to normalize and simplify.

 - Four similar messages has been merged into the most common, the last
   one:
	- "no such branch '%s'"
	- "branch '%s' does not exist"
	- "invalid branch name: '%s'"
	+ "no branch named '%s'"

 - Four specific messages has been reworded and merged:
	- "too many branches for a copy operation"
	- "too many arguments for a rename operation"
	- "too many arguments to set new upstream"
	- "too many arguments to unset upstream"
	+ "too many arguments"

 - Two specific messages has been reworded and merged:
	- "could not set upstream of HEAD to %s when
		it does not point to any branch."
	- "could not unset upstream of HEAD when it
		does not point to any branch."
	+ "cannot modify upstream to detached HEAD"

 - An error message reworded
	- "options '%s' and '%s' cannot be used together",
		"--column", "--verbose"
	+ "options --column and --verbose used together"

 - An error message reworded
	- "The -a, and -r, options to 'git branch' do not take a branch name.\n"
		"Did you mean to use: -a|-r --list <pattern>?"));
	+ "options -a and -r do not take a branch name\n"
		"Did you mean to use: -a|-r --list <pattern>?"));

 - Two error messages not needed, removed:
	- "cannot copy the current branch while not on any."
	- "cannot rename the current branch while not on any."

 - A deprecation message has been reworded, note the '\n':
	- "the '--set-upstream' option is no longer supported."
		"Please use '--track' or '--set-upstream-to' instead."
	+ "option --set-upstream is no longer supported\n"
		"Please use --track or --set-upstream-to instead"

 - "%s" and "'%s'" was used to format a branch name in different
   messages.  "'%s'" has been used to normalize as it's the more
   frequently used in this file and very common in the rest of the
   codebase.  The opposite has been done for options: "-a" used vs
   "'-a'".

A new informative, non-error, message has been introduced for
create_branch:
	+ "New branch '%s' created from '%s'\n"

The tests for the modified messages have been updated and a new test for
the create_branch message has been added.

Finally, let's change the return code on error for --edit-description,
from -1 to 1.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 builtin/branch.c          | 163 ++++++++++++++++----------------------
 t/t1430-bad-ref-name.sh   |  10 +--
 t/t2407-worktree-heads.sh |   2 +-
 t/t3200-branch.sh         |  27 ++++---
 t/t3202-show-branch.sh    |  25 ++----
 5 files changed, 96 insertions(+), 131 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 407517ba68..ca472436f0 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -159,17 +159,13 @@ static int branch_merged(int kind, const char *name,
 	 * any of the following code, but during the transition period,
 	 * a gentle reminder is in order.
 	 */
-	if ((head_rev != reference_rev) &&
-	    in_merge_bases(rev, head_rev) != merged) {
-		if (merged)
-			warning(_("deleting branch '%s' that has been merged to\n"
-				"         '%s', but not yet merged to HEAD."),
-				name, reference_name);
-		else
-			warning(_("not deleting branch '%s' that is not yet merged to\n"
+	if ((head_rev != reference_rev) && in_merge_bases(rev, head_rev) != merged)
+		warning(merged
+			? _("deleting branch '%s' that has been merged to\n"
+				"         '%s', but not yet merged to HEAD.")
+			: _("not deleting branch '%s' that is not yet merged to\n"
 				"         '%s', even though it is merged to HEAD."),
 				name, reference_name);
-	}
 	free(reference_name_to_free);
 	return merged;
 }
@@ -179,16 +175,12 @@ static int check_branch_commit(const char *branchname, const char *refname,
 			       int kinds, int force)
 {
 	struct commit *rev = lookup_commit_reference(the_repository, oid);
-	if (!force && !rev) {
-		error(_("Couldn't look up commit object for '%s'"), refname);
-		return -1;
-	}
-	if (!force && !branch_merged(kinds, branchname, rev, head_rev)) {
-		error(_("The branch '%s' is not fully merged.\n"
+	if (!force && !rev)
+		return error(_("couldn't look up commit object for '%s'"), refname);
+	if (!force && !branch_merged(kinds, branchname, rev, head_rev))
+		return error(_("the branch '%s' is not fully merged\n"
 		      "If you are sure you want to delete it, "
-		      "run 'git branch -D %s'."), branchname, branchname);
-		return -1;
-	}
+		      "run 'git branch -D %s'"), branchname, branchname);
 	return 0;
 }
 
@@ -197,7 +189,7 @@ static void delete_branch_config(const char *branchname)
 	struct strbuf buf = STRBUF_INIT;
 	strbuf_addf(&buf, "branch.%s", branchname);
 	if (git_config_rename_section(buf.buf, NULL) < 0)
-		warning(_("Update of config-file failed"));
+		warning(_("update of config-file failed"));
 	strbuf_release(&buf);
 }
 
@@ -238,7 +230,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 	if (!force) {
 		head_rev = lookup_commit_reference(the_repository, &head_oid);
 		if (!head_rev)
-			die(_("Couldn't look up commit object for HEAD"));
+			die(_("couldn't look up commit object for HEAD"));
 	}
 
 	for (i = 0; i < argc; i++, strbuf_reset(&bname)) {
@@ -252,7 +244,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 		if (kinds == FILTER_REFS_BRANCHES) {
 			const char *path;
 			if ((path = branch_checked_out(name))) {
-				error(_("Cannot delete branch '%s' "
+				error(_("cannot delete branch '%s' "
 					"checked out at '%s'"),
 				      bname.buf, path);
 				ret = 1;
@@ -267,8 +259,8 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
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
@@ -299,8 +291,8 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 			char *refname = name + branch_name_pos;
 			if (!quiet)
 				printf(remote_branch
-					? _("Deleted remote-tracking branch %s (was %s).\n")
-					: _("Deleted branch %s (was %s).\n"),
+					? _("Deleted remote-tracking branch '%s' (was %s)\n")
+					: _("Deleted branch '%s' (was %s)\n"),
 					name + branch_name_pos, describe_ref);
 
 			delete_branch_config(refname);
@@ -501,11 +493,11 @@ static void reject_rebase_or_bisect_branch(const char *target)
 			continue;
 
 		if (is_worktree_being_rebased(wt, target))
-			die(_("Branch %s is being rebased at %s"),
+			die(_("branch '%s' is being rebased at '%s'"),
 			    target, wt->path);
 
 		if (is_worktree_being_bisected(wt, target))
-			die(_("Branch %s is being bisected at %s"),
+			die(_("branch '%s' is being bisected at '%s'"),
 			    target, wt->path);
 	}
 
@@ -520,13 +512,6 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 	const char *interpreted_newname = NULL;
 	int recovery = 0;
 
-	if (!oldname) {
-		if (copy)
-			die(_("cannot copy the current branch while not on any."));
-		else
-			die(_("cannot rename the current branch while not on any."));
-	}
-
 	if (strbuf_check_branch_ref(&oldref, oldname)) {
 		/*
 		 * Bad name --- this could be an attempt to rename a
@@ -535,15 +520,13 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 		if (ref_exists(oldref.buf))
 			recovery = 1;
 		else
-			die(_("Invalid branch name: '%s'"), oldname);
+			die(_("no branch named '%s'"), oldname);
 	}
 
-	if ((copy || strcmp(head, oldname)) && !ref_exists(oldref.buf)) {
-		if (copy && !strcmp(head, oldname))
-			die(_("No commit on branch '%s' yet."), oldname);
-		else
-			die(_("No branch named '%s'."), oldname);
-	}
+	if ((copy || strcmp(head, oldname)) && !ref_exists(oldref.buf))
+		die(copy && !strcmp(head, oldname)
+			? _("no commit on branch '%s' yet")
+			: _("no branch named '%s'"), oldname);
 
 	/*
 	 * A command like "git branch -M currentbranch currentbranch" cannot
@@ -561,32 +544,25 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 		BUG("expected prefix missing for refs");
 	}
 
-	if (copy)
-		strbuf_addf(&logmsg, "Branch: copied %s to %s",
-			    oldref.buf, newref.buf);
-	else
-		strbuf_addf(&logmsg, "Branch: renamed %s to %s",
-			    oldref.buf, newref.buf);
+	strbuf_addf(&logmsg, copy
+		? "Branch: copied %s to %s"
+		: "Branch: renamed %s to %s", oldref.buf, newref.buf);
 
 	if (!copy &&
 	    (!head || strcmp(oldname, head) || !is_null_oid(&head_oid)) &&
 	    rename_ref(oldref.buf, newref.buf, logmsg.buf))
-		die(_("Branch rename failed"));
+		die(_("branch rename failed"));
 	if (copy && copy_existing_ref(oldref.buf, newref.buf, logmsg.buf))
-		die(_("Branch copy failed"));
+		die(_("branch copy failed"));
 
-	if (recovery) {
-		if (copy)
-			warning(_("Created a copy of a misnamed branch '%s'"),
+	if (recovery)
+		warning(copy ? _("created a copy of a misnamed branch '%s'")
+			     : _("renamed a misnamed branch '%s' away"),
 				interpreted_oldname);
-		else
-			warning(_("Renamed a misnamed branch '%s' away"),
-				interpreted_oldname);
-	}
 
 	if (!copy &&
 	    replace_each_worktree_head_symref(oldref.buf, newref.buf, logmsg.buf))
-		die(_("Branch renamed to %s, but HEAD is not updated!"), newname);
+		die(_("branch renamed to '%s', but HEAD is not updated"), newname);
 
 	strbuf_release(&logmsg);
 
@@ -595,9 +571,9 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
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
@@ -715,11 +691,11 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 
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
@@ -740,9 +716,11 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 
 	if (recurse_submodules_explicit) {
 		if (!submodule_propagate_branches)
-			die(_("branch with --recurse-submodules can only be used if submodule.propagateBranches is enabled"));
+			die(_("branch with --recurse-submodules can only be "
+				"used if submodule.propagateBranches is enabled"));
 		if (noncreate_actions)
-			die(_("--recurse-submodules can only be used to create branches"));
+			die(_("--recurse-submodules can only be used to "
+				"create branches"));
 	}
 
 	recurse_submodules =
@@ -756,7 +734,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	finalize_colopts(&colopts, -1);
 	if (filter.verbose) {
 		if (explicitly_enable_column(colopts))
-			die(_("options '%s' and '%s' cannot be used together"), "--column", "--verbose");
+			die(_("options --column and --verbose used together"));
 		colopts = 0;
 	}
 
@@ -805,7 +783,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 
 		if (!argc) {
 			if (filter.detached)
-				die(_("Cannot give description to detached HEAD"));
+				die(_("cannot give description to detached HEAD"));
 			branch_name = head;
 		} else if (argc == 1) {
 			strbuf_branchname(&buf, argv[0], INTERPRET_BRANCH_LOCAL);
@@ -816,9 +794,9 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 
 		strbuf_addf(&branch_ref, "refs/heads/%s", branch_name);
 		if (!ref_exists(branch_ref.buf))
-			ret = error((!argc || !strcmp(head, branch_name))
-			      ? _("No commit on branch '%s' yet.")
-			      : _("No branch named '%s'."),
+			error((!argc || !strcmp(head, branch_name))
+			      ? _("no commit on branch '%s' yet")
+			      : _("no branch named '%s'"),
 			      branch_name);
 		else if (!edit_branch_description(branch_name))
 			ret = 0; /* happy */
@@ -835,7 +813,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		else if (argc == 2)
 			copy_or_rename_branch(argv[0], argv[1], 1, copy > 1);
 		else
-			die(_("too many branches for a copy operation"));
+			die(_("too many arguments"));
 	} else if (rename) {
 		if (!argc)
 			die(_("branch name required"));
@@ -844,7 +822,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		else if (argc == 2)
 			copy_or_rename_branch(argv[0], argv[1], 0, rename > 1);
 		else
-			die(_("too many arguments for a rename operation"));
+			die(_("too many arguments"));
 	} else if (new_upstream) {
 		struct branch *branch;
 		struct strbuf buf = STRBUF_INIT;
@@ -855,21 +833,18 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			strbuf_branchname(&buf, argv[0], INTERPRET_BRANCH_LOCAL);
 			branch = branch_get(buf.buf);
 		} else
-			die(_("too many arguments to set new upstream"));
+			die(_("too many arguments"));
 
 		if (!branch) {
 			if (!argc || !strcmp(argv[0], "HEAD"))
-				die(_("could not set upstream of HEAD to %s when "
-				      "it does not point to any branch."),
-				    new_upstream);
-			die(_("no such branch '%s'"), argv[0]);
+				die(_("cannot modify upstream to detached HEAD"));
+			die(_("no branch named '%s'"), argv[0]);
 		}
 
-		if (!ref_exists(branch->refname)) {
-			if (!argc || !strcmp(head, branch->name))
-				die(_("No commit on branch '%s' yet."), branch->name);
-			die(_("branch '%s' does not exist"), branch->name);
-		}
+		if (!ref_exists(branch->refname))
+			die(!argc || !strcmp(head, branch->name)
+				? _("no commit on branch '%s' yet")
+				: _("no branch named '%s'"), branch->name);
 
 		dwim_and_setup_tracking(the_repository, branch->name,
 					new_upstream, BRANCH_TRACK_OVERRIDE,
@@ -885,17 +860,16 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			strbuf_branchname(&buf, argv[0], INTERPRET_BRANCH_LOCAL);
 			branch = branch_get(buf.buf);
 		} else
-			die(_("too many arguments to unset upstream"));
+			die(_("too many arguments"));
 
 		if (!branch) {
 			if (!argc || !strcmp(argv[0], "HEAD"))
-				die(_("could not unset upstream of HEAD when "
-				      "it does not point to any branch."));
-			die(_("no such branch '%s'"), argv[0]);
+				die(_("cannot modify upstream to detached HEAD"));
+			die(_("no branch named '%s'"), argv[0]);
 		}
 
 		if (!branch_has_merge_config(branch))
-			die(_("Branch '%s' has no upstream information"), branch->name);
+			die(_("branch '%s' has no upstream information"), branch->name);
 
 		strbuf_reset(&buf);
 		strbuf_addf(&buf, "branch.%s.remote", branch->name);
@@ -909,20 +883,23 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		const char *start_name = argc == 2 ? argv[1] : head;
 
 		if (filter.kind != FILTER_REFS_BRANCHES)
-			die(_("The -a, and -r, options to 'git branch' do not take a branch name.\n"
-				  "Did you mean to use: -a|-r --list <pattern>?"));
+			die(_("options -a and -r do not take a branch name\n"
+				"Did you mean to use: -a|-r --list <pattern>?"));
 
 		if (track == BRANCH_TRACK_OVERRIDE)
-			die(_("the '--set-upstream' option is no longer supported. Please use '--track' or '--set-upstream-to' instead."));
+			die(_("option --set-upstream is no longer supported\n"
+				"Please use --track or --set-upstream-to instead"));
 
-		if (recurse_submodules) {
+		if (recurse_submodules)
 			create_branches_recursively(the_repository, branch_name,
 						    start_name, NULL, force,
 						    reflog, quiet, track, 0);
-			return 0;
-		}
-		create_branch(the_repository, branch_name, start_name, force, 0,
-			      reflog, quiet, track, 0);
+		else
+			create_branch(the_repository, branch_name, start_name,
+					force, 0, reflog, quiet, track, 0);
+
+		printf(_("New branch '%s' created from '%s'\n"),
+			branch_name, start_name);
 	} else
 		usage_with_options(builtin_branch_usage, options);
 
diff --git a/t/t1430-bad-ref-name.sh b/t/t1430-bad-ref-name.sh
index ff1c967d55..de3249eb9d 100755
--- a/t/t1430-bad-ref-name.sh
+++ b/t/t1430-bad-ref-name.sh
@@ -192,7 +192,7 @@ test_expect_success 'branch -d can delete broken name' '
 	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID REF_SKIP_REFNAME_VERIFICATION &&
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...ref" &&
 	git branch -d broken...ref >output 2>error &&
-	test_i18ngrep "Deleted branch broken...ref (was broken)" output &&
+	test_i18ngrep "Deleted branch '"'"'broken...ref'"'"' (was broken)" output &&
 	test_must_be_empty error &&
 	git branch >output 2>error &&
 	! grep -e "broken\.\.\.ref" error &&
@@ -218,7 +218,7 @@ test_expect_success 'branch -d can delete symref to broken name' '
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/badname" &&
 	git branch -d badname >output 2>error &&
 	test_path_is_missing .git/refs/heads/badname &&
-	test_i18ngrep "Deleted branch badname (was refs/heads/broken\.\.\.ref)" output &&
+	test_i18ngrep "Deleted branch '"'"'badname'"'"' (was refs/heads/broken\.\.\.ref)" output &&
 	test_must_be_empty error
 '
 
@@ -236,7 +236,7 @@ test_expect_success 'branch -d can delete dangling symref to broken name' '
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/badname" &&
 	git branch -d badname >output 2>error &&
 	test_path_is_missing .git/refs/heads/badname &&
-	test_i18ngrep "Deleted branch badname (was refs/heads/broken\.\.\.ref)" output &&
+	test_i18ngrep "Deleted branch '"'"'badname'"'"' (was refs/heads/broken\.\.\.ref)" output &&
 	test_must_be_empty error
 '
 
@@ -265,7 +265,7 @@ test_expect_success 'branch -d can delete symref with broken name' '
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...symref" &&
 	git branch -d broken...symref >output 2>error &&
 	test_path_is_missing .git/refs/heads/broken...symref &&
-	test_i18ngrep "Deleted branch broken...symref (was refs/heads/main)" output &&
+	test_i18ngrep "Deleted branch '"'"'broken...symref'"'"' (was refs/heads/main)" output &&
 	test_must_be_empty error
 '
 
@@ -283,7 +283,7 @@ test_expect_success 'branch -d can delete dangling symref with broken name' '
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...symref" &&
 	git branch -d broken...symref >output 2>error &&
 	test_path_is_missing .git/refs/heads/broken...symref &&
-	test_i18ngrep "Deleted branch broken...symref (was refs/heads/idonotexist)" output &&
+	test_i18ngrep "Deleted branch '"'"'broken...symref'"'"' (was refs/heads/idonotexist)" output &&
 	test_must_be_empty error
 '
 
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
index 7d8edff9c3..326c505c29 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -39,7 +39,10 @@ test_expect_success 'branch -h in broken repository' '
 '
 
 test_expect_success 'git branch abc should create a branch' '
-	git branch abc && test_path_is_file .git/refs/heads/abc
+	git branch abc >actual &&
+	echo "New branch '"'"'abc'"'"' created from '"'"'main'"'"'" >expect &&
+	test_cmp expect actual &&
+	test_path_is_file .git/refs/heads/abc
 '
 
 test_expect_success 'git branch abc should fail when abc exists' '
@@ -716,7 +719,7 @@ EOF
 test_expect_success 'deleting a symref' '
 	git branch target &&
 	git symbolic-ref refs/heads/symref refs/heads/target &&
-	echo "Deleted branch symref (was refs/heads/target)." >expect &&
+	echo "Deleted branch '"'"'symref'"'"' (was refs/heads/target)" >expect &&
 	git branch -d symref >actual &&
 	test_path_is_file .git/refs/heads/target &&
 	test_path_is_missing .git/refs/heads/symref &&
@@ -726,7 +729,7 @@ test_expect_success 'deleting a symref' '
 test_expect_success 'deleting a dangling symref' '
 	git symbolic-ref refs/heads/dangling-symref nowhere &&
 	test_path_is_file .git/refs/heads/dangling-symref &&
-	echo "Deleted branch dangling-symref (was nowhere)." >expect &&
+	echo "Deleted branch '"'"'dangling-symref'"'"' (was nowhere)" >expect &&
 	git branch -d dangling-symref >actual &&
 	test_path_is_missing .git/refs/heads/dangling-symref &&
 	test_cmp expect actual
@@ -735,7 +738,7 @@ test_expect_success 'deleting a dangling symref' '
 test_expect_success 'deleting a self-referential symref' '
 	git symbolic-ref refs/heads/self-reference refs/heads/self-reference &&
 	test_path_is_file .git/refs/heads/self-reference &&
-	echo "Deleted branch self-reference (was refs/heads/self-reference)." >expect &&
+	echo "Deleted branch '"'"'self-reference'"'"' (was refs/heads/self-reference)" >expect &&
 	git branch -d self-reference >actual &&
 	test_path_is_missing .git/refs/heads/self-reference &&
 	test_cmp expect actual
@@ -853,7 +856,7 @@ test_expect_success 'test deleting branch deletes branch config' '
 test_expect_success 'test deleting branch without config' '
 	git branch my7 s &&
 	sha1=$(git rev-parse my7 | cut -c 1-7) &&
-	echo "Deleted branch my7 (was $sha1)." >expect &&
+	echo "Deleted branch '"'"'my7'"'"' (was $sha1)" >expect &&
 	git branch -d my7 >actual 2>&1 &&
 	test_cmp expect actual
 '
@@ -923,7 +926,7 @@ test_expect_success 'simple tracking skips when remote ref is not a branch' '
 '
 
 test_expect_success '--set-upstream-to fails on multiple branches' '
-	echo "fatal: too many arguments to set new upstream" >expect &&
+	echo "fatal: too many arguments" >expect &&
 	test_must_fail git branch --set-upstream-to main a b c 2>err &&
 	test_cmp expect err
 '
@@ -931,13 +934,13 @@ test_expect_success '--set-upstream-to fails on multiple branches' '
 test_expect_success '--set-upstream-to fails on detached HEAD' '
 	git checkout HEAD^{} &&
 	test_when_finished git checkout - &&
-	echo "fatal: could not set upstream of HEAD to main when it does not point to any branch." >expect &&
+	echo "fatal: cannot modify upstream to detached HEAD" >expect &&
 	test_must_fail git branch --set-upstream-to main 2>err &&
 	test_cmp expect err
 '
 
 test_expect_success '--set-upstream-to fails on a missing dst branch' '
-	echo "fatal: branch '"'"'does-not-exist'"'"' does not exist" >expect &&
+	echo "fatal: no branch named '"'"'does-not-exist'"'"'" >expect &&
 	test_must_fail git branch --set-upstream-to main does-not-exist 2>err &&
 	test_cmp expect err
 '
@@ -979,7 +982,7 @@ test_expect_success 'use --set-upstream-to modify a particular branch' '
 '
 
 test_expect_success '--unset-upstream should fail if given a non-existent branch' '
-	echo "fatal: Branch '"'"'i-dont-exist'"'"' has no upstream information" >expect &&
+	echo "fatal: branch '"'"'i-dont-exist'"'"' has no upstream information" >expect &&
 	test_must_fail git branch --unset-upstream i-dont-exist 2>err &&
 	test_cmp expect err
 '
@@ -1001,13 +1004,13 @@ test_expect_success 'test --unset-upstream on HEAD' '
 	test_must_fail git config branch.main.remote &&
 	test_must_fail git config branch.main.merge &&
 	# fail for a branch without upstream set
-	echo "fatal: Branch '"'"'main'"'"' has no upstream information" >expect &&
+	echo "fatal: branch '"'"'main'"'"' has no upstream information" >expect &&
 	test_must_fail git branch --unset-upstream 2>err &&
 	test_cmp expect err
 '
 
 test_expect_success '--unset-upstream should fail on multiple branches' '
-	echo "fatal: too many arguments to unset upstream" >expect &&
+	echo "fatal: too many arguments" >expect &&
 	test_must_fail git branch --unset-upstream a b c 2>err &&
 	test_cmp expect err
 '
@@ -1015,7 +1018,7 @@ test_expect_success '--unset-upstream should fail on multiple branches' '
 test_expect_success '--unset-upstream should fail on detached HEAD' '
 	git checkout HEAD^{} &&
 	test_when_finished git checkout - &&
-	echo "fatal: could not unset upstream of HEAD when it does not point to any branch." >expect &&
+	echo "fatal: cannot modify upstream to detached HEAD" >expect &&
 	test_must_fail git branch --unset-upstream 2>err &&
 	test_cmp expect err
 '
diff --git a/t/t3202-show-branch.sh b/t/t3202-show-branch.sh
index ea7cfd1951..6b4be35e4c 100755
--- a/t/t3202-show-branch.sh
+++ b/t/t3202-show-branch.sh
@@ -9,9 +9,7 @@ GIT_TEST_DATE_NOW=1251660000; export GIT_TEST_DATE_NOW
 
 test_expect_success 'error descriptions on empty repository' '
 	current=$(git branch --show-current) &&
-	cat >expect <<-EOF &&
-	error: No commit on branch '\''$current'\'' yet.
-	EOF
+	echo "error: no commit on branch '"'"'$current'"'"' yet" > expect &&
 	test_must_fail git branch --edit-description 2>actual &&
 	test_cmp expect actual &&
 	test_must_fail git branch --edit-description $current 2>actual &&
@@ -20,9 +18,7 @@ test_expect_success 'error descriptions on empty repository' '
 
 test_expect_success 'fatal descriptions on empty repository' '
 	current=$(git branch --show-current) &&
-	cat >expect <<-EOF &&
-	fatal: No commit on branch '\''$current'\'' yet.
-	EOF
+	echo "fatal: no commit on branch '"'"'$current'"'"' yet" > expect &&
 	test_must_fail git branch --set-upstream-to=non-existent 2>actual &&
 	test_cmp expect actual &&
 	test_must_fail git branch -c new-branch 2>actual &&
@@ -198,23 +194,12 @@ done <<\EOF
 EOF
 
 test_expect_success 'error descriptions on non-existent branch' '
-	cat >expect <<-EOF &&
-	error: No branch named '\''non-existent'\'.'
-	EOF
+	echo "error: no branch named '"'"'non-existent'"'"'" > expect &&
 	test_must_fail git branch --edit-description non-existent 2>actual &&
-	test_cmp expect actual
-'
-
-test_expect_success 'fatal descriptions on non-existent branch' '
-	cat >expect <<-EOF &&
-	fatal: branch '\''non-existent'\'' does not exist
-	EOF
+	test_cmp expect actual &&
+	echo "fatal: no branch named '"'"'non-existent'"'"'" > expect &&
 	test_must_fail git branch --set-upstream-to=non-existent non-existent 2>actual &&
 	test_cmp expect actual &&
-
-	cat >expect <<-EOF &&
-	fatal: No branch named '\''non-existent'\''.
-	EOF
 	test_must_fail git branch -c non-existent new-branch 2>actual &&
 	test_cmp expect actual &&
 	test_must_fail git branch -m non-existent new-branch 2>actual &&
-- 
2.36.1
