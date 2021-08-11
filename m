Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 023F5C4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 16:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D737260FD9
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 16:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhHKQz4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 12:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhHKQzx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 12:55:53 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BCAC061765
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 09:55:29 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id v10-20020a9d604a0000b02904fa9613b53dso4113220otj.6
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 09:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=8wyDtSgDei2ZGJelQ60ko2CUdyi93J9eEtjOky1uYPA=;
        b=W++BfWcQlkb0qCw0/DUQZoZC+Z28Nn7Fe1hyy0yPofIosT8uIL0SghA4C3ll6iJ3pb
         uDXsYqb+1LBrdH846/TeNze+UnAtM3lUWNCq8LFrYhDSggSq4ucmZrY8yTB4zeen83Ov
         nbYvqkWatuos2xo8gV77WA7J9s8EyKUJp77Q8CB5EK0RkK7X0RkVY8RFD6PmHpvvlSWV
         UTsebdWYy/vk+QswECxLPcjrX7GU7Us3fTTN2w5FzvYDYpWHT7iVJft8B1luzWOgt4Lw
         AcwBVd18vj0FteyA48V/p4Or7QvpM9r2npRvK5UQ9SEt8FOA7W5FUyVO6ldPqNKNR5sR
         0LCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=8wyDtSgDei2ZGJelQ60ko2CUdyi93J9eEtjOky1uYPA=;
        b=P3LGcCvoKLqhgK9MhTR0FbmdeWur0Zq8R2IRz0+DtVmmZ1WdIcgMqm/j2cWxi2pYIc
         10FUmoK/kwEdLki5I+8Gyt0Y8gcVr3LafZgJ2HzqQ/F744ZJm6SSTYTStvcAXCvRJ1Vp
         zQIHWCncsluC0JXynhpTzgrIEK+lTrQhYLX4A6mEKxjeTvSALv3KoFR7bd5DnyUYVPSc
         FFfSTNumRhaqNCNhBBklN8Bgf4aoYgNPhLR1PsfijzAzw500Q0NzmY3x0Bm/rmaK8gUq
         +sjUn5WfnOdJYiPe9ysPdBrnEpyj8clNPKbyQzbX+R9irw5SKSoUXWOAUH9SQODtd9TX
         iTYQ==
X-Gm-Message-State: AOAM530zfpbSh6d38MHVnjIqZPDxe6TtviuPjDjGW+ckyzdxLWFsU1nc
        tYkLl4Y8xVEmVaBWH8NsW/s=
X-Google-Smtp-Source: ABdhPJwHvsWIg/JT5k2313OyudGdauELVPwNPmHInGcsfXfBl8cJ5YjMILtGl5PMCkq3tAEtJDI9mw==
X-Received: by 2002:a05:6830:30a2:: with SMTP id g2mr23184347ots.206.1628700929026;
        Wed, 11 Aug 2021 09:55:29 -0700 (PDT)
Received: from localhost (fixed-187-189-69-1.totalplay.net. [187.189.69.1])
        by smtp.gmail.com with ESMTPSA id l13sm4838128oii.11.2021.08.11.09.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 09:55:28 -0700 (PDT)
Date:   Wed, 11 Aug 2021 11:55:27 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Michael J Gruber <git@grubix.eu>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Felipe Contreras <felipe.contreras@gmail.com>
Message-ID: <611400ff3e169_30a2087c@natae.notmuch>
In-Reply-To: <162867867735.7067.8548435810107710895.git@grubix.eu>
References: <20210811045727.2381-1-felipe.contreras@gmail.com>
 <162867867735.7067.8548435810107710895.git@grubix.eu>
Subject: Re: [PATCH 0/7] [un]stage: officially start moving to "staging area"
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael J Gruber wrote:
> Felipe Contreras venit, vidit, dixit 2021-08-11 06:57:20:
> > In the last 13 years of discussions virtually *everyone* has agreed t=
hat
> > the term "the index" is not a good approximation to how most users
> > perceive and utilize this feature. For a summary of the discssions se=
e
> > my blog post [1].
> > =

> > This is particularly true of newcomers, which is why everyone that
> > teaches git uses the term "staging area".
> > =

> > Among all the proposals for a better name "staging area" is by far th=
e
> > one with the most consensus.
> > =

