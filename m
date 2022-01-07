Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F1FC433F5
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 19:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbiAGTls (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 14:41:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiAGTls (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 14:41:48 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D21C061574
        for <git@vger.kernel.org>; Fri,  7 Jan 2022 11:41:48 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id t8so5382636ilf.12
        for <git@vger.kernel.org>; Fri, 07 Jan 2022 11:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/6CNROJNEFCQti7yugOGPsE8LFUlSCRw64T3ECqaaTw=;
        b=NQfSqCG6iJxPEeDFhS/nNZRM2B+XUlY6lfbFMaT4sHr+FZgi9Ac6k41IqdTOjz23eL
         +8IaLtuDu/on7Tg+Oh++kIc4IdZtPHM/wYDHdKaxQmRyqNm5mExsKNTY90obDNNooBGV
         VwYMFEQrAb/1OoNfj5y2S9HHz3adCPOaRDgP01GmpoGoTC0h8cl/3wyzo8+iVTca4lKj
         rgukeWUWNsd33A2cBBTn6JfaDURDXrEPos1tNyXNP+pHHL2sMkHbUei3qEAGPa934MI4
         sofOiIqdPYLHHhSWLQhVuMCX4AHSygdCafGdJRK1nPPGKTQJ8aQTTtl+FH9y37bKBvl8
         cNaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/6CNROJNEFCQti7yugOGPsE8LFUlSCRw64T3ECqaaTw=;
        b=Gt0qXlOrD5LU3WNzdxEELHo2ReoRezueewPG+pw77N7ddm5uyogtcOEXp7GQ98+cZw
         ovwXcW16Fuc+8/ENv0EK1udXPTKuG6i948RVSJjXX+MLisjQjLzlBeUxoFhyFKlN4+tq
         XiBt1pu9ftvZLk2dmedyFTWyz24hs+btxoYkEtGiwb4EAczOT67bdECwb+Lukf/N05x9
         oY8lGziCuowojUXurjtTAT3+EabdmRMGIjojY2J0b1J7NGwSjRn6z4qi9FH/HjzVeUK5
         femIkHwdRe4A8D7Oxwt+75buWuhPd49nUNr1YUbF+AMb7zAfIjiRCa3DSEhcu7QhMFVY
         5Kuw==
X-Gm-Message-State: AOAM531AE9drEz1wB4ds6tB09OQ99p47UL6PFYjW1B4p9TPd6by2rRsm
        Uv4cjRmfz9A6YacDpSy0ueOcYA==
X-Google-Smtp-Source: ABdhPJxW/HT8U7dmT+UkcCtrJ8/2S/rGbVLpgYaXC6vDA3U5syanh/DVYwvjodX3+DYPZxzXw2z6eQ==
X-Received: by 2002:a05:6e02:20cb:: with SMTP id 11mr32227025ilq.163.1641584507409;
        Fri, 07 Jan 2022 11:41:47 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id n10sm2596354ioz.17.2022.01.07.11.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 11:41:47 -0800 (PST)
Date:   Fri, 7 Jan 2022 14:41:45 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, larsxschneider@gmail.com,
        peff@peff.net, tytso@mit.edu,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 02/17] pack-mtimes: support reading .mtimes files
Message-ID: <YdiXecK6fAKl8++G@nand.local>
References: <cover.1638224692.git.me@ttaylorr.com>
 <7d4ae7bd3e28e2ec904abb37b6f26505e37531c5.1638224692.git.me@ttaylorr.com>
 <ef10c824-e2d9-f113-f010-6a1ac307427a@gmail.com>
 <YaqZA02FsCFA9qBi@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YaqZA02FsCFA9qBi@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 03, 2021 at 05:24:03PM -0500, Taylor Blau wrote:
> On Thu, Dec 02, 2021 at 10:06:07AM -0500, Derrick Stolee wrote:
>     - A table of 4-byte unsigned integers in network order. The ith
>       value is the modification time (mtime) of the ith object in the
>       corresponding pack by lexicographic (index) order. The mtimes
>       count standard epoch seconds.
>
> > Storing these mtimes in 32-bits means we will hit the 2038 problem.
> > The commit-graph stores commit times with an extra two bits to extend
> > the lifetime by another hundred years or so.
> >
> > Could we extend the lifetime of cruft packs by decreasing the granularity
> > here? Should 'mtime' store a number of _minutes_ instead of seconds? That
> > should be enough granularity for these purposes.
>
> Perhaps, though it does add some complexity to the code that deals with
> this format at the expense of some future-proofing. I'm open to it,
> though.

I still have quite a bit of review from this topic sitting in my inbox.

But this had been lingering on my mind, and I realized I said something
incorrect. 32-bit mtimes won't cause us to run into the "2038" problem,
since these aren't signed values. So storing epoch seconds in a uint32_t
should get us into the year 2106.

If anybody is still using cruft packs by then, I'll call this project a
wild success ;-). So in the meantime, I don't think it makes sense to
reduce the granularity and/or use extra bits to store the timestamps.

Thanks,
Taylor
