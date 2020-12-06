Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01ADC433FE
	for <git@archiver.kernel.org>; Sun,  6 Dec 2020 14:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5B2D2313F
	for <git@archiver.kernel.org>; Sun,  6 Dec 2020 14:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgLFO51 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Dec 2020 09:57:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbgLFO50 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Dec 2020 09:57:26 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9A6C0613D0
        for <git@vger.kernel.org>; Sun,  6 Dec 2020 06:56:46 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id u19so10959572edx.2
        for <git@vger.kernel.org>; Sun, 06 Dec 2020 06:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cE5q259z6RpnNPq7OhWaA1Y55QNq5VKDp38H8v4Ukzw=;
        b=lanuhZ83SLEJUyssKUAbU4Uo78BJXZODLjEK6FJr6xkuXkmfRZVE+IQ8sOclQplqtT
         YLOouyUDReQrggOcRDTQF17GbhaTd6/VwoPsKCKyAUJGpzLiAb0liQCfgOAkUI2oWq2t
         LSObR6aOjLdvUj0w0EfKyPQ1ibAHbD7bT5m0ARppw9nOoExHmphY26jmQokYy11X80qY
         V5g/36lkycnNNCKtJBYUoYAhbRrw9Qe+xpQvsrNenpPqOYF/c2MytIAqDQk3yLPZUsBe
         t6XjA6mVmPB/Au2x27V7G5v00ssLE5+aotaXARudTpDUQGCZ/Gcl+j1eaY2roVGm49JD
         nqWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cE5q259z6RpnNPq7OhWaA1Y55QNq5VKDp38H8v4Ukzw=;
        b=F3Gq7xzg5B+zXTxlfTOPGBeWBHpMgkCGouJRoCt+jcgoEbR7byLSZye2VFVf3442mp
         EV+gAtVIWfV9jaycXV4epH5WR2rpj6g5rsidrIneKrUAMtjvXrfLk+2NIRUl7/jM40wK
         Bmobc+w/I5CmvzORAO89qQJSi42AQx58/NVgjL61GwGgvWgNrElchxHeSSrCO0nsvVC/
         K5X+TjKSD9ZhVSAnZCLmmJuucorqoMapZdjZ3ifJ70I3GDX7qSUwc2zHTR1qBNC1Dxvz
         /zh2elNivWZPcqcbnX4Y7kH5xDMkIGkcJgk2SfIo0qAoo9oZasjEuTCw3GZvBm5L8bOC
         dkiA==
X-Gm-Message-State: AOAM532D0Ar85nZa9To+8HPN+wcrzd+hHyppWEQVXuljVD8xOUfnZ2F8
        gG5egwN7sHI/pj9jBynAyEw=
X-Google-Smtp-Source: ABdhPJyh0aZ2DLKncsewloetKJOo9wgPpp8+LctLnRJkjKIVFTBA7qAZ9nduOHQCPMOFEia8En2LqA==
X-Received: by 2002:a50:b905:: with SMTP id m5mr11403932ede.292.1607266604804;
        Sun, 06 Dec 2020 06:56:44 -0800 (PST)
Received: from szeder.dev (78-131-14-139.pool.digikabel.hu. [78.131.14.139])
        by smtp.gmail.com with ESMTPSA id i13sm8395016ejc.57.2020.12.06.06.56.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Dec 2020 06:56:44 -0800 (PST)
Date:   Sun, 6 Dec 2020 15:56:42 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/2] banned.h: mark non-reentrant gmtime, etc as banned
Message-ID: <20201206145642.GH8396@szeder.dev>
References: <X8aMt2LEiCLkdV9/@nand.local>
 <20201201211138.33850-1-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201201211138.33850-1-gitster@pobox.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 01, 2020 at 01:11:37PM -0800, Junio C Hamano wrote:
> From: Jeff King <peff@peff.net>
> 
> The traditional gmtime(), localtime(), ctime(), and asctime() functions
> return pointers to shared storage. This means they're not thread-safe,
> and they also run the risk of somebody holding onto the result across
> multiple calls (where each call invalidates the previous result).
> 
> All callers should be using their reentrant counterparts.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  banned.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/banned.h b/banned.h
> index 60a18d4403..ed11300bb2 100644
> --- a/banned.h
> +++ b/banned.h
> @@ -29,4 +29,13 @@
>  #define vsprintf(buf,fmt,arg) BANNED(vsprintf)
>  #endif
>  
> +#undef gmtime
> +#define gmtime(t) BANNED(gmtime)
> +#undef localtime
> +#define localtime(t) BANNED(localtime)
> +#undef ctime
> +#define ctime(t) BANNED(ctime)
> +#undef asctime
> +#define asctime(t) BANNED(asctime)
> +
>  #endif /* BANNED_H */

This patch should be queued on top of topic
'tb/bugreport-no-localtime'.  Currently they are on parallel branches:

  * 91aef03015 (refs/upstream/jk/banned) banned.h: mark ctime_r() and asctime_r() as banned
  * 1fbfdf556f banned.h: mark non-reentrant gmtime, etc as banned
  | * 4f6460df55 (refs/upstream/tb/bugreport-no-localtime) builtin/bugreport.c: use thread-safe localtime_r()
  |/  
  * 72ffeb997e Ninth batch

and because of the not-yet-removed localtime() call in
'builtin/bugreport.c' commits 1fbfdf556f and 91aef03015 can't be
built.

