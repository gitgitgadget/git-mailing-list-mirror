Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3B1C4363D
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 11:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99A9C20BED
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 11:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="EU8vJhKH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgIYLWQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 07:22:16 -0400
Received: from mout.gmx.net ([212.227.17.22]:53937 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbgIYLWP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 07:22:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601032929;
        bh=BxwPxOtwWznyiH+G7zYo8rOo83QrccTi7xpLIsR8OoQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=EU8vJhKH8bIMVw8ifH9w8ZpAQzbTcE+uMXa6P9e33Itd+4hCJu1bNCvBSLi+J924n
         AGuF5zg2+S4OMvmZbFusfrPAzhz/q1jXtvWjd6DffPzBCZwxj3UOCNgYp01vpcJcHl
         pxR67g5lgVjVZooZ2xrt/9+KdPlnv6FkJuNkIRpI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.89.169] ([89.1.212.158]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MDysm-1kBuRh3tgq-009wLD; Fri, 25
 Sep 2020 13:22:02 +0200
Date:   Fri, 25 Sep 2020 09:14:35 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Miriam Rubio <mirucam@gmail.com>
Subject: Re: [PATCH] bisect: don't use invalid oid as rev when starting
In-Reply-To: <nycvar.QRO.7.76.6.2009250910200.5061@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.2009250914140.5061@tvgsbejvaqbjf.bet>
References: <20200923170915.21748-1-chriscool@tuxfamily.org> <nycvar.QRO.7.76.6.2009232229000.5061@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.2009232302050.5061@tvgsbejvaqbjf.bet> <xmqqa6xgi363.fsf@gitster.c.googlers.com> <CAP8UFD3mfPgedqGk0ZFp3K3r1gDA3-stbSxoEomRh4T0_qH+tg@mail.gmail.com>
 <nycvar.QRO.7.76.6.2009240950010.5061@tvgsbejvaqbjf.bet> <xmqqo8lvgmdw.fsf@gitster.c.googlers.com> <xmqqwo0jm356.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2009250910200.5061@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:6vVq5AMhXKsT8aR+IdlETtu8zbhKVsRgduWH4HIG/12BeOzKnaW
 amvVERwTqzckcLI3FCb/IJwFrLJ3pgQ+pbTbyfea63VYUEmCsvLeA39teFpyAopOlmDi1oT
 C7DV5JBj3m7QoP4QBpW4wmMhFEVDV9ATCYWBWBcVw9pH7aWCknmwg7hJT7oHW+afu/wnfBl
 sulDb3BoBV+l7mT+M/p/w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Gxbh0ombq5o=:OUfTmnKGTyIBPYmT5pKIyQ
 7TuNv6AAWqoG2VBM2TOHwlLBL57sDT+BOZjxH0vEqaqtXyrRSrVTUX1k+p3GyphRS1/inheLV
 POvozdj5MWlAAd4sVFFLFZvrvN+qfOl854KrTEA+tUlaa8bgZt3b2vyRycqneYxsKfuxqJZoO
 eAWIUjPKNm7Af/jR806bDnAw+6Pb0vW3v6PNqNi1JOjabBGy441kXD8/kvHHE3E4N0oEDvfL3
 uEEwDI8xhFYRp2bKeRLlGhH2h5/lpeIuIDogAclHzpa0kRsaGxtJWsDokg/73x2HP6KxUVyb9
 s4viN+oVr8eoaCtXjIqIUnEMia4v0Dcsb+DQwKuwP/Y15zRrchFLyOCyJHI891slYXAkvoaSC
 BtbBjReip22rhnerUSUJHpAmwoCFju7DbenyP+m/utGeGfQ7qQybMwnMX4UAsny3bU6PaK6mg
 rBMkBubRKC1GqwtOvnhOG3a8WYyZoLHvDont9CVKH1glcvcd1AtNt5rhWnk905oUf6F4gPdT0
 60cIT9gv5+G034erWvVW1221BRpmDZCDvrxile/hsWmBaOaR/KDaWU1WcmVQ+SIzdz1Lm0Oiv
 h07NSIHcmsyaGxpFqiXuvlc/Og2Prl3RBCnc1R5c8WhDtPFSViRIeqhhIwGx8Ybd4uhS5wlDG
 xIGqezhYi3aHxigOTfp4/cLU7pMtyET4z8PAKPQWHIvB2NmaiZ5Efa7lOGwx9/NvA9rxb3TOC
 6PurQ7lotfvX5CG4aqnrcEZvGY6YptEfWlXo7BahFYOYjxIAzVF4X6NaHAbVB6ZJImQeYnoov
 h6VkZWbvmTJNo3ktRzrZhl9k3NxJtS60RuuoFzoAqGdQoTzsv6aqs+Q0ovWwn/TcEuKAg6vAF
 mVlO3fsKzgYZIt+vNjf9y3qA1iPCHQe2dQYgEFgRwfeNc0DXyhLLNEAX8CdRUekyRAwyhPL0f
 egZUs0HDuEqXSIIsPbY30oYilvKH+M4pEJs18wYDDjdiYP3ak0bA8dV8iQDn1sR13Wfh3/OVX
 o3E4BU52LoYHlAKWvCDEq3NwKYSkCRkaJmj+ahucvJ3fbQNMckgaQDMDt6v7J4vTTjZAf75HL
 8pPbvT1frGihtW4URt3q+fl5aYsAaatWxdOES/QbUU9b9t9imKoHiHRkeyqBtX+hECTzJbu01
 nVng0DxzBYx0b5gC5ZfuDrXyy4FcwRtiDnnB/xWm2m/3TSu7A0hmvbNZbNc3V8ZH0KjdhtYBJ
 nnkk0NJVZC+Gf46o+OpB9T74Bje1DmwaNrkXltw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, 25 Sep 2020, Johannes Schindelin wrote:

> On Thu, 24 Sep 2020, Junio C Hamano wrote:
>
> > Junio C Hamano <gitster@pobox.com> writes:
> >
> > > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > >
> > >>> Hopefully the V2 I just sent will be better anyway.
> > >>
> > >> FWIW I was working off of Miriam's `git-bisect-work-part2-v8` branc=
h at
> > >> https://gitlab.com/mirucam/git.git.
> > >>
> > >> I'm happy with Christian's v2 (with or without the indentation fixe=
s I
> > >> suggested).
> > >
> > > Thanks, both of you.  The updated one does look good.
> >
> > Oops, do you mean s/path restriction/pathspec/ fix?  v2 looks OK nesti=
ng-wise
> > and I think your indentex-fix suggestion was for the previous one.
>
> I was referring to the indentation of the -/+ lines in the commit messag=
e.
> Your current `SQUASH???` does not include the line-shortening, but that'=
s
> okay. I slightly prefer the version where single conditional statements
> lose the curly brackets, but that's just nit-picking.
>
> A slightly bigger question is whether `git_oid_committish()` would be ok=
ay
> enough, or whether we do need `get_oidf(&oid, "%s^{commit}", arg)` (as
> your `SQUASH???` does).
>
> I'm not quite sure: aren't those two calls idempotent, with the latter
> going through some unnecessary string processing dances?

Whoops. You explained that elsewhere in the thread. My bad. Ignore me.

Ciao,
Dscho
