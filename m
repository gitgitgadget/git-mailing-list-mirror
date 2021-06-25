Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF604C2B9F4
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 09:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A1FF61421
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 09:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbhFYJ0R (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Jun 2021 05:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbhFYJ0Q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jun 2021 05:26:16 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6E1C061574
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 02:23:54 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id hz1so14106675ejc.1
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 02:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=AADQ5koAYoD21UVhEcGwKdKhfjROKh7fuEj/wo+b/9U=;
        b=RT7HVcKuwQ3qwt3T9Hgo7XmGdBdx+vZ+nPtz6wucW6KJ7pjnz83M9zLR+xsN4+WYak
         2+MA2rSR4/Dk/4n39GuNWdZ02/56hGABzp5uf1YZcg638QZ+eDAQb90fYZ+0x/ftN0kI
         npO5RvZjCyni4TtNhg4di4sffla4ISxIhavKUMO5QPFsLLpVYwLtiY0yksftoQGbb7d9
         u2daPbW128rE7suygte3wAYerLuI9kn27P0CkarXQm5XiheGE0seMFxgg2OFFzCaNHch
         UCJqq4ookpM5wOaG0OtWgluKoFnLU596QErbgwaRHLJ/KoPzxPfkwlsrt2rpmOySJy/6
         S+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=AADQ5koAYoD21UVhEcGwKdKhfjROKh7fuEj/wo+b/9U=;
        b=EAOHPuSCVp38WPzji3K7UAMJOKTX8f+awFBLRN6TiQ/U8ffBPHegvc9p8tgZMY/HIF
         gBz7fXud5pgRZrGJmT3Xs226aMRlmhO46TfTndLFWAEmZW1lOnhKyJvZP30mlxnIijHk
         Pwq8jebHeA+I8igh7+0jXF/PZ199O+dZu6+oPLVGG80dEuIrpA38Sw7e8xm/MzT7FD6E
         eJlbmet5L/coTJ2K3Cpq/5r3X+Y7BDwSyKSMp9TAiZOcIp+RU7/Eoy1kix6fs6gdLNMt
         Nsjd3lAvUa6lpEXBkQF3wl8c4DsfC+5k6hUqgcHZf+R8a34JCTtK4SimQ8HWwjVGQf4M
         cwFg==
X-Gm-Message-State: AOAM5339gkxgtDcmriZqBE4ECLTgAYXmbwadUVvD9GrEQtXVtgC7ySnr
        xVZKuRy1+pD5I/lSL2iROvo=
X-Google-Smtp-Source: ABdhPJxzeBybAyZjdBowHNFvgvCvcwzohV1n0l8tZ+N9NydZs5w/s3/xGBmVLl/gdltqNq1W9gIx5Q==
X-Received: by 2002:a17:906:509:: with SMTP id j9mr9863695eja.109.1624613033280;
        Fri, 25 Jun 2021 02:23:53 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id m26sm2423967ejl.26.2021.06.25.02.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 02:23:52 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Philip Oakley <philipoakley@iee.email>, git@vger.kernel.org,
        =?utf-8?Q?V=C3=ADt?= Ondruch <vondruch@redhat.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/2] doc: pull: explain what is a fast-forward
Date:   Fri, 25 Jun 2021 11:12:35 +0200
References: <20210621175234.1079004-1-felipe.contreras@gmail.com>
 <20210621175234.1079004-2-felipe.contreras@gmail.com>
 <b4e612ba-21c7-3bef-d113-0f070449cd87@iee.email>
 <60d49748b8538_2fb2082c@natae.notmuch>
 <c2170f74-b93b-599b-1fb4-45b013c7bff1@iee.email>
 <60d4d75e7622c_242620854@natae.notmuch>
 <93084036-804d-4c52-2836-42efd5deba1c@iee.email>
 <60d5183a9e34d_3a20208b@natae.notmuch>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.12
