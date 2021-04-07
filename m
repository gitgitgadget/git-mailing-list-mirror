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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E137C433B4
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 17:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4E2D61262
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 17:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354891AbhDGRem (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 13:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354880AbhDGRef (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 13:34:35 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46506C06175F
        for <git@vger.kernel.org>; Wed,  7 Apr 2021 10:34:25 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id z24-20020a1cf4180000b029012463a9027fso1020075wma.5
        for <git@vger.kernel.org>; Wed, 07 Apr 2021 10:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+9fryXH1et7HH7cUCVPfCiR4w/AEgQEVLcqt4AeGkB4=;
        b=U4ARIB+7pK2sqLG6s7YMJw/BPVXgey146g6VEWyyXUCn5hUbOQw/icKOnvo2LfaeTT
         q8jR0vZm2YwwuU0a9GFFlX1U49ZAxqdjsIECbVjSQiHyASsV9MBruy7hA2akqOH27XPc
         Z1uiYvTu2T9TmtXXJiBGdeUub06xayLC5+JVIJPMCP1qGbdzqQvM/saVY1Q1UvNoAtc+
         xB8vNioCdtwU/DEy/q94smqjR1DsSFLFLWq3eKnptkMZyqTlCPXepKhlk76wbb+2qn65
         yw99UgNhnRu7YfKWEta0/fXQVDlKiUyTeZb2HeZkMGkGjhjB2N9L1QveZgJsvMnzh1hJ
         TVbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+9fryXH1et7HH7cUCVPfCiR4w/AEgQEVLcqt4AeGkB4=;
        b=as7mS8A0hbviW4rsUFabSPfoydRzBLGKVo8qaip/1NwA2//v7wLw5KGSJcPrPzetUC
         xbsq+kxFb7hX1XDzC7E/0+P7WEdzoNOjpgG0QnIStWch63akH8qPQgFTgeqFE2h8RUwq
         vwgPai6n+s6ExofiOL6P028So7lsdnFUpBL7taWJ61Z5fMxUu3ZIZkFf6jX/O+fpMfNK
         H7yU4Fnwhi47hJM2o+YPFLWpcKKOrHz5pOgxdHxdrs99RVN9MXhr67hg07TGqLk8d4pb
         YJG9+jhfq1EvrqIZQhHdZD6th+PsPODHxMJDdQVQZrz+PgwsZ5RA4x04h58tO9nL6LPD
         uwfA==
X-Gm-Message-State: AOAM5334Qt/dQdylpXrxrXKcJhxrjGJLHdP6lWyEAskT8YWu/YPoTOpn
        vsya6xgxnpeMgm+mWMoUMyR3pIc6QN5/rw==
X-Google-Smtp-Source: ABdhPJyRp7+8pBYOysoJ9l34r2fdWDmY6eJMnoOxip+sPZ0NZFYjfJM6W4OzKqdgOV8S5oDLjoTlDA==
X-Received: by 2002:a1c:ed05:: with SMTP id l5mr4208909wmh.154.1617816864025;
        Wed, 07 Apr 2021 10:34:24 -0700 (PDT)
Received: from localhost.localdomain ([81.0.37.230])
        by smtp.gmail.com with ESMTPSA id o7sm41657197wrs.16.2021.04.07.10.34.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Apr 2021 10:34:23 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v2 2/4] bisect--helper: reimplement `bisect_visualize()`shell function in C
Date:   Wed,  7 Apr 2021 19:33:31 +0200
Message-Id: <20210407173334.68222-3-mirucam@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210407173334.68222-1-mirucam@gmail.com>
References: <20210407173334.68222-1-mirucam@gmail.com>
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
index 1fdb7d9d10..b77c4f6b29 100644
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
+	strvec_pushl(&args, "--bisect",  NULL);
+
+	strbuf_read_file(&sb, git_path_bisect_names(), 0);
+	strvec_split(&args, sb.buf);
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
+		BISECT_VISUALIZE
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

