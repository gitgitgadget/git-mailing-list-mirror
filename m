Return-Path: <SRS0=bfGv=CG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668A4C433E6
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 12:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DE2E20872
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 12:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FnNoAjIv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729414AbgH1MsP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Aug 2020 08:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729416AbgH1MrW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Aug 2020 08:47:22 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D16C061235
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 05:47:18 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id q9so816910wmj.2
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 05:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NqJAa24aXt7XkNFoKLAjRUSlD+KeojnIECQGhM640xQ=;
        b=FnNoAjIv2So5MC8H5yj8BPzpbF20RM2BfYbrfxsLI5BWtOU/p24zYTwD5UxDYaicpB
         ITUJPX9pPVYKIA6L1GHL/n5eOPCNGxLsqiwn2Yg4PsEDCLUYPNdR82LAP+7Al1+ZLnUd
         nYJnZ8NMGwfY0hglscppxz2ZHwubnz7DAa9IWw+v7vgYRi5Ul47mQL4O6EWmUpVzq05j
         KqUjdcr+3ZZa6Q+69k0yqWl/+NNalXpSZ/WLJ1v03+JRlPAbs60NUCqeJJnQq2+CyYYB
         23Kig7pNnMMstQhH3YHcXAW+QlwhjbcriCRyyw9i1Y9OKPqtJn1yZn0CKHlXw20dYEdi
         PqTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NqJAa24aXt7XkNFoKLAjRUSlD+KeojnIECQGhM640xQ=;
        b=GCURFhDqUySqZ9Y29ylq76sn4tAn3lfFJ3LeYZr6mNXu/tafgSPrpCMduhvEK5Dleg
         fQsA6r5LOoaLjfd0St9jMGoHAzei8nn+l4TRX0W5hmx/x1NtCwYL/0KDlT3f9Er5Aehn
         VDSorjimamsz08Z+WtT8cQ0mxZY2mGX45wSsKurFs/2qOOO1t40MoFa6fESLQCqFyEHH
         H/g/2t93rMfUG6FSsdFCY1o9nbA7d0EszcOEte6dImzXhbO2o7Js3bNRelN7Tin/OqQu
         E1gdcrf/3sSCxXR6ZgkVRlznSiB8lc6nCDs7e7p9KbYP/XRO842MKxMXO7S0AtY5lltn
         yFOA==
X-Gm-Message-State: AOAM53251KOGY5MIpPspdiFq8mxmH1GBvzWJ9AsTwN5dVq3PvJxoLXwn
        dktGwkakf/fQuGeaU8Rwx2nY3XlOOGc=
X-Google-Smtp-Source: ABdhPJysCnCdLQslGluf6rL4FfsL1fMFxEUwpLlndWMvQN2OspcYTaxBLr9pYvco81reNPzfiI/yhg==
X-Received: by 2002:a7b:cb47:: with SMTP id v7mr1468199wmj.36.1598618837071;
        Fri, 28 Aug 2020 05:47:17 -0700 (PDT)
Received: from localhost.localdomain ([178.237.236.228])
        by smtp.gmail.com with ESMTPSA id o66sm2176878wmb.27.2020.08.28.05.47.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Aug 2020 05:47:16 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v6 06/13] bisect--helper: reimplement `bisect_next` and `bisect_auto_next` shell functions in C
Date:   Fri, 28 Aug 2020 14:46:10 +0200
Message-Id: <20200828124617.60618-7-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200828124617.60618-1-mirucam@gmail.com>
References: <20200828124617.60618-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

Reimplement the `bisect_next()` and the `bisect_auto_next()` shell functions
in C and add the subcommands to `git bisect--helper` to call them from
git-bisect.sh .

bisect_auto_next() function returns an enum bisect_error type as whole
`git bisect` can exit with an error code when bisect_next() does.

Using `--bisect-next` and `--bisect-auto-next` subcommands is a
temporary measure to port shell function to C so as to use the existing
test suite. As more functions are ported, `--bisect-auto-next`
subcommand will be retired and will be called by some other methods.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 bisect.c                 |   6 ++
 builtin/bisect--helper.c | 183 ++++++++++++++++++++++++++++++++++++++-
 git-bisect.sh            |  47 +---------
 3 files changed, 190 insertions(+), 46 deletions(-)

