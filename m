Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60775C433EF
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 12:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235533AbiCaMGC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 08:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234232AbiCaMF6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 08:05:58 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D563E5E8
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 05:04:08 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id bi12so47700897ejb.3
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 05:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=bXyWskLSEIZf+n235pxBjFIpiZP3cVDDu6Y2yQlQCn8=;
        b=fKnkMgGiWI0sE7OPxWDRMjywXZdAdIGqY1MCdd6k3BDyW9ABc46+Vdkj87Zz6PFnDw
         BCu4QaKHFTDIHebSfJgpQtehUNrZcW+dwOM0aVDtNQC9ZmNJwiIqcD8XOl1VqURicVSG
         uT4JUpQlyAu3nHpVBTXD2lNzZxJ3pI6P5mGXYUWI/6vcS5KiGedWU17iyTneEKrkmKxz
         AEqVYPCQqGpqF31krDgUTSiK3/xa7reaNqYyQ3uTq9m0ILkGZL+QUMoTrC1MVXo4gEMt
         //nYtt06i2/ZRGdzcwiVExkrtPFvXp0LdjPTBs4dyePSssZrX3AD9HLwZRO3HRLzjWY8
         u33g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=bXyWskLSEIZf+n235pxBjFIpiZP3cVDDu6Y2yQlQCn8=;
        b=hR5iHygWhUgqVhFBU3ywQTTToQfOsRNOOtg/k8uaq4lIx5mehyyDgwzW87a+aeCg6d
         Ya1g2ZdZhndz7vdROmK2mVX3DsDm7EKF0q1bKEcicgpOYVetYlT6ffQ7dCoO9REBcbag
         pj4nil6gZJRVyxR8eNSgF/dugH/WuznY8O9nO4jLRL5gFLdXkrHTsxM3p/8TNB+q21tW
         LeOKi4fwCsWgR8hRECtBz1Zyu2LWib+W7BliPl2DmraluX9gNPb/bAUD8bQghQtkFkad
         Cw6OC/pcUSrxH4fqeoytQ/Q012YM9m9WQvD5MlESjSqXDgX1/4DStJJeYwXYXPRZrOA4
         VUnw==
X-Gm-Message-State: AOAM5309auePziOi2XlgDPvWbc6jBgxVxNLR8aPgrIaOWpdth/mV5q1A
        j3IpI5qfS28iHTiBZlba8hQ=
X-Google-Smtp-Source: ABdhPJzIE+wTbSQKyh8vONMkqAk0SdRs5IsShE8Po6St0l4tXNyQgo4Twn7uRniQ800VL/HehPH0UA==
X-Received: by 2002:a17:906:7316:b0:6d7:16be:b584 with SMTP id di22-20020a170906731600b006d716beb584mr4588816ejc.759.1648728246188;
        Thu, 31 Mar 2022 05:04:06 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id cr19-20020a170906d55300b006df6b316e29sm9587265ejc.208.2022.03.31.05.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 05:04:05 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nZtX3-000Px4-4D;
        Thu, 31 Mar 2022 14:04:05 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v3 7/7] git-sh-setup: don't mark trees not used in-tree
 for i18n
Date:   Thu, 31 Mar 2022 13:15:05 +0200
References: <cover-v2-0.5-00000000000-20211119T202455Z-avarab@gmail.com>
        <cover-v3-0.7-00000000000-20220326T171200Z-avarab@gmail.com>
        <patch-v3-7.7-7a82b1fd005-20220326T171200Z-avarab@gmail.com>
        <2e2d20d6-a33d-b223-d364-ab43d92dd220@kdbg.org>
        <220327.8635j3fx3t.gmgdl@evledraar.gmail.com>
        <63bf6e97-1dca-c2b1-5673-301039e73acf@kdbg.org>
        <220328.86lewudzw3.gmgdl@evledraar.gmail.com>
        <45c963da-19a5-de51-34d4-5b29f461c9ec@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <45c963da-19a5-de51-34d4-5b29f461c9ec@gmail.com>
Message-ID: <220331.86a6d6qqfe.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 31 2022, Phillip Wood wrote:

[tl;dr: Reply below, but this whole thing should be addressed by the v4
I sent last night:
https://lore.kernel.org/git/cover-v4-0.6-00000000000-20220331T014349Z-avara=
b@gmail.com/

I.e. the controversial patch has been ejected].

