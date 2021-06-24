Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D2FC49EA5
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 22:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45575610A0
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 22:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbhFXWeI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 18:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbhFXWeI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 18:34:08 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FED4C061574
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 15:31:47 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id i5so10815272eds.1
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 15:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=ab3/T2PfAs/qjB2KLA8xY34pwK/J+1LgtDUjEh6UVRk=;
        b=uByng7LQz16KluzQjtm6SY3klXxraBEheqyb4UJdpGOhtY9RAHlAPio+iO+J96g4Bt
         aDuSZKa8llBN+eLoNScOTouCoAOaUOExDVZwhoHfpdzGfilxUWvgFKLDlE3kg1FTavmA
         qiBWb+suKwoUDCS3NgGTvosNBLqq/fmx/RG4SONIsk4RGCnV2xz8ekVzKOI7c6kXS9KB
         nzQvRIrxaK4Soe8qLiB2kPB74CBpppgIfATejWk5cpPdd6XK4Ld7gnOpwKm4CnuEKrRJ
         zB6N+Q6i/u/1T2M8kTo0owi8TCh253ve89SI10rvYqnKWcodze+Y/HvMaw6p+0aJ7yKC
         a61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=ab3/T2PfAs/qjB2KLA8xY34pwK/J+1LgtDUjEh6UVRk=;
        b=hZ3Y1MaN2Xz88l0XNeD7X9Ykqhy2okzzbz61hna5Lf2BIyFdoW+8Fe4/j9Tb5HTHuk
         h6MR5jtBixEBVFXeWZ0Xi6QK6JykyZnMMz9pPY3n7fzzN00n7v4KPzpvBs+ABnM7bag8
         LqLmtYjihU3MxYUjo9QSwVzuV+wobBM4QYzfc8I38mL1aDekh2756VL8nSaQRKF8CcA4
         AGgTK+g2aoyz/xyz0aLLu8Q7umPm/71fZ3tTu3hGh1LLfHtdR2CGiGxe4xXbe8JtSf2F
         XyQ6YhGHSd2gcFSmb7JE717hIr2erdQCPDG48/TiyUsEqOwRIGJyBXUE+hZMS9PTuqs0
         wf/Q==
X-Gm-Message-State: AOAM530VWpYx5awqnHdvYKmn92KT3KjttcCDXLZ5iamwL9Qzw6MjZLjf
        j9GqX3x7UugEAkf08mNab2M=
X-Google-Smtp-Source: ABdhPJx2ppojyLydLbZ65SgkvpfcY56OyZ8Z079iAWO/PibPWBwW7A0I0yqxYNx9th0b03YJyYckzQ==
X-Received: by 2002:aa7:dc0a:: with SMTP id b10mr10279574edu.134.1624573905711;
        Thu, 24 Jun 2021 15:31:45 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id n13sm2697829edx.30.2021.06.24.15.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 15:31:45 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Avishay Matayev <me@avishay.dev>
Cc:     phillip.wood@dunelm.org.uk, git@vger.kernel.org, gitster@pobox.com
Subject: Re: Forcing git to use a pager without a tty
Date:   Fri, 25 Jun 2021 00:10:49 +0200
References: <CAJ-0OswsrnAuCwU6U=S2i1qKkg=66U-8RHSGqD2kh9T_30Yw9w@mail.gmail.com>
 <077d147c-c22f-6463-6545-3aa991e7868b@gmail.com>
 <b5462f20-5d9d-4775-ad5c-c8de686167af@gmail.com>
 <CAJ-0Osy9JhGD0=6eF3jgZuoHJEzymksCWZZZC+A4FtHxzOrdhA@mail.gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.12
In-reply-to: <CAJ-0Osy9JhGD0=6eF3jgZuoHJEzymksCWZZZC+A4FtHxzOrdhA@mail.gmail.com>
Message-ID: <87pmwazygf.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 24 2021, Avishay Matayev wrote:

