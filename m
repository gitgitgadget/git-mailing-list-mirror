Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE39C48BCF
	for <git@archiver.kernel.org>; Sat, 12 Jun 2021 23:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77987601FE
	for <git@archiver.kernel.org>; Sat, 12 Jun 2021 23:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbhFLXPO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Jun 2021 19:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbhFLXPO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Jun 2021 19:15:14 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96358C061574
        for <git@vger.kernel.org>; Sat, 12 Jun 2021 16:13:13 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id j11-20020a9d738b0000b02903ea3c02ded8so7026743otk.5
        for <git@vger.kernel.org>; Sat, 12 Jun 2021 16:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iLqo36fOA9wtkFtHbpcuIzua/6fO7v7R8kGglVrQPaY=;
        b=ajExFw9R3XYULXYcg9vy0HO2j4nizRqi1g8eRbnRGfJMDQSj75EhQWKHV2AGEoBjMl
         O4VzFODFZLW1mqtqr7odapI80hEGC68MCsTCz/ltQOHjWbtw24KBfGL733FH+iNTb/T3
         5xJxoSx6X5pyz5WxQhHFVH1scAvC0KcJ5dMo4MstEkIldHQcze893lrd//ALexkpYhPN
         2V5+fYDYZ9Qs2a9G7AT51QCXUdayxMscDbdAmieUTbEYx0vhnwziYR+PSNDwx4mm4ePI
         dfxtV0rwNoKfLDUYQZpHxh8vlFlmRg3pZu5qcEc56BZp9QYSAeFraMjMaZQ4dCki2jPF
         xHDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iLqo36fOA9wtkFtHbpcuIzua/6fO7v7R8kGglVrQPaY=;
        b=X4lcu29+SXRUycTrsAIl6kAAcoyIp3ohgJcHV1bbn07DRJVDRE71Fc/K7KaYWynZOJ
         l02Yw7R8b9NKDAM9GsmvP3u3zDRsSxPcqQ9Q522BlBUJIWAmFcKEXmFHlUm66V31V5w5
         tv5Prf14anM3P4H/7lhQNW78zyjhvdAgYCX6k/QWQbhhw0wwpY98ln53O61gYk+TK2Oj
         vsTgjnP09gnoJd/fKp/dcOCnV2KuZffPYWPGJ1MUgoCps/M5ff+2ydURsJql+SGaACkT
         5lbwCQNBt41Ja29Xhp9RQW6PGeF2l3D30FCY7PjpWMcG3Eu6MYs/Okw9tuX3LnnaeAEJ
         xhTg==
X-Gm-Message-State: AOAM532JBVLY//Za+C5DYYV4cpT80kUeTX0iph3FFKa8hLlhJNKesk56
        wAc0+C65vmBvQcbpVicQr1omIbdm13UMg8s2GW4=
X-Google-Smtp-Source: ABdhPJz35qIV4BHCUTR/CucCTlAUVRky5XECtJa38hipL8jrD1f++vt2y18aSnZjfS5+bNCtFeBCfdomSRa9305cLKI=
X-Received: by 2002:a9d:2202:: with SMTP id o2mr8371041ota.24.1623539589729;
 Sat, 12 Jun 2021 16:13:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210512170153.GE8544@kitsune.suse.cz> <609c112066acd_71bd1208aa@natae.notmuch>
 <20210512180418.GF8544@kitsune.suse.cz> <609c2f98932f3_71bd120840@natae.notmuch>
 <20210513074622.GG8544@kitsune.suse.cz> <CAFLLRpJeU3BFKmsGgFoKQRLCw-uGRRH1Ob7PZBHUEQu_Pqshgw@mail.gmail.com>
 <20210513094818.GH8544@kitsune.suse.cz> <CAD2i4DDY1z1ZNigRfVog1205hKBk+U5KfinzXCk-2mkaYy4cjQ@mail.gmail.com>
 <20210527114629.GD8544@kitsune.suse.cz> <60afa7d9d4ca_2056d208d9@natae.notmuch>
 <20210527143541.GH8544@kitsune.suse.cz>
