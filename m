Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BFCC433FE
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 13:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbiJRNl2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Oct 2022 09:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbiJRNlT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2022 09:41:19 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9001F611
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 06:41:16 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id q9so32369893ejd.0
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 06:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZvSnZmXA5WI3ejIQpfya/EivQNwU7o0Wjl3SnLagclA=;
        b=CYWXVh/PYbVKr5DEO17rjyEIImJng9gUC6AD9zyuD+o2bQDLB2P6cb6t7iYIM8ArVl
         VGWuIix8bwNdlJ6EWb1Vkxu5zaNdnK7nAk73ULvtFxTTM6rVphSa1/Q/5Ueo4DFFX5a1
         E6yUwkp0alxaDdD+uGRL6AjqbLmsjJdeTiEir+uCznZjjeKZNoiuemVvQ7SF5anAQod4
         i6zkglZfPLDfBjoUyyKVzb6M2cdtKuhTHC6dil1CLmOyXqlkhsfCs7B3FP0h+iSd7yOJ
         gg42xTdq86R1tZWownVHNB/BGiSi65ZRYUJjvGOTLCxpjY31mIAKV2zs6apBrJ81xfHR
         Dfaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZvSnZmXA5WI3ejIQpfya/EivQNwU7o0Wjl3SnLagclA=;
        b=Lb5BAjAt8wAVENEDYIMg5SxdzY4jENanHCrjas8QHePhgX39V0KWJzjHILk8mHvknQ
         4GXRur6XQqMjXwTUExRIDp0QeUyk6JYQ7W8X3ALfAJhwFbvJxOqL91lgM1n7oeX5gnc5
         tnhmrY+4voFNUPoEG1Jw4mX+yqvB9qlVYdRwLzMCV9DELxrmnfgxbUpMLoHR/FmQvnqw
         4C7jedGLBt/HWnnNy0+iGs2ME/AzglaVZk4Bk+nodDcREiSloroOZGRpcS6X0imfflAw
         m46BmCoQCAynyZ7Wgb0ENBzniA6JxtqNvqS1Hlb+xn0VV3YwZmufPEL8OCi/onDSbbSb
         ykfg==
X-Gm-Message-State: ACrzQf2j4t1/2WoNYvB5IbdsOyVJFdYNooP+4NC87+BB+47nfbHqKGzQ
        qxp78862EMAjZcSP66zigQw=
X-Google-Smtp-Source: AMsMyM4b9D9M2nQrI9VH9Wxx8IwgIE1uFlxzb0zCdWyzk2Q0bAiKB0nap/hTEPHs/3zpf9N9LhfZWA==
X-Received: by 2002:a17:907:d08:b0:72f:b107:c07a with SMTP id gn8-20020a1709070d0800b0072fb107c07amr2492587ejc.340.1666100474642;
        Tue, 18 Oct 2022 06:41:14 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id j18-20020a17090623f200b007417041fb2bsm7536173ejg.116.2022.10.18.06.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 06:41:14 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1okmqH-005m5k-1A;
        Tue, 18 Oct 2022 15:41:13 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2 00/10] run-command API: add run_command_{l,sv}_opt()
Date:   Tue, 18 Oct 2022 15:28:43 +0200
References: <cover-00.10-00000000000-20221014T153426Z-avarab@gmail.com>
 <cover-v2-00.10-00000000000-20221017T170316Z-avarab@gmail.com>
 <xmqq4jw1wl6z.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <xmqq4jw1wl6z.fsf@gitster.g>
Message-ID: <221018.86a65ti70m.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 18 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> This series provides a more idiomatic set of run-command API helpers
>> to match our current use-cases for run_command_v_opt(). See v1[1] for
>> a more general overview.
>
> Hmph...  I somehow thought that the concensus is rather try the
> complete opposite approach shown by Ren=C3=A9's patch to lose the use of
> run_command_v_opt() by replacing it with run_command(&args), with
> args.v populated using strvec_pushl() and other strvec API
> functions.
>
> One of the reasons I would prefer to see us moving in that direction
> was because the first iteration of this series was a good
> demonstration of the relatively limited usefulness of _l_opt()
> variant and also it seemed to be error prone to use it.

I'm getting somewhat mixed messages. Jeff seemed to like the end-to-end
safety of run_command_l_opt() before I wrote it. I think the
run_command_l_opt() still really shines for the simple cases.

I don't see how *_l_opt() is particularly error prone, I just had a
stupid think-o in v1 of this, but that if/else if bug is something that
could have snuck in with run_command() given the same stupidity :)

I checked out Ren=C3=A9's [1] and diff'd it with mine, excluding various
parts that inflated the diff for no good explanatory purpose (e.g. the
API itself, or where I omitted some conversions).

I think the diffstat is a good argument for *some* version of my series,
but as e.g. the first hunk shows we could also just convert
e.g. run_diff() to run_command() instead of run_command_sv_opt().

