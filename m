Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB46EC47094
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 20:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6B266102A
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 20:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbhFGUCX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 16:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbhFGUCW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 16:02:22 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A383C061574
        for <git@vger.kernel.org>; Mon,  7 Jun 2021 13:00:31 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 5-20020a9d01050000b02903c700c45721so16904868otu.6
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 13:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=pJkM/ePrEJD6iSJhoYzkVv4haNvCsYtYEq5rNoQ9miI=;
        b=KDaBw5poA+C147O9Tf7ApuS22IMRHbYqQ+9mOtJC5H+U8IhRpyCzXOpkFtPo1xoHQ+
         0H9LJzTA+b4prSQCkAp6C1c1fty7TV1lNc4jR+vQkKvTPqaP4soI5Q/hk0MUCiDjyl2d
         qhTEeqrG6mPGXjZsIZdOo4zs9QtpAbvaq+pmSnUkN9MxULeSweZS2YKaAB7jJegB7Fba
         kMlFtlHzf5vBCQwaPcbzsSz4vUpYqWJamLYHnMRmkHB9GIQjhVZBxzueZb0XHifH1RW1
         MZ6G3pfSqjtekOCmK4URsEozd9LmWT/27E9PSd/4y8yPwaJZ1O3yFEI9A6whXCClbEQX
         GEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=pJkM/ePrEJD6iSJhoYzkVv4haNvCsYtYEq5rNoQ9miI=;
        b=YbPMoRjPywUAnRUPu5JwFAua6cZq1wONRTVA+xvMar3A6GjkwlOxZqwRb3y/DYJbb3
         F/E9mPbFJgR1xHlN0cVs7Y/glSRLtiQQY7U1polvqfjk+GGWD/2jtcP3e5dqHnYBFvev
         KrFDUN1kYiBypaJ1reQbe+DAbKzV0IJPsIpRyXT45TjscO6OTG9qzk2IKmC1jHUZRf4t
         hZIUEph7LeysdKVf9yqYsd0QDZk4PJ8RFBlbBZ4qAP6qmVy+lHoYBL+YY2s5BctJ5tab
         G1I6SSpROyWWmZv/vbYOQbGLZSGuWJkJX1JTPdD11uMozuQpMDXHbLPAMeRvB7kuu9fD
         LACA==
X-Gm-Message-State: AOAM532b6x/VbJcp3WnQCWiXf5F593FCAVOcp2Dw5bJey/uvBo5kQQnU
        TQ2xlnV5ZrJjKFwZagOWSZM=
X-Google-Smtp-Source: ABdhPJxSm9Y9ORfLCBEOy1bQDV4Pwv/ajErBgGWa2sZhjly7Q2YyPTP3f85NKWCLOaMfNOkqKmhVzA==
X-Received: by 2002:a9d:6a98:: with SMTP id l24mr4740517otq.360.1623096030344;
        Mon, 07 Jun 2021 13:00:30 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id n11sm202875otq.63.2021.06.07.13.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 13:00:29 -0700 (PDT)
Date:   Mon, 07 Jun 2021 15:00:28 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net, stolee@gmail.com,
        jrnieder@gmail.com, emilyshaffer@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Message-ID: <60be7adcdf3b_db9162081e@natae.notmuch>
In-Reply-To: <d2c079264955b3bd6c3a5ef77a9c3684206f8475.1623085069.git.gitgitgadget@gmail.com>
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
 <d2c079264955b3bd6c3a5ef77a9c3684206f8475.1623085069.git.gitgitgadget@gmail.com>
Subject: RE: [PATCH 4/4] CodingGuidelines: recommend singular they
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> =

> Technical writing seeks to convey information with minimal friction. On=
e
> way that a reader can experience friction is if they encounter a
> description of "a user" that is later simplified using a gendered
> pronoun. If the reader does not consider that pronoun to apply to them,=

> then they can experience cognitive dissonance that removes focus from
> the information.

We can solve that easily by using 50% he, and 50% she (I presume you are
in the equality of outcome camp in the culture war).

By using an invented pronoun we introduce more friction, especially with
the people that just learned English, and just familiarized themselves
with the standard English pronouns.

> If we use singular "they/them" pronouns instead of "he/him" or "she/her=
"
> pronouns, then we can avoid this congitive load on the reader.

I do not consider the singular pronoun "they" to apply to me. I presume
others are on the same boat.

Do I not count? If so, why?

> Using singular "they" is also incredibly efficient. Choosing a gendered=

> pronoun is usually arbitrary between "he" or "she". Using constructs
> such as "he or she", "s/he", or "(s)he" are more complicated than
> singular "they".

But it's not part of standard English language.

  Of all the turf wars that have complicated the landscape of grammar
  over the past few hundred years, the most complicated and frustrating
  may be that of the singular they.

  It may be the most controversial word use in the English
  language=E2=80=94because it highlights a hole where a better-fitting wo=
