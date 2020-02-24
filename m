Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D5DC35679
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 07:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1625520578
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 07:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UsVE8XOD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgBXHax (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 02:30:53 -0500
Received: from mail-ed1-f54.google.com ([209.85.208.54]:41204 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbgBXHax (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Feb 2020 02:30:53 -0500
Received: by mail-ed1-f54.google.com with SMTP id c26so10732475eds.8
        for <git@vger.kernel.org>; Sun, 23 Feb 2020 23:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VcV9D0VHSu2k9d3anro6DWjNUtaxysg2zCQchU5c0wY=;
        b=UsVE8XOD5OWRtHw71ziHLswexcegtSj52d4GZetv7ENVM49tmkQ6cFY2TZsZiofNU/
         EaMt/xettZYXcQVCC0KBOXEuDW4iJSAxDJFm+A9MTMgwnV63R9yLIA9QQnM3XrAL/CBy
         8dc6MfCOhOXHjydRb5zaydPc23CPVAHR7ltMAKvMO5KdjT162Zu75iNQJ8Mg+wi6G6DF
         5SbPR6bAbw6EvGHKnZs9OH4wT6JnvvVtm5Q4bp3K/kXS+BfxvbMJ1nBOlG88XLMW60uw
         wcWkmW+VsSJoxsu4RZo7bfA2TC4li7T7xXW5b2oT9rS4bg4jWY13lD/3NHN5mv+dsJzG
         VZ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VcV9D0VHSu2k9d3anro6DWjNUtaxysg2zCQchU5c0wY=;
        b=LV4Ob6j0lnVdUmfLrt19L7BsTPLlKMz9+h+UMQ/mlD0rQeWZJNmAfl/Aqb66e1zK1g
         e+hvvpFPvdmGD52DaJgCXFOAjHoOUlhID2BF4VZCLznWKEMJNYfFFxpdqV5j246AJWPB
         C3e1NRd/zFBEInZd7p/gm01cH6CQG7PE1tMS1n+Exj6LZtT2Td9rCOEATruPjwHhGhlP
         KPpnz6/CACGSfx2CJAbCAu78DisI9qad81gXI0WjKst46SpjFYwxBROCrU/kWBJ1dyao
         kFM4Tk0B1oQrHhNC9+QlIQYVci5M3CxHyRLSG21d2gd4a8a9ACzhLHWwVi+U7ArPIlSc
         K51Q==
X-Gm-Message-State: APjAAAU53nEXdlQm/8bRjk8+Fv3NQ3bsW08dUc8E9NNt2N3gHrf7bsMc
        opzzjkveN7v64uU9uFtTy6NurTYlUh9OYbIQSkw=
X-Google-Smtp-Source: APXvYqwyFnhJ3wZ/YmatYS4PLOA7Y+pSGi4yUUgC4/FuLGWF9iTMNuUYF0CE5XpKtAoalPy+8pcNi0HJm3R6rwst+cc=
X-Received: by 2002:a05:6402:3088:: with SMTP id de8mr26233158edb.87.1582529450814;
 Sun, 23 Feb 2020 23:30:50 -0800 (PST)
MIME-Version: 1.0
References: <20200122053455.GA51054@coredump.intra.peff.net>
 <CAP8UFD1-cswU0gSX3a2KqiExhYgY_qMZ6Sz7FHdxs7mrb_hh-w@mail.gmail.com>
 <CAP8UFD2_qmB1q9vhz=BJo3XG4jnLWDPhCVVb4gAh_pfKoGnZJQ@mail.gmail.com>
 <20200204163716.GA7308@coredump.intra.peff.net> <CAP8UFD3UewcZ3oid_SiUYuFEO49JTzaSigHDTP8OPs2yh6s6zA@mail.gmail.com>
 <CACg5j25_098i=rU++OB=YSbAFjCQdgUX7gP6D-9yo6F_A_yn0w@mail.gmail.com>
 <CAP8UFD1QbOK9g2oAhfTm2npoNF9Ay_HiAfFai9rJwZzc73cBbw@mail.gmail.com>
 <20200221183003.GA9786@coredump.intra.peff.net> <CACg5j24mH0LRHXbhgf16f+7KqOnrsh7BRovh8mR6AzHG=y5gFA@mail.gmail.com>
In-Reply-To: <CACg5j24mH0LRHXbhgf16f+7KqOnrsh7BRovh8mR6AzHG=y5gFA@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 24 Feb 2020 08:30:39 +0100
Message-ID: <CAP8UFD0DgRd1MZTyLUw2giBCfuS2syivSvRadrBjE0276vjtNA@mail.gmail.com>
Subject: Re: GSoC and Outreachy Summer 2020?
To:     Heba Waly <heba.waly@gmail.com>
Cc:     Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Heba,

On Sat, Feb 22, 2020 at 8:20 AM Heba Waly <heba.waly@gmail.com> wrote:
>
> On Sat, Feb 22, 2020 at 7:30 AM Jeff King <peff@peff.net> wrote:
> >
> > On Fri, Feb 21, 2020 at 05:03:47PM +0100, Christian Couder wrote:
> >
> > > > I'd be happy to co-mentor an Outreachy intern with an experienced
> > > > mentor, hope I'm not too late.
> > >
> > > Thank you for your interest in co-mentoring! It's very much appreciated!
> > >
> > > I don't think you are late. It seems that February 25 at 4pm UTC is
> > > the deadline for project submission.
> >
> > I think it is too late. That's the deadline for mentor project
> > submission, but the signup for orgs was Feb 18th.
>
> You're right, but they mentioned on the website that Feb 18th is for
> new communities who haven't participated before. I double checked with
> the Outreachy organizers and they can still add Git if there's funding
> and a mentor is interested.
>
> I'm happy to help and co-mentor on any of the two programs.

Great! Hopefully someone (perhaps Dscho) will be willing to co-mentor
an Outreachy intern with you, otherwise I will be happy to co-mentor a
GSoC student with you.

Thanks,
Christian.
