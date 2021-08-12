Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181D8C4338F
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 21:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8D806103A
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 21:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236301AbhHLVXQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Aug 2021 17:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbhHLVXN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Aug 2021 17:23:13 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BEBC061756
        for <git@vger.kernel.org>; Thu, 12 Aug 2021 14:22:47 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id q16so8020770ioj.0
        for <git@vger.kernel.org>; Thu, 12 Aug 2021 14:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vUYEe53SYbuB3SBZxcXN9A93+4HaFCe1o3M5TzuCl4g=;
        b=hR3QD1d/L6B9RFM12mJF68uxqN0Rkcs8ZUAixHVK3VZZvyMMNZTqat0GlfYsgIzuoA
         XdXZ6NdA4EgM+mwf+ytANMr6F7Txvxukh24Zf8U0rhn0Jz0gspxMboXG9rgx6D6ZNacq
         FDyqYHt0jbF+SxWSESKyv4Ow+rbjT20lF72aVWmwzWvzQ5NemJSZYemYDXmP1xjRcfRu
         oMotnDB/ZCTJOgHSKcXQXclWM98Eb/OjG59PrnnQGtHTrvqXtWZ25/GQTGtxQOmoZas8
         gkkwDMhSYIeBxfv3IqOkafSDIHX4ARcCri0bAdrY0n98XCfE6oKtYpvOZPs8q9Z5Gg+e
         EmjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vUYEe53SYbuB3SBZxcXN9A93+4HaFCe1o3M5TzuCl4g=;
        b=APcuvZoLtUu+AuIUlfFIHwhAcEwTMysUY0D9quwy1o+nkCo3KBI9471Mw9XvgfTYUX
         DlpmNudHnEqx3z3lbc2oMWKWThkPV29hF31TAtae+LW9G56pDcVwayBPE75tQO9x+IGq
         IXwmJJ/0Xm5Wd9ndw7pzpWOAtzvyttlRvcKAf7FulpdaxEd+UB3joPANY33msXXqkn0a
         0+Fb1Apg72T/i2DdIpgY/zsfR1TiWXqCy/5707gJFdVEih9FkKzI8BYQA9o6ihsKQ8Ku
         dHy2aGQ8+ohkVfPNIYbkUWlTHJ393Bu863clzANQXETT2sXqkU884qz6tpStURUqYcm4
         /gvQ==
X-Gm-Message-State: AOAM532X8nBLyh9OG6KDIsNA0uXyCcAiwPOO2XwvF4gnnBVfV+XBz1Bs
        ZtM6TX77uuRCq6vEGM2HDmxdig==
X-Google-Smtp-Source: ABdhPJwExtB8RSR+TLAXfm8S+CIzmzaWSy+LrDSBt154g+FnZHjGLmf9A4GT9LgXxs3kmPPhsLSgog==
X-Received: by 2002:a5d:9b99:: with SMTP id r25mr4567421iom.104.1628803367329;
        Thu, 12 Aug 2021 14:22:47 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g2sm777555ioq.42.2021.08.12.14.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 14:22:46 -0700 (PDT)
Date:   Thu, 12 Aug 2021 17:20:36 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, gitster@pobox.com, jonathantanmy@google.com
Subject: Re: [PATCH v3 09/25] midx: avoid opening multiple MIDXs when writing
Message-ID: <YRWQpMXzF1Q8RmVu@nand.local>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1627420428.git.me@ttaylorr.com>
 <40cff5beb50cdfbd13ae7f6017152f2628b25814.1627420428.git.me@ttaylorr.com>
 <YRWBZJDCVyUOhk2F@coredump.intra.peff.net>
 <YRWDBdpizLH/gX1a@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YRWDBdpizLH/gX1a@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 12, 2021 at 04:22:29PM -0400, Jeff King wrote:
> On Thu, Aug 12, 2021 at 04:15:32PM -0400, Jeff King wrote:
>
> > I think we'd need something like this:
> >
> > diff --git a/midx.c b/midx.c
> > index 6dfafe7a8c..bfb6afea2e 100644
> > --- a/midx.c
> > +++ b/midx.c
> > @@ -1123,8 +1123,7 @@ static int write_midx_internal(const char *object_dir,
> >  	hold_lock_file_for_update(&lk, midx_name, LOCK_DIE_ON_ERROR);
> >  	f = hashfd(get_lock_file_fd(&lk), get_lock_file_path(&lk));
> >
> > -	if (ctx.m)
> > -		close_midx(ctx.m);
> > +	close_object_store(the_repository->objects);
> >
> >  	if (ctx.nr - dropped_packs == 0) {
> >  		error(_("no pack files to index."));
> >
> > though I'm not sure:
> >
> >  - if this should be unconditional or dependent on ctx.m (I think the
> >    latter, because if we are renaming over any open midx, we would have
> >    filled in ctx.m earlier).
> >
> >  - if this should go below the "no pack files to index" check (i.e., is
> >    there any point in closing if we know we will not write?). In fact,
> >    its purpose might be more obvious right before finalize_hashfile(),
> >    but I am OK either way on that.
>
> Ah, this close_midx() actually gets moved and made unconditional later
> in the series.  But it still needs to be close_object_store() instead.

Exactly; this first patch should read:

    if (ctx.m)
      close_object_store(the_repository->objects);

and then the latter patch (15/25) we drop the conditional and move our
call down until after the MIDX bitmap is written, but before we call
commit_lock_file().

Thanks,
Taylor
