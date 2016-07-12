Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 989C420195
	for <e@80x24.org>; Tue, 12 Jul 2016 22:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752537AbcGLWjd (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 18:39:33 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:33957 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752247AbcGLWja (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2016 18:39:30 -0400
Received: by mail-pa0-f68.google.com with SMTP id hh10so1823765pac.1
        for <git@vger.kernel.org>; Tue, 12 Jul 2016 15:39:29 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BcQwqshhxYzQpbJaSsKdEwy69jlTRnD3w23UwOBDGB0=;
        b=TnENMtopG8rtzX3EjVQJUz3Di3UfRbAA+KFK+p1W2vFCMKrCtd1nMaDu5WhunbemtQ
         eyEsb0ntdxd+r53Ygv+fDV08gxn/VZkrg6fOETCj2Yafcl+6erRM3RHkeOgu/dlRH774
         0jcURXZ0MCbVjTQVKdS0ILFSU4+W8wVekw/1cJKC4r2m+dW0nhj25DV9jBmqvk3EnTvm
         +xiyuL4XgXKeGgUdae+tS0/vg4EAjGi79dEaqMMAuqTARYUbw3toouCOD30WbBjd1EGC
         pfvz7WnZ1LANiwk4asz63Qqjp5k4sGbwmqFHa2QSj5tpNA691tYySukpYOT+ju6Qdhhm
         H0uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BcQwqshhxYzQpbJaSsKdEwy69jlTRnD3w23UwOBDGB0=;
        b=Bz+55Y5ZO5GOeWMcJUUIuLqyltxCCgkMrcPc+sDzIE5bTSkMCh0aNrf20hAChIt0Ck
         6M1HAKwFKt8q0RKYJiesayQYBT0EowjAEVVvY9fy2jj5yQQ1m0gz7jII5pamg+LWcbmq
         75tphxV9NTyPafDG+VxdJNU7vRXfLtYcWpul1WY8s9Iczc/K0IYfd1HWOq9Y/LI0ILCZ
         l7p0rK21Ek5Kx1/QKj/7XVObFOP72Rl7lPVo5fAqYn8uQoRbsK2ZgfAhT+Vigw6GY3kM
         h15RzwcZqJ2KJfmm4L4x2UOznmDtsf3oq9bQEVi6/qcK/USs7K60rCFuBG25L4SqRcjY
         tZUA==
X-Gm-Message-State: ALyK8tIZXA9KP2nxxAscNjDBU2UhCjpNqM6RlMs5KEku1JHaiGZK28wLf7cIPXzt3T+6bA==
X-Received: by 10.66.146.69 with SMTP id ta5mr3336717pab.157.1468363149920;
        Tue, 12 Jul 2016 15:39:09 -0700 (PDT)
Received: from localhost.localdomain ([103.57.70.227])
        by smtp.gmail.com with ESMTPSA id g26sm6723796pfj.82.2016.07.12.15.39.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Jul 2016 15:39:09 -0700 (PDT)
From:	Pranit Bauva <pranit.bauva@gmail.com>
To:	gitster@pobox.com
Cc:	Pranit Bauva <pranit.bauva@gmail.com>, larsxschneider@gmail.com,
	christian.couder@gmail.com, chriscool@tuxfamily.org,
	git@vger.kernel.org
Subject: [PATCH 3/9] bisect--helper: `write_terms` shell function in C
Date:	Wed, 13 Jul 2016 04:05:32 +0530
Message-Id: <20160712223538.28508-4-pranit.bauva@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160712223538.28508-1-pranit.bauva@gmail.com>
References: <20160712223538.28508-1-pranit.bauva@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Reimplement the `write_terms` shell function in C and add a `write-terms`
subcommand to `git bisect--helper` to call it from git-bisect.sh . Also
remove the subcommand `--check-term-format` as it can now be called from
inside the function write_terms() C implementation.

Also `|| exit` is added when calling write-terms subcommand from
git-bisect.sh so as to exit whenever there is an error.

Using `--write-terms` subcommand is a temporary measure to port shell
function to C so as to use the existing test suite. As more functions
are ported, this subcommand will be retired and will be called by some
other method.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 builtin/bisect--helper.c | 36 +++++++++++++++++++++++++++++-------
 git-bisect.sh            | 22 +++++++---------------
 2 files changed, 36 insertions(+), 22 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 3c748d1..bec63d6 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -4,9 +4,11 @@
 #include "bisect.h"
 #include "refs.h"
 
+static GIT_PATH_FUNC(git_path_bisect_terms, "BISECT_TERMS")
+
 static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --next-all [--no-checkout]"),
-	N_("git bisect--helper --check-term-format <term> <orig_term>"),
+	N_("git bisect--helper --write-terms <bad_term> <good_term>"),
 	NULL
 };
 
@@ -56,18 +58,38 @@ static int check_term_format(const char *term, const char *orig_term)
 	return 0;
 }
 
