Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4BE1C433EF
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 13:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B851610CB
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 13:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbhJMNF5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 09:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbhJMNFz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 09:05:55 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E96DC061570
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 06:03:52 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id y12so10062106eda.4
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 06:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=iykVoIe+myR1hjnDIdcGHESC5vTt6QoTzJ47kcuXxVs=;
        b=CFzhqccVOjRK1OQVBlgCO2vyCB8RIWpJLgJDHC2+SCoWvv5LilpbeBj6Q5amoKPKEu
         PUgNAopKZlXNphBhUtBK+ep0P+T0ajZGuuHL3m92McCi++5THw2bbJQsks2eC09E88fT
         U9vMIXe2gf+3AdVAcfQ/52lxWMpJrZ01p8MY/7rn5LqWBHOEAd5q+vy6lPiO5d2f3Ff9
         NthvrUlj8HeSU0MYY0EhO+dZCQxh5RUU0ZdvFxQaiD1KGMmrSegjhMTUXIOp9BrDZBma
         G2h02ogGjbWLSLxYeQBvEGK2cEDxobroUrO50yK+jdpHhufZMQsWcKGJZa4kXhjYb2Gm
         /rHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=iykVoIe+myR1hjnDIdcGHESC5vTt6QoTzJ47kcuXxVs=;
        b=m9Mg8YvpOZBgqU0yBq72R/mcl4LXjE0pLRhY8gqtyIH4RJ9WBbvyOLNaJGDrlrsUEs
         6YJZ0/VGbB8xh+7Vtc6p8fiKQRN8J+CizJsCEz4MSF9Y6k6dZpvN1wEPC4iNZOvd+wCu
         DRzZxZFeryM0fI6y1giHMBvSwpGWtZJZv2hetS4RDCNNW+GDpJfCUTZvQ0raF507jfJM
         P2OHzBZ1bpGcSjeoEdaQCbO4sUuRTTQVaEGvNUetNM9QbUOAnaSNmJrRw1nqJb4pXiA8
         nVxJoBYmeqf42WM2fPVMwt1p6YG7ZXyAxXMeNioqQWI3Tm07EIfw9qh0q4hPdhpvE/zm
         AObA==
X-Gm-Message-State: AOAM532lJk8vfwwPfslPSHjdvoCAHf+RaCINR9MTR1tcT7vRc7tE3TUM
        WfO+TlYigNepobVHz+Td9AfaPm5rWfxQtw==
X-Google-Smtp-Source: ABdhPJyfftO081Bk7qRhiH8xMHHvBgJrv4OwflcdzSg95ulUzS2zC9cY+WoPhUXPpgqoHtrZaQK8zg==
X-Received: by 2002:a17:906:b14d:: with SMTP id bt13mr39902894ejb.39.1634130230655;
        Wed, 13 Oct 2021 06:03:50 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id w6sm3730537edt.12.2021.10.13.06.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 06:03:50 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH 01/13] hook: add 'run' subcommand
Date:   Wed, 13 Oct 2021 14:58:48 +0200
References: <cover-00.13-00000000000-20211012T131934Z-avarab@gmail.com>
 <patch-01.13-a39c0748d3f-20211012T131934Z-avarab@gmail.com>
 <d5e2ac19-30ad-ccbd-c90c-41ba6b597cc0@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <d5e2ac19-30ad-ccbd-c90c-41ba6b597cc0@web.de>
Message-ID: <87k0ihhya2.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 12 2021, Ren=C3=A9 Scharfe wrote:

