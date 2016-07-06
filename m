Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDB532070C
	for <e@80x24.org>; Wed,  6 Jul 2016 20:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755571AbcGFU0o (ORCPT <rfc822;e@80x24.org>);
	Wed, 6 Jul 2016 16:26:44 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:34710 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751629AbcGFU0n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2016 16:26:43 -0400
Received: by mail-pa0-f68.google.com with SMTP id us13so21824439pab.1
        for <git@vger.kernel.org>; Wed, 06 Jul 2016 13:26:43 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M46uqrkFA4UMnQE2CW/dSqXE2jj9R8363aRBxtOmHOo=;
        b=MPwKiNZBWPlDJbgrvi6w9Y1+yZ40a/hEjZsNLwXvPVf4j2N4waXI+c1Vpi7hR7Z4UN
         wEXIgPXvA1M2wHD7BaZ+lxvKE7Gwa2Ug0/CS6vFalCZb+G0OtPxsKTYCxnWGMV8FjQfn
         Gb+dcLVaQTbK50xbTbaDAFoewwwLGDfK8acaBN0wSUMMZnjeD/AffHQ4uL+9gXPR3Sw8
         5ESq5VVM9Sa7RWL3WxWfLS+s/KwIH/6ZE7DtN6dbRrao5fTxA9xcAJeT/31vUc/BqzpG
         DA8TqUe4GEG9wwgtMi8+8bc9ZI2gZDjnnVGHQ76ptRp+1/CjEOJ+1NEjcRBCKcLuFw0U
         cOcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=M46uqrkFA4UMnQE2CW/dSqXE2jj9R8363aRBxtOmHOo=;
        b=Ejp40EbxPscrnxAVu5jApuIKcZLIuwr+2zhJvFeFWCprDWXNTo48cU9OnyU0go8OP5
         6CTHevo5/pAlUEvqFgKm9e/wHiK8Uj2zFTSQCXEaIrczffBa9eUa6pl2JQJnsoXOv/mZ
         iDn9RHjV7UedYt2veQi0fdKzrQYmNLqhez+Pz3Z3V3z2wWwz7ugrcYn5DCF9ZH4hE1aQ
         hheDe9QrymSsWdsv+Vb9FhRHDrSOs1eGxA0omdjzCSbCM1abjvIcfQbYzYQtmC65ADmG
         Yf4RVJWn/eob4fD3/9ogc80LT9IwpvQqV3Ob7WqcIE2w9aE3sD+ikWvxqt5hKz27oezs
         kpKw==
X-Gm-Message-State: ALyK8tJJjrbj46RvOD4mLwYm48Bkb+oMpX8ZPk3gDJPCQn4mPFe8XvlvuncmdDLH32URRg==
X-Received: by 10.66.51.137 with SMTP id k9mr24495419pao.49.1467836802754;
        Wed, 06 Jul 2016 13:26:42 -0700 (PDT)
Received: from localhost.localdomain ([27.106.54.176])
        by smtp.gmail.com with ESMTPSA id a87sm6272459pfc.63.2016.07.06.13.26.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 Jul 2016 13:26:41 -0700 (PDT)
From:	Pranit Bauva <pranit.bauva@gmail.com>
To:	git@vger.kernel.org
Cc:	Pranit Bauva <pranit.bauva@gmail.com>, larsxschneider@gmail.com,
	christian.couder@gmail.com, chriscool@tuxfamily.org,
	sunshine@sunshineco.com
Subject: [PATCH v4 1/6] bisect--helper: `bisect_clean_state` shell function in C
Date:	Thu,  7 Jul 2016 01:55:18 +0530
Message-Id: <20160706202523.9850-2-pranit.bauva@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160706202523.9850-1-pranit.bauva@gmail.com>
References: <20160626122356.28999-1-pranit.bauva@gmail.com>
 <20160706202523.9850-1-pranit.bauva@gmail.com>
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
index 91027b0..57fd4e9 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -3,12 +3,21 @@
 #include "parse-options.h"
 #include "bisect.h"
 #include "refs.h"
+#include "dir.h"
 
 static GIT_PATH_FUNC(git_path_bisect_write_terms, "BISECT_TERMS")
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
+	remove_path(git_path_bisect_write_terms());
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

