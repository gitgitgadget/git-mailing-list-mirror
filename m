Return-Path: <SRS0=S8Id=BG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32C3C433E8
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 15:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA92E20775
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 15:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="xTJ7DpoI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730002AbgG0PK0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jul 2020 11:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728845AbgG0PK0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jul 2020 11:10:26 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46554C061794
        for <git@vger.kernel.org>; Mon, 27 Jul 2020 08:10:26 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id a19so1600759qvy.3
        for <git@vger.kernel.org>; Mon, 27 Jul 2020 08:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/dP3nPtu18Raw44+kkUrokGSoOrQgF65uSy0pYaCvq8=;
        b=xTJ7DpoIfZPrdde946kt8ZYQ+akDm+I1J29FMV7N3mNU+49j1Kbkm4kgO5NhXlOZA0
         ty1lOT8YdP5giA+yxD4G87beBDV8vKp5soM4C/8EqhIydyYtjf81rpHzYPKahhdieomH
         inKcSwlq75PsQPzrhhqkn1Y4D160WVduCRfBBbwhWiS0iD5RHGC2OK03gG8Xny2fCtVg
         bxPMd+h+QM7N/wCS1pQx5x3ILuOGPqAwAbGYEqN665xJc5QyFyANdy6/P/7EL3MD3ojH
         4mHMPH+rfogKwOjXkatria8jKMdhMYDJWdWDRE8M+Q+NuE1j9PfYpx/aKg+aHq8OfQIL
         Yjgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/dP3nPtu18Raw44+kkUrokGSoOrQgF65uSy0pYaCvq8=;
        b=a2d2wOw/HtrDiSAoy75xP9ckEuSnbFKG6eWOEcHGbY1ax52ciOvdszqlk6pL4SF7wP
         +P0TuRL2G/ihPvMAgOmNZgJLkfYZObbPr3dFViF3vwaQEdwtRJqVpE16KzTK+50oQQgW
         CDuE3ky3h9xXYhSG0zzF6uh+EmIC5KzqYDrZajBq40sJdZ5xf5AA9gct6V73TlSUwH9G
         HCBBoqJzaDxH2WLmLPg/iJpY0xB6IN/ySv/z6sVfPij0WH5VtNZEbfZfn9WrCVGJWSnw
         5o2g1FfukSk37G5yedDnuT7mXG76vqJkuIa4MR4K5+DjG+XelzHpUm6cUhPbwtlW+vrI
         rp8A==
X-Gm-Message-State: AOAM5330vazV+etJWZLhgpkD1nG7kiH2kowAuf+W/8j44437P66OQrhk
        FiHNDQxUVPiL+eI+a1G5IcHeDQ==
X-Google-Smtp-Source: ABdhPJyBTPBuQzisJxlzGn+8vIvgcIwygwOS3UB7P2FaspUUoYeNPd+3nLjKzFMERmr29pkBnrcI3Q==
X-Received: by 2002:a0c:e641:: with SMTP id c1mr1872465qvn.121.1595862625221;
        Mon, 27 Jul 2020 08:10:25 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:9c58:8530:481a:f835])
        by smtp.gmail.com with ESMTPSA id o187sm17672253qkd.112.2020.07.27.08.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 08:10:24 -0700 (PDT)
Date:   Mon, 27 Jul 2020 11:10:23 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Eric Wong <e@80x24.org>
Cc:     Carmen Andoh <candoh@google.com>, git@vger.kernel.org,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Git Inclusion Summit
Message-ID: <20200727151023.GB62919@syl.lan>
References: <CA+TwhoKBYwUKmtQTyiocPWJD=KeZQryS+6Q8JKxKgLEy0qJwAw@mail.gmail.com>
 <20200726040226.GA19030@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200726040226.GA19030@dcvr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 26, 2020 at 04:02:26AM +0000, Eric Wong wrote:
