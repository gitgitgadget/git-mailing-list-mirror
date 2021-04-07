Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198D4C433ED
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 00:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8964613BE
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 00:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245140AbhDGAG1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Apr 2021 20:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233071AbhDGAG0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Apr 2021 20:06:26 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72A3C06174A
        for <git@vger.kernel.org>; Tue,  6 Apr 2021 17:06:16 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id x2so16996425oiv.2
        for <git@vger.kernel.org>; Tue, 06 Apr 2021 17:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n4QnWDp3I1s8x/5asleWWimG4KYY250kz8+nBlz0DGA=;
        b=mAr3AceW8vISW2haEKEJada/vmZLB7HwSu0kZ6YWdOF+le4S133LP25Xo69L4Enit5
         wgakDCA2pBa2exCx3UwIdF9aDnnWbK3dOljoJEbBY7avchdzRooCmrDfkY9OE06kji+l
         bvCZRGUoht1xNjAGgImAyQW87WnqvfbifaspZwzMOo/n3vWOJQYtoCr4o9c4Luw5PG6d
         YQJU8DYadiLsQ8mujNt07ASBAxVxPsQoqYOZYbP9N/KF3+xla/cngVkITUlSin2E5Ajn
         rl0HVcWUNKoOCOGlM7WeIzeg2Xfp0N+fFO7thoulswdlmU+wlsXTFD0GHcVijCaBnuI5
         BmCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n4QnWDp3I1s8x/5asleWWimG4KYY250kz8+nBlz0DGA=;
        b=hj9qPw51fx/OJDNNJ4H4HAWFRkUv6jFAh2qfJswAHyt5nRZYnNpS1HTPmehS34L8cO
         /FekmlqsjpjBROpRRUsgMsQRxnO2XFLsFOyhodyx8wl6cF3uL/nlLrYLJpA4snzN49Pr
         92jcvLtT7eaWjtxMwjkeIhROTCIiIKNUjGGKSoHtSvFANUvGS9LAgMs4OHfYXJy3zocR
         rB9Xbqmy8TdIiUa2mQ0Px6ZRQnkDNvY2pJmFmlchukJluS9pt9awa/qU7VgvTgrs8pLU
         GmL9XXLg+gD+lNGEur0x2/ydn3loRHfXJOMwfjXR0PqYSYNOaqUBqw/FWmX2WMsDOVww
         Vxgg==
X-Gm-Message-State: AOAM530BMvWSAaPbLxkzffY+iZLmnq2qxh63H9j+wHoSFBi8uG3+P7Xp
        jBXmSJQxkUwMrOnGzf9zN/tMu1g0bitHrLuKpZU=
X-Google-Smtp-Source: ABdhPJx9GwFeNciQjmKxXLggBILdkz7Sx9/ANwwhwWtSzY3YWuTPj475uoBTgeswU787X64dpmfhUeSrQPFfipTBrPw=
X-Received: by 2002:a05:6808:483:: with SMTP id z3mr307049oid.166.1617753974544;
 Tue, 06 Apr 2021 17:06:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAD2i4DBj6fNvq=Lc3KiXJj5uBpteyKfEKp7ATOWrTE36KUeRww@mail.gmail.com>
 <20210406092440.GZ6564@kitsune.suse.cz> <CAD2i4DDr3Ftk6RE8cA74iSsJTpC9nEb=Cqvr79pF51BpcWEnsA@mail.gmail.com>
 <YGzoX9OeWMKXpqtf@coredump.intra.peff.net>
In-Reply-To: <YGzoX9OeWMKXpqtf@coredump.intra.peff.net>
From:   Varun Varada <varuncvarada@gmail.com>
Date:   Tue, 6 Apr 2021 19:06:03 -0500
Message-ID: <CAD2i4DDNZ+oOgtp8dcgqwUjtwaTYnNmg2E0oC88ZDW3LYMBiRw@mail.gmail.com>
Subject: Re: [PATCH] doc: replace jargon word "impact" with "effect"/"affect"
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 6 Apr 2021 at 18:01, Jeff King <peff@peff.net> wrote:
>
> On Tue, Apr 06, 2021 at 02:36:27PM -0500, Varun Varada wrote:
>
> > > while using "will not impact" in an incorrect or unclear way may be a
> > > problem the word "impact" in itself is not "jargon".
> >
> > The word means "to have a strong or marked effect on" (v.) and "a
> > strong or market influence" (n.) when used figuratively; it is not
> > synonymous with "affect" and "effect", respectively, as shown even by
> > all of the entries you've cited. Using it as such is the incorrect
> > part, so those are the instances I've changed in the diff.
>
> Er, is that true? From Michal's definitions:
>
> > > From The Collaborative International Dictionary of English v.0.48 :
> > [...]
> > >      2. To affect or influence, especially in a significant or
>
> It literally uses "affect" to define it. The "especially significant"
> does not apply to many, but I don't think that makes it necessarily
> wrong to use impact to mean "affect".

I was drawing attention to the "especially significant" bit and the
like being there in all the entries. I'm not sure about these
dictionaries, but the definition is hyperbolic / violent / shocking in
every reputable dictionary out there: the Oxford English Dictionary,
Merriam-Webster, and Collins.

>
> Likewise:
>
> > > From WordNet (r) 3.0 (2006) :
> > [...]
> > >       v 1: press or wedge together; pack together
> > >       2: have an effect upon; "Will the new rules affect me?" [syn:
> > >          affect, impact, bear upon, bear on, touch on,
> > >          touch]
>
> That is likewise listing "impact" and "affect" as synonyms.
>
> I do agree the word is over-used in some forms of writing, but I don't
> find anything at all confusing or wrong about the uses that you changed
> in your patch. I am a native speaker of English. I'm open to the
> argument that non-native speakers may be more confused by the word. But
> this seems like mostly a style preference thing, and I'd generally
> prefer to leave the contributions and style of the original writers
> intact unless there is a good reason not to.

I am a native English speaker as well, and there were multiple places
where I had to think twice about what the sentences mean. I agree with
your sentiment about leaving stylistic preferences intact, but this is
actually a semantic one. And given that there is a perfectly good
alternative that doesn't have this confusion / jargon status, I wanted
to make the change to improve it, especially where it says that in the
output of the git command (`git checkout` when in detached HEAD mode).

>
> Such changes are doubly unwanted in cases like this:
>
> > --- a/compat/nedmalloc/malloc.c.h
> > +++ b/compat/nedmalloc/malloc.c.h
> > @@ -2952,7 +2952,7 @@ static size_t traverse_and_check(mstate m);
> >  #endif /* (FOOTERS && !INSECURE) */
> >
> >
> > -/* In gcc, use __builtin_expect to minimize impact of checks */
> > +/* In gcc, use __builtin_expect to minimize affect of checks */
> >  #if !INSECURE
> >  #if defined(__GNUC__) && __GNUC__ >= 3
> >  #define RTCHECK(e)  __builtin_expect(e, 1)
>
> where the text is imported from another project, and we'd prefer to stay
> as close to their version as possible (e.g., to avoid unnecessary
> conflicts when pulling in new versions).

That's fair; I wasn't aware that this was being pulled directly from
another project. I can change this back.

>
> Also, this one should be "effect" anyway, as it is a noun.

This seems to have slipped through, as I used a text search tool.

>
> -Peff
