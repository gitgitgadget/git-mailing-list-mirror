Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156B2C433EF
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 00:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344555AbiA1AMp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 19:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344498AbiA1AMl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 19:12:41 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9991EC06173B
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 16:12:40 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id q9-20020a7bce89000000b00349e697f2fbso7037251wmj.0
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 16:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Jt99SVPjrm6dYMEkAoDnOZORP+udyvsiw8E8i08g75U=;
        b=TAXSmZ01HkiAsU9xOVG+ew0lCssG0cgjwD7LfppylZ7THd1bvHPyvT8gdkuBtBSKzT
         VG9zoz184s2CWQrl48ElN0a9XYSnFkXW/slzWoC07wIVagCEkhgueeYyLWQQb2y3w2s1
         KaumUtEIrdvpvE0za2Qi7iLBDDAvwI0NlhBEDNhgYjRMkP9y1UID5xuEYAhXVpfZqv1s
         vYRPQ5RT1aWyq73dKaOev2QjjE+BIqI8p/6LY5kTXxaX8wJZ/3h0Q89M+aQFObwdHtAl
         cZZ8bPoJkjLh0ax+tjzbsxfdBx/dwQRCz5yXSPPReC4nKFj46bs7hXWtFJy5+aN7Rkmh
         SmiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Jt99SVPjrm6dYMEkAoDnOZORP+udyvsiw8E8i08g75U=;
        b=K350daJh+KzXyDulk32d3Ds7vTv25h7gP1+O6Xe9qwBPvSJYbQbtv+eBI/Rf9t4vXk
         Ed6MxDGeazhQlX4p3l5JRffwiO3M/tkVahcyjUcGOVGdGoAJDogVEexfYzmXA0p/bvBS
         +KCJesYu57VybjQL5g05AtG+p0qyvyRB89Rfzwckd+lf56KooqHG4pc0Awkpnp36XdoQ
         GJdb2IlUmenAk1i062erjb0dnOavH57LloveRDA4ZwO0suDn26omGNjjYZMbFvCXtqfD
         OhrXdBhzjnqqDI6t37gq4TM71L+szpIuvtWg9ryF4OAvg7IkdEdKUeM0xMCOJdxJ1O67
         Z0qg==
X-Gm-Message-State: AOAM530+EgWEEnFTfpJ0m1Ejchvh9Fx/XZ/gtRPciKOtRUffUe9iVcWq
        PP98Ez1/O4YAMXT/8RWtQSmULvMoCFs=
X-Google-Smtp-Source: ABdhPJyABV/pJqDkPpiebWqnIMdNyKKtvvEybxPtBOaCYTP+QFEO64e4xvX9M/PcZXwJJafkx8p9eQ==
X-Received: by 2002:a05:600c:3d8a:: with SMTP id bi10mr5295294wmb.62.1643328758918;
        Thu, 27 Jan 2022 16:12:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y14sm3901351wrd.91.2022.01.27.16.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 16:12:38 -0800 (PST)
Message-Id: <515e86e20758ed7f5b4a8ce8f38bfbbac27ec42a.1643328752.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.git.1643328752.gitgitgadget@gmail.com>
References: <pull.1132.git.1643328752.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 28 Jan 2022 00:12:28 +0000
Subject: [PATCH 07/11] bisect: move even the option parsing to
 `bisect--helper`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

On our journey to a fully built-in `git bisect`, this is the
second-to-last step.

