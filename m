Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9165C47089
	for <git@archiver.kernel.org>; Thu, 27 May 2021 17:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B468613BE
	for <git@archiver.kernel.org>; Thu, 27 May 2021 17:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbhE0RcA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 13:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235100AbhE0Rb7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 13:31:59 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C884FC061574
        for <git@vger.kernel.org>; Thu, 27 May 2021 10:30:24 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 80-20020a9d08560000b0290333e9d2b247so925979oty.7
        for <git@vger.kernel.org>; Thu, 27 May 2021 10:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Yu2MiIRQgXmz5IbwDMgqmS3Mc4co+UvbKk0R1rNL3ek=;
        b=nqfbdBIMSLSCSZhUfOq2LOBgANq7oAYe+nJSdkpVGQOfWYGDZ1NZZWfyD+A1c7ovyZ
         5E7dpa0mwgkQodDoIrwt9SML55ofSxHW1TA+MAh+HmipWRSZAKDUnOWfD6EtELvYmYPv
         UGlDQaO8h9AS367viLjMhfrMpGyyMMOoDk3113Qnc1tw7ph/IThXK/aHRzMxfeAqR5RG
         xa5S7d8i9VMPy53P3mPjJIohI/3E3OxjxiWebDrLlmYshjd9VAfZaXqRng/uGpKVKdeZ
         Iy2YupeH580I9zuo+qDgHhUVWZqmwJeMDyC1+F4U1ELMFj71IBFievnzEfQBg+IZZ6Y4
         HprA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Yu2MiIRQgXmz5IbwDMgqmS3Mc4co+UvbKk0R1rNL3ek=;
        b=iiWMrLODciTXDVDSyxuMy6lh2YCQ4fUV/xRvNVeOJgHrJmJjiniO5Axe4ddxsORytB
         9/s3tGm+8gm4aF1l9HQT+4JD5CnRPq5Qdw6yYl17bLCuQWJ+Z2vZi6Qg/Kzkh39jk/G0
         Phpc7HLyQXpxVUTJcm3+FQm5LDZYic4aAwn+CkvSptniQLEikDL35iTdRLIURW8Nb3JN
         GyOJE3C3lfeCQLS2gqvvPe+7Q5GuFAPLodmKilpfJ71ceZiRSOagGydFwaJWeZe+FrQf
         LGChhpq5CXn9iV2u2mW/FxiME6qXPqx7uWDRxvgXsCLTEV6yniOX0n5JRb600D8QgH1j
         oAoQ==
X-Gm-Message-State: AOAM531Kn6ZiAumqrpLypGYTQJTJQfxHR3DYlcTyJjJT9biranzu7Bd6
        pw9hbvXtnzPypHigIHFKqS8=
X-Google-Smtp-Source: ABdhPJyDcxU2esraa8Ln5/JCh0gk9e9BMRG36ls/RoXIMm0Yyq2srZ52T5gvI00K84Z3nho7nXVKlw==
X-Received: by 2002:a05:6830:319a:: with SMTP id p26mr3684756ots.314.1622136624131;
        Thu, 27 May 2021 10:30:24 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id k18sm647370otj.42.2021.05.27.10.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 10:30:23 -0700 (PDT)
Date:   Thu, 27 May 2021 12:30:21 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>
Message-ID: <60afd72defc6b_2653020886@natae.notmuch>
In-Reply-To: <YK+rmNWh+jPais9P@coredump.intra.peff.net>
References: <20210520221359.75615-5-lenaic@lhuard.fr>
 <715d8115-641b-5c06-d514-36911eb169ef@gmail.com>
 <44d937a0-e876-e185-f409-a4fd61eae580@gmail.com>
 <nycvar.QRO.7.76.6.2105220856320.57@tvgsbejvaqbjf.bet>
 <60aaa09aebce4_454920811@natae.notmuch>
 <YKrk4dEjEm6+48ji@camp.crustytoothpaste.net>
 <87wnrooa17.fsf@evledraar.gmail.com>
 <xmqqim38jfja.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2105250327550.57@tvgsbejvaqbjf.bet>
 <87mtshn3vj.fsf@evledraar.gmail.com>
 <YK+rmNWh+jPais9P@coredump.intra.peff.net>
Subject: Re: CoC, inclusivity etc. (was "Re: [...] systemd timers on Linux")
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Wed, May 26, 2021 at 12:29:01PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
> =

> > The reason I chimed in on this thread was that I thought concern over=

> > one such topic had started to negatively impact another. We've got a =
lot
> > of people trying to contribute who aren't comfortable contributing in=

> > English, or whose proficiency doesn't extend to the latest linguistic=

> > trends.
> > =

> > I'm suggesting that it's more helpful to leave certain things be than=
 to
> > pounce on contributors about things that are ultimately not integral =
to
> > their work, and which can be readily understood.
> =

> Yes, I want to express my support of this point, and not just for this
> particular issue.
> =

> If you're a new contributor (or even an old one), it can be frustrating=

> to spend a lot of time working on and polishing up an improvement to th=
e
> software, to be met with feedback that mostly consists of "there's a
> typo in your commit message". Whether that's true or not, or whether it=

> improves the commit message or not, it can feel like reviewers are
> missing the point of the patch, which will discourage contributors.
> =

> As reviewers, I think we can do a few things to encourage people,
> especially new contributors:
> =

>   - let little errors slide if they're not important. I think sometimes=

>     we get into a mentality that the commit message is baked into
>     history, and thus needs to be revised and perfected. But commit
>     messages are also just a conversation that's happening and being
>     recorded. There will be hiccups, and polishing them forever has
>     diminishing returns.

Yes, polishing forever has diminishing returns, but that's not really
the hard problem here; the problem is when two people (or more) can't
agree on what "polishing" means. That's a more eternal forever.

Fortunately we do have a dictator, and he can make determinations to end
the eternal debate.

He can simply fix the commit message--or any other minor
details--himself.

Sure, that doesn't scale, and ideally we would want the patch
contributors to do these tasks themselves, and not burden the
maintainer. But if the task of herding the cats is taken forever, why
keep insisting? Just fix the commit message and move on.

> I would even extend some of those into the code itself. Obviously we
> don't want to lower the bar and take incorrect code, or even typos in
> error messages. But I think we could stand to relax sometimes on issues=

> of style or "I would do it like this" (and at the very least, the
> "temper small corrections" advice may apply).

Plus code can be fixed later. If as a reviewer you really dislike one
aspect of a patch, you don't necessarily need to convince the author to
change it. You can propose a separate patch later on.


Sometimes good is good enough. Don't let perfect be the enemy of good.

Cheers.

-- =

Felipe Contreras=
