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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DADC43460
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 09:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CC0E611F0
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 09:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235394AbhDKJ4a (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 05:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235391AbhDKJ43 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Apr 2021 05:56:29 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78006C06138B
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 02:56:13 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so5188324wmj.2
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 02:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XiUdO9/MUHtGHyGT/+/I7m+LftBF4SC9h8sIkh34j1Y=;
        b=ZzuBZ6AWXemreCvAXpNOWTlOrzzRH/XcR9RBQICwCJLzEuSHj0sAAHrBuY6zgREilb
         2ce7u7ucUIZ4J3Neun/+wzYb1wjbOXIDR1X4oKMdu+mXktkHnFJ83K6EiwL7w6f02Dg4
         r75v91pP5PMF8xIiMseV7f//iGoewJp557XwCBZPOmd2Nt1Guvf2UqITr4suogPR2KbJ
         wcgYEDhV0wgwn+q3pKKtFRqJsvJtJNLa8QoThkg5fQIAd+0Nhp2ZYOoTrkTHtEn/kkBr
         lV3ImGAmfiDcyxm2RsSy8TDLhIfKf6zqMkLdJSwruAIuhwI9SloITE+xytmz2ixWKEGA
         jwsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XiUdO9/MUHtGHyGT/+/I7m+LftBF4SC9h8sIkh34j1Y=;
        b=IJfkTIBBi4bI+sVxkW+VmKXV3lXXgcRFD9tspzQp1TMfM+2UEoRbk9Lv21PbvI5U61
         C8lgEZ5FVy/npTeiwVOZeIe26q+ZbiUdflJUbTkxzT2xJrNa5pXMpYivHrbcNBU9lYih
         ie/S2ZCijNoWL7JgMzTqBzi0wx0Fef2ocY05PTt5lgL5vorePZQtm44duhLl8EDeOq0M
         5Amxa4QROKrxZyRt0nQE6AvvTNxQRLJuv41V1xCFrXuELBIT5gTIohocVmGfS8ke2ID7
         iVrBHhSoVmSQIGnuAq/WJrRi9aXS5ZPjG/O+mHyBiIeHcxYReLP6+lboDjtOWTMyK6c+
         +eFw==
X-Gm-Message-State: AOAM531yag0aHbKLTfFMMFCjCjhijIwYIWfWHq4hQfivwLRj0tIidSLU
        2uUJUN/sfSrzZ8tQUto7LRy6KZDusZc=
X-Google-Smtp-Source: ABdhPJzTN+slzZusRMXgdpSIX0Q8u09Lup5Xku0W8ejxDtmi+H0jHEA9US3r9Qr+rZfYbCUk0S1hAA==
X-Received: by 2002:a05:600c:1457:: with SMTP id h23mr21712962wmi.118.1618134972297;
        Sun, 11 Apr 2021 02:56:12 -0700 (PDT)
Received: from localhost.localdomain ([81.0.37.230])
        by smtp.gmail.com with ESMTPSA id j30sm12994099wrj.62.2021.04.11.02.56.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Apr 2021 02:56:12 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v3 2/4] bisect--helper: reimplement `bisect_visualize()`shell function in C
Date:   Sun, 11 Apr 2021 11:55:36 +0200
Message-Id: <20210411095538.34129-3-mirucam@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210411095538.34129-1-mirucam@gmail.com>
References: <20210411095538.34129-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

Reimplement the `bisect_visualize()` shell function
in C and also add `--bisect-visualize` subcommand to
`git bisect--helper` to call it from git-bisect.sh.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 48 +++++++++++++++++++++++++++++++++++++++-
 git-bisect.sh            | 25 +--------------------
 2 files changed, 48 insertions(+), 25 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 1fdb7d9d10..71963979b1 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -30,6 +30,7 @@ static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-state (good|old) [<rev>...]"),
 	N_("git bisect--helper --bisect-replay <filename>"),
 	N_("git bisect--helper --bisect-skip [(<rev>|<range>)...]"),
+	N_("git bisect--helper --bisect-visualize"),
 	NULL
 };
 
@@ -1034,6 +1035,44 @@ static enum bisect_error bisect_skip(struct bisect_terms *terms, const char **ar
 	return res;
 }
 
