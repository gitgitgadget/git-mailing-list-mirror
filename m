Return-Path: <SRS0=UYkv=ZZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C05C432C0
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 00:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88FD2206F0
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 00:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYFjcaHW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbfLCATB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Dec 2019 19:19:01 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35284 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfLCATB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Dec 2019 19:19:01 -0500
Received: by mail-pl1-f194.google.com with SMTP id s10so824355plp.2
        for <git@vger.kernel.org>; Mon, 02 Dec 2019 16:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Gs4eynjNNPQBfgVTJmX+fcXfKMMH+BOYOT6aX4XarVE=;
        b=KYFjcaHWaMy8I0/7+P6c+YZBokAAcBPipMgWIbUX9iFa6HBC7OiqQCqkZo+HSypz/4
         dNq9hseXB7TL1c8RhygPrRtq9Iy8UvafadwF/rB9rZ1Dloo5aT8ybs9+0LqbsWzjlVEn
         m/WtrCQzTNfOHo/jrwgZqLuwg9GDFHnnSHKdyOOAWlTXEJfqezXe0zYSgraHAy6h+1kj
         zP3MC+j5dO2d29i9kHuKXTmSIJ5puwkG8phggeRKELwaMDswhoFs3jO4z2r/ul4ZjInq
         37XzdXtfmg1sCCbWRpTiznqkg0m4fF0i6ILKjQ8gnH8wnft3TKhSifXYqoClO1LxztWe
         nmDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Gs4eynjNNPQBfgVTJmX+fcXfKMMH+BOYOT6aX4XarVE=;
        b=gRDzHnbNKX6vax0XQ67K8F+TCcO0Vpo42pB4dAFEcWg+XZYYz+k67F3Q3T9FhEG25p
         dZxfCClb5sPG1Koz0h0XX1usTrYyHWClhTjDK5wyyvA6Ys5HwfahgBvlGTeB7EYPt1Qg
         D5t8iQ78Mr8cLJHuINammyLyOI7k5zHetfV4yGaNkZNo/2KlkXgXmJMcSExz/hXL5TkK
         NuSMrvi4ksjyM0eZO1DzZV+DG4SvbQWajNYSmLMK45UI12LCV/z1jnaYk1V/i0OCgbj8
         9Nsk099VvWbqqhK4MEIyxDurERz/Fg/NzYvxBTu5di6FevnKIuO0/eraRHS0exsDbAsL
         VtLQ==
X-Gm-Message-State: APjAAAUm4nExd8EfojBvte9F/bvVIbog4299NQOkpKEAdS/ErUbIGjDp
        5K7OQYq5WqJ7g/gpmh/59+I=
X-Google-Smtp-Source: APXvYqy+x8y73ciX7Xb+EauWLKS6d5gaKhQmhmW4C7gtn48Pi06aIMQCM6TDbaRIe0aG0xfvXux9Cg==
X-Received: by 2002:a17:902:860a:: with SMTP id f10mr2056074plo.326.1575332340176;
        Mon, 02 Dec 2019 16:19:00 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id s15sm743662pgq.4.2019.12.02.16.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 16:18:59 -0800 (PST)
Date:   Mon, 2 Dec 2019 16:18:54 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Ben Keene via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Ben Keene <seraphire@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/1] Python3 support for t9800 tests. Basic P4/Python3
 support
Message-ID: <20191203001854.GA59841@generichostname>
References: <pull.463.v2.git.1573828756.gitgitgadget@gmail.com>
 <pull.463.v3.git.1575313336.gitgitgadget@gmail.com>
 <02b3843e9f21105a945335d0b1d78251ddcc8cee.1575313336.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02b3843e9f21105a945335d0b1d78251ddcc8cee.1575313336.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ben,

Thanks for the contribution!

> Subject: Python3 support for t9800 tests. Basic P4/Python3 support

In git.git, the convention for commit subjects is to use 
"<area>: <summary>". Perhaps something like, "git-p4: support Python 3"?
Although I doubt this patch should remain as is... More below.

On Mon, Dec 02, 2019 at 07:02:16PM +0000, Ben Keene via GitGitGadget wrote:
> From: Ben Keene <seraphire@gmail.com>

It would be nice to have a bit more information about what this patch
does. Could you please fill this in with some more details about the
whats and, more importantly, the _whys_ of your change?

> 
> Signed-off-by: Ben Keene <seraphire@gmail.com>
> ---
>  git-p4.py | 825 +++++++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 628 insertions(+), 197 deletions(-)

This is a very big change to be done in one patch. Could you please
split this into multiple smaller patches that each do one logical
change? For example, you could have the following series of changes:

	1. git-p4: use p4.exe if on Windows
	2. git-p4: introduce encoding helper functions # this is to
	        introduce the as_string(), as_bytes(), etc. functions
	3. git-p4: start using the encoding helper functions
	...

This was just an example and you don't have to follow those literally. I
just wanted to give you an idea of what I meant.

You can see Documentation/SubmittingPatches#separate-commits for more
information.

Thanks,

Denton
