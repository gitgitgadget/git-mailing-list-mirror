Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44FEC6FA82
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 17:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbiIZRhe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 13:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbiIZRhI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 13:37:08 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC56817E12
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 09:59:20 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 198so9211359ybc.1
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 09:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=c+RnJg+YBli6p8sNuDposTuZckavN4QWRM6jD719bZY=;
        b=N1bNpJljxgmWrOkj6p8VOExQ0Kij0r+R3p3R45fRIc5mVUuTuL9zPT4c4m4+JMwOvu
         uaDTsmgZfr/mKmRj0VTO8ueQ3HQKYz7xmUF/lGYfH8x+54EtsWm74B2xv77bNSczLweb
         BXBZKDS/CuIM0+iaX/HNLqccz/LbAsYCAsVww2C0F/s2Be7FjRPGy3wLlx/oCZpKSLsW
         YnU8oMCT4GZwwHzt4yqWFpStNFHWGdYcMwZELgVFrgqEtHYMV+PJau7/vY0vuoazQaBA
         xo1ZAYhUCK2tiFkn23og3ACgQdbtaTIZosAf1HQ38+agt8YI2cNeRO4fPC92KlVZ6W0n
         22Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=c+RnJg+YBli6p8sNuDposTuZckavN4QWRM6jD719bZY=;
        b=OOi87abM8COfqBpPwu4QAkh6sXlIXWTzPIPKc/qoUsVlftZRMBXhQGo1NEzU2OFqFx
         biW7i0YJQZP5PsEzn9yCc3wThxtdTxkuKIKEGojItQcjyQRzAJvTUqv7xmsubcSihw82
         hgKFJbxl1RHV1FAjDwVkHRGAzc/LFYKQAgj6AKwCdvmsQYTVhQ/euCo3r0iwFYF1JYwO
         jdsgRAJxjo9XNji9MUyAxhZ70af9K7n686OSvwS5nEwe4gGxCW4ZHwzEM8Hp/v3CFrh+
         hom4mCpQIow9CTr6Kq2yKitxayO/An6KJtZaAa8lPTHByNQ7qyWEHPdMFT6Nk11w1XR5
         Vh9A==
X-Gm-Message-State: ACrzQf38jH59im57ZBw8zvJnxzPFL9hPjgoZwNQjD+ytR/ZP/16HIYz0
        d9oP3f7YoNKgJRMqzLvauXWD32KZ6vEP6aJrx57DNTMT0W4=
X-Google-Smtp-Source: AMsMyM65atck8NSqUvSGVuJukP+9gLyobARmahC59Y1AJTtt2Bj3ejnjZufNECXrRdRzbMvZdNAAvNKBsaw++oNKaZI=
X-Received: by 2002:a5b:48d:0:b0:6a1:881a:5d73 with SMTP id
 n13-20020a5b048d000000b006a1881a5d73mr22391845ybp.510.1664211559867; Mon, 26
 Sep 2022 09:59:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220922232947.631309-1-calvinwan@google.com> <20220922232947.631309-2-calvinwan@google.com>
 <220923.86sfki4ize.gmgdl@evledraar.gmail.com>
In-Reply-To: <220923.86sfki4ize.gmgdl@evledraar.gmail.com>
From:   Calvin Wan <calvinwan@google.com>
Date:   Mon, 26 Sep 2022 09:59:08 -0700
Message-ID: <CAFySSZB=bPWpK25Gwtm06cOyupGeUYo6qLC4PWPwaS2pNn22hA@mail.gmail.com>
Subject: Re: [PATCH 1/4] run-command: add pipe_output to run_processes_parallel
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, emilyshaffer@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> An earlier version of that series simply changed the API to pass an
> "opts" struct instead:
> https://lore.kernel.org/git/patch-v2-2.8-5f0a6e9925f-20220518T195858Z-avarab@gmail.com/
>
> I really should have submitted those post-release cleanup patches
> already, and I'm not sure whether the right thing at this point is to
> take this & do the cleanup for "ungroup" *and* this new argument later.
>
> But maybe you're interested in cherry-picking & adjusting the relevant
> part of that series for this one? I.e. we're not in some post-release
> regression hurry, so rather than extending the use of this odd interface
> we could (and maybe should) just fix how we're doing it first.

I'll go ahead and give this a try. I was also a little bit surprised that
"ungroup" was set this way, but didn't realize it was for a quick fix.

>
> On the implementation:
>
> > + * If the "pipe_output" option is specified, the output will be piped
> > + * to task_finished_fn in the "struct strbuf *out" variable. The output
> > + * will still be printed unless the callback resets the strbuf. The
> > + * "pipe_output" option can be enabled by setting the global
> > + * "run_processes_parallel_pipe_output" to "1" before invoking
> > + * run_processes_parallel(), it will be set back to "0" as soon as the
> > + * API reads that setting.
>
> ...okey, but...
>
> > +static int task_finished_pipe_output(int result,
> > +                      struct strbuf *err,
> > +                      void *pp_cb,
> > +                      void *pp_task_cb)
> > +{
> > +     if (err && pipe_output) {
> > +             fprintf(stderr, "%s", err->buf);
> > +             strbuf_reset(err);
>
> ...my memory's hazy, and I haven't re-logged in any detail, but is it
> really the API interface here that the "output" callback function is
> responsible for resetting the strbuf that the API gives to it?
>
> That seems backwards to me, and e.g. a look at "start_failure" shows
> that we strbuf_reset() the "err".
>
> What's the point of doing it in the API consumer? If it doesn't do it
> we'll presumably keep accumulating output. Is there a use-case for that?
>
> Or perhaps it's not needed & this is really just misleading boilerplate?

Ultimately it is not needed -- I added it as an example to showcase that
the output is correctly being piped to "task_finished_pipe_output". The
reset is necessary in this case to prevent the output from being printed
twice. I'm not sure how exactly else I would go about testing "pipe_output".

>
> > @@ -140,6 +140,11 @@ test_expect_success 'run_command runs ungrouped in parallel with more jobs avail
> >       test_line_count = 4 err
> >  '
> >
> > +test_expect_success 'run_command runs pipe_output in parallel with more jobs available than tasks' '
> > +     test-tool run-command --pipe-output run-command-parallel 5 sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
> > +     test_cmp expect actual
> > +'
> > +
>
> Like the global argument, the copy/pasting for "ungroup" was mostly a
> matter of expediency.
>
> But at least in that case we have a different assertion (test_cmp
> v.s. test_line_count).
>
> But here this test case seems to be exactly the same as for the
> "vanilla" version.
>
> So can't we make this some:
>
>         for opt in '' '--pipe-output'
>         do
>                 test_expect_success ...
>         done
>
> ?

Yes we can -- but I may need to rethink how instead I should be testing
this option?
