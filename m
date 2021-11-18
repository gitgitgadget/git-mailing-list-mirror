Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5FEC433EF
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 20:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B934E61407
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 20:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbhKRVAv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 16:00:51 -0500
Received: from mout.web.de ([212.227.15.4]:42301 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229905AbhKRVAv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 16:00:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1637269056;
        bh=tlIgBu7TEusIfbKQUzFX/rhRQVhFzTVsygc+DKDeyj0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=cQAM3c0H5F7Ka1BVFB1CxGCDKbV0KFPl8nsAFS+w55DMeeMN7cFW1sw0bPJhJFOHA
         RPIX8/LH0oYwYY96c+WE+1dAm1UqFjbgjN6ZEwIrvOuSQjyCgIuzjLb0IkfU8UzPXJ
         3ctbbo0L4ptViJLMRxFDsNr6X0TIMPFhdo9n+uBY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.20.171]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mi4yz-1mAKzh1jer-00dbaE; Thu, 18
 Nov 2021 21:57:36 +0100
Message-ID: <c5223004-6db6-e808-f607-d11bd45e7d99@web.de>
Date:   Thu, 18 Nov 2021 21:57:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.1
Subject: Re: [PATCH v13 3/3] grep/pcre2: fix an edge case concerning ascii
 patterns and UTF-8 data
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Carlo Arenas <carenas@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Hamza Mahfooz <someguy@effective-light.com>,
        git@vger.kernel.org
References: <20211015161356.3372-1-someguy@effective-light.com>
 <20211015161356.3372-3-someguy@effective-light.com>
 <877dd9i1zj.fsf@igel.home> <211115.86fsrxqbvp.gmgdl@evledraar.gmail.com>
 <87o86kv6fh.fsf@igel.home>
 <CAPUEspi=r9EsG8KPvdiD-HM7Drq8ho1yjkN_c_T1e+ZeR4eejg@mail.gmail.com>
 <87fsrwv46h.fsf@igel.home>
 <CAPUEspg8ZUdn+KFz35yG1k9bbfVTe1b+7=+WdMknRS1zu8VcDQ@mail.gmail.com>
 <634c4237-325a-13e8-0a92-09d23bdfb111@web.de>
 <211117.86y25m5wez.gmgdl@evledraar.gmail.com> <xmqqczmxxr8o.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqczmxxr8o.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jbGMVdfFo4GOrsa/2kNaVaCSz4ykiGz0/cypW5zYbOl8Xgscyu4
 5OxT4g+Fp/NMv99JxdMYRRqQhYmYq5ESiOqTKnszZpNKSn6RGNYWEPk7j+KyiIZTb90b2vh
 7Tp03MwrI7CDw2S9h4PrHCxJlUGhlO2/tFgOsimg/zjY/ZWHz0CuB24dOiKt9Y1R/cAHV2S
 CL4Z11FyCOOZOCjtTpmuA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:z0gbEwgBo34=:4g5aCo83R6UhcAfr1SXXzr
 6ReBqLFwLAaddh7dWcNlS4GyRUbt/FTGpLhJyP5MxUAeLqzkbkZyRloTwHB8IfbTh5KVsz7/C
 djzgMFlQOmHGUL9f/X1wAt3BihfKowdPgCd2cg2/crzqnU+yNNw2/uCKMghgkNekYLKAeE1SW
 PzDP+GyCmoQfuodvqbixUX4yCLX59K1lRqzM+vFgICsmU1q/26RxFSSmvm9wWvhXdTdrCPWvE
 kvEtL/W0jXtjASFj7SzOVantRGrldafkre9KOVoKWUytKa7vJc6aPRMzVS9qiM0bH6Z7IeB70
 9+Xu5+y6GL8SIHmaOidLL6sy4IQdq4xeqwZHpvIQN+DIw0k432xOotaz6p/47c5c8Tme1RB4h
 vIoPU440H5oLFfO6fYtyH4kJrZ+zQ3KYrQIkjEIHVnQ7NYoEJefd/CpspyysIQUTK4KokrRkx
 uQJCV25Wp0N3NgoUwNn9LvxMfdv0f2hw/pHnSgAQVc0AMTm4L2mqJ49Rm2tjGX2eIZo1JNN/B
 DCaShraRIxfNSm6dWK4SVEWBIBbxLnWVs5WB7WD1gQi+hZ2X71Dzqt5inuZX2dbw/evn6hkl+
 qtf7CHSXkrhVYwiDS8geoZumzNCEYEm0evGZIoRoiAovS9D5ORXTKn0TxD3rW9QjJogsP0Nao
 EnY01xrS+knS9YJZMyeSK0UTzr9PB8+eF0ruqRoaFdyahDXHXXoGgRx2DEoLqzg0mhJoJL7NG
 OGzR95kdENQlCQ/D71gvjxD1MFc4gehkqS4ku56gZN7TIjgM4v5qE1E4gi0WMzlhtPUI9B+vh
 68xwZBEToz+wO97fSw6GQkV1BXoNlfQl788xkTfHec4eMH9TBGRH6CNrRZVvJH5OpHwaShZxL
 UAE7To9mQEiLjMd/C+BMaHdsD9CkwO0fVfAryNRPuZ9IFVV9QP4TGKJHjx3Qw83EOQHNOCOc4
 ysQ7g8Eq5KoinZcNanNiZfS8BshzxBt+uCgdT7O9Sqzwq8G/MfUGr+9efTU1oZcVYeG89Ym7P
 IzVGBqtIo+tIjsYlQwJBsT/u5i4Myq0H8fYf6YTrLxbqULe2EJ/z9+nbomdh8GwnJw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 18.11.21 um 19:17 schrieb Junio C Hamano:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>> Let's have a look at the map.  Here are the differences between the
