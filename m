Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4855C2B9F4
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 10:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD6D561445
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 10:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbhFYKtg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Jun 2021 06:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbhFYKtf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jun 2021 06:49:35 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86AD3C061574
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 03:47:15 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id d21-20020a9d72d50000b02904604cda7e66so7045503otk.7
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 03:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=mix4LW5bEI1Z04/+7gsn4Lb8w23SdlxGZ2ojJKRXN4c=;
        b=jfqu8BlklMkZD8+RemsWPqoA80WvtCkL3TOw+Y8FOUXsPd/EtVY13/hf0/Aqd72nIM
         QTxqWZTJRlJUt1WTpUEyC/NcDYQMQXBZjhE/7bYWF880T5a/fSrMNkAbqal442Pe23ff
         DmAfYv1Om9jRVhNLpdAN6D9zDQUOFmcNiux7S2diglyiOQVEe9ZDs9ASCcmNQsl62Jhm
         9SST7jvSSp9/nwm4gWQ22I51MBe4PK96F3kgndCfe8XD8YuyNCDHkAtiaK+v9NlHGue7
         /Edi31zx330zLp3jttDaH5Dq2Q560MKq7Wq10Q2AtQ9OaY/UYD4bcoxpZPoimTTM9f/V
         YlIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=mix4LW5bEI1Z04/+7gsn4Lb8w23SdlxGZ2ojJKRXN4c=;
        b=ixF1QosE00rXN2fqbYjt2obRcrXq/rTUsOYHKv9UgBdAONzot3ojP8q7aNflTyRdmL
         2/p0dDIy72fwY3L9/ac0MJ+z+egkp7Sdvj1hkxCFs8c28yQeLnRLXpweGa5y/ef4JvjN
         +Sc1wm6AeSPloKj4QsaBBvtCuwg/Svm8KUb540Jw7brhBtq4u1HxT/T47RaLrLqwzRVM
         tV2tsbIrBc/YauXAAYTZJD0S842DCjb/uu7tbGMIZO3ytRsywr/D2anhSUID5yD5voI1
         1JXTmnev+CazyLr4K4Fv9+KJFFfe3JgLeVaNAvYQWZTUTh7d5WZ+oz3p5qiLOdpZ9vwB
         C+Uw==
X-Gm-Message-State: AOAM531vb26OwDBrH9/n1XIoB2CkSUhR/2/AdFkwyAQpstLz8ND7TmmQ
        OoUAnKJeqN8cwIh9G9ZVqDU=
X-Google-Smtp-Source: ABdhPJyLPyp3SHzshMLXxRwE4HdsnMKwVk5Emp4+V9VzSDoL72aobt9GiBVP8v4Z1BdWI50NiuYJPQ==
X-Received: by 2002:a9d:1905:: with SMTP id j5mr9005714ota.321.1624618034903;
        Fri, 25 Jun 2021 03:47:14 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id l7sm1245093otu.76.2021.06.25.03.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 03:47:14 -0700 (PDT)
Date:   Fri, 25 Jun 2021 05:47:12 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Philip Oakley <philipoakley@iee.email>, git@vger.kernel.org,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Message-ID: <60d5b430f2f13_ba7520890@natae.notmuch>
In-Reply-To: <87im22xpp4.fsf@evledraar.gmail.com>
References: <20210621175234.1079004-1-felipe.contreras@gmail.com>
 <20210621175234.1079004-2-felipe.contreras@gmail.com>
 <b4e612ba-21c7-3bef-d113-0f070449cd87@iee.email>
 <60d49748b8538_2fb2082c@natae.notmuch>
 <c2170f74-b93b-599b-1fb4-45b013c7bff1@iee.email>
 <60d4d75e7622c_242620854@natae.notmuch>
 <93084036-804d-4c52-2836-42efd5deba1c@iee.email>
 <60d5183a9e34d_3a20208b@natae.notmuch>
 <87im22xpp4.fsf@evledraar.gmail.com>
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

> On Thu, Jun 24 2021, Felipe Contreras wrote:
> =

> > Philip Oakley wrote:
> >> On 24/06/2021 20:05, Felipe Contreras wrote:
> >> > Philip Oakley wrote:
> >> >> Hi Felipe,
> >> >> On 24/06/2021 15:31, Felipe Contreras wrote:
> >> >>> Philip Oakley wrote:
> >> >>>> On 21/06/2021 18:52, Felipe Contreras wrote:
> >> >>>>> --- a/Documentation/git-pull.txt
> >> >>>>> +++ b/Documentation/git-pull.txt
> >> >>>>> @@ -41,16 +41,41 @@ Assume the following history exists and th=
e current branch is
> >> >>>>>  ------------
> >> >>>>>  	  A---B---C master on origin
> >> >>>>>  	 /
> >> >>>>> -    D---E---F---G master
> >> >>>>> +    D---E master
> >> >>>>>  	^
> >> >>>>>  	origin/master in your repository
> >> >>>>>  ------------
> >> >>>>>  =

