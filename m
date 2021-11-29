Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71CE5C433F5
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 18:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237175AbhK2SRg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 13:17:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346747AbhK2SPf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 13:15:35 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D30FC03AA1E
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 06:44:34 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id n66so34986945oia.9
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 06:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Pl3Fl36HNVHyp+pKiGi4XXwOihA0WxgxqDWRF5eM10E=;
        b=qoy6fOvHKOFRIS/7Xbh58kJcHt2vDrpslkb3n9vDy1AzA0X7zsF2sv2fE9ALgeko/M
         NSQh/ln9wLjy5paOWI3UtCbYnCLWF7Ze8RdHx6fHJW8fmyzxgC/tugI1qEof3oDDy1iw
         Vih0OE0sDwgsVxG0Ju0OKgSSuoA00qW+EJK9UrMEk1vyOCE4rrb30Wogy8Zwh0lwtruj
         GvKoxaS2yj/7ZZHyy45TefMTuvLYpXWepmjuCYnHi4o80Wjdzy2TjRoTH6Qk44JtNa2w
         zkw7ZD3/r3OqIJVUa38cW/8g2TyuCyC5wlVkWb6lNqUV6kpCKJehJNmLRZdos5Q8N+bp
         o+gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Pl3Fl36HNVHyp+pKiGi4XXwOihA0WxgxqDWRF5eM10E=;
        b=yl3zIZfAJU/Qx3p3ubOQUFT+pohuNpMCISFQE447Bf3wDVW4rZChGRByfSJkyB4QYn
         g1kjW3k0kBFuqRNhp82QahW4wP+eek4Gya7pvNbvZeYvEpixQ4/XJw3VpwA+lDwrbWht
         0wep+LOjTWzsSfP+2yvhkH25p+XCe2TFdkmAS/JtFasC0eBdyrZhiDdrvF167HkLpmQA
         Msv1EwSmWUw8oQoMBBmBvId/8ttR0M8VzHTqq5jp6VBSA3/7PiEaAy62bq3nUQrjfNoK
         YsqjogOPCl+ktgjtgucZruUWO2NdVah0bW+dCOdANdGReCoTxh6TAYtqlMqrL3xq53fu
         TR0A==
X-Gm-Message-State: AOAM530OIcN8XQhpp/B/KL4FyyVNiHiuTt52bNar0F4J10HoAREFcgny
        TcuPOXMbkYo1a91Cl7G9DzY=
X-Google-Smtp-Source: ABdhPJyFVeZESYgl5onzBOjLg5QmjLmWFQDH3F3dwxhM5XAqHWshApRvuXi85w2k+r/VAoQv7S6yGg==
X-Received: by 2002:a05:6808:15a:: with SMTP id h26mr40918768oie.123.1638197073683;
        Mon, 29 Nov 2021 06:44:33 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:3085:654c:eb81:848b? ([2600:1700:e72:80a0:3085:654c:eb81:848b])
        by smtp.gmail.com with ESMTPSA id w4sm3131713oiv.37.2021.11.29.06.44.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Nov 2021 06:44:33 -0800 (PST)
Message-ID: <f721bc99-6d79-e2f2-7810-dd77b777161f@gmail.com>
Date:   Mon, 29 Nov 2021 09:44:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 3/4] diffcore-delta.c: LLP64 compatibility, upcast unity
 for left shift
Content-Language: en-US
To:     Philip Oakley <philipoakley@iee.email>,
        GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20211126113614.709-1-philipoakley@iee.email>
 <20211126113614.709-4-philipoakley@iee.email>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20211126113614.709-4-philipoakley@iee.email>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/26/2021 6:36 AM, Philip Oakley wrote:
> Visual Studio reports C4334 "was 64-bit shift intended" warning
> because of size miss-match.
> 
> Promote unity to the matching type to fit with its subsequent operation.
> 
> Signed-off-by: Philip Oakley <philipoakley@iee.email>
> ---
>  diffcore-delta.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/diffcore-delta.c b/diffcore-delta.c
> index 5668ace60d..a4e86dfa38 100644
> --- a/diffcore-delta.c
> +++ b/diffcore-delta.c
> @@ -133,10 +133,10 @@ static struct spanhash_top *hash_chars(struct repository *r,
>  
>  	i = INITIAL_HASH_SIZE;
>  	hash = xmalloc(st_add(sizeof(*hash),
> -			      st_mult(sizeof(struct spanhash), 1<<i)));
> +			      st_mult(sizeof(struct spanhash), (size_t)1<<i)));

This could use spaces around "<<"

>  	hash->alloc_log2 = i;
>  	hash->free = INITIAL_FREE(i);
> -	memset(hash->data, 0, sizeof(struct spanhash) * (1<<i));
> +	memset(hash->data, 0, sizeof(struct spanhash) * ((size_t)1 << i));

Especially because you correctly add them here.

Thanks,
-Stolee