> > Everyone except two people agreed that "the index" is not a good term=
.
> > =

> > All non-official documentation already uses the term "staging area" [=
2]
> > [3] [4], including what is considered by most people the best
> > documentation out there: the Pro Git book.
> > =

> > There is absolutely no reason not to start using the term "staging ar=
ea"
> > officially.
> > =

> > Let's start by making the staging area a first-class citizen and maki=
ng
> > 'git stage' a prominent command, similar to 'git branch'. Additionall=
y
> > add 'git unstage' too.
> > =

> > Only *one* person expressed discontent with the term "staging area".
> > =

> > In favor:
> > =

> > * Felipe Contreras
> > * Scott Chacon
> > * Jonathan Nieder
> > * Matthieu Moy
> > * Jeff King
> > * Miles Bader
> > * =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> > * Jay Soffian
> > * Pete Harlan
> > * Aghiles
> > * Piotr Krukowiecki
> > * Phil Hord
> > * Victor Engmark
> > * David (bouncingcats)
> > * Alexey Feldgendler
> > * Alexei Sholik
> > * Zbigniew J=C4=99drzejewski-Szmek
> > * Sebastien Douche
> > * Thiago Farina
> > * Mark Lodato
> > * Philip Oakley
> > * William Swanson
> > * Ping Yin
> > * Hilco Wijbenga
> > * Lars Vogel
> > * David A. Wheeler
> > =

> > [1] https://felipec.wordpress.com/2021/08/10/git-staging-area-rename/=

> > [2] https://git-scm.com/book/en/v2/Git-Basics-Recording-Changes-to-th=
e-Repository
> > [3] https://www.atlassian.com/git/tutorials/saving-changes
> > [4] https://coderefinery.github.io/git-intro/04-staging-area/
> =

> Of the many possible ways to restart this discussion, calling out
> names and pitching people against each other is quite possibly the
> worst.  Incidentally, this proves (again) what I wrote back then.

Everyone already agrees that "staging area" is a better term than "the
index".

> Git (the project) has always been about the strive for the "best"
> solution, and different people have different views about the metrics
> (technically sound, user friedly, consistency, backwards compatibility =
...),
> their scales and their relative weights - and the same is true for
> judging a particular suggested solution in these metrics.
> =

> There are definitely more than two "staging camps" in this community -
> you can come up with a count of "2" only if you conflate a multitude of=

> aspects, such as:

For any question there's always three camps: in favor, against, neutral.

In the particular question of "staging area" versus "the index" the
consensus is overwhelmingly in favor, very very few are neutral, and
only one person is against.

> - use the term staging area in documentation
> - scratch the term index from the documentation
> - use "--staged" option aliases
> - rename "--cached" option to "--staged"
> - use "stage" command alias for "add"
> - rename "add" to "stage" (and possibly revamp)
> - use pseudorev STAGE (and dump "--cached")
> - use pseudorev INDEX (and dump "--cached")
> - one of the above plus WORKTREE
> - ...

Each one of these questions has different people in
favor/against/neutral and they are mostly orthogonal to each other. For
example a person can be in favor of adding the term "staging area" in
the documentation but neutral to the "stage" command alias.

Either way the whole point of my proposal was to shine a light to the
question we have all agreed to: "staging area" versus "the index".

This means by extension that everyone (except one person) would be in
favor of using the term "staging area" in the documentation, which is
your first point.

Each one of those points could be implemented in a different patch
series, and each patch series can be discussed separately.

But my main concern is the *first* patch series, regardless of which it
is, so the term finally becomes official. If you don't like the first
patch series that I chose, then please state which would it be easier
for you to get behind and I'll gladly work on that.

I also have a patch series that implements --stage everywhere, and that
series already received feedback in 2014.

The reason why I chose this point is that 1) it's the one that I find
more useful, 2) it's the one that it's easier to implement, 3)
already received positive feedback, and 4) I wasn't the only one who
suggested this.

In case you don't remember, you yourself stated "in principle I like this=

a lot" [1] back in 2011.

> I would in fact think that this community is comprised of individuals
> rather than camps, and that overall it does not object against the use =
of
> "stage/staging area".

