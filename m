Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA625C43465
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 13:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 682D3218AC
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 13:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1Q5Pwz9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgIUNa5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 09:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbgIUNaz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 09:30:55 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC77C0613D1
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 06:30:55 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id b79so12691922wmb.4
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 06:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eobagORDrsVXE1P0bHoIU/4L3O/zDkcGzvNeMF+BhKs=;
        b=E1Q5Pwz95gJOYmnKTm4kPwjd8e+7jZGL84B454ch/eu8iKVmbEnQVqxM+Jxe3jhsdA
         5qBBNQg5bvxaaSAoJntBDLKImSGna6K+CnQXI98f4VvJuambFWQvVW6unkXazEhyJ9QU
         HD74sOu9UBVVt2AsRHXLO1j07SH3fH+Ud3ys0WP4V5GNnA24FQ4RU5DO8ltWxKFczAvq
         jojNCsU1KV1vbf8ELPX1m6oYUfye9Pgrn5BXpCUULVQXE0ej/Mga2SyRHcgEr0T2AcNk
         UvBR1lHS3CzYoAl/BVn7Kkmby/LfhpB29Y3bTKOik05eF0NnTp7/GZViFFK6pyjO2LBE
         etXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eobagORDrsVXE1P0bHoIU/4L3O/zDkcGzvNeMF+BhKs=;
        b=SGcwZkeouebpGiWq9hSYaNa8bY6slbia8+zGBoGq63KnuEzTNxMvf9OZIT2f2P2Eju
         9L2cu7acxqXlDzOSiE0unN72my1r/ZMCdywxR4RxMjYRAio/6SumvMv8Tqpk0fIsH4QM
         ygNTT+NYMsmUEvH0yhudY0I51MhCgyxCL+lybmBHqA653U1H1+bAXYedb9mUlWUfP590
         aJ5O3sEebg3J4WVdLOUWxTr4onsP0/K4kA/ajnTA8Q6P1dKZc0hrkI8IoETttyOqvitO
         yZo80KrXU/jpSFiOrwuYKtlc2zK7999HM2a/T2OPm9nVgDJdC7kocN8TJrxrH/FkXGL4
         5Ppw==
X-Gm-Message-State: AOAM5330DcH4Gna7Z+YNZ94Arwj3Yo2v36AVG3u8oEaSv4ajrnsS1ssG
        +UGKPgaM4ImtXBAg+F/MI5ZVkR5qvr0=
X-Google-Smtp-Source: ABdhPJzQs3OXZ9T0DPB3qeLva6AvhCt+a0g4usImFmPjG4sqCtLg8zQFe32vuM8MCLW1Il8ahNXRfg==
X-Received: by 2002:a1c:7e15:: with SMTP id z21mr29952373wmc.21.1600695053904;
        Mon, 21 Sep 2020 06:30:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u17sm19284160wmm.4.2020.09.21.06.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 06:30:53 -0700 (PDT)
