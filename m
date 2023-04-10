Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54974C76196
	for <git@archiver.kernel.org>; Mon, 10 Apr 2023 22:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjDJWwU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Apr 2023 18:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjDJWwQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2023 18:52:16 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0FA1FE0
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 15:52:14 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1a652700c36so31295ad.0
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 15:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1681167133;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QSaFEG8Yb6T8CKmpBjbXJM5O8JI8SHWGrRK4dUnU15M=;
        b=sIf1Rr4c0idNiOgLCYZY0o5lyRPgF6/5k5k25fxBNduEabNN1SADkKKY/TDW0jSEk+
         mHuBby40xTpc2pPZBFKpHHUgCzAFmtS8rdRaw8zsvZ8qRBiXmvnDXKacunxrL5Qzo6MT
         KAA6nsPcQNMMa1hPDQThwUOceRRxV8JeNYcGodG1oRrLRvUeo+WUclNjed3r5KRyouRe
         Peha8NUmVAU962giNvS64aHDZjg3ycSkfcQcr19YD8GOunCE5lSGLH9pADYugr195K+X
         Dn8ia+nKMLxD0N1Si8Y5GTXcyPkDNizyuipwba05g7SLsYamkQVYobS2uKC9Ji9fkIgA
         oTGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681167133;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QSaFEG8Yb6T8CKmpBjbXJM5O8JI8SHWGrRK4dUnU15M=;
        b=gjYJHaGaDUiGMvjzYP6BRSwbBNp3i/VkHv60o6PCitJzb3rGR0T7RY+1ttXiz6QYq+
         U9Bgyu+p8oJVCnbbGUcoTP4I0teupaMcXGNcWf0jr7IV5KOBijCmkmOQ/mQY7cyl5U8q
         23RSe3R8hG52aoNI5yJXX9Iw17mI+kpGPKGPoPENfIJ+3Rr6z1HOJx2sAac52wL8xErf
         e2k7udzbnQZ32/HYD3GlSyPe4cFxvIXCuUGfA3r3fpj4Nko1Fd4Qu32DuJ69JBLKg1YT
         iLvCAyNsk3FWL7iuANB/Hpjk+LGuAzQf9aS7otSaFIGUHK4onFFTVYmyq/L5mQrxrUe8
         dArw==
X-Gm-Message-State: AAQBX9f01CRdT4BxGelSLmN3sajUuCAXr6871vAi7WI1eS/De6P+dLrX
        fGOVM1UMjBWsJ/JVbeMnikVFhtlf5baVxWaxg0CD5Fjf
X-Google-Smtp-Source: AKy350ZuzKqkf0SKF7VuRRHbh1KQ/fXHEcMoyRMXrMrX+alwejMhPlqHOqyGNvn2pKk3zWCXr5vWDQ==
X-Received: by 2002:a17:902:c191:b0:1a5:160f:8581 with SMTP id d17-20020a170902c19100b001a5160f8581mr108512pld.10.1681167133113;
        Mon, 10 Apr 2023 15:52:13 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:202:e06e:1db:d0a:7a9])
        by smtp.gmail.com with ESMTPSA id p15-20020aa7860f000000b005810c4286d6sm8411244pfn.0.2023.04.10.15.52.12
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 15:52:12 -0700 (PDT)
Date:   Mon, 10 Apr 2023 15:52:07 -0700
From:   Emily Shaffer <nasamuffin@google.com>
To:     git@vger.kernel.org
Subject: [PATCH v2] usage: clarify --recurse-submodules as a boolean
Message-ID: <ZDSTFwMFO7vbj/du@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDCWrl4GhgYKYFYG@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`git switch` `git checkout`, `git reset`, and `git read-tree` allow a
user to choose to recurse into submodules. All four of these commands'
short usage seems to indicate that `--recurse-submodules` should take an
argument. In practice, though, all four of these commands parse through
the same callback path:

  option_parse_recurse_submodules_worktree_updater(...) checks for
  set/unset, or passes off to...
  parse_update_recurse_submodules_arg(...), which is a straight handoff
  to...
  parse_update_recurse(...), which only accepts true or false.