> Am 12.10.21 um 15:30 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>> From: Emily Shaffer <emilyshaffer@google.com>
>>
>> In order to enable hooks to be run as an external process, by a
>> standalone Git command, or by tools which wrap Git, provide an external
>> means to run all configured hook commands for a given hook event.
>>
>> Most of our hooks require more complex functionality than this, but
>> let's start with the bare minimum required to support our simplest
>> hooks.
>>
>> In terms of implementation the usage_with_options() and "goto usage"
>> pattern here mirrors that of
>> builtin/{commit-graph,multi-pack-index}.c.
>>
>> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  .gitignore                 |   1 +
>>  Documentation/git-hook.txt |  38 +++++++++++
>>  Documentation/githooks.txt |   4 ++
>>  Makefile                   |   1 +
>>  builtin.h                  |   1 +
>>  builtin/hook.c             |  90 ++++++++++++++++++++++++++
>>  command-list.txt           |   1 +
>>  git.c                      |   1 +
>>  hook.c                     | 101 +++++++++++++++++++++++++++++
>>  hook.h                     |  39 +++++++++++
>>  t/t1800-hook.sh            | 129 +++++++++++++++++++++++++++++++++++++
>>  11 files changed, 406 insertions(+)
>>  create mode 100644 Documentation/git-hook.txt
>>  create mode 100644 builtin/hook.c
>>  create mode 100755 t/t1800-hook.sh
>>
>> diff --git a/.gitignore b/.gitignore
>> index 6be9de41ae8..66189ca3cdc 100644
>> --- a/.gitignore
>> +++ b/.gitignore
>> @@ -77,6 +77,7 @@
>>  /git-grep
>>  /git-hash-object
>>  /git-help
>> +/git-hook
>>  /git-http-backend
>>  /git-http-fetch
>>  /git-http-push
>> diff --git a/Documentation/git-hook.txt b/Documentation/git-hook.txt
>> new file mode 100644
>> index 00000000000..660d6a992a0
>> --- /dev/null
>> +++ b/Documentation/git-hook.txt
>> @@ -0,0 +1,38 @@
>> +git-hook(1)
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +NAME
>> +----
>> +git-hook - run git hooks
>> +
>> +SYNOPSIS
>> +--------
>> +[verse]
>> +'git hook' run <hook-name> [-- <hook-args>]
>> +
>> +DESCRIPTION
>> +-----------
>> +
>> +This command is an interface to git hooks (see linkgit:githooks[5]).
>> +Currently it only provides a convenience wrapper for running hooks for
>> +use by git itself. In the future it might gain other functionality.
>
> As a man page reader I'm only interested in the present features of the
> command up here.  Breaking changes could be mentioned in a HISTORY
> section, and missing critical features in a BUGS section at the bottom.
>
> I assume the last sentence applies to almost all programs, and could be
> safely removed.

Willdo.

>> +
>> +SUBCOMMANDS
>> +-----------
>> +
>> +run::
>> +	Run the `<hook-name>` hook. See linkgit:githooks[5] for
>> +	the hook names we support.
>> ++
>> +Any positional arguments to the hook should be passed after an
>> +optional `--` (or `--end-of-options`, see linkgit:gitcli[7]). The
>
> Dash dash (or EoO) is optional.

This just needs to be rephrased, the -- is mandatory, i.e. it's either:

    git hook run [args] hook-name

Or:

    git hook run [args] hook-name -- [hook-args]

But not:

    git hook run [args] hook-name [hook-args]

