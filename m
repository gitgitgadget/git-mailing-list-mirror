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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89718C433EF
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 17:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70709610D1
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 17:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346701AbhIMRln (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 13:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344671AbhIMRlM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 13:41:12 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2A2C061797
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 10:39:17 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id x6so15911094wrv.13
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 10:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tJvXCdQwq20j860N/extc/9doqrCnzuR6uR/99nLMgw=;
        b=j2UzAGaR/nUqm5X8oJKEj4nJu/s7Oe40mL/+27sC3PiLatGHzuX7VYbV4l6TFhKpqA
         XJDux8IOMAUr4ZSwBpRSe5//w+mzMjJznChsaf81ywOKeflp0cKvdfP4z5U6ki4Kggoe
         joXWfoTxH77COuzyWkxwpZSfUfY1zVZMahRsY3BHUXYzQpoaPtjBFLk7+91G2T2/dXDm
         CUD3WnxkViW0xsis6b+WwyR/uD0al/2ewDeXitDzqdpzdcT/9OHYmoHYgzo9TP4LWLw6
         fuZ8pZZrUwpmbeUxT8Yx1UwjZTnV9FBD9OPu/hA5YNxMQ5lhCBDlrOitaFno0LrR9KOd
         W2bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tJvXCdQwq20j860N/extc/9doqrCnzuR6uR/99nLMgw=;
        b=QYpq9S0NgGWX/ihrZsAw/mFfAbKU9hMFx5rzQMWQMyTwqys1ppvlpKYWyPstDYW2vU
         XyZiWATHIIJ0hzwKW/cR11jltK1Pd6fth34Qx1tqs3AO17lyi7rwuBn9jOJkEBqrJPqX
         tfX0m2L6/Og2nArVpRAGMnQY/Onjyw+4pmhg8jXFIFC2EoZdZoNQbueG8CELfwZ6gplr
         Yi9c8SpGkG/HqWblE8Y+Yx7wGGArKDUpY71zTzvYpH4XwITprlYuM5/kqKsINJN9D4V2
         ferxw8kMCZBwf6W+wTDv2Lw8cyq0im7C9HX/pfVKTU808YP0Dgi6kiT7bwztBpuLwII0
         aJ2A==
X-Gm-Message-State: AOAM532oHFXI/PbUsdXQsMOwoubNReE8vh99PwE1xgkO7jBR1MVa0V77
        tRU7WkGJd+n91sR7SAgTp8m3ThXBsrg=
X-Google-Smtp-Source: ABdhPJxHgC3lFuIKzoMBOUgNv8AdzbhlFMHr0ctK/B2y2uNA4C/mIN/y1uiPdIyJU518jSGMtC7vcg==
X-Received: by 2002:a5d:67cc:: with SMTP id n12mr8454220wrw.381.1631554756566;
        Mon, 13 Sep 2021 10:39:16 -0700 (PDT)
Received: from localhost.localdomain ([81.0.34.57])
        by smtp.gmail.com with ESMTPSA id u25sm4428959wmm.5.2021.09.13.10.39.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Sep 2021 10:39:16 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Tanushree Tumane <tanushreetumane@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v7 5/6] bisect--helper: reimplement `bisect_run` shell function in C
Date:   Mon, 13 Sep 2021 19:39:03 +0200
Message-Id: <20210913173905.44438-6-mirucam@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210913173905.44438-1-mirucam@gmail.com>
References: <20210913173905.44438-1-mirucam@gmail.com>
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
 builtin/bisect--helper.c | 105 +++++++++++++++++++++++++++++++++++++++
 git-bisect.sh            |  62 +----------------------
 2 files changed, 106 insertions(+), 61 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 1465310734..ea966268df 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -18,6 +18,7 @@ static GIT_PATH_FUNC(git_path_bisect_log, "BISECT_LOG")
 static GIT_PATH_FUNC(git_path_head_name, "head-name")
 static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
 static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
+static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
 
 static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-reset [<commit>]"),
@@ -31,6 +32,7 @@ static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-replay <filename>"),
 	N_("git bisect--helper --bisect-skip [(<rev>|<range>)...]"),
 	N_("git bisect--helper --bisect-visualize"),
+	N_("git bisect--helper --bisect-run <cmd>..."),
 	NULL
 };
 
@@ -144,6 +146,19 @@ static int append_to_file(const char *path, const char *format, ...)
 	return res;
 }
 
+static int print_file_to_stdout(const char *path)
+{
+	int fd = open(path, O_RDONLY);
+	int ret = 0;
+
+	if (fd < 0)
+		return error_errno(_("cannot open file '%s' for reading"), path);
+	if (copy_fd(fd, 1) < 0)
+		ret = error_errno(_("failed to read '%s'"), path);
+	close(fd);
+	return ret;
+}
+
 static int check_term_format(const char *term, const char *orig_term)
 {
 	int res;
@@ -1075,6 +1090,87 @@ static int bisect_visualize(struct bisect_terms *terms, const char **argv, int a
 	return res;
 }
 
+static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
+{
+	int res = BISECT_OK;
+	struct strbuf command = STRBUF_INIT;
+	struct strvec args = STRVEC_INIT;
+	struct strvec run_args = STRVEC_INIT;
+	const char *new_state;
+	int temporary_stdout_fd, saved_stdout;
+
+	if (bisect_next_check(terms, NULL))
+		return BISECT_FAILED;
+
+	if (argc)
+		sq_quote_argv(&command, argv);
+	else {
+		error(_("bisect run failed: no command provided."));
+		return BISECT_FAILED;
+	}
+
+	strvec_push(&run_args, command.buf);
+
+	while (1) {
+		strvec_clear(&args);
+
+		printf(_("running %s\n"), command.buf);
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
+			new_state = "skip";
+		else if (!res)
+			new_state = terms->term_good;
+		else
+			new_state = terms->term_bad;
+
+		temporary_stdout_fd = open(git_path_bisect_run(), O_CREAT | O_WRONLY | O_TRUNC, 0666);
+
+		if (temporary_stdout_fd < 0)
+			return error_errno(_("cannot open file '%s' for writing"), git_path_bisect_run());
+
+		fflush(stdout);
+		saved_stdout = dup(1);
+		dup2(temporary_stdout_fd, 1);
+
+		res = bisect_state(terms, &new_state, 1);
+
+		fflush(stdout);
+		dup2(saved_stdout, 1);
+		close(saved_stdout);
+		close(temporary_stdout_fd);
+
+		print_file_to_stdout(git_path_bisect_run());
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
+			continue;
+		}
+
+		strbuf_release(&command);
+		strvec_clear(&args);
+		strvec_clear(&run_args);
+		return res;
+	}
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
@@ -1089,6 +1185,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_REPLAY,
 		BISECT_SKIP,
 		BISECT_VISUALIZE,
+		BISECT_RUN,
 	} cmdmode = 0;
 	int res = 0, nolog = 0;
 	struct option options[] = {
@@ -1112,6 +1209,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("skip some commits for checkout"), BISECT_SKIP),
 		OPT_CMDMODE(0, "bisect-visualize", &cmdmode,
 			 N_("visualize the bisection"), BISECT_VISUALIZE),
+		OPT_CMDMODE(0, "bisect-run", &cmdmode,
+			 N_("use <cmd>... to automatically bisect."), BISECT_RUN),
 		OPT_BOOL(0, "no-log", &nolog,
 			 N_("no log for BISECT_WRITE")),
 		OPT_END()
@@ -1177,6 +1276,12 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
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

