Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F36A9C2B9F4
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 19:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2DE16162F
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 19:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbhFYTEb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Jun 2021 15:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbhFYTE3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jun 2021 15:04:29 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82BDC061574
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 12:02:08 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id u11so12451389oiv.1
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 12:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=bVP0Wy2EVhDRkDOqM555yi7m5ofYxexX2yDwEjZAF9s=;
        b=QGajeb54HNwu3d0tX7aSMKTcqtBac9t4x0ymKm5014J9OjS7WyKBwkJ4IEW0LLRT0Y
         +8ea1VLYwCytVLXXSIxTCaQ1WN2IiuuzI6KBPnP26ytmJMevUgC1LdpuoaFPNPDCiTiG
         OgUtLMjLQRbbjmQmtHbFDuOxAFccOj/NPyMVaRqQf+4nBrZc0vx/AweqgTERS6Cbq9DI
         H+F49OWlfK1Yzho0E1htTlkniYzQG/NGfRyVmTnzQCCegJ7WlIcydLhyO2tlkykp0Dn0
         xSLptdgAivRpfxQxoWRJKZDGJ4u3QGs5cSbHVWQl7JtDEqt4B4WWZsCtH/16cnFiVcT4
         Fnow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=bVP0Wy2EVhDRkDOqM555yi7m5ofYxexX2yDwEjZAF9s=;
        b=ObayJjxLG1doVwdsA8LTREDfTKiXmzCbRYbdRS7dMwDhHDa3B5+czzN6OhwcLKd+51
         aykKcPYuanRy5Y6W3Y8Pn85ZNyZTntP5iE8RwKyF58KlveZO9eWbvPUZBbePbprW0MqG
         RbPCwCYkb77oj7fAWiNPaIk/jXzOU1TV75jEvLX+TeX6RUdKc4/PZV6PCvd5WkL5ub4b
         TfSQSnWgPpf7juU+bf9vojAU9Dpm3vtBfJzaiFcQfFrMFvS2jhYv4poqMYrZDXvOqA8X
         xTewLr5MawqQ5vevUJCJormgXW9AONPS3HRBo2kOZ9I2vXEQR7cT++7diTW0f/Cl+hxA
         S+Yw==
X-Gm-Message-State: AOAM530bST/NQmrvufA5b9PnoQ0FcUXn0Zza/A1R0u+FRv4p5ibwDAO7
        ghTl0zzpA4UPHFL4T8dNqP0=
X-Google-Smtp-Source: ABdhPJzlyMZHuczoaJbwdY/A+l29T5WER75QGPMpftvoH52yzu7+6HSAeI8ZLDD9VSU1/FiONOBOeQ==
X-Received: by 2002:a05:6808:1511:: with SMTP id u17mr12782777oiw.53.1624647728108;
        Fri, 25 Jun 2021 12:02:08 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id o26sm1584620otk.77.2021.06.25.12.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 12:02:07 -0700 (PDT)
Date:   Fri, 25 Jun 2021 14:02:06 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>
Message-ID: <60d6282e246e5_cc8d2085c@natae.notmuch>
In-Reply-To: <YM0alLP5U81D+ZI0@google.com>
References: <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com>
 <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com>
 <patch-01.30-447d349c738-20210614T101920Z-avarab@gmail.com>
 <YMfLO9CT+iIDR3OA@google.com>
 <87lf7bzbrk.fsf@evledraar.gmail.com>
 <YM0alLP5U81D+ZI0@google.com>
Subject: Re: [PATCH v2 01/30] hook: add 'run' subcommand
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer wrote:
> On Tue, Jun 15, 2021 at 11:36:26AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
> > > Overall, I think I like the direction your reroll is going - I've n=
eeded
> > > some time to process it. Hopefully I'll be able to get through all =
or
> > > most of the series this week, but there's a lot going on here, too.=
 I'll
> > > do what I can. Thanks for the help.
> > =

> > Yeah, will reply to any qusetions etc; and as noted above my initial
> > goal here was "hey, what about this approach", so if you wanted to pi=
ck
> > this up & run with it...
> > =

> > This particular version of the series is at github.com/avar/git.git's=

> > es-avar/config-based-hooks-3 b.t.w.
> =

> Have finished scanning through the rest of the series, and I think I
> understand your goal a little better - you are not saying "let me take
> over and drive this part of the feature set", which is what I thought
> initially. Instead, you seem to be saying "let's chop it up this way
> instead".

Indeed. In particular =C3=86var's chopping allowed me to visualize what t=
he
patches were trying to do and it was much easier to review. Step by
step. I don't know about others, but I think it's similar.

> I don't dislike the reorganization, but I do still wonder whether it's
> a setback to the progress the original series had made. I guess it is
> hard to know - I had thought the original series was pretty much ready
> to go in, therefore making "what if we ordered it this way" moot. But i=
t
> seems that you disagree.
> =

> Anyway, I do hear also that you don't have interest in driving this
> subset to completion, and that's fine. Correct me if I'm wrong.

In an open source project nobody "owns" a set of patches, we can all
work on them collaboratively.

> I'll keep thinking on this over the weekend. Thanks for the suggestion.=


My suggestion is to not think about it too much. Just find what would be
the next logical step to do on top of =C3=86var's base and simply do it
(cherry-pick or rebase).

By simply trying it out you would get a much better idea of how the
series could progress to the end-goal you have in mind.

Cheers.

-- =

Felipe Contreras=
