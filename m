Return-Path: <SRS0=cmu9=3J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15890C33CAA
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 14:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E022B217F4
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 14:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MI12mwFT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbgATOiw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 09:38:52 -0500
Received: from mail-wr1-f46.google.com ([209.85.221.46]:38187 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728831AbgATOit (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jan 2020 09:38:49 -0500
Received: by mail-wr1-f46.google.com with SMTP id y17so29850247wrh.5
        for <git@vger.kernel.org>; Mon, 20 Jan 2020 06:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GOlUYXysL8hTlc9pOBhOuUOphhwKLaK2FXy+Dwox900=;
        b=MI12mwFTmCp6qUVESALvvU/qIa29q/pxDS3bQ/di+q5b+84KaRoSfwwDDeKUsr5pVA
         uZjEDqbIzGHJ4iHzBxWJohPBvnZ85ftYHzPl10idNggWZ55kFhYLRXGahGOhJx7lP9PV
         yi/raZ/7bDB3lIpvJr+6gGLiQiFoHx8VSl8bXf5EqLH8rrwBhxpMWznwbdXsN/oVfSQb
         0tY8uFTmBY/LSV8/MbZxRg4EUQPuMnajLUoZ6fo18FFqLC99HzFvYXoek1msvCtqZ+qY
         ZUZvW4hd+q6p2k91XobL8AubE6v+UBD1PAu/wlm5T2lq9ysQF4RoZaZEtf7TvdSS8WiN
         /4vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GOlUYXysL8hTlc9pOBhOuUOphhwKLaK2FXy+Dwox900=;
        b=JYrRmr14qZIlrRkwDm1S0IM7iTgK87EuruleCqH+LAB/DlvGsQVuP+FoT46QAo+WrB
         2QbgnCv5cNiRE+KWsWCkj3qiqoHYP5syjOh1D62ScvBo8L/TwICripd270YqRi77F3Q3
         8Ck+v8edxiVdXInkns5dum+sF8840tt9qOPJGdtA93vZYZ4C1lbqm4sLl2TD9ZqGfqcy
         8VjdfSh/AaXMK9nIqiPrcbQFITpvf0oVty/iSOVxhOD4MTQXpVb+63ZsdEpWuOWC08tN
         gtqcY3H1VD5S1lLw1FIyNXTe1Az1DyIu7fm/mzead/z1QcKs9ZvZkfdp+k9/YtRQOUNJ
         lA/w==
X-Gm-Message-State: APjAAAUecCSUIuboqj2zgpdnHnOqu7c5MiAI+1BEzCbmvdfv86N7jGUz
        ewGLBIFFK3O4YHUmFm3AcyHPqHKa7/E=
X-Google-Smtp-Source: APXvYqys8RSIhA3rNCdKpVU/EaBtDv19lKdFN+/Ns9d8HXDhovUpA7HN4Dwx1kKFnViZPzblho6ziQ==
X-Received: by 2002:adf:82a7:: with SMTP id 36mr19134512wrc.203.1579531127935;
        Mon, 20 Jan 2020 06:38:47 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id u8sm23192588wmm.15.2020.01.20.06.38.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jan 2020 06:38:47 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH 16/29] bisect--helper: reimplement `bisect_autostart` shell function in C
Date:   Mon, 20 Jan 2020 15:37:47 +0100
Message-Id: <20200120143800.900-17-mirucam@gmail.com>
X-Mailer: git-send-email 2.21.1 (Apple Git-122.3)
In-Reply-To: <20200120143800.900-1-mirucam@gmail.com>
References: <20200120143800.900-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

Reimplement the `bisect_autostart()` shell function in C and add the
C implementation from `bisect_next()` which was previously left
uncovered. Also add a subcommand `--bisect-autostart` to
`git bisect--helper` be called from `bisect_state()` from
git-bisect.sh .

Using `--bisect-autostart` subcommand is a temporary measure to port
shell function to C so as to use the existing test suite. As more
functions are ported, this subcommand will be retired and
bisect_autostart() will be called directly by `bisect_state()`.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 39 +++++++++++++++++++++++++++++++++++++++
 git-bisect.sh            | 23 +----------------------
 2 files changed, 40 insertions(+), 22 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 6953c68f93..f03ed23431 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -30,6 +30,7 @@ static const char * const git_bisect_helper_usage[] = {
 					     "[--no-checkout] [<bad> [<good>...]] [--] [<paths>...]"),
 	N_("git bisect--helper --bisect-next"),
 	N_("git bisect--helper --bisect-auto-next"),
+	N_("git bisect--helper --bisect-autostart"),
 	NULL
 };
 
