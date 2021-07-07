Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76CB9C07E96
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 02:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C61261CB6
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 02:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbhGGCQw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 22:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbhGGCQw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 22:16:52 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA620C061574
        for <git@vger.kernel.org>; Tue,  6 Jul 2021 19:14:11 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id s18so665042pgg.8
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 19:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=7BxxW4Za7bmlwSSIcFqDMacXdxUgTKJyF7bCrIAqnFk=;
        b=W88wkZMq8erZGwdEYGdf3HXp28niYbsFgIh8gSV7ouibuuQIP8TP2eqvtJkmEuEFDr
         7zTkm94mCO9JcISnhTtX2FpyFb4FCK78jv5E1/dvl7btioH7IRLsSlXVkdM9OBdK3/rF
         oXHFNnsie9iZ2uAJ1LAcjrMh17wmOUwKm4ao5jQkeai52cAwnb5+uUtETR5yARxp7Wfd
         vAEWBw+B6tEb/Qt+DofVcxMKBAcYCChjw11JThS2wvhkbN+0ButS/MkTK9F8SaMIB3kK
         XP8g3ssoawIDt90LziEJNZeeDjjPXB8lEl94AL4vrv0g0J8bnljNHjq4FjRG21nlk46L
         a/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=7BxxW4Za7bmlwSSIcFqDMacXdxUgTKJyF7bCrIAqnFk=;
        b=m+XWSEvtthEsEhzsq6FsOQprz6WYRPK0AinRFEXxOZqGFymztmHSYHS4mJNPDj4yC7
         SABGwAM6dOzk08gR974AuktiyGxsjwUGQzzvL7HuefclzVfUlyaqFgH1kshq6wVd+Ztn
         0iej9dgGCaA8RNEFvjblYiTNvHYmHw9JjgjNHnI3CXeohf/4EvmvA1y4HRyAAwhz9lH2
         hn1xwcbofOYMPBS5dxE1biAJd1d6chWxJUdBS6cx4ECcH5tqcb75l+2RLZxeXff2OVog
         +FMKPajVUNrkEh+7/ucZqmIOn0SaDJGh8ThdLsdG6ALERuEvx0fL1R9ZjZxJajB8JmTi
         k1jg==
X-Gm-Message-State: AOAM532LMXE5K4l2Fj76HDSMk4oyS7gIma4nuIV/0RNdwsi0RWdrZyUq
        lCCdXhEIPJX+0ykrAGKEDfkbT4xnXsCL8No2ZCGQxT38x6g=
X-Google-Smtp-Source: ABdhPJylbZAuzWrW6XOj6Svn9IsX0wFIPv5cH0wEaeWOsDHv5HiZZ+xy04X69WRDMYZWLdyjvo4GUmaAATJimkfw7R0=
X-Received: by 2002:aa7:820d:0:b029:2f1:d22d:f21d with SMTP id
 k13-20020aa7820d0000b02902f1d22df21dmr23146471pfi.7.1625624051048; Tue, 06
 Jul 2021 19:14:11 -0700 (PDT)
MIME-Version: 1.0
References: <CADrEZfE+LuDnhWkRHPMwHq7aGYcvDeqken8uZzPgHREtf0iqjA@mail.gmail.com>
 <xmqqczrugahy.fsf@gitster.g> <CADrEZfGHAi=Lr6QMsJbXGy1Rs9VDzTVxQPNH4xHHj6ataEAvVA@mail.gmail.com>
 <CADrEZfHJZT47nNZJ8v2T4vOJkMN7ccaai6DKdzFLF8Zoc42hWw@mail.gmail.com>
In-Reply-To: <CADrEZfHJZT47nNZJ8v2T4vOJkMN7ccaai6DKdzFLF8Zoc42hWw@mail.gmail.com>
From:   Aaron Hall <aaronchallmba@gmail.com>
Date:   Tue, 6 Jul 2021 22:13:34 -0400
Message-ID: <CADrEZfEVbtbovTbFM2BEuK_cWp4jcV3CZyrzasvsvFbuu1rmWg@mail.gmail.com>
Subject: Re: Default ssh command
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> When we use ssh to run the receive-pack over the wire while pushing,
> we do not ask for pty, and because the "-e" option to set the escape
> character is meaningful only when ssh runs with pty allocated, you
> shouldn't have to do this, unless you force pty allocation by
> e.g. passing "-t" yourself.

Then I wonder why I'm getting a pseudoterminal.

Note that I'm using git from git bash on Windows in a walled off
corporate environment.

The ssh manpage says:

> If no pseudo-terminal has been allocated, the session is transparent
> and can be used to reliably transfer binary data.  On most
> systems, setting the escape character to ``none'' will also
> make the session transparent even if a tty is used.

If we want the ssh to be binary transparent regardless
(and I think we do) then that makes my suggestion,
`ssh -e none`, still perhaps a good one?

On Tue, Jul 6, 2021 at 10:03 PM Aaron Hall <aaronchallmba@gmail.com> wrote:
>
> I'll reply on list.
>
> On Tue, Jul 6, 2021 at 9:58 PM Aaron Hall <aaronchallmba@gmail.com> wrote:
> >
> > My context is using git from git bash on Windows in a walled off environment.
> >
> > On Tue, Jul 6, 2021 at 9:48 PM Junio C Hamano <gitster@pobox.com> wrote:
> > >
> > > Aaron Hall <aaronchallmba@gmail.com> writes:
> > >
> > > > I was trying to push some binary files (PNGs) over ssh and found some
> > > > files inexplicably wouldn't successfully push.
> > > >
> > > > I set, in my .gitconfig file:
> > > >
> > > > [core]
> > > >         sshCommand = ssh -e none
> > > >
> > > > And it works now for all files (that I can tell).
> > > >
> > > > From a close examination of the output where I noted escape codes
> > > > showing up, I believe the problem to be ssh escape codes.
> > > >
> > > > `\n~.` for example closes the ssh client.
> > > >
> > > > Therefore I think the default ssh command should be `ssh -e none`
> > > > instead of `ssh` for the benefit of users who won't recognize the
> > > > problem, unless `git` is expected to make use of ssh escape codes.
> > >
> > > Curious.
> > >
> > > When we use ssh to run the receive-pack over the wire while pushing,
> > > we do not ask for pty, and because the "-e" option to set the escape
> > > character is meaningful only when ssh runs with pty allocated, you
> > > shouldn't have to do this, unless you force pty allocation by
> > > e.g. passing "-t" yourself.
