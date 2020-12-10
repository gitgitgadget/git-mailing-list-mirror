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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53445C433FE
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 10:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB07F22DA9
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 10:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbgLJKGX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Dec 2020 05:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbgLJKGW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Dec 2020 05:06:22 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B77C0613CF
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 02:05:42 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id d27so5147538oic.0
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 02:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n2HiDF2OWk7mZi9FPvKWiXZxzL8kplKjr9W0JX4a4XU=;
        b=IMbq9FULjF0qzGXbFq5s3aI8SQcgPmrwLNXCgZYKdVldmiZgkzmE/TGMCZVFV538+A
         R0vN5ScIAtJ5s79WbFJD3Kp+NW2II+b3jC3rHNrVOZrFGy+eXNuNEpmFF/jFth3lkc0Q
         oqAov/jjRPBZXy3MFzLKVyrb0fp/hExO7lqSlqdyRJ4dgW2rABJS18pNHm8lzQV5dY8n
         2b4jF6xpWAnzB8ogMG7mmR+vNWVb7q3FyahTPBFGmwOA2Nq7wS4GgpgK9f1SILuGgIdM
         b1C7LqujWr7MVNdow1leriEZ/uhgeUW18Nxe4PZa1duofQnmGtUmakEag+JVJJNFOwfG
         Gf0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n2HiDF2OWk7mZi9FPvKWiXZxzL8kplKjr9W0JX4a4XU=;
        b=uhhjtx4SpxtyKPOk4M5PBsBhcRQEyPyreWjrJh8cdhIQDlVxuh9Ze/UMkNxj3b4H7X
         I66Clcu7W0niF9xxCTJtwcmtaOZ192KoQ/MbsuiTaFhN6mbDoNC1w0QoHvugG8zhZ2Ks
         oEdr0U9JN9oFhDITiSY4ARieKcJm/s9ghjOPuLpiBulmFS/qyacBKWmCZSciaqhwB3D5
         48MtRkWqdli+W8AKkBZ/e5VhdIRAWquGrPfslh6A8cGVMfnZ70SKZNteGyVmCY56p40u
         V9t3GatdpIRgCjyDiIws7SY6BMaMdZ/G6vPA9Lt7mrszcLKJHL+8hs+vBELJBcOtjxTE
         LT5A==
X-Gm-Message-State: AOAM5333W7Mm7D5DtlI5SRjOZG3KgBpk12NKVAOm4Svprjj03hSyBveP
        ftP6l8UJFzDi/cd6bIGZaVD3Hmt4dvS5Dw==
X-Google-Smtp-Source: ABdhPJwUJTE1CYqJR4ETqD7kRT8da8w7FTXkJUWSaAIlWPK5GQo/Brqs1fy7f3hBywzr2AyoauaGFQ==
X-Received: by 2002:aca:b60a:: with SMTP id g10mr4765681oif.26.1607594741229;
        Thu, 10 Dec 2020 02:05:41 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id u10sm966238oig.54.2020.12.10.02.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 02:05:40 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?V=C3=ADt=20Ondruch?= <vondruch@redhat.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 0/3] pull: stop warning on every pull
Date:   Thu, 10 Dec 2020 04:05:35 -0600
Message-Id: <20201210100538.696787-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The discussion about making fast-forward-only pulls the default is stuck on mud, and there's no
agreement about what we should even be warning our users about.

Even my straightforward patches about improving documentation, and the consistency of the UI with
--merge and other obvious fixes lost traction.

This is not the totality of part I, it's doing one thing, and one thing only: stops warning the
users on every single pull (warns only if they are not-fast-forward).

Everything else is dropped.

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 21b50aff77..5c3fb67c01 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -38,20 +38,6 @@ as set by linkgit:git-branch[1] `--track`.
 Assume the following history exists and the current branch is
 "`master`":
 
-------------
-	  A---B---C master on origin
-	 /
-    D---E master
-------------
-
-Then `git pull` will merge in a fast-forward way up to the new master.
-
-------------
-    D---E---A---B---C master, origin/master
-------------
-
-However, a non-fast-forward case looks very different.
-
 ------------
 	  A---B---C master on origin
 	 /
@@ -60,9 +46,6 @@ However, a non-fast-forward case looks very different.
 	origin/master in your repository
 ------------
 
-By default `git pull` will warn about these situations, however, most likely
-you would want to force a merge, which you can do with `git pull --merge`.
-
 Then "`git pull`" will fetch and replay the changes from the remote
 `master` branch since it diverged from the local `master` (i.e., `E`)
 until its current commit (`C`) on top of `master` and record the
