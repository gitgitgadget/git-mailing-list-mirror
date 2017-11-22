Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D9CC20954
	for <e@80x24.org>; Wed, 22 Nov 2017 22:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753015AbdKVWad (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 17:30:33 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36108 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753381AbdKVW2z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 17:28:55 -0500
Received: by mail-wm0-f65.google.com with SMTP id r68so13195928wmr.1
        for <git@vger.kernel.org>; Wed, 22 Nov 2017 14:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GAnHGWk5D1n8CWQ+B2bp+gbN48QPglH4PCSgcBOgL44=;
        b=M/CvoG4VLjjCtoDAV+9RsuOrvDMTqSFIilyAtr98BVXdgYdOlyKG9i5w35kIPnnQlN
         ACAbc/0EnqI5qgAkVTE1fdJHoxcI8LWuKXIuel7urPYx+IR8mqIlzm2m6POabRBl+04r
         iSViMljs6qhHvDI+dNHRk2PMEzwMdRe6PHdQUrJefTZP4uzHMuiWtKsGPTR+LiUKZ8bE
         MR5GNoIgQVy3EISYhOk20P7jwMcCoB5saebyqLokDCdYfUIm9uvGD0JEXeDhDAhGTUpR
         iJBWcTDQEQwCiz6DJUNguqW4i+uYXW+I5YkztZF0pY1rOQgiDJE83Zjzk1MNdZIIkA+L
         vjow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GAnHGWk5D1n8CWQ+B2bp+gbN48QPglH4PCSgcBOgL44=;
        b=Jop1bLgJXE6T7HRHA8LtK4U2cHgdW5iYAte0haEUjmdU7+XOfeX/qIXl/FEv+jYC4u
         +aP5JdvAy/H+pkDSt/PHIhK9YIDyeTRPw3/q2mYZegK1OCvV0hqLSqHyelzSO31988PD
         qMsrcjBJ23SCX8crtTaScI6EiVZfFdkO3yf7JMacpZCE6afM1c3ulrNhjNwZzPXW3w+t
         pElaurRPqkNknC2ZupMgvnUcok7xTVh7vJGRYYgMq6ESllaQB3TK9Q9xhjupnV5scRiI
         qufeC7MZkDUgDPiinFXtop78WEb55h5glXXF2IUYTBFS9MukZUC97JS8K9s6mQr4nxOs
         ZGBw==
X-Gm-Message-State: AJaThX4jSvEQGgOoLkPYias/T+F9D5STXbN+rlMLvahUIm3FiCmWAXyP
        FhBJuVTagn7j0Q+pTxxfmqwE8qAJ
X-Google-Smtp-Source: AGs4zMb5U3tIAbxg1jNxS4qKuCYfC2aglcTYRFDHcaA224cHAKpuD7b0TCKG0LctlupjkjLMHhL8Qg==
X-Received: by 10.28.234.71 with SMTP id i68mr5295807wmh.7.1511389734367;
        Wed, 22 Nov 2017 14:28:54 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id n143sm10434673wmd.31.2017.11.22.14.28.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Nov 2017 14:28:53 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 2/4] worktree: add --[no-]track option to the add subcommand
Date:   Wed, 22 Nov 2017 22:30:18 +0000
Message-Id: <20171122223020.2780-3-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.15.0.345.gf926f18f3
In-Reply-To: <20171122223020.2780-1-t.gummerer@gmail.com>
References: <mailto:20171118224706.13810-1-t.gummerer@gmail.com>
 <20171122223020.2780-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently 'git worktree add' sets up tracking branches if '<branch>' is
a remote tracking branch, and doesn't set them up otherwise, as is the
default for 'git branch'.

This may or may not be what the user wants.  Allow overriding this
behaviour with a --[no-]track flag that gets passed through to 'git
branch'.

We already respect branch.autoSetupMerge, as 'git worktree' just calls
'git branch' internally.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Documentation/git-worktree.txt |  6 +++++
 builtin/worktree.c             |  8 ++++++
 t/t2025-worktree-add.sh        | 55 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 69 insertions(+)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index b472acc356..798a642f84 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -107,6 +107,12 @@ OPTIONS
 	such as configuring sparse-checkout. See "Sparse checkout"
 	in linkgit:git-read-tree[1].
 
