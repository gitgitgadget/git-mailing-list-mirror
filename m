Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50CC6C7EE22
	for <git@archiver.kernel.org>; Tue,  9 May 2023 20:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234622AbjEIUXv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 16:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjEIUXu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 16:23:50 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E83F40C4
        for <git@vger.kernel.org>; Tue,  9 May 2023 13:23:49 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-b983027d0faso8208256276.0
        for <git@vger.kernel.org>; Tue, 09 May 2023 13:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683663828; x=1686255828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FaZ9Fr4iOSlD9y5YXDVHSxTT+1jj+2gtMM82yMoSgH0=;
        b=thB4UkrCwa9WTyslbrHCYTzCYGE6YZQvtOZyl1aumkTC+sGrNqanGDjyrXhnOVsmqK
         DulVAsffc7udNWq3gxAf/gQHYI8Y7II0+ROlFCqwz+rg54Cp/gIbppdkCCzZk/JgapFx
         ARLYe2eCm6PTYr/81XH6YYiOUa4WGVX33NWx4dhEx1LBS0S56465uro+j6GHqoV3MdsE
         PmJPa6pR6hRCbd0/+3LeTb10mP/MnAkl1J2V1cPVNjCP+Y8RDGiZvxxd9ISt5hjNysRG
         2mHeNtgr4u7Nb8ghHRGj/TapZwvCplKl44moHQgozxVwU0V3hnN2y9oJSXm33CsklEfe
         dzxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683663828; x=1686255828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FaZ9Fr4iOSlD9y5YXDVHSxTT+1jj+2gtMM82yMoSgH0=;
        b=GsiMT4lSxgzNUSQBq7YHtgVQ1lmQP/4k70o0oKjExXrf+NzImeHXN4mbkX+c1YqxA1
         iPG5qeLelcVmKoKhv5esbuBlRHyYlamQGH2DlS1wIBZ8YxQoWbiQaxyHGIraFhor0AOq
         h07fqyFux0/EVjvhv86ApP/9O2N/t+z7mWiY+4S55gG0Hcpo1jbfRE1okO1pSwKf1auD
         xKIfknrEnUmkco1TuUeIhE3kzBi3Lq6xJSZZUMsUY7jQB34THXC41ChjH9imWlqERjBL
         3Z+DONWCL2yxVzuNLXcS4T8pdF/7kJaa42HhK06OxISep2X0vsYB4eYXpC0uOLsgCa3z
         4h9A==
X-Gm-Message-State: AC+VfDx/QOl3cfx5NJoqLAg6dBZJU2mT92NHaiBBSA+4EMXz145LS1kI
        AfPGP5yWAqq7VDzZg1hJyKgybw==
X-Google-Smtp-Source: ACHHUZ4AHBXr2mE0h1YR9h95KkaK4aebGGHzEomcNDNHuJMAhvl0yJTydBfFvx/sIQm18jjeGXR+bQ==
X-Received: by 2002:a25:b07:0:b0:b95:3877:2161 with SMTP id 7-20020a250b07000000b00b9538772161mr15644874ybl.31.1683663828684;
        Tue, 09 May 2023 13:23:48 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h15-20020a5b02cf000000b00b9dcfade2bbsm3197229ybp.8.2023.05.09.13.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 13:23:47 -0700 (PDT)
Date:   Tue, 9 May 2023 16:23:46 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 07/15] refs: plumb `exclude_patterns` argument throughout
Message-ID: <ZFqr0oxt4IZkbPaD@nand.local>
References: <cover.1683581621.git.me@ttaylorr.com>
 <f437cd83e2d2177b1526673821b950f47814abc6.1683581621.git.me@ttaylorr.com>
 <ZFpjcoylGSj7Palo@ncase>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZFpjcoylGSj7Palo@ncase>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 09, 2023 at 05:14:58PM +0200, Patrick Steinhardt wrote:
> On Mon, May 08, 2023 at 06:00:01PM -0400, Taylor Blau wrote:
> > The subsequent patch will want to access an optional `excluded_patterns`
> > array within refs/packed-backend.c. To do so, the refs subsystem needs
> > to be updated to pass this value across a number of different locations.
> >
> > Prepare for a future patch by introducing this plumbing now, passing
> > NULLs at top-level APIs in order to make that patch less noisy and more
> > easily readable.
>
> It might be worth mentioning in the commit message that the exclude
> patterns are supposed to be best-effort. In other words, any caller
> would still need to do manual filtering if I understand correctly. And
> while this is indeed documented via `refs_for_each_fullref_in_prefixes`
> it is quite easy to miss this important little detail.

Good suggestion, I updated this patch message accordingly.

Thanks,
Taylor