It's interesting that your original mail didn't end up in our main
archive:
https://lore.kernel.org/git/CAJ-0OswsrnAuCwU6U=S2i1qKkg=66U-8RHSGqD2kh9T_30Yw9w@mail.gmail.com/,
but e.g. marc.info has it (and it's in my mailbox):
https://marc.info/?l=git&m=162440160200930

> On Wed, 23 Jun 2021 at 12:29, Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> On 23/06/2021 10:05, Phillip Wood wrote:
>> > Hi Avishay
>> >
>> > On 22/06/2021 23:40, Avishay Matayev wrote:
>> >> Hi there!
>> >>
>> >> Fugitive[1] is a vim plugin that wraps git and many of its commands
>> >> into the editor in a really awesome way, I won't meddle into it too
>> >> much as you can read about it in its README, but as you understand, it
>> >> uses git, a lot.
>> >>
>> >> Some git commands use a pager, which is usually a program that needs a
>> >> pty to function properly (`less`, for example). Fugitive can't really
>> >> use a pty for the pager as vim runs its subprocesses without a pty.
>> >> Therefore Fugitive just creates its own pager (which is a simple
>> >> window in vim) and pastes the git command output there.
>> >
>> > If I understand correctly fugitive is reading the output of the git
>> > command over a pipe and putting it into a vim buffer?
>> >
> AFAIK, no. It could read the output through vim's jobstart API (that calls a
> callback when there's activity on stdout for example) or by
> redirecting the output
> to a temporary file and reading it.

...

>> >> The only problem left is that Fugitive can't reliably know when git
>> >> decides to use the pager, for example `git reflog show` does raise the
>> >> pager while `git reflog expire` does not. Fugitive currently maintains
>> >> an (very possibly) incomplete list of commands that need a pager but
>> >> maintaining it manually isn't ideal.
>> >
>> > I don't understand, if as you say above there isn't a pty then git wont
>> > use a pager unless GIT_PAGER_IN_USE is set which Fugitive does not seem
>> > to,
>>
>> Sorry that is confused. GIT_PAGER_IN_USE only causes git to act as if a
>> pager is being used (for example so it colors things as if it was
>> outputting to a tty), it does not invoke the pager
>>
>>   so I'm not sure what you mean by 'Fugitive can't reliably know when
>> > git decides to use the pager'
>>
>> I'm still confused by this - if there is no tty git wont use a pager.
>>
> That's the problem, git doesn't tell whoever calls it if it is going
> to use the pager,
> and that information is useful for Fugitive. Why? Because even if
> fugitive just naively
> reads git's output, it doesn't know whether it needs to open a pager.
>
> i.e If the user calls `git log`, the log is printed through the pager.
> However, if a user
> calls the exact same command through Fugitive. Fugitive needs to know
> ahead if the
> resulting command is going to need a pager (AKA a new window in vim) and prepare
> accordingly. However, since git does not tell us when it's going to
> open a page, we
> have to book-keep commands and whether they are going to use the pager or not.

Having read this thread it feels as though there's a missing description
between the 2nd and 3rd paragraphs of your original mail.

I.e. you never really explicitly said what you're going to use this for,
and why it's needed, but I think I get it now.

The "straighforward" thing to do would be to just capture stderr/stdout,
which is what e.g. Magit does, which I gather is a similar thing to this
"Fugitive" thing, except for Emacs (I use Magit heavily, I've only spent
~5m browsing the Fugitive page for the first time, skipping through a
couple of screencasts).

But what you're doing in this editor plugin is assigning semantic
importance to if and when git uses a pager. If it would you open a
dedicated window with the output, if it doesn't you presumably show it
differently, just the exit code, in some "raw git output" buffer or
something?

> 1. https://github.com/tpope/vim-fugitive/blob/79e2bd381ad6e7f3d70ce4a8ec9f3f107b40f053/autoload/fugitive.vim#L2951-L2956
>
> This is the current proposal:
>
> --- a/pager.c
> +++ b/pager.c
> @@ -45,7 +45,8 @@ const char *git_pager(int stdout_is_tty)
>  {
>         const char *pager;
>
> -       if (!stdout_is_tty)
> +
> +       if (!stdout_is_tty && !(is_terminal_dumb() &&
> git_env_bool("GIT_FORCE_TTY_DUMB", 0)))
>                 return NULL;
>
>         pager = getenv("GIT_PAGER");

So yes, I could see how this would be useful, and FWIW I've got nothing
against such a thing, it just took me a while to understand what you
were going for, and maybe I still don't get it.

I will say that I think this approach is /probably/ not a very fruitful
one in the longer term for an editor plugin.

E.g. in Magit everything we'd invoke a pager for such as "log", "blame"
etc. is a dedicated top-level command, Magit heavily modifies the UI, so
e.g. for the "log" equivalent you can "click" on commits, fold them and
their diffs etc.

So "does it use a pager?" nonwithstanding I'd think any sufficiently
mature editor plugin would end up having to maintain its own list of
"this is an interesting command, and this is how I make use of its
anyway. So the equivalent of piping what we'd send to the pager to
another FD (or setting a flag or whatever) wouldn't be very useful in
the end.

But hey, if it works for you why not :)

What do you do about things like "git status" etc. that produce a lot of
output, but don't invoke the pager even then (but perhaps should), ditto
for all the plumbing or plumbing-like such as "ls-files", "ls-tree" etc?

