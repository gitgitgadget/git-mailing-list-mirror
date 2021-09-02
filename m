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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14289C4320E
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 09:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3B5A61057
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 09:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244983AbhIBJGV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 05:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244955AbhIBJGT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 05:06:19 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5521C061764
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 02:05:21 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id m9so1735280wrb.1
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 02:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ktl74k5Q2uTlQ9/SeSsFyS8i0Yj60tIMh0mbF+xmXEw=;
        b=GS90uK2B6bokkJzOaqz7kiYB4GJ97cP9Vq+bZpnKizSzl8YiRWoU71wgsculDft5sU
         95Y9aKfDytOEVSerCRM4tXb98TXi/PkUFNT5wwZrERjZNWml+sWY9y0LNwN1g/KerwEB
         gMf0g8G/LuKDKi/vKGmi4FRNf6bHTFwMXVg19b8kqm0Xjl5KZf18c6EWJcvCn4weZO5B
         SoQGz30VH6JodL5+9kj5/pT/VIz4ZL60PUnC3ft4VHOl6dqVCJaGkXK4qcS1Rwd4xH9P
         06W2kxBcFLFmDn/IENC6nJPEzrvttWNX6Nb5q9wrQY6yaul6Dc+IF8Rd1t77xrY4dITh
         k8OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ktl74k5Q2uTlQ9/SeSsFyS8i0Yj60tIMh0mbF+xmXEw=;
        b=otGpSeuTr7UIEsh5LDeex5PEpFRSPtUqP/Tis6fZcNXyYMDmABhd5PlT1sNONOP9vw
         AxiZoD56WD+GntqSzWc4xyDgSZP8GfNLF5sXQwfCiKaLKMNHhExB8HYYc1IQYRrwfYAT
         qRsgMFRNx0aYgFt9zXFBF/xYkutfY+LCBCkWZFJZzmMqwnNYhvWCXJRgLl1JuqRmPaBu
         bNarRotpTXW5Z33k+kfEkjTzDJ4tYnYHNjbD36N26T+SLYth7ZLZ+2NEhoosSGzOgBcF
         DwCE+krXGnhju9ZDn6EBPVffmDUkD2mYXLPgjeCKdrX7vfG73dgqWe6GQ9DzszxTUvEq
         vZZw==
X-Gm-Message-State: AOAM533/r2LwU2M22fpjcDaYUlO7x+CyRa2F1Mxlp4Vhxrt2UDG9ks1U
        vuSmbDvei4CfAb6I6XuoqvRytstBros=
X-Google-Smtp-Source: ABdhPJyE23HiCd4XBY425g8aJ6OozNUYoJVvKml78QzDu+0T3+08mFONmpqh1HlRSrXZnTYxldOliQ==
X-Received: by 2002:a5d:5441:: with SMTP id w1mr2364625wrv.280.1630573520332;
        Thu, 02 Sep 2021 02:05:20 -0700 (PDT)
Received: from localhost.localdomain ([178.237.237.111])
        by smtp.gmail.com with ESMTPSA id l17sm1262516wrz.35.2021.09.02.02.05.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Sep 2021 02:05:20 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v6 4/6] bisect--helper: reimplement `bisect_visualize()`shell function in C
Date:   Thu,  2 Sep 2021 11:04:19 +0200
Message-Id: <20210902090421.93113-5-mirucam@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210902090421.93113-1-mirucam@gmail.com>
References: <20210902090421.93113-1-mirucam@gmail.com>
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

