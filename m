Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F75C4167B
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 19:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 091A423127
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 19:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgLETyG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Dec 2020 14:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgLETyD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Dec 2020 14:54:03 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF82C0613D4
        for <git@vger.kernel.org>; Sat,  5 Dec 2020 11:53:16 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id l200so10476772oig.9
        for <git@vger.kernel.org>; Sat, 05 Dec 2020 11:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p0oAJI/gwVBDFtcF3Zl7guRfcEu3rA898yi1SB7nRAM=;
        b=SX96mqLyqBehIiFbGJOvIawzYsh2lH+rU77UlqZVAv+LqJ819YLDYYM2U7l8jd00Bz
         Bd34Dyho3Y2oLFeOsEElhB9vEe66TD7S0VxRqqsSh7VbYWeA5D9gd+Yi6RF8IkiMUApb
         162XxAp6Uq0ZZlkooCa+hjAthDogP85F1755ImVX0DzNiHsouxiVUxf2SFim4N9lVzhb
         8J8VCJudcKZJVMYn99OmBO1bmskwCzkgNGLX5o34uU/KlErV5mo1eYAEbknY7SmXQ1Sd
         UOBxVc/gph2gPyy7ylGsRI9M6AwoH6UX/LmEg148iZEJhTo4xIpDYJRkMZKSByXX1pUv
         myiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p0oAJI/gwVBDFtcF3Zl7guRfcEu3rA898yi1SB7nRAM=;
        b=amSJcN192M8hWrUsnv29RMoKFpOsjFtfevcjBDTL85GGclDfx/1oP+33NR7/6la2f+
         NDnH2gyKRbWzgRo25xCWdc0iAYo9F0NwTErGebxfhJeOGmKFMRdzii+rp9TnEIsKqgmM
         0uhlsHEyJwJGk449gBQwwdw6CfaAMmPHG+junnZ0MjYFGt9IdQemfiQzYTn9+a1KtS8n
         lZM6CVIql+DBAokokYBZb9xi14h+0rY9PWIhFRA3SDGfUwj8Lu1bYZUk0nAQjjm2Mwfq
         CEoZxJOXNhiQcane3HQlvIwCtqD0S1GVhMG50AQw4t2iE3JZuRsjB4AekpbqzH7mSsKr
         bjOw==
X-Gm-Message-State: AOAM532JC1Jzidk5e3rDuslj2vLa8GLM4oRpyP09rvZZXcDm0ZF2bYa6
        Sxq5nSnlHm/CbTNyCTnTXgBizBk6Uk6C1w==
X-Google-Smtp-Source: ABdhPJy0nOx7N9YpE7797gjASKfCO1UCVaLQm9NzhCRhhtsBEVfdCgdWWm5XD0uHHTaHte7bgfKsfg==
X-Received: by 2002:a05:6808:5:: with SMTP id u5mr7448567oic.18.1607197995699;
        Sat, 05 Dec 2020 11:53:15 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id h2sm1519981otn.15.2020.12.05.11.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 11:53:15 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 00/16] pull: default warning improvements
Date:   Sat,  5 Dec 2020 13:52:57 -0600
Message-Id: <20201205195313.1557473-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The old thread "Pull is Mostly Evil" [1] came to haunt us back again.

The main solution--reject non-fast-forward merges by default--seems to have lost traction (again).

There are multiple approaches floating around, but no clear path forward.

This patch series attempts to fix as much as possible of the current situation without committing to
any particular solution.

It does:

1. Improve the current documentation
2. Improve the current default warning
3. Minimize the instances where we display the default warning
4. Add a --merge option
5. Improve the error message with --ff-only
6. Fix the behavior of the warning with --ff

And tentatively (and this should be the only controversial change):

7. Change the semantics of --ff-only

It does not:

* Introduce the suggested pull.mode
* Change the current default (still --ff)

It is not a complete solution, but should improve the current situation.

Since v2:

1. The warning is updated to say "a merge, a rebase, or a fast-forward"
2. A suggestion 'If unsure, run "git pull --merge".' is removed
3. A new REBASE_DEFAULT is introduced
4. Tests are revamped using helpers
5. The logic of --merge and --ff-only is updated so one can override the other
6. A bunch of commit messages are updated
7. A memory inconsistency is fixed

[1] https://lore.kernel.org/git/5363BB9F.40102@xiplink.com/

diff --git a/builtin/pull.c b/builtin/pull.c
index e389ffcdc3..0735c77f42 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -27,8 +27,6 @@
 #include "commit-reach.h"
 #include "sequencer.h"
 
