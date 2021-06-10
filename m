Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65FB4C48BDF
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 23:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4916A61403
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 23:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhFJXrW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 19:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbhFJXrT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 19:47:19 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E4FC061574
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 16:45:07 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id g8so1736253ejx.1
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 16:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=PrI/XN03pPqtWzXWgjfQ6LdG3oDg931MRJIXZtB1obc=;
        b=MNSLypbjqPuNUSVM6AQl4KLmlmM22Fa9bn4PRSQ2vc6DtMnQARxFH+6cvnSN3QuqjQ
         P5hSjIdYnCEmGifmuVqU3Henyv1qxX59Jf1MmaXEIW0Jvjv2aBv5BCojda5lzhA78KhV
         WW6TY2GvgMhxW+8M+kV9Wh4tkxU/vUwHtc0HnIGHvIaTiZLHHGCyhFvXQPuESS6jmRvR
         X7cBiQVSFAlI4IdEbByeKLhw0W+Eq9HZOeJ1bp7Ea/L2+u11h158B/peZF+m6l8W+Fhq
         ieK671768XQKzsr6p5cKtmhOCcpoW3t5+ru0RmuYhXwLyNrho7PKtB/BLr+h/Wr+gIII
         Klew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=PrI/XN03pPqtWzXWgjfQ6LdG3oDg931MRJIXZtB1obc=;
        b=bhLmIA59q6uk8FmHtRMjnuGeIgO2NKMOQpIXHNuzMg79uBL2j96X4pn1TBpxiSt4s1
         cIngDatz7g0xggeE5gVwotyxGgabdIVcdVhQwyCiAEqOV2WckPh+D3B712xPspo4OJn/
         HVlQsztuii3BhwhzMpIQptWYxhTuxZYy9P9sADmB0ttnlx/6WXkT28ZpW5nxu806faYd
         u0DJlzaDqghTXE3CiMZiQYWHfXQB7ulR2JPcnO/meY413lhSdUoxkxIWhvfWdOY8PGe9
         lFBx3YGSgQoSg7FFgUSPE2GJPPwDK+bSrBV6xTHULQSWYARFkLM8PYloTzLoXMP+zmeU
         TujA==
X-Gm-Message-State: AOAM532zzWrE2MG6pPl+LiNI1lmtDKb3pUIr0ARywBZeLefh9YkAW7wm
        slH+2r0T3cV/6V5yjc/k9GQ=
X-Google-Smtp-Source: ABdhPJzTRHJ+A/QRuDYX9hPb66/+jlyoX+9JnTYmZwtazqarb3cY8sihljxfrbjDe18AkuTMJlMSIg==
X-Received: by 2002:a17:906:b55:: with SMTP id v21mr844425ejg.88.1623368705957;
        Thu, 10 Jun 2021 16:45:05 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id b14sm1365053ejk.120.2021.06.10.16.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 16:45:05 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, stolee@gmail.com,
        jrnieder@gmail.com, emilyshaffer@google.com,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Robert Karszniewicz <avoidr@posteo.de>,
        Jeff King <peff@peff.net>,
        "Kerry, Richard" <richard.kerry@atos.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 0/4] Use singular "they" when appropriate
Date:   Fri, 11 Jun 2021 00:58:22 +0200
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
 <pull.975.v2.git.1623246878.gitgitgadget@gmail.com>
 <87a6nz2fda.fsf@evledraar.gmail.com>
 <YMKTARn368Qzsqc2@camp.crustytoothpaste.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <YMKTARn368Qzsqc2@camp.crustytoothpaste.net>
Message-ID: <87pmwt1dz3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 10 2021, brian m. carlson wrote:

> [[PGP Signed Part:Undecided]]
> On 2021-06-09 at 15:44:59, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Wed, Jun 09 2021, Derrick Stolee via GitGitGadget wrote:
>>=20
>> > Updates in v2
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >
>> >  * Some edits were removed because they were in contrib/ or
>> >    Documentation/howto/ and these are now listed as exclusions in the
>> >    message of Patch 4.
>>=20
>> Thanks.
>>=20
>> >  * Several recommendations to improve the edits in the documentation a=
nd
>> >    code comments were incorporated. Those who recommended these edits =
are
>> >    credited with "Helped-by" tags.
>>=20
>> I think a v2 is a bit premature with all the active discussion on the v1
>> thread, a lot of which isn't addressed by the v2 or this CL, e.g. many
>> point I[1] and others raised.
>>=20
>> My main objection of extending this to commit messages and thus making
>> e.g. non-native speakers be on their toes when contributing to the
>> project is gone, so that's good.
>>=20
>> I'm still not in favor of this change because I think an active
>> recommendation like "Refer to an anonymous user in a gender neutral way"
>> probably isn't needed if we simply document that our preferred prose is
>> to avoid the issue entirely, which is the case in most of our
>> documentation.
>
> I agree that in many cases in technical writing that the passive voice
> (or another technique) may be preferable.  For example, this selection
> about O_TRUNC from open(2):
>
>   If  the  file already exists and is a regular file and the access mode
>   allows writing (i.e., is O_RDWR or O_WRONLY) it will be truncated to
>   length 0.  If the file is a FIFO or terminal device file, the O_TRUNC
>   flag is ignored.  Otherwise, the effect of O_TRUNC is unspecified.
>
> Who is truncating it?  Who is ignoring it?  Who is not specifying it?
> In all three cases, the specific actor is unimportant or irrelevant, and
> we're better off using the passive voice here than trying to enumerate
> the actor.

