Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7615CC433B4
	for <git@archiver.kernel.org>; Wed, 12 May 2021 02:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5108F61943
	for <git@archiver.kernel.org>; Wed, 12 May 2021 02:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhELDBD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 23:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhELDBD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 23:01:03 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41E9C061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 19:59:54 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id j17-20020a4ad6d10000b02901fef5280522so4667314oot.0
        for <git@vger.kernel.org>; Tue, 11 May 2021 19:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=BJdo/qlFFBLK9Z9X5jN4r2s4ednIRd4rUjJHgrL6hhA=;
        b=AtvtskC6mJlDcyDLrE+I5fPc/CYZx65f648+hp0iFMnH4uGg9ldL3wOmYJ3ZQTuc/h
         Hc697l+fkWLRuVQAVy5nZISHLqIOQtJLS8IX4llcn2FGn04QhVfbkTaI8Jicr1khrdMF
         OScJ8Tbkp8xEiPeC1OiI1nZ6JxosLsWmK+iJ6qtIZ14Oh9L8JUiY3roRNJBwmddYSeYx
         DOgh2XfVpx8jvbEtrL/tKeyl3oc+1rZp64lZJNWC4WxLuMSd2oYNpn4xmC3V8DgE3Vuc
         IG53Lfsnk9DMm2uWylFc/rT2wFt4TgTjpf7erAqSEvb6IFMrtV0ws48KEm3g0JbmoIch
         OoXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=BJdo/qlFFBLK9Z9X5jN4r2s4ednIRd4rUjJHgrL6hhA=;
        b=iPcwh7jORsvabRmpC6Ji/acH1u5lZ8es3yCJGAYdZ+l80Bi2sIwoczJP5q67lSHnYA
         UNUL7uHbfGIlHF5eKoFXIk9TPCkCo6nbWHv1Wak3FHDWy6GpG3ZqP59/zRv38AeYBq8F
         /7qvrN1eQetIqMeJAoAInV3SHD9auFHe1LgCAYHOO0d4Xiw7h387+5BppYzNmeKwol6n
         NVpK9hBmW43JbEE0d7ERGsGamqF/MNfI+syHOCOpjjtrx1hNe9EWvYRmBVC7dZdMRik9
         LB/jRlC7CPXJgSj8Ijhq5uLlQCskPhX4fKW6shheTFjo/s+hmmYy4onBLv8xn6bJ78w6
         Cniw==
X-Gm-Message-State: AOAM531G68+BdKKoHyX4bBYojSLE4xe1RnwrkUPl/QfX74XULpGIF97g
        W8Ws04Z0+MC+78Y7zmtpqUk=
X-Google-Smtp-Source: ABdhPJzkf2YfRrgH51GbyW6EQyVlMnfW7NBJ/18zDhjKyOahy+NNdNJ6pKAX5nBkuWDOak0hSY37IA==
X-Received: by 2002:a4a:8311:: with SMTP id f17mr22920058oog.83.1620788394106;
        Tue, 11 May 2021 19:59:54 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id r83sm801685oih.48.2021.05.11.19.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 19:59:53 -0700 (PDT)
Date:   Tue, 11 May 2021 21:59:49 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?TWljaGFsIFN1Y2jDoW5law==?= <msuchanek@suse.de>,
        Varun Varada <varuncvarada@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Message-ID: <609b44a559ade_678ff2088@natae.notmuch>
In-Reply-To: <20210511104326.GJ12700@kitsune.suse.cz>
References: <CAD2i4DDNZ+oOgtp8dcgqwUjtwaTYnNmg2E0oC88ZDW3LYMBiRw@mail.gmail.com>
 <CAD2i4DCtqxziTy5TPjG+U8EGC+8daJGXjpVgxoJwp8__t8fqxQ@mail.gmail.com>
 <20210428085838.GN6564@kitsune.suse.cz>
 <CAD2i4DASL-ZAsLm=_U53zvqMaAC_AOsGnTe-H=XQsfnftgb=rA@mail.gmail.com>
 <20210428184956.GS6564@kitsune.suse.cz>
 <CAD2i4DCLpvAuwp5UEDcPA0wzr4Eg_qhs_xXDW1eLiOwYkUvL1g@mail.gmail.com>
 <20210430075924.GB6564@kitsune.suse.cz>
 <CAD2i4DBSajgNFCwMMDv_tyQwuKDU095avmHs=BHcrAY1GbCqwA@mail.gmail.com>
 <20210510173502.GH12700@kitsune.suse.cz>
 <CAD2i4DBrERhtE5Br22s-bSt7C3SAvcHG62EZ=61COcnBGtUh-g@mail.gmail.com>
 <20210511104326.GJ12700@kitsune.suse.cz>
Subject: Re: [PATCH] doc: replace jargon word "impact" with "effect"/"affect"
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michal Such=C3=A1nek wrote:
> Also there is no single authority on the English language. The language=

> is spoken in multiple distinct countries, and even within one country
> there is some variation. It also evolves over time.

And this is precisely the reason why you target the least common
denominator.

Do you have **any** instance in which the sentence with "affect" reads
worse than with "impact"?

> Since you can look up the meaning of the word in a general purpose
> dictionary it should be an acceptable use even if it's less commonly
> used in some other English-speaking parts of the world.

If you are writing classic prose, and most of your audience needs to use
the dictionary to understand what you meant, you have failed.

> > > If you do wholesale word replacement in the project for no good rea=
son
> > > it only makes working with the project history harder.
> > =

> > I'm not sure I understand the sentiment here. As in, the Git history
> > will be polluted? Because the "git blame" command will only show
> > changes for the lines where I changed the single words.
> =

> Yes, it will be polluted. And since we have an opinion of another nativ=
e
> English speaker that the use of 'impact' as synonym for affect/effect i=
s
> fine this is clearly a matter of opinion.

It's not just native English speakers that read the English
documentation.

> This topic somewhat interests me so I was continuing this discussion
> in the hope that you either provide a specific very confusing use of th=
e
> word impact in the documentation that triggered creating this patch or
> some solid evidence that the general use of word 'impact' as synonym fo=
r
> affect/effect is in some way problematic but niether happened.

This is not how improvements work.

We have two options: $a, and $b. You argue that $a doesn't really
provide any advantages over $b (although it has been clearly demonstrated=

that it does). But you are not providing any advantage of $b over $a
either.

Let's turn the tables around; do **you** have any evidence that "impact"
is superior to "affect" in **any** instance?

-- =

Felipe Contreras=
