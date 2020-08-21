Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C910DC433E1
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 20:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A07B720724
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 20:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgHUUwr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 16:52:47 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:40423 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgHUUwq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 16:52:46 -0400
Received: by mail-ej1-f67.google.com with SMTP id o18so3963930eje.7
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 13:52:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GqTOHQQTCHhyQkUOJ3wooHSonAvOkOTzktbjTgblRHw=;
        b=pqcz4N9Din0+9Mx9YF4TxFwn8LJ+CYU1WgBzWkNtCROcbHdGQU1FJ031VOb29UkFiJ
         93jqq5KKjFgYk038SiJ4oZ3tf/VUQW7xBMTHY/Jz/29LDxpy7Hk54U55EwwW4LgsVKyL
         84VCX8hiw02qwVNxlu96QDzumBBMhxs8KyUSZgok2wTtgDvlWh5gRSaT62vDoR8WvcwU
         PtIIECh7gfQv0geK6hWphrPMjFJi57OdutDvN4546JriC7yHLcTsrqv7zrJ2TG1klAzv
         TolQg2PCLmuaPVfbH4a0RqbAyp9daO+CG5XkoBR72c8Lt4Lw2MOnzWGSXmUv4y+QX7QV
         /7rg==
X-Gm-Message-State: AOAM532y+5WOoqwyJf3AgTu7mEtemUVZISIAeR7GRgaf8ttR0HNgb4xm
        cHGiucyGIef+MQaKIl8AKNlCLEowdrsUTqW6uFY=
X-Google-Smtp-Source: ABdhPJw99jXAYNpRhrCVVEhZKsmbqfrPaCJPJXEbrrit01Fht45ssJvBkWq6tAq58Nko8RvU/LRWrZDONL2ScPQ05vI=
X-Received: by 2002:a17:906:a1cf:: with SMTP id bx15mr4427548ejb.231.1598043163869;
 Fri, 21 Aug 2020 13:52:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAOW=8D2J3t3cE32q2xNqSOPTa6gxR5gSuJUCCj5MSj58ccc3Cg@mail.gmail.com>
 <87ft8fvoow.fsf@igel.home> <xmqqr1rz96ry.fsf@gitster.c.googlers.com>
 <CAOW=8D3WZyoc=PpyzmPRYM2MT_=F4tnuTxJ0Z+_dHMb4Xk8imQ@mail.gmail.com> <xmqq5z9b91o3.fsf_-_@gitster.c.googlers.com>
In-Reply-To: <xmqq5z9b91o3.fsf_-_@gitster.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 21 Aug 2020 16:52:33 -0400
Message-ID: <CAPig+cR12i8KQjiWYm8DGuAc9BfJqanmNBZcZfwHGsrt2hW3Dw@mail.gmail.com>
Subject: Re: [PATCH] ident: say whose identity is missing when giving
 user.name hint
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Alvaro Aleman <aaleman@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 21, 2020 at 4:36 PM Junio C Hamano <gitster@pobox.com> wrote:
> When the author or the committer identity is missing when required,
> "git" errors out with a message that suggests to set these
> configuration variables at the per-user level as the easiest way
> forward.  This message is given to a brand-new user, whose
> ~/.gitconfig hasn't been configured for user.name and user.email,
> who runs "git commit --author=...", too, but such a user may find it
> confusing ("why?  I just gave you a name and e-mail").
>
> State whose identity is missing as the reason why we are erroring
> out, when we give the hint, to help reduce the confusion.

I had trouble following the first paragraph due to the run-on nature
of the second sentence. Perhaps the entire message could be rewritten
something like this:

    If `user.name` and `user.email` have not been configured and the
    user invokes:

        git commit --author=...

    without without specifying `--committer=`, then Git errors out
    with a message asking the user to configure `user.name` and
    `user.email` but doesn't tell the user which attribution was
    missing. This can be confusing for a user new to Git who isn't
    aware of the distinction between user, author, and committer.
    Give such users a bit more help by extending the error message to
    also say which attribution is expected.