@@ -56,6 +57,8 @@ static void set_terms(struct bisect_terms *terms, const char *bad,
 static const char vocab_bad[] = "bad|new";
 static const char vocab_good[] = "good|old";
 
+static int bisect_autostart(struct bisect_terms *terms);
+
 /*
  * Check whether the string `term` belongs to the set of strings
  * included in the variable arguments.
@@ -547,6 +550,7 @@ static int bisect_next(struct bisect_terms *terms, const char *prefix)
 {
 	int res, no_checkout;
 
+	bisect_autostart(terms);
 	if (bisect_next_check(terms, terms->term_good))
 		return -1;
 
@@ -793,6 +797,32 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
 	return res;
 }
 
+static int bisect_autostart(struct bisect_terms *terms)
+{
+	if (is_empty_or_missing_file(git_path_bisect_start())) {
+		const char *yesno;
+		const char *argv[] = {NULL};
+		fprintf(stderr, _("You need to start by \"git bisect "
+				  "start\"\n"));
+
+		if (!isatty(STDIN_FILENO))
+			return 1;
+
+		/*
+		 * TRANSLATORS: Make sure to include [Y] and [n] in your
+		 * translation. The program will only accept English input
+		 * at this point.
+		 */
+		yesno = git_prompt(_("Do you want me to do it for you "
+				     "[Y/n]? "), PROMPT_ECHO);
+		if (starts_with(yesno, _("n")) || starts_with(yesno, _("N")))
+			return 1;
+
+		return bisect_start(terms, 0, argv, 0);
+	}
+	return 0;
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
@@ -806,6 +836,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_START,
 		BISECT_NEXT,
 		BISECT_AUTO_NEXT,
+		BISECT_AUTOSTART,
 	} cmdmode = 0;
 	int no_checkout = 0, res = 0, nolog = 0;
 	struct option options[] = {
@@ -829,6 +860,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("find the next bisection commit"), BISECT_NEXT),
 		OPT_CMDMODE(0, "bisect-auto-next", &cmdmode,
 			 N_("verify the next bisection state then checkout the next bisection commit"), BISECT_AUTO_NEXT),
+		OPT_CMDMODE(0, "bisect-autostart", &cmdmode,
+			 N_("start the bisection if BISECT_START is empty or missing"), BISECT_AUTOSTART),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_BOOL(0, "no-log", &nolog,
@@ -895,6 +928,12 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		get_terms(&terms);
 		res = bisect_auto_next(&terms, prefix);
 		break;
+	case BISECT_AUTOSTART:
+		if (argc)
+			return error(_("--bisect-autostart requires 0 arguments"));
+		set_terms(&terms, "bad", "good");
+		res = bisect_autostart(&terms);
+		break;
 	default:
 		return error("BUG: unknown subcommand '%d'", cmdmode);
 	}
diff --git a/git-bisect.sh b/git-bisect.sh
index fec527e1ef..97bb15b38f 100755
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
-			git bisect--helper --bisect-start
-		else
-			exit 1
-		fi
-	}
-}
-
 bisect_skip() {
 	all=''
 	for arg in "$@"
@@ -86,7 +65,7 @@ bisect_skip() {
 }
 
 bisect_state() {
-	bisect_autostart
+	git bisect--helper --bisect-autostart
 	state=$1
 	git bisect--helper --check-and-set-terms $state $TERM_GOOD $TERM_BAD || exit
 	get_terms
-- 
2.21.1 (Apple Git-122.3)

