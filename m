Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0819C48BE5
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 16:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D94BE6191A
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 16:44:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhFOQqx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 12:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhFOQqv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 12:46:51 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C309FC061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 09:44:45 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id r7so37590046edv.12
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 09:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=llLzuXKIg/kQL1+1JdYSIo9yRZLYmqausJQzUbi1oHQ=;
        b=RG6zzj1ottHuq8KA207Uzk978kfNrMCN7omX+gjarqJ0TH0VtcACuerNFftTwMEK81
         sb+7XA1Z2Yt+KKg2L8QafttP4oA8r7jI3oAiKQhHb7qeC4+raJTNrP9MezAdlqu2LwPR
         oPtyDFXlM+HzA0xhkDqwh8F85rKhV5QQ89B4KYoLsX3EVxPNV5yTif896R8otzZ6d519
         dThrV1b+Werk855z/lZYZ4yG8HAm3ousOFTlmNxUI8pD16CfniZUOZYBNk/QGuD8AdV4
         HRDT+4p1emwfkLedRFzxDGn38ygS+6WexCaDSBEkzCj7Bbim/azXa0A8DGBVdQyHiOQu
         k56g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=llLzuXKIg/kQL1+1JdYSIo9yRZLYmqausJQzUbi1oHQ=;
        b=MsbwBR0CouD+GwdsWbNGZwj2DDIfZgv29xdHZvm2WYb0MRxnPGYrv335rOCpDQJh5k
         xn+sEm2WZf2Q+z6vE0HVG5ZxYW9zKtaNd/kbLwHcGaeqVD4XxtZn7pFCKHQ4qESWPjbg
         1lDST1bsPnArhgNxh//YzGAlAd3Q1Zdvu2eeem7gzgKnEXrdpcnrNeOdjReQOcemJKM1
         zwGkCPbLuT9qCMNNbR+Kfxt27cZy4g73G2bcUZHK3E07+hRSAqS5RMIwp0oparPwYdU8
         Lh0OA7kcjwWQVM/t1bmXy+AwvHEHBYRZ3SvmDPHQWuv/TlIgxt0a/zTrnfF9+lhdjeRy
         SDrA==
X-Gm-Message-State: AOAM5309oCcvUn4+6QKIbxV76Cp9o5BxM1Cu/e+V7zz5eQvKSKwNz1B7
        8AZq5vdA9ymfwu991ASLl+jvqBz4fG1odQ==
X-Google-Smtp-Source: ABdhPJzM85eLm8WECAl7rr3EsIRKHHQW5QKkvDTT0BPt2kuihREbySlseLPaH1YGVn3CptVrVDSUDg==
X-Received: by 2002:a05:6402:1590:: with SMTP id c16mr449587edv.7.1623775484126;
        Tue, 15 Jun 2021 09:44:44 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id cf5sm12659633edb.81.2021.06.15.09.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 09:44:43 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        sandals@crustytoothpaste.net, stolee@gmail.com, jrnieder@gmail.com,
        emilyshaffer@google.com, Andrei Rybak <rybak.a.v@gmail.com>,
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
Date:   Tue, 15 Jun 2021 18:19:53 +0200
References: <pull.975.v2.git.1623246878.gitgitgadget@gmail.com>
 <pull.975.v3.git.1623766273.gitgitgadget@gmail.com>
 <f06092a9053e40d93c4ec94b7fbbb1b8d563957b.1623766273.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <f06092a9053e40d93c4ec94b7fbbb1b8d563957b.1623766273.git.gitgitgadget@gmail.com>
Message-ID: <87a6nryt51.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 15 2021, Derrick Stolee via GitGitGadget wrote:

> [...]
> * References to fictional people with clear genders (e.g. Alice and
>   Bob).

I mentioned in the feedback on an earlier round[1] that aside from your
goals, these would be better rewritten. I've just submitted a series[2]
to do that; perhaps you can look at that and see if you think there's
still a reason to explicitly exclude these.

> * Sample text used in test cases (e.g t3702, t6432).

FWIW that's another unaddressed-by-you question I had in an earlier
round[1].

