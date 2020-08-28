Return-Path: <SRS0=bfGv=CG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F844C433E2
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 12:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F3C720872
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 12:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1aFRsxW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729418AbgH1MsG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Aug 2020 08:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729414AbgH1MrU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Aug 2020 08:47:20 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31FCC061234
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 05:47:17 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id i7so253722wre.13
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 05:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VyLXkwQ3/HkrtKdVLWhHqYP4nvTAof/JNG9ta8LJpxA=;
        b=f1aFRsxWVP1OhT6/WQX41uh2aoAVbsdwkrhZd2kFA1qAP0LcXlHDFtmJTUr1BCHaBa
         lcoyBcMLPR9VHfnxD7ltDwWLVgZ6VNFiynQs6NJjsRZfcrxPI7puUNvoW1+mOFnfattl
         o2V3edQoHeU9bO2dew0WMwR2CVdTMQacDz0UTtt6RxDNR4+w6+HF/LLGBMfIxtAC+/VZ
         ejyPYG9k+RhUgQx/SZOu5QQ3Vm9uVNsuzP9c3xFRJN+UqbzTD/RxNQhHPxovvKXACb3e
         XVRA/Ugz5TuPFzSrSS2eJqi2lMSplQHegQ41SH48sz5yA8YXJmauczOEbYPmS44HYK1O
         +znw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VyLXkwQ3/HkrtKdVLWhHqYP4nvTAof/JNG9ta8LJpxA=;
        b=rPaBi83kAppKwJg4YBnAozRmIIZiwqGyDg3xwA+eAnCsQtDH7pMPZyzQS2tUq3q/AO
         lK6BIZ3TexbSULzTNX3XO1OXYBUSsX6dXFBspCzv0oYIWLArJWNStTJ9R59L92hiGhv5
         ns1Et77/51JDq0VcC7R0W4E4sBf+apXAWbYYk9ttKcd0uHXvoEItP2h/YQ27UOqADoN6
         snGSKq+JE84JTfcOACiUkdmBTJ7dgpTqDx744aaXD6c+bjAFVw99FGdaRNeVWGqHzrIQ
         CFGM5tVQyaSMRmdQ7+kJqvKaS9jX3v4rqtD5MIheX602nJGFoqWFzOAQD1WX2i4t4HCG
         Ibgg==
X-Gm-Message-State: AOAM532dhmlSafNzdzYyFZ1vwlYaAuhe7zScPHuBQh8Gea8x5avnP7yc
        zq8F67icMIlwrbfKa4XSwZEtQcTTfKs=
X-Google-Smtp-Source: ABdhPJw4ondE/YB/SaXSQKxxvoRL0S/q1y7aT1NUe4ZRpbnCx1DjOfRr59oEsfUjF8wdM2Ik8Uqi5g==
X-Received: by 2002:a5d:4210:: with SMTP id n16mr1435347wrq.426.1598618834710;
        Fri, 28 Aug 2020 05:47:14 -0700 (PDT)
Received: from localhost.localdomain ([178.237.236.228])
        by smtp.gmail.com with ESMTPSA id o66sm2176878wmb.27.2020.08.28.05.47.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Aug 2020 05:47:14 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v6 04/13] bisect--helper: reimplement `bisect_autostart` shell function in C
Date:   Fri, 28 Aug 2020 14:46:08 +0200
Message-Id: <20200828124617.60618-5-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200828124617.60618-1-mirucam@gmail.com>
References: <20200828124617.60618-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

Reimplement the `bisect_autostart()` shell function in C and add the
C implementation from `bisect_next()` which was previously left
uncovered.

Add `--bisect-autostart` subcommand to be called from git-bisect.sh.
Using `--bisect-autostart` subcommand is a temporary measure to port
the shell function to C so as to use the existing test suite. As more
functions are ported, this subcommand will be retired and
bisect_autostart() will be called directly by `bisect_state()`.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 44 +++++++++++++++++++++++++++++++++++++++-
 git-bisect.sh            | 25 ++---------------------
 2 files changed, 45 insertions(+), 24 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index bae09ce65d..f71e8e54d2 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -29,6 +29,7 @@ static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-terms [--term-good | --term-old | --term-bad | --term-new]"),
 	N_("git bisect--helper --bisect-start [--term-{old,good}=<term> --term-{new,bad}=<term>]"
 					    " [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<paths>...]"),
