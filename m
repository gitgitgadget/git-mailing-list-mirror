Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1357BC2BA19
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 07:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E318E208E4
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 07:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpTghm1X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgDWHJo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 03:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbgDWHJn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 03:09:43 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09251C03C1AB
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 00:09:43 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id x25so5215282wmc.0
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 00:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4+PWo85AlycXUUMEUYHlBu2WrkYKhvD0yxDn0yeXUCY=;
        b=mpTghm1X5EZq7gBjvNsi46c9yX9Vmis+p1LrghIKsl2Ajg1uk5C12RG6GKoZzQFN4z
         7D42Sndygyfu+uXU3imc6yCWlIBqRO5U179Ja3ckJ7QsukLIqAdooTD3mtAeimRCe/yo
         +8GEi8MBzh73qh7q0XuMfCbJ5LgswpQYfidsQjddFnRbe2GgKr3piKgZb9siyz+IuZIr
         8M1RbHBwsj6AnnoNMvmpPCmdSiM3Qs0tluzMCcaLwPDyazrtM0jtJYRqAerOjCsM8M9I
         IlBCpmH5Twq959YjvYMn1CAsJN1K0A66NBe8Zt7293+6wHJhoRmAq8hbtvnnkAwnzns/
         64Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4+PWo85AlycXUUMEUYHlBu2WrkYKhvD0yxDn0yeXUCY=;
        b=MRxrzhOd7rU59P9nrpFHJVyfIGfPvLo715qYB8h67ZjmbWm2Mgm7GfA1591svFJXvq
         nW7m31MBwTCH3XEk6v3QAuDsOg7kw9VBY2R4P3HisNMIf9biQbHiXaEi11DA6uwd/2qL
         i2EHv48y119qs8vkS0S5rKPIDL3K5hNSjS9WMy6W5pPKftX8JD99wXp3sBhsVrK61VCo
         RanQxJfQv9OKDtKIhMCBGa9VBNp1i7l/ZbY10GXCPPSxJe6yspk8Rdsl5nTKW961IVLD
         IBI8fGkUCQKbbOUoMY1/VVk+h5p7U6qXVSPiq2XumZqOBOcll5twJ9Tj2vPxOZahgx0g
         O6Ow==
X-Gm-Message-State: AGi0Pub3kRFr7X2ViMXW9oenBfD1tQFd931g7VW1PKoPkeodhnMadQ1K
        hMulByA2WfY1AmIWMItWvfBm5kV9U1YYzg==
X-Google-Smtp-Source: APiQypLsYDQ497MYKlb7Ig0cJhvaUbdmjpRfxlwONierZREiKrnT/tGIRrASVt9VpHriCnQKTM7o8A==
X-Received: by 2002:a7b:c10d:: with SMTP id w13mr2465205wmi.78.1587625780806;
        Thu, 23 Apr 2020 00:09:40 -0700 (PDT)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id u17sm2518585wra.63.2020.04.23.00.09.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Apr 2020 00:09:40 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v3 05/12] bisect--helper: reimplement `bisect_next` and `bisect_auto_next` shell functions in C
Date:   Thu, 23 Apr 2020 09:06:57 +0200
Message-Id: <20200423070704.39872-6-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200423070704.39872-1-mirucam@gmail.com>
References: <20200423070704.39872-1-mirucam@gmail.com>
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
 bisect.c                 |   8 ++
 builtin/bisect--helper.c | 169 ++++++++++++++++++++++++++++++++++++++-
 git-bisect.sh            |  47 +----------
 3 files changed, 179 insertions(+), 45 deletions(-)

diff --git a/bisect.c b/bisect.c
index 9154f810f7..31cab3f0b0 100644
--- a/bisect.c
+++ b/bisect.c
@@ -980,6 +980,12 @@ void read_bisect_terms(const char **read_bad, const char **read_good)
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
@@ -1064,6 +1070,8 @@ enum bisect_error bisect_next_all(struct repository *r, const char *prefix, int
 		  "Bisecting: %d revisions left to test after this %s\n",
 		  nr), nr, steps_msg);
 	free(steps_msg);
+	/* Clean up objects used, as they will be reused. */
+	clear_commit_marks_all(ALL_REV_FLAGS);
 
 	return bisect_checkout(bisect_rev, no_checkout);
 }
diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 9df69800e3..c6aaa8eb15 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -8,6 +8,7 @@
 #include "run-command.h"
 #include "prompt.h"
 #include "quote.h"
+#include "revision.h"
 
 static GIT_PATH_FUNC(git_path_bisect_terms, "BISECT_TERMS")
 static GIT_PATH_FUNC(git_path_bisect_expected_rev, "BISECT_EXPECTED_REV")
@@ -29,6 +30,8 @@ static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-terms [--term-good | --term-old | --term-bad | --term-new]"),
 	N_("git bisect--helper --bisect-start [--term-{old,good}=<term> --term-{new,bad}=<term>]"
 					     "[--no-checkout] [<bad> [<good>...]] [--] [<paths>...]"),
+	N_("git bisect--helper --bisect-next"),
+	N_("git bisect--helper --bisect-auto-next"),
 	N_("git bisect--helper --bisect-autostart"),
 	NULL
 };
@@ -441,6 +444,150 @@ static int bisect_append_log_quoted(const char **argv)
 	return res;
 }
 
