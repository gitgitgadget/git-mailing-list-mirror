Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3095BC433EF
	for <git@archiver.kernel.org>; Wed, 19 Jan 2022 11:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354027AbiASLLl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jan 2022 06:11:41 -0500
Received: from mout.web.de ([212.227.15.3]:60781 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353333AbiASLLg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jan 2022 06:11:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1642590694;
        bh=j2uMhwymmEziK7wHeHfuP3CMFSpCRlw1uPQmyuOMFDo=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=oeqU467VtuWT4gf6N6OeXT7arMqaVLW6SRxrxwcEav6dW5Uin3o50oraQzUqUi8M1
         GY+T1J2vmN6+v5uj96Fs1ToEdOPF/ckDLv4+UnTCaFQ1cDEF4OJcq+8oCH+31WIvar
         FWCoch53F50sMTMdr6hWFGw0MmqSKlmrdc9n1kOo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MxHYK-1mPjIM1s4G-00xjGo; Wed, 19
 Jan 2022 12:11:34 +0100
Message-ID: <b49ba26e-e41b-c597-aeb4-d76c6011fbca@web.de>
Date:   Wed, 19 Jan 2022 12:11:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] advice: refactor "action is not possible because you
 have unmerged files"
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org
Cc:     Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>,
        =?UTF-8?Q?Jean-No=c3=abl_Avila?= <jn.avila@free.fr>
References: <20220119094445.15542-1-bagasdotme@gmail.com>
 <20220119094445.15542-3-bagasdotme@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20220119094445.15542-3-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MPTjghLWVdjcIx23z1J8tVkvdsxJlkwI4f++ad9ffuie4s2Vwfu
 JMvaCbFXQOtpG0dIvSu8OZR8fAQOK3HSyLTWewlU72bqzkEy/7WxhdupdaXFNoMrb6a4oK1
 d7b5gO6ubaKFW19NEuHinysqCQO03HXb/om+ZnX5hiQqbOpNpnLB+UeecqmXmVgXKRCmFw7
 d1E4vn23I/ib8gNh8YRBg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Jey4sb5FSIU=:6ONEmkYT9DxOk+1cZd6AkN
 JWd2UmjdlfZCxLtJnfwbqoWxJ+wXsea59CPVePA5BdkWUsUpklkjFeXbrd39sVZuHMgsDsPZ/
 ggyD53VR20xK4CUoLaULxoSF0uCkK86NOXt6TR2ECpnSwhcrd2GvC8bEphRYyFn1MTjPIFzfw
 CW+B2SaHs+25vvQKtX4mO2sPyrfQxcZBXojjG9c15o7BtHd1Y3wbwTtbTB8LD7ZDH92AEFcHG
 ceeIS5s99SwiC/GHKgv94CaEOra+FDv73KbLzx5MuN/qTZRI7CJtBjzBrcQK7pzp1TG+8er0x
 C71+GMBHemjdIuYrpPjJn/qLnMWwzrjIPEQuJHQI1v1DVtWSLDXfC2bLBpfSbBGxswNNokMg6
 rhzRhNozKR4+M7avtBFzLf0vqq7AGf6ETWDnrroqxUiCjBQ1FFtkEgSaD1NBLaVWvvOhJdrGX
 gs1I2hPpWLSvF9LWPbRwRTjKzMhohsqPouGcgcUDwGaj2HCIFFc7LQJeFGtyAz9mbfGyWKk8B
 Fab/Kc6LimxLQ3Qf2a0EKox4a2CwPngWej+HvZ8FTyK5tt04V0kNi3pAt+/inixaywJAWZf80
 gQsnV6kz7enMePw7fRdVHy8zQ+y6Ax81nxbL8LuWWryN+/1YaLgVyk9EH6sglqhKGMIPwiKcp
 yOplOGYA0AXqwtvS3G0HXxaUZB62s6F61FBskuqDAgdz3eKIsg7MjaL1DgZm34lRJ3cmQkZT9
 vuwzS5Lray32RarTb3yJkZ7cdBSHSb0yxtuPeNwHoiZBjQp5eggLfmpEgsL3gLAy4PbhRDiv9
 t+TQCEZRh0iMjnLIU7DT27DG3XVgEO1FtY7EiOk0e8g1v+9n/zXjcILoNVDjc1FS9rVfiaW1V
 QZqqSbHCiDia5MB8IjYvAXomsuz7aTjKp1R8tIvT/uZrYxxzkx41Qxs2ewOY95sQhupnzzQon
 vG5EKhb2m0baJjpAbRvpH9jsWpl0CAxd3qzrkOOt55sjgOEIzHNVfpeP+1epuWI3PCaK7mM8T
 x5pcY0zNGPwb3fo+DN8gMtQaqFoYampDhyLKI9T1zrsEItBjgc2hLeZUch/tIpgPhrG3cEo68
 lgBlR7dlZb6Tcg=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.01.22 um 10:44 schrieb Bagas Sanjaya:
> Factor action names (cherry-picking, committing, merging, pulling, and
> reverting) out of the message string.
>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  advice.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/advice.c b/advice.c
> index 1dfc91d176..4c72856478 100644
> --- a/advice.c
> +++ b/advice.c
> @@ -175,15 +175,15 @@ void list_config_advices(struct string_list *list,=
 const char *prefix)
>  int error_resolve_conflict(const char *me)
>  {
>  	if (!strcmp(me, "cherry-pick"))
> -		error(_("Cherry-picking is not possible because you have unmerged fil=
es."));
> +		error(_("%s is not possible because you have unmerged files."), "Cher=
ry-picking");
>  	else if (!strcmp(me, "commit"))
> -		error(_("Committing is not possible because you have unmerged files."=
));
> +		error(_("%s is not possible because you have unmerged files."), "Comm=
iting");
>  	else if (!strcmp(me, "merge"))
> -		error(_("Merging is not possible because you have unmerged files."));
> +		error(_("%s is not possible because you have unmerged files."), "Merg=
ing");
>  	else if (!strcmp(me, "pull"))
> -		error(_("Pulling is not possible because you have unmerged files."));
> +		error(_("%s is not possible because you have unmerged files."), "Pull=
ing");
>  	else if (!strcmp(me, "revert"))
> -		error(_("Reverting is not possible because you have unmerged files.")=
);
> +		error(_("%s is not possible because you have unmerged files."), "Reve=
rting");
>  	else
>  		error(_("It is not possible to %s because you have unmerged files."),
>  			me);

That effectively reverts 8785c42532 (i18n: advice: internationalize
message for conflicts, 2016-06-17).  Why?  Having the capitalized
English present participle of the action appear somewhere in a
translated string would sure look quite foreign in some (most?)
languages.

Ren=C3=A9
