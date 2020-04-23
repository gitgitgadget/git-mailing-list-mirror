Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE6AC54FD0
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 07:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62EA3208E4
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 07:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2BusIAW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgDWHJn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 03:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbgDWHJm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 03:09:42 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA214C03C1AB
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 00:09:40 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id z6so5352376wml.2
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 00:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=owAgqsYyhbNZZxr7DGdJQM8sc4QHTU2PXw0FK8VVF80=;
        b=A2BusIAWLq34GumztXRoAnde3nbEMIbTVvxSbtzLT5sZPIqHQjhGwBBH3iWCMZsyGr
         //vbHcTNfYeJZbMw/vh5mW6Epgy7EnWK/cpA1r0SSm2x4eSYbiECUjMOPsWnaDXHbnCW
         7bRLi8rTg4xG9U7VgJG3rbPEaqjz+9uI0Vm9V4GptqUC9euOyG6f8m6+Sg6osa74SRTi
         ZXbpuBBDUBUh6XC1z7Tph7B5Wt080DzeYx08221tid1FCduU0YFvQlINb6f+g0tMa903
         rdfO0mScwM9W5GeYZ/+dmeXcGSxlj2qkw0OADTYLx+KuIkU2SjWTUeeQaHN5iCd3NRqo
         UobA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=owAgqsYyhbNZZxr7DGdJQM8sc4QHTU2PXw0FK8VVF80=;
        b=TbFB2NO9eKLqiMcmBAUpReZvkzbpwFGoBMoseUbJwFIPGYHfsybbpuyNGgi3P3YkY4
         Os2wBXOKhjGMvdnevmtT8L1X0DARf8/ajMumxfeicILLUuKuUY9otd+wmk+VUMbOTBNr
         6Did+T7DsdZbnwVmimXSOHznlBE5Li60iuH+K83vv4YDG73EXMa1FlPxDYjmQxRgPSqR
         /jEvfFKvzZApD8FKwM5bqccys74GbVw0Yotr4qVKU/znruxOgJBqDO6HQkmPtxWEy7QF
         R7MRffS+oFWi1JL8pMpmrkDAIcqet61sda//53mkDcpNJlLNdVf7heQp8TR4aHGIG8M2
         Ug8w==
X-Gm-Message-State: AGi0PuZA1jw8BZeq6xWGg2QYa4ElY/nRA2yb+MgV6JU6l4IkhtyN6enM
        H7aqBZhprg4WOFMfJ2g/VVvdNeBZwH6qJg==
X-Google-Smtp-Source: APiQypL8r9nwAjnnlNr759kN7IrxyxY7C/K1hix3U4fZJIteRwYiJM3rg47UW3TEiqSbuywVF7GJnA==
X-Received: by 2002:a7b:cd10:: with SMTP id f16mr2580792wmj.21.1587625779186;
        Thu, 23 Apr 2020 00:09:39 -0700 (PDT)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id u17sm2518585wra.63.2020.04.23.00.09.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Apr 2020 00:09:38 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v3 04/12] bisect--helper: reimplement `bisect_autostart` shell function in C
Date:   Thu, 23 Apr 2020 09:06:56 +0200
Message-Id: <20200423070704.39872-5-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200423070704.39872-1-mirucam@gmail.com>
References: <20200423070704.39872-1-mirucam@gmail.com>
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
 builtin/bisect--helper.c | 40 +++++++++++++++++++++++++++++++++++++++-
 git-bisect.sh            | 25 ++-----------------------
 2 files changed, 41 insertions(+), 24 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index d3b2b33df0..9df69800e3 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -29,6 +29,7 @@ static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-terms [--term-good | --term-old | --term-bad | --term-new]"),
 	N_("git bisect--helper --bisect-start [--term-{old,good}=<term> --term-{new,bad}=<term>]"
 					     "[--no-checkout] [<bad> [<good>...]] [--] [<paths>...]"),
+	N_("git bisect--helper --bisect-autostart"),
 	NULL
 };
 
@@ -55,6 +56,8 @@ static void set_terms(struct bisect_terms *terms, const char *bad,
 static const char vocab_bad[] = "bad|new";
 static const char vocab_good[] = "good|old";
 
+static int bisect_autostart(struct bisect_terms *terms);
+
 /*
  * Check whether the string `term` belongs to the set of strings
  * included in the variable arguments.
@@ -630,6 +633,32 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
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
@@ -642,7 +671,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		CHECK_AND_SET_TERMS,
 		BISECT_NEXT_CHECK,
 		BISECT_TERMS,
-		BISECT_START
+		BISECT_START,
+		BISECT_AUTOSTART,
 	} cmdmode = 0;
 	int no_checkout = 0, res = 0, nolog = 0;
 	struct option options[] = {
@@ -666,6 +696,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("print out the bisect terms"), BISECT_TERMS),
 		OPT_CMDMODE(0, "bisect-start", &cmdmode,
 			 N_("start the bisect session"), BISECT_START),
+		OPT_CMDMODE(0, "bisect-autostart", &cmdmode,
+			 N_("start the bisection if BISECT_START is empty or missing"), BISECT_AUTOSTART),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_BOOL(0, "no-log", &nolog,
@@ -727,6 +759,12 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		set_terms(&terms, "bad", "good");
 		res = bisect_start(&terms, no_checkout, argv, argc);
 		break;
+	case BISECT_AUTOSTART:
+		if (argc)
+			return error(_("--bisect-autostart requires 0 arguments"));
+		set_terms(&terms, "bad", "good");
+		res = bisect_autostart(&terms);
+		break;
 	default:
 		BUG("unknown subcommand %d", (int)cmdmode);
 	}
diff --git a/git-bisect.sh b/git-bisect.sh
index efee12b8b1..426d443e7e 100755
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

