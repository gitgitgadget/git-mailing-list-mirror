Return-Path: <SRS0=8LOk=DA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C80C4363D
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 07:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AF112223E
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 07:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="roGXDTjN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgIWH2O (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Sep 2020 03:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbgIWH2L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Sep 2020 03:28:11 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F580C061755
        for <git@vger.kernel.org>; Wed, 23 Sep 2020 00:28:10 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id k15so19780585wrn.10
        for <git@vger.kernel.org>; Wed, 23 Sep 2020 00:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OPvHuI4I9ltG2U+CejGb+eCqCwUop1dC5eFjfi65CIw=;
        b=roGXDTjNwzd3qu8O+00W9MPbsxEHjnsUNcH60DFaitKc2aa/2QpEVoFfjWF7oKGMp4
         /8KA7N+EbVJpo7y72cy49hApyufGbtrVEaxml3j9je/Imb2oZwKxUrrqqbsw/4TNCQGq
         We7fX4FNvPiiBT723GByoslVjWAdXuY5Cvd7hkw8XmgLunDq9DIf0XkuTx89aS6Te3W1
         pLuQMsrQ+d8+bGzn2s5fFAycamX04ISII24sSqAs8TM7d8RntqQwJzg5QKS5qwv/kpTq
         IwEe+JVhMyj4O3rsPomfGHJU/F5BP7bmlngy4ZX32rdZ7Rm6EASSdHBtK9VSpPLKfXDV
         pZ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OPvHuI4I9ltG2U+CejGb+eCqCwUop1dC5eFjfi65CIw=;
        b=QW4anH3DfQJgM/xU0N0rR4gdnwQkRWpT+7jFYISV9/hpWEBZn42Dqrdg2nyMho+h/G
         jGOvRRSpcoyGi4fsteyx7/Vaewn+kIzWbxDfYpDkMCq+wgwFStCV29GTydZr4UT5BIvv
         3IdPFCZUCxsDwafT3WwdTp2cobR55dPLTEmsQ0hjcRmAxW+rEmzfQbrfdTE7t3Ny9Cy6
         Ss+7i6TR+qInIBz0B92wVoHQvvF8eLbh2/3NvppovaR83mc9YONObFF9gf5ksLuTnBPB
         yv0KT1wne1AzTNhfsTZswig3dNzWAzBV7xGudZLo5oErJy3HaJHfBJ42Ws04O4L0zkZM
         KNCw==
X-Gm-Message-State: AOAM532yQASBipoGGV/gvttkT5RUZyhz+WYPNRTS75fzL+M+f1YtmX7J
        NJZzs/NSOmZCtNWHbvtKZDB96TiSd5A=
X-Google-Smtp-Source: ABdhPJzL6TzjDnk4uncFSZaC/HO2NQCIC7wczXTzwKJj5Yq73WwiOUMVrHxkI7byEVzK3HwHWjSJrw==
X-Received: by 2002:adf:e601:: with SMTP id p1mr10218062wrm.172.1600846088868;
        Wed, 23 Sep 2020 00:28:08 -0700 (PDT)
Received: from localhost.localdomain ([178.237.235.60])
        by smtp.gmail.com with ESMTPSA id j14sm30046838wrr.66.2020.09.23.00.28.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Sep 2020 00:28:08 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v8 6/6] bisect--helper: reimplement `bisect_next` and `bisect_auto_next` shell functions in C
Date:   Wed, 23 Sep 2020 09:27:40 +0200
Message-Id: <20200923072740.20772-7-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200923072740.20772-1-mirucam@gmail.com>
References: <20200923072740.20772-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

Reimplement the `bisect_next()` and the `bisect_auto_next()` shell functions
in C and add the subcommands to `git bisect--helper` to call them from
git-bisect.sh .

bisect_auto_next() function returns an enum bisect_error type as whole
`git bisect` can exit with an error code when bisect_next() does.

Return an error when `bisect_next()` fails, that fix a bug on shell script
version.

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
 bisect.c                 |  11 ++-
 builtin/bisect--helper.c | 180 ++++++++++++++++++++++++++++++++++++++-
 git-bisect.sh            |  47 +---------
 3 files changed, 191 insertions(+), 47 deletions(-)

diff --git a/bisect.c b/bisect.c
index c6aba2b9f2..f5b1368128 100644
--- a/bisect.c
+++ b/bisect.c
@@ -988,8 +988,11 @@ void read_bisect_terms(const char **read_bad, const char **read_good)
  * the bisection process finished successfully.
  * In this case the calling function or command should not turn a
  * BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND return code into an error or a non zero exit code.
- * If no_checkout is non-zero, the bisection process does not
- * checkout the trial commit but instead simply updates BISECT_HEAD.
+ *
+ * Checking BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND
+ * in bisect_helper::bisect_next() and only transforming it to 0 at
+ * the end of bisect_helper::cmd_bisect__helper() helps bypassing
+ * all the code related to finding a commit to test.
  */
 enum bisect_error bisect_next_all(struct repository *r, const char *prefix)
 {
@@ -999,6 +1002,10 @@ enum bisect_error bisect_next_all(struct repository *r, const char *prefix)
 	enum bisect_error res = BISECT_OK;
 	struct object_id *bisect_rev;
 	char *steps_msg;
+	/*
+	 * If no_checkout is non-zero, the bisection process does not
+	 * checkout the trial commit but instead simply updates BISECT_HEAD.
+	 */
 	int no_checkout = ref_exists("BISECT_HEAD");
 	unsigned bisect_flags = 0;
 
diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index ab27a8dff6..3a5bf99257 100644
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
 	N_("git bisect--helper --bisect-start [--term-{new,bad}=<term> --term-{old,good}=<term>]"
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
@@ -451,6 +473,142 @@ static int bisect_append_log_quoted(const char **argv)
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
+	enum bisect_error res;
+
+	if (bisect_autostart(terms))
+		return BISECT_FAILED;
+
+	if (bisect_next_check(terms, terms->term_good))
+		return BISECT_FAILED;
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
@@ -700,6 +858,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_TERMS,
 		BISECT_START,
 		BISECT_AUTOSTART,
+		BISECT_NEXT,
+		BISECT_AUTO_NEXT
 	} cmdmode = 0;
 	int res = 0, nolog = 0;
 	struct option options[] = {
@@ -723,6 +883,10 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
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
@@ -784,6 +948,18 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
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
@@ -799,7 +975,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	 * Handle early success
 	 * From check_merge_bases > check_good_are_ancestors_of_bad > bisect_next_all
 	 */
-	if (res == BISECT_INTERNAL_SUCCESS_MERGE_BASE)
+	if ((res == BISECT_INTERNAL_SUCCESS_MERGE_BASE) || (res == BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND))
 		res = BISECT_OK;
 
 	return -res;
diff --git a/git-bisect.sh b/git-bisect.sh
index 4e9b2d36cb..ea7e684ebb 100755
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
+	git bisect--helper --bisect-auto-next || exit
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

