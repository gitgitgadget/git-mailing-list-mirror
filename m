Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2701E20196
	for <e@80x24.org>; Tue, 12 Jul 2016 22:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752553AbcGLWjq (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 18:39:46 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:36237 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752542AbcGLWjn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2016 18:39:43 -0400
Received: by mail-pa0-f68.google.com with SMTP id ib6so1822248pad.3
        for <git@vger.kernel.org>; Tue, 12 Jul 2016 15:39:43 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dVtUnEW0aP/PSHjjgshejX2p76FmPS+Im8dr8BpSLvE=;
        b=rUaKG4wct226HL3YqAdc9QEQwZAij/aFqcwdgY9/LuiuJK1jfWhd4UyRIeWWt7IVD5
         ymxUlWXh8PIb1EdwmuFsKgaB9ajNEWzyn0RNqblj2BW03lhdKN0ofP0JF/WWT68+Bl8C
         TJuUofMHxOkD0aeRa/ut2n4638NkL0dszrtj00QCgA6gPT00msYdnbhdHe4uvXnxB1h6
         2dPMU501XVIdFWURNQVKGPC0/ZX0OVp1nJMEdyforS7G2AmrGiPNOAww48K61ixcA6oI
         h1hSJA0DOFNyJ0HcciYFbRL0BY7I09OLMybPto7a7VOx4VH/lzPkAZ8ngNU5NMXKSsC5
         ixMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dVtUnEW0aP/PSHjjgshejX2p76FmPS+Im8dr8BpSLvE=;
        b=f/NIxiJ4+HlsBXBagcl6KwgQbXc2KCNT2NnOAgOUKKZiMdgfw0L2WDGqtCv0aYejtB
         Npe7Q3Gr1WtxGhAuWyNoofkz328vXS1xYcPx+xigznTnNmdsDzoX2jrou9n0e7IWrWvj
         sjtEQUvXfnNzs+T7q3W6tJQwvPMNpKnIn6lavFqxHbheRgZ97kkEvRNurXWcGgysC0HB
         fHPUrV5qK0uwKd4TCCmNAH27X7meVL2BsuqctuKyXMjyLN67mNylwkV8rd7zFuQuv8/Z
         pVPrkk04jdExkcj3HKXWaJN4AjhLPIufrK7rCC12VrvAYs0gHAbymWivBDPSKnFovPJ2
         ABWA==
X-Gm-Message-State: ALyK8tJY/21QI/rQcknPEO3w0YUg4pTH4mVl/P/O0FRnS5Av/dcy+k6gYBFObgGG0mAhAw==
X-Received: by 10.66.80.2 with SMTP id n2mr8094979pax.134.1468363163912;
        Tue, 12 Jul 2016 15:39:23 -0700 (PDT)
Received: from localhost.localdomain ([103.57.70.227])
        by smtp.gmail.com with ESMTPSA id g26sm6723796pfj.82.2016.07.12.15.39.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Jul 2016 15:39:23 -0700 (PDT)
From:	Pranit Bauva <pranit.bauva@gmail.com>
To:	gitster@pobox.com
Cc:	Pranit Bauva <pranit.bauva@gmail.com>, larsxschneider@gmail.com,
	christian.couder@gmail.com, chriscool@tuxfamily.org,
	git@vger.kernel.org
Subject: [PATCH 8/9] bisect--helper: `is_expected_rev` & `check_expected_revs` shell function in C
Date:	Wed, 13 Jul 2016 04:05:37 +0530
Message-Id: <20160712223538.28508-9-pranit.bauva@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160712223538.28508-1-pranit.bauva@gmail.com>
References: <20160712223538.28508-1-pranit.bauva@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Reimplement `is_expected_rev` & `check_expected_revs` shell function in
C and add a `--check-expected-revs` subcommand to `git bisect--helper` to
call it from git-bisect.sh .

Using `--check-expected-revs` subcommand is a temporary measure to port
shell functions to C so as to use the existing test suite. As more
functions are ported, this subcommand would be retired and will be
called by some other method.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 builtin/bisect--helper.c | 33 ++++++++++++++++++++++++++++++++-
 git-bisect.sh            | 20 ++------------------
 2 files changed, 34 insertions(+), 19 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 636044a..88b5d0a 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -162,13 +162,40 @@ static int bisect_reset(const char *commit)
 	return bisect_clean_state();
 }
 
