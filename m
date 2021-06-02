Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D1AC47093
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 20:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCB4561403
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 20:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbhFBUVe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 16:21:34 -0400
Received: from mail-qv1-f44.google.com ([209.85.219.44]:43662 "EHLO
        mail-qv1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbhFBUVd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 16:21:33 -0400
Received: by mail-qv1-f44.google.com with SMTP id e18so2008538qvm.10
        for <git@vger.kernel.org>; Wed, 02 Jun 2021 13:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kpch6edrnPYaw2Zm06Uqn5rVR/8PL2ozxcHG2twCEgA=;
        b=1wZx9GELZ/K/GZRrHGBBe0hpKMZDgmmJVnnY2xLXFMHiBscCmmYU4oqumqHQ9PWMl5
         i3Gg/O/4SWCqu32LKqbfLWGknEHWWS8HjQvKSU5P4+mU9+a5W7bDwIAtTjm+k9NByBAC
         4v5U4CT916ahkBpuSMOL6K9NvN+AGOcfM994KuY0ubxhO/C9xuAOGUXQq4kPecND0mnf
         BItaPHNDhFYyl2LmTnhc2ZjVeice++3uZyuv5xMqiQbxTbzZuQg7BdFyQKEAcSLNnQfK
         H0GF1rNeI4lVWreGRY4ynLynr4M0IER0RHT20LyzaiIffCLmwn6nH771VK479KlRqKQA
         3EQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kpch6edrnPYaw2Zm06Uqn5rVR/8PL2ozxcHG2twCEgA=;
        b=mblyn0IaqzQgk9x1FPNWjiTCS8w2P9z2R7jqYPG/0rDizkt1aLeJj6Nx1+BZIe5Jwv
         sqO44MKOqKTcNSMwRH3VM1xaxv5ZKksWId90jFi9SZUXOBwckC3p3R0+Wky0sVfpjQpx
         euiKI2RwQDmvbWVe8oP+n38Zi0dDQTU3eMYQptyTwYPgkVxe/KO/yf1h+Y6PxfENuzPx
         V0QD8bBz0qpVgDSpt7ltHXVTBrVJ7nLvGhy11q3+jmoR7XUHNCNSEWBqKN8PsF1qhqbh
         fGSvc9MmPiuv4lfypxKVPdV4RVLlpVQ02ssLa0PzHrimrl06xneFUQVdfa8e7Vef/0Gh
         75Zg==
X-Gm-Message-State: AOAM530/hE+ca2jg293vzvZQSNvoCl1arbFEKA4xanJzdLAw6os1eCia
        CYfPyFN6yNMT8nCTOoz5NRbG6hw2JcZ8sDFm
X-Google-Smtp-Source: ABdhPJyEWQ7tESZa/NZZ4nNtQG35TFqVgd0tFGwgb/UKhi5LuZl9I65kvFYREpELOM4xe9IAqYvHDA==
X-Received: by 2002:a0c:cdc9:: with SMTP id a9mr23869523qvn.51.1622665119511;
        Wed, 02 Jun 2021 13:18:39 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:9178:81cf:a7f0:8e5d])
        by smtp.gmail.com with ESMTPSA id q190sm517329qkf.133.2021.06.02.13.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 13:18:39 -0700 (PDT)
Date:   Wed, 2 Jun 2021 16:18:38 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Wong <e@80x24.org>, Taylor Blau <me@ttaylorr.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.32.0-rc3 - t5300 Still Broken on NonStop
 ia64/x86
Message-ID: <YLfnnkl3UfuU6Yo/@nand.local>
References: <002701d757d8$1a8d9dc0$4fa8d940$@nexbridge.com>
 <YLfc2+Te7Y3UY+Sm@nand.local>
 <YLfgy94sbmStC0mR@coredump.intra.peff.net>
 <20210602201150.GA29388@dcvr>
 <YLfmo8kl0URnGgp5@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YLfmo8kl0URnGgp5@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 02, 2021 at 04:14:27PM -0400, Jeff King wrote:
> > The wrapper should apply to all platforms.  NFS (and presumably
> > other network FSes) can be mounted with interrupts enabled.
>
> I don't mind that, as the wrapper is pretty low-cost (and one less
> Makefile knob is nice). If it's widespread, though, I find it curious
> that nobody has run into it before now.

Yeah, I find it curious as well. I agree that the wrapper is relatively
cheap (especially relative to fsync), but it seems unnecessary despite
what's in POSIX's fsync(3). So the more conservative choice to me would
be to hide it behind a Makefile knob, but I don't mind much either way.

Thanks,
Taylor
