Return-Path: <SRS0=xqrk=6B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D55BC2BA2B
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 02:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBE54221E9
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 02:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXILvsJF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbgDQCYT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 22:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728969AbgDQCYT (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 16 Apr 2020 22:24:19 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE19C061A0C
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 19:24:19 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id g6so362221pgs.9
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 19:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o7pwkfpjbqBFj/tEJOYJPBcyeI5k7Fg+G6uvC64EtLs=;
        b=YXILvsJFvakFBtKQj+MCH35C1ErYuhoxChTXJE08jVFg51L9CJYO9G98nzfeVk4tdc
         ugd80J20hRXCsu+l8eAp/A/LMq9amcUsFj8bi00UjMJSrVhO0mR6tmeGft61GJPAhoaE
         DsOcpfq+N9f3S8us/6iy1XHjJZg+uTyVxv1YBIiNQbE86Zm28BjY7cvK5dbEuibpx+VE
         ZGQ2OrjpE3b31RmLHU3QTxn68SvCKWWWVzK+eUycRKnL8IyATmnw+vsgIwmEgrmGQdI0
         YAvzgjxfARWO8ZZISdmh7skXVknQYjHpYcz+fgmOtNuz2mL7IAD8qV/WCw5Uera4RlcA
         k9EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o7pwkfpjbqBFj/tEJOYJPBcyeI5k7Fg+G6uvC64EtLs=;
        b=GnGQpYdNtFjleBh8eOq82ADB/lKkLrVgXY5XaWnPRej9qG1EQlLGADneJm0kL8zXPO
         8d3rh9jIXE0CGdRVnfLRaDKYQ4FJYprNaiIoD8ysWEm1dcgKfeaxELjSfX+1wqdXEHp8
         z4SnYCTgoJvXTFLxkJbbvKM4aosTrqjaYzW83+EQnRPV5Lw4PFdpkV3yMiM4VqGZAILd
         mOQs689Eg3O0gaBjvbKrCADlJZp83qyoNUVLhbiurd0XByV7dUBSFh43vijW/D5XcXjR
         c60nryevyrN/6c/mrm0xRXcpSV25j520ZMw2dp9OHrEiT7aAqEq2QESusce1wdABvC4P
         Qjog==
X-Gm-Message-State: AGi0PuZ/oEiThrvl+Wy0NQcN7rsASs66OXqFZKHYmHVE7UepDc05EzFu
        eJLqXSvNjzjeZshgIsCc3ik=
X-Google-Smtp-Source: APiQypIVIiT5mwpCH8Ur/KCLBOHzOR18c5ePL4EH3MSGTn8Dgsgad76ncy4ZZ/0rO8LLYgP+ved7lA==
X-Received: by 2002:aa7:8b4e:: with SMTP id i14mr862952pfd.98.1587090258819;
        Thu, 16 Apr 2020 19:24:18 -0700 (PDT)
Received: from localhost ([2402:800:6374:5380:b9e1:93e1:68db:b9f6])
        by smtp.gmail.com with ESMTPSA id b75sm3995268pjc.23.2020.04.16.19.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 19:24:18 -0700 (PDT)
Date:   Fri, 17 Apr 2020 09:24:16 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2020, #01; Wed, 15)
Message-ID: <20200417022416.GE2285@danh.dev>
References: <xmqqr1wo4alb.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr1wo4alb.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-15 16:01:52-0700, Junio C Hamano <gitster@pobox.com> wrote:
> * dd/iso-8601-updates (2020-04-15) 2 commits
>  - date.c: allow compact version of ISO-8601 datetime
>  - date.c: skip fractional second part of ISO-8601
> 
>  The approxidate parser learns to parse seconds with fraction.
> 
>  Will merge to 'next'.

I thought we haven't gained enough concious for "12:34:56.7.days.ago"
Current code will treat it as "7 days ago at 12:34:56"
New code will treat it as 12:34:56 (today?)

-- 
Danh
