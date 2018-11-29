Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07E4B211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 21:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbeK3JGO (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Nov 2018 04:06:14 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37522 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbeK3JGN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Nov 2018 04:06:13 -0500
Received: by mail-lj1-f194.google.com with SMTP id e5-v6so3165602lja.4
        for <git@vger.kernel.org>; Thu, 29 Nov 2018 13:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pQB4m/QdW9WH6C2Fmg0RlHRysMK7NnTTak9ont9S4w0=;
        b=QhZfSEHSbMt50xWZgjRrFu/451YtoN4bFC7PFQPYuBHuQP5Shpa8p4fjY0VDpK65xA
         C+4WKJUW0F2vYo9dg8SXegYRw1L9MFYGUqjKaqFsZ044XDOJDx15OyHecgM6jv0S/V8r
         FAbwF6jK4+pZ39h2+iJ3+3glxGs+PPHCYqtnUj2UAlFV2FEX74c4bgDwYRovTdp0IJkZ
         BPNCIzVdivkL+7qnu+Jtkk77vZiw8X6othdfL0QsyORTQY0kCb9k8zoiGfCUNo8guLJN
         xCq3+Ultqgxc7Ukxt7r60iV039/hJE3v7iNwJXur0rVz0OLJv3eqXslPKvmM6qIBVuUf
         BR5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pQB4m/QdW9WH6C2Fmg0RlHRysMK7NnTTak9ont9S4w0=;
        b=fPmQJ4Qa1IYRkJPyhjN+scJeEQJDWPR9ydp1G41PHDO9YAT6EbIASUMk4UoC8BrVVd
         inHP8AaqUjVXlV5x3N5/3E11qXN3p1/FOUpOBE9HQXMb+UfeI1Hsk31v27iCgymrzej6
         kXwZcqiKBsw8EVgXrymzHqTmCqG8UwFa48IpquvGK99UW3nlWTjY870IAruvY8DbEwuh
         GbeZyicy0qfDEilHrz3bjZvzxb1W4LCGwRqDIxDRrldXLIrh4a4QQk62KY9pGBG9oO3w
         uivXiFbLt+hCQ8lMdhShhRihjV5rVT9yg1ubemEcWx9ZI4VqcAt0UoqyhXN4xyTX3W/e
         aXYw==
X-Gm-Message-State: AA+aEWbUbtg0lEnWlnUa4ntDw12Hy+XWf3JjEV7HvmMpd4MsVeWLLvsx
        +4IEaVZe2l0joczVQs9yRjk=
X-Google-Smtp-Source: AFSGD/VwIoUE7vyD7zKb1k0IMBfmnnKIB6r8p8VtbPxtm2J/8/mgeieac5dIbDW3yRIqiSC5ltL/hA==
X-Received: by 2002:a2e:2d4:: with SMTP id y81-v6mr2235681lje.62.1543528756800;
        Thu, 29 Nov 2018 13:59:16 -0800 (PST)
Received: from localhost.localdomain (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id o17sm489703lff.77.2018.11.29.13.59.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 13:59:16 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        sbeller@google.com, t.gummerer@gmail.com, sxenos@google.com
Subject: [PATCH v3 04/14] checkout: make "opts" in cmd_checkout() a pointer
Date:   Thu, 29 Nov 2018 22:58:39 +0100
Message-Id: <20181129215850.7278-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.rc1.380.g3eb999425c.dirty
In-Reply-To: <20181129215850.7278-1-pclouds@gmail.com>
References: <20181127165211.24763-1-pclouds@gmail.com>
 <20181129215850.7278-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"opts" will soon be moved out of cmd_checkout(). To keep changes in
that patch smaller, convert "opts" to a pointer and keep the real
thing behind "real_opts".

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 109 +++++++++++++++++++++++----------------------
 1 file changed, 55 insertions(+), 54 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 1887c996c6..1b19328d0a 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1236,76 +1236,77 @@ static int checkout_branch(struct checkout_opts *opts,
 
 int cmd_checkout(int argc, const char **argv, const char *prefix)
 {
-	struct checkout_opts opts;
+	struct checkout_opts real_opts;
+	struct checkout_opts *opts = &real_opts;
 	struct branch_info new_branch_info;
 	char *conflict_style = NULL;
 	int dwim_new_local_branch = 1;
 	int dwim_remotes_matched = 0;
 	struct option options[] = {
-		OPT__QUIET(&opts.quiet, N_("suppress progress reporting")),
-		OPT_STRING('b', NULL, &opts.new_branch, N_("branch"),
+		OPT__QUIET(&opts->quiet, N_("suppress progress reporting")),
+		OPT_STRING('b', NULL, &opts->new_branch, N_("branch"),
 			   N_("create and checkout a new branch")),
-		OPT_STRING('B', NULL, &opts.new_branch_force, N_("branch"),
+		OPT_STRING('B', NULL, &opts->new_branch_force, N_("branch"),
 			   N_("create/reset and checkout a branch")),
-		OPT_BOOL('l', NULL, &opts.new_branch_log, N_("create reflog for new branch")),
-		OPT_BOOL(0, "detach", &opts.force_detach, N_("detach HEAD at named commit")),
-		OPT_SET_INT('t', "track",  &opts.track, N_("set upstream info for new branch"),
+		OPT_BOOL('l', NULL, &opts->new_branch_log, N_("create reflog for new branch")),
+		OPT_BOOL(0, "detach", &opts->force_detach, N_("detach HEAD at named commit")),
+		OPT_SET_INT('t', "track",  &opts->track, N_("set upstream info for new branch"),
 			BRANCH_TRACK_EXPLICIT),
-		OPT_STRING(0, "orphan", &opts.new_orphan_branch, N_("new-branch"), N_("new unparented branch")),
-		OPT_SET_INT_F('2', "ours", &opts.writeout_stage,
+		OPT_STRING(0, "orphan", &opts->new_orphan_branch, N_("new-branch"), N_("new unparented branch")),
+		OPT_SET_INT_F('2', "ours", &opts->writeout_stage,
 			      N_("checkout our version for unmerged files"),
 			      2, PARSE_OPT_NONEG),
-		OPT_SET_INT_F('3', "theirs", &opts.writeout_stage,
+		OPT_SET_INT_F('3', "theirs", &opts->writeout_stage,
 			      N_("checkout their version for unmerged files"),
 			      3, PARSE_OPT_NONEG),
-		OPT__FORCE(&opts.force, N_("force checkout (throw away local modifications)"),
+		OPT__FORCE(&opts->force, N_("force checkout (throw away local modifications)"),
 			   PARSE_OPT_NOCOMPLETE),
-		OPT_BOOL('m', "merge", &opts.merge, N_("perform a 3-way merge with the new branch")),
-		OPT_BOOL_F(0, "overwrite-ignore", &opts.overwrite_ignore,
+		OPT_BOOL('m', "merge", &opts->merge, N_("perform a 3-way merge with the new branch")),
+		OPT_BOOL_F(0, "overwrite-ignore", &opts->overwrite_ignore,
 			   N_("update ignored files (default)"),
 			   PARSE_OPT_NOCOMPLETE),
 		OPT_STRING(0, "conflict", &conflict_style, N_("style"),
 			   N_("conflict style (merge or diff3)")),
-		OPT_BOOL('p', "patch", &opts.patch_mode, N_("select hunks interactively")),
-		OPT_BOOL(0, "ignore-skip-worktree-bits", &opts.ignore_skipworktree,
+		OPT_BOOL('p', "patch", &opts->patch_mode, N_("select hunks interactively")),
+		OPT_BOOL(0, "ignore-skip-worktree-bits", &opts->ignore_skipworktree,
 			 N_("do not limit pathspecs to sparse entries only")),
 		OPT_HIDDEN_BOOL(0, "guess", &dwim_new_local_branch,
 				N_("second guess 'git checkout <no-such-branch>'")),
-		OPT_BOOL(0, "ignore-other-worktrees", &opts.ignore_other_worktrees,
+		OPT_BOOL(0, "ignore-other-worktrees", &opts->ignore_other_worktrees,
 			 N_("do not check if another worktree is holding the given ref")),
 		{ OPTION_CALLBACK, 0, "recurse-submodules", NULL,
 			    "checkout", "control recursive updating of submodules",
 			    PARSE_OPT_OPTARG, option_parse_recurse_submodules_worktree_updater },
-		OPT_BOOL(0, "progress", &opts.show_progress, N_("force progress reporting")),
+		OPT_BOOL(0, "progress", &opts->show_progress, N_("force progress reporting")),
 		OPT_END(),
 	};
 
-	memset(&opts, 0, sizeof(opts));
+	memset(opts, 0, sizeof(*opts));
 	memset(&new_branch_info, 0, sizeof(new_branch_info));
-	opts.overwrite_ignore = 1;
-	opts.prefix = prefix;
-	opts.show_progress = -1;
+	opts->overwrite_ignore = 1;
+	opts->prefix = prefix;
+	opts->show_progress = -1;
 
-	git_config(git_checkout_config, &opts);
+	git_config(git_checkout_config, opts);
 
-	opts.track = BRANCH_TRACK_UNSPECIFIED;
+	opts->track = BRANCH_TRACK_UNSPECIFIED;
 
 	argc = parse_options(argc, argv, prefix, options, checkout_usage,
 			     PARSE_OPT_KEEP_DASHDASH);
 
-	if (opts.show_progress < 0) {
-		if (opts.quiet)
-			opts.show_progress = 0;
+	if (opts->show_progress < 0) {
+		if (opts->quiet)
+			opts->show_progress = 0;
 		else
-			opts.show_progress = isatty(2);
+			opts->show_progress = isatty(2);
 	}
 
 	if (conflict_style) {
-		opts.merge = 1; /* implied */
+		opts->merge = 1; /* implied */
 		git_xmerge_config("merge.conflictstyle", conflict_style, NULL);
 	}
 
-	if ((!!opts.new_branch + !!opts.new_branch_force + !!opts.new_orphan_branch) > 1)
+	if ((!!opts->new_branch + !!opts->new_branch_force + !!opts->new_orphan_branch) > 1)
 		die(_("-b, -B and --orphan are mutually exclusive"));
 
 	/*
@@ -1313,14 +1314,14 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	 * and new_branch_force and new_orphan_branch will tell us which one of
 	 * -b/-B/--orphan is being used.
 	 */
-	if (opts.new_branch_force)
-		opts.new_branch = opts.new_branch_force;
+	if (opts->new_branch_force)
+		opts->new_branch = opts->new_branch_force;
 
-	if (opts.new_orphan_branch)
-		opts.new_branch = opts.new_orphan_branch;
+	if (opts->new_orphan_branch)
+		opts->new_branch = opts->new_orphan_branch;
 
 	/* --track without -b/-B/--orphan should DWIM */
-	if (opts.track != BRANCH_TRACK_UNSPECIFIED && !opts.new_branch) {
+	if (opts->track != BRANCH_TRACK_UNSPECIFIED && !opts->new_branch) {
 		const char *argv0 = argv[0];
 		if (!argc || !strcmp(argv0, "--"))
 			die(_("--track needs a branch name"));
@@ -1329,7 +1330,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		argv0 = strchr(argv0, '/');
 		if (!argv0 || !argv0[1])
 			die(_("missing branch name; try -b"));
-		opts.new_branch = argv0 + 1;
+		opts->new_branch = argv0 + 1;
 	}
 
 	/*
@@ -1348,56 +1349,56 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	if (argc) {
 		struct object_id rev;
 		int dwim_ok =
-			!opts.patch_mode &&
+			!opts->patch_mode &&
 			dwim_new_local_branch &&
-			opts.track == BRANCH_TRACK_UNSPECIFIED &&
-			!opts.new_branch;
+			opts->track == BRANCH_TRACK_UNSPECIFIED &&
+			!opts->new_branch;
 		int n = parse_branchname_arg(argc, argv, dwim_ok,
-					     &new_branch_info, &opts, &rev,
+					     &new_branch_info, opts, &rev,
 					     &dwim_remotes_matched);
 		argv += n;
 		argc -= n;
 	}
 
 	if (argc) {
-		parse_pathspec(&opts.pathspec, 0,
-			       opts.patch_mode ? PATHSPEC_PREFIX_ORIGIN : 0,
+		parse_pathspec(&opts->pathspec, 0,
+			       opts->patch_mode ? PATHSPEC_PREFIX_ORIGIN : 0,
 			       prefix, argv);
 
-		if (!opts.pathspec.nr)
+		if (!opts->pathspec.nr)
 			die(_("invalid path specification"));
 
 		/*
 		 * Try to give more helpful suggestion.
 		 * new_branch && argc > 1 will be caught later.
 		 */
-		if (opts.new_branch && argc == 1)
+		if (opts->new_branch && argc == 1)
 			die(_("'%s' is not a commit and a branch '%s' cannot be created from it"),
-				argv[0], opts.new_branch);
+				argv[0], opts->new_branch);
 
-		if (opts.force_detach)
+		if (opts->force_detach)
 			die(_("git checkout: --detach does not take a path argument '%s'"),
 			    argv[0]);
 
-		if (1 < !!opts.writeout_stage + !!opts.force + !!opts.merge)
+		if (1 < !!opts->writeout_stage + !!opts->force + !!opts->merge)
 			die(_("git checkout: --ours/--theirs, --force and --merge are incompatible when\n"
 			      "checking out of the index."));
 	}
 
-	if (opts.new_branch) {
+	if (opts->new_branch) {
 		struct strbuf buf = STRBUF_INIT;
 
-		if (opts.new_branch_force)
-			opts.branch_exists = validate_branchname(opts.new_branch, &buf);
+		if (opts->new_branch_force)
+			opts->branch_exists = validate_branchname(opts->new_branch, &buf);
 		else
-			opts.branch_exists =
-				validate_new_branchname(opts.new_branch, &buf, 0);
+			opts->branch_exists =
+				validate_new_branchname(opts->new_branch, &buf, 0);
 		strbuf_release(&buf);
 	}
 
 	UNLEAK(opts);
-	if (opts.patch_mode || opts.pathspec.nr) {
-		int ret = checkout_paths(&opts, new_branch_info.name);
+	if (opts->patch_mode || opts->pathspec.nr) {
+		int ret = checkout_paths(opts, new_branch_info.name);
 		if (ret && dwim_remotes_matched > 1 &&
 		    advice_checkout_ambiguous_remote_branch_name)
 			advise(_("'%s' matched more than one remote tracking branch.\n"
@@ -1416,6 +1417,6 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 			       dwim_remotes_matched);
 		return ret;
 	} else {
-		return checkout_branch(&opts, &new_branch_info);
+		return checkout_branch(opts, &new_branch_info);
 	}
 }
-- 
2.20.0.rc1.380.g3eb999425c.dirty

