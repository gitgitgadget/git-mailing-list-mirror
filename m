Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A0EC433F5
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 17:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FDB86138E
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 17:34:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344450AbhI2Rfw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Sep 2021 13:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244721AbhI2Rfv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Sep 2021 13:35:51 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D2DC06161C
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 10:34:10 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id i62so4144329ioa.6
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 10:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=N31ozZzm//q7K+qCzAfd9Gykl3uqJ9Tqxr6eBHJGR/Y=;
        b=QFofa29YEpCuYN+MbOPQfOtKQ89QYQFILO+6v0vCLwqslMY+jI8TPm2rPgWNqi7Qms
         BC4aC/F6gFPyzOOjIyBu1WZDv4epJAe0/+qp1XsSjBUc+e/vBab5Kj/5ZJVIGzsrCfUH
         LJTKYwK5HiA1DsJsgGPXz4CEtTf9oK7QVHMH8F/Z1V42Hn/SWI5hB+YCa814jI3999Yr
         iy8Zd1pJiPwwhhguLkG3A5ZnIrweOsnaAmyQwPJPK3RGHmq0n3b6SP/8LS+FGDw/F+NZ
         T5bjXeJ8+N33URw2Kq7QbOxkbTzlwvVWMwbnZGEiiI2RdRhb16IgcEfm3gDZM0JOHaWr
         XrKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N31ozZzm//q7K+qCzAfd9Gykl3uqJ9Tqxr6eBHJGR/Y=;
        b=hpdmZcU4NxZzI/RKSx1WiiQP/eMqZEORNZdomrO+D3osYzz1eC+urezLh6C0MhOUtN
         /xb30l1kSaddBnL0ALEHTbAt5xv7A3/hVyH8eNFZdPGVxSMTCeFH7kjtslKl0v4aD2he
         fXBGmm6V8nndRbfggHBkGG28IDeWJG8UDRHRAp+uxuPqgKqXVFj+W5jSD1HFfJ//Aerq
         LRImlFQbS0c62yU4e/yIJa9HQLkrnsBafEBTUiRbnGqLFC+IrgIrGj7v45zu1pS4nc5q
         aXeyE/iha9Dfd01XyzpCfFvMxLEbahLEdggcA5sv4AXnEjot5w8VlFTeXXvIqzMFKu91
         MTHQ==
X-Gm-Message-State: AOAM5330/ry2g0L0/EGglXAGjhmgW+LA/7pDgkpz3mxF1OrMsWtOdiW4
        h4XqK4fljtCRMVRhpg3l/5BSSw==
X-Google-Smtp-Source: ABdhPJy5Sv/AOmonici6nctWGEDD/S6bEki5KdmqnjgEWV4cgS8msxc0BiZj3cakXBi8VSijVVCXTw==
X-Received: by 2002:a05:6638:95:: with SMTP id v21mr854462jao.113.1632936850054;
        Wed, 29 Sep 2021 10:34:10 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z26sm260456ioe.9.2021.09.29.10.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 10:34:09 -0700 (PDT)
Date:   Wed, 29 Sep 2021 13:34:08 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Taylor Blau <ttaylorr@github.com>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Emily Shaffer <emilyshaffer@google.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: Git in Outreachy?
Message-ID: <YVSjkMLdxtURP5iN@nand.local>
References: <YTGLLQCvlnT17jo8@nand.local>
 <YUYPgF6tRQ5ERYWL@nand.local>
 <YUpN4zrZmyxoTb4l@nand.local>
 <CAP8UFD0snuPE0L+L2LxEgCAQXaP_j9LwxwJP_ZounOtg4kRv_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD0snuPE0L+L2LxEgCAQXaP_j9LwxwJP_ZounOtg4kRv_g@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 29, 2021 at 04:18:43PM +0200, Christian Couder wrote:
> Hi Taylor and all,
>
> On Tue, Sep 21, 2021 at 11:26 PM Taylor Blau <me@ttaylorr.com> wrote:
>
> > > The project deadline of September 23rd is fast approaching, and we do
> > > not have any proposed projects or signed-up mentors.
> >
> > It looks like the deadline was extended to September 29th at 4pm UTC. So
> > we have a little less than an extra week. The below link is still the
> > right place to submit proposals:
> >
> >     https://www.outreachy.org/communities/cfp/git/
>
> So the deadline for mentors to submit projects has been extended again
> to Wednesday, October 6 at 4pm UTC.

Thanks for mentioning. I got an email from Sage announcing this
yesterday, but neglected to share it here.

> We still have only one project ("Unify ref-filter formats with other
> pretty formats", that ZheNing and me are willing to co-mentor)
> submitted though.

I plan to submit and mentor a project myself. (I'm thinking that I'll do
a grab-bag of bitmap-related items that I'd like to see implemented, but
that may be too open-ended for a successful Outreachy project).

GitHub is planning on sponsoring an intern, too, but I haven't finalized
the paperwork.

Thanks,
Taylor