rd
  should go.

  It creates a conflict between writers and editors who want things to
  follow the natural symmetry of Latin, and people who find they the
  only logical option for referring to a single person without a gender
  attached.

  And there has been a lot written about it=E2=80=94it=E2=80=99s somethin=
g of a hot
  topic this year, thanks to a vote by the American Dialect Society to
  name they its word of the year for 2015.

  Alas, this problem isn=E2=80=99t as easy to solve as a vote from a dial=
ect
  society. The problem is something of an emotional one=E2=80=94and it=E2=
=80=99s sparked
  debate for centuries.

  Really, if this problem is ever to go away, it=E2=80=99s going to be up=
 to
  professional copy editors to speak up. And at least some of them
  appear to have made peace with the change.

https://www.atlasobscura.com/articles/the-linguistic-turf-wars-over-the-s=
ingular-they

This is a problem for linguists, copy editors, and society in general.
Not a software project.

By introducing rules that presume an outcome fiercly debated *at this
very moment* you are introducing more friction.

> When choosing a gendered pronoun, that pronoun no longer applies to
> nearly half of possible readers. Even if we alternated between "he/him"=

> and "she/her" perfectly evenly, we would still expect male and female
> readers to experience an incorrect pronoun half the time. However, some=

> readers will not prescribe to either of these binary genders. Those
> readers hence suffer an incorrect pronoun the entire time. Singular
> "they" applies to every reader.

This is a problem of the English language, not Git's documentation.

> Perhaps due to similar reasons, official style guides have changed thei=
r
> stance on singuler "they" in recent years. For example, the APA style
> guide changed their official recommendation in 2019 [1]. The MLA
> handbook also references helpful ways to use singular "they" [2]. While=

> not fully endorsing it, the Chicago Manual of Style has removed its
> blanket ban on singular "they" [3] (the previous recommendation was to
> only use "it" as a singular non-gendered pronoun).

This would be a killer argument if language was prescriptive, but it's
not. At least half of linguists (probably way more) are on the
descriptivist side.

Most writers ignore style guides and write in the way they see others
write. Not how anyone prescribes.

> While not all styleguides are updating their recommendations, we can
> make a choice as a project to adopt the concept because of the
> efficiencies above, as well as the benefits of increased inclusion.
> =

> To futher justify singular "they" as an acceptable grammatical concept,=

> I include the careful research of brian m. carlson who collected their
> thoughts on this matter [2] (lightly edited):
> =

>   Singular "they" has been used by native English speakers as part of
>   the language for over half a millennium and is widely used and
>   understood. This usage is specified in Merriam Webster[3]:

Again, I already responded to this argument:

A similar thing happens with the word "nucular" [2]; it is used by
native English speakers as part of the language for many decades and is
widely used and understood.

Does that mean it's a valid word? Maybe.

But does that make "nuclear" invalid? No.

You can use "nucular" if you want (many people do). I will use
"nuclear".

Both can be valid, and we shouldn't demand the use of one over the
other.

>   Linguists fit roughly into two camps: prescriptive and descriptive.
>   The former specify rules for people to use, and the latter document
>   language as it is actually used without forming a judgment.
> =

>   Some prescriptivists think it is acceptable, and some do not. But
>   descriptivists will rightly note that it is and has been commonly
>   used in English across countries, cultures, and contexts for an
>   extended period of time and is therefore generally accepted by most
>   English speakers as a normal part of the language.  Since we are
>   writing text for an English language audience who are mostly not
>   linguists, we should probably consider using the language that most
>   people will use in this context.

This is an argument against your proposal:

  1. It dismantles the need to heed style guides
  2. If it was true, we would already see wideslread use of the singular
     "they" in the documentation (and we don't)
  3. If we follow the descriptivist approach, the we should let the
     writers of the documentation follow what they think is best, not
     *prescrive* what prononoun they shall use

And even if this was an argument in favor of "they", you still need to
provide an argument against "she", or "he.

> If we refer to a specific person, then using a gendered pronoun is
> appropriate. Examples within the Git codebase include:
> =

> * References to real people (e.g. Linus Torvalds, "the Git maintainer")=
.
>   Do not misgender real people. If there is any doubt to the gender of =
a
>   person, then use singular "they".
> =

> * References to fictional people with clear genders (e.g. Alice and
>   Bob).
> =

> * Sample text used in test cases (e.g t3702, t6432).
> =

> * The official text of the GPL license contains uses of "he or she", bu=
t
>   modifying the license this way is not within the scope of the Git
>   project.

This is linguistic prescription [3]:

  Linguistic prescription, or prescriptive grammar, is the attempt to
  establish rules defining preferred or correct usage of language.

You can't eat your cake and have it too.

Cheers.

[1] https://www.atlasobscura.com/articles/the-linguistic-turf-wars-over-t=
he-singular-they
[2] https://en.wikipedia.org/wiki/Nucular
[3] https://en.wikipedia.org/wiki/Linguistic_prescription

-- =

Felipe Contreras=
