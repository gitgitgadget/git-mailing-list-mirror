Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B3AC433EF
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 16:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380499AbiDTQZK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 12:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355738AbiDTQZJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 12:25:09 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96C53B546
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 09:22:22 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id y32so3905859lfa.6
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 09:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9sNazECU7AZ9vXET0xfpnrZd0eiGCgITHTZ0cRW1zDw=;
        b=i8HQ+2aC657JN2GB3DwWyECbchoy/0J9u9zGqDR/tJldQLCW55CeHvkrCGhbj0ayO+
         aINT1Rew+f6Sm9tI3TACepO1XpLsLI2o4NeWko44xXKEKV9RF932e/3TeqbcqlnHlU5s
         TUpbOokvpIiZezw3P77XbO41PN5NxpLCQxPyHDV/CwAIOCcwaW/DETDVg3FivqgoFU4t
         yCziRO84TxmWJ6E5kYOB7R5yG/n4KQa0k0oA4Tm53tn69DiLOXhhR6PWnDtNZsvFn74c
         zavS5p793H1/ic3gusS7Edm9ztmcjGMXN+11P2LQY8sUVTl0RvKTmJh0nctPGTVilMVx
         mUJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9sNazECU7AZ9vXET0xfpnrZd0eiGCgITHTZ0cRW1zDw=;
        b=kX/U1j1PAdvtwUiVCILgXJKyyBEB3cKpfNEpW4RMLJP5zjrQlH7xQCtQzEnBWxOWVH
         1CBlVVZjQakrr1bKqxVbxmvT5FknAsmAz5xA95r8cdNLvI5rM7iE+Qk0Qq/rid2AG7HH
         0vKAfJwt21CN7RqS1bQ98dcWERYY0RzGkjT4+YHJkAATn97z6exeww9LMsOj/8IeO46v
         /0VQlMBXnhfJ7s4qZtCstiM1mFlvtasrJsgiC3tKFpnehonwrpJ7DIGmfudyCM5KjAND
         L6aqehNjYii4KdiFYvj+PEaFlu39zhjZ3FW+V0OJQ0/wlH5nDLeS1qEThfHkzRbP7xF/
         VI8g==
X-Gm-Message-State: AOAM533fx4peHHY7q5m2KYcM4RxOHVm2MUKrG0PHLnJo2tdqZgNcp4aq
        jb7J/agEibtWb23tusvpRw78oyKr7LUR35I5ae9LDQ==
X-Google-Smtp-Source: ABdhPJw+TrGf71Gw5E8+tnFIe1emhLWrSPOGtc6WKnjLejzD0hBf8OHCS+6fOheQU96dp50ADssoA51oA4UH7IqWzY4=
X-Received: by 2002:ac2:48b4:0:b0:46f:a773:fefa with SMTP id
 u20-20020ac248b4000000b0046fa773fefamr15259771lfg.385.1650471740532; Wed, 20
 Apr 2022 09:22:20 -0700 (PDT)
MIME-Version: 1.0
References: <CA+dzEBn108QoMA28f0nC8K21XT+Afua0V2Qv8XkR8rAeqUCCZw@mail.gmail.com>
 <Yl9Hn0C0TwalASC0@google.com> <6aabbcd6-f6c2-fe97-eb73-593bcf2e9e75@gmail.com>
 <220420.86wnfk6isy.gmgdl@evledraar.gmail.com>