>> +arguments (if any) differ by hook name, see linkgit:githooks[5] for
>> +what those are.
>> +
>> +SEE ALSO
>> +--------
>> +linkgit:githooks[5]
>> +
>> +GIT
>> +---
>> +Part of the linkgit:git[1] suite
>> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
>> index b51959ff941..a16e62bc8c8 100644
>> --- a/Documentation/githooks.txt
>> +++ b/Documentation/githooks.txt
>> @@ -698,6 +698,10 @@ and "0" meaning they were not.
>>  Only one parameter should be set to "1" when the hook runs.  The hook
>>  running passing "1", "1" should not be possible.
>>
>> +SEE ALSO
>> +--------
>> +linkgit:git-hook[1]
>> +
>>  GIT
>>  ---
>>  Part of the linkgit:git[1] suite
>> diff --git a/Makefile b/Makefile
>> index 877492386ee..12b481fdabe 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -1108,6 +1108,7 @@ BUILTIN_OBJS +=3D builtin/get-tar-commit-id.o
>>  BUILTIN_OBJS +=3D builtin/grep.o
>>  BUILTIN_OBJS +=3D builtin/hash-object.o
>>  BUILTIN_OBJS +=3D builtin/help.o
>> +BUILTIN_OBJS +=3D builtin/hook.o
>>  BUILTIN_OBJS +=3D builtin/index-pack.o
>>  BUILTIN_OBJS +=3D builtin/init-db.o
>>  BUILTIN_OBJS +=3D builtin/interpret-trailers.o
>> diff --git a/builtin.h b/builtin.h
>> index 8a58743ed63..83379f3832c 100644
>> --- a/builtin.h
>> +++ b/builtin.h
>> @@ -164,6 +164,7 @@ int cmd_get_tar_commit_id(int argc, const char **arg=
v, const char *prefix);
>>  int cmd_grep(int argc, const char **argv, const char *prefix);
>>  int cmd_hash_object(int argc, const char **argv, const char *prefix);
>>  int cmd_help(int argc, const char **argv, const char *prefix);
>> +int cmd_hook(int argc, const char **argv, const char *prefix);
>>  int cmd_index_pack(int argc, const char **argv, const char *prefix);
>>  int cmd_init_db(int argc, const char **argv, const char *prefix);
>>  int cmd_interpret_trailers(int argc, const char **argv, const char *pre=
fix);
>> diff --git a/builtin/hook.c b/builtin/hook.c
>> new file mode 100644
>> index 00000000000..012a2973b38
>> --- /dev/null
>> +++ b/builtin/hook.c
>> @@ -0,0 +1,90 @@
>> +#include "cache.h"
>> +#include "builtin.h"
>> +#include "config.h"
>> +#include "hook.h"
>> +#include "parse-options.h"
>> +#include "strbuf.h"
>> +#include "strvec.h"
>> +
>> +#define BUILTIN_HOOK_RUN_USAGE \
>> +	N_("git hook run <hook-name> [-- <hook-args>]")
>> +
>> +static const char * const builtin_hook_usage[] =3D {
>> +	BUILTIN_HOOK_RUN_USAGE,
>> +	NULL
>> +};
>> +
>> +static const char * const builtin_hook_run_usage[] =3D {
>> +	BUILTIN_HOOK_RUN_USAGE,
>> +	NULL
>> +};
>> +
>> +static int run(int argc, const char **argv, const char *prefix)
>> +{
>> +	int i;
>> +	struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
>> +	const char *hook_name;
>> +	const char *hook_path;
>> +	struct option run_options[] =3D {
>> +		OPT_END(),
>> +	};
>> +	int ret;
>> +
>> +	argc =3D parse_options(argc, argv, prefix, run_options,
>> +			     builtin_hook_run_usage,
>> +			     PARSE_OPT_KEEP_DASHDASH);
>> +
>> +	if (!argc)
>> +		goto usage;
>> +
>> +	/*
>> +	 * Having a -- for "run" when providing <hook-args> is
>> +	 * mandatory.
>> +	 */
>> +	if (argc > 1 && strcmp(argv[1], "--") &&
>> +	    strcmp(argv[1], "--end-of-options"))
>> +		goto usage;
> Dash dash (or EoO) is mandatory unless parse_options() left no
> arguments, contrary to what the documentation says above.  Update
> the doc above?

*nod*

>> +
>> +	/* Add our arguments, start after -- */
>> +	for (i =3D 2 ; i < argc; i++)
>> +		strvec_push(&opt.args, argv[i]);
>> +
>> +	/* Need to take into account core.hooksPath */
>> +	git_config(git_default_config, NULL);
>> +
>> +	/*
>> +	 * We are not using a plain run_hooks() because we'd like to
>> +	 * detect missing hooks. Let's find it ourselves and call
>> +	 * run_hooks() instead.
>
> So run_hooks(), which is introduced later in this patch, can find a
> hook as well, but would do so silently?

Will clarify, I think Emily and I went back and forth on this comment a
bit, and at some point I removed it entirely I think...

>> +	 */
>> +	hook_name =3D argv[0];
>> +	hook_path =3D find_hook(hook_name);
>
> This is the only find_hook() call introduced by this patch.
> Does run_hooks() really posses an unused hook-finding capability?

Will address...

>> +	if (!hook_path) {
>> +		error("cannot find a hook named %s", hook_name);
>> +		return 1;
>> +	}
>> +
>> +	ret =3D run_hooks(hook_name, hook_path, &opt);
>> +	run_hooks_opt_clear(&opt);
>> +	return ret;
>> +usage:
>> +	usage_with_options(builtin_hook_run_usage, run_options);
>> +}
>> +
>> +int cmd_hook(int argc, const char **argv, const char *prefix)
>> +{
>> +	struct option builtin_hook_options[] =3D {
>> +		OPT_END(),
>> +	};
>> +
>> +	argc =3D parse_options(argc, argv, NULL, builtin_hook_options,
>> +			     builtin_hook_usage, PARSE_OPT_STOP_AT_NON_OPTION);
>> +	if (!argc)
>> +		goto usage;
>> +
>> +	if (!strcmp(argv[0], "run"))
>> +		return run(argc, argv, prefix);
>> +
>> +usage:
>> +	usage_with_options(builtin_hook_usage, builtin_hook_options);
>> +}
>> diff --git a/command-list.txt b/command-list.txt
>> index a289f09ed6f..9ccd8e5aebe 100644
>> --- a/command-list.txt
>> +++ b/command-list.txt
>> @@ -103,6 +103,7 @@ git-grep                                mainporcelai=
n           info
>>  git-gui                                 mainporcelain
>>  git-hash-object                         plumbingmanipulators
>>  git-help                                ancillaryinterrogators         =
 complete
