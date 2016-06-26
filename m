Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SBL_CSS,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E609F20179
	for <e@80x24.org>; Sun, 26 Jun 2016 20:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491AbcFZUqM (ORCPT <rfc822;e@80x24.org>);
	Sun, 26 Jun 2016 16:46:12 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35870 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449AbcFZUqL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jun 2016 16:46:11 -0400
Received: by mail-pf0-f194.google.com with SMTP id i123so14019820pfg.3
        for <git@vger.kernel.org>; Sun, 26 Jun 2016 13:46:10 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vhCx+azYtZ3/Qg7Dm/5RStaiNb1fr0VNd7ztAgL1QrU=;
        b=R8t53Q8zVE03kP1qWen0Q/nadBu2NmHsrGcDblyRnNbrRGI+P+OZ7qn2aKCB0qWGBC
         uJXrfKhX9J3PHecDvX4hH9FPQ+CeQs3Wkx5fnhefE1YnLIzqIWdMpcz6QCXH1yPAqQgI
         XwKora5Q4SNFbVCLLtGsLBv6qgt2r0Y9oZq1B7WRrT6Mpa8sE7R6Z3xLzPdzH/ybnc8z
         KxVJguNC1Z2jOHoOF+N6POMbCsSe6LCZV2pial1vCom0cq6DtHwIbnfqOOnXP7UmEZyK
         xF6DLSZgyeIIC1Xz7LGrrZRQnz1ynzYMoR9ws59iVoVA3qa8aDRBOfvNBiioV5xd84pU
         D2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vhCx+azYtZ3/Qg7Dm/5RStaiNb1fr0VNd7ztAgL1QrU=;
        b=MTcMiJ2Y4WF600SWl49tIrdmV09srMm4B1Ifle1SnW7tj7sVLJ/zI9uJcHi+mjAny7
         aEtCNkSnJ2FKIClYLobwS1qV7ToJuan3mODahTlJHnsW0v3d9Wqlpt2LY9tDBGNLTwrZ
         ZkC5DmqEq1CUo3C+7+oCuFtUTmIEL4wb6w+KIsnUeueDzlmyzI1Jku7YoF2jqHkA/Eva
         2537gq06DIM/+h/61pYo4zOZDRZToU5C+FtBaBOoLp7lVx0YBpOZs8s+QjYbIHCn9xAS
         qa9R+UALgnGFlrS4m/FnD1XvVG3Ej6vni1Q5n2qQAuGfKibbbQUZqicO80YbVOr04isj
         vwJw==
X-Gm-Message-State: ALyK8tKjbR7Ed3BJy0obXMwvqTOpevEUNyVujDk66OYnR39DmLbEssM1HfooxSOaRd5CVg==
X-Received: by 10.98.108.5 with SMTP id h5mr27446525pfc.22.1466973970264;
        Sun, 26 Jun 2016 13:46:10 -0700 (PDT)
Received: from localhost.localdomain ([111.119.199.22])
        by smtp.gmail.com with ESMTPSA id ot2sm1591749pac.29.2016.06.26.13.46.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 26 Jun 2016 13:46:09 -0700 (PDT)
From:	Pranit Bauva <pranit.bauva@gmail.com>
To:	git@vger.kernel.org
Cc:	Pranit Bauva <pranit.bauva@gmail.com>, Matthie.Moy@grenoble-inp.fr,
	christian.couder@gmail.com, chriscool@tuxfamily.org,
	gitster@pobox.com
Subject: [RFC/PATCH 2/3] bisect--helper: `bisect_next_check` shell function in C
Date:	Mon, 27 Jun 2016 02:14:10 +0530
Message-Id: <20160626204411.19919-2-pranit.bauva@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160626204411.19919-1-pranit.bauva@gmail.com>
References: <20160626204411.19919-1-pranit.bauva@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Reimplement `bisect_next_check` shell function in C and add
`bisect-next-check` subcommand to `git bisect--helper` to call it from
git-bisect.sh .

Using `--bisect-next-check` is a temporary measure to port shell
function to C so as to use the existing test suite. As more functions
are ported, this subcommand will be retired and will be called by some
other methods.

