Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEF2C2B9F4
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 11:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CEA461459
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 11:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbhFYLMU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Jun 2021 07:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbhFYLMT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jun 2021 07:12:19 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B9DC061574
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 04:09:58 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id hc16so14365682ejc.12
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 04:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=1ADfCrmJyzZ9E8kVW5H/4fLmysPjcocpX0Vv8ESVobA=;
        b=fQJna0fwIu7V2kQqguaCAmG+oUeOPTnJx50nmrxELcbWC56389xai/IRRN3q06UXVx
         0trMCVnPnkFVukY12QdGpa0N60xy9Wigm/Iq7UhM1FDAsRa99JT7Sk1Jw4drjlp5wbYt
         rVeyvdelH/td1tSEnKg9b7rLkiiTPkDgifLSNZEejX+rORL5m7+lZRgCdMTbbPlz2Ojt
         8i0nl5z2Isw301TmuCOnE1lUWeuqaE/wFSXkDl7TxmFuiNimhEQPFytLmrb3lGZHlT27
         CXJiK+zxDKW181BtE5bKjgM0++5txqTHjPB3ySs1w+kUyoVxcXdewOR+DocDdIuWNXC0
         OpJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=1ADfCrmJyzZ9E8kVW5H/4fLmysPjcocpX0Vv8ESVobA=;
        b=Ix72A2wP/XqfqTcj+xcK+tXR50lhyduQquuAD+mIPKmJdJGOhoxuPx2e0oYTqrrkCk
         owhekY1NRaELofhBJvuoIn22yQ+We/VuiCptZd629j9eCT5rtAYM9oVbQYxk/E5sVJqo
         IIaAEBRJApMple6thFIy4yH2GmwmgiRBUz0Otg+Q/kiwCW6vthfHTCH5Y8SRjwrO2Yms
         3fj2UKPAuQE414Zbwx3e3XoWmBfBTW/226yQUHS8iI1WVColJfuc2SDa4IHg5akxl+U7
         p5jHiMoEXxVDq8wbKvtvAt/FOV0CX4v8DbXO76JT2wGdnQHsiPBxKitnlRGY8LqNqrPl
         yg6g==
X-Gm-Message-State: AOAM531f3PbFb/xhyoAFZrCYw2fJnkgHHovMNNe0WnGasxteaqpPbNzU
        knSUQ5HYFCnDB8dTlYe51Nw=
X-Google-Smtp-Source: ABdhPJxas9O/UjkD8d9URFKV8SwScO0ilBefzuj7mxtXViYDjS3spPge/hCy76AQc1cWLcIwhIfG7Q==
X-Received: by 2002:a17:906:2d51:: with SMTP id e17mr10229125eji.500.1624619396717;
        Fri, 25 Jun 2021 04:09:56 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id y5sm3711791eds.12.2021.06.25.04.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 04:09:56 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Philip Oakley <philipoakley@iee.email>, git@vger.kernel.org,
        =?utf-8?Q?V=C3=ADt?= Ondruch <vondruch@redhat.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/2] doc: pull: explain what is a fast-forward
Date:   Fri, 25 Jun 2021 12:59:11 +0200
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
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.12
In-reply-to: <60d5b430f2f13_ba7520890@natae.notmuch>
Message-ID: <87czsaxksc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jun 25 2021, Felipe Contreras wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Thu, Jun 24 2021, Felipe Contreras wrote:
>>=20
>> > Philip Oakley wrote:
>> >> On 24/06/2021 20:05, Felipe Contreras wrote:
>> >> > Philip Oakley wrote:
>> >> >> Hi Felipe,
>> >> >> On 24/06/2021 15:31, Felipe Contreras wrote:
>> >> >>> Philip Oakley wrote:
>> >> >>>> On 21/06/2021 18:52, Felipe Contreras wrote:
>> >> >>>>> --- a/Documentation/git-pull.txt
>> >> >>>>> +++ b/Documentation/git-pull.txt
>> >> >>>>> @@ -41,16 +41,41 @@ Assume the following history exists and the=
 current branch is
>> >> >>>>>  ------------
>> >> >>>>>  	  A---B---C master on origin
>> >> >>>>>  	 /
>> >> >>>>> -    D---E---F---G master
>> >> >>>>> +    D---E master
>> >> >>>>>  	^
>> >> >>>>>  	origin/master in your repository
>> >> >>>>>  ------------
>> >> >>>>>=20=20
>> >> >>>>>  Then "`git pull`" will fetch and replay the changes from the r=
emote
>> >> >>>>>  `master` branch since it diverged from the local `master` (i.e=
., `E`)
>> >> >>>>> -until its current commit (`C`) on top of `master` and record t=
he
>> >> >>>>> -result in a new commit along with the names of the two parent =
commits
>> >> >>>>> -and a log message from the user describing the changes.
>> >> >>>>> +until its current commit (`C`) on top of `master`.
>> >> >>>>> +
>> >> >>>>> +After the remote changes have been synchronized, the local `ma=
ster` will
>> >> >>>>> +be fast-forwarded to the same commit as the remote one, theref=
ore
>> >> >>>> Perhaps s/be fast-forwarded/have been 'fast-forward'ed/ ?
>> >> >>> No, there's multiple steps:
>> >> >> My key point was to 'quote' the fast-forward term.
>> >> > fast-forward is an English word [1], there's no need to quote it as=
 if