@@ -148,11 +131,8 @@ It rewrites history, which does not bode well when you
 published that history already.  Do *not* use this option
 unless you have read linkgit:git-rebase[1] carefully.
 
--m::
---merge::
-	Force a merge.
-+
-Previously this was --no-rebase, but that usage has been deprecated.
+--no-rebase::
+	Override earlier --rebase.
 
 Options related to fetching
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/builtin/pull.c b/builtin/pull.c
index 118fbdeb62..9a7caf3a3e 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -27,6 +27,8 @@
 #include "commit-reach.h"
 #include "sequencer.h"
 
+static int default_mode;
+
 /**
  * Parses the value of --rebase. If value is a false value, returns
  * REBASE_FALSE. If value is a true value, returns REBASE_TRUE. If value is
@@ -74,7 +76,7 @@ static char *opt_progress;
 static int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
 
 /* Options passed to git-merge or git-rebase */
-static enum rebase_type opt_rebase;
+static enum rebase_type opt_rebase = -1;
 static char *opt_diffstat;
 static char *opt_log;
 static char *opt_signoff;
@@ -126,11 +128,9 @@ static struct option pull_options[] = {
 	/* Options passed to git-merge or git-rebase */
 	OPT_GROUP(N_("Options related to merging")),
 	OPT_CALLBACK_F('r', "rebase", &opt_rebase,
-		"(false|true|merges|preserve|interactive)",
-		N_("incorporate changes by rebasing rather than merging"),
-		PARSE_OPT_OPTARG, parse_opt_rebase),
-	OPT_SET_INT('m', "merge", &opt_rebase,
-		N_("incorporate changes by merging"), REBASE_FALSE),
+	  "(false|true|merges|preserve|interactive)",
+	  N_("incorporate changes by rebasing rather than merging"),
+	  PARSE_OPT_OPTARG, parse_opt_rebase),
 	OPT_PASSTHRU('n', NULL, &opt_diffstat, NULL,
 		N_("do not show a diffstat at the end of the merge"),
 		PARSE_OPT_NOARG | PARSE_OPT_NONEG),
@@ -346,7 +346,9 @@ static enum rebase_type config_get_rebase(void)
 	if (!git_config_get_value("pull.rebase", &value))
 		return parse_config_rebase("pull.rebase", value, 1);
 