>> +git-hook                                mainporcelain
>>  git-http-backend                        synchingrepositories
>>  git-http-fetch                          synchelpers
>>  git-http-push                           synchelpers
>> diff --git a/git.c b/git.c
>> index 60c2784be45..e5891e02021 100644
>> --- a/git.c
>> +++ b/git.c
>> @@ -538,6 +538,7 @@ static struct cmd_struct commands[] =3D {
>>  	{ "grep", cmd_grep, RUN_SETUP_GENTLY },
>>  	{ "hash-object", cmd_hash_object },
>>  	{ "help", cmd_help },
>> +	{ "hook", cmd_hook, RUN_SETUP },
>>  	{ "index-pack", cmd_index_pack, RUN_SETUP_GENTLY | NO_PARSEOPT },
>>  	{ "init", cmd_init_db },
>>  	{ "init-db", cmd_init_db },
>> diff --git a/hook.c b/hook.c
>> index 55e1145a4b7..240270db64e 100644
>> --- a/hook.c
>> +++ b/hook.c
>> @@ -1,6 +1,7 @@
>>  #include "cache.h"
>>  #include "hook.h"
>>  #include "run-command.h"
>> +#include "config.h"
>>
>>  const char *find_hook(const char *name)
>>  {
>> @@ -40,3 +41,103 @@ int hook_exists(const char *name)
>>  {
>>  	return !!find_hook(name);
>>  }
>> +
>> +void run_hooks_opt_clear(struct run_hooks_opt *o)
>> +{
>> +	strvec_clear(&o->env);
>> +	strvec_clear(&o->args);
>> +}
>> +
>> +static int pick_next_hook(struct child_process *cp,
>> +			  struct strbuf *out,
>> +			  void *pp_cb,
>> +			  void **pp_task_cb)
>> +{
>> +	struct hook_cb_data *hook_cb =3D pp_cb;
>> +	struct hook *run_me =3D hook_cb->run_me;
>> +
>> +	if (!run_me)
>> +		return 0;
>> +
>> +	cp->no_stdin =3D 1;
>> +	cp->env =3D hook_cb->options->env.v;
>> +	cp->stdout_to_stderr =3D 1;
>> +	cp->trace2_hook_name =3D hook_cb->hook_name;
>> +
>> +	/* add command */
>> +	strvec_push(&cp->args, run_me->hook_path);
>> +
>> +	/*
>> +	 * add passed-in argv, without expanding - let the user get back
>> +	 * exactly what they put in
>
> What kind of expanding is it doing without?  I was expecting the
> arguments to passed on verbatim before reading this comment, so it
> leaves me wondering what I'm missing.

I think that's one of Emily's comments, will find out...

>> +	 */
>> +	strvec_pushv(&cp->args, hook_cb->options->args.v);
>> +
>> +	/* Provide context for errors if necessary */
>> +	*pp_task_cb =3D run_me;
>> +
>> +	/*
>> +	 * This pick_next_hook() will be called again, we're only
>> +	 * running one hook, so indicate that no more work will be
>> +	 * done.
>> +	 */
>> +	hook_cb->run_me =3D NULL;
>
> A single hook is picked.

Right...

>> +
>> +	return 1;
>> +}
>> +
>> +static int notify_start_failure(struct strbuf *out,
>> +				void *pp_cb,
>> +				void *pp_task_cp)
>> +{
>> +	struct hook_cb_data *hook_cb =3D pp_cb;
>> +	struct hook *attempted =3D pp_task_cp;
>> +
>> +	hook_cb->rc |=3D 1;
>> +
>> +	strbuf_addf(out, _("Couldn't start hook '%s'\n"),
>> +		    attempted->hook_path);
>> +
>> +	return 1;
>> +}
>> +
>> +static int notify_hook_finished(int result,
>> +				struct strbuf *out,
>> +				void *pp_cb,
>> +				void *pp_task_cb)
>> +{
>> +	struct hook_cb_data *hook_cb =3D pp_cb;
>> +
>> +	hook_cb->rc |=3D result;
>> +
>> +	return 0;
>> +}
>> +
>> +int run_hooks(const char *hook_name, const char *hook_path,
>> +	      struct run_hooks_opt *options)
>> +{
>> +	struct hook my_hook =3D {
>> +		.hook_path =3D hook_path,
>> +	};
>> +	struct hook_cb_data cb_data =3D {
>> +		.rc =3D 0,
>> +		.hook_name =3D hook_name,
>> +		.options =3D options,
>> +	};
>> +	int jobs =3D 1;
>> +
>> +	if (!options)
>> +		BUG("a struct run_hooks_opt must be provided to run_hooks");
>> +
>> +	cb_data.run_me =3D &my_hook;
>> +
>> +	run_processes_parallel_tr2(jobs,
>> +				   pick_next_hook,
>> +				   notify_start_failure,
>> +				   notify_hook_finished,
>> +				   &cb_data,
>> +				   "hook",
>> +				   hook_name);
>
> A single process (jobs =3D=3D 1) is used to run a single hook.  Why use
> run_processes_parallel_tr2() for that instead of run_command()?  The
> latter would require a lot less code to achieve the same outcome, no?

...also for this...

>> +
>> +	return cb_data.rc;
>> +}
>> diff --git a/hook.h b/hook.h
>> index 6aa36fc7ff9..111c5cf9296 100644
>> --- a/hook.h
>> +++ b/hook.h
>> @@ -1,5 +1,33 @@
>>  #ifndef HOOK_H
>>  #define HOOK_H
>> +#include "strvec.h"
>> +
>> +struct hook {
>> +	/* The path to the hook */
>> +	const char *hook_path;
>> +};
>
> None of the patches in this series extend this structure.  Why not
> use a bare string directly?

...the reason for all of this is that it's a multi-part series where
we're eventually headed towards multi-hook parallel support.

An earlier version of this started with run_command() et al, then later
migrated to the parallel API, since the parallel API can do a single run
with a jobs=3D1 I found that easier than the curn of switching back and
forth.

Ditto some other scaffolding like this one-member struct, which will be
expanded later on.

Will address this by clarifying the plans in commit messages.

>> +
>> +struct run_hooks_opt
>> +{
>> +	/* Environment vars to be set for each hook */
>> +	struct strvec env;
>> +
>> +	/* Args to be passed to each hook */
>> +	struct strvec args;
>> +};
>> +
>> +#define RUN_HOOKS_OPT_INIT { \
>> +	.env =3D STRVEC_INIT, \
>> +	.args =3D STRVEC_INIT, \
>> +}
>> +
>> +struct hook_cb_data {
>> +	/* rc reflects the cumulative failure state */
>> +	int rc;
>> +	const char *hook_name;
>> +	struct hook *run_me;
>> +	struct run_hooks_opt *options;
>> +};
>>
>>  /*
>>   * Returns the path to the hook file, or NULL if the hook is missing
>> @@ -13,4 +41,15 @@ const char *find_hook(const char *name);
>>   */
>>  int hook_exists(const char *hookname);
>>
>> +/**
>> + * Clear data from an initialized "struct run_hooks-opt".
>                                                       ^
> y/-/_/

*nod*

>> + */
>> +void run_hooks_opt_clear(struct run_hooks_opt *o);
>> +
>> +/**
>> + * Takes an already resolved hook found via find_hook() and runs
>> + * it. Does not call run_hooks_opt_clear() for you.
>> + */
>> +int run_hooks(const char *hookname, const char *hook_path,
>> +	      struct run_hooks_opt *options);
>
> If it runs one hook, why is it called run_hooks(), plural?

Ditto above, will clarify, eventually it will run N, and then having the
churn of changing all callers/re-indenting argument lists...


Thanks a lot for your time & the review. Will wait on a re-roll for more
comments...
