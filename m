Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD8EC4BA12
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 10:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD19020838
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 10:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iinAQONa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbgBZKQN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 05:16:13 -0500
Received: from mail-wm1-f52.google.com ([209.85.128.52]:52826 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbgBZKQM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 05:16:12 -0500
Received: by mail-wm1-f52.google.com with SMTP id p9so2319362wmc.2
        for <git@vger.kernel.org>; Wed, 26 Feb 2020 02:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BBZ6G+fUiInsLyBUGxOxUOQrqvvTCxZ1x7uwHVKAz8U=;
        b=iinAQONaUFhdx36IYrTF31Wd9EayFT7POcDyGF0XRq8q/l+9KeJOJWpfECl2/CDj8t
         GTKpIpGYWrEeNKBIVdSBmu7ITeB3gR+ClrhNlQiAYgD5p9rmjORXAu9OC65R2i4CzsVW
         RH0S4Rr9ZaxxUK3BXolUxZsYNal/S4n9dNpOr6/vq93IXWaMhAgezYrj7fMVmbb+PTFw
         lUxOlAnw8A3cWoVOfg9EGc1QEjDJPCJ0Z1pRqVgWVpyANI6K3JVNagwsV3KHpJhyzF2J
         MwI54kzlgw+++jICMCDTqpnEFL0QEUGyZSdTOq1It3z2n3pQqWmzxdKkY5Zhu0CGNgwh
         k13g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BBZ6G+fUiInsLyBUGxOxUOQrqvvTCxZ1x7uwHVKAz8U=;
        b=f85KHMnWloTWNCwoV8TJYiJDwQYfXpwg50wCwTo7avVl+4VgABYT0JAHiUdAzX9ybE
         4VMFpLMHL2JsyPAun39q0S+JF3DkgIHyTH2LcRdQxiAguRUfaU6GXxv4F7+a2Fc5KiAO
         K/m7CS4mxH753DAsC0X2FrFeDNLqGPfa8h6sUE3tuUqBycK800IDBW8emx5SiLViV862
         tb3oJIhF1W8b1SNygW1mMdFIitdZCE/zi6vqq9PYOW6qIrKBxlSTMd9xOYXSUoOEYgL+
         DLpwr3SIZpS5OHPBArHFeldVX4ZMJFO9D+YwnVE/1KV2/RR79xafI0qEIUVKM5fwG756
         Ef8Q==
X-Gm-Message-State: APjAAAV1SCK7UmUWAANrJChM6Pkalcqh2Z9qSxZZdPZruglU+8Pw65oD
        U4BIH8uaRGknRmuf3Gze3MbYpo5MnbA=
X-Google-Smtp-Source: APXvYqx+NPUZw4TPLUWINC0QxnbrDgSKLhQR7j9+k0Wz/BKBXGikxRpyDzXhC3sVgZZIvv0QzSkkQA==
X-Received: by 2002:a7b:cf08:: with SMTP id l8mr4522611wmg.169.1582712168308;
        Wed, 26 Feb 2020 02:16:08 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id t3sm2577081wrx.38.2020.02.26.02.16.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Feb 2020 02:16:07 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH 02/10] bisect--helper: reimplement `bisect_next` and `bisect_auto_next` shell functions in C
Date:   Wed, 26 Feb 2020 11:14:21 +0100
Message-Id: <20200226101429.81327-3-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200226101429.81327-1-mirucam@gmail.com>
References: <20200226101429.81327-1-mirucam@gmail.com>
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

Using `--bisect-next` and `--bisect-auto-start` subcommands is a
temporary measure to port shell function to C so as to use the existing
test suite. As more functions are ported, `--bisect-auto-start`
subcommand will be retired and will be called by some other methods.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 bisect.c                 |  11 +++
 builtin/bisect--helper.c | 172 ++++++++++++++++++++++++++++++++++++++-
 git-bisect.sh            |  47 +----------
 3 files changed, 186 insertions(+), 44 deletions(-)

diff --git a/bisect.c b/bisect.c
index 9154f810f7..a50278ea7e 100644
--- a/bisect.c
+++ b/bisect.c
@@ -635,6 +635,11 @@ static void bisect_rev_setup(struct repository *r, struct rev_info *revs,
 	struct argv_array rev_argv = ARGV_ARRAY_INIT;
 	int i;
 
+	/*
+	 * `revs` could has been used before.
+	 * Thus we first need to reset it.
+	 */
+	reset_revision_walk();
 	repo_init_revisions(r, revs, prefix);
 	revs->abbrev = 0;
 	revs->commit_format = CMIT_FMT_UNSPECIFIED;
@@ -980,6 +985,12 @@ void read_bisect_terms(const char **read_bad, const char **read_good)
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
index ee1be630da..c82ffe9c1c 100644
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
 	NULL
 };
 
@@ -431,6 +434,155 @@ static int bisect_append_log_quoted(const char **argv)
 	return res;
 }
 