diff --git a/bisect.c b/bisect.c
index c6aba2b9f2..f0fca5c6f3 100644
--- a/bisect.c
+++ b/bisect.c
@@ -988,6 +988,12 @@ void read_bisect_terms(const char **read_bad, const char **read_good)
  * the bisection process finished successfully.
  * In this case the calling function or command should not turn a
  * BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND return code into an error or a non zero exit code.
+ *
+ * Checking BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND
+ * in bisect_helper::bisect_next() and only transforming it to 0 at
+ * the end of bisect_helper::cmd_bisect__helper() helps bypassing
+ * all the code related to finding a commit to test.
+ *
  * If no_checkout is non-zero, the bisection process does not
  * checkout the trial commit but instead simply updates BISECT_HEAD.
  */
diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index f71e8e54d2..5d443829e0 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -8,6 +8,7 @@
 #include "run-command.h"
 #include "prompt.h"
 #include "quote.h"
+#include "revision.h"
 
 static GIT_PATH_FUNC(git_path_bisect_terms, "BISECT_TERMS")
 static GIT_PATH_FUNC(git_path_bisect_expected_rev, "BISECT_EXPECTED_REV")
@@ -29,10 +30,17 @@ static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-terms [--term-good | --term-old | --term-bad | --term-new]"),
 	N_("git bisect--helper --bisect-start [--term-{old,good}=<term> --term-{new,bad}=<term>]"
 					    " [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<paths>...]"),
+	N_("git bisect--helper --bisect-next"),
+	N_("git bisect--helper --bisect-auto-next"),
 	N_("git bisect--helper --bisect-autostart"),
 	NULL
 };
 
