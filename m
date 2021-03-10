Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E00C433DB
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 21:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7420364FB1
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 21:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbhCJV61 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 16:58:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbhCJV6U (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 16:58:20 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E78C061574
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 13:58:20 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id u8so19609586ior.13
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 13:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nfGiKWoR+1naGXouHLpSOH5e02KdHl/XWDYlzuQeZyc=;
        b=J2fPh+BcysaP033I7yRrdIgw0jeSjkTVCzLLnsI0r1Jg8U919dVSd2QIkf5mnKR55u
         bV4TWgwU2D3KKbIM9pi84+JOWI/SFSBZ+PUNRoiUW53tzSuwKm2STyOqG05xXzKiK3Ux
         uBi2Q4GtHvBdZ5uQSME1A6KtZynsz7T197HK0oFVkee9Zjo/pVcIpB30vTnUJSb5S/V4
         DxBcyE+TLhRNtTv+v40/QvGIenVqYK+7pJ+8rl+ESFvUmTo4SO6tqbifbXnM/deDRnQ8
         ZzEnegrOR1GsycjiFzePzTMMYZTq5V1WPWWjBVFa+9Wy5XqZHZM8Q7UlHB6wyiPybr0W
         WEPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nfGiKWoR+1naGXouHLpSOH5e02KdHl/XWDYlzuQeZyc=;
        b=qDDXG4+/g5GUCM0YD5jzZnBgGJZmDICHVbCdO6zUPWzG+NV5CPSnYHPlWBz7I+CUH4
         XoqTMu4Zm0esWvMtc+f0sEKkBSqIqLO/x5Mv5q9TPlp10LZ8IoQ1b7KnvKvP0PxN1Jtq
         2h5S3CuLrepM4T4NG+BcXQTvu8vLvRQOYeTe4VlZH5mSrJJv+j34a8v0oRVAqli+CYmw
         xsREjE1KmRGIIi/oO7idsTD66256QlnnBCZyd8+B2gRqzraMMVgTfIOq9ufckxPuNDF6
         BUh20xu6IG7j2Az6DKhzI+ae57P//mVzSg7ZQgxo9EEXrx9a/MRD3fcsnqPsgk22kAtA
         KCsQ==
X-Gm-Message-State: AOAM53390PfLzDWGZW6MxkrEPTgtGJ2LcEaGaHi30CLah9DzsgsVker0
        JFlbd7vWdzge7vSfY2FC4WaLyQ==
X-Google-Smtp-Source: ABdhPJyxagZZtBjgAE0as3cyFqQmUrYGKd+TUGn/jkBWsKkNXKxRMQE5pAihpi+by0Rk4GBUH2jx/w==
X-Received: by 2002:a02:c8d4:: with SMTP id q20mr596108jao.90.1615413499924;
        Wed, 10 Mar 2021 13:58:19 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:f947:1686:6ada:db5b])
        by smtp.gmail.com with ESMTPSA id c16sm338515ils.2.2021.03.10.13.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 13:58:19 -0800 (PST)
Date:   Wed, 10 Mar 2021 16:58:16 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 0/7] rev-parse: implement object type filter
Message-ID: <YElA+GI3oAZiueOs@nand.local>
References: <cover.1614600555.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1614600555.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 01, 2021 at 01:20:26PM +0100, Patrick Steinhardt wrote:
> - A new object type filter `--filter=object:type=<type>` for
>   git-rev-list(1), which is implemented both for normal graph walks and
>   for the packfile bitmap index.

I understand what you're looking for here, but I worry that '--filter'
might be too leaky of an abstraction.

I was a little surprised to learn that you can clone a repository with
--filter=object:type=tree (excluding commits), but it does work. I'm
fine reusing a lot of the object filtering code if it makes this an
easier task, but I think it may be worthwhile to hide this new kind of
filter from upload-pack.

> - Given that above usecase requires two filters (the object type
>   and blob size filters), bitmap filters were extended to support
>   combined filters.

Nice. We didn't do this since the only previously supported filters were
blob:none and tree:0 (the latter implying the former), so there was no
need.

Thanks,
Taylor
