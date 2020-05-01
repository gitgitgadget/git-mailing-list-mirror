Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4DDC47254
	for <git@archiver.kernel.org>; Fri,  1 May 2020 22:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51A062166E
	for <git@archiver.kernel.org>; Fri,  1 May 2020 22:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="zw/pLxwL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgEAWkH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 18:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgEAWkG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 18:40:06 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BE9C061A0C
        for <git@vger.kernel.org>; Fri,  1 May 2020 15:40:06 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id t7so4141111plr.0
        for <git@vger.kernel.org>; Fri, 01 May 2020 15:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WXMc7At7mbFPYiTBcOzzeL+qtS73zOSewVuJBiYQTMs=;
        b=zw/pLxwLtqkxCoZQLeJCCULhQV2K9ceAd/tJVTj7oqQ1mdsVrxTfsDTJpUEhuzZQZF
         PQA5nvplXK4O3NUSKCUOO+uNWoE0VlGzIF7MQJn8m0PzUVKCyz6qvwoMxT3O+ulRatgz
         p7JG3bBEFiPsRf+a4SjVYMbVkIO+Grf43XyYX3ByBM8MxTAVUQVt5ali6RamC+cKVk4Q
         M9bnqhQqb3dOddV5BdsUJBjinTEHfIfRVt4gkQUl+ZijF9agx5X/37adKJxpJRO5UC2x
         fYiX0xX19o193NMD/CKYZae4qBUBxI9xDJlD5NlyL7brFRo6Y+pwRWNaSOdyq+jbcpFj
         8SxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WXMc7At7mbFPYiTBcOzzeL+qtS73zOSewVuJBiYQTMs=;
        b=LImx2pRR1TuYOCysmhfQk9RoUuwOe541KWsPbKmi8Cs8fUAwM86hgyKQVswj0PPXK7
         iSmPozMD5QFUO4SeSORyj1ZHrObE0UZ2CKJEqefHxxzQG4NwWloVyvJlCkq1gfEvfkSN
         5WPhhnEeVsvTQALVzOdGG5X81jzPJrYYigxW6o1tensKvVORXXdEXoLNUY0MJcJrLt6t
         eGLwL4bR5qKSEPUfgPMUmvjjyHazlHGa33UpYqfBSTal4OopgZ3XRThlS4Wglo5mSkMR
         c2uwD2fNmaaAsev6DTl4FVeAbDzyW+A05b+e0DemrFIc2iZdkanEVsqZQ6x/w8XMOkUT
         hpXQ==
X-Gm-Message-State: AGi0PuaOGjPNRXImiRhXaO8ZGM0lTUpMyNGdCAwBLGOohjC9PIf4NUyU
        bzMOUyOanypD7aIvp9z4txQEBA==
X-Google-Smtp-Source: APiQypIShtbpXUWwdIwlITsQFoemvv6XVo9SgSkDJHhW63tgmsl/fP4R/IrlHfMc7OpOpNUCyEHc8A==
X-Received: by 2002:a17:902:32b:: with SMTP id 40mr6478205pld.73.1588372806386;
        Fri, 01 May 2020 15:40:06 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id k12sm2828880pgj.33.2020.05.01.15.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 15:40:05 -0700 (PDT)
Date:   Fri, 1 May 2020 16:40:04 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2020, #04; Thu, 30)
Message-ID: <20200501224004.GA45288@syl.local>
References: <xmqqmu6spocm.fsf@gitster.c.googlers.com>
 <20200501202411.GA41612@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200501202411.GA41612@syl.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio,

On Fri, May 01, 2020 at 02:24:11PM -0600, Taylor Blau wrote:
> One thing that may have been passed over is my series to teach the
> bitmap machinery how to quickly interpret '--filter=tree:0' by
> discarding non-named trees from the result set. That is here:
>
>   https://lore.kernel.org/git/cover.1587597151.git.me@ttaylorr.com/
>
> This didn't get much review outside of from Peff, who wrote some of the
> patches, so I'd be happy to re-send it or wait longer for others to have
> a look, too. For what it's worth, these changes are fairly
> straightforward and we have been running them at GitHub (and allowing
> partial clones with `--filter=tree:0`!) for some time now.

At the risk of nagging, would you like this one to be re-sent, or are
you feeling OK about picking it up?

> Thanks,
> Taylor

Thanks,
Taylor
