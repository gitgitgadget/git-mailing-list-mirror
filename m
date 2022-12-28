Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B55C4332F
	for <git@archiver.kernel.org>; Wed, 28 Dec 2022 22:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbiL1WuS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Dec 2022 17:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbiL1WuL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2022 17:50:11 -0500
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0059140E9
        for <git@vger.kernel.org>; Wed, 28 Dec 2022 14:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1672267803; bh=K0NFr54KzPneIxtc/vkRk6nF9LbcLAj6nnSMO+wRYz4=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=kujutHEz8xl6Kl3y3duOClacaW/UBY+XAB4nQWVoNvkw64UOEV6AlYon6+OLyx97W
         YmPByphC0SjC4PSxpYUcKRjnwICjIugwSgmETTRUEZYHSfJzVAYwOnQCMxs+1JJwHB
         tLJBeUXoFSDTIfsMkfnA/OlCnU1knS8dfAj3Aub5SyfLeJxzHXCm9L7NV1fV9nz93K
         IIm0x5pJxLrdBPuWZC+QIsFyizv55gpIlicseIjBU6CZpqbFhKsyqx3xzDQAchmzmX
         yL3w3IUIxx2ZWmZpmeZB5NmBkB0aeagIQqDr8twVMeTXIIgF6NabGNmRb9Mopw67Mj
         CqewD9g2s3bQA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.151.35]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N4NDQ-1ojYFx1sbW-011XHw; Wed, 28
 Dec 2022 23:50:03 +0100
Message-ID: <aabc1976-63cf-4057-c5b4-8ab00a33b8c6@web.de>
Date:   Wed, 28 Dec 2022 23:50:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 20/20] grep API: plug memory leaks by freeing
 "header_list"
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com>
 <patch-20.20-8ecc68c3e93-20221228T175512Z-avarab@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <patch-20.20-8ecc68c3e93-20221228T175512Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5/axgaRvOPI+KARefYz4qAh1aFHQc3LejZhpImHXS1a9hiktp6L
 EI9kH8OA5cKbyM9n2U/Y/qi2vb9W/suO6jCOFgSDmFwlp/ndThlGDb5/6La6xX5hddhA8Zb
 RVIDXpuUB29gW4ju9X5000f4eGGR40bobZDB94QQQCAPn7IZy0B02dLtRphZqvqRaVf0oDr
 1EnKAnP3ghHenDrlkHGEQ==
UI-OutboundReport: notjunk:1;M01:P0:QpFXtbZNoLY=;hvthGJ0rSHP38DRvmXd+K4JZSas
 XDW6GpyDB33O1IausmW/YzhV8DE7wE+jTdlW80Yx611hajY6WgO0nmILFASAuJQgI1IM2VLp6
 TIi+U+ENhSPNms+fYQQL0gxVqqlwCnTiLwvgxRUJE0vQOiDxWmgyIdBQ21wPxznWvw3+9nJcG
 Zfu0GI2EWy83Du0qfy2IjsCzXiBX87huFlfmhk2My6+PqP7c6VvqOza1cAE9su1nBr25kvvHU
 NJ++6UlG6VwnB/E3sVnEUdINy24xWXMrjHKv0q2H0pxTD/dw2OC/7NNn9jV0RHbcsPPDgw2cV
 5FoOCfzgu+erRU1rB2JfqdiS8eFuT+LLj1pwJ3QGSt8IfQV5swhx7gUofwB0/+Z7cVeVu4b5y
 cAtl2GITBuKcriiMeIzuPCvG6EWgolahRBWwuno8UC1pFUUPzDRZYlw9SaB9Rsfj5CNQrodTg
 ZnFwXKKunU0IZjp8oBQeK+43op4htxBwGsq3JHNrKc08hMqmtISGkMn1Jk6w/mLFeEcvz87BL
 faukHaDY2li8i4c6/Mlb4I1wCsJt+35FQOMn2wdgTbteJAXABtKiqAHpTWh3mg6bGSv+4Zc3G
 c5kqO8ht7EKT8GHwtV9yYkvS1OaRB2VnOtVwnBLGiPDIHA2yI6BsEyw4MrDbXzd1vWENgGbqX
 s6hMRoF6Q+pd1axOpHhPhcWnx9mK75hgrdg3o1U5LhDiWbGHhxu1T9EZ5lhi091dPkwcnJ519
 8fzQtBVG4a91bpLvoP4peejROhk3VnbwsgHcL4YjZNLCNP0Wlo1heRc6sM6w5qz+qFWE85uxp
 LFWU1o3c0SXeAWH+K3ovdFMCw1RfBxfw00nvpWJfsRvD75Odq67nU7kX/f9GLAAfztr0JQA20
 dFPmCG2yc8vYt291uOsq7wg4VZ5OcE0GXAnqo5rIaUCp3sGoynIPHcI/5CkOarzkGwFj+JwJ2
 JPcd8A==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.12.22 um 19:00 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> When the "header_list" struct member was added in [1] it wasn't made
> to free the list using loop added for the adjacent "pattern_list"
> member, see [2] for when we started freeing it.
>
> Let's start doing o by splitting up the loop in free_grep_patterns()
> into a utility function. This makes e.g. this command leak-free when
> run on git.git:
>
> 	./git -P log -1 --color=3Dalways --author=3DA origin/master
>
> 1. 80235ba79ef ("log --author=3Dme --grep=3Dit" should find intersection=
,
>    not union, 2010-01-17)
> 2. b48fb5b6a95 (grep: free expressions and patterns when done.,
>    2006-09-27)
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  grep.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/grep.c b/grep.c
> index ca75514f8f6..c908535e0d8 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -769,11 +769,11 @@ static void free_pattern_expr(struct grep_expr *x)
>  	free(x);
>  }
>
> -void free_grep_patterns(struct grep_opt *opt)
> +static void free_grep_pat(struct grep_pat *pattern)
>  {
>  	struct grep_pat *p, *n;
>
> -	for (p =3D opt->pattern_list; p; p =3D n) {
> +	for (p =3D pattern; p; p =3D n) {
>  		n =3D p->next;
>  		switch (p->token) {
>  		case GREP_PATTERN: /* atom */
> @@ -790,6 +790,12 @@ void free_grep_patterns(struct grep_opt *opt)
>  		}
>  		free(p);
>  	}
> +}
> +
> +void free_grep_patterns(struct grep_opt *opt)
> +{
> +	free_grep_pat(opt->pattern_list);
> +	free_grep_pat(opt->header_list);

OK.  Patch 19 didn't help me understand this one, though, contrary to
the foreshadowing in its commit message.  It seems quite unrelated, in
fact.  It's a stylistic improvement, to be sure, but I expected more
structural relevance.

Factoring out free_grep_pat() first and then using it for header_list
in a separate patch would have made a difference by making the actual
leak fix being a one-liner.

Not necessarily worth a re-roll, though -- the patch is understandable
as-is, but it probably took me a moment longer with refactoring and
fix blended together like this.

>
>  	if (opt->pattern_expression)
>  		free_pattern_expr(opt->pattern_expression);
