Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1487FC64ED6
	for <git@archiver.kernel.org>; Tue, 28 Feb 2023 18:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjB1S5O (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Feb 2023 13:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjB1S5D (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2023 13:57:03 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67165301BD
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 10:56:59 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id m18-20020a17090a7f9200b002375a3cbc9bso3304804pjl.9
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 10:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2fYQcH/kJ1rUNvVb2YC9RCfJJEZVtZAfrB2GGGFDwBQ=;
        b=L7SyTuSpfiaqZ52krsynvj5KS03IYx0sjCsix1bqEBp3hz6m7J3SVwArnZTsEkqYmj
         unPOB+lzKyujY8Q9YxC92EWzRCSQDV/4UuskHFp6QKmX0ziiSNa9NnnZ9xBLlTvENdsE
         +GLLO6MOHG2e16epaaKZ7pg8KiKKIZAF3HiSK9TPiy01RgEoXq7iE01tAVE7lr0dhh6b
         g3jCk9xiL6Eb/J2cSocredXSRZjRCMCSqU3LzrLc8OGTZvWPXk3U6newTSuprfoAbLXY
         jN62KxTkLcQsdrkiN0ASokMudb2++GohJ4ynJ2T+pustnmVmExRUqfRC+4BAVqw6SNLZ
         nSzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2fYQcH/kJ1rUNvVb2YC9RCfJJEZVtZAfrB2GGGFDwBQ=;
        b=NJFSZWbdLgXFYbGH5oD/TmhpsnNdd5gljaliJYNXrVVyadcdqAiFHP+W+cw60sRzrI
         1u8jnxAHBPitdHhnRs5VRJZJhUt/KH1sga/lNXVl896QbW/kTbwaQJNk4ECxSsHiPkQ2
         7dIF15xFdQZJ5w/pgmAdrcM1NS1SOsSgEdcSwHEfhi4zbE8syvmhaMkoxFYCF+MVrmY2
         OoEH8LSNiEX4160cklcphzMd9bO6ellWNOog+evxMlboYYvLMAyUhHfrrek9hou0Pgkd
         Q0CRPUFwaAJ8xKxGUIbaf867zmWIQXXG6ii+y18Cm0ms23X4J5itJxoQ/G5kfALv9L1C
         t5+w==
X-Gm-Message-State: AO0yUKXIcTCek6VI2lBfKmfuWkxTSJEHzYyxoL6GVwBHblqCHAcS6kf1
        nYCJuUG7XOrakwKoAc9WT7a7hg76ssAoQlamKnsCDal4UWN0lEXv6H/g9+IpGl2FPNKgK/9E9BX
        0fdiECBIdbcNOqtVQ1B4ZHoWiOHOsYopyOwlfNedtr1b1Q3hPcylaUBK8qqJRaRkRxQ==
X-Google-Smtp-Source: AK7set+5BQnjjDxU/NFbq5xeNrL8jYl70uIm5EoTPKVbcsc9GPoqlRgCjmOZv4p8NbEmr2H0UUFkVtkz3vKVDfQ=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a62:8747:0:b0:5a8:dc92:109f with SMTP id
 i68-20020a628747000000b005a8dc92109fmr1444502pfe.3.1677610618771; Tue, 28 Feb
 2023 10:56:58 -0800 (PST)
Date:   Tue, 28 Feb 2023 18:56:42 +0000
In-Reply-To: <20230228185253.2356546-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230213182134.2173280-1-calvinwan@google.com>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Message-ID: <20230228185642.2357806-6-calvinwan@google.com>
Subject: [PATCH v2 6/6] add: reject nested repositories
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Josh Steadmon <steadmon@google.com>, peff@peff.net,
        gitster@pobox.com, Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Josh Steadmon <steadmon@google.com>

As noted in 532139940c (add: warn when adding an embedded repository,
2017-06-14), adding embedded repositories results in subpar experience
compared to submodules, due to the lack of a corresponding .gitmodules
entry, which means later clones of the top-level repository cannot
locate the embedded repo. We expect that this situation is usually
unintentional, which is why 532139940c added a warning message and
advice when users attempt to add an embedded repo.

At $dayjob, we have found that even this advice is insufficient to stop
users from committing unclonable embedded repos in shared projects.
This causes toil for the owners of the top-level project repository as
they must clean up the resulting gitlinks. Additionally, these mistakes
are often made by partners outside of $dayjob, which means that a simple
organization-wide change to the default Git config would be insufficient
to prevent these mistakes.

Due to this experience, we believe that Git's default behavior should be
changed to disallow adding embedded repositories. This commit changes
the existing warning into a fatal error, rewrites the advice given, and
deprecates `--no-warn-embedded-repo` in favor of `--allow-embedded-repo`
to bypass the fatal error.

Signed-off-by: Josh Steadmon <steadmon@google.com>
Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 Documentation/git-add.txt              | 15 +++++++----
 builtin/add.c                          | 37 +++++++++++++++++---------
 builtin/submodule--helper.c            |  4 +--
 t/t0008-ignores.sh                     |  2 +-
 t/t2103-update-index-ignore-missing.sh |  2 +-
 t/t4035-diff-quiet.sh                  |  2 +-
 t/t6430-merge-recursive.sh             |  2 +-
 t/t7400-submodule-basic.sh             |  4 +--
 t/t7412-submodule-absorbgitdirs.sh     |  2 +-
 t/t7414-submodule-mistakes.sh          | 29 +++++++++++---------
 t/t7450-bad-git-dotfiles.sh            |  2 +-
 11 files changed, 61 insertions(+), 40 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index a030d33c6e..b90e305110 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -176,12 +176,17 @@ for "git add --no-all <pathspec>...", i.e. ignored removed files.
 	be ignored, no matter if they are already present in the work
 	tree or not.
 
---no-warn-embedded-repo::
-	By default, `git add` will warn when adding an embedded
+--allow-embedded-repo::
+	By default, `git add` will error out when adding an embedded
 	repository to the index without using `git submodule add` to
-	create an entry in `.gitmodules`. This option will suppress the
-	warning (e.g., if you are manually performing operations on
-	submodules).
+	create an entry in `.gitmodules`. This option will allow the
+	embedded repository to be added. (e.g., if you are manually
+	performing operations on submodules).
+
+--no-warn-embedded-repo::
+	This option is deprecated in favor of '--add-embedded-repo'.
+	Passing this option still suppresses advice but does not bypass
+	the error.
 
 --renormalize::
 	Apply the "clean" process freshly to all tracked files to
diff --git a/builtin/add.c b/builtin/add.c
index 76277df326..c1590129bb 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -354,6 +354,7 @@ N_("The following paths are ignored by one of your .gitignore files:\n");
 static int verbose, show_only, ignored_too, refresh_only;
 static int ignore_add_errors, intent_to_add, ignore_missing;
 static int warn_on_embedded_repo = 1;
+static int allow_embedded_repo = 0;
 
 #define ADDREMOVE_DEFAULT 1
 static int addremove = ADDREMOVE_DEFAULT;
@@ -392,6 +393,8 @@ static struct option builtin_add_options[] = {
 		   N_("override the executable bit of the listed files")),
 	OPT_HIDDEN_BOOL(0, "warn-embedded-repo", &warn_on_embedded_repo,
 			N_("warn when adding an embedded repository")),
+	OPT_HIDDEN_BOOL(0, "allow-embedded-repo", &allow_embedded_repo,
+			N_("allow adding an embedded repository")),
 	OPT_PATHSPEC_FROM_FILE(&pathspec_from_file),
 	OPT_PATHSPEC_FILE_NUL(&pathspec_file_nul),
 	OPT_END(),
@@ -409,48 +412,53 @@ static int add_config(const char *var, const char *value, void *cb)
 }
 
 static const char embedded_advice[] = N_(
-"You've added another git repository inside your current repository.\n"
+"You attempted to add another git repository inside your current repository.\n"
 "Clones of the outer repository will not contain the contents of\n"
 "the embedded repository and will not know how to obtain it.\n"
 "If you meant to add a submodule, use:\n"
 "\n"
 "	git submodule add <url> %s\n"
 "\n"
-"If you added this path by mistake, you can remove it from the\n"
-"index with:\n"
+"See \"git help submodule\" for more information.\n"
 "\n"
-"	git rm --cached %s\n"
+"If you cannot use submodules, you may bypass this check with:\n"
 "\n"
-"See \"git help submodule\" for more information."
+"	git add --allow-embedded-repo %s\n"
 );
 
-static void check_embedded_repo(const char *path)
+static int check_embedded_repo(const char *path)
 {
+	int ret = 0;
 	struct strbuf name = STRBUF_INIT;
 	static int adviced_on_embedded_repo = 0;
 
-	if (!warn_on_embedded_repo)
-		return;
+	if (allow_embedded_repo)
+		goto cleanup;
 	if (!ends_with(path, "/"))
-		return;
+		goto cleanup;
+
+	ret = 1;
 
 	/* Drop trailing slash for aesthetics */
 	strbuf_addstr(&name, path);
 	strbuf_strip_suffix(&name, "/");
 
-	warning(_("adding embedded git repository: %s"), name.buf);
+	error(_("cannot add embedded git repository: %s"), name.buf);
 	if (!adviced_on_embedded_repo &&
-	    advice_enabled(ADVICE_ADD_EMBEDDED_REPO)) {
+		warn_on_embedded_repo &&
+		advice_enabled(ADVICE_ADD_EMBEDDED_REPO)) {
 		advise(embedded_advice, name.buf, name.buf);
 		adviced_on_embedded_repo = 1;
 	}
 
+cleanup:
 	strbuf_release(&name);
+	return ret;
 }
 
 static int add_files(struct dir_struct *dir, int flags)
 {
-	int i, exit_status = 0;
+	int i, exit_status = 0, embedded_repo = 0;
 	struct string_list matched_sparse_paths = STRING_LIST_INIT_NODUP;
 
 	if (dir->ignored_nr) {
@@ -476,10 +484,13 @@ static int add_files(struct dir_struct *dir, int flags)
 				die(_("adding files failed"));
 			exit_status = 1;
 		} else {
-			check_embedded_repo(dir->entries[i]->name);
+			embedded_repo |= check_embedded_repo(dir->entries[i]->name);
 		}
 	}
 
+	if (embedded_repo)
+		die(_("refusing to add embedded git repositories"));
+
 	if (matched_sparse_paths.nr) {
 		advise_on_updating_sparse_paths(&matched_sparse_paths);
 		exit_status = 1;
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 05f2c9bc98..534ed22c9e 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -3129,7 +3129,7 @@ static void configure_added_submodule(struct add_data *add_data)
 
 	add_submod.git_cmd = 1;
 	strvec_pushl(&add_submod.args, "add",
-		     "--no-warn-embedded-repo", NULL);
+		     "--allow-embedded-repo", NULL);
 	if (add_data->force)
 		strvec_push(&add_submod.args, "--force");
 	strvec_pushl(&add_submod.args, "--", add_data->sm_path, NULL);
@@ -3318,7 +3318,7 @@ static int module_add(int argc, const char **argv, const char *prefix)
 		cp.git_cmd = 1;
 		cp.no_stdout = 1;
 		strvec_pushl(&cp.args, "add", "--dry-run", "--ignore-missing",
-			     "--no-warn-embedded-repo", add_data.sm_path, NULL);
+			     "--allow-embedded-repo", add_data.sm_path, NULL);
 		if ((ret = pipe_command(&cp, NULL, 0, NULL, 0, &sb, 0))) {
 			strbuf_complete_line(&sb);
 			fputs(sb.buf, stderr);
diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index c70d11bc91..a53dac5931 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -191,7 +191,7 @@ test_expect_success 'setup' '
 		git add a &&
 		git commit -m"commit in submodule"
 	) &&
