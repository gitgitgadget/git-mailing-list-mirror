Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 405991F453
	for <e@80x24.org>; Wed, 30 Jan 2019 09:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730254AbfA3JtD (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 04:49:03 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33624 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbfA3JtD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 04:49:03 -0500
Received: by mail-pf1-f194.google.com with SMTP id c123so11202361pfb.0
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 01:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QCPTp1r5EZFNiGyQZ2bCrEBN/03rDLfjxcnzvraacas=;
        b=tv09vVCOCZNHKO1ocYOP0/gJAopVDs4nUm6LuiOjaqSVG8K5oqChlXoiAcoS8prjpO
         Ak8XSBlF440ZUD8t0Yb5FZBs0SU3qg3u7BPHRr6OMNybnCZpXWCxfBmSSTU3tO5/WafF
         fd8gqmhh0nUmKBc0KAuXI2otabd4u4/vPnMGSKCpIDPTG3mLU0wb40r5gNrDN71yzyYp
         Pq8MMpQhsK1jhbppSeaypGFKhKR5pEZFsofIaLg8+dPyUg+AjFFvNONtN9DvgkzzOlgo
         VrPU/avZsrdTn+H7XtyVSyQ4Td8DD7+GA+JTNU+RvBOayWJ8k4QZTkdJT7qPk9qyAzeM
         vXXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QCPTp1r5EZFNiGyQZ2bCrEBN/03rDLfjxcnzvraacas=;
        b=jxKbe6gzJEf868wBgo0xkM12meL6UR96seMJmJt0Kg4jQgNNinQuftmemog4GSiso0
         cGn2P+qfJHqTfQVWwG0/fPdHh/b0Pv1nl491EG9S0wLpImN9WAxGChvQNEah6Oq3QRL4
         yIvNGyWlKVCiKmxwS0aLznbSICpqg/XRZGB1gzGzT5Gaa+g3/mJBaTFOogLG7jzgo8L3
         t0GuiMPvPSQymn8Mjbp3TW0C76gqiUTWHQsoZFk3n6WdfVzaa1gdyB/xbtObl3PzEFGb
         doczglldUQr9esWVOthwI1ZV4FhAlKibffKZsgDgWnQlPoOGYxh3BacRO+ezpfBboEcT
         U4Vg==
X-Gm-Message-State: AJcUukc+BvYF1qVCL2O1Zjq1Pb4wiqPE1pUnT/61fe4YEtduro0Ip4BS
        0P63qDF7F7tEzmelkkA3lfkPjBbc
X-Google-Smtp-Source: ALg8bN5umQeDLZ3Ni05KiPpZRx4VHiwG/WiGQOuter7Kpx9rVeEfkvgVWsjMZQB/tJhRmNkk9VpD+A==
X-Received: by 2002:a62:9913:: with SMTP id d19mr29856073pfe.107.1548841741635;
        Wed, 30 Jan 2019 01:49:01 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id w184sm1346919pgd.34.2019.01.30.01.48.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 01:49:00 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 30 Jan 2019 16:48:57 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 05/19] checkout: make "opts" in cmd_checkout() a pointer
Date:   Wed, 30 Jan 2019 16:48:17 +0700
Message-Id: <20190130094831.10420-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.682.gd5861c6d90
In-Reply-To: <20190130094831.10420-1-pclouds@gmail.com>
References: <20190130094831.10420-1-pclouds@gmail.com>
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
 builtin/checkout.c | 115 +++++++++++++++++++++++----------------------
 1 file changed, 58 insertions(+), 57 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 12b7e08d4e..66f99e788d 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1326,82 +1326,83 @@ static int checkout_branch(struct checkout_opts *opts,
 
 int cmd_checkout(int argc, const char **argv, const char *prefix)
 {
-	struct checkout_opts opts;
+	struct checkout_opts real_opts;
+	struct checkout_opts *opts = &real_opts;
 	struct branch_info new_branch_info;
 	char *conflict_style = NULL;
 	int dwim_new_local_branch, no_dwim_new_local_branch = 0;
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
 		OPT_BOOL(0, "no-guess", &no_dwim_new_local_branch,
 			 N_("do not second guess 'git checkout <no-such-branch>'")),
-		OPT_BOOL(0, "ignore-other-worktrees", &opts.ignore_other_worktrees,
+		OPT_BOOL(0, "ignore-other-worktrees", &opts->ignore_other_worktrees,
 			 N_("do not check if another worktree is holding the given ref")),
 		{ OPTION_CALLBACK, 0, "recurse-submodules", NULL,
 			    "checkout", "control recursive updating of submodules",
 			    PARSE_OPT_OPTARG, option_parse_recurse_submodules_worktree_updater },
-		OPT_BOOL(0, "progress", &opts.show_progress, N_("force progress reporting")),
-		OPT_BOOL(0, "overlay", &opts.overlay_mode, N_("use overlay mode (default)")),
+		OPT_BOOL(0, "progress", &opts->show_progress, N_("force progress reporting")),
+		OPT_BOOL(0, "overlay", &opts->overlay_mode, N_("use overlay mode (default)")),
 		OPT_END(),
 	};
 
-	memset(&opts, 0, sizeof(opts));
+	memset(opts, 0, sizeof(*opts));
 	memset(&new_branch_info, 0, sizeof(new_branch_info));
-	opts.overwrite_ignore = 1;
-	opts.prefix = prefix;
-	opts.show_progress = -1;
-	opts.overlay_mode = -1;
+	opts->overwrite_ignore = 1;
+	opts->prefix = prefix;
+	opts->show_progress = -1;
+	opts->overlay_mode = -1;
 
-	git_config(git_checkout_config, &opts);
+	git_config(git_checkout_config, opts);
 
-	opts.track = BRANCH_TRACK_UNSPECIFIED;
+	opts->track = BRANCH_TRACK_UNSPECIFIED;
 
 	argc = parse_options(argc, argv, prefix, options, checkout_usage,
 			     PARSE_OPT_KEEP_DASHDASH);
 
 	dwim_new_local_branch = !no_dwim_new_local_branch;
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
 
-	if (opts.overlay_mode == 1 && opts.patch_mode)
+	if (opts->overlay_mode == 1 && opts->patch_mode)
 		die(_("-p and --overlay are mutually exclusive"));
 
 	/*
@@ -1409,14 +1410,14 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
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
@@ -1425,7 +1426,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		argv0 = strchr(argv0, '/');
 		if (!argv0 || !argv0[1])
 			die(_("missing branch name; try -b"));
-		opts.new_branch = argv0 + 1;
+		opts->new_branch = argv0 + 1;
 	}
 
 	/*
@@ -1444,56 +1445,56 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
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
@@ -1512,6 +1513,6 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 			       dwim_remotes_matched);
 		return ret;
 	} else {
-		return checkout_branch(&opts, &new_branch_info);
+		return checkout_branch(opts, &new_branch_info);
 	}
 }
-- 
2.20.1.682.gd5861c6d90

