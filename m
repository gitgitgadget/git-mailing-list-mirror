Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CEF3C0B
	for <git@vger.kernel.org>; Mon, 15 Jan 2024 07:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtVyKcJt"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40e7e0a6ed4so1717425e9.1
        for <git@vger.kernel.org>; Sun, 14 Jan 2024 23:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705302309; x=1705907109; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NcmXm/NxEreradn01uADefClzFwVZEHtHh2bPfVXrss=;
        b=YtVyKcJtSLNGCKTVyazGvo9CrAq/mMdBUksmBexLP2jWwjmTtM4kP+xNmtclPAwXlF
         r+VL/6vAzCsneh47TGWVO/k/wxK0W7HhvEUzq4xDV8yv5SOvPk5GrgCElxKrTx1rXkS6
         829hVUdi199ehDhlgehOInqzqO6/4YLyQWX+oAeRpMMWlRk20tFRoJ8NBOOZulPqQh8K
         EmkMgh4g9l0QFH9T5+grwAbX83D09JctpsNlk/L0X7RCbySMdjcCybCAA7wUBGdXE1ea
         7rNZ1KKR8vGSlL98R19nBf5/qAbD9aldtKtZNQVtgS+o7w1yedzBCuKxlLI9Ns6MAh5R
         84rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705302309; x=1705907109;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NcmXm/NxEreradn01uADefClzFwVZEHtHh2bPfVXrss=;
        b=RIeJa9/HKvqRUeR4/Z4NFuAeG62+EG76zXIA3tRYwhcOJF5LG0zr7rEQ4MMPyaH0fp
         Va7HVfQpCJcVGxekuy594F7NDX3/1/wDz2MbMCKysP/lluBLniI9KKiu29SQTQp8UZQL
         arIW6MVCYt1iMBDK/QYeuBeBV7NqBsiwcTNyxvv+8PzznOtSwxe+2Nh/lsVvOrvfj1/Q
         /DhC4xlBGTuPk/HDLQP0aJ82DSyiFNiCXuBwDMBjH2MFnWmkyjTGMXU6s5MbQqxpEJSQ
         fRfEmSbEJliGNEpXhUq8uC8YIHJNsP3jcV5wwTBpY1culZl+L7ZN0qiOcdsF5p/Wz92l
         8Qxg==
X-Gm-Message-State: AOJu0Yx0H3mVqUgcEh96WwVmvd8Z1GG9PDUhMOGwNH6v1PWvK1ENXHZY
	mzD/Gd+hXqoetAGWvTks5kYyxX1yBGE=
X-Google-Smtp-Source: AGHT+IFMpH/U1f/jZuPEirBwu8lQx6yYRwvfd2ubc75yH5FRVrEhmYsOn6C/M0MRV9PURhBVgFplCg==
X-Received: by 2002:a05:600c:319a:b0:40e:7c23:898d with SMTP id s26-20020a05600c319a00b0040e7c23898dmr224281wmp.102.1705302309265;
        Sun, 14 Jan 2024 23:05:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g14-20020a05600c310e00b0040e398f8cafsm14773537wmo.31.2024.01.14.23.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jan 2024 23:05:08 -0800 (PST)
Message-ID: <pull.1641.git.git.1705302307639.gitgitgadget@gmail.com>
From: "Kevin Wang via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 15 Jan 2024 07:05:07 +0000
Subject: [PATCH] bisect: add --force flag to force checkout
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Kevin Wang <kevmo314@gmail.com>,
    Kevin Wang <kevmo314@gmail.com>

From: Kevin Wang <kevmo314@gmail.com>

Adds a `--force`/`-f` flag to `git bisect good/bad` and `git bisect run` to
force a checkout. Currently, if the repository state adds any local changes
the user must manually reset the repository state before moving to the next
bisection step. This can happen with package lock files or log output data,
for example. With this change, a developer can run `git bisect run --force`
to automatically reset the repository state after each evaluation. The flag
is also supported as `git bisect (good|bad) --force` as well.

Signed-off-by: Kevin Wang <kevmo314@gmail.com>
---
    bisect: add --force flag to force checkout
    
    Adds a --force/-f flag to git bisect good/bad and git bisect run to
    force a checkout. Currently, if the repository state adds any local
    changes the user must manually reset the repository state before moving
    to the next bisection step. This can happen with package lock files or
    log output data, for example. With this change, a developer can run git
    bisect run --force to automatically reset the repository state after
    each evaluation. The flag is also supported as git bisect (good|bad)
    --force as well.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1641%2Fkevmo314%2Fbisect-force-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1641/kevmo314/bisect-force-v1
