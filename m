Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67AEBC352A1
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 02:29:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiLGC3V (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 21:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiLGC3U (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 21:29:20 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E88101CD
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 18:29:19 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id x11so6482319ilo.13
        for <git@vger.kernel.org>; Tue, 06 Dec 2022 18:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0+X2Utzix2EtkUaum6Ns1uT40J2MZPFreBjWdQWpgzA=;
        b=lLC2+SQvA1v1aOc5N1raeJwBvNwTJTI8CuH0HGRKooOg/p75k8798ALUZIYWu0hT0h
         r9CGX0tE6K47kPYiWY8+0r8cNKxeZEKsKToSBc0c1M/gBoPcYZFZskFWpJ+sQ1zayvbA
         10DVdvrNg4ibSqYnxkqiR8g/+UkaQBPCbYkZbKkO8Z+J1p/iVvhpoSSg5AhIefOcC6ZA
         TNf+HHJF+acqNLgbcd4lVA7jIYeQ3SpzCSji6JW48p4sc7t6LCgmwcJMxj50Rkuyzznw
         H/Z6CMxYAok1Updlx2GcE8TXIHsiVaUSGQ+IRXTqmhqRvm+Dzl8t8fSgsxF+uTbdRZXM
         Ul6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0+X2Utzix2EtkUaum6Ns1uT40J2MZPFreBjWdQWpgzA=;
        b=oF5oTc2tmWy4ySXnnqdD7d/4Fa0lzwGu4OWDXQ33t+P4NvpGmxIsI7yJqlVknwuv8V
         F1r2fzk03S3fbaBWYtclsNmJ9mSkEM1cjeIsYRIHB661Ma5AMOTpxUOdVY/b5xG2BkqU
         4gkd24UVihfMiFuyZidQuEBqQ+ptTvTcdWqo2gba8xPsEXlQ+nZseYnoLDW/v6QcEhun
         PA0YA4Te4LFe6S6l8kTDQoccnD3BsgAF2mx2B34x1G87p2AN9HDMSyxi2GEvkX4TjLgr
         ikGNUngCL2DCbu7vbQqBBmnIrt0Krg0EROF9Wbj/ypFQvCHIIveNJI+2CvzeAuX5E+lK
         Qbdw==
X-Gm-Message-State: ANoB5pliTMvESR5uyY1w8dnNEKI6yCEVthWvQh9s2LO4h+/ka83rdh2n
        j0XG/LAAnSUmfG2q+PNafjKZqA==
X-Google-Smtp-Source: AA0mqf4+zqUA/tG+L0gX+dDAPZRdl8SufH4mTXx9DFzBKwwG2wtZvSKRnI0KH4AE1B65YU431y3x/g==
X-Received: by 2002:a92:c5c5:0:b0:303:1215:ea9d with SMTP id s5-20020a92c5c5000000b003031215ea9dmr20341108ilt.242.1670380159187;
        Tue, 06 Dec 2022 18:29:19 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f27-20020a056602071b00b006e25b512bdesm130171iox.33.2022.12.06.18.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 18:29:18 -0800 (PST)
Date:   Tue, 6 Dec 2022 21:29:12 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-compat-util.h: introduce CALLOC(x)
Message-ID: <Y4/6eDxUeSLYss/a@nand.local>
References: <6694c52b38674859eb0390c7f62da1209a8d8ec3.1670266373.git.me@ttaylorr.com>
 <a8e33b1e-1056-5f75-55b5-65c0bceef3ca@web.de>
 <Y45yaYV3xFB/xR2G@nand.local>
 <Y46eVnYrcOGAbUhi@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y46eVnYrcOGAbUhi@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 05, 2022 at 08:43:50PM -0500, Jeff King wrote:
> On Mon, Dec 05, 2022 at 05:36:25PM -0500, Taylor Blau wrote:
>
> > On Mon, Dec 05, 2022 at 10:01:11PM +0100, René Scharfe wrote:
> > > This rule would turn this code:
> > >
> > > 	struct foo *bar = xcalloc(1, sizeof(*bar));
> > > 	int i;
> > >
> > > ... into:
> > >
> > > 	struct foo *bar;
> > > 	CALLOC(bar);
> > > 	int i;
> > >
> > > ... which violates the coding guideline to not mix declarations and
> > > statements (-Wdeclaration-after-statement).
> >
> > Yeah, I was wondering about this myself when I wrote this part of the
> > Coccinelle patch.
> >
> > Is there an intelligent way to tell it to put the first statement after
> > all declarations? I couldn't find anything after a quick scan of the
> > documentation nor our own patches.
>
> It feels like generating the code as above is not the end of the world.
> The most valuable thing that coccinelle is doing here is _finding_ the
> location, and telling you "it's supposed to be like this". It is great
> when the "this" post-image is perfect and doesn't need further tweaking.

I have to agree. If Coccinelle can generate the right output; great. But
if it can't, the amount of additional work to reorganize an already
generated and mostly correct *.patch from the tool seems minimal by
comparison.

> But if the compiler then reminds you "hey, you need to go a bit further
> manually", that doesn't seem so bad. In other words, I would be happy to
> follow that work flow if I introduced a bare xcalloc(). My only worry is
> that somebody less experienced with the project (or with C) would get
> confused.

Agreed.

Thanks,
Taylor