>> >> > it weren't.
>> >>=20
>> >> You appear to be arguing that your "explain what is a fast-forward"
>> >> (subject line of the patch) doesn't need, within the patch, to explain
>> >> that it is about the term "fast-forward", being used in a Git specific
>> >> way...
>> >
>> > When you are trying to explain the meaning of a word it's generally
>> > better to not use that word in the explanation. For example if you are
>> > trying to explain "recursion", but you use "recursion" in the
>> > explanation, that kinds of defeats the purpose.
>> >
>> > So yes, in the sentence "the local `master` will be fast-forwarded to
>> > the same commit as the remote one", the verb "fast-forwarded" can easi=
ly
>> > be replaced with "advanced" and no meaning would be lost.
>> >
>> > The meaning of this "fast-forward" verb is the same as when you
>> > fast-forward a tape, and is not git-specific.
>>=20
>> Using quotes for a term like 'fast-forward' or some made up word like
>> 'qibbix' doesn't just serve the purpose of clarifying which ones are in
>> the dictionary, but also to establish that the quoted word is jargon
>> within the context of the documentation.
>>=20
>> If I invent a new and exciting way to cut grass I might say my new
>> machine 'shaves' the grass. The word "shave" is something I assume
>> everyone knows, but I'm making it clear that I'm referring to the
>> exciting mode of operation of my new death machine.
>>=20
>> So I think it Philip's suggestion makes sense. We're not talking about
>> how to fast-forward a tape, but what happens in git when we use that
>> term.
>
> No. In this particular sentence we are using fast-forward *precisely* in
> the same way as a tape. We haven't even talked about what constitutes a
> "fast-forward" in git jargon.
>
> Substitute the word "fast-forward", and the meaning remains intact:
>
>   After the remote changes have been synchronized, the local `master`
>   will be advanced to the same commit as the remote one, therefore
>   creating a linear history.
>
> As I already explained.

I think even if you can accurately substitute the jargon it's worth
quoting the jargon, to call out that it's jargon we're using quoted that
place and others.

Anyway, that doesn't have much to do with your isolated change, just a
general comment on quoting v.s. not quoting invented
v.s. borrowed/reused words.

>> As an aside after however many years of using git this is the first time
>> I made the connection to that usage of the term, I thought it was jargon
>> git invented. That's also something to consider,
>
> I was in your camp, but after thinking deeply about what would be a
> better term than "fast-forward" (advance, forward, boost), I realized
> that in fact "fast-forward" is perfectly fine because it already exists
> in English and conveys precisely the meaning we want: quickly advance to
> a desired position.

I think whatever term we're introducing will need git-specific
explanation. E.g. because a "tree" is an everyday object our use of it
needs explaining.

>> I've also actually seen an interacted with a tape record and VHS tape in
>> my lifetime, but I suspect many readers of this documentation have not.
>
> But they have pressed fast-forward on their Roku control, or whatever.
>
> Not only is it part of modern technology, but it's even used inside
> films, TV shows, and video games. See TV Tropes for dozens of examples
> where inside the film they fast-forward [1].

Unfortunately I haven't been able to non-fast-forward say the Game of
Thrones TV show in such a way that the latest seasons makes any sense,
since no amount of button mashing will merge their version with mine :)

So I think in the context of us using this jargon to describe
git-specific concepts the connection to reality is tenuous at best

>> This isn't something for your patch, but I wonder more generally if we
>> shouldn't consider moving away from the term entirely, and just say a
>> branch was one of:
>>=20
>>     * advanced (or some other such term, forwarded?)
>>     * rebased
>>     * merged
>>=20
>> The existence (and it being the default) of "merge --ff" makes that
>> somewhat difficult, but in those cases we could and probably should just
>> also say "advanced" (or whatever), since that's what happened, ditto a
>> noop rebase.
>
> I already thought about it and I don't think so. The word "advanced"
> doesn't hint where, how much, or how quickly, could very well be just
> one commit forward.

Hrm, we use fast-forward for N commits advanced, including N=3D1, or
perhaps I'm misunderstanding you.

> This is one of those rare occasions where I think the git project chose
> the perfect word.

Perhaps, it's not like I've got much in the way of a holistic world view
with which to replace it.

I do think "perfect" would do a few things it doesn't though, imagine
reading about it for the first time and not making the connection to
tapes. Is it an optimization? Is there a slow-forward? What if upstream
rewound there branch and I merge, is that a merge-backwards?

It's not immediately obvious how rebase/merge/fast-forward relate or
if/when (e.g. merge sometimes being a merge-ff) they're incompatible
concepts.
