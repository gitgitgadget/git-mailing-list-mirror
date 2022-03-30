Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483DCC433F5
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 02:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242092AbiC3CqL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 22:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239261AbiC3CqK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 22:46:10 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916C152E1E
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 19:44:26 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id g21so10093998iom.13
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 19:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=libYV18Tb3sMCpGCCv4Gfl1hGRIkkGqweZw7pLzeeL4=;
        b=LWAkgdE1N1EDljhKTdwHwIEZviSV3vK3XtHV8C9xr6DOw8kMbPm4DioCleOjZD29Dv
         B7BOs8+C9M//xqNIL5q71oV5U4I2xKgmHuc67PKvyttozC5VTO1D6Eo2VenaZt8pDSlt
         bwB1Ds0rUOMY75xbWJ/cyChYFKaRy8l8srdfyfr6S97I10VluvlZIvadFmIoLEbYFraL
         P8bDLquWJ8kEEUoKhE0hEEV8XagA5XpRWfNqxBVkVjcV/ePAW+bzRBxidUdFvutwgRuK
         4cngKnyd3NFQyIhQX0M+Aalwmor38oTJEawTZWlO4tBITDoz6yudxvCvdIaAk7qKElSX
         vtEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=libYV18Tb3sMCpGCCv4Gfl1hGRIkkGqweZw7pLzeeL4=;
        b=ZycyxaHAlavqBFTEHtJipZSizUvPTgRSc/LFTBnC4S2SfEnbZE7zgJXXr1kL35hvmP
         pj25UrbemhoiZ7kafcDejC2xSP0zhbSldViibg8uB/KRID1NLLJH0NJKb8i2L6ToKh/U
         k38z7EL9P59U0mPaDBRa5H56mDePHfChjt9z+UN4JA6TH7OsP3xCqOD7u4XakQfUmUNS
         vc2nThVlEv5cJwh0FvU7YA02PpiZnPa9qOyMiehh89sShGGzB/4KXH3QJvvPFlsBBoTo
         8zoRXuIIgNqPVWFiDTgr69iAaA4yd5ABGLeROj8F0xec4zqlXwJhakS2s49ZlaswlOZY
         8fBQ==
X-Gm-Message-State: AOAM533GZNwmjIAqV6ibqvr7iM40zNJ1PUnbkVQ57Snt8zofr2c06wgS
        SiZb8HgVwp4aCUAjKXRi7NGifA==
X-Google-Smtp-Source: ABdhPJwHWBXptWaDeYJaW+c1ZQWMwnQCt9PIx+kWoXwTtqx5LfF1/82RWt+tu+VxsEFVFyhHd/XmKQ==
X-Received: by 2002:a05:6638:1410:b0:323:7682:25bd with SMTP id k16-20020a056638141000b00323768225bdmr4930415jad.45.1648608265916;
        Tue, 29 Mar 2022 19:44:25 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c15-20020a92b74f000000b002c9cc44ede9sm2481353ilm.86.2022.03.29.19.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 19:44:25 -0700 (PDT)
Date:   Tue, 29 Mar 2022 22:44:25 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        chakrabortyabhradeep79@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 0/2] test-lib-functions: fix test_subcommand_inexact
Message-ID: <YkPECUcH3zIU4nZW@nand.local>
References: <pull.1185.v2.git.1648146897.gitgitgadget@gmail.com>
 <pull.1185.v3.git.1648234967.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1185.v3.git.1648234967.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 25, 2022 at 07:02:45PM +0000, Derrick Stolee via GitGitGadget wrote:
> Junio discovered in [1] that test_subcommand_inexact is more flexible than
> initially intended.
>
> [1] https://lore.kernel.org/git/xmqq4k41vdwe.fsf@gitster.g/
>
> The intention was that we do not need to specify the remaining arguments for
> a subcommand, but instead the current behavior is to allow the given
> arguments to appear as any subsequence within the command (except that the
> first "git" instance must be the first argument).
>
> By changing the test that needed the helper, we can avoid the helper in the
> first place. Modify the test and remove the helper.

I reviewed both patches carefully, and this version looks great to me.
Thanks for all of your patience in cleaning up that sketch of the new
test; you version in v3 here is delightfully easy to follow.

    Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
