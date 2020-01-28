Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D21C2D0DB
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 22:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5BE721739
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 22:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wpm7pVez"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgA1WRm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 17:17:42 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:50219 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbgA1WRm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 17:17:42 -0500
Received: by mail-pg1-f202.google.com with SMTP id d129so9458441pgc.17
        for <git@vger.kernel.org>; Tue, 28 Jan 2020 14:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=TrfTtGyNMBHFX3u5yUbwQ6WSoF8Ro25BxMOSU44yCWQ=;
        b=Wpm7pVezllxb43/902g7NVjHZdmeXi8VsAM/6LK02jA5smuEo1dBVaSTnRqGFavI8J
         ZzCrG0WwoBBbP6Aqjz6oJ6kEZ0VFh6YUznGVZc99av3D7TMNSxym4P3papuwiMTt/gpU
         s7iWHZvCEaoKVWLuBFxs03EP7j1e3GQ2PjpFtyqZGFF9PAd6zstzSPfvQmZzq/1AdmmZ
         kn62tgDH2P1N4MhV5reFiGFDh9zxahIJNG1PH+2PH3/MqmNIgrkppML1UAauAkfTVuL/
         iS8ZSkoTGieAU+XPHIxQiPM9Xsi6YhJzeDx9o5BaSrHCKmsK23MdqphZIHXwZioJLCVn
         Gh+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=TrfTtGyNMBHFX3u5yUbwQ6WSoF8Ro25BxMOSU44yCWQ=;
        b=YOCPe0CcgN5/LT5dWzFITWDsSBg4Sogdq4cmDOOvyJWF8Uf+O+I9wFNZ/lpzBRCM0R
         3k35vzK31s+oVyVlkVFOY3nxDcwTEreWcGaI3wOKqQCp52SLidQQI6FLg+8WkRi3t8c4
         FLf7MLHhcvK05QiRQeE34OISQUspt3ebnG6Lxt8e5IH8NktpkdGFDWyx8GGFDoWouQGE
         6hzcxC9Ox1oABKx0pkDNPc8sftj2GSpRQaExh5gE1VykyCsAKtXJZqiOclPQT3AIjFhH
         uoLhouApHqQMlRHRSc3NRKPdUZe0drxOmnraSCwGc/VQgxgAn5yVBIfIyEgRn32ejSgv
         7Tcg==
X-Gm-Message-State: APjAAAV4vNe3ZX3EcWl4MAgSsznk4Zq+PACoYxUfbdQKeWZC+VhqiHLA
        3ONNsjkM+cAui2ilObaLdqXzPYwB0CoHEDoJKwjmXciGVV4+89rtMtEE1cpYIUBbKkW6AX/wOcP
        F1IBt3vXr8Qa57fFS4Ds5mtxzxCpl7UoINTbk/SL/0JLVv+IxpHS9oY0vfMxiakhTTu6L+hhnxQ
        ==
X-Google-Smtp-Source: APXvYqwWaOkiMREIu/iQDmsPC60350dtT3pQXLyCdHyqbKR3AT/5/DhLHbA6D6uX8S3wXZGDnrdpOV/nU6tcvXCq9pU=
X-Received: by 2002:a65:4d0b:: with SMTP id i11mr28320452pgt.340.1580249861757;
 Tue, 28 Jan 2020 14:17:41 -0800 (PST)
Date:   Tue, 28 Jan 2020 14:17:36 -0800
In-Reply-To: <20200108231900.192476-1-emilyshaffer@google.com>
Message-Id: <20200128221736.9217-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v2] clone: pass --single-branch during --recurse-submodules
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously, performing "git clone --recurse-submodules --single-branch"
resulted in submodules cloning all branches even though the superproject
cloned only one branch. Pipe --single-branch through the submodule
helper framework to make it to 'clone' later on.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
Removed references to --branch since v1.