In-Reply-To: <20210527143541.GH8544@kitsune.suse.cz>
From:   Varun Varada <varuncvarada@gmail.com>
Date:   Sat, 12 Jun 2021 18:13:02 -0500
Message-ID: <CAD2i4DC0zH8WQvfZiHJA7f+DXubZjG6fKSuMbXdaztDC_PU4ZA@mail.gmail.com>
Subject: Re: [PATCH] doc: replace jargon word "impact" with "effect"/"affect"
To:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Robert Coup <robert.coup@koordinates.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 27 May 2021 at 09:35, Michal Such=C3=A1nek <msuchanek@suse.de> wrot=
e:
>
> > > Not all evidence. There are people who think the use is fine.
> >
> > What people think is not evidence.
> >
> > There's people who think the Earth is flat.
>
> And there's people who think it's not ok to use 'impact' as synonym for
> effect/affect, too.

This is not because they *think* this, but because it's demonstrably
true. The words are not synonyms according to any reputable
dictionaries, as shown already.

>
> Indeed, but what the dictionaries provide is a definition.
>
> Based on the definition some people think it's not OK, and some people
> think it's OK.
>
> That's only opinion, not evidence.

Hence, the dictionary definitions, which are evidence. If people are
confused as to what the words within the definition mean, they can
then recursively refer to the definitions of those words within the
definition. Unless you're implying that most of the dictionaries
referenced here are prescriptive (which they're not), then what the
dictionaries say are the definitions of words are results of the
linguists of those dictionaries going around and documenting what the
words mean, with ample historical and etymological evidence to back
it.

People having opinions about said definitions is, like you said, only
opinion and not evidence. All evidence points to the fact that the
words are not synonyms.

> >
> > > > that "per se" being used to mean "necessarily" is not a style issue=
,
> > > > using "impact" to mean "an effect" or "to affect" is not a style
> > > > issue.
> > > >
> > > > As has been stated already, the clear and substantial argument for
> > > > this change is that it reduces the confusion that arises from
> > > > improperly using the word "impact" in the instances without any los=
s
> > >
> > > There is no final authority on 'correct' word use in English.

Yes, there essentially is. It's called a dictionary. If you don't
respect the value of dictionaries, you're tacitly claiming that anyone
can use words in any which way they want and they would be correct in
doing so. E.g., someone can use "hello" to mean "goodbye" and be
correct because there's no so-called authority.

> >
> > You don't need a final authority.
> >
> > There is evidence that A is problematic.
>
> So we should stop using words that have different spelling in British
> and American English because no matter what spelling you choose somebody
> can find it 'problematic'?

No, because practically every dictionary on the planet acknowledges
when spelling differences exist and which spellings correspond to
identical words (e.g., "colour" and "color" mean the same thing in all
contexts).

>
> >
> > > We should learn to work together with people that use different
> > > variant of the language rather than insist that the variant that I or=
 my
> > > teacher uses is the only correct one and everyone else should use it.
> >
> > Except one variant is problematic, and the other is not.
> >
> >
> > Do you have *ANY* evidence that shows a problem with "effect"?
>
> I find problem with the proposition that 'impact' should be replaced
> with 'effect' based solely on the opinion that use of 'impact' is
> somehow inferior.

It's not "somehow inferior". No one is waving their hands arbitrarily;
it's already been discussed precisely how the word is inappropriate.

>
> This will bring in reviews that focus on hairsplitting when the
> formulation with 'impact' reads better than 'effect' and where the
> change does not make it read any better so it should not be changed.
>
> It also brings in reviews of the sort that simply say that use of
> 'impact' is OK, and there is no need to change.

That's an "if". This, however, is a situation where multiple people
have already voiced concerns about it being a problem. And it's not
hairsplitting; not at all, in fact. It's genuinely confusing.

>
> You can reason the change in different, more objective ways. You
> refuse and insist that people acknowledge that the use of 'impact' is
> wrong. It is not universally true in the same way that writing neither
> 'color' nor 'colour' is not universally correct.

It's clear by now that you are not fundamentally against the change
either, but are merely arguing about what reason one should "report to
the world" for why this change was made. I've already stated that we
don't need to agree on what the reason is since the end result will be
the same. Please stop this pedantic and frankly pointless discussion
about a hypothetical about what future people might think; it's
becoming exhausting. This is a change that (evidently) multiple people
in the present have brought up as an issue, so it needs solving now.

> Also I have so far not seen any real evidence that 'impact' is in fact
> used incorrectly, only some opinions and reference to a style guide.

If you don't consider dictionaries and style guides to be evidence,
then I don't know what counts as evidence.

Varun
