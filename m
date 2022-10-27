Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F76DFA3740
	for <git@archiver.kernel.org>; Thu, 27 Oct 2022 16:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235052AbiJ0QiH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Oct 2022 12:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236551AbiJ0QiD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2022 12:38:03 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC79218F252
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 09:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1666888672; bh=Hd1uKT5Cbyz8k2lJ87VTZTu036aj2FQ2N42BtpzXwSw=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=tR5YX03131p/UfBjm6VtthTMr1fQOfoTAIDfOWWkSy5RZoO+XaUZaEOpPlh+Xofp9
         vY5+LTKJRwI6L9GczC9+Z0RhH1nb6TklGiR+F1YQbxStF0K/6dwU8eghwLzHcfUR+I
         9UeFDTuLWtHRC7e7UE6sqwXIX0wLFOcek1Fvmw78WorfJWW5ijP5OFbjrmeBS8baKT
         vYRPGOIoUpDGmXcWN5SuSNSUl6OcTTDRWEuPqtaHZVEWdhHvrcZI7msPqwMIXycI76
         nrmVMExdhZq/WKsc4aSzpenkTvW0NlZd1YB1Wyezcdfp7xCMblj52AhFgznyHaoKRU
         uYg9bLxjTd9Tg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.191]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MjBRZ-1pK7C12smj-00f7RT; Thu, 27
 Oct 2022 18:37:52 +0200
Message-ID: <0e889c96-6004-96e4-9505-19ce1e7f9900@web.de>
Date:   Thu, 27 Oct 2022 18:37:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: [PATCH 4/8] use child_process member "args" instead of string array
 variable
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
X-Provags-ID: V03:K1:RGmmrzX2WJ+EWyl3Kv0f4YOIqdl72zm+kfpInyM7AF8dv7gAl+k
 c35WF5IaA0D3DqFUKRsPal+9xmljx7v0MdfHxYObiYynkrmjDzhxXK3UYknfOSZY2KWYX/W
 uzYTr1d1i9m3Pk87tWkYEuQNvkk9di4ElKhpu+ow3VBZ+K44HZdeSqUooIzHW35I5A4B4px
 CB14VI+Y3SWVo1md0uhaA==
UI-OutboundReport: notjunk:1;M01:P0:ScaiSMadREI=;Ib3Ka0/nYfoBydWCmy7IL111LG2
 3L1PdztKUiBQBrX94YUtEKlKVp9OAsRH9xeqJA6o/X/mJWrGMpUxMbntcVhiABHi7ynRRqs7I
 QBwnnkPMyhiZ4joxr9ZSM+pI6N9dm0h+xFdZ7lXXT5SHGAvNH4Y//5GuD9PdnjW1kevUL/WrW
 6bbs7XqHetr1/1qQzfFleapyKX+7P22ihBc3Rtr5cJ42/EwvVvlu0XMRqJnIpWD1dfMH9ax+r
 6ATqx2ZHMZyf9lZTKtPoy/sww0j7X9A4gWTteVY5zzyLYV9TVWps5t8ngLMfvj7RQ449iVDIr
 EBybfCW+UwewAR03vRKakJ6/v8L/6vuwHdJl91pNAdL2cwXyoHjDSE7m5uTefEJWZ+AUEnVAG
 YS0C92ADdthXLYHUHbYcfN66BJ9Vj+kCMg8Tgc8I6R0pUNYpnzBEN4cJ0hoAMX6EgdJvTzUbG
 pL/6DlrmRnmBkc1PNlu9WSHgngYKBMhGfdot2kjSEs9sOQ/zeosSon9hxXMrNjUaP9uqBE0/l
 +Ei95nBe1RmeccHSJo4dJBpZajIDJjY4l+Xt8ExTFqqSEjt+3I5J4ziuCEs78FLGKrn4CueeO
 lZ3LtFCJou4sZuCtdNBYU9MV4oVBtoG2pta/DDrHiZ2a+burF16qbcfUD2y7aL/6E9qtPqm1G
 G7+LdEZGpDkjGpYxTO9T8X+iUCgZecikqAriIz+/HXViqz8LlTdv00tnpuvJInJ5n9G/9px03
 iEgTUauWZNNvKvVYzlq6KyWjpE3qfkfTWIpQ/TEGsVq1eD1dyDCjSej9PwDwMluFfm6+HmEJ6
 7rXmwsxwcaYQrO7qpPkcxLJhG10yWrlUSS/r1OCQkLDTvxlpJmPM9EwsK4HcJjb51Oh8vYXxV
 bjD8hvnqYGdEa1V2B7c3J2AEd1UHd7Lf6KYC5463rXJW4f0rQZeiqvMDFJAHMt/+ut22g0wHC
 OpNUB/H82yjAiUaCh7jXYakG9Ls=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use run_command() with a struct child_process variable and populate its