I wonder if a run_command() that just had the prototype (struct
child_process *cmd, ...) might not be the best of both worlds (or a
run_commandl() alternative). I.e. to do away with the whole custom way
of specifying the flag(s), and just take the passed-in arguments and
append them to "&cmd.args".

That would give us run_command_l_opt() behavior, which is handy in some
cases, and gives us compile-time checks. We could BUG() out if
"cmd.args.nr > 0" if we use it, to ensure we use one or the other
(although a combination would be handy in some cases, so maybe not).

What do you all think?

It's also interesting to consider adding a --noop option to be supported
by parse-options.c. The reason we can't use a run_command_l_opt() in
some cases is because we're doing e.g.:

	if (progress)
		strvec_push(&args, "--progress");

We have a --no-progress, but in those cases the recipient at the end
often cares about a default of -1 for a bool variable, or similar. So if
we could do:

	run_command_l_opt(0, command,
		(progress ? "--progress" : "--noop"),
		...,
		NULL
	);

We could benefit from compile-time checks, and wouldn't have to allocate
a strvec just for building up the arguments in some cases. Just food for
thought...

1. https://lore.kernel.org/git/9d924a5d-5c72-fbe6-270c-a8f6c5fc5850@web.de/

 add-interactive.c        |   8 +--
 builtin/add.c            |  15 +++---
 builtin/am.c             |  12 +++--
 builtin/clone.c          |  44 +++++++++------
 builtin/difftool.c       |  24 +++++----
 builtin/fetch.c          |   9 ++--
 builtin/gc.c             |  74 ++++++++++++++++---------
 builtin/merge-index.c    |   4 +-
 builtin/pull.c           | 138 ++++++++++++++++++++++++-------------------=