Exactly. The preferred prose in Git's documentation in this regard
should be the same matter of fact prose found in C library, binutils
etc. documentation.

>> The below for-show patch[2] shows an alternate approach that I think is
>> a better direction than this series.
>>=20
>> It shows how some of the s/he|she/they/g search-replacements you did
>> could IMO be better if we simply reduced the amount of prose, e.g. in
>> strbuf.h changing:
>>=20
>>     passes a context pointer, which can be used by the programmer of the
>>     callback as she sees fit.
>>=20
>> To:
>>=20
>>     passes a `void *context` to the callback `fn`
>
> In many cases, saying less is better, I agree.  If we don't need to
> refer to a human being, then we don't need to consider any pronouns for
> that human being.  If we communicate things more simply with fewer
> words, then that's clearly better overall for everyone involved.
> Nobody's reading documentation for pleasure, after all.
>
> I do think that the recommendation that we refer to an anonymous user in
> a gender-neutral way still stands, though.  Sometimes we will need to
> refer to the user or another human actor and that will be the most
> natural way to express the idea, so we should use gender-neutral
> language to do so.
>
> So roughly here, I'm in favor of both approaches.

When do we need or even prefer to refer to a user like that?

I haven't seen an example in our documentation that's actually better
off because we're talking about things as if two "people" we need to
invent pronouns for are interacting.

Can anyone name one that'll stand up under scrutiny, i.e. once we can
look at it and see if we couldn't phrase it better by avoiding the issue
this series tries to address with a regex search-replacement?

The diffstat of this series is only:

 12 files changed, 22 insertions(+), 15 deletions(-)

I've looked at all of them and I can't see one that wouldn't be better
if the relevant text was changed similarly to what I've suggested
upthread.

That's why I don't think this proposal is useful. If we accept this
series we're going to be left with an active recommendation for a
pattern that's already almost nonexistent in our documentation.

Perhaps that's because we're doing it 98% right already and aren't using
"he" or "she" but "they" or "their". The multiple ways you can use
"they" or "their" in the English language makes that hard to grep for. A
lot of our "they"'s are referring e.g. to a command-line option, or
"their" referring to "their arguments", as in the argv vector of a
program.

The skepticism about this being needed at all isn't an opinion I hold
about software documentation in general, but about software in Git's
problem space specifically.

Git isn't something like software to track medical records or tax
filings where we can make a hard assumption that the software is dealing
with data from people, and thus the software's documentation might
regularly expect to need to discuss such an invented cast of characters.

We just have:

 * You: The "user" of the software. Maybe a human being, but that's
   usually no more assumed than the "user" of chmod(2) being a human
   being.

 * Other users, not people, but users in the UID/GID sense of the
   word. Describing system-local interactions that are really two
   operating system users interacting in terms of assuming that they map
   onto two people just adds confusion.

   Note how e.g. chmod(2) and other such documentation rightly avoids
   bringing people into the matter. At most it refers to "owner" or
   "another user" etc.

 * "Other users" on the network, e.g. you make a change, it conflicts
   with upstream. I think in all these cases saying something like:

       You can add data and commit it, then push it. Once you push it
       you might find another person has made changes on the same
       branch, he/she/it/they changed the same file as you, now you've
       got a conflict...

   Is worse than:

       When push your branch you might get a conflict with the remote's
       upstream branch, if merging it results in a conflict then...

   In such scenarios we're talking about e.g. our local state
   interacting with remote network state, those are ultimately commits
   or other data we have to deal with in some way.

   It's almost never important whether that data was made by a human or
   some automated system. Inventing a cast of characters just makes
   things more confusing.

I think the nearest we come to rightly discussing actual people in the
context of git's documentation is things like commit envelope data
(names, E-Mail addresses). Even those don't cleanly map to human beings,
so our documentation probably shouldn't be implying that in its prose.