> On 28/03/2022 13:16, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Mon, Mar 28 2022, Johannes Sixt wrote:
>>=20
>>> Am 27.03.22 um 13:15 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>>>
>>>> On Sun, Mar 27 2022, Johannes Sixt wrote:
>>>>
>>>>> Am 26.03.22 um 18:14 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>>>>> Partially revert d323c6b6410 (i18n: git-sh-setup.sh: mark strings for
>>>>>> translation, 2016-06-17).
>>>>>>
>>>>>> These strings are no longer used in-tree, and we shouldn't be wasting
>>>>>> translator time on them for the benefit of a hypothetical out-of-tree
>>>>>> user of git-sh-setup.sh.
>
> The out of tree users of git-sh-setup.sh are not hypothetical, they
> exist and objected when you recently tried to remove these functions=20
> entirely[1].

I see that what I wrote there is ambiguous, but I'm aware of that &
remember that thread. I meant to say the hypothetical user that cares
about the i18n these functions exposed.

>>>>> There is public documentation for these functions. Hence, you must
>>>>> assume that they are used in scripts outside of Git. Castrating their
>>>>> functionality like this patch does is unacceptable.
>>>>
>>>> For require_clean_work_tree() the public documentation for this functi=
on
>>>> states that it will emit a specific error message in English, and you'=
re
>>>> expected to Lego-interpolate a string that we'll concatenate with it:
>
> The documentation does not say whether the message is translated or
> not, probably because it was not updated when the translations were
> added six years ago.

It does say it. It uses the word "Cannot" at the beginning, and promises
to emit that specific string.

Yes we didn't update it at the time for i18n, and probably should.

But to the extent that the gordian knot in making any changes to these
whatsoever is because they've been publicly documented I don't think
anyone using these has been promised different behavior. So it's highly
relevant here.

>>>> 	[...]It emits an error message of the form `Cannot
>>>>          <action>: <reason>. <hint>`, and dies.  Example:
>
> This is not a promising a "specific error message in English"

It really is. You cannot use this API to produce sensible output in any
other language. It was used like this:

    require_clean_work_tree "pull with rebase" "Please commit or stash them=
."

For which we'd emit:

    Cannot pull with rebase: You have unstaged changes.

    Please commit or stash them.

You can see e.g. in the Bulgarian translation that this was dealt with
by putting the interpolated string in double-quotes.

>>>> 	+
>>>> 	----------------
>>>> 	require_clean_work_tree rebase "Please commit or stash them."
>
> This is an example message you cannot use that to argue that we will
> always show a message in English

I'm saying that the documentation says it emits English, that it didn't
always do that, and now does so again.

And that to get it to emit anything sensible in cases where we're not
under LC_ALL=3DC would have required 1=3D1 matching the behavior of whatever
shellscript is using this to what git-sh-i18n in picking the locale.

I don't think it's plausible that there's an out-of-tree user
maintaining their own set of i18n'd po/ files which expect to interact
with our translations in this way.