As discussed in the thread for v1 of this patch, in cases when the
submodule commit referenced by the specified superproject branch isn't
the same as the HEAD of the submodule repo known by the server side,
this still works in kind of a non-obvious way. In these cases, first we
fetch the single branch that is the ancestor of the server's HEAD; then
we fetch the commit needed by the superproject (and its ancestry). So
while this change prevents us from fetching *all* branches on clone, it
doesn't necessarily limit us to a single branch as described.

To limit submodules to a single branch on clone, we need to know which
branch we want for each submodule; unfortunately it seems that just
propagating --branch doesn't necessarily help as there's not much
guarantee that the superproject branch name matches the submodule branch
name, or that all submodule branch names are the same. So, we need to
give a little more thought there.

 - Emily

 Documentation/git-submodule.txt    |  6 +++++-
 builtin/clone.c                    |  3 +++
 builtin/submodule--helper.c        | 17 ++++++++++++++---
 git-submodule.sh                   |  7 ++++++-
 t/t5617-clone-submodules-remote.sh | 13 ++++++++++++-
 5 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 5232407f68..10c42b752a 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -133,7 +133,7 @@ If you really want to remove a submodule from the repository and commit
 that use linkgit:git-rm[1] instead. See linkgit:gitsubmodules[7] for removal
 options.
 
-update [--init] [--remote] [-N|--no-fetch] [--[no-]recommend-shallow] [-f|--force] [--checkout|--rebase|--merge] [--reference <repository>] [--depth <depth>] [--recursive] [--jobs <n>] [--] [<path>...]::
+update [--init] [--remote] [-N|--no-fetch] [--[no-]recommend-shallow] [-f|--force] [--checkout|--rebase|--merge] [--reference <repository>] [--depth <depth>] [--recursive] [--jobs <n>] [--single-branch] [--] [<path>...]::
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
index 0fc89ae2b9..ec749a86c1 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -832,6 +832,9 @@ static int checkout(int submodule_progress)
 			argv_array_push(&args, "--no-fetch");
 		}
 
+		if (option_single_branch)
+			argv_array_push(&args, "--single-branch");
+
 		err = run_command_v_opt(args.argv, RUN_GIT_CMD);
 		argv_array_clear(&args);
 	}
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index c72931ecd7..50c9e23db1 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1225,7 +1225,7 @@ static int module_deinit(int argc, const char **argv, const char *prefix)
 
 static int clone_submodule(const char *path, const char *gitdir, const char *url,
 			   const char *depth, struct string_list *reference, int dissociate,
-			   int quiet, int progress)
+			   int quiet, int progress, int single_branch)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 
@@ -1247,6 +1247,8 @@ static int clone_submodule(const char *path, const char *gitdir, const char *url
 		argv_array_push(&cp.args, "--dissociate");
 	if (gitdir && *gitdir)
 		argv_array_pushl(&cp.args, "--separate-git-dir", gitdir, NULL);
+	if (single_branch)
+		argv_array_push(&cp.args, "--single-branch");
 
 	argv_array_push(&cp.args, "--");
 	argv_array_push(&cp.args, url);
@@ -1373,6 +1375,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	struct string_list reference = STRING_LIST_INIT_NODUP;
 	int dissociate = 0, require_init = 0;
 	char *sm_alternate = NULL, *error_strategy = NULL;
+	int single_branch = 0;
 
 	struct option module_clone_options[] = {
 		OPT_STRING(0, "prefix", &prefix,
@@ -1400,12 +1403,15 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 			   N_("force cloning progress")),
 		OPT_BOOL(0, "require-init", &require_init,
 			   N_("disallow cloning into non-empty directory")),
+		OPT_BOOL(0, "single-branch", &single_branch,
+			 N_("clone only one branch, HEAD or --branch")),
 		OPT_END()
 	};
 
 	const char *const git_submodule_helper_usage[] = {
 		N_("git submodule--helper clone [--prefix=<path>] [--quiet] "
 		   "[--reference <repository>] [--name <name>] [--depth <depth>] "
+		   "[--single-branch] "
 		   "--url <url> --path <path>"),
 		NULL
 	};
@@ -1438,7 +1444,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 		prepare_possible_alternates(name, &reference);
 
 		if (clone_submodule(path, sm_gitdir, url, depth, &reference, dissociate,
-				    quiet, progress))
+				    quiet, progress, single_branch))
 			die(_("clone of '%s' into submodule path '%s' failed"),
 			    url, path);
 	} else {
@@ -1562,6 +1568,7 @@ struct submodule_update_clone {
 	const char *depth;
 	const char *recursive_prefix;
 	const char *prefix;
+	int single_branch;
 
 	/* to be consumed by git-submodule.sh */
 	struct update_clone_data *update_clone;
@@ -1578,7 +1585,7 @@ struct submodule_update_clone {
 };
 #define SUBMODULE_UPDATE_CLONE_INIT {0, MODULE_LIST_INIT, 0, \
 	SUBMODULE_UPDATE_STRATEGY_INIT, 0, 0, -1, STRING_LIST_INIT_DUP, 0, 0, \
-	NULL, NULL, NULL, \
+	NULL, NULL, NULL, 0,\
 	NULL, 0, 0, 0, NULL, 0, 0, 1}
 
 
@@ -1718,6 +1725,8 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 		argv_array_push(&child->args, "--dissociate");
 	if (suc->depth)
 		argv_array_push(&child->args, suc->depth);
+	if (suc->single_branch)
+		argv_array_push(&child->args, "--single-branch");
 
 cleanup:
 	strbuf_reset(&displaypath_sb);
@@ -1897,6 +1906,8 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 			    N_("force cloning progress")),
 		OPT_BOOL(0, "require-init", &suc.require_init,
 			   N_("disallow cloning into non-empty directory")),
