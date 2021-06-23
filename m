Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5734AC4743C
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 08:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3305160241
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 08:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbhFWI1b (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 04:27:31 -0400
Received: from mail-qt1-f175.google.com ([209.85.160.175]:39911 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbhFWI1a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 04:27:30 -0400
Received: by mail-qt1-f175.google.com with SMTP id b3so781666qtq.6
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 01:25:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3WtPn6psLzbatz1p0e4QiytnP+MsVQpeZqVCm1ORMgY=;
        b=BKVpAZJ8ANdUEtRjna/eiF7hG8n1xNHfGS5Of8wb70lEy85/c+kVXJSdkTIW6RNxfe
         6xXoQBTfXiq3BTR6uI5REJQ5rQGYEErPpCPOW/zW7BBHYSpu5Un486bNBdikfIDi51Vb
         p+YfL2evfIyMhAqj2GEwo6qIoq8gMsWjn0Q5TCt51ZnbE9kQ6vwxWOoFIDeyPbn7zHl7
         MIKh4B5NK/ImuIPsPW+pJd5WEghtMhV+Q2iXjko+S7DxGPhwtgsHFGBMMrmzrg4yMRdy
         +fIT/ElUrahjDJ3n0jAmxrwJ6JH21JPM+XvWQIJWFlYX9PAqCadjYTqIOl3iNStfLjLR
         5nWg==
X-Gm-Message-State: AOAM531iRiM2CIG9kV1UC9CltuC9Yp3duhl9cTjiV98aQYboAH2++viN
        DM+XT+A47dPvm/jO+lYE/55ZpegEf28p48Jo
X-Google-Smtp-Source: ABdhPJwVV98gJVtwzQiOwyd+R4yJ6Hfev+3LUPxUFa5y5LbWbRAvI4rPf61cOykzwXzi5uN3sDgziA==
X-Received: by 2002:ac8:65d7:: with SMTP id t23mr2706308qto.311.1624436712185;
        Wed, 23 Jun 2021 01:25:12 -0700 (PDT)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com. [209.85.222.176])
        by smtp.gmail.com with ESMTPSA id a19sm2597549qtb.54.2021.06.23.01.25.11
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jun 2021 01:25:11 -0700 (PDT)
Received: by mail-qk1-f176.google.com with SMTP id c23so3061017qkc.10
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 01:25:11 -0700 (PDT)
X-Received: by 2002:ae9:edc2:: with SMTP id c185mr8939376qkg.144.1624436711613;
 Wed, 23 Jun 2021 01:25:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ-0OswsrnAuCwU6U=S2i1qKkg=66U-8RHSGqD2kh9T_30Yw9w@mail.gmail.com>
 <60d294eb984ba_3122081@natae.notmuch>
In-Reply-To: <60d294eb984ba_3122081@natae.notmuch>
From:   Avishay Matayev <me@avishay.dev>
Date:   Wed, 23 Jun 2021 11:25:00 +0300
X-Gmail-Original-Message-ID: <CAJ-0Oswry0Rry_0ZqZzzVGuzfU-apZnv95LcxQEhm7GVA=uOxA@mail.gmail.com>
Message-ID: <CAJ-0Oswry0Rry_0ZqZzzVGuzfU-apZnv95LcxQEhm7GVA=uOxA@mail.gmail.com>
Subject: Re: Forcing git to use a pager without a tty
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 23 Jun 2021 at 04:57, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> Avishay Matayev wrote:
>
> > Some git commands use a pager, which is usually a program that needs a
> > pty to function properly (`less`, for example). Fugitive can't really
> > use a pty for the pager as vim runs its subprocesses without a pty.
> > Therefore Fugitive just creates its own pager (which is a simple
> > window in vim) and pastes the git command output there.
>
> That's not necessarily true; vim uses a bunch of convoluted logic to
> sometimes use a pty, but that depends on the mode used (graphical vs.
> console), and a bunch of other things.
>
> Even more complicated when you throw nvim into the mix.
>
> But yeah, for the sake of simplication let's say that's true.

True, I did oversimplify.

> > We had some ideas how to make this feasible (as you can read on the
> > thread) but for brevity's sake I'll present the best (IMO) idea:
> > Essentially, at `pager.c`, don't short-circuit in `git_pager` (or
> > `setup_pager`?) due to pty absence if a new environment variable is
> > present, perhaps something like `GIT_PAGER_FORCE` which will override
> > the `PAGER` and `GIT_PAGER` variables. This will allow Fugitive to
> > apply custom logic through to pager to know if one exists and present
> > the window in vim.
>
> Seems like a completely sensible request to me, except I would do it a
> slightly different place:
>
> --- a/pager.c
> +++ b/pager.c
> @@ -101,7 +101,7 @@ void prepare_pager_args(struct child_process *pager_process, const char *pager)
>
>  void setup_pager(void)
>  {
> -       const char *pager = git_pager(isatty(1));
> +       const char *pager = git_pager(git_env_bool("GIT_PAGER_FORCE", isatty(1)));
>
>         if (!pager)
>                 return;
>
> I'm Cc'ing Jonathan Nieder who seems to have toched these lines.
>
> Cheers.
>
> --
> Felipe Contreras

Well I'm glad to hear you find it sensible, though your patch suggests
that `GIT_PAGER_FORCE` will be a boolean, while I expect it to be an
actual pager, which would make more sense IMO.

Avishay
