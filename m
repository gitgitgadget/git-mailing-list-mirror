Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B56C4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 00:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 307D422D75
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 00:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbgLPAe4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 19:34:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbgLPAez (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 19:34:55 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F56C061793
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 16:34:14 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id w6so15532500pfu.1
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 16:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=Cuv0JfhoEH1uF78hUabZelZIb6JRKaK5k1DNR6Zk7YI=;
        b=RkBbe6pSHd4QOHSr5lymMWkm5+1nqQD2frA8Kwoh3ZFIzvxADJ6wji84KzeA2Y59B9
         UmuSgA/VoffV+o/WoQNlMHX+fvIohlp7evyNwtNELV6Uh3ABua1h8vePP/B+4hdC1Bf/
         4hb8i4gMBg234o9TSJxNVmt8f5VFDkAZMKcpdd0Gl/wqZBJZc7riFEYJbRBpgrJvsIXF
         eWxjBYzAaqNLiyj8PdO4pmXQvb84sEyDTqqrqMjeVRSHZz7f3pnUDYNYwQVtkSeEW2MR
         dPRsOmZ0i9253g3d7Jzvk+E8EzujF5rl+PmOcHi9mu621NMPtW920UUz41n4vXbtHQfH
         fC3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=Cuv0JfhoEH1uF78hUabZelZIb6JRKaK5k1DNR6Zk7YI=;
        b=K4Bhcx7FvlDyXMJeArg+FN5Dw4mXyc+wk2YnL2SJKEljcf+nosjhypbNNPra3JYwo+
         3AjJ5MdZU6GSJWHTrRgZYNgN24nl63+bt3wlJPaS3D0CTyGcgfsQff5KlrkcA3ah9pNZ
         oqBjCVWdoLPPqnApKF/EbIMeU8ZcyP1QXikiZVmkg/uK+i7g9OL4yQx+zu3M04y+4s6A
         LkjbnC5Mi98ANYmcHkQdnOASupnchkSI9YxRKzFMHfDzyFe4CntLkf/Nh2EkP/jqBgHo
         hxxZx6ie8MhleB88u18mIWsDAqIUQAfBkcqcjNa+vjBLgNYdPR0ClQkJRs4f2rBKNzJn
         3e7A==
X-Gm-Message-State: AOAM530fiCJOghO0BrSZgE2EAQa2WkWTpmgetqT720zFn/yEAnDNc08x
        S6Or9u4R5M30hNtk3JYqRP5RUg==
X-Google-Smtp-Source: ABdhPJw4tn3Cg+qvFQ+sGaucgKChHFUHNvh+6EP6nvPDTnLCUZuYeQqq2iKmbt5wtPnzh0lGwSnRMw==
X-Received: by 2002:aa7:9ab7:0:b029:19d:ac89:39aa with SMTP id x23-20020aa79ab70000b029019dac8939aamr23682170pfi.10.1608078854435;
        Tue, 15 Dec 2020 16:34:14 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:1ea0:b8ff:fe74:b4c1])
        by smtp.gmail.com with ESMTPSA id p187sm157249pfp.60.2020.12.15.16.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 16:34:13 -0800 (PST)
Date:   Tue, 15 Dec 2020 16:34:08 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        James Ramsay <james@jramsay.com.au>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v6 00/17] propose config-based hooks (part I)
Message-ID: <20201216003408.GR36751@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        James Ramsay <james@jramsay.com.au>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20201014232447.3050579-1-emilyshaffer@google.com>
 <20201205014607.1464119-1-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201205014607.1464119-1-emilyshaffer@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020.12.04 17:45, Emily Shaffer wrote:
> Hi folks, and thanks for the patience - I ran into many, many last-mile
> challenges.
> 
> I haven't addressed many comments on the design doc yet - I was keen to get the
> "functionally complete" implementation and conversion to the list.
> 
> Next on my plate:
>  - Update the design doc to make sense with what's in the implementation.
>  - A blog post! How to set up new hooks, why they're neat, etc.
>  - We seem to have some Googlers interested in trying it out internally, so
>    I'm hoping we'll gather and collate feedback from that soon too.
>  - And of course addressing comments on this series.
> 
> Thanks!
>  - Emily

This approach looks good to me. I'll look forward to seeing the updated
design and the feedback from the internal tests.
