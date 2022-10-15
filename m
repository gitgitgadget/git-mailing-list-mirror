Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF80DC433FE
	for <git@archiver.kernel.org>; Sat, 15 Oct 2022 06:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiJOGv4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Oct 2022 02:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiJOGvz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Oct 2022 02:51:55 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F91E11
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 23:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1665816695; bh=x+E+OSdSTiWILelLeYHk1nAuA1aJogeZ958oklZe8IU=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=dfkKOthAzBdx5FWONHZmWDxWKzH+n++no0quvwIENyeYJeKtPWr4mf9Ufo4JNIXo7
         vM+L3h4m26FSSVw8RgxxTxVKIwymBmRqDINCZ8bDBsMunKCMPJS4vm692jSgkgmQ01
         Njis3y/wQfckOE7MXM9odLIFskDzOVKZwwu3pFS2z7IjcTJwieHlU6fGi/ewg5UdGD
         jlc2BT71swys4XdbtIPb1s5k2CIu/RTV9FIdBNNVUeoS6t1hKJYM+a4CwuNi6RviIg
         GcNk5Wbr6Xri0y/3582pSiJY2m30l2i0DQ1CgFCvXKrr4WCAMXdt94+tdDp8cT9Hso
         6EyK+u7Qcyeuw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.161]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M6YJB-1om2vO1fQn-006ehl; Sat, 15
 Oct 2022 08:51:35 +0200
Message-ID: <9d924a5d-5c72-fbe6-270c-a8f6c5fc5850@web.de>
Date:   Sat, 15 Oct 2022 08:51:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
Subject: Re: [PATCH v2] bisect--helper: plug strvec leak
Content-Language: en-US
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>
References: <xmqqy1tunjgp.fsf@gitster.g>
 <221006.86a668r5mf.gmgdl@evledraar.gmail.com> <xmqqk05cipq8.fsf@gitster.g>
 <1965b54b-122a-c965-f886-1a7dd6afbfb4@web.de>
 <Y0TXTl0gSBOFQa9B@coredump.intra.peff.net> <xmqq35buykz1.fsf@gitster.g>
 <Y0VtkmNwjKcXcemP@coredump.intra.peff.net> <xmqqpmeyuvxt.fsf@gitster.g>
 <221011.86czayns5x.gmgdl@evledraar.gmail.com> <xmqq8rlmujcz.fsf@gitster.g>
 <Y0m8AU+Yf7PREI2E@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <Y0m8AU+Yf7PREI2E@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zKAG8jhghuoggYviSjYodleBGHXQagqmXM0N5/TK53Psa7nun16
 nuDEGhjf5hhY5MfRnNQzHat1vRdNfTHDOOaPcI6XD+MxGefEpIHURtT/CGB6H4juwesr9pi
 HD251WT93tVlp/4kS7zGzKP/OytxQGmW5UuH/Sf0vwm3QJaE7jzXxb+7ucShfwvsOUzAoAN
 1q+/sJEWDYtvw5OP6JQAQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:I3xD8VYXYyo=:qLE1H5E7zvdGA9gox0/5eg
 EKKg2YeVAKRIXAHqFHcNJ6FcvjC2cUvS5KbXS28u8GyEEF5JihJsW8H6rySAeWg676w0Cgbu2
 FjiT3M/Opf6WpSsP2ZxgTwxrEGJcBeQa7Xl+tJKsUyKTVtLPlf73okWoiZPTvgjiGPQZQMZNf
 c43sOh0qh/Z60snZ/PhwSBXHTf4CYXLdJlfWcouo858jm5zjk0q3BIQa6b0X2x8WZLrZOi4ye
 d3MXagUd3fnYwwx8/qpSKfoZpDfbQw+E+wR4N08SDRK0AcvojOp9ITHUW0iv/U+fsw3u7IcjC
 4X8B5QxUGyenErGxMYZniSJ9PptiqSn6bUkYkRLwrp+8NJKX6mo+PvFceAOF5Beaoabhi0Te6
 hJXT3LsQfGRrUoUoNdcGXTaMY86aaVoS86Z0fISrl9DlPF5mr8zT10k02QaOzfY8QubNVdFVI
 XBiRS3Sy0qHQHdtGXm0AlO+yTZsmU1jriwJbX+Em8jYn8O6lYME4iI6/W3S8V2MNVi6VPJrEE
 u9/aosnBcEtQorIq7bptRQiqSX4idPBdZWNhpoVuSYLJOF0TPh4Je7git/nVFCtVOBXbr0r+L
 9E5OLFQrapGnWCW3Glw0Ft6o1B/O1971lKBwww8pjCashnBmmO5q7d7ZG871UvK7wQESMMta5
 bDO+JE5EKJs/T79CstPUyv5QSQHr0IMxC2IdyABGjDMxxSDiZZAauqDkKIO8vgM4ZOu0uSDUN
 rEV21Od5VoC2FPC++KVUC7XcYiMRibUXg1uJgy8e1lBmUHDIq7bp/OHh4cNCYOvz2A08UlzDy
 +i5cCZk3bji+Fm8+EDStPG7fA6+liYAXKoew5SvRhiX3uUmazy5YzYOtzwZVba1UNJt66CDqz
 8Jyg0nHxgUs+3SRdFM/9xSNnaCiPJyezUbuNPaZS0jjdXEshTHUDFlpfkir2bDGZS4Mzd51Ph
 a23ZOPEq+oenP7GvbGtzMgHguuluIRx5nKfBdSWZbj9WVs7wQ0KA97M8biXpD/9yO1+XL6t/O
 daNc1APxZpYn7hOEwf1ppi6SAKvWMUdiG1JP0q5Yhsvd1VNhBn8KiSSU5tgeEuVa9mtYlly9k
 z/1Mzt/Qm3w03i2OUlKIGaiLxStWGsLUgvz24Gp9yP/bQMpt7bVKFhrJEfItselGbGkV1v5Ti
 aIPpkfHBrkmKfKDwXTtJak5vdiCHI36uuwHaY7jBo/Oo61F6674dkRksZUf7XLg5CnzWVh8x1
 NKXLqgZT7GFN7ADg7o5dKONysKZCNnk+CQuuKWKVq+4yCDiElHiiKDCuyqDCgSLgAlNQ0EJeW
 6YSUQwxz0Hb8DMhk/NZ+BLgDVVOb5i0oaLoezjz5WW1YLqAfPPiTpFGzFhB5VTOX4e2ds+AT4
 DEueYy6jVKCU5UfNaUp7EeevDx/ODM/I+HwQQbHIt7m1BZ7+Wo9KZl1zDr/C7kFqtLzeqXBxB
 JN+YXeMTXS+y54UyKIg/LBB9bSYjh70bibROPHfS/jRB7dBGQVZtpnfk1oHUUjz4+6GfS32YK
 wkFzPgG1AZ/9bsPg/Q6ufbLOVz0KpfpvMbhhHVrkttckv
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 14.10.22 um 21:44 schrieb Jeff King:
> And I'd be happy to see all of the run_command_v() variants go away
> entirely. It does save a few lines, but with modern niceties, it's
> not very many, and it's much less flexible.
That would look something like below.

