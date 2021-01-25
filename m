Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5A7C433DB
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 05:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7857722B2C
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 05:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbhAZFC3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 00:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731673AbhAYTSf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 14:18:35 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E51FC061793
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 11:17:31 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id c128so572635wme.2
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 11:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/S+Og8y7Cuomg5nhyRkGBh6mxvDOMx02RqS4GI1gbpg=;
        b=PMBFcdnoLUSk02ygcVcw+m0Ui47Pl1qHwkXY6onAS0rkMGQckXsxW1+bzrDg/3wAXE
         z8TCNdY4Ufdkp0hg5HSiTxkYDgqf2CQTrEncCGiAB+39LaMmGXy3lXDf8+jO7JdOQ2HK
         BUNPDnAPv6HWqHK/cIQtZ5olrTQyVa17+6xgstCtMcpeBYCLp3sgUi/cs8YIanKCaZA1
         jPmvRmD+Rp2Y6xydWdVLf+wUq7LXp6po65MTb9TCii7HGICWqVfPiKaSADiNl/PeV65P
         VnLIqYuiR644Y5+DGuJee+E9s+fSi3B+oMIjOyM5iuii6yXPEOdh+zmKY2AwYB0LwaMX
         E9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/S+Og8y7Cuomg5nhyRkGBh6mxvDOMx02RqS4GI1gbpg=;
        b=Lr18pAgE5AaaVrnOfFcP7FbTTa5CEn5ua9Png0beVL0LABiunwKccXcjwIzY+z9rw4
         1qTiPh2g+OW6aCQF0Q6Q9AKZjlB8MrRp5icqlemCoK1fUGFK6m6PQpXGwA6HzjOgZ2j1
         PxadGDG7JSju1TqgjA2tXEbF4lvqxnPRwuRhTbjTs7sFG5njSbu4z4w6HzxjQxSv8fw7
         pXIxmeOtnghFB/1Y9SZikVXrYmXejN7psqwzqesJ/RnCn/LTSQBS0Gr9jLMckSBd4f4u
         bdG3aO294CfszLb06kQ5MsymFEJWujvpLWDewk4xjB+KW0z84BmOJmAUai1PbSPyBjMW
         tRuQ==
X-Gm-Message-State: AOAM530+vJJoq6PsnXCaSZ0t5Q/XaitwNuWUzpGnSq5wU8E4P+K7MdAt
        ffC1UUMntNj7U2LbJnKMv5Pd6YkAlm0=
X-Google-Smtp-Source: ABdhPJx68dwkq27iDrf87mgDWQuZvtk2rRxtOejXjGjBg96kCnh3hHg4N29KLGEoQpo/Z1YA9KrA7g==
X-Received: by 2002:a7b:c8c3:: with SMTP id f3mr1488630wml.110.1611602250073;
        Mon, 25 Jan 2021 11:17:30 -0800 (PST)
Received: from localhost.localdomain ([81.0.37.108])
        by smtp.gmail.com with ESMTPSA id e4sm11665895wrw.96.2021.01.25.11.17.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jan 2021 11:17:29 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v4 6/7] bisect--helper: reimplement `bisect_skip` shell function in C
Date:   Mon, 25 Jan 2021 20:17:09 +0100
Message-Id: <20210125191710.45161-7-mirucam@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210125191710.45161-1-mirucam@gmail.com>
References: <20210125191710.45161-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

Reimplement the `bisect_skip()` shell function in C and also add
`bisect-skip` subcommand to `git bisect--helper` to call it from
git-bisect.sh

Using `--bisect-skip` subcommand is a temporary measure to port shell
function to C so as to use the existing test suite.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 45 +++++++++++++++++++++++++++++++++++++++-
 git-bisect.sh            | 17 +--------------
 2 files changed, 45 insertions(+), 17 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 3672994c19..145e1a6998 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -30,6 +30,7 @@ static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-state (bad|new) [<rev>]"),
 	N_("git bisect--helper --bisect-state (good|old) [<rev>...]"),
 	N_("git bisect--helper --bisect-replay <filename>"),
