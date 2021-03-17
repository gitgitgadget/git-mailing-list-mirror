Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DB4C433E0
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 22:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CB1364F53
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 22:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhCQWQA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 18:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbhCQWPf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 18:15:35 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08884C06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 15:15:34 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id t20so262495plr.13
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 15:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qvuRRaAwz6v+XBWmz/EKYHImV+/wsh03Yprvdeg4n9k=;
        b=pIcz4qVOsVkE0/EwfGAB9ihZrNYNm4HSwpyENajng+Ff+0csisAAyNOnti1qa5/Elu
         O0ByqXP3shwkE9r92pnDriekhpr4k5qjUCi8SXyMymQ1Yefz3KsyibQS7JohQYeRPHkR
         SYBoHcATyC4uCQta0b63w9J3Szvrlnuc1tkxuLHzJkprsd4Z9L7VvLYj6TnRPT1YGzNm
         BHjIcIckq4d/T6x6zdmo7pYSYCG2LTNBOFnE5Ig5E6cYS/Tslut8VD8TCaqRU+Nl7JEE
         wfFTAQ/uE+ujU+8PTHnt6del1WSdiKFva/VzFt+8Q/q18Qn2snxnHTdiCLWV6OO+vbmt
         iqsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qvuRRaAwz6v+XBWmz/EKYHImV+/wsh03Yprvdeg4n9k=;
        b=aX9cslgG9dQt41/SPeNSVwjW8nJudAUBGSfWFpPrNIZCPBf13/CnFbGBu2f8vQJtih
         6Bc4ReTXwouGrRPqYFIsdM6Kp9egALdFguxQ5Exwbb9VTVP42RFyJqHh6P4B7i6iAlYv
         r0upZywivESZ86/ft94oIP8xg1T1c5nwTaQMIEALAnFvY2ShJXZR7B6pC4gDBiArnsDk
         zQ7xMNV2pwVB5uSDuEtpVEeVI0DojTX98J5Mg1kA7V7l7ErWlP2dnMpkEgLz9IF3rDkj
         uITZiIQwmIyu3YBB5lS6c1dPuMefGDRdG1BY2iC2DUb08cNqAHpFSckvX3ukCuejCP4V
         uGfw==
X-Gm-Message-State: AOAM531rnBLRStwH31G87K09W8jT2f0ii7heX2iRWGvhdPkDoUWHjOc4
        TKtbWbvAza8WiRq71e6y0pII0iIMU3o=
X-Google-Smtp-Source: ABdhPJxJOAQz8AD182Pjzp3kMVlchgqHiHDQ9FCn87LGYfgmgc9aWWq7GrMIcotFs4oJoBIt/QAvbw==
X-Received: by 2002:a17:902:bd06:b029:e6:54ad:519a with SMTP id p6-20020a170902bd06b02900e654ad519amr6447201pls.52.1616019334219;
        Wed, 17 Mar 2021 15:15:34 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:5131:e9a2:44f8:45ea])
        by smtp.gmail.com with ESMTPSA id m4sm82957pgu.4.2021.03.17.15.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 15:15:33 -0700 (PDT)
Date:   Wed, 17 Mar 2021 15:15:31 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Eli Schwartz <eschwartz@archlinux.org>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Drew DeVault <sir@cmpwn.com>, git@vger.kernel.org
Subject: Re: Regarding the depreciation of ssh+git/git+ssh protocols
Message-ID: <YFJ/g2N+s1V3/qMo@google.com>
References: <C9Y2DPYH4XO1.3KFD8LT770P2@taiga>
 <YE+ftT2WaKDzc+45@google.com>
 <C9Y4NXXX6HRI.1IROIK8ZXK4S2@taiga>
 <YE/ZSiuIsMs3ucVM@camp.crustytoothpaste.net>
 <C9YD4AEUH84L.29FP64NJJ1BPU@taiga>
 <YFADuptwV7iR76g5@google.com>
 <40740478-8b3c-b33e-8bb4-a2d68b83d385@archlinux.org>
 <YFCckC8fHmEyOAnp@camp.crustytoothpaste.net>
 <8fed0d1f-a2bd-131c-5552-e95216b43474@archlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fed0d1f-a2bd-131c-5552-e95216b43474@archlinux.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Eli Schwartz wrote:

> I'm not especially attached to the proposal. I'm a maintainer for one
> of these package managers that currently special-case git+https?:// and
> rewrite the url that git sees, which has worked adequately for a long
> time.

This is useful context.  What URL forms does this package manager
support (e.g., do you have a link to its documentation)?  What would
the effect be for the package manager and its users if Git started
supporting a git+https:// synonym for https://?

Thanks,
Jonathan
