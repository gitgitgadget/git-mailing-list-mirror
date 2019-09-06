Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2C0E1F461
	for <e@80x24.org>; Fri,  6 Sep 2019 15:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732090AbfIFPFd (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Sep 2019 11:05:33 -0400
Received: from mout.web.de ([212.227.15.14]:52963 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbfIFPFd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Sep 2019 11:05:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1567782316;
        bh=4v9bF4av30ZdurI2mUef3oAXW7HxWCwNOG5zVrXmCpQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=evl49MLmCEHXH5067STU3or3FC5lQHqbTF+ngtoKdee3/8CPMqtFvBeN8u5Vr6Joh
         hIDJbB8cj4WRWFDKt6nhpn7jxkvbaPoomg1XVVeTkJuHgzgX0d2V90DcRnwIHDDjBt
         rKmB+lmcFo728FCVdUJtwlCFhUytI5IWoP3MtcK0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.24.71]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MEEMy-1hvDAi06fo-00FSfT; Fri, 06
 Sep 2019 17:05:16 +0200
Subject: Re: [PATCH 1/2] tag: factor out get_tagged_oid()
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Sperling <stsp@stsp.name>,
        Martin Koegler <martin.koegler@chello.at>
References: <1385c954-d9ef-7ef6-6185-0dad885531ec@web.de>
 <20190906071320.GA14343@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <f44b7abc-cab1-0bd4-029a-1c84cf36ec7b@web.de>
Date:   Fri, 6 Sep 2019 17:05:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190906071320.GA14343@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8Ie0MOUwBr80najyP1v0ETitM4JX6jXxdmax9ekog6hh14cWmHT
 5tKOe+qcZ0p5xsJsvzacqEXwYBP3bevvnm7c+yjAv/uDtOkwyXu+PsLojO0aTSu6+yGZ/Nw
 AHLkZc1g7yl52IjnjNoyV+f9Gyj1jmc3QCY3eaYp/1m4DKtUAd+6LOPRLyLxmGEVz4Oi/vk
 MoZqfMusKWCZPU5YPjWvQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nFm/3Qb8xV8=:xBZBmzU0n65d6ng32xpH02
 QuyECaqS6ZfNaR8LOaZJ2ChuNCPWbrsQEJ1oJPeALX3GhlxbqcD0A6KHAz0IHpIapzEaBx2/n
 3ZCzhcMDe+LnLhhKpCBYaGInjzZzvgWcaXK0+UX6awGl1NSAxRuJEiV41N+fAyXTkp+cX2XoO
 JgjWaWu4Lw6kkPXosBZVmnDcs0wriah/UIKQQMAz8syaPPw9t3Sdlk9CIVhr5lH3ZNJkFnM4a
 pzh30WXu+SxAjaLeUlsqlMl0vSOphxXsBj59sl9/3XZUJYyLIV3g/ZEvEeFQxbv88W1Vre467
 gj0SHzxzullDyfoI5prWClEkgLyVhw1HBcT33gPBTEHXbdLyfZACGVxxQpdciTx/27ScNOE8S
 rS/yJQoWlTQKMhacmZWJI1nf5NY8VEA6GFvEgHJZ+ffbHwzqdQ8hAPjfXZiPk3kROWMWQmDFH
 bwsCGDxboO5+5HR8kXuEEA5WE2vB1dPCBHF67h2WBbJ90GRTRo/chU4dnvFTFvqwRQhJM/FxU
 OgjYVlfsIE5DG/qhuAW7tzOq8FBEbWsNAE0e404jSqgPi/iilgXk9aI++nC9oH3aJQwQdvJrP
 LjHRvEoiF9LbbjkhDjmecIo3My1muYfAkwbI2dtXuIqUsXjeIMHTNv5eb0PDtfGsYKqA6PoLx
 syBlFHukRHWhns4uDaVHal12i5N33W2AUwwhtCniiWLvQhqqtgpxzw9Hznbaw+HUk6TvaEKrk
 fQsIvXOFPw+YAfSULz+7fKTwPuW9SabcQDkkDvCsCXxUQziU1YyKKCyAdLORCgnAC1gdt0fM3
 dWV37rW4STi1hAK+dco0ibT+EKXk8N+NF/2M4eqSLtuS9ZeSbWj92VYGb7Dq6EbXuTJDcigK2
 yeT54nlIBp1e+tZztlsT2cMWoAblYLR6Ulq7cQip/1AxHkF+22BfJeB7VXgV6NTdm+SqGvyU/
 oyOHj952BvEIBNaj2EYN65UG9O1JWn7QBAZqHrtmBBSUkmYxjLn44uFXHGVqVWAiK65rS/8BJ
 clwfhVrFVulBjncOtd1GVAepocK0d1N1Cm0phgHlUaex3c+1AvNL1AlSxgGyf2QYugKanbn4Y
 lbpVwDVeB5hY2LRcEC25SNzeSNedh2IVoAXty4yeXndB8ad0krw2COCNHlcJrVXUY4hni8fWb
 1dqxG6HyRMLaU4spsq8DMrhr8+GyDrbKJuB5WXn6FWgpAa6yiZNOgvyoeaA618T7T3EUQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 06.09.19 um 09:13 schrieb Jeff King:
> On Thu, Sep 05, 2019 at 09:55:55PM +0200, Ren=C3=A9 Scharfe wrote:
>
>> Add a function for accessing the ID of the object referenced by a tag
>> safely, i.e. without causing a segfault when encountering a broken tag
>> where ->tagged is NULL.
>
> This approach seems to pretty reasonable. As somebody who's been
> thinking about this, I'd be curious to hear your thoughts on:
>
>   https://public-inbox.org/git/20190906065606.GC5122@sigill.intra.peff.n=
et/
>
> which _in theory_ means tag->tagged would never be NULL (we'd catch it
> at the parsing stage and consider that an error). But we'd still
> potentially want to protect ourselves as you do here for code paths
> which don't necessarily check the parse result.

A tag referencing an unknown object sounds strange to me.  I imagine we
might get such a thing when the referenced object is lost (broken repo)
or purpose-built from an attacker.  Could such a tag still be used for
anything?  Are there other possible causes?  I suspect the answer to
both questions is "no", and then it makes sense to reject it as early
as possible.

But I may be missing something.  In particular I'm confused by these
patches from February 2008, which seem to suggest that such tags should
not be reported in all cases, but sometimes just silently ignored:

   9684afd967 revision.c: handle tag->tagged =3D=3D NULL
   cc36934791 process_tag: handle tag->tagged =3D=3D NULL
   24e8a3c946 deref_tag: handle tag->tagged =3D NULL

So is there perhaps a use case for them after all?

Leaving that aside: The parsed flag means we saw and checked the object
already.  That is true also for broken objects.  Clearing the flag can
cause the same error to be reported multiple times.  How about setting
it at the start as before, but returning -1 from parse_tag_buffer() if
.parsed =3D=3D 1 && .tagged =3D=3D NULL?

Ren=C3=A9
