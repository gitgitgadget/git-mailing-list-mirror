Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A6CBC433F5
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 21:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbiAYVqP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 16:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbiAYVqO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 16:46:14 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D76C06173B
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 13:46:14 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id 9so9762533iou.2
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 13:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vpkJfqE9Pf/rBeTL35V+3UWxqujI6UpTbFrv7Ny+D/0=;
        b=b3uIlnkYMcGTRBWIft3Cxetoab6DACgpJz1QzxFW7Yx54w44NEqerGWaTOQ8t2k2G3
         RPd/CZsIMsxFeO6RZM3SSBwXWRUYtvUShdIrFGveyKFN3jP002oqBwapnw3ysaLq2Po/
         j9HpDKRhllnyF9W/GsqfcRVpEBrgtF6B7l7uJ/VcTjKHXX1YISoUuac52kqwGmIBe1Hk
         QfMmGEEsfUgLbP/62iV+/Z5pmtL/MGGnW3vOcGToTVQtQo/aBIhFjU8sZBnyD7V7cFkG
         rh6G9EkD56OBgTDLw2h021RC8GlKLB5YJfI7kqPjpCdg2BzPWo930WBqqp1dokrKDtlS
         074A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vpkJfqE9Pf/rBeTL35V+3UWxqujI6UpTbFrv7Ny+D/0=;
        b=Uf8oCv/7EncT6DwzawAVDyS6eB4P7vHYJ0HHtn96F7WZTOr43IQzEQTxL7iV8HI33e
         6AfcpjVFW+X+vLpKhqm7o6kZz4p3joeMgI//2bjfcAj2s7D4cZhkcfL/PoYWPpC9+d8j
         pFBfFpuaycvLyEEDXK9MRaQW8vEHiC7ksAmicS3owhWEDc3IYOBzZtPBK920BIhixg84
         5YJDiGm18WsxXBdC9nV1WAPsD7ZvP0ZMKXPkHs0BwO3Mx3SKtkqT/TIEVeVCnpKl/xaX
         PZZUj92WzfKPFqWcdjrOpCfOcY2DEVH6trVOtg+EnZ1pgVR+o8D0Wgu8+Sg+RVFpbIOh
         ixIw==
X-Gm-Message-State: AOAM53326SpHO/3eeqiKY/R/ChHPYd496IwpKrd49cWGX/HMVFhUd66M
        EElytqokh+6lIXAdQVcdr9hWwOjsZxxz9Q==
X-Google-Smtp-Source: ABdhPJzdXxTX/8+MNO5RYsvozjIf0PeI46ym+lht7ig93srT3tbGtFBLddJm+j5LZdFhPNk8u2HkQA==
X-Received: by 2002:a05:6602:2ac6:: with SMTP id m6mr12103588iov.134.1643147173428;
        Tue, 25 Jan 2022 13:46:13 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d7sm9635163ilv.7.2022.01.25.13.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 13:46:13 -0800 (PST)
Date:   Tue, 25 Jan 2022 16:46:12 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, stolee@gmail.com
Subject: Re: [PATCH v3 9/9] pack-bitmap.c: gracefully fallback after opening
 pack/MIDX
Message-ID: <YfBvpKCEFLWHF59p@nand.local>
References: <9707d5ea4433d9a5c7f8581dbb2d8a05f410efd3.1641320129.git.me@ttaylorr.com>
 <20220124192910.2453842-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220124192910.2453842-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 24, 2022 at 11:29:10AM -0800, Jonathan Tan wrote:
> Taylor Blau <me@ttaylorr.com> writes:
> > When opening a MIDX/pack-bitmap, we call open_midx_bitmap_1() or
> > open_pack_bitmap_1() respectively in a loop over the set of MIDXs/packs.
> > By design, these functions are supposed to be called over every pack and
> > MIDX, since only one of them should have a valid bitmap.
>
> Thanks for this series. Apart from my minor comments on patches 7 and 8,
> this series looks good.

Thanks, I think we need a reroll anyway to reinstate the call to
finalize_object_file() as well as to have these patches be based on the
tip of master now that we're on the other side of v2.35.0.

I'll send that shortly. In the meantime, thanks for your review!

Thanks,
Taylor
