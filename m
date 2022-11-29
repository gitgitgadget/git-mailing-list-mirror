Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92E9C433FE
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 08:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiK2IJh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Nov 2022 03:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiK2IJg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2022 03:09:36 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74A153EDD
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 00:09:34 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id e13so18684741edj.7
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 00:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O/vCRGHwxp5bDc52VTL4zpFMpeVy7OEjwZO/435UPBg=;
        b=XLSb4X/iFOpf2/6oEm7qnmCuLlw0ICadDR/a+soonaztwFD5cUQE4VJMQGWXzJpvuc
         za7d8ixQI4qe7cHSDiM9c7IT6MHmITTRlByOyf0fUTr349JPb50sqMHBlpFE0SjTUUy5
         TETRfbEY7+qvZQbaC3m1Y74GryeO4vFcuJ//KbtKtJ5F9hjkU32wdZUYXJcJASxbLqAE
         YI3wjKZlgnTtQCDrWzC1W+2fasSqE9EnAJMHV0EnTWPmD25x1YNz2Yk7abJ01c0xlZoC
         mSJEC3aUxRfmsJfwoVY0KYm57n8OJg1qwsoMaRDhvy5cGE4q0mrObMGmNRX3HzPsYgbZ
         M68w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O/vCRGHwxp5bDc52VTL4zpFMpeVy7OEjwZO/435UPBg=;
        b=dyN4gD3db2Bo11u1BnXPbEyr+s28ad0ayV3n507xzqQ36LvWK51FkMPNA08/c4hW21
         BRfMvueBipmiCrX50XcCZR3cdZxoPe6L6Xi3NwFjNSxnbxeE2xR59KRtxw6VKCEj4XHQ
         GvCeQJZb+tM8nR/+JKJZCVFEeSfLSnJef32pW8xtt6WRO2aspm1lnqLMOaQy4gJ9dsvG
         4MI6gcBAZIZMfp42dU7Nd6KF9AV0jN5b5YVg0g9HFQcikRnpgBYfxpUZRzdg6WvkljEF
         0CoBar7AZpHdg+kLv3hOxCqU4k+FjKnjDEf7oDCLaZI1QgQruoE1W4+AcgSarkOB392T
         orFw==
X-Gm-Message-State: ANoB5plQYvajSUipispXxmoYKmuwieO2mcvMmCzsMmRSgteoXIT5VIZO
        kth/oIrnHEHyRrMAcHnW9aX3Wb0A3nHXYA==
X-Google-Smtp-Source: AA0mqf4W0zyA82aprgfLuaO3s6KP2IzPYP972It8E9Io7IJXwLCP3MDeS7OdmVx8WdKXxkqAfJ8K1g==
X-Received: by 2002:a05:6402:2070:b0:467:5e4f:591 with SMTP id bd16-20020a056402207000b004675e4f0591mr36676527edb.414.1669709373200;
        Tue, 29 Nov 2022 00:09:33 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id 10-20020a170906218a00b0077a8fa8ba55sm4152884eju.210.2022.11.29.00.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 00:09:32 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ozvgK-001HpD-04;
        Tue, 29 Nov 2022 09:09:32 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/3] Revert "pack-objects: lazily set up "struct
 rev_info", don't leak"
Date:   Tue, 29 Nov 2022 08:12:25 +0100
References: <c64e4fa5-62c2-2a93-a4ef-bd84407ea570@web.de>
 <d19c6cb4-611f-afea-8a14-5e58d7509113@web.de>
 <f5779e19-813c-cda9-2f84-9fe58f745e89@web.de> <xmqqv8mz5ras.fsf@gitster.g>
 <d10de9b5-e5ff-18d6-d950-1d090d87b113@web.de>
 <221128.864jujmhgp.gmgdl@evledraar.gmail.com>
 <c5aeb93c-763d-3eae-0150-15f6ca675319@web.de>
 <221128.865yezkule.gmgdl@evledraar.gmail.com>
 <59431916-9f55-d0f4-da54-e7369803eb4c@web.de>
 <2488058d-dc59-e8c1-0611-fbcaeb083d73@web.de>
 <221128.86o7sqkjcj.gmgdl@evledraar.gmail.com>
 <0b86ae8b-5523-3857-cdba-12275f727cde@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <0b86ae8b-5523-3857-cdba-12275f727cde@web.de>