=2D--
 add-interactive.c        |   9 ++-
 bisect.c                 |  12 ++--
 builtin/add.c            |  19 +++--
 builtin/am.c             |  12 ++--
 builtin/bisect--helper.c |  64 ++++++++---------
 builtin/clone.c          |  41 ++++++-----
 builtin/difftool.c       |  24 ++++---
 builtin/fetch.c          |   9 ++-
 builtin/gc.c             |  51 ++++++++------
 builtin/merge-index.c    |   4 +-
 builtin/merge.c          |  42 +++++------
 builtin/pull.c           | 147 +++++++++++++++++++--------------------
 builtin/remote.c         |  40 +++++------
 compat/mingw.c           |  11 +--
 diff.c                   |  27 ++++---
 fsmonitor-ipc.c          |  10 ++-
 git.c                    |  15 ++--
 ll-merge.c               |   7 +-
 merge.c                  |  18 ++---
 run-command.c            |  35 ----------
 run-command.h            |  30 --------
 scalar.c                 |  13 ++--
 sequencer.c              |  32 ++++-----
 shell.c                  |  17 +++--
 t/helper/test-fake-ssh.c |   7 +-
 t/helper/test-trace2.c   |   4 +-
 tmp-objdir.h             |   4 +-
 27 files changed, 330 insertions(+), 374 deletions(-)

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
diff --git a/bisect.c b/bisect.c
index fd581b85a7..ec7487e683 100644
=2D-- a/bisect.c
+++ b/bisect.c
@@ -22,8 +22,6 @@ static struct oid_array skipped_revs;

 static struct object_id *current_bad_oid;

-static const char *argv_checkout[] =3D {"checkout", "-q", NULL, "--", NUL=
L};
-
 static const char *term_bad;
 static const char *term_good;

