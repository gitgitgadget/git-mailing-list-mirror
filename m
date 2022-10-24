Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 843DBECAAA1
	for <git@archiver.kernel.org>; Mon, 24 Oct 2022 19:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbiJXTIC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Oct 2022 15:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232960AbiJXTHj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2022 15:07:39 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270ABB515E
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 10:46:44 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-3691e040abaso91981207b3.9
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 10:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yN4OWPoq/tSDL2xNyEejQDHUqJCDAb0XLYncPUdsBFg=;
        b=Xd1wb9DXevr/lMJd7KHWiUBavFND114mkISMTp4/O9S6L46XDoyCze+5u9Ooo5xAyR
         IVOhfI5NRLRz5bfDVpOwCP+B1Bwy+8e9/pgLIKayYzbMdoEf/U98BIQaGc3oWvB0yBfP
         NLWeKfziJLAdesVoTs3JZ1h6RqXP+CDpS0Ok+G3Rk/Ytj2zAUiBDxWwL+la3nFQWnMin
         qMwZ+rS5iGJRC2aO5OF/SHaNrJloO5Z8ekyo4QoC2anz3CrCc19+e6AJBDEgmK6EhDUW
         QXVn1PF1vQcfLjhPXyWxP0LoywqDyjB4fMMJuYzHHgUP47i5tMeBOQ8VPOaT5AqmWX7b
         6hOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yN4OWPoq/tSDL2xNyEejQDHUqJCDAb0XLYncPUdsBFg=;
        b=CKmM88FbGIpBMAGq09P5tSzUdjXLzr9f62IZTb/mNf/BYZqEPGh5JqsEVwdEJcBrpC
         +my6TheVKYJyRZraEfPlhK//ydltnSij/Ps5XO6VHUqIsQoDFMZQrLXB18acQxH2V3CV
         u4Vw/5roKc/wK3j6R3XkSuRioXN82tEvua3yuHjibWfnr29xLKT90xzU5bnwp/uRt8Is
         k8ZrhHa90e8klm9ehOPFWJOKi6Ti7uFHDXi4gWNXENb6EHU15xivDJSuzKp7PgCQhxuV
         YAvwV1K28V/Xm0eaCQaMCr7thcU4PPgitdjAzOymlns+7lURR7PV46shO7iq89KCyBbb
         NBQA==
X-Gm-Message-State: ACrzQf3jk/V632Z7SllQ9vlceUg7BwDkOqiok/TuE6gUwfr/85epxyK0
        B0EzkbXQv01G99sujY/n1stvNeUOT2LvVGXQEuK8xSYl/Nk=
X-Google-Smtp-Source: AMsMyM7zxYuSuhiBOBVGI3xkIdYx3i3WBZ8sQo3iiDiK72494Yc7a6rrdX+Y1wonHX2pOVKT7BJh7Mnb/h42rrifVxw=
X-Received: by 2002:a25:a288:0:b0:6ca:e3de:ae75 with SMTP id
 c8-20020a25a288000000b006cae3deae75mr7212266ybi.391.1666631599207; Mon, 24
 Oct 2022 10:13:19 -0700 (PDT)
MIME-Version: 1.0
References: <20221020232532.1128326-2-calvinwan@google.com> <221021.86h6zxg8ds.gmgdl@evledraar.gmail.com>
In-Reply-To: <221021.86h6zxg8ds.gmgdl@evledraar.gmail.com>
From:   Calvin Wan <calvinwan@google.com>
Date:   Mon, 24 Oct 2022 10:13:08 -0700
Message-ID: <CAFySSZDoZ5sVRchwAiE-ixOxhpe7UL5e-y+b5+wVXwQnLdqreQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] run-command: add pipe_output_fn to run_processes_parallel_opts
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, emilyshaffer@google.com,
        phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 20, 2022 at 8:31 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Thu, Oct 20 2022, Calvin Wan wrote:
>
> > Add pipe_output_fn as an optionally set function in
> > run_process_parallel_opts. If set, output from each child process is
> > first separately stored in 'out' and then piped to the callback
> > function when the child process finishes to allow for separate parsing.
>
> The "when[...]finish[ed]" here seems a bit odd to me. Why isn't the API
> to just stream this to callbacks as it comes in.
>
> Then if a caller only cares about the output at the very end they can
> manage that state between their streaming callbacks and "finish"
> callback, i.e. buffer it & flush it themselves.

That's a good idea. This also lets me remove the 'out' variable from
parallel_process.children.