-	git add a/submodule &&
+	git add --allow-embedded-repo a/submodule &&
 	cat <<-\EOF >.gitignore &&
 		one
 		ignored-*
diff --git a/t/t2103-update-index-ignore-missing.sh b/t/t2103-update-index-ignore-missing.sh
index 11bc136f6e..1ce4fc49fa 100755
--- a/t/t2103-update-index-ignore-missing.sh
+++ b/t/t2103-update-index-ignore-missing.sh
@@ -36,7 +36,7 @@ test_expect_success basics '
 		git add file &&
 		git commit -m "sub initial"
 	) &&
-	git add ./xyzzy &&
+	git add --allow-embedded-repo ./xyzzy &&
 
 	test_tick &&
 	git commit -m initial &&
diff --git a/t/t4035-diff-quiet.sh b/t/t4035-diff-quiet.sh
index 76f8034c60..bfd87891f4 100755
--- a/t/t4035-diff-quiet.sh
+++ b/t/t4035-diff-quiet.sh
@@ -66,7 +66,7 @@ test_expect_success 'git diff-index --cached HEAD^' '
 test_expect_success 'git diff-index --cached HEAD^' '
 	echo text >>b &&
 	echo 3 >c &&
-	git add . &&
+	git add --allow-embedded-repo . &&
 	test_expect_code 1 git diff-index --quiet --cached HEAD^ >cnt &&
 	test_line_count = 0 cnt
 '
