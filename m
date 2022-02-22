Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC69C4332F
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 16:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234075AbiBVQbV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 11:31:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234039AbiBVQbG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 11:31:06 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF57B167F95
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 08:30:35 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id x15so31225wrg.8
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 08:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+WtbEiJLuTOp06tMnFg0vJAku9FUpDs7h7Qt7ARx3GA=;
        b=PUv2HMk2mfA47pj2U45/XU6HTXVRlUpV/TBmyKctVxDCBg97yNuasrUec8EK+BRbY1
         TcOAR1aMkbcjF/ftmF5tZwCZp5Fufq9/MbiuIU9MghNFVdYoBct72PwnYD6kI67YFV5H
         d9HG74l0T5qv0Jb/0AYabC5bxFtnX2CHrHM6P+zEJDSz62/O92/R9260CWvckV9V7pPL
         BsXF2xHqpaiO2vzkxxBVOKa7oDILMLS8fdl+dGK5Um4J/vPRXoVdXSyCRW0+DVclLTpO
         h6wVvOkzzdne31CMw7XtmNm5Z7or/L35dd+twdEZIMqJQuplQb0ZKmuvQT3EzQILgTr9
         /ePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+WtbEiJLuTOp06tMnFg0vJAku9FUpDs7h7Qt7ARx3GA=;
        b=lED1I8kVsc6+sD6rNjErSNzLgeEuNJ4Fp4fw4oMGEftZuc38Q7iMI7MsSthytyZcDj
         35NPM5YyvQzciQoD/Y7NCtXmWfI95/Odgl1ww58Zy4NF/bcbwDRIjVTD2Twmz4nw1EMy
         SIgFB002eakkKswBHLPouuQx3TNvpmUYm2mRcvtRMW4oSYY1FknbT3yB9LmpeRM+vFhx
         sFeHFNqe7mMFThQejmbIWd3Xya8BEWilYjKgK/Xe8jtpnUrh2R7DAH6LvG9nD2WBm3H5
         jrbn2sgiBvK2tI7dAbhIKdHUILXdIONfTnaIj1lCySoOw3TGzjor3yAUvDM4uvRVdNsZ
         K8vA==
X-Gm-Message-State: AOAM531iAA2C/lewkZeo8QX98+5dxJBA86KktKLbFF9T1B+QG7WS6vZ8
        2xqlqTjP8d5ElMX6v4PNlJxVMf6QAZg=
X-Google-Smtp-Source: ABdhPJxh8yqWZifPUF/87SHZfVtLE3vtPjz8VvORWmWHu+kUobp9AOM4VTuinea/t9SNK9/W9yfABQ==
X-Received: by 2002:a5d:678b:0:b0:1ed:9f21:d36 with SMTP id v11-20020a5d678b000000b001ed9f210d36mr63634wru.550.1645547433555;
        Tue, 22 Feb 2022 08:30:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i9sm33156484wrf.79.2022.02.22.08.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 08:30:33 -0800 (PST)
Message-Id: <dc04b06206bbb833ce3a7fa893d724d00fe58a74.1645547423.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v2.git.1645547423.gitgitgadget@gmail.com>
References: <pull.1132.git.1643328752.gitgitgadget@gmail.com>
        <pull.1132.v2.git.1645547423.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Feb 2022 16:30:20 +0000
Subject: [PATCH v2 11/14] bisect: move even the option parsing to
 `bisect--helper`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
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
dramatically simpler implementation.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/bisect--helper.c | 133 ++++++++++++++++-----------------------
 git-bisect.sh            |  49 +--------------
 2 files changed, 56 insertions(+), 126 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 5228964937d..ef0b06d594b 100644
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
 
@@ -1168,108 +1184,69 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
 
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
+	if (!strcmp("-h", command) || !strcmp("help", command))
+		usage_with_options(git_bisect_usage, options);
 
-	switch (cmdmode ? cmdmode : BISECT_STATE) {
-	case BISECT_START:
+	argc -= 2;
+	argv += 2;
+
+	if (!strcmp("start", command)) {
 		set_terms(&terms, "bad", "good");
 		res = bisect_start(&terms, argv, argc);
-		break;
-	case BISECT_TERMS:
+	} else if (!strcmp("terms", command)) {
 		if (argc > 1)
-			die(_("--bisect-terms requires 0 or 1 argument"));
+			die(_("'terms' requires 0 or 1 argument"));
 		res = bisect_terms(&terms, argc == 1 ? argv[0] : NULL);
-		break;
-	case BISECT_SKIP:
+	} else if (!strcmp("skip", command)) {
 		set_terms(&terms, "bad", "good");
 		get_terms(&terms);
 		res = bisect_skip(&terms, argv, argc);
-		break;
-	case BISECT_NEXT:
+	} else if (!strcmp("next", command)) {
 		if (argc)
-			die(_("--bisect-next requires 0 arguments"));
+			die(_("'next' requires 0 arguments"));
 		get_terms(&terms);
 		res = bisect_next(&terms, prefix);
-		break;
-	case BISECT_RESET:
+	} else if (!strcmp("reset", command)) {
 		if (argc > 1)
-			die(_("--bisect-reset requires either no argument or a commit"));
+			die(_("'reset' requires either no argument or a commit"));
 		res = bisect_reset(argc ? argv[0] : NULL);
-		break;
-	case BISECT_VISUALIZE:
+	} else if (one_of(command, "visualize", "view", NULL)) {
 		get_terms(&terms);
 		res = bisect_visualize(&terms, argv, argc);
-		break;
-	case BISECT_REPLAY:
+	} else if (!strcmp("replay", command)) {
 		if (argc != 1)
 			die(_("no logfile given"));
 		set_terms(&terms, "bad", "good");
 		res = bisect_replay(&terms, argv[0]);
-		break;
-	case BISECT_LOG:
+	} else if (!strcmp("log", command)) {
 		if (argc)
-			die(_("--bisect-log requires 0 arguments"));
+			die(_("'log' requires 0 arguments"));
 		res = bisect_log();
-		break;
-	case BISECT_RUN:
+	} else if (!strcmp("run", command)) {
 		if (!argc)
 			die(_("bisect run failed: no command provided."));
 		get_terms(&terms);
 		res = bisect_run(&terms, argv, argc);
-		break;
-	case BISECT_STATE:
+	} else {
 		set_terms(&terms, "bad", "good");
 		get_terms(&terms);
-		if (!cmdmode &&
-		    (!argc || check_and_set_terms(&terms, argv[0]))) {
-			char *msg = xstrfmt(_("unknown command: '%s'"), argv[0]);
-			usage_msg_opt(msg, git_bisect_helper_usage, options);
+		if (check_and_set_terms(&terms, command)) {
+			char *msg = xstrfmt(_("unknown command: '%s'"), command);
+			usage_msg_opt(msg, git_bisect_usage, options);
 		}
+		/* shift the `command` back in */
+		argc++;
+		argv--;
 		res = bisect_state(&terms, argv, argc);
-		break;
-	default:
-		BUG("unknown subcommand %d", cmdmode);
 	}
+
 	free_terms(&terms);
 
 	/*
diff --git a/git-bisect.sh b/git-bisect.sh
index fbf56649d7d..028d39cd9ce 100755
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
-		git bisect--helper "$cmd" "$@" ;;
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

