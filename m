Return-Path: <SRS0=EnZj=DB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCFCC2D0E2
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 12:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66F6C238E4
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 12:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZScrOiz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbgIXMeE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Sep 2020 08:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727757AbgIXMeE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Sep 2020 08:34:04 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA6BC0613D3
        for <git@vger.kernel.org>; Thu, 24 Sep 2020 05:34:03 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id k18so3399003wmj.5
        for <git@vger.kernel.org>; Thu, 24 Sep 2020 05:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XqFQnS4xBRLe9JS0i3eneAHjIpDK3GpJ2K5ArNHAlKk=;
        b=lZScrOizl8WUREsuJUUvkh+WYS/M/If7zstXoM6MAptyWCJgqCtB/z6XTZ8AlJA5Lf
         woYjxcR+zB1rggf65YDgI3FBx/eC8nXCW4iq1sZTiKhfPMnUQMqO/AASevvT2Y4Ae3Ho
         N2OGkZ+arvu16mYKXJrdUj9qAKRll93dIR0xBXzdoWXF7idEogx34DtYNYcHLoQ4CJ9N
         us/g9uQNRCXwiPWjwz20nm4nf7oRQ7fLYe9BSL7A/NXumWL4TqWH93zn5fjCVvgjdBh4
         9jolpatcjkXdKeMp6RWm7Fuf6HT8U2l3YAkOv3cFKP3zvRvPqg+4xqzmPldc49QjYeNv
         ov9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XqFQnS4xBRLe9JS0i3eneAHjIpDK3GpJ2K5ArNHAlKk=;
        b=NH2+NbL6MIO7XjyVZQ3AGMxXUKHxoP2PxkCOkGhy8n4hfGhqaua/bemEWYSGKCxhSX
         qvR8E1RhF7nbxYuD2wKLn6ZB311ky5SfHruiMfC1NeoIHETeBRYOxTZTWtie3MwHlXGy
         dAJ/9DaJgMYJC6xay08WbEzxnlW2VFMfl0fKtO8vzlcCDbBo6MrZlie+UQ2sj2epfppQ
         U0Xcmb/2WeN+Gf6xMrobbnsw/w6gyiZwLuz55kWAR6cGzKmvl238JcztifUb72GU3Cie
         1ZPdoKkiJvNRbnzsXa0BUOgqZSnaVmRihbB3nFiPsjeMFTghEMg0MkizzlrGnUdfPGWX
         jOag==
X-Gm-Message-State: AOAM530qz4No6rvXjZFuzbf4A/hkBE9R9/1alQYcc8CbnLQlqX5psVN8
        BkRcFM2PkbtaVeirdqVGg/g5vP0PLGE=
X-Google-Smtp-Source: ABdhPJzRBh8Fe0FTfuGz2iGtCX8R7TXrUpuAYJ1XGRvos6WxlUJAloaVIM5jlRJXT6jslyB8witV5w==
X-Received: by 2002:a1c:9c8c:: with SMTP id f134mr4499865wme.27.1600950841549;
        Thu, 24 Sep 2020 05:34:01 -0700 (PDT)
Received: from localhost.localdomain ([178.237.235.60])
        by smtp.gmail.com with ESMTPSA id i83sm3485457wma.22.2020.09.24.05.34.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Sep 2020 05:34:01 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v9 4/6] bisect--helper: reimplement `bisect_autostart` shell function in C
Date:   Thu, 24 Sep 2020 14:33:38 +0200
Message-Id: <20200924123340.52632-5-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200924123340.52632-1-mirucam@gmail.com>
References: <20200924123340.52632-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Change behavior of shell script that returned success when user aborted
the bisection.

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
index 46d2abb36f..ab27a8dff6 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -29,6 +29,7 @@ static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-terms [--term-good | --term-old | --term-bad | --term-new]"),
 	N_("git bisect--helper --bisect-start [--term-{new,bad}=<term> --term-{old,good}=<term>]"
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
+		return -1;
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
index 2f60fefcfa..6ed3e42fc2 100755
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
+	git bisect--helper --bisect-autostart || exit
 	state=$1
 	git bisect--helper --check-and-set-terms $state $TERM_GOOD $TERM_BAD || exit
 	get_terms
@@ -149,7 +128,7 @@ bisect_auto_next() {
 
 bisect_next() {
 	case "$#" in 0) ;; *) usage ;; esac
-	bisect_autostart
+	git bisect--helper --bisect-autostart || exit
 	git bisect--helper --bisect-next-check $TERM_GOOD $TERM_BAD $TERM_GOOD|| exit
 
 	# Perform all bisection computation, display and checkout
-- 
2.25.0

