Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54EF7C38A02
	for <git@archiver.kernel.org>; Sun, 30 Oct 2022 11:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiJ3LzS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Oct 2022 07:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ3LzQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Oct 2022 07:55:16 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988ABBF63
        for <git@vger.kernel.org>; Sun, 30 Oct 2022 04:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1667130907; bh=LnbE6Om4mcxPaf3PE8ovErtbUYaLFVHrvTuJwnmX12Q=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=JYW0bwthBsKZY3hpXPty362rOS4jTQC1UEVGYdPFRYExAymOLahJdHnLfRVuFBrf3
         2DBC8Joxz+olczAT9s1tfDllH8f8hXB6GxMzQsgDKJ50XQa9YcGQJlxjUmh0XoGwqH
         EhclnT3qYpIeIHMMm4DzwmWj3tJb8zQDgSwLRdein6DN+s0GhT4KxSRSDTvxNZK2pj
         yq1qtdUkBvEWcTD8nsMrjuoWj7qHoSrPBVJt9e8ZwS/t8+/tPQArvshSZQq9s1gGv2
         GMnu0MvdiRdzU0ezjGyw7K2ebEySMHukSP+Nlf/JTNXVK6RgXb/6MBw2XCBBg8wNS8
         TZ+A1i0pE7oDA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.191]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M1rTQ-1omv2o40Xg-002DsB; Sun, 30
 Oct 2022 12:55:07 +0100
Message-ID: <0c13812c-dcb6-7319-4b41-ccba3f27a5fd@web.de>
Date:   Sun, 30 Oct 2022 12:55:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: [PATCH v2 12/12] replace and remove run_command_v_opt()
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <7407e074-4bd8-b351-7fa4-baf59b41880c@web.de>
 <ea061164-b36b-485c-963f-8c13e813a47e@web.de>
In-Reply-To: <ea061164-b36b-485c-963f-8c13e813a47e@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:47GRYJweGAtJL+otSY6gcfzrgwXIV46MeHT/RtBZRSk0yOiY8yx
 NOrXCQ6rzgjqkLXNHqUruyuaEVdgCtLVGsg5g3czU3DYLsKSL70ZmMXPnHkI/LLC45X5Eoj
 WI926ifeMf8YyfhuSeIlBwuMvM6aq5MsMrS0uLVR6L9GUmaWaEfekWGFTKhbcgLUv2tHdf8
 cpwIBSLgUIs2LvzAMNCOg==
UI-OutboundReport: notjunk:1;M01:P0:Xxgvo6PUsyo=;7y3+FrHDxFMHzCuIVn6oJl8pHPt
 8F/P0zdqebFY2Fdlp18RWyMfImMNGt2lW1zreXle4r36EOiwgfH+lNrnBTZCpsdKqG4qlCAI+
 /SNsr5InXr7JgliskQfnOTnr3nWhTLa+Pe1n4VVieexlri9/c33o53rePPPTqrAit5Y6dvVc6
 oKNioKX7eyHWHvtzzYRQJTNcSQnY/XMJp2OLG/m3OgyUak+FVky7Y23+ueiWE2eu2hYOgE6H9
 GIIfma7+LTR/aCJX24xV4kMjIB61GBXqqln4sNNPoEHjtRFe8FRgaeIjk6XYFvd8TiYRPnSfI
 jxBNZe48XQp3mA1CpMD+tqI0ldG2daINT1aRRJCw/KjYNYPLP8Jf8eiabtpa9o8KEmMSgbQLa
 7g+dOUIbGcbq45zQNKUHHJfvvLwVMSFemB3MIeKi+IqEtdPjtXE9hkMCIW8k3JLXChYWl6iyq
 avqVKHvMawi2P1g889G2U5hklheaDbOUsTNrWP8SXj7vmYqNb7HKWbu+KhfaDMmTCKVMAKTeQ
 O4jGlb67ydURwGZ0F0jSu1t8RAF152XHExy8vXfrJNbrIAsGXLp6Ij8QFqE+qzHUlcayWFK+S
 LVDKisE4AiOzN1nbEqSMe9ET9CJdp+4fSihpxXFTjrjpIKGGy6rHad63WAF2dnih3Sva6K/0E
 QZroLnWTmaaLdXKnTGvxO28JbApdR3ZxZxe6pdWgjmIGzkbOKDHpoZt3b0T0SIdy3WTWdCbaJ
 6E+AJw/AOj7n5+cuN3DtdmthJ9aaIQqUjoWwIQZtovi4c0LxzzNfYD/97DeKLLFr+5ZZaNr2Q
 HqROs4PGZCzuNdkm4w6m2qX6W5l8ccPtCf6CYL9jK+rgjR5nLVIlCRnjbZ79rZbQsAmwZs8rg
 UDu8fRs8N4XU7Gfw5td2c4GQHExNdIWp53Iaqqv6R7WN/Fy+VjynY2oBKXbktALM+38SupHlA
 2DQXkJ7DIQmayYGNF/1MDg0CW0E=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace the remaining calls of run_command_v_opt() with run_command()
