Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42C9C77B75
	for <git@archiver.kernel.org>; Tue,  2 May 2023 23:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjEBXwP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 19:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjEBXwO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 19:52:14 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E373594
        for <git@vger.kernel.org>; Tue,  2 May 2023 16:52:13 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-55a44a2637bso43266057b3.2
        for <git@vger.kernel.org>; Tue, 02 May 2023 16:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683071532; x=1685663532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8tWQ+uICQkRJxbIYrA6stED6PNXSbfio43gV8zVy30E=;
        b=E7gy4en3o22kSDwArwJE38DAQ9w0YbxCxtFivjQrMecLGa3pRbzYmYsgypCsTJTuPV
         oQxLgoKS7Qbnov3/+eToFMlOyOcxKENSPdr7iDmv8XykYeRCNfAWIN4Km0OMPtdNg1ze
         fUyC3jFgtJRu/aoMoHqNEUzJea+bMY9hydZzsBMrV52bqakrmq0ldujbHdDuKKtDgPTf
         UStk6quWSnauGgFFt+JuqKwyGKmalp0X4ri8Jjrr9xFri9LYl8wy/X0GfeIbWfXAoDSD
         Pm8lL/w/frvnnZmF4SMU3RBVhtjzXVr8zAoI2GjaPawb0tWw4aTVz8Onk6fh+mkuLptg
         eZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683071532; x=1685663532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8tWQ+uICQkRJxbIYrA6stED6PNXSbfio43gV8zVy30E=;
        b=CIGMDCFcmaP45URZfn1+MyMyF6JSESe8lXx3AOh4+TdQ3RhNUZwvg36uyck/W+hmxP
         suj7QXk9HyO3DLJ6jOr/UE9sCEegNq1rOLknAOSn/dUQpEVX3hxDRhfUWN4KDcqWjlFa
         RyfS+d4Sik2gKq3BF9QLJ0TCnX8fwId9DkYl8hdvudPGn0G4obXzSWdCbNcCFETPGaKa
         fWY3AJl9IPFwkh0u/aitp0zt863s7uMkeofwK3q/viGWcIhl7iqqJJd/fEb0/LKe1JPs
         qNiKVytyu+iHg5fi6tC6vFhBoe8+CV8CSUInocVYzEJhLOwnA3QqI06hdDBYtjpeMT8Y
         9T0w==
X-Gm-Message-State: AC+VfDy3jKs2VXJasO+gGcE6nXj4zzV57Ydnckn994BYC1RirGuxqR1T
        iFxC/1u6O2tw81o0vCsJnl9rji6X/rk53rgsKHIpNQ==
X-Google-Smtp-Source: ACHHUZ7hI2odh4brwDn6Z4YAT08b+xNFrSbc05Tx5sHyLXC1UYuZrZhhYKiJ1/QhD/G980XMNIRCJA==
X-Received: by 2002:a81:73c4:0:b0:55a:2cdb:55c9 with SMTP id o187-20020a8173c4000000b0055a2cdb55c9mr9035694ywc.3.1683071532348;
        Tue, 02 May 2023 16:52:12 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id l145-20020a0de297000000b0055a21492192sm2036359ywe.115.2023.05.02.16.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 16:52:11 -0700 (PDT)
Date:   Tue, 2 May 2023 19:52:10 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 0/3] pack-bitmap: boundary-based bitmap traversal
Message-ID: <ZFGiKtLlmQFtZftO@nand.local>
References: <cover.1682380788.git.me@ttaylorr.com>
 <xmqqo7n33dsx.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo7n33dsx.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 01, 2023 at 03:08:30PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > Here is a short (but dense) series that I worked on towards the end of
> > 2021 with Peff.
>
> The topic gathered interest on the day it was posted but after 24
> hours or so activities seem to have quieted down.  Are we expecting
> a polished version?  Or did it open a can of worms that is a bit
> larger than we want to deal with and the topic is left on backburner?

We are expecting a polished version ;-). Though I haven't gotten to it
as soon as I had hoped. I should have something on the list tomorrow,
though.

But, no, the can of worms is as expected here, and I need to provide
some more thorough explanation (e.g., we can collect UNINTERESTING
commits in limit_list() only because we only need to walk down to the
first UNINTERESTING commit common to both sides, and no further).

Sorry for the delay, more soon.

Thanks,
Taylor
