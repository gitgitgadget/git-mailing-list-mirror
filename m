Return-Path: <SRS0=3Brp=4J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C33C35669
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 20:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1097A208C4
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 20:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qW1Q+Fph"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgBUUPU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Feb 2020 15:15:20 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:46908 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbgBUUPU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Feb 2020 15:15:20 -0500
Received: by mail-io1-f66.google.com with SMTP id t26so3666451ioi.13
        for <git@vger.kernel.org>; Fri, 21 Feb 2020 12:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h2zE7y/UhfgabbXzQi7d3yesmhnCOhx39eqTLEHjzh8=;
        b=qW1Q+FphvN109SCcGIZO5Y2LRd0I60LrQTcd9dCcI6djgGcpumxDU64bfSCrKRtOsx
         B6PjLSmGz+nHXlrzRHhtN0iod2oHvkpYsIKLSr2XAo6KB9lwQCvJJvHJrcrwDlJKvHIw
         dIRXTgBhee4lA1tNWC4Ar4rzNuzcawrdBROdlf7GVYjUlg1rEMblrnQHmHHvBmUk9KxK
         7eUmRVYTCWr85M8wYtJg+c+ZwtIzhA1rP5mkUr9fX+UV6QPs8K/eU28Mjw6FEQBzIP0Z
         lln8Pq0WU2bukzvO99NRWTXiQ6AnnxonSpbFIdI6X8dmrzf0nXD5EEKV6Yra17WwFZqq
         Bgkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h2zE7y/UhfgabbXzQi7d3yesmhnCOhx39eqTLEHjzh8=;
        b=m1lg9xnvguHEL+s43ZbFFWLnSehuHUPIcB44DEhq3ixG03Pligoe6q0ZhE0s4bDZKW
         IcpKYV8q4Zx6aEX4voMAWApO3xg2n3U1EXKFof/LCdqC8YEmTLQdxDLT3YljrVqcgwzd
         278wLikuzHMWlU+aJuaFY9WcskIcMWEWNjyctmo1Lg+OW9Qfzn4lq2/8p4PeY0Ywl6hn
         s+eqoQUGlZW060aKkjrjDyV82wwAXeZN/rxrkly8gB+m1wsF2TjwL6fNGO2RPpT3hZfr
         ZdLSeF+ywzJLkeTIcJr+UI3n+FsPabR8B5WhkAoUgsq20o4g1/OB2ERuOUo+iprGPBJ0
         H1VA==
X-Gm-Message-State: APjAAAWOaLSVjtp3iz4mUr6vQBvAKXHR+GS42br0nu9oElz/qRNz5+IO
        9/97LpoZNK3PgXuMgfQYJyotCwauKGpFLES81EQ=
X-Google-Smtp-Source: APXvYqwkUMsVrAgiPfxeFGxNN6rcUackYEnI6KN2F5eO2RQvdgXVHoYE2KPif+o/lb9E+nXifCVy4VMWu9ALB4xbX6U=
X-Received: by 2002:a5d:9d11:: with SMTP id j17mr1458729ioj.83.1582316119674;
 Fri, 21 Feb 2020 12:15:19 -0800 (PST)
MIME-Version: 1.0
References: <20200220214647.451064-1-kolyshkin@gmail.com> <CAHd-oW61vuuvs25iOkLJ--Wv39ZXFF87_-pV=vX=oTibRinn5Q@mail.gmail.com>
In-Reply-To: <CAHd-oW61vuuvs25iOkLJ--Wv39ZXFF87_-pV=vX=oTibRinn5Q@mail.gmail.com>
From:   Kirill Kolyshkin <kolyshkin@gmail.com>
Date:   Fri, 21 Feb 2020 12:15:08 -0800
Message-ID: <CAGmPdrwDUzk7iHYOrjPNrCJkhuJT==v5L-d_hY5gXxMLf+gFDQ@mail.gmail.com>
Subject: Re: [PATCH] completion: add diff --color-moved[-ws]
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 20 Feb 2020 at 15:30, Matheus Tavares Bernardino
<matheus.bernardino@usp.br> wrote:
>
> On Thu, Feb 20, 2020 at 6:47 PM Kir Kolyshkin <kolyshkin@gmail.com> wrote:
> >
> > These options are available since git v2.15, but somehow
> > eluded from the completion script.
> >
> > Signed-off-by: Kir Kolyshkin <kolyshkin@gmail.com>
> > ---
> >  contrib/completion/git-completion.bash | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> > index 1aac5a56c0..43cb6a312d 100644
> > --- a/contrib/completion/git-completion.bash
> > +++ b/contrib/completion/git-completion.bash
> > @@ -1487,9 +1487,16 @@ __git_diff_algorithms="myers minimal patience histogram"
> >
> >  __git_diff_submodule_formats="diff log short"
> >
> > +__git_color_moved_opts="no default plain blocks zebra dimmed-zebra"
> > +
> > +__git_color_moved_ws_opts="no ignore-space-at-eol ignore-all-space
> > +                       allow-indentation-change"
>
> I think "ignore-space-change" is missing in the above list. Besides
> that, the patch LGTM.

Thanks for catching this, I'll send v2.

>
> As a side-note: when we have an option with an already filled value,
> e.g. `--color-moved-ws=allow-identation-change,`, although it accepts
> more values as a comma separated list, pressing <tab><tab> won't
> suggest others. But I think the helper functions in
> git-completion.bash don't provide an easy way to do that right now

That's right -- as much as I want to make --key=val[,val ...] work,
there is no (easy?) way to do that :(

> (and there might even be a bug in bash-completion involving this [1]).
> So, I think the patch is good as it is (just adding the missing item
> to that list) :)
>
> [1]: https://github.com/scop/bash-completion/issues/240
