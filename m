Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97962EB64DD
	for <git@archiver.kernel.org>; Mon, 24 Jul 2023 20:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbjGXUJr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jul 2023 16:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjGXUJp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2023 16:09:45 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A727E10F8
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 13:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1690229377; x=1690834177; i=l.s.r@web.de;
 bh=+nyPUyu9nASHvPaHMRuFBoe8/VRkcJK+1+dtqbmLaBw=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=Y/0brVrfiSumHesO0hShEXybAD3BXLDlmzrj+JTI2bLrAI5Uz3JuSbDSOStoivO9ddob7jj
 UkbcrqEJ8oAenroS2Xo0Uj6oJ8Sct20yOrz7yxQTKDisGzLOJ/47Q/ZZp2SiCTVzGcRox1owA
 1zczDwluD8PBUswz7Reb1WCsPPDNJJ3C4YY6QqM+m05Y5cjktGHdA2YhyxLAPKlmK4gQs/USa
 PkwYPNtlbaeaYzkAeDv0gOcHEuQBqUaQZgQinR+6iVFoMcUgFnJMqFc523Qdja45m75iXY2wR
 GSVvQZU4U5Yzzju0q8/VLnJej119vpfIKcr3pwdznKQOw4/T4wQQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.150.179]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MeUbo-1pnb7s3YKy-00ambR; Mon, 24
 Jul 2023 22:09:36 +0200
Message-ID: <9e8225dd-1e8b-8af2-c3e1-0c5834694244@web.de>
Date:   Mon, 24 Jul 2023 22:09:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] ls-tree: fix --no-full-name
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
References: <d392a005-4eba-7cc7-9554-cdb8dc53975e@web.de>
 <xmqqo7k9fa5x.fsf@gitster.g> <a6326aaa-4f05-4d00-8906-2f50ea8e1e7a@web.de>
 <xmqq351hz5xp.fsf@gitster.g> <43ca3f01-ba11-6c29-a8e8-4e6c262a68cc@web.de>
 <xmqq4jlxuiuu.fsf@gitster.g> <1535f30e-3cf9-1a0a-04af-4ba4a7c46d15@web.de>
 <xmqqr0oxnnx4.fsf@gitster.g>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqr0oxnnx4.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ei2mGrIOFu6Gan8KrHSkTses8ktS05YGMfZ1mS3FfdKOg8YPkt6
 2TJr63gA0tRCii7xaAyHEsCZnWbqyd9PEKz9+psocRC0Q1grPSJvh2xmErua5bIRY3LXl1u
 pL229O6I2WEh8PU6yaP7Sbi5SeUaPEBBxXR+U0Uah0B4/09wskllauyTwLD+EJuPDLwTALW
 rjiJMGOZUZ2vuXfpe0eVw==
UI-OutboundReport: notjunk:1;M01:P0:AAsI97hLJnI=;SFNHCZ0jVnTaedVZ+KKCwCXf2LH
 qUfbo6HXGJji6roarZOoyA0Bd/gEOK9PTuTPk/uWgTmq3w25xaeYciHg75u2PCgUwI59Wvw8+
 LhlveFLErOTAAgWOZJSo8FjOx/v7FJ4wM3ZAwWT+TnLuCpe1P3iwxfTXMaL/xFm4qxqT3ypi8
 WLUxBUMjqeEjKz+l3xLHd8lO8s7tqE8G8vCZa494tej5BQDSBcAXTnStwuzlpRWd++77ilAt9
 47UsttIJOcZPRHgvfFYzzXD0S6aLxsXrDLuk2qTzElNCKdgmm57ZkcuzNWib6nXDt5l3Vu8oH
 BEIel6i5eXyqwmm0EBpLhVvKjDdUHUSC8GwrAtFz+Pfhs5gYTDrT5wvzDc2Akov7TNfTIQwq8
 kz4oA5sye8IJko8fkdYryiqYBjNUI3pLd+vQenliQQTfvmZrIRLyrCHwWAzZeh1ir/kJT6n36
 CHK14MwNPGL+jia1c9JxOfo5U2A2RhYwiYVA13OFktcDaENv6hBaBUnRBB47kh1zV5YmJHOeS
 FLiq08PdtlRwbHPGlzQSTpf5KtK1khlBnhtVX2G1XgQ+aLSD2EmZqgUEpSphGgkj4KaiSnsri
 nncyldsldd5fGBhGROCqXNRiJ/IjUqPD4ntcOF8Z11YzsxdWY1qBfKGXi94UhcFsHZw0PCJQ3
 TJ6h2shBwMDTowM/Ch7nswRr0+arCTnZV4ILol9Yph5R/hogj61cNYNwxk5+QNNmg+sB7Fk23
 Fbjl+uVEvfJD3gnHmRLvEQ4kyWrtML4xe0iBLvP8sy1I6N6ogv3Ucg7QGQ+sSr0oNRqcek667
 ht0/OcAuhZL21+y0XleaYMbuCY9a7ru3g2e5KG+rpkOu6lbw91ctTxywHUFikyCNQ8m938u7f
 nBR9QghFU+5Zc2ZVbmW6zC7/NNCvTP3DXiDQVVgdsLB3qqJ97H++2eX1AU1yy3VyoEMzNW70Y
 YrxJVFZ4RocVC7m8ys50q1jZGdw=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.07.23 um 20:51 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> Am 21.07.23 um 22:09 schrieb Junio C Hamano:
>>> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>>>
>>>> -    -D, --no-doubt        begins with 'no-'
>>>> +    -D, --[no-]no-doubt   begins with 'no-'
>>>
>>> Hmph, I really really loved the neat trick to allow "no-doubt"
>>> option to be "positivised" by _dropping_ the leading "no-" at around
>>> 0f1930c5 (parse-options: allow positivation of options starting,
>>> with no-, 2012-02-25).
>>
>> Yeah, if there is a better way to document A) that the "no-" is optiona=
l
>> and B) whether it's present by default, I'm all ears.
>
> Some options take "no-" prefix while some others do not, so
> indicating that "this can take negative forms" vs "this do not take
> negative forms" by "--[no-]xyzzy" and "--frotz" makes sense.
>
> Yikes.  There are tons of options whose names begin with "no-" and
> marked PARSE_OPT_NONEG, so "an option '--no-nitfol' that does not
> have the 'no-' part in [brackets] can drop 'no-' to make it
> positive" would not fly as a rule/convention.
>
> If we do not mind getting longer, we could say
>
> 	-D, --no-doubt, --doubt
>
> and explain in the description that --no-doubt is the same as -D and
> --doubt is the default.  It is making the developers responsible for
> clarify, which is not very satisfying.

Adjusting all explanations manually seems quite tedious.

> We may not reject "--no-no-doubt" but with the positivization
> support, double negation is not something we'd encourage without
> feeling embarrassed.

Right.  Perhaps --[[no-]no-]doubt?  Looks a bit silly with its nested
brackets, but it's more correct, because it documents all three accepted
forms, including the no-less one.

Ren=C3=A9
