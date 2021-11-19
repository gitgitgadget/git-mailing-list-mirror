Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5E1C433F5
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 16:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7F0561A89
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 16:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236221AbhKSQL0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 11:11:26 -0500
Received: from mout.web.de ([217.72.192.78]:50941 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235720AbhKSQL0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 11:11:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1637338087;
        bh=KSwObPthOn7tPcToKZIL/WMAvEJvyok+YjNBAhA4UJk=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=DnleKjm6x2NJT7zQmDXb6b+jeRaW2MCuvyT+30Adw72/GgfND+gD0BWVIFTGsq/yU
         E131EVpRKsvlCO22f1tH/UDpe1VHO/PtkhXMI8Ea4PrTCERKXm8zC+nRugK91eu5tL
         Os7VqbzNS86gDKuGOxCiZc4sTZM+VtORp2JaOEZM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.20.171]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MRW2R-1mzsWY2QCL-00NKoA; Fri, 19
 Nov 2021 17:08:07 +0100
Message-ID: <d1509690-0341-b6ef-5fd4-878ebbdfaf39@web.de>
Date:   Fri, 19 Nov 2021 17:08:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.1
Subject: Re: [PATCH v13 3/3] grep/pcre2: fix an edge case concerning ascii
 patterns and UTF-8 data
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Carlo Arenas <carenas@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
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
 <c5223004-6db6-e808-f607-d11bd45e7d99@web.de>
 <211119.86mtm04og8.gmgdl@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <211119.86mtm04og8.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JSn1bFYI9z7BaypQ3jzG5xEqE3ivYGg8B9vbJMy6ztNc+K1CoPz
 RBPgk1JtE6RISQCIufvc2d6HrP7CzznvMH+/K1aqyj1CuhNEVjzsZTROLfCAx+C618ErCe9
 SrfxBpMdj4D2/wRvAKuHdWHM2l0dUU/PqnoxJe6ojspGJX07zYxHXEFs8bzSkmN32UchuTE
 WTEOnocilov1rJFuKGvHg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JbJF3ROF/e8=:74dFN4cUdeMwEWTVgFegFb
 nVJVFqd+8c+lXQOOsllqRoEabMhB4WharkUEb2R39ojGV/Fb3Vx12ubxOzT8GDi3In/sVFItZ
 OjtjVjbcnu5VVtMISzfWvJz8pCV1c1BuVTmGu3ImmuELZxKy1Z4WmuNqAmOW66IWs6wTg9Mcp
 xZC68E56umM2OhV978vHLZNL8EhRgyNlXWabFwI9A8mMe1GIfA7NZ9E0zSSovhMv9pCxpfoGH
 KtMLuqdyPZCO/uKHrVY4MBeKmx3kdNoUdBotbzygrv8WJIDH6nNZ4uJUgQSl5SUN4fspvdcls
 BXGTWKz1V87ndv9VRHkJrC7NlmVRJdW3mUVrBeWBYH04VO/t6evdRti133oFMUopvJV77DBdj
 LV9m+K7thb4NkxK7o/DCu1eDhWfCNGgOe8RqRuC994+OsXwnUaF5fIjwg3xQuqDF7YJw/zGa0
 eGTeiglQdWg2Q0CTggv03Gb7D3LVDQ2JnGWfdRzTQt6NVAi+PnI5GhSPWY54149DsMMJfg6cT
 +qjeAX2VjeJ5aYw+ujb9Oa6wSwlC8jbhG6392EXMyVGs9pOVqqXNshi47mJR+UC2aWbRfq+pH
 irkO8J/v9krVZMHX+2tS3B0DdprPmSUZ8StzTn/2cGmtEEO7WDHx2Fr9U5Onf+VrUJJLOYfLa
 ADeYG5aUf/pKoR76XbIIvRgkpO4jtACB85TVjEe3TzitP9c3JKsXPD+0dqYH/W50UAo1NVjCZ
 +e+A7Wv1ZdpT1D/48oB/ecV7YYuefks4AxDDZKXdBv17zbtaw0CyzThox0Z5lfWn4g7hmj3oY
 71wRm9kqjEh1GmpB3ISxnixSfxkImhjCfpFeleQUbxh3e89RaWpq5FN1z7AtMu5YyOk3aO6Ew
 FWSWtYtLdyX1umBb1buxRFFq+eekmi0wdUa+HaqNQhbHA3/yY8nWgK/ec2WaGquPunIn3Hhk5
 UaWERRgjf4uaYewLyV9ZhMvNmDBygoA8y3HtAkAxhDjR8JnIPjHIoB8oOo4jsmK50s5Gk8Pg8
 8XCEcXx6A7nd2RRWDN1uaHXCtZYJPp2KR2UiQ8lF5+e1zdNyJQvCcfKNbNyJ8AL2UpXEjByfn
 h9MPJ0nq2b8gwg=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.11.21 um 08:00 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Thu, Nov 18 2021, Ren=C3=A9 Scharfe wrote:
>
>> Am 18.11.21 um 19:17 schrieb Junio C Hamano:
>>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>> [...]
>>> I guess this is a lot of change in the amount of text involved but
>>> the least amount of actual change in the behaviour.  For those with
>>> newer PCREv2, the behaviour would be the same as v2.34.0, and for
>>> others, the behaviour would be the same as v2.33.0.
>>>
>>> Having said all that, because the consensus seems to be that the
>>> whole "when we should match in UTF mode" may need to be rethought, I
>>> think reverting Hamza's [v13 3/3] would be the simplest way to clean
>>> up the mess for v2.34.1 that will give us a cleaner slate to later
>>> build on, than applying this patch.
>>
>> Makes sense to me.  It gives a better starting point to solve the issue
>> afresh without getting entangled in mind-melting boolean expressions.
>
> Yes, agreed. As noted I haven't had time to dig deeply into this, but
> from what I've seen so far there doesn't seem to be any obvious way
> forward in terms of a quick fix.
>
> I thought perhaps your patch would be that (but I haven't looked into it
> carefully enough), but since you're on-board with reverting & retrying.

That patch should fix the edge case without any side-effects -- at least
I haven't seen any reports of ill effects that would apply to it.  It's
easier to understand and reason about when applied after reverting, I
think.  But it's only for grep.c and I don't know the situation in t/.

Ren=C3=A9
