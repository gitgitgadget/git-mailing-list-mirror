Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 092D220195
	for <e@80x24.org>; Tue, 12 Jul 2016 22:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752348AbcGLWjm (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 18:39:42 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:32874 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752542AbcGLWjh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2016 18:39:37 -0400
Received: by mail-pa0-f65.google.com with SMTP id q2so1822896pap.0
        for <git@vger.kernel.org>; Tue, 12 Jul 2016 15:39:31 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sLmM6gAuVqneiGcbpXJisOz5KK0c8lAa4YPjoh6tr+4=;
        b=EHqlv1njuUbvRNnvZMBg8eU6FlU5kRxV5iKJa1lNAYmPDQKh1kFqtCv1DGta8uEpo5
         uZUmJuA8vxPNJW3OK6PNT8L2NB1Yf1VVXbFj+AI+i8FDbp5zPE8Qx+gGlP+f0QV1/z+U
         ANm/wIllQWSK0YjSka8aTdmD6Dy7rMhgAj/znLmM6x/ZCW+fB5MwvZaEeFS3sJ5vvjTn
         NaKyz1/m5+WFpa+GRXdTupup9KUDGzRKQp6ypZWNeVTU3lpvSgLaw1Xi2sUfkook4Yzg
         lkwecJVblvnNk9nYAbXpfxAtOo2EBye3K6F9Ha/AVLIi93Zu6XsthDFSTiBTuERR+RaS
         dyAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sLmM6gAuVqneiGcbpXJisOz5KK0c8lAa4YPjoh6tr+4=;
        b=kqOhtmJNSU7kFA63cNUDFsmmuojngRkOSZecNGAJW40LxKvQ+7QUaM63ubVOrO77fG
         m1P8IP7kVz5hM+KLy/f1N5fNr7EqnZkU1EyubL6mIlog6rd15inVFaZLG45RdQobC8Tk
         49Idnda7VdOn7rYdwuL3ckszv6NMt8KQ1aBPW286N9yh682Px+ZDLDDFCh95iBQLGpkT
         KRB1xSd4rXP3Cof9g2GIPR8dCTmZ0B6xPrjUg+jo4SKtpacjWit2Ctn22GQ3AmSUfBoT
         kW/HH5wKCVhMHYicU0Mfeo9JDHPUTDQdG/Y2PY9uBm+5OBymwWcn3M8gBDW7P86B8G/8
         f3fA==
X-Gm-Message-State: ALyK8tLGjy42pHnsDZmRxrnpoePYqtCm1QlViIBYr7tWnvTPIi4Lzwyyo5PUZCVBZTgABw==
X-Received: by 10.66.157.40 with SMTP id wj8mr7932603pab.53.1468363161206;
        Tue, 12 Jul 2016 15:39:21 -0700 (PDT)
Received: from localhost.localdomain ([103.57.70.227])
        by smtp.gmail.com with ESMTPSA id g26sm6723796pfj.82.2016.07.12.15.39.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Jul 2016 15:39:20 -0700 (PDT)
From:	Pranit Bauva <pranit.bauva@gmail.com>
To:	gitster@pobox.com
Cc:	Pranit Bauva <pranit.bauva@gmail.com>, larsxschneider@gmail.com,
	christian.couder@gmail.com, chriscool@tuxfamily.org,
	git@vger.kernel.org
Subject: [PATCH 7/9] bisect--helper: `bisect_reset` shell function in C
Date:	Wed, 13 Jul 2016 04:05:36 +0530
Message-Id: <20160712223538.28508-8-pranit.bauva@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160712223538.28508-1-pranit.bauva@gmail.com>
References: <20160712223538.28508-1-pranit.bauva@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Reimplement `bisect_reset` shell function in C and add a `--bisect-reset`
subcommand to `git bisect--helper` to call it from git-bisect.sh .

Using `bisect_reset` subcommand is a temporary measure to port shell
functions to C so as to use the existing test suite. As more functions
are ported, this subcommand would be retired and will be called by some
other method.

Note: --bisect-clean-state subcommand has not been retired as there are
still a function namely `bisect_start()` which still uses this
subcommand.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 builtin/bisect--helper.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++-
 git-bisect.sh            | 28 ++--------------------------
 2 files changed, 48 insertions(+), 27 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 3089433..636044a 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -4,6 +4,8 @@
 #include "bisect.h"
 #include "refs.h"
 #include "dir.h"
+#include "argv-array.h"
+#include "run-command.h"
 
 static GIT_PATH_FUNC(git_path_bisect_terms, "BISECT_TERMS")
 static GIT_PATH_FUNC(git_path_bisect_expected_rev, "BISECT_EXPECTED_REV")
@@ -13,11 +15,13 @@ static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
 static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
 static GIT_PATH_FUNC(git_path_head_name, "head-name")
 static GIT_PATH_FUNC(git_path_bisect_start, "BISECT_START")
+static GIT_PATH_FUNC(git_path_bisect_head, "BISECT_HEAD")
 
 static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --next-all [--no-checkout]"),
 	N_("git bisect--helper --write-terms <bad_term> <good_term>"),
 	N_("git bisect--helper --bisect-clean-state"),
+	N_("git bisect--helper --bisect-reset [<commit>]"),
 	NULL
 };
 
