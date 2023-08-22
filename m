Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD5AEE4996
	for <git@archiver.kernel.org>; Tue, 22 Aug 2023 04:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbjHVEs7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Aug 2023 00:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbjHVEs6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2023 00:48:58 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D12B189
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 21:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1692679716; x=1693284516; i=johannes.schindelin@gmx.de;
 bh=98PqPIdH28Vstjn/nD3pxDCWqrzipSAccKT8bYP1+Sw=;
 h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
 b=AZ/jw/V13opaX34KWbSjqMAhYfjnHGbg9gH5Ul61uuL9X78Ydmbcxz69OuS+1BVV2RbfFsq
 WkREA/k1C7FuBv/D43k6r6OUPXslX4jL3G+APAvP/BkrbIq8m9YslXR8h7N0cphe/AWw3VRj7
 fmOrW9VErtxuYifHSPbIyr4OUzs2JkCBLNLuMnWfyxdBwi86FPgI1pocA4YJN/GzNaCkqAfZk
 RRw9/1N7tKE6xOB4ny50+fRAcZx+uRjKdTNIpCtnRE/Yv1wxzXDAb6PkkuTM57Kj4fEOf6SyN
 sCiSmMjfC4dZpWRQcOv0RKgSnuFNJ9sMxDeS5UsryO1KR09G+qgQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.15]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MdNcG-1pzFcC13Qm-00ZOec; Tue, 22
 Aug 2023 06:48:36 +0200
Date:   Tue, 22 Aug 2023 06:48:33 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, rsbecker@nexbridge.com,
        'Jeff King' <peff@peff.net>, 'Taylor Blau' <me@ttaylorr.com>,
        'Andy Koppe' <andy.koppe@gmail.com>
Subject: Re: [PATCH] ci: avoid building from the same commit in parallel
In-Reply-To: <xmqqpm3fn16f.fsf@gitster.g>
Message-ID: <99e19de6-c17d-e85f-dc58-1019aed1e2b1@gmx.de>
References: <20230715103758.3862-1-andy.koppe@gmail.com> <20230715160730.4046-1-andy.koppe@gmail.com> <kl6l351j22dr.fsf@chooglen-macbookpro.roam.corp.google.com> <CAHWeT-ZA8f-TGRwDHixAvi5kddVBbuK8LpVGJ9cjYZMsMk5ODw@mail.gmail.com> <xmqq7cpwjhr1.fsf@gitster.g>
 <006574bd-4d53-495e-8cfe-677ede521908@gmail.com> <xmqq350kjfk8.fsf@gitster.g> <ce5d20db-2220-45dd-8c39-2a52e0f9f816@gmail.com> <ZNv5PQlkn6tbUcH7@nand.local> <20230816022420.GA2248431@coredump.intra.peff.net> <000901d9d045$e780f790$b682e6b0$@nexbridge.com>
 <xmqqo7j5uqza.fsf@gitster.g> <15b89f2e-adb8-ea2b-fd74-2cbe95e20501@gmx.de> <xmqqttssqsj5.fsf@gitster.g> <xmqq1qfvor35.fsf_-_@gitster.g> <xmqqpm3fn16f.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:fxMM9YMFx7HeOvVsEpP61MC8X8o91VEsQ7EwYfBGK681lhx/nba
 0vF7VXAV1u0VQTC4/v3vHxCeaxAd4W/cv6L8a2aMGR2GsuoX4aSQRe2TxUHY+8imuNFCcvR
 SMo71PM0rPMFnAZEmh8aAYQ/t2+44/dvCeZiINk/vD3SLh5tzV/y2aKkDW9ra7Zl32qLAgX
 /YQaHGGLhdOy/cVnsoNpw==
UI-OutboundReport: notjunk:1;M01:P0:oi5SFiX63jU=;us69RS6E+ENqjnlG2bkrGtOfDYm
 c1HSVH4nQENlfPH1JhPw1BVUeQOuazC+b86xqe0jmdSTrefh+To3SQCSMBUV2vygo93EL/ZIS
 uTCFnOH2TswNe7x+ENizCu9oBhNpo48lEXGvtiuSmXY6pcXV6aKKsGoZXbReCkYlTY6bf+PCH
 XAE/N7xXtG7U+nR3NR0FroOUP2M3wvZBC7I5r8mZZU+UA0gjqfrU2bt9mC9Wz6Al2Gw2pqIbo
 0WRW2vNgEFoDuF6Ihxp4zN5UqyOp8d1H2pm3f9cDKOiNdxX7MqqyUvbnGkXlrfI6uCZPVTIaT
 Gk8T2rANDvA/A/6mxAMdEGnFrIFBEF7tCt/znWi6Mph3eGQcspPWQgEzHTtubhRSW62H6DLS0
 h1Zgs5+pysy4U1NjwdjA01PGFAn8/5fxdpjqImvYbEJqLo4enNs+10R2Q8NTdgVbnn99KpgxA
 3Ty4gACXU1u/lRntc6a5d4NSEBvSHjlrU9PF1Xb0xsIF845B8wVILyrvolB8wvz+Jdx8rPygO
 wLk00Qy6negVF9OfcS+quxhj1BZRYkNL0PpVy4ZAZp5KSjhQU7yXypcebd0NuZUYQIEODf2uG
 VAfvQQJ60KzGs5PL1MF7uLMZcW2AOqcxZCRgPqm4O4Z62ewISp9no8++6QsBO2Mow+vRhcfBq
 FPfMKpxhsj9P5wBGqIj2cf0kbEZEO82bUNO+TCpLkXuvYcCxY4Wb71dh3Xn5E3vpylvyC8ptF
 TRd+SE/f6YpwluGjU7Uofk1rWbMlrZ/8XqEE61xb0LMoIl1ufXSm7UwCGvaNpQaz33ya0/eNX
 QSoy/NgoELGMyhperixQiNaNPr7ArnLR70vbrh4Bwv5VTcAzGufcdhNjD1JRJxw6UoFIr4ZCJ
 av+ICNozKP48hvXWBE6/7M5ppRGbLld4uMj+PlsYB5ZjvG0ynS1jM6KXMY8eBtT4O5n2KaS8+
 em7/jA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 21 Aug 2023, Junio C Hamano wrote:

> If we wanted to do this, I suspect that we need to serialize the
> entire thing, not at the individual level where we currently define
> the "concurrency" thing.

Right, we'd need that `concurrency: ${{ github.sha }}` attribute on the
`config` job.

BTW there is another caveat. According to the documentation, if a job is
queued while another job is already queued, that other job is canceled in
favor of the latest one.

I have not verified this by testing it out, but have no reason to doubt
it.

If that's the case, pushing, say, `master`, `main` and `next` to the same
SHA will see one of them canceled. Which might be okay, if the cancelation
message on the canceled one is indicative enough.

This all depends on reducing the number of flakes (in particular the p4
tests in the ASAN job), but that's a story for another day.

Ciao,
Johannes
