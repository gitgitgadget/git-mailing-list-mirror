Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8886FC41604
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 16:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 032162064E
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 16:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="b8KIoPKP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbgJGQbm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 12:31:42 -0400
Received: from mout.gmx.net ([212.227.17.22]:56649 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726388AbgJGQbl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 12:31:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602088297;
        bh=GMUQ3vV1eXwVZvfK2qh0mKD8iz02romNQZzj2iU9DHw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=b8KIoPKPK1oHuS1B+svFmpD0yuA7/+XJIS9fyfREf9SWKdbn6NhkCX0Nfqh7MiG9w
         a5ftV3MJzt8GQ3xQisssbdeBApV5VOOgN9wtBoD1cNpHjL4Z2x+rVFEMZ+cOLkmS8Y
         9K4SkT4P8IaDmAJG5SgFLfPRd9gYSsyprP6POqIk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.73.169] ([213.196.213.184]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N3siG-1kYl0T0zzc-00zlXb; Wed, 07
 Oct 2020 18:31:37 +0200
Date:   Wed, 7 Oct 2020 18:31:34 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Ed Maste <emaste@freebsd.org>
cc:     Tom Clarkson via GitGitGadget <gitgitgadget@gmail.com>,
        git mailing list <git@vger.kernel.org>,
        Avery Pennarun <apenwarr@gmail.com>,
        Tom Clarkson <tom@tqclarkson.com>
Subject: Re: [PATCH 0/7] subtree: Fix handling of complex history
In-Reply-To: <CAPyFy2BeHnacdqd_C8BdPntsN7FCoTciL+s8fDXGhBU0H01FaA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2010071829590.50@tvgsbejvaqbjf.bet>
References: <pull.493.git.1589176201.gitgitgadget@gmail.com> <CAPyFy2BsFLZZeEY=54evEJwed9q+Dc3TX3s1O+cr-nqwjCRHvg@mail.gmail.com> <nycvar.QRO.7.76.6.2010042124320.50@tvgsbejvaqbjf.bet> <CAPyFy2BeHnacdqd_C8BdPntsN7FCoTciL+s8fDXGhBU0H01FaA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ijLtkVPr+/dSCGhts2M98L1TfrCbTuOZ9TikWvFB0HjbXp1vrLo
 24rCoXZpTpu74gFsmJoZSCVj0ETZAlUIHrmHZknjacfTx4oFyJZGr2Xdzbjz35Rw9OO2AEs
 waXIOlF6oIXvAAzs45ir0eEy3pVjhtsAKYP4c29T6t/ivP6LqBm9egh9ChPuh5zCM8jr3lW
 c6SFAba846NZTZuCSdO3w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5jMK2s+h8n0=:M5J2k58AcnkTx3qnyDkHDd
 cgQeYlOmpN28PbQiAL3o+WUrlkAooKA0mSD/UPssegIHdJE89rX2seQZ69PIq6JV5+nQq2B+x
 Gb09o/cAN9vuGdVrvjtDNh4qAwE4G/OeaPNAC2iZJt/ps6ZrZVhlof7zb/kf/ntRIp0A7qt1A
 Tptq0VFbrE3ztdoYjYaoUQAGVeXEktdPy1utcROnRBvVSgak2cz+t2EmCp5SQ/RzbQdhTx5rs
 yvwyfnL4fwSNPThvFrtgMTm8yO4jK1Q/pJvB1ZStO1i/ZwX4aNEnQiNYtnmRhXuLt7wUNRjGT
 UOSXCVEZ3z76BLP9KH6HUd2rVSHnWH0fw7Um66Za2MhFyGgaAi4+g7plCopqRxfrw/Eapa+MH
 sUKpFDUddnVDpudn008ptFfqnyRrblNtbeADT6fEiQPmU8QAkYQyyuS21hTQxNyrPLOAyNBYk
 pyrEqvfpzq/FjHxNUr5Vc46jUMyJPwPI/l31Tm2iekbxM8OwtC6hPUPb8zFyzfTyikEkTwXBm
 b06YKWprnAJWAPXfa1vNHKFDWcYqTIHDyb8HoCxIVwmlOfETA4cuztZYxPkXVXnVJ1G9xJ6Uk
 G63qPOUWQHkbqbWhG3+2T+5SgfegAp1itPEB9x1TkZxaOJxl9wMQEJ+hQHsOOu/tN1CKBDpgS
 OK+iLNQskbMbm+d3+RgGyazVR6i/XIrmuEJM4bmoQ3ctdf9ttvWsTw5oSBEhIV8gJyJZKQWiw
 nf6vEGGFlB2Ppi9S2dLz1MRF7U++gGo+2n3irbrWdgPloJS+xRek8WMInevW6ufhlsyBADTLh
 IxVBQqHsxOVoL4OpZu46MB8oL76sqMS48E5SJkdfcTIGMS8SPfwrWCVFsd1/NHlgUp7uURst+
 D2Cb9tz6aOUZKgRCnjbcIACaffx4NQSSVokLov7jp4Fn1jIJqtmrsFtKDC2AI84cFoqmJpSeM
 0BvJ1Kx2pXnyMqIMKPc+Vg0Lt9XcXDrA1m4P/774ZzeBqhEXe+n/CYlkTiUIxAVrzPa1VolfS
 10T8IysVvbiYqEFgDK+CiKXtXBu2HjgqK9vGnaFFRnBmYeY+mWa6sB0pYDBDMd/Dq9LYyv64C
 eY+kKUvMInRsXJIYRmMoFjM21gcUDE1/xaI4Cb2CGZcJ0ILc5BNi+q0Hz7nyiC+U6/7FxpRQw
 p0i3EmBBvn3rucGstU2HAglO4BohTrl2hs/GfZk1Mx/M2XFF9DIDIqZzAAEFNXjY7KPX94lE1
 mqL+UX7YMokIUDRuPYGQjCMYsvTyaLC2vSp2hHQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ed,

On Mon, 5 Oct 2020, Ed Maste wrote:

> On Mon, 5 Oct 2020 at 09:18, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > FWIW there have been more comments in favor of this patch in
> > https://github.com/gitgitgadget/git/pull/493.
> >
> > I guess what this patch series needs to proceed further is an ACK by
> > Avery?
>
> Avery says "if it's good enough for Johannes it's good enough for me"
> https://twitter.com/apenwarr/status/1313231132721401861

What Avery does not quite understand is that Johannes has not a lot of
clue about `git subtree`... ;-)

Seriously, I am not a user, unfamiliar with the implementation details
(although I am getting a bit more familiar through the review I started
and plan on finishing later). My biggest connection with `git subtree` is
that there seem to be a couple of Git for Windows users who actively use
that command (which is the reason why we include it in Git for Windows,
unlike many other things from `contrib/`).

Ciao,
Dscho