Pull-Request: https://github.com/git/git/pull/1641

 Documentation/git-bisect.txt |  13 ++++-
 bisect.c                     |  17 ++++--
 bisect.h                     |   4 +-
 builtin/bisect.c             |  50 +++++++++++-----
 t/t6030-bisect-porcelain.sh  | 109 +++++++++++++++++++++++++++++++++++
 5 files changed, 167 insertions(+), 26 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index aa02e462244..57357221718 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -19,14 +19,14 @@ on the subcommand:
  git bisect start [--term-(new|bad)=<term-new> --term-(old|good)=<term-old>]
 		  [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<paths>...]
  git bisect (bad|new|<term-new>) [<rev>]
- git bisect (good|old|<term-old>) [<rev>...]
+ git bisect (good|old|<term-old>) [-f] [<rev>...]
  git bisect terms [--term-good | --term-bad]
  git bisect skip [(<rev>|<range>)...]
  git bisect reset [<commit>]
  git bisect (visualize|view)
  git bisect replay <logfile>
  git bisect log
- git bisect run <cmd> [<arg>...]
+ git bisect run [-f] <cmd> [<arg>...]
  git bisect help
 
 This command uses a binary search algorithm to find which commit in
@@ -381,6 +381,15 @@ ignored.
 This option is particularly useful in avoiding false positives when a merged
 branch contained broken or non-buildable commits, but the merge itself was OK.
 
+-f::
+--force::
++
+Throw away any local changes and untracked files before moving to the next
+bisection step.
++
+This option may be useful if the repository state changes when testing a
+revision.
+
 EXAMPLES
 --------
 
