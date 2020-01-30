Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C99C2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 23:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AA532063A
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 23:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="EwuZBECK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbgA3XDk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 18:03:40 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46036 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbgA3XDk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 18:03:40 -0500
Received: by mail-pg1-f194.google.com with SMTP id b9so2404211pgk.12
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 15:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vny87IdQOlzN0bVI4yjpv6Y1ecy49ja2Nc0h9gAndeE=;
        b=EwuZBECKMSEJcrRPJvPFjjCiR53ueMRPurloTHd+nQJjZTld+HQ1eQGJjEGvByLen4
         76psDsS803vu2sqsuEKFbRsnQUU5LUxEjmo7B3WobZTv02WYV3CnylTHp16Cnyko1PWW
         KmiT5yC+P9KTFiaXrYRyWSVqT1YozyfQBJwRianQ3aCBZP8iUd08cx5DMyCICbD+I3o1
         BcxSBZdumEtP6xT0dsjcSiTERFJAbA2hjPX99OOebxrAWgffEjb/0VHsyXefs5GRUMPF
         5xfTFnYZzJJMKL+1Gj8eMtZARNmaagy2tTM2sqMmdjb+iIJJZBjK1XqaY4EjnK6Bd9HR
         R/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vny87IdQOlzN0bVI4yjpv6Y1ecy49ja2Nc0h9gAndeE=;
        b=V2W9mgUk23Cqxq+v+LS1v0peuXB4OkGBuz+MBGYOP2tRqjVcaIYSF17tDn5i912JZe
         qb0KfpCSEBeOj7//bQNPCh9Rr44ue1na5np+5sf00Y8YrthZtGNeNjL1lhof4JlJ8Ckl
         A39P57bBvOQFp3UxoCbiKIdQeDAyLms3/rqHQ5Z2X6qAlpq4T5mCN0fAMbuuGpHjzL8L
         SvUbv6GnCjYZ0ylk2aaY8Eq/OrWD/iRfxNRPCUZGlaNBC7qLQxMtQRQzQsNUozT7nUta
         prEeRslELwVhz7gNwSjdg0V6uqHmcq5G4uMhAGgXNGu+0UOXtnP+JvGcFMo5lzTgbYb1
         UaBw==
X-Gm-Message-State: APjAAAUGWmvo1zU4aPYZHvdqh+KZ4rY2EDXeNzEdxlYd43fqIqiaLl/u
        /h8XzKLEWM+vC963UlzOe8XB5aeuFMVSOg==
X-Google-Smtp-Source: APXvYqxLFGXjfPbuzVOqKaUl2PxQ+/StxcCQHJykXDe6x1QpKmWYJonWne+uTk08Ty03u8bxYK+E0g==
X-Received: by 2002:a63:5f84:: with SMTP id t126mr6908874pgb.71.1580425419318;
        Thu, 30 Jan 2020 15:03:39 -0800 (PST)
Received: from localhost ([2601:602:9200:32b0:5c8f:7dac:47b8:95ff])
        by smtp.gmail.com with ESMTPSA id x143sm7734162pgx.54.2020.01.30.15.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 15:03:39 -0800 (PST)
Date:   Thu, 30 Jan 2020 15:03:38 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/3] some minor memory allocation cleanups
Message-ID: <20200130230338.GA37366@syl.local>
References: <20200130095155.GA839988@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200130095155.GA839988@coredump.intra.peff.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, Jan 30, 2020 at 04:51:55AM -0500, Jeff King wrote:
> These are a result of me poking at the results of:
>
>   git grep 'x[mc]alloc.*[+*] '
>
> looking for any buffer allocation computations that could overflow (and
> hence under-allocate).
>
> There are a few hits left after this in the commit-graph code. Those
> will be dealt with in a separate series (coming soon!) since they have
> other problems, as discussed in:

I just sent the series you're referring to in [1].

>   https://lore.kernel.org/git/20191027042116.GA5801@sigill.intra.peff.net/
>
> (those have to do with normalize_path_copy(), hence the only
> semi-related documentation patch here).
>
>   [1/3]: normalize_path_copy(): document "dst" size expectations
>   [2/3]: walker_fetch(): avoid raw array length computation
>   [3/3]: traverse_trees(): use stack array for name entries
>
>  path.c      |  2 ++
>  tree-walk.c | 13 ++++++++-----
>  walker.c    |  4 +++-
>  3 files changed, 13 insertions(+), 6 deletions(-)
>
> -Peff

[1]: https://lore.kernel.org/git/cover.1580424766.git.me@ttaylorr.com/

Thanks,
Taylor
