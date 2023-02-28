Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3131FC64EC7
	for <git@archiver.kernel.org>; Tue, 28 Feb 2023 14:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjB1OCo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Feb 2023 09:02:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjB1OCn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2023 09:02:43 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590B72B607
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 06:02:40 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id h18-20020a4abb92000000b00525397f569fso1565950oop.3
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 06:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sdExZwDucoBG92K0yr3nXw560kZfIeehpV7rRQRHpf4=;
        b=lSIrEhKzhIw75l+p8iEp9ylbqcDJlpJeKS3jD52yl4XE+ZOLKr557bNQKQWrA6uAjF
         mTfVUhLpce1z0j/zYdXCaPCcc/rT0Q1gJXyYL4VAGezt+OWGJWPaFbXL2EYb2mV4TbiI
         cLPHb9DHBIZdBIUUyUuF7VwEqvoKNvIh64kXG6kZxIuUMQdAWrFv9DIGjoAB5A7Jd9V/
         QbtW0oPEepejzQY2NmMuhZLPj4pKwqNLr3AIQ3HNweTw4EO6lAe5u9L1KFJ3eqKfi0/E
         rGmXbw7XUdBUwdzY6e0z+eQug5vAPgpCXhqldy7HP0ZoDwtrfX7zJ7Qe+7CzuMuBPoM0
         YJ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sdExZwDucoBG92K0yr3nXw560kZfIeehpV7rRQRHpf4=;
        b=FesyujCV0LPto5pHpiiS+9eDhRKbwJ2MGz/ziCUn+RA+5VYLItXJO9zF2OZ2PucTlx
         XVuQ3mw2KDD6FHiLalix5t8P1uOmZSBOOYEeNLFoQn7UDl7w4oFoCwgEDFhPxtRCTYHg
         SG4MrWTYwjXcGB7dBhR96JEVTjA5S5H77QoGSnEOLqUOCndH5hvz3mjCauJ645Xvg4NH
         wxa/25ChHK4P4gWqYLmPS5Jk45HepV5fmlAbgYBGidh3IB7zLTAWLF9SS3yS9or3Alxz
         K84ShPT5zC1MdVlzRL60e8DaKBRt0wqx0jZXd6uBmzp0YJ6IEWdNtbLEo3if4v+9Q485
         VWHg==
X-Gm-Message-State: AO0yUKVUE5rJc3cn4ZDpAWpjaf5P/KiUK4c+W7/BYS70rAb7yoXi0qdi
        jFoFDYO22DNlnatFMF4NPPJbs81TqVE=
X-Google-Smtp-Source: AK7set/eykZoC+sbIe8WExSmvJ6gT6HsqC+aUTjfoOjaPFxm39JfOmj7eRsvo9P0hSkUcpg2AjmPWA==
X-Received: by 2002:a4a:edca:0:b0:51a:9982:3bb4 with SMTP id m10-20020a4aedca000000b0051a99823bb4mr1354666ooh.2.1677592959061;
        Tue, 28 Feb 2023 06:02:39 -0800 (PST)