diff --git a/bisect.c b/bisect.c
index 985b96ed132..72ce09f2015 100644
--- a/bisect.c
+++ b/bisect.c
@@ -713,7 +713,7 @@ static int is_expected_rev(const struct object_id *oid)
 }
 
 enum bisect_error bisect_checkout(const struct object_id *bisect_rev,
-				  int no_checkout)
+				  int no_checkout, int force_checkout)
 {
 	struct commit *commit;
 	struct pretty_print_context pp = {0};
@@ -728,8 +728,13 @@ enum bisect_error bisect_checkout(const struct object_id *bisect_rev,
 		struct child_process cmd = CHILD_PROCESS_INIT;
 
 		cmd.git_cmd = 1;
-		strvec_pushl(&cmd.args, "checkout", "-q",
-			     oid_to_hex(bisect_rev), "--", NULL);
+		if (force_checkout) {
+			strvec_pushl(&cmd.args, "checkout", "-f", "-q",
+					oid_to_hex(bisect_rev), "--", NULL);
+		} else {
+			strvec_pushl(&cmd.args, "checkout", "-q",
+					oid_to_hex(bisect_rev), "--", NULL);
+		}
 		if (run_command(&cmd))
 			/*
 			 * Errors in `run_command()` itself, signaled by res < 0,
@@ -850,7 +855,7 @@ static enum bisect_error check_merge_bases(int rev_nr, struct commit **rev, int
 			handle_skipped_merge_base(mb);
 		} else {
 			printf(_("Bisecting: a merge base must be tested\n"));
-			res = bisect_checkout(mb, no_checkout);
+			res = bisect_checkout(mb, no_checkout, 0);
 			if (!res)
 				/* indicate early success */
 				res = BISECT_INTERNAL_SUCCESS_MERGE_BASE;
@@ -1002,7 +1007,7 @@ void read_bisect_terms(const char **read_bad, const char **read_good)
  * the end of bisect_helper::cmd_bisect__helper() helps bypassing
  * all the code related to finding a commit to test.
  */
-enum bisect_error bisect_next_all(struct repository *r, const char *prefix)
+enum bisect_error bisect_next_all(struct repository *r, const char *prefix, int force_checkout)
 {
 	struct strvec rev_argv = STRVEC_INIT;
 	struct rev_info revs = REV_INFO_INIT;
@@ -1104,7 +1109,7 @@ enum bisect_error bisect_next_all(struct repository *r, const char *prefix)
 	/* Clean up objects used, as they will be reused. */
 	repo_clear_commit_marks(r, ALL_REV_FLAGS);
 
-	res = bisect_checkout(bisect_rev, no_checkout);
+	res = bisect_checkout(bisect_rev, no_checkout, force_checkout);
 cleanup:
 	release_revisions(&revs);
 	strvec_clear(&rev_argv);
diff --git a/bisect.h b/bisect.h
index ee3fd65f3bd..6f972365faa 100644
--- a/bisect.h
+++ b/bisect.h
@@ -71,7 +71,7 @@ struct bisect_state {
 	unsigned int nr_bad;
 };
 
-enum bisect_error bisect_next_all(struct repository *r, const char *prefix);
+enum bisect_error bisect_next_all(struct repository *r, const char *prefix, int force_checkout);
 
 int estimate_bisect_steps(int all);
 
@@ -80,6 +80,6 @@ void read_bisect_terms(const char **bad, const char **good);
 int bisect_clean_state(void);
 
 enum bisect_error bisect_checkout(const struct object_id *bisect_rev,
-				  int no_checkout);
+				  int no_checkout, int force_checkout);
 
 #endif
diff --git a/builtin/bisect.c b/builtin/bisect.c
index 47fcce59ff7..99c16d57942 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -29,7 +29,7 @@ static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
 	   "    [--no-checkout] [--first-parent] [<bad> [<good>...]] [--]" \
 	   "    [<pathspec>...]")
 #define BUILTIN_GIT_BISECT_STATE_USAGE \
-	N_("git bisect (good|bad) [<rev>...]")
+	N_("git bisect (good|bad) [-f] [<rev>...]")
 #define BUILTIN_GIT_BISECT_TERMS_USAGE \
 	"git bisect terms [--term-good | --term-bad]"
 #define BUILTIN_GIT_BISECT_SKIP_USAGE \
@@ -45,7 +45,7 @@ static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
 #define BUILTIN_GIT_BISECT_LOG_USAGE \
 	"git bisect log"
 #define BUILTIN_GIT_BISECT_RUN_USAGE \
-	N_("git bisect run <cmd> [<arg>...]")
+	N_("git bisect run [-f] <cmd> [<arg>...]")
 
 static const char * const git_bisect_usage[] = {
 	BUILTIN_GIT_BISECT_START_USAGE,
@@ -651,7 +651,7 @@ static int bisect_successful(struct bisect_terms *terms)
 	return res;
 }
 
-static enum bisect_error bisect_next(struct bisect_terms *terms, const char *prefix)
+static enum bisect_error bisect_next(struct bisect_terms *terms, const char *prefix, int force_checkout)
 {
 	enum bisect_error res;
 
@@ -662,7 +662,7 @@ static enum bisect_error bisect_next(struct bisect_terms *terms, const char *pre
 		return BISECT_FAILED;
 
 	/* Perform all bisection computation */
-	res = bisect_next_all(the_repository, prefix);
+	res = bisect_next_all(the_repository, prefix, force_checkout);
 
 	if (res == BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND) {
 		res = bisect_successful(terms);
@@ -674,14 +674,14 @@ static enum bisect_error bisect_next(struct bisect_terms *terms, const char *pre
 	return res;
 }
 
-static enum bisect_error bisect_auto_next(struct bisect_terms *terms, const char *prefix)
+static enum bisect_error bisect_auto_next(struct bisect_terms *terms, const char *prefix, int force_checkout)
 {
 	if (bisect_next_check(terms, NULL)) {
 		bisect_print_status(terms);
 		return BISECT_OK;
 	}
 
-	return bisect_next(terms, prefix);
+	return bisect_next(terms, prefix, force_checkout);
 }
 
 static enum bisect_error bisect_start(struct bisect_terms *terms, int argc,
@@ -875,7 +875,7 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, int argc,
 	if (res)
 		return res;
 
-	res = bisect_auto_next(terms, NULL);
+	res = bisect_auto_next(terms, NULL, 0);
 	if (!is_bisect_success(res))
 		bisect_clean_state();
 	return res;
@@ -917,7 +917,7 @@ static enum bisect_error bisect_state(struct bisect_terms *terms, int argc,
 				      const char **argv)
 {
 	const char *state;
-	int i, verify_expected = 1;
+	int i, force_checkout = 0, verify_expected = 1;
 	struct object_id oid, expected;
 	struct oid_array revs = OID_ARRAY_INIT;
 
@@ -934,6 +934,13 @@ static enum bisect_error bisect_state(struct bisect_terms *terms, int argc,
 
 	argv++;
 	argc--;
+
+	if (argc > 0 && (!strcmp(argv[0], "--force") || !strcmp(argv[0], "-f"))) {
+		force_checkout = 1;
+		argv++;
+		argc--;
+	}
+
 	if (argc > 1 && !strcmp(state, terms->term_bad))
 		return error(_("'git bisect %s' can take only one argument."), terms->term_bad);
 
@@ -989,7 +996,7 @@ static enum bisect_error bisect_state(struct bisect_terms *terms, int argc,
 	}
 
 	oid_array_clear(&revs);
-	return bisect_auto_next(terms, NULL);
+	return bisect_auto_next(terms, NULL, force_checkout);
 }
 
 static enum bisect_error bisect_log(void)
@@ -1078,7 +1085,7 @@ static enum bisect_error bisect_replay(struct bisect_terms *terms, const char *f
 	if (res)
 		return BISECT_FAILED;
 
-	return bisect_auto_next(terms, NULL);
+	return bisect_auto_next(terms, NULL, 0);
 }
 
 static enum bisect_error bisect_skip(struct bisect_terms *terms, int argc,
@@ -1173,7 +1180,7 @@ static int do_bisect_run(const char *command)
 	return run_command(&cmd);
 }
 
-static int verify_good(const struct bisect_terms *terms, const char *command)
+static int verify_good(const struct bisect_terms *terms, const char *command, int force_checkout)
 {
 	int rc;
 	enum bisect_error res;
@@ -1189,13 +1196,13 @@ static int verify_good(const struct bisect_terms *terms, const char *command)
 	if (read_ref(no_checkout ? "BISECT_HEAD" : "HEAD", &current_rev))
 		return -1;
 
-	res = bisect_checkout(&good_rev, no_checkout);
+	res = bisect_checkout(&good_rev, no_checkout, force_checkout);
 	if (res != BISECT_OK)
 		return -1;
 
 	rc = do_bisect_run(command);
 
-	res = bisect_checkout(&current_rev, no_checkout);
+	res = bisect_checkout(&current_rev, no_checkout, force_checkout);
 	if (res != BISECT_OK)
 		return -1;
 
@@ -1209,6 +1216,7 @@ static int bisect_run(struct bisect_terms *terms, int argc, const char **argv)
 	const char *new_state;
 	int temporary_stdout_fd, saved_stdout;
 	int is_first_run = 1;
+	int force_checkout = 0;
 
 	if (bisect_next_check(terms, NULL))
 		return BISECT_FAILED;
@@ -1218,8 +1226,14 @@ static int bisect_run(struct bisect_terms *terms, int argc, const char **argv)
 		return BISECT_FAILED;
 	}
 
+	if (argc > 0 && (!strcmp(argv[0], "--force") || !strcmp(argv[0], "-f"))) {
+		force_checkout = 1;
+		argv++;
+		argc--;
+	}
 	sq_quote_argv(&command, argv);
 	strbuf_ltrim(&command);
+
 	while (1) {
 		res = do_bisect_run(command.buf);
 
@@ -1231,7 +1245,7 @@ static int bisect_run(struct bisect_terms *terms, int argc, const char **argv)
 		 * missing or non-executable script.
 		 */
 		if (is_first_run && (res == 126 || res == 127)) {
-			int rc = verify_good(terms, command.buf);
+			int rc = verify_good(terms, command.buf, force_checkout);
 			is_first_run = 0;
 			if (rc < 0 || 128 <= rc) {
 				error(_("unable to verify %s on good"
@@ -1271,7 +1285,11 @@ static int bisect_run(struct bisect_terms *terms, int argc, const char **argv)
 		saved_stdout = dup(1);
 		dup2(temporary_stdout_fd, 1);
 
-		res = bisect_state(terms, 1, &new_state);
+		if (force_checkout) {
+			res = bisect_state(terms, 2, (const char *[]){ new_state, "--force" });
+		} else {
+			res = bisect_state(terms, 1, &new_state);
+		}
 
 		fflush(stdout);
 		dup2(saved_stdout, 1);
@@ -1342,7 +1360,7 @@ static int cmd_bisect__next(int argc, const char **argv UNUSED, const char *pref
 		return error(_("'%s' requires 0 arguments"),
 			     "git bisect next");
 	get_terms(&terms);
-	res = bisect_next(&terms, prefix);
+	res = bisect_next(&terms, prefix, 0);
 	free_terms(&terms);
 	return res;
 }
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 561080bf240..eb17cc58a16 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -1259,4 +1259,113 @@ test_expect_success 'verify correct error message' '
 	grep "git bisect good.*exited with error code" error
 '
 
+test_expect_success 'bisect dirty, explicit ref' '
+	test_when_finished "git bisect reset" &&
+    add_line_into_file "Commit 1" file &&
+    add_line_into_file "Commit 2" file &&
+    add_line_into_file "Commit 3" file &&
+	git bisect start &&
+	git bisect bad HEAD &&
+	echo "modified state" >file &&
+	test_when_finished "git checkout -- file" &&
+	test_must_fail git bisect good HEAD~2
+'
+
+test_expect_success 'bisect dirty good force, explicit ref' '
+	test_when_finished "git bisect reset" &&
+    add_line_into_file "Commit 1" file &&
+    add_line_into_file "Commit 2" file &&
+    add_line_into_file "Commit 3" file &&
+	git bisect start &&
+	git bisect bad HEAD &&
+	echo "modified state" >file &&
+	test_when_finished "git checkout -- file" &&
+	git bisect good --force HEAD~2
+'
+
+test_expect_success 'bisect dirty, implicit ref' '
+	test_when_finished "git bisect reset" &&
+    add_line_into_file "Commit 1" file &&
+    add_line_into_file "Commit 2" file &&
+    add_line_into_file "Commit 3" file &&
+    add_line_into_file "Commit 4" file &&
+    add_line_into_file "Commit 5" file &&
+	git bisect start &&
+	git bisect bad HEAD &&
+	git bisect good HEAD~4 &&
+	echo "modified state" >file &&
+	test_when_finished "git checkout -- file" &&
+	test_must_fail git bisect good &&
+	test_must_fail git bisect bad
+'
+
+test_expect_success 'bisect dirty good force, implicit ref' '
+	test_when_finished "git bisect reset" &&
+    add_line_into_file "Commit 1" file &&
+    add_line_into_file "Commit 2" file &&
+    add_line_into_file "Commit 3" file &&
+    add_line_into_file "Commit 4" file &&
+    add_line_into_file "Commit 5" file &&
+	git bisect start &&
+	git bisect bad HEAD &&
+	git bisect good HEAD~4 &&
+	echo "modified state" >file &&
+	test_when_finished "git checkout -- file" &&
+	git bisect good --force
+'
+
+test_expect_success 'bisect dirty bad force, implicit ref' '
+	test_when_finished "git bisect reset" &&
+    add_line_into_file "Commit 1" file &&
+    add_line_into_file "Commit 2" file &&
+    add_line_into_file "Commit 3" file &&
+    add_line_into_file "Commit 4" file &&
+    add_line_into_file "Commit 5" file &&
+	git bisect start &&
+	git bisect bad HEAD &&
+	git bisect good HEAD~4 &&
+	echo "modified state" >file &&
+	test_when_finished "git checkout -- file" &&
+	git bisect bad --force
+'
+
+test_expect_success 'bisect run dirty' '
+	test_when_finished "git bisect reset" &&
+	test_when_finished "git checkout -- file" &&
+    add_line_into_file "Bisect run 1" file &&
+    add_line_into_file "Bisect run 2" file &&
+    add_line_into_file "Bisect run 3" file &&
+    add_line_into_file "Bisect run 4" file &&
+    add_line_into_file "Bisect run 5" file &&
+	write_script test_script.sh <<-\EOF &&
+	! echo "modified state" >file
+	! grep "Bisect run 3" || exit 126 >/dev/null
+	EOF
+	git bisect start &&
+	git bisect bad HEAD &&
+	git bisect good HEAD~4 &&
+	test_must_fail git bisect run ./test_script.sh
+'
+
+test_expect_success 'bisect run dirty force' '
+	test_when_finished "git bisect reset" &&
+	test_when_finished "git checkout -- file" &&
+    add_line_into_file "Bisect run 1" file &&
+    add_line_into_file "Bisect run 2" file &&
+    add_line_into_file "Bisect run 3" file &&
+    add_line_into_file "Bisect run 4" file &&
+    add_line_into_file "Bisect run 5" file &&
+	write_script test_script.sh <<-\EOF &&
+	! echo "modified state" >file
+	! grep "Bisect run 3" || exit 126 >/dev/null
+	EOF
+	HASH5=$(git rev-parse --verify HEAD) &&
+	git bisect start &&
+	git bisect bad HEAD &&
+	git bisect good HEAD~4 &&
+	echo "doing run\n" &&
+	git bisect run --force ./test_script.sh >my_bisect_log.txt &&
+	grep "$HASH5 is the first bad commit" my_bisect_log.txt
+'
+
 test_done

base-commit: a26002b62827b89a19b1084bd75d9371d565d03c
-- 
gitgitgadget
