From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH 2/2] bisect: rewrite `check_term_format` shell function in C
Date: Wed,  4 May 2016 10:37:52 +0530
Message-ID: <1462338472-3581-3-git-send-email-pranit.bauva@gmail.com>
References: <01020153a254974b-68f7d16a-66d7-4dc1-805d-2185ff1b3ebf-000000@eu-west-1.amazonses.com>
 <1462338472-3581-1-git-send-email-pranit.bauva@gmail.com>
Cc: Pranit Bauva <pranit.bauva@gmail.com>, chriscool@tuxfamily.org,
	christain.couder@gmail.com, Johannes.Schindelin@gmx.de,
	larsxschneider@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 04 07:09:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axp3T-00051v-7Y
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 07:08:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbcEDFIv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 01:08:51 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:35949 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751310AbcEDFIu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 01:08:50 -0400
Received: by mail-pa0-f51.google.com with SMTP id bt5so19360753pac.3
        for <git@vger.kernel.org>; Tue, 03 May 2016 22:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ryQotjX4uNYOL0W4BuC4IdeFx9CtuJv2aK/leJDs+ao=;
        b=bbJwL/kwhD5fWwF1wj/xLEdn3rs8sQdqBJFkphQwipE/IN3LdY1yKH6TrUcQ45ZTHD
         rkrtmnB6+JvBX+mf+icT9AO+RSsamlpoLsKXGjR3KecloarG2gtZcPcprS2pW7MhCpa8
         4XZStv0JTCEvUAqDHzeMBGKZAMKvQkcmE6w26eZOKIJNVqzgS5MNhnBvGjiM5c69kNXr
         5+oeRWPYEnXMK4Ek8cQ4VwuZot5oSzmzzt1Q7/cXyA8yQoeYXZX7UvwFjsAoIP0Z24OZ
         m5ECi8+jr+EattfprNVjoF2WUFHD/Y4naka6IOwqp0pvSNgYp1uJ685rfRz0YTMwBNRc
         C+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=ryQotjX4uNYOL0W4BuC4IdeFx9CtuJv2aK/leJDs+ao=;
        b=mbHzDFxMJU0GnMzy6QeyZR1aWLeB17dZzcD/HooTfj8QnqIYPGewFOhcK7zeGQLNxX
         5gtT/pEvfUulPJKR+S1HAZXyd5aAlwsdRBmFdswFRRy8tJK0b7XxmdD2buZJle9HP7Th
         JZJg2XIIFYQoUihSBlEZWZD+jfNuMNjmU02gHOWqcfyJEhzosBgWyzW4aiohaIDprdcL
         vwaZhPIlrKRj3hvN3+z8H3T9lSgAFgmLT7AGo34RiKW3vHErtwB3hh9CfWfhEGfyDqiI
         +yJW2GRykao+8xU4zsY5bidIeRzCwBtDIPaqqtxxhhw5RNA9KcpdBJ33FhsE/ZN2X1aP
         ritQ==
X-Gm-Message-State: AOPr4FWS4LxquiuHANeE3mlWj+cFkP/35ZWiTP/Jn/+jZRCRQC4SCg9i6i73lJkVRbcITA==
X-Received: by 10.66.66.42 with SMTP id c10mr9247442pat.119.1462338529944;
        Tue, 03 May 2016 22:08:49 -0700 (PDT)
Received: from localhost.localdomain ([183.87.83.50])
        by smtp.gmail.com with ESMTPSA id p189sm2171709pfb.51.2016.05.03.22.08.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 May 2016 22:08:49 -0700 (PDT)
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1462338472-3581-1-git-send-email-pranit.bauva@gmail.com>
In-Reply-To: <01020153a254974b-68f7d16a-66d7-4dc1-805d-2185ff1b3ebf-000000@eu-west-1.amazonses.com>
References: <01020153a254974b-68f7d16a-66d7-4dc1-805d-2185ff1b3ebf-000000@eu-west-1.amazonses.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293489>

This reimplements the `check_term_format` shell function in C and adds
a `--check-term-format` subcommand to `git bisect--helper` to call it
from git-bisect.sh

Helped-by: Johannes Schindelein <Johannes.Schindelein@gmx.de>
Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 builtin/bisect--helper.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++-
 git-bisect.sh            | 31 ++------------------------
 2 files changed, 59 insertions(+), 30 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 5f6ef8c..228920f 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -2,16 +2,66 @@
 #include "cache.h"
 #include "parse-options.h"
 #include "bisect.h"
