Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9CBC282DD
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 23:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A7CA20705
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 23:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="swZ70NzK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbgAHXTF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jan 2020 18:19:05 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:36178 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgAHXTF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jan 2020 18:19:05 -0500
Received: by mail-pf1-f201.google.com with SMTP id 6so2812955pfv.3
        for <git@vger.kernel.org>; Wed, 08 Jan 2020 15:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=5TjSjTgwzDtl/SzVxReA0Mubl2l7aTXrMbkDVRbJ1kA=;
        b=swZ70NzKk3seeQ4e780an9cJeJXj1eNH9IAyaA3YqbAe+uhhtDIBRXFsYssQd++TO7
         HYQHahd990YM6qe4SMNZYPytQ8adHwN3r+v8DazIB1m9cJsEcO/5jj71nGJYfHvVI3s/
         lGEgIb+EzxjZgEBeOidBQNUOPUZB5h+gjvSE+AsVwH1yaS2aAjl71DdJZ+/JrPb8H9wO
         KoakA236qqdEH77cwKwtPYXqbQTaEw0rrNlZgT1xXySGoIDWylYbYVKzt+l80al2ElFo
         HxWHGAzCLIwLAU/u+Tz1fCWvCeo68oAn6OkJtBhO8QjQK6DwzNj8BoL49z/dyn1ILn2i
         mbAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=5TjSjTgwzDtl/SzVxReA0Mubl2l7aTXrMbkDVRbJ1kA=;
        b=Lw/LMZ3MnrRe3UktbIg2c5vUYOwKhIDaH5LNpSWHH+KfFJARH4sWf8/m7EsiW/2ehc
         OciaNkpZKFSGjw2vD6zS33++dgyWEzr2MryyBlTYs4JWHEHAbSw/ywmV+pfyKa31SVYc
         i8XMFEbzZ3D681c+KVsXijreoJ1P1s2lVfAFxo+Qghp7IEahy1HhYKYLmvofXKxU8Ioj
         74+NLdZP15OGtb5LnhWNnKz0QbjHYsEVlUF47A3OBuVtw414ACsHnvDlUt8MzRT6eAqu
         f5JAAolvYd3xjOzGcptgDCI3S4nZURqL6Cs3ZG4LXZXnKeC0njy1Ruwnp4d2XsHo0eNb
         Ai+A==
X-Gm-Message-State: APjAAAWFLC3aTr5P1mic5y4d+uH8BANyw2xTNmgY4BkT0dmu7acsaV1w
        tFMvpeo6fbQPo1Xll5yxYUbd1pHQi7s49fM0hzBgBTQ7XhQd7fNEEMIH0QMhdu98G3CJ297K0H/
        yGNU2sXYlTGlGvUpdg2oylO09e8tRY7Ig+rzF69gC0nhTd5Heum2TkZTOZf58//tRZFkI9uGmvg
        ==
X-Google-Smtp-Source: APXvYqwewSMm2ix0pV4XPrQTQr7DQUb/5IR+ZJNTPPoVF1zuM5ZrJ03vLM2nVn6WrY/1hOiG1DeLJENHuEFXXEpAwqU=
X-Received: by 2002:a63:5b0a:: with SMTP id p10mr7806763pgb.228.1578525544156;
 Wed, 08 Jan 2020 15:19:04 -0800 (PST)
Date:   Wed,  8 Jan 2020 15:19:00 -0800
Message-Id: <20200108231900.192476-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
Subject: [PATCH] clone: teach --single-branch and --branch during --recurse
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously, performing "git clone --recurse-submodules --single-branch"
resulted in submodules cloning all branches even though the superproject
cloned only one branch. Pipe --single-branch and its friend, --branch,
through the submodule helper framework to make it to 'clone' later on.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
Note that 'branch' was already in use in git-submodules.sh, so
"submodule branch" aka 'sm_branch' was used to disambiguate the two.

 Documentation/git-submodule.txt    |  6 +++++-
 builtin/clone.c                    |  6 ++++++
 builtin/submodule--helper.c        | 28 +++++++++++++++++++++++++---
 git-submodule.sh                   | 17 ++++++++++++++++-
 t/t5617-clone-submodules-remote.sh | 26 ++++++++++++++++++++++++--
 5 files changed, 76 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 22425cbc76..8c516a9670 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -133,7 +133,7 @@ If you really want to remove a submodule from the repository and commit
 that use linkgit:git-rm[1] instead. See linkgit:gitsubmodules[7] for removal
 options.
 
