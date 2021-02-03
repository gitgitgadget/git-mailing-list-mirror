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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BA8C433DB
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 21:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AD7964F6B
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 21:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbhBCV4y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 16:56:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbhBCV4s (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 16:56:48 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2556C06178B
        for <git@vger.kernel.org>; Wed,  3 Feb 2021 13:55:32 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id f16so1217337wmq.5
        for <git@vger.kernel.org>; Wed, 03 Feb 2021 13:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1I9MuZk5+Y9ELPMFnogL7a7Kp0ubTDgTkirTInm3rRI=;
        b=neEOt168rcL9GoZSFr9+q2ox8yV2lFU1T7NRdF2PhXc7a+xOLn5pgPX4lAdV7Ber7L
         3P5/5xnE2IQfAWSWd+AkXXShfCgpekqwTVZU6Bwl1H8nkB2FOTlBd0qbVyOBz+ezY2Wo
         CoDifFe4vWVSBCkMkyhKSwKKtrugOiPOMM4LwvbrQW48+jdLSdJFHHLDc43V1DdzufwM
         d3Rwx8NRgo65xmlvAqv1f2H3u0CSLkpF0FYDWSFFLWGny1nCIBZ+U5U/0k203qDrel5v
         pyaaK+TQ4WjFpVxA4q/IsDcAVlUBgmkrA1/Y3Hs5XuaPYPhNO9Hpz4JO7iQ6U7/3bj3/
         Dp6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1I9MuZk5+Y9ELPMFnogL7a7Kp0ubTDgTkirTInm3rRI=;
        b=TU4F38FKafXTXn84cPyn/hwtbHjDrWu+0R98X99ZDh6Vy7zX6/EWb0UVuLQtRywiCX
         4IiJf4YgCctmTOhcvtDXZ5GpmWxnb9YxOC0EqMNqidoOkvCg9AKMiHnGBbQnzpv8Y0iy
         CtLqrdIvZTIUwyCVY3Y0VaxokUSYO9+2M58xtB3MPdnFm2/0+50avb8YNl9zjub+w2XG
         FLHWIbBmG139M9mLVsdfcDQx0YYfGuB82AbZgBy2B+7NWt0UBem4PyrXzN9omlKac6Rg
         ybqddkc5gqAsoEzqIzvNxKUzlqoX7U8m30hBi3ED4XYSp1xXrTxXy5PfOG1Cyq56fEG9
         eIvg==
X-Gm-Message-State: AOAM530PjjP8FPIx2syGmYCBGkovpryjLR20LdVacFSz8EwbAM8RqPEB
        Km4YjoQnJ4V49A96BfCnGg0Ojk039DQ=
X-Google-Smtp-Source: ABdhPJy7xeGVZ7n4RvIIEekZ3RjmJg6qZ1wZz2qonIE69J7jZfKGZZyUIcpRPi7aXKMtlcK5fzhZcA==
X-Received: by 2002:a05:600c:3504:: with SMTP id h4mr4712173wmq.168.1612389331571;
        Wed, 03 Feb 2021 13:55:31 -0800 (PST)
Received: from localhost.localdomain ([81.0.37.148])
        by smtp.gmail.com with ESMTPSA id 143sm2609531wmb.47.2021.02.03.13.55.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2021 13:55:31 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     rafaeloliveira.cs@gmail.com, Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v5 6/7] bisect--helper: reimplement `bisect_skip` shell function in C
Date:   Wed,  3 Feb 2021 22:54:37 +0100
Message-Id: <20210203215438.96760-7-mirucam@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210203215438.96760-1-mirucam@gmail.com>
References: <20210203215438.96760-1-mirucam@gmail.com>
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
index 31eba522ff..7ad9b4d55b 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -30,6 +30,7 @@ static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-state (bad|new) [<rev>]"),
 	N_("git bisect--helper --bisect-state (good|old) [<rev>...]"),
 	N_("git bisect--helper --bisect-replay <filename>"),
+	N_("git bisect--helper --bisect-skip [(<rev>|<range>)...]"),
 	NULL
 };
 
@@ -992,6 +993,41 @@ static enum bisect_error bisect_replay(struct bisect_terms *terms, const char *f
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
@@ -1004,7 +1040,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_NEXT,
 		BISECT_STATE,
 		BISECT_LOG,
-		BISECT_REPLAY
+		BISECT_REPLAY,
+		BISECT_SKIP
 	} cmdmode = 0;
 	int res = 0, nolog = 0;
 	struct option options[] = {
@@ -1026,6 +1063,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("list the bisection steps so far"), BISECT_LOG),
 		OPT_CMDMODE(0, "bisect-replay", &cmdmode,
 			 N_("replay the bisection process from the given file"), BISECT_REPLAY),
+		OPT_CMDMODE(0, "bisect-skip", &cmdmode,
+			 N_("skip some commits for checkout"), BISECT_SKIP),
 		OPT_BOOL(0, "no-log", &nolog,
 			 N_("no log for BISECT_WRITE")),
 		OPT_END()
@@ -1088,6 +1127,10 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
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