>>> versions regarding use of PCRE2_UTF:
>>>
>>> o: opt->ignore_locale
>>> h: has_non_ascii(p->pattern)
>>> i: is_utf8_locale()
>>> l: !opt->ignore_case && (p->fixed || p->is_fixed)
>>>
>>> o h i l master hamza rene2
>>> 0 0 0 0      0     1     0
>>> 0 0 0 1      0     1     0
>>> 0 0 1 0      0     1     1
>>> 0 0 1 1      0     1     0  <=3D=3D 7812.13, confirmed using fprint() =
debugging
>>>
>>> So http://public-inbox.org/git/0ea73e7a-6d43-e223-ab2e-24c684102856@we=
b.de/
>>> should not have this breakage, because it doesn't enable PCRE2_UTF for
>>> literal patterns.
>>
>> PCRE2_UTF will also matter for literal patterns. Try to peel apart the
>> two bytes in "=C3=A9" and match them under -i with/without PCRE_UTF.
>
> Sorry for being late to the party, but doesn't "literal" in the
> context of this thread mean the column "l" above, i.e. we are not
> ignoring case and fixed or is_fixed member is set?  So "under -i"
> disqualifies as an example for "will also matter for literal",
> doesn't it?

Correct.

> In hindsight, I guess we could have pushed a bit harder when Ren=C3=A9's
>
> -	if (!opt->ignore_locale && is_utf8_locale() && has_non_ascii(p->patter=
n) &&
> +	if (!opt->ignore_locale && is_utf8_locale() &&
>  	    !(!opt->ignore_case && (p->fixed || p->is_fixed)))
>  		options |=3D (PCRE2_UTF | PCRE2_MATCH_INVALID_UTF);
>
> in https://public-inbox.org/git/0ea73e7a-6d43-e223-ab2e-24c684102856@web=
.de/
> (is that what is called 'rene2' above?) was raised on Oct 17th to
> amend/fix Hamza's [v13 3/3]; that would have prevented 'master' from
> having this breakage?

Yes, that the change I meant with "rene2".

> Carlo, in your [PATCH v2] in <20211117102329.95456-1-carenas@gmail.com>,
> I see that the #else side for older PCREv2 users essentially reverts
> what Hamza's [PATCH v13 3/3] did to this area.
>
> +#else
> +	if (!opt->ignore_locale && is_utf8_locale() && has_non_ascii(p->patter=
n) &&
> +	    !(!opt->ignore_case && (p->fixed || p->is_fixed)))
> +		options |=3D PCRE2_UTF;
> +#endif
>
> I guess this is a lot of change in the amount of text involved but
> the least amount of actual change in the behaviour.  For those with
> newer PCREv2, the behaviour would be the same as v2.34.0, and for
> others, the behaviour would be the same as v2.33.0.
>
> Having said all that, because the consensus seems to be that the
> whole "when we should match in UTF mode" may need to be rethought, I
> think reverting Hamza's [v13 3/3] would be the simplest way to clean
> up the mess for v2.34.1 that will give us a cleaner slate to later
> build on, than applying this patch.

Makes sense to me.  It gives a better starting point to solve the issue
afresh without getting entangled in mind-melting boolean expressions.

Ren=C3=A9