Message-Id: <7f851e7c20aafdae5d5ae46ee1083b32ecc82c84.1600695050.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.736.git.1600695050.gitgitgadget@gmail.com>
References: <pull.736.git.1600695050.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Sep 2020 13:30:50 +0000
Subject: [PATCH 3/3] commit: add an option the reword HEAD
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If one notices a typo in the last commit after starting to stage
changes for the next commit it is useful to be able to reword the last
commit without changing its contents. Currently the way to do that is
by specifying --amend --only with no pathspec which is not that
obvious to new users (so much so that before beb635ca9c ("commit:
remove 'Clever' message for --only --amend", 2016-12-09) commit
printed a message to congratulate the user on figuring out how to do
it). If the last commit is empty one has to pass --allow-empty as well
even though the contents are not being changed. This commits adds a
--reword option for commit that rewords the last commit without
changing its contents.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 Documentation/git-commit.txt          | 14 ++++++-
 builtin/commit.c                      | 46 +++++++++++++++++++++-
 t/t7501-commit-basic-functionality.sh | 56 +++++++++++++++++++++++++++
 3 files changed, 113 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 9de4dc5d66..8ec87ecb6b 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -8,7 +8,7 @@ git-commit - Record changes to the repository
 SYNOPSIS
 --------
 [verse]
-'git commit' [-a | --interactive | --patch] [--amend]
+'git commit' [-a | --interactive | --patch] [--amend | --reword]
 	   [(-c | -C | --fixup | --squash) <commit>] [-F <file> | -m <msg>]
 	   [--allow-empty] [--allow-empty-message] [--no-verify] [-e]
 	   [--reset-author] [--author=<author>] [--date=<date>]
@@ -99,7 +99,7 @@ OPTIONS
 	linkgit:git-rebase[1] for details.
 
 --reset-author::
-	When used with `-C`/`-c`/`--amend` options, or when committing
+	When used with `-C`/`-c`/`--amend`/`--reword` options, or when committing
 	after a conflicting cherry-pick, declare that the authorship of
 	the resulting commit now belongs to the committer. This also
 	renews the author timestamp.
@@ -229,6 +229,16 @@ variable (see linkgit:git-config[1]).
 	For example, `git commit --amend --no-edit` amends a commit
 	without changing its commit message.
 
+--reword::
+	Reword the commit message of the tip of the current branch by
+	replacing it with a new commit. The commit contents will be
+	unchanged even if there are staged changes. This is equivalent
+	to specifying `--amend --only --allow-empty` with no paths.
++
+You should understand the implications of rewriting history if you
+reword a commit that has already been published.  (See the "RECOVERING
+FROM UPSTREAM REBASE" section in linkgit:git-rebase[1].)
+
 --amend::
 	Replace the tip of the current branch by creating a new
 	commit. The recorded tree is prepared as usual (including
diff --git a/builtin/commit.c b/builtin/commit.c
index 5d91b13a5c..f7913f771a 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -107,6 +107,7 @@ static const char *author_message, *author_message_buffer;
 static char *edit_message, *use_message;
 static char *fixup_message, *squash_message;
 static int all, also, interactive, patch_interactive, only, amend, signoff;
+static int reword;
 static int edit_flag = -1; /* unspecified */
 static int quiet, verbose, no_verify, allow_empty, dry_run, renew_authorship;
 static int config_commit_verbose = -1; /* unspecified */
@@ -1152,6 +1153,41 @@ static void finalize_deferred_config(struct wt_status *s)
 		s->ahead_behind_flags = AHEAD_BEHIND_FULL;
 }
 
+static void validate_reword_options(int argc, struct commit *current_head)
+{
+	if (!current_head)
+		die(_("You have nothing to reword."));
+	if (whence != FROM_COMMIT) {
+		if (whence == FROM_MERGE)
+			die(_("You are in the middle of a merge -- cannot "
+			      "reword."));
+		else if (is_from_cherry_pick(whence))
+			die(_("You are in the middle of a cherry-pick -- cannot"
+			      " reword."));
+		else if (is_from_rebase(whence))
+			die(_("You are in the middle of a rebase -- cannot "
+			      "reword."));
+	}
+	if (amend)
+		die(_("cannot combine --reword with --amend"));
+	if (argc)
+		die(_("cannot combine --reword with paths"));
+	if (interactive)
+		die(_("cannot combine --reword with --interactive"));
+	if (patch_interactive)
+		die(_("cannot combine --reword with --patch"));
+	if (all)
+		die(_("cannot combine --reword with --all"));
+	if (also)
+		die(_("cannot combine --reword with --include"));
+	if (only)
+		die(_("cannot combine --reword with --only"));
+	if (!edit_flag && !force_author && !force_date && !renew_authorship &&
+	    !use_message && !edit_message && !fixup_message &&
+	    !squash_message && !logfile && !have_option_m && !signoff)
+		die(_("cannot combine --reword with --no-edit"));
+}
+
 static int parse_and_validate_options(int argc, const char *argv[],
 				      const struct option *options,
 				      const char * const usage[],
@@ -1186,6 +1222,12 @@ static int parse_and_validate_options(int argc, const char *argv[],
 		else if (whence == FROM_REBASE_PICK)
 			die(_("You are in the middle of a rebase -- cannot amend."));
 	}
+	if (reword) {
+		validate_reword_options(argc, current_head);
+		amend = 1;
+		only = 1;
+		allow_empty = 1;
+	}
 	if (fixup_message && squash_message)
 		die(_("Options --squash and --fixup cannot be used together"));
 	if (use_message)
@@ -1208,7 +1250,8 @@ static int parse_and_validate_options(int argc, const char *argv[],
 		use_message = "HEAD";
 	if (!use_message && !is_from_cherry_pick(whence) &&
 	    !is_from_rebase(whence) && renew_authorship)
-		die(_("--reset-author can be used only with -C, -c or --amend."));
+		die(_("--reset-author can be used only with -C, -c, --amend "
+		      "or --reword."));
 	if (use_message) {
 		use_message_buffer = read_commit_message(use_message);
 		if (!renew_authorship) {
@@ -1537,6 +1580,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		OPT_BOOL('z', "null", &s.null_termination,
 			 N_("terminate entries with NUL")),
 		OPT_BOOL(0, "amend", &amend, N_("amend previous commit")),
+		OPT_BOOL(0, "reword", &reword, N_("reword the previous commit")),
 		OPT_BOOL(0, "no-post-rewrite", &no_post_rewrite, N_("bypass post-rewrite hook")),
 		{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg, N_("mode"), N_("show untracked files, optional modes: all, normal, no. (Default: all)"), PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
 		OPT_PATHSPEC_FROM_FILE(&pathspec_from_file),
diff --git a/t/t7501-commit-basic-functionality.sh b/t/t7501-commit-basic-functionality.sh
index 110b4bf459..1ea65b426a 100755
--- a/t/t7501-commit-basic-functionality.sh
+++ b/t/t7501-commit-basic-functionality.sh
@@ -713,4 +713,60 @@ test_expect_success '--dry-run --short' '
 	git commit --dry-run --short
 '
 
+test_expect_success '--reword does not commit staged changes' '
+	echo changed >file &&
+	git add file &&
+	cat >expect <<-EOF &&
+	$(git log -1 --pretty=format:%B HEAD)
+
+	reworded
+	EOF
+	GIT_EDITOR="printf reworded >>" git commit --reword &&
+	git log -1 --pretty=format:%B >actual &&
+	test_cmp expect actual &&
+	test_cmp_rev HEAD@{1}^{tree} HEAD^{tree} &&
+	test_cmp_rev HEAD@{1}^ HEAD^ &&
+	git cat-file blob :file >actual &&
+	test_cmp file actual
+'
+
+test_reword_opt () {
+	test_expect_success C_LOCALE_OUTPUT "--reword incompatible with $1" "
+		echo 'fatal: cannot combine --reword with $1' >expect &&
+		test_must_fail git commit --reword $1 2>actual &&
+		test_cmp expect actual
+	"
+}
+
+for opt in --all --amend --include --interactive --only --patch --no-edit
+do
+	test_reword_opt $opt
+done
+
+test_expect_success C_LOCALE_OUTPUT '--reword with paths' '
+	echo "fatal: cannot combine --reword with paths" >expect &&
+	test_must_fail git commit --reword file 2>actual &&
+	test_cmp expect actual
+'
+
+test_reword_no_edit () {
+	test_expect_success "--reword $@ --no-edit" '
+		git commit --reword '"$@"' --no-edit
+	'
+}
+
+for opt in -mmessage -CHEAD^ -cHEAD --reset-author \
+		"--author=\"Commit Author <commit.author@example.com>\"" \
+		--date=yesterday --fixup=HEAD^ --squash=HEAD^ --signoff
+do
+	test_reword_no_edit "$opt"
+done
+
+test_expect_success '--reword -F' '
+	echo reworded >msg &&
+	git commit --reword -F msg --no-edit &&
+	git log -1 --pretty=format:%B >actual &&
+	test_cmp msg actual
+'
+
 test_done
-- 
gitgitgadget
