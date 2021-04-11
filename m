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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CD7C433B4
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 09:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07010611EF
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 09:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235398AbhDKJ4b (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 05:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235386AbhDKJ4a (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Apr 2021 05:56:30 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF5EC061574
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 02:56:14 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id a6so9859324wrw.8
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 02:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MLx0yqmDJ4v5kn2GC09r04P04VxiTIwut8GKzsOetEk=;
        b=C0Od25XbF+eWyFxn7rGhukmE17qGjXWo4S9RIvxSdZfDLTry8o2/Wh77Yoruj1QiCb
         hSKMd99y+naolx3jU5Rz00gUoiVIBtcqr31RsgU5KpPDJRkb8VKaxCKMaz5Ud1vZz+oK
         10jYzYBqRDPYj3T5IrM6QUEYB472m8kFJFZGPTsfFDsJ0u0e4Mqp/KJ0Fe054gr2YSOZ
         CJgeD2pq0+YxMdICyf8p0VjNndrOEuG/hsqoVwzBzqxB9nnRy2XB0qWgMxnrnMlKBnhK
         20ea6cKjKeKsS9A4IRxPhPSfeIVA7gX39bZLaXBPlau4XssyCIAmLmuEm+rmSGydJ9uQ
         v46w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MLx0yqmDJ4v5kn2GC09r04P04VxiTIwut8GKzsOetEk=;
        b=WKrqSCZEpZZ3uvQbm7GC+SflozIAuTGloYH90rQuCG6m+A8fR+SMVMKTBlpOsGh0RJ
         vh2N4HWRp39MiWjzEla0PFUwFDgW+RAqwbAf34qpezxxiXMVz+m8OTQsrs6MQWI7T+iq
         7CL8UwUuAnSbXNqIlZ2xef62NuW0O2Q2/tMEzRPA0x6jU8TWHwIOy4uvVfwzeYLDgjaA
         sq4K3aztqZYOhn6hHL7P4uLfqwI8QoxGA+bm6sHVl+uE5x9q7PNf/35reDB5iikChvcQ
         Fp23f34h6+CjwQ0jz+XJ6NohA/uvQtnWV6VgUJI7/TludAz53dYHAws94rTQlfghxAZs
         SLzg==
X-Gm-Message-State: AOAM531uuhmT3wiOr8Ctn7Qh+opaf1wLF9fvUaGxye/XtFDN62RI62+C
        D74p5SBTfB94U+dz0ZQIEg1P8TVMWGo=
X-Google-Smtp-Source: ABdhPJy4bk2Rcrq0WhH0L2xtiobm+Hiw61fQObVh7comTYV6uCIKj2I94ehnNkShYk8qgETyt2MvkA==
X-Received: by 2002:a5d:4402:: with SMTP id z2mr6501058wrq.179.1618134972945;
        Sun, 11 Apr 2021 02:56:12 -0700 (PDT)
Received: from localhost.localdomain ([81.0.37.230])
        by smtp.gmail.com with ESMTPSA id j30sm12994099wrj.62.2021.04.11.02.56.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Apr 2021 02:56:12 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Tanushree Tumane <tanushreetumane@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v3 3/4] bisect--helper: reimplement `bisect_run` shell function in C
Date:   Sun, 11 Apr 2021 11:55:37 +0200
Message-Id: <20210411095538.34129-4-mirucam@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210411095538.34129-1-mirucam@gmail.com>
References: <20210411095538.34129-1-mirucam@gmail.com>
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
 builtin/bisect--helper.c | 83 ++++++++++++++++++++++++++++++++++++++++
 git-bisect.sh            | 62 +-----------------------------
 2 files changed, 84 insertions(+), 61 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 71963979b1..dc87fc7dd0 100644
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
 
@@ -1073,6 +1075,78 @@ static int bisect_visualize(struct bisect_terms *terms, const char **argv, int a
 	return res;
 }
 
+static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
+{
+	int res = BISECT_OK;
+	struct strbuf command = STRBUF_INIT;
+	struct strvec args = STRVEC_INIT;
+	struct strvec run_args = STRVEC_INIT;
+	int exit = 0;
+	int temporary_stdout_fd, saved_stdout;
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
+		temporary_stdout_fd = open(git_path_bisect_run(), O_CREAT | O_WRONLY | O_TRUNC, 0666);
+		saved_stdout = dup(1);
+		dup2(temporary_stdout_fd, 1);
+
+		res = bisect_state(terms, args.v, args.nr);
+
+		dup2(saved_stdout, 1);
+		close(saved_stdout);
+		close(temporary_stdout_fd);
+
+		if (res == BISECT_ONLY_SKIPPED_LEFT)
+			error(_("bisect run cannot continue any more"));
+		else if (res == BISECT_INTERNAL_SUCCESS_MERGE_BASE) {
+			printf(_("bisect run success"));
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
@@ -1087,6 +1161,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_REPLAY,
 		BISECT_SKIP,
 		BISECT_VISUALIZE,
+		BISECT_RUN,
 	} cmdmode = 0;
 	int res = 0, nolog = 0;
 	struct option options[] = {
@@ -1110,6 +1185,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("skip some commits for checkout"), BISECT_SKIP),
 		OPT_CMDMODE(0, "bisect-visualize", &cmdmode,
 			 N_("visualize the bisection"), BISECT_VISUALIZE),
+		OPT_CMDMODE(0, "bisect-run", &cmdmode,
+			 N_("use <cmd>... to automatically bisect."), BISECT_RUN),
 		OPT_BOOL(0, "no-log", &nolog,
 			 N_("no log for BISECT_WRITE")),
 		OPT_END()
@@ -1174,6 +1251,12 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
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

