Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1ACC4332F
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 19:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiJMTTu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 15:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiJMTTs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 15:19:48 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7410F60DE
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 12:19:39 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-358bf076f1fso26664437b3.9
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 12:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g0y8uJtU+HhxbL6/sGhr7NPjLG2dQJgDLkqCdsW/dj4=;
        b=J3CWxQCRQfNlD/67ZFXdoHPXVqaN9C2wuUxTL7rxs3bedUfXtISnRUKijaqZ+BC2IA
         BB8ldP5DlJl7piX57Bs45kNvOJ1OGFKQy8sC4UYIa/iU3533fs8LOCXI28F5ZruVfclx
         GGhtI1nlw13CFWhhiFyy34ZLnZh39dT0H5m/3rGt+yuMlnvhCXQFMN7XzS4+pW87jfSx
         PFKEsZEPPVU8/ndQ4NFZ9QFtAsfXl0NCELPOpQo5M2ulNwdkwmTIuPUjQYG0AY3fhmsR
         CXsRtcqwFWYAFK81k+1DI8YzEOEA++lkPSFplNpSMK8mSFVFy+KDKMxOt3eGSTWKmn1H
         Xihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g0y8uJtU+HhxbL6/sGhr7NPjLG2dQJgDLkqCdsW/dj4=;
        b=UgcmGFR3jM3BMmPtSGXBx1+YFA0K/6FLYuUmug1HxKm+3lpbY6f1i77W7xjwhdo7AN
         Mw4PYGe0htTeKrOwSx9vnfJ0PPt2ZHRtFdWu9glnW/VkgmwLy1TG4G4mZsPjemfWdz96
         aA66qZ3yLWWPLPPRokqAcuYtsOWmdb1DCfX7J28sT3LpgHesyXbLrjr0LKUixFTWDTAB
         2pO4tX6XYH0tQg+njws/GUUGK0sjumEe8pBjPWEumu8rxG3l1lQFas9KnoHBg0yCNQ1D
         1KkapJP+a8epP7OI4TBKvwRe610/oVpgRugGX+akVJB6sCwlSZpffr6Sw0mn7bSJApf4
         Jxow==
X-Gm-Message-State: ACrzQf31b63ippLNDK2xdSlLjepFxT3YvgnRE6CZw1Tlgu/nhMzHC7a6
        oww6/k+MfeiCBB2WjFOwyUUU/fNhKfumtvpKzD0D8A==
X-Google-Smtp-Source: AMsMyM6Gqg95YG2tuTJK+woEue0tKfaQ27lPlkriQg8vZcJTWS38QIKo5tj0oo0nnCY/vhQM63MNZcsSGGodKzeKvMY=
X-Received: by 2002:a0d:df83:0:b0:35b:f6d9:1ed2 with SMTP id
 i125-20020a0ddf83000000b0035bf6d91ed2mr1397944ywe.369.1665688778341; Thu, 13
 Oct 2022 12:19:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com> <cover-v3-00.15-00000000000-20221012T205712Z-avarab@gmail.com>
In-Reply-To: <cover-v3-00.15-00000000000-20221012T205712Z-avarab@gmail.com>
From:   Calvin Wan <calvinwan@google.com>
Date:   Thu, 13 Oct 2022 12:19:27 -0700
Message-ID: <CAFySSZDdSCHjKCH74h-uStZa4n9xGPbA95unpQUK82b+sBQuvA@mail.gmail.com>
Subject: Re: [PATCH v3 00/15] run-command API: pass functions & opts via struct
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi =C3=86var

Thank you for condensing the patch series into something more palatable
for reviewers. The general consensus from the review club yesterday (we
looked at v2) was that it was difficult to follow what patches were
relevant to your original intention and what patches were auxiliary QOL
changes. Also having too many intermediary patches where you add
variables/functions that were later deleted made it hard to visualize
which parts of the patch would end up making it into the final state. I
appreciate the "show your work" approach you take, but I think that
approach is better suited for more difficult patch series where there
are significant/difficult to understand functionality changes. In this
case, the end state of a refactor is clear and there are no
functionality changes so I believe a more condensed series would be
easier to review. That being said, I don't believe there is a need to
spend more time trying to condense this series so future reviewers have
an easier time -- the end result and intentions are enough.

