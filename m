Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6ACC433E6
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 16:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B06A64F10
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 16:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237951AbhBDQTB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 11:19:01 -0500
Received: from mout.web.de ([212.227.15.4]:52617 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237807AbhBDQSd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 11:18:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1612455391;
        bh=zPSGM7v5cPcHxDrkuBHomAdpeShWgbSqDZ7N8OybQu0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=VTGdaE5F3zlTCfQoQ9h4wdSt+At37Y+YG9JxqPSoaNlaljAktLFzKLwIXoapGfxpZ
         zl2zwIsNuh7BRZKbaj2NVJqjliTqJGa/4RaYnHWXmYkhB3QZldMP0PXK7Iyij3PMhu
         oIDtO3sFCREH5LVZu0vKNKCB9mwiVEPsyVbX9yuM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([91.47.159.90]) by smtp.web.de
 (mrweb006 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1N3Xjb-1m8MLk1W9z-010Foh; Thu, 04 Feb 2021 17:16:31 +0100
Subject: Re: [PATCH 14/25] pickaxe -S: remove redundant "sz" check in
 while-loop
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>
References: <20210203032811.14979-1-avarab@gmail.com>
 <20210203032811.14979-15-avarab@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <4ef09db7-34f2-2fb5-b9e9-be69c7102787@web.de>
Date:   Thu, 4 Feb 2021 17:16:29 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210203032811.14979-15-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mPL339FM+TUHFw305kVd/ytWbXRmBRPqzMWYnCpF3eFoSNvEIMh
 ng5Mbi46mfPEJnXhLFiWvkQkyF1FLtMqIcQtjp5oSCB7Dh/Q6hwdL3s3o+pD/nt0Ohauxvi
 x1MKS8vSG+oHMPDEGPRPio6jL2U/Ey64J2PSKaVQfeJbdZ8WJTxfVyfr3zPkUBtv+YcxHJ6
 eu7WyWQifA7G263w1Ot+Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bvpfF7d+1Xs=:g7/QcXWu+hJTjZYUH0vobr
 4BR5pE99PLFkoN4Tmy3OmreFBsLqawA2qTE4fg6PxL8B3F9sVwfI+5QZrAqyQYgarUAAGEzEV
 Z+/6toTxQ1Fxw2wCELGZafaTW9ClbhBu4pHbzSpfWf+DjwEpLr7A2v4292TggCs+XodkIATHY
 NZ5+hmaf702Ncc2W8YmLmLmuWK/u65yqfudVHUo2DxeTdwupuXNfWzbkwXodIKPUNA8Q+sfIf
 cTcxEnqlvdDCkq83WJ2ZZGApjJiJcz1IeYW3oaqldY8W+Z6Omtibe1KN6qov3XLvBgVd3VKjn
 xltwfk15zCVFy/kLtAW//R0k8+HblqX7qRYe9Kcsij5/hznneFNm5bmy7pbJdighT0owOuf5J
 eNy7avZ7Kb3CzHz1CZD4hnGSegYUiNSHk0GCDjuPuBxsf3bNcmm57mE8b2by3I46Bm/Kgrdhr
 12JWTi7cIiply2ehmUdJTMrk4obtk1E48ECvpDJx+xa6hnudNFIfs3CG3Ncbhmbox/hC+V8VW
 9Id+c+AvhUYWhWV2/P9S7FNjPe6sdu2cSzPkwWXvduG8NAtixwpTplJOeCRqVEV6yuFsn7kO/
 7Kq4+27TzRGFdvNQvqhkGFv6npozqeI50R9Bs1RkW51iatx1vw9FkWGci4lzXSeG8LVdWd4Qb
 2OrGp5dx131NUWpMdQZMMJ8tKrGNTRp6Zz0clhqxhmAXoGzU9Lx8pBCsL/Xe6Vj0jLDdmnn7f
 ce5cNbVH081z1MIwhvHoNEZd3oMEsQSQoSTkYBb0NNhevjuMXE+8aQGp8hpCBNemOzHr12qSV
 BSJSbQh15JUp0vlDvRHU78OawPiWHpM8K2D80vJ67wYnzGZkV4YlVoqHMCTMULG9CnwlW5+P8
 24qWd9hinFyjY6lS5UaQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.02.21 um 04:28 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> If we walk to the end of the string we just won't match the rest of
> the regex. This removes an optimization for simplicity's sake. In
> subsequent commits we'll alter this code more, and not having to think
> about this condition makes it easier to read.
>
> If we look at the context of what we're doing here the last thing we
> need to be worried about is one extra regex match. The real problem is
> that we keep matching after it's clear that the number of contains()
> for "A" and "B" is different. So we could be much smarter here.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  diffcore-pickaxe.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
> index 208177bb40..8df76afb6e 100644
> --- a/diffcore-pickaxe.c
> +++ b/diffcore-pickaxe.c
> @@ -82,12 +82,11 @@ static unsigned int contains(mmfile_t *mf, regex_t *=
regexp, kwset_t kws)
>  		regmatch_t regmatch;
>  		int flags =3D 0;
>
> -		while (sz &&
> -		       !regexec_buf(regexp, data, sz, 1, &regmatch, flags)) {
> +		while (!regexec_buf(regexp, data, sz, 1, &regmatch, flags)) {

This will loop forever for regexes that match an empty string.  An
example would be /$/.  Silly, perhaps, but still I understand this check
less as an optimization and more as a correctness/robustness thing.

>  			flags |=3D REG_NOTBOL;
>  			data +=3D regmatch.rm_eo;
>  			sz -=3D regmatch.rm_eo;
> -			if (sz && regmatch.rm_so =3D=3D regmatch.rm_eo) {
> +			if (regmatch.rm_so =3D=3D regmatch.rm_eo) {
>  				data++;
>  				sz--;
>  			}

Before, if the match was an empty string and there was more data after
it, then the code would consume a character anyway, in order to avoid
matching the same empty string again.  With the patch, that character
is consumed even if there is no more data.  This leaves 'data'
pointing beyond the buffer and 'sz' rolls over to ULONG_MAX.  Oops. :(

Ren=C3=A9

