Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34982C433DF
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 16:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CCFF2054F
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 16:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r2diDnkv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgHMQu0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 12:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgHMQuZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 12:50:25 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3CCC061757
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 09:50:25 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id u63so5633849oie.5
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 09:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=LOaYXSLa9nws5ZEGrbnvabYeqArjetzcEDorvbfQ4gc=;
        b=r2diDnkvAPZNWluXPqVw395GcCMeXRlPNiHvWeafIz4rS0ZqzKFl4MXFqW6YItwe1N
         efQjhEAVY0QG5TR5+mbQHKLpoTVr5hv6qwpRA7bDvaPpAqL/L3Ktp8WttPvrlHHE1C3f
         aGhD5HZld4pPP7zNWWTDNhBgpULlPlGQY63qwbj9Ts/0Ra0zdnmoDsjPZkBX6JwBspGr
         OIfC9xegDRFp2lP6pD6Vyq1YI+mZMxk1fWioia4FDye6PrSjCRkeOfNkYrWuaAi/7GOu
         Cvhs3R6BSxFjHSZxuEz/dbQDdpz2oj0TXCRQxvC3UuRc/KZQrRS2+xpXjEJDFsmV0Ioe
         kT7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LOaYXSLa9nws5ZEGrbnvabYeqArjetzcEDorvbfQ4gc=;
        b=EQ9LbpIKi+cSfoZqaZbO+5LJBR4+CWV9Pj30dHzeKjh8XXVs5Aoig2njLaBncQm5UK
         PGXzeaEVFCQNQ5ePgRJL3I2yw1nh/sB4TwFLuUZkMZvmocjXxeJilV11r1cb/saU+iq3
         +itcaGOpZ6UWZ7mo6Ci2dOzReCTMMYrUPkJYoVF67NT7ywt95LXz3ERRCR1yQinLj0IE
         aP+SNxexFi185VrhG6/pUwi0sZoXYCMDSa6akLkAovbuyRla75GEKZdRO9MYMyXON7tK
         hj4MVEgkCLADZQUDDG/6F5Sst+5xCol35Xi7FeiBZBbRP3RVYz+vTSnSP1xoygPhAvU+
         ZRXQ==
X-Gm-Message-State: AOAM5318t49BHqRBGKLQLs+z4Yc0JBr+OKW+Bqclw5IZfYu+8bdkPwth
        WTac78/FvpZXrvRRAMDSPj8X4BjFMdM=
X-Google-Smtp-Source: ABdhPJzrYp6CRhH+RkZECTVvygPTA6W/zfdPFv+o57d3V4NjnAN0B2lcFDwtygX6wsPyI/YT9Ho1HA==
X-Received: by 2002:aca:2306:: with SMTP id e6mr4204177oie.108.1597337424088;
        Thu, 13 Aug 2020 09:50:24 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:7dfc:cd76:faf5:aaad? ([2600:1700:e72:80a0:7dfc:cd76:faf5:aaad])
        by smtp.gmail.com with ESMTPSA id y18sm1224323ool.16.2020.08.13.09.50.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2020 09:50:23 -0700 (PDT)
Subject: Re: [PATCH] docs: commit-graph: fix some whitespace in the diagram
To:     Johannes Berg <johannes@sipsolutions.net>, git@vger.kernel.org
References: <20200813145053.43360-1-johannes@sipsolutions.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <6bd838fd-3fef-8a04-771e-7b9b372a65a7@gmail.com>
Date:   Thu, 13 Aug 2020 12:50:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <20200813145053.43360-1-johannes@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/13/2020 10:50 AM, Johannes Berg wrote:
> In the merge diagram, some whitespace is missing which
> makes it a bit confusing, fix that.

Thanks for noticing and fixing this. This must have been
due to some un-careful find/replace on my part.

-Stolee

>  			    +---------------------+
>  			    |                     |
>   +-----------------------+  +---------------------+
> - |  graph-{hash2} |->|                     |
> + |  graph-{hash2}        |->|                     |
>   +-----------------------+  +---------------------+
>  	  |                 |                     |
>   +-----------------------+  +---------------------+
>   |                       |  |                     |
> - |  graph-{hash1} |->|                     |
> + |  graph-{hash1}        |->|                     |
>   |                       |  |                     |
>   +-----------------------+  +---------------------+
>  	  |                  tmp_graphXXX
> @@ -223,7 +223,7 @@ file.
>   |                       |
>   |                       |
>   |                       |
> - |  graph-{hash0} |
> + |  graph-{hash0}        |
>   |                       |
>   |                       |
>   |                       |
> 

