Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 435381F453
	for <e@80x24.org>; Fri, 26 Apr 2019 14:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfDZOvO (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Apr 2019 10:51:14 -0400
Received: from mout.gmx.net ([212.227.15.15]:51079 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbfDZOvN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Apr 2019 10:51:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1556290266;
        bh=G3Nyg8rwiz8oE7t2zxAYrR/K4z/+I6nG8UuKk+4J5RU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=hxyE17NVhaXjlIiZ39cnkD2cqWdGal28OJ5Of14popExEN+hE1YrVDakpPPzNTl60
         mlJGyX44Z69Egyx8xkg2m54+aMEig8o+vXBAcJKzVb22iD3xPRMQgwl0X1cOiPoHnU
         PKyompw/BlRWUEebymxlVBS+Er3Xd7bvdbBSynVg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.106.210.8] ([167.220.152.136]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M3j17-1gTAYS2gbp-00rEGr; Fri, 26
 Apr 2019 16:51:06 +0200
Date:   Fri, 26 Apr 2019 10:51:02 -0400 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Rohit Ashiwal via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Subject: Re: [PATCH 2/2] archive: avoid spawning `gzip`
In-Reply-To: <20190415213556.GB28128@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1904261047560.45@tvgsbejvaqbjf.bet>
References: <pull.145.git.gitgitgadget@gmail.com> <44d5371ae6808ec40e8f52c3dc258a85c878b27e.1555110278.git.gitgitgadget@gmail.com> <20190413015102.GC2040@sigill.intra.peff.net> <8ef2164c-1d44-33bf-ea8a-49fa0b5c8abf@web.de>
 <20190415213556.GB28128@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2116294719-1556290266=:45"
X-Provags-ID: V03:K1:SfjCEoQk/9UyWwC0sjr6Wflh/+vqJWbXK7Ankkr3zbEfwSvd0Ow
 Ukb/VKP3ePaMQQxRNMx9hqPFY0/cqOE919aFxC5bhDW/vJcwHkII5e0SrVvX+Ds9OmdV6Lr
 GYi/sNIJQqoaAguwYUgJxa4twwZ5ErogWMguw3LW9ul2gATfiwbH9n67frJ+ILlfHdnklOg
 qFWcbc/w5+v6uNVA+J21w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VZ02R+KDS1o=:ANirS+nGR9GIGdGQsEK56a
 CE2/LL2/6ds2CsdexxrX9olW+2GOSR4AdUvCrEcS3/btThgwNiw08+hbK6UzB+nA8+9uNzAxL
 WlbPHY4eBFqBbvBbYRImeQu6dfznNr2jbz0oqcu+V/8E1OKZNbqENeSNKh91pU8gGyln3mvXQ
 lJxzDlsDzJMkdrwbojLqs6VdB8u+tsFjH5+GOVbBUCu9LSfdpo6b50X4nXT6vkNtVuV0ReGa1
 YSOzhhHN/7MTs+iDSscUvqSvVlgucQXd+4sauwehSIUbEBRxrK6NrUfXQI9tw/OlprwADQP13
 Ps3/rqXKS6dSHFK/19d05fI6CLWfZyMqr82GDo+4jKA/hZJsByh9gjJPKG+Q5SShENlyjvp/J
 748XprmL1LGXzUrKgF0P4ZMs2vqFpu3tScFD3g2UPP/RlKo1O49/easZ9WqoZPZEmdm2EcM26
 GIZka55xurMqaY21/RwmlIzIdSxTSzWZOyO+LrYf1NGa1t2sO3+677/ypxKiYs2V3kIzKySzz
 EW5jpHzBYIsoTtFsfGRcKKZfY5DFinh5IvxYmWjfTcBX09XX6L26guifQ2xrRAbyWJyZ7lbsi
 3r/2BZI4NSjEsVASBTg+I9LftCo5/wxNHLsftlTlZ0d6w+t6S+3AObesKf4rJQB+/LWcRn7Tr
 yrDwk4TeS+/6aXZbehmpECoBxWhNMEFbAYFX0Ac2EndluLUCX3iCgj20q+5nOh5BGGeev1fUu
 0OLUAX7bRIt0Aci2SkrknMxiNBtTOXEZMth0J2sx8mfCdszlM2apcvXadfhjerqVx67t1j+5q
 K8O7ChK6Hmy8dJnKPVZp3FHvQ3mBFYRQw0PBpRMkNEuzPRDZxD/LqIRCDjDN7z49caTZsEgK2
 IsaGZv2U+u1Ksq/Y+dXF2D0tmgxvdQks3bcgSlCI7fFZAw5ocauBjEZ8FTD3MIYVKLddB15A1
 FkQgAhA3J6A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2116294719-1556290266=:45
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Peff,

On Mon, 15 Apr 2019, Jeff King wrote:

> On Sun, Apr 14, 2019 at 12:01:10AM +0200, Ren=C3=A9 Scharfe wrote:
>
> > >> As we already link to the zlib library, we can perform the compress=
ion
> > >> without even requiring gzip on the host machine.
> > >
> > > Very cool. It's nice to drop a dependency, and this should be a bit =
more
> > > efficient, too.
> >
> > Getting rid of dependencies is good, and using zlib is the obvious way=
 to
> > generate .tgz files. Last time I tried something like that, a separate=
 gzip
> > process was faster, though -- at least on Linux [1].  How does this on=
e
> > fare?
>
> I'd expect a separate gzip to be faster in wall-clock time for a
> multi-core machine, but overall consume more CPU. I'm slightly surprised
> that your timings show that it actually wins on total CPU, too.

If performance is really a concern, you'll be much better off using `pigz`
than `gzip`.

> Here are best-of-five times for "git archive --format=3Dtar.gz HEAD" on
> linux.git (the machine is a quad-core):
>
>   [before, separate gzip]
>   real	0m21.501s
>   user	0m26.148s
>   sys	0m0.619s
>
>   [after, internal gzwrite]
>   real	0m25.156s
>   user	0m25.059s
>   sys	0m0.096s
>
> which does show what I expect (longer overall, but less total CPU).
>
> Which one you prefer depends on your situation, of course. A user on a
> workstation with multiple cores probably cares most about end-to-end
> latency and using all of their available horsepower. A server hosting
> repositories and receiving many unrelated requests probably cares more
> about total CPU (though the differences there are small enough that it
> may not even be worth having a config knob to un-parallelize it).

I am a bit sad that this is so noticeable. Nevertheless, I think that
dropping the dependency is worth it, in particular given that `gzip` is
not exactly fast to begin with (you really should switch to `pigz` or to a
faster compression if you are interested in speed).

> > Doing compression in its own thread may be a good idea.
>
> Yeah. It might even make the patch simpler, since I'd expect it to be
> implemented with start_async() and a descriptor, making it look just
> like a gzip pipe to the caller. :)

Sadly, it does not really look like it is simpler.

And when going into the direction of multi-threaded compression anyway,
the `pigz` trick of compressing 32kB chunks in parallel is an interesting
idea, too.

All of this, however, is outside of the purview of this (still relatively
simple) patch series.

Ciao,
Dscho

--8323328-2116294719-1556290266=:45--