diff --git a/t/t6430-merge-recursive.sh b/t/t6430-merge-recursive.sh
index 07067bb347..ae435fa492 100755
--- a/t/t6430-merge-recursive.sh
+++ b/t/t6430-merge-recursive.sh
@@ -677,7 +677,7 @@ test_expect_success 'merging with triple rename across D/F conflict' '
 	echo content3 >sub2/file3 &&
 	mkdir simple &&
 	echo base >simple/bar &&
-	git add -A &&
+	git add -A --allow-embedded-repo &&
 	test_tick &&
 	git commit -m base &&
 
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index eae6a46ef3..18ef9141b7 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -118,7 +118,7 @@ test_expect_success 'setup - repository in init subdirectory' '
 test_expect_success 'setup - commit with gitlink' '
 	echo a >a &&
 	echo z >z &&
-	git add a init z &&
+	git add --allow-embedded-repo a init z &&
 	git commit -m "super commit 1"
 '
 
@@ -771,7 +771,7 @@ test_expect_success 'set up for relative path tests' '
 			git init &&
 			test_commit foo
 		) &&
-		git add sub &&
+		git add --allow-embedded-repo sub &&
 		git config -f .gitmodules submodule.sub.path sub &&
 		git config -f .gitmodules submodule.sub.url ../subrepo &&
 		cp .git/config pristine-.git-config &&
