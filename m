Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5673C4332F
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 02:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbiKHCyz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 21:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbiKHCyx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 21:54:53 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876BE1B9C6
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 18:54:51 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id s10so8647226ioa.5
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 18:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zJPU3K7TE7A49Fo64Kpa5i/LW3Lw8RzTfvD9Q4b4wOY=;
        b=S7MzdHyI3PM4PnERo90yuXAfJSEyW6KTtxXSIiUTm6u7BJzafMz+70MD+C7RwXRHDf
         ii/iNxEkgWuTdFXrh+VEAwG5bdeLU0uylYuBkpXRvaqxgp4pMnHOe/GKaN2jgoKuhRWm
         e50vPB1XQyUmmgcWdNajjJmhj5kIt15qEp2LkH9DMntxeu1uGRWrmnJcfceRf8Yf6Qwj
         ujVq2Ef6k6SWd3ZgMoMeJAAq9AVaA+OAUJg4c4KWxPBSU3V3Y5CUhAsdhDThepjEvGWq
         YjJxj4uprZAfpT2p861c1O4cIZtG4um9NG1Z1rcRyLQbOjXLA2iUED6cr8Kt92/0I3iQ
         Qetw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJPU3K7TE7A49Fo64Kpa5i/LW3Lw8RzTfvD9Q4b4wOY=;
        b=ZP+Xn9Q19h1/tTiaFh+BGjfM9j6PKS6+7GCfWQThaOrydFjZPQUIwirtDxwOu32xvi
         YcFk7IYM2mWmz6XcDG9Oyfl8uSoPZ5YScjzeByq5ZXNmhxB3kiTLSr1FdH0zeaUBc8yw
         zkA/b/DuD22WjSu47YA4ecA4I+hohZEahVKIJoGagaV8D7kXJ4BWEp6BCRygDhXiv+Xv
         wzFuUVF3xdingUfRbkvtPlzm7UAHbnTlJ4sj+gardnnEFYaszmOoqFxW3KpC3xMj6zv3
         Sab3iecGoSoa5gj5xxq9vwx6tR5WZZ8cwl6G7H+U2OooJlv1z4aDUFdSBG5pqBtPgcQ2
         oLQA==
X-Gm-Message-State: ACrzQf3adMq8jE2RCbCQJ77Boc3vNj0aVCV374cDGviDpQOobddKFNtX
        PN1Hu8MNe88Munto3nTGIGpLHmVFktEOWA==
X-Google-Smtp-Source: AMsMyM70k62SyxZjn9v+mPx8DRcMghi24fKVVT0gO+L9SKz7qiL325tqmnjCqPSggEggCB3tEw3AyQ==
X-Received: by 2002:a02:ab86:0:b0:374:2da8:ed19 with SMTP id t6-20020a02ab86000000b003742da8ed19mr30039479jan.213.1667876090866;
        Mon, 07 Nov 2022 18:54:50 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z23-20020a056638215700b003636b73cf29sm3370969jaj.8.2022.11.07.18.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 18:54:50 -0800 (PST)
Date:   Mon, 7 Nov 2022 21:54:49 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Vincent Bernat <vincent@bernat.ch>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] ls-files: fix --ignored and --killed flags in synopsis
Message-ID: <Y2nE+Q1NH6wvqk5W@nand.local>
References: <20221106073445.47789-1-vincent@bernat.ch>
 <20221106073727.48405-1-vincent@bernat.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221106073727.48405-1-vincent@bernat.ch>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 06, 2022 at 08:37:27AM +0100, Vincent Bernat wrote:
> Signed-off-by: Vincent Bernat <vincent@bernat.ch>
> ---
>  Documentation/git-ls-files.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks, will queue.

Thanks,
Taylor
