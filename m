Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620C3C433DB
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 08:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E744C64E9E
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 08:34:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbhBHIdj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 03:33:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbhBHIdC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Feb 2021 03:33:02 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C6DC06178B
        for <git@vger.kernel.org>; Mon,  8 Feb 2021 00:32:06 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id z6so15984516wrq.10
        for <git@vger.kernel.org>; Mon, 08 Feb 2021 00:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TZJ7xBC0VPiPJ0z8Z0TBuJiQrEJBiOn9tCwmC6RpT/Q=;
        b=CNVpo3oWHT4wJn0PrU2eKSbnpP7bxxj3F8KO/hk32yn1CNlpGuGeCBWlQC5etuIZbP
         Fva5IiRTIopgBdQgXXQnmLhM8VdQed+sGQ4rQs8PrOzqhOJCtTJ9YVmbDL8U+M9ohmP2
         4SuJpbr8ZTNWSKQr6vtyNsBVgl3+MMaS6sTsuMPgItb6TassS8jXQMdYX5eyn3KTYqQk
         qnDZldfoqWJfDDvioxiuiidi5jiSBOSiOypsIVEU3Qj8J3KU/s75xSbIaFneioGmh+xj
         mOfcIlUff/ABKdVIwxvTnqHBMl2aCjuKW3w9QVhBCrYi4C+AyRz89Py9e/k3BX0kmBqr
         hB/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TZJ7xBC0VPiPJ0z8Z0TBuJiQrEJBiOn9tCwmC6RpT/Q=;
        b=SOOHf53oNf1yRVa9IDT7HfmBxDA3upBnpbil5sF+UnSxY6Pb9RVKq4b/H8FD1XVPxK
         HrEFaP6sDm2pblHScJHswdWelwwLusBFTcSIGJezR+1Zvz/J6k626R1hJfplIL+5Hy2V
         LcI5a9w+RHLJijwtMqs40lPlyQvfZBHEkW8FKlmyDFVlavgromhspJ6UvdrNd4u843T1
         uhLqhyl+O9NYgEitGGW+Z1Y48pUCWGpLQl34JjUOdUZZ1rmL9gy5wxJajyFlTw61sUmA
         hjDkcTcyyk3YxI7f6Ye2wJTGUJJMTpJVvNgaH13OdgzHF+5OpU9W7soZqk9oVj/Auv9X
         m4TA==
X-Gm-Message-State: AOAM531Pbv3hGHXOxb7GzkDp/tf+thvFFfFQ5UN3WRT0SiEpL4A39vLi
        s7riJ9tYwDcD3UvPpszBhhNgid7449k=
X-Google-Smtp-Source: ABdhPJyokuVr3CD3H1sm5MCoteT1K4NGjkDWIus18GSFI+yowFcQ6C+wqL6pa5vs30KRirsqpn7xpQ==
X-Received: by 2002:a05:6000:10c5:: with SMTP id b5mr5276355wrx.284.1612773124808;
        Mon, 08 Feb 2021 00:32:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s23sm19641834wmc.29.2021.02.08.00.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 00:32:03 -0800 (PST)
Message-Id: <cfcfc3ec6b3742b4726301346b0c825d09aace8f.1612773119.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.865.v2.git.1612773119.gitgitgadget@gmail.com>
References: <pull.865.git.1612409491842.gitgitgadget@gmail.com>
        <pull.865.v2.git.1612773119.gitgitgadget@gmail.com>
From:   "lilinchao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 08 Feb 2021 08:31:59 +0000
Subject: [PATCH v2 2/2] builtin/clone.c: add --reject-shallow option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        dscho <johannes.schindelin@gmx.de>,
        Li Linchao <lilinchao@oschina.cn>,
        lilinchao <lilinchao@oschina.cn>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: lilinchao <lilinchao@oschina.cn>

In some scenarios, users may want more history than the repository
offered for cloning, which mostly to be a shallow repository, can
give them. But users don't know it is a shallow repository until
they download it to local, users should have the option to refuse
to clone this kind of repository, and may want to exit the process
immediately without creating any unnecessary files.

Althought there is an option '--depth=x' for users to decide how
deep history they can fetch, but as the unshallow cloning's depth
is INFINITY, we can't know exactly the minimun 'x' value that can
satisfy the minimum integrity, so we can't pass 'x' value to --depth,
and expect this can obtain a complete history of a repository.

In other scenarios, given that we have an API that allow us to import
external repository, and then perform various operations on the repo.
But if the imported is a shallow one(which is actually possible), it
will affect the subsequent operations. So we can choose to refuse to
clone, and let's just import an unshallow repository.

This patch offers a new option '--reject-shallow' that can reject to
clone a shallow repository.