----
 builtin/remote.c         |  37 +++++++------
 compat/mingw.c           |  11 ++--
 diff.c                   |   5 +-
 fsmonitor-ipc.c          |   4 +-
 ll-merge.c               |   5 +-
 merge.c                  |  17 +++---
 scalar.c                 |   9 ++--
 sequencer.c              |  23 ++++----
 t/helper/test-fake-ssh.c |   5 +-
 t/helper/test-trace2.c   |   4 +-
 tmp-objdir.h             |   6 +--
 20 files changed, 265 insertions(+), 189 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 9c86f3b9532..ecc5ae1b249 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -997,17 +997,17 @@ static int run_diff(struct add_i_state *s, const stru=
ct pathspec *ps,
 	count =3D list_and_choose(s, files, opts);
 	opts->flags =3D 0;
 	if (count > 0) {
-		struct strvec args =3D STRVEC_INIT;
+		struct child_process cmd =3D CHILD_PROCESS_INIT;
=20
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
-		res =3D run_command_sv_opt(&args, 0);
+		res =3D run_command(&cmd);
 	}
=20
 	putchar('\n');
diff --git a/builtin/add.c b/builtin/add.c
index 7c783eebc0e..626c71ec6aa 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -241,7 +241,7 @@ int run_add_interactive(const char *revision, const cha=
r *patch_mode,
 			const struct pathspec *pathspec)
 {
 	int i;
-	struct strvec argv =3D STRVEC_INIT;
+	struct child_process cmd =3D CHILD_PROCESS_INIT;
 	int use_builtin_add_i =3D
 		git_env_bool("GIT_TEST_ADD_I_USE_BUILTIN", -1);
=20
@@ -272,17 +272,18 @@ int run_add_interactive(const char *revision, const c=
har *patch_mode,
 		return !!run_add_p(the_repository, mode, revision, pathspec);
 	}
=20
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
=20
-	return run_command_sv_opt(&argv, RUN_GIT_CMD);
+	cmd.git_cmd =3D 1;
+	return run_command(&cmd);
 }
=20
 int interactive_add(const char **argv, const char *prefix, int patch)
diff --git a/builtin/am.c b/builtin/am.c
index 1d298a91306..20aea0d2487 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2186,10 +2186,14 @@ static int show_patch(struct am_state *state, enum =
show_patch_type sub_mode)
 	const char *patch_path;
 	int len;
=20
-	if (!is_null_oid(&state->orig_commit))
-		return run_command_l_opt(RUN_GIT_CMD, "show",
-					 oid_to_hex(&state->orig_commit),
-					 "--", NULL);
+	if (!is_null_oid(&state->orig_commit)) {
+		struct child_process cmd =3D CHILD_PROCESS_INIT;
+
+		strvec_pushl(&cmd.args, "show", oid_to_hex(&state->orig_commit),
+			     "--", NULL);
+		cmd.git_cmd =3D 1;
+		return run_command(&cmd);
+	}
=20
 	switch (sub_mode) {
 	case SHOW_PATCH_RAW:
diff --git a/builtin/clone.c b/builtin/clone.c
index 8e43781e147..219cfbd7355 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -651,19 +651,23 @@ static void update_head(const struct ref *our, const =
struct ref *remote,
=20
 static int git_sparse_checkout_init(const char *repo)
 {
+	struct child_process cmd =3D CHILD_PROCESS_INIT;
+	int result =3D 0;
+	strvec_pushl(&cmd.args, "-C", repo, "sparse-checkout", "set", NULL);
+
 	/*
 	 * We must apply the setting in the current process
 	 * for the later checkout to use the sparse-checkout file.
 	 */
 	core_apply_sparse_checkout =3D 1;
=20
-	if (run_command_l_opt(RUN_GIT_CMD, "-C", repo, "sparse-checkout",
-			      "set", NULL)) {
+	cmd.git_cmd =3D 1;
+	if (run_command(&cmd)) {
 		error(_("failed to initialize sparse-checkout"));
-		return 1;
+		result =3D 1;
 	}
=20
-	return 0;
+	return result;
 }
=20
 static int checkout(int submodule_progress, int filter_submodules)
@@ -727,36 +731,38 @@ static int checkout(int submodule_progress, int filte=
r_submodules)
 			   oid_to_hex(&oid), "1", NULL);
=20
 	if (!err && (option_recurse_submodules.nr > 0)) {
-		struct strvec args =3D STRVEC_INIT;
-		strvec_pushl(&args, "submodule", "update", "--require-init", "--recursiv=
e", NULL);
+		struct child_process cmd =3D CHILD_PROCESS_INIT;
+		strvec_pushl(&cmd.args, "submodule", "update", "--require-init",
+			     "--recursive", NULL);
=20
 		if (option_shallow_submodules =3D=3D 1)
-			strvec_push(&args, "--depth=3D1");
+			strvec_push(&cmd.args, "--depth=3D1");
=20
 		if (max_jobs !=3D -1)
-			strvec_pushf(&args, "--jobs=3D%d", max_jobs);
+			strvec_pushf(&cmd.args, "--jobs=3D%d", max_jobs);
=20
 		if (submodule_progress)
-			strvec_push(&args, "--progress");
+			strvec_push(&cmd.args, "--progress");
=20
 		if (option_verbosity < 0)
-			strvec_push(&args, "--quiet");
+			strvec_push(&cmd.args, "--quiet");
=20
 		if (option_remote_submodules) {
-			strvec_push(&args, "--remote");
-			strvec_push(&args, "--no-fetch");
+			strvec_push(&cmd.args, "--remote");
+			strvec_push(&cmd.args, "--no-fetch");
 		}
=20
 		if (filter_submodules && filter_options.choice)
-			strvec_pushf(&args, "--filter=3D%s",
+			strvec_pushf(&cmd.args, "--filter=3D%s",
 				     expand_list_objects_filter_spec(&filter_options));
=20
 		if (option_single_branch >=3D 0)
-			strvec_push(&args, option_single_branch ?
+			strvec_push(&cmd.args, option_single_branch ?
 					       "--single-branch" :
 					       "--no-single-branch");
=20
-		return run_command_sv_opt(&args, RUN_GIT_CMD);
+		cmd.git_cmd =3D 1;
+		err =3D run_command(&cmd);
 	}
=20
 	return err;
@@ -860,8 +866,12 @@ static void dissociate_from_references(void)
 	char *alternates =3D git_pathdup("objects/info/alternates");
=20
 	if (!access(alternates, F_OK)) {
-		if (run_command_l_opt(RUN_GIT_CMD|RUN_COMMAND_NO_STDIN,
-				      "repack", "-a", "-d", NULL))
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
index ed211a87322..d6c262e15ff 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -44,8 +44,10 @@ static int difftool_config(const char *var, const char *=
value, void *cb)
=20
 static int print_tool_help(void)
 {
-	return run_command_l_opt(RUN_GIT_CMD, "mergetool", "--tool-help=3Ddiff",
-				 NULL);
+	struct child_process cmd =3D CHILD_PROCESS_INIT;
+	strvec_pushl(&cmd.args, "mergetool", "--tool-help=3Ddiff", NULL);
+	cmd.git_cmd =3D 1;
+	return run_command(&cmd);
 }
=20
 static int parse_index_info(char *p, int *mode1, int *mode2,
@@ -360,8 +362,8 @@ static int run_dir_diff(const char *extcmd, int symlink=
s, const char *prefix,
 	struct pair_entry *entry;
 	struct index_state wtindex;
 	struct checkout lstate, rstate;
-	int flags =3D RUN_GIT_CMD, err =3D 0;
-	const char *helper_command =3D "difftool--helper";
+	int err =3D 0;
+	struct child_process cmd =3D CHILD_PROCESS_INIT;
 	struct hashmap wt_modified, tmp_modified;
 	int indices_loaded =3D 0;
=20
@@ -564,13 +566,17 @@ static int run_dir_diff(const char *extcmd, int symli=
nks, const char *prefix,
=20
 	strbuf_setlen(&ldir, ldir_len);
 	strbuf_setlen(&rdir, rdir_len);
+
 	if (extcmd) {
-		helper_command =3D extcmd;
-		flags =3D 0;
-	} else
+		strvec_push(&cmd.args, extcmd);
+	} else {
+		strvec_push(&cmd.args, "difftool--helper");
+		cmd.git_cmd =3D 1;
 		setenv("GIT_DIFFTOOL_DIRDIFF", "true", 1);
-	ret =3D run_command_l_opt(flags, helper_command, ldir.buf, rdir.buf,
-				NULL);
+	}
+	strvec_pushl(&cmd.args, ldir.buf, rdir.buf, NULL);
+
+	ret =3D run_command(&cmd);
=20
 	/* TODO: audit for interaction with sparse-index. */
 	ensure_full_index(&wtindex);
diff --git a/builtin/fetch.c b/builtin/fetch.c
index a0fca93bb6a..dd060dd65af 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1965,14 +1965,17 @@ static int fetch_multiple(struct string_list *list,=
 int max_children)
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
=20
 	strvec_clear(&argv);
diff --git a/builtin/gc.c b/builtin/gc.c
index 8393e19b504..b47e53c2101 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -58,6 +58,8 @@ static unsigned long max_delta_cache_size =3D DEFAULT_DEL=
TA_CACHE_SIZE;
 static struct strvec reflog =3D STRVEC_INIT;
 static struct strvec repack =3D STRVEC_INIT;
 static struct strvec prune =3D STRVEC_INIT;
+static struct strvec prune_worktrees =3D STRVEC_INIT;
+static struct strvec rerere =3D STRVEC_INIT;
=20
 static struct tempfile *pidfile;
 static struct lock_file log_lock;
@@ -165,8 +167,11 @@ static void gc_config(void)
 struct maintenance_run_opts;
 static int maintenance_task_pack_refs(MAYBE_UNUSED struct maintenance_run_=
opts *opts)
 {
-	return run_command_l_opt(RUN_GIT_CMD, "pack-refs", "--all", "--prune",
-				 NULL);
+	struct child_process cmd =3D CHILD_PROCESS_INIT;
+
+	strvec_pushl(&cmd.args, "pack-refs", "--all", "--prune", NULL);
+	cmd.git_cmd =3D 1;
+	return run_command(&cmd);
 }
=20
 static int too_many_loose_objects(void)
@@ -518,6 +523,16 @@ static int report_last_gc_error(void)
 	return ret;
 }
=20
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
@@ -532,8 +547,8 @@ static void gc_before_repack(void)
 	if (pack_refs && maintenance_task_pack_refs(NULL))
 		die(FAILED_RUN, "pack-refs");
=20
-	if (prune_reflogs && run_command_v_opt(reflog.v, RUN_GIT_CMD))
-		die(FAILED_RUN, reflog.v[0]);
+	if (prune_reflogs)
+		run_git_or_die(reflog.v);
 }
=20
 int cmd_gc(int argc, const char **argv, const char *prefix)
@@ -571,6 +586,8 @@ int cmd_gc(int argc, const char **argv, const char *pre=
fix)
 	strvec_pushl(&reflog, "reflog", "expire", "--all", NULL);
 	strvec_pushl(&repack, "repack", "-d", "-l", NULL);
 	strvec_pushl(&prune, "prune", "--expire", NULL);
+	strvec_pushl(&prune_worktrees, "worktree", "prune", "--expire", NULL);
+	strvec_pushl(&rerere, "rerere", "gc", NULL);
=20
 	/* default expiry time, overwritten in gc_config */
 	gc_config();
@@ -666,8 +683,12 @@ int cmd_gc(int argc, const char **argv, const char *pr=
efix)
 	gc_before_repack();
=20
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
=20
 		if (prune_expire) {
@@ -678,18 +699,16 @@ int cmd_gc(int argc, const char **argv, const char *p=
refix)
 			if (has_promisor_remote())
 				strvec_push(&prune,
 					    "--exclude-promisor-objects");
-			if (run_command_v_opt(prune.v, RUN_GIT_CMD))
-				die(FAILED_RUN, prune.v[0]);
+			run_git_or_die(prune.v);
 		}
 	}
=20
-	if (prune_worktrees_expire &&
-	    run_command_l_opt(RUN_GIT_CMD, "worktree", "prune", "--expire",
-			      prune_worktrees_expire, NULL))
-		die(FAILED_RUN, "worktree");
+	if (prune_worktrees_expire) {
+		strvec_push(&prune_worktrees, prune_worktrees_expire);
+		run_git_or_die(prune_worktrees.v);
+	}
=20
-	if (run_command_l_opt(RUN_GIT_CMD, "rerere", "gc", NULL))
-		die(FAILED_RUN, "rerere");
+	run_git_or_die(rerere.v);
=20
 	report_garbage =3D report_pack_garbage;
 	reprepare_packed_git(the_repository);
@@ -1894,21 +1913,26 @@ static int is_schtasks_available(void)
 #endif
 }
=20
-#define SCHTASKS_NAME_FMT "Git Maintenance (%s)"
+static char *schtasks_task_name(const char *frequency)
+{
+	struct strbuf label =3D STRBUF_INIT;
+	strbuf_addf(&label, "Git Maintenance (%s)", frequency);
+	return strbuf_detach(&label, NULL);
+}
=20
 static int schtasks_remove_task(enum schedule_priority schedule)
 {
 	const char *cmd =3D "schtasks";
-	struct strvec args =3D STRVEC_INIT;
+	struct child_process child =3D CHILD_PROCESS_INIT;
 	const char *frequency =3D get_frequency(schedule);
+	char *name =3D schtasks_task_name(frequency);
=20
 	get_schedule_cmd(&cmd, NULL);
-	strvec_split(&args, cmd);
-	strvec_pushl(&args, "/delete", "/tn", NULL);
-	strvec_pushf(&args, SCHTASKS_NAME_FMT, frequency);
-	strvec_pushl(&args, "/f", NULL);
+	strvec_split(&child.args, cmd);
+	strvec_pushl(&child.args, "/delete", "/tn", name, "/f", NULL);
+	free(name);
=20
-	return run_command_sv_opt(&args, 0);
+	return run_command(&child);
 }
=20
 static int schtasks_remove_tasks(void)
@@ -1926,6 +1950,7 @@ static int schtasks_schedule_task(const char *exec_pa=
th, enum schedule_priority
 	const char *xml;
 	struct tempfile *tfile;
 	const char *frequency =3D get_frequency(schedule);
+	char *name =3D schtasks_task_name(frequency);
 	struct strbuf tfilename =3D STRBUF_INIT;
=20
 	get_schedule_cmd(&cmd, NULL);
@@ -2018,10 +2043,8 @@ static int schtasks_schedule_task(const char *exec_p=
ath, enum schedule_priority
 	      "</Task>\n";
 	fprintf(tfile->fp, xml, exec_path, exec_path, frequency);
 	strvec_split(&child.args, cmd);
-	strvec_pushl(&child.args, "/create", "/tn", NULL);
-	strvec_pushf(&child.args, SCHTASKS_NAME_FMT, frequency);
-	strvec_pushl(&child.args, "/f", "/xml",
-		     get_tempfile_path(tfile), NULL);
+	strvec_pushl(&child.args, "/create", "/tn", name, "/f", "/xml",
+				  get_tempfile_path(tfile), NULL);
 	close_tempfile_gently(tfile);
=20
 	child.no_stdout =3D 1;
@@ -2032,6 +2055,7 @@ static int schtasks_schedule_task(const char *exec_pa=
th, enum schedule_priority
 	result =3D finish_command(&child);
=20
 	delete_tempfile(&tfile);
+	free(name);
 	return result;
 }
=20
diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index c0383fe9df9..012f52bd007 100644
--- a/builtin/merge-index.c
+++ b/builtin/merge-index.c
@@ -12,6 +12,7 @@ static int merge_entry(int pos, const char *path)
 	const char *arguments[] =3D { pgm, "", "", "", path, "", "", "", NULL };
 	char hexbuf[4][GIT_MAX_HEXSZ + 1];
 	char ownbuf[4][60];
+	struct child_process cmd =3D CHILD_PROCESS_INIT;
=20
 	if (pos >=3D active_nr)
 		die("git merge-index: %s not in the cache", path);
@@ -31,7 +32,8 @@ static int merge_entry(int pos, const char *path)
 	if (!found)
 		die("git merge-index: %s not in the cache", path);
=20
-	if (run_command_v_opt(arguments, 0)) {
+	strvec_pushv(&cmd.args, arguments);
+	if (run_command(&cmd)) {
 		if (one_shot)
 			err++;
 		else {
diff --git a/builtin/pull.c b/builtin/pull.c
index 2f36823c97e..b21edd767aa 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -515,73 +515,75 @@ static void parse_repo_refspecs(int argc, const char =
**argv, const char **repo,
  */
 static int run_fetch(const char *repo, const char **refspecs)
 {
-	struct strvec args =3D STRVEC_INIT;
+	struct child_process cmd =3D CHILD_PROCESS_INIT;
=20
-	strvec_pushl(&args, "fetch", "--update-head-ok", NULL);
+	strvec_pushl(&cmd.args, "fetch", "--update-head-ok", NULL);
=20
 	/* Shared options */
-	argv_push_verbosity(&args);
+	argv_push_verbosity(&cmd.args);
 	if (opt_progress)
-		strvec_push(&args, opt_progress);
+		strvec_push(&cmd.args, opt_progress);
=20
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
=20
 	if (repo) {
-		strvec_push(&args, repo);
-		strvec_pushv(&args, refspecs);
+		strvec_push(&cmd.args, repo);
+		strvec_pushv(&cmd.args, refspecs);
 	} else if (*refspecs)
 		BUG("refspecs without repo?");
-	return run_command_sv_opt(&args, RUN_GIT_CMD | RUN_CLOSE_OBJECT_STORE);
+	cmd.git_cmd =3D 1;
+	cmd.close_object_store =3D 1;
+	return run_command(&cmd);
 }
=20
 /**
@@ -650,49 +652,50 @@ static int update_submodules(void)
  */
 static int run_merge(void)
 {
-	struct strvec args =3D STRVEC_INIT;
+	struct child_process cmd =3D CHILD_PROCESS_INIT;
=20
-	strvec_pushl(&args, "merge", NULL);
+	strvec_pushl(&cmd.args, "merge", NULL);
=20
 	/* Shared options */
-	argv_push_verbosity(&args);
+	argv_push_verbosity(&cmd.args);
 	if (opt_progress)
-		strvec_push(&args, opt_progress);
+		strvec_push(&cmd.args, opt_progress);
=20
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
=20
-	strvec_push(&args, "FETCH_HEAD");
-	return run_command_sv_opt(&args, RUN_GIT_CMD);
+	strvec_push(&cmd.args, "FETCH_HEAD");
+	cmd.git_cmd =3D 1;
+	return run_command(&cmd);
 }
=20
 /**
@@ -873,40 +876,41 @@ static int get_rebase_newbase_and_upstream(struct obj=
ect_id *newbase,
 static int run_rebase(const struct object_id *newbase,
 		const struct object_id *upstream)
 {
-	struct strvec args =3D STRVEC_INIT;
+	struct child_process cmd =3D CHILD_PROCESS_INIT;
=20
-	strvec_push(&args, "rebase");
+	strvec_push(&cmd.args, "rebase");
=20
 	/* Shared options */
-	argv_push_verbosity(&args);
+	argv_push_verbosity(&cmd.args);
=20
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
=20
-	strvec_push(&args, "--onto");
-	strvec_push(&args, oid_to_hex(newbase));
+	strvec_push(&cmd.args, "--onto");
+	strvec_push(&cmd.args, oid_to_hex(newbase));
=20
-	strvec_push(&args, oid_to_hex(upstream));
+	strvec_push(&cmd.args, oid_to_hex(upstream));
=20
-	return run_command_sv_opt(&args, RUN_GIT_CMD);
+	cmd.git_cmd =3D 1;
+	return run_command(&cmd);
 }
=20
 static int get_can_ff(struct object_id *orig_head,
diff --git a/builtin/remote.c b/builtin/remote.c
index 5d3534db19c..0cde2e244a4 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -92,13 +92,15 @@ static int verbose;
=20
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
@@ -1508,34 +1510,35 @@ static int update(int argc, const char **argv, cons=
t char *prefix)
 			 N_("prune remotes after fetching")),
 		OPT_END()
 	};
-	struct strvec fetch_argv =3D STRVEC_INIT;
+	struct child_process cmd =3D CHILD_PROCESS_INIT;
 	int default_defined =3D 0;
=20
 	argc =3D parse_options(argc, argv, prefix, options,
 			     builtin_remote_update_usage,
 			     PARSE_OPT_KEEP_ARGV0);
=20
-	strvec_push(&fetch_argv, "fetch");
+	strvec_push(&cmd.args, "fetch");
=20
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
=20
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
=20
-	return run_command_sv_opt(&fetch_argv, RUN_GIT_CMD);
+	cmd.git_cmd =3D 1;
+	return run_command(&cmd);
 }
=20
 static int remove_all_fetch_refspecs(const char *key)
diff --git a/compat/mingw.c b/compat/mingw.c
index 4f5392c5796..d614f156df1 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -196,15 +196,20 @@ static int read_yes_no_answer(void)
 static int ask_yes_no_if_possible(const char *format, ...)
 {
 	char question[4096];
-	char *retry_hook;
+	const char *retry_hook;
 	va_list args;
=20
 	va_start(args, format);
 	vsnprintf(question, sizeof(question), format, args);
 	va_end(args);
=20
-	if ((retry_hook =3D mingw_getenv("GIT_ASK_YESNO")))
-		return !run_command_l_opt(0, retry_hook, question, NULL);
+	retry_hook =3D mingw_getenv("GIT_ASK_YESNO");
+	if (retry_hook) {
+		struct child_process cmd =3D CHILD_PROCESS_INIT;
+
+		strvec_pushl(&cmd.args, retry_hook, question, NULL);
+		return !run_command(&cmd);
+	}
=20
 	if (!isatty(_fileno(stdin)) || !isatty(_fileno(stderr)))
 		return 0;
diff --git a/diff.c b/diff.c
index 392530016fa..8451c230d9e 100644
--- a/diff.c
+++ b/diff.c
@@ -4278,8 +4278,8 @@ static void run_external_diff(const char *pgm,
 			      const char *xfrm_msg,
 			      struct diff_options *o)
 {
-	struct diff_queue_struct *q =3D &diff_queued_diff;
 	struct child_process cmd =3D CHILD_PROCESS_INIT;
+	struct diff_queue_struct *q =3D &diff_queued_diff;
=20
 	strvec_push(&cmd.args, pgm);
 	strvec_push(&cmd.args, name);
@@ -4295,7 +4295,8 @@ static void run_external_diff(const char *pgm,
 		}
 	}
=20
-	strvec_pushf(&cmd.env, "GIT_DIFF_PATH_COUNTER=3D%d", ++o->diff_path_count=
er);
+	strvec_pushf(&cmd.env, "GIT_DIFF_PATH_COUNTER=3D%d",
+		     ++o->diff_path_counter);
 	strvec_pushf(&cmd.env, "GIT_DIFF_PATH_TOTAL=3D%d", q->nr);
=20
 	diff_free_filespec_data(one);
diff --git a/fsmonitor-ipc.c b/fsmonitor-ipc.c
index 19d772f0f3a..96d8d37c06d 100644
--- a/fsmonitor-ipc.c
+++ b/fsmonitor-ipc.c
@@ -56,11 +56,11 @@ static int spawn_daemon(void)
 {
 	struct child_process cmd =3D CHILD_PROCESS_INIT;
=20
+	strvec_pushl(&cmd.args, "fsmonitor--daemon", "start", NULL);
+
 	cmd.git_cmd =3D 1;
 	cmd.no_stdin =3D 1;
 	cmd.trace2_child_class =3D "fsmonitor";
-	strvec_pushl(&cmd.args, "fsmonitor--daemon", "start", NULL);
-
 	return run_command(&cmd);
 }
=20
diff --git a/ll-merge.c b/ll-merge.c
index 740689b7bd6..b20491043e0 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -193,6 +193,7 @@ static enum ll_merge_result ll_ext_merge(const struct l=
l_merge_driver *fn,
 	struct strbuf cmd =3D STRBUF_INIT;
 	struct strbuf_expand_dict_entry dict[6];
 	struct strbuf path_sq =3D STRBUF_INIT;
+	struct child_process child =3D CHILD_PROCESS_INIT;
 	int status, fd, i;
 	struct stat st;
 	enum ll_merge_result ret;
@@ -218,7 +219,9 @@ static enum ll_merge_result ll_ext_merge(const struct l=
l_merge_driver *fn,
=20
 	strbuf_expand(&cmd, fn->cmdline, strbuf_expand_dict_cb, &dict);
=20
-	status =3D run_command_l_opt(RUN_USING_SHELL, cmd.buf, NULL);
+	strvec_push(&child.args, cmd.buf);
+	child.use_shell =3D 1;
+	status =3D run_command(&child);
 	fd =3D open(temp[1], O_RDONLY);
 	if (fd < 0)
 		goto bad;
diff --git a/merge.c b/merge.c
index 487debacecb..445b4f19aa8 100644
--- a/merge.c
+++ b/merge.c
@@ -19,21 +19,22 @@ int try_merge_command(struct repository *r,
 		      const char **xopts, struct commit_list *common,
 		      const char *head_arg, struct commit_list *remotes)
 {
-	struct strvec args =3D STRVEC_INIT;
+	struct child_process cmd =3D CHILD_PROCESS_INIT;
 	int i, ret;
 	struct commit_list *j;
=20
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
=20
-	ret =3D run_command_sv_opt(&args, RUN_GIT_CMD);
+	cmd.git_cmd =3D 1;
+	ret =3D run_command(&cmd);
=20
 	discard_index(r->index);
 	if (repo_read_index(r) < 0)
diff --git a/scalar.c b/scalar.c
index 3480bf73cbd..03f9e480dd6 100644
--- a/scalar.c
+++ b/scalar.c
@@ -69,17 +69,18 @@ static void setup_enlistment_directory(int argc, const =
char **argv,
=20
 static int run_git(const char *arg, ...)
 {
-	struct strvec argv =3D STRVEC_INIT;
+	struct child_process cmd =3D CHILD_PROCESS_INIT;
 	va_list args;
 	const char *p;
=20
 	va_start(args, arg);
-	strvec_push(&argv, arg);
+	strvec_push(&cmd.args, arg);
 	while ((p =3D va_arg(args, const char *)))
-		strvec_push(&argv, p);
+		strvec_push(&cmd.args, p);
 	va_end(args);
=20
-	return run_command_sv_opt(&argv, RUN_GIT_CMD);
+	cmd.git_cmd =3D 1;
+	return run_command(&cmd);
 }
=20
 struct scalar_config {
diff --git a/sequencer.c b/sequencer.c
index 7ee0e05512c..9b9d6a55828 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3183,14 +3183,15 @@ static int rollback_is_safe(void)
=20
 static int reset_merge(const struct object_id *oid)
 {
-	struct strvec argv =3D STRVEC_INIT;
+	struct child_process cmd =3D CHILD_PROCESS_INIT;
=20
-	strvec_pushl(&argv, "reset", "--merge", NULL);
+	strvec_pushl(&cmd.args, "reset", "--merge", NULL);
=20
 	if (!is_null_oid(oid))
-		strvec_push(&argv, oid_to_hex(oid));
+		strvec_push(&cmd.args, oid_to_hex(oid));
=20
-	return run_command_sv_opt(&argv, RUN_GIT_CMD);
+	cmd.git_cmd =3D 1;
+	return run_command(&cmd);
 }
=20
 static int rollback_single_pick(struct repository *r)
@@ -3554,10 +3555,13 @@ static int error_failed_squash(struct repository *r,
=20
 static int do_exec(struct repository *r, const char *command_line)
 {
+	struct child_process cmd =3D CHILD_PROCESS_INIT;
 	int dirty, status;
=20
 	fprintf(stderr, _("Executing: %s\n"), command_line);
-	status =3D run_command_l_opt(RUN_USING_SHELL, command_line, NULL);
+	strvec_push(&cmd.args, command_line);
+	cmd.use_shell =3D 1;
+	status =3D run_command(&cmd);
=20
 	/* force re-reading of the cache */
 	if (discard_index(r->index) < 0 || repo_read_index(r) < 0)
@@ -4861,13 +4865,13 @@ static int pick_commits(struct repository *r,
=20
 static int continue_single_pick(struct repository *r, struct replay_opts *=
opts)
 {
-	struct strvec argv =3D STRVEC_INIT;
+	struct child_process cmd =3D CHILD_PROCESS_INIT;
=20
 	if (!refs_ref_exists(get_main_ref_store(r), "CHERRY_PICK_HEAD") &&
 	    !refs_ref_exists(get_main_ref_store(r), "REVERT_HEAD"))
 		return error(_("no cherry-pick or revert in progress"));
=20
-	strvec_push(&argv, "commit");
+	strvec_push(&cmd.args, "commit");
=20
 	/*
 	 * continue_single_pick() handles the case of recovering from a
@@ -4880,9 +4884,10 @@ static int continue_single_pick(struct repository *r=
, struct replay_opts *opts)
 		 * Include --cleanup=3Dstrip as well because we don't want the
 		 * "# Conflicts:" messages.
 		 */
-		strvec_pushl(&argv, "--no-edit", "--cleanup=3Dstrip", NULL);
+		strvec_pushl(&cmd.args, "--no-edit", "--cleanup=3Dstrip", NULL);
=20
-	return run_command_sv_opt(&argv, RUN_GIT_CMD);
+	cmd.git_cmd =3D 1;
+	return run_command(&cmd);
 }
=20
 static int commit_staged_changes(struct repository *r,
diff --git a/t/helper/test-fake-ssh.c b/t/helper/test-fake-ssh.c
index 7967478a40a..42185f3fc05 100644
--- a/t/helper/test-fake-ssh.c
+++ b/t/helper/test-fake-ssh.c
@@ -8,6 +8,7 @@ int cmd_main(int argc, const char **argv)
 	struct strbuf buf =3D STRBUF_INIT;
 	FILE *f;
 	int i;
+	struct child_process cmd =3D CHILD_PROCESS_INIT;
=20
 	/* First, print all parameters into $TRASH_DIRECTORY/ssh-output */
 	if (!trash_directory)
@@ -24,5 +25,7 @@ int cmd_main(int argc, const char **argv)
 	/* Now, evaluate the *last* parameter */
 	if (argc < 2)
 		return 0;
-	return run_command_l_opt(RUN_USING_SHELL, argv[argc - 1], NULL);
+	strvec_push(&cmd.args, argv[argc - 1]);
+	cmd.use_shell =3D 1;
+	return run_command(&cmd);
 }
diff --git a/t/helper/test-trace2.c b/t/helper/test-trace2.c
index a714130ece7..94fd8ccf513 100644
--- a/t/helper/test-trace2.c
+++ b/t/helper/test-trace2.c
@@ -132,6 +132,7 @@ static int ut_003error(int argc, const char **argv)
  */
 static int ut_004child(int argc, const char **argv)
 {
+	struct child_process cmd =3D CHILD_PROCESS_INIT;
 	int result;
=20
 	/*
@@ -141,7 +142,8 @@ static int ut_004child(int argc, const char **argv)
 	if (!argc)
 		return 0;
=20
-	result =3D run_command_v_opt(argv, 0);
+	strvec_pushv(&cmd.args, argv);
+	result =3D run_command(&cmd);
 	exit(result);
 }
=20
diff --git a/tmp-objdir.h b/tmp-objdir.h
index c96aa77396d..615b1885733 100644
--- a/tmp-objdir.h
+++ b/tmp-objdir.h
@@ -10,11 +10,9 @@
  *
  * Example:
  *
- *	struct child_process cmd =3D CHILD_PROCESS_INIT;
- *	...
  *	struct tmp_objdir *t =3D tmp_objdir_create("incoming");
- *      strvec_pushl(&cmd.env, tmp_objdir_env(t));
- *	if (!run_command(&cmd) && !tmp_objdir_migrate(t))
+ *	strvec_pushv(&cmd.env, tmp_objdir_env(t));
+ *	if (!run_command(&cmd)) && !tmp_objdir_migrate(t))
  *		printf("success!\n");
  *	else
  *		die("failed...tmp_objdir will clean up for us");
