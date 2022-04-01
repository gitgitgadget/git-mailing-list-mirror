Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96003C433F5
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 10:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245343AbiDAK2f (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 06:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241970AbiDAK2e (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 06:28:34 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F403F26E54C
        for <git@vger.kernel.org>; Fri,  1 Apr 2022 03:26:41 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id b15so2251500pfm.5
        for <git@vger.kernel.org>; Fri, 01 Apr 2022 03:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=coup.net.nz; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qJA8bNBTYoICSzMesyQFq751mA4NoRrrrhR2C5LfFys=;
        b=RJeArP7ieUgFjDimbZotkusfY5NW6EYtu8lUBd7ey6JTSQqUI3sRD5bbewernb0GTI
         bEdHdLstKQmTVusgRE7xf2FIxKGY2shxzIrB4E3DJXTV8K6wrTRSj42XLD+EJGu2WNt8
         84odLEL0af24q5rulA8cxQcBiR5yVhLG4quzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qJA8bNBTYoICSzMesyQFq751mA4NoRrrrhR2C5LfFys=;
        b=urTNvOCp1TmHL/2OKDkkjf5tFZ+Hqld8kdRfpEF0KNOOsNP/1tdN5OzYj7HdKPD6ee
         s+/xMEpzQVg9QkWYFJf68bcozusLPGUMcVBEVvF9wjpxT5OAzqcPxMMRRJyfV0V3zWhJ
         QbtWNAELHBWjUJdBeVei4PnfNVqEz7kEha+ZgErl4vTMGkXRWZ8VuGDXG72U7F+jrvPu
         OidphL6kQxABRPnx4cPhERFKauY5tn9C6DuA8Llne8xjK1p016OrISAiya5fXpo5BOu5
         hHVOfTlapo1Zgj4BhO5nWOO5vTkCRn2SRIDmvsgW7p2uVqO+ac0V88SRUsQtuTI/Kocx
         zr0Q==
X-Gm-Message-State: AOAM533zITVJQ9DYbvTbdLdu11M8e9mYHzJsdP5v+w07E+h0jnsECX+4
        sv/JNNtoOVSv0JWerALFStqO9IdJaoHtUKJFbrwG1SxsVWznu1Dh
X-Google-Smtp-Source: ABdhPJw+Y2L5+pbWVgqevHBKP0Fj2DGs5camkzKwn6nbxZvpcyzxMttxETEuuKoUhij7BQOIJqjE4jCrXBwZ9y2+Z6Y=
X-Received: by 2002:a63:2683:0:b0:382:65ea:d5aa with SMTP id
 m125-20020a632683000000b0038265ead5aamr14279518pgm.579.1648808801436; Fri, 01
 Apr 2022 03:26:41 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1138.v3.git.1646406274.gitgitgadget@gmail.com>
 <pull.1138.v4.git.1648476131.gitgitgadget@gmail.com> <03f0de3d28c00cbfda73f31a21e0fa8f8fe51742.1648476132.git.gitgitgadget@gmail.com>
 <220331.86o81mp2w1.gmgdl@evledraar.gmail.com>
In-Reply-To: <220331.86o81mp2w1.gmgdl@evledraar.gmail.com>
From:   Robert Coup <robert@coup.net.nz>
Date:   Fri, 1 Apr 2022 11:26:30 +0100
Message-ID: <CACf-nVdahRDwtbYFWAbJQ-f9XHDB3rJXYKcqzuURQUePCb-AjA@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] fetch-pack: add refetch
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Robert Coup via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        John Cai <johncai86@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi =C3=86var,

< just when I was thinking I'm done... ;-) >

On Thu, 31 Mar 2022 at 16:17, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avara=
b@gmail.com> wrote:
>
> FWIW it's not clear to me re earlier comments on earlier iterations
> whether the "noop fetch" is per-se wanted for this feature for some
> reason, or if it's just much easier to implement than doing what I
> suggested in:
> https://lore.kernel.org/git/220228.86ee3m39jf.gmgdl@evledraar.gmail.com/

The noop-fetch is an implementation detail IMO, and can be improved
if/when someone is motivated later.

> I don't think such a thing should hold this series up, but as it would
> be a bit kinder to servers I think it's worth at least noting in the
> commit message what's desired per-se here, v.s. what's just needed for
> the convenience of implementation.

Yes, doing some per-commit negotiation is conceptually nicer. The
user-facing alternative at this point is basically running "clone" in
some form; or temporarily moving aside the object DB and running
fetch. Both those (and the new approach) all end up putting the same
load on the server.

I can note it in the commit message.

> I.e. when this series was in an earlier iteration the scope was to
> repair repository corruption

That was never _my_ motivation, I was a bit eager in reflecting some
comments I received suggesting it would be useful for that as well.

> But now that it's a "fetch what's missing" wouldn't it make more sense
> to descend from our otherwise-negotiated tips, and find the OIDs that
> are "complete", if any, and negotiate with those?
>
> Which again, I think it's fine to say "yeah, that would be ideal, but
> this is easier". I'm just checking if I'm missing some subtlety here...

Yeah, that would be ideal, but this is easier. AFAICS I'm not putting
in place any barriers to making it smarter later.

> nit: remove the {} here
> nit: this double-indented if can just be one if-statement
> nit: don't compare against NULL, use ! instead.

Is the common interpretation for nits "Do another re-roll"; "If you're
doing another re-roll"; or "For future reference"?

> nit: This function has only two callers, perhaps it's clearer to do do
> this "early abort" in those calls?

I discussed similar in
https://lore.kernel.org/git/CACf-nVePhtm_HAzAKzcap0E8kiyyEJPY_+N+bbPcYPVUkj=
weFg@mail.gmail.com/
but yes, I think you're right about mark_complete_and_common_ref().
Will see what it looks like.

Thanks, Rob.
