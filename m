Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A094C47082
	for <git@archiver.kernel.org>; Wed, 26 May 2021 18:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8B32613BE
	for <git@archiver.kernel.org>; Wed, 26 May 2021 18:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235005AbhEZSpo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 14:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234863AbhEZSpo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 14:45:44 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6183C061574
        for <git@vger.kernel.org>; Wed, 26 May 2021 11:44:12 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id q10so2066559qkc.5
        for <git@vger.kernel.org>; Wed, 26 May 2021 11:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=zyCsm0SV6GUzorQSQBzXcYqsjR7lOpfdTq1u7xWhYxM=;
        b=RPz7BLIIR8IA2z2D9Z8LaMpunxo7tUlQUdmBvIzB4Hr8i04GhCsIDOehEvq2xLY1bh
         WN85e2KT/gSaucVpd0WQRoV8t08u+9AL/RTzx8ItBuDIH29szD3iCYvfYGpcf5kB7oAE
         xrG6QCXc2HYVJuv1cQjOHe9WhZl8mVnMtTUgw8UODmvV9TX2sR8biCEKQCG9HZ2Q2Bm0
         sAxkRTeb/k0HTNjJeLiqdV7zi/uetbqhoK49hUgdYyXil5JV1PZpK+2Pfxp7PbT1JmGn
         9HYHTRJ4pPE1khJh3pWC/3qHGaou8XJZxQUnfFrDpF3r7OwRFZbtuNYr30YJqBq+p373
         QxqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zyCsm0SV6GUzorQSQBzXcYqsjR7lOpfdTq1u7xWhYxM=;
        b=AJor+V7GVjBrdRM171db+JF1YdQtcyDDLD7/kBujcZwrBdtin8teQWGfgu0QoR+95h
         IpdeGsJ3ZF+Wj6ZPgZCLNvdNy39GsjH02AR6ybJMMXCEksfABzQnvqp4f2eiiqJkpqEx
         /ANinBvCcYs2e5Y2vruhLl6FqBIkwizjORSdu6JBWdRTj914vcO5TCh4EcpZruFM0M2L
         cYF/8x4KE3rsFpvbW3KNyR/GJUTF3YlN10hMFxjl28ewBQIhbve6zmc0n32gamy6Jdvl
         4TNLI2/CP6lLb7aKrkDlBv00YyQzMvLGpyvTMlv8qb6m6n9jNVlDpeK+PtSWURHEKs+0
         6IoQ==
X-Gm-Message-State: AOAM532OzUzu+oyC5fERc9VR9N052A260iKMBCH3C6XUtzWVzyQjUSck
        Pnq+0biqqwUuBjA74dxHjxTUTTn4ZAjYBDaC
X-Google-Smtp-Source: ABdhPJzlvuIVejAeZw+i+F3zsEFQu0xYuQbw+vPtCJN/w/jxxk2yzH0Rc/7jcUs1Zf+m0SLwVha4lA==
X-Received: by 2002:a37:7605:: with SMTP id r5mr21104904qkc.321.1622054651777;
        Wed, 26 May 2021 11:44:11 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:fd7b:5b8e:7238:b804])
        by smtp.gmail.com with ESMTPSA id l65sm2130971qke.7.2021.05.26.11.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 11:44:11 -0700 (PDT)
Date:   Wed, 26 May 2021 14:44:10 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: Re: SunCC doesn't compile v2.32.0-rc* anymore (was "Re: [PATCH 2/3]
 t/helper/test-bitmap.c: initial commit")
Message-ID: <YK6W+q1BhC1ZiB6H@nand.local>
References: <cover.1617240723.git.me@ttaylorr.com>
 <ec974bb0c85bcde00d45e983d701c538488550a6.1617240723.git.me@ttaylorr.com>
 <87h7ipmjkw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h7ipmjkw.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 26, 2021 at 08:30:49PM +0200, Ævar Arnfjörð Bjarmason wrote:
>
> On Wed, Mar 31 2021, Taylor Blau wrote:
>
> > Add a new 'bitmap' test-tool which can be used to list the commits that
> > have received bitmaps.
> > [...]
> > @@ -0,0 +1,24 @@
> > +#include "test-tool.h"
> > +#include "cache.h"
> > +#include "pack-bitmap.h"
>
> Since this commit SunCC (on Solaris) refuses to compile git, a new bug
> in v2.32.0-rc*.
>
> It's because it can't find the oe_get_size_slow symbol, you include
> pack-bitmap.h, which in turn includes pack-objects.h. That file
> references oe_get_size_slow, but it's only defined in
> builtin/pack-objects.c.

I'm not sure I understand. pack-objects.h has a declaration of that
method, but the implementation is in builtin/pack-objects.c. That should
be fine, but I don't know about how SunCC works.

What needs to be changed here?

Thanks,
Taylor
