Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71AF8C433EF
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 15:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 566C361101
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 15:37:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237658AbhKIPkb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 10:40:31 -0500
Received: from mout.gmx.net ([212.227.15.18]:38533 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237909AbhKIPka (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 10:40:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636472231;
        bh=Rs6OEjt6a3Yoih6WNAKNXj28gYjNuM6gDSrQb3asR+E=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=N3UWClDnpt/2X00Ws78NTtlBypZ0pz+aCv0DfpwCkEtWyTMHS0yevjvNQQ6AxkexS
         amsIOQpG259WcDBzlgnT7BGlLUif75g7l5DUFdeMc4dRe71q+/H/UaLNe4pvQBkybC
         cloFo4h/qvFu6sxhjRl6O4jeKvL/xc1bRlrC9x78=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.22.201.164] ([89.1.212.10]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MEm2D-1mvDki2AH5-00GLKr; Tue, 09
 Nov 2021 16:37:11 +0100
Date:   Tue, 9 Nov 2021 16:37:08 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Anders Kaseorg <andersk@mit.edu>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, Andreas Heiduk <andreas.heiduk@mathema.de>
Subject: Re: [PATCH v3 2/2] receive-pack: Protect current branch for bare
 repository worktree
In-Reply-To: <xmqqzgqe448a.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2111091635531.54@tvgsbejvaqbjf.bet>
References: <alpine.DEB.2.21.999.2111081515380.100671@scrubbing-bubbles.mit.edu> <xmqqzgqe448a.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:wbveqBD/MFEZwpB3MDjQzj6QQ9X0F1T6Bexo7LPC3VV7ClvG8ei
 P8thU912vWPgEdjsIKC0BZRdk8GpFGjvRdAgatVlEHuWx2HerkUgzEZpOiXIxc/1zIS9Im8
 lCVM0MaNht41dsBWu2NkelOUzurvMM1NCLpNvcywi8FpspmP47EZfNnq6GQu+XgTRKjRgZJ
 6y9vuL4/ghZHsYREqHFBg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:a5vuDh/KU1w=:iRaM/DYlV5IsDyV00j2fWy
 qAwknpctlrJ6CXyRggKF+cK47EfHTHe8cbMaV4ZWn8wjwhZZOW1TzVOY5ojeLujRAmyw2nY+1
 EUDhws+P4y+Q1wimJ9a7BOuHwLwuCA15axalsCUQZ5VOCzFTyExfupCsIaJextKb/LEhf/wpg
 x4S5XZQO5nSiPvuLN+uMGCdfWloR+kZ+c9BrM/tNTgKuF07xFP0wVzMNIJxeCvmvZaq4+sI2J
 v3mlA8ykg9Coera5xDjL01GP2YKI6Eui3WBgBd7ynsZcH1dIr8HnNn+UPtudwazzDtGkAMG89
 znA1p380sH8tL+l6lOICJdSr51+LwuSY69qD+jy0I39WWpqUF2VNBdnDaWKsRLDboWyF8o34s
 lQVxysjGbYsInFzx47vkLFKJf4mf8vp6eS16XsaVAUb33yAr92uEgYgg8XABcUCHGeXBMM5+J
 nmpGTJsWop16eVv7f3uwF2p0XLozxbhhwBSxyPeYZvoHMaoEtU3HIkC/vJpoo46ujkKgaFUor
 UWi6CM5EnODjofefrYIuua5Q73SiKYEPoldQWaipmcR2soTVwB9TU5YIydMgC17m61a/WNfh9
 bt/VbVm122+x8BZRftMKibxhyGWi7CkKh1thDaRWbm1Z7gMbBEa0R8pdlmMQ4xizCeGMQgJv5
 bWxDohJHWYsXWJv9aPNOd+r5K9a/iP4D78gW4+9iwdVgegEbXfUiqBzIp8B6uWO8szAKt3AXt
 krXONxfbMHNPMpFSyc9zET0bi3qpXtOIJPHLMS+ylXHK2blynmjd7upbFKX6oF+lfotsd8hle
 uAJKbiIInB7F79i5O0DE9jXJ0/WbObHhbZaJEgbuTHNrZE37pS3asjUZaO6aqj3RbUYrlSoXF
 MCf0As51v/SX63WP+MJiGRa1Z2oTi+1hS98slPaEcHqPjqWYYFy8LXK0SMzfIw9psG7mEdxRg
 GH3Y0Ed8CCnvl+MzgMb0aKe5NBXOFa2cVptH0hhyK/C4Op9UVruOrDRpeCFFmdAp2bRWQXXcx
 BRqrjztwR4oR5Ike/4+dWCXwy/8svuyIAs3HRFDHkEkUBJ5oiVU3WOwxnfzCz6wAoJG6DePiw
 CcgcM9GS2X9HzE=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 8 Nov 2021, Junio C Hamano wrote:

> Anders Kaseorg <andersk@mit.edu> writes:
>
> > diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> > index 4ef4ecbe71..52a4686afe 100755
> > --- a/t/t5516-fetch-push.sh
> > +++ b/t/t5516-fetch-push.sh
> > @@ -1763,20 +1763,25 @@ test_expect_success 'updateInstead with push-t=
o-checkout hook' '
> >
> >  test_expect_success 'denyCurrentBranch and worktrees' '
> >  	git worktree add new-wt &&
> > +	git clone --bare . bare.git &&
> > +	git -C bare.git worktree add bare-wt &&
>
> We create a bare.git bare repository with a bare-wt worktree that
> has a working tree.  bare-wt branch must be protected now.
>
> [...]
>
> >  '
> >
> >  test_expect_success 'refuse fetch to current branch of worktree' '
> >  	test_commit -C cloned second &&
> >  	test_must_fail git fetch cloned HEAD:new-wt &&
> > -	git clone --bare . bare.git &&
> > -	git -C bare.git worktree add bare-wt &&
>
> It is a bit sad that these two tests are so inter-dependent.
> Depending on an earlier failure of other tests, this may fail in an
> unexpected way.

Indeed. Maybe we should keep the latter as-is, and add this to the former?

	test_when_finished "rm -rf bare.git bare-wt" &&

Ciao,
Dscho