+		OPT_BOOL(0, "single-branch", &suc.single_branch,
+			 N_("clone only one branch, HEAD or --branch")),
 		OPT_END()
 	};
 
diff --git a/git-submodule.sh b/git-submodule.sh
index aaa1809d24..95f73ab775 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -10,7 +10,7 @@ USAGE="[--quiet] [--cached]
    or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] init [--] [<path>...]
    or: $dashless [--quiet] deinit [-f|--force] (--all| [--] <path>...)
-   or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--[no-]recommend-shallow] [--reference <repository>] [--recursive] [--] [<path>...]
+   or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--[no-]recommend-shallow] [--reference <repository>] [--recursive] [--single-branch] [--] [<path>...]
    or: $dashless [--quiet] set-branch (--default|--branch <branch>) [--] <path>
    or: $dashless [--quiet] set-url [--] <path> <newurl>
    or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
@@ -47,6 +47,7 @@ custom_name=
 depth=
 progress=
 dissociate=
+single_branch=
 
 die_if_unmatched ()
 {
@@ -526,6 +527,9 @@ cmd_update()
 		--jobs=*)
 			jobs=$1
 			;;
+		--single-branch)
+			single_branch=1
+			;;
 		--)
 			shift
 			break
@@ -555,6 +559,7 @@ cmd_update()
 		${dissociate:+"--dissociate"} \
 		${depth:+--depth "$depth"} \
 		${require_init:+--require-init} \
+		${single_branch:+--single-branch} \
 		$recommend_shallow \
 		$jobs \
 		-- \
diff --git a/t/t5617-clone-submodules-remote.sh b/t/t5617-clone-submodules-remote.sh
index 37fcce9c40..67f2b48659 100755
--- a/t/t5617-clone-submodules-remote.sh
+++ b/t/t5617-clone-submodules-remote.sh
@@ -14,7 +14,8 @@ test_expect_success 'setup' '
 		cd sub &&
 		git init &&
 		test_commit subcommit1 &&
-		git tag sub_when_added_to_super
+		git tag sub_when_added_to_super &&
+		git branch other
 	) &&
 	git submodule add "file://$pwd/sub" sub &&
 	git commit -m "add submodule" &&
@@ -51,4 +52,14 @@ test_expect_success 'check the default is --no-remote-submodules' '
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
 test_done
-- 
2.25.0.341.g760bfbb309-goog

