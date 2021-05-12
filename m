Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80481C433ED
	for <git@archiver.kernel.org>; Wed, 12 May 2021 02:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AFB7611F1
	for <git@archiver.kernel.org>; Wed, 12 May 2021 02:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbhELCZW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 22:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbhELCZW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 22:25:22 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940E2C061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 19:24:14 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id c3so20887732oic.8
        for <git@vger.kernel.org>; Tue, 11 May 2021 19:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=8G1hyDZtlqOrJnmZ6qSrVd7NtMqbXhgFwJ3CGdXMsUw=;
        b=iwULS+0Fk1plsTqnjFQGIshk+gK9kLMhQ0riacEkZ9PQ/tnCU0d8FPjGQLPIQExJkv
         MAlLM2Z4ctzNY7jRD7aG3ruy6Qm1GsGanHsBZhqAQ5TE8fp8KG08XMoskKmtDpp4ZlLC
         usVo6HxKOcHXE9Jl2Txi8jxP80kLOq6I5lqDRP2SamHd/cPreu67ISQ/cp8aoyLl0wYd
         zVxD9z7GrPP56/iMxc2yDVW+klxnaKbu44w8hllA7OIi5cPp/ECew6HiUiFNtDQhRqa1
         Gm8dNI8KeTveTddRombkc0dEWC+tMz4Iba2OwJIH4x+1PPUpQkmexFfobPdmp5VOnHeo
         ETkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=8G1hyDZtlqOrJnmZ6qSrVd7NtMqbXhgFwJ3CGdXMsUw=;
        b=UbhkuNfYRLpA9qJWzA6zHf+nEY7wFw8Oa7M0m6n5MKotIVLVr+bGrOklbBCaPfZfiS
         XO+3tZORIAwfxN8E/59XI0N4sEWKX1QegGF/10Sxsskv5IbJBMhnBTzpV+ZdpURNAmje
         5RZHzrlkfGCPNqv2oFkELe7qDma4tUH6+DkdPW2LINzpwOCbbsltJ6tcaobYWuLmfHX0
         keulhDvggD6i73jLuRbP+0CPhSVqgBIWkLIM06LUj9eUHYfhh8Q+SG4/NrWuL00BWmUq
         uDWfFxu2CpKFFITNNw1NpsWuVEgiYvg1DknsVxGWzjK7A9y8OvgUSuLtk5hIpMsIfm29
         +h6Q==
X-Gm-Message-State: AOAM533Z6CjM4yUWJDg0IMaGiP3lpB8xqj7IkSRQdlV9jZqwF3cf8XJz
        1/pUcRj6r+QI8JBGhfKeTW4=
X-Google-Smtp-Source: ABdhPJxFBrXPRlXU4Tbo9m7NjJ5eP58RDpBG8Bi01qgwPq+CqVQYQ0M3XRpgD59AS07tHfDK/EzsFw==
X-Received: by 2002:a05:6808:6d9:: with SMTP id m25mr5792309oih.31.1620786254026;
        Tue, 11 May 2021 19:24:14 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id x24sm4192518otq.34.2021.05.11.19.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 19:24:13 -0700 (PDT)
Date:   Tue, 11 May 2021 21:24:11 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>, Varun Varada <varuncvarada@gmail.com>
Cc:     =?UTF-8?B?TWljaGFsIFN1Y2jDoW5law==?= <msuchanek@suse.de>,
        git@vger.kernel.org
Message-ID: <609b3c4bf3296_678ff2084c@natae.notmuch>
In-Reply-To: <YGzoX9OeWMKXpqtf@coredump.intra.peff.net>
References: <CAD2i4DBj6fNvq=Lc3KiXJj5uBpteyKfEKp7ATOWrTE36KUeRww@mail.gmail.com>
 <20210406092440.GZ6564@kitsune.suse.cz>
 <CAD2i4DDr3Ftk6RE8cA74iSsJTpC9nEb=Cqvr79pF51BpcWEnsA@mail.gmail.com>
 <YGzoX9OeWMKXpqtf@coredump.intra.peff.net>
Subject: Re: [PATCH] doc: replace jargon word "impact" with "effect"/"affect"
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
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

It's not necessarily wrong, but it's also not quite right.

You can say "the financial crisis impacted Jeff Bezos", because he was
affected, but was he *especially* affected? Nah. On the other hand "the
financial crisis affected Jeff Bezos" is something much less
problematic.

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

A synonym can be a word with nearly the same meaning in some senses. Not
necessarily exactly the same meaning in all senses.

> I do agree the word is over-used in some forms of writing, but I don't
> find anything at all confusing or wrong about the uses that you changed
> in your patch.

It doesn't need to be confusing to be changed. Most of the changes in
the code are not because the original version is confusing, but because
the new version is simply better.

Do you have any instance in which a sentence with "impact" is *better*
than whith one with affect/effect?

-- 
Felipe Contreras
