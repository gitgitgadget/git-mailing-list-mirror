Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025E6C433EF
	for <git@archiver.kernel.org>; Wed, 15 Dec 2021 23:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbhLOXB0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Dec 2021 18:01:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbhLOXB0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Dec 2021 18:01:26 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9FCC061574
        for <git@vger.kernel.org>; Wed, 15 Dec 2021 15:01:25 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id q72so32552131iod.12
        for <git@vger.kernel.org>; Wed, 15 Dec 2021 15:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/X+sdsBr+PRh7Nq7o7Zq5L4H0r1muvGBlktVbe0dvXI=;
        b=H28dWTlHn1ulTOTuw0+1IBKLOIoVMFKwSZm3YIiuuHhoMIt5WjyJHE/tSxLanXYv3E
         Ezl0DIZBEU6Sk/vSzANFNOBprDOWyvSSFpyHyHOCpeg7Xan7BA2qZ70Z6ihDnryASuzb
         M0HMqMKFvOFOkM28V1emmIeNA6K69hbm8mgiPiw2jvOIehfAaaQi0CSFDt2ZtbEatqon
         BpwRfeI/I6wTuzVV5uCRzczH2mePHHJqhf2mylCcdKKejLvjY4CwzFVk+ivcLwSH+wbn
         Sj4sCdwmw5upDk77K36CRvaW11kP8qecWdT0DCLW0SzmiIad1VlH+wEZVxvSQOkQZwq3
         u9ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/X+sdsBr+PRh7Nq7o7Zq5L4H0r1muvGBlktVbe0dvXI=;
        b=qWolGvQyKrCzItK79j+7D6+5OzMJlBLctAV3+/EScJYvWQYWq8Wd4J2bYVTnUulWsT
         cBHFD88RtxgjyZH+ECvepby7tgtoUGcRLl9UoUXSThH4sk4seI7xhNjMUxH1EaTv18XS
         A8po1X/r0zaMU+TfIotDs+of4Wwl4etJNMDYe19tXR8rrGFNxpJu8lpNEpRiUqGMtUSG
         qtI75x9hw+dlQ8nWs15ynM4HDMgeHTwWvLvI5ggZZq3rqOF538HJXNnUPz9wJlQolyNz
         C8sINeJBuYJ+PDjJi3ptTFR2R3i+aegtx9MF5YTFFgejtkDxCZ4eijjblsXT2CRvo30v
         sTGg==
X-Gm-Message-State: AOAM532rDqBN4fT1IikexB+yiae3SvH3HqWgJZB8MT4n2PYp7tCT0dOh
        GPMynuFkQFgH5K0xYt3zNkGRA8JusJSN2V0B
X-Google-Smtp-Source: ABdhPJzzpGRlb+vZRIDzbvp9Kepfr3X5aSJpaQmxEivhN1kvAftL5woCxJWTGnF7qtB0CQCjfmzG3Q==
X-Received: by 2002:a5d:9857:: with SMTP id p23mr7855896ios.137.1639609285235;
        Wed, 15 Dec 2021 15:01:25 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g20sm1992029iov.35.2021.12.15.15.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 15:01:23 -0800 (PST)
Date:   Wed, 15 Dec 2021 18:01:19 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        stolee@gmail.com
Subject: Re: [PATCH v2 0/8] midx: prevent bitmap corruption when permuting
 pack order
Message-ID: <Ybpzv+jVba6wafFN@nand.local>
References: <cover.1638991570.git.me@ttaylorr.com>
 <cover.1639446906.git.me@ttaylorr.com>
 <xmqqzgp11nnk.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzgp11nnk.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 15, 2021 at 02:58:07PM -0800, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> >  Documentation/technical/multi-pack-index.txt |   1 +
> >  Documentation/technical/pack-format.txt      |  13 +-
> >  midx.c                                       |  31 +++-
> >  midx.h                                       |   1 +
> >  pack-revindex.c                              |  20 ++
> >  t/lib-bitmap.sh                              | 186 +++++++++++++++++++
> >  t/t5326-multi-pack-bitmaps.sh                | 144 +-------------
> >  t/t5327-multi-pack-bitmaps-rev.sh            |  23 +++
> >  t/t7700-repack.sh                            |   4 -
> >  9 files changed, 271 insertions(+), 152 deletions(-)
> >  create mode 100755 t/t5327-multi-pack-bitmaps-rev.sh
>
> As 5327 is taken by the tb/cruft-packs topic, I'll move it to 5328.

Ah, thanks. It should be a straightforward move. Alternatively feel free
to eject the cruft packs topic and I can update that series to use
t5328 instead.

Sounds like you were able to get the patches to apply, though, so I'll
refrain from sending anymore until there is a compelling reason to do
so.

Thanks,
Taylor
