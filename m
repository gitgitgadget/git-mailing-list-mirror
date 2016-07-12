Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B8B820195
	for <e@80x24.org>; Tue, 12 Jul 2016 22:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752559AbcGLWju (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 18:39:50 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33422 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752554AbcGLWjs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2016 18:39:48 -0400
Received: by mail-pf0-f194.google.com with SMTP id i6so1570611pfe.0
        for <git@vger.kernel.org>; Tue, 12 Jul 2016 15:39:33 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rshTJyelOuWs2GNAbB0JDeO+4l/0V3AV6Y6B94logn8=;
        b=GBZo4ZBmfR1YpqNdIfcxzSJk+tGm054YXTIKiWlYHe4oTiXHBswx/28BCtlSJlaqim
         MBz1j8Hcf1+1+STDxq+NaW6PXIBCZvRaCEgs2NxzhPvoSe9CEws8EoJDtyaccxChCDef
         OB1/y8HdW4BkoPKwGboqt1sh29XDX9zA0LCJRwvdK9jRkIv9ePkKYCKBcVhFQSarwY+R
         8A4/hswKKj8Zotur+le64cr+0uauU3WNc1p+xI4ilbkfItc+CTMdNMRq/nSA+Vj/0o8k
         rJOkiP5i5B09TWNP7ZA+Z1RPej8Lo0iEjCfX1la89/HVGF+u2QagZNQrCQEhWh96yvh8
         nuhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rshTJyelOuWs2GNAbB0JDeO+4l/0V3AV6Y6B94logn8=;
        b=cJOzSl7De5DqmFNRAOD7LMfXFTzbV5Ih/HWaRK2ju8KYpauJ9Cg0eaz4u8uibEpqDN
         alo7XEM4t23qlWFKIOo6XDcJ+2DcOcsWbQ9vffQ69ERFfd4fXa42vCI5PJICMDE7bK1A
         wpLPRx/fopctozNoDYPV23YXtukhoMyAWsQZsA8MqlkF1jSUcax9DZPrhRjPiv4fI/Xo
         L/POvmLhfIIDwdSxlo10YnMJT3ZJ4ZkvGPCzaqUbNdUqkxjxmB3ZpcOEHghb2ngYiKwc
         gYjXOOWE/OcAcO+BpZTmhOyV8XTqDNpFYjeQZB6NhpDMg5qCE/BSHHu0pJq3R4U0rIJ+
         affg==
X-Gm-Message-State: ALyK8tL0E3MbhFyEg32TdjDZoTr7jL9vKcFNDIjewZKpJzG7g+FzwiOsN3oNoUDU+SGHKA==
X-Received: by 10.98.13.206 with SMTP id 75mr49541615pfn.161.1468363167269;
        Tue, 12 Jul 2016 15:39:27 -0700 (PDT)
Received: from localhost.localdomain ([103.57.70.227])
        by smtp.gmail.com with ESMTPSA id g26sm6723796pfj.82.2016.07.12.15.39.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Jul 2016 15:39:26 -0700 (PDT)
From:	Pranit Bauva <pranit.bauva@gmail.com>
To:	gitster@pobox.com
Cc:	Pranit Bauva <pranit.bauva@gmail.com>, larsxschneider@gmail.com,
	christian.couder@gmail.com, chriscool@tuxfamily.org,
	git@vger.kernel.org
Subject: [PATCH 9/9] bisect--helper: `bisect_write` shell function in C
Date:	Wed, 13 Jul 2016 04:05:38 +0530
Message-Id: <20160712223538.28508-10-pranit.bauva@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160712223538.28508-1-pranit.bauva@gmail.com>
References: <20160712223538.28508-1-pranit.bauva@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Reimplement the `bisect_write` shell function in C and add a
`bisect-write` subcommand to `git bisect--helper` to call it from
git-bisect.sh

Using `--bisect-write` subcommand is a temporary measure to port shell
function in C so as to use the existing test suite. As more functions
are ported, this subcommand will be retired and will be called by some
other methods.

Note: bisect_write() uses two variables namely TERM_GOOD and TERM_BAD
from the global shell script thus we need to pass it to the subcommand
using the arguments. We then store them in a struct bisect_terms and
pass the memory address around functions.

This patch also introduces new methods namely bisect_state_init() and
bisect_terms_release() for easy memory management for the struct
bisect_terms.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 builtin/bisect--helper.c | 97 ++++++++++++++++++++++++++++++++++++++++++++----
 git-bisect.sh            | 25 ++-----------
 2 files changed, 94 insertions(+), 28 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 88b5d0a..88a1df8 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -22,9 +22,27 @@ static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --write-terms <bad_term> <good_term>"),
 	N_("git bisect--helper --bisect-clean-state"),
 	N_("git bisect--helper --bisect-reset [<commit>]"),
+	N_("git bisect--helper --bisect-write <state> <revision> <TERM_GOOD> <TERM_BAD> [<nolog>]"),
 	NULL
 };
 