+static int write_terms(const char *bad, const char *good)
+{
+	FILE *fp;
+	int res;
+
+	if (!strcmp(bad, good))
+		return error(_("please use two different terms"));
+
+	if (check_term_format(bad, "bad") || check_term_format(good, "good"))
+		return -1;
+
+	fp = fopen(git_path_bisect_terms(), "w");
+	if (!fp)
+		return error_errno(_("could not open the file BISECT_TERMS"));
+
+	res = fprintf(fp, "%s\n%s\n", bad, good);
+	fclose(fp);
+	return (res < 0) ? -1 : 0;
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
 		NEXT_ALL = 1,
-		CHECK_TERM_FMT
+		WRITE_TERMS
 	} cmdmode = 0;
 	int no_checkout = 0;
 	struct option options[] = {
 		OPT_CMDMODE(0, "next-all", &cmdmode,
 			 N_("perform 'git bisect next'"), NEXT_ALL),
-		OPT_CMDMODE(0, "check-term-format", &cmdmode,
-			 N_("check format of the term"), CHECK_TERM_FMT),
+		OPT_CMDMODE(0, "write-terms", &cmdmode,
+			 N_("write the terms to .git/BISECT_TERMS"), WRITE_TERMS),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_END()
@@ -82,10 +104,10 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	switch (cmdmode) {
 	case NEXT_ALL:
 		return bisect_next_all(prefix, no_checkout);
-	case CHECK_TERM_FMT:
+	case WRITE_TERMS:
 		if (argc != 2)
-			die(_("--check-term-format requires two arguments"));
-		return check_term_format(argv[0], argv[1]);
+			die(_("--write-terms requires two arguments"));
+		return write_terms(argv[0], argv[1]);
 	default:
 		die("BUG: unknown subcommand '%d'", cmdmode);
 	}
diff --git a/git-bisect.sh b/git-bisect.sh
index 7d7965d..cd39bd0 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -210,7 +210,7 @@ bisect_start() {
 	eval "$eval true" &&
 	if test $must_write_terms -eq 1
 	then
-		write_terms "$TERM_BAD" "$TERM_GOOD"
+		git bisect--helper --write-terms "$TERM_BAD" "$TERM_GOOD"
 	fi &&
 	echo "git bisect start$orig_args" >>"$GIT_DIR/BISECT_LOG" || exit
 	#
@@ -557,18 +557,6 @@ get_terms () {
 	fi
 }
 
-write_terms () {
-	TERM_BAD=$1
-	TERM_GOOD=$2
-	if test "$TERM_BAD" = "$TERM_GOOD"
-	then
-		die "$(gettext "please use two different terms")"
-	fi
-	git bisect--helper --check-term-format "$TERM_BAD" bad || exit
-	git bisect--helper --check-term-format "$TERM_GOOD" good || exit
-	printf '%s\n%s\n' "$TERM_BAD" "$TERM_GOOD" >"$GIT_DIR/BISECT_TERMS"
-}
-
 check_and_set_terms () {
 	cmd="$1"
 	case "$cmd" in
@@ -582,13 +570,17 @@ check_and_set_terms () {
 		bad|good)
 			if ! test -s "$GIT_DIR/BISECT_TERMS"
 			then
-				write_terms bad good
+				TERM_BAD=bad
+				TERM_GOOD=good
+				git bisect--helper --write-terms "$TERM_BAD" "$TERM_GOOD" || exit
 			fi
 			;;
 		new|old)
 			if ! test -s "$GIT_DIR/BISECT_TERMS"
 			then
-				write_terms new old
+				TERM_BAD=new
+				TERM_GOOD=old
+				git bisect--helper --write-terms "$TERM_BAD" "$TERM_GOOD" || exit
 			fi
 			;;
 		esac ;;
-- 
2.9.0