@@ -124,12 +128,47 @@ static int bisect_clean_state(void)
 	return result;
 }
 
+static int bisect_reset(const char *commit)
+{
+	struct strbuf branch = STRBUF_INIT;
+
+	if (!commit) {
+		if (strbuf_read_file(&branch, git_path_bisect_start(), 0) < 1) {
+			printf("We are not bisecting.\n");
+			return 0;
+		}
+		strbuf_rtrim(&branch);
+	} else {
+		struct object_id oid;
+		if (get_oid(commit, &oid))
+			return error(_("'%s' is not a valid commit"), commit);
+		strbuf_addstr(&branch, commit);
+	}
+
+	if (!file_exists(git_path_bisect_head())) {
+		struct argv_array argv = ARGV_ARRAY_INIT;
+		argv_array_pushl(&argv, "checkout", branch.buf, "--", NULL);
+		if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
+			error(_("Could not check out original HEAD '%s'. Try"
+				"'git bisect reset <commit>'."), branch.buf);
+			strbuf_release(&branch);
+			argv_array_clear(&argv);
+			return -1;
+		}
+		argv_array_clear(&argv);
+	}
+
+	strbuf_release(&branch);
+	return bisect_clean_state();
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
 		NEXT_ALL = 1,
 		WRITE_TERMS,
-		BISECT_CLEAN_STATE
+		BISECT_CLEAN_STATE,
+		BISECT_RESET
 	} cmdmode = 0;
 	int no_checkout = 0;
 	struct option options[] = {
@@ -139,6 +178,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("write the terms to .git/BISECT_TERMS"), WRITE_TERMS),
 		OPT_CMDMODE(0, "bisect-clean-state", &cmdmode,
 			 N_("cleanup the bisection state"), BISECT_CLEAN_STATE),
+		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
+			 N_("reset the bisection state"), BISECT_RESET),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_END()
@@ -161,6 +202,10 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		if (argc != 0)
 			die(_("--bisect-clean-state requires no arguments"));
 		return bisect_clean_state();
+	case BISECT_RESET:
+		if (argc > 1)
+			die(_("--bisect-reset requires either zero or one arguments"));
+		return bisect_reset(argc ? argv[0] : NULL);
 	default:
 		die("BUG: unknown subcommand '%d'", cmdmode);
 	}
diff --git a/git-bisect.sh b/git-bisect.sh
index bbc57d2..18580b7 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -409,35 +409,11 @@ bisect_visualize() {
 	eval '"$@"' --bisect -- $(cat "$GIT_DIR/BISECT_NAMES")
 }
 
-bisect_reset() {
-	test -s "$GIT_DIR/BISECT_START" || {
-		gettextln "We are not bisecting."
-		return
-	}
-	case "$#" in
-	0) branch=$(cat "$GIT_DIR/BISECT_START") ;;
-	1) git rev-parse --quiet --verify "$1^{commit}" >/dev/null || {
-			invalid="$1"
-			die "$(eval_gettext "'\$invalid' is not a valid commit")"
-		}
-		branch="$1" ;;
-	*)
-		usage ;;
-	esac
-
-	if ! test -f "$GIT_DIR/BISECT_HEAD" && ! git checkout "$branch" --
-	then
-		die "$(eval_gettext "Could not check out original HEAD '\$branch'.
-Try 'git bisect reset <commit>'.")"
-	fi
-	git bisect--helper --bisect-clean-state || exit
-}
-
 bisect_replay () {
 	file="$1"
 	test "$#" -eq 1 || die "$(gettext "No logfile given")"
 	test -r "$file" || die "$(eval_gettext "cannot read \$file for replaying")"
-	bisect_reset
+	git bisect--helper --bisect-reset || exit
 	while read git bisect command rev
 	do
 		test "$git $bisect" = "git bisect" || test "$git" = "git-bisect" || continue
@@ -627,7 +603,7 @@ case "$#" in
 	visualize|view)
 		bisect_visualize "$@" ;;
 	reset)
-		bisect_reset "$@" ;;
+		git bisect--helper --bisect-reset "$@" ;;
 	replay)
 		bisect_replay "$@" ;;
 	log)
-- 
2.9.0