> [...]
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuideli=
nes
> index e3af089ecf26..0282f836548a 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -551,6 +551,34 @@ Writing Documentation:
>   documentation, please see the documentation-related advice in the
>   Documentation/SubmittingPatches file).
>=20=20
> + In order to ensure the documentation is inclusive, avoid assuming
> + that an unspecified example person is male or female, and think
> + twice before using "he", "him", "she", or "her".  Here are some
> + tips to avoid use of gendered pronouns:
> +
> +  - Removing the example person might make the sentence more
> +    clear and efficient.  Instead of saying "The programmer
> +    chooses between X and Y as she sees fit", it is clearer to
> +    say "Valid choices are X and Y".
> +
> +  - If you need to talk about an example person, then try using
> +    second-person to allow the reader to be that example.  For
> +    example, "If you want X to happen, you'd pass option Y",
> +    instead of "If the user wants X to happen, she'd ...").
> +    Alternatively, replace the single example with more than one
> +    person and use plural "they", such as "Interested readers
> +    can read 'git log -p README' to learn the history in their
> +    ample spare time" instead of "an interested reader" learning
> +    in "his" spare time).
> +
> +  - If you absolutely need to refer to an example person that is
> +    third-person singluar, you may resort to "singular they" (e.g.
> +    "A contributor asks their upstream to pull from them").  Note
> +    that this sounds ungrammatical and unnatural to those who
> +    learned English as a second language in some parts of the
> +    world, so should be avoided unless the earlier techniques
> +    fail to improve the sentence.
> +
>   Every user-visible change should be reflected in the documentation.
>   The same general rule as for code applies -- imitate the existing
>   conventions.

In the same E-Mail that you copied the original version of this new text
from[3], Junio suggested, mostly in reference to my [4]:
=20=20=20=20
    I tend to agree that =C3=86var's approach to guidelines is to cover more
    general readability tips, not necessarily focusing on avoidance of
    gendered pronouns, let alone encouraging of "singular they".  I
    think that is overall a good approach to advance the "let's make
    sure the document is easier to read by everybody" goal than
    mechanical "he and she are bad, let's use they" does.

To be fair he does go on to say something that suggests to also go for a
version of your approach here, i.e. that we still have some reference to
"they" over "he" and "she". I've got no problem with that, but he also
said (comments in [] are mine):
=20=20=20=20
    If we were to go that route [(of copying Junio's version from [3])],
    I think the first two points [(i.e. the first two bullet-points you
    incorporated above)] (which I didn't give enough thought to be even
    called a "draft") should be replaced with something like what =C3=86var
    wrote in his write-up.

So your version here does none of that, and we're mostly left with advice
about what not to do in the demonstrably obscure edge case of gendered
language in our docs (as evidenced by the diffstat).

But we aren't helping contributors much with with positive examples of
what to do unrelated to that, i.e. for documentation they could actually
be expected to write or maintain. I.e. general prose guidelines for
common the cases of discussing command-line options, program behavior,
user interaction etc.

Anyway, I don't think I'll be participating in this topic any
further. It seems you're not interested in pursuing alternate approaches
that accomplish your goals, or in responding to specific point-by-point
feedback on your series from myself and others.

I do think it would be a much better and respectful use of everyone's
time on this ML if you clearly stated your unwillingness to deviate from
the narrow approach in the initial version of a series you're
submitting.

Maybe I'm wrong and you are willing to incorporate something like more
general prose that accomplishes most or all of your narrow goals as a
side-effect, but right now it seems you're not.

If we're going to make some use of the collective time spent by a lot of
people on-list reading the documentation you're suggesting to change,
that'll have to be done in a series that would textually conflict with
yours (and which Junio would need to clean up), or in something that
would build on top of your more narrowly focused work.

1. https://lore.kernel.org/git/875yyp4fun.fsf@evledraar.gmail.com/
2. https://lore.kernel.org/git/cover-0.6-00000000000-20210615T161330Z-avara=
b@gmail.com/
3. https://lore.kernel.org/git/xmqqr1h51dce.fsf@gitster.g/
4. https://lore.kernel.org/git/87a6nz2fda.fsf@evledraar.gmail.com/
