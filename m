Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA63C4332F
	for <git@archiver.kernel.org>; Fri, 18 Nov 2022 18:14:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235448AbiKRSOV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 13:14:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242588AbiKRSOQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 13:14:16 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5662487564
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 10:14:15 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id o13so2907675ilq.6
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 10:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Uy9kQAksuCWfFAg2L9yjFsZIfn7Nt39q+qy1GK10874=;
        b=lmbHZzETwQMso+W8goUL9LVtuCbfwFkcr8o0SXAT5NzH/wjoMoJSLv3MNuGIQGbSUh
         XEYjt4l0upOlsU93KGA2UYcnZ9GqKmvD1gJX+WlEkOZ+FSrCUnO67te0IOa7wHkHzhy7
         +DQR52ZdFGIzkWkWryK2RZHa+p/tVpH7wiaz7hdQYuG95WyXPFDxq+hk9YDBRr5JlMnt
         l3uGNec/D8YrjiROCYLIVbEXbpdsV7tqq+eVTcr7Q85Ncc5O2quhFIfQb1N930rnh0QV
         tDYB53awRjXL9ez4BcbI3EF6FuYIyEwNHX+ZzGvEMrQZuC1y6G2J4gSerzL5+V56tjQB
         yt2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uy9kQAksuCWfFAg2L9yjFsZIfn7Nt39q+qy1GK10874=;
        b=2+x08gH8BkeNfFGQdHor7u1POpVOxhfrDFVQ7rkDSn4keN+KKODILU8PdFFF6YKdfE
         +h61rRMO72ZzXPgkmO6uaam0Lo2NCLxpPA7LIw9U5xuWCSnT1EbKHxf2ObWFEAG2YyzR
         FPHKsC0FlAaqtRYSBJDygEYARLyY/MzyQ4722cJTX2Thl6JXbZOAMZZO9deTQKOaTo6I
         T+h7/+X2doISU9ZpqSignJ2M9ding9CJHIPtkg2cD1XIFQs8pyHPYh5mZHmoMCevNiwf
         bvOyMt+iCWQoB0fRpVO5ENjiMK/nFC5oJipITNLd80uVgR6QhNNKlskHfWbbXlb5lS+t
         2Ccw==
X-Gm-Message-State: ANoB5pkb13442mvez2D4omzEY6L0xAYByi7mo/WCe5paHLzgZULPnDnU
        QOj9AfGxxcsLmteE2yQOCX+bWw==
X-Google-Smtp-Source: AA0mqf7QqmXo8PN3uVTei/ZuPSYIBLNIwaBq/WIHxsFOQPxJFc52vlKCPnyDOyDaGH3elQ1p4Ko45g==
X-Received: by 2002:a92:d783:0:b0:300:cf25:37ec with SMTP id d3-20020a92d783000000b00300cf2537ecmr3632948iln.282.1668795254672;
        Fri, 18 Nov 2022 10:14:14 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w8-20020a023948000000b00375aa177cb8sm1454473jae.145.2022.11.18.10.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 10:14:13 -0800 (PST)
Date:   Fri, 18 Nov 2022 13:14:12 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v4 2/2] tests(mingw): avoid very slow `mingw_test_cmp`
Message-ID: <Y3fLdJ7CIIU8fj0g@nand.local>
References: <pull.1309.v3.git.1668290855.gitgitgadget@gmail.com>
 <pull.1309.v4.git.1668434812.gitgitgadget@gmail.com>
 <128b1f348d8fad730cac1c36d3082fab49904b2c.1668434812.git.gitgitgadget@gmail.com>
 <Y3LD1CtKBoDhPdSZ@nand.local>
 <qp0556o2-6q18-8556-0n8s-p28831qr6qs6@tzk.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <qp0556o2-6q18-8556-0n8s-p28831qr6qs6@tzk.qr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 18, 2022 at 02:32:28PM +0100, Johannes Schindelin wrote:
> > But I'm not sure the rewritten version does what you claim, at least in
> > my own personal opinion.
> >
> > It is not helpful to say the original approach "saw a lot of backlash".
>
> It is the nicest thing I can say about it.

I don't think you have to or should refer to the earlier round of review
at all.

> > It is helpful, on the other hand, to say what about the original
> > approach gave reviewers pause, and why that alternative approach isn't
> > pursued here.
> >
> > Maybe I'm splitting hairs here, but I really do stand by my original
> > suggestion from back in [1].
>
> We can also keep hitting a dead horse, but I don't think that will make
> anything any better.

Instead, it would be much more helpful to explain what you tried before,
and why you are taking a different approach now.

I am simply not comfortable with taking the patch with the way the body
is currently written.

Thanks,
Taylor
