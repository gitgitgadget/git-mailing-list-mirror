Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F924C433DB
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 20:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBD1E64E6C
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 20:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbhBWUI2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 15:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233043AbhBWUHG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 15:07:06 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95DDEC061574
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 12:06:26 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id v206so17533475qkb.3
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 12:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mcIlsUlRWA8R2bRhqNCwo4VxPUlldtnIIs5QQzH+VdM=;
        b=1xzWVw2UywtkUpTaLJ3d4oJb5tG3rWn45hiSolgfAF4teUwHkbYTRHMXXHn57MZ+pK
         bRiBBxOYpJUiuFHqJfiRo6e6fct8zDu8HPNyYHiNgCxwAM5cr49FWaddMQLeZ+LkM8p5
         psE5D8koZRQcoKBxKJz9uBOqcQWBuOkiVrxTBlZpnMybzvhiXCCefTktt760h1PMvx9C
         sK2rK0MbG03ht+aqKl2DwtswGGXVK/OXgienxjKXXpUpc3cjvfzXjJnMvHYqfS+UbrS0
         p4TQMqIGzQB+Zpk5CFizYsNweyorONFCvyx/eGeEXRA2Jn1Bn7G4rfprgpXhrYyOuSKU
         +qIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mcIlsUlRWA8R2bRhqNCwo4VxPUlldtnIIs5QQzH+VdM=;
        b=XwljGbBJByyCIF3x3m1hpex7f4IiK6SDsZ+bj9wMps8QRRe67fRDvClmxKJn5Yy0QL
         Ku+1psnqzayMsRWkX4WnSQKN7S1lYSzVFB9GGwx7NPZlT4BWu3z96Gapb+TelIsohRZt
         lKH8amGM4g807DcvWnsptAKcEBhI1cAslaoypvrPvVzCfh2mDdsOCdGCVo5nhfHZX6Hj
         Tx+pgPUf37qni2TjtR5xdf/+6+QH3EGfb1ZelBxyfQfOtahHuKBPdz4PyIw5iYt16y40
         3kawuayxhwo5UdU0bxCQ9miArVg9rgpWfaCY6GuUeVS40ZSdyd9yUnmBrR/WBAXLh6X4
         k3lA==
X-Gm-Message-State: AOAM532FxHApOStGxCAQqXrjnmNHgvVoW1UpUuzGsoQRkVtLHlYxtler
        8glq8aDQvSAJIw3Vm86ISbZ/Cw==
X-Google-Smtp-Source: ABdhPJyhyEq7ilgqMPTLjI+0gFzTaPc0GBIO7mIyQ4jjFxKAyR0tWDIG4TgI16TCFIg1qq39tOSJTA==
X-Received: by 2002:a37:8605:: with SMTP id i5mr22494293qkd.216.1614110785804;
        Tue, 23 Feb 2021 12:06:25 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:29df:918f:599f:2c96])
        by smtp.gmail.com with ESMTPSA id u133sm15730884qka.116.2021.02.23.12.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 12:06:25 -0800 (PST)
Date:   Tue, 23 Feb 2021 15:06:22 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Martin Fick <mfick@codeaurora.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com
Subject: Re: [PATCH v4 0/8] repack: support repacking into a geometric
 sequence
Message-ID: <YDVgPtkaTb9zNq0/@nand.local>
References: <cover.1611098616.git.me@ttaylorr.com>
 <xmqq7dmz5iw5.fsf@gitster.g>
 <YDVM9U7zLstNBVq2@coredump.intra.peff.net>
 <1724378.IzK8VI2DXP@mfick-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1724378.IzK8VI2DXP@mfick-lnx>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 23, 2021 at 12:54:56PM -0700, Martin Fick wrote:
> Would it make sense to somehow detect all new packs since the last rollup and
> always include them in the rollup no matter what their size? That is one thing
> that my git-exproll script did.

I'm certainly not opposed, and this could certainly be done in an
additive way (i.e., after this series). I think the current approach has
nice properties, but I could also see "roll-up all packs that have
mtimes after xyz timestamp" being useful.

It would even be possible to reuse a lot of the geometric repack
machinery. Having a separate path to arrange packs by their mtimes and
determine the "split" at pack whose mtime is nearest the provided one
would do exactly what you want.

(As a side-note, reading the original threads about your git-exproll was
quite humbling, since it turns out all of the problems I thought were
hard had already been discussed eight years ago!)

Thanks,
Taylor