+struct add_bisect_ref_data {
+	struct rev_info *revs;
+	unsigned int object_flags;
+};
+
 struct bisect_terms {
 	char *term_good;
 	char *term_bad;
@@ -56,6 +64,8 @@ static void set_terms(struct bisect_terms *terms, const char *bad,
 static const char vocab_bad[] = "bad|new";
 static const char vocab_good[] = "good|old";
 
+static int bisect_autostart(struct bisect_terms *terms);
+
 /*
  * Check whether the string `term` belongs to the set of strings
  * included in the variable arguments.
@@ -80,7 +90,7 @@ static int write_in_file(const char *path, const char *mode, const char *format,
 	FILE *fp = NULL;
 	int res = 0;
 
-	if (strcmp(mode, "w"))
+	if (strcmp(mode, "w") && strcmp(mode, "a"))
 		BUG("write-in-file does not support '%s' mode", mode);
 	fp = fopen(path, mode);
 	if (!fp)
@@ -109,6 +119,18 @@ static int write_to_file(const char *path, const char *format, ...)
 	return res;
 }
 
+static int append_to_file(const char *path, const char *format, ...)
+{
+	int res;
+	va_list args;
+
+	va_start(args, format);
+	res = write_in_file(path, "a", format, args);
+	va_end(args);
+
+	return res;
+}
+
 static int check_term_format(const char *term, const char *orig_term)
 {
 	int res;
@@ -451,6 +473,143 @@ static int bisect_append_log_quoted(const char **argv)
 	return res;
 }
 
+static int add_bisect_ref(const char *refname, const struct object_id *oid,
+			  int flags, void *cb)
+{
+	struct add_bisect_ref_data *data = cb;
+
+	add_pending_oid(data->revs, refname, oid, data->object_flags);
+
+	return 0;
+}
+
+static int prepare_revs(struct bisect_terms *terms, struct rev_info *revs)
+{
+	int res = 0;
+	struct add_bisect_ref_data cb = { revs };
+	char *good = xstrfmt("%s-*", terms->term_good);
+
+	/*
+	 * We cannot use terms->term_bad directly in
+	 * for_each_glob_ref_in() and we have to append a '*' to it,
+	 * otherwise for_each_glob_ref_in() will append '/' and '*'.
+	 */
+	char *bad = xstrfmt("%s*", terms->term_bad);
+
+	/*
+	 * It is important to reset the flags used by revision walks
+	 * as the previous call to bisect_next_all() in turn
+	 * sets up a revision walk.
+	 */
+	reset_revision_walk();
+	init_revisions(revs, NULL);
+	setup_revisions(0, NULL, revs, NULL);
+	for_each_glob_ref_in(add_bisect_ref, bad, "refs/bisect/", &cb);
+	cb.object_flags = UNINTERESTING;
+	for_each_glob_ref_in(add_bisect_ref, good, "refs/bisect/", &cb);
+	if (prepare_revision_walk(revs))
+		res = error(_("revision walk setup failed\n"));
+
+	free(good);
+	free(bad);
+	return res;
+}
+
+static int bisect_skipped_commits(struct bisect_terms *terms)
+{
+	int res;
+	FILE *fp = NULL;
+	struct rev_info revs;
+	struct commit *commit;
+	struct pretty_print_context pp = {0};
+	struct strbuf commit_name = STRBUF_INIT;
+
+	res = prepare_revs(terms, &revs);
+	if (res)
+		return res;
+
+	fp = fopen(git_path_bisect_log(), "a");
+	if (!fp)
+		return error_errno(_("could not open '%s' for appending"),
+				  git_path_bisect_log());
+
+	if (fprintf(fp, "# only skipped commits left to test\n") < 0)
+		return error_errno(_("failed to write to '%s'"), git_path_bisect_log());
+
+	while ((commit = get_revision(&revs)) != NULL) {
+		strbuf_reset(&commit_name);
+		format_commit_message(commit, "%s",
+				      &commit_name, &pp);
+		fprintf(fp, "# possible first %s commit: [%s] %s\n",
+			terms->term_bad, oid_to_hex(&commit->object.oid),
+			commit_name.buf);
+	}
+
+	/*
+	 * Reset the flags used by revision walks in case
+	 * there is another revision walk after this one.
+	 */
+	reset_revision_walk();
+
+	strbuf_release(&commit_name);
+	fclose(fp);
+	return 0;
+}
+
+static int bisect_successful(struct bisect_terms *terms)
+{
+	struct object_id oid;
+	struct commit *commit;
+	struct pretty_print_context pp = {0};
+	struct strbuf commit_name = STRBUF_INIT;
+	char *bad_ref = xstrfmt("refs/bisect/%s",terms->term_bad);
+	int res;
+
+	read_ref(bad_ref, &oid);
+	commit = lookup_commit_reference_by_name(bad_ref);
+	format_commit_message(commit, "%s", &commit_name, &pp);
+
+	res = append_to_file(git_path_bisect_log(), "# first %s commit: [%s] %s\n",
+			    terms->term_bad, oid_to_hex(&commit->object.oid),
+			    commit_name.buf);
+
+	strbuf_release(&commit_name);
+	free(bad_ref);
+	return res;
+}
+
+static enum bisect_error bisect_next(struct bisect_terms *terms, const char *prefix)
+{
+	int no_checkout;
+	enum bisect_error res;
+
+	bisect_autostart(terms);
+	if (bisect_next_check(terms, terms->term_good))
+		return BISECT_FAILED;
+
+	no_checkout = ref_exists("BISECT_HEAD");
+
+	/* Perform all bisection computation */
+	res = bisect_next_all(the_repository, prefix);
+
+	if (res == BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND) {
+		res = bisect_successful(terms);
+		return res ? res : BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND;
+	} else if (res == BISECT_ONLY_SKIPPED_LEFT) {
+		res = bisect_skipped_commits(terms);
+		return res ? res : BISECT_ONLY_SKIPPED_LEFT;
+	}
+	return res;
+}
+
+static enum bisect_error bisect_auto_next(struct bisect_terms *terms, const char *prefix)
+{
+	if (bisect_next_check(terms, NULL))
+		return BISECT_OK;
+
+	return bisect_next(terms, prefix);
+}
+
 static int bisect_start(struct bisect_terms *terms, const char **argv, int argc)
 {
 	int no_checkout = 0;
@@ -699,7 +858,9 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_NEXT_CHECK,
 		BISECT_TERMS,
 		BISECT_START,
-		BISECT_AUTOSTART,
+		BISECT_NEXT,
+		BISECT_AUTO_NEXT,
+		BISECT_AUTOSTART
 	} cmdmode = 0;
 	int res = 0, nolog = 0;
 	struct option options[] = {
@@ -723,6 +884,10 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("print out the bisect terms"), BISECT_TERMS),
 		OPT_CMDMODE(0, "bisect-start", &cmdmode,
 			 N_("start the bisect session"), BISECT_START),
+		OPT_CMDMODE(0, "bisect-next", &cmdmode,
+			 N_("find the next bisection commit"), BISECT_NEXT),
+		OPT_CMDMODE(0, "bisect-auto-next", &cmdmode,
+			 N_("verify the next bisection state then checkout the next bisection commit"), BISECT_AUTO_NEXT),
 		OPT_CMDMODE(0, "bisect-autostart", &cmdmode,
 			 N_("start the bisection if it has not yet been started"), BISECT_AUTOSTART),
 		OPT_BOOL(0, "no-log", &nolog,
@@ -784,6 +949,18 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		set_terms(&terms, "bad", "good");
 		res = bisect_start(&terms, argv, argc);
 		break;
+	case BISECT_NEXT:
+		if (argc)
+			return error(_("--bisect-next requires 0 arguments"));
+		get_terms(&terms);
+		res = bisect_next(&terms, prefix);
+		break;
+	case BISECT_AUTO_NEXT:
+		if (argc)
+			return error(_("--bisect-auto-next requires 0 arguments"));
+		get_terms(&terms);
+		res = bisect_auto_next(&terms, prefix);
+		break;
 	case BISECT_AUTOSTART:
 		if (argc)
 			return error(_("--bisect-autostart does not accept arguments"));
@@ -799,7 +976,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	 * Handle early success
 	 * From check_merge_bases > check_good_are_ancestors_of_bad > bisect_next_all
 	 */
-	if (res == BISECT_INTERNAL_SUCCESS_MERGE_BASE)
+	if ((res == BISECT_INTERNAL_SUCCESS_MERGE_BASE) || (res == BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND))
 		res = BISECT_OK;
 
 	return -res;
diff --git a/git-bisect.sh b/git-bisect.sh
index 9ca583d964..59424f5b37 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -65,8 +65,7 @@ bisect_start() {
 	#
 	# Check if we can proceed to the next bisect state.
 	#
-	get_terms
-	bisect_auto_next
+	git bisect--helper --bisect-auto-next || exit
 
 	trap '-' 0
 }
@@ -119,45 +118,7 @@ bisect_state() {
 	*)
 		usage ;;
 	esac
-	bisect_auto_next
-}
-
-bisect_auto_next() {
-	git bisect--helper --bisect-next-check $TERM_GOOD $TERM_BAD && bisect_next || :
-}
-
-bisect_next() {
-	case "$#" in 0) ;; *) usage ;; esac
-	git bisect--helper --bisect-autostart
-	git bisect--helper --bisect-next-check $TERM_GOOD $TERM_BAD $TERM_GOOD|| exit
-
-	# Perform all bisection computation, display and checkout
-	git bisect--helper --next-all
-	res=$?
-
-	# Check if we should exit because bisection is finished
-	if test $res -eq 10
-	then
-		bad_rev=$(git show-ref --hash --verify refs/bisect/$TERM_BAD)
-		bad_commit=$(git show-branch $bad_rev)
-		echo "# first $TERM_BAD commit: $bad_commit" >>"$GIT_DIR/BISECT_LOG"
-		exit 0
-	elif test $res -eq 2
-	then
-		echo "# only skipped commits left to test" >>"$GIT_DIR/BISECT_LOG"
-		good_revs=$(git for-each-ref --format="%(objectname)" "refs/bisect/$TERM_GOOD-*")
-		for skipped in $(git rev-list refs/bisect/$TERM_BAD --not $good_revs)
-		do
-			skipped_commit=$(git show-branch $skipped)
-			echo "# possible first $TERM_BAD commit: $skipped_commit" >>"$GIT_DIR/BISECT_LOG"
-		done
-		exit $res
-	fi
-
-	# Check for an error in the bisection process
-	test $res -ne 0 && exit $res
-
-	return 0
+	git bisect--helper --bisect-auto-next
 }
 
 bisect_visualize() {
@@ -213,7 +174,7 @@ bisect_replay () {
 		esac
 	done <"$file"
 	IFS="$oIFS"
-	bisect_auto_next
+	git bisect--helper --bisect-auto-next
 }
 
 bisect_run () {
@@ -310,7 +271,7 @@ case "$#" in
 		bisect_skip "$@" ;;
 	next)
 		# Not sure we want "next" at the UI level anymore.
-		bisect_next "$@" ;;
+		git bisect--helper --bisect-next "$@" || exit ;;
 	visualize|view)
 		bisect_visualize "$@" ;;
 	reset)
-- 
2.25.0

