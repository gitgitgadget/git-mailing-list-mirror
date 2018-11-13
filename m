Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89A751F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 17:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732141AbeKNDvo (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 22:51:44 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34827 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731673AbeKNDvo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 22:51:44 -0500
Received: by mail-lj1-f193.google.com with SMTP id x85-v6so11650951ljb.2
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 09:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ec7m/NRsDEFnnAFG978khPTbT9uzn5sql8LI5/nvyp0=;
        b=CHJIHBE26LyofLgsc0OrOk6G8AgPArXmm2bSRAmO4Q7F5t6T+wnqvnm5uWJwX/cS37
         FVoA12ZfkhvfGoQ6HRpbtZ1vGgrmtYz1hRp3IzV5VpeJwMEKOMpJ/QxcT+yfPNlQyVc7
         XHBJPR+1YrwI/baxbomGvSR4AKUEiCeszmmEtmhyhyaGlbzbNu8NI3nCSBXlw+fwC1Oc
         Fc/6FadSjg6wRQweAqcROckVmfM3C32henThE2f1dk3gN6BMoqQW8SIdJZg0iyfQytrL
         F2b3PQ4BPen3IIG/TEne05mASn93OBC052iCAoDi1I+Etnt9KhxyLhWBW/jzHllq0roz
         2CXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ec7m/NRsDEFnnAFG978khPTbT9uzn5sql8LI5/nvyp0=;
        b=gcTQiJ+Rsvvi7hp2x0MLCtgQkTyLtyL4dRojWccCV0MaFVa48v+rqs9w2Uv1w/MqmY
         Fq2qt6CMt+UUajTfrSVgYBlg4SoCCxNCUmPN/JMcY0H9/wsRJs15cpIgnfEs32lZOX03
         gtOAKdInBGDpZbfs6UimL6B7JWL3gQ3CbpCf4+C3dT2iw5gGRP2ROIaNgeSPiCWG9WnE
         iRdF2R+wWUhgCL4CxUCRkBkUZbmkFBWNNh3vb9rkUnKkLGKJ2oLJI/i3gfJLtefTXSeX
         3lYRCgoL161ToiJkQ/MgUYClRhcP1tRzjzR3z9fQjBtv5t+URojIeFubmb1vjEZ1la37
         ym6A==
X-Gm-Message-State: AGRZ1gKQKiCMiUa3CMfxn38h1Vd/UX9BSbjtl6ENFGPzW9e2nJiWhZhg
        kbTKMonRJTOjCvEqOm0xtJvHXQX3
X-Google-Smtp-Source: AJdET5egEtPpVWN0/CJMxp8YCCQUyKv8Sn8pdafhOF8YTEMwHTC62dtWczjyw/mSrFMYV16nZISbQA==
X-Received: by 2002:a2e:2281:: with SMTP id i123-v6mr3227763lji.154.1542131552955;
        Tue, 13 Nov 2018 09:52:32 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id j12-v6sm3468887lja.8.2018.11.13.09.52.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 09:52:31 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/1] checkout: disambiguate dwim tracking branches and local files
Date:   Tue, 13 Nov 2018 18:52:26 +0100
Message-Id: <20181113175226.25635-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1318.g5295c6727d
In-Reply-To: <20181113175226.25635-1-pclouds@gmail.com>
References: <20181110120707.25846-1-pclouds@gmail.com>
 <20181113175226.25635-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When checkout dwim is added in [1], it is restricted to only dwim when
certain conditions are met and fall back to default checkout behavior
otherwise. It turns out falling back could be confusing. One of the
conditions to turn

    git checkout frotz

to

    git checkout -b frotz origin/frotz

is that frotz must not exist as a file. But when the user comes to
expect "git checkout frotz" to create the branch "frotz" and there
happens to be a file named "frotz", git's silently reverting "frotz"
file content is not helping. This is reported in Git mailing list [2]
and even used as an example of "Git is bad" elsewhere [3].

We normally try to do the right thing, but when there are multiple
"right things" to do, it's best to leave it to the user to decide.
Check this case, ask the user to to disambiguate:

- "git checkout -- foo" will check out path "foo"
- "git checkout foo --" will dwim and create branch "foo" [4]

For users who do not want dwim, use --no-guess. It's useless in this
particular case because "git checkout --no-guess foo --" will just
fail. But it could be used by scripts.