In-Reply-To: <220420.86wnfk6isy.gmgdl@evledraar.gmail.com>
From:   Emily Shaffer <emilyshaffer@google.com>
Date:   Wed, 20 Apr 2022 09:22:09 -0700
Message-ID: <CAJoAoZ=ysz6GDjUVCzUC-4OEwkyfrUzDyAws1xPbKXeLufUa0w@mail.gmail.com>
Subject: Re: git 2.36.0 regression: pre-commit hooks no longer have
 stdout/stderr as tty
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Anthony Sottile <asottile@umich.edu>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 20, 2022 at 5:28 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> >> It *is* true that run-command.c:pp_start_one() sets child_process:err=
=3D-1
> >> for the child and run-command.c:run_hook_ve() didn't do that; that -1
> >> means that start_command() will create a new fd for the child's stderr=
.
> >> Since run_hook_ve() didn't care about the child's stderr before, I
> >> wonder if that is why? Could it be that now that we're processing the
> >> child's stderr, the child no longer thinks stderr is in tty, because t=
he
> >> parent is consuming its output?
> >
> > Exactly, stderr is redirected to a pipe so that we can buffer the
> > output from each process and then write it to the real stdout when the
> > process has finished to avoid the output from different processes
> > getting mixed together. Ideally in this case we'd see that stdout is a
> > tty and create a pty rather than a pipe when buffering the output from
> > the process.
>
> All: I have a fix for this, currently CI-ing, testing etc. Basically it
> just adds an option to run_process_parallel() to stop doing the
> stdout/stderr interception.
>
> It means that for the current jobs=3D1 we'll behave as before.
>
> For jobs >1 in the future we'll need to decide what we want to do,
> i.e. you can have TTY, or guaranteed non-interleaved output, but not
> both.
>
> I'd think for hooks no interception makes sense, but in any case we can
> defer that until sometime later...

I'm curious what your reasoning is there. I rely on hooks which give
me user-readable output quite frequently, so the interleaving is
important to keep them from being useless if I trigger more than one
hook (e.g. I have separate hooks to check for secret keys and for
debug strings).

Would it make sense to start by setting it based on the number of
hooks available?

Left a quick thought below, but please don't consider it as a full
review - I haven't got time to look much more yet.

>
> Preview of the fix below, this is on top of an earlier change to add the
> "struct run_process_parallel_opts" to pass such options along:
>
> diff --git a/hook.c b/hook.c
> index eadb2d58a7b..1f20e5db447 100644
> --- a/hook.c
> +++ b/hook.c
> @@ -126,6 +126,7 @@ int run_hooks_opt(const char *hook_name, struct run_h=
ooks_opt *options)
>         struct run_process_parallel_opts run_opts =3D {
>                 .tr2_category =3D "hook",
>                 .tr2_label =3D hook_name,
> +               .no_buffering =3D 1,
>         };
>
>         if (!options)
> diff --git a/run-command.c b/run-command.c
> index 2383375ee07..0f9d84433ad 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -1604,7 +1604,7 @@ static void pp_cleanup(struct parallel_processes *p=
p)
>   * <0 no new job was started, user wishes to shutdown early. Use negativ=
e code
>   *    to signal the children.
>   */
> -static int pp_start_one(struct parallel_processes *pp)
> +static int pp_start_one(struct parallel_processes *pp, const int no_buff=
ering)
>  {
>         int i, code;
>
> @@ -1623,9 +1623,12 @@ static int pp_start_one(struct parallel_processes =
*pp)
>                 strbuf_reset(&pp->children[i].err);
>                 return 1;
>         }
> -       pp->children[i].process.err =3D -1;
> -       pp->children[i].process.stdout_to_stderr =3D 1;
> -       pp->children[i].process.no_stdin =3D 1;
> +
> +       if (!no_buffering) {
> +               pp->children[i].process.err =3D -1;
> +               pp->children[i].process.stdout_to_stderr =3D 1;
> +               pp->children[i].process.no_stdin =3D 1;
> +       }

Is it not possible to let run_processes_parallel() callers set these
flags manually (as they are providing a child_process in the "get next
task" callback), and then to decide whether to buffer the output based
on the fd status instead? I'd prefer that rather than an all-or-none
option that may not apply to every process, I think... But I could be
wrong :)

