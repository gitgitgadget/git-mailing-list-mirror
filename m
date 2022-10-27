Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0EDAECAAA1
	for <git@archiver.kernel.org>; Thu, 27 Oct 2022 16:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236452AbiJ0Qg6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Oct 2022 12:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235972AbiJ0Qg5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2022 12:36:57 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979A41867BD
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 09:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1666888606; bh=B4xJqkKObNOkFhbRWHLJUXMZH56oAE9dklMoBG56oW4=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=o2wlLKvUtGtPqnsWVQn/hQwNOhMGsZmHX0SXj0na54PIeRvjl5vYnEGF24N3wkcab
         xH/K0W6bgDwFjQu/4AVM2Ed4E+vxo5vZUylxBEyp3PBeyM/WE7LrEuHR2d8NmLvTVE
         wC59hgNHEiiFAlVzYxFluicpnSJBIFawywuCowBZT5Las/VImXe5gss0GdakZc4aU5
         X1xQjQpfwMF7FKm+zFC3mgihzgGkJQiMcpv42Ze7Dugjs7sgfOyeu8XyUjARhTSjxt
         MuxdXSDTW/23WlC8e2gQvc0ThBZ+4wK+ZIsnz5FESP1VOBrZ7xzleX/P2QcrVg4uDE
         70UOxjt0eBEig==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.191]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MKdLM-1oVTcY0eJI-00Kz6z; Thu, 27
 Oct 2022 18:36:46 +0200
Message-ID: <672e4176-81b4-bb9c-5a14-e558d24b0c0d@web.de>
Date:   Thu, 27 Oct 2022 18:36:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: [PATCH 3/8] use child_process members "args" and "env" directly
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <7407e074-4bd8-b351-7fa4-baf59b41880c@web.de>
In-Reply-To: <7407e074-4bd8-b351-7fa4-baf59b41880c@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/i1Y1VGkliXBewUAqg/6AHqgPaTiN0r0fgXfbbOP9n0dmnHtYH2
 htZS2/CfIOi8DXqMsQI2vue/lPC5ZlEPlrtkZn85o0YYOZJsL2kB6XN0o1FP0vh7DBu91P9
 Ye+pt2oX64P8WEUtstrfTkchuoX0mqMPokxQJvCzUB1epwjmxetDHfs3MJGYJoBHrF1sose
 ZlZ15zHv2UmIiTQ6ydmdQ==
UI-OutboundReport: notjunk:1;M01:P0:vfFzVVzSGbY=;lT/uo7LRhfXhSdk9L4fvdQtvvI6
 UprmvOHT9IfwzHwF6aM7MjrjFQZ4lrPuq3hLKDKKcS9kolj9bQR4dU6DOVCoSYSFfOsY0Pxke
 xZD6n231tLkCWfW9rrpAK0t3aUCGuLOVKCAN491JSVMj7ns6IMFw3DbIRzD8P6iB9GbdWQz5/
 AM+wn/1XV6MqJ18ZQ3QVGysaS1D1Ensvo45Yx8qQJ2ll935HvroTm+gET03pPME2a0xvnbXM5
 D5J29SzD7ph12QKXgsQBFRJgjrMY1GdL5Cg1rjrEmSV58iRVgzlmK/N52yD+yG/z7ls8rqJK7
 eMUibrm69+NkTMPAJrgfZjmeTwjLfVJ36adV1tfLQNNNEeXqsVsc7dDqkRrs7kW+AgTEcM5fz
 Kd8MtBCGD7tEQ9jistw40QhAJfBZNc3N/Z+/hZI9XecvafQzJVfRhgm1G0DXU08HjaomIaZbI
 EEp4kUYYReuZhfQuKIe0d7xHUi4MpInOEIKlRX1qf1997qjH53lPaETKgoxa75WZ9g+07GktM
 E02hsi2EK1xcd5E6WmkuDbxn5b8gU9kgvnI7kAqcIvpaotuLqXwYRV8DZOPhiOAyb22ZeFuX6
 pGEDzfzqCbzipM5TFLIWJX8c71IWlFyllZmE+kwsjL7yomh60pLoJocJDNKraQSZrL++df+iK
 6b9nEYJEbNxKm68NZnE0RVIXGSOdYTAjv9+JafN85VHqkdcrsdcbKxZKL56ATd0FepgdPE3kN
 ErqD0BaCnjFatEyY7harNhqcH1ekGJQw/M6ga0gUM26r1kllDV/b3nNZpBvNlga0NR5Ya24eK
 lYjL0OhsjXGfy73WNu/IK8sbp9pdlkD/S0qMT2h30a+MIAy/j0CC89HGjlaWY9rvUC+qIzpes
 VQ7UlMtyaS8a7K7TXLkFcDFEXF1SLyZrzVIb4flD0hF6SBJMExXpnALDfP6NaGuPife+ryzmd
 uJaUC6KV3kBF34kxkyoHmEQbZYo=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Build argument list and environment of child processes by using
