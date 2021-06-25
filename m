Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F288CC2B9F4
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 15:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7ED861952
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 15:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhFYPwU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Jun 2021 11:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbhFYPwT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jun 2021 11:52:19 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5494CC061574
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 08:49:58 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so9711188otl.3
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 08:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=lnwed4sq8Np/yWgERDionSUu8tCfA6c50R5Kpq3K+V8=;
        b=k2/fmYEpiX42vtiupp1b0gns86/YhK176XGTeQ4qA1TeZpMsLOmNVTdYa1hqORS+Vn
         184lKBbQRerIm7OGcyWffcXiMBqSVW87r2bvXTdHGMBPtmnZ9UxgKqMTZFF7jLEe+F19
         pUSkRh9rY/3pl8RNOmFtc2XsaFDiQ6GR1UnzdZZVoQqYivrzfDn0YyeLDCjsG6R3Ij9K
         WN94Hb63Sb+EHoaX45+/p3A3PLXNLg6FEeiCzCdQx7z2/7ZyOc0rcCRxHKbcXTSwBenw
         aALZOS5R2lIPfL7N9oWhRsQZZbxibGj9bBlKDP5gWtHUQt++jSJmPmpxEVlCWppM58cR
         PomA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=lnwed4sq8Np/yWgERDionSUu8tCfA6c50R5Kpq3K+V8=;
        b=Zw0rj/i4Yn4/HTeMA8S8jsORaBbrqbRq6YQQ5Uw4fwsJJXfYJzRQK0ZBWQa1MwLEA0
         4J7qlgboAHsSVd9c3EeBRwaYJtpHaWhhFRsJK6jfogG1j+P0+TCvnpG8hyQsc21hYICl
         s9vbxlKQ30/vRk9XmUJJdtqo3H3l/wQXNh2OUAVtNQmKBV02HNYHt/Y5OOOovVcgdtd7
         3tntKQ1LVdD9d0mjGoncDKcFWQ3V7Jo4S5jqHhiQka4VH2iMC1ElzE0smg5/8+iWuafS
         PIBOYF39Xiu7xixkdawAPbGMu50mRvovotgQw55DKBLa3vf3C2nn0vufilO8Tdy4Y3b8
         j03w==
X-Gm-Message-State: AOAM530Eu5l57lfnJCzMNvxPUxzS6HeRILud/wXtwCNyR00rmGh80pq/
        aT9HS/QP9B2cdpb0f6hHVOM=
X-Google-Smtp-Source: ABdhPJxTSp2xte9BZ702ll3EzSern2VDdX6QRUYE2jlLZ/vZipNsQOpAiTWEwlW+dUO0cRbDfi4OJA==
X-Received: by 2002:a05:6830:1098:: with SMTP id y24mr9875309oto.144.1624636197607;
        Fri, 25 Jun 2021 08:49:57 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id y84sm1376841oie.56.2021.06.25.08.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 08:49:56 -0700 (PDT)
Date:   Fri, 25 Jun 2021 10:49:55 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Philip Oakley <philipoakley@iee.email>, git@vger.kernel.org,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Message-ID: <60d5fb23c06a6_c2372086f@natae.notmuch>
In-Reply-To: <87czsaxksc.fsf@evledraar.gmail.com>
References: <20210621175234.1079004-1-felipe.contreras@gmail.com>
 <20210621175234.1079004-2-felipe.contreras@gmail.com>
 <b4e612ba-21c7-3bef-d113-0f070449cd87@iee.email>
 <60d49748b8538_2fb2082c@natae.notmuch>
 <c2170f74-b93b-599b-1fb4-45b013c7bff1@iee.email>
 <60d4d75e7622c_242620854@natae.notmuch>
 <93084036-804d-4c52-2836-42efd5deba1c@iee.email>
 <60d5183a9e34d_3a20208b@natae.notmuch>
 <87im22xpp4.fsf@evledraar.gmail.com>
 <60d5b430f2f13_ba7520890@natae.notmuch>
 <87czsaxksc.fsf@evledraar.gmail.com>
Subject: Re: [PATCH 1/2] doc: pull: explain what is a fast-forward
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> =

> On Fri, Jun 25 2021, Felipe Contreras wrote:
> =

> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >> =

> >> On Thu, Jun 24 2021, Felipe Contreras wrote:
> >> =

