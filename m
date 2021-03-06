Return-Path: <SRS0=58cf=IE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C8AC433E0
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 19:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4BC2650B5
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 19:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbhCFTJI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Mar 2021 14:09:08 -0500
Received: from mout.web.de ([212.227.15.3]:35653 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230346AbhCFTIy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Mar 2021 14:08:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1615057719;
        bh=eHlDonmO13ypxNGi6F7PmKXHcko0UdaT/Ofka38GdKU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=O7XB02Grzrp77l6JRFEs2LlfkkquKtWq611p80UwaaxBja2vEH12I8KtJhDXyxzXP
         jCsmWgzNhksJoRR8hnbe4pCUSnOVT3DpI/FlILAZnN70GThXZZc7bXLGBupsqqpT8U
         SbrgrLyyPmWmY7SlmSs9EjMNsRSjTbJRaNW3U0Qk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.24.70]) by smtp.web.de
 (mrweb002 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0LtoCT-1ljfiU2wT7-011Cdh; Sat, 06 Mar 2021 20:08:39 +0100
Subject: Re: [PATCH v2 0/4] Makefile/coccicheck: fix bugs and speed it up
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Eric Wong <e@80x24.org>, Denton Liu <liu.denton@gmail.com>
References: <20210302205103.12230-1-avarab@gmail.com>
 <20210305170724.23859-1-avarab@gmail.com>
 <3aac381e-2ce9-e35e-498c-9c26df235aed@web.de>
 <87ft18tcog.fsf@evledraar.gmail.com>
 <c654c7f8-bcdd-ab58-cddb-a1005a9b8914@web.de>
 <87czwctbim.fsf@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe=2e?= <l.s.r@web.de>
Message-ID: <e2a1c84b-4dc0-e5db-fbac-16be0135bf81@web.de>
Date:   Sat, 6 Mar 2021 20:08:39 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <87czwctbim.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:toedsigQKOw4RAaFG8ZeaJsEcpPhxzXuGmSgfnwaqtDWxZo7wSx
 3tizsQlszzFKBccgUFZQWDXojRlKfBEgvdM3wWTCJw1HYVXkfndMR/CeelKKfX6isfj/kWF
 K7wNp+Nlg7yMPJlRNru1Yq7/4D2SPL8WkL6B66FVD/rdx6fEfixmB056lLzkEdfKQ0FOE35
 lJCLT5C6mAzuTzztQ6R+A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8pWmFgFtKYQ=:Jc247620d8WMw/F6LmHXx9
 PSQ/oagFZDCi1eGNCeYNWaE4WqMvSjggYqkAXN3EqqTJVniTZwUXUcL05Sc1Lg3/wz4ChLfrK
 c4qdMEdtLhY2NigFpsOAfThrPzkgdF2MU6OAc7a6EoF9pE3Ib66/RifXIYuXrMdJNImjiMhjU
 u0aJANKQvM5LKs1IXtV098XkKwOWDfNU9XEySOyH7VJHqHW6g/lHapzUPs58LLLdu89EVA42t
 00D/0TbQx+WpzRk/IRvdYpCWEB+hRBoZrvcpvbpZs+kSgA8EqywoLHzInrjfoVX/vDvIT8rRs
 E3sYj3uxYgCq7wtBGIatOj+ZHkcL4KVdhnBGok4d3Fuz7qoLCH8B+pZfgbZi2vCsL6Ho/GZwI
 Qg+A6Xi4Fc4dgMtfTsO4Bq1xCmYcEytCUllogyiHVeOJ+Vx4wiHKz8tD/nsvMsFBzegaUS7/e
 if8VeXT9VA4dU68XOxDC7SUsZxKITE6dqz1tWMxQwIJ6QgOW45RXdchGd+SL6nK4DDS/AF+NA
 iAm0UldmB7CXgjToEI3ochUGRxA20dheDutCyBRqb8xbt2shgDEzwcO1FlJg2R6UfetvrQKIp
 72y8T2YSfuEK1LKMhTD9R3A4P9BBhc7G9tztaktmvMuYDKEDoySMSY7HzLwXCcOkFjK9Y8WUY
 rXE5XXBXTnib5raJhdjPLw02I6TJETDGJnmfQg7I+CRBNndDWJyAhIji64E3sOihXr1vGZMO8
 plvzeLfUTZUUP3k7Odsmdf5efPtaZuZ/TT/233s3W6DY85HaPkCUbtJ/uwqRcFD00970id8f9
 liGcWTS5glgCbVwbgq3jXZuAbY9tWexp1wiBU2L1VoSlqoqqF8KRK0KxqxC+hJx/owU8c3Xk3
 Rb7nkSga78diItgGSdVA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 06.03.21 um 18:52 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Sat, Mar 06 2021, Ren=C3=A9 Scharfe. wrote:
>
>> Am 06.03.21 um 18:27 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>> Do these sorts of rules really benefit that much from the type
>>> v.s. expression? If yes we'll obviously need to support it, but if (an=
d
>>> I haven't looked closely) we can equally rewrite them with "expression=
"
>>> (or it would be good enough) we could be quite a bit faster by
>>> default...
>>
>> Type information is essential for many (most?) semantic patches.
>> Untyped replacements could be done more easily using sed or similar.
>
> We have 65 individual hunks in *.cocci by my count $((/ (cat *.cocci |
> grep -c ^@@) 2)), but only 9 of those use the "type T" construct, which
> AFAICT is the only thing affected.

I don't understand why using type variables would be the only feature
that needs headers.  Accessing struct members like in commit.cocci surely
needs their definition, no?
> There's still plenty of reason to use spatch without headers being
> included, it's still doing a full parse and knows that something's a
> function, and otherwise cares about C syntax etc.
>
> Anyway, I'm not saying you don't need it, just that AFAICT it's a small
> minority of the rules that require the includes.

https://coccinelle.gitlabpages.inria.fr/website/docs/options.pdf says
"If the semantic patch contains type speci=1Cfications on expression
metavariables, then the default is --local-includes. Otherwise the
default is --no-includes."   So spatch by default already avoids loading
includes unless needed, but we override that.

Ren=C3=A9
