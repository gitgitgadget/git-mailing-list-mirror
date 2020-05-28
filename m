Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75CDC433DF
	for <git@archiver.kernel.org>; Thu, 28 May 2020 13:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82C3020814
	for <git@archiver.kernel.org>; Thu, 28 May 2020 13:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="BVk/zxns"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390680AbgE1NyU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 09:54:20 -0400
Received: from mout.web.de ([212.227.17.12]:44561 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390526AbgE1NyS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 09:54:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1590674044;
        bh=AKwvE9TEsfWV8JuuDKPSbU3B4l1euOj2awCrbkH/zwY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=BVk/zxnsKNlujoYtSHSPdpQc2GQK0Ga1AX8WoVOvGbarXTe6sKACcCKDCnIlsJq7l
         y60RChyH+Xr3ldU0ifi8awc4wUGF6wD8sOWea/R5GcrMCz+jO2gRAoL5XMavepCzLp
         EGlTa33CJcCzQ+44d8ZA/fVdtV0bZYGADPcLn5Sg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.155.84]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MKrPw-1jeIyy35CS-0007Ij; Thu, 28
 May 2020 15:54:04 +0200
Subject: Re: [PATCH 1/2] checkout: add tests for -b and --track
To:     Jeff King <peff@peff.net>
Cc:     Dana Dahlstrom <dahlstrom@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
References: <CACqwCQiLpZ1HFzgJw0p0KR3jXNsxkhjXmF_huzhv+qkMZmybBQ@mail.gmail.com>
 <20200521191626.GC1308489@coredump.intra.peff.net>
 <9f26099a-e77b-ede4-bee3-27382a5a0875@web.de>
 <20200523162914.GA2178752@coredump.intra.peff.net>
 <ebe696b2-bf68-ccd1-b930-dce274ec9279@web.de>
 <20200527064056.GA4005121@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <a879b067-978c-aa9f-fb51-a9e717363544@web.de>
Date:   Thu, 28 May 2020 15:53:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200527064056.GA4005121@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HZeS3FaWv2B1P/vPyiYk6eutsvy8sdMwTudJ1jqpGcg8/brr3nZ
 Oudh7IHT4qm71FMPpoCs17v/1DPJx8uaciw8d4dl0zVlAYL1e4lpP+ffuzyPU0MN2PsTdG4
 RqxZ2AbX1DmgZP9HlbGtFSuxVIPrRBlzMEXK3nZj00s2nb1ox7QLrM0RnQcMLWd61KEqMSp
 g9ZSnnDolF9Bkp8xkXXAg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tOed1W0QrHc=:M5BFAEZjnNI3MAaAwtChrJ
 icBLMJVvWgvPRCAApwQrZXrDzr1oCWIYZ9khVKYZTZPY5z9pSPZdJlaqbJf7MPLC2AkT63rq5
 J/0BIVp4IJpcN0DVTca4+tiUPuMb/9TCP/Q8vDgVxT6wfCQVBxZZXVIo+BHo3wvSnE1VQs71v
 AUg7S7oa4pHg3hIC/FP6wnE6+3+Awh63aCAIbhG024bEhTRTNB0tjclG3kDu5FitqfoZtELaD
 Tv2MZ005MXp/NdRgEpzWocMjVKLqIZ2wVLFOykS1V1Rjc+BbGkWhE7j+QSvJQIrRBoNsoG5Iv
 0qNE5R9n8ClWSDuWIVE2j1hJgiXFNfUfEgwZz/bwDSkVLFXk5r+oblw1xyFyMJ8ZuH4vihIar
 r6GnKcpN53b8Z6qtVfHEcF6hlegQKNJX4XN38TRWtrHSHjJwcBZ312Hibp7m4ReJNn8AMeZ9g
 sRCAX1ohhft5JrBH7m3ZtO7+oQKGj38nA1CskczuY5fKIPXlg+7naTVTFxYGs2SsPHmfJIhRB
 SJVQyf5b8nJaWEibOvZpDw3+gwjreBD72YhmjhRPfjR/YxLW/91OjTxYfR0pl3EZ1Lu52JpYn
 TVCRy8BOsyRxw3Wqb4SbcA6k1rOPLm7DxD3Em7U2V4IStjONTy3uOmDW0RUZioIqzdJ9GURLy
 K9dGRMnpV5ycSd+nwxJAF+ZahiM6xMsUjZhvnk2XRH6kR+8dS8FMPy+BeApNY1tmFMuaJ0ttH
 Bg4ybXaJe8zlo6SffnoXJ6MTZw0C0KGPXl0lgv8Ag2afG7jnY095ylwMoeNtXHP3BpUsNx2s4
 d7urP0d3wFHfihotZPHNntW1MTkKn3RdYzHZvv2v9+NoSxmJtle00X8YXxmsbVcxMBmWgQ8H+
 Ejqr3A1OU2mw3F+USSyVmfzVPEdFv+X+97HFL0Ii1mQ9jsjnk2RXWrWnhUxaj3S5fzX8KGf8N
 VmCG7NkMXiimXm9nTZKMTD/QVF+Rp2i+tw5wF0uUEYyzYRQ7ptuKFVITyg5TPvVQX9vTW78wE
 wfNkI/Caw84u9DQBFwjhack6uFxs8uYNw9jCCOjKlHnCfGLcNtCIWQZCRwAD0lhsui4xdYpH5
 way4rhWOIjRpet7zzUluQppEC5cjNd0fyIZOGDY3mlqnkWI0LchhgCdGaR8jiKPJ+pBgH0uSN
 Z2xtR5svrpOQYZnp9pqCrIG1MPkZHz3WiWLvI1rXKZOPHNgancsyZJJgL1Q4lR1JIa4WQ7osv
 1jKWCX1v/D2aa2AVK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 27.05.20 um 08:40 schrieb Jeff King:
> On Sun, May 24, 2020 at 09:22:51AM +0200, Ren=C3=A9 Scharfe wrote:
>
>> Test git checkout -b with and without --track and demonstrate unexpecte=
d
>> error messages when it's given an extra (i.e. unsupported) path
>> argument.  In both cases it reports:
>>
>>    $ git checkout -b foo origin/master bar
>>    fatal: 'bar' is not a commit and a branch 'foo' cannot be created fr=
om it
>>
>> The problem is that the start point we gave for the new branch is
>> "origin/master" and "bar" is just some extra argument -- it could even
>> be a valid commit, which would make the message even more confusing.  W=
e
>> have more fitting error messages in git commit, but get confused; use
>> the text of the rights ones in the tests.
>
> Did you mean "more fitting error message in git checkout"?

Dang, yes, a typo -- it's all about checkout.

Ren=C3=A9