> >> > Philip Oakley wrote:
> >> >> On 24/06/2021 20:05, Felipe Contreras wrote:
> >> >> > Philip Oakley wrote:
> >> >> >> Hi Felipe,
> >> >> >> On 24/06/2021 15:31, Felipe Contreras wrote:
> >> >> >>> Philip Oakley wrote:
> >> >> >>>> On 21/06/2021 18:52, Felipe Contreras wrote:
> >> >> >>>>> --- a/Documentation/git-pull.txt
> >> >> >>>>> +++ b/Documentation/git-pull.txt
> >> >> >>>>> @@ -41,16 +41,41 @@ Assume the following history exists and=
 the current branch is
> >> >> >>>>>  ------------
> >> >> >>>>>  	  A---B---C master on origin
> >> >> >>>>>  	 /
> >> >> >>>>> -    D---E---F---G master
> >> >> >>>>> +    D---E master
> >> >> >>>>>  	^
> >> >> >>>>>  	origin/master in your repository
> >> >> >>>>>  ------------
> >> >> >>>>>  =

> >> >> >>>>>  Then "`git pull`" will fetch and replay the changes from t=
he remote
> >> >> >>>>>  `master` branch since it diverged from the local `master` =
(i.e., `E`)
> >> >> >>>>> -until its current commit (`C`) on top of `master` and reco=
rd the
> >> >> >>>>> -result in a new commit along with the names of the two par=
ent commits
> >> >> >>>>> -and a log message from the user describing the changes.
> >> >> >>>>> +until its current commit (`C`) on top of `master`.
> >> >> >>>>> +
> >> >> >>>>> +After the remote changes have been synchronized, the local=
 `master` will
> >> >> >>>>> +be fast-forwarded to the same commit as the remote one, th=
erefore
> >> >> >>>> Perhaps s/be fast-forwarded/have been 'fast-forward'ed/ ?
> >> >> >>> No, there's multiple steps:
> >> >> >> My key point was to 'quote' the fast-forward term.
> >> >> > fast-forward is an English word [1], there's no need to quote i=
t as if
> >> >> > it weren't.
> >> >> =

> >> >> You appear to be arguing that your "explain what is a fast-forwar=
d"
> >> >> (subject line of the patch) doesn't need, within the patch, to ex=
plain
> >> >> that it is about the term "fast-forward", being used in a Git spe=
cific
> >> >> way...
> >> >
> >> > When you are trying to explain the meaning of a word it's generall=
y
> >> > better to not use that word in the explanation. For example if you=
 are
> >> > trying to explain "recursion", but you use "recursion" in the
> >> > explanation, that kinds of defeats the purpose.
> >> >
> >> > So yes, in the sentence "the local `master` will be fast-forwarded=
 to
> >> > the same commit as the remote one", the verb "fast-forwarded" can =
easily
> >> > be replaced with "advanced" and no meaning would be lost.
> >> >
> >> > The meaning of this "fast-forward" verb is the same as when you
> >> > fast-forward a tape, and is not git-specific.
> >> =

> >> Using quotes for a term like 'fast-forward' or some made up word lik=
e
> >> 'qibbix' doesn't just serve the purpose of clarifying which ones are=
 in
> >> the dictionary, but also to establish that the quoted word is jargon=

> >> within the context of the documentation.
> >> =

> >> If I invent a new and exciting way to cut grass I might say my new
> >> machine 'shaves' the grass. The word "shave" is something I assume
> >> everyone knows, but I'm making it clear that I'm referring to the
> >> exciting mode of operation of my new death machine.
> >> =

> >> So I think it Philip's suggestion makes sense. We're not talking abo=
ut
> >> how to fast-forward a tape, but what happens in git when we use that=

> >> term.
> >
> > No. In this particular sentence we are using fast-forward *precisely*=
 in
> > the same way as a tape. We haven't even talked about what constitutes=
 a
> > "fast-forward" in git jargon.
> >
> > Substitute the word "fast-forward", and the meaning remains intact:
> >
> >   After the remote changes have been synchronized, the local `master`=

> >   will be advanced to the same commit as the remote one, therefore
> >   creating a linear history.
> >
> > As I already explained.
> =

> I think even if you can accurately substitute the jargon it's worth
> quoting the jargon, to call out that it's jargon we're using quoted tha=
t
> place and others.

But in this sentence it is not jargon. Do you want me to send another
patch using "advance" instead of "fast-forward"?