calls and explict struct child_process variables.  This is more verbose,
but not by much overall.  The code becomes more flexible, e.g. it's easy
to extend to conditionally add a new argument.

Then remove the now unused function and its own flag names, simplifying
the run-command API.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 bisect.c                 |  9 +++++----
 builtin/am.c             |  9 +++++----
 builtin/bisect--helper.c | 15 ++++++++++-----
 builtin/clone.c          |  8 ++++++--
 builtin/difftool.c       |  7 +++++--
 builtin/fetch.c          |  9 ++++++---
 builtin/gc.c             | 41 +++++++++++++++++++++++++++++++---------
 builtin/merge-index.c    |  4 +++-
 run-command.c            | 15 ---------------
 run-command.h            | 23 +---------------------
 sequencer.c              |  6 ++++--
 shell.c                  | 17 ++++++++++++-----
 t/helper/test-trace2.c   |  4 +++-
 13 files changed, 92 insertions(+), 75 deletions(-)

diff --git a/bisect.c b/bisect.c
index 090aa5c4b4..ec7487e683 100644
=2D-- a/bisect.c
+++ b/bisect.c
@@ -737,11 +737,12 @@ enum bisect_error bisect_checkout(const struct objec=
t_id *bisect_rev,
 		update_ref(NULL, "BISECT_HEAD", bisect_rev, NULL, 0,
 			   UPDATE_REFS_DIE_ON_ERR);
 	} else {
-		const char *argv_checkout[] =3D {
-			"checkout", "-q", oid_to_hex(bisect_rev), "--", NULL
-		};
+		struct child_process cmd =3D CHILD_PROCESS_INIT;

-		if (run_command_v_opt(argv_checkout, RUN_GIT_CMD))
+		cmd.git_cmd =3D 1;
+		strvec_pushl(&cmd.args, "checkout", "-q",
+			     oid_to_hex(bisect_rev), "--", NULL);
+		if (run_command(&cmd))
 			/*
 			 * Errors in `run_command()` itself, signaled by res < 0,
 			 * and errors in the child process, signaled by res > 0
diff --git a/builtin/am.c b/builtin/am.c
index 5781e7a95e..20aea0d248 100644
=2D-- a/builtin/am.c
+++ b/builtin/am.c
@@ -2187,11 +2187,12 @@ static int show_patch(struct am_state *state, enum=
 show_patch_type sub_mode)
 	int len;

 	if (!is_null_oid(&state->orig_commit)) {
-		const char *av[] =3D {
-			"show", oid_to_hex(&state->orig_commit), "--", NULL
-		};
+		struct child_process cmd =3D CHILD_PROCESS_INIT;

-		return run_command_v_opt(av, RUN_GIT_CMD);
+		strvec_pushl(&cmd.args, "show", oid_to_hex(&state->orig_commit),
+			     "--", NULL);
+		cmd.git_cmd =3D 1;
+		return run_command(&cmd);
 	}

 	switch (sub_mode) {
diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 5c63ba6994..1d2ce8a0e1 100644
=2D-- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -764,10 +764,12 @@ static enum bisect_error bisect_start(struct bisect_=
terms *terms, const char **a
 		strbuf_read_file(&start_head, git_path_bisect_start(), 0);
 		strbuf_trim(&start_head);
 		if (!no_checkout) {
-			const char *argv[] =3D { "checkout", start_head.buf,
-					       "--", NULL };
+			struct child_process cmd =3D CHILD_PROCESS_INIT;

-			if (run_command_v_opt(argv, RUN_GIT_CMD)) {
+			cmd.git_cmd =3D 1;
+			strvec_pushl(&cmd.args, "checkout", start_head.buf,
+				     "--", NULL);
+			if (run_command(&cmd)) {
 				res =3D error(_("checking out '%s' failed."
 						 " Try 'git bisect start "
 						 "<valid-branch>'."),
@@ -1141,9 +1143,12 @@ static int get_first_good(const char *refname UNUSE=
D,

 static int do_bisect_run(const char *command)
 {
-	const char *argv[] =3D { command, NULL };
+	struct child_process cmd =3D CHILD_PROCESS_INIT;
+
 	printf(_("running %s\n"), command);
-	return run_command_v_opt(argv, RUN_USING_SHELL);
+	cmd.use_shell =3D 1;
+	strvec_push(&cmd.args, command);
+	return run_command(&cmd);
 }

 static int verify_good(const struct bisect_terms *terms, const char *comm=
and)
diff --git a/builtin/clone.c b/builtin/clone.c
index 56e7775dae..0e4348686b 100644
=2D-- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -865,11 +865,15 @@ static void write_refspec_config(const char *src_ref=
_prefix,

 static void dissociate_from_references(void)
 {
-	static const char* argv[] =3D { "repack", "-a", "-d", NULL };
 	char *alternates =3D git_pathdup("objects/info/alternates");

 	if (!access(alternates, F_OK)) {
-		if (run_command_v_opt(argv, RUN_GIT_CMD|RUN_COMMAND_NO_STDIN))
+		struct child_process cmd =3D CHILD_PROCESS_INIT;
+
+		cmd.git_cmd =3D 1;
+		cmd.no_stdin =3D 1;
+		strvec_pushl(&cmd.args, "repack", "-a", "-d", NULL);
+		if (run_command(&cmd))
 			die(_("cannot repack to clean up"));
 		if (unlink(alternates) && errno !=3D ENOENT)
 			die_errno(_("cannot unlink temporary alternates file"));
diff --git a/builtin/difftool.c b/builtin/difftool.c
index 22bcc3444b..d7f08c8a7f 100644
=2D-- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -44,8 +44,11 @@ static int difftool_config(const char *var, const char =
*value, void *cb)

 static int print_tool_help(void)
 {
-	const char *argv[] =3D { "mergetool", "--tool-help=3Ddiff", NULL };
-	return run_command_v_opt(argv, RUN_GIT_CMD);
+	struct child_process cmd =3D CHILD_PROCESS_INIT;
+
+	cmd.git_cmd =3D 1;
+	strvec_pushl(&cmd.args, "mergetool", "--tool-help=3Ddiff", NULL);
+	return run_command(&cmd);
 }

 static int parse_index_info(char *p, int *mode1, int *mode2,
diff --git a/builtin/fetch.c b/builtin/fetch.c
index b06e454cbd..7378cafeec 100644
=2D-- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1972,14 +1972,17 @@ static int fetch_multiple(struct string_list *list=
, int max_children)
 	} else
 		for (i =3D 0; i < list->nr; i++) {
 			const char *name =3D list->items[i].string;
-			strvec_push(&argv, name);
+			struct child_process cmd =3D CHILD_PROCESS_INIT;
+
+			strvec_pushv(&cmd.args, argv.v);
+			strvec_push(&cmd.args, name);
 			if (verbosity >=3D 0)
 				printf(_("Fetching %s\n"), name);
-			if (run_command_v_opt(argv.v, RUN_GIT_CMD)) {
+			cmd.git_cmd =3D 1;
+			if (run_command(&cmd)) {
 				error(_("could not fetch %s"), name);
 				result =3D 1;
 			}
-			strvec_pop(&argv);
 		}

 	strvec_clear(&argv);
diff --git a/builtin/gc.c b/builtin/gc.c
index a185bec813..6504c0b729 100644
=2D-- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -167,9 +167,11 @@ static void gc_config(void)
 struct maintenance_run_opts;
 static int maintenance_task_pack_refs(MAYBE_UNUSED struct maintenance_run=
_opts *opts)
 {
-	const char *argv[] =3D { "pack-refs", "--all", "--prune", NULL };
+	struct child_process cmd =3D CHILD_PROCESS_INIT;

-	return run_command_v_opt(argv, RUN_GIT_CMD);
+	cmd.git_cmd =3D 1;
+	strvec_pushl(&cmd.args, "pack-refs", "--all", "--prune", NULL);
+	return run_command(&cmd);
 }

 static int too_many_loose_objects(void)
@@ -535,8 +537,14 @@ static void gc_before_repack(void)
 	if (pack_refs && maintenance_task_pack_refs(NULL))
 		die(FAILED_RUN, "pack-refs");

-	if (prune_reflogs && run_command_v_opt(reflog.v, RUN_GIT_CMD))
-		die(FAILED_RUN, reflog.v[0]);
+	if (prune_reflogs) {
+		struct child_process cmd =3D CHILD_PROCESS_INIT;
+
+		cmd.git_cmd =3D 1;
+		strvec_pushv(&cmd.args, reflog.v);
+		if (run_command(&cmd))
+			die(FAILED_RUN, reflog.v[0]);
+	}
 }

 int cmd_gc(int argc, const char **argv, const char *prefix)
@@ -550,6 +558,7 @@ int cmd_gc(int argc, const char **argv, const char *pr=
efix)
 	int daemonized =3D 0;
 	int keep_largest_pack =3D -1;
 	timestamp_t dummy;
+	struct child_process rerere_cmd =3D CHILD_PROCESS_INIT;

 	struct option builtin_gc_options[] =3D {
 		OPT__QUIET(&quiet, N_("suppress progress reporting")),
@@ -671,11 +680,17 @@ int cmd_gc(int argc, const char **argv, const char *=
prefix)
 	gc_before_repack();

 	if (!repository_format_precious_objects) {
-		if (run_command_v_opt(repack.v,
-				      RUN_GIT_CMD | RUN_CLOSE_OBJECT_STORE))
+		struct child_process repack_cmd =3D CHILD_PROCESS_INIT;
+
+		repack_cmd.git_cmd =3D 1;
+		repack_cmd.close_object_store =3D 1;
+		strvec_pushv(&repack_cmd.args, repack.v);
+		if (run_command(&repack_cmd))
 			die(FAILED_RUN, repack.v[0]);

 		if (prune_expire) {
+			struct child_process prune_cmd =3D CHILD_PROCESS_INIT;
+
 			/* run `git prune` even if using cruft packs */
 			strvec_push(&prune, prune_expire);
 			if (quiet)
@@ -683,18 +698,26 @@ int cmd_gc(int argc, const char **argv, const char *=
prefix)
 			if (has_promisor_remote())
 				strvec_push(&prune,
 					    "--exclude-promisor-objects");
-			if (run_command_v_opt(prune.v, RUN_GIT_CMD))
+			prune_cmd.git_cmd =3D 1;
+			strvec_pushv(&prune_cmd.args, prune.v);
+			if (run_command(&prune_cmd))
 				die(FAILED_RUN, prune.v[0]);
 		}
 	}

 	if (prune_worktrees_expire) {
+		struct child_process prune_worktrees_cmd =3D CHILD_PROCESS_INIT;
+
 		strvec_push(&prune_worktrees, prune_worktrees_expire);
-		if (run_command_v_opt(prune_worktrees.v, RUN_GIT_CMD))
+		prune_worktrees_cmd.git_cmd =3D 1;
+		strvec_pushv(&prune_worktrees_cmd.args, prune_worktrees.v);
+		if (run_command(&prune_worktrees_cmd))
 			die(FAILED_RUN, prune_worktrees.v[0]);
 	}

