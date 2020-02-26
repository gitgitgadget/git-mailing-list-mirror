Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E07C4BA0B
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 10:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB90B24656
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 10:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XwcIM5mR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgBZKQR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 05:16:17 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:39099 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbgBZKQQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 05:16:16 -0500
Received: by mail-wm1-f53.google.com with SMTP id c84so2370009wme.4
        for <git@vger.kernel.org>; Wed, 26 Feb 2020 02:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fwaFBmY1I9+bJ0iOkZeTf1r9fPmgP9t5FK7ijAcwtJc=;
        b=XwcIM5mR2tBSxmGJ69QrPpeCMyCGwYby8g1PTcGPrgSQKPewX2a5GC9Dyk1Gu4E0Xd
         rSA9LGIcfdHLK8XFwH0gFzynrixff8ipnR6rLjv6NVUQmHJ3BS5EhQaDYffip8WGoa7E
         E6g1biUObuPcqv0egd/OAiI3QRbE/w/Uw2nfN2K1qQkolcSJaDQ4ssEXoMAges8i0oBA
         GWREjRf/6CjkC9z6TgozSkPJy6wUo1oH0RcZ7uDR+wnFumsvztLp/r+w7PiULfp+B7y8
         hbmGbJaZh4xUGBSHQk9iI5UuYGLsqPhUnTjqC+vBcxcjB0IlIujbDehTGwWe0NwHN+IX
         OGag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fwaFBmY1I9+bJ0iOkZeTf1r9fPmgP9t5FK7ijAcwtJc=;
        b=PhTbL6IGT4isc4LwfqDvzSVT6ruoM2q9rskNR+IyyXpVChXruXB5Btch7q0OXVDo3g
         1ul0zng6Nw1wM4vCMiBn/1e6UMe1RXh2WkCLAaOS0+ZLFkGEuqy7jxTAkN0/m7UZBigP
         vNM7eXZO/D4XH8c3MJ2fdxmWz/haXJOD+T8KWu3v4fpzq4SZW1GYIvQDvfKZe97TO4Kg
         c9ABk+o6p+bIvwDdlYR1NfTmJTUBFtGqXctiJ8H1KMHlNKFiu9H5gUTQF3Y1d+XiLxI7
         TbGlB1kpmqcka2T2n+NhkuGaptXGzYpTSLF5ETtY2wKS91bcBd7/pH+KRyPUhYWp/rXN
         wnsQ==
X-Gm-Message-State: APjAAAVaIB3erQW8yOPAaXY1EQzF+p6YYu69LS0p1+gjnG2TMyRlpKtS
        7STXF8bmNvXH5MsPd1au+ISL9tRMTfo=
X-Google-Smtp-Source: APXvYqxFlRwRiCPqmiipxqo7L9/UK/ocGHgyaAXf605Rnlc86nOxsPROE33/aS6v2VcNls8iuQ2qZQ==
X-Received: by 2002:a1c:38c7:: with SMTP id f190mr4545631wma.94.1582712173946;
        Wed, 26 Feb 2020 02:16:13 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id t3sm2577081wrx.38.2020.02.26.02.16.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Feb 2020 02:16:13 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH 06/10] bisect--helper: reimplement `bisect_autostart` shell function in C
Date:   Wed, 26 Feb 2020 11:14:25 +0100
Message-Id: <20200226101429.81327-7-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200226101429.81327-1-mirucam@gmail.com>
References: <20200226101429.81327-1-mirucam@gmail.com>
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
index c3bb936a40..f9b04bee23 100644
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
@@ -555,6 +558,7 @@ static enum bisect_error bisect_next(struct bisect_terms *terms, const char *pre
 	int no_checkout;
 	enum bisect_error res;
 
+	bisect_autostart(terms);
 	if (bisect_next_check(terms, terms->term_good))
 		return BISECT_FAILED;
 
@@ -803,6 +807,32 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, int no_checkou
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
+	return BISECT_OK;
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
@@ -816,6 +846,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_START,
 		BISECT_NEXT,
 		BISECT_AUTO_NEXT,
+		BISECT_AUTOSTART,
 	} cmdmode = 0;
 	int no_checkout = 0, res = 0, nolog = 0;
 	struct option options[] = {
@@ -839,6 +870,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("find the next bisection commit"), BISECT_NEXT),
 		OPT_CMDMODE(0, "bisect-auto-next", &cmdmode,
 			 N_("verify the next bisection state then checkout the next bisection commit"), BISECT_AUTO_NEXT),
+		OPT_CMDMODE(0, "bisect-autostart", &cmdmode,
+			 N_("start the bisection if BISECT_START is empty or missing"), BISECT_AUTOSTART),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_BOOL(0, "no-log", &nolog,
@@ -905,6 +938,12 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
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
index 166f6a64dd..049ffacdff 100755
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
2.25.0

