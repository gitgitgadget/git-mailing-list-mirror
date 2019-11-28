Return-Path: <SRS0=/qQH=ZU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C091C432C0
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 12:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BDA2217C3
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 12:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmkkWaQn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfK1MQQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Nov 2019 07:16:16 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41211 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfK1MQQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Nov 2019 07:16:16 -0500
Received: by mail-pf1-f196.google.com with SMTP id s18so4502954pfd.8
        for <git@vger.kernel.org>; Thu, 28 Nov 2019 04:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vEAqH9xxeeAv8dzKwV8JLYEEOTM8p+4BoCYPNrmUWl4=;
        b=hmkkWaQnKhNfZ/Vk3tRVB3ZkVsivo/wtGo6z6mES1DiglzRoF5DWCQsgMhtR5bpwLb
         FSoYraUCjOAz5XjpYVqr30+MSsy/e2f/QczlxaioZcn81yuWaHsg3s/XTsARDMRt3D3v
         BJN0s0dzFLmeyhFj8FYxXlT2+Hpv1miG0mubxKXEZkicDpILFYgjhKTCN5imLZlDgy+t
         ZWMzsOUTz4IAj8v2uo51DU7Ddcp5Xn+Osovaa0xpPdIbn3DdE9osd5lfuyM3fKDy9FvV
         FN2ITY5qzCHXKdeYXk1WNtuv5bixRhXqJyoirUdp86CU8PKylarciLwyB6eY8LAVbs4h
         7xBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vEAqH9xxeeAv8dzKwV8JLYEEOTM8p+4BoCYPNrmUWl4=;
        b=RWpHsYkM43fBu7YmwK8kDUWYzWLl5n55gVmugergAKYpr50Y8LyQH/CqEolqUHu31P
         p0sMC3vSvtGHD/Xjol5N4/GKA9XfpU4UH/NIppuvri0WPOwLgkUED8pSg/8XOVAVKdtL
         4YxN/o0X/AnkQpvW6RnuxXKx/Qtbg6P43W+FT+qB99wQk9nz9pZ8az6BfisskoJlSzZW
         Oe/VgEF9msTw2vgZBiYT2sCMNVrkgUyZxWePEhn8C8HnoY1yL7qq9tqJFtuMUDuGn26V
         HLJfvQMLMona1TADQkmcYKyB0jN+jXTENAMWubwWpZ8ImzFHNbVPx2HQUQIBHYX7ALVL
         2l9Q==
X-Gm-Message-State: APjAAAXzEdNvm/ZR/FFRhotY6Oy/HbgH+wvrVLd+Da8ncK6IoTwm3C2/
        xo4qW+R9U85eiG6Vrs7OURAcZpk0
X-Google-Smtp-Source: APXvYqwmlG/7NOgP5UQGhDs4uW8mpusF51R02n3vYQl2acbx1M18zNw0BmxpyfIpFLXni9uLC5RHDg==
X-Received: by 2002:a62:6044:: with SMTP id u65mr52780830pfb.227.1574943375995;
        Thu, 28 Nov 2019 04:16:15 -0800 (PST)
Received: from localhost ([2402:800:6375:24ff:b05:3145:6413:309f])
        by smtp.gmail.com with ESMTPSA id b16sm8263196pfo.64.2019.11.28.04.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 04:16:15 -0800 (PST)
Date:   Thu, 28 Nov 2019 19:16:13 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/5] drop non-reentrant time usage
Message-ID: <20191128121613.GC9067@danh.dev>
References: <cover.1574867409.git.congdanhqx@gmail.com>
 <20191127162930.GC30581@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191127162930.GC30581@sigill.intra.peff.net>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019-11-27 11:29:30-0500, Jeff King <peff@peff.net> wrote:
> On Wed, Nov 27, 2019 at 10:13:16PM +0700, Doan Tran Cong Danh wrote:
> 
> > gmtime/localtime is considered unsafe in multithread environment.
> > 
> > git was started as single-thread application, but we have some
> > multi-thread code, right now.
> > 
> > replace all usage of gmtime/localtime by their respective reentrant ones.
> 
> I think this is a good change.
> 
> A minor point, but I think it may be simpler if the first four were just
> a single patch. There's no rationale given at all in the 3rd and 4th
> ones. Which is because you already explained it in patch 1, but that
> won't help somebody who digs up the commit via "git blame".
> 
> So I think they either ought to be one patch, or they should repeat the
> rationale (I'd probably go with the first, but I could live with the
> second).

I'll merge first three into one since both of them are in date.c,
the 4th one changed another file.

-- 
Danh