> >> As an aside after however many years of using git this is the first =
time
> >> I made the connection to that usage of the term, I thought it was ja=
rgon
> >> git invented. That's also something to consider,
> >
> > I was in your camp, but after thinking deeply about what would be a
> > better term than "fast-forward" (advance, forward, boost), I realized=

> > that in fact "fast-forward" is perfectly fine because it already exis=
ts
> > in English and conveys precisely the meaning we want: quickly advance=
 to
> > a desired position.
> =

> I think whatever term we're introducing will need git-specific
> explanation. E.g. because a "tree" is an everyday object our use of it
> needs explaining.

But in this specific sentence it's not a git-specific explanation. It's
using as few git-specific concepts, and as many non-git-specific
concepts, to explain a git-specific concept.

> >> I've also actually seen an interacted with a tape record and VHS tap=
e in
> >> my lifetime, but I suspect many readers of this documentation have n=
ot.
> >
> > But they have pressed fast-forward on their Roku control, or whatever=
.
> >
> > Not only is it part of modern technology, but it's even used inside
> > films, TV shows, and video games. See TV Tropes for dozens of example=
s
> > where inside the film they fast-forward [1].
> =

> Unfortunately I haven't been able to non-fast-forward say the Game of
> Thrones TV show in such a way that the latest seasons makes any sense,
> since no amount of button mashing will merge their version with mine :)=


But they used the fast-forward gag in Deadpool. Why? Because Hollywood
writers know their audience, and they know virtually everyone is aware
of what fast-forwarding is.

Even the simplest remote controllers have a fast-forward button.

> So I think in the context of us using this jargon to describe
> git-specific concepts the connection to reality is tenuous at best

Why do you think it was named "fast-forward" in the first place? And not
say "look-announce"?

I still haven't seen an argument as to why Deadpool writers (and many
others) would have used this concept if it weren't mainstream.

> >> This isn't something for your patch, but I wonder more generally if =
we
> >> shouldn't consider moving away from the term entirely, and just say =
a
> >> branch was one of:
> >> =

> >>     * advanced (or some other such term, forwarded?)
> >>     * rebased
> >>     * merged
> >> =

> >> The existence (and it being the default) of "merge --ff" makes that
> >> somewhat difficult, but in those cases we could and probably should =
just
> >> also say "advanced" (or whatever), since that's what happened, ditto=
 a
> >> noop rebase.
> >
> > I already thought about it and I don't think so. The word "advanced"
> > doesn't hint where, how much, or how quickly, could very well be just=

> > one commit forward.
> =

> Hrm, we use fast-forward for N commits advanced, including N=3D1, or
> perhaps I'm misunderstanding you.

For example in the context of a film, "advance" could easily mean move
one second ahead, or even unpause.

Fast-forward on the other hand can't be used that way, it implies moving
quickly many seconds.

> > This is one of those rare occasions where I think the git project cho=
se
> > the perfect word.
> =

> Perhaps, it's not like I've got much in the way of a holistic world vie=
w
> with which to replace it.
> =

> I do think "perfect" would do a few things it doesn't though, imagine
> reading about it for the first time and not making the connection to
> tapes. Is it an optimization? Is there a slow-forward? What if upstream=

> rewound there branch and I merge, is that a merge-backwards?
> =

> It's not immediately obvious how rebase/merge/fast-forward relate or
> if/when (e.g. merge sometimes being a merge-ff) they're incompatible
> concepts.

I don't think there's any word in the English language that would
magically place the fully-formed concept of the git's fast-forward in
the reader's mind.

That applies for all concepts though. A git "branch" needs to be
explained, just knowing what a branch is in English isn't enough, and if
nobody has used a SCM, the same for a "commit".


In psychology of learning there's a concept called chunking [1]. In
order to understand what the word "economy" means, you need to learn
many other concepts before, including the concept of "market", and for
that you need many others, including "money", and so on. Very complex
concepts are constituted by multiple big sub-chunks.

To explain the git-specific concept of a fast-forward, it's in our best
interest to reuse chunks that are already in the zeitgeist of the
culture, including the non-git-specific concept of fast-forwarding.

This patch is not simply saying a "fast-forward" is a fast-forward. It's
explaining the git-specific fast-forward by capitalizing from the
general knowledge fast-forward, which is so mainstream it's even used in
Hollywood.

Cheers.

[1] https://en.wikipedia.org/wiki/Chunking_(psychology)

-- =

Felipe Contreras=