-	return REBASE_DEFAULT;
+	default_mode = 1;
+
+	return REBASE_FALSE;
 }
 
 /**
@@ -441,7 +443,7 @@ static void NORETURN die_no_merge_candidates(const char *repo, const char **refs
 	const char *remote = curr_branch ? curr_branch->remote_name : NULL;
 
 	if (*refspecs) {
-		if (opt_rebase >= REBASE_TRUE)
+		if (opt_rebase)
 			fprintf_ln(stderr, _("There is no candidate for rebasing against among the refs that you just fetched."));
 		else
 			fprintf_ln(stderr, _("There are no candidates for merging among the refs that you just fetched."));
@@ -454,7 +456,7 @@ static void NORETURN die_no_merge_candidates(const char *repo, const char **refs
 			repo);
 	} else if (!curr_branch) {
 		fprintf_ln(stderr, _("You are not currently on a branch."));
-		if (opt_rebase >= REBASE_TRUE)
+		if (opt_rebase)
 			fprintf_ln(stderr, _("Please specify which branch you want to rebase against."));
 		else
 			fprintf_ln(stderr, _("Please specify which branch you want to merge with."));
@@ -469,7 +471,7 @@ static void NORETURN die_no_merge_candidates(const char *repo, const char **refs
 			remote_name = _("<remote>");
 
 		fprintf_ln(stderr, _("There is no tracking information for the current branch."));
-		if (opt_rebase >= REBASE_TRUE)
+		if (opt_rebase)
 			fprintf_ln(stderr, _("Please specify which branch you want to rebase against."));
 		else
 			fprintf_ln(stderr, _("Please specify which branch you want to merge with."));
@@ -931,11 +933,9 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	struct oid_array merge_heads = OID_ARRAY_INIT;
 	struct object_id orig_head, curr_head;
 	struct object_id rebase_fork_point;
+	int autostash;
 	int can_ff;
 
-	opt_ff = xstrdup_or_null(config_get_ff());
-	opt_rebase = config_get_rebase();
-
 	if (!getenv("GIT_REFLOG_ACTION"))
 		set_reflog_message(argc, argv);
 
@@ -952,6 +952,12 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 	parse_repo_refspecs(argc, argv, &repo, &refspecs);
 
+	if (!opt_ff)
+		opt_ff = xstrdup_or_null(config_get_ff());
+
+	if (opt_rebase < 0)
+		opt_rebase = config_get_rebase();
+
 	if (read_cache_unmerged())
 		die_resolve_conflict("pull");
 
@@ -961,8 +967,8 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (get_oid("HEAD", &orig_head))
 		oidclr(&orig_head);
 
-	if (opt_rebase >= REBASE_TRUE) {
-		int autostash = config_autostash;
+	autostash = config_autostash;
+	if (opt_rebase) {
 		if (opt_autostash != -1)
 			autostash = opt_autostash;
 
@@ -1021,28 +1027,29 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 			die(_("Cannot merge multiple branches into empty head."));
 		return pull_into_void(merge_heads.oid, &curr_head);
 	}
-	if (opt_rebase >= REBASE_TRUE && merge_heads.nr > 1)
+	if (opt_rebase && merge_heads.nr > 1)
 		die(_("Cannot rebase onto multiple branches."));
 
 	can_ff = get_can_ff(&orig_head, &merge_heads.oid[0]);
 
-	if (!opt_rebase && !can_ff && opt_verbosity >= 0 && (!opt_ff || !strcmp(opt_ff, "--ff"))) {
-		advise(_("Pulling without specifying how to reconcile divergent branches is discouraged;\n"
-			"you need to specify if you want a merge, or a rebase.\n"
-			"You can squelch this message by running one of the following commands:\n"
-			"\n"
-			"  git config pull.rebase false  # merge (the default strategy)\n"
-			"  git config pull.rebase true   # rebase\n"
-			"  git config pull.ff only       # fast-forward only\n"
-			"\n"
-			"You can replace \"git config\" with \"git config --global\" to set a default\n"
-			"preference for all repositories.\n"
-			"If unsure, run \"git pull --merge\".\n"
-			"Read \"git pull --help\" for more information."));
+	if (default_mode && !can_ff && opt_verbosity >= 0 && !opt_ff) {
+		advise(_("Pulling without specifying how to reconcile divergent branches is\n"
+			 "discouraged. You can squelch this message by running one of the following\n"
+			 "commands sometime before your next pull:\n"
+			 "\n"
+			 "  git config pull.rebase false  # merge (the default strategy)\n"
+			 "  git config pull.rebase true   # rebase\n"
+			 "  git config pull.ff only       # fast-forward only\n"
+			 "\n"
+			 "You can replace \"git config\" with \"git config --global\" to set a default\n"
+			 "preference for all repositories. You can also pass --rebase, --no-rebase,\n"
+			 "or --ff-only on the command line to override the configured default per\n"
+			 "invocation.\n"));
 	}
 
-	if (opt_rebase >= REBASE_TRUE) {
+	if (opt_rebase) {
 		int ret = 0;
+		int ran_ff = 0;
 
 		struct object_id newbase;
 		struct object_id upstream;
@@ -1053,15 +1060,16 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		     recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND) &&
 		    submodule_touches_in_range(the_repository, &upstream, &curr_head))
 			die(_("cannot rebase with locally recorded submodule modifications"));
-
-		if (can_ff) {
-			/* we can fast-forward this without invoking rebase */
-			free(opt_ff);
-			opt_ff = xstrdup_or_null("--ff-only");
-			ret = run_merge();
-		} else {
-			ret = run_rebase(&newbase, &upstream);
+		if (!autostash) {
+			if (can_ff) {
+				/* we can fast-forward this without invoking rebase */
+				opt_ff = "--ff-only";
+				ran_ff = 1;
+				ret = run_merge();
+			}
 		}
+		if (!ran_ff)
+			ret = run_rebase(&newbase, &upstream);
 
 		if (!ret && (recurse_submodules == RECURSE_SUBMODULES_ON ||
 			     recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND))
diff --git a/rebase.h b/rebase.h
index 34d4acfd74..cc723d4748 100644
--- a/rebase.h
+++ b/rebase.h
@@ -3,8 +3,7 @@
 
 enum rebase_type {
 	REBASE_INVALID = -1,
-	REBASE_DEFAULT = 0,
-	REBASE_FALSE,
+	REBASE_FALSE = 0,
 	REBASE_TRUE,
 	REBASE_PRESERVE,
 	REBASE_MERGES,
diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
index 1a4fe2583a..db1a381cd9 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -11,10 +11,10 @@ test_expect_success 'setup' '
 	 git commit -m one)
 '
 
-test_expect_success 'git pull -q' '
+test_expect_success 'git pull -q --no-rebase' '
 	mkdir clonedq &&
 	(cd clonedq && git init &&
-	git pull -q "../parent" >out 2>err &&
+	git pull -q --no-rebase "../parent" >out 2>err &&
 	test_must_be_empty err &&
 	test_must_be_empty out)
 '
@@ -30,10 +30,10 @@ test_expect_success 'git pull -q --rebase' '
 	test_must_be_empty out)
 '
 
