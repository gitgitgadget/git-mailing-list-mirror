Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88283C4321E
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 14:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbiK1Ooi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 09:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232700AbiK1Ony (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 09:43:54 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D0422BD3
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 06:43:44 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id ml11so1475791ejb.6
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 06:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uFj+OO0p/7cb2veyChqEVS6J/Pr331UtM+tefc9cmT8=;
        b=OFuMy7AVz/qo7kbBv6WhTSleDgMihgrmmQqhwwmtHUHsTUZm2eiFhp7iypTBT15rGi
         vxRaMBYA+K6ZeUtoIw8WUdXGMVtQX7eR1VSvdkGtKy3J45tX8mTQSf9T4BvJhCReKpla
         FJGN8NDgsGlxjCjjNWu7wXj5l1Arj9S0vxaTXdB0Ro5axLDgbJ7ISbG1gMrdmplvrCV3
         Lqer5VZIJQ8c1qoUsV2jlNpVPpjoNvXBKWHMbjAHGtOuheK87YBxmhUtd8mCLp02qP/D
         YsPpugBKTgUoZoQ9kn3PyiaZSWGsZqSnHLto5iJv6+UIjjD94js0Lw/DBiJQyvK+8hyS
         9hnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uFj+OO0p/7cb2veyChqEVS6J/Pr331UtM+tefc9cmT8=;
        b=xWwKYdHdUr7Q8ACB+sSBp/IFDs+ygDu+3PAhRJizd1neK/0ba5RIal5b8n9Xyk4+CR
         B5ped7ABWVbJEJBgQCMYyORPeq/cjphKEqRtVCQbuHw+pPlDrKLl83SaXOvqTQiiGtz0
         zo4Ez6EMz+ub9t0OrLkq64FVgmiJf/dJq+BY1qKpSZtX4uDyGeNjcgr+kn3h7GoEBE7c
         IG/XiDhL0++Xthbxq4lF7VwxbexGQZBlTgcRyZTUH5gcKGOYLwok5kiiM9db4XUhiBWI
         z5kyBSc45TN2sLud6lJTRInyNEWbfag8TPx1CS90ClF1QdgKpyhsSy3RxseJf8x/UDdc
         GzaA==
X-Gm-Message-State: ANoB5pnMUsJYzY2uIO1kLanLEaz7h9RUFASc6VhBuSFUjmQfXYzsx9Jw
        olqSHXta0Y/YIsDHVERWroA=
X-Google-Smtp-Source: AA0mqf6kIn7WTZOP3znOpk/KTMD9t4LnYdhuiZBSxbFbEk1/Ayb2eXMAz8CT24jwHos4dVD/c6LYVA==
X-Received: by 2002:a17:907:9a8a:b0:7bf:9949:969e with SMTP id km10-20020a1709079a8a00b007bf9949969emr5177822ejc.132.1669646622939;
        Mon, 28 Nov 2022 06:43:42 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id 11-20020a170906300b00b00781e7d364ebsm5050153ejz.144.2022.11.28.06.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 06:43:42 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ozfMD-0016u1-2T;
        Mon, 28 Nov 2022 15:43:41 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/3] Revert "pack-objects: lazily set up "struct
 rev_info", don't leak"
Date:   Mon, 28 Nov 2022 15:34:25 +0100
References: <c64e4fa5-62c2-2a93-a4ef-bd84407ea570@web.de>
 <d19c6cb4-611f-afea-8a14-5e58d7509113@web.de>
 <f5779e19-813c-cda9-2f84-9fe58f745e89@web.de> <xmqqv8mz5ras.fsf@gitster.g>
 <d10de9b5-e5ff-18d6-d950-1d090d87b113@web.de>
 <221128.864jujmhgp.gmgdl@evledraar.gmail.com>
 <c5aeb93c-763d-3eae-0150-15f6ca675319@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <c5aeb93c-763d-3eae-0150-15f6ca675319@web.de>
Message-ID: <221128.865yezkule.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 28 2022, Ren=C3=A9 Scharfe wrote:

> Am 28.11.2022 um 12:31 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>
>> On Mon, Nov 28 2022, Ren=C3=A9 Scharfe wrote:
>>
>>> Am 28.11.2022 um 11:03 schrieb Junio C Hamano:
>>>> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>>>>
>>>>> This reverts commit 5cb28270a1ff94a0a23e67b479bbbec3bc993518.
>>>>>
>>>>> 5cb28270a1 (pack-objects: lazily set up "struct rev_info", don't leak,
>>>>> 2022-03-28) avoided leaking rev_info allocations in many cases by
>>>>> calling repo_init_revisions() only when the .filter member was actual=
ly
>>>>> needed, but then still leaking it.  That was fixed later by 2108fe4a19
>>>>> (revisions API users: add straightforward release_revisions(),
>>>>> 2022-04-13), making the reverted commit unnecessary.
>>>>
>>>> Hmph, with this merged, 'seen' breaks linux-leaks job in a strange
>>>> way.
>>>>
>>>> https://github.com/git/git/actions/runs/3563546608/jobs/5986458300#ste=
p:5:3917
>>>>
>>>> Does anybody want to help looking into it?
>>
>> [I see we crossed E-Mails]:
>> https://lore.kernel.org/git/221128.868rjvmi3l.gmgdl@evledraar.gmail.com/
>>
>>> The patch exposes that release_revisions() leaks the diffopt allocations
>>> as we're yet to address the TODO added by 54c8a7c379 (revisions API: add
>>> a TODO for diff_free(&revs->diffopt), 2022-04-14).
>>
>> That's correct, and we have that leak in various places in our codebase,
>> but per the above side-thread I think this is primarily exposing that
>> we're setting up the "struct rev_info" with your change when we don't
>> need to. Why can't we just skip it?
>
> I have no idea how to stop get_object_list() from using struct rev_info.
> We could let it take a struct list_objects_filter_options pointer
> instead and have it build a struct rev_info internally, but that would
> just move the problem, not solve it.

