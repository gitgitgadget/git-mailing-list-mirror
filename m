Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77C9C48BE5
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 21:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C85EA600EF
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 21:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233842AbhFPVDb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 17:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233678AbhFPVDa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 17:03:30 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FEFC061574
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 14:01:22 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id nd37so6052668ejc.3
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 14:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=pxf7ON4WUc7YIf/QyFZ/aY0PbDVCVoYbE7z9kl1RmTM=;
        b=CjrlaCtX26e1HSZWV2lWD0k40wb3vFyaCSLNmVys8dRNAlzVHulM4EgnfdYx/ke0WL
         0VVVlWFTV418IsebfnaPgIP4+eGaw1WGh+s3YOXOwie0+omtWb45fBXwUZ7tQ5H7XTLJ
         3gMQwLzk7YdAUdGoEkf9GkBXZvgqHG3C3fqcFK/KApn2zEcjXhbC3k5BnuC+Wb+jfGoe
         XuZ//iyrIjc+zibvYhOWQE1U7AjwbhV37rTxSTx4Mg2EIwAayBlocdbz6kJLMA6S0Ppj
         mbxlOppw+GbRI93+Ux8wVIh2+V5WOlC+/GrRE/zXkdxDey24eohYpVCCYuyL1qcKkzJh
         8dXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=pxf7ON4WUc7YIf/QyFZ/aY0PbDVCVoYbE7z9kl1RmTM=;
        b=S6gkuPYXKW2rypQdYTQXuT6S+XAuVcJmRkrqTKun1mQaKF7YHaIaAKFDgKaN3wDLym
         zvbfi6HDWYJI1W+uJOxjT9e70vl9sGZNVI3G3pXctdJbcginyEdaBO4cHIPf3RhYSytx
         11aVSJuyPnIu5x+n3UDmpM32lEzDCeEexaUi2V56zDXyLwJQDz3fzVpdAqDvOBoRtV+f
         Ld7Roa72SRkuRDbFaqY9FNT39FripY50gfpfwjG9IW6x/nEwvUsV2fVBsq0k4i01vOTF
         PyocS+wNVeNZMS1vboB8ZTuJxKaCNa7ddmhcYK14M4MVdhJfTrHB/ov+W2oZWsr4cXje
         v5aw==
X-Gm-Message-State: AOAM531LiUFieXGaArVvwwKsmh0ATBLZDw/J+PFMKEr7oFcRYWX0oMd5
        SL2oNZ0iiMf3Qo109e5t5UY=
X-Google-Smtp-Source: ABdhPJwtd3BbfuyoaZQiHe0uZWmi7WCuzCeJD46pcCmEtOm8hTXr6VL+01wqtOrYWRo/Il5KXsx/2g==
X-Received: by 2002:a17:906:1815:: with SMTP id v21mr1474302eje.376.1623877281036;
        Wed, 16 Jun 2021 14:01:21 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id f10sm2649163edx.60.2021.06.16.14.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 14:01:20 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sandals@crustytoothpaste.net,
        stolee@gmail.com, jrnieder@gmail.com, emilyshaffer@google.com,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Robert Karszniewicz <avoidr@posteo.de>,
        Jeff King <peff@peff.net>,
        "Kerry, Richard" <richard.kerry@atos.net>,
        Phillip Susi <phill@thesusis.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 4/4] CodingGuidelines: recommend singular they
Date:   Wed, 16 Jun 2021 21:54:20 +0200
References: <pull.975.v2.git.1623246878.gitgitgadget@gmail.com>
 <pull.975.v3.git.1623766273.gitgitgadget@gmail.com>
 <f06092a9053e40d93c4ec94b7fbbb1b8d563957b.1623766273.git.gitgitgadget@gmail.com>
 <87a6nryt51.fsf@evledraar.gmail.com> <xmqqsg1iseza.fsf@gitster.g>
 <xmqqbl86qtyf.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <xmqqbl86qtyf.fsf@gitster.g>
