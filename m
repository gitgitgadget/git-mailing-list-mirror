Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CCF81F516
	for <e@80x24.org>; Tue, 26 Jun 2018 09:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933829AbeFZJb5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 05:31:57 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:39256 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932558AbeFZJbz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 05:31:55 -0400
Received: by mail-yb0-f194.google.com with SMTP id k127-v6so1230457ybk.6
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 02:31:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a0UscnsneoE1N6KNfPp8gbiP7b32GAOgFrtsY0zSXRw=;
        b=U5p1czFqj9hMD8HXmAJLdC330zX2e3OUX65hbfhXxpYxPz9bGlAqyT1wHz8t3o9yLR
         S8qy56PPnklYqlv3wAEg7r+e2ldDFpRykNwd3H/JZY601dbCmwDKoDWrOkjlvuMAzJE+
         1LBatVljFkUkk9hYlNb0YvUg81D7cNybvF/GfYxFeP8kCl+Rym5UTPwjeUfv5EKI3P+v
         0wn8D0Glt3uJAd0dMKM2yr4JJiD4iEVlGUBw9j60RlwUCkcOayUi70VlI4JMPHWQlZzn
         5GGydAaIXW5rr6/q9Sp1niaA2/KvxaOYweOD0jnRqOn2kioLcbTwJ9mae23D6/qfPC4G
         Si7Q==
X-Gm-Message-State: APt69E2xwa4ivcP0YF5QLeX+ZEjLCl70cle/rBYLsCHHEhg/23noRB00
        1Uuxh6jWJP3wzlrFvcOAYuggt6j3cAqXgHnsE/vX9A==
X-Google-Smtp-Source: ADUXVKKAoAiQhngA46EZzYOcv/v+Q+NrDdb9nwEgp7GsBYocKXkHEgt1nf/RxH4Ziim4DsbhTNCQgCZRz3iV3uUlBxk=
X-Received: by 2002:a25:ac5b:: with SMTP id r27-v6mr302813ybd.497.1530005514869;
 Tue, 26 Jun 2018 02:31:54 -0700 (PDT)
MIME-Version: 1.0
References: <20180626073001.6555-1-sunshine@sunshineco.com> <CABPp-BEz=mLHsg1NizJUKxOKM=dKFSAVec=x0mcs=4cJ73k_+Q@mail.gmail.com>
In-Reply-To: <CABPp-BEz=mLHsg1NizJUKxOKM=dKFSAVec=x0mcs=4cJ73k_+Q@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 26 Jun 2018 05:31:42 -0400
Message-ID: <CAPig+cRBN5-80HOvajG8WXqZUHmOX5SCrO93T9G4ePzgbGftZA@mail.gmail.com>
Subject: Re: [PATCH 00/29] t: detect and fix broken &&-chains in subshells
To:     Elijah Newren <newren@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 26, 2018 at 5:20 AM Elijah Newren <newren@gmail.com> wrote:
> On Tue, Jun 26, 2018 at 12:29 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> > Aside from identifying a rather significant number of &&-chain breaks,
> > repairing those broken chains uncovered genuine bugs in several tests
> > which were hidden by missing &&-chain links. Those bugs are also fixed
> > by this series. I would appreciate if the following people would
> > double-check my fixes:
> >
> > Stefan Bellar - 8/29 "t7400" and (especially) 13/29 "lib-submodule-update"
> > Jonathan Tan - 10/29 "t9001"
> > Elijah Newren - 6/29 "t6036"
>
> Commented on the patch in question; 6/29 looks good.
>
> I also looked over the rest of the series.  Apart from the ones you
> specifically called out as needing review by others besides me, and
> the final patch which makes me feel like a sed neophyte, all but one
> patch looked good to me.  I just have a small question for that
> remaining patch, which I posted there.

I guess you refer to your question[1] about whether test_must_fail()
is the correct choice over test_expect_code(). I just responded[2]
with a hopefully satisfactory answer.

[1]: https://public-inbox.org/git/CABPp-BFmfN6=E+3BAKt-NH5hmU-368shgDnrnkrnMRvKnx07BQ@mail.gmail.com/
[2]: https://public-inbox.org/git/CAPig+cRTG625H3CF1Zw30vQt2W8uKf1xLxVaQni2YbJ=xAif2g@mail.gmail.com/
