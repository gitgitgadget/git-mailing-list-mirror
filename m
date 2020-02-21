Return-Path: <SRS0=3Brp=4J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C48C11D24
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 03:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98ACD20722
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 03:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iwAXWBzt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729548AbgBUDKo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 22:10:44 -0500
Received: from mail-pj1-f74.google.com ([209.85.216.74]:42532 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729413AbgBUDKo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 22:10:44 -0500
Received: by mail-pj1-f74.google.com with SMTP id hi12so141258pjb.7
        for <git@vger.kernel.org>; Thu, 20 Feb 2020 19:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/VVOUmS0GcKvPaa8r0+tH0pTTs76Ux41JhvW1JX0zxM=;
        b=iwAXWBzt+fkQ6Ko/c0xQJQBmEQL0Zq30SO6WLEnf5IFGVhriDhRzIzbYgIi4lkAkkV
         fivRyuGxBEL2ZgV65K10+HzD1kKk1XZMekUjlMjjvc3x1KbyWgNPIJFIYodZGQlFxrhs
         YltRC75qrRmOCjY0L+dWjoOfZry59kymlPVxwV5RWcD+Q9R6KYGj3HL1Ww326clItUDf
         ZdYNUsqKrfiDsOadfk/geM949ciI/0z9oB7FVvAAC8XL5+Est3GY1zX+CvRShjZv0quc
         6OVP/3Tv5oz+KnL/LnRCAJ1hia5d21MHB1m8+bOSghZs1VSa0+kt/kL5Z7fS42cbvTtM
         RnTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/VVOUmS0GcKvPaa8r0+tH0pTTs76Ux41JhvW1JX0zxM=;
        b=pgKE1aw98UarQ1nrkLPr3prOD+ywnYyd30+eyJjADttCF8GWmqVcrP+wFUSuqZMr/R
         AvH+mhK29FlEmKrzQxvEcQ9pYFCOo4GECQ3v3KEBlMW4qFZQKblqz1fGkUT8sJ5Km7k4
         NOdg3P6DHviK6zhZZ/Htcm8meBqhx68VHqLmEDV0U3jGQE7px26wWAK0jP4uJaALfiJq
         ByCSeabL5WFHjl6Y6K5QRjBzJQq1lkJCHvPLvBjGUPLoarxVwM73157c4qvXy9bc8usH
         yoBiQTjTLciuQ5/xj/I7AcNk+dp5w8A/By4HVA0QRztBFe0vVHvJNkfyvtQGgJTb/4J3
         nsHg==
X-Gm-Message-State: APjAAAXcbxHlw9wQPX8IhuzRmZU+IO7D+xofw7rTV83vL22EtLWNOg0f
        jmyo4g2Z4sx3oVArTDE+ILJstgsPHafGxdAyweBAHvIH0XF354U3rgc8nvWdCttFJactTN6hZ3c
        vnvFNgiuy/ERMYLGKAe+NVG7HJhopYNa9efhqmQuF6aFeJ/asXKcb4rHw3pICIgCRMlW33LMHYQ
        ==
X-Google-Smtp-Source: APXvYqx2Zm8UvDGcOCgB/KGA43dosaWbxKYNqYpyesIGIwaHtfiMoiWpDCLv2HbCVJ8S021Nw179Wq8/wQEjQwDGv8k=
X-Received: by 2002:a63:5f4e:: with SMTP id t75mr35601319pgb.7.1582254642115;
 Thu, 20 Feb 2020 19:10:42 -0800 (PST)
Date:   Thu, 20 Feb 2020 19:10:27 -0800
In-Reply-To: <20200221031027.204486-1-emilyshaffer@google.com>
Message-Id: <20200221031027.204486-3-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200221031027.204486-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v3 2/2] clone: pass --single-branch during --recurse-submodules
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
cloned only one branch. Pipe --single-branch through the submodule
helper framework to make it to 'clone' later on.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/git-submodule.txt    |  6 +++++-
 builtin/clone.c                    |  5 +++++
 builtin/submodule--helper.c        | 21 ++++++++++++++++++---
 git-submodule.sh                   | 10 +++++++++-
 t/t5617-clone-submodules-remote.sh | 13 ++++++++++++-
 5 files changed, 49 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 218942acd1..c9ed2bf3d5 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -133,7 +133,7 @@ If you really want to remove a submodule from the repository and commit
 that use linkgit:git-rm[1] instead. See linkgit:gitsubmodules[7] for removal
 options.
 
-update [--init] [--remote] [-N|--no-fetch] [--[no-]recommend-shallow] [-f|--force] [--checkout|--rebase|--merge] [--reference <repository>] [--depth <depth>] [--recursive] [--jobs <n>] [--] [<path>...]::
+update [--init] [--remote] [-N|--no-fetch] [--[no-]recommend-shallow] [-f|--force] [--checkout|--rebase|--merge] [--reference <repository>] [--depth <depth>] [--recursive] [--jobs <n>] [--[no-]single-branch] [--] [<path>...]::
 +
 --
 Update the registered submodules to match what the superproject
@@ -430,6 +430,10 @@ options carefully.
 	Clone new submodules in parallel with as many jobs.
 	Defaults to the `submodule.fetchJobs` option.
 
+--[no-]single-branch::
+	This option is only valid for the update command.
+	Clone only one branch during update: HEAD or one specified by --branch.
+
 <path>...::
 	Paths to submodule(s). When specified this will restrict the command
 	to only operate on the submodules found at the specified paths.