Any out-of-tree user of this (if they're using this at all) will either
not care, or they'll see more sensible output again.

>>>> So I think that marking it for translation like this as d323c6b6410 was
>>>> always broken in that it broke that documented promise.
>>>
>>> I can buy this argument. But then this must be a separate commit with
>>> this justification.
>> Sure, I can elaborate on that point & split it up.
>>=20
>>>> But that's just an argument for keeping the require_clean_work_tree()
>>>> part of this patch, not require_work_tree_exists().
>>>>
>>>> For that one and others in git-sh-setup we've never said that we'd
>>>> provide these translated (and to the extent we've implied anything abo=
ut
>>>> the rest, have strongly implied the opposite with
>>>> require_clean_work_tree()'s docs).
>>>>
>>>> Nothing will break for out-of-tree users as a result of this
>>>> change.
>
> The strings the user sees will change

Yes, and I'll admit that "nothing will break here" on my part isn't the
same as saying "there will be no observable change whatsoever". Sorry
about being unclear there.

As a general matter we don't promise that such strings won't change,
even for die(), error() etc. messages emitted by plumbing commands.

Except in some rare cases where they've been known to be used out of
tree extensively, e.g. the human-readable "merge" messages where we
have/had no other API to expose the same information.

Or, in the case of plumbing output where such strings are part of the
API contract.

But for these commands in the "Internal helper commands" category I
think this fall squarely in the category of changing a random error(),
die() etc. in the C code (which we do quite freely).

>>>> When we added these functions and their documentation their
>>>> output wouldn't be translated,
>
> Where does the documentation say "the output will not be translated"?

I think this was covered above, it's sufficient that it didn't promise
that it would be, and in the one case where we discuss it in passing
with an example we imply that it won't be.

>>>> then sometimes it was, now it's not
>>>> again.
>>>
>>> This does not sound convincing at all, but rather like "I want the code
>>> to be so, and here is some handwaving to justify it". What is wrong with
>>> the status quo?
>> The larger context for why I was looking at this again is that I'm
>> trying to slowly get us to the point where we can remove the
>> i18n-in-shellscript entirtely.
>> But I thought that was a rather large digression for the commit
>> message,
>> and that these being both unused, and not something the "public" API
>> affected ever promised it would do was sufficient.
>
> I think if that is what you want to do then you should propose a
> series that does just that and explains why it is desirable, rather
> than coming up with other reasons to justify the changes you want.

Just because I start looking at some code for reason X that doesn't mean
that submitting a patch with rationale Y isn't a sufficient reason to
make that change.

I still think that in this case that they're not used by our own i18n
effort is a perfectly sufficient reason to make the change, as we won't
waste translator time in it. I.e. I'll still stand behind the stated
rationale.

But aside from that most changes I made to git are with an eye to some
larger semi-related goal.

I do have some WIP changes to tear down most of the *.sh and *.perl i18n
infrastructure (the parts still in use would still have translations),
and IIRC it's at least a 2k line negative diffstat, and enables us to do
more interesting things in i18n (e.g. getting rid of the libintl
dependency).

But I also don't think that such a series is probably not possible in
the near term if we're going to insist that all shellscript output must
byte-for-byte be the same (for boring reasons I won't go into, but it's
mainly to do with sh-i18n--envsubst.c).

So it's also a bit of a chicke & egg problem. I wanted to send any such
UI changes in first, to see if it was even worth finishing up that work,
or if the whole thing would stall on not being able to change some
output someone somewhere might have relied on being byte-for-byte the
same.

>>>> We need also need to be mindful of translator time, it's a *lot* of
>>>> strings to go through, and e.g. I've commented in the past on patches
>>>> that marked stuff in t/helper/ for translation.
>>>
>>> Translator's time is your concern? No translator sifts through 5000
>>> strings on every release. There are tools that show only new strings to
>>> translate.
>> Yes, I'm the person who added this entire i18n infrastructure to
>> git, I
>> know how it works :)
>>=20
>>> A text is translated once and then it lies under the radar
>>> until someone changes it. Don't tell me that is time-consuming.
>> Yes, individual orphaned strings aren't, but they add up.
>> Just like having that "USE_PIC" comment in configure.ac isn't much
>> of a
>> big deal, but it makes sense to clean up unused code, just as we're
>> adding new code.
>> I will say that your implicit proposal of keeping this forever
>> instead
>> is assuming that we won't have more translations for git, and every new
>> translator will look at this.
>> Context is critical for translators, so even if it's one string it's
>> a
>> string you'll quickly grep for and find ... no uses for, and then likely
>> go hunting around for where it's used only to (hopefully, in that case)
>> find this thread. Better not to have it.
>>=20
>>> On the other hand, there is a lot of *reviewer* time that you are
>>> spending with changes like this. *That* should be your concern.
>> I'd think most of the that time, if any, will be spent on this
>> sub-thread you started, so ... :)
>
> This sub-tread exists because you posted this patch to the mailing
> list. Blaming reviewers for asking perfectly reasonable questions is
> neither fair nor helpful.

I didn't mean any offense there, but did mean to suggest (smiley an all)
that a mountain was being made out a molehill in this case.

Yes translator time is my concern. I started the i18n effort in git, and
I think it's really important. We currently have 18 translations of git
in the po/ directory, 16 if you leave out "dialects". Which if you
compare it with
https://en.wikipedia.org/wiki/List_of_languages_by_number_of_native_speakers
is quite bad.

For comparison I worked extensively on MediaWiki in a past life, which
at the time had at least 100 such translations. I looked again and it's
up to around 600 (many incomplete, to be fair).

Is that our fault as project? No, but we could definitely help it along.

I value the scarcity of translator time (including future translations)
much more than concerns that there *may be* someone somewhere who's got
a reliance on this particular output.

> This patch does not remove dead code as the rest of the series does
> but instead changes user facing messages in code that we recently=20
> established is part of the public api[2]. Nothing has changed since
> that recent discussion so I'm confused as to why you are proposing to
> modify the api again so soon.

As noted above I don't think that previous discussion applies to these
changes as you describe, but in any case, ~8 hours before you sent this
reply I sent a v4 re-roll which left out this change:

    https://lore.kernel.org/git/cover-v4-0.6-00000000000-20220331T014349Z-a=
varab@gmail.com/

Which I hope will address your & Johannes Sixt's concerns here. Does the
rest of this series look good to you?
