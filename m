Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7054CC433DB
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 19:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16D9D64F05
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 19:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbhBESAN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 13:00:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233676AbhBER5G (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 12:57:06 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3332AC0613D6
        for <git@vger.kernel.org>; Fri,  5 Feb 2021 11:38:50 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id d16so8898456wro.11
        for <git@vger.kernel.org>; Fri, 05 Feb 2021 11:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JrSmtxZkAX7BPsesKmXfS+0HhCbYJJovl0POs6TwuR0=;
        b=V2onELFCcU0O1IOgpa+jimx4HghR0SsJwW9HnbmG2K2eO/hFfqdF2L//rvg7DY4y6d
         HS5qhNgYRFJPHR2H1YfU5H+HhszK057ioLIwbn1kYTaHxVsExAzG8ZftAQyaD0ym6Gt1
         ZWBJklO2GloHHxj8eKy1f41VNSKfJl9fyk/s/KVRyQfxjLPSdxTs9mom88c2CRN0fJBz
         NgV79AIwEGp99P+j57j2zhzr3nw8eLyHFW0XXmDd7sfoknJXkDcTVDhJ9Xtlzq8f5B92
         5x9LERikCyvHSWaQiqwk44rgdmuWyLAoczyp/L21Kb1yPdhYCT5INUx1iZ+cT7Jr1ttv
         Wmgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JrSmtxZkAX7BPsesKmXfS+0HhCbYJJovl0POs6TwuR0=;
        b=l3hbU6WWEhBvzPT4EP4NlCxCk4AqoqFQ/eQeKS7KHZSoUd5ltJBFTp81b/XaiLIcur
         q9iN2FaS+Wkc1OfjBK0EZ/SDVsG4c60bl5/N6Ej50cRwbZ+qgpmH55D5KQuQ0iK3f9OY
         A8huaC1HgaPtJxXpTyBMfuuCVrSeGytagX1bSywOOxL8LWXzJzC8K66ydyPvnqwUK0cC
         tJWs54SrDiqQIgJ1HHRUX40QjqYdOCNBuYHFfEXZL0g0QBKOS/F3NFbgCYQ7nrG9QwZH
         RRKDdlLZTDmiBInUd8H8nkXXW3H5X4tsWmEmmQ/PvFQzX5tA2+ejiXFVpT+4wiX9+4pp
         AVbg==
X-Gm-Message-State: AOAM530Awxe4uzHE4Tq/TQHxTvxL4Ahggep6mZIcoVX8o5LQe9INJuRW
        kyaVLin8eVYFWucEmItN5GSUuZAcLU4=
X-Google-Smtp-Source: ABdhPJwQfVyCqoTef7GIIXtKSs57EL7IfqKjjjNDkSXsOpVJhmHV4H3Oo2ngnlEuVhcY+W5P+1gyJQ==
X-Received: by 2002:a05:6000:1841:: with SMTP id c1mr6586711wri.278.1612553929058;
        Fri, 05 Feb 2021 11:38:49 -0800 (PST)
Received: from szeder.dev (62-165-236-114.pool.digikabel.hu. [62.165.236.114])
        by smtp.gmail.com with ESMTPSA id d3sm13879752wrp.79.2021.02.05.11.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 11:38:48 -0800 (PST)
Date:   Fri, 5 Feb 2021 20:38:47 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>, Chris Torek <chris.torek@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 09/14] simple-ipc: add t/helper/test-simple-ipc and
 t0052
Message-ID: <20210205193847.GG2091@szeder.dev>
References: <pull.766.git.1610465492.gitgitgadget@gmail.com>
 <pull.766.v2.git.1612208747.gitgitgadget@gmail.com>
 <f0bebf1cdb31f94cb111df100b3bcb5e2d93a91e.1612208747.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f0bebf1cdb31f94cb111df100b3bcb5e2d93a91e.1612208747.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 01, 2021 at 07:45:42PM +0000, Jeff Hostetler via GitGitGadget wrote:
> Create unit tests for "simple-ipc".  These are currently only enabled
> on Windows.

> diff --git a/t/t0052-simple-ipc.sh b/t/t0052-simple-ipc.sh

> +test_expect_success '`quit` works' '
> +	test-tool simple-ipc send quit &&
> +	test_must_fail test-tool simple-ipc is-active &&
> +	test_must_fail test-tool simple-ipc send ping
> +'

This test is flaky as well, and it did actually fail in CI:

  expecting success of 0052.9 '`quit` works': 
  	test-tool simple-ipc send quit &&
  	test_must_fail test-tool simple-ipc is-active &&
  	test_must_fail test-tool simple-ipc send ping
  
  +test-tool simple-ipc send quit
  +test_must_fail test-tool simple-ipc is-active
  test_must_fail: command succeeded: test-tool simple-ipc is-active
  error: last command exited with $?=1
  not ok 9 - `quit` works

> +
> +test_done
> -- 
> gitgitgadget
> 