Signed-off-by: lilinchao <lilinchao@oschina.cn>
---
 Documentation/config/clone.txt |  3 ++-
 Documentation/git-clone.txt    | 20 ++++++++++++++++----
 builtin/clone.c                | 32 ++++++++++++++++++++++++++------
 t/t5606-clone-options.sh       | 33 +++++++++++++++++++++++++++++++--
 t/t5611-clone-config.sh        | 29 +++++++++++++++++++++++++++--
 5 files changed, 102 insertions(+), 15 deletions(-)
 mode change 100755 => 100644 builtin/clone.c

diff --git a/Documentation/config/clone.txt b/Documentation/config/clone.txt
index 29b779b8a825..50ebc170bb81 100644
--- a/Documentation/config/clone.txt
+++ b/Documentation/config/clone.txt
@@ -4,4 +4,5 @@ clone.defaultRemoteName::
 	option to linkgit:git-clone[1].
 
 clone.rejectshallow::
-	Reject to clone a repository if it is a shallow one.
+	Reject to clone a repository if it is a shallow one, can be overridden by
+	passing option `--reject-shallow` in command line. See linkgit:git-clone[1]
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 9ce6e545577f..af5a97903a05 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -15,7 +15,7 @@ SYNOPSIS
 	  [--dissociate] [--separate-git-dir <git dir>]
 	  [--depth <depth>] [--[no-]single-branch] [--no-tags]
 	  [--recurse-submodules[=<pathspec>]] [--[no-]shallow-submodules]
-	  [--[no-]remote-submodules] [--jobs <n>] [--sparse] [--no-shallow]
+	  [--[no-]remote-submodules] [--jobs <n>] [--sparse] [--reject-shallow]
 	  [--filter=<filter>] [--] <repository>
 	  [<directory>]
 
@@ -149,11 +149,23 @@ objects from the source repository into a pack in the cloned repository.
 --no-checkout::
 	No checkout of HEAD is performed after the clone is complete.
 
---no-shallow::
-	Don't clone a shallow source repository. In some scenariors, clients
+--reject-shallow::
+	Don't clone a shallow source repository. In some scenarios, clients
 	want the cloned repository information to be complete. Otherwise,
 	the cloning process should end immediately without creating any files,
-	which can save some disk space.
+	which can save some disk space. This can override `clone.rejectshallow`
+	from the configuration:
+
+	--------------------------------------------------------------------
+	$ git -c clone.rejectshallow=false clone --reject-shallow source out
+	--------------------------------------------------------------------
+
+	While there is a way to countermand a configured "I always refuse to
+	clone from a shallow repository" with "but let's allow it only this time":
+
+	----------------------------------------------------------------------
+	$ git -c clone.rejectshallow=true clone --no-reject-shallow source out
+	----------------------------------------------------------------------
 
 --bare::
 	Make a 'bare' Git repository.  That is, instead of
diff --git a/builtin/clone.c b/builtin/clone.c
old mode 100755
new mode 100644
index b07d867e6641..a9d49c8e13c2
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -50,7 +50,8 @@ static int option_no_checkout, option_bare, option_mirror, option_single_branch
 static int option_local = -1, option_no_hardlinks, option_shared;
 static int option_no_tags;
 static int option_shallow_submodules;
-static int option_no_shallow;
+static int option_no_shallow = -1;  /* unspecified */
+static int config_shallow = -1;    /* unspecified */
 static int deepen;
 static char *option_template, *option_depth, *option_since;
 static char *option_origin = NULL;
@@ -91,7 +92,8 @@ static struct option builtin_clone_options[] = {
 	OPT__VERBOSITY(&option_verbosity),
 	OPT_BOOL(0, "progress", &option_progress,
 		 N_("force progress reporting")),
-	OPT_BOOL(0, "no-shallow", &option_no_shallow, N_("don't clone shallow repository")),
+	OPT_BOOL(0, "reject-shallow", &option_no_shallow,
+		 N_("don't clone shallow repository")),
 	OPT_BOOL('n', "no-checkout", &option_no_checkout,
 		 N_("don't create a checkout")),
 	OPT_BOOL(0, "bare", &option_bare, N_("create a bare repository")),
@@ -861,7 +863,7 @@ static int git_clone_config(const char *k, const char *v, void *cb)
 		remote_name = xstrdup(v);
 	}
 	if (!strcmp(k, "clone.rejectshallow")) {
-		option_no_shallow = 1;
+		config_shallow = git_config_bool(k, v);
 	}
 	return git_default_config(k, v, cb);
 }
@@ -1211,6 +1213,12 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 	path = get_repo_path(remote->url[0], &is_bundle);
 	is_local = option_local != 0 && path && !is_bundle;