bisect_voc() is removed as it is redundant and does not serve any useful
purpose. We are better off specifying "bad|new" "good|old" as and when
we require in bisect_next_check().

Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 builtin/bisect--helper.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++-
 git-bisect.sh            | 60 +++---------------------------------
 2 files changed, 83 insertions(+), 57 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index c387697..9a289a1 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -6,6 +6,7 @@
 #include "dir.h"
 #include "argv-array.h"
 #include "run-command.h"
+#include "prompt.h"
 
 static GIT_PATH_FUNC(git_path_bisect_write_terms, "BISECT_TERMS")
 static GIT_PATH_FUNC(git_path_bisect_expected_rev, "BISECT_EXPECTED_REV")
@@ -23,6 +24,7 @@ static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-clean-state"),
 	N_("git bisect--helper --bisect-reset [<commit>]"),
 	N_("git bisect--helper --bisect-write <state> <revision> <TERM_GOOD> <TERM_BAD> [<nolog>]"),
+	N_("git bisect--helper --bisect-next-check [<term>] <TERM_GOOD> <TERM_BAD"),
 	NULL
 };
 
@@ -295,6 +297,68 @@ static int check_and_set_terms(const char *cmd, struct bisect_terms *term)
 	return 0;
 }
 
+static int mark_good(const char *refname, const struct object_id *oid,
+		     int flag, void *cb_data)
+{
+	int *m_good = (int *)cb_data;
+	*m_good = 0;
+	return 0;
+}
+
+static int bisect_next_check(const struct bisect_terms *state, const char *term)
+{
+	int missing_good = 1, missing_bad = 1;
+	char *bad_ref = xstrfmt("refs/bisect/%s", state->term_bad.buf);
+	char *good_ref = xstrfmt("%s*", state->term_good.buf);
+	if (ref_exists(bad_ref))
+		missing_bad = 0;
+
+	for_each_glob_ref_in(mark_good, good_ref, "refs/bisect/",
+			     (void *) &missing_good);
+	free(good_ref);
+	free(bad_ref);
+
+	if (!missing_good && !missing_bad)
+		return 0;
+
+	if (!term)
+		return -1;
+
+	if (missing_good && !missing_bad && term && !strcmp(term, state->term_good.buf)) {
+		char *yesno;
+		/*
+		 * have bad (or new) but not good (or old). We could bisect
+		 * although this is less optimum.
+		 */
+		fprintf(stderr, "Warning: bisecting only with a %s commit\n",
+			state->term_bad.buf);
+		if (!isatty(0))
+			return 0;
+		/*
+		 * TRANSLATORS: Make sure to include [Y] and [n] in your
+		 * translation. The program will only accept English input
+		 * at this point.
+		 */
+		yesno = git_prompt(_("Are you sure [Y/n]? "), PROMPT_ECHO);
+		if (starts_with(yesno, "N") || starts_with(yesno, "n"))
+			return -1;
+		return 0;
+	}
+	if (!is_empty_or_missing_file(git_path_bisect_start()))
+		return error(_("You need to give me at least one good|old and "
+				"bad|new revision. You can use \"git bisect "
+				"bad|new\" and \"git bisect good|old\" for "
+				"that. \n"));
+	else
+		return error(_("You need to start by \"git bisect start\". "
+				"You then need to give me at least one good|"
+				"old and bad|new revision. You can use \"git "
+				"bisect bad|new\" and \"git bisect good|old\" "
+				" for that.\n"));
+
+	return 0;
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
@@ -304,7 +368,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_RESET,
 		CHECK_EXPECTED_REVS,
 		BISECT_WRITE,
-		CHECK_AND_SET_TERMS
+		CHECK_AND_SET_TERMS,
+		BISECT_NEXT_CHECK
 	} cmdmode = 0;
 	int no_checkout = 0, res = 0;
 	struct option options[] = {
@@ -322,6 +387,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("write out the bisection state in BISECT_LOG"), BISECT_WRITE),
 		OPT_CMDMODE(0, "check-and-set-terms", &cmdmode,
 			 N_("check and set terms in a bisection state"), CHECK_AND_SET_TERMS),
+		OPT_CMDMODE(0, "bisect-next-check", &cmdmode,
+			 N_("check whether bad or good terms exist"), BISECT_NEXT_CHECK),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_END()
@@ -372,6 +439,17 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		strbuf_addstr(&state.term_bad, argv[2]);
 		res = check_and_set_terms(argv[0], &state);
 		break;