+--[no-]track::
+	With `--track` `<branch>` is set as "tracking" branch for
+	`<new-branch>`.  This is the default if `<branch>` is a remote
+	tracking branch, and can be suppressed with `--no-track`.  See
+	also linkgit:git-branch[1].
+
 --lock::
 	Keep the working tree locked after creation. This is the
 	equivalent of `git worktree lock` after `git worktree add`,
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 7b9307aa58..8f9446d43c 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -341,6 +341,7 @@ static int add(int ac, const char **av, const char *prefix)
 	const char *new_branch_force = NULL;
 	char *path;
 	const char *branch;
+	const char *opt_track = NULL;
 	struct option options[] = {
 		OPT__FORCE(&opts.force, N_("checkout <branch> even if already checked out in other worktree")),
 		OPT_STRING('b', NULL, &opts.new_branch, N_("branch"),
@@ -350,6 +351,9 @@ static int add(int ac, const char **av, const char *prefix)
 		OPT_BOOL(0, "detach", &opts.detach, N_("detach HEAD at named commit")),
 		OPT_BOOL(0, "checkout", &opts.checkout, N_("populate the new working tree")),
 		OPT_BOOL(0, "lock", &opts.keep_locked, N_("keep the new working tree locked")),
+		OPT_PASSTHRU(0, "track", &opt_track, NULL,
+			     N_("set up tracking mode (see git-branch(1))"),
+			     PARSE_OPT_NOARG | PARSE_OPT_OPTARG),
 		OPT_END()
 	};
 
@@ -394,9 +398,13 @@ static int add(int ac, const char **av, const char *prefix)
 			argv_array_push(&cp.args, "--force");
 		argv_array_push(&cp.args, opts.new_branch);
 		argv_array_push(&cp.args, branch);
+		if (opt_track)
+			argv_array_push(&cp.args, opt_track);
 		if (run_command(&cp))
 			return -1;
 		branch = opts.new_branch;
+	} else if (opt_track) {
+		die(_("--[no-]track can only be used if a new branch is created"));
 	}
 
 	UNLEAK(path);
diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index b5c47ac602..53042ce565 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -313,5 +313,60 @@ test_expect_success 'checkout a branch under bisect' '
 test_expect_success 'rename a branch under bisect not allowed' '
 	test_must_fail git branch -M under-bisect bisect-with-new-name
 '
+# Is branch "refs/heads/$1" set to pull from "$2/$3"?
+test_branch_upstream () {
+	printf "%s\n" "$2" "refs/heads/$3" >expect.upstream &&
+	{
+		git config "branch.$1.remote" &&
+		git config "branch.$1.merge"
+	} >actual.upstream &&
+	test_cmp expect.upstream actual.upstream
+}
+
+test_expect_success '--track sets up tracking' '
+	test_when_finished rm -rf track &&
+	git worktree add --track -b track track master &&
+	git config "branch.track.merge" &&
+	(
+		test_branch_upstream track . master
+	)
+'
+
+# setup remote repository $1 and repository $2 with $1 set up as
+# remote.  The remote has two branches, master and foo.
+setup_remote_repo () {
+	git init $1 &&
+	(
+		cd $1 &&
+		test_commit $1_master &&
+		git checkout -b foo &&
+		test_commit upstream_foo
+	) &&
+	git init $2 &&
+	(
+		cd $2 &&
+		test_commit $2_master &&
+		git remote add $1 ../$1 &&
+		git config remote.$1.fetch \
+			"refs/heads/*:refs/remotes/$1/*" &&
+		git fetch --all
+	)
+}
+
+test_expect_success '--no-track avoids setting up tracking' '
+	test_when_finished rm -rf repo_upstream repo_local foo &&
+	setup_remote_repo repo_upstream repo_local &&
+	(
+		cd repo_local &&
+		git worktree add --no-track -b foo ../foo repo_upstream/foo
+	) &&
+	(
+		cd foo &&
+		! test_branch_upstream foo repo_upstream foo &&
+		git rev-parse repo_upstream/foo >expect &&
+		git rev-parse foo >actual &&
+		test_cmp expect actual
+	)
+'
 
 test_done
-- 
2.15.0.345.gf926f18f3