Reviewed-by: Calvin Wan <calvinwan@google.com>

On Wed, Oct 12, 2022 at 2:03 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> For a general overview see the v2 CL:
> https://lore.kernel.org/git/cover-v2-00.22-00000000000-20221012T084850Z-a=
varab@gmail.com/
>
> Changes since v2:
>
>  * Ejected various not-to-the-point of converting to the "opts struct"
>    per feedback about attempting to make this leaner.
>  * I kept the size_t change & the online_cpus() fallback, and updated
>    a commit message for the latter. For "int" v.s. "size_t" once we're
>    not handling "-1" to mean "use the default" it makes sense to be
>    unsigned, and if we're re-doing that at this point we'd need
>    rewrites for "!processes" assumptions.
>  * Squashed the multi-step introduction of the "opts" struct, per
>    Phillip's suggestion.
>  * Fixed a segfault in the v2's 22/22 (this 15/15).
>  * Got rid of superfluous unsigned conversions of code related to the
>    "env" member.
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (15):
>   run-command test helper: use "else if" pattern
>   run-command API: have "run_processes_parallel{,_tr2}()" return void
>   run-command tests: use "return", not "exit"
>   run-command API: make "n" parameter a "size_t"
>   run-command API: don't fall back on online_cpus()
>   run-command.c: use designated init for pp_init(), add "const"
>   run-command API: have run_process_parallel() take an "opts" struct
>   run-command API: move *_tr2() users to "run_processes_parallel()"
>   run-command.c: make "struct parallel_processes" const if possible
>   run-command.c: don't copy *_fn to "struct parallel_processes"
>   run-command.c: don't copy "ungroup" to "struct parallel_processes"
>   run-command.c: don't copy "data" to "struct parallel_processes"
>   run-command.c: use "opts->processes", not "pp->max_processes"
>   run-command.c: pass "opts" further down, and use "opts->processes"
>   run-command.c: remove "max_processes", add "const" to signal() handler
>
>  builtin/fetch.c             |  25 ++--
>  builtin/submodule--helper.c |  16 ++-
>  hook.c                      |  23 ++--
>  run-command.c               | 236 ++++++++++++++++--------------------
>  run-command.h               |  71 ++++++++---
>  submodule-config.c          |   2 +
>  submodule.c                 |  18 ++-
>  t/helper/test-run-command.c |  77 +++++++-----
>  t/t5526-fetch-submodules.sh |   8 +-
>  9 files changed, 268 insertions(+), 208 deletions(-)
>
> Range-diff against v2:
>  1:  bc51dfcb1be <  -:  ----------- hook tests: fix redirection logic err=
or in 96e7225b310
>  2:  3027f5587a7 <  -:  ----------- submodule tests: reset "trace.out" be=
tween "grep" invocations
>  3:  c4923358bbd <  -:  ----------- run-command tests: test stdout of run=
_command_parallel()
>  4:  26e28086252 =3D  1:  d3a2489d9b2 run-command test helper: use "else =
if" pattern
>  5:  5e09dc68fd9 =3D  2:  a2e4fd652c1 run-command API: have "run_processe=
s_parallel{,_tr2}()" return void
>  6:  e4e91dbbf9e =3D  3:  4a19de65783 run-command tests: use "return", no=
t "exit"
>  7:  b90961ae76d <  -:  ----------- run-command.c: remove dead assignment=
 in while-loop
>  8:  279b0430c5d <  -:  ----------- run-command.c: use C99 "for (TYPE VAR=
 =3D ..." syntax where useful
>  9:  a900711270c !  4:  58018a79b2f run-command API: make "n" parameter a=
 "size_t"
