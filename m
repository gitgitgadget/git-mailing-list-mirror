Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BA9C433FE
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 14:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbiK1Oas (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 09:30:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232570AbiK1OaS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 09:30:18 -0500
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC0B22B2F
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 06:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1669645783; bh=HwJsFuI68EqhuhJnb5RLGTubRarTTeB78kRwQLb3b2o=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=UlPqMM4fbmHhGgZlFSh1GuOmDuNYc8BLinW0b7GsvQSPQZQ8IKLCfTqs8ynmyJFOt
         NioynknOlGnCnM6xnFVb2SeqEnPwJJR6tMx5VifY1jYoQ/xR8ljj83tCYLAXe8k84e
         LzTxQPMvy0TBQyC2d6Wr6mBhiPZDgX6xyECXPAe9qY5hygBLqpBQKz1dLEZvCPnC5J
         rPcM+Jy6dNfjeHH7hGVtfgXyMjMUGd2LOFFfpKuQtL8+5axVllMG5rWQKwxhPnk3X6
         KGmr+ka0Fxn8BgJtGJViDEwuiJ1Q9hnJsTqAHelDNYwfkg9EP4d/bWfDWBICEmPv5m
         FkVJogiV7lNBw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.35] ([91.47.154.159]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MXGK4-1pW6ET2oNq-00Z9U5; Mon, 28
 Nov 2022 15:29:43 +0100
Message-ID: <c5aeb93c-763d-3eae-0150-15f6ca675319@web.de>
Date:   Mon, 28 Nov 2022 15:29:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 3/3] Revert "pack-objects: lazily set up "struct
 rev_info", don't leak"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff King <peff@peff.net>
References: <c64e4fa5-62c2-2a93-a4ef-bd84407ea570@web.de>
 <d19c6cb4-611f-afea-8a14-5e58d7509113@web.de>
 <f5779e19-813c-cda9-2f84-9fe58f745e89@web.de> <xmqqv8mz5ras.fsf@gitster.g>
 <d10de9b5-e5ff-18d6-d950-1d090d87b113@web.de>
 <221128.864jujmhgp.gmgdl@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <221128.864jujmhgp.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Rk5EpWlw5Q4I83ZGjFrd8nQ3SVXoQfx9fiqFtpWA+AV0dyEQkiN
 vDjiVoBuUgulFv7dFO+x9kEa2wxXX453BOKro9i4BGvouNUTZm8DfgpmifScHISVlIaHbvN
 DnKfXAudah19cqDi4gLIPTGbqpgEXMAljrRx/gQ4JVCB6SaRYoP5vO4gsQrPm/VZIzo37+Y
 RARcJuZbCjNqbD1i0IB5g==
UI-OutboundReport: notjunk:1;M01:P0:zCF5Rks6X/Q=;+tLLWXR771HWC987B+1ExdKrJ8k
 K+jk6Bpp+8pb2Ejvbw7UCzZiX5HZ2KNwB+ldkk+nnlurgQrcDaG+q2+H4eLTpIikBFD5oM646
 d0QIeQsLwycePtobgFMbX1VJkBQ1k2DXXAHxuZRE5KbG62BbQnFeL5AMB6jzvsCOOSEpd59Co
 QKqwn7JXUq/Mu/zdqpmT+163M3kB3JyUxZTocRcZQkckSZ29qRDfcgTO29kN1E6VdcSbfgVEY
 vmMi/IJlhx2yW+GqhdC3MExWgNMCG/N6wp9O0AgvMKZtIDAHbpt1kARCqW6dDpZzjbIZPMQ9g
 Wm/5TZCAGJqUa/3LqX1PZdlWkJZlTNSIWV6T11OY7viW4B6Jxcm4fvYvAPOoWP3z79JiXrSGr
 mtDmKs+tlYzz4OXQXTe5ETNh4c+MgeAJoQfL4uull8g/oFjb3XUQY4ONJ4IJGCV8tetuspY3U
 bbeAp78Es1drbGzFHB6wfpCpwraNDac3sfgLbiicVd95tHEBdYMsPhCME5qydYNXDZIBX25hM
 WcOyJ5hEa5OWrTa462Q8aQw32/IlgxGzfTrKIOaaH/+4b+y+ke5CabzmDZtL/7oWJ/Nji6Nu9
 4JDOK1GbSvIeXvcoibosI7bjcfW9vCYbauQaaNnM6VrOQb8sZzbwgG2UyToZbkkb5//0IY87T
 G/TpKVomMzctVR/TSncY38y5spuZdC2FO+1NR6HKoFUPHK+qkBUvhgStsGtYjUmfyIIg4gI9x
 FPHf2isLuQKax5k/P/i4aHru9rEWeH/pYE6uDlIC6WF9trU/2jS4JgBpqF1WUntco/8698rqI
 DhRIRGW4SRjMupblUWbo169I97IcncKsiwLsAWJzToc5z+fSfvwRZK3LLykR6e8W0NCAPn98d
 jtwoRRLYmttiBb+D/9eMuP8nonrhFdG0X1Ts5TgfrKcVtSOLKTahOlJuec0b/8DetCMZJxEXD
 vhp+kn/qOsYF8/7yoNLJose1+xM=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.11.2022 um 12:31 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Mon, Nov 28 2022, Ren=C3=A9 Scharfe wrote:
