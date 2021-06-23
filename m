Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5F7C48BC2
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 19:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26B3C61166
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 19:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbhFWUBD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 16:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhFWUBD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 16:01:03 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7504FC061574
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 12:58:45 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id i5so5193013eds.1
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 12:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Rz75RwXfRpabwGse+kjOHxMw2IkLQKsdzRb/sQtIllI=;
        b=t8tSDbcGQgpLbjjCWqiRjUgRBriW0HLd+6zu9Vpo5DKigtJr5F7euT36WA0yCDt2Vj
         szEttF3VSW/nxiQx0z+rK42+GO81RCSvKXi2YCx1NDa0X0aTbMF/x7RhRPB0eyNWcOJh
         pqS/B3ZzY1GauPlWt/7pIhhUydKw0wepaEEPWTNaXxA/fq9EKt/mN2SdMdjox8q1r6jG
         21AFDmyM9p0Vq6SDKfrF7h0RC6Zr/5qYNQMLZX949scqsnMSgS5wIIUJj+v0euV3Nw9X
         Jk2fY3LHCXwXSKWp/kTIic7iTQXd+nyUazQI8k+kaHT1bJNT11FUBTr7aDg/BFMKSVv8
         udEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Rz75RwXfRpabwGse+kjOHxMw2IkLQKsdzRb/sQtIllI=;
        b=oXEbtYfj++Rs2cBiV2gNAQeV3LrBYhn5i7AiuKH17oirFbKFR522SiGdXdmm+GDmcQ
         r+Om7/h/8wDKgjaTOJPRfeY7kVjGnFtqm/QTOLd2di3gAG/I9xePLA8E7L+7mp1ovWmh
         0oWhiYBUDaR0+j+nJy83KdJHc6bDZerVT34YBwe1gGFf5T3CtAr3BZQdKyRhKLHsusVp
         /lHPyPMyxJ9TCJ5lBGQwhJJBV9Q0FhlNUumCifp4bH2M8KhYgCrAPGXjYkc6RvUeGWQt
         +rQdHkHKCIkWt0CMwpAcftC27VNtLTtvIHHCpnLn0l7fBmPONhFSy4nW7h8tUWbxD50e
         i5wg==
X-Gm-Message-State: AOAM532FkZRZh8d44+843xpDK123PQyKQCIHpLhJvs6g5n41mwzFfxpf
        pnqxmbmRXQd0qFlCpimt3C8=
X-Google-Smtp-Source: ABdhPJzX6kkJllYel1liRrgxoym2QzENT25IbNsqSqOqx5fRTJooP0Nl5N61gT8n8HCs4LMzSfGI7g==
X-Received: by 2002:a05:6402:5143:: with SMTP id n3mr2027797edd.80.1624478323920;
        Wed, 23 Jun 2021 12:58:43 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id de33sm286945ejc.38.2021.06.23.12.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 12:58:43 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Makefile: add and use the ".DELETE_ON_ERROR" flag
Date:   Wed, 23 Jun 2021 21:54:06 +0200
References: <patch-1.1-9420448e74f-20210622T141100Z-avarab@gmail.com>
 <YNIBRboFiCRAq3aA@nand.local> <8735t93h0u.fsf@evledraar.gmail.com>
 <YNI3WVu5SK7pHI7T@coredump.intra.peff.net>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.12
In-reply-to: <YNI3WVu5SK7pHI7T@coredump.intra.peff.net>
Message-ID: <87r1gs1hfx.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 22 2021, Jeff King wrote:

> On Tue, Jun 22, 2021 at 07:34:13PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> > That makes me a little sad, but it does leave us with a much cleaner
>> > Makefile as a result. So, I'm not really sure how to feel about it. I
>> > think in general I would be happy overall to see this picked up.
>> >
>> > [1]: https://lore.kernel.org/git/YGQdpkHAcFR%2FzNOx@coredump.intra.pef=
f.net/
>>=20
>> Yes, it makes me sad too, but as noted above I think you're right about
>> the general case, and so is Jeff in that E-Mail you linked, but it
>> doesn't apply to these patches, or my earlier patches.
>>=20
>> I'd like us to always have a working binary, but from my understanding
>> of Jeff and Junio's position on it it's something they'd like to
>> actively prevent, see the discussion around my earlier series.
>>=20
>> I.e. from what I gather they view this "your thing is clobbered as it
>> builds" as a feature. I.e. it serves to throw a monkey wrench into any
>> use of git that may overlap with said build, and they think that's a
>> feature.
>
> Just to be clear, I would be happy to drop the "oops, the tests barf if
> you recompile halfway through" feature away if it made things more
> robust overall (i.e., if we always did an atomic rename-into-place). I
> just consider it the fact that we do clobber to be an accidental feature
> that is not really worth "fixing". But if we care about "oops, make was
> interrupted and now you have a stale build artifact with a bogus
> timestamp" type of robustness, and "the tests barf" goes away as a side
> effect, I won't complain.

..and "this behavior is really annoying on one platform we target, and
the fix is rather trivial".

> I'd like it a lot more if we didn't have to add "mv $@+ $@" to every
> rule to get there. In some other projects I've worked on, compilation
> happens with a script, like:
>
>   %.o: %.c
> 	./compile $@

I'd think that supporting e.g. "-o" in the middle of an argument list in
such a tool would be more annoying than on the order of a dozen
callsites I needed to add this to in the linked series.

But yes, we could do it in some helper script too; I actually wrote one
that does almost that a while ago for a related use-case, simplifying
the "use cmp(1) and replace if different" we have copy/pasted in various
places.

> and then that "compile" script is generated by the Makefile, and encodes
> all of the dependencies of what's in $(CC), $(CFLAGS), and so on (we'd
> probably have an update-if-changed rule like we do for GIT-CFLAGS).
>
> And it also becomes an easy single spot to do that kind of "let's
> replaced the output atomically" trick.
>
> That's a pretty big departure from our current Makefile style, though.
> And I don't feel like it buys us a lot. Having a pretty generic and
> typical Makefile is nice for people coming to the project (I have
> noticed that most people are not well versed in "make" arcana).

I still think just doing "&& mv $@+ $@" is the simplest in this case, we
already have that in a dozen places in the Makefile, I wanted to add it
to a dozen or so more.

It's a common pattern already, I'd think if anything applying it
uniformly would make things easier to read, even if we didn't get more
portability & the ability to run stuff concurrently when you have "make"
active as bonus.
