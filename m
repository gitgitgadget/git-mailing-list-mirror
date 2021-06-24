Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FC5C48BC2
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 01:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C8616135C
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 01:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbhFXBFc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 21:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbhFXBFc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 21:05:32 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4876CC061574
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 18:03:14 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id u11so5493154oiv.1
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 18:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=gj/PcyYdiv/RkUzZtWgLxQ7rpiifNw73m/6hfNx3w1I=;
        b=VuEyzTQBYdQVtp2Os2TLzs2jNPOOsqVUNZpOJ1rOAzohBMK2jDRfYyEONjyaQbxpg0
         XPcbRb45v1CDPsRvRJ+27gxHWNbyufYh3HU+vtRUy3KHgs0E5GMxYVorwXCUzguWCehV
         GSMB15CRFxsDjX2V5gpcq7T+DTF8XU2BRvLaej+LWZwuNMPBzP41zgoq5YLfWec8LJj6
         1UzctJsjmnm8pgsSXFNtVKXBj/uxAB+EzG4jXHCa39Sy6+RtNtm5Hpiv5uN8caCo489L
         v3X0p6fzyZIwpgn9h3zjT9yF6Ys8Z9zEDxJq63ROM6p2iz7Pq3rabUAT3wPhqYAQjsZp
         4Amw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=gj/PcyYdiv/RkUzZtWgLxQ7rpiifNw73m/6hfNx3w1I=;
        b=E8J9I0gWYXPOJsZeh+3zMdNn+7YWcm47GYoRQyuNfH1QDT2AmMdwWBQI/OvIk+UaOV
         XUtsRM/n9EB7e0CX0F9BRl5dUQGj5cDVj3wZO/HaHdfV1ZL9+mU7ofEuTUZb38313Blm
         V/ZBrzRuYP6fxaSIyR0kE1vIeH5BZzRb2tEtkxMNADxiwvSo8JqlF7mmq/531T/6e8FK
         09rnk0m3VGoEp+arhFE+o9D4xSiQzkrFRhQKcgYRO05DK+jxoXvYT3MxkbNqNqHWmpD4
         DCkoVMW/LW1jk7plm0TCSdXvDQQcZawG7nDOef7+Xiy0uecc4lWq5CS0TQ65t0z2C2Ui
         Paig==
X-Gm-Message-State: AOAM531yzKFwJyNaKw4PN2TF8AY5oqbFrhmRJ2qMmmRoIRjQUXVl2797
        V0ixCaKLp5egBXoHvHXu0HU=
X-Google-Smtp-Source: ABdhPJzigt+KCTscCTvWfoJCp97dIrbhq/DkKeTymNIeuYgx/4KM7d9KLU85oyntEpP85CnCKpudPQ==
X-Received: by 2002:aca:d805:: with SMTP id p5mr2063585oig.60.1624496593503;
        Wed, 23 Jun 2021 18:03:13 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id w11sm309870oov.19.2021.06.23.18.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 18:03:12 -0700 (PDT)
Date:   Wed, 23 Jun 2021 20:03:11 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <60d3d9cf77ddb_b4120889@natae.notmuch>
In-Reply-To: <YNPKwIuZvpyWSNXH@coredump.intra.peff.net>
References: <xmqq4ke8pig9.fsf@gitster.g>
 <patch-1.1-a950ef49e28-20210621T083254Z-avarab@gmail.com>
 <xmqqfsxbika3.fsf@gitster.g>
 <87mtrj2faq.fsf@evledraar.gmail.com>
 <YNPKwIuZvpyWSNXH@coredump.intra.peff.net>
Subject: Re: [PATCH v7] help: colorize man pages if man.color=true under
 less(1)
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Mon, Jun 21, 2021 at 09:08:20PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
> =

> > > [snip] I think it would be easier to understand to end-users
> > > if this were exposed as a new "mode", like "git help --web" and "gi=
t
> > > help --info" are different modes from the "git help --man",
> > > something like "git help --fancy-man" (or whatever is easy to type
> > > and explain, and also add it to the variants help.format knows abou=
t
> > > to make it easy to set the default).
> > >
> > > One advantage of doing so is that we do not have to worry about "ah=
,
> > > user has LESS_BLAH environment variable so we should disable this
> > > new mode here" etc.  As long as the new mode is requested either vi=
a
> > > the command line option or help.format configuration, it can
> > > completely take it over.  That simplifies the necessary explanation=

> > > given to the users quite a lot, no?
> > =

> > The interaction between "git help" and "man"/"less" doesn't really ha=
ve
> > an equivalent in the rest of git as far as color output goes. Usually=
 we
> > emit colors via our own programs.
> > =

> > But no, I think it makes the most sense to consider this orthagonal t=
o
> > help.format=3Dman or man.viewer=3D<cmd>.
> > =

> > We're not invoking a different man viewer or command, we're just
> > expecting that mode to invoke the pager, and if that pager is less to=

> > have these variables tweak our color preferences.
> =

> FWIW, if we are going to do this, then just having it as "color.man"
> makes the most sense to me. It is easily explained as "when we invoke
> man, set up some environment variables that may enable colors in the
> output".
> =

> I'm still entirely unconvinced that this should be in Git at all;

That's OK, you don't need to be convinced for this change to be a
positive one.

> pointing GIT_MAN_VIEWER or man.*.cmd at a color-man wrapper seems like
> it would be sufficient.

What color-man wrapper?

> But it feels like that conversation was not going anywhere productive;

Feelings are not facts.

Bailing from a discussion doesn't resolve the discussion, and the
question "how is a user supposed to configure this properly?" remains
unanswered by you, or anyone [1].

This patch is the closest to a convenient solution anybody has come up
with.

If anybody has any other proposal it would be good to hear them.

[1] https://lore.kernel.org/git/60bfadc0aca09_1abb8f208fd@natae.notmuch/

-- =

Felipe Contreras=