>     @@ Commit message
>
>                  make run-command.o DEVOPTS=3Dextra-all CFLAGS=3D-Wno-unu=
sed-parameter
>
>     -    Only has one (and new) -Wsigned-compare warning, about a compari=
son of
>     -    "i" to online_cpus(), a subsequent commit will adjust & deal wit=
h
>     -    online_cpus() and that warning.
>     +    Only has one (and new) -Wsigned-compare warning relevant to a
>     +    comparison about our "n" or "{nr,max}_processes": About using ou=
r
>     +    "n" (size_t) in the same expression as online_cpus() (int). A
>     +    subsequent commit will adjust & deal with online_cpus() and that
>     +    warning.
>
>          The only users of the "n" parameter are:
>
>     @@ run-command.c: static void pp_cleanup(struct parallel_processes *p=
p)
>
>         for (i =3D 0; i < pp->max_processes; i++)
>                 if (pp->children[i].state =3D=3D GIT_CP_FREE)
>     -@@ run-command.c: static int pp_start_one(struct parallel_processes =
*pp)
>     -
>     - static void pp_buffer_stderr(struct parallel_processes *pp, int out=
put_timeout)
>     - {
>     --  int i;
>     --
>     -   while (poll(pp->pfd, pp->max_processes, output_timeout) < 0) {
>     -           if (errno =3D=3D EINTR)
>     -                   continue;
>      @@ run-command.c: static void pp_buffer_stderr(struct parallel_proce=
sses *pp, int output_timeout)
>         }
>
> 10:  eb9d672b0d8 !  5:  e230701dff6 run-command API: don't fall back on o=
nline_cpus()
>     @@ Commit message
>          child processor, 2015-12-15).
>
>          Most of our code in-tree that scales up to "online_cpus()" by de=
fault
>     -    calls that function by itself. By having these callers of the
>     -    "run_processes_parallel()" API do the same we can in subsequent
>     -    commits pass all arguments down as a "const struct".
>     +    calls that function by itself. Keeping this default behavior jus=
t for
>     +    the sake of two callers means that we'd need to maintain this on=
e spot
>     +    where we're second-guessing the config passed down into pp_init(=
).
>
>          The preceding commit has an overview of the API callers that pas=
sed
>          "jobs =3D 0". There were only two of them (actually three, but t=
hey
>     @@ submodule-config.c: int parse_submodule_fetchjobs(const char *var,=
 const char *v
>
>       ## t/t5526-fetch-submodules.sh ##
>      @@ t/t5526-fetch-submodules.sh: test_expect_success 'fetching submod=
ules respects parallel settings' '
>     +           GIT_TRACE=3D$(pwd)/trace.out git fetch &&
>     +           grep "8 tasks" trace.out &&
>                 GIT_TRACE=3D$(pwd)/trace.out git fetch --jobs 9 &&
>     -           grep "9 tasks" trace.out &&
>     -           >trace.out &&
>     +-          grep "9 tasks" trace.out
>     ++          grep "9 tasks" trace.out &&
>     ++          >trace.out &&
>      +
>      +          GIT_TRACE=3D$(pwd)/trace.out git -c submodule.fetchJobs=
=3D0 fetch &&
>      +          grep "preparing to run up to [0-9]* tasks" trace.out &&
> 11:  aedda10d8e1 !  6:  df2ca5dd097 run-command.c: use designated init fo=
r pp_init(), add "const"
>     @@ run-command.c: void run_processes_parallel(size_t n,
>      -          ungroup);
>      +  pp_init(&pp, get_next_task, start_failure, task_finished);
>         while (1) {
>     -           for (int i =3D 0;
>     +           for (i =3D 0;
>                     i < spawn_cap && !pp.shutdown &&
> 12:  fde2af11579 <  -:  ----------- run-command API: add nascent "struct =
run_process_parallel_opts"
> 13:  01e894bed90 <  -:  ----------- run-command API: make run_process_par=
allel{,_tr2}() thin wrappers
> 14:  41c2886b44b !  7:  eaed3d8838d run-command API: have run_process_par=
allel() take an "opts" struct
>     @@ Metadata
>       ## Commit message ##
>          run-command API: have run_process_parallel() take an "opts" stru=
ct
>
>     -    Have the "run_process_parallel()" function take an "opts" struct=
,
>     -    which allows us to eliminate it as a wrapper for
>     -    "run_processes_parallel_1()".
>     +    As noted in fd3aaf53f71 (run-command: add an "ungroup" option to
>     +    run_process_parallel(), 2022-06-07) which added the "ungroup" pa=
ssing
>     +    it to "run_process_parallel()" via the global
>     +    "run_processes_parallel_ungroup" variable was a compromise to ge=
t the
>     +    smallest possible regression fix for "maint" at the time.
>     +
>     +    This follow-up to that is a start at passing that parameter and =
others
>     +    via a new "struct run_process_parallel_opts", as the earlier
>     +    version[1] of what became fd3aaf53f71 did.
>     +
>     +    Since we need to change all of the occurrences of "n" to
>     +    "opt->SOMETHING" let's take the opportunity and rename the terse=
 "n"
>     +    to "processes". We could also have picked "max_processes", "jobs=
",
>     +    "threads" etc., but as the API is named "run_processes_parallel(=
)"
>     +    let's go with "processes".
>
>          Since the new "run_processes_parallel()" function is able to tak=
e an
>          optional "tr2_category" and "tr2_label" via the struct we can at=
 this
>          point migrate all of the users of "run_processes_parallel_tr2()"=
 over
>          to it.
>
>     -    But let's not migrate all the API users, only the two users that
>     +    But let's not migrate all the API users yet, only the two users =
that
>          passed the "ungroup" parameter via the
>     -    "run_processes_parallel_ungroup" global, allowing us to delete t=
hat
>     -    global in favor of passing "ungroup" via the "opts" struct. As n=
oted
>     -    in fd3aaf53f71 (run-command: add an "ungroup" option to
>     -    run_process_parallel(), 2022-06-07) which added
>     -    "run_processes_parallel_ungroup" passing this as a global was a =
hack
>     -    to produce a small regression fix for "maint".
>     +    "run_processes_parallel_ungroup" global
>     +
>     +    1. https://lore.kernel.org/git/cover-v2-0.8-00000000000-20220518=
T195858Z-avarab@gmail.com/
>
>          Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gm=
ail.com>
>
>     @@ run-command.c: enum child_state {
>       struct parallel_processes {
>         void *const data;
>
>     +@@ run-command.c: static void handle_children_on_signal(int signo)
>     + }
>     +
>     + static void pp_init(struct parallel_processes *pp,
>     +-              get_next_task_fn get_next_task,
>     +-              start_failure_fn start_failure,
>     +-              task_finished_fn task_finished)
>     ++              const struct run_process_parallel_opts *opts)
>     + {
>     +-  const size_t n =3D pp->max_processes;
>     ++  const size_t n =3D opts->processes;
>     ++  get_next_task_fn get_next_task =3D opts->get_next_task;
>     ++  start_failure_fn start_failure =3D opts->start_failure;
>     ++  task_finished_fn task_finished =3D opts->task_finished;
>     +
>     +   if (!n)
>     +           BUG("you must provide a non-zero number of processes!");
>      @@ run-command.c: static int pp_collect_finished(struct parallel_pro=
cesses *pp)
>         return result;
>       }
>
>     --static void run_processes_parallel_1(const struct run_process_paral=
lel_opts *opts, void *pp_cb)
>     +-void run_processes_parallel(size_t n,
>     +-                      get_next_task_fn get_next_task,
>     +-                      start_failure_fn start_failure,
>     +-                      task_finished_fn task_finished,
>     +-                      void *pp_cb)
>      +void run_processes_parallel(const struct run_process_parallel_opts =
*opts)
>       {
>     -   int code;
>     +   int i, code;
>         int output_timeout =3D 100;
>         int spawn_cap =3D 4;
>     +-  int ungroup =3D run_processes_parallel_ungroup;
>         struct parallel_processes pp =3D {
>     -           .max_processes =3D opts->processes,
>     +-          .max_processes =3D n,
>      -          .data =3D pp_cb,
>     ++          .max_processes =3D opts->processes,
>      +          .data =3D opts->data,
>                 .buffered_output =3D STRBUF_INIT,
>     --          .ungroup =3D run_processes_parallel_ungroup,
>     +-          .ungroup =3D ungroup,
>      +          .ungroup =3D opts->ungroup,
>         };
>     -   /* options */
>     -   const char *tr2_category =3D opts->tr2_category;
>     -   const char *tr2_label =3D opts->tr2_label;
>     -   const int do_trace2 =3D tr2_category && tr2_label;
>     ++  /* options */
>     ++  const char *tr2_category =3D opts->tr2_category;
>     ++  const char *tr2_label =3D opts->tr2_label;
>     ++  const int do_trace2 =3D tr2_category && tr2_label;
>
>      -  /* unset for the next API user */
>      -  run_processes_parallel_ungroup =3D 0;
>     --
>     -   if (do_trace2)
>     -           trace2_region_enter_printf(tr2_category, tr2_label, NULL,
>     -                                      "max:%d", opts->processes);
>     -@@ run-command.c: static void run_processes_parallel_1(const struct =
run_process_parallel_opts *opt
>     -           trace2_region_leave(tr2_category, tr2_label, NULL);
>     ++  if (do_trace2)
>     ++          trace2_region_enter_printf(tr2_category, tr2_label, NULL,
>     ++                                     "max:%d", opts->processes);
>     +
>     +-  pp_init(&pp, get_next_task, start_failure, task_finished);
>     ++  pp_init(&pp, opts);
>     +   while (1) {
>     +           for (i =3D 0;
>     +               i < spawn_cap && !pp.shutdown &&
>     +@@ run-command.c: void run_processes_parallel(size_t n,
>     +           }
>     +           if (!pp.nr_processes)
>     +                   break;
>     +-          if (ungroup) {
>     ++          if (opts->ungroup) {
>     +                   for (size_t i =3D 0; i < pp.max_processes; i++)
>     +                           pp.children[i].state =3D GIT_CP_WAIT_CLEA=
NUP;
>     +           } else {
>     +@@ run-command.c: void run_processes_parallel(size_t n,
>     +   }
>     +
>     +   pp_cleanup(&pp);
>     ++
>     ++  if (do_trace2)
>     ++          trace2_region_leave(tr2_category, tr2_label, NULL);
>       }
>
>     --void run_processes_parallel(size_t processes,
>     --                      get_next_task_fn get_next_task,
>     --                      start_failure_fn start_failure,
>     --                      task_finished_fn task_finished,
>     --                      void *pp_cb)
>     --{
>     --  const struct run_process_parallel_opts opts =3D {
>     --          .processes =3D processes,
>     --          .ungroup =3D run_processes_parallel_ungroup,
>     --
>     --          .get_next_task =3D get_next_task,
>     --          .start_failure =3D start_failure,
>     --          .task_finished =3D task_finished,
>     --  };
>     --
>     --  run_processes_parallel_1(&opts, pp_cb);
>     --}
>     --
>     - void run_processes_parallel_tr2(size_t processes, get_next_task_fn =
get_next_task,
>     +-void run_processes_parallel_tr2(size_t n, get_next_task_fn get_next=
_task,
>     ++void run_processes_parallel_tr2(size_t processes, get_next_task_fn =
get_next_task,
>                                 start_failure_fn start_failure,
>                                 task_finished_fn task_finished, void *pp_=
cb,
>     -@@ run-command.c: void run_processes_parallel_tr2(size_t processes, =
get_next_task_fn get_next_task
>     -   const struct run_process_parallel_opts opts =3D {
>     -           .tr2_category =3D tr2_category,
>     -           .tr2_label =3D tr2_label,
>     --
>     -           .processes =3D processes,
>     --          .ungroup =3D run_processes_parallel_ungroup,
>     +                           const char *tr2_category, const char *tr2=
_label)
>     + {
>     +-  trace2_region_enter_printf(tr2_category, tr2_label, NULL, "max:%d=
", n);
>     ++  const struct run_process_parallel_opts opts =3D {
>     ++          .tr2_category =3D tr2_category,
>     ++          .tr2_label =3D tr2_label,
>     ++          .processes =3D processes,
>
>     -           .get_next_task =3D get_next_task,
>     -           .start_failure =3D start_failure,
>     -           .task_finished =3D task_finished,
>     -   };
>     +-  run_processes_parallel(n, get_next_task, start_failure,
>     +-                         task_finished, pp_cb);
>     ++          .get_next_task =3D get_next_task,
>     ++          .start_failure =3D start_failure,
>     ++          .task_finished =3D task_finished,
>     ++  };
>
>     --  run_processes_parallel_1(&opts, pp_cb);
>     +-  trace2_region_leave(tr2_category, tr2_label, NULL);
>      +  run_processes_parallel(&opts);
>       }
>
>       int run_auto_maintenance(int quiet)
>
>       ## run-command.h ##
>     -@@ run-command.h: struct run_process_parallel_opts
>     -    * NULL to omit any special handling.
>     -    */
>     -   task_finished_fn task_finished;
>     +@@ run-command.h: typedef int (*task_finished_fn)(int result,
>     +                           void *pp_task_cb);
>     +
>     + /**
>     +- * Runs up to n processes at the same time. Whenever a process can =
be
>     +- * started, the callback get_next_task_fn is called to obtain the d=
ata
>     ++ * Option used by run_processes_parallel(), { 0 }-initialized means=
 no
>     ++ * options.
>     ++ */
>     ++struct run_process_parallel_opts
>     ++{
>     ++  /**
>     ++   * tr2_category & tr2_label: sets the trace2 category and label f=
or
>     ++   * logging. These must either be unset, or both of them must be s=
et.
>     ++   */
>     ++  const char *tr2_category;
>     ++  const char *tr2_label;
>     ++
>     ++  /**
>     ++   * processes: see 'processes' in run_processes_parallel() below.
>     ++   */
>     ++  size_t processes;
>     ++
>     ++  /**
>     ++   * ungroup: see 'ungroup' in run_processes_parallel() below.
>     ++   */
>     ++  unsigned int ungroup:1;
>     ++
>     ++  /**
>     ++   * get_next_task: See get_next_task_fn() above. This must be
>     ++   * specified.
>     ++   */
>     ++  get_next_task_fn get_next_task;
>     ++
>     ++  /**
>     ++   * start_failure: See start_failure_fn() above. This can be
>     ++   * NULL to omit any special handling.
>     ++   */
>     ++  start_failure_fn start_failure;
>     ++
>     ++  /**
>     ++   * task_finished: See task_finished_fn() above. This can be
>     ++   * NULL to omit any special handling.
>     ++   */
>     ++  task_finished_fn task_finished;
>      +
>      +  /**
>      +   * data: user data, will be passed as "pp_cb" to the callback
>      +   * parameters.
>      +   */
>      +  void *data;
>     - };
>     -
>     - /**
>     ++};
>     ++
>     ++/**
>      + * Options are passed via the "struct run_process_parallel_opts" ab=
ove.
>      + *
>     -  * Runs N 'processes' at the same time. Whenever a process can be
>     -- * started, the callback get_next_task_fn is called to obtain the d=
ata
>     ++ * Runs N 'processes' at the same time. Whenever a process can be
>      + * started, the callback opts.get_next_task is called to obtain the=
 data
>        * required to start another child process.
>        *
>        * The children started via this function run in parallel. Their ou=
tput
>     -@@ run-command.h: struct run_process_parallel_opts
>     +  * (both stdout and stderr) is routed to stderr in a manner that ou=
tput
>     +  * from different tasks does not interleave (but see "ungroup" belo=
w).
>     +  *
>     +- * start_failure_fn and task_finished_fn can be NULL to omit any
>     +- * special handling.
>     +- *
>     +  * If the "ungroup" option isn't specified, the API will set the
>     +  * "stdout_to_stderr" parameter in "struct child_process" and provi=
de
>     +  * the callbacks with a "struct strbuf *out" parameter to write out=
put
>     +@@ run-command.h: typedef int (*task_finished_fn)(int result,
>        * NULL "struct strbuf *out" parameter, and are responsible for
>        * emitting their own output, including dealing with any race
>        * conditions due to writing in parallel to stdout and stderr.
>     @@ run-command.h: struct run_process_parallel_opts
>      - * API reads that setting.
>        */
>      -extern int run_processes_parallel_ungroup;
>     --void run_processes_parallel(size_t processes,
>     +-void run_processes_parallel(size_t n,
>      -                      get_next_task_fn,
>      -                      start_failure_fn,
>      -                      task_finished_fn,
>      -                      void *pp_cb);
>     +-void run_processes_parallel_tr2(size_t n, get_next_task_fn, start_f=
ailure_fn,
>     +-                          task_finished_fn, void *pp_cb,
>      +void run_processes_parallel(const struct run_process_parallel_opts =
*opts);
>     - void run_processes_parallel_tr2(size_t processes, get_next_task_fn,
>     -                           start_failure_fn, task_finished_fn, void =
*pp_cb,
>     ++void run_processes_parallel_tr2(size_t processes, get_next_task_fn,
>     ++                          start_failure_fn, task_finished_fn, void =
*pp_cb,
>                                 const char *tr2_category, const char *tr2=
_label);
>     +
>     + /**
>
>       ## t/helper/test-run-command.c ##
>      @@ t/helper/test-run-command.c: static const char * const testsuite_=
usage[] =3D {
> 15:  391d1d99d91 =3D  8:  c19c60b2e95 run-command API: move *_tr2() users=
 to "run_processes_parallel()"
> 16:  acac50cc1a5 =3D  9:  99a4f4f6b9c run-command.c: make "struct paralle=
l_processes" const if possible
> 17:  fdd64236985 =3D 10:  bf67e24bcc5 run-command.c: don't copy *_fn to "=
struct parallel_processes"
> 18:  17f34d81ecd =3D 11:  06de42adc2e run-command.c: don't copy "ungroup"=
 to "struct parallel_processes"
> 19:  9cbee2dfe76 =3D 12:  3081dfc49d1 run-command.c: don't copy "data" to=
 "struct parallel_processes"
> 20:  2dabed9e155 ! 13:  b7c10f6a23f run-command.c: use "opts->processes",=
 not "pp->max_processes"
>     @@ run-command.c: static int pp_collect_finished(struct parallel_proc=
esses *pp,
>
>      @@ run-command.c: void run_processes_parallel(const struct run_proce=
ss_parallel_opts *opts)
>         while (1) {
>     -           for (int i =3D 0;
>     +           for (i =3D 0;
>                     i < spawn_cap && !pp.shutdown &&
>      -              pp.nr_processes < pp.max_processes;
>      +              pp.nr_processes < opts->processes;
> 21:  c1a286a8ebb ! 14:  4856d6a4674 run-command.c: pass "opts" further do=
wn, and use "opts->processes"
>     @@ run-command.c: static int pp_start_one(struct parallel_processes *=
pp,
>      +                       const struct run_process_parallel_opts *opts=
,
>      +                       int output_timeout)
>       {
>     --  while (poll(pp->pfd, pp->max_processes, output_timeout) < 0) {
>     -+  while (poll(pp->pfd, opts->processes, output_timeout) < 0) {
>     +   int i;
>     +
>     +-  while ((i =3D poll(pp->pfd, pp->max_processes, output_timeout)) <=
 0) {
>     ++  while ((i =3D poll(pp->pfd, opts->processes, output_timeout) < 0)=
) {
>                 if (errno =3D=3D EINTR)
>                         continue;
>      -          pp_cleanup(pp);
> 22:  541f41566e7 ! 15:  39a20be0cbb run-command.c: remove "pp->max_proces=
ses", add "const" to signal() handler
>     @@ Metadata
>      Author: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>
>       ## Commit message ##
>     -    run-command.c: remove "pp->max_processes", add "const" to signal=
() handler
>     +    run-command.c: remove "max_processes", add "const" to signal() h=
andler
>
>          As with the *_fn members removed in a preceding commit, let's no=
t copy
>          the "processes" member of the "struct run_process_parallel_opts"=
 over
>     @@ run-command.c: static void pp_init(struct parallel_processes *pp,
>      -  pp_for_signal =3D pp;
>      +  pp_sig->pp =3D pp;
>      +  pp_sig->opts =3D opts;
>     ++  pp_for_signal =3D pp_sig;
>         sigchain_push_common(handle_children_on_signal);
>       }
>
>      @@ run-command.c: void run_processes_parallel(const struct run_proce=
ss_parallel_opts *opts)
>     -   int code;
>     +   int i, code;
>         int output_timeout =3D 100;
>         int spawn_cap =3D 4;
>      +  struct parallel_processes_for_signal pp_sig;
>     @@ run-command.c: void run_processes_parallel(const struct run_proces=
s_parallel_opt
>      -  pp_init(&pp, opts);
>      +  pp_init(&pp, opts, &pp_sig);
>         while (1) {
>     -           for (int i =3D 0;
>     +           for (i =3D 0;
>                     i < spawn_cap && !pp.shutdown &&
>      @@ run-command.c: void run_processes_parallel(const struct run_proce=
ss_parallel_opts *opts)
>                                 continue;
> --
> 2.38.0.971.ge79ff6d20e7
>