>
>> Am 28.11.2022 um 11:03 schrieb Junio C Hamano:
>>> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>>>
>>>> This reverts commit 5cb28270a1ff94a0a23e67b479bbbec3bc993518.
>>>>
>>>> 5cb28270a1 (pack-objects: lazily set up "struct rev_info", don't leak=
,
>>>> 2022-03-28) avoided leaking rev_info allocations in many cases by
>>>> calling repo_init_revisions() only when the .filter member was actual=
ly
>>>> needed, but then still leaking it.  That was fixed later by 2108fe4a1=
9
>>>> (revisions API users: add straightforward release_revisions(),
>>>> 2022-04-13), making the reverted commit unnecessary.
>>>
>>> Hmph, with this merged, 'seen' breaks linux-leaks job in a strange
>>> way.
>>>
>>> https://github.com/git/git/actions/runs/3563546608/jobs/5986458300#ste=
p:5:3917
>>>
>>> Does anybody want to help looking into it?
>
> [I see we crossed E-Mails]:
> https://lore.kernel.org/git/221128.868rjvmi3l.gmgdl@evledraar.gmail.com/
>
>> The patch exposes that release_revisions() leaks the diffopt allocation=
s
>> as we're yet to address the TODO added by 54c8a7c379 (revisions API: ad=
d
>> a TODO for diff_free(&revs->diffopt), 2022-04-14).
>
> That's correct, and we have that leak in various places in our codebase,
> but per the above side-thread I think this is primarily exposing that
> we're setting up the "struct rev_info" with your change when we don't
> need to. Why can't we just skip it?

I have no idea how to stop get_object_list() from using struct rev_info.
We could let it take a struct list_objects_filter_options pointer
instead and have it build a struct rev_info internally, but that would
just move the problem, not solve it.

> Yeah, if we do set it up we'll run into an outstanding leak, and that
> should also be fixed (I have some local patches...), but the other cases
> I know of where we'll leak that data is where we're actually using the
> "struct rev_info".
>
> I haven't tried tearing your change apart to poke at it myself, and
> maybe there's some really good reason for why you can't separate getting
> rid of the J.5.7 dependency and removing the lazy-init.
>
>> The patch below plugs it locally.
>>
>> --- >8 ---
>> Subject: [PATCH 4/3] fixup! revision: free diffopt in release_revisions=
()
>>
>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>> ---
>>  builtin/pack-objects.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
>> index 3e74fbb0cd..a47a3f0fba 100644
>> --- a/builtin/pack-objects.c
>> +++ b/builtin/pack-objects.c
>> @@ -4462,6 +4462,7 @@ int cmd_pack_objects(int argc, const char **argv,=
 const char *prefix)
>>  	} else {
>>  		get_object_list(&revs, rp.nr, rp.v);
>>  	}
>> +	diff_free(&revs.diffopt);
>>  	release_revisions(&revs);
>>  	cleanup_preferred_base();
>>  	if (include_tag && nr_result)
>
> So, the main motivation for the change was paranoia that a compiler or
> platform might show up without J.5.7 support and that would bite us, but
> we're now adding a double-free-in-waiting?
>
> I think we're both a bit paranoid, but clearly have different
> paranoia-priorities :)
>
> If we do end up with some hack like this instead of fixing the
> underlying problem I'd much prefer that such a hack just be an UNLEAK()
> here.
>
> I.e. we have a destructor for "revs.*" already, let's not bypass it and
> start freeing things from under it, which will result in a double-free
> if we forget this callsite once the TODO in 54c8a7c379 is addressed.

Well, that TODO fix should remove this new diff_free() call, but I
agree that this is fragile.

Removing the "TEST_PASSES_SANITIZE_LEAK=3Dtrue" line from affected tests
is probably better.

> As you'd see if you made release_revisions() simply call
> diff_free(&revs.diffopt) doing so would reveal some really gnarly edge
> cases.

That was my first attempt; it breaks lots of tests due to double frees.

> I haven't dug into this one, but offhand I'm not confident in saying
> that this isn't exposing us to some aspect of that gnarlyness (maybe
> not, it's been a while since I looked).

I saw it as the way towards a release_revisions() that calls diff_free()
itself: Add such calls to each of them, fix the "gnarlyness"
individually, finally move them all into release_revisions().  The only
problem is that there are 60+ callsites.

> (IIRC some of the most gnarly edge cases will only show up as CI
> failures on Windows, to do with the ordering of when we'll fclose()
> files hanging off that "diffopt").

Fun.

Ren=C3=A9