>
> > diff --git a/run-command.c b/run-command.c
> > index c772acd743..03787bc7f5 100644
> > --- a/run-command.c
> > +++ b/run-command.c
> > @@ -1503,6 +1503,7 @@ struct parallel_processes {
> >               enum child_state state;
> >               struct child_process process;
> >               struct strbuf err;
> > +             struct strbuf out;
> >               void *data;
> >       } *children;
> >       /*
> > @@ -1560,6 +1561,9 @@ static void pp_init(struct parallel_processes *pp=
,
> >
> >       if (!opts->get_next_task)
> >               BUG("you need to specify a get_next_task function");
> > +
> > +     if (opts->pipe_output && opts->ungroup)
> > +             BUG("pipe_output and ungroup are incompatible with each o=
ther");
> >
> >       CALLOC_ARRAY(pp->children, n);
> >       if (!opts->ungroup)
> > @@ -1567,6 +1571,8 @@ static void pp_init(struct parallel_processes *pp=
,
> >
> >       for (size_t i =3D 0; i < n; i++) {
> >               strbuf_init(&pp->children[i].err, 0);
> > +             if (opts->pipe_output)
> > +                     strbuf_init(&pp->children[i].out, 0);
>
> Even if we're not using this, let's init it for simplicity. We don't use
> the "err" with ungroup and we're init-ing that, and...

ack.

>
> >               child_process_init(&pp->children[i].process);
> >               if (pp->pfd) {
> >                       pp->pfd[i].events =3D POLLIN | POLLHUP;
> > @@ -1586,6 +1592,7 @@ static void pp_cleanup(struct parallel_processes =
*pp,
> >       trace_printf("run_processes_parallel: done");
> >       for (size_t i =3D 0; i < opts->processes; i++) {
> >               strbuf_release(&pp->children[i].err);
> > +             strbuf_release(&pp->children[i].out);
>
> ...here you're strbuf_relese()-ing a string that was never init'd, it's
> not segfaulting because we check sb->alloc, and since we calloc'd this
> whole thing it'll be 0, but let's just init it so it's a proper strbuf
> (with slopbuf). It's cheap.

ack.

> > +/**
> > + * This callback is called on every child process that finished proces=
sing.
> > + *
> > + * "struct strbuf *process_out" contains the output from the finished =
child
> > + * process.
> > + *
> > + * pp_cb is the callback cookie as passed into run_processes_parallel,
> > + * pp_task_cb is the callback cookie as passed into get_next_task_fn.
> > + *
> > + * This function is incompatible with "ungroup"
> > + */
> > +typedef void (*pipe_output_fn)(struct strbuf *process_out,
> > +                            void *pp_cb,
> > +                            void *pp_task_cb);
> > +
> >  /**
> >   * This callback is called on every child process that finished proces=
sing.
> >   *
> > @@ -493,6 +508,12 @@ struct run_process_parallel_opts
> >        */
> >       start_failure_fn start_failure;
> >
> > +     /**
> > +      * pipe_output: See pipe_output_fn() above. This should be
> > +      * NULL unless process specific output is needed
> > +      */
> > +     pipe_output_fn pipe_output;
> > +
> >       /**
> >        * task_finished: See task_finished_fn() above. This can be
> >        * NULL to omit any special handling.
> > diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
> > index 3ecb830f4a..e9b41419a0 100644
> > --- a/t/helper/test-run-command.c
> > +++ b/t/helper/test-run-command.c
> > @@ -52,6 +52,13 @@ static int no_job(struct child_process *cp,
> >       return 0;
> >  }
> >
> > +static void pipe_output(struct strbuf *process_out,
> > +                     void *pp_cb,
> > +                     void *pp_task_cb)
> > +{
> > +     fprintf(stderr, "%s", process_out->buf);
>
> maybe print this with split lines prefixed with something so wour tests
> can see that something actually happened here, & test-cmp it so we can
> see what went where, as opposed to...
>
> > +test_expect_success 'run_command runs in parallel with more jobs avail=
able than tasks --pipe-output' '
> > +     test-tool run-command --pipe-output run-command-parallel 5 sh -c =
"printf \"%s\n%s\n\" Hello World" >out 2>err &&
> > +     test_must_be_empty out &&
> > +     test_line_count =3D 20 err
> > +'
>
> Just checking the number of lines, which seems to leave a lot of leeway
> for the output being mixed up in all sorts of ways & the test to still
> pass..
>
> (ditto below)

ack.
