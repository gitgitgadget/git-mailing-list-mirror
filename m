Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCC6FA373D
	for <git@archiver.kernel.org>; Thu, 27 Oct 2022 23:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235239AbiJ0XC1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Oct 2022 19:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234642AbiJ0XCY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2022 19:02:24 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C465495E3
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 16:02:22 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id b2so8946171eja.6
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 16:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D4rrZIxpxMsNu2lw0aHENjPo0sxoYQOsDJqOsRjGhCk=;
        b=Nsq87OfOJIyj7fhDRD0J5Qzq75O94YV6H+B88VzRzAqOYBvn3Y0BKBH9zjYHaJTMzw
         H2E6ijLWkyZguTqt2d3nhZxh9Hs2i76qCxKAD8U5EDvPjbmMPLzIbHGPFRhwjiJKQNaN
         +DAXP+VYoaem+rUUKB4z2zLyEjCnVtHzDzVyjY6ZLteB11TB/OYE5ewlNXl50l7If3Vh
         wV7ho9yNrqBQd2XqoshlxiJO/WkVT67v05Hmccip4cVRhlMaS0tCUH4qEPPTFVazJ+OR
         ppkF00ms6pvve3gXSLj0t5uxO8ECO4bHXqwHuLRHrzEc+Zu6MzQcor5sSUWauK0L7DsK
         42Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D4rrZIxpxMsNu2lw0aHENjPo0sxoYQOsDJqOsRjGhCk=;
        b=n+uXjdEi92bTt3BQ8NImckoTRY6OBjJ9LMsJTRmm1xRM4aE2U5Fy+xpOZSK4oXoBLc
         /q8vYdm8zqYYPQJJpC04/GaE5hqUFNMlmbigQrRsnb7W39jx/RqYA72Qz/ODZ/0tle8S
         G9N8/2TL4krXQgDjIJxYQv+PwGkbxpPv637GmokgSmgjmTBO+Zl1BNQrtBiGzpadhBsg
         DoB7ghYjdkLxHvDQkUYCZIM/dSho0OGBXI/zUPL2O1gwS2k+HIGxWxIgwB/DVW9kG697
         KzUOz7Mo0knlMoBHmlrXfqZUHJa9ZEorQUjjD/m09cA65GNO5X9/EJHuoUfHYNB/uehE
         0+eg==
X-Gm-Message-State: ACrzQf1U3RYFOO2glHSyzAO1oEEnkZGrzsCUXz3wL1cvbD9Vi09LnE/W
        e5jKlU/IHedWvqAiSXY/rEBWKUnQ10RB+A==
X-Google-Smtp-Source: AMsMyM6sKK9uoLZ84GdaPUOPupumrIVLMzN/mPRlZET1eSvE6ODT3qOAkDb1Yrat1YeZMo/lfJhQYg==
X-Received: by 2002:a17:907:980e:b0:78d:b6d5:661e with SMTP id ji14-20020a170907980e00b0078db6d5661emr44364127ejc.46.1666911740946;
        Thu, 27 Oct 2022 16:02:20 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id w18-20020a1709067c9200b007acc5a42e77sm1368243ejo.88.2022.10.27.16.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 16:02:20 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ooBtD-009eJz-1f;
        Fri, 28 Oct 2022 01:02:19 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/8] run-command: remove run_command_v_*()
Date:   Thu, 27 Oct 2022 23:46:50 +0200
References: <7407e074-4bd8-b351-7fa4-baf59b41880c@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <7407e074-4bd8-b351-7fa4-baf59b41880c@web.de>
Message-ID: <221028.86edusan0k.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 27 2022, Ren=C3=A9 Scharfe wrote:

> Replace the convenience functions run_command_v_opt() et. al. and use
> struct child_process and run_command() directly instead, for an overall
> code reduction and a simpler and more flexible API that allows creating
> argument lists without magic numbers and reduced risk of memory leaks.
>
> This is a broken-out and polished version of the original scratch at
> https://lore.kernel.org/git/9d924a5d-5c72-fbe6-270c-a8f6c5fc5850@web.de/
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (1):
>   merge: remove always-the-same "verbose" arguments
>
> Ren=C3=A9 Scharfe (7):
>   bisect--helper: factor out do_bisect_run()
>   use child_process members "args" and "env" directly
>   use child_process member "args" instead of string array variable
>   replace and remove run_command_v_opt_cd_env()
>   replace and remove run_command_v_opt_tr2()
>   replace and remove run_command_v_opt_cd_env_tr2()
>   replace and remove run_command_v_opt()

