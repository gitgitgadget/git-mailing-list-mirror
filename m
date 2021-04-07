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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A956C433ED
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 17:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E782E6128D
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 17:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354894AbhDGRen (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 13:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354881AbhDGReg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 13:34:36 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08849C061760
        for <git@vger.kernel.org>; Wed,  7 Apr 2021 10:34:26 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id f12so12852555wro.0
        for <git@vger.kernel.org>; Wed, 07 Apr 2021 10:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DSUY569oHjkC1ywZQ0wdQmy4KfPUqh+cHJCfrmIfiOw=;
        b=KvDJkl37hdkpAvuen7PvrX+l3Uxu2xrrK9wsvB8czC7nX0hbU/dCYHUL8ToTkC0LVv
         WjtDCUfkZe0WQauGePNvQK+4syLTWvZjOHIkq7HehJD6lTfcFmovDhxqix8Vj9AHTel9
         d6CkTlpRptDxKB0f8YAzQ3O2K0A6AooVbAnP/pXs9FKvw+VElzq3UBo4Hvt0DTSUeBFP
         /PtZtPn/gtlagqxcPWImqjyTf/BFTXm7euUfoMolDxcggF5btnyZglNMcc4b9UQJ4SVt
         8+Qhcl3VB0WB/6iVUJurgAxO53m3iuneIZ5pXz0M7sFrrYF56Ey7EpwVfoQS8SR/EqcY
         wWwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DSUY569oHjkC1ywZQ0wdQmy4KfPUqh+cHJCfrmIfiOw=;
        b=Tb7LMQEMAC2BDNq+OloybAxUagS1SoovqvD0j4n9Le5pJACBJR/TB5KlUqK0pcmM0p
         Fqd8iBYLOcmbSkO8z1z2VjKCFG2x3abMNATHIGgTFg5Nc4qPPtEJLMhewYHC7IFvc43q
         bec8BwZyyjYNb2omOMQXZB/uuAOH1yRj4wKURW3MDk4n+2enVdfgCq3wPVWcYCAaSkPT
         RRlkmIMWaO2Yya413kPUFsV7pCW12D6y6xDPw+Zb2i6s0ksexvo6z4RXm2+sBYcnJZ3O
         ybYidDDTudbkU5gL+Z2q8Dzy/MYRLW19CsSKFTgcLV75I0iNasW0xM8HrP9BLBK3uaXm
         czbA==
X-Gm-Message-State: AOAM533oZQOGK8cDKKmWdd0Wwc2LBqpDYSCqL+98YzTSymz2aC4dV6en
        rxlKwURhidJPRsmJrNkkoUAWhJ6cWpEoHg==
X-Google-Smtp-Source: ABdhPJzqkkP53P+nuH3qbPq+i1myiAusp5/aDcIdT74TxQxYH7IrlzKUysuLE0J3KdYxiRzOIgNWHg==
X-Received: by 2002:a5d:5082:: with SMTP id a2mr5652722wrt.267.1617816864812;
        Wed, 07 Apr 2021 10:34:24 -0700 (PDT)
Received: from localhost.localdomain ([81.0.37.230])
        by smtp.gmail.com with ESMTPSA id o7sm41657197wrs.16.2021.04.07.10.34.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Apr 2021 10:34:24 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Tanushree Tumane <tanushreetumane@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v2 3/4] bisect--helper: reimplement `bisect_run` shell function in C
Date:   Wed,  7 Apr 2021 19:33:32 +0200
Message-Id: <20210407173334.68222-4-mirucam@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210407173334.68222-1-mirucam@gmail.com>
References: <20210407173334.68222-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tanushree Tumane <tanushreetumane@gmail.com>

Reimplement the `bisect_run()` shell function
in C and also add `--bisect-run` subcommand to
`git bisect--helper` to call it from git-bisect.sh.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 71 +++++++++++++++++++++++++++++++++++++++-
 git-bisect.sh            | 62 +----------------------------------
 2 files changed, 71 insertions(+), 62 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index b77c4f6b29..31c5f99660 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -31,6 +31,7 @@ static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-replay <filename>"),
 	N_("git bisect--helper --bisect-skip [(<rev>|<range>)...]"),
 	N_("git bisect--helper --bisect-visualize"),
+	N_("git bisect--helper --bisect-run <cmd>..."),
 	NULL
 };
 
@@ -1073,6 +1074,65 @@ static int bisect_visualize(struct bisect_terms *terms, const char **argv, int a
 	return res;
 }
 