>
>         if (start_command(&pp->children[i].process)) {
>                 code =3D pp->start_failure(&pp->children[i].err,
> @@ -1681,12 +1684,17 @@ static void pp_output(struct parallel_processes *=
pp)
>         }
>  }
>
> -static int pp_collect_finished(struct parallel_processes *pp)
> +static int pp_collect_finished(struct parallel_processes *pp,
> +                              const int no_buffering)
>  {
>         int i, code;
>         int n =3D pp->max_processes;
>         int result =3D 0;
>
> +       if (no_buffering)
> +               for (i =3D 0; i < pp->max_processes; i++)
> +                       pp->children[i].state =3D GIT_CP_WAIT_CLEANUP;
> +
>         while (pp->nr_processes > 0) {
>                 for (i =3D 0; i < pp->max_processes; i++)
>                         if (pp->children[i].state =3D=3D GIT_CP_WAIT_CLEA=
NUP)
> @@ -1741,7 +1749,7 @@ static int pp_collect_finished(struct parallel_proc=
esses *pp)
>  static int run_processes_parallel_1(int n, get_next_task_fn get_next_tas=
k,
>                                     start_failure_fn start_failure,
>                                     task_finished_fn task_finished,
> -                                   void *pp_cb)
> +                                   void *pp_cb, const int no_buffering)
>  {
>         int i, code;
>         int output_timeout =3D 100;
> @@ -1754,7 +1762,7 @@ static int run_processes_parallel_1(int n, get_next=
_task_fn get_next_task,
>                     i < spawn_cap && !pp.shutdown &&
>                     pp.nr_processes < pp.max_processes;
>                     i++) {
> -                       code =3D pp_start_one(&pp);
> +                       code =3D pp_start_one(&pp, no_buffering);
>                         if (!code)
>                                 continue;
>                         if (code < 0) {
> @@ -1765,9 +1773,11 @@ static int run_processes_parallel_1(int n, get_nex=
t_task_fn get_next_task,
>                 }
>                 if (!pp.nr_processes)
>                         break;
> -               pp_buffer_stderr(&pp, output_timeout);
> -               pp_output(&pp);
> -               code =3D pp_collect_finished(&pp);
> +               if (!no_buffering) {
> +                       pp_buffer_stderr(&pp, output_timeout);
> +                       pp_output(&pp);
> +               }
> +               code =3D pp_collect_finished(&pp, no_buffering);
>                 if (code) {
>                         pp.shutdown =3D 1;
>                         if (code < 0)
> @@ -1783,7 +1793,8 @@ static int run_processes_parallel_tr2(int n, get_ne=
xt_task_fn get_next_task,
>                                       start_failure_fn start_failure,
>                                       task_finished_fn task_finished,
>                                       void *pp_cb, const char *tr2_catego=
ry,
> -                                     const char *tr2_label)
> +                                     const char *tr2_label,
> +                                     const int no_buffering)
>  {
>         int result;
>
> @@ -1791,7 +1802,7 @@ static int run_processes_parallel_tr2(int n, get_ne=
xt_task_fn get_next_task,
>                                    ((n < 1) ? online_cpus() : n));
>
>         result =3D run_processes_parallel_1(n, get_next_task, start_failu=
re,
> -                                         task_finished, pp_cb);
> +                                         task_finished, pp_cb, no_buffer=
ing);
>
>         trace2_region_leave(tr2_category, tr2_label, NULL);
>
> @@ -1803,6 +1814,8 @@ int run_processes_parallel(int n, get_next_task_fn =
get_next_task,
>                            task_finished_fn task_finished, void *pp_cb,
>                            struct run_process_parallel_opts *opts)
>  {
> +       const int no_buffering =3D opts && opts->no_buffering;
> +
>         if (!opts)
>                 goto no_opts;
>
> @@ -1811,12 +1824,13 @@ int run_processes_parallel(int n, get_next_task_f=
n get_next_task,
>                 return run_processes_parallel_tr2(n, get_next_task,
>                                                   start_failure, task_fin=
ished,
>                                                   pp_cb, opts->tr2_catego=
ry,
> -                                                 opts->tr2_label);
> +                                                 opts->tr2_label,
> +                                                 no_buffering);
>         }
>
>  no_opts:
>         return run_processes_parallel_1(n, get_next_task, start_failure,
> -                                       task_finished, pp_cb);
> +                                       task_finished, pp_cb, no_bufferin=
g);
>  }
>
>
> diff --git a/run-command.h b/run-command.h
> index 9ec57a25de4..062eff81e17 100644
> --- a/run-command.h
> +++ b/run-command.h
> @@ -463,11 +463,17 @@ typedef int (*task_finished_fn)(int result,
>   *
>   * tr2_category & tr2_label: sets the trace2 category and label for
>   * logging. These must either be unset, or both of them must be set.
> + *
> + * no_buffering: Don't redirect stderr to stdout, and don't "buffer"
> + * the output of the N children started. The output will not be
> + * deterministic and may be interleaved, but we won't interfere with
> + * the connection to the TTY.
>   */
>  struct run_process_parallel_opts
>  {
>         const char *tr2_category;
>         const char *tr2_label;
> +       unsigned int no_buffering:1;
>  };
>
>  /**
> @@ -477,7 +483,8 @@ struct run_process_parallel_opts
>   *
>   * The children started via this function run in parallel. Their output
>   * (both stdout and stderr) is routed to stderr in a manner that output
> - * from different tasks does not interleave.
> + * from different tasks does not interleave. This can be disabled by set=
ting
> + * "no_buffering" in "struct run_process_parallel_opts".
>   *
>   * start_failure_fn and task_finished_fn can be NULL to omit any
>   * special handling.
> diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
> index ee281909bc3..fb6ad0bf4f7 100755
> --- a/t/t0061-run-command.sh
> +++ b/t/t0061-run-command.sh
> @@ -130,7 +130,7 @@ World
>  EOF
>
>  test_expect_success 'run_command runs in parallel with more jobs availab=
le than tasks' '
> -       test-tool run-command run-command-parallel 5 sh -c "printf \"%s\n=
%s\n\" Hello World" 2>actual &&
> +       test-tool run-command run-command-parallel 5 sh -c "printf \"%s\n=
%s\n\" Hello World" >actual 2>&1 &&
>         test_cmp expect actual
>  '
>
> diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
> index 26ed5e11bc8..c0eda4e9237 100755
> --- a/t/t1800-hook.sh
> +++ b/t/t1800-hook.sh
> @@ -4,6 +4,7 @@ test_description=3D'git-hook command'
>
>  TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  . ./test-lib.sh
> +. "$TEST_DIRECTORY"/lib-terminal.sh
>
>  test_expect_success 'git hook usage' '
>         test_expect_code 129 git hook &&
> @@ -120,4 +121,49 @@ test_expect_success 'git -c core.hooksPath=3D<PATH> =
hook run' '
>         test_cmp expect actual
>  '
>
> +test_expect_success TTY 'git hook run: stdout and stderr are connected t=
o a TTY: STDOUT redirect' '
> +       rm -rf .git &&
> +       test_when_finished "rm -rf .git" &&
> +       git init . &&
> +
> +       test_hook pre-commit <<-EOF &&
> +       {
> +               test -t 1 && echo STDOUT TTY || echo STDOUT NO TTY &&
> +               test -t 2 && echo STDERR TTY || echo STDERR NO TTY
> +       } >actual
> +       EOF
> +
> +       test_commit A &&
> +       test_commit B &&
> +       git reset --soft HEAD^ &&
> +       cat >expect <<-\EOF &&
> +       STDOUT NO TTY
> +       STDERR TTY
> +       EOF
> +       test_terminal git commit -m"msg" &&
> +       test_cmp expect actual
> +'
> +
> +test_expect_success TTY 'git hook run: stdout and stderr are connected t=
o a TTY: STDERR redirect' '
> +       test_when_finished "rm -rf .git" &&
> +       git init . &&
> +
> +       test_hook pre-commit <<-EOF &&
> +       {
> +               test -t 1 && echo >&2 STDOUT TTY || echo >&2 STDOUT NO TT=
Y &&
> +               test -t 2 && echo >&2 STDERR TTY || echo >&2 STDERR NO TT=
Y
> +       } 2>actual
> +       EOF
> +
> +       test_commit A &&
> +       test_commit B &&
> +       git reset --soft HEAD^ &&
> +       cat >expect <<-\EOF &&
> +       STDOUT TTY
> +       STDERR NO TTY
> +       EOF
> +       test_terminal git commit -m"msg" &&
> +       test_cmp expect actual
> +'
> +
>  test_done