-static int default_mode;
-
 /**
  * Parses the value of --rebase. If value is a false value, returns
  * REBASE_FALSE. If value is a true value, returns REBASE_TRUE. If value is
@@ -76,7 +74,7 @@ static char *opt_progress;
 static int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
 
 /* Options passed to git-merge or git-rebase */
-static enum rebase_type opt_rebase = -1;
+static enum rebase_type opt_rebase;
 static char *opt_diffstat;
 static char *opt_log;
 static char *opt_signoff;
@@ -114,6 +112,24 @@ static int opt_show_forced_updates = -1;
 static char *set_upstream;
 static struct strvec opt_fetch = STRVEC_INIT;
 
+static int parse_opt_ff_only(const struct option *opt, const char *arg, int unset)
+{
+	char **value = opt->value;
+	opt_rebase = REBASE_DEFAULT;
+	free(*value);
+	*value = xstrdup_or_null("--ff-only");
+	return 0;
+}
+
+static int parse_opt_merge(const struct option *opt, const char *arg, int unset)
+{
+	enum rebase_type *value = opt->value;
+	free(opt_ff);
+	opt_ff = NULL;
+	*value = REBASE_FALSE;
+	return 0;
+}
+
 static struct option pull_options[] = {
 	/* Shared options */
 	OPT__VERBOSITY(&opt_verbosity),
@@ -131,8 +147,9 @@ static struct option pull_options[] = {
 		"(false|true|merges|preserve|interactive)",
 		N_("incorporate changes by rebasing rather than merging"),
 		PARSE_OPT_OPTARG, parse_opt_rebase),
-	OPT_SET_INT('m', "merge", &opt_rebase,
-		N_("incorporate changes by merging"), 0),
+	OPT_CALLBACK_F('m', "merge", &opt_rebase, NULL,
+		N_("incorporate changes by merging"),
+		PARSE_OPT_NOARG | PARSE_OPT_NONEG, parse_opt_merge),
 	OPT_PASSTHRU('n', NULL, &opt_diffstat, NULL,
 		N_("do not show a diffstat at the end of the merge"),
 		PARSE_OPT_NOARG | PARSE_OPT_NONEG),
@@ -161,9 +178,9 @@ static struct option pull_options[] = {
 	OPT_PASSTHRU(0, "ff", &opt_ff, NULL,
 		N_("allow fast-forward"),
 		PARSE_OPT_NOARG),
-	OPT_PASSTHRU(0, "ff-only", &opt_ff, NULL,
+	OPT_CALLBACK_F(0, "ff-only", &opt_ff, NULL,
 		N_("abort if fast-forward is not possible"),
-		PARSE_OPT_NOARG | PARSE_OPT_NONEG),
+		PARSE_OPT_NOARG | PARSE_OPT_NONEG, parse_opt_ff_only),
 	OPT_PASSTHRU(0, "verify-signatures", &opt_verify_signatures, NULL,
 		N_("verify that the named commit has a valid GPG signature"),
 		PARSE_OPT_NOARG),
@@ -348,9 +365,7 @@ static enum rebase_type config_get_rebase(void)
 	if (!git_config_get_value("pull.rebase", &value))
 		return parse_config_rebase("pull.rebase", value, 1);
 
-	default_mode = 1;
-
-	return REBASE_FALSE;
+	return REBASE_DEFAULT;
 }
 
 /**
@@ -445,7 +460,7 @@ static void NORETURN die_no_merge_candidates(const char *repo, const char **refs
 	const char *remote = curr_branch ? curr_branch->remote_name : NULL;
 
 	if (*refspecs) {
-		if (opt_rebase)
+		if (opt_rebase >= REBASE_TRUE)
 			fprintf_ln(stderr, _("There is no candidate for rebasing against among the refs that you just fetched."));
 		else
 			fprintf_ln(stderr, _("There are no candidates for merging among the refs that you just fetched."));
@@ -458,7 +473,7 @@ static void NORETURN die_no_merge_candidates(const char *repo, const char **refs
 			repo);
 	} else if (!curr_branch) {
 		fprintf_ln(stderr, _("You are not currently on a branch."));
-		if (opt_rebase)
+		if (opt_rebase >= REBASE_TRUE)
 			fprintf_ln(stderr, _("Please specify which branch you want to rebase against."));
 		else
 			fprintf_ln(stderr, _("Please specify which branch you want to merge with."));
@@ -473,7 +488,7 @@ static void NORETURN die_no_merge_candidates(const char *repo, const char **refs
 			remote_name = _("<remote>");
 
 		fprintf_ln(stderr, _("There is no tracking information for the current branch."));
-		if (opt_rebase)
+		if (opt_rebase >= REBASE_TRUE)
 			fprintf_ln(stderr, _("Please specify which branch you want to rebase against."));
 		else
 			fprintf_ln(stderr, _("Please specify which branch you want to merge with."));
@@ -919,6 +934,9 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	struct object_id rebase_fork_point;
 	int can_ff;
 
+	opt_ff = xstrdup_or_null(config_get_ff());
+	opt_rebase = config_get_rebase();
+
 	if (!getenv("GIT_REFLOG_ACTION"))
 		set_reflog_message(argc, argv);
 
@@ -935,12 +953,6 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 	parse_repo_refspecs(argc, argv, &repo, &refspecs);
 
-	if (!opt_ff)
-		opt_ff = xstrdup_or_null(config_get_ff());
-
-	if (opt_rebase < 0)
-		opt_rebase = config_get_rebase();
-
 	if (read_cache_unmerged())
 		die_resolve_conflict("pull");
 
@@ -950,7 +962,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (get_oid("HEAD", &orig_head))
 		oidclr(&orig_head);
 
-	if (opt_rebase) {
+	if (opt_rebase >= REBASE_TRUE) {
 		int autostash = config_autostash;
 		if (opt_autostash != -1)
 			autostash = opt_autostash;
@@ -1010,19 +1022,18 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 			die(_("Cannot merge multiple branches into empty head."));
 		return pull_into_void(merge_heads.oid, &curr_head);
 	}
-	if (opt_rebase && merge_heads.nr > 1)
+	if (opt_rebase >= REBASE_TRUE && merge_heads.nr > 1)
 		die(_("Cannot rebase onto multiple branches."));
 
 	can_ff = get_can_ff(&orig_head, &merge_heads.oid[0]);
 
-	if (!can_ff && default_mode) {
-		if (opt_ff && !strcmp(opt_ff, "--ff-only")) {
-			die(_("The pull was not fast-forward, please either merge or rebase.\n"
-				"If unsure, run \"git pull --merge\"."));
-		}
+	if (!can_ff && !opt_rebase) {
+		if (opt_ff && !strcmp(opt_ff, "--ff-only"))
+			die(_("The pull was not fast-forward, please either merge or rebase."));
+
 		if (opt_verbosity >= 0 && (!opt_ff || !strcmp(opt_ff, "--ff"))) {
-			advise(_("Pulling without specifying how to reconcile divergent branches is\n"
-				"discouraged; you need to specify if you want a merge, or a rebase.\n"
+			advise(_("Pulling without specifying how to reconcile divergent branches is discouraged;\n"
+				"you need to specify if you want a merge, a rebase, or a fast-forward.\n"
 				"You can squelch this message by running one of the following commands:\n"
 				"\n"
 				"  git config pull.rebase false  # merge (the default strategy)\n"
@@ -1037,11 +1048,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	/* Disable --ff-only when --merge is specified */
-	if (!can_ff && !default_mode && !opt_rebase && opt_ff && !strcmp(opt_ff, "--ff-only"))
-		opt_ff = NULL;
-
-	if (opt_rebase) {
+	if (opt_rebase >= REBASE_TRUE) {
 		int ret = 0;
 		if ((recurse_submodules == RECURSE_SUBMODULES_ON ||
 		     recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND) &&
@@ -1050,7 +1057,8 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 		if (can_ff) {
 			/* we can fast-forward this without invoking rebase */
-			opt_ff = "--ff-only";
+			free(opt_ff);
+			opt_ff = xstrdup_or_null("--ff-only");
 			ret = run_merge();
 		} else {
 			ret = run_rebase(&curr_head, merge_heads.oid, &rebase_fork_point);
diff --git a/rebase.h b/rebase.h
index cc723d4748..34d4acfd74 100644
--- a/rebase.h
+++ b/rebase.h
@@ -3,7 +3,8 @@
 
 enum rebase_type {
 	REBASE_INVALID = -1,
-	REBASE_FALSE = 0,
+	REBASE_DEFAULT = 0,
+	REBASE_FALSE,
 	REBASE_TRUE,
 	REBASE_PRESERVE,
 	REBASE_MERGES,
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index eec6224fb0..0cdac4010b 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -819,66 +819,89 @@ test_expect_success 'git pull --rebase against local branch' '
 	test_cmp expect file2
 '
 
-test_expect_success 'git pull fast-forward (ff-only)' '
+setup_other () {
 	test_when_finished "git checkout master && git branch -D other test" &&
-	test_config pull.ff only &&
-	git checkout -b other master &&
+	git checkout -b other $1 &&
 	>new &&
 	git add new &&
 	git commit -m new &&
 	git checkout -b test -t other &&
-	git reset --hard master &&
+	git reset --hard master
+}
+
+setup_ff () {
+	setup_other master
+}
+
+setup_non_ff () {
+	setup_other master^
+}
+
+test_expect_success 'fast-forward (ff-only)' '
+	test_config pull.ff only &&
+	setup_ff &&
 	git pull
 '
 
-test_expect_success 'git pull non-fast-forward (ff-only)' '
-	test_when_finished "git checkout master && git branch -D other test" &&
+test_expect_success 'non-fast-forward (ff-only)' '
 	test_config pull.ff only &&
-	git checkout -b other master^ &&
-	>new &&
-	git add new &&
-	git commit -m new &&
-	git checkout -b test -t other &&
-	git reset --hard master &&
+	setup_non_ff &&
 	test_must_fail git pull
 '
 
-test_expect_success 'git pull non-fast-forward with merge (ff-only)' '
-	test_when_finished "git checkout master && git branch -D other test" &&
+test_expect_success 'non-fast-forward with merge (ff-only)' '
 	test_config pull.ff only &&
-	git checkout -b other master^ &&
-	>new &&
-	git add new &&
-	git commit -m new &&
-	git checkout -b test -t other &&
-	git reset --hard master &&
-	git pull --no-rebase
+	setup_non_ff &&
+	git pull --merge
 '
 
-test_expect_success 'git pull non-fast-forward with rebase (ff-only)' '
-	test_when_finished "git checkout master && git branch -D other test" &&
+test_expect_success 'non-fast-forward with rebase (ff-only)' '
 	test_config pull.ff only &&
-	git checkout -b other master^ &&
-	>new &&
-	git add new &&
-	git commit -m new &&
-	git checkout -b test -t other &&
-	git reset --hard master &&
+	setup_non_ff &&
 	git pull --rebase
 '
 
-test_expect_success 'git pull non-fast-forward error message' '
-	test_when_finished "git checkout master && git branch -D other test" &&
+test_expect_success 'non-fast-forward error message (ff-only)' '
 	test_config pull.ff only &&
-	git checkout -b other master^ &&
-	>new &&
-	git add new &&
-	git commit -m new &&
-	git checkout -b test -t other &&
-	git reset --hard master &&
+	setup_non_ff &&
 	test_must_fail git pull 2> error &&
 	cat error &&
 	grep -q "The pull was not fast-forward" error
 '
 
+test_expect_success '--merge overrides --ff-only' '
+	setup_non_ff &&
+	git pull --ff-only --merge
+'
+
+test_expect_success '--rebase overrides --ff-only' '
+	setup_non_ff &&
+	git pull --ff-only --rebase
+'
+
+test_expect_success '--ff-only overrides --merge' '
+	setup_non_ff &&
+	test_must_fail git pull --merge --ff-only
+'
+
+test_expect_success '--ff-only overrides pull.rebase=false' '
+	test_config pull.rebase false &&
+	setup_non_ff &&
+	test_must_fail git pull --ff-only
+'
+
+test_expect_success 'pull.rebase=true overrides pull.ff=only' '
+	test_config pull.ff only &&
+	test_config pull.rebase true &&
+	setup_non_ff &&
+	git pull
+'
+
+test_expect_success 'pull.rebase=false overrides pull.ff=only' '
+	test_config pull.ff only &&
+	test_config pull.rebase false &&
+	setup_non_ff &&
+	test_must_fail git pull
+'
+
 test_done


Felipe Contreras (16):
  doc: pull: explain what is a fast-forward
  pull: improve default warning
  pull: refactor fast-forward check
  pull: cleanup autostash check
  pull: trivial cleanup
  pull: move default warning
  pull: display default warning only when non-ff
  pull: trivial whitespace style fix
  pull: introduce --merge option
  pull: show warning with --ff
  rebase: add REBASE_DEFAULT
  pull: move configurations fetches
  pull: add proper error with --ff-only
  test: merge-pull-config: trivial cleanup
  test: pull-options: revert unnecessary changes
  pull: trivial memory fix

 Documentation/git-pull.txt   |  24 +++++-
 builtin/pull.c               | 140 +++++++++++++++++++++--------------
 rebase.h                     |   3 +-
 t/t5520-pull.sh              |  85 +++++++++++++++++++++
 t/t5521-pull-options.sh      |  22 +++---
 t/t7601-merge-pull-config.sh |  35 +++++----
 6 files changed, 224 insertions(+), 85 deletions(-)

-- 
2.29.2

