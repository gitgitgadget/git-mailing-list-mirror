Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9A1C432BE
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 09:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B906661051
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 09:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244987AbhIBJGX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 05:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244954AbhIBJGU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 05:06:20 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC652C061757
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 02:05:22 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id g18so1709136wrc.11
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 02:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u+U3A7uwrSjpldvMAPFF7E24CBpunjpwfcceQ3BE+94=;
        b=QSj1PtwJ7h/nWkhC2CJCGkW2CWja8Ws+txZPkZnCwwO5c4e8if5BhPhzaOjRB0FUdo
         sZ74y/vOcY1xITMnxOCIlFRRVy0atXFtvGqgs6KbT1sBbtP9rySV6fDgN8R4kcpRVYug
         hRnzhTWzuvX5OD6cnoSrTX1TrXARt9b+N0pmDv6lY5hlPQmvXZGzOCX+oXJqNSujUwVj
         MkWatQgQD8TtEvdZQIEjIi0NiIj4y27cP3QLPwhLcL9dWpk6G3LTFtqxaWVPZwBIyv7W
         vHtdZeZcesSvwCjHWjX2ZEksrd1ZsaH40tEOTpB+q0v8nu6gGVdWU6tsQFIpQxmwJV1W
         ScsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u+U3A7uwrSjpldvMAPFF7E24CBpunjpwfcceQ3BE+94=;
        b=qsg5FiSLC/3LHherCs7WSXwot/DZcpCpfft8NZGL3GoCs075dKMNJG3vGdOe8TYYJD
         Rr/+ucyqF1WcmAiorhuuK9s5mlO91/d/2M5Y407H7X3nPKa2/fycDmYoSGarYfUQAvlu
         DS4i3znzEbPwbXuHC9rOH9c5P4xWEXSXhOdvx8JGrFCZT8UkNvPYeA2ViRVWDrM1Hv93
         DlkdneNAA/NYYWei8hQ+j826OqcpJaUFEfMNSTE57i4OaSqrRk4sUh6WktW8rNBrCwx5
         K1ESbA+PJeJy0jeoNtZfc6H2YHqYhVF+iseiaDgCEfJBFVBPe9q1HPilwDixLWNdTwN2
         ynfg==
X-Gm-Message-State: AOAM5307pE/Mlm2KrnbKZISq6VMOB25INdxdQ/7eZGDHjOSiOwUy+SqG
        CHtK+XTtzHeM5WOEkrk1a/Y1CtQLyjw=
X-Google-Smtp-Source: ABdhPJyXQBhi51haRL341Mso+g2vHxDfI4F/pnOviaQcuII/usEUCGGVg+V0VlDHDGNz5F1YLEAzVQ==
X-Received: by 2002:adf:9e08:: with SMTP id u8mr2350082wre.383.1630573521325;
        Thu, 02 Sep 2021 02:05:21 -0700 (PDT)
Received: from localhost.localdomain ([178.237.237.111])
        by smtp.gmail.com with ESMTPSA id l17sm1262516wrz.35.2021.09.02.02.05.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Sep 2021 02:05:20 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Tanushree Tumane <tanushreetumane@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v6 5/6] bisect--helper: reimplement `bisect_run` shell
Date:   Thu,  2 Sep 2021 11:04:20 +0200
Message-Id: <20210902090421.93113-6-mirucam@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210902090421.93113-1-mirucam@gmail.com>
References: <20210902090421.93113-1-mirucam@gmail.com>
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
 builtin/bisect--helper.c | 97 ++++++++++++++++++++++++++++++++++++++++
 git-bisect.sh            | 62 +------------------------
 2 files changed, 98 insertions(+), 61 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 1e118a966a..8e9ed9c318 100644
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
@@ -1075,6 +1090,79 @@ static int bisect_visualize(struct bisect_terms *terms, const char **argv, int a
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
+		else
+			new_state = res > 0 ? terms->term_bad : terms->term_good;
+
+		temporary_stdout_fd = open(git_path_bisect_run(), O_CREAT | O_WRONLY | O_TRUNC, 0666);
+		saved_stdout = dup(1);
+		dup2(temporary_stdout_fd, 1);
+
+		res = bisect_state(terms, &new_state, 1);
+
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
@@ -1089,6 +1177,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_REPLAY,
 		BISECT_SKIP,
 		BISECT_VISUALIZE,
+		BISECT_RUN,
 	} cmdmode = 0;
 	int res = 0, nolog = 0;
 	struct option options[] = {
@@ -1112,6 +1201,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("skip some commits for checkout"), BISECT_SKIP),
 		OPT_CMDMODE(0, "bisect-visualize", &cmdmode,
 			 N_("visualize the bisection"), BISECT_VISUALIZE),
+		OPT_CMDMODE(0, "bisect-run", &cmdmode,
+			 N_("use <cmd>... to automatically bisect."), BISECT_RUN),
 		OPT_BOOL(0, "no-log", &nolog,
 			 N_("no log for BISECT_WRITE")),
 		OPT_END()
@@ -1177,6 +1268,12 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
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

