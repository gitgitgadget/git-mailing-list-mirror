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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D1DC433E0
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 15:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FC6E23340
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 15:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbhAWPnM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 10:43:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbhAWPnI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 10:43:08 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACE6C061794
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 07:41:55 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id v15so7947846wrx.4
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 07:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MKV0VC1SUcPkTQL0JeTYDy+yzBhRPgxMJyS0MYrjpHI=;
        b=AD8M14rp9xlsuqbwfvkBAQXnJ7gUJfbq1srPIaM1D40GVnGOSgpiI2UkSOQEvE4eud
         KlfUIu1R/mJ8Arkxa3LduaEvbGSH4Tb3HKaVLipyj9p4Ktz0GOzS/IOXmlJS0uJNOpX9
         FBYV8yU/JXAYStxkreeAUN7c2kKFr3P4PSAy0JYct5KrJuXyFYORXTAJYAO4sP8yr2Ue
         zEqnot1oIX+4q38YpaOWrxWhi+QZVNi4K0OpqVlxinLq+rBJE6McsQ0Fn7izVnW8kWhn
         /OOS95geIBgrsKIOiqDUaElKT39dpP9068bMus60scG/CMT3UvdE70CIVF3IFG+tEhEp
         6JMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MKV0VC1SUcPkTQL0JeTYDy+yzBhRPgxMJyS0MYrjpHI=;
        b=ImseA4LtlmdB4Iown6BnZ3InGhzyxsaXUlRT/J+D7+dmUPBBwH0X9VHeMUg3lzbpXn
         t7WxcCtN1ex2CvOLZrbbqw/qADMLzpUdeFsduCJQ8qHxiwYhD63Uq5t3QysnhKq/u5Up
         BKgBk/Yt3bEsGWBotknjdtH8D9vICsrAmMrL7vdv6ahUsM1baJvpWrQpL1ofcG54dW9A
         wOf+grYyBkplE/bT+qlrK0upE67jOaazGW0ptGMWJCMlWgQ+21jm5gM0xr7U6/2NIgQn
         xiwi6ngxmtUmDqXYmszNmHwr+VgRTGnQOmBPf0q57+Jk2KNJdquIysEeO6LQoy6PdaMG
         k2hQ==
X-Gm-Message-State: AOAM530VxQp9OfD4a5R6afxG+SSV2pyhDW8maxmXjBOPDS+tjvkJpDbR
        b1rx0SyFVixlSFTHxFlaTBUImPPG5+o=
X-Google-Smtp-Source: ABdhPJx7U3GD4L4EvRxikNp5jYa5TaOtKQwanHz3aDQ9uyES7MroR3YIHTCqiLrtLTpUsWpI+uMfYw==
X-Received: by 2002:a5d:664c:: with SMTP id f12mr9474759wrw.61.1611416513795;
        Sat, 23 Jan 2021 07:41:53 -0800 (PST)
Received: from localhost.localdomain ([81.0.50.72])
        by smtp.gmail.com with ESMTPSA id o8sm16772353wrm.17.2021.01.23.07.41.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Jan 2021 07:41:52 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v3 6/7] bisect--helper: reimplement `bisect_skip` shell function in C
Date:   Sat, 23 Jan 2021 16:40:55 +0100
Message-Id: <20210123154056.48234-7-mirucam@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210123154056.48234-1-mirucam@gmail.com>
References: <20210123154056.48234-1-mirucam@gmail.com>
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
index 1e53845e69..61ddaa6b9c 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -30,6 +30,7 @@ static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-state (bad|new) [<rev>]"),
 	N_("git bisect--helper --bisect-state (good|old) [<rev>...]"),
 	N_("git bisect--helper --bisect-replay <filename>"),
+	N_("git bisect--helper --bisect-skip [(<rev>|<range>)...]"),
 	NULL
 };
 
@@ -987,6 +988,41 @@ static enum bisect_error bisect_replay(struct bisect_terms *terms, const char *f
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
@@ -999,7 +1035,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_NEXT,
 		BISECT_STATE,
 		BISECT_LOG,
-		BISECT_REPLAY
+		BISECT_REPLAY,
+		BISECT_SKIP
 	} cmdmode = 0;
 	int res = 0, nolog = 0;
 	struct option options[] = {
@@ -1021,6 +1058,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("list the bisection steps so far"), BISECT_LOG),
 		OPT_CMDMODE(0, "bisect-replay", &cmdmode,
 			 N_("replay the bisection process from the given file"), BISECT_REPLAY),
+		OPT_CMDMODE(0, "bisect-skip", &cmdmode,
+			 N_("skip some commits for checkout"), BISECT_SKIP),
 		OPT_BOOL(0, "no-log", &nolog,
 			 N_("no log for BISECT_WRITE")),
 		OPT_END()
@@ -1083,6 +1122,10 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
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
index 79bcd31bd7..016cc34e03 100755
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

