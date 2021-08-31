Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6BEC432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 16:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6703661057
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 16:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240197AbhHaQoQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 12:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234317AbhHaQoP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 12:44:15 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18ABC061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 09:43:19 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id n24so25701056ion.10
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 09:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pV7eiHIhf9xvzI46XWheomwB3+Vt+DxRKcu8m/TN0ZY=;
        b=Sw3D5oVkOzqAFvcnXwj0cTz1OcXkqmad1tX9cmIPEAKhANAvXLPWspmiGqAoNzFx3+
         LD1B6iTa/Taw9oW6fyqJ13HUw3icbYNoc+Ezs1/QdWRx3NFA6m6mCc1CwD0hafnK+kOY
         yvGCFSPVLTAPEAPQKkb1wWmqDr4iUqcsqAfjBCogmBx1DKaOc3gFsvZUV/E/2+9xVt+R
         zl8xjIkBnluYcHpDa/1LClpJFSq3y1ggfOhAUTVm7cMdX7F/LKgJHIxw+TpwlP9f+KHV
         hQNbi6q/hbjpVAPLFrRAMvmYGdR49Q5M3vBxmuEjS+/LUOGcg8w/oSlcQoY5cUSv6WE9
         ZVQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pV7eiHIhf9xvzI46XWheomwB3+Vt+DxRKcu8m/TN0ZY=;
        b=mRhjR6GJ6ZdbAtYSwCffRL/8Uu0kfIL8wCsvYgbBLPrOUrMlOxQNKwW+dpdVU9X8u1
         SjzXuRQdixQ+Fs0Sy0GyL/mKigTjKTMBAXWrqRSvZLurL2VBuETj0h46RanxaTWS0mvz
         Sc3PrmvmU29Yr6mrY+GL19BMjAqjlVbJdVjLZXPCAY+oAAs4l2Kh6YAkTYAAVvJ8+ngM
         eF/sYz0otcZ1W+j3scKtHM15XDkhGS7sBm9gJ4I440E9P+JKG4A+h7Z2vGynE+eWt7M5
         Qj8xBXF1ZLBSMCw0MHpeA/VFqXpozrWlOLHwfe1z8zAa++FB5tO8isRuv/SPhrDxsAKW
         xA7A==
X-Gm-Message-State: AOAM533QG5mdqx7h+4nN+91HnAB7vw9vR2vH/oIHMa/rsGICXFbPPB4o
        FUDAcdOQgiU7D9nlj0KyZ5cPlQ==
X-Google-Smtp-Source: ABdhPJxWxyF/oGqu4cfYJkqVVlyEHilpx9zbq5E7w4bAZRyP4XJ06OOeWB2xRLIDIaQBaQyZT/39iw==
X-Received: by 2002:a6b:fd1a:: with SMTP id c26mr22871285ioi.57.1630428199202;
        Tue, 31 Aug 2021 09:43:19 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b3sm10618439ilh.14.2021.08.31.09.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 09:43:18 -0700 (PDT)
Date:   Tue, 31 Aug 2021 12:43:18 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, jonathantanmy@google.com
Subject: Re: [PATCH v4 05/25] midx: clear auxiliary .rev after replacing the
 MIDX
Message-ID: <YS5cJjlV0Rkpu49n@nand.local>
References: <xmqq35qymrcn.fsf@gitster.g>
 <xmqqy28qlcow.fsf@gitster.g>
 <YSVuUYFh7lmhNlEy@nand.local>
 <xmqqo89jbf49.fsf@gitster.g>
 <YSko4OwwPb7MwEMa@nand.local>
 <xmqq4kb797xc.fsf@gitster.g>
 <YSwhNxqAS8JajA7p@nand.local>
 <22366f81-65a6-55d1-706c-59f877127be0@gmail.com>
 <YS3AKhQJjMrFm1JO@coredump.intra.peff.net>
 <xmqqk0k1wp3x.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk0k1wp3x.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 31, 2021 at 09:33:38AM -0700, Junio C Hamano wrote:
> I do not see the reasoning behind "should not be a blocker" from
> Derrick substantiated.  What's the reason why that raw object store
> cannot come from an existing repository, and what's the benefit we
> get from not having to have a repository there?

I also didn't find the reasoning spelled out in his response, but I have
definitely had off-list discussions with Stolee where it was important to
be able to pass a value to `--object-dir` which does *not* belong to a
Git repository (but is used as a dumping ground for packs, a MIDX, and
loose objects).

It may be worthwhile to recapitulate that discussion here on the list.
(I'm hoping that Stolee won't mind filling in the details, since I seem
to have forgotten most of them).

Thanks,
Taylor