So ultimately, it can only be true or false, unlike `git push
--recurse-submodules=<enum>`. A user could provide
`--recurse-submodules=true`, but we don't typically suggest that for
boolean arguments.
(Documentation/git-(switch|checkout|reset|read-tree).txt suggests
--[no-]recurse-submodules, too.)

In fact, these four commands are the only ones that use this codepath -
so there's not any reason for it to be so meandering. However, because
option_parse_recurse_submodules_worktree_updater() modifies static state
in submodule.c, we still need to get a handle to that static state
through a function call.

To preserve the behavior of --recurse-submodules=true and clarify the
usage string simultaneously, get rid of the OPT_CALLBACK_F in favor of a
simple OPT_BOOL, and call a setter in submodule.c for the static state
instead. Also, remove the now-unused
option_parse_recurse_submodules_worktree_updater(),
parse_update_recurse_submodules_arg(), and parse_update_recurse() calls.

Signed-off-by: Emily Shaffer <nasamuffin@google.com>

---

The one thing missing from this patch is tests - especially since the
need for a reroll was predicated on not breaking a specific user edge
case. But I had some trouble finding a good spot, because it seems these
commands weren't explicitly testing the --recurse-submodule flag
anywhere. I'm planning to add them sometime this week, but if someone
beats me to it, or has a suggestion of where to put them, or if Junio
wants to take this patch without them, I won't mind.

Changes since v1:

 - Added translation tag to the usage string at all 3 callsites
 - Took Junio's advice[1] and got rid of the callback interface
   entirely, replacing it with a setter to the static state in
   submodule.c.

By the way, it occurred to me to try and get a handle directly to the
static int and pass that in to OPT_BOOL instead of this overhead. I gave
it a try despite the feeling of poor layering smell, but it turns out
we're saved from having to even consider that, because
RECURSE_SUBMODULES_ON == 2. So no matter what, we will need to take an
extra step to do the conversion from bool (and be careful about setting
when it wasn't explicitly provided, because this static also takes its
value from the config before the option parse happens).

 - Emily