-	if (run_command_v_opt(rerere.v, RUN_GIT_CMD))
+	rerere_cmd.git_cmd =3D 1;
+	strvec_pushv(&rerere_cmd.args, rerere.v);
+	if (run_command(&rerere_cmd))
 		die(FAILED_RUN, rerere.v[0]);

 	report_garbage =3D report_pack_garbage;
diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index c0383fe9df..012f52bd00 100644
=2D-- a/builtin/merge-index.c
+++ b/builtin/merge-index.c
@@ -12,6 +12,7 @@ static int merge_entry(int pos, const char *path)
 	const char *arguments[] =3D { pgm, "", "", "", path, "", "", "", NULL };
 	char hexbuf[4][GIT_MAX_HEXSZ + 1];
 	char ownbuf[4][60];
+	struct child_process cmd =3D CHILD_PROCESS_INIT;

 	if (pos >=3D active_nr)
 		die("git merge-index: %s not in the cache", path);
@@ -31,7 +32,8 @@ static int merge_entry(int pos, const char *path)
 	if (!found)
 		die("git merge-index: %s not in the cache", path);

-	if (run_command_v_opt(arguments, 0)) {
+	strvec_pushv(&cmd.args, arguments);
+	if (run_command(&cmd)) {
 		if (one_shot)
 			err++;
 		else {
diff --git a/run-command.c b/run-command.c
index f8f810d755..48b9ba6d6f 100644
=2D-- a/run-command.c
+++ b/run-command.c
@@ -1004,21 +1004,6 @@ int run_command(struct child_process *cmd)
 	return finish_command(cmd);
 }

-int run_command_v_opt(const char **argv, int opt)
-{
-	struct child_process cmd =3D CHILD_PROCESS_INIT;
-	strvec_pushv(&cmd.args, argv);
-	cmd.no_stdin =3D opt & RUN_COMMAND_NO_STDIN ? 1 : 0;
-	cmd.git_cmd =3D opt & RUN_GIT_CMD ? 1 : 0;
-	cmd.stdout_to_stderr =3D opt & RUN_COMMAND_STDOUT_TO_STDERR ? 1 : 0;
-	cmd.silent_exec_failure =3D opt & RUN_SILENT_EXEC_FAILURE ? 1 : 0;
-	cmd.use_shell =3D opt & RUN_USING_SHELL ? 1 : 0;
-	cmd.clean_on_exit =3D opt & RUN_CLEAN_ON_EXIT ? 1 : 0;
-	cmd.wait_after_clean =3D opt & RUN_WAIT_AFTER_CLEAN ? 1 : 0;
-	cmd.close_object_store =3D opt & RUN_CLOSE_OBJECT_STORE ? 1 : 0;
-	return run_command(&cmd);
-}
-
 #ifndef NO_PTHREADS
 static pthread_t main_thread;
 static int main_thread_set;
diff --git a/run-command.h b/run-command.h
index 4391696bf0..072db56a4d 100644
=2D-- a/run-command.h
+++ b/run-command.h
@@ -150,8 +150,7 @@ struct child_process {
 }

 /**
- * The functions: start_command, finish_command, run_command,
- * run_command_v_opt do the following:
+ * The functions: start_command, finish_command, run_command do the follo=
wing:
  *
  * - If a system call failed, errno is set and -1 is returned. A diagnost=
ic
  *   is printed.
@@ -223,26 +222,6 @@ int run_command(struct child_process *);
  */
 int run_auto_maintenance(int quiet);

-#define RUN_COMMAND_NO_STDIN		(1<<0)
-#define RUN_GIT_CMD			(1<<1)
-#define RUN_COMMAND_STDOUT_TO_STDERR	(1<<2)
-#define RUN_SILENT_EXEC_FAILURE		(1<<3)
-#define RUN_USING_SHELL			(1<<4)
-#define RUN_CLEAN_ON_EXIT		(1<<5)
-#define RUN_WAIT_AFTER_CLEAN		(1<<6)
-#define RUN_CLOSE_OBJECT_STORE		(1<<7)
-
-/**
- * Convenience function that encapsulates a sequence of
- * start_command() followed by finish_command(). The argument argv
- * specifies the program and its arguments. The argument opt is zero
- * or more of the flags `RUN_COMMAND_NO_STDIN`, `RUN_GIT_CMD`,
- * `RUN_COMMAND_STDOUT_TO_STDERR`, or `RUN_SILENT_EXEC_FAILURE`
- * that correspond to the members .no_stdin, .git_cmd,
- * .stdout_to_stderr, .silent_exec_failure of `struct child_process`.
- */
-int run_command_v_opt(const char **argv, int opt);
-
 /**
  * Execute the given command, sending "in" to its stdin, and capturing it=
s
  * stdout and stderr in the "out" and "err" strbufs. Any of the three may
diff --git a/sequencer.c b/sequencer.c
index 31e24f38f8..643744fb9b 100644
=2D-- a/sequencer.c
+++ b/sequencer.c
@@ -3555,11 +3555,13 @@ static int error_failed_squash(struct repository *=
r,

 static int do_exec(struct repository *r, const char *command_line)
 {
-	const char *child_argv[] =3D { command_line, NULL };
+	struct child_process cmd =3D CHILD_PROCESS_INIT;
 	int dirty, status;

 	fprintf(stderr, _("Executing: %s\n"), command_line);
-	status =3D run_command_v_opt(child_argv, RUN_USING_SHELL);
+	cmd.use_shell =3D 1;
+	strvec_push(&cmd.args, command_line);
+	status =3D run_command(&cmd);

 	/* force re-reading of the cache */
 	if (discard_index(r->index) < 0 || repo_read_index(r) < 0)
diff --git a/shell.c b/shell.c
index 7ff4109db7..af0d7c734f 100644
=2D-- a/shell.c
+++ b/shell.c
@@ -52,21 +52,24 @@ static void cd_to_homedir(void)
 static void run_shell(void)
 {
 	int done =3D 0;
-	static const char *help_argv[] =3D { HELP_COMMAND, NULL };
+	struct child_process help_cmd =3D CHILD_PROCESS_INIT;

 	if (!access(NOLOGIN_COMMAND, F_OK)) {
 		/* Interactive login disabled. */
-		const char *argv[] =3D { NOLOGIN_COMMAND, NULL };
+		struct child_process nologin_cmd =3D CHILD_PROCESS_INIT;
 		int status;

-		status =3D run_command_v_opt(argv, 0);
+		strvec_push(&nologin_cmd.args, NOLOGIN_COMMAND);
+		status =3D run_command(&nologin_cmd);
 		if (status < 0)
 			exit(127);
 		exit(status);
 	}

 	/* Print help if enabled */
-	run_command_v_opt(help_argv, RUN_SILENT_EXEC_FAILURE);
+	help_cmd.silent_exec_failure =3D 1;
+	strvec_push(&help_cmd.args, HELP_COMMAND);
+	run_command(&help_cmd);

 	do {
 		const char *prog;
@@ -125,9 +128,13 @@ static void run_shell(void)
 			   !strcmp(prog, "exit") || !strcmp(prog, "bye")) {
 			done =3D 1;
 		} else if (is_valid_cmd_name(prog)) {
+			struct child_process cmd =3D CHILD_PROCESS_INIT;
+
 			full_cmd =3D make_cmd(prog);
 			argv[0] =3D full_cmd;
-			code =3D run_command_v_opt(argv, RUN_SILENT_EXEC_FAILURE);
+			cmd.silent_exec_failure =3D 1;
+			strvec_pushv(&cmd.args, argv);
+			code =3D run_command(&cmd);
 			if (code =3D=3D -1 && errno =3D=3D ENOENT) {
 				fprintf(stderr, "unrecognized command '%s'\n", prog);
 			}
diff --git a/t/helper/test-trace2.c b/t/helper/test-trace2.c
index a714130ece..94fd8ccf51 100644
=2D-- a/t/helper/test-trace2.c
+++ b/t/helper/test-trace2.c
@@ -132,6 +132,7 @@ static int ut_003error(int argc, const char **argv)
  */
 static int ut_004child(int argc, const char **argv)
 {
+	struct child_process cmd =3D CHILD_PROCESS_INIT;
 	int result;

 	/*
@@ -141,7 +142,8 @@ static int ut_004child(int argc, const char **argv)
 	if (!argc)
 		return 0;

-	result =3D run_command_v_opt(argv, 0);
+	strvec_pushv(&cmd.args, argv);
+	result =3D run_command(&cmd);
 	exit(result);
 }

=2D-
2.38.1