Message-ID: <221129.86fse2ji6c.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 28 2022, Ren=C3=A9 Scharfe wrote:

> Am 28.11.2022 um 19:32 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>
>> On Mon, Nov 28 2022, Ren=C3=A9 Scharfe wrote:
>>
>>> Am 28.11.2022 um 16:56 schrieb Ren=C3=A9 Scharfe:>
>>>> The problem is "How to use struct rev_info without leaks?".  No matter
>>>> where you move it, the leak will be present until the TODO in
>>>> release_revisions() is done.
>>>
>>> Wrong.  The following sequence leaks:
>>>
>>> 	struct rev_info revs;
>>> 	repo_init_revisions(the_repository, &revs, NULL);
>>> 	release_revisions(&revs);
>>>
>>> ... and this here doesn't:
>>>
>>> 	struct rev_info revs;
>>> 	repo_init_revisions(the_repository, &revs, NULL);
>>> 	setup_revisions(0, NULL, &revs, NULL);  // leak plugger
>>> 	release_revisions(&revs);
>>>
>>> That's because setup_revisions() calls diff_setup_done(), which frees
>>> revs->diffopt.parseopts, and release_revisions() doesn't.
>>>
>>> And since builtin/pack-objects.c::get_object_list() calls
>>> setup_revisions(), it really frees that memory, as you claimed from the
>>> start.  Sorry, I was somehow assuming that a setup function wouldn't
>>> clean up.  D'oh!
>>>
>>> The first sequence is used in some other places. e.g. builtin/prune.c.
>>> But there LeakSanitizer doesn't complain for some reason; Valgrind
>>> reports the parseopts allocation as "possibly lost".
>>
>> Yes, some of the interactions are tricky. It's really useful to run the
>> tests with GIT_TEST_PASSING_SANITIZE_LEAK=3D[true|check] (see t/README) =
to
>> check these sorts of assumptions for sanity.
>
> That may be true, and looks even useful -- I didn't know the check
> value.  I only get a strange error message, though:
>
>    $ GIT_TEST_PASSING_SANITIZE_LEAK=3Dcheck ./t0001-init.sh
>    Bail out! GIT_TEST_PASSING_SANITIZE_LEAK=3Dtrue has no effect except w=
hen compiled with SANITIZE=3Dleak
>
> Same with make test and prove, of course.  And of course I compiled
> with SANITIZE=3Dleak beforehand.

The "=3Dtrue" part of the message is unfortunately incorrect (it pre-dates
"check" being a possible value), but I don't see how you could have
compiled with "SANITIZE=3Dleak" and get that message.

It's unreachable if 'test -n "$SANITIZE_LEAK"', and that'll be non-empty
in GIT-BUILD-OPTIONS if compiled with it. Perhaps you gave SANITIZE=3Dleak
to t/Makefile, not the top-level Makefile?

Try this at the top-level:

	GIT_TEST_PASSING_SANITIZE_LEAK=3Dcheck make SANITIZE=3D test T=3Dt0001-ini=
t.sh

> But I don't see a connection between my comment and yours.  I was
> not running any tests, just the above sequences of function calls,
> e.g. in git prune.

The connection is that you submitted patches that fail the CI. I don't
think you use GitHub, so in particular if you're submitting patches that
claim to do something with leak checking it's useful to run those modes
against them to check your assumptions.

