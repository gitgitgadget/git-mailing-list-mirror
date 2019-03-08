Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C4E320248
	for <e@80x24.org>; Fri,  8 Mar 2019 09:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbfCHJ7e (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 04:59:34 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35594 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfCHJ7d (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 04:59:33 -0500
Received: by mail-pf1-f193.google.com with SMTP id j5so13797058pfa.2
        for <git@vger.kernel.org>; Fri, 08 Mar 2019 01:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hxXPn8+w/Rk9e3nxWMN5jDHqQFAGnlH7FSFqPRhLgAE=;
        b=ZPmR1Xtu//j9pfCbV9cRQKwR8SxgGLhPWyOXW7S+r1bM7YEKfU8mnAr+6IKGw5LdYw
         m2jFs5mClsfA1xcLKKTRsIypnsEpSo1ms6LMx7Jzz6nKWeLD9RI6oXDZJJsl4pPAIXWH
         b5eWVSyTVJr9UvrN6mwKIGDJFxdRzEc3P+NJKqG7M/Cnjk8vN5Hh1r9LpQ6pxdR2xHH7
         j2T47hsFWoFlQC/gCTZF5qf/7yafwLmRowFHzE3m1zUpFTpzOlOxGLwiIO8GJTuxly58
         1Ba4wjWLQmRo0vqN4oHxgMr8zLKDGokxroh0JvxyRJ28XFDOKuoJeIFEVZqy+pr+5fpb
         a+Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hxXPn8+w/Rk9e3nxWMN5jDHqQFAGnlH7FSFqPRhLgAE=;
        b=IKu03w7bCwJEeV6j6pzimpc+zIWviFf1OlO9h1x1xdhJD3sUcF9siMXKtULcNV2tow
         T4Fb9EA1FXtrhDTZNGr9CAoNXKj3lJpf2imjBL6pzzkreTJaenFheRrd/1A7Es3zhjNt
         qZHkyFdrLKpuvgPiji4px4Z8krOY/hZ4DpMWd0oK5kCRsvqZ5N43QaRKxyCucyDCKViL
         qTB+62yqJNAhNYynCX2e0CUD53eUkZMAWDUggXHsOCAMdY3dyqFGkx4KXAw3iUeXAUCw
         xe6odT2iiSVViE6EghjVCHEpuzVai1P9YtRwyElox9zUCjPlrO2rgpnvyOqaEXgq6WpF
         R8vA==
X-Gm-Message-State: APjAAAWWVaKIsHxwl66WVRuzUu/98oxIO5lRMs6t+p1YOn4vQjL3Br+e
        FiUUF3eC2Jw4VSmWUUAI9Lc=
X-Google-Smtp-Source: APXvYqzepY1AogUcsQT7eLlgFxVDd23T2BcQJI4MmxQW3X7hSQBD4LamP8/BRKy3s6oqab9e5XT4qA==
X-Received: by 2002:a17:902:8609:: with SMTP id f9mr17913556plo.85.1552039172699;
        Fri, 08 Mar 2019 01:59:32 -0800 (PST)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id s4sm6084272pgc.4.2019.03.08.01.59.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 01:59:32 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 08 Mar 2019 16:59:22 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com
Subject: [PATCH v3 17/21] switch: no implicit dwim, use --guess to dwim
Date:   Fri,  8 Mar 2019 16:57:48 +0700
Message-Id: <20190308095752.8574-18-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc1.337.gdf7f8d0522
In-Reply-To: <20190308095752.8574-1-pclouds@gmail.com>
References: <20190208090401.14793-1-pclouds@gmail.com>
 <20190308095752.8574-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Similar to automatic detach, this behavior could be confusing because
it can sometimes create a new branch without a user asking it to,
especially when the user is still not aware about this feature.

In the future, perhaps we could have a config key to disable these
safety nets and let 'switch' do automatic detach or dwim
again. But that will be opt-in after the user knows what is what. For
now give a short option if you want to use it often.
---
 Documentation/git-checkout.txt | 38 ++++++++++++++++++++--------------
 builtin/checkout.c             | 16 +++++++-------
 2 files changed, 31 insertions(+), 23 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index ac355dc3f3..2b776c1269 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -31,22 +31,13 @@ branch.
 	`<branch>`.
 +
 If `<branch>` is not found but there does exist a tracking branch in
-exactly one remote (call it `<remote>`) with a matching name, treat as
-equivalent to
+exactly one remote (call it `<remote>`) with a matching name and
+`--no-guess` is not specified, treat as equivalent to
 +
 ------------
 $ git checkout -b <branch> --track <remote>/<branch>
 ------------
 +
-If the branch exists in multiple remotes and one of them is named by
-the `checkout.defaultRemote` configuration variable, we'll use that
-one for the purposes of disambiguation, even if the `<branch>` isn't
-unique across all remotes. Set it to
-e.g. `checkout.defaultRemote=origin` to always checkout remote
-branches from there if `<branch>` is ambiguous but exists on the
-'origin' remote. See also `checkout.defaultRemote` in
-linkgit:git-config[1].
-+
 You could omit `<branch>`, in which case the command degenerates to
 "check out the current branch", which is a glorified no-op with
 rather expensive side-effects to show only the tracking information,
@@ -183,6 +174,27 @@ explicitly give a name with `-b` in such a case.
 	Do not set up "upstream" configuration, even if the
 	branch.autoSetupMerge configuration variable is true.
 
+--guess::
+--no-guess::
+	If `<branch>` is not found but there does exist a tracking
+	branch in exactly one remote (call it `<remote>`) with a
+	matching name, treat as equivalent to
++
+------------
+$ git checkout -b <branch> --track <remote>/<branch>
+------------
++
+If the branch exists in multiple remotes and one of them is named by
+the `checkout.defaultRemote` configuration variable, we'll use that
+one for the purposes of disambiguation, even if the `<branch>` isn't
+unique across all remotes. Set it to
+e.g. `checkout.defaultRemote=origin` to always checkout remote
+branches from there if `<branch>` is ambiguous but exists on the
+'origin' remote. See also `checkout.defaultRemote` in
+linkgit:git-config[1].
++
+Use `--no-guess` to disable this.
+
 -l::
 	Create the new branch's reflog; see linkgit:git-branch[1] for
 	details.
@@ -287,10 +299,6 @@ Note that this option uses the no overlay mode by default (see also
 	Just like linkgit:git-submodule[1], this will detach the
 	submodules HEAD.
 
---no-guess::
-	Do not attempt to create a branch if a remote tracking branch
-	of the same name exists.
-
 --overlay::
 --no-overlay::
 	In the default overlay mode, `git checkout` never
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 0866aeba83..8a89df4f36 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -53,7 +53,7 @@ struct checkout_opts {
 	int show_progress;
 	int count_checkout_paths;
 	int overlay_mode;
-	int no_dwim_new_local_branch;
+	int dwim_new_local_branch;
 	int accept_pathspec;
 	int switch_branch_doing_nothing_is_ok;
 
@@ -1403,8 +1403,6 @@ static struct option *add_common_switch_branch_options(
 		OPT_BOOL_F(0, "overwrite-ignore", &opts->overwrite_ignore,
 			   N_("update ignored files (default)"),
 			   PARSE_OPT_NOCOMPLETE),
-		OPT_BOOL(0, "no-guess", &opts->no_dwim_new_local_branch,
-			 N_("second guess 'git checkout <no-such-branch>'")),
 		OPT_BOOL(0, "ignore-other-worktrees", &opts->ignore_other_worktrees,
 			 N_("do not check if another worktree is holding the given ref")),
 		OPT_END()
@@ -1441,7 +1439,6 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 {
 	struct branch_info new_branch_info;
 	int dwim_remotes_matched = 0;
-	int dwim_new_local_branch;
 
 	memset(&new_branch_info, 0, sizeof(new_branch_info));
 	opts->overwrite_ignore = 1;
@@ -1456,7 +1453,6 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 	argc = parse_options(argc, argv, prefix, options, usagestr,
 			     PARSE_OPT_KEEP_DASHDASH);
 
-	dwim_new_local_branch = !opts->no_dwim_new_local_branch;
 	if (opts->show_progress < 0) {
 		if (opts->quiet)
 			opts->show_progress = 0;
@@ -1516,7 +1512,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 		struct object_id rev;
 		int dwim_ok =
 			!opts->patch_mode &&
-			dwim_new_local_branch &&
+			opts->dwim_new_local_branch &&
 			opts->track == BRANCH_TRACK_UNSPECIFIED &&
 			!opts->new_branch;
 		int n = parse_branchname_arg(argc, argv, dwim_ok,
@@ -1597,12 +1593,14 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		OPT_STRING('B', NULL, &opts.new_branch_force, N_("branch"),
 			   N_("create/reset and checkout a branch")),
 		OPT_BOOL('l', NULL, &opts.new_branch_log, N_("create reflog for new branch")),
+		OPT_BOOL(0, "guess", &opts.dwim_new_local_branch,
+			 N_("second guess 'git checkout <no-such-branch>' (default)")),
 		OPT_END()
 	};
 	int ret;
 
 	memset(&opts, 0, sizeof(opts));
-	opts.no_dwim_new_local_branch = 0;
+	opts.dwim_new_local_branch = 1;
 	opts.switch_branch_doing_nothing_is_ok = 1;
 	opts.accept_pathspec = 1;
 	opts.implicit_detach = 1;
@@ -1627,12 +1625,14 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
 			   N_("create and switch to a new branch")),
 		OPT_STRING('C', "force-create", &opts.new_branch_force, N_("branch"),
 			   N_("create/reset and switch to a branch")),
+		OPT_BOOL('g', "guess", &opts.dwim_new_local_branch,
+			 N_("second guess 'git switch <no-such-branch>'")),
 		OPT_END()
 	};
 	int ret;
 
 	memset(&opts, 0, sizeof(opts));
-	opts.no_dwim_new_local_branch = 0;
+	opts.dwim_new_local_branch = 0;
 	opts.accept_pathspec = 0;
 	opts.switch_branch_doing_nothing_is_ok = 0;
 	opts.implicit_detach = 0;
-- 
2.21.0.rc1.337.gdf7f8d0522