@@ -729,20 +727,22 @@ static int is_expected_rev(const struct object_id *o=
id)
 enum bisect_error bisect_checkout(const struct object_id *bisect_rev,
 				  int no_checkout)
 {
-	char bisect_rev_hex[GIT_MAX_HEXSZ + 1];
 	struct commit *commit;
 	struct pretty_print_context pp =3D {0};
 	struct strbuf commit_msg =3D STRBUF_INIT;

-	oid_to_hex_r(bisect_rev_hex, bisect_rev);
 	update_ref(NULL, "BISECT_EXPECTED_REV", bisect_rev, NULL, 0, UPDATE_REFS=
_DIE_ON_ERR);

-	argv_checkout[2] =3D bisect_rev_hex;
 	if (no_checkout) {
 		update_ref(NULL, "BISECT_HEAD", bisect_rev, NULL, 0,
 			   UPDATE_REFS_DIE_ON_ERR);
 	} else {
-		if (run_command_v_opt(argv_checkout, RUN_GIT_CMD))
+		struct child_process cmd =3D CHILD_PROCESS_INIT;
+
+		cmd.git_cmd =3D 1;
+		strvec_pushl(&cmd.args, "checkout", "-q",
+			     oid_to_hex(bisect_rev), "--", NULL);
+		if (run_command(&cmd))
 			/*
 			 * Errors in `run_command()` itself, signaled by res < 0,
 			 * and errors in the child process, signaled by res > 0
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
diff --git a/builtin/am.c b/builtin/am.c
index 39fea24833..20aea0d248 100644
=2D-- a/builtin/am.c
+++ b/builtin/am.c
@@ -2187,14 +2187,12 @@ static int show_patch(struct am_state *state, enum=
 show_patch_type sub_mode)
 	int len;

 	if (!is_null_oid(&state->orig_commit)) {
-		const char *av[4] =3D { "show", NULL, "--", NULL };
-		char *new_oid_str;
-		int ret;
+		struct child_process cmd =3D CHILD_PROCESS_INIT;

-		av[1] =3D new_oid_str =3D xstrdup(oid_to_hex(&state->orig_commit));
-		ret =3D run_command_v_opt(av, RUN_GIT_CMD);
-		free(new_oid_str);
-		return ret;
+		strvec_pushl(&cmd.args, "show", oid_to_hex(&state->orig_commit),
+			     "--", NULL);
+		cmd.git_cmd =3D 1;
+		return run_command(&cmd);
 	}

 	switch (sub_mode) {
diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 501245fac9..542f0cb8f5 100644
=2D-- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -220,18 +220,17 @@ static int bisect_reset(const char *commit)
 	}

 	if (!ref_exists("BISECT_HEAD")) {
-		struct strvec argv =3D STRVEC_INIT;
+		struct child_process cmd =3D CHILD_PROCESS_INIT;

-		strvec_pushl(&argv, "checkout", branch.buf, "--", NULL);
-		if (run_command_v_opt(argv.v, RUN_GIT_CMD)) {
+		strvec_pushl(&cmd.args, "checkout", branch.buf, "--", NULL);
+		cmd.git_cmd =3D 1;
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
@@ -765,11 +764,12 @@ static enum bisect_error bisect_start(struct bisect_=
terms *terms, const char **a
 		strbuf_read_file(&start_head, git_path_bisect_start(), 0);
 		strbuf_trim(&start_head);
 		if (!no_checkout) {
-			struct strvec argv =3D STRVEC_INIT;
+			struct child_process cmd =3D CHILD_PROCESS_INIT;

-			strvec_pushl(&argv, "checkout", start_head.buf,
+			strvec_pushl(&cmd.args, "checkout", start_head.buf,
 				     "--", NULL);
-			if (run_command_v_opt(argv.v, RUN_GIT_CMD)) {
+			cmd.git_cmd =3D 1;
+			if (run_command(&cmd)) {
 				res =3D error(_("checking out '%s' failed."
 						 " Try 'git bisect start "
 						 "<valid-branch>'."),
@@ -1099,40 +1099,38 @@ static enum bisect_error bisect_skip(struct bisect=
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
@@ -1143,8 +1141,7 @@ static int get_first_good(const char *refname UNUSED=
,
 	return 1;
 }

-static int verify_good(const struct bisect_terms *terms,
-		       const char **quoted_argv)
+static int verify_good(const struct bisect_terms *terms, const char *comm=
and)
 {
 	int rc;
 	enum bisect_error res;
@@ -1152,6 +1149,7 @@ static int verify_good(const struct bisect_terms *te=
rms,
 	struct object_id current_rev;
 	char *good_glob =3D xstrfmt("%s-*", terms->term_good);
 	int no_checkout =3D ref_exists("BISECT_HEAD");
+	struct child_process cmd =3D CHILD_PROCESS_INIT;

 	for_each_glob_ref_in(get_first_good, good_glob, "refs/bisect/",
 			     &good_rev);
@@ -1164,8 +1162,10 @@ static int verify_good(const struct bisect_terms *t=
erms,
 	if (res !=3D BISECT_OK)
 		return -1;

-	printf(_("running %s\n"), quoted_argv[0]);
-	rc =3D run_command_v_opt(quoted_argv, RUN_USING_SHELL);
+	printf(_("running %s\n"), command);
+	strvec_push(&cmd.args, command);
+	cmd.use_shell =3D 1;
+	rc =3D run_command(&cmd);

 	res =3D bisect_checkout(&current_rev, no_checkout);
 	if (res !=3D BISECT_OK)
@@ -1178,7 +1178,6 @@ static int bisect_run(struct bisect_terms *terms, co=
nst char **argv, int argc)
 {
 	int res =3D BISECT_OK;
 	struct strbuf command =3D STRBUF_INIT;
-	struct strvec run_args =3D STRVEC_INIT;
 	const char *new_state;
 	int temporary_stdout_fd, saved_stdout;
 	int is_first_run =3D 1;
@@ -1193,11 +1192,13 @@ static int bisect_run(struct bisect_terms *terms, =
const char **argv, int argc)
 		return BISECT_FAILED;
 	}

-	strvec_push(&run_args, command.buf);
-
 	while (1) {
+		struct child_process cmd =3D CHILD_PROCESS_INIT;
+
 		printf(_("running %s\n"), command.buf);
-		res =3D run_command_v_opt(run_args.v, RUN_USING_SHELL);
+		strvec_push(&cmd.args, command.buf);
+		cmd.use_shell =3D 1;
+		res =3D run_command(&cmd);

 		/*
 		 * Exit code 126 and 127 can either come from the shell
@@ -1207,7 +1208,7 @@ static int bisect_run(struct bisect_terms *terms, co=
nst char **argv, int argc)
 		 * missing or non-executable script.
 		 */
 		if (is_first_run && (res =3D=3D 126 || res =3D=3D 127)) {
-			int rc =3D verify_good(terms, run_args.v);
+			int rc =3D verify_good(terms, command.buf);
 			is_first_run =3D 0;
 			if (rc < 0) {
 				error(_("unable to verify '%s' on good"
@@ -1274,7 +1275,6 @@ static int bisect_run(struct bisect_terms *terms, co=
nst char **argv, int argc)
 	}

 	strbuf_release(&command);
-	strvec_clear(&run_args);
 	return res;
 }

diff --git a/builtin/clone.c b/builtin/clone.c
index ed8d44bb6a..219cfbd735 100644
=2D-- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -651,9 +651,9 @@ static void update_head(const struct ref *our, const s=
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
@@ -661,12 +661,12 @@ static int git_sparse_checkout_init(const char *repo=
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

@@ -731,37 +731,38 @@ static int checkout(int submodule_progress, int filt=
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
@@ -862,11 +863,15 @@ static void write_refspec_config(const char *src_ref=
_prefix,

 static void dissociate_from_references(void)
 {
-	static const char* argv[] =3D { "repack", "-a", "-d", NULL };
 	char *alternates =3D git_pathdup("objects/info/alternates");

 	if (!access(alternates, F_OK)) {
-		if (run_command_v_opt(argv, RUN_GIT_CMD|RUN_COMMAND_NO_STDIN))
+		struct child_process cmd =3D CHILD_PROCESS_INIT;
+
+		strvec_pushl(&cmd.args, "repack", "-a", "-d", NULL);
+		cmd.git_cmd =3D 1;
+		cmd.no_stdin =3D 1;
+		if (run_command(&cmd))
 			die(_("cannot repack to clean up"));
 		if (unlink(alternates) && errno !=3D ENOENT)
 			die_errno(_("cannot unlink temporary alternates file"));
diff --git a/builtin/difftool.c b/builtin/difftool.c
index 4b10ad1a36..d6c262e15f 100644
=2D-- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -44,8 +44,10 @@ static int difftool_config(const char *var, const char =
*value, void *cb)

 static int print_tool_help(void)
 {
-	const char *argv[] =3D { "mergetool", "--tool-help=3Ddiff", NULL };
-	return run_command_v_opt(argv, RUN_GIT_CMD);
+	struct child_process cmd =3D CHILD_PROCESS_INIT;
+	strvec_pushl(&cmd.args, "mergetool", "--tool-help=3Ddiff", NULL);
+	cmd.git_cmd =3D 1;
+	return run_command(&cmd);
 }

 static int parse_index_info(char *p, int *mode1, int *mode2,
@@ -360,8 +362,8 @@ static int run_dir_diff(const char *extcmd, int symlin=
ks, const char *prefix,
 	struct pair_entry *entry;
 	struct index_state wtindex;
 	struct checkout lstate, rstate;
-	int flags =3D RUN_GIT_CMD, err =3D 0;
-	const char *helper_argv[] =3D { "difftool--helper", NULL, NULL, NULL };
+	int err =3D 0;
+	struct child_process cmd =3D CHILD_PROCESS_INIT;
 	struct hashmap wt_modified, tmp_modified;
 	int indices_loaded =3D 0;

@@ -563,16 +565,18 @@ static int run_dir_diff(const char *extcmd, int syml=
inks, const char *prefix,
 	}

 	strbuf_setlen(&ldir, ldir_len);
-	helper_argv[1] =3D ldir.buf;
 	strbuf_setlen(&rdir, rdir_len);
-	helper_argv[2] =3D rdir.buf;

 	if (extcmd) {
-		helper_argv[0] =3D extcmd;
-		flags =3D 0;
-	} else
+		strvec_push(&cmd.args, extcmd);
+	} else {
+		strvec_push(&cmd.args, "difftool--helper");
+		cmd.git_cmd =3D 1;
 		setenv("GIT_DIFFTOOL_DIRDIFF", "true", 1);
-	ret =3D run_command_v_opt(helper_argv, flags);
+	}
+	strvec_pushl(&cmd.args, ldir.buf, rdir.buf, NULL);
+
+	ret =3D run_command(&cmd);

 	/* TODO: audit for interaction with sparse-index. */
 	ensure_full_index(&wtindex);
diff --git a/builtin/fetch.c b/builtin/fetch.c
index a0fca93bb6..dd060dd65a 100644
=2D-- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1965,14 +1965,17 @@ static int fetch_multiple(struct string_list *list=
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
index 243ee85d28..b47e53c210 100644
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
+	strvec_pushl(&cmd.args, "pack-refs", "--all", "--prune", NULL);
+	cmd.git_cmd =3D 1;
+	return run_command(&cmd);
 }

 static int too_many_loose_objects(void)
@@ -521,6 +523,16 @@ static int report_last_gc_error(void)
 	return ret;
 }

+static void run_git_or_die(const char **argv)
+{
+	struct child_process cmd =3D CHILD_PROCESS_INIT;
+
+	strvec_pushv(&cmd.args, argv);
+	cmd.git_cmd =3D 1;
+	if (run_command(&cmd))
+		die(FAILED_RUN, argv[0]);
+}
+
 static void gc_before_repack(void)
 {
 	/*
@@ -535,8 +547,8 @@ static void gc_before_repack(void)
 	if (pack_refs && maintenance_task_pack_refs(NULL))
 		die(FAILED_RUN, "pack-refs");

-	if (prune_reflogs && run_command_v_opt(reflog.v, RUN_GIT_CMD))
-		die(FAILED_RUN, reflog.v[0]);
+	if (prune_reflogs)
+		run_git_or_die(reflog.v);
 }

 int cmd_gc(int argc, const char **argv, const char *prefix)
@@ -671,8 +683,12 @@ int cmd_gc(int argc, const char **argv, const char *p=
refix)
 	gc_before_repack();

 	if (!repository_format_precious_objects) {
-		if (run_command_v_opt(repack.v,
-				      RUN_GIT_CMD | RUN_CLOSE_OBJECT_STORE))
+		struct child_process repack_cmd =3D CHILD_PROCESS_INIT;
+
+		strvec_pushv(&repack_cmd.args, repack.v);
+		repack_cmd.git_cmd =3D 1;
+		repack_cmd.close_object_store =3D 1;
+		if (run_command(&repack_cmd))
 			die(FAILED_RUN, repack.v[0]);

 		if (prune_expire) {
@@ -683,19 +699,16 @@ int cmd_gc(int argc, const char **argv, const char *=
prefix)
 			if (has_promisor_remote())
 				strvec_push(&prune,
 					    "--exclude-promisor-objects");
-			if (run_command_v_opt(prune.v, RUN_GIT_CMD))
-				die(FAILED_RUN, prune.v[0]);
+			run_git_or_die(prune.v);
 		}
 	}

 	if (prune_worktrees_expire) {
 		strvec_push(&prune_worktrees, prune_worktrees_expire);
-		if (run_command_v_opt(prune_worktrees.v, RUN_GIT_CMD))
-			die(FAILED_RUN, prune_worktrees.v[0]);
+		run_git_or_die(prune_worktrees.v);
 	}

-	if (run_command_v_opt(rerere.v, RUN_GIT_CMD))
-		die(FAILED_RUN, rerere.v[0]);
+	run_git_or_die(rerere.v);

 	report_garbage =3D report_pack_garbage;
 	reprepare_packed_git(the_repository);
@@ -1910,20 +1923,16 @@ static char *schtasks_task_name(const char *freque=
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
diff --git a/builtin/merge.c b/builtin/merge.c
index 5900b81729..5e14decc22 100644
=2D-- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -347,58 +347,52 @@ static int save_state(struct object_id *stash)

 static void read_empty(const struct object_id *oid, int verbose)
 {
-	int i =3D 0;
-	const char *args[7];
+	struct child_process cmd =3D CHILD_PROCESS_INIT;

-	args[i++] =3D "read-tree";
+	strvec_push(&cmd.args, "read-tree");
 	if (verbose)
-		args[i++] =3D "-v";
-	args[i++] =3D "-m";
-	args[i++] =3D "-u";
-	args[i++] =3D empty_tree_oid_hex();
-	args[i++] =3D oid_to_hex(oid);
-	args[i] =3D NULL;
+		strvec_push(&cmd.args, "-v");
+	strvec_pushl(&cmd.args, "-m", "-u", empty_tree_oid_hex(),
+		     oid_to_hex(oid), NULL);

-	if (run_command_v_opt(args, RUN_GIT_CMD))
+	cmd.git_cmd =3D 1;
+	if (run_command(&cmd))
 		die(_("read-tree failed"));
 }

 static void reset_hard(const struct object_id *oid, int verbose)
 {
-	int i =3D 0;
-	const char *args[6];
+	struct child_process cmd =3D CHILD_PROCESS_INIT;

-	args[i++] =3D "read-tree";
+	strvec_push(&cmd.args, "read-tree");
 	if (verbose)
-		args[i++] =3D "-v";
-	args[i++] =3D "--reset";
-	args[i++] =3D "-u";
-	args[i++] =3D oid_to_hex(oid);
-	args[i] =3D NULL;
+		strvec_push(&cmd.args, "-v");
+	strvec_pushl(&cmd.args, "--reset", "-u", oid_to_hex(oid), NULL);

-	if (run_command_v_opt(args, RUN_GIT_CMD))
+	cmd.git_cmd =3D 1;
+	if (run_command(&cmd))
 		die(_("read-tree failed"));
 }

 static void restore_state(const struct object_id *head,
 			  const struct object_id *stash)
 {
-	struct strvec args =3D STRVEC_INIT;
+	struct child_process cmd =3D CHILD_PROCESS_INIT;

 	reset_hard(head, 1);

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
index 910f7b9316..0cde2e244a 100644
=2D-- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -92,13 +92,15 @@ static int verbose;

 static int fetch_remote(const char *name)
 {
-	const char *argv[] =3D { "fetch", name, NULL, NULL };
-	if (verbose) {
-		argv[1] =3D "-v";
-		argv[2] =3D name;
-	}
+	struct child_process cmd =3D CHILD_PROCESS_INIT;
+
+	strvec_push(&cmd.args, "fetch");
+	if (verbose)
+		strvec_push(&cmd.args, "-v");
+	strvec_push(&cmd.args, name);
 	printf_ln(_("Updating %s"), name);
-	if (run_command_v_opt(argv, RUN_GIT_CMD))
+	cmd.git_cmd =3D 1;
+	if (run_command(&cmd))
 		return error(_("Could not fetch %s"), name);
 	return 0;
 }
@@ -1508,37 +1510,35 @@ static int update(int argc, const char **argv, con=
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
diff --git a/compat/mingw.c b/compat/mingw.c
index 901375d584..d614f156df 100644
=2D-- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -196,16 +196,19 @@ static int read_yes_no_answer(void)
 static int ask_yes_no_if_possible(const char *format, ...)
 {
 	char question[4096];
-	const char *retry_hook[] =3D { NULL, NULL, NULL };
+	const char *retry_hook;
 	va_list args;

 	va_start(args, format);
 	vsnprintf(question, sizeof(question), format, args);
 	va_end(args);

-	if ((retry_hook[0] =3D mingw_getenv("GIT_ASK_YESNO"))) {
-		retry_hook[1] =3D question;
-		return !run_command_v_opt(retry_hook, 0);
+	retry_hook =3D mingw_getenv("GIT_ASK_YESNO");
+	if (retry_hook) {
+		struct child_process cmd =3D CHILD_PROCESS_INIT;
+
+		strvec_pushl(&cmd.args, retry_hook, question, NULL);
+		return !run_command(&cmd);
 	}

 	if (!isatty(_fileno(stdin)) || !isatty(_fileno(stderr)))
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
diff --git a/fsmonitor-ipc.c b/fsmonitor-ipc.c
index 789e7397ba..8d0b0b157c 100644
=2D-- a/fsmonitor-ipc.c
+++ b/fsmonitor-ipc.c
@@ -56,10 +56,14 @@ enum ipc_active_state fsmonitor_ipc__get_state(void)

 static int spawn_daemon(void)
 {
-	const char *args[] =3D { "fsmonitor--daemon", "start", NULL };
+	struct child_process cmd =3D CHILD_PROCESS_INIT;

-	return run_command_v_opt_tr2(args, RUN_COMMAND_NO_STDIN | RUN_GIT_CMD,
-				    "fsmonitor");
+	strvec_pushl(&cmd.args, "fsmonitor--daemon", "start", NULL);
+
+	cmd.git_cmd =3D 1;
+	cmd.no_stdin =3D 1;
+	cmd.trace2_child_class =3D "fsmonitor";
+	return run_command(&cmd);
 }

 int fsmonitor_ipc__send_query(const char *since_token,
diff --git a/git.c b/git.c
index da411c5382..ccf444417b 100644
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
diff --git a/ll-merge.c b/ll-merge.c
index 8955d7e1f6..b20491043e 100644
=2D-- a/ll-merge.c
+++ b/ll-merge.c
@@ -193,7 +193,7 @@ static enum ll_merge_result ll_ext_merge(const struct =
ll_merge_driver *fn,
 	struct strbuf cmd =3D STRBUF_INIT;
 	struct strbuf_expand_dict_entry dict[6];
 	struct strbuf path_sq =3D STRBUF_INIT;
-	const char *args[] =3D { NULL, NULL };
+	struct child_process child =3D CHILD_PROCESS_INIT;
 	int status, fd, i;
 	struct stat st;
 	enum ll_merge_result ret;
@@ -219,8 +219,9 @@ static enum ll_merge_result ll_ext_merge(const struct =
ll_merge_driver *fn,

 	strbuf_expand(&cmd, fn->cmdline, strbuf_expand_dict_cb, &dict);

-	args[0] =3D cmd.buf;
-	status =3D run_command_v_opt(args, RUN_USING_SHELL);
+	strvec_push(&child.args, cmd.buf);
+	child.use_shell =3D 1;
+	status =3D run_command(&child);
 	fd =3D open(temp[1], O_RDONLY);
 	if (fd < 0)
 		goto bad;
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
diff --git a/run-command.c b/run-command.c
index 5ec3a46dcc..23e100dffc 100644
=2D-- a/run-command.c
+++ b/run-command.c
@@ -1004,41 +1004,6 @@ int run_command(struct child_process *cmd)
 	return finish_command(cmd);
 }

-int run_command_v_opt(const char **argv, int opt)
-{
-	return run_command_v_opt_cd_env(argv, opt, NULL, NULL);
-}
-
-int run_command_v_opt_tr2(const char **argv, int opt, const char *tr2_cla=
ss)
-{
-	return run_command_v_opt_cd_env_tr2(argv, opt, NULL, NULL, tr2_class);
-}
-
-int run_command_v_opt_cd_env(const char **argv, int opt, const char *dir,=
 const char *const *env)
-{
-	return run_command_v_opt_cd_env_tr2(argv, opt, dir, env, NULL);
-}
-
-int run_command_v_opt_cd_env_tr2(const char **argv, int opt, const char *=
dir,
-				 const char *const *env, const char *tr2_class)
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
-	cmd.dir =3D dir;
-	if (env)
-		strvec_pushv(&cmd.env, (const char **)env);
-	cmd.trace2_child_class =3D tr2_class;
-	return run_command(&cmd);
-}
-
 #ifndef NO_PTHREADS
 static pthread_t main_thread;
 static int main_thread_set;
diff --git a/run-command.h b/run-command.h
index 0e85e5846a..57354fb7df 100644
=2D-- a/run-command.h
+++ b/run-command.h
@@ -224,36 +224,6 @@ int run_command(struct child_process *);
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
- * Convenience functions that encapsulate a sequence of
- * start_command() followed by finish_command(). The argument argv
- * specifies the program and its arguments. The argument opt is zero
- * or more of the flags `RUN_COMMAND_NO_STDIN`, `RUN_GIT_CMD`,
- * `RUN_COMMAND_STDOUT_TO_STDERR`, or `RUN_SILENT_EXEC_FAILURE`
- * that correspond to the members .no_stdin, .git_cmd,
- * .stdout_to_stderr, .silent_exec_failure of `struct child_process`.
- * The argument dir corresponds the member .dir. The argument env
- * corresponds to the member .env.
- */
-int run_command_v_opt(const char **argv, int opt);
-int run_command_v_opt_tr2(const char **argv, int opt, const char *tr2_cla=
ss);
-/*
- * env (the environment) is to be formatted like environ: "VAR=3DVALUE".
- * To unset an environment variable use just "VAR".
- */
-int run_command_v_opt_cd_env(const char **argv, int opt, const char *dir,=
 const char *const *env);
-int run_command_v_opt_cd_env_tr2(const char **argv, int opt, const char *=
dir,
-				 const char *const *env, const char *tr2_class);
-
 /**
  * Execute the given command, sending "in" to its stdin, and capturing it=
s
  * stdout and stderr in the "out" and "err" strbufs. Any of the three may
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
index debb2ecbaf..9b9d6a5582 100644
=2D-- a/sequencer.c
+++ b/sequencer.c
@@ -3183,18 +3183,15 @@ static int rollback_is_safe(void)

 static int reset_merge(const struct object_id *oid)
 {
-	int ret;
-	struct strvec argv =3D STRVEC_INIT;
+	struct child_process cmd =3D CHILD_PROCESS_INIT;

-	strvec_pushl(&argv, "reset", "--merge", NULL);
+	strvec_pushl(&cmd.args, "reset", "--merge", NULL);

 	if (!is_null_oid(oid))
-		strvec_push(&argv, oid_to_hex(oid));
-
-	ret =3D run_command_v_opt(argv.v, RUN_GIT_CMD);
-	strvec_clear(&argv);
+		strvec_push(&cmd.args, oid_to_hex(oid));

-	return ret;
+	cmd.git_cmd =3D 1;
+	return run_command(&cmd);
 }

 static int rollback_single_pick(struct repository *r)
@@ -3558,12 +3555,13 @@ static int error_failed_squash(struct repository *=
r,

 static int do_exec(struct repository *r, const char *command_line)
 {
-	const char *child_argv[] =3D { NULL, NULL };
+	struct child_process cmd =3D CHILD_PROCESS_INIT;
 	int dirty, status;

 	fprintf(stderr, _("Executing: %s\n"), command_line);
-	child_argv[0] =3D command_line;
-	status =3D run_command_v_opt(child_argv, RUN_USING_SHELL);
+	strvec_push(&cmd.args, command_line);
+	cmd.use_shell =3D 1;
+	status =3D run_command(&cmd);

 	/* force re-reading of the cache */
 	if (discard_index(r->index) < 0 || repo_read_index(r) < 0)
@@ -4867,14 +4865,13 @@ static int pick_commits(struct repository *r,

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
+	strvec_push(&cmd.args, "commit");

 	/*
 	 * continue_single_pick() handles the case of recovering from a
@@ -4887,11 +4884,10 @@ static int continue_single_pick(struct repository =
*r, struct replay_opts *opts)
 		 * Include --cleanup=3Dstrip as well because we don't want the
 		 * "# Conflicts:" messages.
 		 */
-		strvec_pushl(&argv, "--no-edit", "--cleanup=3Dstrip", NULL);
+		strvec_pushl(&cmd.args, "--no-edit", "--cleanup=3Dstrip", NULL);

-	ret =3D run_command_v_opt(argv.v, RUN_GIT_CMD);
-	strvec_clear(&argv);
-	return ret;
+	cmd.git_cmd =3D 1;
+	return run_command(&cmd);
 }

 static int commit_staged_changes(struct repository *r,
diff --git a/shell.c b/shell.c
index 811e13b9c9..4abc14eeee 100644
=2D-- a/shell.c
+++ b/shell.c
@@ -50,21 +50,24 @@ static void cd_to_homedir(void)
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
+	strvec_push(&help_cmd.args, HELP_COMMAND);
+	help_cmd.silent_exec_failure =3D 1;
+	run_command(&help_cmd);

 	do {
 		struct strbuf line =3D STRBUF_INIT;
@@ -99,9 +102,13 @@ static void run_shell(void)
 			   !strcmp(prog, "exit") || !strcmp(prog, "bye")) {
 			done =3D 1;
 		} else if (is_valid_cmd_name(prog)) {
+			struct child_process cmd =3D CHILD_PROCESS_INIT;
+
 			full_cmd =3D make_cmd(prog);
 			argv[0] =3D full_cmd;
-			code =3D run_command_v_opt(argv, RUN_SILENT_EXEC_FAILURE);
+			strvec_pushv(&cmd.args, argv);
+			cmd.silent_exec_failure =3D 1;
+			code =3D run_command(&cmd);
 			if (code =3D=3D -1 && errno =3D=3D ENOENT) {
 				fprintf(stderr, "unrecognized command '%s'\n", prog);
 			}
diff --git a/t/helper/test-fake-ssh.c b/t/helper/test-fake-ssh.c
index 12beee99ad..42185f3fc0 100644
=2D-- a/t/helper/test-fake-ssh.c
+++ b/t/helper/test-fake-ssh.c
@@ -8,7 +8,7 @@ int cmd_main(int argc, const char **argv)
 	struct strbuf buf =3D STRBUF_INIT;
 	FILE *f;
 	int i;
-	const char *child_argv[] =3D { NULL, NULL };
+	struct child_process cmd =3D CHILD_PROCESS_INIT;

 	/* First, print all parameters into $TRASH_DIRECTORY/ssh-output */
 	if (!trash_directory)
@@ -25,6 +25,7 @@ int cmd_main(int argc, const char **argv)
 	/* Now, evaluate the *last* parameter */
 	if (argc < 2)
 		return 0;
-	child_argv[0] =3D argv[argc - 1];
-	return run_command_v_opt(child_argv, RUN_USING_SHELL);
+	strvec_push(&cmd.args, argv[argc - 1]);
+	cmd.use_shell =3D 1;
+	return run_command(&cmd);
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

diff --git a/tmp-objdir.h b/tmp-objdir.h
index 76efc7edee..615b188573 100644
=2D-- a/tmp-objdir.h
+++ b/tmp-objdir.h
@@ -11,8 +11,8 @@
  * Example:
  *
  *	struct tmp_objdir *t =3D tmp_objdir_create("incoming");
- *	if (!run_command_v_opt_cd_env(cmd, 0, NULL, tmp_objdir_env(t)) &&
- *	    !tmp_objdir_migrate(t))
+ *	strvec_pushv(&cmd.env, tmp_objdir_env(t));
+ *	if (!run_command(&cmd)) && !tmp_objdir_migrate(t))
  *		printf("success!\n");
  *	else
  *		die("failed...tmp_objdir will clean up for us");
=2D-
2.38.0
