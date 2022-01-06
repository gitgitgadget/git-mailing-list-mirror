Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50D0C433F5
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 22:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245266AbiAFWuy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jan 2022 17:50:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245281AbiAFWuw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jan 2022 17:50:52 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D935EC061245
        for <git@vger.kernel.org>; Thu,  6 Jan 2022 14:50:51 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id f9so3082413qtk.3
        for <git@vger.kernel.org>; Thu, 06 Jan 2022 14:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PExsHUBQclPWZV4U5p5UvtGwMhziPw7dzdwsTLEe32s=;
        b=58HukrpSFLOL5M4/CBNrR0w35YL5V8ZrlKtyYqaX1cGoKkEAd5/+oHSgodkGy83y0v
         VpkHYxeM1XAO0Yw0V3Br616aA/gf7T4ol+F97kWpJJYIdtIFFNsHvsmMUe7ONDTOqBPY
         O8aRZFBi3oScvA/sZVFM/KsuxpL0gxWqnO5mmAGhJLHlPUUZlOB8eQSrFuXFMcsjCX78
         ycB+w3lE6rQwRFMcYJnIFZTtSMb5jwMxWNLsbjyw0AEFNGV8FtuuRTX11jUQFCZ2zI3n
         syanDbA3qOKvCkSUR0FqzU65qX5jABMpqgRKTor2p8Sv/LJUDSjXa2WAlGNtdosTwu8D
         JSHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PExsHUBQclPWZV4U5p5UvtGwMhziPw7dzdwsTLEe32s=;
        b=yhm02dRFyc0mekFIXXkJsBa/4AohQevkuAsFbU14R2KI1krSeN0N8Y2VroUpHWbhuU
         CPJfrzKeQFJmVHraXmrg2S4+ts4ZZuJ01xtKYDbGkz9masbi/gttwAeHYU+oNUBk/17Q
         YYgzVmBdJy4G4tXBZblzane0vGLgeAGtpkvQGOWbBRP4rNmX9lCFrjNJajnGl8H4jDHN
         0RMDx4dfm1wWqXcawnwFVIR7J/NJ8qr/4LdT02Yd1n6hYQyz2GItPNC1TbxFnFIVmm6Q
         mdd6DgyJjkTvGu1CWx6Kr7Oq30WCCehtpOwpKi5zeQEzVsd0tdjCbaka9Om1V+AqlEYX
         wztg==
X-Gm-Message-State: AOAM531P7NS2csGRsj0LlYuzj2qhBuNfQgbfhvuwP5uP2EhOfQY6yk0x
        KPU0DVxQ0CRh9Y+9deA3KhJgEcRAL27htg==
X-Google-Smtp-Source: ABdhPJzhTjVguLrQyImUfocVZ/jIAAPNWlF83Tcto4RsKsZuI2YosvdL2l6mw58tc37rgorYpq2FBA==
X-Received: by 2002:ac8:7d07:: with SMTP id g7mr53917531qtb.364.1641509451060;
        Thu, 06 Jan 2022 14:50:51 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h19sm2592782qth.63.2022.01.06.14.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 14:50:50 -0800 (PST)
Date:   Thu, 6 Jan 2022 17:50:50 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jessica Clarke <jrtc27@jrtc27.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] apply: Avoid ambiguous pointer provenance for
 CHERI/Arm's Morello
Message-ID: <YddySiBCOOYYKDmC@nand.local>
References: <20220105132310.6600-1-jrtc27@jrtc27.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220105132310.6600-1-jrtc27@jrtc27.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 05, 2022 at 01:23:10PM +0000, Jessica Clarke wrote:
> [...] In most cases this is clear, as normally at least one operand is
> provably a plain integer, but if both operands are uintptr_t and have
> no indication they're just plain integers then it is ambiguous, and
> the current implementation will arbitrarily, but deterministically,
> pick the left-hand side, due to empirical evidence that it is more
> likely to be correct.

Wouldn't a simpler, less invasive fix be to instead write the expression
so that the left-hand operand is a pointer? IOW, shouldn't the following
work (with no other changes):

    ent->util = (void *)((uintptr_t)what | ent->util);

?

(I dropped the explicit cast on the right-hand side, since ent->util is
already a uintptr_t, and the left-hand side has an explicit cast, so
there isn't any type promotion going on here).

Thanks,
Taylor
