Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA61C433EF
	for <git@archiver.kernel.org>; Fri, 15 Apr 2022 13:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354002AbiDONb7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 09:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354000AbiDONb5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 09:31:57 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962512ED
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 06:29:28 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id u18so9944356eda.3
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 06:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=1IBjJlFzEvoD9U8GTrLW+1+QzCG3ds2rSt8lzf2qa50=;
        b=DJ4X2ORwIJK1Ya05qAFsf9p2Jx0nAlcsheAVtHlpr0udpF34C72HleHx9jZbHIj28K
         xFes2uaOm0+56nnzwY4Jyx9D6rgAeU6hR1XlA5aZc1AsJdfM4fSmlX85X2s9bzWd/dXL
         iPTvkk6RVJ2+woKQD8wHB2lM3Us/j9fSIiyTNVP4WKUfMylzR6Pw5vYzY8Irw65bq0Y4
         A1nvWPgVarvmRIz/kRAH1Z1GLTTbut8W/bj+ffrC2Etapqr7QCjPxifqtx+OLxHGqRot
         TJ1i22TKdq+z+jReVIb6cpej31pOxse5sIRSKHopn75hpEPpRnkAEZrLpPccrVFBdtLG
         86tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=1IBjJlFzEvoD9U8GTrLW+1+QzCG3ds2rSt8lzf2qa50=;
        b=VllG2PExHfALbZA3AWfCS1Qx1j33NE+7qkJd/ppB9XxGE3cPj/Qe2AE/tat/y6kYct
         j6jRw8ZfBIKmTwF2SAkHpyPtv3qA8WAWhZPtXsqQbcQRByvv+CHRBhUbQ0EZ8vFS70o0
         3h9rFOO7CPsd5l4YdcNRhDnW4MJPIQHgqaMzBtaQ7eK4kQeMrxbSnWm43izisomT8W+3
         ALH9O7xMz9msUbVA74ATrn4ba68chB/cl4VVSbIbecLbRDZqHSRNuniGgXsyrn82zNgr
         vWi+Imx8DbVhUcgOCIywGnBNBXUHrkfMhdc4Dm/T2UvB48xHgaWvoM0PTHCasGWsR0HA
         +RGw==
X-Gm-Message-State: AOAM532hdHLP0pW61rpZVBExdw8z+gqcYGvK4/7u2QVp5V8KH7Lv7Qn1
        vlliu+C9/eFF7Zz64g7Q9V4=
X-Google-Smtp-Source: ABdhPJzymKzYhiB0ORQ3Xnp1t3dz/W2N7FvJgX3qsNlbpZzcqKxxcYz+J6SrWMXFuHTg2n7zVOy9hg==
X-Received: by 2002:a05:6402:914:b0:41d:8d96:57e1 with SMTP id g20-20020a056402091400b0041d8d9657e1mr8219756edz.3.1650029367142;
        Fri, 15 Apr 2022 06:29:27 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id v6-20020a17090690c600b006e8a4cdb77dsm1677680ejw.225.2022.04.15.06.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 06:29:26 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nfM0r-005eqA-Tv;
        Fri, 15 Apr 2022 15:29:25 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Users <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>
Subject: Re: reference-transaction regression in 2.36.0-rc1
Date:   Fri, 15 Apr 2022 15:27:26 +0200
References: <CAGyf7-GYYA2DOnAVYW--=QEc2WjSHzUhp2OQyuyOr3EOtFDm6g@mail.gmail.com>
 <CAGyf7-GaoBarXD2xKG3KUXwGZgbhKgv-4Mz45achbr6G9ihTBQ@mail.gmail.com>
 <220413.86r161f3qp.gmgdl@evledraar.gmail.com> <xmqq4k2w92xo.fsf@gitster.g>
 <CAGyf7-EU4aBO5JGfDAK+rkrjMwmDjZdCBeXBh_=z0Cqv=KnCkg@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <CAGyf7-EU4aBO5JGfDAK+rkrjMwmDjZdCBeXBh_=z0Cqv=KnCkg@mail.gmail.com>
Message-ID: <220415.86sfqebhl6.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 14 2022, Bryan Turner wrote:

> I'm happy to try and format this into a proper patch, with sign-offs
> and new tests, if folks think this is the way to go. If the 2.36
> release cycle is too far along, I can still try and get a patch to the
> list for inclusion in 2.37 (though I'm less confident what commit I'd
> base the patch on in that scenario). Any pointers would be
> appreciated. (Or, if someone with more familiarity than me, not to
> mention a patch submission setup that already works, wants to take
> over, that's fine too.)

I think that would be great if you can spend the time, but Junio's
already pushed out a revert of the topic for the final 2.36.0, can you
confirm that current "master" solves the issues you had?

So revert/retry & extra tests etc. can wait until the post-release, and
likely Patrick will be back to work on it at that time...