> >> >>>>>  Then "`git pull`" will fetch and replay the changes from the =
remote
> >> >>>>>  `master` branch since it diverged from the local `master` (i.=
e., `E`)
> >> >>>>> -until its current commit (`C`) on top of `master` and record =
the
> >> >>>>> -result in a new commit along with the names of the two parent=
 commits
> >> >>>>> -and a log message from the user describing the changes.
> >> >>>>> +until its current commit (`C`) on top of `master`.
> >> >>>>> +
> >> >>>>> +After the remote changes have been synchronized, the local `m=
aster` will
> >> >>>>> +be fast-forwarded to the same commit as the remote one, there=
fore
> >> >>>> Perhaps s/be fast-forwarded/have been 'fast-forward'ed/ ?
> >> >>> No, there's multiple steps:
> >> >> My key point was to 'quote' the fast-forward term.
> >> > fast-forward is an English word [1], there's no need to quote it a=
s if
> >> > it weren't.
> >> =

> >> You appear to be arguing that your "explain what is a fast-forward"
> >> (subject line of the patch) doesn't need, within the patch, to expla=
in
> >> that it is about the term "fast-forward", being used in a Git specif=
ic
> >> way...
> >
> > When you are trying to explain the meaning of a word it's generally
> > better to not use that word in the explanation. For example if you ar=
e
> > trying to explain "recursion", but you use "recursion" in the
> > explanation, that kinds of defeats the purpose.
> >
> > So yes, in the sentence "the local `master` will be fast-forwarded to=

> > the same commit as the remote one", the verb "fast-forwarded" can eas=
ily
> > be replaced with "advanced" and no meaning would be lost.
> >
> > The meaning of this "fast-forward" verb is the same as when you
> > fast-forward a tape, and is not git-specific.
> =

> Using quotes for a term like 'fast-forward' or some made up word like
> 'qibbix' doesn't just serve the purpose of clarifying which ones are in=

> the dictionary, but also to establish that the quoted word is jargon
> within the context of the documentation.
> =

> If I invent a new and exciting way to cut grass I might say my new
> machine 'shaves' the grass. The word "shave" is something I assume
> everyone knows, but I'm making it clear that I'm referring to the
> exciting mode of operation of my new death machine.
> =

> So I think it Philip's suggestion makes sense. We're not talking about
> how to fast-forward a tape, but what happens in git when we use that
> term.

No. In this particular sentence we are using fast-forward *precisely* in
the same way as a tape. We haven't even talked about what constitutes a
"fast-forward" in git jargon.

Substitute the word "fast-forward", and the meaning remains intact:

  After the remote changes have been synchronized, the local `master`
  will be advanced to the same commit as the remote one, therefore
  creating a linear history.

As I already explained.

> As an aside after however many years of using git this is the first tim=
e
> I made the connection to that usage of the term, I thought it was jargo=
n
> git invented. That's also something to consider,

I was in your camp, but after thinking deeply about what would be a
better term than "fast-forward" (advance, forward, boost), I realized
that in fact "fast-forward" is perfectly fine because it already exists
in English and conveys precisely the meaning we want: quickly advance to
a desired position.

> I've also actually seen an interacted with a tape record and VHS tape i=
n
> my lifetime, but I suspect many readers of this documentation have not.=


But they have pressed fast-forward on their Roku control, or whatever.

Not only is it part of modern technology, but it's even used inside
films, TV shows, and video games. See TV Tropes for dozens of examples
where inside the film they fast-forward [1].

> This isn't something for your patch, but I wonder more generally if we
> shouldn't consider moving away from the term entirely, and just say a
> branch was one of:
> =

>     * advanced (or some other such term, forwarded?)
>     * rebased
>     * merged
> =

> The existence (and it being the default) of "merge --ff" makes that
> somewhat difficult, but in those cases we could and probably should jus=
t
> also say "advanced" (or whatever), since that's what happened, ditto a
> noop rebase.

I already thought about it and I don't think so. The word "advanced"
doesn't hint where, how much, or how quickly, could very well be just
one commit forward.

This is one of those rare occasions where I think the git project chose
the perfect word.

Cheers.

[1] https://tvtropes.org/pmwiki/pmwiki.php/Main/FastForwardGag

-- =

Felipe Contreras=
