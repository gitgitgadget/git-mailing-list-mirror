Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8075FC433EF
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 16:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 616A761159
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 16:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbhINQ4V (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 12:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbhINQ4V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 12:56:21 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51B1C061574
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 09:55:03 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id a22so18000185iok.12
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 09:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gmtVbvtOSLRI3v1SI/1OZWLHMpqHF1u0v23j4Xh0dFI=;
        b=GxOCfJVfVF3fCLZVJ5r4FwfP4kTvEZ6ojvu1s+wkDbFK18gAoo5U2Qp+STTFCAbxEV
         vQQiFYUIjzFDmEtorhq3jSugfQw5KEk8BZK5LgpMW+Imn/5+xn9B0AHlnfh8aUBsz6qA
         EYKTH/Z4o4W2mNbzHa3sVemUcO7ljSMMWpOka8TEJxq1+0fImTFbemFNvEmn0wPBvo9h
         tnXNZYOGeShXbEOrkEBCUWkRBfZ9udGwlORDxOxQF+CcGFnno+Sjm1nrRaEzDS3QzsXS
         bawNX3hCRNVPhIjj+wPfiEG2gdrkh7KvSvAZm2nEDatbPX7oift4PJjCbFF5FdbW4SeI
         g56A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gmtVbvtOSLRI3v1SI/1OZWLHMpqHF1u0v23j4Xh0dFI=;
        b=n5E5yzrMCH+l6P0lZ39CuEFE/IsyrhkcprQQHoTenHne8G0pn3ulpnxYEEJxD+44yG
         xyQdJzQWHY8jntuCqFXPc+lvFOSAsQS8FLT5/I55EfoDRQNImJ+O8LE04JtDFkg+KI7X
         1VrDH00t2WBbYqJBlhNR+RfSiRLy6o5ICcnydlXtNNJLa1PJvdLzlB21mYMkYsrf2hJb
         0zO/4+jG+7kkmb9Nau3H+8Cidp/DZtPPIeOphHwMquSeYEh2qRppu7G90QF3ohmwpabW
         HMJjjeJcuejy1uXmyIqsisol+90FtAAdF1/cb7TkVXRk4k6qdUF4LwrhfRUus7pDQAic
         /RGw==
X-Gm-Message-State: AOAM530pYRYY4dGCeQOWa73Ucm7GWjomXfIGd0GQhjVPSQqW0+jelx+w
        /FWiLAObF/MHMqLHrA3IIibEga/Op+6IDeu1
X-Google-Smtp-Source: ABdhPJxKkqPt7oxy2mxS9O8qwnGUMB/o+d1B1P3TEqsgFwlCY4Y9SPvoiBkEzcF0FErXjHrKUyAlGA==
X-Received: by 2002:a05:6602:3284:: with SMTP id d4mr14133671ioz.100.1631638503073;
        Tue, 14 Sep 2021 09:55:03 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p135sm6922446iod.26.2021.09.14.09.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 09:55:02 -0700 (PDT)
Date:   Tue, 14 Sep 2021 12:55:01 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 5/9] serve: provide "receive" function for session-id
 capability
Message-ID: <YUDT5bnnMNtkc3KK@nand.local>
References: <YUC/6n1hhUbMJiLw@coredump.intra.peff.net>
 <YUDAtbHcbv6zNFxe@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUDAtbHcbv6zNFxe@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 14, 2021 at 11:33:09AM -0400, Jeff King wrote:
> I had originally dropped has_capability() in a separate patch, to keep
> this one more readable. That breaks bisectability, but only with
> -Werror. I'm not sure where we should fall on that spectrum (I generally
> bisect with -Wno-error just because warnings may come and go when
> working with different compilers than what was normal at the time).

I tend to fall the same way, especially when bisecting things in ancient
(to me) versions of Git where my current compiler complains. So I think
the approach that you took here is just fine.

(This patch, as with all leading up to it, looks good to me.)

Thanks,
Taylor