+static int bisect_visualize(struct bisect_terms *terms, const char **argv, int argc)
+{
+	struct strvec args = STRVEC_INIT;
+	int flags = RUN_COMMAND_NO_STDIN, res = 0;
+	struct strbuf sb = STRBUF_INIT;
+
+	if (bisect_next_check(terms, NULL) != 0)
+		return BISECT_FAILED;
+
+	if (!argc) {
+		if ((getenv("DISPLAY") || getenv("SESSIONNAME") || getenv("MSYSTEM") ||
+		     getenv("SECURITYSESSIONID")) && exists_in_PATH("gitk"))
+			strvec_push(&args, "gitk");
+		else {
+			strvec_pushl(&args, "log", NULL);
+			flags |= RUN_GIT_CMD;
+		}
+	} else {
+		if (argv[0][0] == '-') {
+			strvec_pushl(&args, "log", NULL);
+			flags |= RUN_GIT_CMD;
+		} else if (strcmp(argv[0], "tig") && !starts_with(argv[0], "git"))
+			flags |= RUN_GIT_CMD;
+
+		strvec_pushv(&args, argv);
+	}
+
+	strvec_pushl(&args, "--bisect", "--", NULL);
+
+	strbuf_read_file(&sb, git_path_bisect_names(), 0);
+	sq_dequote_to_strvec(sb.buf, &args);
+	strbuf_release(&sb);
+
+	res = run_command_v_opt(args.v, flags);
+	strvec_clear(&args);
+	return res;
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
@@ -1046,7 +1085,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_STATE,
 		BISECT_LOG,
 		BISECT_REPLAY,
-		BISECT_SKIP
+		BISECT_SKIP,
+		BISECT_VISUALIZE,
 	} cmdmode = 0;
 	int res = 0, nolog = 0;
 	struct option options[] = {
@@ -1068,6 +1108,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("replay the bisection process from the given file"), BISECT_REPLAY),
 		OPT_CMDMODE(0, "bisect-skip", &cmdmode,
 			 N_("skip some commits for checkout"), BISECT_SKIP),
+		OPT_CMDMODE(0, "bisect-visualize", &cmdmode,
+			 N_("visualize the bisection"), BISECT_VISUALIZE),
 		OPT_BOOL(0, "no-log", &nolog,
 			 N_("no log for BISECT_WRITE")),
 		OPT_END()
@@ -1128,6 +1170,10 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		set_terms(&terms, "bad", "good");
 		res = bisect_skip(&terms, argv, argc);
 		break;
+	case BISECT_VISUALIZE:
+		get_terms(&terms);
+		res = bisect_visualize(&terms, argv, argc);
+		break;
 	default:
 		BUG("unknown subcommand %d", cmdmode);
 	}
diff --git a/git-bisect.sh b/git-bisect.sh
index 6a7afaea8d..95f7f3fb8c 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -39,29 +39,6 @@ _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
 TERM_BAD=bad
 TERM_GOOD=good
 
-bisect_visualize() {
-	git bisect--helper --bisect-next-check $TERM_GOOD $TERM_BAD fail || exit
-
-	if test $# = 0
-	then
-		if test -n "${DISPLAY+set}${SESSIONNAME+set}${MSYSTEM+set}${SECURITYSESSIONID+set}" &&
-			type gitk >/dev/null 2>&1
-		then
-			set gitk
-		else
-			set git log
-		fi
-	else
-		case "$1" in
-		git*|tig) ;;
-		-*)	set git log "$@" ;;
-		*)	set git "$@" ;;
-		esac
-	fi
-
-	eval '"$@"' --bisect -- $(cat "$GIT_DIR/BISECT_NAMES")
-}
-
 bisect_run () {
 	git bisect--helper --bisect-next-check $TERM_GOOD $TERM_BAD fail || exit
 
@@ -152,7 +129,7 @@ case "$#" in
 		# Not sure we want "next" at the UI level anymore.
 		git bisect--helper --bisect-next "$@" || exit ;;
 	visualize|view)
-		bisect_visualize "$@" ;;
+		git bisect--helper --bisect-visualize "$@" || exit;;
 	reset)
 		git bisect--helper --bisect-reset "$@" ;;
 	replay)
-- 
2.29.2

