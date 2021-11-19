Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136CDC433F5
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 17:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE1E461A03
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 17:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236129AbhKSRSq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 12:18:46 -0500
Received: from mout.web.de ([212.227.17.12]:40925 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232663AbhKSRSo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 12:18:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1637342135;
        bh=Euy0XMVsoxSwLLRpTV5pA5FxpCtx90TEDI5Cp1oT2/0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=rECayQ/jif8/+ADliIw0PBlkxeSIqqOdWEfjiVsQDtiNEf59aj/zZ3QexaavxbJzj
         RK1mcYBkODv35OqXlTDZh4zML00tQOxDtPn6s1dDjftsSRKNH14TzCjRwS7XL867JB
         Y7aX44Etk2JRoopvOz3Ul5D706M8v6o+38VWZd9I=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.20.171]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MZjET-1n88vY2tRX-00Wic5; Fri, 19
 Nov 2021 18:15:35 +0100
Message-ID: <fb70a801-369b-c1b1-457b-bab06688b2bc@web.de>
Date:   Fri, 19 Nov 2021 18:15:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.1
Subject: Re: [PATCH] mergesort: avoid left shift overflow
Content-Language: en-US
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philip Oakley <philipoakley@iee.email>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <5eabbe1c-4c0f-559a-da21-423afec89e7e@web.de>
 <7fbd4cf4-5f66-a4cd-0c41-e5b12d14d761@iee.email>
 <nycvar.QRO.7.76.6.2111191750400.63@tvgsbejvaqbjf.bet>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <nycvar.QRO.7.76.6.2111191750400.63@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:P2FjrY34V2InyIKOCDt30WHyimGeC0BLoNGldEA9yv8E1IP31A2
 P2Kai/A1qKQQ/t7DXEFru20n93dUwcUNjMFFAc/y4ToN9K91klZBCvhehzwq8LfkgZ5m/Op
 q9lIlDr+l8UdfwAj5673WslrIuSHwqd8STdxiW/PfoPfXujbUEd5VzeuVjBXIfeMMwY3E20
 6vypY4+fzzD64ky4CTqLA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:79kuM43eYvc=:S4BHYLhipW3FpcgYyiU8Ge
 MHQ/jjIqGYeBPV3DT2GhxwE0RcjcBy930ZX6l7/+8nKLsXISw73rcqIVLTnHaPnVyxtitCh7R
 0HtZbQldzESNK4tVI3uiRjs+W4gcKJIewDbqpJZK7BdvQIlbA2HS1P3IVSBwn24TbEc81hmr3
 iwkK5CeyEYES1Q6iSr1/8qhPZDcx0sfQxr5mc/iCrBybAIhMp93j3ASHnuL0YAz55Sl5gNXUO
 tHSOksFqbfyZkAKjuu36HJzY4iuI6pnJtKsiJN3XIgdh9vJsAp/Pf8iykKlhdEMLRxawB0kDC
 88m5lIZ//kOlZeBTeC47Grxo1rvZX07/2x93tDcrkOaLJIXyFqlg1z5qUa64+NyKN4fe2N5Lh
 CRyqBDkKkIUkqb32foBkvyMfYXyn47MS34wulxjhJtuoMpmMmMy559VfnNhNE3OONAcpQoexV
 TYurzhpmbWmrsiAMwVcdmGpSpqZSOaqqaNV1TkoCN20cvYmqFecgwQbdPXXMn4Y69czwf9vDN
 zjiGM87P85MrmKTekXN2Z2WVlYMYuqxnN3rAkXXlid1NEc4avLSD4xm7/JBNQhAr51qohv0fG
 VugGeM+fKlYpjca/Fj2zTJAZkQWFGPDPjNLqK4lqO7gG94YbFcpE9uk4PVmIwyth31ZZOCEu6
 cfF3JFesh0sRQVK/q3MhecE+XbYeaJe5+5oacVPcV5FvIHFz1zwUqDzYTwyZz8ZBwevxuIP/B
 tF8VNiA/T+u9rzDkeEwADqCAc20Xnyb8MsjjrX+UiQu9o+sKQ6ap0hi+pmRpEZppfyD4jvJB7
 0b5pMpQHPDX1DVpawkJOR8L4bPIaD/dmD4n5GzxOCoOtL3xy4sO73G2UZsUIbYkLdoA6e4Yc4
 vTxAvf3e770OeWzRRk6Y96D3METilvzldQSEAadDspREZJy3JfgzJXpnJZUfFkzZIm/6Prd5t
 DiVatso/BO1u99A0aOT2i/jTdYoCEP/BdXiPT2y3EVR2Vxhuya8LUl6K1g2Io95bYYNTHDnXp
 q/lL1t0o+OFTDxUFyUO7Q4Epx92dyQva5KRS2WWg2aDw/Hk2FeUahCAz0IqKxz1zcybWlvaMC
 nV7Yv8nCr/cQ/A=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.11.21 um 17:51 schrieb Johannes Schindelin:
> Hi Philip,
>
> On Thu, 18 Nov 2021, Philip Oakley wrote:
>
>> I already had this locally as part of an MSVC (Visual Studio) fix for
>> the various C4334 warnings.
>>
>> The other cases are in object-file.c, diffcore-delta.c (2 occurrences) =
,
>> and repack.c.
>>
>> My patches are in https://github.com/PhilipOakley/git/tree/oneU_t

Good warning, that.  And scary stuff.

builtin/repack.c shifts by 5, diffcore-delta.c by at most 17 IIUC, and
object-file.c by at most 31, which should all be safe.  Shifting by 32
or more would push the 1 off the right end, leaving only a surprising 0.
Phew!  Definitely worth fixing regardless.

> How about rebasing the remaining patches from
> https://github.com/git-for-windows/git/compare/main...PhilipOakley:oneU_=
t
> on top of `rs/mergesort` and then submitting them, to avoid duplicate
> efforts?

That would be nice.  I'd also don't mind if Junio took the whole set
incl. the mergesort.c change instead.

Ren=C3=A9
