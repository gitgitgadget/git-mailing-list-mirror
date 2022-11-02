Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502C0C433FE
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 01:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiKBBFI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 21:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiKBBFH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 21:05:07 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB39B1A212
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 18:05:06 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id s9so8752323ilu.1
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 18:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c8EHqixf2pQrDz9KRfoaMx9hB7MqFxjHQFE6gs8Xr1g=;
        b=xtiMwghBNjXtHxml++92FRMCwFow0uQtdFtF+3flRSWdk/H6HlLBqAtbA4thGJAQhS
         RVF3GtH/Ctxth9Jpa4q7COtHQvluHyL8Ht3diktqL8UIUYRmwE8qWGD/jaL3GOQ8hzbP
         h6uVK+K64B84J/NTYZ7peEDl883c3bAlXqFrKra9dy1WIZQZkXib6Qu7hDVbHDyp0gVu
         LobIuzoho+8oOoNc4ZoU3IY4sktahcMHi1I4Wfedh49X/enaXGJDtQ9ueq6ZZvK3t2x4
         DXvbSQS+6mbCb+7a01PE1kj5CVZJkF/FZl46g4pLcEQiXcq1y8L8FrXitEePT+T0fA5S
         GN6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8EHqixf2pQrDz9KRfoaMx9hB7MqFxjHQFE6gs8Xr1g=;
        b=fw7wfHRwcvLnKM3onpMnD0VUpglvYVyNtK3CGAuRgsAku0mOtw62cf5J6ZPUUM51ek
         v4G4FWbgQQCqL3VOcV/+WenKQeUpiJ2tZxRTZwPfkw70p2zwKQi5/XHpM6x09MMpyre2
         y03oYqIgpd3sWEqbd6glClSvIguc10fWrDK2JlU9LuZbpMJfsSegCfN47q5GyKNGxSoR
         15/+RYLZQdj1MtI1JvthQjRr3b80+laQYiykfeB4gHdJZtjkwlwQ/Z3XfUsA6HP2O21H
         R8bruE5EjXafx0pYTbeP870cViDPXL9ZSy80uF/yiArDztOaCam6H/GQCUQVN4DWfoTj
         vqGg==
X-Gm-Message-State: ACrzQf0G1VW2Hn+YhctAvN508Ti7xxxfK+bgw0sFsoh7rspeFhrox2kR
        Km+gohSbcIlM+m5c6HvI9Cx+VVdGel59nb8q
X-Google-Smtp-Source: AMsMyM5FVVVb7nmU+UviXhmikGWzyQ1/zOyD+KFYN3UvPXMTPm18zhcWJD7CpZQxkLhoIK1MgRbFyg==
X-Received: by 2002:a05:6e02:180f:b0:300:2f31:a1f1 with SMTP id a15-20020a056e02180f00b003002f31a1f1mr12972881ilv.179.1667351106364;
        Tue, 01 Nov 2022 18:05:06 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g16-20020a92d7d0000000b002ffbf49a0d2sm4097204ilq.84.2022.11.01.18.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 18:05:05 -0700 (PDT)
Date:   Tue, 1 Nov 2022 21:05:04 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] receive-pack: use advertised reference tips to
 inform connectivity check
Message-ID: <Y2HCQAGfY+xsDzKe@nand.local>
References: <cover.1666967670.git.ps@pks.im>
 <006e89f384be1227b922fb6fdc8755ae84cac587.1666967670.git.ps@pks.im>
 <Y17L0IjELU5QlOPL@nand.local>
 <Y1/fm1prlAs3U1NE@ncase>
 <Y2B2KeYX5X9vp+cf@nand.local>
 <Y2DI0OL1bXhPS/JD@ncase>
 <Y2EIxp+YM0Bee79v@ncase>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y2EIxp+YM0Bee79v@ncase>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 01, 2022 at 12:53:42PM +0100, Patrick Steinhardt wrote:
> > > Maybe, though I think it's fine to let clients send us smaller packfiles
> > > if they have some a-priori knowledge that the server has objects that it
> > > isn't advertising. And that can all happen without buggy code. So it's
> > > weird, but there isn't anything wrong with letting it happen.
> >
> > Well, I don't see how to achieve both at the same time though: we can
> > either limit the set of uninteresting tips to what we have announced to
> > the client, or we allow clients to omit objects that have not been
> > announced. These are mutually exclusive.
> >
> > So if we take the stance that it was fine to send packfiles that omit
> > hidden objects and that this is something we want to continue to support
> > then this patch series probably becomes moot. Doing the proposed
> > optimization means that we also tighten the rules here.
>
> I'm wrong and you're right: we can do the optimization to limit the refs
> we use but still let clients send objects that are hidden. I didn't take
> into account that this is merely an optimization that we stop walking at
> reachable tips. I'll reword the commit message when having another go
> and will likely do something along the lines of your proposed new
> `--visible-refs` option in v2 of this series.

I wasn't necessarily advocating for a behavior change in this series,
more pointing out that the situation you said can only happen with buggy
code doesn't actually require a bug in practice.

Thanks,
Taylor