+struct bisect_terms {
+	struct strbuf term_good;
+	struct strbuf term_bad;
+};
+
+static void bisect_terms_init(struct bisect_terms *terms)
+{
+	strbuf_init(&terms->term_good, 0);
+	strbuf_init(&terms->term_bad, 0);
+}
+
+static void bisect_terms_release(struct bisect_terms *terms)
+{
+	strbuf_release(&terms->term_good);
+	strbuf_release(&terms->term_bad);
+}
+
 /*
  * Check whether the string `term` belongs to the set of strings
  * included in the variable arguments.
@@ -188,6 +206,52 @@ static int check_expected_revs(const char **revs, int rev_nr)
 	return 0;
 }
 
+static int bisect_write(const char *state, const char *rev,
+			const struct bisect_terms *terms, int nolog)
+{
+	struct strbuf tag = STRBUF_INIT;
+	struct strbuf commit_name = STRBUF_INIT;
+	struct object_id oid;
+	struct commit *commit;
+	struct pretty_print_context pp = {0};
+	FILE *fp;
+
+	if (!strcmp(state, terms->term_bad.buf))
+		strbuf_addf(&tag, "refs/bisect/%s", state);
+	else if(one_of(state, terms->term_good.buf, "skip", NULL))
+		strbuf_addf(&tag, "refs/bisect/%s-%s", state, rev);
+	else
+		return error(_("Bad bisect_write argument: %s"), state);
+
+	if (get_oid(rev, &oid)) {
+		strbuf_release(&tag);
+		return error(_("couldn't get the oid of the rev '%s'"), rev);
+	}
+
+	if (update_ref(NULL, tag.buf, oid.hash, NULL, 0,
+		       UPDATE_REFS_MSG_ON_ERR)) {
+		strbuf_release(&tag);
+		return -1;
+	}
+	strbuf_release(&tag);
+
+	fp = fopen(git_path_bisect_log(), "a");
+	if (!fp)
+		return error_errno(_("couldn't open the file '%s'"), git_path_bisect_log());
+
+	commit = lookup_commit_reference(oid.hash);
+	format_commit_message(commit, "%s", &commit_name, &pp);
+	fprintf(fp, "# %s: [%s] %s\n", state, sha1_to_hex(oid.hash),
+		commit_name.buf);
+	strbuf_release(&commit_name);
+
+	if (!nolog)
+		fprintf(fp, "git bisect %s %s\n", state, rev);
+
+	fclose(fp);
+	return 0;
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
@@ -195,9 +259,10 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		WRITE_TERMS,
 		BISECT_CLEAN_STATE,
 		BISECT_RESET,
-		CHECK_EXPECTED_REVS
+		CHECK_EXPECTED_REVS,
+		BISECT_WRITE
 	} cmdmode = 0;
-	int no_checkout = 0;
+	int no_checkout = 0, res = 0;
 	struct option options[] = {
 		OPT_CMDMODE(0, "next-all", &cmdmode,
 			 N_("perform 'git bisect next'"), NEXT_ALL),
@@ -209,10 +274,14 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("reset the bisection state"), BISECT_RESET),
 		OPT_CMDMODE(0, "check-expected-revs", &cmdmode,
 			 N_("check for expected revs"), CHECK_EXPECTED_REVS),
+		OPT_CMDMODE(0, "bisect-write", &cmdmode,
+			 N_("write out the bisection state in BISECT_LOG"), BISECT_WRITE),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_END()
 	};
+	struct bisect_terms terms;
+	bisect_terms_init(&terms);
 
 	argc = parse_options(argc, argv, prefix, options,
 			     git_bisect_helper_usage, 0);
@@ -221,24 +290,38 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		usage_with_options(git_bisect_helper_usage, options);
 
 	switch (cmdmode) {
+	int nolog;
 	case NEXT_ALL:
 		return bisect_next_all(prefix, no_checkout);
 	case WRITE_TERMS:
 		if (argc != 2)
 			die(_("--write-terms requires two arguments"));
-		return write_terms(argv[0], argv[1]);
+		res = write_terms(argv[0], argv[1]);
+		break;
 	case BISECT_CLEAN_STATE:
 		if (argc != 0)
 			die(_("--bisect-clean-state requires no arguments"));
-		return bisect_clean_state();
+		res = bisect_clean_state();
+		break;
 	case BISECT_RESET:
 		if (argc > 1)
 			die(_("--bisect-reset requires either zero or one arguments"));
-		return bisect_reset(argc ? argv[0] : NULL);
+		res = bisect_reset(argc ? argv[0] : NULL);
+		break;
 	case CHECK_EXPECTED_REVS:
-		return check_expected_revs(argv, argc);
+		res = check_expected_revs(argv, argc);
+		break;
+	case BISECT_WRITE:
+		if (argc != 4 && argc != 5)
+			die(_("--bisect-write requires either 4 or 5 arguments"));
+		nolog = (argc == 5) && !strcmp(argv[4], "nolog");
+		strbuf_addstr(&terms.term_good, argv[2]);
+		strbuf_addstr(&terms.term_bad, argv[3]);
+		res = bisect_write(argv[0], argv[1], &terms, nolog);
+		break;
 	default:
 		die("BUG: unknown subcommand '%d'", cmdmode);
 	}
-	return 0;
+	bisect_terms_release(&terms);
+	return res;
 }
diff --git a/git-bisect.sh b/git-bisect.sh
index 4f6545e..b9896a4 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -145,7 +145,7 @@ bisect_start() {
 		0) state=$TERM_BAD ; bad_seen=1 ;;
 		*) state=$TERM_GOOD ;;
 		esac
-		eval="$eval bisect_write '$state' '$rev' 'nolog' &&"
+		eval="$eval git bisect--helper --bisect-write '$state' '$rev' '$TERM_GOOD' '$TERM_BAD' 'nolog' &&"
 	done
 	#
 	# Verify HEAD.
@@ -221,23 +221,6 @@ bisect_start() {
 	trap '-' 0
 }
 
-bisect_write() {
-	state="$1"
-	rev="$2"
-	nolog="$3"
-	case "$state" in
-		"$TERM_BAD")
-			tag="$state" ;;
-		"$TERM_GOOD"|skip)
-			tag="$state"-"$rev" ;;
-		*)
-			die "$(eval_gettext "Bad bisect_write argument: \$state")" ;;
-	esac
-	git update-ref "refs/bisect/$tag" "$rev" || exit
-	echo "# $state: $(git show-branch $rev)" >>"$GIT_DIR/BISECT_LOG"
-	test -n "$nolog" || echo "git bisect $state $rev" >>"$GIT_DIR/BISECT_LOG"
-}
-
 bisect_skip() {
 	all=''
 	for arg in "$@"
@@ -263,7 +246,7 @@ bisect_state() {
 	1,"$TERM_BAD"|1,"$TERM_GOOD"|1,skip)
 		rev=$(git rev-parse --verify $(bisect_head)) ||
 			die "$(gettext "Bad rev input: $(bisect_head)")"
-		bisect_write "$state" "$rev"
+		git bisect--helper --bisect-write "$state" "$rev" "$TERM_GOOD" "$TERM_BAD" || exit
 		git bisect--helper --check-expected-revs "$rev" ;;
 	2,"$TERM_BAD"|*,"$TERM_GOOD"|*,skip)
 		shift
@@ -276,7 +259,7 @@ bisect_state() {
 		done
 		for rev in $hash_list
 		do
-			bisect_write "$state" "$rev"
+			git bisect--helper --bisect-write "$state" "$rev" "$TERM_GOOD" "$TERM_BAD" || exit
 		done
 		git bisect--helper --check-expected-revs $hash_list ;;
 	*,"$TERM_BAD")
@@ -413,7 +396,7 @@ bisect_replay () {
 			cmd="bisect_start $rev"
 			eval "$cmd" ;;
 		"$TERM_GOOD"|"$TERM_BAD"|skip)
-			bisect_write "$command" "$rev" ;;
+			git bisect--helper --bisect-write "$command" "$rev" "$TERM_GOOD" "$TERM_BAD" || exit;;
 		terms)
 			bisect_terms $rev ;;
 		*)
-- 
2.9.0