Message-ID: <87bl85y15s.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 16 2021, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> FWIW, I am not happy with this version for that reason, either.
>>
>> I wonder if replacing the first two bullet points ("Removing" and
>> "If you need to talk about") above with what was added to the
>> CodingGuidelines by the "succinct matter-of-factly description" in
>>
>> https://lore.kernel.org/git/87a6nz2fda.fsf@evledraar.gmail.com/
>>
>> would be sufficient.
>
> So, here is what I plan to queue on top of these four patches to
> replace my "not even draft" garbage with what you wrote, with a bit
> of copyediting.
>
> Comments?
>
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> index 605f924981..476b840d30 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -546,28 +546,43 @@ Writing Documentation:
>   twice before using "he", "him", "she", or "her".  Here are some
>   tips to avoid use of gendered pronouns:
>  
> -  - Removing the example person might make the sentence more
> -    clear and efficient.  Instead of saying "The programmer
> -    chooses between X and Y as she sees fit", it is clearer to
> -    say "Valid choices are X and Y".
> -
> -  - If you need to talk about an example person, then try using
> -    second-person to allow the reader to be that example.  For
> -    example, "If you want X to happen, you'd pass option Y",
> -    instead of "If the user wants X to happen, she'd ...").
> -    Alternatively, replace the single example with more than one
> -    person and use plural "they", such as "Interested readers
> -    can read 'git log -p README' to learn the history in their
> -    ample spare time" instead of "an interested reader" learning
> -    in "his" spare time).
> -
> -  - If you absolutely need to refer to an example person that is
> -    third-person singluar, you may resort to "singular they" (e.g.
> -    "A contributor asks their upstream to pull from them").  Note
> -    that this sounds ungrammatical and unnatural to those who
> -    learned English as a second language in some parts of the
> -    world, so should be avoided unless the earlier techniques
> -    fail to improve the sentence.
> +  - Prefer succinctness and matter-of-factly describing functionality
> +    in the abstract.  E.g.
> +
> +     --short:: Emit output in the short-format.
> +
> +    and avoid something like these overly verbose alternatives:
> +
> +     --short:: Use this to emit output in the short-format.
> +     --short:: You can use this to get output in the short-format.
> +     --short:: A user who prefers shorter output could....
> +     --short:: Should a person and/or program want shorter output, he
> +               she/they/it can...
> +
> +    This practice often eliminates the need to involve human actors in
> +    your description, but it is a good practice regardless of the
> +    avoidance of gendered pronouns.
> +
> +  - When it becomes awkward to stick to this style, prefer "you" when
> +    addressing the the hypothetical user, and possibly "we" when
> +    discussing how the program might react to the user.  E.g.
> +
> +      You can use this option instead of --xyz, but we might remove
> +      support for it in future versions.
> +
> +    while keeping in mind that you can probably be less verbose, e.g.
> +
> +      Use this instead of --xyz. This option might be removed in future
> +      versions.
> +
> +  - If you still need to refer to an example person that is
> +    third-person singular, you may resort to "singular they" to avoid
> +    "he/she/him/her", e.g.
> +
> +      A contributor asks their upstream to pull from them.
> +
> +    Note that this sounds ungrammatical and unnatural to those who
> +    learned English as a second language in some parts of the world.
>  
>   Every user-visible change should be reflected in the documentation.
>   The same general rule as for code applies -- imitate the existing

That mostly-my-draft was hastily a written one-off, perhaps this is
better and a more exhaustive discussion of common cases:

  - Discussing command-line options, and program functionality:

    Prefer succinctness and matter-of-factly describing functionality in
    the abstract.  E.g.

     --short:: Emit output in the short-format.

    Avoid more verbose constructions, such as:

     --short:: Use this to emit output in the short-format.
     --short:: You can use this to get output in the short-format.
     --short:: A user who prefers shorter output could....
     --short:: Should a person and/or program want shorter output, he
               she/they/it can...

  - Addressing the reader:

    Address the reader of the documentation directly with "you",
    e.g. "you can do xyz".

  - Discussing Git, "the command" etc.:

    Use "we" when discussing how the program might react to the user, or
    perhaps "git" or "the command", e.g.:

        we might store the data[...]
        git will emit[...]
        the command will[...]

  - Discussing other users:

    When referring to other users on the same system prefer talking
    about "a user" or "another user". There's usually no reason to
    invent a cast of characters with names, titles and hobbies.

    Your OS's users don't cleanly map onto any particular people, a user
    of git might be having a merge conflict with another person, or an
    automated commit from a cron daemon.

    We prefer the style typical of standard library adn system tooling
    documentation in this and most other cases, you can look at the
    documentation of chmod(2) and other commands, syscalls and libraries
    that deal with UIDs or GIDs for examples.

  - Discussing other systems:

    As with discussing other users, git might interact with other
    systems over the network. In these cases we also avoid a cast of
    characters, preferring to talk about concepts like "fetching data
    from a remote", having a conflict with "diverging histories" etc.

The references to "gendered prounouns" etc. are gone, perhaps there's a
good reason to re-include them, but the point of "isn't that issue
solved by recommending an orthagonal approach?" is one of the many
things Stolee hasn't been addressing in the threads related to this
series.

To me that whole approach is somewhere between a solution in search of a
problem and a "let's fix it and move on". Not something we need
explicitly carry in our CodingGuidelines forever.

The v1 of this series started with decreeing that nobody should be using
gendered language in commit messages. It seems that the discussion I
started that perhaps that was overly pedantic and unfriendly to people
struggling with English won out, so that's gone in recent revisions.

That's left only a handful of examples \b(?:she|he)\b in our docs, we
have outstanding patches to fix those, and draft guidelines (amended
above) to thoroughly lead documentation writers in other directions.

It just seems superfluous to me to insist on enumerating increasingly
obscure and disfavored alternatives to what we suggest as preferred
prose in our documentation. For example, we have around the same order
of magnitude of "one might" in Documentation/, I think we should
probably just fix that and move on, not forever have a guideline against
overly formal or "Shakespearean language" in the guidelines.
