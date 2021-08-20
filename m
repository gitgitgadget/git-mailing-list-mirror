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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53AD8C4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 17:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3918061154
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 17:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbhHTRXu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 13:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbhHTRXm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 13:23:42 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B41C061575
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 10:23:03 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id u16so15268628wrn.5
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 10:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S1p9BU7/HgWV/1gFQbJBMzmsygz83jLigSmct0YDqdM=;
        b=R2DnKXcgvLiyMHC1RxKRKUb+sVUbGB7D0yvLQhxSY44/hnMfmoy8KgPIKX0pNiNYld
         QPR5z+tagIeI3cj3KKqNoaZPhgp1lIjciV/zCkMhKF/+Lgy5BHwpYNIOdCkmEz4UzWwy
         G/swyP2VVqQhHti1NItplDBHtvidr9Vi9Rrsp8K0+c4mBtxzELEQsIdELr2E3I37+B/L
         iFbGXA3xHewG834yuGu1PsAbsZnD2W5dVGf/UZBx9wQIhd5ixTNLFsadmIas2w5eRgOw
         /Roz+vuuTLUfWjf5AW71f1qKhINYjDWo51EFFNYoQ7aPSlLYl55/K9GRn+DFFLGHOyAm
         lESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S1p9BU7/HgWV/1gFQbJBMzmsygz83jLigSmct0YDqdM=;
        b=AGKURIQvkl6SxvVY7J8znplfu/SIltUYSH6jQo5nBzw7a4pQUSUVwzi3QTgQGW90x4
         kDpGh3+P27YKdlZdp/+IwuNGsuVrDB5XFK8dMWO+4pgIGz49bVgmsboLRht0HGSoRT/O
         jJfkBNege1cK8Y24iTnd01VPhP/NxImJMDylz14xEKbyt2FSsRetBTG8Vw7y4YIPLtWa
         LlBE7Zfw4FwXgLlpOhDz661XpD70QY/1Sqx2rUCv5JRdKLaeZBKQKGAwN+4Z5qILiyY/
         8F5KlncEuTE8NNBy0dpzMA0iYcvSvrO+B8P5a3cZIz9gl4l/50ZbW0SpxK3jaKyacM5f
         ZW4A==
X-Gm-Message-State: AOAM5327Zh1FDo7mImNvfL1ksuFp9l1KGSGHcCSMfRw380QuqQmfOudm
        9E02RBTOSnpf3zoyF+iXOlDQ5sRNo5A=
X-Google-Smtp-Source: ABdhPJw7hWJjmmeO0dnW5TOJ5PhUPCvQhlklefOR7L44h/ldtc0Y+DNstzoY02AyJ/BnPkzp+VZYGg==
X-Received: by 2002:a5d:5085:: with SMTP id a5mr12040211wrt.62.1629480182493;
        Fri, 20 Aug 2021 10:23:02 -0700 (PDT)
Received: from localhost.localdomain ([178.237.232.111])
        by smtp.gmail.com with ESMTPSA id x13sm6623278wrq.44.2021.08.20.10.23.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Aug 2021 10:23:02 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Tanushree Tumane <tanushreetumane@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v5 5/6] bisect--helper: reimplement `bisect_run` shell function in C
Date:   Fri, 20 Aug 2021 19:21:47 +0200
Message-Id: <20210820172148.2249-6-mirucam@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210820172148.2249-1-mirucam@gmail.com>
References: <20210820172148.2249-1-mirucam@gmail.com>
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
 builtin/bisect--helper.c | 102 +++++++++++++++++++++++++++++++++++++++
 git-bisect.sh            |  62 +-----------------------
 2 files changed, 103 insertions(+), 61 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 1e118a966a..8d33c809aa 100644
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
 
@@ -144,6 +146,25 @@ static int append_to_file(const char *path, const char *format, ...)
 	return res;
 }
 
+static int print_file_to_stdout(const char *path)
+{
+	FILE *fp;
+	char c;
+
+	fp = fopen(path, "r");
+	if (!fp)
+		return error_errno(_("cannot open file '%s' in read mode"), path);
+
+	c = fgetc(fp);
+	while (c != EOF) {
+		printf ("%c", c);
+		c = fgetc(fp);
+	}
+
+	fclose(fp);
+	return 0;
+}
+
 static int check_term_format(const char *term, const char *orig_term)
 {
 	int res;
@@ -1075,6 +1096,78 @@ static int bisect_visualize(struct bisect_terms *terms, const char **argv, int a
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
+		else new_state = res > 0 ? terms->term_bad : terms->term_good;
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
@@ -1089,6 +1182,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_REPLAY,
 		BISECT_SKIP,
 		BISECT_VISUALIZE,
+		BISECT_RUN,
 	} cmdmode = 0;
 	int res = 0, nolog = 0;
 	struct option options[] = {
@@ -1112,6 +1206,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("skip some commits for checkout"), BISECT_SKIP),
 		OPT_CMDMODE(0, "bisect-visualize", &cmdmode,
 			 N_("visualize the bisection"), BISECT_VISUALIZE),
+		OPT_CMDMODE(0, "bisect-run", &cmdmode,
+			 N_("use <cmd>... to automatically bisect."), BISECT_RUN),
 		OPT_BOOL(0, "no-log", &nolog,
 			 N_("no log for BISECT_WRITE")),
 		OPT_END()
@@ -1177,6 +1273,12 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
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

