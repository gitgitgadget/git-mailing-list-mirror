Return-Path: <SRS0=ybwr=BB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19367C433E0
	for <git@archiver.kernel.org>; Wed, 22 Jul 2020 20:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E46B920771
	for <git@archiver.kernel.org>; Wed, 22 Jul 2020 20:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="ctpdztZG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgGVUPg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jul 2020 16:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbgGVUPf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jul 2020 16:15:35 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58780C0619E1
        for <git@vger.kernel.org>; Wed, 22 Jul 2020 13:15:35 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id di5so1597633qvb.11
        for <git@vger.kernel.org>; Wed, 22 Jul 2020 13:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=pwNw+mNXmFrO3Y+dysNtGRAcvPUO9TE4FZbyaOx7LxQ=;
        b=ctpdztZG5xqo8suO03aulreeqSAejj+P6ZCH3igjrL4HyK0EFN/N5vdHIeuYDKv2+s
         WcRzNYFU5AsK46HAE15VxP0UBUUtG730LUblaVjyY4z0gZ196K2JucG3bO3qqlzBfnmC
         t38xkkxPJ8SYgiiO+Y/c6Yn2sxOdjjXXyeckpFJjogohBhwYErh2qxvrCVVJnW9AhkeX
         emnE5lfrZwm0Sw+9bSQAHkeWqpYHkLd48eJmcFlA7Cz42Kz9bO1QxjxzmfeuVRZRQyZU
         21HrziQjTspT3d2YGL54+ZbuMb9QyzixEwEF8loAluVYyT5adk9YgAebIKhiSaKFnsV0
         OW5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pwNw+mNXmFrO3Y+dysNtGRAcvPUO9TE4FZbyaOx7LxQ=;
        b=CNxkelqLLjiWRiCHTO093dkvVp42xBGj8BWDAQquN6Co0DGR2seffnMQCA9rDquoBM
         TBIHG+TqCp30SlrPy/+xfThreaeVcQDLvvooRcSVXnEDZ/wxy5joGLITf0hfmQsicGe2
         DZ5GnTqfOCtv8KqD7JKAwbbTEJPbSkPykD0sllUArq0bn/TMAKS6bAK45coddHpIcZC8
         vx2QYHRgPtmP4jC7OF/Mw13gymDHgmlZcxNaZK8UFu4XXFfFbLkaHUk6JEg9YDTTjdqg
         ejC7Yj9ShDpsCbqkZ2kC6kd7dhG2e2sxAOBtWfMpfRRgmDwfdX0RhoAF+hSei68aR/89
         SD3g==
X-Gm-Message-State: AOAM533gp8LSpbilE6oPaEBeNjXPGh/RQfh3yrskpE7t8e1Krie448dN
        oZesNlJSUfbDaT2RaB4GYNcpOQ==
X-Google-Smtp-Source: ABdhPJzIXpxZLcjpL5o2utEXDg+nHkt8+HqAziZDh+y4ZfyvrpumJxpjK9cKotCiSFY4sRx+zyuUJA==
X-Received: by 2002:a0c:a4e2:: with SMTP id x89mr477002qvx.240.1595448934379;
        Wed, 22 Jul 2020 13:15:34 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:351c:83f3:acec:de38])
        by smtp.gmail.com with ESMTPSA id d14sm570131qti.41.2020.07.22.13.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 13:15:33 -0700 (PDT)
Date:   Wed, 22 Jul 2020 16:15:31 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, chriscool@tuxfamily.org
Subject: Re: [PATCH 2/4] upload-pack.c: allow banning certain object filter(s)
Message-ID: <20200722201531.GA59352@syl.lan>
References: <cover.1593720075.git.me@ttaylorr.com>
 <f0982d24e74155f6c0e405e5e3ae8c3e579f798a.1593720075.git.me@ttaylorr.com>
 <20200715100043.GG11341@szeder.dev>
 <20200715105521.GB3262157@coredump.intra.peff.net>
 <20200720200739.GB91942@syl.lan>
 <20200722091758.GJ11341@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200722091758.GJ11341@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 22, 2020 at 11:17:58AM +0200, SZEDER Gábor wrote:
> On Mon, Jul 20, 2020 at 04:07:39PM -0400, Taylor Blau wrote:
> > What I'd rather do is something like:
> >
> >   - Introduce this patch series with the 'test_must_fail ok=sigpipe',
> >     and no error checking.
>
> die_if_using_banned_filter() shows two error messages: a "fancy" one
> is sent to the client in the ERR packet, including which particular
> filter is not supported/allowed, and a simple
>
>   die(_("git upload-pack: banned object filter requested"));
>
> If this die() were to show the same fancy error message as in the ERR
> packet, then it would always make it to 'git clone's stderr in the
> tests, so the tests could reliably check that 'git upload-pack' died
> for the expected reason.

Beautiful idea. I changed this in my fork, and I'll send it to this
thread after 2.28 is out, since I don't want to create a distraction in
the meantime.

> >   - Modify clone to swallow these errors and eat a packet or two.
> >
> >   - Then, drop the 'ok=sigpipe' from t5616 after 'git clone' is a little
> >     bit smarter here.
> >
> > Maybe more steps than is strictly necessary, but I think it keeps the
> > scope of the review on this series reasonable, which is a tradeoff that
> > I'm willing to make.
> >
> > > Probably git-clone should ignore SIGPIPE during the network transfer
> > > portion of the process for the same reasons given in 143588949c (fetch:
> > > ignore SIGPIPE during network operation, 2019-03-03).
> > >
> > > -Peff
> >
> > Thanks,
> > Taylor

Thanks,
Taylor