Side note: The `if (!strcmp(...)) ... else if (!strcmp(...)) ... else if
(!strcmp(...)) ...` chain seen in this patch was not actually the first
idea how to convert the command modes to sub-commands. Since the
`bisect--helper` command already used the `parse-opions` API with neatly
set-up command modes, naturally the idea was to use `PARSE_OPT_NODASH`
to support proper sub-commands instead. However, the `parse-options` API
is not set up for that, and even after making that option work with long
options, it turned out that `STOP_AT_NON_OPTION` and `KEEP_UNKNOWN`
would have to be used but these options were not designed to work
together. So it would appear as if a lot of work would have to be done
just to be able to use `parse_options()` just to parse the sub-command,
instead of a simple `if...else if` chain, the latter being a
dramatically simpler implementation. Therefore, we now keep the
`parse_options()` call primarily to support `-h` and little else.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/bisect--helper.c | 172 ++++++++++++++++-----------------------
 git-bisect.sh            |  49 +----------
 2 files changed, 72 insertions(+), 149 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 219fa99cd0b..4450305c81c 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -20,18 +20,34 @@ static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
 static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
 static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
 
-static const char * const git_bisect_helper_usage[] = {
-	N_("git bisect--helper --bisect-reset [<commit>]"),
-	N_("git bisect--helper --bisect-terms [--term-good | --term-old | --term-bad | --term-new]"),
-	N_("git bisect--helper --bisect-start [--term-{new,bad}=<term> --term-{old,good}=<term>]"
-					    " [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<paths>...]"),
-	N_("git bisect--helper --bisect-next"),
-	N_("git bisect--helper [--bisect-state] (bad|new) [<rev>]"),
-	N_("git bisect--helper [--bisect-state] (good|old) [<rev>...]"),
-	N_("git bisect--helper --bisect-replay <filename>"),
-	N_("git bisect--helper --bisect-skip [(<rev>|<range>)...]"),
-	N_("git bisect--helper --bisect-visualize"),
-	N_("git bisect--helper --bisect-run <cmd>..."),
+static const char * const git_bisect_usage[] = {
+	N_("git bisect help\n"
+	   "\tprint this long help message."),
+	N_("git bisect start [--term-{new,bad}=<term> --term-{old,good}=<term>]\n"
+	   "\t\t [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<pathspec>...]\n"
+	   "\treset bisect state and start bisection."),
+	N_("git bisect (bad|new) [<rev>]\n"
+	   "\tmark <rev> a known-bad revision/\n"
+	   "\t\ta revision after change in a given property."),
+	N_("git bisect (good|old) [<rev>...]\n"
+	   "\tmark <rev>... known-good revisions/\n"
+	   "\t\trevisions before change in a given property."),
+	N_("git bisect terms [--term-good | --term-bad]\n"
+	   "\tshow the terms used for old and new commits (default: bad, good)"),
+	N_("git bisect skip [(<rev>|<range>)...]\n"
+	   "\tmark <rev>... untestable revisions."),
+	N_("git bisect next\n"
+	   "\tfind next bisection to test and check it out."),
+	N_("git bisect reset [<commit>]\n"
+	   "\tfinish bisection search and go back to commit."),
+	N_("git bisect (visualize|view)\n"
+	   "\tshow bisect status in gitk."),
+	N_("git bisect replay <logfile>\n"
+	   "\treplay bisection log."),
+	N_("git bisect log\n"
+	   "\tshow bisect log."),
+	N_("git bisect run <cmd>...\n"
+	   "\tuse <cmd>... to automatically bisect."),
 	NULL
 };
 
@@ -1168,115 +1184,69 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
 
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
-	enum {
-		BISECT_START = 1,
-		BISECT_STATE,
-		BISECT_TERMS,
-		BISECT_SKIP,
-		BISECT_NEXT,
-		BISECT_RESET,
-		BISECT_VISUALIZE,
-		BISECT_REPLAY,
-		BISECT_LOG,
-		BISECT_RUN,
-	} cmdmode = 0;
 	int res = 0;
 	struct option options[] = {
-		OPT_CMDMODE(0, "bisect-start", &cmdmode,
-			 N_("start the bisect session"), BISECT_START),
-		OPT_CMDMODE(0, "bisect-state", &cmdmode,
-			 N_("mark the state of ref (or refs)"), BISECT_STATE),
-		OPT_CMDMODE(0, "bisect-terms", &cmdmode,
-			 N_("print out the bisect terms"), BISECT_TERMS),
-		OPT_CMDMODE(0, "bisect-skip", &cmdmode,
-			 N_("skip some commits for checkout"), BISECT_SKIP),
-		OPT_CMDMODE(0, "bisect-next", &cmdmode,
-			 N_("find the next bisection commit"), BISECT_NEXT),
-		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
-			 N_("reset the bisection state"), BISECT_RESET),
-		OPT_CMDMODE(0, "bisect-visualize", &cmdmode,
-			 N_("visualize the bisection"), BISECT_VISUALIZE),
-		OPT_CMDMODE(0, "bisect-replay", &cmdmode,
-			 N_("replay the bisection process from the given file"), BISECT_REPLAY),
-		OPT_CMDMODE(0, "bisect-log", &cmdmode,
-			 N_("list the bisection steps so far"), BISECT_LOG),
-		OPT_CMDMODE(0, "bisect-run", &cmdmode,
-			 N_("use <cmd>... to automatically bisect."), BISECT_RUN),
 		OPT_END()
 	};
 	struct bisect_terms terms = { .term_good = NULL, .term_bad = NULL };