+#include "refs.h"
 
 static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --next-all [--no-checkout]"),
+	N_("git bisect--helper --check-term-format <term> <orig_term>"),
 	NULL
 };
 
 enum sub_commands {
-	NEXT_ALL = 1
+	NEXT_ALL = 1,
+	CHECK_TERM_FMT
 };
 
+/*
+ * To check whether the string `term` belongs to the set of strings
+ * included in the variable arguments so as to make the code look
+ * clean and avoid having long lines in the `if` statement.
+ */
+static int one_of(const char *term, ...)
+{
+	va_list matches;
+	const char *match;
+
+	va_start(matches, term);
+	while ((match = va_arg(matches, const char *)) != NULL)
+		if (!strcmp(term, match))
+			return 1;
+
+	va_end(matches);
+
+	return 0;
+}
+
+static int check_term_format(const char *term, const char *orig_term,
+			     int flag)
+{
+	struct strbuf new_term = STRBUF_INIT;
+	strbuf_addf(&new_term, "refs/bisect/%s", term);
+
+	if (check_refname_format(new_term.buf, flag))
+		die(_("'%s' is not a valid term\n"), term);
+
+	else if (one_of(term, "help", "start", "skip", "next", "reset",
+			"visualize", "replay", "log", "run", NULL))
+		return error("can't use the builtin command '%s' as a term\n", term);
+
+	/*
+	 * In theory, nothing prevents swapping
+	 * completely good and bad, but this situation
+	 * could be confusing and hasn't been tested
+	 * enough. Forbid it for now.
+	 */
+
+	else if ((one_of(term, "bad", "new", NULL) && strcmp(orig_term, "bad")) ||
+		 (one_of(term, "good", "old", NULL) && strcmp(orig_term, "good")))
+		return error("can't change the meaning of the term '%s'\n", term);
+
+	return 0;
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	int sub_command = 0;
@@ -19,6 +69,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_CMDMODE(0, "next-all", &sub_command,
 			 N_("perform 'git bisect next'"), NEXT_ALL),
+		OPT_CMDMODE(0, "check-term-format", &sub_command,
+			 N_("check format of the ref"), CHECK_TERM_FMT),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_END()
@@ -33,6 +85,10 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	switch (sub_command) {
 	case NEXT_ALL:
 		return bisect_next_all(prefix, no_checkout);
+	case CHECK_TERM_FMT:
+		if (argc != 2)
+			die(_("--check-term-format should be followed by exactly 2 arguments."));
+		return check_term_format(argv[0], argv[1], 0);
 	default:
 		die(_("bug: unknown subcommand '%d'"), sub_command);
 	}
diff --git a/git-bisect.sh b/git-bisect.sh
index 5d1cb00..7d7965d 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -564,38 +564,11 @@ write_terms () {
 	then
 		die "$(gettext "please use two different terms")"
 	fi
-	check_term_format "$TERM_BAD" bad
-	check_term_format "$TERM_GOOD" good
+	git bisect--helper --check-term-format "$TERM_BAD" bad || exit
+	git bisect--helper --check-term-format "$TERM_GOOD" good || exit
 	printf '%s\n%s\n' "$TERM_BAD" "$TERM_GOOD" >"$GIT_DIR/BISECT_TERMS"
 }
 
-check_term_format () {
-	term=$1
-	git check-ref-format refs/bisect/"$term" ||
-	die "$(eval_gettext "'\$term' is not a valid term")"
-	case "$term" in
-	help|start|terms|skip|next|reset|visualize|replay|log|run)
-		die "$(eval_gettext "can't use the builtin command '\$term' as a term")"
-		;;
-	bad|new)
-		if test "$2" != bad
-		then
-			# In theory, nothing prevents swapping
-			# completely good and bad, but this situation
-			# could be confusing and hasn't been tested
-			# enough. Forbid it for now.
-			die "$(eval_gettext "can't change the meaning of term '\$term'")"
-		fi
-		;;
-	good|old)
-		if test "$2" != good
-		then
-			die "$(eval_gettext "can't change the meaning of term '\$term'")"
-		fi
-		;;
-	esac
-}
-
 check_and_set_terms () {
 	cmd="$1"
 	case "$cmd" in
-- 
2.8.1
