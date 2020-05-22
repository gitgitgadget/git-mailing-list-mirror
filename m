Return-Path: <SRS0=kZBr=7E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20587C433DF
	for <git@archiver.kernel.org>; Fri, 22 May 2020 16:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAC3220723
	for <git@archiver.kernel.org>; Fri, 22 May 2020 16:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="euCTPR0y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730058AbgEVQF5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 May 2020 12:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729903AbgEVQF4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 May 2020 12:05:56 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893ABC061A0E
        for <git@vger.kernel.org>; Fri, 22 May 2020 09:05:56 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id fb16so4959035qvb.5
        for <git@vger.kernel.org>; Fri, 22 May 2020 09:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Kl9pRFz6APSEpRpm66X1RMmoKZCLkRm9amwu44XvPRs=;
        b=euCTPR0yHsZyJUemfGZJKwhdCr/KEhJpYWXl+wcqhcJU1+Q+Lf9o441/fgzah6MRSO
         /lHMeg9JL6iO1tHcIw/LimBO9L2nYfdIgI7tFfm+1437W30xd0vpDmywAK5bVmCeq2cS
         g00epLOxQkatRgLrLBNWJaDmA6RWVQaKn5fAtZ81WQpO3WfOOdJvDbiBnrmheW0eLwRI
         hC+/gLPwT6AEe2K0ptW5uh6MUTT30L51kzlmMzQima1m819IPRhRvrfrtIaJDPy/E1gD
         Saqqp2AP9F4BkBpSuMx4t0cuKU1xKrfqGQdmXSUw4O6Me13Ci6f+kTYSKhTBVNhkzDUK
         /mhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Kl9pRFz6APSEpRpm66X1RMmoKZCLkRm9amwu44XvPRs=;
        b=HyuvU7gZZY23pvq82f7S6jHMVu90b/rphSTtOyPEIhLotN4N1ot7tWpjKBDVFhH/Wu
         fN9YdRuWPYpx2Sras0t1+YHG9W0suT9cfdHlLJu56qFrqqh5q6tJiJ0SdkaNhyW7TbXG
         /xLN/1rXjDKCrsTIdj+kWQuxmyvBzoDLbxO3VXDiTHwQMVycRDORSOPSYrDBQDhygaP9
         5tndK8uC1AycqHNfT5FJSlAfyQMPwYCi+n30/ZhiLZbwv3wEzoCkLOJnuXRu4gs4O5fg
         /josHDuq/MVXHh1AdCwp3qwRX0F5Cj4vhkdxnsgGwc7BVMUwdmG2wO9KPvcK+xglc6PC
         7hGQ==
X-Gm-Message-State: AOAM5304xn37d5viPfBzS+MMcg3yAl4gxlAtcVUaWs9X1ZV3rHkgIu6H
        buSEzJoMqugM0t8kRfKZVawb9FNk
X-Google-Smtp-Source: ABdhPJyXAN0dbcQtP4mWJ6jHuCTP4iVDKls40MBpJ8Y9OtjcUX5dYika0O7D/VGeig826woiuhK7Aw==
X-Received: by 2002:ad4:536a:: with SMTP id e10mr4370351qvv.246.1590163555791;
        Fri, 22 May 2020 09:05:55 -0700 (PDT)
Received: from generichostname (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id a188sm1250539qkg.11.2020.05.22.09.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 09:05:54 -0700 (PDT)
Date:   Fri, 22 May 2020 12:05:52 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 9/9] fixup! remote-curl: error on incomplete packet
Message-ID: <20200522160552.GA677085@generichostname>
References: <cover.1589885479.git.liu.denton@gmail.com>
 <4364b38bd027c219d41282bad3f8476daec936f9.1590154401.git.liu.denton@gmail.com>
 <20200522155410.GA2146293@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522155410.GA2146293@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, May 22, 2020 at 11:54:10AM -0400, Jeff King wrote:
> > -printf "%s\n" "00"
> > +printf "%s" "00"
> 
> This one is a behavior improvement: we were probably hitting "oops,
> newline isn't a valid line-length character" before, and now we're
> really hitting the truncated packet.

The test currently actually greps for the "incomplete length" error
message and it passes so the behaviour remains the same. We just got
lucky that we send "00" instead of "000" beacuse "000\n" would've
otherwise given us a full length header.

> I don't know if it's worth adding an extra test with a bogus
> line-length. I'm OK with with it either way.

I think I'll leave this unless anyone really wants this to be tested.

Thanks,

Denton
