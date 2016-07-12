Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 845DD20196
	for <e@80x24.org>; Tue, 12 Jul 2016 22:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752530AbcGLWjb (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 18:39:31 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:32841 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712AbcGLWj3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2016 18:39:29 -0400
Received: by mail-pa0-f67.google.com with SMTP id q2so1822727pap.0
        for <git@vger.kernel.org>; Tue, 12 Jul 2016 15:39:24 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3p60GMDUukiYU1BkkYPR/0Nf4tCFmMYiZlKD9NQcRJw=;
        b=cPHIAL6seNG7a8ytQ+Pp/8VTo92Rs7YbNZX1FWizB+VG+7G+8fY+eXzbq8sgUALpUQ
         EtSZHPDjm2u8OJhDdJoofz1n6ee+nGKEN/7uOMjuEzbfooyz1QhYzl2+NwdJff2j1KEI
         9R8P8LYm9k9umrNTo/k/Vsb59OE2gMVBRTmfcs+KhtdHiU4yfiC+zhIdaJ4nAH4086EH
         5W8dJtCIEfvjyFPl5NXAbJVvMt1OT15cP/Vl2kGWQC+5K/QvQ59HWd3KtGbJ1p5Aapmz
         54dv4s3Qz3SaePpzdZM+HpS3VX8+u1V9HGRF8jn6gl9LIoytruOP2ELugkc5IISh4ml0
         WtJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3p60GMDUukiYU1BkkYPR/0Nf4tCFmMYiZlKD9NQcRJw=;
        b=C9a4Xye79YdcJzRHyY8wx4Q+B7gHYMer2jTeZ6rOm0S7VvXUtKJRKYuXVosLzT4h/W
         AG7fECuq9ItNkT1GXk7QBYiHnXjBiKJ20CScnnMb9ny/VqGiHZEByIaShzeiv985Ilv5
         eQoVF5vmUKleAJ6gzH3yo53Ty+6eVLjnJipZ0F24dTNoZ0RA3ZMtyWtdOoZm5WEXztyJ
         z1M45ZZQjCgIOVh6MrO7ILSYe22cSv7wMOna1wfmzU5nd7kqmu76CuV6W7wMEsniyCxZ
         wd/yOL4ygsSgR5OJjhNK9keu27cf/FWNgHbhLlBBMCG5/bLBoCM2uh4/mRCoLgJxdVX3
         KM3A==
X-Gm-Message-State: ALyK8tIj+k7CTXcC+wOXZjJv2CfNv9XVXmmD47FRY/sP2CUyWPfTPVqitmGMncR8oDsLyQ==
X-Received: by 10.66.47.133 with SMTP id d5mr8007798pan.48.1468363152814;
        Tue, 12 Jul 2016 15:39:12 -0700 (PDT)
Received: from localhost.localdomain ([103.57.70.227])
        by smtp.gmail.com with ESMTPSA id g26sm6723796pfj.82.2016.07.12.15.39.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Jul 2016 15:39:12 -0700 (PDT)
From:	Pranit Bauva <pranit.bauva@gmail.com>
To:	gitster@pobox.com
Cc:	Pranit Bauva <pranit.bauva@gmail.com>, larsxschneider@gmail.com,
	christian.couder@gmail.com, chriscool@tuxfamily.org,
	git@vger.kernel.org
Subject: [PATCH 4/9] bisect--helper: `bisect_clean_state` shell function in C
Date:	Wed, 13 Jul 2016 04:05:33 +0530
Message-Id: <20160712223538.28508-5-pranit.bauva@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160712223538.28508-1-pranit.bauva@gmail.com>
References: <20160712223538.28508-1-pranit.bauva@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Reimplement `bisect_clean_state` shell function in C and add a
`bisect-clean-state` subcommand to `git bisect--helper` to call it from
git-bisect.sh .

Using `--bisect-clean-state` subcommand is a measure to port shell
function to C so as to use the existing test suite. As more functions
are ported, this subcommand will be retired and will be called by
bisect_reset() and bisect_start().

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 builtin/bisect--helper.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++-
 git-bisect.sh            | 26 +++--------------------
 2 files changed, 57 insertions(+), 24 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index bec63d6..3089433 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -3,12 +3,21 @@
 #include "parse-options.h"
 #include "bisect.h"
 #include "refs.h"
+#include "dir.h"
 
 static GIT_PATH_FUNC(git_path_bisect_terms, "BISECT_TERMS")
+static GIT_PATH_FUNC(git_path_bisect_expected_rev, "BISECT_EXPECTED_REV")
+static GIT_PATH_FUNC(git_path_bisect_ancestors_ok, "BISECT_ANCESTORS_OK")
+static GIT_PATH_FUNC(git_path_bisect_log, "BISECT_LOG")
+static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
+static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
+static GIT_PATH_FUNC(git_path_head_name, "head-name")
+static GIT_PATH_FUNC(git_path_bisect_start, "BISECT_START")
 
 static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --next-all [--no-checkout]"),
 	N_("git bisect--helper --write-terms <bad_term> <good_term>"),
+	N_("git bisect--helper --bisect-clean-state"),
 	NULL
 };
 
