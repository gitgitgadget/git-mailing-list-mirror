Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F92FC4363A
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 07:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A7DE2225F
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 07:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJjljm98"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440881AbgJUHPA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 03:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440878AbgJUHPA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 03:15:00 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED48EC0613CE
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 00:14:59 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id w25so301416oos.10
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 00:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=83IXP6+cWQEsavCgo3Cqw8wP16z8m+/o4ydXWPqYILU=;
        b=RJjljm98ez7X6LVQXjG0YEhwPmPKoHuZD/qmNoczwJUbBMtBMZ0rQDjcNqpTZHelxX
         i6hi9P32uCpwYfZK+fGANzLCGNrs75Wo4H4AAYHPC/m5sHgtHahiBXY0oN4KkjXZ8yN/
         aiHGtMKU6GflegoCebF2pt9rooBn5aLuF5UucDQR9JjMER6AcndHJkLSskyYo/hdhCmg
         yeVG3qBdjdAeV6JSisqNpgKuNT+Fnl6PhTV8inK3TFhs63rhH8z/k1wZARl+OEnDtMOI
         SoVJu3GbMjqS8Jfg1Vu2koPnAPM3Cwhq7cDL69o/9eK+wtN9ODKQ+1gFxJrEcIaEy0Vt
         W+6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=83IXP6+cWQEsavCgo3Cqw8wP16z8m+/o4ydXWPqYILU=;
        b=jBDCpsygR1PILFfKdiC67fwzXkciEQoKA6ObGObrSwqZdU2ycv5b6aD0cRr7NgGGAF
         aa2WcWuKZeb4lSHqUDO+HXuyNnRUx0M7lfL5ER94awIMBishueRTG6+HTF1JoImlB3th
         r7Gh2u81ZElSZ30duzi69rsJdQ9gkvCqjiox3Lf2OMaFEqyJkPkwQSNvMzkuV1kF10/d
         IuxuJoPcpg0q+a/PHGfnCDcFz0mI08Tof7s5/CztrkiPru2/n9vA0DdiZV4SErQeX6fy
         L8cN3NoalBQwwEsPoEMPvfwIsFGsyXGhiNBaMo7gTab/aSx/t4TGSPGFWLlPXSm1mHRN
         VMjA==
X-Gm-Message-State: AOAM531Eoyek5EvlVYqH/6tofHTuTkXXmGeiDrpcGbi+t1O7ssFbFkxK
        icXHXUMpgdmRPufMpq4yG4x2f2Rl7b2q1BeZ6ac=
X-Google-Smtp-Source: ABdhPJz7YcFbGKiMIRoVBKUyls5AtKZFnqDm7CkLg9ePeKCGFnRZYyJbuVm5EByZRJSgbF3Lz7WQJLkIObe6W9e8SA4=
X-Received: by 2002:a4a:ba10:: with SMTP id b16mr1414723oop.75.1603264499102;
 Wed, 21 Oct 2020 00:14:59 -0700 (PDT)
MIME-Version: 1.0
References: <20201017075455.9660-1-charvi077@gmail.com> <20201020121152.21645-1-charvi077@gmail.com>
 <xmqqa6wgbqpq.fsf@gitster.c.googlers.com> <20201020201535.GB75186@nand.local>
 <xmqq1rhsbq6a.fsf@gitster.c.googlers.com> <20201020203024.GC75186@nand.local>
In-Reply-To: <20201020203024.GC75186@nand.local>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Wed, 21 Oct 2020 12:44:47 +0530
Message-ID: <CAPSFM5fQJWk5kqgaCytTZMOQDbKzCDArq0ano9ovAWVpToQAHQ@mail.gmail.com>
Subject: Re: [PATCH v4] t7201: put each command on a separate line
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        phillip.wood123@gmail.com,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 21 Oct 2020 at 02:00, Taylor Blau <me@ttaylorr.com> wrote:
>
> On Tue, Oct 20, 2020 at 01:25:33PM -0700, Junio C Hamano wrote:
> > Taylor Blau <me@ttaylorr.com> writes:
> > > When I applied this locally, I used this patch as a replacement for the
> > > last patch of v3 [1]. That kept everything passing after each patch.
> >
> > Oh, so this is a replacement for 5/5 and 1-4/5 of v4 are supposed to
> > be identical to those from v3?  The difference between [v3 5/5] and
> > this one is a single typofix on the subject line, it seems, though.
>
> Yes, at least that's what I interpreted it as (and how I applied it when
> testing). I'd like to hear from the author to make sure.
>

I think I messed up the versions. Its correct that v4 patch was only
replacement for 5/5 (5th patch) of v3, since I need  to fix the typo
error of subject line. Also, other 4 patches (1-4/5) of v3 need to be
remain same in v4.

> (As an aside to the author, I often fall into the trap of thinking that
> it will be easier to send a single replacement patch which will generate
> less email, but--as you can see--it is often more complicated for
> reviewers and the maintainer to decipher what's going on. It's often
> just easier to re-submit the entire series and include in your cover
> letter "this is unchanged from v(n-1) except for ...").
>

Yes I realized this, actually earlier I was doubtful about whether to include
the previous version's correct patches in the new version or not. I might
have confirmed this before sending. But now I will strictly follow this .

Thanks a lot to Junio and Taylor for pointing this out. And in order to
correct this, I will send the new patch series having (v3 1-4/5]+[v4]).

Please correct me, if I missed out anything else.

> > >> As you've demonstrated through the microproject that you can now
> > >> comfortably be involved in the review discussion, I am tempted to
> > >> suggest that we declare victory at this point and move on, but I
> > >> don't know what the plans are for the other 4 patches (I guess we
> > >> won't miss them that much---the micros are meant to be practice
> > >> targets).
> > >
> > > Yup, ditto.
> >
> > As [v4] single patch won't apply standalone, we cannot quite declare
> > the victory yet.  Are [v3 1-5/5] (or [v3 1-4/5] + [v4]) good to the
> > reviewers of the past rounds?
>
> For what it's worth, I'm happy with [v3 1-4/5] + [v4].
>
> Thanks,
> Taylor

Thanks and Regards,
Charvi