+	const char *command = argc > 1 ? argv[1] : "help";
 
-	argc = parse_options(argc, argv, prefix, options,
-			     git_bisect_helper_usage,
-			     PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_UNKNOWN);
+	/* Handle -h and invalid options */
+	parse_options(argc - 1, argv + 1, prefix, options,
+		      git_bisect_usage,
+		      PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_UNKNOWN |
+		      PARSE_OPT_ONE_SHOT | PARSE_OPT_STOP_AT_NON_OPTION);
 
-	if (!cmdmode && argc > 0) {
+	if (!strcmp("help", command))
+		usage_with_options(git_bisect_usage, options);
+	else if (!strcmp("start", command)) {
 		set_terms(&terms, "bad", "good");
-		get_terms(&terms);
-		if (!check_and_set_terms(&terms, argv[0]))
-			cmdmode = BISECT_STATE;
-	}
-
-	if (!cmdmode)
-		usage_with_options(git_bisect_helper_usage, options);
-
-	switch (cmdmode) {
-	case BISECT_START:
-		set_terms(&terms, "bad", "good");
-		res = bisect_start(&terms, argv, argc);
-		break;
-	case BISECT_TERMS:
-		if (argc > 1)
-			return error(_("--bisect-terms requires 0 or 1 argument"));
-		res = bisect_terms(&terms, argc == 1 ? argv[0] : NULL);
-		break;
-	case BISECT_SKIP:
+		res = bisect_start(&terms, argv + 2, argc - 2);
+	} else if (!strcmp("terms", command)) {
+		if (argc > 3)
+			return error(_("'terms' requires 0 or 1 argument"));
+		res = bisect_terms(&terms, argc == 3 ? argv[2] : NULL);
+	} else if (!strcmp("skip", command)) {
 		set_terms(&terms, "bad", "good");
 		get_terms(&terms);
-		res = bisect_skip(&terms, argv, argc);
-		break;
-	case BISECT_NEXT:
-		if (argc)
-			return error(_("--bisect-next requires 0 arguments"));
+		res = bisect_skip(&terms, argv + 2, argc - 2);
+	} else if (!strcmp("next", command)) {
+		if (argc != 2)
+			return error(_("'next' requires 0 arguments"));
 		get_terms(&terms);
 		res = bisect_next(&terms, prefix);
-		break;
-	case BISECT_RESET:
-		if (argc > 1)
-			return error(_("--bisect-reset requires either no argument or a commit"));
-		res = bisect_reset(argc ? argv[0] : NULL);
-		break;
-	case BISECT_VISUALIZE:
+	} else if (!strcmp("reset", command)) {
+		if (argc > 3)
+			return error(_("'reset' requires either no argument or a commit"));
+		res = bisect_reset(argc > 2 ? argv[2] : NULL);
+	} else if (one_of(command, "visualize", "view", NULL)) {
 		get_terms(&terms);
-		res = bisect_visualize(&terms, argv, argc);
-		break;
-	case BISECT_REPLAY:
-		if (argc != 1)
+		res = bisect_visualize(&terms, argv + 2, argc - 2);
+	} else if (!strcmp("replay", command)) {
+		if (argc != 3)
 			return error(_("no logfile given"));
 		set_terms(&terms, "bad", "good");
-		res = bisect_replay(&terms, argv[0]);
-		break;
-	case BISECT_LOG:
-		if (argc)
-			return error(_("--bisect-log requires 0 arguments"));
+		res = bisect_replay(&terms, argv[2]);
+	} else if (!strcmp("log", command)) {
+		if (argc > 2)
+			return error(_("'log' requires 0 arguments"));
 		res = bisect_log();
-		break;
-	case BISECT_RUN:
-		if (!argc)
+	} else if (!strcmp("run", command)) {
+		if (argc < 3)
 			return error(_("bisect run failed: no command provided."));
 		get_terms(&terms);
-		res = bisect_run(&terms, argv, argc);
-		break;
-	case BISECT_STATE:
-		if (!terms.term_good) {
-			set_terms(&terms, "bad", "good");
-			get_terms(&terms);
+		res = bisect_run(&terms, argv + 2, argc - 2);
+	} else {
+		set_terms(&terms, "bad", "good");
+		get_terms(&terms);
+		if (!check_and_set_terms(&terms, command))
+			res = bisect_state(&terms, argv + 1, argc - 1);
+		else {
+			char *msg = xstrfmt(_("unknown command: '%s'"), command);
+			usage_msg_opt(msg, git_bisect_usage, options);
 		}
-		res = bisect_state(&terms, argv, argc);
-		break;
-	default:
-		BUG("unknown subcommand %d", cmdmode);
 	}
+
 	free_terms(&terms);
 
 	/*
diff --git a/git-bisect.sh b/git-bisect.sh
index 405cf76f2a3..028d39cd9ce 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -34,51 +34,4 @@ Please use "git help bisect" to get the full man page.'
 OPTIONS_SPEC=
 . git-sh-setup
 
-TERM_BAD=bad
-TERM_GOOD=good
-
-get_terms () {
-	if test -s "$GIT_DIR/BISECT_TERMS"
-	then
-		{
-		read TERM_BAD
-		read TERM_GOOD
-		} <"$GIT_DIR/BISECT_TERMS"
-	fi
-}
-
-case "$#" in
-0)
-	usage ;;
-*)
-	cmd="$1"
-	get_terms
-	shift
-	case "$cmd" in
-	help)
-		git bisect -h ;;
-	start)
-		git bisect--helper --bisect-start "$@" ;;
-	bad|good|new|old|"$TERM_BAD"|"$TERM_GOOD")
-		git bisect--helper --bisect-state "$cmd" "$@" ;;
-	skip)
-		git bisect--helper --bisect-skip "$@" || exit;;
-	next)
-		# Not sure we want "next" at the UI level anymore.
-		git bisect--helper --bisect-next "$@" || exit ;;
-	visualize|view)
-		git bisect--helper --bisect-visualize "$@" || exit;;
-	reset)
-		git bisect--helper --bisect-reset "$@" ;;
-	replay)
-		git bisect--helper --bisect-replay "$@" || exit;;
-	log)
-		git bisect--helper --bisect-log || exit ;;
-	run)
-		git bisect--helper --bisect-run "$@" || exit;;
-	terms)
-		git bisect--helper --bisect-terms "$@" || exit;;
-	*)
-		usage ;;
-	esac
-esac
+exec git bisect--helper "$@"
-- 
gitgitgadget

