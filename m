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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3855C433EF
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 17:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8572360EB7
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 17:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350328AbhICR4H (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Sep 2021 13:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350285AbhICRz5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Sep 2021 13:55:57 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054B2C0613CF
        for <git@vger.kernel.org>; Fri,  3 Sep 2021 10:54:57 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 192-20020a1c04c9000000b002f7a4ab0a49so97034wme.0
        for <git@vger.kernel.org>; Fri, 03 Sep 2021 10:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cUSMHzmMPMPnOWwfOFLwz3q+r1P32QWjXe2cwNH6zOY=;
        b=J7W60LMDysyvPcP52CoknH1KOZ/e7VgzCtWhETMIsQJ/KHDrofE/qTmzWwLcfwtiSN
         3jbThgSj66+FznRmnr1tjXz167Sb3/tPLLBulF4exdl40EEtt1WlRjFvtJ6k7UDbEdvq
         gggTR7B8hy7bInNWFWEH+s8EZYobAwYvdWrzC/n7i2+LEv4pm6Z05v1OhPzhbp8Dafy0
         OicBSUnnRv/yv463hO9gnGqRdEL6QRwceHVCdtr7mRruXSvptQMSVi7NbNb/7s+4/U7H
         EHzP1BEJlS38UYmuGemM3rLJH/c1Roj/jEcccmDfDmI/DieOIOVyMVSWhS75dMO3dmLB
         uLsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cUSMHzmMPMPnOWwfOFLwz3q+r1P32QWjXe2cwNH6zOY=;
        b=J4TVZokGLAPRvfqcNoE2ycsDISPLwZhMunxhgZXSU7F/Rir0tw6GydpKQcIpb2TbMl
         rLQrrZ0JjAKGx4zdGXQq3jQiCNyHPk0+8FaajQ/GgfaVq8F4JKCxlOQod2M+8DGOSvGq
         uoPlbTWQ4DaRGi1Ym1b+7L+FzzW2zZSvKJ+LdHUqg/PAX0gNnSOYimmsSoA8aOYWWGya
         LuLLLBXTgW0KwtC+4lf/+2kmpPb9sBYag9nj2PqYZEan6YkGegAVXdrbdtPZBZGNPS78
         PpOcvGkqRJJY4C2XYf2M1Omt7RD+uC09dqmaf3B/GMxEEJVImkbUT10v3/CLLy/KYvpz
         loJQ==
X-Gm-Message-State: AOAM532NaK6xp6WFgVwWZI9zFo/IuXP8B5cWSmQrc8irh9lYOb0QPdcM
        81vnJpgKakEwQDAv6UIxWP8Y5gM0wSA=
X-Google-Smtp-Source: ABdhPJwJgtCwgx4LxBnb87TN7Lh1j1OeNOPdZ7BvhT3AOgLivvAeAUZFSkW1eawEk7WmoEzHd4qyuw==
X-Received: by 2002:a7b:c350:: with SMTP id l16mr34250wmj.151.1630691695597;
        Fri, 03 Sep 2021 10:54:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o2sm5731392wrh.13.2021.09.03.10.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 10:54:55 -0700 (PDT)
Message-Id: <f3223c10788fe836d0322006dc2dcbafe08f6b5b.1630691688.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v2.git.1630691688.gitgitgadget@gmail.com>
References: <pull.1005.git.1630359290.gitgitgadget@gmail.com>
        <pull.1005.v2.git.1630691688.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 03 Sep 2021 17:54:40 +0000
Subject: [PATCH v2 08/15] scalar: implement the `clone` subcommand
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This implements Scalar's opinionated `clone` command: it tries to use a
partial clone and sets up a sparse checkout by default. In contrast to
`git clone`, `scalar clone` sets up the worktree in the `src/`
subdirectory, to encourage a separation between the source files and the
build output (which helps Git tremendously because it avoids untracked
files that have to be specifically ignored when refreshing the index).

Also, it registers the repository for regular, scheduled maintenance,
and configures a flurry of configuration settings based on the
experience and experiments of the Microsoft Windows and the Microsoft
Office development teams.

Note: since the `scalar clone` command is by far the most commonly
called `scalar` subcommand, we document it at the top of the manual
page.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/scalar/scalar.c          | 201 +++++++++++++++++++++++++++++++
 contrib/scalar/scalar.txt        |  35 +++++-
 contrib/scalar/t/t9099-scalar.sh |  32 +++++
 3 files changed, 263 insertions(+), 5 deletions(-)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index 7f5436399da..bf18003b297 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -7,6 +7,7 @@
 #include "parse-options.h"
 #include "config.h"
 #include "run-command.h"
+#include "refs.h"
 
 /*
  * Remove the deepest subdirectory in the provided path string. Path must not
@@ -257,6 +258,205 @@ static int unregister_dir(void)
 	return res;
 }
 
+/* printf-style interface, expects `<key>=<value>` argument */
+static int set_config(const char *fmt, ...)
+{
+	struct strbuf buf = STRBUF_INIT;
+	char *value;
+	int res;
+	va_list args;
+
+	va_start(args, fmt);
+	strbuf_vaddf(&buf, fmt, args);
+	va_end(args);
+
+	value = strchr(buf.buf, '=');
+	if (value)
+		*(value++) = '\0';
+	res = git_config_set_gently(buf.buf, value);
+	strbuf_release(&buf);
+
+	return res;
+}
+
+static char *remote_default_branch(const char *url)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	struct strbuf out = STRBUF_INIT;
+
+	cp.git_cmd = 1;
+	strvec_pushl(&cp.args, "ls-remote", "--symref", url, "HEAD", NULL);
+	if (!pipe_command(&cp, NULL, 0, &out, 0, NULL, 0)) {
+		const char *line = out.buf;
+
+		while (*line) {
+			const char *eol = strchrnul(line, '\n'), *p;
+			size_t len = eol - line;
+			char *branch;
+
+			if (!skip_prefix(line, "ref: ", &p) ||
+			    !strip_suffix_mem(line, &len, "\tHEAD")) {
+				line = eol + (*eol == '\n');
+				continue;
+			}
+
+			eol = line + len;
+			if (skip_prefix(p, "refs/heads/", &p)) {
+				branch = xstrndup(p, eol - p);
+				strbuf_release(&out);
+				return branch;
+			}
+
+			error(_("remote HEAD is not a branch: '%.*s'"),
+			      (int)(eol - p), p);
+			strbuf_release(&out);
+			return NULL;
+		}
+	}
+	warning(_("failed to get default branch name from remote; "
+		  "using local default"));
+	strbuf_reset(&out);
+
+	child_process_init(&cp);
+	cp.git_cmd = 1;
+	strvec_pushl(&cp.args, "symbolic-ref", "--short", "HEAD", NULL);
+	if (!pipe_command(&cp, NULL, 0, &out, 0, NULL, 0)) {
+		strbuf_trim(&out);
+		return strbuf_detach(&out, NULL);
+	}
+
+	strbuf_release(&out);
+	error(_("failed to get default branch name"));
+	return NULL;
+}
+
+static int cmd_clone(int argc, const char **argv)
+{
+	const char *branch = NULL;
+	int full_clone = 0;
+	struct option clone_options[] = {
+		OPT_STRING('b', "branch", &branch, N_("<branch>"),
+			   N_("branch to checkout after clone")),
+		OPT_BOOL(0, "full-clone", &full_clone,
+			 N_("when cloning, create full working directory")),
+		OPT_END(),
+	};
+	const char * const clone_usage[] = {
+		N_("scalar clone [<options>] [--] <repo> [<dir>]"),
+		NULL
+	};
+	const char *url;
+	char *enlistment = NULL, *dir = NULL;
+	struct strbuf buf = STRBUF_INIT;
+	int res;
+
+	argc = parse_options(argc, argv, NULL, clone_options, clone_usage, 0);
+
+	if (argc == 2) {
+		url = argv[0];
+		enlistment = xstrdup(argv[1]);
+	} else if (argc == 1) {
+		url = argv[0];
+
+		strbuf_addstr(&buf, url);
+		/* Strip trailing slashes, if any */
+		while (buf.len > 0 && is_dir_sep(buf.buf[buf.len - 1]))
+			strbuf_setlen(&buf, buf.len - 1);
+		/* Strip suffix `.git`, if any */
+		strbuf_strip_suffix(&buf, ".git");
+
+		enlistment = find_last_dir_sep(buf.buf);
+		if (!enlistment) {
+			die(_("cannot deduce worktree name from '%s'"), url);
+		}
+		enlistment = xstrdup(enlistment + 1);
+	} else {
+		usage_msg_opt(_("You must specify a repository to clone."),
+			      clone_usage, clone_options);
+	}
+
+	if (is_directory(enlistment))
+		die(_("directory '%s' exists already"), enlistment);
+
+	dir = xstrfmt("%s/src", enlistment);
+
+	strbuf_reset(&buf);
+	if (branch)
+		strbuf_addf(&buf, "init.defaultBranch=%s", branch);
+	else {
+		char *b = repo_default_branch_name(the_repository, 1);
+		strbuf_addf(&buf, "init.defaultBranch=%s", b);
+		free(b);
+	}
+
+	if ((res = run_git("-c", buf.buf, "init", "--", dir, NULL)))
+		goto cleanup;
+
+	if (chdir(dir) < 0) {
+		res = error_errno(_("could not switch to '%s'"), dir);
+		goto cleanup;
+	}
+
+	setup_git_directory();
+
+	/* common-main already logs `argv` */
+	trace2_def_repo(the_repository);
+
+	if (!branch && !(branch = remote_default_branch(url))) {
+		res = error(_("failed to get default branch for '%s'"), url);
+		goto cleanup;
+	}
+
+	if (set_config("remote.origin.url=%s", url) ||
+	    set_config("remote.origin.fetch="
+		       "+refs/heads/*:refs/remotes/origin/*") ||
+	    set_config("remote.origin.promisor=true") ||
+	    set_config("remote.origin.partialCloneFilter=blob:none")) {
+		res = error(_("could not configure remote in '%s'"), dir);
+		goto cleanup;
+	}
+
+	if (!full_clone &&
+	    (res = run_git("sparse-checkout", "init", "--cone", NULL)))
+		goto cleanup;
+
+	if (set_recommended_config())
+		return error(_("could not configure '%s'"), dir);
+
+	if ((res = run_git("fetch", "--quiet", "origin", NULL))) {
+		warning(_("partial clone failed; attempting full clone"));
+
+		if (set_config("remote.origin.promisor") ||
+		    set_config("remote.origin.partialCloneFilter")) {
+			res = error(_("could not configure for full clone"));
+			goto cleanup;
+		}
+
+		if ((res = run_git("fetch", "--quiet", "origin", NULL)))
+			goto cleanup;
+	}
+
+	if ((res = set_config("branch.%s.remote=origin", branch)))
+		goto cleanup;
+	if ((res = set_config("branch.%s.merge=refs/heads/%s",
+			      branch, branch)))
+		goto cleanup;
+
+	strbuf_reset(&buf);
+	strbuf_addf(&buf, "origin/%s", branch);
+	res = run_git("checkout", "-f", "-t", buf.buf, NULL);
+	if (res)
+		goto cleanup;
+
+	res = register_dir();
+
+cleanup:
+	free(enlistment);
+	free(dir);
+	strbuf_release(&buf);
+	return res;
+}
+
 static int cmd_list(int argc, const char **argv)
 {
 	if (argc != 1)
@@ -353,6 +553,7 @@ static struct {
 	const char *name;
 	int (*fn)(int, const char **);
 } builtins[] = {
+	{ "clone", cmd_clone },
 	{ "list", cmd_list },
 	{ "register", cmd_register },
 	{ "unregister", cmd_unregister },
diff --git a/contrib/scalar/scalar.txt b/contrib/scalar/scalar.txt
index f2528557a0c..d4e3cb73fda 100644
--- a/contrib/scalar/scalar.txt
+++ b/contrib/scalar/scalar.txt
@@ -8,6 +8,7 @@ scalar - an opinionated repository management tool
 SYNOPSIS
 --------
 [verse]
+scalar clone [--branch <main-branch>] [--full-clone] <url> [<enlistment>]
 scalar list
 scalar register [<enlistment>]
 scalar unregister [<enlistment>]
@@ -29,19 +30,43 @@ an existing Git worktree with Scalar whose name is not `src`, the enlistment
 will be identical to the worktree.
 
 The `scalar` command implements various subcommands, and different options
-depending on the subcommand. With the exception of `list`, all subcommands
-expect to be run in an enlistment.
+depending on the subcommand. With the exception of `clone` and `list`, all
+subcommands expect to be run in an enlistment.
 
 COMMANDS
 --------
 
+Clone
+~~~~~
+
+clone [<options>] <url> [<enlistment>]::
+	Clones the specified repository, similar to linkgit:git-clone[1]. By
+	default, only commit and tree objects are cloned. Once finished, the
+	worktree is located at `<enlistment>/src`.
++
+The sparse-checkout feature is enabled (except when run with `--full-clone`)
+and the only files present are those in the top-level directory. Use
+`git sparse-checkout set` to expand the set of directories you want to see,
+or `git sparse-checkout disable` to expand to all files (see
+linkgit:git-sparse-checkout[1] for more details). You can explore the
+subdirectories outside your sparse-checkout by using `git ls-tree HEAD`.
+
+-b <name>::
+--branch <name>::
+	Instead of checking out the branch pointed to by the cloned
+	repository's HEAD, check out the `<name>` branch instead.
+
+--[no-]full-clone::
+	A sparse-checkout is initialized by default. This behavior can be
+	turned off via `--full-clone`.
+
 List
 ~~~~
 
 list::
 	To see which repositories are currently registered by the service, run
-	`scalar list`. This subcommand does not need to be run inside a Scalar
-	enlistment.
+	`scalar list`. This subcommand, like `clone`, does not need to be run
+	inside a Scalar enlistment.
 
 Register
 ~~~~~~~~
@@ -65,7 +90,7 @@ unregister [<enlistment>]::
 
 SEE ALSO
 --------
-linkgit:git-maintenance[1].
+linkgit:git-clone[1], linkgit:git-maintenance[1].
 
 Scalar
 ---
diff --git a/contrib/scalar/t/t9099-scalar.sh b/contrib/scalar/t/t9099-scalar.sh
index ef0e8d680d5..295398f62cc 100755
--- a/contrib/scalar/t/t9099-scalar.sh
+++ b/contrib/scalar/t/t9099-scalar.sh
@@ -10,6 +10,9 @@ PATH=$PWD/..:$PATH
 
 . ../../../t/test-lib.sh
 
+GIT_TEST_MAINT_SCHEDULER="crontab:test-tool crontab ../cron.txt"
+export GIT_TEST_MAINT_SCHEDULER
+
 test_expect_success 'scalar shows a usage' '
 	test_expect_code 129 scalar -h
 '
@@ -29,4 +32,33 @@ test_expect_success 'scalar unregister' '
 	! grep -F "$(pwd)/vanish/src" scalar.repos
 '
 
+test_expect_success 'set up repository to clone' '
+	test_commit first &&
+	test_commit second &&
+	test_commit third &&
+	git switch -c parallel first &&
+	mkdir -p 1/2 &&
+	test_commit 1/2/3 &&
+	git config uploadPack.allowFilter true &&
+	git config uploadPack.allowAnySHA1InWant true
+'
+
+test_expect_success 'scalar clone' '
+	second=$(git rev-parse --verify second:second.t) &&
+	scalar clone "file://$(pwd)" cloned &&
+	(
+		cd cloned/src &&
+
+		git config --get --global --fixed-value maintenance.repo \
+			"$(pwd)" &&
+
+		test_path_is_missing 1/2 &&
+		test_must_fail git rev-list --missing=print $second &&
+		git rev-list $second &&
+		git cat-file blob $second >actual &&
+		echo "second" >expect &&
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
gitgitgadget