+static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
+{
+	int res = BISECT_OK;
+	struct strbuf command = STRBUF_INIT;
+	struct strvec args = STRVEC_INIT;
+	struct strvec run_args = STRVEC_INIT;
+
+	if (bisect_next_check(terms, NULL))
+		return BISECT_FAILED;
+
+	if (argc)
+		sq_quote_argv(&command, argv);
+	else
+		return BISECT_FAILED;
+
+	run_args.v[0] = xstrdup(command.buf);
+	run_args.nr = 1;
+
+	while (1) {
+		strvec_clear(&args);
+
+		printf(_("running %s"), command.buf);
+		res = run_command_v_opt(run_args.v, RUN_USING_SHELL);
+
+		if (res < 0 && res >= 128) {
+			error(_("bisect run failed: exit code %d from"
+				" '%s' is < 0 or >= 128"), res, command.buf);
+			strbuf_release(&command);
+			return res;
+		}
+
+		if (res == 125)
+			strvec_push(&args, "skip");
+		else if (res > 0)
+			strvec_push(&args, terms->term_bad);
+		else
+			strvec_push(&args, terms->term_good);
+
+		res = bisect_state(terms, args.v, args.nr);
+
+		if (res == BISECT_INTERNAL_SUCCESS_MERGE_BASE) {
+			printf(_("bisect run success"));
+			res = BISECT_OK;
+		} else if (res == BISECT_ONLY_SKIPPED_LEFT)
+			error(_("bisect run cannot continue any more"));
+		else if (res)
+			error(_("bisect run failed:'git bisect--helper --bisect-state"
+				" %s' exited with error code %d"), args.v[0], res);
+		else
+			continue;
+
+		strbuf_release(&command);
+		strvec_clear(&args);
+		strvec_clear(&run_args);
+
+		return res;
+	}
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
@@ -1086,7 +1146,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_LOG,
 		BISECT_REPLAY,
 		BISECT_SKIP,
-		BISECT_VISUALIZE
+		BISECT_VISUALIZE,
+		BISECT_RUN,
 	} cmdmode = 0;
 	int res = 0, nolog = 0;
 	struct option options[] = {
@@ -1110,6 +1171,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("skip some commits for checkout"), BISECT_SKIP),
 		OPT_CMDMODE(0, "bisect-visualize", &cmdmode,
 			 N_("visualize the bisection"), BISECT_VISUALIZE),
+		OPT_CMDMODE(0, "bisect-run", &cmdmode,
+			 N_("use <cmd>... to automatically bisect."), BISECT_RUN),
 		OPT_BOOL(0, "no-log", &nolog,
 			 N_("no log for BISECT_WRITE")),
 		OPT_END()
@@ -1174,6 +1237,12 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		get_terms(&terms);
 		res = bisect_visualize(&terms, argv, argc);
 		break;
+	case BISECT_RUN:
+		if (!argc)
+			return error(_("bisect run failed: no command provided."));
+		get_terms(&terms);
+		res = bisect_run(&terms, argv, argc);
+		break;
 	default:
 		BUG("unknown subcommand %d", cmdmode);
 	}
diff --git a/git-bisect.sh b/git-bisect.sh
index 95f7f3fb8c..e83d011e17 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -39,66 +39,6 @@ _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
 TERM_BAD=bad
 TERM_GOOD=good
 
-bisect_run () {
-	git bisect--helper --bisect-next-check $TERM_GOOD $TERM_BAD fail || exit
-
-	test -n "$*" || die "$(gettext "bisect run failed: no command provided.")"
-
-	while true
-	do
-		command="$@"
-		eval_gettextln "running \$command"
-		"$@"
-		res=$?
-
-		# Check for really bad run error.
-		if [ $res -lt 0 -o $res -ge 128 ]
-		then
-			eval_gettextln "bisect run failed:
-exit code \$res from '\$command' is < 0 or >= 128" >&2
-			exit $res
-		fi
-
-		# Find current state depending on run success or failure.
-		# A special exit code of 125 means cannot test.
-		if [ $res -eq 125 ]
-		then
-			state='skip'
-		elif [ $res -gt 0 ]
-		then
-			state="$TERM_BAD"
-		else
-			state="$TERM_GOOD"
-		fi
-
-		git bisect--helper --bisect-state $state >"$GIT_DIR/BISECT_RUN"
-		res=$?
-
-		cat "$GIT_DIR/BISECT_RUN"
-
-		if sane_grep "first $TERM_BAD commit could be any of" "$GIT_DIR/BISECT_RUN" \
-			>/dev/null
-		then
-			gettextln "bisect run cannot continue any more" >&2
-			exit $res
-		fi
-
-		if [ $res -ne 0 ]
-		then
-			eval_gettextln "bisect run failed:
-'bisect-state \$state' exited with error code \$res" >&2
-			exit $res
-		fi
-
-		if sane_grep "is the first $TERM_BAD commit" "$GIT_DIR/BISECT_RUN" >/dev/null
-		then
-			gettextln "bisect run success"
-			exit 0;
-		fi
-
-	done
-}
-
 get_terms () {
 	if test -s "$GIT_DIR/BISECT_TERMS"
 	then
@@ -137,7 +77,7 @@ case "$#" in
 	log)
 		git bisect--helper --bisect-log || exit ;;
 	run)
-		bisect_run "$@" ;;
+		git bisect--helper --bisect-run "$@" || exit;;
 	terms)
 		git bisect--helper --bisect-terms "$@" || exit;;
 	*)
-- 
2.29.2

