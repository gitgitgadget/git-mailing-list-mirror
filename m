Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7D981FE90
	for <e@80x24.org>; Tue, 25 Apr 2017 15:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1951115AbdDYPw4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 11:52:56 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:35024 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1950369AbdDYPwu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 11:52:50 -0400
Received: by mail-pf0-f180.google.com with SMTP id v14so25177533pfd.2
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 08:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ixbiQ17bOsGVoiKlQj3qR3qpP3K+Dy29s0+VfiN1rTo=;
        b=HiYyBsqMfugiCJ87Vdgoz/7jYNcttGavhWExfg5fmaadEmSKrmlhSEzAVBolw9FJv7
         /+/jJSPridSG/DbWjztMstwDF7TVq5cyiITIhoAnPzUZf2DWwVTLp8ZyQl4srDwyMID2
         dlr2bXTdPgcHMxzo0w9S/3liT0l5nPm6XCYiPAjw4ooIiVA2W1NcyUf1JodW4+B/HX/G
         qab16YMw+V5AEYrjQVAo4RZE3tJxQJHWo4FeGOhgJHuFOXirKmvHpNTahl0UAtwqkW9r
         P+u/z1YiHiFzGvVqB1aLP9DRf4eto01TGazUdCBGKLcKQYhvRvnnPjgDX4C2ku/bJ3nT
         W/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ixbiQ17bOsGVoiKlQj3qR3qpP3K+Dy29s0+VfiN1rTo=;
        b=hGXrWOihNLqcBWRJhphsk8QA8zz/kEblvD8bfOH3d4U9yAT57Ztti/1Bvy+YX8SHdB
         BLf89ZUkHj0G7KCSNEm8jDpVVGnrY4vysg9Z39rnRKLFDXdJQs5VOpKCilen8qTJr1OR
         8ujf27lvu6pozcmkZscJKlBu2eA3ly/MSKSVHNTd16X8HHarwKzvAwzB7D381eDFSMj5
         B42ynPba1ZOZ63unyHX4Ys07SXqB1JgNUnFAQe3Gjqz2V/+Y/JLZ3yOk9NWgMUpTTsIL
         iAHkZ+AvV6ieKLaqt2vUHC1kwLcQh8fsYWYzquFxsh+ZrbKsVhU9g4vph7Cl1iGZl+jY
         ZIdQ==
X-Gm-Message-State: AN3rC/6YPBBM3knikOxJqGJ6B+KiPHfD5mcp8I7m3npZiaNbHVWk6Aj4
        kB/QWFSGiI2spMyeqEwD/Nasf8GP5jAmPC4=
X-Received: by 10.98.24.195 with SMTP id 186mr29507382pfy.35.1493135568736;
 Tue, 25 Apr 2017 08:52:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.153.156 with HTTP; Tue, 25 Apr 2017 08:52:48 -0700 (PDT)
In-Reply-To: <20170425005746.tulvexabonlexah3@sigill.intra.peff.net>
References: <20170425005746.tulvexabonlexah3@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 25 Apr 2017 08:52:48 -0700
Message-ID: <CAGZ79kb9hsvrzc=RnhhyJf-tTnr9rTfV-TQWimYFGwU_Kuew9w@mail.gmail.com>
Subject: Re: [PATCH] submodule_init: die cleanly on submodules without url defined
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 24, 2017 at 5:57 PM, Jeff King <peff@peff.net> wrote:
> When we init a submodule, we try to die when it has no URL
> defined:
>
>   url = xstrdup(sub->url);
>   if (!url)
>           die(...);
>
> But that's clearly nonsense. xstrdup() will never return
> NULL, and if sub->url is NULL, we'll segfault.
>
> These two bits of code need to be flipped, so we check
> sub->url before looking at it.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---

Makes sense. At the time I assumed xstrdup had a _or_null
behavior (i.e. if NULL goes in, it is not duplicated, but rather
return NULL)

Thanks,
Stefan