+static int register_good_ref(const char *refname,
+			     const struct object_id *oid, int flags,
+			     void *cb_data)
+{
+	struct argv_array *rev_argv = cb_data;
+
+	argv_array_push(rev_argv, oid_to_hex(oid));
+	return 0;
+}
+
+static void prepare_rev_argv(struct bisect_terms *terms, struct argv_array *rev_argv)
+{
+	char *term_good = xstrfmt("%s-*", terms->term_good);
+
+	argv_array_pushl(rev_argv, "skipped_commits", "refs/bisect/bad", "--not", NULL);
+	for_each_glob_ref_in(register_good_ref, term_good, "refs/bisect/", rev_argv);
+
+	free(term_good);
+}
+
+static int prepare_revs(struct bisect_terms *terms, struct rev_info *revs)
+{
+	int res = 0;
+	struct argv_array rev_argv = ARGV_ARRAY_INIT;
+
+	prepare_rev_argv(terms, &rev_argv);
+
+	/*
+	 * It is important to reset the flags used by revision walks
+	 * as the previous call to bisect_next_all() in turn
+	 * sets up a revision walk.
+	 */
+	reset_revision_walk();
+	init_revisions(revs, NULL);
+	rev_argv.argc = setup_revisions(rev_argv.argc, rev_argv.argv, revs, NULL);
+	if (prepare_revision_walk(revs))
+		res = error(_("revision walk setup failed\n"));
+
+	argv_array_clear(&rev_argv);
+	return res;
+}
+
+static int process_skipped_commits(FILE *fp, struct bisect_terms *terms, struct rev_info *revs)
+{
+	struct commit *commit;
+	struct pretty_print_context pp = {0};
+
+	if (fprintf(fp, "# only skipped commits left to test\n") < 0)
+		return error_errno(_("failed to write to '%s'"), git_path_bisect_log());
+
+	while ((commit = get_revision(revs)) != NULL) {
+		struct strbuf commit_name = STRBUF_INIT;
+		format_commit_message(commit, "%s",
+				      &commit_name, &pp);
+		fprintf(fp, "# possible first %s commit: [%s] %s\n",
+			terms->term_bad, oid_to_hex(&commit->object.oid),
+			commit_name.buf);
+		strbuf_release(&commit_name);
+	}
+
+	/*
+	 * Reset the flags used by revision walks in case
+	 * there is another revision walk after this one.
+	 */
+	reset_revision_walk();
+
+	return 0;
+}
+
+static int bisect_skipped_commits(struct bisect_terms *terms)
+{
+	int res = 0;
+	FILE *fp = NULL;
+	struct rev_info revs;
+
+	fp = fopen(git_path_bisect_log(), "a");
+	if (!fp)
+		return error_errno(_("could not open '%s' for appending"),
+				  git_path_bisect_log());
+
+	res = prepare_revs(terms, &revs);
+
+	if (!res)
+		res = process_skipped_commits(fp, terms, &revs);
+
+	fclose(fp);
+	return res;
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
+	printf("%s\n", bad_ref);
+	commit = lookup_commit_reference(the_repository, &oid);
+	format_commit_message(commit, "%s", &commit_name, &pp);
+
+	res = write_in_file(git_path_bisect_log(), "a", "# first %s commit: [%s] %s\n",
+			    terms->term_bad, oid_to_hex(&oid),
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
+	no_checkout = file_exists(git_path_bisect_head());
+
+	/* Perform all bisection computation, display and checkout */
+	res = bisect_next_all(the_repository, prefix, no_checkout);
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
 static int bisect_start(struct bisect_terms *terms, int no_checkout,
 			const char **argv, int argc)
 {
@@ -672,7 +819,9 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_NEXT_CHECK,
 		BISECT_TERMS,
 		BISECT_START,
-		BISECT_AUTOSTART,
+		BISECT_NEXT,
+		BISECT_AUTO_NEXT,
+		BISECT_AUTOSTART
 	} cmdmode = 0;
 	int no_checkout = 0, res = 0, nolog = 0;
 	struct option options[] = {
@@ -696,6 +845,10 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("print out the bisect terms"), BISECT_TERMS),
 		OPT_CMDMODE(0, "bisect-start", &cmdmode,
 			 N_("start the bisect session"), BISECT_START),
+		OPT_CMDMODE(0, "bisect-next", &cmdmode,
+			 N_("find the next bisection commit"), BISECT_NEXT),
+		OPT_CMDMODE(0, "bisect-auto-next", &cmdmode,
+			 N_("verify the next bisection state then checkout the next bisection commit"), BISECT_AUTO_NEXT),
 		OPT_CMDMODE(0, "bisect-autostart", &cmdmode,
 			 N_("start the bisection if BISECT_START is empty or missing"), BISECT_AUTOSTART),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
@@ -759,6 +912,18 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		set_terms(&terms, "bad", "good");
 		res = bisect_start(&terms, no_checkout, argv, argc);
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
 			return error(_("--bisect-autostart requires 0 arguments"));
@@ -774,7 +939,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	 * Handle early success
 	 * From check_merge_bases > check_good_are_ancestors_of_bad > bisect_next_all
 	 */
-	if (res == BISECT_INTERNAL_SUCCESS_MERGE_BASE)
+	if ((res == BISECT_INTERNAL_SUCCESS_MERGE_BASE) || (res == BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND))
 		res = BISECT_OK;
 
 	return -res;
diff --git a/git-bisect.sh b/git-bisect.sh
index 426d443e7e..897825b675 100755
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
-	git bisect--helper --next-all $(test -f "$GIT_DIR/BISECT_HEAD" && echo --no-checkout)
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
@@ -211,7 +172,7 @@ bisect_replay () {
 			die "$(gettext "?? what are you talking about?")" ;;
 		esac
 	done <"$file"
-	bisect_auto_next
+	git bisect--helper --bisect-auto-next
 }
 
 bisect_run () {
@@ -308,7 +269,7 @@ case "$#" in
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

