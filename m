Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13B8C433F5
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 14:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243086AbiBJOl7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 09:41:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243077AbiBJOlx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 09:41:53 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DEABCD
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 06:41:53 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id r15-20020a4ae5cf000000b002edba1d3349so6655738oov.3
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 06:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=07WiERXygHs+ohYciKTfkH4Bsc3OO3/Qij3X1NTqBtU=;
        b=ImPiECXacCYgX+5t2FQm/NjsZTF9dn+JYQlQC7o6t1ECmc5/MVnulC4snZy2tmUjGs
         R/ZcoHffK3mqsqlOZ4gQNQbiXIXLSLgrhPOGT9m62LvCqg6ejDdTkYIPPZAokTfirTQ+
         3AYb2oF8j6iJdjlTxr10ujoE8BaMgYA+GBlL7GYeK/Jc6svHoA2yW69LbibHZuZhh9qo
         KQcpJOawKMC2KF1LKHe6YgRqJ8suSAL7BQ6E0oRlbBQaj5CLrY9yo1DM+Q6LvDnANHwM
         YL4aeIzs/wPsCkhsQY3cvZ3l02pjZEVi3FlsG/PKdhQpI8bKZpiCgU9Fzui/twgQLvAp
         nW4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=07WiERXygHs+ohYciKTfkH4Bsc3OO3/Qij3X1NTqBtU=;
        b=f4SalO4a3Nj4U0avjJJOEulF/wP6Fn5bRvtU6L5PdBCLaDL989rcUOhnYqHgbgyeQF
         b/xjoTCMm89+u/y/Itkx48BP+0wn3YSgeCIps/AAWUKgP19sI0/vYgFKsbGK1sDJ8lb+
         fXCavSmQ/0tMDnQXVGzLW5k5ZWjdu8eHXS75gD7sZuncaBlgyTAe+49OpJGVfSFdrKeL
         n6iQDTHqIfHQXrwK1WpQqgYeSlfNPGrUyAs7S+8scFofZStcmQQPkl/xbXzpn62kH6AT
         R1q1aFKS/JtT6JAep2Qdz3cUlOlVM+Ks+DSCf5Mbaek1PuAq91MSewtrh0RPULo1+YIY
         e4yg==
X-Gm-Message-State: AOAM533hkU1LQ+HE5hJ75bqCSGXQjRjUbUUuO5ErnywvoIEnlxBqOVXk
        UBTI3pz6OkP7HVZ119QgEACVFV/Q6uE=
X-Google-Smtp-Source: ABdhPJwbfe6LPaMFaUyfgB9JDgiI3Fw+Srpq78sqi6iH3C6LmZBoFwyEYO+DPnDobUrkEPfj6JipYA==
X-Received: by 2002:a05:6870:a548:: with SMTP id p8mr925074oal.149.1644504113220;
        Thu, 10 Feb 2022 06:41:53 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:9556:7d7f:ddbf:443c? ([2600:1700:e72:80a0:9556:7d7f:ddbf:443c])
        by smtp.gmail.com with ESMTPSA id c32sm8240549otu.15.2022.02.10.06.41.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 06:41:52 -0800 (PST)
Message-ID: <748a2358-7bdf-5b28-09f9-5c4b266a3b52@gmail.com>
Date:   Thu, 10 Feb 2022 09:41:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 1/1] midx: prevent writing a .bitmap without any objects
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     gitster@pobox.com
References: <cover.1644434802.git.me@ttaylorr.com>
 <abc67d757cb6b244cf54b7b030985180ce134724.1644434802.git.me@ttaylorr.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <abc67d757cb6b244cf54b7b030985180ce134724.1644434802.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/9/2022 2:26 PM, Taylor Blau wrote:
> When trying to write a MIDX, we already prevent the case where there
> weren't any packs present, and thus we would have written an empty MIDX.

> diff --git a/midx.c b/midx.c
> index 6e6cb0eb04..865170bad0 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -1077,6 +1077,9 @@ static int write_midx_bitmap(char *midx_name, unsigned char *midx_hash,
>  	char *bitmap_name = xstrfmt("%s-%s.bitmap", midx_name, hash_to_hex(midx_hash));
>  	int ret;
>  
> +	if (!ctx->entries_nr)
> +		BUG("cannot write a bitmap without any objects");
> +
>  	if (flags & MIDX_WRITE_BITMAP_HASH_CACHE)
>  		options |= BITMAP_OPT_HASH_CACHE;
>  
> @@ -1401,6 +1404,12 @@ static int write_midx_internal(const char *object_dir,
>  		goto cleanup;
>  	}
>  
> +	if (!ctx.entries_nr) {
> +		if (flags & MIDX_WRITE_BITMAP)
> +			warning(_("refusing to write multi-pack .bitmap without any objects"));
> +		flags &= ~(MIDX_WRITE_REV_INDEX | MIDX_WRITE_BITMAP);
> +	}
> +

This patch looks good to me. The code change is simple and the
test is clear.

Thanks,
-Stolee
