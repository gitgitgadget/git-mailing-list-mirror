Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B56C4332F
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 15:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbiJUPTT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 11:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiJUPTR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 11:19:17 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37B8277099
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 08:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1666365550; bh=VP01CVz1e5+9L+EkZjW+IW2sU/dWAqMwZDq6HS7Akx8=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=gFie5L4Ylo/9/AiTP4nz2SGr2PiTXWq6aFJcAlkM2JCFvvFOqgqMEXSElsFQy7uza
         sKUhmNyQqoBvGNGD5uJ0aQs7ZoMhY2U/u4N17+HADBtcYHV21+2RlqzXaOI5D9uQ5P
         8Pl2NIRMXF2bWdVm1TGBiBsujGIjBdhRYlEjBddVdcuHaE2KRwC17tsbRo+SGAZXeh
         qTk5+kmEIMNJWcUF6O0wb36/IflTzJ5oHgisL9hgDcKmsKgce1CojpBIXnY88uD0Ns
         RtK6A/QQTmimA6kN1SK4rv8/pnIU5LojHI2W8D1VZMyFmE/tJvxs1fj71c/oOIItqe
         nVuLP3vzM00qg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M2xvy-1opC7O2XRE-003a9u; Fri, 21
 Oct 2022 17:19:10 +0200
Date:   Fri, 21 Oct 2022 17:19:09 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, alexander.s.m@gmail.com,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v5 1/1] diff.c: When appropriate, use utf8_strwidth()
Message-ID: <20221021151909.z3nejpnnt2wmmkry@tb-raspi4>
References: <CA+VDVVVmi99i6ZY64tg8RkVXDc5gOzQP_SH12zhDKRkUnhWFgw@mail.gmail.com>
 <20220914151333.3309-1-tboegi@web.de>
 <xmqqpmfx52qj.fsf@gitster.g>
 <20220926184308.5oaaoopod36igq6i@tb-raspi4>
 <xmqq35bv1gu5.fsf@gitster.g>
 <20221020154608.jndql5sio3jyii3z@tb-raspi4>
 <xmqqy1tas85w.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <xmqqy1tas85w.fsf@gitster.g>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:Zob4DxZRWM5S/PyzMit2iWz061h7va9uzOyYEcCHZa/8MIlEy8u
 JGL1wPmEC77g+uHYIJ+3vThZBu/sUlGZ4a12A8Ryx8lBd4vuSJiObZOJ+9PT82OildTgD4r
 x/6qjqDDPxN0GIgndombtTwE5DJJcrrzMqQPFfmb3ki37Bq0BhjwWl6jTC+GaLgnNyKHdQk
 XB++NzSuvjsqiqQ1CSeag==
UI-OutboundReport: notjunk:1;M01:P0:z+gu/hubhFw=;zC34c1a9DO2E4SEgJANxyba0bOJ
 PJpp5m/P6mrF+EIUnZIA6yM0rnTnO+8HpMZmKMuUOmcTTUxQcF947UtLqeipqFBQyxBQ3jb8O
 f2GfcyLKPIVQ2zjuGrOhj+Smqzd1gTKnbZ+5gUNNsanzjNCIRzpH5NX9Dr+sw8WJKWpo6TyQR
 dODWqYuQ8ASX2gNcrOClZN5fu5emDrWesQ8XQIPOCUOaf4X21Zc0tHlLbPN8llEUIdGLprtd6
 IBmz4+BONkDBNgT3xVopsLhIejj78H1+1uIGahkG45A7ReAISqHsc9/tlX/By9tpCKpbXs8k1
 DqfQLm0Ec8y9EipCLRobgPF3xMX7220o2VVEOXn56AYxmnwhQuFRgbNGad1nbBVG/cKcgfpMe
 1CEetzp+7iFB7Hulda9gFOzQ/n8hKcWsScqm8bD0qvuQgReM684com9u1dIzi1RadqGZwJcFA
 YiHF4UCZBX+fwiDYlEMQHItFmxJtK+65burrveIihRfOzJXAXVhL4eIt6UYc/sLc1YR6+5CwO
 Kx7R7sSNPnnnoDc9mz6FBlIkoVluNj6e9FDuNZapjSyyLTxLPJUvWUdIoZEQTZBD2THakbL3f
 BjDKKpdKiI5SVM0KC1eHC/GUTWuzRcnDHz8HsFDcg01BdQfFocG2SuySrnO5AcmqGfY/fPgKq
 pNrO01nCr13fMkFsaTVTRBH7m/qpjR8K6WUmRS1enVOetHtuZ2Dc8FmxaXjMphg5EsoczDWUz
 85MkNALtTRCXTsohUfHwmB7moRbWIv4YnsLnq0LD2gR4zIbWt8H40Xe5/Avz1lJitR5MFJXR2
 c5mST5EJNIb11aHvXUzQaPwEQOOvPG7aCnHIoZBJU5wZojtXooXiIuNWCgjGb2uZE6rm3Iof7
 nj23Tw/PtM+5rqwoTduVvzSqdSmyETg7mJrGyF+sUZZlxU3bq5zbaNeXeRi4SQym3aAk50lcP
 bWZAfA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 20, 2022 at 10:43:07AM -0700, Junio C Hamano wrote:
> Torsten B=F6gershausen <tboegi@web.de> writes:
>
> > What more is needed ?
> > To fix all other bugs/issues/limitations in diff.c ?
> > If yes, they need to go in separate commits anyway, or do I miss
> > something ?
>
> At least leave some NEEDSWORK comment in the code that is known to
> need more work, to remind others that the fix in the area of the
> code is not done, perhaps.  Otherwise, much of the effort in the
> review gets lost.
>
> I offhand recall at least two (please go back to the original thread
> to find the details of them).  One that measures the width of
> long/path/name in bytes to determine where to start chomping in the
> diffstat filename (because it still mixes display columns and
> bytes), and the other one that measures the width of leading graph
> segment in bytes without ignoring the ANSI color sequence, which
> should be using utf8_strnwidth() but is using strlen().
>
> https://lore.kernel.org/git/xmqqpmfx52qj.fsf@gitster.g/
>
> Thanks.

Good, good, good.
For the moment I don't have any spare time to spend on Git.
All your comments are noted, and I hope to get time to address them later.
If you kick out the branch from seen and the whats cooking list,
that would be fine with me.