"args" member directly instead of building a string array and passing it
to run_command_v_opt().  This avoids the use of magic index numbers.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 bisect.c                 | 12 ++++++------
 builtin/am.c             | 12 +++++-------
 builtin/difftool.c       | 17 +++++++++--------
 builtin/merge.c          | 32 ++++++++++++--------------------
 builtin/remote.c         | 14 ++++++++------
 compat/mingw.c           | 11 +++++++----
 ll-merge.c               |  7 ++++---
 sequencer.c              |  7 ++++---
 t/helper/test-fake-ssh.c |  7 ++++---
 9 files changed, 59 insertions(+), 60 deletions(-)

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
diff --git a/builtin/difftool.c b/builtin/difftool.c
index 4b10ad1a36..22bcc3444b 100644
=2D-- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -360,8 +360,8 @@ static int run_dir_diff(const char *extcmd, int symlin=
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

@@ -563,16 +563,17 @@ static int run_dir_diff(const char *extcmd, int syml=
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
+	ret =3D run_command(&cmd);

 	/* TODO: audit for interaction with sparse-index. */
 	ensure_full_index(&wtindex);
diff --git a/builtin/merge.c b/builtin/merge.c
index 864808f51a..b3f75f55c8 100644
=2D-- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -347,33 +347,25 @@ static int save_state(struct object_id *stash)

 static void read_empty(const struct object_id *oid)
 {
-	int i =3D 0;
-	const char *args[7];
-
-	args[i++] =3D "read-tree";
-	args[i++] =3D "-m";
-	args[i++] =3D "-u";
-	args[i++] =3D empty_tree_oid_hex();
-	args[i++] =3D oid_to_hex(oid);
-	args[i] =3D NULL;
+	struct child_process cmd =3D CHILD_PROCESS_INIT;
+
+	strvec_pushl(&cmd.args, "read-tree", "-m", "-u", empty_tree_oid_hex(),
+		     oid_to_hex(oid), NULL);
+	cmd.git_cmd =3D 1;

-	if (run_command_v_opt(args, RUN_GIT_CMD))
+	if (run_command(&cmd))
 		die(_("read-tree failed"));
 }

 static void reset_hard(const struct object_id *oid)
 {
-	int i =3D 0;
-	const char *args[6];
-
-	args[i++] =3D "read-tree";
-	args[i++] =3D "-v";
-	args[i++] =3D "--reset";
-	args[i++] =3D "-u";
-	args[i++] =3D oid_to_hex(oid);
-	args[i] =3D NULL;
+	struct child_process cmd =3D CHILD_PROCESS_INIT;
+
+	strvec_pushl(&cmd.args, "read-tree", "-v", "--reset", "-u",
+		     oid_to_hex(oid), NULL);
+	cmd.git_cmd =3D 1;

-	if (run_command_v_opt(args, RUN_GIT_CMD))
+	if (run_command(&cmd))
 		die(_("read-tree failed"));
 }

diff --git a/builtin/remote.c b/builtin/remote.c
index 11304c096a..12632676cd 100644
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
+	cmd.git_cmd =3D 1;
 	printf_ln(_("Updating %s"), name);
-	if (run_command_v_opt(argv, RUN_GIT_CMD))
+	if (run_command(&cmd))
 		return error(_("Could not fetch %s"), name);
 	return 0;
 }
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
diff --git a/ll-merge.c b/ll-merge.c
index 8955d7e1f6..d5f0c62bd8 100644
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
+	child.use_shell =3D 1;
+	strvec_push(&child.args, cmd.buf);
+	status =3D run_command(&child);
 	fd =3D open(temp[1], O_RDONLY);
 	if (fd < 0)
 		goto bad;
diff --git a/sequencer.c b/sequencer.c
index 8ab0225f0f..643744fb9b 100644
=2D-- a/sequencer.c
+++ b/sequencer.c
@@ -3555,12 +3555,13 @@ static int error_failed_squash(struct repository *=
r,

 static int do_exec(struct repository *r, const char *command_line)
 {
-	const char *child_argv[] =3D { NULL, NULL };
+	struct child_process cmd =3D CHILD_PROCESS_INIT;
 	int dirty, status;

 	fprintf(stderr, _("Executing: %s\n"), command_line);
-	child_argv[0] =3D command_line;
-	status =3D run_command_v_opt(child_argv, RUN_USING_SHELL);
+	cmd.use_shell =3D 1;
+	strvec_push(&cmd.args, command_line);
+	status =3D run_command(&cmd);

 	/* force re-reading of the cache */
 	if (discard_index(r->index) < 0 || repo_read_index(r) < 0)
diff --git a/t/helper/test-fake-ssh.c b/t/helper/test-fake-ssh.c
index 12beee99ad..2e576bcc11 100644
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
+	cmd.use_shell =3D 1;
+	strvec_push(&cmd.args, argv[argc - 1]);
+	return run_command(&cmd);
 }
=2D-
2.38.1
