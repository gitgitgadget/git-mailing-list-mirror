Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SBL_CSS,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23B6420179
	for <e@80x24.org>; Sun, 26 Jun 2016 12:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752293AbcFZMZc (ORCPT <rfc822;e@80x24.org>);
	Sun, 26 Jun 2016 08:25:32 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36175 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752239AbcFZMZ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jun 2016 08:25:28 -0400
Received: by mail-pf0-f194.google.com with SMTP id i123so13388318pfg.3
        for <git@vger.kernel.org>; Sun, 26 Jun 2016 05:25:27 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=zrXiNx3XrR78BlfGp0P1Hd/ChbcI809DNC1WEI+nP4g=;
        b=DVl87XbzOSwaJCEk5yl5GlLsr4+PILjtB6hPg858LLInbMewULEzGlKnxjeAcEKw83
         0/qYZNBNMDpBRz5FcxIzB+Pj52VuTegjD8SObrO9anFCamJJue5f74tOvwbmS6UmW6qo
         kZdF/x4c640H9a7ZfN/D1ymP43IIHSsC0W0YVVnoJOZHQnKKLK50IhyjqxHv5filmaJ6
         sCOa+PKOI4/6vpYJyOFKdlKVIFpJDjpBtevNerfqAjDmVa6sJ7hOW0DgHZXXnsW9sJEA
         bJYNiROZdqSfOy7YaL9n9SzL5tlqi9vcsjk/GCiluXPdlzsa0SRpTOQQpYNpWishNBZC
         8D3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=zrXiNx3XrR78BlfGp0P1Hd/ChbcI809DNC1WEI+nP4g=;
        b=i4JVr8xhMERKNSjtmZy/DIAlXGsOCJzjl4E9dTA4o1J1xWRm+Bgr5TMWB4632zMEr0
         f7I7XCzbtJdOJ836yUahwmpgtSVuxnkzBHk2W7bC53w7ZZoee6cP74wNaJqoVVAs/DUi
         iQvdGYs/DiavCYm4ZtEmto9ZiLOMBhyug2wt810AOeXhLTvrx/QEEO5Blla6Fo1Zuqm/
         ZHRprAxlSXBHD7F5KGy3uP7KjtaqrpqXPTQmSKUIUhBaQN2yqLvV8BHEGuvwQvvKa4pc
         e6OU7wzlLZMhgUjJQzyrGrOKon/lQwurnZwTZ05HHXFfqJ+52YyWntaFdWdQf48OaGBy
         iphA==
X-Gm-Message-State: ALyK8tK9uiu47uzOm6CEUGmycBGthLsLUZjPn8uTjClyxvMRQEuIh84mqV+jhAQBhTK41w==
X-Received: by 10.98.207.4 with SMTP id b4mr24133881pfg.20.1466943926924;
        Sun, 26 Jun 2016 05:25:26 -0700 (PDT)
Received: from localhost.localdomain ([111.119.199.22])
        by smtp.gmail.com with ESMTPSA id e9sm4633670pfg.2.2016.06.26.05.25.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 26 Jun 2016 05:25:26 -0700 (PDT)
From:	Pranit Bauva <pranit.bauva@gmail.com>
To:	git@vger.kernel.org
Cc:	Pranit Bauva <pranit.bauva@gmail.com>, christian.couder@gmail.com,
	chriscool@tuxfamily.org, larsxschneider@gmail.com,
	sunshine@sunshineco.com
Subject: [PATCH v3 5/6] bisect--helper: `is_expected_rev` & `check_expected_revs` shell function in C
Date:	Sun, 26 Jun 2016 17:53:55 +0530
Message-Id: <20160626122356.28999-6-pranit.bauva@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160626122356.28999-1-pranit.bauva@gmail.com>
References: <20160626122356.28999-1-pranit.bauva@gmail.com>
In-Reply-To: <20160607205454.22576-1-pranit.bauva@gmail.com>
References: <20160607205454.22576-1-pranit.bauva@gmail.com>
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

