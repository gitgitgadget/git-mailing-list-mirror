Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1CEC433F5
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 15:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241745AbiAKPmP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 10:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349602AbiAKPmN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 10:42:13 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1179C06173F
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 07:42:13 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id 2so10717003ilj.4
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 07:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0nZEpXv/ZqpitAsNJkef5X1tfPU5cqn1TnSJr1TAf+M=;
        b=0h+RNxWOTyOSECmSwXo6oBYNe0MK3bnO9lZVcpYHgAbjsMyHJvYDVF4VtiOJkQIfPh
         UiOIuwh+B28wfIS2tjeNqTx8BgGJVs4e9O7wS0panvMGAYyPv22d0w1Iu25jTFC6RLRR
         /laC7bgR0jrJT5bDvR1NPPan1YyM5oHOUt4dY9jebUnKYmJvqQ9ttKUHBOr0WuvK7WbH
         i/Z8EeaPGN6vfKYYESmIdpyf5Oz7L0oKG4obUlnqauFUgmrp/4kUonTzLqumL8KBXTPm
         jxxVQuUFYqoZlbIDqWh3OB1uyUNnnnY7kgt6Rr+oGI33wsfoi8uOg84ILwjr0ZAgupAh
         JXHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0nZEpXv/ZqpitAsNJkef5X1tfPU5cqn1TnSJr1TAf+M=;
        b=TjMpQyMLVlPaBuTjhtW+wxrCTlLYqqX+gQeXkjWc4uEkqHD/ULbtMJvDrhSYOw+K3Q
         H/Hi17oKIONduClI0Rp1xtuTUJYzPWlYx1kqhCJr5Y/53OMpCrGOga7+ygj+l5trjDuP
         iizbTacXPvT+jglO4UcMtdR8RRZwYIJJ7k/LxxLm3Ik1tNtVYlCvzZWGYjthctxobslt
         Sxl6+wm2nmCa822BmUYrmsRoBul31FO4N7uw09N/oFQsW/eYhQkOUYiOz79qQ2kjPDyt
         ivMQY/a8fQXdnMXhTvGhiK+wKz4vB6eHm0jFY9nmEBjWJMR9oEW0CrdEhNfg3H1Vvz+V
         krDw==
X-Gm-Message-State: AOAM533320PQ2Hpjrz70qlJ8AV5MI5JndzO5rQhnrmp7FRlqzkB2Q4iI
        LRryZk8L/A9P/Udazl23JawiMib0fzIJ0A==
X-Google-Smtp-Source: ABdhPJzGiIseing7T4srEbmtgMMBi1cFALjtk+RED/UQy0krJ2UMGhqey1zMp+KI6PUhAr7LW7XPfw==
X-Received: by 2002:a92:dc8c:: with SMTP id c12mr2553701iln.43.1641915732910;
        Tue, 11 Jan 2022 07:42:12 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i23sm4175946ila.85.2022.01.11.07.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 07:42:12 -0800 (PST)
Date:   Tue, 11 Jan 2022 10:42:11 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] fmt-merge-msg: prevent use-after-free with signed tags
Message-ID: <Yd2lU/ecNx1uIt7Q@nand.local>
References: <YdxqshqXB/+ApOn2@nand.local>
 <6e08b73d602853b3de71257117e85e32b96b5c19.1641849502.git.me@ttaylorr.com>
 <20220111084115.esuyxeopdpaq7g7y@fs>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220111084115.esuyxeopdpaq7g7y@fs>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 11, 2022 at 09:41:15AM +0100, Fabian Stelzer wrote:
> fmt_merge_msg_sigs() could probably use some additional refactoring to avoid
> these multiple pointers to the same (detached) buffer. But thats for another
> time.

I thought similarly when trying to looking at the original bisection.
But now that we're in the release candidate phase, I figure that any
less-than-minimal fix was liable to cause more harm than good.

It is worth looking at in the future, though.

Thanks,
Taylor
