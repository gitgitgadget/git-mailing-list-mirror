Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 597C71F954
	for <e@80x24.org>; Sun, 19 Aug 2018 22:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbeHTBXu (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Aug 2018 21:23:50 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:43636 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbeHTBXu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Aug 2018 21:23:50 -0400
Received: by mail-qk0-f193.google.com with SMTP id 130-v6so767068qkd.10
        for <git@vger.kernel.org>; Sun, 19 Aug 2018 15:10:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=guTY385Ow+xU02ueE8I8eKRJVQ9YMyvKjQq1PikdcP0=;
        b=Q1I1Jh/zsaYuMd16aTAZwyb6TJ4TFIi0k8GX4eA1BPrOdhUscef1m5JKPD8uQfj5RW
         NLVas6PGGLs9pGlXEPp8d8Y+T/ppCHScPd2ut2pAvozPHGn5kIdUu/lFX5qioFTZEHNh
         /jr2/5G2UI6Uxy6pODMXef7b6kmXH7VOAlhZHAD0swJlVzIq9bAVYIbcrt1E6URQEyMO
         pgWjFK1TnziZNGG1cwllE6kzf8dzOOvp7c6sakam4vMkRE2D0lBHoguY/uBqN492kTXY
         pEIUiUGaqgfImdKatqtoILDBmri+TknmTquc5x4R8fcF1YbSc99CUNiK1kg/CPvlNSL0
         LucA==
X-Gm-Message-State: AOUpUlGk/B+2mvh5G7wRi7Wqup0pLFvWSXqgYdt0etUiY/IUDHdKeCL2
        z4/d4pHONfi+IO4AGCSATRgpcb9ItEKpPfBBzA8=
X-Google-Smtp-Source: AA+uWPw8aixV4bn6dQLeSKaEvN5IhmjEgCIDXM2EqZMob+NBOhF3uZQ4RrZ7B8WAKgRIJSwvIZvCOGqCIuaB0jYcUzA=
X-Received: by 2002:a37:4951:: with SMTP id w78-v6mr39393289qka.2.1534716649999;
 Sun, 19 Aug 2018 15:10:49 -0700 (PDT)
MIME-Version: 1.0
References: <20180819175351.449973-1-sandals@crustytoothpaste.net>
 <20180819175351.449973-6-sandals@crustytoothpaste.net> <CAPig+cS6Z+U-Z26m-eW-JX5D29ONSb_Zzur2fvWGb_ZMbmF4UQ@mail.gmail.com>
 <20180819215732.GJ70480@genre.crustytoothpaste.net>
In-Reply-To: <20180819215732.GJ70480@genre.crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 19 Aug 2018 18:10:38 -0400
Message-ID: <CAPig+cTTmOw-d7umES9p2xv4uCkjTnNtjTni_DaVFKbhc8WTgA@mail.gmail.com>
Subject: Re: [PATCH v2 05/11] t0027: make hash size independent'
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 19, 2018 at 5:57 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Sun, Aug 19, 2018 at 04:10:21PM -0400, Eric Sunshine wrote:
> > On Sun, Aug 19, 2018 at 1:54 PM brian m. carlson
> > > -       tr '\015\000abcdef0123456789' QN00000000000000000 <"$2" >"$exp" &&
> > > +       tr '\015\000abcdef0123456789' QN00000000000000000 <"$2" >"$exp+" &&
> >
> > My immediate thought upon reading this was whether "+" is valid in
> > Windows filenames. Apparently, it is, but perhaps (if you re-roll) it
> > would make sense to use a character less likely to cause brain
> > hiccups; for instance, "exp0'.
>
> The reason I picked that is that we use it quite a bit in the Makefile,
> so it seemed like an obvious choice for a temporary file name.  If you
> feel strongly I can pick something else, but I thought it would be
> reasonably intuitive for other developers.  Maybe I was wrong, though.

I don't feel strongly about it. My brain tripped over it probably
because it's not an idiom in Git tests. In fact, I see just one place
where "+" has been used like this, in t6026.