I mean skip it when it's not needed, it's needed when we call
get_object_list().

But what "problem" is being caused by get_object_list()? That there's
some other case(s) where it'll leak still? I haven't checked, I think we
should leave that for some other time if there's such leaks, and just
not introduce any new leaks in this topic.

>> Yeah, if we do set it up we'll run into an outstanding leak, and that
>> should also be fixed (I have some local patches...), but the other cases
>> I know of where we'll leak that data is where we're actually using the
>> "struct rev_info".
>>
>> I haven't tried tearing your change apart to poke at it myself, and
>> maybe there's some really good reason for why you can't separate getting
>> rid of the J.5.7 dependency and removing the lazy-init.
>>
>>> The patch below plugs it locally.
>>>
>>> --- >8 ---
>>> Subject: [PATCH 4/3] fixup! revision: free diffopt in release_revisions=
()
>>>
>>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>>> ---
>>>  builtin/pack-objects.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
>>> index 3e74fbb0cd..a47a3f0fba 100644
>>> --- a/builtin/pack-objects.c
>>> +++ b/builtin/pack-objects.c
>>> @@ -4462,6 +4462,7 @@ int cmd_pack_objects(int argc, const char **argv,=
 const char *prefix)
>>>  	} else {
>>>  		get_object_list(&revs, rp.nr, rp.v);
>>>  	}
>>> +	diff_free(&revs.diffopt);
>>>  	release_revisions(&revs);
>>>  	cleanup_preferred_base();
>>>  	if (include_tag && nr_result)
>>
>> So, the main motivation for the change was paranoia that a compiler or
>> platform might show up without J.5.7 support and that would bite us, but
>> we're now adding a double-free-in-waiting?
>>
>> I think we're both a bit paranoid, but clearly have different
>> paranoia-priorities :)
>>
>> If we do end up with some hack like this instead of fixing the
>> underlying problem I'd much prefer that such a hack just be an UNLEAK()
>> here.
>>
>> I.e. we have a destructor for "revs.*" already, let's not bypass it and
>> start freeing things from under it, which will result in a double-free
>> if we forget this callsite once the TODO in 54c8a7c379 is addressed.
>
> Well, that TODO fix should remove this new diff_free() call, but I
> agree that this is fragile.
>
> Removing the "TEST_PASSES_SANITIZE_LEAK=3Dtrue" line from affected tests
> is probably better.

Or just not introduce new leaks, per my suggested fix-up at
https://lore.kernel.org/git/221128.86zgcbl0pe.gmgdl@evledraar.gmail.com/
(which it looks like you haven't seen when this E-Mail is composed...).

>> As you'd see if you made release_revisions() simply call
>> diff_free(&revs.diffopt) doing so would reveal some really gnarly edge
>> cases.
>
> That was my first attempt; it breaks lots of tests due to double frees.

Right, to be clear I'm saying that none of this is needed right now,
i.e. I don't get why we'd want the scope-creep past the hunk I noted in
https://lore.kernel.org/git/221128.868rjvmi3l.gmgdl@evledraar.gmail.com/
for the --filter bug fix (plus the tests you're adding).

>> I haven't dug into this one, but offhand I'm not confident in saying
>> that this isn't exposing us to some aspect of that gnarlyness (maybe
>> not, it's been a while since I looked).
>
> I saw it as the way towards a release_revisions() that calls diff_free()
> itself: Add such calls to each of them, fix the "gnarlyness"
> individually, finally move them all into release_revisions().  The only
> problem is that there are 60+ callsites.

I think this is a really bad approach in general.

Yes, it may happen to work to free() some data from under an API, but
it's just as likely that we'll miss that this one caller is screwing
with its internal state, and e.g. when some new revision.c code is used
it'll go boom.

If we wanted to phase in such a free() of "foo" I think the right way
would be to add some "revs.free_foo =3D 1" flag, giving the API a chance
to treat that sanely, not to start poking at members of the struct, and
assuming that its release() won't be free()-ing them.

But as noted above & in the linked I think we can defer all of that. The
only reason we're discussing this is because you're changing the
lazy-init to be not-lazy, and introducing new leaks as a result.

I've shown a couple of approaches in this thread of fixing the issue(s)
at hand without introducing such leaks, so ...