>>
>>> I still think the assumption that "init_x(x); release_x(x);" doesn't
>>> leak is reasonable.  Let's make it true.  How about this?  It's safe
>>> in the sense that we don't risk double frees and it's close to the
>>> TODO comment so we probably won't forget removing it once diff_free()
>>> becomes used.
>>>
>>> ---
>>>  revision.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/revision.c b/revision.c
>>> index 439e34a7c5..6a51ef9418 100644
>>> --- a/revision.c
>>> +++ b/revision.c
>>> @@ -3055,6 +3055,7 @@ void release_revisions(struct rev_info *revs)
>>>  	release_revisions_mailmap(revs->mailmap);
>>>  	free_grep_patterns(&revs->grep_filter);
>>>  	/* TODO (need to handle "no_free"): diff_free(&revs->diffopt) */
>>> +	FREE_AND_NULL(revs->diffopt.parseopts);
>>>  	diff_free(&revs->pruning);
>>>  	reflog_walk_info_release(revs->reflog_info);
>>>  	release_revisions_topo_walk_info(revs->topo_walk_info);
>>
>> At this point I'm unclear on what & why this is needed? I.e. once we
>> narrowly fix the >1 "--filter" options what still fails?
>
> As I wrote: A call to an initialization function followed by a call to a
> cleanup function and nothing else shouldn't leak.  There are examples of
> repo_init_revisions()+release_revisions() without setup_revisions() or
> diff_setup_done() beyond pack-objects.  I mentioned prune, but there are
> more, e.g. in sequencer.c.

Yes, I agree it shouldn't leak. And we should definitely fix those
leaks. I just don't see why a series fixing bugs in --filter needs to
expand the scope to fix those.

>> But in general: I don't really think this sort of thing is worth
>> it. Here we're reaching into a member of "revs->diffopt" behind its back
>> rather than calling diff_free(). I think we should just focus on being
>> able to do do that safely.
>
> Sure, but the FREE_AND_NULL call is simple and safe, while diff_free()
> is complicated and calling it one time too many can hurt.

It's "safe" because you've read the internals of it, and know that it
isn't assuming a non-NULL there once it's past initialization?

Or is it like the revisions init()+release() in this thread, where
you're assuming it works one way based on the function names etc., only
for the CI to fail?

In either case, I'm saying that if someone's confident enough to reach
into the internals of a structure and tweak it they should be confident
enough to just patch diff_free() or the like.

>> WIP patches I have in that direction, partially based on your previous
>> "is_dead" suggestion:
>>
>> 	https://github.com/avar/git/commit/e02a15f6206
>> 	https://github.com/avar/git/commit/c718f36566a
>
> Copy-typed the interesting parts of the first patch like a medieval monk
> because there doesn't seem to be a download option. :-|

Jeff pointed out the ".patch" (there's also ".diff"), but also: Git has
this well-known transport protocol it uses, which typically maps to the
web URL on public hosting sites ... :)

	git remote add avar https://github.com/avar/git.git
	git fetch avar
	git show <OID>

>> I haven't poked at that in a while, I think the only outstanding issue
>> with it is that fclose() interaction.
>
> You mean the t3702-add-edit.sh failure on Windows mentioned in the
> commit message of e02a15f6206?  That's caused by the file being kept
> open and thus locked during the call of the editor.  Moving the
> release_revisions() call in builtin/add.c::edit_patch() before the
> launch_editor() call fixes that by closing the file.

Yeah, I haven't had time to poke at it in a while, and I had it queued
behind various other leak fixes.

I'm sure it's not that complicated in the end, just that that
interaction needs to be dealt with.

>> I think for this particular thing there aren't going to be any bad
>> side-effects in practice, but I also think convincing oneself of that
>> basically means putting the same amount of work in as just fixing some
>> of these properly.
>
> Not to me, but perhaps that TODO is easier solved that I expected.
> In any case, with the mentioned edit_patch() change described above
> e02a15f6206 passes the test suite on Windows for me.

Nice! I'll try that out.