Even though I had a an earlier alternate series series[1] for this I'd
be happy to see this version go in. I left some comments here and there,
but with/without a re-roll am happy to give this:

	Reviewed-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

I think I would have just gone for this in the first place, but thought
that people loved the convenience functions too much. It can be hard to
judge sentiments in advance :)

One reason I hadn't re-submitted something is that there were
outstanding new conflicts with "seen", and I see from applying this
topic & merging it that it conflicts somewhat heavily. Junio seems to be
on-board with this though, so maybe he won't mind.

I didn't see any glaring instances where this made things worse, so
maybe we didn't need these convenience wrappers in the first place.

But from the earlier discussion it does seema bit like we tossed the
very notion out because some didn't like the duplicating of struct
members with the flags (which I also doen't like).

So I came up with the below experiment on top, it's not an attempt to
convert all callers, just a demo.

Maybe you think some ideas here are worth using, I probably won't pursue
it (but maybe as ideas for some other future API).

It's a combination of stuff, some of which you might like, some not,
namely:

- Have the API work the same way, but just have a run_commandl(&opt,
  ...) in addition to the run_command(). It's just a trivial wrapper to
  push stuff into &cmd.args for you.

- I saw a few callers that could have perhaps used a similarly trivial
  run_commandv(), but that doesn't benefit from LAST_ARG_MUST_BE_NULL,
  so I didn't bother.

- I wish C had a nicer syntax for not just declaring but squashing
  together compile_time bracketed lists (think set operations). But the
  below "CHILD_PROCESS_INIT_LIST" is a pretty good poor man's version.

  I see gcc/clang nicely give us safety rails for that with
  "-Woverride-init", for this sort of "opts struct with internal stuff,
  but also user options" I think it works out very nicely.

- We have quite a few callers that want "on error, die", so maybe we
  should have something like that "on_error" sooner than later.

On clever (but perhaps overly clever) thing I didn't use, but played
with recently in another context, is that now with C99 you can also do:

	int run_commandl(struct child_process *cmd, ...);
	#define run_command(...) run_command_1(__VA_ARGS__, NULL)

I.e. make the API itself support all of:

	run_command(&cmd);
	run_command(&cmd, "reboot");
	run_command(&cmd, "reboot", NULL);

I haven't made up my mind on whether that's just overly clever, or
outright insane :)

