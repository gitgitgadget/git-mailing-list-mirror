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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70794C4320A
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 08:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56EF860E78
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 08:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239067AbhHQIQl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 04:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238985AbhHQIQb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 04:16:31 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E134C0613C1
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 01:15:58 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id h24-20020a1ccc180000b029022e0571d1a0so1550064wmb.5
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 01:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RVyqWPJ8eOL3p0gBxtbX/zKM1tSkT+6bDVd5q5TFpmU=;
        b=JC1IXQZHV+uHlnCsegiW8k8/obo0umOzk5XxWSa5v40lFKzCIGKhCtVADaRVScWjmx
         IIgaktrpehrMIs3KrRPFaEwZbcGEP2dHt13o3aA/mGZVq6U/SJ6x8Elna4V1Yhoj12mH
         Mfib90jX5YJ/G/qBLuW8JmU73nzvsq9xs2f+v8Vzi69Dx4jrCqyy9TDrNA2Trm+96hvV
         x1I4FIuMHGdJf/fLAWabdH+p2pt4TI1vUUqUT911fBwXSKQZnKtjAE3Vk+j0FgbuhbSM
         u0OOvKGBmbII3U6ZWRrc2KVk3sqfrR+rxWVHLqx4q8vmLxvpI3YDT5ek/k23RKjEMJsm
         d/2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RVyqWPJ8eOL3p0gBxtbX/zKM1tSkT+6bDVd5q5TFpmU=;
        b=X8vNoEhDkb8gxVtPQi2vcT17XoaT4lkZr3PDqmQw+RBZaWZokwzyrrzwbj7oVvA52X
         5SohnLbZy29LWTKayw5VvNIe6L0kOQdN9spNQ+HPzQjM3asPfYQI7OcsgHE6c7Xv4dj6
         y5AZttn/iad5TIZEDBZfNVZWk9lNabWT1trmAdGoyEAErWT51Gr1CXRmTrye5bDMF813
         vhn8LyuLBFB2PTZ+43cEXCGU8+IqQZNe94SRK/Hg4ScwEKSLjueCzLgB8/FlcCTqpqu4
         zTD5mqwBSe5fqSxX+CLmJCN07cZTszlWlCovXdqIbWGdJnzQeHVJihIwQqJVm2jhoyKE
         ZJ0g==
X-Gm-Message-State: AOAM532PQa1lS+oWterKUz+gih3NGBsAHByTQ3VuqsDBkeBVUVMAXH+E
        3H0SVn0kV/T1Pl1/w2F6uBDjrfx8wcc=
X-Google-Smtp-Source: ABdhPJxSHroMt2xxm9j6HPlFCxNtZi0ZE796yjooJcv2kqLh57FWYPa9L7soH9QwYfxjCqX5sPzZWw==
X-Received: by 2002:a05:600c:1546:: with SMTP id f6mr2060633wmg.125.1629188156700;
        Tue, 17 Aug 2021 01:15:56 -0700 (PDT)
Received: from localhost.localdomain ([178.237.233.111])
        by smtp.gmail.com with ESMTPSA id l21sm1256238wmh.31.2021.08.17.01.15.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Aug 2021 01:15:56 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Tanushree Tumane <tanushreetumane@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v4 5/6] bisect--helper: reimplement `bisect_run` shell function in C
Date:   Tue, 17 Aug 2021 10:14:57 +0200
Message-Id: <20210817081458.53136-6-mirucam@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210817081458.53136-1-mirucam@gmail.com>
References: <20210817081458.53136-1-mirucam@gmail.com>
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
 builtin/bisect--helper.c | 75 ++++++++++++++++++++++++++++++++++++++++
 git-bisect.sh            | 62 +--------------------------------
 2 files changed, 76 insertions(+), 61 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 4258429c1c..852e0a30fb 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -31,6 +31,7 @@ static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-replay <filename>"),
 	N_("git bisect--helper --bisect-skip [(<rev>|<range>)...]"),
 	N_("git bisect--helper --bisect-visualize"),
+	N_("git bisect--helper --bisect-run <cmd>..."),
 	NULL
 };
 
@@ -1075,6 +1076,71 @@ static int bisect_visualize(struct bisect_terms *terms, const char **argv, int a
 	return res;
 }
 
+static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
+{
+	int res = BISECT_OK;
+	struct strbuf command = STRBUF_INIT;
+	struct strvec args = STRVEC_INIT;
+	struct strvec run_args = STRVEC_INIT;
+	int exit = 0;
+
+	if (bisect_next_check(terms, NULL))
+		return BISECT_FAILED;
+
+	if (argc)
+		sq_quote_argv(&command, argv);
+	else
+		return BISECT_FAILED;
+
+	strvec_push(&run_args, command.buf);
+
+	while (1) {
+		strvec_clear(&args);
+		exit = 1;
+
+		printf(_("running %s"), command.buf);
+		res = run_command_v_opt(run_args.v, RUN_USING_SHELL);
+
+		if (res < 0 || 128 <= res) {
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
+		if (res == BISECT_ONLY_SKIPPED_LEFT)
+			error(_("bisect run cannot continue any more"));
+		else if (res == BISECT_INTERNAL_SUCCESS_MERGE_BASE) {
+			printf(_("bisect run success"));
+			res = BISECT_OK;
+		} else if (res == BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND) {
+			printf(_("bisect found first bad commit"));
+			res = BISECT_OK;
+		} else if (res) {
+			error(_("bisect run failed:'git bisect--helper --bisect-state"
+			" %s' exited with error code %d"), args.v[0], res);
+		} else {
+			exit = 0;
+		}
+
+		if (exit) {
+			strbuf_release(&command);
+			strvec_clear(&args);
+			strvec_clear(&run_args);
+			return res;
+		}
+	}
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
@@ -1089,6 +1155,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_REPLAY,
 		BISECT_SKIP,
 		BISECT_VISUALIZE,
+		BISECT_RUN,
 	} cmdmode = 0;
 	int res = 0, nolog = 0;
 	struct option options[] = {
@@ -1112,6 +1179,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("skip some commits for checkout"), BISECT_SKIP),
 		OPT_CMDMODE(0, "bisect-visualize", &cmdmode,
 			 N_("visualize the bisection"), BISECT_VISUALIZE),
+		OPT_CMDMODE(0, "bisect-run", &cmdmode,
+			 N_("use <cmd>... to automatically bisect."), BISECT_RUN),
 		OPT_BOOL(0, "no-log", &nolog,
 			 N_("no log for BISECT_WRITE")),
 		OPT_END()
@@ -1177,6 +1246,12 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
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

