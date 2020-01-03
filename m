Return-Path: <SRS0=XQOF=2Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54259C2D0C2
	for <git@archiver.kernel.org>; Fri,  3 Jan 2020 13:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D17520678
	for <git@archiver.kernel.org>; Fri,  3 Jan 2020 13:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KerJjGrX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbgACNFr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jan 2020 08:05:47 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:37032 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727350AbgACNFq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jan 2020 08:05:46 -0500
Received: by mail-qv1-f66.google.com with SMTP id f16so16179133qvi.4
        for <git@vger.kernel.org>; Fri, 03 Jan 2020 05:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zV2MCLfPQJFHBiNZWE5joStIXy+ThElvphTBLbxTEA0=;
        b=KerJjGrXtOw8+0/B8yFNcuYc0FYS79ysAEz3FRnAvgxFOna5jLRB9cd9PjJk+S/A/1
         Nz2iFTu1qNRI1ynM3NpoOMbyjfeSaIauERx3j0ArPS7PTTgcENvW2kje4gaHbFpjS5vh
         oqsDi6ROKYZ+1/i0Po6gyV3AJD02oEKdkeMyoiE6RiS8nPXBba3GYzEpf7lQhcfxuMb4
         YxeaLGaVAC+R3/59Ti/03Os5zKjRCdp0MJjF9tz1nmPYT4+3ODwwo63f88T6QH2am/J3
         Cxc1+A4LQml2y9yRx9CRCB2nloB5Le/r9E0j+7kg2oAX1llWhhQkz9ZlXWMFKPxroYJT
         EEbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zV2MCLfPQJFHBiNZWE5joStIXy+ThElvphTBLbxTEA0=;
        b=M/ZSox8mLcuOa05wBFXomuUk7U8LfFzWw5kB1rnkWSgHc9TGXmEHiH+8cnkTfuhfYI
         5WKbSRU+P+0aAaL1M6F+7y/0yOzH5K2hb6coifkUwBirTFBu2nukQCHQELPaKM1Vui5H
         ncEvmey79wXIzaWQ7uSFHH4aNfnKqt+CgTc9DB2BoMzIrp1+h14Fko56K5IhnrFQUSK7
         YJMBLGCQZt5i0874NTfRLy4VD106PaOuKCMwmgmFz6hTSBFdrrK6Ig0t65Z/dkv7YmXQ
         HoVGQXWiXf2hFCo2Rfe797DAtYzqs0WEDVxmwKNETX1PF4Nq/zy4MLICJr+Ny35l9iOn
         HEUQ==
X-Gm-Message-State: APjAAAXr+I1esKiYo422vzFKsEarEVJ/f7cINTO8cIPvNC0UcQfMFw0S
        B7ammn1AjIZgn9iNeUtB5qU=
X-Google-Smtp-Source: APXvYqypkb5MxjK9Q1rdZCQ8eIxkr6o5RT+agdOCNtS7O7UmQzE4ysMZj16dSESGPA9OjiQWTZBbPg==
X-Received: by 2002:ad4:58e1:: with SMTP id di1mr52901236qvb.201.1578056745558;
        Fri, 03 Jan 2020 05:05:45 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:a438:4a34:2dfd:4bc? ([2001:4898:a800:1012:556c:4a34:2dfd:4bc])
        by smtp.gmail.com with ESMTPSA id i16sm16410861qkh.120.2020.01.03.05.05.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jan 2020 05:05:44 -0800 (PST)
Subject: Re: [PATCH] Documentation/git-sparse-checkout.txt: fix a typo
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     dstolee@microsoft.com
References: <1acd9e81607cc3f430a52512d7ff3cb82ccb0cfb.1578005500.git.me@ttaylorr.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ea6541ae-24d6-fb8a-3411-56702a9ee525@gmail.com>
Date:   Fri, 3 Jan 2020 08:05:44 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <1acd9e81607cc3f430a52512d7ff3cb82ccb0cfb.1578005500.git.me@ttaylorr.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/2/2020 5:51 PM, Taylor Blau wrote:
> This typo was introduced in 94c0956b60 (sparse-checkout: create builtin
> with 'list' subcommand, 2019-11-21).
> 
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  Documentation/git-sparse-checkout.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
> index 9c3c66cc37..a3c920fa6c 100644
> --- a/Documentation/git-sparse-checkout.txt
> +++ b/Documentation/git-sparse-checkout.txt
> @@ -5,7 +5,7 @@ NAME
>  ----
>  git-sparse-checkout - Initialize and modify the sparse-checkout
>  configuration, which reduces the checkout to a set of paths
> -given by a list of atterns.
> +given by a list of patterns.

Thanks for finding this. Obviously correct.

-Stolee