+	case BISECT_NEXT_CHECK:
+		if (argc != 2 && argc != 3)
+			die(_("--bisect-next-check requires 2 or 3 arguments"));
+		strbuf_addstr(&state.term_good, argv[0]);
+		strbuf_addstr(&state.term_bad, argv[1]);
+		if (argc == 2) {
+			res = bisect_next_check(&state, NULL);
+			break;
+		}
+		res = bisect_next_check(&state, argv[2]);
+		break;
 	default:
 		die("BUG: unknown subcommand '%d'", cmdmode);
 	}
diff --git a/git-bisect.sh b/git-bisect.sh
index 63ae742..51b0a6b 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -271,59 +271,14 @@ bisect_state() {
 	bisect_auto_next
 }
 
-bisect_next_check() {
-	missing_good= missing_bad=
-	git show-ref -q --verify refs/bisect/$TERM_BAD || missing_bad=t
-	test -n "$(git for-each-ref "refs/bisect/$TERM_GOOD-*")" || missing_good=t
-
-	case "$missing_good,$missing_bad,$1" in
-	,,*)
-		: have both $TERM_GOOD and $TERM_BAD - ok
-		;;
-	*,)
-		# do not have both but not asked to fail - just report.
-		false
-		;;
-	t,,"$TERM_GOOD")
-		# have bad (or new) but not good (or old).  we could bisect although
-		# this is less optimum.
-		eval_gettextln "Warning: bisecting only with a \$TERM_BAD commit." >&2
-		if test -t 0
-		then
-			# TRANSLATORS: Make sure to include [Y] and [n] in your
-			# translation. The program will only accept English input
-			# at this point.
-			gettext "Are you sure [Y/n]? " >&2
-			read yesno
-			case "$yesno" in [Nn]*) exit 1 ;; esac
-		fi
-		: bisect without $TERM_GOOD...
-		;;
-	*)
-		bad_syn=$(bisect_voc bad)
-		good_syn=$(bisect_voc good)
-		if test -s "$GIT_DIR/BISECT_START"
-		then
-
-			eval_gettextln "You need to give me at least one \$bad_syn and one \$good_syn revision.
-(You can use \"git bisect \$bad_syn\" and \"git bisect \$good_syn\" for that.)" >&2
-		else
-			eval_gettextln "You need to start by \"git bisect start\".
-You then need to give me at least one \$good_syn and one \$bad_syn revision.
-(You can use \"git bisect \$bad_syn\" and \"git bisect \$good_syn\" for that.)" >&2
-		fi
-		exit 1 ;;
-	esac
-}
-
 bisect_auto_next() {
-	bisect_next_check && bisect_next || :
+	git bisect--helper --bisect-next-check $TERM_GOOD $TERM_BAD && bisect_next || :
 }
 
 bisect_next() {
 	case "$#" in 0) ;; *) usage ;; esac
 	bisect_autostart
-	bisect_next_check $TERM_GOOD
+	git bisect--helper --bisect-next-check $TERM_GOOD $TERM_BAD $TERM_GOOD|| exit
 
 	# Perform all bisection computation, display and checkout
 	git bisect--helper --next-all $(test -f "$GIT_DIR/BISECT_HEAD" && echo --no-checkout)
@@ -355,7 +310,7 @@ bisect_next() {
 }
 
 bisect_visualize() {
-	bisect_next_check fail
+	git bisect--helper --bisect-next-check $TERM_GOOD $TERM_BAD fail || exit
 
 	if test $# = 0
 	then
@@ -409,7 +364,7 @@ bisect_replay () {
 }
 
 bisect_run () {
-	bisect_next_check fail
+	git bisect--helper --bisect-next-check $TERM_GOOD $TERM_BAD fail || exit
 
 	while true
 	do
@@ -482,13 +437,6 @@ get_terms () {
 	fi
 }
 
-bisect_voc () {
-	case "$1" in
-	bad) echo "bad|new" ;;
-	good) echo "good|old" ;;
-	esac
-}
-
 bisect_terms () {
 	get_terms
 	if ! test -s "$GIT_DIR/BISECT_TERMS"
-- 
2.9.0

