Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5AA6C433EF
	for <git@archiver.kernel.org>; Sat, 29 Jan 2022 06:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240956AbiA2Gej (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Jan 2022 01:34:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235895AbiA2Gei (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jan 2022 01:34:38 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EC0C061714
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 22:34:37 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id me13so23562833ejb.12
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 22:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=mN6TzOjRNhse8NW7nyFtgqug4AIzLlh6MZ2AJwebwhI=;
        b=RM8dhKWfOncgckmLho9E/nR2OwUNSpxzO+qjvqnJFXUAlN/6mARbcxsRqDY2wYHVrV
         HfmTlLO1hRq+lnbqZn0YRfWLV3UIptB6Sf6EEPH/rLX2cC9LCRJr8U1rFA7CdWIwTJMl
         O9xUai4aEJprrqIKRpT3VLZNa/vXe7UBFusjarGnd/hk6tlHpnU9C+rttfq/7WqRods/
         BZawVm0H59hiaij13LEUe10MaolzX0IAG5HQLPe6jI+K//veXJoSfZI+6cxXB9NiwbMB
         3JDywkygje+3hhqcqpNMMU47ZUyAYPWUXoQNP7N+qrR7Wa1NUvJuBfavnzDXdAxaPFwT
         tXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=mN6TzOjRNhse8NW7nyFtgqug4AIzLlh6MZ2AJwebwhI=;
        b=nSEf0eTANXK5PNTIxYcVHJ0s/Ak9JEzKg767Zaen7uE2VchUZVoNoMYpBFHr//7nin
         hRuL9nTnvzWppN2/3LB2ix7nrNYB5v9pGOvdic6Pxx78egEcIzBP2HU7ATm5Nh2U4bP5
         yuyxJaVGBKnqmyK8bVZosOkjrMqYHdvriuLICc76RR5f5KZ4mHl/IPf+whGmU1RRlJUs
         s0jzakbN1N+JI95zbnaB6uGg2OuHyNFj0sPejdHl0GNorXORdZN4kNuWGG27PHDLMcJY
         66vKpZUgk32uwqeeoP+aS0Y9bux26Mcxy7hMt6+AqJZda71AtYlRyPRydBpE9VGe/kXh
         RYuQ==
X-Gm-Message-State: AOAM531FcXjvDg8Cl9oCFn0yXqTwe3bdrBhOqjawcZTBR2Rahjznm399
        7adgmi7g4m95dwO9N8FRR+aQFvSHQQh8PlHf
X-Google-Smtp-Source: ABdhPJydsPmXqZLS0ifDAhryygF947C7ENplfAyG9P8xtdSWMI9riU6KTQRAsXDrUbrus9bllKlAxA==
X-Received: by 2002:a17:907:1b21:: with SMTP id mp33mr9908747ejc.523.1643438075802;
        Fri, 28 Jan 2022 22:34:35 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id f6sm14112451edy.18.2022.01.28.22.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 22:34:35 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nDhJi-003kyx-7r;
        Sat, 29 Jan 2022 07:34:34 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] repo-settings: fix checking for
 fetch.negotiationAlgorithm=default
Date:   Sat, 29 Jan 2022 07:08:44 +0100
References: <pull.1131.git.1643334969216.gitgitgadget@gmail.com>
 <220128.86ee4scn2s.gmgdl@evledraar.gmail.com>
 <CABPp-BEehHHbDi_muWHCaT1GvRmPbPiMmvB-2O9+0w2A+yEM0Q@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <CABPp-BEehHHbDi_muWHCaT1GvRmPbPiMmvB-2O9+0w2A+yEM0Q@mail.gmail.com>
Message-ID: <220129.86y22zaw3p.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jan 28 2022, Elijah Newren wrote:

> Hi =C3=86var,
>
> On Thu, Jan 27, 2022 at 11:54 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
> [...]
>>> > Technically, before commit 3050b6dfc75d, repo-settings would treat any
>> > fetch.negotiationAlgorithm value other than "skipping" or "noop" as a
>> > request for "default", but I think it probably makes more sense to
>> > ignore such broken requests and leave fetch.negotiationAlgorithm with
>> > the default value rather than the value of "default".  (If that sounds
>> > confusing, note that "default" is usually the default value, but when
>> > feature.experimental=3Dtrue, "skipping" is the default value.)
>> >
>> > [...]
>> >     A long sidenote about naming things "default":
>> >
>> >     Many years ago, in the Gnome community, there was a huge fight that
>> >     erupted, in part due to confusion over "default". There was a jour=
nalist
>> >     who had been a designer in a past life, who had a little friction =
with
>> >     the rest of the community, but intended well and generally improved
>> >     things. At some point, they suggested some changes to improve the
>> >     "default" theme (and they were a nice improvement), but not being a
>> >     developer the changes weren't communicated in the form of a patch.=
 And
>> >     the changes accidentally got applied to the wrong theme: the defau=
lt one
>> >     (yes, there was a theme named "default" which was not the default
>> >     theme). Now, basically no one used the default theme because it wa=
s so
>> >     hideously ugly. I think we suffered from a case of not being able =
to
>> >     change the default (again?) because no one could get an agreement =
on
>> >     what the default should be. Who did actually use the default theme,
>> >     though? The person writing the release notes (though they only use=
d it
>> >     for taking screenshots to include in the release notes, and otherw=
ise
>> >     used some other theme). So, with people under pressure for an immi=
nent
>> >     release, there were screenshots that looked like garbage, and
>> >     investigation eventually uncovered that it was due to changes that=
 were
>> >     meant for the "default" theme having accidentally been applied to =
the
>> >     default theme. It could have just been an amusing story if not for=
 the
>> >     other unfortunate factors happening around the same time and the h=
eated
>> >     and protracted flamewars that erupted.
>> >
>> >     Don't name settings/themes/things "default" if it describes someth=
ing
>> >     specific, since someone may come along and decide that something e=
lse
>> >     should be the default, and then you're stuck with a non-default
>> >     "default". Sadly, the name was already picked and documented so for
>> >     backward compatibility we need to support it...
>>
>> Funny story, I think this is only going to bite us if we don't switch
>> the default over along with promoting this out of feature.experimental.
>>
>> I.e. =3Ddefault should always be equivalent to not declaring that config
>> at all anywhere, and not drift to being a reference to some name that
>> happens to be "default", as in the GNOME case.
>
> No, we have the same problem as the Gnome case.  See this part of the
> documentation for fetch.negotiationAlgorithm:
>
> """
>     The default is "default" which instructs Git to use the
>     default algorithm that never skips commits (unless the server has
>     acknowledged it or one of its descendants).
> """
>
> features.experimental turns on "skipping" as the default behavior, and
> that text clearly rules out the possibility that "default" could be
> used to mean "skipping".  So, if that experimental feature graduates,
> then the default behavior of fetch.negotiationAlgorithm will NOT be
> the "default" behavior of fetch.negotationAlgorithm.

I see what you mean, and I'm aware that I'm debating this with a native
speaker :)

