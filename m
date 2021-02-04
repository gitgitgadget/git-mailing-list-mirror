Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA76BC433DB
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 03:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 993D764F5F
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 03:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234299AbhBDDcU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 22:32:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbhBDDcR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 22:32:17 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8E0C061573
        for <git@vger.kernel.org>; Wed,  3 Feb 2021 19:31:36 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id o10so5071751wmc.1
        for <git@vger.kernel.org>; Wed, 03 Feb 2021 19:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=fIyMjwLYEqvu0wSrGKJ715m9Fb8qkWOTfw+RvHNSLZc=;
        b=o8Gi2IK1UDysetH1OuD4S6R0HRE6f0VsPyN9Qgap2rHP9SjuQgbJCIQY4Ng6AiNGKU
         0mXHJuXjUIhOC0LJZ2zG4vfBZwvFQ7YSfgzhsOC7El4L1mPomgyG0zvZxXHo9TdRQ8dL
         hvFi10tYNWrgC7ZujXdiFlpEiz9JnK+sIwCaxedjoY7N6C5LSvXDLSR6VNrqQVvHXRLX
         gUNz+rW0XEm75zFLDyOo+XksiUbfMtuk2KVQFXxusljNg6nvU9vWwMhYmmmGQFYswgAs
         1a+VzUefZHE0sTBVeuknH3cPF0T4Gpddk3jiByRm5meupPCHxXxzGYIMu7q+OP4OiCPV
         d02g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fIyMjwLYEqvu0wSrGKJ715m9Fb8qkWOTfw+RvHNSLZc=;
        b=Pg7zuwwvOR03IY1weKrhi3Og0HAvr/Ev91n+BLsApkeEAUTrjgy/KgR3ekeS0fDYKu
         NsjhrysV7qAVatySe3HJeYSu50k1qFheRgLznwFPnX94iR3LTf4v/6JKdty1KRCuSflg
         5xSj93nIX234Vo7j3vZh+oCHW0b2WaiRnBplwkZxQGD121kfTZONGHXDn9pu8+FnNYhK
         EJfSmB87BuNXR1S3Kjvc5WJvZLXqExx+gcNqbv58YKBlyJteTHTbL4OxVrwbgeHcnW70
         YdeNwn/PKqERb7tbmVnyNI3+r4+ovYFo0KniChhbzOkJtJuARfRml0L20vL2cJVZVYo7
         j+gw==
X-Gm-Message-State: AOAM5309XQFB6PXVS0ZZ7ANw2gDW7RPQ39RzoioViztSgMYnpXvKAl+f
        8a4H0f4tYJzjT3sHz92DorvTfFY4nqk=
X-Google-Smtp-Source: ABdhPJwBFqo4hcwtySDwdmiRpBZhYYbXKRsOBEDYnGHoEKixgOBKL0uJEHPUVw6uZNG6YQ5vv3lt9A==
X-Received: by 2002:a1c:1fca:: with SMTP id f193mr4801891wmf.102.1612409493452;
        Wed, 03 Feb 2021 19:31:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l14sm6350257wrq.87.2021.02.03.19.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 19:31:32 -0800 (PST)
Message-Id: <pull.865.git.1612409491842.gitgitgadget@gmail.com>
From:   "Li Linchao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 04 Feb 2021 03:31:31 +0000
Subject: [PATCH] builtin/clone.c: add --no-shallow option
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

This patch add a new option that reject to clone a shallow repository.
Clients don't know it's a shallow repository until they download it
locally, in some scenariors, clients just don't want to clone this kind
of repository, and want to exit the process immediately without creating
any unnecessary files.

Signed-off-by: lilinchao <lilinchao@oschina.cn>
---
    builtin/clone.c: add --no-shallow option
    
    This patch add a new option that reject to clone a shallow repository.
    Clients don't know it's a shallow repository until they download it
    locally, in some scenariors, clients just don't want to clone this kind
    of repository, and want to exit the process immediately without creating
    any unnecessary files.
    
    Signed-off-by: lilinchao lilinchao@oschina.cn

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-865%2FCactusinhand%2Fgit-clone-options-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-865/Cactusinhand/git-clone-options-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/865

 Documentation/config/clone.txt |  3 +++
 Documentation/git-clone.txt    |  8 +++++++-
 builtin/clone.c                | 13 +++++++++++++
 t/t5606-clone-options.sh       |  7 +++++++
 t/t5611-clone-config.sh        |  7 +++++++
 5 files changed, 37 insertions(+), 1 deletion(-)
 mode change 100644 => 100755 builtin/clone.c

diff --git a/Documentation/config/clone.txt b/Documentation/config/clone.txt
index 47de36a5fedf..29b779b8a825 100644
--- a/Documentation/config/clone.txt
+++ b/Documentation/config/clone.txt
@@ -2,3 +2,6 @@ clone.defaultRemoteName::
 	The name of the remote to create when cloning a repository.  Defaults to
 	`origin`, and can be overridden by passing the `--origin` command-line
 	option to linkgit:git-clone[1].