+
+	/* Detect if the remote repository is shallow */
+	if (!access(mkpath("%s/shallow", path), F_OK)) {
+		is_shallow = 1;
+	}
+
 	if (is_local) {
 		if (option_depth)
 			warning(_("--depth is ignored in local clones; use file:// instead."));
@@ -1220,8 +1228,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 			warning(_("--shallow-exclude is ignored in local clones; use file:// instead."));
 		if (filter_options.choice)
 			warning(_("--filter is ignored in local clones; use file:// instead."));
-		if (!access(mkpath("%s/shallow", path), F_OK)) {
-			is_shallow = 1;
+		if (is_shallow) {
 			if (option_local > 0)
 				warning(_("source repository is shallow, ignoring --local"));
 			is_local = 0;
@@ -1231,8 +1238,21 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		warning(_("--local is ignored"));
 
 	if (is_shallow) {
-		if (option_no_shallow)
+		int reject = 0;
+
+		/* If option_no_shallow is specified from CLI option,
+		 * ignore config_shallow from git_clone_config.
+		 */
+
+		if (config_shallow != -1) {
+			reject = config_shallow;
+		}
+		if (option_no_shallow != -1) {
+			reject = option_no_shallow;
+		}
+		if (reject) {
 			die(_("source repository is shallow, reject to clone."));
+		}
 	}
 
 	transport->cloning = 1;
diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
index e9b2bde8be8e..bf007448ad20 100755
--- a/t/t5606-clone-options.sh
+++ b/t/t5606-clone-options.sh
@@ -45,13 +45,42 @@ test_expect_success 'disallows --bare with --separate-git-dir' '
 
 '
 
-test_expect_success 'reject clone shallow repository' '
+test_expect_success 'fail to clone shallow repository' '
 	git clone --depth=1 --no-local parent shallow-repo &&
-	test_must_fail git clone --no-shallow shallow-repo out 2>err &&
+	test_must_fail git clone --reject-shallow shallow-repo out 2>err &&
 	test_i18ngrep -e "source repository is shallow, reject to clone." err
 
 '
 
+test_expect_success 'fail to clone non-local shallow repository' '
+	rm -rf shallow-repo &&
+	git clone --depth=1 --no-local parent shallow-repo &&
+	test_must_fail git clone --reject-shallow --no-local shallow-repo out 2>err &&
+	test_i18ngrep -e "source repository is shallow, reject to clone." err
+
+'
+
+test_expect_success 'clone shallow repository with --no-reject-shallow' '
+	rm -rf shallow-repo &&
+	git clone --depth=1 --no-local parent shallow-repo &&
+	git clone --no-reject-shallow --no-local shallow-repo clone-repo
+
+'
+
+test_expect_success 'clone normal repository with --reject-shallow' '
+	rm -rf clone-repo &&
+	git clone --no-local parent normal-repo &&
+	git clone --reject-shallow --no-local normal-repo clone-repo
+
+'
+
+test_expect_success 'unspecified any configs or options' '
+	rm -rf shallow-repo clone-repo &&
+	git clone --depth=1 --no-local parent shallow-repo &&
+	git clone shallow-repo clone-repo
+
+'
+
 test_expect_success 'uses "origin" for default remote name' '
 
 	git clone parent clone-default-origin &&
diff --git a/t/t5611-clone-config.sh b/t/t5611-clone-config.sh
index 68fdf5b7ce1b..00789d7487d5 100755
--- a/t/t5611-clone-config.sh
+++ b/t/t5611-clone-config.sh
@@ -95,13 +95,38 @@ test_expect_success 'clone -c remote.<remote>.fetch=<refspec> --origin=<name>' '
 	test_cmp expect actual
 '
 
-test_expect_success 'clone -c clone.rejectshallow' '
+test_expect_success 'clone.rejectshallow=true should fail to clone' '
 	rm -rf child &&
 	git clone --depth=1 --no-local . child &&
-	test_must_fail git clone -c clone.rejectshallow child out 2>err &&
+	test_must_fail git -c clone.rejectshallow=true clone --no-local child out 2>err &&
 	test_i18ngrep -e "source repository is shallow, reject to clone." err
 '
 
+test_expect_success 'clone.rejectshallow=false should succeed cloning' '
+	rm -rf child &&
+	git clone --depth=1 --no-local . child &&
+	git -c clone.rejectshallow=false clone --no-local child out
+'
+
+test_expect_success 'clone.rejectshallow=true should succeed cloning normal repo' '
+	rm -rf child out &&
+	git clone --no-local . child &&
+	git -c clone.rejectshallow=true clone --no-local child out
+'
+
+test_expect_success 'option --reject-shallow override clone.rejectshallow' '
+	rm -rf child out &&
+	git clone --depth=1 --no-local . child &&
+	test_must_fail git clone -c clone.rejectshallow=false  --reject-shallow --no-local child out 2>err &&
+	test_i18ngrep -e "source repository is shallow, reject to clone." err
+'
+
+test_expect_success ' option --no-reject-shallow override clone.rejectshallow' '
+	rm -rf child &&
+	git clone --depth=1 --no-local . child &&
+	git -c clone.rejectshallow=true clone --no-reject-shallow --no-local child out
+'
+
 test_expect_success MINGW 'clone -c core.hideDotFiles' '
 	test_commit attributes .gitattributes "" &&
 	rm -rf child &&
-- 
gitgitgadget