+	N_("git bisect--helper --bisect-autostart"),
 	NULL
 };
 
@@ -653,6 +654,38 @@ static int bisect_start(struct bisect_terms *terms, const char **argv, int argc)
 	return res;
 }
 
+static inline int file_is_not_empty(const char *path)
+{
+	return !is_empty_or_missing_file(path);
+}
+
+static int bisect_autostart(struct bisect_terms *terms)
+{
+	int res;
+	const char *yesno;
+
+	if (file_is_not_empty(git_path_bisect_start()))
+		return 0;
+
+	fprintf_ln(stderr, _("You need to start by \"git bisect "
+			  "start\"\n"));
+
+	if (!isatty(STDIN_FILENO))
+		return 0;
+
+	/*
+	 * TRANSLATORS: Make sure to include [Y] and [n] in your
+	 * translation. The program will only accept English input
+	 * at this point.
+	 */
+	yesno = git_prompt(_("Do you want me to do it for you "
+			     "[Y/n]? "), PROMPT_ECHO);
+	res = tolower(*yesno) == 'n' ?
+		-1 : bisect_start(terms, empty_strvec, 0);
+
+	return res;
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
@@ -665,7 +698,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		CHECK_AND_SET_TERMS,
 		BISECT_NEXT_CHECK,
 		BISECT_TERMS,
-		BISECT_START
+		BISECT_START,
+		BISECT_AUTOSTART,
 	} cmdmode = 0;
 	int res = 0, nolog = 0;
 	struct option options[] = {
@@ -689,6 +723,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("print out the bisect terms"), BISECT_TERMS),
 		OPT_CMDMODE(0, "bisect-start", &cmdmode,
 			 N_("start the bisect session"), BISECT_START),
+		OPT_CMDMODE(0, "bisect-autostart", &cmdmode,
+			 N_("start the bisection if it has not yet been started"), BISECT_AUTOSTART),
 		OPT_BOOL(0, "no-log", &nolog,
 			 N_("no log for BISECT_WRITE")),
 		OPT_END()
@@ -748,6 +784,12 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		set_terms(&terms, "bad", "good");
 		res = bisect_start(&terms, argv, argc);
 		break;
+	case BISECT_AUTOSTART:
+		if (argc)
+			return error(_("--bisect-autostart does not accept arguments"));
+		set_terms(&terms, "bad", "good");
+		res = bisect_autostart(&terms);
+		break;
 	default:
 		BUG("unknown subcommand %d", cmdmode);
 	}
diff --git a/git-bisect.sh b/git-bisect.sh
index c7580e51a0..9ca583d964 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -49,27 +49,6 @@ bisect_head()
 	fi
 }
 
-bisect_autostart() {
-	test -s "$GIT_DIR/BISECT_START" || {
-		gettextln "You need to start by \"git bisect start\"" >&2
-		if test -t 0
-		then
-			# TRANSLATORS: Make sure to include [Y] and [n] in your
-			# translation. The program will only accept English input
-			# at this point.
-			gettext "Do you want me to do it for you [Y/n]? " >&2
-			read yesno
-			case "$yesno" in
-			[Nn]*)
-				exit ;;
-			esac
-			bisect_start
-		else
-			exit 1
-		fi
-	}
-}
-
 bisect_start() {
 	git bisect--helper --bisect-start $@ || exit
 
@@ -108,7 +87,7 @@ bisect_skip() {
 }
 
 bisect_state() {
-	bisect_autostart
+	git bisect--helper --bisect-autostart
 	state=$1
 	git bisect--helper --check-and-set-terms $state $TERM_GOOD $TERM_BAD || exit
 	get_terms
@@ -149,7 +128,7 @@ bisect_auto_next() {
 
 bisect_next() {
 	case "$#" in 0) ;; *) usage ;; esac
-	bisect_autostart
+	git bisect--helper --bisect-autostart
 	git bisect--helper --bisect-next-check $TERM_GOOD $TERM_BAD $TERM_GOOD|| exit
 
 	# Perform all bisection computation, display and checkout
-- 
2.25.0

