Return-Path: <SRS0=A5vO=CJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA613C433E2
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 10:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A31A2068F
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 10:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5EkeCmT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgHaKvs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Aug 2020 06:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgHaKvQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Aug 2020 06:51:16 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E32FC061239
        for <git@vger.kernel.org>; Mon, 31 Aug 2020 03:51:15 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id o5so1559257wrn.13
        for <git@vger.kernel.org>; Mon, 31 Aug 2020 03:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VyLXkwQ3/HkrtKdVLWhHqYP4nvTAof/JNG9ta8LJpxA=;
        b=A5EkeCmTu0pPeS4UfDL+pOMQ/siTBGGNNN9d+myLni8/NS/LMYcFSkNYPRFyuaedhP
         JTCPS9izXm7ucOASaXOTStQYrMy+kPp3GqCv7i4UohJvatgE0sHYqFp2SWSm7uJ1ifQX
         jp1Hw4oTsBixbaMQZ4rH54er++u/XJpmJrsvq62lp8lDhdS2AVVgUPEwlHJfikJ2Jegu
         dih0ayGp+vodHh+youyMimmG6m8n/uYGAjrIe5TgyxJ2HNCLGn0VIp50AX1K66s4vSbn
         hSqTzS+5UEapfedxR5SNTvwOhGJoLq/0+b6Avd+asRwXY3xdT7C6fmcKbMEwBD/naa+d
         HN8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VyLXkwQ3/HkrtKdVLWhHqYP4nvTAof/JNG9ta8LJpxA=;
        b=d+eYiMVYDjh6xIC05zBkyCR8B5cWWZ8VY66A0nO4iOK6sr3mTX29cORK5It7GNq01G
         VRCfUpLOhmAZqJL9IlTV68d/FpSdNyvbtoUTEg/ypw12ND5BJX7Ezmc39tFuvTsPYI7L
         YFTx9VIoH32fOCdiLeS94ABgJ+hF0OrGa+1XZLNOJZb5OuEcr3vAkAv2KNywONWHiGMG
         eFJLPSiIBoLmDmmmL4J2Z4NRRdV+S526N0o/YwKt2tr+rc3n16EqYwBGMr+MspDLC7w5
         Hq0AQTNSI3eW581hGQgEg4sG0yFQ9YVVXHxMdlkhoXG+++2OfbMf5siT96ltpxPSSLqr
         ljGw==
X-Gm-Message-State: AOAM531VxBD/m3t6MCV0/zTla7tm28TOMYrSYB/xj8CzSvsaTf8PGNnP
        cmC2vH+CoCEg9B8XHZ13gYFRTg/p5k0=
X-Google-Smtp-Source: ABdhPJzckneV7tWAqR3/Cv4yGdF1ay4DdpIyV9DYViiWLBV2biXuIGKbHkGDR5Sa7b95Tw9Hj8ZQ2A==
X-Received: by 2002:adf:f34f:: with SMTP id e15mr1022745wrp.387.1598871072666;
        Mon, 31 Aug 2020 03:51:12 -0700 (PDT)
Received: from localhost.localdomain ([178.237.236.228])
        by smtp.gmail.com with ESMTPSA id k84sm7674454wmf.6.2020.08.31.03.51.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Aug 2020 03:51:12 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v7 04/13] bisect--helper: reimplement `bisect_autostart` shell function in C
Date:   Mon, 31 Aug 2020 12:50:34 +0200
Message-Id: <20200831105043.97665-5-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200831105043.97665-1-mirucam@gmail.com>
References: <20200831105043.97665-1-mirucam@gmail.com>
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