diff --git a/bisect.c b/bisect.c
index ec7487e6836..ef4f80650f7 100644
--- a/bisect.c
+++ b/bisect.c
@@ -740,9 +740,8 @@ enum bisect_error bisect_checkout(const struct object_i=
d *bisect_rev,
 		struct child_process cmd =3D CHILD_PROCESS_INIT;
=20
 		cmd.git_cmd =3D 1;
-		strvec_pushl(&cmd.args, "checkout", "-q",
-			     oid_to_hex(bisect_rev), "--", NULL);
-		if (run_command(&cmd))
+		if (run_commandl(&cmd, "checkout", "-q",
+				 oid_to_hex(bisect_rev), "--", NULL))
 			/*
 			 * Errors in `run_command()` itself, signaled by res < 0,
 			 * and errors in the child process, signaled by res > 0
diff --git a/builtin/am.c b/builtin/am.c
index 20aea0d2487..3b7df32ce22 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2189,10 +2189,9 @@ static int show_patch(struct am_state *state, enum s=
how_patch_type sub_mode)
 	if (!is_null_oid(&state->orig_commit)) {
 		struct child_process cmd =3D CHILD_PROCESS_INIT;
=20
-		strvec_pushl(&cmd.args, "show", oid_to_hex(&state->orig_commit),
-			     "--", NULL);
 		cmd.git_cmd =3D 1;
-		return run_command(&cmd);
+		return run_commandl(&cmd, "show", oid_to_hex(&state->orig_commit),
+				    "--", NULL);
 	}
=20
 	switch (sub_mode) {
diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 1d2ce8a0e12..087d21c614a 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -764,12 +764,12 @@ static enum bisect_error bisect_start(struct bisect_t=
erms *terms, const char **a
 		strbuf_read_file(&start_head, git_path_bisect_start(), 0);
 		strbuf_trim(&start_head);
 		if (!no_checkout) {
-			struct child_process cmd =3D CHILD_PROCESS_INIT;
-
-			cmd.git_cmd =3D 1;
-			strvec_pushl(&cmd.args, "checkout", start_head.buf,
-				     "--", NULL);
-			if (run_command(&cmd)) {
+			struct child_process cmd =3D {
+				CHILD_PROCESS_INIT_LIST,
+				.git_cmd =3D 1,
+			};
+			if (run_commandl(&cmd, "checkout", start_head.buf,
+					 "--", NULL)) {
 				res =3D error(_("checking out '%s' failed."
 						 " Try 'git bisect start "
 						 "<valid-branch>'."),
@@ -1147,8 +1147,7 @@ static int do_bisect_run(const char *command)
=20
 	printf(_("running %s\n"), command);
 	cmd.use_shell =3D 1;
-	strvec_push(&cmd.args, command);
-	return run_command(&cmd);
+	return run_commandl(&cmd, command, NULL);
 }
=20
 static int verify_good(const struct bisect_terms *terms, const char *comma=
nd)
diff --git a/builtin/clone.c b/builtin/clone.c
index 0e4348686b6..80d09e0fbf1 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -655,7 +655,6 @@ static int git_sparse_checkout_init(const char *repo)
 {
 	struct child_process cmd =3D CHILD_PROCESS_INIT;
 	int result =3D 0;
-	strvec_pushl(&cmd.args, "-C", repo, "sparse-checkout", "set", NULL);
=20
 	/*
 	 * We must apply the setting in the current process
@@ -664,7 +663,7 @@ static int git_sparse_checkout_init(const char *repo)
 	core_apply_sparse_checkout =3D 1;
=20
 	cmd.git_cmd =3D 1;
-	if (run_command(&cmd)) {
+	if (run_commandl(&cmd, "-C", repo, "sparse-checkout", "set", NULL)) {
 		error(_("failed to initialize sparse-checkout"));
 		result =3D 1;
 	}
@@ -868,13 +867,14 @@ static void dissociate_from_references(void)
 	char *alternates =3D git_pathdup("objects/info/alternates");
=20
 	if (!access(alternates, F_OK)) {
-		struct child_process cmd =3D CHILD_PROCESS_INIT;
-
-		cmd.git_cmd =3D 1;
-		cmd.no_stdin =3D 1;
-		strvec_pushl(&cmd.args, "repack", "-a", "-d", NULL);
-		if (run_command(&cmd))
-			die(_("cannot repack to clean up"));
+		struct child_process cmd =3D {
+			CHILD_PROCESS_INIT_LIST,
+			.git_cmd =3D 1,
+			.no_stdin =3D 1,
+			.on_error =3D CHILD_PROCESS_ON_ERROR_DIE,
+		};
+
+		run_commandl(&cmd, "repack", "-a", "-d", NULL);
 		if (unlink(alternates) && errno !=3D ENOENT)
 			die_errno(_("cannot unlink temporary alternates file"));
 	}
diff --git a/builtin/difftool.c b/builtin/difftool.c
index d7f08c8a7fa..b4165b5a8ae 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -44,11 +44,12 @@ static int difftool_config(const char *var, const char =
*value, void *cb)
=20
 static int print_tool_help(void)
 {
-	struct child_process cmd =3D CHILD_PROCESS_INIT;
-
-	cmd.git_cmd =3D 1;
-	strvec_pushl(&cmd.args, "mergetool", "--tool-help=3Ddiff", NULL);
-	return run_command(&cmd);
+	struct child_process cmd =3D {
+		CHILD_PROCESS_INIT_LIST,
+		.git_cmd =3D 1,
+	};
+=09=09
+	return run_commandl(&cmd, "mergetool", "--tool-help=3Ddiff", NULL);
 }
=20
 static int parse_index_info(char *p, int *mode1, int *mode2,
diff --git a/git.c b/git.c
index 6662548986f..93179f44f78 100644
--- a/git.c
+++ b/git.c
@@ -724,7 +724,13 @@ static void handle_builtin(int argc, const char **argv)
=20
 static void execv_dashed_external(const char **argv)
 {
-	struct child_process cmd =3D CHILD_PROCESS_INIT;
+	struct child_process cmd =3D {
+		CHILD_PROCESS_INIT_LIST,
+		.clean_on_exit =3D 1,
+		.wait_after_clean =3D 1,
+		.silent_exec_failure =3D 1,
+		.trace2_child_class =3D "dashed",
+	};
 	int status;
=20
 	if (get_super_prefix())
@@ -736,10 +742,6 @@ static void execv_dashed_external(const char **argv)
=20
 	strvec_pushf(&cmd.args, "git-%s", argv[0]);
 	strvec_pushv(&cmd.args, argv + 1);
-	cmd.clean_on_exit =3D 1;
-	cmd.wait_after_clean =3D 1;
-	cmd.silent_exec_failure =3D 1;
-	cmd.trace2_child_class =3D "dashed";
=20
 	trace2_cmd_name("_run_dashed_");
=20
diff --git a/run-command.c b/run-command.c
index 23e100dffc4..4b20aa1b577 100644
--- a/run-command.c
+++ b/run-command.c
@@ -993,15 +993,45 @@ int finish_command_in_signal(struct child_process *cm=
d)
=20
 int run_command(struct child_process *cmd)
 {
-	int code;
+	int starting =3D 1;
+	int code =3D 0;
=20
 	if (cmd->out < 0 || cmd->err < 0)
 		BUG("run_command with a pipe can cause deadlock");
=20
 	code =3D start_command(cmd);
 	if (code)
+		goto error;
+	starting =3D 0;
+	code =3D finish_command(cmd);
+	if (!code)
+		return 0;
+error:
+	switch (cmd->on_error) {
+	case CHILD_PROCESS_ON_ERROR_DIE:
+		die(starting ?
+		    _("start_command() for '%s' failed (error code %d)") :
+		    _("'%s': got non-zero exit code '%d'"),
+		    cmd->args.v[0], code);
+		break;
+	case CHILD_PROCESS_ON_ERROR_RETURN:
 		return code;
-	return finish_command(cmd);
+	default:
+		BUG("unreachable");
+	}
+}
+
+int run_commandl(struct child_process *cmd, ...)
+{
+	va_list ap;
+	const char *arg;
+
+	va_start(ap, cmd);
+	while ((arg =3D va_arg(ap, const char *)))
+		strvec_push(&cmd->args, arg);
+	va_end(ap);
+
+	return run_command(cmd);
 }
=20
 #ifndef NO_PTHREADS
diff --git a/run-command.h b/run-command.h
index fe2717ad11e..71e390350ed 100644
--- a/run-command.h
+++ b/run-command.h
@@ -15,7 +15,22 @@
  * produces in the caller in order to process it.
  */
=20
+enum child_process_on_error {
+	/**
+	 * Return a status code from run_command(). Set to 0 so that
+	 * it'll be { 0 } init'd. If it's specified in a
+	 * CHILD_PROCESS_INIT_LIST initialization we don't want a
+	 * "-Woverride-init" warning.
+	 */
+	CHILD_PROCESS_ON_ERROR_RETURN =3D 0,
=20
+	/**
+	 * die() with some sensible message if run_command() would
+	 * have returned a non-zero exit code.
+	 */
+	CHILD_PROCESS_ON_ERROR_DIE,
+};
+=09
 /**
  * This describes the arguments, redirections, and environment of a
  * command to run in a sub-process.
@@ -42,6 +57,10 @@
  *		redirected.
  */
 struct child_process {
+	/**
+	 * Error behavior, see "enum child_process_on_error" above.
+	 */
+	enum child_process_on_error on_error;
=20
 	/**
 	 * The .args is a `struct strvec', use that API to manipulate
@@ -144,10 +163,11 @@ struct child_process {
 	void (*clean_on_exit_handler)(struct child_process *process);
 };
=20
-#define CHILD_PROCESS_INIT { \
+#define CHILD_PROCESS_INIT_LIST \
+	/* .on_error =3D CHILD_PROCESS_ON_ERROR_RETURN */ \
 	.args =3D STRVEC_INIT, \
-	.env =3D STRVEC_INIT, \
-}
+	.env =3D STRVEC_INIT
+#define CHILD_PROCESS_INIT { CHILD_PROCESS_INIT_LIST }
=20
 /**
  * The functions: child_process_init, start_command, finish_command,
@@ -218,6 +238,14 @@ int finish_command_in_signal(struct child_process *);
  */
 int run_command(struct child_process *);
=20
+/**
+ * Like run_command() but takes a variable number of arguments, which
+ * will be appended with the equivalent of strvec_pushl(&cmd.args,
+ * ...) before invoking run_command().
+ */
+LAST_ARG_MUST_BE_NULL
+int run_commandl(struct child_process *cmd, ...);
+
 /*
  * Trigger an auto-gc
  */