-update [--init] [--remote] [-N|--no-fetch] [--[no-]recommend-shallow] [-f|--force] [--checkout|--rebase|--merge] [--reference <repository>] [--depth <depth>] [--recursive] [--jobs <n>] [--] [<path>...]::
+update [--init] [--remote] [-N|--no-fetch] [--[no-]recommend-shallow] [-f|--force] [--checkout|--rebase|--merge] [--reference <repository>] [--depth <depth>] [--recursive] [--jobs <n>] [--single-branch] [-b|--branch <name>] [--] [<path>...]::
 +
 --
 Update the registered submodules to match what the superproject
@@ -430,6 +430,10 @@ options carefully.
 	Clone new submodules in parallel with as many jobs.
 	Defaults to the `submodule.fetchJobs` option.
 
+--single-branch::
+	This option is only valid for the update command.
+	Clone only one branch during update, HEAD or --branch.
+
 <path>...::
 	Paths to submodule(s). When specified this will restrict the command
 	to only operate on the submodules found at the specified paths.
diff --git a/builtin/clone.c b/builtin/clone.c
index 6dee265cc9..293cef8b30 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -808,6 +808,12 @@ static int checkout(int submodule_progress)
 			argv_array_push(&args, "--no-fetch");
 		}
 
+		if (option_single_branch)
+			argv_array_push(&args, "--single-branch");
+
+		if (option_branch)
+			argv_array_pushf(&args, "--branch=%s", option_branch);
+
 		err = run_command_v_opt(args.argv, RUN_GIT_CMD);
 		argv_array_clear(&args);
 	}
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index c72931ecd7..92bd823d38 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1225,7 +1225,8 @@ static int module_deinit(int argc, const char **argv, const char *prefix)
 
 static int clone_submodule(const char *path, const char *gitdir, const char *url,
 			   const char *depth, struct string_list *reference, int dissociate,
-			   int quiet, int progress)
+			   int quiet, int progress, int single_branch,
+			   const char *branch)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 
@@ -1247,6 +1248,10 @@ static int clone_submodule(const char *path, const char *gitdir, const char *url
 		argv_array_push(&cp.args, "--dissociate");
 	if (gitdir && *gitdir)
 		argv_array_pushl(&cp.args, "--separate-git-dir", gitdir, NULL);
+	if (single_branch)
+		argv_array_push(&cp.args, "--single-branch");
+	if (branch)
+		argv_array_pushl(&cp.args, "--branch", branch, NULL);
 
 	argv_array_push(&cp.args, "--");
 	argv_array_push(&cp.args, url);
@@ -1373,6 +1378,8 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	struct string_list reference = STRING_LIST_INIT_NODUP;
 	int dissociate = 0, require_init = 0;
 	char *sm_alternate = NULL, *error_strategy = NULL;
+	int single_branch = 0;
+	char *branch = NULL;
 
 	struct option module_clone_options[] = {
 		OPT_STRING(0, "prefix", &prefix,
@@ -1400,12 +1407,17 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 			   N_("force cloning progress")),
 		OPT_BOOL(0, "require-init", &require_init,
 			   N_("disallow cloning into non-empty directory")),
+		OPT_BOOL(0, "single-branch", &single_branch,
+			 N_("clone only one branch, HEAD or --branch")),
+		OPT_STRING('b', "branch", &branch, "<branch>",
+			   N_("checkout <branch> instead of the remote's HEAD")),
 		OPT_END()
 	};
 
 	const char *const git_submodule_helper_usage[] = {
 		N_("git submodule--helper clone [--prefix=<path>] [--quiet] "
 		   "[--reference <repository>] [--name <name>] [--depth <depth>] "
+		   "[--single-branch] [-b | --branch <name>] "
 		   "--url <url> --path <path>"),
 		NULL
 	};
@@ -1438,7 +1450,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 		prepare_possible_alternates(name, &reference);
 
 		if (clone_submodule(path, sm_gitdir, url, depth, &reference, dissociate,
-				    quiet, progress))
+				    quiet, progress, single_branch, branch))
 			die(_("clone of '%s' into submodule path '%s' failed"),
 			    url, path);
 	} else {
@@ -1562,6 +1574,8 @@ struct submodule_update_clone {
 	const char *depth;
 	const char *recursive_prefix;
 	const char *prefix;
+	int single_branch;
+	const char *branch;
 
 	/* to be consumed by git-submodule.sh */
 	struct update_clone_data *update_clone;
@@ -1578,7 +1592,7 @@ struct submodule_update_clone {
 };
 #define SUBMODULE_UPDATE_CLONE_INIT {0, MODULE_LIST_INIT, 0, \
 	SUBMODULE_UPDATE_STRATEGY_INIT, 0, 0, -1, STRING_LIST_INIT_DUP, 0, 0, \
-	NULL, NULL, NULL, \
+	NULL, NULL, NULL, 0, NULL,\
 	NULL, 0, 0, 0, NULL, 0, 0, 1}
 
 
@@ -1718,6 +1732,10 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 		argv_array_push(&child->args, "--dissociate");
 	if (suc->depth)
 		argv_array_push(&child->args, suc->depth);
+	if (suc->single_branch)
+		argv_array_push(&child->args, "--single-branch");
+	if (suc->branch)
+		argv_array_pushl(&child->args, "--branch", suc->branch, NULL);
 
 cleanup:
 	strbuf_reset(&displaypath_sb);
@@ -1897,6 +1915,10 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 			    N_("force cloning progress")),
 		OPT_BOOL(0, "require-init", &suc.require_init,
 			   N_("disallow cloning into non-empty directory")),