-test_expect_success 'git pull' '
+test_expect_success 'git pull --no-rebase' '
 	mkdir cloned &&
 	(cd cloned && git init &&
-	git pull "../parent" >out 2>err &&
+	git pull --no-rebase "../parent" >out 2>err &&
 	test -s err &&
 	test_must_be_empty out)
 '
@@ -46,10 +46,10 @@ test_expect_success 'git pull --rebase' '
 	test_must_be_empty out)
 '
 
-test_expect_success 'git pull -v' '
+test_expect_success 'git pull -v --no-rebase' '
 	mkdir clonedv &&
 	(cd clonedv && git init &&
-	git pull -v "../parent" >out 2>err &&
+	git pull -v --no-rebase "../parent" >out 2>err &&
 	test -s err &&
 	test_must_be_empty out)
 '
@@ -62,25 +62,25 @@ test_expect_success 'git pull -v --rebase' '
 	test_must_be_empty out)
 '
 
-test_expect_success 'git pull -v -q' '
+test_expect_success 'git pull -v -q --no-rebase' '
 	mkdir clonedvq &&
 	(cd clonedvq && git init &&
-	git pull -v -q "../parent" >out 2>err &&
+	git pull -v -q --no-rebase "../parent" >out 2>err &&
 	test_must_be_empty out &&
 	test_must_be_empty err)
 '
 
-test_expect_success 'git pull -q -v' '
+test_expect_success 'git pull -q -v --no-rebase' '
 	mkdir clonedqv &&
 	(cd clonedqv && git init &&
-	git pull -q -v "../parent" >out 2>err &&
+	git pull -q -v --no-rebase "../parent" >out 2>err &&
 	test_must_be_empty out &&
 	test -s err)
 '
 test_expect_success 'git pull --cleanup errors early on invalid argument' '
 	mkdir clonedcleanup &&
 	(cd clonedcleanup && git init &&
-	test_must_fail git pull --cleanup invalid "../parent" >out 2>err &&
+	test_must_fail git pull --no-rebase --cleanup invalid "../parent" >out 2>err &&
 	test_must_be_empty out &&
 	test -s err)
 '
diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index 8a6aae564a..6b4adab8b1 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -33,6 +33,7 @@ test_expect_success 'pull.rebase not set' '
 	test_decode_color <err >decoded &&
 	test_i18ngrep "<YELLOW>hint: " decoded &&
 	test_i18ngrep "Pulling without specifying how to reconcile" decoded
+
 '
 
 test_expect_success 'pull.rebase not set (fast-forward)' '
@@ -45,7 +46,7 @@ test_expect_success 'pull.rebase not set and pull.ff=true' '
 	git reset --hard c2 &&
 	test_config pull.ff true &&
 	git pull . c1 2>err &&
-	test_i18ngrep "Pulling without specifying how to reconcile" err
+	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and pull.ff=false' '
@@ -68,16 +69,16 @@ test_expect_success 'pull.rebase not set and --rebase given' '
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
-test_expect_success 'pull.rebase not set and --merge given' '
+test_expect_success 'pull.rebase not set and --no-rebase given' '
 	git reset --hard c2 &&
-	git pull --merge . c1 2>err &&
+	git pull --no-rebase . c1 2>err &&
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and --ff given' '
 	git reset --hard c2 &&
 	git pull --ff . c1 2>err &&
-	test_i18ngrep "Pulling without specifying how to reconcile" err
+	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and --no-ff given' '


Felipe Contreras (3):
  pull: refactor fast-forward check
  pull: move default warning
  pull: display default warning only when non-ff

 builtin/pull.c               | 61 +++++++++++++++++++++---------------
 t/t7601-merge-pull-config.sh | 28 ++++++++++-------
 2 files changed, 53 insertions(+), 36 deletions(-)

-- 
2.29.2

