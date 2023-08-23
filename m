Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A25C3DA66
	for <git@archiver.kernel.org>; Wed, 23 Aug 2023 18:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238188AbjHWShP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Aug 2023 14:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232847AbjHWShO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2023 14:37:14 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B669FD
        for <git@vger.kernel.org>; Wed, 23 Aug 2023 11:37:12 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5922b96c5fcso32664697b3.0
        for <git@vger.kernel.org>; Wed, 23 Aug 2023 11:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1692815831; x=1693420631;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eSkAXuZKIckMG+3KfVPIlbKljuAVyVFpXfU9rDeV+OQ=;
        b=iSBcepCvuD3ej69Wse8U4oXO39veJjBeVdBPal0oHC7Zo4kJBqtwsiqFH5aTuRAf5o
         JwX5/8Z31oXs2ahniRaYi2O2DfiM7c4FoRKpAx5VEPQkzHjCyeU2xMCmOjejJLRhEeIy
         fyWVU/viR/jx8z3qVWdZXS26/sR+Y0K1QjB3XXcz9uIHm0IKmrSgzUjK3VXDU1Sk8ZlT
         EW2qqCQQAIGWNVOEocS9gzfxgMPW3TZQtP9w0BYGtSb4kFsEeUVwhwnjbCtmTEubyKut
         ARNhbUlH99NzaRmdw0kJNo2P4Vn6f0n6jBRjSWAYPfj249vLdZbAS9C+P0YtSOhxEE/C
         0pDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692815831; x=1693420631;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eSkAXuZKIckMG+3KfVPIlbKljuAVyVFpXfU9rDeV+OQ=;
        b=c/SmO1on6jWs6/Nv8uzhLfupvRS9O37ssxw9eZXq8jqFVK9YmAmwrijIRLwz0WL8D4
         AB8Vua3RhXkmUumkAcoPLAHS97CkmNuxFlhIx7dEXfnwrp42wNJdJKiy6xvz8BJ1BxdN
         3aPvUuN11Bsy1alPMK+GI+4eY9ht/C9IF/rxSa0sbcx0HdFw1T0IEq2oRpO29gAv7rdw
         opP4DMSD/BRtpWM8S6l94q8nzs2/5tttqNlWM+1F/0isS7oW+OcVQ+nXBaFZaxm88aat
         pwwVA84xxZxN44LEDCAaS7DzwUIXkb7Tt/8T9MfnwCH2iqb3RUwcU5QBF3fW4Sm1233s
         1XOA==
X-Gm-Message-State: AOJu0YyL2OzUhaYXfzsvhKZtXuB/0jBw24sbS+/LcBy4x/pP8xZXR3G4
        IqRAs3RzLQjys2jA4Of4wPm0E1LPsQN92oaK823t0w==
X-Google-Smtp-Source: AGHT+IE2i+IGLihJyDUU92iEsfOJ89xHIpqAvLBfJ38g8EAORewbNnpf1O5z3/2lnffLogDp8Ddbkw==
X-Received: by 2002:a0d:f586:0:b0:569:e7cb:cd4e with SMTP id e128-20020a0df586000000b00569e7cbcd4emr13236364ywf.48.1692815831291;
        Wed, 23 Aug 2023 11:37:11 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i127-20020a819185000000b0058c4e33b2d6sm3487825ywg.90.2023.08.23.11.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 11:37:10 -0700 (PDT)
Date:   Wed, 23 Aug 2023 14:37:06 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: 2.43 release date adjustment?
Message-ID: <ZOZR0jesPpCDNbRj@nand.local>
References: <ZOYdG8RtPIgymtBV@nand.local>
 <xmqqpm3dg27i.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpm3dg27i.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 23, 2023 at 09:20:33AM -0700, Junio C Hamano wrote:
> > Should we consider pushing back the release to the week after
> > Thanksgiving, say on 2023-11-27? This cycle is already somewhat long so
> > we could move the release up to 2023-11-13, but I think it would be
> > nice to have folks around in case of any brown paper-bag fixes.
>
> I am not sure how it would help to place the release day immediately
> after the off-week everybody has stayed off the keyboard, though.  I
> would prefer to see fully working weeks during the pre-release
> period so that people can work on last minute regression fixes, so I
> hoped it would work much better to release before the holiday week
> begins, rather than after it ends.

Perhaps then we should shorten this cycle by a week and plan to cut the
release on 2023-11-13.

That gives us a full working week to catch any bugs, and gives everybody
a nice break before starting on 2.44. Thoughts?

Thanks,
Taylor