@@ -78,11 +87,49 @@ static int write_terms(const char *bad, const char *good)
 	return (res < 0) ? -1 : 0;
 }
 
+static int mark_for_removal(const char *refname, const struct object_id *oid,
+			    int flag, void *cb_data)
+{
+	struct string_list *refs = cb_data;
+	char *ref = xstrfmt("refs/bisect/%s", refname);
+	string_list_append(refs, ref);
+	return 0;
+}
+
+static int bisect_clean_state(void)
+{
+	int result = 0;
+
+	/* There may be some refs packed during bisection */
+	struct string_list refs_for_removal = STRING_LIST_INIT_NODUP;
+	for_each_ref_in("refs/bisect/", mark_for_removal, (void *) &refs_for_removal);
+	string_list_append(&refs_for_removal, xstrdup("BISECT_HEAD"));
+	result = delete_refs(&refs_for_removal);
+	refs_for_removal.strdup_strings = 1;
+	string_list_clear(&refs_for_removal, 0);
+	remove_path(git_path_bisect_expected_rev());
+	remove_path(git_path_bisect_ancestors_ok());
+	remove_path(git_path_bisect_log());
+	remove_path(git_path_bisect_names());
+	remove_path(git_path_bisect_run());
+	remove_path(git_path_bisect_terms());
+	/* Cleanup head-name if it got left by an old version of git-bisect */
+	remove_path(git_path_head_name());
+	/*
+	 * Cleanup BISECT_START last to support the --no-checkout option
+	 * introduced in the commit 4796e823a.
+	 */
+	remove_path(git_path_bisect_start());
+
+	return result;
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
 		NEXT_ALL = 1,
-		WRITE_TERMS
+		WRITE_TERMS,
+		BISECT_CLEAN_STATE
 	} cmdmode = 0;
 	int no_checkout = 0;
 	struct option options[] = {
@@ -90,6 +137,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("perform 'git bisect next'"), NEXT_ALL),
 		OPT_CMDMODE(0, "write-terms", &cmdmode,
 			 N_("write the terms to .git/BISECT_TERMS"), WRITE_TERMS),
+		OPT_CMDMODE(0, "bisect-clean-state", &cmdmode,
+			 N_("cleanup the bisection state"), BISECT_CLEAN_STATE),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_END()
@@ -108,6 +157,10 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		if (argc != 2)
 			die(_("--write-terms requires two arguments"));
 		return write_terms(argv[0], argv[1]);
+	case BISECT_CLEAN_STATE:
+		if (argc != 0)
+			die(_("--bisect-clean-state requires no arguments"));
+		return bisect_clean_state();
 	default:
 		die("BUG: unknown subcommand '%d'", cmdmode);
 	}
diff --git a/git-bisect.sh b/git-bisect.sh
index cd39bd0..bbc57d2 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -187,7 +187,7 @@ bisect_start() {
 	#
 	# Get rid of any old bisect state.
 	#
-	bisect_clean_state || exit
+	git bisect--helper --bisect-clean-state || exit
 
 	#
 	# Change state.
@@ -196,7 +196,7 @@ bisect_start() {
 	# We have to trap this to be able to clean up using
 	# "bisect_clean_state".
 	#
-	trap 'bisect_clean_state' 0
+	trap 'git bisect--helper --bisect-clean-state' 0
 	trap 'exit 255' 1 2 3 15
 
 	#
@@ -430,27 +430,7 @@ bisect_reset() {
 		die "$(eval_gettext "Could not check out original HEAD '\$branch'.
 Try 'git bisect reset <commit>'.")"
 	fi
-	bisect_clean_state
-}
-
-bisect_clean_state() {
-	# There may be some refs packed during bisection.
-	git for-each-ref --format='%(refname) %(objectname)' refs/bisect/\* |
-	while read ref hash
-	do
-		git update-ref -d $ref $hash || exit
-	done
-	rm -f "$GIT_DIR/BISECT_EXPECTED_REV" &&
-	rm -f "$GIT_DIR/BISECT_ANCESTORS_OK" &&
-	rm -f "$GIT_DIR/BISECT_LOG" &&
-	rm -f "$GIT_DIR/BISECT_NAMES" &&
-	rm -f "$GIT_DIR/BISECT_RUN" &&
-	rm -f "$GIT_DIR/BISECT_TERMS" &&
-	# Cleanup head-name if it got left by an old version of git-bisect
-	rm -f "$GIT_DIR/head-name" &&
-	git update-ref -d --no-deref BISECT_HEAD &&
-	# clean up BISECT_START last
-	rm -f "$GIT_DIR/BISECT_START"
+	git bisect--helper --bisect-clean-state || exit
 }
 
 bisect_replay () {
-- 
2.9.0

