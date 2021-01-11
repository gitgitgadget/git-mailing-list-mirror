Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,BIGNUM_EMAILS,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7323BC433E0
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 16:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27FB0208D5
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 16:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732237AbhAKQbZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 11:31:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729530AbhAKQbY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jan 2021 11:31:24 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D53C061786
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 08:30:44 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id p14so15056700qke.6
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 08:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cX089PAiK9AQNVapNrcDn+Wu6ejZOJM47s2Jvqol3y8=;
        b=vmmOipNsZx+vYO9op4xs4aiGKUxCucrZNrWRiOax+1VAGWaRtMLbFmF6bamFqEDVgl
         Y7JmXer0Q0cmzT6X2nBZtRFTO4X0KYIT3t2MPQ1TyyxpzQuWd7kfRbrcPPgfMFjUh0DE
         cGZElQ7iYq6mZvXIgea9WJuJHctlN0unaxZdcUFBVbNZQxfBBaQY29MDyqUkwbVzVvBc
         wnoR+PE7fXqHMboGmCKRU4dOQplHqcsrUecCmuema7JFAQ2iWtAy9BmGCzs1qWddHBRC
         UBXFV/vS4uPMJs1CtU/Slv8amod6UWeSaUFfpGg5SEfM03GC7gP0llFuvtAHLtC07k7P
         1KXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cX089PAiK9AQNVapNrcDn+Wu6ejZOJM47s2Jvqol3y8=;
        b=qym7EVlzMB5g/6Fn3bouHsoU9Yd4MSqSp7c2HYt2C9ODPjrZ1RQ7ACRzyYoSFsMBhX
         PF4sbP95UL5jwwP0vBN+1EaPK0zalwUEeuPRX+6tMzxLoW2XrKrzk01TpFhSjcMsEnNE
         U2vZHJPdIlJYphVpJ4Y1b1Zq3IkCtUwUDN1pkowh1wNzkj78xXszLGP2OH0C8o0pz7Go
         Vp76LO8LNk3yJOwUxX4+xsYJrHDcWI8T/hMnkuv8XMErkGQe7+wnuT5BUuYxPeebJjR+
         u+QSq7PfMBv4kt8BoefaWvJhj5AMeRmlIB0jSMELBLtj4aMojhfvqsLs3CLYEzeilsqi
         u8jw==
X-Gm-Message-State: AOAM531wY/ei1UNQFCbhrj2oS2kfds3DCjuIprTXYIClfN2Qg1zspkKy
        egkG9XuiCRI5p0THaWuWgSr1rQ==
X-Google-Smtp-Source: ABdhPJznsaot64GIiadteYk2ysABgj0uAK6gkEaVtIs6Vc+N7a2dmEMqsqSIaV30eIv7vFvDSLMjxg==
X-Received: by 2002:ae9:e909:: with SMTP id x9mr129766qkf.166.1610382643797;
        Mon, 11 Jan 2021 08:30:43 -0800 (PST)
Received: from localhost ([8.9.92.205])
        by smtp.gmail.com with ESMTPSA id v4sm34775qth.16.2021.01.11.08.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 08:30:43 -0800 (PST)
Date:   Mon, 11 Jan 2021 11:30:40 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        jrnieder@gmail.com
Subject: Re: [PATCH 00/20] pack-revindex: prepare for on-disk reverse index
Message-ID: <X/x9MMv4hBZMGKBT@nand.local>
References: <cover.1610129796.git.me@ttaylorr.com>
 <75ba9979-1a1f-de9f-c2cc-1433d30ed09d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <75ba9979-1a1f-de9f-c2cc-1433d30ed09d@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 11, 2021 at 07:07:17AM -0500, Derrick Stolee wrote:
> My comments on this series are very minor.
>
> I made only one comment about "if (method() < 0)" versus
> "if (method())" but that pattern appears in multiple patches.
> _If_ you decide to change that pattern, then I'm sure you can
> find all uses.

I have no strong opinion here, so I'm happy to defer to your or others'
judgement. My very weak opinion is that I'd just as soon leave it as-is,
but that if I'm rerolling and others would like to see it changed, then
I'm happy to do it.

> Reviewed-by: Derrick Stolee <dstolee@microsoft.com>

Thank you for your review. I think that I owe you some as well,
somewhere in the near-2,000 emails that I still have :-/.

Thanks,
Taylor
