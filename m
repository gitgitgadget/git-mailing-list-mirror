Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EE312070C
	for <e@80x24.org>; Wed,  6 Jul 2016 20:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755792AbcGFU07 (ORCPT <rfc822;e@80x24.org>);
	Wed, 6 Jul 2016 16:26:59 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:34905 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755787AbcGFU05 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2016 16:26:57 -0400
Received: by mail-pa0-f68.google.com with SMTP id dx3so5197546pab.2
        for <git@vger.kernel.org>; Wed, 06 Jul 2016 13:26:56 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zrXiNx3XrR78BlfGp0P1Hd/ChbcI809DNC1WEI+nP4g=;
        b=x0tj6Fu1d8qdRrZBml3u+vJUBzfURVwQYPqOREOuTgWpbGB9+l6H//PUy+F2pEfsU0
         fBY6pp7BccAHllWm7l5vlvA03PI9K3HbNM60OUlQGsJRDPaE4mhEIcnGPk6rgMWT7VUq
         saesdXC34Z2TdMsURjmlUN+Fwu3DrXiHjsjUrQvWY4GEHLXt12hjC856ym/cRNYL9SKX
         +njjUw1w/NKR57hMpxMka39EPkXplZFPjMbT3eGtBLxKdky5VkwKTUybVyw45Z7LcTF3
         EqODK5UnP/T3EXKy7ShE6YW+HnnUJ9p5B6vQDL8SYe8Hsuu761Gv/tGGpY6zgPkSvkWg
         mYug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zrXiNx3XrR78BlfGp0P1Hd/ChbcI809DNC1WEI+nP4g=;
        b=YfM29nZcjEdojbWYLJ62kUAebcu/AnZ4Z3PG5LipMcYk3W3AUfAEWysT/5YFLNT5i0
         iegJS2VsvVBFp9yLhp/d9Cpwi7FY+olvI4PPqIuoWpK8sfNNXsCnRgksLUjgH916arLD
         VbaKMoxQ6ArDyW9aVnbQvtS1eiMuxFy0kmaxQHVzfEacjl2zbTdMDAy/g0ute/LdEjdJ
         hnLaR3obhT5YOEHiUOghMBQ489QJ1Jzir7YbvBpCrV9/SmaFtXMHUpXAwSf/EPjNUg8a
         RaM7phDq8jku4vgw0O42qEnBIKHm4vr3FdeHi5FLch1Pke8ANUW8fdXmLsANgaQnNAdB
         6L0w==
X-Gm-Message-State: ALyK8tIWLTOYHpMbxUZVEJU2Grh7Yu0poTpRqqWDrEVPcRQvO8AfjIaE/TIEhX05lTDEcA==
X-Received: by 10.67.11.104 with SMTP id eh8mr6664031pad.9.1467836816216;
        Wed, 06 Jul 2016 13:26:56 -0700 (PDT)
Received: from localhost.localdomain ([27.106.54.176])
        by smtp.gmail.com with ESMTPSA id a87sm6272459pfc.63.2016.07.06.13.26.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 Jul 2016 13:26:55 -0700 (PDT)
From:	Pranit Bauva <pranit.bauva@gmail.com>
To:	git@vger.kernel.org
Cc:	Pranit Bauva <pranit.bauva@gmail.com>, larsxschneider@gmail.com,
	christian.couder@gmail.com, chriscool@tuxfamily.org,
	sunshine@sunshineco.com
Subject: [PATCH v4 5/6] bisect--helper: `is_expected_rev` & `check_expected_revs` shell function in C
Date:	Thu,  7 Jul 2016 01:55:22 +0530
Message-Id: <20160706202523.9850-6-pranit.bauva@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160706202523.9850-1-pranit.bauva@gmail.com>
References: <20160626122356.28999-1-pranit.bauva@gmail.com>
 <20160706202523.9850-1-pranit.bauva@gmail.com>
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
index 96f6b65..96de65a 100644
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