[1] 70c9ac2f19 (DWIM "git checkout frotz" to "git checkout -b frotz
    origin/frotz" - 2009-10-18)
[2] https://public-inbox.org/git/CACsJy8B2TVr1g+k+eSQ=pBEO3WN4_LtgLo9gpur8X7Z9GOFL_A@mail.gmail.com/
[3] https://news.ycombinator.com/item?id=18230655
[4] a047fafc78 (checkout: allow dwim for branch creation for "git
    checkout $branch --" - 2013-10-18)

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-checkout.txt |  4 ++++
 builtin/checkout.c             | 18 +++++++++++++-----
 t/t2024-checkout-dwim.sh       | 31 +++++++++++++++++++++++++++++++
 t/t9902-completion.sh          |  3 ++-
 4 files changed, 50 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 801de2f764..6acc3d98e7 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -276,6 +276,10 @@ section of linkgit:git-add[1] to learn how to operate the `--patch` mode.
 	Just like linkgit:git-submodule[1], this will detach the
 	submodules HEAD.
 
+--no-guess::
+	Do not attempt to create a branch if a remote tracking branch
+	of the same name exists.
+
 <branch>::
 	Branch to checkout; if it refers to a branch (i.e., a name that,
 	when prepended with "refs/heads/", is a valid ref), then that
diff --git a/builtin/checkout.c b/builtin/checkout.c
index acdafc6e4c..4744e8c0a7 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1079,9 +1079,12 @@ static int parse_branchname_arg(int argc, const char **argv,
 		 */
 		int recover_with_dwim = dwim_new_local_branch_ok;
 
-		if (!has_dash_dash &&
-		    (check_filename(opts->prefix, arg) || !no_wildcard(arg)))
+		int could_be_checkout_paths = !has_dash_dash &&
+			check_filename(opts->prefix, arg);
+
+		if (!has_dash_dash && !no_wildcard(arg))
 			recover_with_dwim = 0;
+
 		/*
 		 * Accept "git checkout foo" and "git checkout foo --"
 		 * as candidates for dwim.
@@ -1094,6 +1097,10 @@ static int parse_branchname_arg(int argc, const char **argv,
 			const char *remote = unique_tracking_name(arg, rev,
 								  dwim_remotes_matched);
 			if (remote) {
+				if (could_be_checkout_paths)
+					die(_("'%s' could be both a local file and a tracking branch.\n"
+					      "Please use -- (and optionally --no-guess) to disambiguate"),
+					    arg);
 				*new_branch = arg;
 				arg = remote;
 				/* DWIMmed to create local branch, case (3).(b) */
@@ -1228,7 +1235,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	struct checkout_opts opts;
 	struct branch_info new_branch_info;
 	char *conflict_style = NULL;
-	int dwim_new_local_branch = 1;
+	int dwim_new_local_branch, no_dwim_new_local_branch = 0;
 	int dwim_remotes_matched = 0;
 	struct option options[] = {
 		OPT__QUIET(&opts.quiet, N_("suppress progress reporting")),
@@ -1258,8 +1265,8 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		OPT_BOOL('p', "patch", &opts.patch_mode, N_("select hunks interactively")),
 		OPT_BOOL(0, "ignore-skip-worktree-bits", &opts.ignore_skipworktree,
 			 N_("do not limit pathspecs to sparse entries only")),
-		OPT_HIDDEN_BOOL(0, "guess", &dwim_new_local_branch,
-				N_("second guess 'git checkout <no-such-branch>'")),
+		OPT_BOOL(0, "no-guess", &no_dwim_new_local_branch,
+			 N_("do not second guess 'git checkout <no-such-branch>'")),
 		OPT_BOOL(0, "ignore-other-worktrees", &opts.ignore_other_worktrees,
 			 N_("do not check if another worktree is holding the given ref")),
 		{ OPTION_CALLBACK, 0, "recurse-submodules", NULL,
@@ -1282,6 +1289,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, options, checkout_usage,
 			     PARSE_OPT_KEEP_DASHDASH);
 
+	dwim_new_local_branch = !no_dwim_new_local_branch;
 	if (opts.show_progress < 0) {
 		if (opts.quiet)
 			opts.show_progress = 0;
diff --git a/t/t2024-checkout-dwim.sh b/t/t2024-checkout-dwim.sh
index 69b6774d10..fa0718c730 100755
--- a/t/t2024-checkout-dwim.sh
+++ b/t/t2024-checkout-dwim.sh
@@ -278,4 +278,35 @@ test_expect_success 'loosely defined local base branch is reported correctly' '
 	test_cmp expect actual
 '
 
+test_expect_success 'reject when arg could be part of dwim branch' '
+	git remote add foo file://non-existent-place &&
+	git update-ref refs/remotes/foo/dwim-arg HEAD &&
+	echo foo >dwim-arg &&
+	git add dwim-arg &&
+	echo bar >dwim-arg &&
+	test_must_fail git checkout dwim-arg &&
+	test_must_fail git rev-parse refs/heads/dwim-arg -- &&
+	grep bar dwim-arg
+'
+
+test_expect_success 'disambiguate dwim branch and checkout path (1)' '
+	git update-ref refs/remotes/foo/dwim-arg1 HEAD &&
+	echo foo >dwim-arg1 &&
+	git add dwim-arg1 &&
+	echo bar >dwim-arg1 &&
+	git checkout -- dwim-arg1 &&
+	test_must_fail git rev-parse refs/heads/dwim-arg1 -- &&
+	grep foo dwim-arg1
+'
+
+test_expect_success 'disambiguate dwim branch and checkout path (2)' '
+	git update-ref refs/remotes/foo/dwim-arg2 HEAD &&
+	echo foo >dwim-arg2 &&
+	git add dwim-arg2 &&
+	echo bar >dwim-arg2 &&
+	git checkout dwim-arg2 -- &&
+	git rev-parse refs/heads/dwim-arg2 -- &&
+	grep bar dwim-arg2
+'
+
 test_done
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 175f83d704..aa92f85230 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1434,7 +1434,8 @@ test_expect_success 'double dash "git checkout"' '
 	--ignore-other-worktrees Z
 	--recurse-submodules Z
 	--progress Z
-	--no-quiet Z
+	--guess Z
+	--no-guess Z
 	--no-... Z
 	EOF
 '
-- 
2.19.1.1318.g5295c6727d