diff --git a/t/t7412-submodule-absorbgitdirs.sh b/t/t7412-submodule-absorbgitdirs.sh
index 2859695c6d..d1662aa23c 100755
--- a/t/t7412-submodule-absorbgitdirs.sh
+++ b/t/t7412-submodule-absorbgitdirs.sh
@@ -100,7 +100,7 @@ test_expect_success 'absorb the git dir in a nested submodule' '
 test_expect_success 'setup a gitlink with missing .gitmodules entry' '
 	git init sub2 &&
 	test_commit -C sub2 first &&
-	git add sub2 &&
+	git add --allow-embedded-repo sub2 &&
 	git commit -m superproject
 '
 
diff --git a/t/t7414-submodule-mistakes.sh b/t/t7414-submodule-mistakes.sh
index 101afff30f..d38cf34dff 100755
--- a/t/t7414-submodule-mistakes.sh
+++ b/t/t7414-submodule-mistakes.sh
@@ -10,31 +10,36 @@ test_expect_success 'create embedded repository' '
 	test_commit -C embed one
 '
 
-test_expect_success 'git-add on embedded repository warns' '
-	test_when_finished "git rm --cached -f embed" &&
-	git add embed 2>stderr &&
-	test_i18ngrep warning stderr
+test_expect_success 'git-add on embedded repository dies' '
+	test_must_fail git add embed 2>stderr &&
+	test_i18ngrep fatal stderr
 '
 
-test_expect_success '--no-warn-embedded-repo suppresses warning' '
+test_expect_success '--allow-embedded-repo adds embedded repository and suppresses error message' '
 	test_when_finished "git rm --cached -f embed" &&
-	git add --no-warn-embedded-repo embed 2>stderr &&
-	test_i18ngrep ! warning stderr
+	git add --allow-embedded-repo embed 2>stderr &&
+	test_i18ngrep ! fatal stderr
+'
+
+test_expect_success '--no-warn-embedded-repo dies and suppresses advice' '
+	test_must_fail git add --no-warn-embedded-repo embed 2>stderr &&
+	test_i18ngrep ! hint stderr &&
+	test_i18ngrep fatal stderr
 '
 
-test_expect_success 'no warning when updating entry' '
+test_expect_success 'no error message when updating entry' '
 	test_when_finished "git rm --cached -f embed" &&
-	git add embed &&
+	git add --allow-embedded-repo embed &&
 	git -C embed commit --allow-empty -m two &&
 	git add embed 2>stderr &&
-	test_i18ngrep ! warning stderr
+	test_i18ngrep ! fatal stderr
 '
 
-test_expect_success 'submodule add does not warn' '
+test_expect_success 'submodule add neither fails nor issues error message' '
 	test_when_finished "git rm -rf submodule .gitmodules" &&
 	git -c protocol.file.allow=always \
 		submodule add ./embed submodule 2>stderr &&
-	test_i18ngrep ! warning stderr
+	test_i18ngrep ! fatal stderr
 '
 
 test_done
diff --git a/t/t7450-bad-git-dotfiles.sh b/t/t7450-bad-git-dotfiles.sh
index ba1f569bcb..4b3010c9e2 100755
--- a/t/t7450-bad-git-dotfiles.sh
+++ b/t/t7450-bad-git-dotfiles.sh
@@ -307,7 +307,7 @@ test_expect_success 'git dirs of sibling submodules must not be nested' '
 		EOF
 		git clone . thing1 &&
 		git clone . thing2 &&
-		git add .gitmodules thing1 thing2 &&
+		git add --allow-embedded-repo .gitmodules thing1 thing2 &&
 		test_tick &&
 		git commit -m nested
 	) &&
-- 
2.39.2.722.g9855ee24e9-goog

