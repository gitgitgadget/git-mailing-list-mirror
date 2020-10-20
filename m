Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB47C433DF
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 02:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C9222244C
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 02:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="PsjZWWEU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730836AbgJTCkX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 22:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730782AbgJTCkX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 22:40:23 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C14C0613CE
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 19:40:21 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id z2so399707ilh.11
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 19:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jgZbWM/1lH5kKyT7bfNbOCz2l154MUkx0JlcDQVOGHk=;
        b=PsjZWWEULAg6+FK5cWPqqn3ZwoJ2fQuwjAmMdtc3m2cJ1EXs9mzNT2yiofBB/WSr7X
         M4PMVENh020G0bb5uWYVJAsS78jZZBLMyY1L4q87ZQFdwNjZR0SM1uaOxrySAmRHX1Ts
         Pu1L1luOEAB7dfzm9TEzfA3qvSZ5p7vQq3FUdxRXoix9XRDY/zvAFu6r0uyWDIOtTGwF
         o1wr+CuecUfLOJSyBq3ID7iaxBpWpx0kB3GvYGT6jaOvlL9frZID/ApcgY5BmchX4zv7
         XojFutZCAtagkZI7OSDVRHeXHQmm0uyCJQfsRQH8p+4Mdt21P4B65vjk0xNco64ewzHc
         k4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jgZbWM/1lH5kKyT7bfNbOCz2l154MUkx0JlcDQVOGHk=;
        b=YX8+mCDc6l2pv6fwBkmjL4KY+cNq+QDVhP3zKEq2bvLUn073hfWcNcKyAH9jfmSHPh
         /T9K0fUt9HNDSRkpzA0nhzRorqTMaAP/Q9EeHTXYCFYvsijDIPUwqO+qQQ/irdc/dgF3
         VvvAjJ4MQx7e1BuEa++5JME8L4s0Ii87JzGfYUaht+spmYOlKgwy1ru3WlHT9sQ4dDXL
         JF6SxtLwHhTYeJNhRXVfZRmv84CfUYM9qsFRtWJDDQjKIal0Yevwa0paK9IWXCcyN0M6
         bAXXw+cMqG1bXuv+yaJfvUKj5CSRuAWwcUBDgSYcfx/JZe4AcBVGqk/65AMeF5lTXo8h
         0Ueg==
X-Gm-Message-State: AOAM531/K6+2e6bPd/tO5dezP0jhFNLi9oI90+zwM88JlGqmYdquzi42
        zCKrwqP/GiwP2sAG9utm5wg1VQ==
X-Google-Smtp-Source: ABdhPJw42DAOho6+NfVyYtrQ78zKpwSFP+f9gf52iQ0LmkreuzOZnYBWKbqatk+4jqrjATK3gWs7nQ==
X-Received: by 2002:a92:1952:: with SMTP id e18mr353879ilm.189.1603161621028;
        Mon, 19 Oct 2020 19:40:21 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:943f:d0f4:e8b9:b8f9])
        by smtp.gmail.com with ESMTPSA id t10sm367733iog.49.2020.10.19.19.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 19:40:20 -0700 (PDT)
Date:   Mon, 19 Oct 2020 22:40:18 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Nipunn Koorapati via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Utsav Shah <utsav@dropbox.com>,
        Nipunn Koorapati <nipunn1313@gmail.com>,
        Nipunn Koorapati <nipunn@dropbox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 7/7] p7519-fsmonitor: add a git add benchmark
Message-ID: <20201020024018.GD54484@nand.local>
References: <pull.756.v2.git.1603143316.gitgitgadget@gmail.com>
 <pull.756.v3.git.1603147657.gitgitgadget@gmail.com>
 <d392a523f239f92f1b47ec1a96885f69fdc6d8b4.1603147657.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d392a523f239f92f1b47ec1a96885f69fdc6d8b4.1603147657.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 19, 2020 at 10:47:37PM +0000, Nipunn Koorapati via GitGitGadget wrote:
> From: Nipunn Koorapati <nipunn@dropbox.com>
>
> Test                                                                     v2.29.0-rc1       this tree
> -----------------------------------------------------------------------------------------------------------------
> [...]
> 7519.22: add (fsmonitor=)                                                2.26(1.46+1.49)   2.27(1.42+1.55) +0.4%

Good; no huge slow-down here. Thanks for checking!

> Signed-off-by: Nipunn Koorapati <nipunn@dropbox.com>
> ---
>  t/perf/p7519-fsmonitor.sh | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
> index 75a0cef01d..fb20fe0937 100755
> --- a/t/perf/p7519-fsmonitor.sh
> +++ b/t/perf/p7519-fsmonitor.sh
> @@ -169,6 +169,10 @@ test_fsmonitor_suite() {
>  	test_perf_w_drop_caches "diff -- 10000_files (fsmonitor=$INTEGRATION_SCRIPT)" '
>  		git diff -- 10000_files
>  	'
> +
> +	test_perf_w_drop_caches "add (fsmonitor=$INTEGRATION_SCRIPT)" '
> +		git add  --all
> +	'
>  }
>
>  test_fsmonitor_suite
> --
> gitgitgadget

  Acked-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