+
+clone.rejectshallow::
+	Reject to clone a repository if it is a shallow one.
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 876aedcd472a..94bc76702757 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -15,7 +15,7 @@ SYNOPSIS
 	  [--dissociate] [--separate-git-dir <git dir>]
 	  [--depth <depth>] [--[no-]single-branch] [--no-tags]
 	  [--recurse-submodules[=<pathspec>]] [--[no-]shallow-submodules]
-	  [--[no-]remote-submodules] [--jobs <n>] [--sparse]
+	  [--[no-]remote-submodules] [--jobs <n>] [--sparse] [--no-shallow]
 	  [--filter=<filter>] [--] <repository>
 	  [<directory>]
 
@@ -145,6 +145,12 @@ objects from the source repository into a pack in the cloned repository.
 --no-checkout::
 	No checkout of HEAD is performed after the clone is complete.
 
+--no-shallow::
+	Don't clone a shallow source repository. In some scenariors, clients
+	want the cloned repository information to be complete. Otherwise,
+	the cloning process should end immediately without creating any files,
+	which can save some disk space.
+
 --bare::
 	Make a 'bare' Git repository.  That is, instead of
 	creating `<directory>` and placing the administrative
diff --git a/builtin/clone.c b/builtin/clone.c
old mode 100644
new mode 100755
index e335734b4cfd..b07d867e6641
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -50,6 +50,7 @@ static int option_no_checkout, option_bare, option_mirror, option_single_branch
 static int option_local = -1, option_no_hardlinks, option_shared;
 static int option_no_tags;
 static int option_shallow_submodules;
+static int option_no_shallow;
 static int deepen;
 static char *option_template, *option_depth, *option_since;
 static char *option_origin = NULL;
@@ -90,6 +91,7 @@ static struct option builtin_clone_options[] = {
 	OPT__VERBOSITY(&option_verbosity),
 	OPT_BOOL(0, "progress", &option_progress,
 		 N_("force progress reporting")),
+	OPT_BOOL(0, "no-shallow", &option_no_shallow, N_("don't clone shallow repository")),
 	OPT_BOOL('n', "no-checkout", &option_no_checkout,
 		 N_("don't create a checkout")),
 	OPT_BOOL(0, "bare", &option_bare, N_("create a bare repository")),
@@ -858,6 +860,9 @@ static int git_clone_config(const char *k, const char *v, void *cb)
 		free(remote_name);
 		remote_name = xstrdup(v);
 	}
+	if (!strcmp(k, "clone.rejectshallow")) {
+		option_no_shallow = 1;
+	}
 	return git_default_config(k, v, cb);
 }
 
@@ -963,6 +968,7 @@ static int path_exists(const char *path)
 int cmd_clone(int argc, const char **argv, const char *prefix)
 {
 	int is_bundle = 0, is_local;
+	int is_shallow = 0;
 	const char *repo_name, *repo, *work_tree, *git_dir;
 	char *path, *dir, *display_repo = NULL;
 	int dest_exists, real_dest_exists = 0;
@@ -1215,6 +1221,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		if (filter_options.choice)
 			warning(_("--filter is ignored in local clones; use file:// instead."));
 		if (!access(mkpath("%s/shallow", path), F_OK)) {
+			is_shallow = 1;
 			if (option_local > 0)
 				warning(_("source repository is shallow, ignoring --local"));
 			is_local = 0;
@@ -1222,6 +1229,12 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	}
 	if (option_local > 0 && !is_local)
 		warning(_("--local is ignored"));
+
+	if (is_shallow) {
+		if (option_no_shallow)
+			die(_("source repository is shallow, reject to clone."));
+	}
+
 	transport->cloning = 1;
 
 	transport_set_option(transport, TRANS_OPT_KEEP, "yes");
diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
index 7f082fb23b6a..9d310dbb158a 100755
--- a/t/t5606-clone-options.sh
+++ b/t/t5606-clone-options.sh
@@ -42,6 +42,13 @@ test_expect_success 'disallows --bare with --separate-git-dir' '
 
 '
 
+test_expect_success 'reject clone shallow repository' '
+	git clone --depth=1 --no-local parent shallow-repo &&
+	test_must_fail git clone --no-shallow shallow-repo out 2>err &&
+	test_i18ngrep -e "source repository is shallow, reject to clone." err
+
+'
+
 test_expect_success 'uses "origin" for default remote name' '
 
 	git clone parent clone-default-origin &&
diff --git a/t/t5611-clone-config.sh b/t/t5611-clone-config.sh
index 8e0fd398236b..3aab86ad4def 100755
--- a/t/t5611-clone-config.sh
+++ b/t/t5611-clone-config.sh
@@ -92,6 +92,13 @@ test_expect_success 'clone -c remote.<remote>.fetch=<refspec> --origin=<name>' '
 	test_cmp expect actual
 '
 
+test_expect_success 'clone -c clone.rejectshallow' '
+	rm -rf child &&
+	git clone --depth=1 --no-local . child &&
+	test_must_fail git clone -c clone.rejectshallow child out 2>err &&
+	test_i18ngrep -e "source repository is shallow, reject to clone." err
+'
+
 test_expect_success MINGW 'clone -c core.hideDotFiles' '
 	test_commit attributes .gitattributes "" &&
 	rm -rf child &&

base-commit: 72c4083ddf91b489b7b7b812df67ee8842177d98
-- 
gitgitgadget
