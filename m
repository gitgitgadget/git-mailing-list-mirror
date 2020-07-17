Return-Path: <SRS0=XbPV=A4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE501C433EA
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 10:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A362A206BE
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 10:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q5DWbi7g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgGQKyn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jul 2020 06:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgGQKyj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jul 2020 06:54:39 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C1BC061755
        for <git@vger.kernel.org>; Fri, 17 Jul 2020 03:54:39 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id f2so10494255wrp.7
        for <git@vger.kernel.org>; Fri, 17 Jul 2020 03:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cVqZSgXxypSKFkwgBgn8iwzajRNejPvHwTMkSfXEo6k=;
        b=q5DWbi7gNimemYrdYwvBz51KiqRG13TPAH/pIzpayHsJfhIaEV7pFQ4w5K05jzENrq
         wLJAEVigtQaxhl+5aqH2o6/BxLPDOXWNt/MNe6063sintL8HJYBW2dT3ZDtcaTxz/qcj
         KBmjrwNjH0EZ1cVWcXRRJSQBBQXOSjQj2DhWjVyVzyOETabswtxFKi1+j5+8EfNnNJFw
         +JCKoWeBUuuKnslcG8NHGBGQIJXyOtp1WQrxhVbZr+ENoECwWX45w/z0v1yF9JlgV27z
         Djnh2imeEhxuK8b9HWZ2Jk275mtSYxi/WsvihY784BicDB/2RA2UmjvnOenPIKbLDtuZ
         fL3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cVqZSgXxypSKFkwgBgn8iwzajRNejPvHwTMkSfXEo6k=;
        b=GDpDx8tnIAsqnKz3HuLHCTs5JApTuN+ue9EHcK0eXjvVZ6+kEt5YH+4FEiOdWGagPd
         yI7cqAc/nrQan9oKBOyyOvxyW+zBHEKgwNyjNHbePaYcOdY5ltC/u/GAhHYUfeNHgXny
         FE7IAdjb5ffvVN8PAM/wUsVPgpCOxz+gSs/qxDdYq/7TrDVWCo9bklxE+n9wxDhdgzll
         V2g88lLMfUyukMtza/mPT1HZgRqhYCuRlV2k0Xv+JIM6afk4Gd9dWRrDWU4sT03Gg+FM
         60Ha6LIl2yCOGFW2UHaxAZUVEuwpHTgvNb3iw5sel/c3uGik8qEdLbJJP9/7J2rEfyqC
         ixpA==
X-Gm-Message-State: AOAM531ViXH9h9oZWIowjUpDZRLRVlHDz9SoTiKRNASsSvWbXtGfJgvq
        Fu8WpLvwcFU+fkSw88qSetgU/tef+s8=
X-Google-Smtp-Source: ABdhPJy9fuzq5OvCniIWR+kiQfv7gRpdgdqJePXyqK0CGVCFcLSaRqyQmNS64FfzTp5px8y072ecgg==
X-Received: by 2002:adf:eecf:: with SMTP id a15mr9760424wrp.83.1594983277580;
        Fri, 17 Jul 2020 03:54:37 -0700 (PDT)
Received: from localhost.localdomain ([91.242.153.178])
        by smtp.gmail.com with ESMTPSA id w14sm13924474wrt.55.2020.07.17.03.54.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jul 2020 03:54:37 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v5 04/13] bisect--helper: reimplement `bisect_autostart` shell function in C
Date:   Fri, 17 Jul 2020 12:53:57 +0200
Message-Id: <20200717105406.82226-5-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200717105406.82226-1-mirucam@gmail.com>
References: <20200717105406.82226-1-mirucam@gmail.com>
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
index d620d84d92..7662ec0ce3 100644
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