diff --git a/builtin/clone.c b/builtin/clone.c
index 4f6150c55c..1ad26f4d8c 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -833,6 +833,11 @@ static int checkout(int submodule_progress)
 			argv_array_push(&args, "--no-fetch");
 		}
 
+		if (option_single_branch >= 0)
+			argv_array_push(&args, option_single_branch ?
+					       "--single-branch" :
+					       "--no-single-branch");
+
 		err = run_command_v_opt(args.argv, RUN_GIT_CMD);
 		argv_array_clear(&args);
 	}
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 1737a91890..11c38369bd 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1235,7 +1235,7 @@ static int module_deinit(int argc, const char **argv, const char *prefix)
 
 static int clone_submodule(const char *path, const char *gitdir, const char *url,
 			   const char *depth, struct string_list *reference, int dissociate,
-			   int quiet, int progress)
+			   int quiet, int progress, int single_branch)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 
@@ -1257,6 +1257,10 @@ static int clone_submodule(const char *path, const char *gitdir, const char *url
 		argv_array_push(&cp.args, "--dissociate");
 	if (gitdir && *gitdir)
 		argv_array_pushl(&cp.args, "--separate-git-dir", gitdir, NULL);
+	if (single_branch >= 0)
+		argv_array_push(&cp.args, single_branch ?
+					  "--single-branch" :
+					  "--no-single-branch");
 
 	argv_array_push(&cp.args, "--");
 	argv_array_push(&cp.args, url);
@@ -1383,6 +1387,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	struct string_list reference = STRING_LIST_INIT_NODUP;
 	int dissociate = 0, require_init = 0;
 	char *sm_alternate = NULL, *error_strategy = NULL;
+	int single_branch = -1;
 
 	struct option module_clone_options[] = {
 		OPT_STRING(0, "prefix", &prefix,
@@ -1410,12 +1415,15 @@ static int module_clone(int argc, const char **argv, const char *prefix)
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
@@ -1448,7 +1456,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 		prepare_possible_alternates(name, &reference);
 
 		if (clone_submodule(path, sm_gitdir, url, depth, &reference, dissociate,
-				    quiet, progress))
+				    quiet, progress, single_branch))
 			die(_("clone of '%s' into submodule path '%s' failed"),
 			    url, path);
 	} else {
@@ -1572,6 +1580,7 @@ struct submodule_update_clone {
 	const char *depth;
 	const char *recursive_prefix;
 	const char *prefix;
+	int single_branch;
 
 	/* to be consumed by git-submodule.sh */
 	struct update_clone_data *update_clone;
@@ -1591,10 +1600,10 @@ struct submodule_update_clone {
 	.update = SUBMODULE_UPDATE_STRATEGY_INIT, \
 	.recommend_shallow = -1, \
 	.references = STRING_LIST_INIT_DUP, \
+	.single_branch = -1, \
 	.max_jobs = 1 \
 }
 
-
 static void next_submodule_warn_missing(struct submodule_update_clone *suc,
 		struct strbuf *out, const char *displaypath)
 {
@@ -1731,6 +1740,10 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 		argv_array_push(&child->args, "--dissociate");
 	if (suc->depth)
 		argv_array_push(&child->args, suc->depth);
+	if (suc->single_branch >= 0)
+		argv_array_push(&child->args, suc->single_branch ?
+					      "--single-branch" :
+					      "--no-single-branch");
 
 cleanup:
 	strbuf_reset(&displaypath_sb);
@@ -1910,6 +1923,8 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 			    N_("force cloning progress")),
 		OPT_BOOL(0, "require-init", &suc.require_init,
 			   N_("disallow cloning into non-empty directory")),
+		OPT_BOOL(0, "single-branch", &suc.single_branch,
+			 N_("clone only one branch, HEAD or --branch")),
 		OPT_END()
 	};
 
diff --git a/git-submodule.sh b/git-submodule.sh
index afcb4c0948..89f915cae9 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -10,7 +10,7 @@ USAGE="[--quiet] [--cached]
    or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] init [--] [<path>...]
    or: $dashless [--quiet] deinit [-f|--force] (--all| [--] <path>...)
-   or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--[no-]recommend-shallow] [--reference <repository>] [--recursive] [--] [<path>...]
+   or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--[no-]recommend-shallow] [--reference <repository>] [--recursive] [--[no-]single-branch] [--] [<path>...]
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
@@ -528,6 +529,12 @@ cmd_update()
 		--jobs=*)
 			jobs=$1
 			;;
+		--single-branch)
+			single_branch="--single-branch"
+			;;
+		--no-single-branch)
+			single_branch="--no-single-branch"
+			;;
 		--)
 			shift
 			break
@@ -557,6 +564,7 @@ cmd_update()
 		${dissociate:+"--dissociate"} \
 		${depth:+--depth "$depth"} \
 		${require_init:+--require-init} \
+		$single_branch \
 		$recommend_shallow \
 		$jobs \
 		-- \
diff --git a/t/t5617-clone-submodules-remote.sh b/t/t5617-clone-submodules-remote.sh
index 37fcce9c40..1a041df10b 100755
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
+		git rev-parse --verify origin/master &&
+		test_must_fail git rev-parse --verify origin/other
+	)
+'
+
 test_done
-- 
2.25.0.265.gbab2e86ba0-goog