FWIW I didn't read it that way, earlier it discusses "skipping", and
here it's describing what the default is. But especially since you'd
have no reason to set this except to "reset to default" I didn't take it
to be a promise that the default wouldn't change.

I.e. maybe we'll just make it "skipping" and drop the current "default"
code, or we'll give the current "default" a name at that point.

But I do see how us not having a name for the "defult" complicates that
view of the world. For grep.patternType we've got the same thing, but
"default" there is "basic", so that's a bit different.

I do read log.date's "default" as being the sort of GNOME case you're
describing however. But I don't think we'd ever change the default
there, a date format is too subjective, whereas an internal algorithm is
liable to change.

But I think we should just change this to make it explicit (separate
from this narrow bugfix). Maybe "exhaustive" would be a good permanent
name for the default algorithm?

>> In our case it's more of a story about the inconsistencies in our config
>> space, i.e. some values you can't reset at all, some take empty values
>> to do so, others "default" etc.
>> [...]
>>
>> Since it's the same as the preceding test, maybe we can squash this in
>> to avoid the duplication? This works for me.
>> [...]
>> -       rm -f trace &&
>> -       cp -r client clientv2 &&
>> -       GIT_TRACE_PACKET=3D"$(pwd)/trace" git -C clientv2 -c protocol.ve=
rsion=3D2 \
>> +test_expect_success 'use ref advertisement to prune "have" lines sent' '
>> +       test_negotiation_algorithm_default \
>>                 -c feature.experimental=3Dtrue \
>> -               -c fetch.negotiationAlgorithm=3Ddefault \
>> -               fetch origin server_has both_have_2 &&
>> -       grep "have $(git -C client rev-parse client_has)" trace &&
>> -       grep "have $(git -C client rev-parse both_have_2)" trace &&
>> -       ! grep "have $(git -C client rev-parse both_have_2^)" trace
>> +               -c fetch.negotiationAlgorithm=3Ddefault
>
> I think you accidentally dropped one of the two tests by turning it
> into a function and then only calling it for the latter usage and not
> the former, but I get your idea.  It makes sense; I'll make the
> change.

Ah yes, oops. Yes we should clearly have the non-"-c [...]" case too
(and it's what I was aiming for) :)
