Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D92FC43217
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 13:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239811AbiDENBC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Apr 2022 09:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382828AbiDEMRA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 08:17:00 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D8EBAB8B
        for <git@vger.kernel.org>; Tue,  5 Apr 2022 04:30:02 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id r10so8796817eda.1
        for <git@vger.kernel.org>; Tue, 05 Apr 2022 04:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+1kwBSq0BzSRJIUWpjZGfJCzegoKBf0Lk+BzBCbMwlQ=;
        b=ko5SHTGzGTaiFMtD5VM7F3L6LPiOkfGIAcMUA8/1t+0nBNaCTEq4sLrOAF/7MhI/76
         1rxUkzteWLfPnmQcwcN9RH/eb1UM+R1ng8VI+51BTKdghxgFeRjtTNQAJg/0/Kc1vMBd
         Dl8RQ2naSIdNsYAzB79DNZeNOfo9QqG13fCwRvr1okSjBTvlQ63oWnVrT3xTg963AN2B
         HZQheAmOHdQRVzKik+5H8kq8mXy8gbMtWB59axoocvQG5d9hsGPsYLAIYqlAE4metjJE
         kp/4FkUQlzyYZalk8dh3sqVMpVqmLJYWsUVtz7wqm/IYPxVItpc68cK6gHD5SFLay9Ll
         GJIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+1kwBSq0BzSRJIUWpjZGfJCzegoKBf0Lk+BzBCbMwlQ=;
        b=sFI+7OS9/0Zu1YcNjxn27UXNdNZZJZaEHp8pHXcNKb8zXg97ur6RK95/We3B6s5mwj
         IdIBE5EBdQ8haaOwziI4NV1L2Bmq4ZjnsTnJSMotvSysn2BfhpysTNLTKZyd3D/ZgOTH
         3/JgxtX5+tFHSUa0sl2IH8o3asGwa71XxM2+KwnYRPIja9bGq49fZJgaCpf26wTnH7Rc
         q4ExuO7NS65yQ5Olj6G23ZvMMV6PlIDRs428zfQ1medEn6EluWs8XsyXq4QRGMyD30D+
         UkpPj8GtF2WGcBI/H7bgfKhVI147Ufo2LeRDmyv9CN1GAfW37wID/5daOEsIVClqDlyu
         U1Ag==
X-Gm-Message-State: AOAM531OyGrOJAyMpPSlG/4sZ15jwg7sI5vCQOzYmrIG3w3BwCqLgwWb
        dS5q/h+wQfTs6ZZN4UWWLmXAbrz+kplgTLUDgdK1BA==
X-Google-Smtp-Source: ABdhPJx0IHWf2I9hE++el06F8Rub21f6kGiUN/Ecawtkpv8ZIu4Ug4iYf2jIQPxopkYqP2KJNNkecNKK4fx8KZQz3bo=
X-Received: by 2002:aa7:d148:0:b0:41c:df0f:194a with SMTP id
 r8-20020aa7d148000000b0041cdf0f194amr3137545edo.42.1649158200627; Tue, 05 Apr
 2022 04:30:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220210164627.279520-1-jholdsworth@nvidia.com>
 <CAPMMpohZxpMFc-rVE96QbeGzN6NdF5CdYVp6FLrHD6Ngi=mu4A@mail.gmail.com>
 <BL0PR12MB484938E9950EBCA08315544CC8E59@BL0PR12MB4849.namprd12.prod.outlook.com>
 <CAPMMpoggSvPox5tM3B_NZ0GwLzg7LtHkXGhby1mZqpkehZ1G0Q@mail.gmail.com>
In-Reply-To: <CAPMMpoggSvPox5tM3B_NZ0GwLzg7LtHkXGhby1mZqpkehZ1G0Q@mail.gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Tue, 5 Apr 2022 13:29:49 +0200
Message-ID: <CAPMMpohm74nVbi-dR=YOLoT+CbPiHGuVo35EoufKGKHP9Urexg@mail.gmail.com>
Subject: Re: [PATCH v4 00/22] git-p4: Various code tidy-ups
To:     Joel Holdsworth <jholdsworth@nvidia.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Luke Diamand <luke@diamand.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 5, 2022 at 6:27 AM Tao Klerks <tao@klerks.biz> wrote:
>
> On Mon, Apr 4, 2022 at 4:46 PM Joel Holdsworth <jholdsworth@nvidia.com> wrote:
> >
> >
> > Can you give me a bit more information about this, because I was going to try and push for the git-p4 to discard Python 2 support later this year in a bid to simplify the code, reduce the testing burden, and move toward cleaner pylint output.
> >
>
> I'll try to look into this and see whether git-p4 itself can be made
> to be more forgiving under python3, or whether there is an even better
> solution where inconsistently-encoded Perforce metadata can somehow be
> harmonized. Either way, I'll try to contribute some
> test_expect_failure tests.

So, an initial test suggests that a recent version of git-p4 at least
doesn't fail in the same way under python3, in the face of at least
some of these encoding issues. I don't know yet whether failures will
occur in other places, nor whether the not-failing behavior is better,
worse or the same as I had under python2, but it seems plausible that
I won't be filing any test_expect_failure tests after all, and will
instead say "yay, python3 ftw!"