Junio objects to the use of the term "staging area".

> At the same time, the fact that 13 years on we still have the same
> "git diff --cached" etc. indicates that we never had an alternative
> concept and implementation which the majority agreed on.

No it doesn't. Git is not a democracy: the majority can agree on
something and yet if Junio disagrees, that's the end of that (as is the
case here).

> So, depending on how you conflate the aspects above into two, either th=
e
> "pro" or the "contra" camp consists of 1 person, and you can certainly
> reach most 2-partitionings.
> =

> Just imagine someone who thinks purely in terms of "technically sound"
> and "backwards compatible" (you know who you are ;) ): that person will=

> never be "pro stage" or "contra stage", but if they don't like your
> implementation of "git stage" you will put them in the "contra camp",
> giving up all chances of winning them over technically.

No. Being against a particular patch series doesn't necessarily mean
against the spirit of the patch series.

If that person would rather start with the --stage aliases, or using
"staging area" in the documentation, then that person can simply state
so on this patch series, and I will work on that instead.

> [As a side note, index might be more l10n-friendly than stage because o=
f
> its latin origin (so it's there in more languages already).]

We don't need to go into the hypotheticals of "might" because this has
already been discussed, and translators already agreed that "staging
area" is better.

Additionally =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason explained [2] that it=
 makes no sense to
look for a term in English that is easier to translate, but instead the
better term in English should be picked, and then that meaning is what
gets translated.

All this is mentioned in my blog post.

> I have been away from the project quite a bit (merely for lack of time)=
,
> but some people will remember me as striving for "consistency" in the U=
I
> (e.g., favouring "git diff [HEAD] INDEX" over "git diff --cached [HEAD]=
").
> =

> Independent of my remarks about the restart of the discussion, I had a
> quick glance at this series. The questions which arose already around
> "stage/staged" seem to indicate that the series is more about renaming,=

> some reorganising but not so much about a fresh look at a consistent
> user experience.

I did have a "fresh look" at a consistent user experience, and I did
send those patches in 2014 [3]. However, those patches had no hope of
going anywhere until Junio agrees to start using the term "staging area"
officially. So that's what this patch series attempts to do (although
I'm not hopeful in the least).

> In other words (and to show a way forward), a cover letter with the
> potential to bring many on board could start with:

Once again everyone is already on board.

> ##
> =

> It has been 13 years that we discussed about "the index", "the cache",
> "staging" and the "staging area". There seemed to be overall consensus
> that the concept of "put something on stage that is to be committed [to=
]"
> serves well in training and documentation when we explain git's index
> and related commands which change the index (git add) and compare to it=

> (git diff --cached).

It didn't "seem" there was overall consensus, there *was* close to 100%
consensus.

> Let's try and find a common ground for implementing this in user facing=

> commands. Here are a few possible appoaches:
> - command/option aliases
> - command/option renaming
> - revamping of the command structure (as we did "checkout->switch")
> - revamping the rev UI (from "--cached" to "INDEX" or "STAGE")
> - you name it

Most of these are not practical. For example why start renaming if we
can start with aliases, and then later on deprecate the old ones, and
finally obsolete them?

And again, these have already been discussed before and what people
seemed to gravitate towards are:

 * Officially use "staging area" instead of "the index" in the
   documentation
 * Add --stage aliases instead of --cache and --index
 * Make `git stage` more prominent

Anything else would require more discussion, and that's not my goal
here (not yet).

> To kick start this, here are a few more thoughts on some of these/an
> example implemenation for one of these/...
> =

> ##

I'm all in favor of changing the cover letter and even pick another
point on the list to officially start moving to the term "staging area",
but I think you are missing the main point:

Consensus has *already* been reached.

In fact, in all my years working on git I have never seen a UI change
proposal with more consensus.

Cheers.

[1] https://lore.kernel.org/git/4D594911.40409@drmicha.warpmail.net/
[2] https://lore.kernel.org/git/CACBZZX7LOKqKNe09636N0xJ_VvmKP58BMDtjoKn1=
t5e9hJ0OiQ@mail.gmail.com/
[3] https://lore.kernel.org/git/1398449567-16314-1-git-send-email-felipe.=
contreras@gmail.com/

-- =

Felipe Contreras=