struct child_process and populating its members "args" and "env"
directly instead of maintaining separate strvecs and letting
run_command_v_opt() and friends populate these members.  This is
simpler, shorter and slightly more efficient.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 add-interactive.c        |   9 ++-
 builtin/add.c            |  19 +++--
 builtin/bisect--helper.c |  35 +++++-----
 builtin/clone.c          |  33 ++++-----
 builtin/gc.c             |  14 ++--
 builtin/merge.c          |  10 +--
 builtin/pull.c           | 147 +++++++++++++++++++--------------------
 builtin/remote.c         |  26 ++++---
 diff.c                   |  27 ++++---
 git.c                    |  15 ++--
 merge.c                  |  18 ++---
 scalar.c                 |  13 ++--
 sequencer.c              |  25 +++----
 13 files changed, 185 insertions(+), 206 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index f071b2a1b4..ecc5ae1b24 100644
=2D-- a/add-interactive.c
+++ b/add-interactive.c
@@ -997,18 +997,17 @@ static int run_diff(struct add_i_state *s, const str=
uct pathspec *ps,
 	count =3D list_and_choose(s, files, opts);
 	opts->flags =3D 0;
 	if (count > 0) {
-		struct strvec args =3D STRVEC_INIT;
+		struct child_process cmd =3D CHILD_PROCESS_INIT;

-		strvec_pushl(&args, "git", "diff", "-p", "--cached",
+		strvec_pushl(&cmd.args, "git", "diff", "-p", "--cached",
 			     oid_to_hex(!is_initial ? &oid :
 					s->r->hash_algo->empty_tree),
 			     "--", NULL);
 		for (i =3D 0; i < files->items.nr; i++)
 			if (files->selected[i])
-				strvec_push(&args,
+				strvec_push(&cmd.args,
 					    files->items.items[i].string);
-		res =3D run_command_v_opt(args.v, 0);
-		strvec_clear(&args);
+		res =3D run_command(&cmd);
 	}

 	putchar('\n');
diff --git a/builtin/add.c b/builtin/add.c
index f84372964c..626c71ec6a 100644
=2D-- a/builtin/add.c
+++ b/builtin/add.c
@@ -240,8 +240,8 @@ static int refresh(int verbose, const struct pathspec =
*pathspec)
 int run_add_interactive(const char *revision, const char *patch_mode,
 			const struct pathspec *pathspec)
 {
-	int status, i;
-	struct strvec argv =3D STRVEC_INIT;
+	int i;
+	struct child_process cmd =3D CHILD_PROCESS_INIT;
 	int use_builtin_add_i =3D
 		git_env_bool("GIT_TEST_ADD_I_USE_BUILTIN", -1);

@@ -272,19 +272,18 @@ int run_add_interactive(const char *revision, const =
char *patch_mode,
 		return !!run_add_p(the_repository, mode, revision, pathspec);
 	}

-	strvec_push(&argv, "add--interactive");
+	strvec_push(&cmd.args, "add--interactive");
 	if (patch_mode)
-		strvec_push(&argv, patch_mode);
+		strvec_push(&cmd.args, patch_mode);
 	if (revision)
-		strvec_push(&argv, revision);
-	strvec_push(&argv, "--");
+		strvec_push(&cmd.args, revision);
+	strvec_push(&cmd.args, "--");
 	for (i =3D 0; i < pathspec->nr; i++)
 		/* pass original pathspec, to be re-parsed */
-		strvec_push(&argv, pathspec->items[i].original);
+		strvec_push(&cmd.args, pathspec->items[i].original);

-	status =3D run_command_v_opt(argv.v, RUN_GIT_CMD);
-	strvec_clear(&argv);
-	return status;
+	cmd.git_cmd =3D 1;
+	return run_command(&cmd);
 }

 int interactive_add(const char **argv, const char *prefix, int patch)
diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 70d1e9d1ad..5c63ba6994 100644
=2D-- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -220,18 +220,17 @@ static int bisect_reset(const char *commit)
 	}

 	if (!ref_exists("BISECT_HEAD")) {
-		struct strvec argv =3D STRVEC_INIT;
+		struct child_process cmd =3D CHILD_PROCESS_INIT;

-		strvec_pushl(&argv, "checkout", branch.buf, "--", NULL);
-		if (run_command_v_opt(argv.v, RUN_GIT_CMD)) {
+		cmd.git_cmd =3D 1;
+		strvec_pushl(&cmd.args, "checkout", branch.buf, "--", NULL);
+		if (run_command(&cmd)) {
 			error(_("could not check out original"
 				" HEAD '%s'. Try 'git bisect"
 				" reset <commit>'."), branch.buf);
 			strbuf_release(&branch);
-			strvec_clear(&argv);
 			return -1;
 		}
-		strvec_clear(&argv);
 	}

 	strbuf_release(&branch);
@@ -1098,40 +1097,38 @@ static enum bisect_error bisect_skip(struct bisect=
_terms *terms, const char **ar

 static int bisect_visualize(struct bisect_terms *terms, const char **argv=
, int argc)
 {
-	struct strvec args =3D STRVEC_INIT;
-	int flags =3D RUN_COMMAND_NO_STDIN, res =3D 0;
+	struct child_process cmd =3D CHILD_PROCESS_INIT;
 	struct strbuf sb =3D STRBUF_INIT;

 	if (bisect_next_check(terms, NULL) !=3D 0)
 		return BISECT_FAILED;

+	cmd.no_stdin =3D 1;
 	if (!argc) {
 		if ((getenv("DISPLAY") || getenv("SESSIONNAME") || getenv("MSYSTEM") ||
 		     getenv("SECURITYSESSIONID")) && exists_in_PATH("gitk")) {
-			strvec_push(&args, "gitk");
+			strvec_push(&cmd.args, "gitk");
 		} else {
-			strvec_push(&args, "log");
-			flags |=3D RUN_GIT_CMD;
+			strvec_push(&cmd.args, "log");
+			cmd.git_cmd =3D 1;
 		}
 	} else {
 		if (argv[0][0] =3D=3D '-') {
-			strvec_push(&args, "log");
-			flags |=3D RUN_GIT_CMD;
+			strvec_push(&cmd.args, "log");
+			cmd.git_cmd =3D 1;
 		} else if (strcmp(argv[0], "tig") && !starts_with(argv[0], "git"))
-			flags |=3D RUN_GIT_CMD;
+			cmd.git_cmd =3D 1;

-		strvec_pushv(&args, argv);
+		strvec_pushv(&cmd.args, argv);
 	}

-	strvec_pushl(&args, "--bisect", "--", NULL);
+	strvec_pushl(&cmd.args, "--bisect", "--", NULL);

 	strbuf_read_file(&sb, git_path_bisect_names(), 0);
-	sq_dequote_to_strvec(sb.buf, &args);
+	sq_dequote_to_strvec(sb.buf, &cmd.args);
 	strbuf_release(&sb);

-	res =3D run_command_v_opt(args.v, flags);
-	strvec_clear(&args);
-	return res;
+	return run_command(&cmd);
 }

 static int get_first_good(const char *refname UNUSED,
diff --git a/builtin/clone.c b/builtin/clone.c
index 547d6464b3..56e7775dae 100644
=2D-- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -653,9 +653,9 @@ static void update_head(const struct ref *our, const s=
truct ref *remote,

 static int git_sparse_checkout_init(const char *repo)
 {
-	struct strvec argv =3D STRVEC_INIT;
+	struct child_process cmd =3D CHILD_PROCESS_INIT;
 	int result =3D 0;
-	strvec_pushl(&argv, "-C", repo, "sparse-checkout", "set", NULL);
+	strvec_pushl(&cmd.args, "-C", repo, "sparse-checkout", "set", NULL);

 	/*
 	 * We must apply the setting in the current process
@@ -663,12 +663,12 @@ static int git_sparse_checkout_init(const char *repo=
)
 	 */
 	core_apply_sparse_checkout =3D 1;

-	if (run_command_v_opt(argv.v, RUN_GIT_CMD)) {
+	cmd.git_cmd =3D 1;
+	if (run_command(&cmd)) {
 		error(_("failed to initialize sparse-checkout"));
 		result =3D 1;
 	}

-	strvec_clear(&argv);
 	return result;
 }

@@ -733,37 +733,38 @@ static int checkout(int submodule_progress, int filt=
er_submodules)
 			   oid_to_hex(&oid), "1", NULL);

 	if (!err && (option_recurse_submodules.nr > 0)) {
-		struct strvec args =3D STRVEC_INIT;
-		strvec_pushl(&args, "submodule", "update", "--require-init", "--recursi=
ve", NULL);
+		struct child_process cmd =3D CHILD_PROCESS_INIT;
+		strvec_pushl(&cmd.args, "submodule", "update", "--require-init",
+			     "--recursive", NULL);

 		if (option_shallow_submodules =3D=3D 1)
-			strvec_push(&args, "--depth=3D1");
+			strvec_push(&cmd.args, "--depth=3D1");

 		if (max_jobs !=3D -1)
-			strvec_pushf(&args, "--jobs=3D%d", max_jobs);
+			strvec_pushf(&cmd.args, "--jobs=3D%d", max_jobs);

 		if (submodule_progress)
-			strvec_push(&args, "--progress");
+			strvec_push(&cmd.args, "--progress");

 		if (option_verbosity < 0)
-			strvec_push(&args, "--quiet");
+			strvec_push(&cmd.args, "--quiet");

 		if (option_remote_submodules) {
-			strvec_push(&args, "--remote");
-			strvec_push(&args, "--no-fetch");
+			strvec_push(&cmd.args, "--remote");
+			strvec_push(&cmd.args, "--no-fetch");
 		}

 		if (filter_submodules && filter_options.choice)
-			strvec_pushf(&args, "--filter=3D%s",
+			strvec_pushf(&cmd.args, "--filter=3D%s",
 				     expand_list_objects_filter_spec(&filter_options));

 		if (option_single_branch >=3D 0)
-			strvec_push(&args, option_single_branch ?
+			strvec_push(&cmd.args, option_single_branch ?
 					       "--single-branch" :
 					       "--no-single-branch");

-		err =3D run_command_v_opt(args.v, RUN_GIT_CMD);
-		strvec_clear(&args);
+		cmd.git_cmd =3D 1;
+		err =3D run_command(&cmd);
 	}

 	return err;
diff --git a/builtin/gc.c b/builtin/gc.c
index 243ee85d28..87ad0077d8 100644
=2D-- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1910,20 +1910,16 @@ static char *schtasks_task_name(const char *freque=
ncy)
 static int schtasks_remove_task(enum schedule_priority schedule)
 {
 	const char *cmd =3D "schtasks";
-	int result;
-	struct strvec args =3D STRVEC_INIT;
+	struct child_process child =3D CHILD_PROCESS_INIT;
 	const char *frequency =3D get_frequency(schedule);
 	char *name =3D schtasks_task_name(frequency);

 	get_schedule_cmd(&cmd, NULL);
-	strvec_split(&args, cmd);
-	strvec_pushl(&args, "/delete", "/tn", name, "/f", NULL);
-
-	result =3D run_command_v_opt(args.v, 0);
-
-	strvec_clear(&args);
+	strvec_split(&child.args, cmd);
+	strvec_pushl(&child.args, "/delete", "/tn", name, "/f", NULL);
 	free(name);
-	return result;
+
+	return run_command(&child);
 }

 static int schtasks_remove_tasks(void)
diff --git a/builtin/merge.c b/builtin/merge.c
index 3bb49d805b..864808f51a 100644
=2D-- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -380,22 +380,22 @@ static void reset_hard(const struct object_id *oid)
 static void restore_state(const struct object_id *head,
 			  const struct object_id *stash)
 {
-	struct strvec args =3D STRVEC_INIT;
+	struct child_process cmd =3D CHILD_PROCESS_INIT;

 	reset_hard(head);

 	if (is_null_oid(stash))
 		goto refresh_cache;

-	strvec_pushl(&args, "stash", "apply", "--index", "--quiet", NULL);
-	strvec_push(&args, oid_to_hex(stash));
+	strvec_pushl(&cmd.args, "stash", "apply", "--index", "--quiet", NULL);
+	strvec_push(&cmd.args, oid_to_hex(stash));

 	/*
 	 * It is OK to ignore error here, for example when there was
 	 * nothing to restore.
 	 */
-	run_command_v_opt(args.v, RUN_GIT_CMD);
-	strvec_clear(&args);
+	cmd.git_cmd =3D 1;
+	run_command(&cmd);

 refresh_cache:
 	if (discard_cache() < 0 || read_cache() < 0)
diff --git a/builtin/pull.c b/builtin/pull.c
index 403a24d7ca..b21edd767a 100644
=2D-- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -515,76 +515,75 @@ static void parse_repo_refspecs(int argc, const char=
 **argv, const char **repo,
  */
 static int run_fetch(const char *repo, const char **refspecs)
 {
-	struct strvec args =3D STRVEC_INIT;
-	int ret;
+	struct child_process cmd =3D CHILD_PROCESS_INIT;

-	strvec_pushl(&args, "fetch", "--update-head-ok", NULL);
+	strvec_pushl(&cmd.args, "fetch", "--update-head-ok", NULL);

 	/* Shared options */
-	argv_push_verbosity(&args);
+	argv_push_verbosity(&cmd.args);
 	if (opt_progress)
-		strvec_push(&args, opt_progress);
+		strvec_push(&cmd.args, opt_progress);

 	/* Options passed to git-fetch */
 	if (opt_all)
-		strvec_push(&args, opt_all);
+		strvec_push(&cmd.args, opt_all);
 	if (opt_append)
-		strvec_push(&args, opt_append);
+		strvec_push(&cmd.args, opt_append);
 	if (opt_upload_pack)
-		strvec_push(&args, opt_upload_pack);
-	argv_push_force(&args);
+		strvec_push(&cmd.args, opt_upload_pack);
+	argv_push_force(&cmd.args);
 	if (opt_tags)
-		strvec_push(&args, opt_tags);
+		strvec_push(&cmd.args, opt_tags);
 	if (opt_prune)
-		strvec_push(&args, opt_prune);
+		strvec_push(&cmd.args, opt_prune);
 	if (recurse_submodules_cli !=3D RECURSE_SUBMODULES_DEFAULT)
 		switch (recurse_submodules_cli) {
 		case RECURSE_SUBMODULES_ON:
-			strvec_push(&args, "--recurse-submodules=3Don");
+			strvec_push(&cmd.args, "--recurse-submodules=3Don");
 			break;
 		case RECURSE_SUBMODULES_OFF:
-			strvec_push(&args, "--recurse-submodules=3Dno");
+			strvec_push(&cmd.args, "--recurse-submodules=3Dno");
 			break;
 		case RECURSE_SUBMODULES_ON_DEMAND:
-			strvec_push(&args, "--recurse-submodules=3Don-demand");
+			strvec_push(&cmd.args, "--recurse-submodules=3Don-demand");
 			break;
 		default:
 			BUG("submodule recursion option not understood");
 		}
 	if (max_children)
-		strvec_push(&args, max_children);
+		strvec_push(&cmd.args, max_children);
 	if (opt_dry_run)
-		strvec_push(&args, "--dry-run");
+		strvec_push(&cmd.args, "--dry-run");
 	if (opt_keep)
-		strvec_push(&args, opt_keep);
+		strvec_push(&cmd.args, opt_keep);
 	if (opt_depth)
-		strvec_push(&args, opt_depth);
+		strvec_push(&cmd.args, opt_depth);
 	if (opt_unshallow)
-		strvec_push(&args, opt_unshallow);
+		strvec_push(&cmd.args, opt_unshallow);
 	if (opt_update_shallow)
-		strvec_push(&args, opt_update_shallow);
+		strvec_push(&cmd.args, opt_update_shallow);
 	if (opt_refmap)
-		strvec_push(&args, opt_refmap);
+		strvec_push(&cmd.args, opt_refmap);
 	if (opt_ipv4)
-		strvec_push(&args, opt_ipv4);
+		strvec_push(&cmd.args, opt_ipv4);
 	if (opt_ipv6)
-		strvec_push(&args, opt_ipv6);
+		strvec_push(&cmd.args, opt_ipv6);
 	if (opt_show_forced_updates > 0)
-		strvec_push(&args, "--show-forced-updates");
+		strvec_push(&cmd.args, "--show-forced-updates");
 	else if (opt_show_forced_updates =3D=3D 0)
-		strvec_push(&args, "--no-show-forced-updates");
+		strvec_push(&cmd.args, "--no-show-forced-updates");
 	if (set_upstream)
-		strvec_push(&args, set_upstream);
-	strvec_pushv(&args, opt_fetch.v);
+		strvec_push(&cmd.args, set_upstream);
+	strvec_pushv(&cmd.args, opt_fetch.v);

 	if (repo) {
-		strvec_push(&args, repo);
-		strvec_pushv(&args, refspecs);
+		strvec_push(&cmd.args, repo);
+		strvec_pushv(&cmd.args, refspecs);
 	} else if (*refspecs)
 		BUG("refspecs without repo?");
-	ret =3D run_command_v_opt(args.v, RUN_GIT_CMD | RUN_CLOSE_OBJECT_STORE);
-	strvec_clear(&args);
-	return ret;
+	cmd.git_cmd =3D 1;
+	cmd.close_object_store =3D 1;
+	return run_command(&cmd);
 }

 /**
@@ -653,52 +652,50 @@ static int update_submodules(void)
  */
 static int run_merge(void)
 {
-	int ret;
-	struct strvec args =3D STRVEC_INIT;
+	struct child_process cmd =3D CHILD_PROCESS_INIT;

-	strvec_pushl(&args, "merge", NULL);
+	strvec_pushl(&cmd.args, "merge", NULL);

 	/* Shared options */
-	argv_push_verbosity(&args);
+	argv_push_verbosity(&cmd.args);
 	if (opt_progress)
-		strvec_push(&args, opt_progress);
+		strvec_push(&cmd.args, opt_progress);

 	/* Options passed to git-merge */
 	if (opt_diffstat)
-		strvec_push(&args, opt_diffstat);
+		strvec_push(&cmd.args, opt_diffstat);
 	if (opt_log)
-		strvec_push(&args, opt_log);
+		strvec_push(&cmd.args, opt_log);
 	if (opt_signoff)
-		strvec_push(&args, opt_signoff);
+		strvec_push(&cmd.args, opt_signoff);
 	if (opt_squash)
-		strvec_push(&args, opt_squash);
+		strvec_push(&cmd.args, opt_squash);
 	if (opt_commit)
-		strvec_push(&args, opt_commit);
+		strvec_push(&cmd.args, opt_commit);
 	if (opt_edit)
-		strvec_push(&args, opt_edit);
+		strvec_push(&cmd.args, opt_edit);
 	if (cleanup_arg)
-		strvec_pushf(&args, "--cleanup=3D%s", cleanup_arg);
+		strvec_pushf(&cmd.args, "--cleanup=3D%s", cleanup_arg);
 	if (opt_ff)
-		strvec_push(&args, opt_ff);
+		strvec_push(&cmd.args, opt_ff);
 	if (opt_verify)
-		strvec_push(&args, opt_verify);
+		strvec_push(&cmd.args, opt_verify);
 	if (opt_verify_signatures)
-		strvec_push(&args, opt_verify_signatures);
-	strvec_pushv(&args, opt_strategies.v);
-	strvec_pushv(&args, opt_strategy_opts.v);
+		strvec_push(&cmd.args, opt_verify_signatures);
+	strvec_pushv(&cmd.args, opt_strategies.v);
+	strvec_pushv(&cmd.args, opt_strategy_opts.v);
 	if (opt_gpg_sign)
-		strvec_push(&args, opt_gpg_sign);
+		strvec_push(&cmd.args, opt_gpg_sign);
 	if (opt_autostash =3D=3D 0)
-		strvec_push(&args, "--no-autostash");
+		strvec_push(&cmd.args, "--no-autostash");
 	else if (opt_autostash =3D=3D 1)
-		strvec_push(&args, "--autostash");
+		strvec_push(&cmd.args, "--autostash");
 	if (opt_allow_unrelated_histories > 0)
-		strvec_push(&args, "--allow-unrelated-histories");
+		strvec_push(&cmd.args, "--allow-unrelated-histories");

-	strvec_push(&args, "FETCH_HEAD");
-	ret =3D run_command_v_opt(args.v, RUN_GIT_CMD);
-	strvec_clear(&args);
-	return ret;
+	strvec_push(&cmd.args, "FETCH_HEAD");
+	cmd.git_cmd =3D 1;
+	return run_command(&cmd);
 }

 /**
@@ -879,43 +876,41 @@ static int get_rebase_newbase_and_upstream(struct ob=
ject_id *newbase,
 static int run_rebase(const struct object_id *newbase,
 		const struct object_id *upstream)
 {
-	int ret;
-	struct strvec args =3D STRVEC_INIT;
+	struct child_process cmd =3D CHILD_PROCESS_INIT;

-	strvec_push(&args, "rebase");
+	strvec_push(&cmd.args, "rebase");

 	/* Shared options */
-	argv_push_verbosity(&args);
+	argv_push_verbosity(&cmd.args);

 	/* Options passed to git-rebase */
 	if (opt_rebase =3D=3D REBASE_MERGES)
-		strvec_push(&args, "--rebase-merges");
+		strvec_push(&cmd.args, "--rebase-merges");
 	else if (opt_rebase =3D=3D REBASE_INTERACTIVE)
-		strvec_push(&args, "--interactive");
+		strvec_push(&cmd.args, "--interactive");
 	if (opt_diffstat)
-		strvec_push(&args, opt_diffstat);
-	strvec_pushv(&args, opt_strategies.v);
-	strvec_pushv(&args, opt_strategy_opts.v);
+		strvec_push(&cmd.args, opt_diffstat);
+	strvec_pushv(&cmd.args, opt_strategies.v);
+	strvec_pushv(&cmd.args, opt_strategy_opts.v);
 	if (opt_gpg_sign)
-		strvec_push(&args, opt_gpg_sign);
+		strvec_push(&cmd.args, opt_gpg_sign);
 	if (opt_signoff)
-		strvec_push(&args, opt_signoff);
+		strvec_push(&cmd.args, opt_signoff);
 	if (opt_autostash =3D=3D 0)
-		strvec_push(&args, "--no-autostash");
+		strvec_push(&cmd.args, "--no-autostash");
 	else if (opt_autostash =3D=3D 1)
-		strvec_push(&args, "--autostash");
+		strvec_push(&cmd.args, "--autostash");
 	if (opt_verify_signatures &&
 	    !strcmp(opt_verify_signatures, "--verify-signatures"))
 		warning(_("ignoring --verify-signatures for rebase"));

-	strvec_push(&args, "--onto");
-	strvec_push(&args, oid_to_hex(newbase));
+	strvec_push(&cmd.args, "--onto");
+	strvec_push(&cmd.args, oid_to_hex(newbase));

-	strvec_push(&args, oid_to_hex(upstream));
+	strvec_push(&cmd.args, oid_to_hex(upstream));

-	ret =3D run_command_v_opt(args.v, RUN_GIT_CMD);
-	strvec_clear(&args);
-	return ret;
+	cmd.git_cmd =3D 1;
+	return run_command(&cmd);
 }

 static int get_can_ff(struct object_id *orig_head,
diff --git a/builtin/remote.c b/builtin/remote.c
index 910f7b9316..11304c096a 100644
=2D-- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1508,37 +1508,35 @@ static int update(int argc, const char **argv, con=
st char *prefix)
 			 N_("prune remotes after fetching")),
 		OPT_END()
 	};
-	struct strvec fetch_argv =3D STRVEC_INIT;
+	struct child_process cmd =3D CHILD_PROCESS_INIT;
 	int default_defined =3D 0;
-	int retval;

 	argc =3D parse_options(argc, argv, prefix, options,
 			     builtin_remote_update_usage,
 			     PARSE_OPT_KEEP_ARGV0);

-	strvec_push(&fetch_argv, "fetch");
+	strvec_push(&cmd.args, "fetch");

 	if (prune !=3D -1)
-		strvec_push(&fetch_argv, prune ? "--prune" : "--no-prune");
+		strvec_push(&cmd.args, prune ? "--prune" : "--no-prune");
 	if (verbose)
-		strvec_push(&fetch_argv, "-v");
-	strvec_push(&fetch_argv, "--multiple");
+		strvec_push(&cmd.args, "-v");
+	strvec_push(&cmd.args, "--multiple");
 	if (argc < 2)
-		strvec_push(&fetch_argv, "default");
+		strvec_push(&cmd.args, "default");
 	for (i =3D 1; i < argc; i++)
-		strvec_push(&fetch_argv, argv[i]);
+		strvec_push(&cmd.args, argv[i]);

-	if (strcmp(fetch_argv.v[fetch_argv.nr-1], "default") =3D=3D 0) {
+	if (strcmp(cmd.args.v[cmd.args.nr-1], "default") =3D=3D 0) {
 		git_config(get_remote_default, &default_defined);
 		if (!default_defined) {
-			strvec_pop(&fetch_argv);
-			strvec_push(&fetch_argv, "--all");
+			strvec_pop(&cmd.args);
+			strvec_push(&cmd.args, "--all");
 		}
 	}

-	retval =3D run_command_v_opt(fetch_argv.v, RUN_GIT_CMD);
-	strvec_clear(&fetch_argv);
-	return retval;
+	cmd.git_cmd =3D 1;
+	return run_command(&cmd);
 }

 static int remove_all_fetch_refspecs(const char *key)
diff --git a/diff.c b/diff.c
index 648f6717a5..8451c230d9 100644
=2D-- a/diff.c
+++ b/diff.c
@@ -4278,35 +4278,34 @@ static void run_external_diff(const char *pgm,
 			      const char *xfrm_msg,
 			      struct diff_options *o)
 {
-	struct strvec argv =3D STRVEC_INIT;
-	struct strvec env =3D STRVEC_INIT;
+	struct child_process cmd =3D CHILD_PROCESS_INIT;
 	struct diff_queue_struct *q =3D &diff_queued_diff;

-	strvec_push(&argv, pgm);
-	strvec_push(&argv, name);
+	strvec_push(&cmd.args, pgm);
+	strvec_push(&cmd.args, name);

 	if (one && two) {
-		add_external_diff_name(o->repo, &argv, name, one);
+		add_external_diff_name(o->repo, &cmd.args, name, one);
 		if (!other)
-			add_external_diff_name(o->repo, &argv, name, two);
+			add_external_diff_name(o->repo, &cmd.args, name, two);
 		else {
-			add_external_diff_name(o->repo, &argv, other, two);
-			strvec_push(&argv, other);
-			strvec_push(&argv, xfrm_msg);
+			add_external_diff_name(o->repo, &cmd.args, other, two);
+			strvec_push(&cmd.args, other);
+			strvec_push(&cmd.args, xfrm_msg);
 		}
 	}

-	strvec_pushf(&env, "GIT_DIFF_PATH_COUNTER=3D%d", ++o->diff_path_counter)=
;
-	strvec_pushf(&env, "GIT_DIFF_PATH_TOTAL=3D%d", q->nr);
+	strvec_pushf(&cmd.env, "GIT_DIFF_PATH_COUNTER=3D%d",
+		     ++o->diff_path_counter);
+	strvec_pushf(&cmd.env, "GIT_DIFF_PATH_TOTAL=3D%d", q->nr);

 	diff_free_filespec_data(one);
 	diff_free_filespec_data(two);
-	if (run_command_v_opt_cd_env(argv.v, RUN_USING_SHELL, NULL, env.v))
+	cmd.use_shell =3D 1;
+	if (run_command(&cmd))
 		die(_("external diff died, stopping at %s"), name);

 	remove_tempfile();
-	strvec_clear(&argv);
-	strvec_clear(&env);
 }

 static int similarity_index(struct diff_filepair *p)
diff --git a/git.c b/git.c
index ee7758dcb0..6662548986 100644
=2D-- a/git.c
+++ b/git.c
@@ -787,7 +787,7 @@ static int run_argv(int *argcp, const char ***argv)
 		if (!done_alias)
 			handle_builtin(*argcp, *argv);
 		else if (get_builtin(**argv)) {
-			struct strvec args =3D STRVEC_INIT;
+			struct child_process cmd =3D CHILD_PROCESS_INIT;
 			int i;

 			/*
@@ -804,18 +804,21 @@ static int run_argv(int *argcp, const char ***argv)

 			commit_pager_choice();

-			strvec_push(&args, "git");
+			strvec_push(&cmd.args, "git");
 			for (i =3D 0; i < *argcp; i++)
-				strvec_push(&args, (*argv)[i]);
+				strvec_push(&cmd.args, (*argv)[i]);

-			trace_argv_printf(args.v, "trace: exec:");
+			trace_argv_printf(cmd.args.v, "trace: exec:");

 			/*
 			 * if we fail because the command is not found, it is
 			 * OK to return. Otherwise, we just pass along the status code.
 			 */
-			i =3D run_command_v_opt_tr2(args.v, RUN_SILENT_EXEC_FAILURE |
-						  RUN_CLEAN_ON_EXIT | RUN_WAIT_AFTER_CLEAN, "git_alias");
+			cmd.silent_exec_failure =3D 1;
+			cmd.clean_on_exit =3D 1;
+			cmd.wait_after_clean =3D 1;
+			cmd.trace2_child_class =3D "git_alias";
+			i =3D run_command(&cmd);
 			if (i >=3D 0 || errno !=3D ENOENT)
 				exit(i);
 			die("could not execute builtin %s", **argv);
diff --git a/merge.c b/merge.c
index 2382ff66d3..445b4f19aa 100644
=2D-- a/merge.c
+++ b/merge.c
@@ -19,22 +19,22 @@ int try_merge_command(struct repository *r,
 		      const char **xopts, struct commit_list *common,
 		      const char *head_arg, struct commit_list *remotes)
 {
-	struct strvec args =3D STRVEC_INIT;
+	struct child_process cmd =3D CHILD_PROCESS_INIT;
 	int i, ret;
 	struct commit_list *j;

-	strvec_pushf(&args, "merge-%s", strategy);
+	strvec_pushf(&cmd.args, "merge-%s", strategy);
 	for (i =3D 0; i < xopts_nr; i++)
-		strvec_pushf(&args, "--%s", xopts[i]);
+		strvec_pushf(&cmd.args, "--%s", xopts[i]);
 	for (j =3D common; j; j =3D j->next)
-		strvec_push(&args, merge_argument(j->item));
-	strvec_push(&args, "--");
-	strvec_push(&args, head_arg);
+		strvec_push(&cmd.args, merge_argument(j->item));
+	strvec_push(&cmd.args, "--");
+	strvec_push(&cmd.args, head_arg);
 	for (j =3D remotes; j; j =3D j->next)
-		strvec_push(&args, merge_argument(j->item));
+		strvec_push(&cmd.args, merge_argument(j->item));

-	ret =3D run_command_v_opt(args.v, RUN_GIT_CMD);
-	strvec_clear(&args);
+	cmd.git_cmd =3D 1;
+	ret =3D run_command(&cmd);

 	discard_index(r->index);
 	if (repo_read_index(r) < 0)
diff --git a/scalar.c b/scalar.c
index 6de9c0ee52..03f9e480dd 100644
=2D-- a/scalar.c
+++ b/scalar.c
@@ -69,21 +69,18 @@ static void setup_enlistment_directory(int argc, const=
 char **argv,

 static int run_git(const char *arg, ...)
 {
-	struct strvec argv =3D STRVEC_INIT;
+	struct child_process cmd =3D CHILD_PROCESS_INIT;
 	va_list args;
 	const char *p;
-	int res;

 	va_start(args, arg);
-	strvec_push(&argv, arg);
+	strvec_push(&cmd.args, arg);
 	while ((p =3D va_arg(args, const char *)))
-		strvec_push(&argv, p);
+		strvec_push(&cmd.args, p);
 	va_end(args);

-	res =3D run_command_v_opt(argv.v, RUN_GIT_CMD);
-
-	strvec_clear(&argv);
-	return res;
+	cmd.git_cmd =3D 1;
+	return run_command(&cmd);
 }

 struct scalar_config {
diff --git a/sequencer.c b/sequencer.c
index debb2ecbaf..8ab0225f0f 100644
=2D-- a/sequencer.c
+++ b/sequencer.c
@@ -3183,18 +3183,15 @@ static int rollback_is_safe(void)

 static int reset_merge(const struct object_id *oid)
 {
-	int ret;
-	struct strvec argv =3D STRVEC_INIT;
+	struct child_process cmd =3D CHILD_PROCESS_INIT;

-	strvec_pushl(&argv, "reset", "--merge", NULL);
+	cmd.git_cmd =3D 1;
+	strvec_pushl(&cmd.args, "reset", "--merge", NULL);

 	if (!is_null_oid(oid))
-		strvec_push(&argv, oid_to_hex(oid));
+		strvec_push(&cmd.args, oid_to_hex(oid));

-	ret =3D run_command_v_opt(argv.v, RUN_GIT_CMD);
-	strvec_clear(&argv);
-
-	return ret;
+	return run_command(&cmd);
 }

 static int rollback_single_pick(struct repository *r)
@@ -4867,14 +4864,14 @@ static int pick_commits(struct repository *r,

 static int continue_single_pick(struct repository *r, struct replay_opts =
*opts)
 {
-	struct strvec argv =3D STRVEC_INIT;
-	int ret;
+	struct child_process cmd =3D CHILD_PROCESS_INIT;

 	if (!refs_ref_exists(get_main_ref_store(r), "CHERRY_PICK_HEAD") &&
 	    !refs_ref_exists(get_main_ref_store(r), "REVERT_HEAD"))
 		return error(_("no cherry-pick or revert in progress"));

-	strvec_push(&argv, "commit");
+	cmd.git_cmd =3D 1;
+	strvec_push(&cmd.args, "commit");

 	/*
 	 * continue_single_pick() handles the case of recovering from a
@@ -4887,11 +4884,9 @@ static int continue_single_pick(struct repository *=
r, struct replay_opts *opts)
 		 * Include --cleanup=3Dstrip as well because we don't want the
 		 * "# Conflicts:" messages.
 		 */
-		strvec_pushl(&argv, "--no-edit", "--cleanup=3Dstrip", NULL);
+		strvec_pushl(&cmd.args, "--no-edit", "--cleanup=3Dstrip", NULL);

-	ret =3D run_command_v_opt(argv.v, RUN_GIT_CMD);
-	strvec_clear(&argv);
-	return ret;
+	return run_command(&cmd);
 }

 static int commit_staged_changes(struct repository *r,
=2D-
2.38.1