Received: from localhost ([2806:2f0:4060:3465:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id d9-20020a9d51c9000000b006941ecefc34sm313561oth.18.2023.02.28.06.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 06:02:38 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>, Sergey Organov <sorganov@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH 1/2] Add pull.mode
Date:   Tue, 28 Feb 2023 08:02:35 -0600
Message-Id: <20230228140236.4175835-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230228140236.4175835-1-felipe.contreras@gmail.com>
References: <20230228140236.4175835-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The evolution of pull options has somewhat served most users, however,
they have been found lacking for a very needed trio: merge / rebase /
fast-forward-only.

To avoid some of the problems of git pull Linus Torvalds suggested a
configuration pull.merge [1], however, instead of having pull.merge and
pull.rebase, we can have pull.mode which works for both.

Many people have argued that `git pull` should have a per-branch
configuration for its mode of operation (e.g. Linus Torvalds [1] and
Theodore Ts'o [2]).

branch.<name>.pullMode achieves that.

Some discussions about pull.mode = fast-forward:

https://lore.kernel.org/git/742df4c2-2bc5-8a4b-8de1-cd5e48718398@redhat.com/
https://lore.kernel.org/git/20130522115042.GA20649@inner.h.apk.li
https://lore.kernel.org/git/1377988690-23460-1-git-send-email-felipe.contreras@gmail.com
https://lore.kernel.org/git/4ay6w9i74cygt6ii1b0db7wg.1398433713382@email.android.com

This is a squash of the following patches:

 * pull: reorganize mode conditionals
 * pull: improve default warning
 * pull: add pull.mode=fast-forward
 * pull: add per-branch mode configuration
 * pull: add pull.mode
 * pull: introduce --merge option
 * rebase: add REBASE_DEFAULT

[1] https://lore.kernel.org/git/CA+55aFz2Uvq4vmyjJPao5tS-uuVvKm6mbP7Uz8sdq1VMxMGJCw@mail.gmail.com/
[2] https://lore.kernel.org/git/20130312212027.GE14792@thunk.org/

Cc: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/config/branch.txt |   5 ++
 Documentation/config/pull.txt   |   6 ++
 Documentation/git-pull.txt      |  15 ++--
 builtin/pull.c                  | 147 +++++++++++++++++++++-----------
 rebase.c                        |  12 +++
 rebase.h                        |  13 ++-
 t/t7601-merge-pull-config.sh    |  30 +++----
 7 files changed, 158 insertions(+), 70 deletions(-)

diff --git a/Documentation/config/branch.txt b/Documentation/config/branch.txt
index 445341a906..035e7c1fe4 100644
--- a/Documentation/config/branch.txt
+++ b/Documentation/config/branch.txt
@@ -96,6 +96,11 @@ mode.
 it unless you understand the implications (see linkgit:git-rebase[1]
 for details).
 
+branch.<name>.pullMode::
+	When `git pull` is run, this determines the mode of operation,
+	possible values are 'fast-forward', 'merge', and 'rebase'.
+	See `pull.mode` for doing this in a non branch-specific manner.
+
 branch.<name>.description::
 	Branch description, can be edited with
 	`git branch --edit-description`. Branch description is
diff --git a/Documentation/config/pull.txt b/Documentation/config/pull.txt
index 9349e09261..596a9a504b 100644
--- a/Documentation/config/pull.txt
+++ b/Documentation/config/pull.txt
@@ -25,6 +25,12 @@ mode.
 it unless you understand the implications (see linkgit:git-rebase[1]
 for details).
 
+pull.mode::
+	When "git pull" is run, this determines if it would either merge or
+	rebase the fetched branch. The possible values are 'merge',
+	'rebase', and 'fast-forward'. See "branch.<name>.pullMode" for setting
+	this on a per-branch basis.
+
 pull.octopus::
 	The default merge strategy to use when pulling multiple branches
 	at once.
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 0e14f8b5b2..e961439936 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -17,10 +17,10 @@ DESCRIPTION
 
 Incorporates changes from a remote repository into the current branch.
 If the current branch is behind the remote, then by default it will
-fast-forward the current branch to match the remote.  If the current
-branch and the remote have diverged, the user needs to specify how to
-reconcile the divergent branches with `--rebase` or `--no-rebase` (or
-the corresponding configuration option in `pull.rebase`).
+fast-forward the current branch to match the remote.
+
+By default non-fast-forward merges fail, so you need to specify if you want to
+do a merge or a rebase.
 
 More precisely, `git pull` runs `git fetch` with the given parameters
 and then depending on configuration options or command line flags,
@@ -130,8 +130,11 @@ It rewrites history, which does not bode well when you
 published that history already.  Do *not* use this option
 unless you have read linkgit:git-rebase[1] carefully.
 
---no-rebase::
-	This is shorthand for --rebase=false.
+-m::
+--merge::
+	Force a merge.
++
+Previously this was --no-rebase, but that usage has been deprecated.
 
 Options related to fetching
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/builtin/pull.c b/builtin/pull.c
index 1ab4de0005..0531328e2f 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -28,6 +28,8 @@
 #include "sequencer.h"
 #include "packfile.h"
 
+static enum pull_mode_type mode;
+
 /**
  * Parses the value of --rebase. If value is a false value, returns
  * REBASE_FALSE. If value is a true value, returns REBASE_TRUE. If value is
@@ -49,6 +51,14 @@ static enum rebase_type parse_config_rebase(const char *key, const char *value,
 	return REBASE_INVALID;
 }
 
+static enum pull_mode_type parse_config_pull_mode(const char *key, const char *value)
+{
+	enum pull_mode_type v = pull_mode_parse_value(value);
+	if (v == PULL_MODE_INVALID)
+		die(_("Invalid value for %s: %s"), key, value);
+	return v;
+}
+
 /**
  * Callback for --rebase, which parses arg with parse_config_rebase().
  */
@@ -60,9 +70,21 @@ static int parse_opt_rebase(const struct option *opt, const char *arg, int unset
 		*value = parse_config_rebase("--rebase", arg, 0);
 	else
 		*value = unset ? REBASE_FALSE : REBASE_TRUE;
+
+	if (*value > 0)
+		mode = *value >= REBASE_TRUE ? PULL_MODE_REBASE : PULL_MODE_MERGE;
+
 	return *value == REBASE_INVALID ? -1 : 0;
 }
 
+static int parse_opt_merge(const struct option *opt, const char *arg, int unset)
+{
+	enum rebase_type *value = opt->value;
+	mode = PULL_MODE_MERGE;
+	*value = REBASE_FALSE;
+	return 0;
+}
+
 static const char * const pull_usage[] = {
 	N_("git pull [<options>] [<repository> [<refspec>...]]"),
 	NULL
@@ -75,7 +97,7 @@ static int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
 static int recurse_submodules_cli = RECURSE_SUBMODULES_DEFAULT;
 
 /* Options passed to git-merge or git-rebase */
-static enum rebase_type opt_rebase = -1;
+static enum rebase_type opt_rebase;
 static char *opt_diffstat;
 static char *opt_log;
 static char *opt_signoff;
@@ -131,6 +153,9 @@ static struct option pull_options[] = {
 		"(false|true|merges|interactive)",
 		N_("incorporate changes by rebasing rather than merging"),
 		PARSE_OPT_OPTARG, parse_opt_rebase),
+	OPT_CALLBACK_F('m', "merge", &opt_rebase, NULL,
+		N_("incorporate changes by merging"),
+		PARSE_OPT_NOARG | PARSE_OPT_NONEG, parse_opt_merge),
 	OPT_PASSTHRU('n', NULL, &opt_diffstat, NULL,
 		N_("do not show a diffstat at the end of the merge"),
 		PARSE_OPT_NOARG | PARSE_OPT_NONEG),
@@ -329,7 +354,7 @@ static const char *config_get_ff(void)
  * looks for the value of "pull.rebase". If both configuration keys do not
  * exist, returns REBASE_FALSE.
  */
-static enum rebase_type config_get_rebase(int *rebase_unspecified)
+static enum rebase_type config_get_rebase(void)
 {
 	struct branch *curr_branch = branch_get("HEAD");
 	const char *value;
@@ -349,9 +374,30 @@ static enum rebase_type config_get_rebase(int *rebase_unspecified)
 	if (!git_config_get_value("pull.rebase", &value))
 		return parse_config_rebase("pull.rebase", value, 1);
 
-	*rebase_unspecified = 1;
+	return REBASE_DEFAULT;
+}
+
+static enum pull_mode_type config_get_pull_mode(const char *repo)
+{
+	struct branch *curr_branch = branch_get("HEAD");
+	const char *value;
+
+	if (curr_branch) {
+		char *key = xstrfmt("branch.%s.pullmode", curr_branch->name);
+
+		if (!git_config_get_value(key, &value)) {
+			enum pull_mode_type ret = parse_config_pull_mode(key, value);
+			free(key);
+			return ret;
+		}
+
+		free(key);
+	}
+
+	if (!git_config_get_value("pull.mode", &value))
+		return parse_config_pull_mode("pull.mode", value);
 
-	return REBASE_FALSE;
+	return PULL_MODE_DEFAULT;
 }
 
 /**
@@ -446,7 +492,7 @@ static void NORETURN die_no_merge_candidates(const char *repo, const char **refs
 	const char *remote = curr_branch ? curr_branch->remote_name : NULL;
 
 	if (*refspecs) {
-		if (opt_rebase)
+		if (opt_rebase >= REBASE_TRUE)
 			fprintf_ln(stderr, _("There is no candidate for rebasing against among the refs that you just fetched."));
 		else
 			fprintf_ln(stderr, _("There are no candidates for merging among the refs that you just fetched."));
@@ -459,7 +505,7 @@ static void NORETURN die_no_merge_candidates(const char *repo, const char **refs
 			repo);
 	} else if (!curr_branch) {
 		fprintf_ln(stderr, _("You are not currently on a branch."));
-		if (opt_rebase)
+		if (opt_rebase >= REBASE_TRUE)
 			fprintf_ln(stderr, _("Please specify which branch you want to rebase against."));
 		else
 			fprintf_ln(stderr, _("Please specify which branch you want to merge with."));
@@ -474,7 +520,7 @@ static void NORETURN die_no_merge_candidates(const char *repo, const char **refs
 			remote_name = _("<remote>");
 
 		fprintf_ln(stderr, _("There is no tracking information for the current branch."));
-		if (opt_rebase)
+		if (opt_rebase >= REBASE_TRUE)
 			fprintf_ln(stderr, _("Please specify which branch you want to rebase against."));
 		else
 			fprintf_ln(stderr, _("Please specify which branch you want to merge with."));
@@ -962,18 +1008,19 @@ static int already_up_to_date(struct object_id *orig_head,
 
 static void show_advice_pull_non_ff(void)
 {
-	advise(_("You have divergent branches and need to specify how to reconcile them.\n"
-		 "You can do so by running one of the following commands sometime before\n"
-		 "your next pull:\n"
+	advise(_("The pull wasn't a fast-forward, you have to choose between\n"
+		 "a merge or a rebase:\n"
+		 "\n"
+		 "  git pull --merge\n"
+		 "  git pull --rebase\n"
 		 "\n"
-		 "  git config pull.rebase false  # merge\n"
-		 "  git config pull.rebase true   # rebase\n"
-		 "  git config pull.ff only       # fast-forward only\n"
+		 "You can quell this message by running one of the following commands:\n"
 		 "\n"
-		 "You can replace \"git config\" with \"git config --global\" to set a default\n"
-		 "preference for all repositories. You can also pass --rebase, --no-rebase,\n"
-		 "or --ff-only on the command line to override the configured default per\n"
-		 "invocation.\n"));
+		 "  git config --global pull.mode merge\n"
+		 "  git config --global pull.mode rebase\n"
+		 "  git config --global pull.mode fast-forward\n"
+		 "\n"
+		 "For more information check \"git help fast-forward\"."));
 }
 
 int cmd_pull(int argc, const char **argv, const char *prefix)
@@ -982,11 +1029,13 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	struct oid_array merge_heads = OID_ARRAY_INIT;
 	struct object_id orig_head, curr_head;
 	struct object_id rebase_fork_point;
-	int rebase_unspecified = 0;
 	int can_ff;
 	int divergent;
 	int ret;
 
+	opt_ff = xstrdup_or_null(config_get_ff());
+	opt_rebase = config_get_rebase();
+
 	if (!getenv("GIT_REFLOG_ACTION"))
 		set_reflog_message(argc, argv);
 
@@ -1010,25 +1059,31 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 	parse_repo_refspecs(argc, argv, &repo, &refspecs);
 
-	if (!opt_ff) {
-		opt_ff = xstrdup_or_null(config_get_ff());
-		/*
-		 * A subtle point: opt_ff was set on the line above via
-		 * reading from config.  opt_rebase, in contrast, is set
-		 * before this point via command line options.  The setting
-		 * of opt_rebase via reading from config (using
-		 * config_get_rebase()) does not happen until later.  We
-		 * are relying on the next if-condition happening before
-		 * the config_get_rebase() call so that an explicit
-		 * "--rebase" can override a config setting of
-		 * pull.ff=only.
-		 */
-		if (opt_rebase >= 0 && opt_ff && !strcmp(opt_ff, "--ff-only"))
-			opt_ff = "--ff";
-	}
+	/*
+	 * If the user has not specified --merge or --rebase, fetch pull.mode to override
+	 * pull.rename.
+	 */
+	if (!mode) {
+		mode = config_get_pull_mode(repo);
 
-	if (opt_rebase < 0)
-		opt_rebase = config_get_rebase(&rebase_unspecified);
+		switch (mode) {
+		case PULL_MODE_MERGE:
+		case PULL_MODE_FAST_FORWARD:
+			opt_rebase = REBASE_FALSE;
+			break;
+		case PULL_MODE_REBASE:
+			/* Do not oeverride other rebase modes */
+			if (opt_rebase < REBASE_TRUE)
+				opt_rebase = REBASE_TRUE;
+			break;
+		case PULL_MODE_DEFAULT:
+			if (opt_rebase > 0)
+				mode = opt_rebase >= REBASE_TRUE ? PULL_MODE_REBASE : PULL_MODE_MERGE;
+			break;
+		default:
+			break;
+		}
+	}
 
 	if (repo_read_index_unmerged(the_repository))
 		die_resolve_conflict("pull");
@@ -1039,7 +1094,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (get_oid("HEAD", &orig_head))
 		oidclr(&orig_head);
 
-	if (opt_rebase) {
+	if (opt_rebase >= REBASE_TRUE) {
 		if (opt_autostash == -1)
 			opt_autostash = config_autostash;
 
@@ -1100,7 +1155,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		goto cleanup;
 	}
 	if (merge_heads.nr > 1) {
-		if (opt_rebase)
+		if (opt_rebase >= REBASE_TRUE)
 			die(_("Cannot rebase onto multiple branches."));
 		if (opt_ff && !strcmp(opt_ff, "--ff-only"))
 			die(_("Cannot fast-forward to multiple branches."));
@@ -1109,19 +1164,15 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	can_ff = get_can_ff(&orig_head, &merge_heads);
 	divergent = !can_ff && !already_up_to_date(&orig_head, &merge_heads);
 
-	/* ff-only takes precedence over rebase */
-	if (opt_ff && !strcmp(opt_ff, "--ff-only")) {
-		if (divergent)
+	if (divergent) {
+		if (!mode)
+			show_advice_pull_non_ff();
+
+		if (!mode || mode == PULL_MODE_FAST_FORWARD)
 			die_ff_impossible();
-		opt_rebase = REBASE_FALSE;
-	}
-	/* If no action specified and we can't fast forward, then warn. */
-	if (!opt_ff && rebase_unspecified && divergent) {
-		show_advice_pull_non_ff();
-		die(_("Need to specify how to reconcile divergent branches."));
 	}
 
-	if (opt_rebase) {
+	if (opt_rebase >= REBASE_TRUE) {
 		struct object_id newbase;
 		struct object_id upstream;
 		get_rebase_newbase_and_upstream(&newbase, &upstream, &curr_head,
diff --git a/rebase.c b/rebase.c
index 6775cddb28..4b9a5e2066 100644
--- a/rebase.c
+++ b/rebase.c
@@ -34,3 +34,15 @@ enum rebase_type rebase_parse_value(const char *value)
 
 	return REBASE_INVALID;
 }
+
+enum pull_mode_type pull_mode_parse_value(const char *value)
+{
+	if (!strcmp(value, "merge") || !strcmp(value, "m"))
+		return PULL_MODE_MERGE;
+	else if (!strcmp(value, "rebase") || !strcmp(value, "r"))
+		return PULL_MODE_REBASE;
+	else if (!strcmp(value, "fast-forward") || !strcmp(value, "f"))
+		return PULL_MODE_FAST_FORWARD;
+
+	return PULL_MODE_INVALID;
+}
diff --git a/rebase.h b/rebase.h
index 203b437282..bc2cd75f52 100644
--- a/rebase.h
+++ b/rebase.h
@@ -3,7 +3,8 @@
 
 enum rebase_type {
 	REBASE_INVALID = -1,
-	REBASE_FALSE = 0,
+	REBASE_DEFAULT = 0,
+	REBASE_FALSE,
 	REBASE_TRUE,
 	REBASE_MERGES,
 	REBASE_INTERACTIVE
@@ -11,4 +12,14 @@ enum rebase_type {
 
 enum rebase_type rebase_parse_value(const char *value);
 
+enum pull_mode_type {
+	PULL_MODE_INVALID = -1,
+	PULL_MODE_DEFAULT = 0,
+	PULL_MODE_MERGE,
+	PULL_MODE_REBASE,
+	PULL_MODE_FAST_FORWARD
+};
+
+enum pull_mode_type pull_mode_parse_value(const char *value);
+
 #endif /* REBASE */
diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index bd238d89b0..d1e3ecb68c 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -95,22 +95,22 @@ test_expect_success 'pull.rebase not set (not-fast-forward)' '
 test_expect_success 'pull.rebase not set and pull.ff=true (not-fast-forward)' '
 	git reset --hard c2 &&
 	test_config pull.ff true &&
-	git pull . c1 2>err &&
-	test_i18ngrep ! "You have divergent branches" err
+	test_must_fail git pull . c1 2>err &&
+	test_i18ngrep "You have divergent branches" err
 '
 
 test_expect_success 'pull.rebase not set and pull.ff=false (not-fast-forward)' '
 	git reset --hard c2 &&
 	test_config pull.ff false &&
-	git pull . c1 2>err &&
-	test_i18ngrep ! "You have divergent branches" err
+	test_must_fail git pull . c1 2>err &&
+	test_i18ngrep "You have divergent branches" err
 '
 
 test_expect_success 'pull.rebase not set and pull.ff=only (not-fast-forward)' '
 	git reset --hard c2 &&
 	test_config pull.ff only &&
 	test_must_fail git pull . c1 2>err &&
-	test_i18ngrep ! "You have divergent branches" err
+	test_i18ngrep "You have divergent branches" err
 '
 
 test_expect_success 'pull.rebase not set and --rebase given (not-fast-forward)' '
@@ -127,20 +127,20 @@ test_expect_success 'pull.rebase not set and --no-rebase given (not-fast-forward
 
 test_expect_success 'pull.rebase not set and --ff given (not-fast-forward)' '
 	git reset --hard c2 &&
-	git pull --ff . c1 2>err &&
-	test_i18ngrep ! "You have divergent branches" err
+	test_must_fail git pull --ff . c1 2>err &&
+	test_i18ngrep "You have divergent branches" err
 '
 
 test_expect_success 'pull.rebase not set and --no-ff given (not-fast-forward)' '
 	git reset --hard c2 &&
-	git pull --no-ff . c1 2>err &&
-	test_i18ngrep ! "You have divergent branches" err
+	test_must_fail git pull --no-ff . c1 2>err &&
+	test_i18ngrep "You have divergent branches" err
 '
 
 test_expect_success 'pull.rebase not set and --ff-only given (not-fast-forward)' '
 	git reset --hard c2 &&
 	test_must_fail git pull --ff-only . c1 2>err &&
-	test_i18ngrep ! "You have divergent branches" err
+	test_i18ngrep "You have divergent branches" err
 '
 
 test_does_rebase () {
@@ -210,11 +210,11 @@ test_attempts_fast_forward () {
 # (And related interaction of pull.ff=only with pull.rebase)
 #
 test_expect_success '--ff-only overrides --rebase' '
-	test_attempts_fast_forward pull --rebase --ff-only
+	test_does_fast_forward pull --rebase --ff-only
 '
 
 test_expect_success '--ff-only overrides --rebase even if first' '
-	test_attempts_fast_forward pull --ff-only --rebase
+	test_does_fast_forward pull --ff-only --rebase
 '
 
 test_expect_success '--ff-only overrides --no-rebase' '
@@ -222,7 +222,7 @@ test_expect_success '--ff-only overrides --no-rebase' '
 '
 
 test_expect_success 'pull.ff=only overrides pull.rebase=true' '
-	test_attempts_fast_forward -c pull.ff=only -c pull.rebase=true pull
+	test_does_fast_forward -c pull.ff=only -c pull.rebase=true pull
 '
 
 test_expect_success 'pull.ff=only overrides pull.rebase=false' '
@@ -253,7 +253,7 @@ test_expect_success 'pull.rebase=true overrides pull.ff=true' '
 
 # Group 3: command line flags take precedence over config
 test_expect_success '--ff-only takes precedence over pull.rebase=true' '
-	test_attempts_fast_forward -c pull.rebase=true pull --ff-only
+	test_does_fast_forward -c pull.rebase=true pull --ff-only
 '
 
 test_expect_success '--ff-only takes precedence over pull.rebase=false' '
@@ -261,7 +261,7 @@ test_expect_success '--ff-only takes precedence over pull.rebase=false' '
 '
 
 test_expect_success '--no-rebase takes precedence over pull.ff=only' '
-	test_falls_back_to_full_merge -c pull.ff=only pull --no-rebase
+	test_attempts_fast_forward -c pull.ff=only pull --no-rebase
 '
 
 test_expect_success '--rebase takes precedence over pull.ff=only' '
-- 
2.39.2

