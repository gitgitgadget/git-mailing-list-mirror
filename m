Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBFFC433E1
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 13:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DEF9206BE
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 13:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Um/9H+3I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731158AbgGANfj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 09:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730792AbgGANfg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 09:35:36 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0781CC08C5C1
        for <git@vger.kernel.org>; Wed,  1 Jul 2020 06:35:36 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id b6so23836055wrs.11
        for <git@vger.kernel.org>; Wed, 01 Jul 2020 06:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7nbieT4QtGXk0hmm0z7vqt2vlcmy3vOJN8DpcAIQOIw=;
        b=Um/9H+3IrlnjEt1zJ7uf5eb5kWaP7DZW2mNU174uLTCwSgTJPbacLlgSkJfj/AYuBg
         KDCiKZBS9ihdcGIMM+WmPfkAG9zkwPjydzcFcZ4oRMQfkwRqt+9PomsagDo02ewoKmrH
         HNehpHER/85bAREERynGjgKUlvzrkvhyNfnlPOPevKNlz5DnkwqlGVGUyHNhKT3kN83Y
         ImfAmlOEJwvijDJObAGcFvfmGu6OmeURWf5EJyNEWbPE3l8db3aARWeMW7rf1PO7UzNO
         WROoD2ax/hfvUiEj5vqdn1cbZ07ttgQhDmpdWSKTSC/enZpub3f64ajRbi4pJGghEsrh
         Ky6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7nbieT4QtGXk0hmm0z7vqt2vlcmy3vOJN8DpcAIQOIw=;
        b=kRE3tdGu1iVDrghm8fEQRKzCAA3otLEXOKyAlsvs5qG758iWRfiLeKAd7m1sbnwfga
         LKMjTJPjOvwQFPgYFNE4CS4eRAU9+RLK7Hc7CdadOeLK1AgqrX+I7spoog1+/VSsMdU3
         mk2bhLZEJKJbIDGAsSrJ/0vtHimRqVQZdxBigowCNJswGe+OKiDsK8hl7FJuHS/I0vk4
         ja7+YbOHsbaPXmKe33GswP/fffTWtWlFEr1fPv5NCkMt81Br/+gbZJ1sU3KvduG3FUTK
         at2BHOHf3Mva9eAlPEO+T5Jn7CjBwrGSDVomNRhYWI0nnXlxr1nUMJD7BUwqDscgJDiM
         DuwA==
X-Gm-Message-State: AOAM530+qFFPzWpsC9TYsfkKCWnVL98/y48LJ0sWoR7CjzYlgdSbiOIP
        eYPURH4i+3X80etK1pFN2ijLpq+Bzr2MFw==
X-Google-Smtp-Source: ABdhPJy2bUfXYSLlwebeKd+6ZSWgaezjPzPS1+of5lpZcWIANSZJX5Sl/TDHcRMZhvaJM1IkTZkUhQ==
X-Received: by 2002:adf:f04c:: with SMTP id t12mr24948449wro.382.1593610534430;
        Wed, 01 Jul 2020 06:35:34 -0700 (PDT)
Received: from localhost.localdomain ([91.242.153.178])
        by smtp.gmail.com with ESMTPSA id 30sm7928840wrm.74.2020.07.01.06.35.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jul 2020 06:35:33 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v4 04/13] bisect--helper: reimplement `bisect_autostart` shell function in C
Date:   Wed,  1 Jul 2020 15:34:55 +0200
Message-Id: <20200701133504.18360-5-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200701133504.18360-1-mirucam@gmail.com>
References: <20200701133504.18360-1-mirucam@gmail.com>
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
index b421056546..36166840d1 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -29,6 +29,7 @@ static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-terms [--term-good | --term-old | --term-bad | --term-new]"),
 	N_("git bisect--helper --bisect-start [--term-{old,good}=<term> --term-{new,bad}=<term>]"
 					     "[--no-checkout] [<bad> [<good>...]] [--] [<paths>...]"),
+	N_("git bisect--helper --bisect-autostart"),
 	NULL
 };
 
@@ -645,6 +646,38 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
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
+		-1 : bisect_start(terms, 0, NULL, 0);
+
+		return res;
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
@@ -657,7 +690,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		CHECK_AND_SET_TERMS,
 		BISECT_NEXT_CHECK,
 		BISECT_TERMS,
-		BISECT_START
+		BISECT_START,
+		BISECT_AUTOSTART,
 	} cmdmode = 0;
 	int no_checkout = 0, res = 0, nolog = 0;
 	struct option options[] = {
@@ -681,6 +715,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("print out the bisect terms"), BISECT_TERMS),
 		OPT_CMDMODE(0, "bisect-start", &cmdmode,
 			 N_("start the bisect session"), BISECT_START),
+		OPT_CMDMODE(0, "bisect-autostart", &cmdmode,
+			 N_("start the bisection if it has not yet been started"), BISECT_AUTOSTART),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_BOOL(0, "no-log", &nolog,
@@ -742,6 +778,12 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		set_terms(&terms, "bad", "good");
 		res = bisect_start(&terms, no_checkout, argv, argc);
 		break;
+	case BISECT_AUTOSTART:
+		if (argc)
+			return error(_("--bisect-autostart does not accept arguments"));
+		set_terms(&terms, "bad", "good");
+		res = bisect_autostart(&terms);
+		break;
 	default:
 		BUG("unknown subcommand %d", (int)cmdmode);
 	}
diff --git a/git-bisect.sh b/git-bisect.sh
index 08a6ed57dd..d7a6990c29 100755
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

