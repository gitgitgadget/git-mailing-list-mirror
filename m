Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24C021F453
	for <e@80x24.org>; Fri, 26 Apr 2019 14:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfDZOrU (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Apr 2019 10:47:20 -0400
Received: from mout.gmx.net ([212.227.17.21]:43995 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbfDZOrT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Apr 2019 10:47:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1556290027;
        bh=yFYRkMQxjpAQK46cMBVTau+QbHBmHSHa351u0msXWh8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=LrciOxHqFcomvouGdP3d78WLAK2v6kPl+47BJgTeN6wD7w9LKnd/lKmmIlIl/uLXU
         Y4YW7tVJzTB1LFAmekUKjTDz0mOaXo8UQ7oLXfry1y5n6A+Hw8rRgJNM9MWSOE3fc7
         t4R9XZZ3kHQuYsR5ratDET95MLDGuiorpDBDeP+8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.106.210.8] ([167.220.152.8]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LvPgd-1gbS5B3Xxj-010cel; Fri, 26
 Apr 2019 16:47:07 +0200
Date:   Fri, 26 Apr 2019 10:47:04 -0400 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Rohit Ashiwal via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Subject: Re: [PATCH 2/2] archive: avoid spawning `gzip`
In-Reply-To: <20190413015102.GC2040@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1904261035090.45@tvgsbejvaqbjf.bet>
References: <pull.145.git.gitgitgadget@gmail.com> <44d5371ae6808ec40e8f52c3dc258a85c878b27e.1555110278.git.gitgitgadget@gmail.com> <20190413015102.GC2040@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1046067736-1556290027=:45"
X-Provags-ID: V03:K1:+MNZdjNMuIm7FZHvhbbTKDINGwoDnCFjjix0hBkLZJLMMFuXL0T
 2/fe19+OUoXk5ZUSe6tfVnBB7ZbLDZsSgD0Vy2x/J434Zc0jkXGv0Xbv1LhrLW8tYV106Mu
 KK9wy18/EbamJmXle8H1w1jl8l4D3QzwQ/VXMCTomCxXrYgiuIu/Uu6OJAImE/fUdP3SCIv
 dqeUhXUIVVlDbCLKOwoOw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pdDcxBD/zak=:B7VZmquEUwA9hUDhdyhIPX
 TUQ2NXJ/qwh40AR0JVK9IPHmk+EwlhdmSmCPOBiyEdmJhY6VKtmmMKZov/YZNkSgZRf81+JVq
 0fcv3wa4iB86iYkEh7dD2forNNhUMLbNbntkSzhy3wUTlkrIhyaVLQDGhLMUdATCpi3o5ymjP
 pcCH5hD459eJpzTIEhP4NlSLkjfqbMSxL7awjpHHqwf3cLwYaBEMfjEr8h4r3fBZOag/ig/i5
 +unNbKrTW3umcrvR9iJBlA9zyZG8FlyeEzxygSP2KkXui4dp5DjIASlrbOAS5GfWcdPkipgv/
 AdEiqMWoiSJuLUmz4Uxt+IWPzXqDQD7ab8PX2cMhkJ4pcu6437dwhJiGm4BAlMt+GOXiBUrDa
 l7Dyo4dMEXcv2SmuiuXkNhDFLq+5SHyDKj500GSqzeiDBp+w3JzQd0Ohs5RiRTBiBBEInLqwJ
 LEBCSuVac/6m6MMmAWiYyl1NIVYur+YZmRx9i9fZ4KtKo9TQFEMhp0d74MHksC1uoD1W9TnYN
 ZciQcB+ih8bX47Nvv7bxv9Q09Irp3J3LTMYrz7Ty3YBesrSZFjOblMOZPxbbS4QCvHuzuJYbJ
 /v2Jzs1/kU7UFGaeh+EMQc2fv0mZtRV7tiGNhFTBOCOWiXKe/1AtB4g2tPMrAPdvIHe3Lfwpx
 25my37vU/bXXbQKq1Mug/KIGGXWBSHFPsg5XijDAJMn93kyNoZol4fnldIwp/BUT8KjBxiV/v
 kRPnBXSkNhbjO1GNv9Tb+fF9H4HTueUx2DaRUcXV8WmJHCoTeWv+Ii9KjjJdbX7nAW7JHzT29
 oHD4mt+YpkDxbjl1CvRrUO7U3tg0g/soWxL+xppVvEqJaUBT4hA80wo1j/PEiX2cD3X0HN92u
 E/BkFYcksoTzpOJgh8xo5hK3bynv5Cxe+mDxu3cksMHV7w+FNlJfLA5RV+lTLuwMQZccjxHrC
 osBlgG3RcvQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1046067736-1556290027=:45
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Peff,

On Fri, 12 Apr 2019, Jeff King wrote:

> On Fri, Apr 12, 2019 at 04:04:40PM -0700, Rohit Ashiwal via GitGitGadget=
 wrote:
>
> > From: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
> >
> > As we already link to the zlib library, we can perform the compression
> > without even requiring gzip on the host machine.
>
> Very cool. It's nice to drop a dependency, and this should be a bit more
> efficient, too.

Sadly, no, as Ren=C3=A9 intuited and as your testing shows: there seems to=
 be a
~15% penalty for compressing in the same thread as producing the data to
be compressed.

Given that it reduces the number of dependencies, and given that it might
be better to rely on the external command `pigz -cn` if speed is really a
matter, I still think it makes sense to switch the default, though.

> > diff --git a/archive-tar.c b/archive-tar.c
> > index ba37dad27c..5979ed14b7 100644
> > --- a/archive-tar.c
> > +++ b/archive-tar.c
> > @@ -466,18 +466,34 @@ static int write_tar_filter_archive(const struct=
 archiver *ar,
> >  	filter.use_shell =3D 1;
> >  	filter.in =3D -1;
> >
> > -	if (start_command(&filter) < 0)
> > -		die_errno(_("unable to start '%s' filter"), argv[0]);
> > -	close(1);
> > -	if (dup2(filter.in, 1) < 0)
> > -		die_errno(_("unable to redirect descriptor"));
> > -	close(filter.in);
> > +	if (!strcmp("gzip -cn", ar->data)) {
>
> I wondered how you were going to kick this in, since users can define
> arbitrary filters. I think it's kind of neat to automagically convert
> "gzip -cn" (which also happens to be the default). But I think we should
> mention that in the Documentation, in case somebody tries to use a
> custom version of gzip and wonders why it isn't kicking in.
>
> Likewise, it might make sense in the tests to put a poison gzip in the
> $PATH so that we can be sure we're using our internal code, and not just
> calling out to gzip (on platforms that have it, of course).
>
> The alternative is that we could use a special token like ":zlib" or
> something to indicate that the internal implementation should be used
> (and then tweak the baked-in default, too). That might be less
> surprising for users, but most people would still get the benefit since
> they'd be using the default config.

I went with `:zlib`.

> > +		char outmode[4] =3D "wb\0";
>
> This looks sufficiently magical that it might merit a comment. I had to
> look in the zlib header file to learn that this is just a normal
> stdio-style mode. But we can't just do:
>
>   gzip =3D gzdopen(fd, "wb");
>
> because we want to (maybe) append a compression level. It's also
> slightly confusing that it explicitly includes a NUL, but later:
>
> > +		if (args->compression_level >=3D 0 && args->compression_level <=3D =
9)
> > +			outmode[2] =3D '0' + args->compression_level;
>
> we may overwrite that and assume that outmode[3] is also a NUL. Which it
> is, because of how C initialization works. But that means we also do not
> need the "\0" in the initializer.
>
> Dropping that may make it slightly less jarring (any time I see a
> backslash escape in an initializer, I assume I'm in for some binary
> trickery, but this turns out to be much more mundane).
>
> I'd also consider just using a strbuf:
>
>   struct strbuf outmode =3D STRBUF_INIT;
>
>   strbuf_addstr(&outmode, "wb");
>   if (args->compression_level >=3D 0 && args->compression_level <=3D 9)
> 	strbuf_addch(&outmode, '0' + args->compression_level);
>
> That's overkill in a sense, but it saves us having to deal with
> manually-counted offsets, and this code is only run once per program
> invocation, so the efficiency shouldn't matter.

I'll change that, too, as it seems that `pigz` allows compression levels
higher than 9, in which case we need `strbuf_addf()` anyway. I will not
adjust the condition `<=3D 9`, of course, as zlib is still limited that wa=
y.

> > +		gzip =3D gzdopen(fileno(stdout), outmode);
> > +		if (!gzip)
> > +			die(_("Could not gzdopen stdout"));
>
> Is there a way to get a more specific error from zlib? I'm less
> concerned about gzdopen here (which should never fail), and more about
> the writing and closing steps. I don't see anything good for gzdopen(),
> but...

Sadly, I did not find anything there.

> > +	if (gzip) {
> > +		if (gzclose(gzip) !=3D Z_OK)
> > +			die(_("gzclose failed"));
>
> ...according to zlib.h, here the returned int is meaningful. And if
> Z_ERRNO, we should probably use die_errno() to give a better message.

Okay.

Thanks,
Dscho

--8323328-1046067736-1556290027=:45--
