Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SBL_CSS,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A27C20179
	for <e@80x24.org>; Sun, 26 Jun 2016 20:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751541AbcFZUqT (ORCPT <rfc822;e@80x24.org>);
	Sun, 26 Jun 2016 16:46:19 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:34210 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751508AbcFZUqT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jun 2016 16:46:19 -0400
Received: by mail-pa0-f68.google.com with SMTP id us13so13619459pab.1
        for <git@vger.kernel.org>; Sun, 26 Jun 2016 13:46:18 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wkpqiJmqjdTxuwYEbadN9j8WNDW+3yksz+cWdqTCj1s=;
        b=WfwOtYzwzHFOYxr3tnxxdcEkjXIpbcOhQSrSp8AspL9PDa86HrCyvPYp6r7HxuCtaq
         2oS6/AQ3bg3/D2Cw0BPNUzNNvG2ZLBTSABUXdPxPQ/uoL9dxkvYBaS/Fiw4M72UvBOqX
         q+x+/t0HCYaoU0/cQb7Mpofr+0e776YAie08zMM9nkKS94hX9GSzyI6fWXIxo7RZ2PmQ
         ayYhmu5PVow8pmy55+2uV9NH0AjUaUfTYczkMajKl/50cLmyioefXR+ktL22h1XLJcY5
         M52ybfWJwODCS8mkOp6VH7unzbQVgMioRlPonTdeRSq09dl5QCXW6cld6dYtTod5NJdi
         a3Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wkpqiJmqjdTxuwYEbadN9j8WNDW+3yksz+cWdqTCj1s=;
        b=KNsVAkD9TEmpu9I9m6BzOzQGYrFxjkxYiwhIfVwOLXbYpH6/gebKE7k600kZ5fdcHx
         Apci025OeVNHzpAQQdGUfEYpA8sNsIv0RjxP8ra/cptVziQvimXjimeAagjtqHdOxpJ1
         4j28jHHvjILsZAOYHOZItLCSAx6Zo5MrC+TjQ1ftyjzR/+4W3xSUqYa3eNaX2BwhdGev
         7lAN6BEJ0Bri4+XjWjMcTt2qOdlV+r59O5dKZbVk9kGHbgfQRpgXtQzYhLWTfFfQ4tKb
         Gj92GbIU+D+Vq2XWVGu+m+3tnmadPQG3MOFN0FNkFL5Wqm76IzjArovw/lvOffmV6xTi
         3gIg==
X-Gm-Message-State: ALyK8tK32QEOpeROvcXWctDbf93OgxruHWHlemIKYIytJ4Boms4etHn3QcN9XFYIlfocCw==
X-Received: by 10.66.253.168 with SMTP id ab8mr26870545pad.77.1466973978219;
        Sun, 26 Jun 2016 13:46:18 -0700 (PDT)
Received: from localhost.localdomain ([111.119.199.22])
        by smtp.gmail.com with ESMTPSA id ot2sm1591749pac.29.2016.06.26.13.46.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 26 Jun 2016 13:46:17 -0700 (PDT)
From:	Pranit Bauva <pranit.bauva@gmail.com>
To:	git@vger.kernel.org
Cc:	Pranit Bauva <pranit.bauva@gmail.com>, Matthie.Moy@grenoble-inp.fr,
	christian.couder@gmail.com, chriscool@tuxfamily.org,
	gitster@pobox.com
Subject: [RFC/PATCH 3/3] bisect--helper: `get_terms` & `bisect_terms` shell function in C
Date:	Mon, 27 Jun 2016 02:14:11 +0530
Message-Id: <20160626204411.19919-3-pranit.bauva@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160626204411.19919-1-pranit.bauva@gmail.com>
References: <20160626204411.19919-1-pranit.bauva@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Reimplement the `get_terms` and `bisect_terms` shell function in C and
add `bisect-terms` subcommand to `git bisect--helper` to call it from
git-bisect.sh .

Using `--bisect-terms` subcommand is a temporary measure to port shell
function in C so as to use the existing test suite. As more functions
are ported, this subcommand will be retired and will be called by some
other methods.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 builtin/bisect--helper.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++-
 git-bisect.sh            | 35 ++--------------------------------
 2 files changed, 50 insertions(+), 34 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 9a289a1..51a408c 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -359,6 +359,41 @@ static int bisect_next_check(const struct bisect_terms *state, const char *term)
 	return 0;
 }
 