1: https://lore.kernel.org/git/xmqqy1n3fat2.fsf%40gitster.g
---
Range-diff against v1:
1:  c345a44e36 < -:  ---------- usage: clarify --recurse-submodules as a boolean
-:  ---------- > 1:  1ec2a064d2 usage: clarify --recurse-submodules as a boolean

 builtin/checkout.c  | 14 +++++++++++---
 builtin/read-tree.c | 10 +++++++---
 builtin/reset.c     | 10 +++++++---
 submodule-config.c  | 20 --------------------
 submodule-config.h  |  1 -
 submodule.c         | 19 +++++--------------
 submodule.h         |  6 +++---
 7 files changed, 33 insertions(+), 47 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 38a8cd6a96..d105403b0e 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -80,6 +80,7 @@ struct checkout_opts {
 	int ignore_unmerged;
 	int pathspec_file_nul;
 	char *pathspec_from_file;
+	int recurse_submodules;
 
 	const char *new_branch;
 	const char *new_branch_force;
@@ -1587,9 +1588,8 @@ static struct option *add_common_options(struct checkout_opts *opts,
 {
 	struct option options[] = {
 		OPT__QUIET(&opts->quiet, N_("suppress progress reporting")),
-		OPT_CALLBACK_F(0, "recurse-submodules", NULL,
-			    "checkout", "control recursive updating of submodules",
-			    PARSE_OPT_OPTARG, option_parse_recurse_submodules_worktree_updater),
+		OPT_BOOL(0, "recurse-submodules", &opts->recurse_submodules,
+			 N_("control recursive updating of submodules")),
 		OPT_BOOL(0, "progress", &opts->show_progress, N_("force progress reporting")),
 		OPT_BOOL('m', "merge", &opts->merge, N_("perform a 3-way merge with the new branch")),
 		OPT_STRING(0, "conflict", &opts->conflict_style, N_("style"),
@@ -1597,6 +1597,11 @@ static struct option *add_common_options(struct checkout_opts *opts,
 		OPT_END()
 	};
 	struct option *newopts = parse_options_concat(prevopts, options);
+	/*
+	 * we only want to act on --recurse-submodules if it was set explicitly,
+	 * so put it into unset third state.
+	 */
+	opts->recurse_submodules = -1;
 	free(prevopts);
 	return newopts;
 }
@@ -1677,6 +1682,9 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 	argc = parse_options(argc, argv, prefix, options,
 			     usagestr, parseopt_flags);
 
+	if (opts->recurse_submodules >= 0)
+		set_config_update_recurse_submodules(opts->recurse_submodules);
+
 	if (opts->show_progress < 0) {
 		if (opts->quiet)
 			opts->show_progress = 0;
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 600d4f748f..4d325f7481 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -116,6 +116,7 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
 	struct unpack_trees_options opts;
 	int prefix_set = 0;
 	struct lock_file lock_file = LOCK_INIT;
+	int recurse_submodules = -1;
 	const struct option read_tree_options[] = {
 		OPT__SUPER_PREFIX(&opts.super_prefix),
 		OPT_CALLBACK_F(0, "index-output", NULL, N_("file"),
@@ -149,9 +150,8 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
 			 N_("skip applying sparse checkout filter")),
 		OPT_BOOL(0, "debug-unpack", &opts.internal.debug_unpack,
 			 N_("debug unpack-trees")),
-		OPT_CALLBACK_F(0, "recurse-submodules", NULL,
-			    "checkout", "control recursive updating of submodules",
-			    PARSE_OPT_OPTARG, option_parse_recurse_submodules_worktree_updater),
+		OPT_BOOL(0, "recurse-submodules", &recurse_submodules,
+			 N_("control recursive updating of submodules")),
 		OPT__QUIET(&opts.quiet, N_("suppress feedback messages")),
 		OPT_END()
 	};
@@ -177,6 +177,10 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
 	if (opts.reset)
 		opts.reset = UNPACK_RESET_OVERWRITE_UNTRACKED;
 
+	/* only modify the value if set explicitly */
+	if (recurse_submodules >= 0)
+		set_config_update_recurse_submodules(recurse_submodules);
+
 	prepare_repo_settings(the_repository);
 	the_repository->settings.command_requires_full_index = 0;
 
diff --git a/builtin/reset.c b/builtin/reset.c
index 0ed329236c..d67b5ab1e0 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -326,6 +326,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	struct object_id oid;
 	struct pathspec pathspec;
 	int intent_to_add = 0;
+	int recurse_submodules = -1;
 	const struct option options[] = {
 		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
 		OPT_BOOL(0, "no-refresh", &no_refresh,
@@ -339,9 +340,8 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 				N_("reset HEAD, index and working tree"), MERGE),
 		OPT_SET_INT(0, "keep", &reset_type,
 				N_("reset HEAD but keep local changes"), KEEP),
-		OPT_CALLBACK_F(0, "recurse-submodules", NULL,
-			    "reset", "control recursive updating of submodules",
-			    PARSE_OPT_OPTARG, option_parse_recurse_submodules_worktree_updater),
+		OPT_BOOL(0, "recurse-submodules", &recurse_submodules,
+			 N_("control recursive updating of submodules")),
 		OPT_BOOL('p', "patch", &patch_mode, N_("select hunks interactively")),
 		OPT_BOOL('N', "intent-to-add", &intent_to_add,
 				N_("record only the fact that removed paths will be added later")),
@@ -356,6 +356,10 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 						PARSE_OPT_KEEP_DASHDASH);
 	parse_args(&pathspec, argv, prefix, patch_mode, &rev);
 
+	/* only modify the value if set explicitly */
+	if (recurse_submodules >= 0)
+		set_config_update_recurse_submodules(recurse_submodules);
+
 	if (pathspec_from_file) {
 		if (patch_mode)
 			die(_("options '%s' and '%s' cannot be used together"), "--pathspec-from-file", "--patch");
diff --git a/submodule-config.c b/submodule-config.c
index ecf0fcf007..9ef0bdc207 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -338,26 +338,6 @@ int option_fetch_parse_recurse_submodules(const struct option *opt,
 	return 0;
 }
 
-static int parse_update_recurse(const char *opt, const char *arg,
-				int die_on_error)
-{
-	switch (git_parse_maybe_bool(arg)) {
-	case 1:
-		return RECURSE_SUBMODULES_ON;
-	case 0:
-		return RECURSE_SUBMODULES_OFF;
-	default:
-		if (die_on_error)
-			die("bad %s argument: %s", opt, arg);
-		return RECURSE_SUBMODULES_ERROR;
-	}
-}
-
-int parse_update_recurse_submodules_arg(const char *opt, const char *arg)
-{
-	return parse_update_recurse(opt, arg, 1);
-}
-
 static int parse_push_recurse(const char *opt, const char *arg,
 			       int die_on_error)
 {
diff --git a/submodule-config.h b/submodule-config.h
index c2045875bb..fda6ad0162 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -55,7 +55,6 @@ int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg);
 struct option;
 int option_fetch_parse_recurse_submodules(const struct option *opt,
 					  const char *arg, int unset);
-int parse_update_recurse_submodules_arg(const char *opt, const char *arg);
 int parse_push_recurse_submodules_arg(const char *opt, const char *arg);
 void repo_read_gitmodules(struct repository *repo, int skip_if_read);
 void gitmodules_config_oid(const struct object_id *commit_oid);
diff --git a/submodule.c b/submodule.c
index 94644fac0a..8a2a6c8384 100644
--- a/submodule.c
+++ b/submodule.c
@@ -229,21 +229,12 @@ int git_default_submodule_config(const char *var, const char *value,
 	return 0;
 }
 
-int option_parse_recurse_submodules_worktree_updater(const struct option *opt,
-						     const char *arg, int unset)
+void set_config_update_recurse_submodules(int value)
 {
-	if (unset) {
-		config_update_recurse_submodules = RECURSE_SUBMODULES_OFF;
-		return 0;
-	}
-	if (arg)
-		config_update_recurse_submodules =
-			parse_update_recurse_submodules_arg(opt->long_name,
-							    arg);
-	else
-		config_update_recurse_submodules = RECURSE_SUBMODULES_ON;
-
-	return 0;
+	if (value < 0 || value > 1)
+		BUG("config_update_recurse_submodules is a boolean");
+	config_update_recurse_submodules = value ? RECURSE_SUBMODULES_ON
+						 : RECURSE_SUBMODULES_OFF;
 }
 
 /*
diff --git a/submodule.h b/submodule.h
index c55a25ca37..9532d4e073 100644
--- a/submodule.h
+++ b/submodule.h
@@ -51,9 +51,9 @@ void set_diffopt_flags_from_submodule_config(struct diff_options *,
 					     const char *path);
 int git_default_submodule_config(const char *var, const char *value, void *cb);
 
-struct option;
-int option_parse_recurse_submodules_worktree_updater(const struct option *opt,
-						     const char *arg, int unset);
+/* Sets static state 'config_update_recurse_submodules'. 'value' must be 0 or 1. */
+void set_config_update_recurse_submodules(int value);
+
 int is_tree_submodule_active(struct repository *repo,
 			     const struct object_id *treeish_name,
 			     const char *path);
-- 
2.40.0.577.gac1e443424-goog

