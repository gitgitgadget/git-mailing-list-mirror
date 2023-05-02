Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7472AC77B7E
	for <git@archiver.kernel.org>; Tue,  2 May 2023 16:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbjEBQ5m (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 12:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbjEBQ5k (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 12:57:40 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF04BD7
        for <git@vger.kernel.org>; Tue,  2 May 2023 09:57:39 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6a5eea94963so3720182a34.3
        for <git@vger.kernel.org>; Tue, 02 May 2023 09:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683046659; x=1685638659;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NizfW1IlQtTT3W/Zc7I123vly+c/t/+1sEOz6bqSDR4=;
        b=lPGs9X7yVKaSh4QPQYnAaSEURb5OesRDWVCpJWT24ip4MuYCh6pE2oFr5DY7TGn9AW
         /cgBdaSRkaJa97dBGHoWSGyjv+xIv+z5WEBKVvHmmKYxPr5vSerKmgjeZ2mwKqdMQLbm
         K1pSW+gADW0thl2tx3n0/5l5J+ti7ZDGTj+tznRWK3N9TvlUxNCi3/O2ko1is80SsS1x
         R1ggA8ReRFauLgSXGjfGW9d2LpQAlbBG8TJX24VYSfS0GQnUEIAfYdpPvRQvgqc3pR7b
         ixmzcyoxeMGgAZqqTAL3757NtqCC5CxDJzt8WB7rtomluCmGV3ozTm2NbPvDr4fGV3sL
         mTjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683046659; x=1685638659;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NizfW1IlQtTT3W/Zc7I123vly+c/t/+1sEOz6bqSDR4=;
        b=BjZRBdH5dMYH0IlQty5gxmV+SAWYKYyY2pa0vnP1ZgPmkWXBeOW1MREGRKivH6K4Ck
         4jix/JLmORjStpkZR1wkZEwM/RF2MYZXHdzRUqLC4NnkIWPQM0BcvYVl47dxXUvsubHN
         TuEj/OtuUyEmfFJoL4BA70L7TbILAxmFAfSR8bB3OWJWMwfRLDQz4+JZDNRuTtsXLIFi
         +FZUJb4VEPAiPPbjgywj19zxiq62rIn8Z3NAwC/d911SrABgA+FebQKY7xWo07UbE1eg
         APAFBd5HkiscKUcIc/hrOuH5e/DBg4+5Opemf1M7hIiunwY+ClQ7zmA15WRSDRK9rDSm
         WCpQ==
X-Gm-Message-State: AC+VfDwKMIc9uXRuriHOXvuU5ShOGptdzKOqcBHM/9GVZyDF0rBb2tyd
        YfAplW62/XsqKtJupTADP4Y=
X-Google-Smtp-Source: ACHHUZ6hzYIigj1VgAAm7vlY3mRIXF0D95NwE9aWT0jbuXIKsgDg///WxzsxqHIzx5uoDZ9nZUAh+w==
X-Received: by 2002:a9d:7603:0:b0:6a8:c3bc:81a9 with SMTP id k3-20020a9d7603000000b006a8c3bc81a9mr8755719otl.31.1683046659075;
        Tue, 02 May 2023 09:57:39 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id z2-20020a9d7a42000000b006a62c3af7bfsm11760457otm.81.2023.05.02.09.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 09:57:38 -0700 (PDT)
Date:   Tue, 02 May 2023 10:57:37 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Chris Torek <chris.torek@gmail.com>,
        Pooyan Khanjankhani via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Pooyan Khanjankhani <pooyankhan@gmail.com>,
        Pooyan Khanjankhani <p.khanjankhani@digikala.com>
Message-ID: <64514101af396_1ba2d294cd@chronos.notmuch>
In-Reply-To: <CAPx1GverCci3SZQEMvFX_q7r3XSTKmPizfcj8QcvGNud7reY9g@mail.gmail.com>
References: <pull.1485.git.git.1682495081131.gitgitgadget@gmail.com>
 <CAPx1GverCci3SZQEMvFX_q7r3XSTKmPizfcj8QcvGNud7reY9g@mail.gmail.com>
Subject: Re: [PATCH] revisions.txt: correct a mistake in dotted range
 notations section
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Chris Torek wrote:
> On Wed, Apr 26, 2023 at 1:00=E2=80=AFAM Pooyan Khanjankhani via GitGitG=
adget
> <gitgitgadget@gmail.com> wrote:
> > From: Pooyan Khanjankhani <p.khanjankhani@digikala.com>
> >
> > Insert a missing 'not' word in a negative sentence.
> >   ... but are [not] reachable from neither A or C.
> =

> There's a peculiarity of the English language here that means you
> should not use the word "not". The actual error is using "or" as
> the conjunction, instead of "nor": the construct should read
> "neither <alternative 1> nor <alternative 2>", and it means that
> both alternatives are rejected.

But it's not the same to say "not reachable from either A or C", and
"reachable from neither A nor C". In the latter if a commit is reachable
from X (or anything other than A or C), it should be included.

So A~ would be included, because it's reachable from B and reachable
from not A (i.e. B).

It should be "not reachable from either A or C".

Cheers.

-- =

Felipe Contreras=
