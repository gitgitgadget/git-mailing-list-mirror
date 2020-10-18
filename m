Return-Path: <SRS0=h2Q9=DZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 113A2C43457
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 04:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDD432063A
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 04:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="hxcLKX+Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbgJREWs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Oct 2020 00:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgJREWs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Oct 2020 00:22:48 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6EEC061755
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 21:22:47 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id t12so7105108ilh.3
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 21:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UYnSs+gnDr0lnsD96+VBDBbQ+ie4zVofszdh980F50Y=;
        b=hxcLKX+ZVWoWyKhGf+kaoq0Es/EafqUoN5H5Latius4002BtqlyQM92p6P5+QoKXs0
         1a2UCBaAcMQAKyWWpZpij4jnoW+eNNxpnv1qDskVOfy24U+wRcX3n+OStxxZvjRNOpuP
         g3D7XPjFt8I+78ldiKGgr2X727pxYJhplrbcvdtZEsVpWvrWefuNGIidWXuZ/jaufVn3
         KenxO7RG5QoHTH8W3X1DT+t8vwD5uI+VuisV/xo2wBKUZkzHj3yDANS+PS61mEuRLAZZ
         5CEtNu7Dlfg882BsCSOKNXZYbY0I1WEV85kF3E1JeVVDegDLhceVpzpgtoU3W6gtHk47
         SVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UYnSs+gnDr0lnsD96+VBDBbQ+ie4zVofszdh980F50Y=;
        b=CmFuM+ZPFe+4knjN6y2FPqlaTG8+pwKZ24YIOI8TfbqPD/pHlDegb6vH5PQF5HN+qL
         IaR1P9qXwPckEDGu/1v18RD5LU62ssVSY/dCf7sx6JPcQ/a/1jGNWVFYAa9dZumDkzni
         AKwOmCQOHWXEWEfI8b7TPbRTJEuS8lpxNbiSckNaAAp8u2KdfAZ9U4s3ChpOoRkSd9q7
         K/oII8YaUmeVaqumaDfxa3UoFAnRTIrbWz01IZq7+yzNTJYPGsldJqxipP2oKROe5jE1
         KnurPvB4f1kWsRL/hq/x1qB2vUln7+ctZ4GPcu0ErXsiWX9fLVafK1rX62H4UJ01iYIq
         mvCQ==
X-Gm-Message-State: AOAM533GAV44zWCOSGVlP8pIbWtc/TppxH5ga+3Rq9GfZiFVEMBuSwpe
        R9lsU+JlUiUTSzU1NZeRUuh5ig==
X-Google-Smtp-Source: ABdhPJxV2KEFFbLsddGNmDeDt/yV7/2d0OkUZuK6bhVTEl26vFKhzQjc7LuCor+9fcwpUnyXGhuXCA==
X-Received: by 2002:a92:3f0d:: with SMTP id m13mr7291880ila.31.1602994967188;
        Sat, 17 Oct 2020 21:22:47 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:150e:43c9:4c9b:f1fa])
        by smtp.gmail.com with ESMTPSA id z15sm7069662ioj.22.2020.10.17.21.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2020 21:22:46 -0700 (PDT)
Date:   Sun, 18 Oct 2020 00:22:44 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Nipunn Koorapati via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Utsav Shah <utsav@dropbox.com>,
        Nipunn Koorapati <nipunn1313@gmail.com>,
        Nipunn Koorapati <nipunn@dropbox.com>
Subject: Re: [PATCH 3/4] t/perf/p7519-fsmonitor.sh: warm cache on first git
 status
Message-ID: <20201018042244.GA2263679@nand.local>
References: <pull.756.git.1602968677.gitgitgadget@gmail.com>
 <6482e372bc0dca08efe9686b5b9e06a27a1d7a70.1602968677.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6482e372bc0dca08efe9686b5b9e06a27a1d7a70.1602968677.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 17, 2020 at 09:04:35PM +0000, Nipunn Koorapati via GitGitGadget wrote:
> From: Nipunn Koorapati <nipunn@dropbox.com>
>
> The first git status would be inflated due to warming of
> filesystem cache. This makes the results comparable.
>
> Before
> Test                                                             this tree
> --------------------------------------------------------------------------------
> 7519.2: status (fsmonitor=.git/hooks/fsmonitor-watchman)         2.52(1.59+1.56)
> 7519.3: status -uno (fsmonitor=.git/hooks/fsmonitor-watchman)    0.18(0.12+0.06)
> 7519.4: status -uall (fsmonitor=.git/hooks/fsmonitor-watchman)   1.36(0.73+0.62)
> 7519.7: status (fsmonitor=)                                      0.69(0.52+0.90)
> 7519.8: status -uno (fsmonitor=)                                 0.37(0.28+0.81)
> 7519.9: status -uall (fsmonitor=)                                1.53(0.93+1.32)
>
> After
> Test                                                             this tree
> --------------------------------------------------------------------------------
> 7519.2: status (fsmonitor=.git/hooks/fsmonitor-watchman)         0.39(0.33+0.06)
> 7519.3: status -uno (fsmonitor=.git/hooks/fsmonitor-watchman)    0.17(0.13+0.05)
> 7519.4: status -uall (fsmonitor=.git/hooks/fsmonitor-watchman)   1.34(0.77+0.56)
> 7519.7: status (fsmonitor=)                                      0.70(0.53+0.90)
> 7519.8: status -uno (fsmonitor=)                                 0.37(0.32+0.78)
> 7519.9: status -uall (fsmonitor=)                                1.55(1.01+1.25)

Note that you can directly compare results with the perf suite's "run"
script by passing two revisions in addition to the test that you want to
run and have the results aggregated side-by-side.

In your case, you'd want something like (within the t/perf directory):

  $ ./run HEAD . p7519-*.sh

where this patch is the uncommitted state (alternatively you could
compare the two revisions directly in the case that you have already
committed).

> diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
> index def7ecdbc7..9313d4a51d 100755
> --- a/t/perf/p7519-fsmonitor.sh
> +++ b/t/perf/p7519-fsmonitor.sh
> @@ -114,7 +114,8 @@ test_expect_success "setup for fsmonitor" '
>  	fi &&
>
>  	git config core.fsmonitor "$INTEGRATION_SCRIPT" &&
> -	git update-index --fsmonitor
> +	git update-index --fsmonitor &&
> +	git status  # Warm caches

Seems reasonable, and the comment is much appreciated :-).

Thanks,
Taylor
