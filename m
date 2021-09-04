Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105ACC433EF
	for <git@archiver.kernel.org>; Sat,  4 Sep 2021 17:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D88B160F38
	for <git@archiver.kernel.org>; Sat,  4 Sep 2021 17:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237094AbhIDRww (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Sep 2021 13:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbhIDRwv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Sep 2021 13:52:51 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14034C061575
        for <git@vger.kernel.org>; Sat,  4 Sep 2021 10:51:50 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id j15so2481243ila.1
        for <git@vger.kernel.org>; Sat, 04 Sep 2021 10:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=M85mr/9Yt6vHo/8UHPGE6yXtyHjd3qgwEfTjh9l7+xs=;
        b=ooiyniaiMXQm9iw34icd4KTRf9NOwwRaBWag7R6zvlsLYfqsQc44s7AV6tpdPPuNCf
         7Vr5asrkxcO1ooCS6GzeWPPOz59U4M1Ooh2g/y/cR60lv8yJsSw2eMe5AQJs1C8TSeJ2
         x5sR71QjeUef+ILqnXGOQZj8HTy+aispw9K+dFQ1Z6yPAtyRtCJ7Rxt8eX+mFcIEmw4q
         Hf9ifLU3T0iyRNiDs3ExJjR07wNEh7+dgXU9JfoykXEcyThSNV+AtYue9fEIykLrwjFB
         Eg88w17W6EFpsRO8T8it5/FbPsAdnTHvQOL4/jD6XXqwgUNNf0YhtM5OA4jxk9yX7lC6
         u/wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M85mr/9Yt6vHo/8UHPGE6yXtyHjd3qgwEfTjh9l7+xs=;
        b=J4g7gVwsN1VLNAFwWrF3jlTnOyz70cRzqF/KZq+eILOFW2H4/IKk0qPdxgG/3eI1nd
         l+sXAqGQWoB/Q6BAt4fcskZGs99np0eFWzoWwkQSeIGKQ67A1vNcCp/XtAomxVRFCzCd
         ZWABxLWbZV5egYB+yZ9EijSCSVAbabsL+OSUUrMd0M81lt5VbceAI2q0m82cK9TQ4Qjq
         /izdHZmJQUE+d5gPci+BTd2V+CW+c5c/KcTjgVhQnWvmyM15L0maPAhwP71S9JzNkC0d
         WqxDSc1C6fMjEZmlZv44rYSIVxXrT6YGrtX3I2o3KfSdKNsb+dk9h2Nl+PbjQdmvm61H
         2P+Q==
X-Gm-Message-State: AOAM531PLncqwtyHW40LiqiMEMct4oVnu7YLuvZa/CBTWKwkfmLW0IM8
        xP+wcZm1NroUQxbjsrv5T7MU0VmH4tXDrOvT
X-Google-Smtp-Source: ABdhPJyjChHWdgifW5jkjE+4WAoOpltTnrlqKQwyxFpgem0yr/SyvJ5zfKp3p/uFwTAJgyQCHbGZ2A==
X-Received: by 2002:a05:6e02:b4b:: with SMTP id f11mr3309081ilu.3.1630777909431;
        Sat, 04 Sep 2021 10:51:49 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b12sm1772923ios.0.2021.09.04.10.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Sep 2021 10:51:48 -0700 (PDT)
Date:   Sat, 4 Sep 2021 13:51:47 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Taylor Blau <ttaylorr@github.com>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Jeff King <peff@peff.net>
Subject: Re: Git in Outreachy?
Message-ID: <YTOyMxo2qZeBIWDM@nand.local>
References: <YTGLLQCvlnT17jo8@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YTGLLQCvlnT17jo8@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 02, 2021 at 10:40:45PM -0400, Taylor Blau wrote:
>   - Updates to our applicant materials on git.github.io (project ideas,
>     as well as potential microprojects).

One project I have been thinking of is a grab-bag of bitmap-related
tasks. Some ideas for general improvements are:

  - Designing a new .bitmap format (perhaps using the new chunkfile
    API?) to allow us to add optional data to it in the future, like any
    information we might need for a stable object order.

  - Experimenting with replacing EWAH with different bitmap compression
    algorithms to see if we can increase read performance and/or
    decrease file size.

  - Tidy up and take measurements from my RFC patch(es) to add an
    extension which indicates which commits have bitmaps, and at what
    position. These were discussed beginning at:

        https://lore.kernel.org/git/YNuiM8TR5evSeNsN@nand.local/

    (but they seem to help most when there isn't too much traversal
    required between the ref tips and the bitmapped commits).

  - Rethinking bitmap selection to be more robust against repositories
    which have "spikey" ref tips and for which follow-on traversal is
    expensive.

These are all fairly open-ended, and so may not make a good Outreachy
project. But I would be in favor of having more people familiar with and
interested in reachability bitmaps.

I'll think of some others, too.

Thanks,
Taylor
