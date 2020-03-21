Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59249C4332E
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 16:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26A2320757
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 16:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uo933wxF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbgCUQOD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 12:14:03 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:37631 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbgCUQOB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 12:14:01 -0400
Received: by mail-wr1-f50.google.com with SMTP id w10so11224250wrm.4
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 09:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9eqJLBXV29lnfhARMhQ0AIXLcesdgu4UCr0fKsqsXzU=;
        b=uo933wxFwWx+WIhZCcPWlKo5wAQixXukkXbORentB0mBQTdL1DVCBc1deNKp6Kmme0
         EtosmxpO7cfASqKrYuXKGWQN4UAFnb+6V+xaQF0zZ1V3Ddwx7JGIQeXJjN6BKIwsm3+Y
         Aldev2Ax3bhQsGZp+yttza3YjcDmjUXMe4Whrnzg29gCDifYqEgvSoD2YWrH+5kGuSpo
         DfIRpxFgr9sdr3qhJPT4iQJFqlqyoCbE15mgkEKeLPHHAiH80WvCddAytnOtw+/9oR7e
         CuR/rr0gHYu52lPzQDLcKJ2Ii1BVu6TVxgYlCYhQtqy2xW1HggYHHN3yhXnT+dlqDTt7
         WCjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9eqJLBXV29lnfhARMhQ0AIXLcesdgu4UCr0fKsqsXzU=;
        b=fnrCl3qyW5o4ua//90zjTeXwMXAymyjxfl+eAvKrvEQPFGzOnr1WJns7wd7mW+DFoP
         prK/kFuwvumQEpS8Ux3H61P3+6+VGOBSfYu5ZCROVhrBWRp2G5JHIcqixjUWGNXDtg7L
         pQhXIPuGr9ngsunmfJ2FO4iHXmlZhxAdJ8SKsykZA8HxMAGgJrF8pijvTD22LJTK+LS9
         7bPeeuJrRQmRsHzL59HS5RVl4QzyHZAWRi2po1PZKRxFKmM5VGYGHlMgXxdtu96zOIZd
         O9Y3E5/eiDer9Fcx2ApSjkKvMmnV5++XWoEvF3FWjpD17qgPP9HztxCgsGNfjrKK0fC5
         i4lw==
X-Gm-Message-State: ANhLgQ015ZLpLri7WXrkY37vDdFfH36z4YgBRO2KVnaRyCvwL/cnMrSL
        +U1VHrVQkbHn+rO7gaM/qXErzLvP78Y=
X-Google-Smtp-Source: ADFU+vtFQuesBfdu/SFKjSIiLQtt0GyjsxUdkk/Xout2/yuYTjj9aJgVIe7DuThM6MJjbb0CCHq8ag==
X-Received: by 2002:adf:fc05:: with SMTP id i5mr18357770wrr.152.1584807237597;
        Sat, 21 Mar 2020 09:13:57 -0700 (PDT)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id f22sm13992285wmf.2.2020.03.21.09.13.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Mar 2020 09:13:57 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v2 07/11] bisect--helper: reimplement `bisect_autostart` shell function in C
Date:   Sat, 21 Mar 2020 17:10:16 +0100
Message-Id: <20200321161020.22817-8-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200321161020.22817-1-mirucam@gmail.com>
References: <20200321161020.22817-1-mirucam@gmail.com>
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
index 086ab8e46b..4496fd2228 100644
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
@@ -554,6 +557,7 @@ static enum bisect_error bisect_next(struct bisect_terms *terms, const char *pre
 	int no_checkout;
 	enum bisect_error res;
 
+	bisect_autostart(terms);
 	if (bisect_next_check(terms, terms->term_good))
 		return BISECT_FAILED;
 
@@ -802,6 +806,32 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, int no_checkou
 	return res;
 }
 
+static int bisect_autostart(struct bisect_terms *terms)
+{
+	const char *yesno;
+
+	if (!is_empty_or_missing_file(git_path_bisect_start()))
+		return 0;
+
+	fprintf(stderr, _("You need to start by \"git bisect "
+			  "start\"\n"));
+
+	if (!isatty(STDIN_FILENO))
+		return 1;
+
+	/*
+	 * TRANSLATORS: Make sure to include [Y] and [n] in your
+	 * translation. The program will only accept English input
+	 * at this point.
+	 */
+	yesno = git_prompt(_("Do you want me to do it for you "
+			     "[Y/n]? "), PROMPT_ECHO);
+	if (starts_with(yesno, _("n")) || starts_with(yesno, _("N")))
+		return 1;
+
+	return bisect_start(terms, 0, NULL, 0);
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
@@ -815,6 +845,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_START,
 		BISECT_NEXT,
 		BISECT_AUTO_NEXT,
+		BISECT_AUTOSTART,
 	} cmdmode = 0;
 	int no_checkout = 0, res = 0, nolog = 0;
 	struct option options[] = {
@@ -838,6 +869,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("find the next bisection commit"), BISECT_NEXT),
 		OPT_CMDMODE(0, "bisect-auto-next", &cmdmode,
 			 N_("verify the next bisection state then checkout the next bisection commit"), BISECT_AUTO_NEXT),
+		OPT_CMDMODE(0, "bisect-autostart", &cmdmode,
+			 N_("start the bisection if BISECT_START is empty or missing"), BISECT_AUTOSTART),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_BOOL(0, "no-log", &nolog,
@@ -904,6 +937,12 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
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
 		res = error(_("BUG: unknown subcommand."));
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

