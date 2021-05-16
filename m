Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18056C433ED
	for <git@archiver.kernel.org>; Sun, 16 May 2021 19:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBAEF6115C
	for <git@archiver.kernel.org>; Sun, 16 May 2021 19:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbhEPTBy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 May 2021 15:01:54 -0400
Received: from cpanel8.indieserve.net ([199.212.143.3]:58607 "EHLO
        cpanel8.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbhEPTBy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 May 2021 15:01:54 -0400
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com ([174.114.57.56]:57924 helo=fedora)
        by cpanel8.indieserve.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1liM0D-00016R-D1; Sun, 16 May 2021 15:00:38 -0400
Date:   Sun, 16 May 2021 15:00:21 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
To:     Felipe Contreras <felipe.contreras@gmail.com>
cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        =?ISO-8859-15?Q?Anders_H=F6ckersten_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        =?ISO-8859-15?Q?Anders_H=F6ckersten?= <anders@hockersten.se>
Subject: Re: [PATCH] describe-doc: clarify default length of abbreviation
In-Reply-To: <60a1699eedcd4_109fc7208e1@natae.notmuch>
Message-ID: <7ab75f6a-14a8-1aa7-ad0-20f484e2c8@crashcourse.ca>
References: <pull.1026.git.git.1621150366442.gitgitgadget@gmail.com> <1dc7877e-adb4-e3f5-3b59-bd45f9673596@gmail.com> <60a1699eedcd4_109fc7208e1@natae.notmuch>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1010875943-1621191637=:11182"
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel8.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel8.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel8.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1010875943-1621191637=:11182
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Sun, 16 May 2021, Felipe Contreras wrote:

> Bagas Sanjaya wrote:
> > On 16/05/21 14.32, Anders Höckersten via GitGitGadget wrote:
> > > @@ -139,8 +140,11 @@ at the end.
> > >
> > >   The number of additional commits is the number
> > >   of commits which would be displayed by "git log v1.0.4..parent".
> > > -The hash suffix is "-g" + unambiguous abbreviation for the tip commit
> > > -of parent (which was `2414721b194453f058079d897d13c4e377f92dc6`).
> > > +The hash suffix is "-g" + an unambigous abbreviation for the tip commit
> > > +of parent (which was `2414721b194453f058079d897d13c4e377f92dc6`). The
> > > +length of the abbreviation scales as the repository grows, using the
> > > +approximate number of objects in the repository and a bit of math
> > > +around the birthday paradox, and defaults to a minimum of 7.
> >
> > What is the birthday paradox then?
>
> It's a probability fact that goes against common sense. In a romm
> with 23 people you are 50% likely to find two people with the same
> birthday.
>
> https://en.wikipedia.org/wiki/Birthday_problem

  i've had to explain the logic behind this to people who really have
a tough time understanding this, and it's a concept that applies in a
lot of places (surprisingly).

  what trips people up is thinking they need to calculate the
probability that two or more people have the same birthday.

  no.

  what you want to do is calculate the ongoing probability that each
person's birthday is *different* from all the earlier ones. as in:

  * prob that 2nd person has a different bday is 364/365
  * prob that 3rd person has a different bday is 363/365
  * prob that 4th person has a different bday is 362/365

and so on, and as you multiply those together, it's right at 23 people
that the chance that that person has a different bday from all earlier
ones drops below 50%.

  what's neat is that this way of looking at things applies in a lot
of places.

rday
--8323328-1010875943-1621191637=:11182--
