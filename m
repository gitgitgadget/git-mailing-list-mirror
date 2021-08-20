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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E689C4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 17:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44E0261101
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 17:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbhHTRXq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 13:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233563AbhHTRXl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 13:23:41 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8980C061756
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 10:23:02 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id v10so4027579wrd.4
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 10:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ktl74k5Q2uTlQ9/SeSsFyS8i0Yj60tIMh0mbF+xmXEw=;
        b=kV6PWBbTEgOujU5c1UsSWsg78j0wGrBw1gCNk/dAO01XRungIXLa4zwNcSTmbswZuK
         DHm+Z7ZD5Cu+2pq7NuMSprb88CJHh8MwW5Ic5rzgaTgSrhm5ryICWF2zRTE4+thiC/Nv
         WEVoalaxRZZwK/wrMhfVqEe3ptvreLWz3LCIy+x9+20Ewm3F8qJ1KyrM0RtD3NjvetW2
         z4v38tXRY2W/ZIKZEl0DusWHpTwlVWtBhTullNhiPpxX3Cxys//wea+LftuwhHzMncIk
         r2CdvVGkciVgqYIIy1+ZJ2GKLBtCNtQbvx/oJL9T3bZzYruDHReQLsW+eJeA7o91nmT4
         Gxrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ktl74k5Q2uTlQ9/SeSsFyS8i0Yj60tIMh0mbF+xmXEw=;
        b=alsistwDRoA/mbieJ1/54ubb0QEsy4zCWHUeWB2cYu9GCjDfRyi3HS36u8wJsODNcD
         JOUSNis09CY6Xbe1Kb7eqkI/WOWCJqD5BhClREo8UXCd66iShV1MJjrdDhUB4uIJ9Bn3
         QUNnHyhGwo3dL0AYhLg2+x6In7XIYFG4rk5ZvHqknpxTDOKQeB2//5KCWrSGExpsGW4I
         nJqGmD9ktlmcUkyAepQAqQAbZ1dEsQg6sx7qX+HDNoy/ayp+zY5HFYGqmr6aYILKNGk3
         PQ4+Pl0I0nvz2HeimavUIc2Pt4Udd3+Gzt4v+aT5bzxhyBnA8/s2R6i3zjDYmXxCucnk
         S16A==
X-Gm-Message-State: AOAM533Hbe/67UM/FdjIqJmx2lB+3MD4JAb41SudnBtFqGb/yVQGv319
        EF3sy5Uy7C8mB8NumI9Z526CEs7dRTE=
X-Google-Smtp-Source: ABdhPJxdHrZ6JgbhiQ3ZFHPRCLyMiivoZ68+eNueoSkyt5COMlBq+MC9rsXwc2FTEIdaTehNlNi53A==
X-Received: by 2002:adf:a1ca:: with SMTP id v10mr11198612wrv.177.1629480181509;
        Fri, 20 Aug 2021 10:23:01 -0700 (PDT)
Received: from localhost.localdomain ([178.237.232.111])
        by smtp.gmail.com with ESMTPSA id x13sm6623278wrq.44.2021.08.20.10.23.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Aug 2021 10:23:01 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v5 4/6] bisect--helper: reimplement `bisect_visualize()`shell function in C
Date:   Fri, 20 Aug 2021 19:21:46 +0200
Message-Id: <20210820172148.2249-5-mirucam@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210820172148.2249-1-mirucam@gmail.com>
References: <20210820172148.2249-1-mirucam@gmail.com>
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
index f184eaeac6..1e118a966a 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -30,6 +30,7 @@ static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-state (good|old) [<rev>...]"),
 	N_("git bisect--helper --bisect-replay <filename>"),
 	N_("git bisect--helper --bisect-skip [(<rev>|<range>)...]"),
+	N_("git bisect--helper --bisect-visualize"),
 	NULL
 };
 
@@ -1036,6 +1037,44 @@ static enum bisect_error bisect_skip(struct bisect_terms *terms, const char **ar
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
+			strvec_push(&args, "log");
+			flags |= RUN_GIT_CMD;
+		}
+	} else {
+		if (argv[0][0] == '-') {
+			strvec_push(&args, "log");
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
@@ -1048,7 +1087,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_STATE,
 		BISECT_LOG,
 		BISECT_REPLAY,
-		BISECT_SKIP
+		BISECT_SKIP,
+		BISECT_VISUALIZE,
 	} cmdmode = 0;
 	int res = 0, nolog = 0;
 	struct option options[] = {
@@ -1070,6 +1110,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("replay the bisection process from the given file"), BISECT_REPLAY),
 		OPT_CMDMODE(0, "bisect-skip", &cmdmode,
 			 N_("skip some commits for checkout"), BISECT_SKIP),
+		OPT_CMDMODE(0, "bisect-visualize", &cmdmode,
+			 N_("visualize the bisection"), BISECT_VISUALIZE),
 		OPT_BOOL(0, "no-log", &nolog,
 			 N_("no log for BISECT_WRITE")),
 		OPT_END()
@@ -1131,6 +1173,10 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		get_terms(&terms);
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