+static int register_good_ref(const char *refname,
+			     const struct object_id *oid, int flags,
+			     void *cb_data)
+{
+	struct string_list *good_refs = cb_data;
+
+	string_list_append(good_refs, oid_to_hex(oid));
+	return 0;
+}
+
+static void prepare_rev_argv(struct bisect_terms *terms, struct argv_array *rev_argv)
+{
+	struct string_list good_revs = STRING_LIST_INIT_DUP;
+	char *term_good = xstrfmt("%s-*", terms->term_good);
+
+	for_each_glob_ref_in(register_good_ref, term_good,
+			     "refs/bisect/", &good_revs);
+
+	argv_array_pushl(rev_argv, "skipped_commits", "refs/bisect/bad", "--not", NULL);
+	for (int i = 0; i < good_revs.nr; i++)
+		argv_array_push(rev_argv, good_revs.items[i].string);
+
+	string_list_clear(&good_revs, 0);
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
+	 * setups a revision walk.
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
+	if (fprintf(fp, "# only skipped commits left to test\n") < 1)
+		return -1;
+
+	while ((commit = get_revision(revs)) != NULL) {
+		struct strbuf commit_name = STRBUF_INIT;
+		format_commit_message(commit, "%s",
+				      &commit_name, &pp);
+		fprintf(fp, "# possible first %s commit: [%s] %s\n",
+			terms->term_bad, oid_to_hex(&commit->object.oid),
+			commit_name.buf);
+		strbuf_release(&commit_name);
+		clear_commit_marks(commit, ALL_REV_FLAGS);
+	}
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
+	char *bad_ref = xstrfmt("refs/bisect/%s",
+				terms->term_bad);
+	char *content;
+	int res;
+
+	read_ref(bad_ref, &oid);
+	printf("%s\n", bad_ref);
+	commit = lookup_commit_reference(the_repository, &oid);
+	format_commit_message(commit, "%s", &commit_name, &pp);
+
+	content = xstrfmt("# first %s commit: [%s] %s",
+	terms->term_bad, oid_to_hex(&oid),
+	commit_name.buf);
+
+	res = write_in_file(git_path_bisect_log(), content, 1);
+
+	strbuf_release(&commit_name);
+	free(bad_ref);
+	free(content);
+	return res;
+}
+
+static enum bisect_error bisect_next(struct bisect_terms *terms, const char *prefix)
+{
+	int no_checkout;
+	enum bisect_error res;
+
+	if (bisect_next_check(terms, terms->term_good))
+		return BISECT_FAILED;
+
+	no_checkout = !is_empty_or_missing_file(git_path_bisect_head());
+
+	/* Perform all bisection computation, display and checkout */
+	res = bisect_next_all(the_repository, prefix, no_checkout);
+
+	if (res == BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND) {
+		res = bisect_successful(terms);
+		return res ? res : BISECT_INTERNAL_SUCCESS_MERGE_BASE;
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
@@ -635,7 +787,9 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		CHECK_AND_SET_TERMS,
 		BISECT_NEXT_CHECK,
 		BISECT_TERMS,
-		BISECT_START
+		BISECT_START,
+		BISECT_NEXT,
+		BISECT_AUTO_NEXT,
 	} cmdmode = 0;
 	int no_checkout = 0, res = 0, nolog = 0;
 	struct option options[] = {
@@ -659,6 +813,10 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("print out the bisect terms"), BISECT_TERMS),
 		OPT_CMDMODE(0, "bisect-start", &cmdmode,
 			 N_("start the bisect session"), BISECT_START),
+		OPT_CMDMODE(0, "bisect-next", &cmdmode,
+			 N_("find the next bisection commit"), BISECT_NEXT),
+		OPT_CMDMODE(0, "bisect-auto-next", &cmdmode,
+			 N_("verify the next bisection state then checkout the next bisection commit"), BISECT_AUTO_NEXT),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_BOOL(0, "no-log", &nolog,
@@ -720,6 +878,18 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
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
 	default:
 		return error("BUG: unknown subcommand '%d'", cmdmode);
 	}
diff --git a/git-bisect.sh b/git-bisect.sh
index efee12b8b1..e03f210d55 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -86,8 +86,7 @@ bisect_start() {
 	#
 	# Check if we can proceed to the next bisect state.
 	#
-	get_terms
-	bisect_auto_next
+	git bisect--helper --bisect-auto-next || exit
 
 	trap '-' 0
 }
@@ -140,45 +139,7 @@ bisect_state() {
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
-	bisect_autostart
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
@@ -232,7 +193,7 @@ bisect_replay () {
 			die "$(gettext "?? what are you talking about?")" ;;
 		esac
 	done <"$file"
-	bisect_auto_next
+	git bisect--helper --bisect-auto-next
 }
 
 bisect_run () {
@@ -329,7 +290,7 @@ case "$#" in
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