In-reply-to: <60d5183a9e34d_3a20208b@natae.notmuch>
Message-ID: <87im22xpp4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 24 2021, Felipe Contreras wrote:

> Philip Oakley wrote:
>> On 24/06/2021 20:05, Felipe Contreras wrote:
>> > Philip Oakley wrote:
>> >> Hi Felipe,
>> >> On 24/06/2021 15:31, Felipe Contreras wrote:
>> >>> Philip Oakley wrote:
>> >>>> On 21/06/2021 18:52, Felipe Contreras wrote:
>> >>>>> --- a/Documentation/git-pull.txt
>> >>>>> +++ b/Documentation/git-pull.txt
>> >>>>> @@ -41,16 +41,41 @@ Assume the following history exists and the current branch is
>> >>>>>  ------------
>> >>>>>  	  A---B---C master on origin
>> >>>>>  	 /
>> >>>>> -    D---E---F---G master
>> >>>>> +    D---E master
>> >>>>>  	^
>> >>>>>  	origin/master in your repository
>> >>>>>  ------------
>> >>>>>  
>> >>>>>  Then "`git pull`" will fetch and replay the changes from the remote
>> >>>>>  `master` branch since it diverged from the local `master` (i.e., `E`)
>> >>>>> -until its current commit (`C`) on top of `master` and record the
>> >>>>> -result in a new commit along with the names of the two parent commits
>> >>>>> -and a log message from the user describing the changes.
>> >>>>> +until its current commit (`C`) on top of `master`.
>> >>>>> +
>> >>>>> +After the remote changes have been synchronized, the local `master` will
>> >>>>> +be fast-forwarded to the same commit as the remote one, therefore
>> >>>> Perhaps s/be fast-forwarded/have been 'fast-forward'ed/ ?
>> >>> No, there's multiple steps:
>> >> My key point was to 'quote' the fast-forward term.
>> > fast-forward is an English word [1], there's no need to quote it as if
>> > it weren't.
>> 
>> You appear to be arguing that your "explain what is a fast-forward"
>> (subject line of the patch) doesn't need, within the patch, to explain
>> that it is about the term "fast-forward", being used in a Git specific
>> way...
>
> When you are trying to explain the meaning of a word it's generally
> better to not use that word in the explanation. For example if you are
> trying to explain "recursion", but you use "recursion" in the
> explanation, that kinds of defeats the purpose.
>
> So yes, in the sentence "the local `master` will be fast-forwarded to
> the same commit as the remote one", the verb "fast-forwarded" can easily
> be replaced with "advanced" and no meaning would be lost.
>
> The meaning of this "fast-forward" verb is the same as when you
> fast-forward a tape, and is not git-specific.

Using quotes for a term like 'fast-forward' or some made up word like
'qibbix' doesn't just serve the purpose of clarifying which ones are in
the dictionary, but also to establish that the quoted word is jargon
within the context of the documentation.

If I invent a new and exciting way to cut grass I might say my new
machine 'shaves' the grass. The word "shave" is something I assume
everyone knows, but I'm making it clear that I'm referring to the
exciting mode of operation of my new death machine.

So I think it Philip's suggestion makes sense. We're not talking about
how to fast-forward a tape, but what happens in git when we use that
term.

As an aside after however many years of using git this is the first time
I made the connection to that usage of the term, I thought it was jargon
git invented. That's also something to consider,

I've also actually seen an interacted with a tape record and VHS tape in
my lifetime, but I suspect many readers of this documentation have not.

This isn't something for your patch, but I wonder more generally if we
shouldn't consider moving away from the term entirely, and just say a
branch was one of:

    * advanced (or some other such term, forwarded?)
    * rebased
    * merged

The existence (and it being the default) of "merge --ff" makes that
somewhat difficult, but in those cases we could and probably should just
also say "advanced" (or whatever), since that's what happened, ditto a
noop rebase.



