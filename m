Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23654C2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 20:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E800820CC7
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 20:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="fV9ujDYp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbgA3UMu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 15:12:50 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36795 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgA3UMt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 15:12:49 -0500
Received: by mail-pf1-f196.google.com with SMTP id 185so2059767pfv.3
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 12:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uu+LEAAM7bByQINPO+wYj56VkX7HTSAM3NzelBWS1/8=;
        b=fV9ujDYpmF1VJtuA2DJp9ky8FjLUihgDDYhgQqIVqEZUeGV9VOMupd1+XmLR9gBCly
         MJViTXYjiuLejHeLumQZjrrzNPLuxJDBBrTsfV9isKK3Op9ucbYFh10hXvWt4PWT2BLn
         Zdcj+vcNArMVfvg8dPQxBtJF3al6H93MX1u/C8QbPeh0iuVfk3dAxBn6zYpbyCdjFfDY
         +5g+Uor3CXw/L7c6v1tsypKHAqav/YmlgWFIIWWBMKIya4fXzDYZvf9zIwxcrX4W7Ac4
         8uyhQD7wzv6UVvN9lWv35q0FUHXThe9f6Ayu7Txn1KyLjX0IEkRJb+BvZCkTvqt3yVCQ
         bEwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uu+LEAAM7bByQINPO+wYj56VkX7HTSAM3NzelBWS1/8=;
        b=P4vM6AwqN9UVjuwu2Tg/2JxGAk3Ka8tEW9ZEPg6RRa8CqVC0Idv6L885/SMfc2Ssfx
         6UcfGXpvr623/UK6V8N6g3r/vHrhP4Du5QP+Ayu0iR8/eEiW3Uv/4jQeSUqWUVSouwn5
         542MknTpx4ufJdcYAZ2k4amPVf75mBvzUrqtWxRLHs1sUd6Q6pj1jFrZ+8r7kPFeG+lr
         8qArhwWEtDyPzpZtMpWDi9eUcR2uToNKgTlY38MuKoh9baZ7BUszwhDpB/CuP08K7lyv
         lSY4H4niI4ERVmgPgUekpXFOYJRYk5qjDXqkImhrMc5EEFFo8/Un53VQjaEV3GS6EH8W
         sddA==
X-Gm-Message-State: APjAAAWOrPtYqfJKlfNE8v409l12wFUYGC7KJ7go+wq1Xfdfo0oIWBdk
        o48bZi2nt5mfVupopmleTFoieWpptxOQRA==
X-Google-Smtp-Source: APXvYqzKhfeAL0AL4ONjMvDSHk8BtYqrQHnA0J/V/B5gQeRgdiOg77Ncfg0y33jFOGXrSjqBqTIo5w==
X-Received: by 2002:a62:e30d:: with SMTP id g13mr6757985pfh.92.1580415169005;
        Thu, 30 Jan 2020 12:12:49 -0800 (PST)
Received: from localhost ([205.175.106.98])
        by smtp.gmail.com with ESMTPSA id u26sm7299315pfn.46.2020.01.30.12.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 12:12:48 -0800 (PST)
Date:   Thu, 30 Jan 2020 12:12:47 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] normalize_path_copy(): document "dst" size
 expectations
Message-ID: <20200130201247.GA26000@syl.local>
References: <20200130095155.GA839988@coredump.intra.peff.net>
 <20200130095219.GA840531@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200130095219.GA840531@coredump.intra.peff.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 30, 2020 at 04:52:19AM -0500, Jeff King wrote:
> We take a "dst" buffer to write into, but there's no matching "len"
> parameter. The hidden assumption is that normalizing always makes things
> smaller, so we're OK as long as "dst" is at least as big as "src". Let's
> document that explicitly.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  path.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/path.c b/path.c
> index a76eec8b96..88cf593007 100644
> --- a/path.c
> +++ b/path.c
> @@ -1077,6 +1077,8 @@ const char *remove_leading_path(const char *in, const char *prefix)
>
>  /*
>   * It is okay if dst == src, but they should not overlap otherwise.
> + * The "dst" buffer must be at least as long as "src"; normalizing may shrink
> + * the size of the path, but will never grow it.

Thanks for documenting this. It's quite helpful, and hopefully should
prevent bugs like the one you alluded to in your cover letter from
getting in in the future.

>   *
>   * Performs the following normalizations on src, storing the result in dst:
>   * - Ensures that components are separated by '/' (Windows only)
> --
> 2.25.0.515.gaba5347bc6

This looks obviously good to me.

Thanks,
Taylor
