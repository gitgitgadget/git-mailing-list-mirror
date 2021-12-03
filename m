Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 249CAC4332F
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 13:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381081AbhLCNiN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 08:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381031AbhLCNiG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 08:38:06 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A360C06175E
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 05:34:41 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id a9so5751207wrr.8
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 05:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dJoH1g3lf14FbbkcbC9UpnDZthqLHd7bJjcDeRBOdX8=;
        b=eP21pqctwf/mDW9Qeb202AfBCadqU2Fho5uvnMH/7ZtUI6OItypAang/9Yd0k2R8Pg
         wGVE7un5IUOEhvDBMH4PLkn7FSjzGZukumasObqqG6KV85QTS3BRw1HiHP9RQ9Jq5Qtu
         fcb9SsFjlDL7q3hhXGYLCXIeR9BucjGgMuggqUhW7HtOBYzvo3ykhoYQ+tXg86v+EKe7
         6+A0oXncFBfMeMwwmWiaFiRbXleqrTqLHGZiZfgvnMX8kFF5CymFvI7T5XSCJP+WGDLC
         1Rj43/gZKCwVmTSd8XCczcwqA1yKLSrQsCgj2gMbkQcY4fCjyAgXsZZRpLGaai8lKmSM
         RZtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dJoH1g3lf14FbbkcbC9UpnDZthqLHd7bJjcDeRBOdX8=;
        b=ybGEzaQKrGa+7agqL/XBpiHqvOntcvV5poiW3KuQI+92oEvZMkpG3EgRsezESpOn00
         t3ArTZjN/O+hWjBiJoDMTXhhDjKl1tYNfaZzCd4gR02brHsLQUAA0nrrNWoyCf049fWp
         xxk90YjNupVP1SxNI3GUYUi76HRrt+zJOJJZNu0gcbKmljyh8kTorpb+0wU1ApZYRo5p
         HXz/2WLzcM380njxpia7XO7nQlasYX/0Tt4xM4Ki7XF6NoKyh2N1piTnJ7AcdldKJqUf
         JTi/GyrkFxL87UvixOo5luxTpNpRrdJ5g4uFy9fsR8+x8V8wSlOi6W8HatVBarGGIH6F
         wxcg==
X-Gm-Message-State: AOAM53186eykYkQqd6N5FcwuOjzU+Ev+mFvd/h8KWK5Q6WyEw0NzYEOn
        JMwyMUAdE6VRAZrqk44K6D/1rXCr9XE=
X-Google-Smtp-Source: ABdhPJyRPkd0z8Q7dpCfFs4L3hfm/gzqIEDvwokbLC4jgFC+X9JrUBzs+pO1DGz5l4Bn3s8z2IIh5Q==
X-Received: by 2002:a5d:58f9:: with SMTP id f25mr21529252wrd.206.1638538479859;
        Fri, 03 Dec 2021 05:34:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q4sm2560532wrs.56.2021.12.03.05.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 05:34:39 -0800 (PST)
Message-Id: <60659c4719678891dc98207e666d1da548c2259d.1638538470.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v10.git.1638538470.gitgitgadget@gmail.com>
References: <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>
        <pull.1005.v10.git.1638538470.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 03 Dec 2021 13:34:23 +0000
Subject: [PATCH v10 09/15] scalar: implement the `clone` subcommand
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Matt Rogers <mattr94@gmail.com>,
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
 contrib/scalar/scalar.txt        |  32 ++++-
 contrib/scalar/t/t9099-scalar.sh |  32 +++++
 3 files changed, 262 insertions(+), 3 deletions(-)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index 65da885c5ac..60a9466421b 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -7,6 +7,7 @@
 #include "parse-options.h"
 #include "config.h"
 #include "run-command.h"
+#include "refs.h"
 
 /*
  * Remove the deepest subdirectory in the provided path string. Path must not
@@ -251,6 +252,205 @@ static int unregister_dir(void)
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
@@ -347,6 +547,7 @@ static struct {
 	const char *name;
 	int (*fn)(int, const char **);
 } builtins[] = {
+	{ "clone", cmd_clone },
 	{ "list", cmd_list },
 	{ "register", cmd_register },
 	{ "unregister", cmd_unregister },
diff --git a/contrib/scalar/scalar.txt b/contrib/scalar/scalar.txt
index f93e3d00efd..e8730967f16 100644
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
@@ -29,12 +30,37 @@ an existing Git worktree with Scalar whose name is not `src`, the enlistment
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
+subdirectories outside your sparse-checkout by using `git ls-tree
+HEAD[:<directory>]`.
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
 
@@ -64,7 +90,7 @@ unregister [<enlistment>]::
 
 SEE ALSO
 --------
-linkgit:git-maintenance[1].
+linkgit:git-clone[1], linkgit:git-maintenance[1].
 
 Scalar
 ---
diff --git a/contrib/scalar/t/t9099-scalar.sh b/contrib/scalar/t/t9099-scalar.sh
index ef0e8d680d5..984d69e8f75 100755
--- a/contrib/scalar/t/t9099-scalar.sh
+++ b/contrib/scalar/t/t9099-scalar.sh
@@ -10,6 +10,9 @@ PATH=$PWD/..:$PATH
 
 . ../../../t/test-lib.sh
 
+GIT_TEST_MAINT_SCHEDULER="crontab:test-tool crontab ../cron.txt,launchctl:true,schtasks:true"
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

