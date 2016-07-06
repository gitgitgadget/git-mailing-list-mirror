Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D486F2070C
	for <e@80x24.org>; Wed,  6 Jul 2016 20:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755785AbcGFU0z (ORCPT <rfc822;e@80x24.org>);
	Wed, 6 Jul 2016 16:26:55 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:32881 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755770AbcGFU0x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2016 16:26:53 -0400
Received: by mail-pf0-f195.google.com with SMTP id c74so22683682pfb.0
        for <git@vger.kernel.org>; Wed, 06 Jul 2016 13:26:52 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YCJ+/2MHso/Nt+B8xSM1Comby3/UgAKOtI++USt38pk=;
        b=aTZGZKwzPUcYdGpnPBX37cN4WLHHQnZFru9PLCikI49lX7+1B0FA1eWOiP22z2cU2K
         7KIXVO1+z7Q8FD39VR+7r4H3QbQpb/5850op/wa4BhYBWInVOeLmGG5UzmP8hUlh/zFJ
         4drND+SPKTQBv2Zn6r7QjEBv85zsn2rLiKmoH0tmd4IS5JOAYIx5AfUZbji1mYmX9Tyl
         5wnyFXlIbYCpPh4faAmJEbhuyyOv22YCRpxCDp+W9Uc903YMW+wOHNGGF0XU4O/r/bKK
         BI1aBK2iVFzSYNHwv4o1f4twu7159qX66o9DOUdcFuAjrQhlp0vHciAqTKtc8s6tJ2wF
         01EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YCJ+/2MHso/Nt+B8xSM1Comby3/UgAKOtI++USt38pk=;
        b=jx7P2ftSeSxLn0HhSFOi5UBnIdLGSqsWqoLcqYZgz/Y/aqEAd6Rt66AtMbcPSR2Gro
         cofJJbkc/DzIMTpf6HJBjU/TRovmddaY2PsLO/puwe35mXUVk6e4LXGjS4SkxcJgqyOB
         P29kOJ6QO7FyraDtpVuH4nVSWjvzhHASyGL7CITsUvEr4UiR2KeJq4ISgaS43lX+HfdX
         TOqggjfmR/e+hz7bYZirVXoXxq5QYXimgpBDxclKyRMqUgSHIo/NTEzA5xdaJ2eLKied
         4PvDUCl5O1zrGARHtfJ9t2jZWN6w9mNnui9pZE6XP2MELEWupjQXcSjTYVG7jkwZU3R9
         BV3A==
X-Gm-Message-State: ALyK8tL5PGpq0j1Ho6XOzdqX7WIJ2whJp5Lxq01UmNpIy8uBZpaZJJS8Xrb+dzZcKpncyw==
X-Received: by 10.98.32.65 with SMTP id g62mr45305634pfg.12.1467836812483;
        Wed, 06 Jul 2016 13:26:52 -0700 (PDT)
Received: from localhost.localdomain ([27.106.54.176])
        by smtp.gmail.com with ESMTPSA id a87sm6272459pfc.63.2016.07.06.13.26.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 Jul 2016 13:26:51 -0700 (PDT)
From:	Pranit Bauva <pranit.bauva@gmail.com>
To:	git@vger.kernel.org
Cc:	Pranit Bauva <pranit.bauva@gmail.com>, larsxschneider@gmail.com,
	christian.couder@gmail.com, chriscool@tuxfamily.org,
	sunshine@sunshineco.com
Subject: [PATCH v4 4/6] bisect--helper: `bisect_reset` shell function in C
Date:	Thu,  7 Jul 2016 01:55:21 +0530
Message-Id: <20160706202523.9850-5-pranit.bauva@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160706202523.9850-1-pranit.bauva@gmail.com>
References: <20160626122356.28999-1-pranit.bauva@gmail.com>
 <20160706202523.9850-1-pranit.bauva@gmail.com>
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
index 57fd4e9..96f6b65 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -4,6 +4,8 @@
 #include "bisect.h"
 #include "refs.h"
 #include "dir.h"
+#include "argv-array.h"
+#include "run-command.h"
 
 static GIT_PATH_FUNC(git_path_bisect_write_terms, "BISECT_TERMS")
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