+static int get_terms(struct bisect_terms *term)
+{
+	FILE *fp;
+	fp = fopen(git_path_bisect_write_terms(), "r");
+	if (!fp)
+		return -1;
+
+	bisect_terms_reinit(term);
+	if (strbuf_getline(&term->term_bad, fp) == EOF)
+		return -1;
+	if (strbuf_getline(&term->term_good, fp) == EOF)
+		return -1;
+	return 0;
+}
+
+static int bisect_terms(struct bisect_terms *term, const char *arg)
+{
+	if (get_terms(term)) {
+		fprintf(stderr, "no terms defined\n");
+		return -1;
+	}
+	if (!arg) {
+		printf("Your current terms are %s for the old state\nand "
+		       "%s for the new state.\n", term->term_good.buf,
+		       term->term_bad.buf);
+		return 0;
+	}
+	if (one_of(arg, "--term-good", "--term-old", NULL))
+		printf("%s\n", term->term_good.buf);
+	if (one_of(arg, "--term-bad", "--term-new", NULL))
+		printf("%s\n", term->term_bad.buf);
+
+	return 0;
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
@@ -369,7 +404,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		CHECK_EXPECTED_REVS,
 		BISECT_WRITE,
 		CHECK_AND_SET_TERMS,
-		BISECT_NEXT_CHECK
+		BISECT_NEXT_CHECK,
+		BISECT_TERMS
 	} cmdmode = 0;
 	int no_checkout = 0, res = 0;
 	struct option options[] = {
@@ -389,6 +425,12 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("check and set terms in a bisection state"), CHECK_AND_SET_TERMS),
 		OPT_CMDMODE(0, "bisect-next-check", &cmdmode,
 			 N_("check whether bad or good terms exist"), BISECT_NEXT_CHECK),
+		OPT_CMDMODE(0, "bisect-terms", &cmdmode,
+			 N_("print out the bisect terms"), BISECT_TERMS),
+		OPT_ARGUMENT("term-bad", "handle this in an individual function"),
+		OPT_ARGUMENT("term-good", "handle this in an individual function"),
+		OPT_ARGUMENT("term-new", "handle this in an individual function"),
+		OPT_ARGUMENT("term-old", "handle this in an individual function"),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_END()
@@ -450,6 +492,11 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		}
 		res = bisect_next_check(&state, argv[2]);
 		break;
+	case BISECT_TERMS:
+		if (argc != 0 && argc != 1)
+			die(_("--bisect-terms requires 0 or 1 argument"));
+		res = bisect_terms(&state, argc ? argv[0] : NULL);
+		break;
 	default:
 		die("BUG: unknown subcommand '%d'", cmdmode);
 	}
diff --git a/git-bisect.sh b/git-bisect.sh
index 51b0a6b..5723601 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -355,7 +355,7 @@ bisect_replay () {
 		"$TERM_GOOD"|"$TERM_BAD"|skip)
 			git bisect--helper --bisect-write "$command" "$rev" "$TERM_GOOD" "$TERM_BAD" || exit;;
 		terms)
-			bisect_terms $rev ;;
+			git bisect--helper --bisect-terms $rev ;;
 		*)
 			die "$(gettext "?? what are you talking about?")" ;;
 		esac
@@ -437,37 +437,6 @@ get_terms () {
 	fi
 }
 
-bisect_terms () {
-	get_terms
-	if ! test -s "$GIT_DIR/BISECT_TERMS"
-	then
-		die "$(gettext "no terms defined")"
-	fi
-	case "$#" in
-	0)
-		gettextln "Your current terms are $TERM_GOOD for the old state
-and $TERM_BAD for the new state."
-		;;
-	1)
-		arg=$1
-		case "$arg" in
-			--term-good|--term-old)
-				printf '%s\n' "$TERM_GOOD"
-				;;
-			--term-bad|--term-new)
-				printf '%s\n' "$TERM_BAD"
-				;;
-			*)
-				die "$(eval_gettext "invalid argument \$arg for 'git bisect terms'.
-Supported options are: --term-good|--term-old and --term-bad|--term-new.")"
-				;;
-		esac
-		;;
-	*)
-		usage ;;
-	esac
-}
-
 case "$#" in
 0)
 	usage ;;
@@ -498,7 +467,7 @@ case "$#" in
 	run)
 		bisect_run "$@" ;;
 	terms)
-		bisect_terms "$@" ;;
+		git bisect--helper --bisect-terms "$@" ;;
 	*)
 		usage ;;
 	esac
-- 
2.9.0