+		OPT_BOOL(0, "single-branch", &suc.single_branch,
+			 N_("clone only one branch, HEAD or --branch")),
+		OPT_STRING('b', "branch", &suc.branch, "<branch>",
+			   N_("checkout <branch> instead of the remote's HEAD")),
 		OPT_END()
 	};
 
diff --git a/git-submodule.sh b/git-submodule.sh
index aaa1809d24..c2eadbb930 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -10,7 +10,7 @@ USAGE="[--quiet] [--cached]
    or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] init [--] [<path>...]
    or: $dashless [--quiet] deinit [-f|--force] (--all| [--] <path>...)
-   or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--[no-]recommend-shallow] [--reference <repository>] [--recursive] [--] [<path>...]
+   or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--[no-]recommend-shallow] [--reference <repository>] [--recursive] [--single-branch] [-b|--branch <name>] [--] [<path>...]
    or: $dashless [--quiet] set-branch (--default|--branch <branch>) [--] <path>
    or: $dashless [--quiet] set-url [--] <path> <newurl>
    or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
@@ -47,6 +47,8 @@ custom_name=
 depth=
 progress=
 dissociate=
+single_branch=
+sm_branch=
 
 die_if_unmatched ()
 {
@@ -526,6 +528,17 @@ cmd_update()
 		--jobs=*)
 			jobs=$1
 			;;
+		--single-branch)
+			single_branch=1
+			;;
+		-b|--branch)
+			case "$2" in '') usage ;; esac
+			sm_branch="--branch=$2"
+			shift
+			;;
+		-b=*|--branch=*)
+			sm_branch=$1
+			;;
 		--)
 			shift
 			break
@@ -555,6 +568,8 @@ cmd_update()
 		${dissociate:+"--dissociate"} \
 		${depth:+--depth "$depth"} \
 		${require_init:+--require-init} \
+		${single_branch:+--single-branch} \
+		${sm_branch:+"$sm_branch"} \
 		$recommend_shallow \
 		$jobs \
 		-- \
diff --git a/t/t5617-clone-submodules-remote.sh b/t/t5617-clone-submodules-remote.sh
index 37fcce9c40..390645897d 100755
--- a/t/t5617-clone-submodules-remote.sh
+++ b/t/t5617-clone-submodules-remote.sh
@@ -14,14 +14,16 @@ test_expect_success 'setup' '
 		cd sub &&
 		git init &&
 		test_commit subcommit1 &&
-		git tag sub_when_added_to_super
+		git tag sub_when_added_to_super &&
+		git branch other
 	) &&
 	git submodule add "file://$pwd/sub" sub &&
 	git commit -m "add submodule" &&
 	(
 		cd sub &&
 		test_commit subcommit2
-	)
+	) &&
+	git branch other
 '
 
 test_expect_success 'clone with --no-remote-submodules' '
@@ -51,4 +53,24 @@ test_expect_success 'check the default is --no-remote-submodules' '
 	)
 '
 
+test_expect_success 'clone with --single-branch' '
+	test_when_finished "rm -rf super_clone" &&
+	git clone --recurse-submodules --single-branch "file://$pwd/." super_clone &&
+	(
+		cd super_clone/sub &&
+		git branch -a >branches &&
+		test_must_fail grep other branches
+	)
+'
+
+test_expect_success 'clone with --single-branch and --branch' '
+	test_when_finished "rm -rf super_clone" &&
+	git clone --recurse-submodules --single-branch --branch other "file://$pwd/." super_clone &&
+	(
+		cd super_clone/sub &&
+		git branch -a >branches &&
+		test_must_fail grep master branches
+	)
+'
+
 test_done
-- 
2.25.0.rc1.283.g88dfdc4193-goog

