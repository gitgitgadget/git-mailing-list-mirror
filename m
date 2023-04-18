Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D879C77B75
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 19:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbjDRTwy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 15:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232655AbjDRTww (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 15:52:52 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E709CB451
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 12:52:49 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-54fbee98814so224315907b3.8
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 12:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1681847569; x=1684439569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WhY7UWthj1+ImeE+b8iBmJDxXSmv02PFy4quAspALN8=;
        b=J5Gk/dVJ7+RpwsSJr2WbWkqGmkTwc8whaG2XobYf+p34j7KZb6K/6nksm684RXRksD
         V6AVpNuREg1m6euj0WPow9HhKFxeYg9zIZddLfK8QfDczg5IZ75RkdhsM6F6Fl9h++wx
         6uHO6qp6Ipmga4f+WsAlvvLdtIDO6BX25rFU72M2oiNkD2oGwg9MNu1OyCw6I54YRo2P
         78f5r8SHInStfFL4r1abEJM78lj2wAHJqIMtmpSIFL9tJB0rQWT1BN8K7PVt9pA/yqh1
         k4QmRSgW+ZPVwP3ZEkW3vltJKznTP92XRnBuWMDKNRVGKcoLCnKLfNygJdZbveZxato4
         98NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681847569; x=1684439569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WhY7UWthj1+ImeE+b8iBmJDxXSmv02PFy4quAspALN8=;
        b=RLlQ/Tj2NAKcJWmgGykQW+SvGRfrxSmLUXKEaRzjPkoy8jcULbe0Nt0vfMGRDSNP+h
         dbg788ATO4QHQexB3d2bWKEXCqdVblV3oKDYQ68yyHnHZ0vYSfnp7JI2lqY2OkjoJNYy
         Hg6KHs635cCNwu4sXq+KQmb/5NMVrs4WYvVCxvXp3SZiy9A+8GxtVeyKlfXsXJADurDZ
         r6tc+g2Z9fU755baD8NAT6tAAesKgMC5AJlZo0sM954QxrImz2cIZFVmWiSKy1QSwLpG
         uSIvnfIv5cfo3pmVBMGBSqo7YNR1OCwkDfI9++4x9HzZut9Dxf8OVpZUuF1NFGw9MGQ0
         TEiA==
X-Gm-Message-State: AAQBX9cvkjSbUKDFDvYE2HnmTfMKrdPpH2HEiCB+qhxL9G/wEPqn09Xq
        d9Zj0lCUe5ZLVbo4NXMcEZGcCw==
X-Google-Smtp-Source: AKy350a4kxfaldP0aVqcFHWNel7o2QpdT9/9n7qAPaKlS9WlPlp6m9t8lwDLbiPiQhbutVncJ9cCzA==
X-Received: by 2002:a81:4ec3:0:b0:54f:a5f6:c0db with SMTP id c186-20020a814ec3000000b0054fa5f6c0dbmr1041122ywb.13.1681847569060;
        Tue, 18 Apr 2023 12:52:49 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id cs2-20020a05690c0ec200b00545a08184a7sm4063195ywb.55.2023.04.18.12.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 12:52:48 -0700 (PDT)
Date:   Tue, 18 Apr 2023 15:52:47 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/10] builtin/gc.c: make `gc.cruftPacks` enabled by
 default
Message-ID: <ZD71Dxa+m7/p546d@nand.local>
References: <cover.1681764848.git.me@ttaylorr.com>
 <bfda40a21ddb7abceb6a7eb9aa1f71aa5d856333.1681764848.git.me@ttaylorr.com>
 <20230418110049.GB516715@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230418110049.GB516715@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 18, 2023 at 07:00:49AM -0400, Jeff King wrote:
> On Mon, Apr 17, 2023 at 04:54:39PM -0400, Taylor Blau wrote:
>
> >  for argv in \
> > +	"gc" \
> >  	"gc --cruft" \
> >  	"-c gc.cruftPacks=true gc" \
> > -	"-c gc.cruftPacks=false gc --cruft" \
> > -	"-c feature.experimental=true gc" \
> > -	"-c gc.cruftPacks=true -c feature.experimental=false gc"
> > +	"-c gc.cruftPacks=false gc --cruft"
> >  do
>
> Oh good. I was a little sad to see the increase in the size of this loop
> in the earlier patches, so now reducing the number of combinations is a
> welcome change.

Sorry for the roller-coaster of emotions ;-).

> The set you have here looks fine, though isn't "gc --cruft" redundant
> with "gc" now?

Yeah, these are redundant. I figured that it might be good to test all
cases, but I think this matrix-style of testing only gets you so far,
and can often come out wasteful.

"gc --cruft" isn't testing anything meaningful, so let's drop it.

> > @@ -246,9 +245,7 @@ done
> >  for argv in \
> >  	"gc --no-cruft" \
> >  	"-c gc.cruftPacks=false gc" \
> > -	"-c gc.cruftPacks=true gc --no-cruft" \
> > -	"-c feature.expiremental=true -c gc.cruftPacks=false gc" \
> > -	"-c feature.experimental=false gc"
> > +	"-c gc.cruftPacks=true gc --no-cruft"
>
> Likewise here, "gc --no-cruft" would have been redundant with "gc"
> before this patch, but we did not even bother with it (so no need to
> remove it here!).

Yeah, this one we definitely want to keep. We probably *could* have
dropped it in the previous patch and brought it back here, but I think
that doing so would have been unnecessary churn for reviewers reading
this series.

> The rest of the patch looks good, and I am quite on board with the
> overall goal. It's been a long time coming. :)

Thanks, I agree ;-).

Thanks,
Taylor
