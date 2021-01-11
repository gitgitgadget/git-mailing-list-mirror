Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B4CC433E0
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 17:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E37C422AAD
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 17:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389388AbhAKRa1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 12:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732644AbhAKRa0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jan 2021 12:30:26 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466A0C061786
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 09:29:46 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id h13so11778qvo.1
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 09:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6I8JpnrszRP5/ddry1xSY988g5cca4RtiBjFbw9F2fA=;
        b=L0yvM4gWW3GSfzvlFGwNxdRLNhuc6eqFWkOxavmEG+xHdCCwJL3fcX0TciRbHG9cK8
         qsPpIO5YVE+1YozZEWEYL7aLswwzhPnuZ5JjW8vh7Tqzy1GzCOYk2k3I8ckobQUCiqwS
         Bga59nBDc8jvzaUdIAiz1Spolr9nW2HWeQkB+SF7YD9T074FiuDNip4j9Beo3IqDJS7Y
         klx6LmY6M3KGdZptosLfmSc4Ry6T65Qzs+ycSNmMfsTkoaX3AC3FQPREXuz7nmy+JK0K
         PUwkYGmFXjaP2EGNDGcYZW9sA21bSh3jfZIAeSelZu4KLfWqJSrKNxLvpsK8SXdYq5J/
         H1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6I8JpnrszRP5/ddry1xSY988g5cca4RtiBjFbw9F2fA=;
        b=AwtsplJyhyoxWiNNeafA3E6mt9gacb3gLmKf/SZqYUxqozMU9KYFZGgi6adjYOQluo
         d51EuQXg4NexYj2AHAgsT1/otq93Fs+4GQX33ILz6pYjQxMgWVgOfQ1O1gZusdi0LJVc
         kzGJpNdGBQouZLvocqTENc0OT/+hMTbVXSWBA75VVve4xYJuR747u/WSij4wHVK8mke7
         bJRfbmMOvYpc3vXkDK76f3uAPLUwTC1mlsBiVD6sKfVCH4GsgJ32nD1ym2ThUmkByWbm
         GVc7XyStxn1+jbLUaEEC2qbTL1WL73YcyD4xqFQX9f+xqy64QFqXRcRSSd0YicZQpnWv
         lylw==
X-Gm-Message-State: AOAM531wJmPnertEgG0rSn8ogxlHbx6qPd1mAQLP/FsjGw32anLmpCMb
        isWQ3qh7KtS/zPElwaFKQokUyQ==
X-Google-Smtp-Source: ABdhPJxu4VsWgFOrInHtlTSFn6cdxcfDo5VkCb9q91WtciGAKVoe70LkK9H3CWt6MlGjxXeKk8dItw==
X-Received: by 2002:a0c:c242:: with SMTP id w2mr556734qvh.33.1610386185442;
        Mon, 11 Jan 2021 09:29:45 -0800 (PST)
Received: from localhost ([8.9.92.205])
        by smtp.gmail.com with ESMTPSA id n14sm142248qtr.9.2021.01.11.09.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 09:29:44 -0800 (PST)
Date:   Mon, 11 Jan 2021 12:29:42 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        jrnieder@gmail.com
Subject: Re: [PATCH 00/20] pack-revindex: prepare for on-disk reverse index
Message-ID: <X/yLBm0SSR82Tob8@nand.local>
References: <cover.1610129796.git.me@ttaylorr.com>
 <75ba9979-1a1f-de9f-c2cc-1433d30ed09d@gmail.com>
 <X/x9MMv4hBZMGKBT@nand.local>
 <7e56e831-c6d6-3454-94c5-b8e888497568@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7e56e831-c6d6-3454-94c5-b8e888497568@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 11, 2021 at 12:15:58PM -0500, Derrick Stolee wrote:
> On 1/11/2021 11:30 AM, Taylor Blau wrote:
> > On Mon, Jan 11, 2021 at 07:07:17AM -0500, Derrick Stolee wrote:
> >> My comments on this series are very minor.
> >>
> >> I made only one comment about "if (method() < 0)" versus
> >> "if (method())" but that pattern appears in multiple patches.
> >> _If_ you decide to change that pattern, then I'm sure you can
> >> find all uses.
> >
> > I have no strong opinion here, so I'm happy to defer to your or others'
> > judgement. My very weak opinion is that I'd just as soon leave it as-is,
> > but that if I'm rerolling and others would like to see it changed, then
> > I'm happy to do it.
>
> Well, I found 782 instances of ") < 0)" in the codebase, and my initial
> scan of these shows they are doing exactly what you are asking. So as
> far as code style goes, there is plenty of precedent.

Thanks for looking, I was curious about that myself after our thread,
but I hadn't yet bothered to look.

> The thing that makes me react to this is that it _looks_ like an extra
> comparison. However, I'm sure the assembly instructions have the same
> performance characteristics between "!= 0" and "< 0".

It should make no difference. Both comparisons will do a 'cmp $0 ...'
where '...' is probably an indirect into the current frame. The '!= 0'
will use je, and the '< 0' comparison will use 'jns'. Both conditional
jumps should be implemented by checking a CPU flag only (ZF and SF,
respectively).

Not that any of this matters, it's just fun to look.

> Thanks,
> -Stolee
>
Thanks,
Taylor
