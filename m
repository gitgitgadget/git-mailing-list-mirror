Return-Path: <SRS0=iF2w=72=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AAF6C433DF
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 17:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20FC12078A
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 17:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="DV0grjdK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgFMRfv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Jun 2020 13:35:51 -0400
Received: from mout.gmx.net ([212.227.15.19]:53157 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbgFMRfu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jun 2020 13:35:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592069736;
        bh=tXd1JDJwBiSQwvkNRLI4UfUloAs5COm5KdYYZjUFu10=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=DV0grjdKe7tVS/d5cg3pXvJ7t9Phcn4PvpRwn02i4SPrHYQmOqb6z14LZ6ymQlzgx
         +LPcCvQGHksYjRfVys9dSzuJ+mL85BMJJYKmreqVJUjYztetDKpRrdG+BTK8gBRmHF
         bGASR3YrCYHrqmLXBi60hm3n6O5o96b1UFsvf+hE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.173.52] ([89.1.215.108]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mqb1W-1j6km00kzo-00maSF; Sat, 13
 Jun 2020 19:35:36 +0200
Date:   Sat, 13 Jun 2020 16:47:59 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Sixt <j6t@kdbg.org>, Matt Rogers <mattr94@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        don@goodman-wilson.com, stolee@gmail.com, Jeff King <peff@peff.net>
Subject: Re: Re* [PATCH 8/9] fast-export: respect the possibly-overridden
 default branch name
In-Reply-To: <xmqqv9jvylt7.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2006131645380.56@tvgsbejvaqbjf.bet>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com> <1efe848f2b029e572cea61cadcfe36b9d3797836.1591823971.git.gitgitgadget@gmail.com> <CAOjrSZvm9QNUttUNVBEUMPJ8zgYEoAnSPN5_6N5uwpiM1sVrcQ@mail.gmail.com> <20200610233912.GU6569@camp.crustytoothpaste.net>
 <CAOjrSZvV6+ApfmOBa7rdXDPQJbExRsOfodO16i_1N5QjjhCB1w@mail.gmail.com> <xmqq3672cgw8.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2006111559300.56@tvgsbejvaqbjf.bet> <xmqqpna5bq2l.fsf_-_@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2006121451100.56@tvgsbejvaqbjf.bet>
 <xmqqy2os2u55.fsf@gitster.c.googlers.com> <405521ec-aed7-ff76-5b48-70e9d11018e6@kdbg.org> <xmqqv9jvylt7.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:BXGSGFmLtySU/q3xw1zEu0y6ZwNgMJpL1T3frRvj6EUeTgI9l7r
 yk9s/n5m6RUwvMdQAoKHDuxMRRuO1wK8FusPlKANrw56/QI3ddVBdZPHw3VVwTvutjoq9dB
 at8BJHTG3tjbhLz7WREkYAQJM9Ct2syWb3sqTZ7tDVDPdDSRIZithOT+14zjUPP3uPa065s
 OwEIyeck8Lo2jleOZsQ6A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:G+0uPn9H9cY=:ONXLks7yAR0zk0KF6zLGWZ
 fj5LoJ70iG0OMpqwa59IJQAQVF6X6fpNz7z6BGWh64fU6zU6ztNhtWxMsb900frLxy+Nycy7d
 V3ZhKtQrwUprJpt2Rmdp8E4hGoewGD/jpMqMuPgOzg7sshvV83VApC6vAuZ5CHyoHyImqPzks
 Vz0gbdXiHkokAY1HpqncoFAXZVAWZZmLbMPwaKGcelby6LWTAMagGR75j/NG9OA0/PIJLwcU3
 5DEuzbOhaG1HtnyqvWWGtK2vniHjjQwjSlK9EiQiNnb0cJwlvXkUBTXQ4+fczG5Cy+I31iIzE
 lFeyUFetPzBAlLc+ckkkzk0IvF3PsB91Eb3jEcHzhPrP5UsnlviLA6othJlDJvYHo6uryEmV4
 IiEj9fSY9RzUeKB9miAydlsWMcdCv1yuobjtZEydrJ6ITxwYwNdQnBO28MZlGNskVFLN635b3
 ymAisQAGk8BdHVyVSxas9EWA3u35S53BA7pKgiLECTO3kiihFtgjNBJZ1Xf037QX6nRuwCsWy
 Z5aIDAnbJ0AM1fnAsW0R2UsIujsQFuV2sL8q5vZ+Nmq9DULCZA55ZqE8QmjGv7pw2wdwLPSnL
 C91PevGvnLiwTota4ntIaV868L3t8tFD6QlD6LytVNmi6+hS6OBYYJEH6w5mnealXS0conwEm
 G82Wq2yIKFKuBuymh7JTsohAXCj3zbSiGPRUmbnx4GDVdj5ORVbmScy+YtZff0GhBHk4aWIRb
 BngdRrVm8Si49L1qrfAR8keA3gJqlFxQueSmBM+MicdksA3CEV+5Dd+/dQftxHzwtvOR98kHz
 dFJqgtIOU6DtPAwXy4y+O8jVZf8YvMLGv1k+5VQ3yv+VAvkAagpbw0WZ47/SUciQ9hcVWwUrg
 ViqM+/sNf2oWD59ZTixsDB747KEJYb020TRFFp1Pebgot47wVQkGombnQejS8UhFEc5XNFswD
 DtFcMlGkPoZYtu8kYVK1fRMoW1ZicPlYGPYmlcUTM+bRoqgTZbBukMPVi6e06y06BI57QtmqE
 WwB60rknHzfCIEFIdI1vsrYIprYZ1QVjrs3hB/CSkvdspfqH3Fer+8TP3K4MENs0oevRJxDKe
 ypRTlLm+L0hCKlM9VmRIP1m3HYSdPPZL4VWFGe16CtC8bi2eA5oDs8P12o6kctVBuv7axAvI7
 BDUel8Y7NBw3y2GE0+Ot2K1GTmF3aW2kTTkisZs4g11E6e/+PvCRz1y8fJvDMJFgMfRqGwEza
 8VUIbF3s1xYwGw7BE
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio & Hannes,

On Sat, 13 Jun 2020, Junio C Hamano wrote:

> Johannes Sixt <j6t@kdbg.org> writes:
>
> > Am 12.06.20 um 17:14 schrieb Junio C Hamano:
> >> 	/*
> >> 	 * Anonymize the name used for the primary branch in this
> >> 	 * repository, but reserve `ref0` for it, so that it can
> >> 	 * be identified among other refs in the output.
> >> 	 */
> >>
> >> is the minimum I would expect before calling it an improvement.  We
> >> could add
> >>
> >> 	It is often `main` for new repositories (and `master` for
> >> 	aged ones) and such well-known names may not need
> >> 	anonymizing, but it could be configured to use a secret word
> >> 	that the user may not want to reveal.
> >>
> >> at the end to explain the motivation behind anonymizing even more,
> >> if we wanted to.
> >
> > IMO, making the primary branch identifiable is a reasonable
> > justification to treat it specially. But then, why does it have to be
> > renamed to 'ref0'? Couldn't it just be renamed to Git's default primar=
y
> > branch name, be it 'master' today or 'main' or whatever in the future?
>
> That comes from https://lore.kernel.org/git/xmqqtuzha6xn.fsf@gitster.c.g=
ooglers.com/
>
> But I agree with you 100% if you literally mean 'master' (or 'main')
> hardcoded without any end-user customization.  What I rejected and
> replaced with the vanilla "ref0" was to return the configured name
> that will be used for the primary branch in new repositories.  The
> above proposal suggested a faulty:
>
> -	if (!strcmp(refname, "refs/heads/master"))
> -		return refname;
> +	if (!strcmp(refname, get_primary_branch_name(DO_NOT_ABBREV)))
> +		return get_default_branch_name(DO_NOT_ABBREV);
>
> A corrected code should return a hardwired constant 'main' (it
> probably gets behind a C preprocessor macro, but the point is that
> we do not want end-user customization) for the reason stated in that
> message.

I like `ref0` better, for two reasons:

- it is more consistent to just have all anonymized branches be named
  `ref<N>`, and

- using `main` both for an original `main` and an original `master` can be
  a bit confusing, as the reader might assume that this branch name (as it
  does not follow the `ref<N>` convention) was _not_ anonymized, when it
  very well might have been.

Ciao,
Dscho