> Carmen Andoh <candoh@google.com> wrote:
> > Hello Git community,
> >
> > There's been some conversation about holding a virtual contributor
> > summit focused on inclusion [1]. I've volunteered to work with
> > Jonathan Nieder’s team on organizing this event.
> >
> > The purpose of this inclusion summit is to engage core Git
> > contributors as active participants in diversity and inclusion
> > initiatives for the Git project. As mentioned [2] "to align and
> > coordinate, to set out goals that we want to agree on." This is part
> > of a broader goal to make the Git version control system better
> > support inclusive open source projects. The summit will give
> > contributors the opportunity to learn about and share perspectives on
> > inclusive culture, product inclusion, and career development.
> >
> > This can be run unconference style like previous contributor summits:
> > we'll use a spreadsheet to choose and vote on topics. This event will
> > be a success if we walk away with specific recommendations on where
> > and how Git will make changes to improve the experiences of
> > underrepresented users in the Git project, and how to make the Git
> > project better represent the needs of current and potential users.
> >
> > It was mentioned in [1] that we should have conversations about equity
> > and inclusion with more diverse voices present.  But we also don’t
> > want to put a burden on individuals coming to educate us about things
> > that we should be researching for ourselves. To that end, we are
> > meeting with Diversity, Equity, Inclusion (DEI) experts for guidance
> > and will have recommendations to incorporate into the summit. Prior to
> > the summit, we will send out some resources to look through ahead of
> > time.
> >
> > Who all are invited?
> >
> > Git core contributors on https://lore.kernel.org/git/., anyone
> > interested in teaching OSS projects about DEI.
> >
> > If your network includes any groups or individuals who focus on
> > educating others about DEI, you're welcome to invite them or contact
> > summit organizers to learn more.  We prefer groups and individuals who
> > are in the business of educating on inclusion, or if they are
> > volunteers, already explicitly expressed their interest in
> > volunteering rather than being asked, as we want to be very mindful of
> > free emotional labor. A bonus for knowledge of inclusion in open
> > source.  We can widen our understanding by asking non-Git contributors
> > to come share their perspectives for some or all of the summit.
>
> Hello, I'm only an occasional contributor to git since 2005;
> but I have many concerns which don't seem be brought up.
>
> I have several concerns about the increasing use of video
> conferencing in Open Source development in general.
>
> 1. The data can potentially be used to feed facial and
>    voice recognition (either by the host or some participant).
>
>    I haven't allowed myself to be photographed in over a decade
>    and never video conferenced.  I've also turned down countless
>    professional and personal opportunities because of this, along
>    with never flying due to invasive screenings at airports.
>
> 2. Even without the privacy perspective, I have some hearing loss
>    and conversations can be difficult.  There's plenty of folks
>    with more severe hearing loss than mine who'd be left out.
>
> 3. It seems much of the software used for video conferencing
>    proprietary, even though Free (as in speech) alternatives exist.
>    I don't know enough about this area but maybe others can chime
>    in.
>
> 4. Finally, the hardware and bandwidth requirements for video
>    streaming is high.  Poorer folks on slow computers or in areas
>    with expensive bandwidth would also be left out.
>
>    And one of the reasons I don't code as much as I used to is
>    both gcc and clang are taking longer to compile with every
>    release and our test suite isn't exactly fast.
>
> So yes, I'd like these concerns addressed even though I'm not
> willing to be on video or deal with JavaScript.  Thanks.

I think that it's tough to make individuals on both sides of this feel
comfortable. On the one hand, folks such as yourself may feel
uncomfortable with this format for the reasons that you posted above. On
the other hand, some folks may prefer audio or video instead of text
because they find it easier to express themselves with their body
language, intonation, etc.

A bare minimum seems to be using a free service (I know that Jitsi Meet
is an often-recommended alternative) with support for joining without
video (either using audio only, or participating over chat).

Hopefully everybody should have a good-enough internet connection to
stream a low-quality audio-only feed so that they can listen in and
participate via the chat feature. This is what we did at the
Contributor's Summit in March (I know we had a number of text-only
participants in time-zones where it was late, etc.).

What are your thoughts?

> /me goes back to making public-inbox (and thus lore) faster on
>  rusty old hardware...

;-)

Thanks,
Taylor
