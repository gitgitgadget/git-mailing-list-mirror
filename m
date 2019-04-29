Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D2A81F453
	for <e@80x24.org>; Mon, 29 Apr 2019 21:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbfD2VZu (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Apr 2019 17:25:50 -0400
Received: from mout.gmx.net ([212.227.15.19]:53781 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729283AbfD2VZu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Apr 2019 17:25:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1556573137;
        bh=I6j8+Fg57g/KJLVbV3sjL7GKf4WEYUCyaBuBA21VPGg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=JTRj0f/vY4RRJ9WARITIwvzzwyNnRX1XGcsQyJP9HxfGjeP2t7lvpjGQ9G/knk3lZ
         Fmda3uVaZuWSb/qxW2fMYT0l/B2F4jAH7SxhQphZQTyFv8+xX5vtvC/DQ1k/tWPwQx
         JXQZva65IpBH812JiI4/qpRbHgDca6spk1dmCcuQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.96.188] ([12.174.135.204]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MHG8g-1hYP451hIm-00DHfj; Mon, 29
 Apr 2019 23:25:37 +0200
Date:   Mon, 29 Apr 2019 17:25:39 -0400 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
cc:     Jeff King <peff@peff.net>,
        Rohit Ashiwal via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Subject: Re: [PATCH 2/2] archive: avoid spawning `gzip`
In-Reply-To: <45afd432-9e45-ea76-aa1b-e8cd1264e3a0@web.de>
Message-ID: <nycvar.QRO.7.76.6.1904291720120.45@tvgsbejvaqbjf.bet>
References: <pull.145.git.gitgitgadget@gmail.com> <44d5371ae6808ec40e8f52c3dc258a85c878b27e.1555110278.git.gitgitgadget@gmail.com> <20190413015102.GC2040@sigill.intra.peff.net> <8ef2164c-1d44-33bf-ea8a-49fa0b5c8abf@web.de> <20190415213556.GB28128@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1904261047560.45@tvgsbejvaqbjf.bet> <f6f32bc0-109c-e0eb-f7d2-9e46647f260c@web.de> <45afd432-9e45-ea76-aa1b-e8cd1264e3a0@web.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1684098236-1556573142=:45"
X-Provags-ID: V03:K1:2qs2CyNTU7mNSo4FUJ6kTAfoP6YZ2QzSM8lZIsM3uSOdQqMnnGK
 sLLAg0BJ+afE+WSNgl9zBcSc6mc89RbAVbyXw05M2MvRj2mu++IQ3HA2zWkFGCFRN7xkVOr
 EU8tL6gJ+9W2b7Byr5xCqG/uZRCZXRk1hFTNRbtGMYy90ncL3osIm+jSZB/4Unf1lTPFaYc
 LfBL23od8hO2MotpMdQYg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1+bkheZztXM=:iWil2KWHFnaqrVIq++dszl
 9ks4RtDrz8YZDGeF2gDq9ufbE4iQaLGlXFrXcQtw9lKp3/Q9mwZvnRdtXdvNQy60C9MOKuw/V
 DgcE4Ydd7Pg0NnI97uO/Puhqp+/51yVm+rGv3+QpRwN4GsSoIgqOXY8kgQV83FBTWiCofR2nF
 jIhVdNctORrLaIaXyju7JaY/6fbvYKORVZi/xP9LlUDlW1RwE8xhzZszTq426A2581i0H4F93
 ph/PzjSZDgDblRJv4ZOr/FHcRZeZ4VtWeAuylgi0HNWvpnntyv28FQOATfXIyCmy0Pk+bkmSj
 kTfVKCkGfDjcjxOIuadb4CryMPFDBU9UsP3gSNHI/kj49i2T+8ewiXAVWL4AW4oqMzaP5BpKU
 eUawK9UuXDZLa4VfRcBdCw+fT1s1PhxRnuEAe6miFQUOe94XM8XDyrNiEqbwtSWLUT8AepzXd
 6J/9koTwZ0xJm9+Gdmxyi9+XLs8DgSMAYfXj3xSRwiSNlwIk6sPImL17MbFEk6gYJyxbYcKaJ
 vSLC8RQrqKbWDQAPuEb1G/MAwBH37H/47JoqvqgBKk6WIJROlN6ubNtobOv8lKuht0mHYvYWg
 HbdJvYzsSkkTUZrEFTA+bA9s1mRCNLYXN222vEIwSXs7lkF8il4nJbNsYYx9ONhsdi2bvr0Sj
 2gI8TZeb2mTzjH5ZL+MMn+Bg0SZ2fUX7+C8w9P5dx8BnUXty6x7aGtsu+WUmPPBhaCpuzjCg2
 7DY9T2dO0JWrl4UmoZmJO6JeUZnt4snbW6TeNQRt9zgsbZo0IpL7xhNxDKoaFoMrmfLBcO8fv
 6+OlMw1KHOF4UgjQNON7mL+4zI5a50SjVunCUpFQnW54EpnxAukH6YEC+qieG5inIUFSV3bUE
 7YnLtDju4cl5aKCKHTU6ixggL7ms7k/no9WgTkyn+A1+dL8ZG7Lxa2dWmxi92pawQH1icrMQK
 bBAXObXGMqw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1684098236-1556573142=:45
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Ren=C3=A9,


On Sat, 27 Apr 2019, Ren=C3=A9 Scharfe wrote:

> Am 27.04.19 um 11:59 schrieb Ren=C3=A9 Scharfe:> Am 26.04.19 um 16:51 sc=
hrieb
> Johannes Schindelin:
> >>
> >> On Mon, 15 Apr 2019, Jeff King wrote:
> >>
> >>> On Sun, Apr 14, 2019 at 12:01:10AM +0200, Ren=C3=A9 Scharfe wrote:
> >>>
> >>>> Doing compression in its own thread may be a good idea.
> >>>
> >>> Yeah. It might even make the patch simpler, since I'd expect it to
> >>> be implemented with start_async() and a descriptor, making it look
> >>> just like a gzip pipe to the caller. :)
> >>
> >> Sadly, it does not really look like it is simpler.
> >
> > I have to agree -- at least I was unable to pull off the stdout
> > plumbing trick.
>
> The simplest solution is of course to not touch the archive code.

We could do that, of course, and we could avoid adding a new command that
we have to support for eternity by introducing a command mode for `git
archive` instead (think: `git archive --gzip -9`), and marking that
command mode clearly as an internal implementation detail.

But since the performance is still not quite on par with `gzip`, I would
actually rather not, and really, just punt on that one, stating that
people interested in higher performance should use `pigz`.

And who knows, maybe nobody will complain at all about the performance?
It's not like `gzip` is really, really fast (IIRC LZO blows gzip out of
the water, speed-wise).

And if we get "bug" reports about this, we

1) have a very easy workaround:

	git config --global archive.tgz.command 'gzip -cn'

2) could always implement a pigz-like multi-threading solution.

I strongly expect a YAGNI here, though.

Ciao,
Dscho

--8323328-1684098236-1556573142=:45--
