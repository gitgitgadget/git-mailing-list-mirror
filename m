Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1882CD8C9E
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 14:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233262AbjJJO60 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 10:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233254AbjJJO6Z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 10:58:25 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064E5CC
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 07:58:24 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-534694a9f26so32423a12.1
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 07:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696949902; x=1697554702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dm59/v1Vlv2AJEO8Ytb3MWvek5YVPZBM9jzWVgUB11Y=;
        b=3VT/PyoBcxwqVMaxJBibSkihbQkVorKtmA9u7xel9jAfbi0NsmEAFyrb6b9f7a2ZiW
         dpNvjgsd8XWJ22oD8H5Im1WAZUKUmFWpXTjAerq66A/+9KvDnyxAOJYpU/LW2EvEaEqP
         ghFBy41XSYd+h2MAO73KxeL6jhkCk9Whdm4rqEDJgpz7PXuzqqOqJ4x7SGi1id7jJG4Z
         Lgp0IKvKHniUnAXJTxgR7WiYwU4q7ZpFjEZzqD07Swt2074/Eyjcfw5qMN/NQSk+4kAT
         xwHAZsK8fdP35CCUUgbccr3a/1AkdnYTUtBNHKwh7LYSHdcdqbIaYZB0b9Oi679trf5z
         pqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696949902; x=1697554702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dm59/v1Vlv2AJEO8Ytb3MWvek5YVPZBM9jzWVgUB11Y=;
        b=m+BiOlgcFGlJvJVF1g1663VOMjI4aWCqkGaLKTnCqf1AHFAo3dMpmRYlJNs+FXn1S7
         uwb6qrzXiWkSkasTeCWUHcVOelDFIc8fIGlGgeqnaghxfunsEC7aYwOox3SXhTohvglU
         5yh4CPsSqIyg4w549xJSQGWRc1kAVCTTsUiTXuQ0FbkgTGkRWwwp9kGTBt43q690n45B
         4HJjHPi1AiduQmd/pma5yHfMR5COzcPLfaX+5bDXoJFpigxbuvWGpGLwX6qjHlIwlEYM
         LF94ZVlSoIQjsw6JuASnK2v0elWhwkJLKRX+PDZ9kV0Mpy22Ah9esNrNdvffQjtU5I0D
         FhPw==
X-Gm-Message-State: AOJu0Yzgl5irg9n+u+1y95n5EGT2tVvBh/qU11fMsZzOliifHheYcont
        aekeaJy0rN/49eBnpTpPDJvtXGWDb+xzkIBgWIcRww==
X-Google-Smtp-Source: AGHT+IHqF83gARLG72Aj/fAfxBOqRcaFeE5HV31Ci9XQL7RDTyIuMsMzyrATPXUeGPAX2EJ/KIEvlJnU09a5qPuEJRw=
X-Received: by 2002:a50:c051:0:b0:538:1d3a:d704 with SMTP id
 u17-20020a50c051000000b005381d3ad704mr552229edd.1.1696949902339; Tue, 10 Oct
 2023 07:58:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230909125446.142715-1-sorganov@gmail.com> <20231004214558.210339-1-sorganov@gmail.com>
 <20231004214558.210339-2-sorganov@gmail.com> <xmqq34yog3ux.fsf@gitster.g>
 <CABPp-BFsrt0zS3NHsVAyOSW6vGioe8Z-iN2M3_JNBpP2fWVq9g@mail.gmail.com> <xmqqo7h7urgd.fsf@gitster.g>
In-Reply-To: <xmqqo7h7urgd.fsf@gitster.g>
From:   Emily Shaffer <nasamuffin@google.com>
Date:   Tue, 10 Oct 2023 07:58:06 -0700
Message-ID: <CAJoAoZk+RjPWrSUyTLoP_La216Se_tgvBpri-zOZntFzUh4_1g@mail.gmail.com>
Subject: Re: [silly] worldview documents?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 9, 2023 at 7:44=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> >> [Footnote]
> >> ...
> >
> > Thanks for writing this up.  In the past, I didn't know how to put
> > into words why I didn't particularly care for this mode.  You explain
> > it rather well.
>
> I am glad it helped non-zero number of people.
>
> It probably owes big to my failing, but because we strongly view it
> a virtue not to be opinionated, we have many discrete tools and
> features that can be used in combination to support a workflow well,
> even when some of these tools and features are not useful for a
> different workflow.  It indeed is a good thing to be flexible and to
> support different workflows well, and we tend not to single out a
> workflow among many and advocate it, but because our documentation
> lacks description of major possible workflows, what their underlying
> philosophies and their strengths are, how some of our tools and
> features support them, and why some others are not good fit.  Being
> given a toolbox with too many tools without being taught how they
> are to be used together and for what purpose may be a fun puzzle to
> figure out for tinkerers, but when you have a problem to solve and
> tinkering is not your main focus, which is true for most people, it
> is not fun.
>
> In short, in pursuit of not to be opinionated, we fail to give the
> readers best current practices.  The first place to start rectifying
> it might be to have some write-ups for various major workflows and
> the worldview behind them.

I completely agree with you. The #1 conversation I have with friends
who are new to Git is figuring out which of the major workflows they
should use, and what are the drawbacks and benefits. And how to
diagnose based on the existing commit history, review tool in use, etc
which one is used by their peers. Having this documented somewhere -
maybe in Pro Git book, maybe in manpage - would be hugely useful. I
could envision a diagram of a sample commit history, and "if it
already looks like this or you want it to look like this, your
workflow should be blah" and finally a list of some drawbacks,
benefits, and warnings about what to avoid in that workflow. Plus,
perhaps, many shout-outs to `git reflog` for fixing when you
misunderstood and made a mess. (that's the #2 conversation I have :) )

> The importance given to first-parenthood
> offers two quite different worldviews that affects the choice of
> tools (e.g. "merge --no-ff", "checkout origin/master && merge mine
> && branch -f mine" aka "reverse merge").
>
> I suspect that this also relates to your "would --cc be totally
> unnecessary now we have --remerge-diff?" as well.  What kind of
> conflicts are interesting highly depends on what you are looking
> for, which in turn is influenced by the workflow employed by the
> project and what role you are playing in it.