+static int is_expected_rev(const char *expected_hex)
+{
+	struct strbuf actual_hex = STRBUF_INIT;
+	int res = 0;
+	if (strbuf_read_file(&actual_hex, git_path_bisect_expected_rev(), 0) >= 0) {
+		strbuf_trim(&actual_hex);
+		res = !strcmp(actual_hex.buf, expected_hex);
+	}
+	strbuf_release(&actual_hex);
+	return res;
+}
+
+static int check_expected_revs(const char **revs, int rev_nr)
+{
+	int i;
+
+	for (i = 0; i < rev_nr; i++) {
+		if (!is_expected_rev(revs[i])) {
+			remove_path(git_path_bisect_ancestors_ok());
+			remove_path(git_path_bisect_expected_rev());
+			return 0;
+		}
+	}
+	return 0;
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
 		NEXT_ALL = 1,
 		WRITE_TERMS,
 		BISECT_CLEAN_STATE,
-		BISECT_RESET
+		BISECT_RESET,
+		CHECK_EXPECTED_REVS
 	} cmdmode = 0;
 	int no_checkout = 0;
 	struct option options[] = {
@@ -180,6 +207,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("cleanup the bisection state"), BISECT_CLEAN_STATE),
 		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
 			 N_("reset the bisection state"), BISECT_RESET),
+		OPT_CMDMODE(0, "check-expected-revs", &cmdmode,
+			 N_("check for expected revs"), CHECK_EXPECTED_REVS),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_END()
@@ -206,6 +235,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		if (argc > 1)
 			die(_("--bisect-reset requires either zero or one arguments"));
 		return bisect_reset(argc ? argv[0] : NULL);
+	case CHECK_EXPECTED_REVS:
+		return check_expected_revs(argv, argc);
 	default:
 		die("BUG: unknown subcommand '%d'", cmdmode);
 	}
diff --git a/git-bisect.sh b/git-bisect.sh
index 18580b7..4f6545e 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -238,22 +238,6 @@ bisect_write() {
 	test -n "$nolog" || echo "git bisect $state $rev" >>"$GIT_DIR/BISECT_LOG"
 }
 
-is_expected_rev() {
-	test -f "$GIT_DIR/BISECT_EXPECTED_REV" &&
-	test "$1" = $(cat "$GIT_DIR/BISECT_EXPECTED_REV")
-}
-
-check_expected_revs() {
-	for _rev in "$@"; do
-		if ! is_expected_rev "$_rev"
-		then
-			rm -f "$GIT_DIR/BISECT_ANCESTORS_OK"
-			rm -f "$GIT_DIR/BISECT_EXPECTED_REV"
-			return
-		fi
-	done
-}
-
 bisect_skip() {
 	all=''
 	for arg in "$@"
@@ -280,7 +264,7 @@ bisect_state() {
 		rev=$(git rev-parse --verify $(bisect_head)) ||
 			die "$(gettext "Bad rev input: $(bisect_head)")"
 		bisect_write "$state" "$rev"
-		check_expected_revs "$rev" ;;
+		git bisect--helper --check-expected-revs "$rev" ;;
 	2,"$TERM_BAD"|*,"$TERM_GOOD"|*,skip)
 		shift
 		hash_list=''
@@ -294,7 +278,7 @@ bisect_state() {
 		do
 			bisect_write "$state" "$rev"
 		done
-		check_expected_revs $hash_list ;;
+		git bisect--helper --check-expected-revs $hash_list ;;
 	*,"$TERM_BAD")
 		die "$(eval_gettext "'git bisect \$TERM_BAD' can take only one argument.")" ;;
 	*)
-- 
2.9.0