+	N_("git bisect--helper --bisect-skip [(<rev>|<range>)...]"),
 	NULL
 };
 
@@ -988,6 +989,41 @@ static enum bisect_error bisect_replay(struct bisect_terms *terms, const char *f
 	return bisect_auto_next(terms, NULL);
 }
 
+static enum bisect_error bisect_skip(struct bisect_terms *terms, const char **argv, int argc)
+{
+	int i;
+	enum bisect_error res;
+	struct strvec argv_state = STRVEC_INIT;
+
+	strvec_push(&argv_state, "skip");
+
+	for (i = 0; i < argc; i++) {
+		const char *dotdot = strstr(argv[i], "..");
+
+		if (dotdot) {
+			struct rev_info revs;
+			struct commit *commit;
+
+			init_revisions(&revs, NULL);
+			setup_revisions(2, argv + i - 1, &revs, NULL);
+
+			if (prepare_revision_walk(&revs))
+				die(_("revision walk setup failed\n"));
+			while ((commit = get_revision(&revs)) != NULL)
+				strvec_push(&argv_state,
+						oid_to_hex(&commit->object.oid));
+
+			reset_revision_walk();
+		} else {
+			strvec_push(&argv_state, argv[i]);
+		}
+	}
+	res = bisect_state(terms, argv_state.v, argv_state.nr);
+
+	strvec_clear(&argv_state);
+	return res;
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
@@ -1000,7 +1036,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_NEXT,
 		BISECT_STATE,
 		BISECT_LOG,
-		BISECT_REPLAY
+		BISECT_REPLAY,
+		BISECT_SKIP
 	} cmdmode = 0;
 	int res = 0, nolog = 0;
 	struct option options[] = {
@@ -1022,6 +1059,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("list the bisection steps so far"), BISECT_LOG),
 		OPT_CMDMODE(0, "bisect-replay", &cmdmode,
 			 N_("replay the bisection process from the given file"), BISECT_REPLAY),
+		OPT_CMDMODE(0, "bisect-skip", &cmdmode,
+			 N_("skip some commits for checkout"), BISECT_SKIP),
 		OPT_BOOL(0, "no-log", &nolog,
 			 N_("no log for BISECT_WRITE")),
 		OPT_END()
@@ -1084,6 +1123,10 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		set_terms(&terms, "bad", "good");
 		res = bisect_replay(&terms, argv[0]);
 		break;
+	case BISECT_SKIP:
+		set_terms(&terms, "bad", "good");
+		res = bisect_skip(&terms, argv, argc);
+		break;
 	default:
 		BUG("unknown subcommand %d", cmdmode);
 	}
diff --git a/git-bisect.sh b/git-bisect.sh
index e834154e29..6a7afaea8d 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -39,21 +39,6 @@ _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
 TERM_BAD=bad
 TERM_GOOD=good
 
-bisect_skip() {
-	all=''
-	for arg in "$@"
-	do
-		case "$arg" in
-		*..*)
-			revs=$(git rev-list "$arg") || die "$(eval_gettext "Bad rev input: \$arg")" ;;
-		*)
-			revs=$(git rev-parse --sq-quote "$arg") ;;
-		esac
-		all="$all $revs"
-	done
-	eval git bisect--helper --bisect-state 'skip' $all
-}
-
 bisect_visualize() {
 	git bisect--helper --bisect-next-check $TERM_GOOD $TERM_BAD fail || exit
 
@@ -162,7 +147,7 @@ case "$#" in
 	bad|good|new|old|"$TERM_BAD"|"$TERM_GOOD")
 		git bisect--helper --bisect-state "$cmd" "$@" ;;
 	skip)
-		bisect_skip "$@" ;;
+		git bisect--helper --bisect-skip "$@" || exit;;
 	next)
 		# Not sure we want "next" at the UI level anymore.
 		git bisect--helper --bisect-next "$@" || exit ;;
-- 
2.29.2

