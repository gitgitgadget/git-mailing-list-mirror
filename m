Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2644EEB64DA
	for <git@archiver.kernel.org>; Wed, 28 Jun 2023 13:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbjF1NPQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jun 2023 09:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbjF1NPM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2023 09:15:12 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF20F1705
        for <git@vger.kernel.org>; Wed, 28 Jun 2023 06:15:10 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fa7512e599so69147945e9.2
        for <git@vger.kernel.org>; Wed, 28 Jun 2023 06:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687958109; x=1690550109;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=en/bLLUuMfucCdG6al6207jLYoEnMdtErrM2ee9OJCc=;
        b=SMvue00hy4bmd5onlH2oiSoa0WpXAnDAY86Sf9ZiuHvK4c0tKBCSvqK/l7IJGqBPR6
         HWLU4HlwCZR4+zA/c1GJ2Ej1Kb9GIjME875WNOtT3/zVePvkCI5VuxIc7eEbLIsa6DjJ
         LrOkJE9J72yngF/WobQb4mWSUPxVdhEBp0AsO5NMxRsoYTHgkEwVrkeT8xL1RhiCd6PM
         MoEIL9jy1vfT7FU7T5yD9W+gH30Q2/1vquhyy3xqVLSaL8O84tni2Ui7V56La5x4Fazh
         PaYbco9CB9EksOk7vBHCbNC9mnKaBOO5U/0zgHhpmMT6X/Pbnpcccdp8106g8pvUBraA
         DtLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687958109; x=1690550109;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=en/bLLUuMfucCdG6al6207jLYoEnMdtErrM2ee9OJCc=;
        b=asLSLJn6jcFSdi2LI9OOmNJPh3wV9HecgI05jToT+JxoFHVLTVJ1XCLtUmoczyxq1T
         n0a6VGvxBaGkW2C/hkyGJva1zg84XAdi3vYeGVz3kzaMDEGn0evmrm5IT1snWWoZLrUu
         aOskGnH0OS6Ckm8Ncpq7zhUtHbsIWsL5M4SI71L/475SGX73kRHLfOiXYaU+UaoquCdn
         dGkaw4r9oVpUrD5SCge+Kxz/JfAujAure0QywL6Zjl+LTxCubNEVc2cgZAR0sY/TN92P
         5eWscJCXdeBmECYJapHEuDzv7c0E+LGWPusVkAwZ+eQS/zrTW0IIfAQtsNPg3tJA88gB
         2AcA==
X-Gm-Message-State: AC+VfDxzaBoVlgyTYFiLUv2P9Sob+5KOWvuZphzILSR0MORf4UQo77/L
        URMxjfwl1MFof6JFs6ZqWGw=
X-Google-Smtp-Source: ACHHUZ4UV2PTSmKOtlPENwJVuJWq67aTa+fvmcNe95Yvcn5Gkf48ZqMw/n2UGCI8qroEJ/gpq1ouTA==
X-Received: by 2002:a7b:cd85:0:b0:3fa:826d:1e93 with SMTP id y5-20020a7bcd85000000b003fa826d1e93mr11051699wmj.21.1687958109294;
        Wed, 28 Jun 2023 06:15:09 -0700 (PDT)
Received: from [192.168.1.195] ([90.242.235.211])
        by smtp.googlemail.com with ESMTPSA id k5-20020a5d6e85000000b003063a92bbf5sm13419742wrz.70.2023.06.28.06.15.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 06:15:08 -0700 (PDT)
Message-ID: <e08d9319-9a4f-bf16-242f-d976aeae32bc@gmail.com>
Date:   Wed, 28 Jun 2023 14:15:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH 2/8] hex-ll: split out functionality from hex
Content-Language: en-US
To:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org
Cc:     nasamuffin@google.com, chooglen@google.com,
        johnathantanmy@google.com
References: <20230627195251.1973421-1-calvinwan@google.com>
 <20230627195251.1973421-3-calvinwan@google.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20230627195251.1973421-3-calvinwan@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Calvin

On 27/06/2023 20:52, Calvin Wan wrote:
> Separate out hex functionality that doesn't require a hash algo into
> hex-ll.[ch]. Since the hash algo is currently a global that sits in
> repository, this separation removes that dependency for files that only
> need basic hex manipulation functions.
>
> diff --git a/hex.h b/hex.h
> index 7df4b3c460..c07c8b34c2 100644
> --- a/hex.h
> +++ b/hex.h
> @@ -2,22 +2,7 @@
>   #define HEX_H
>   
>   #include "hash-ll.h"
> -
> -extern const signed char hexval_table[256];
> -static inline unsigned int hexval(unsigned char c)
> -{
> -	return hexval_table[c];
> -}
> -
> -/*
> - * Convert two consecutive hexadecimal digits into a char.  Return a
> - * negative value on error.  Don't run over the end of short strings.
> - */
> -static inline int hex2chr(const char *s)
> -{
> -	unsigned int val = hexval(s[0]);
> -	return (val & ~0xf) ? val : (val << 4) | hexval(s[1]);
> -}
> +#include "hex-ll.h"

I don't think any of the remaining declarations in hex.h depend on the 
ones that are moved to "hex-ll.h" so this include should probably be in 
"hex.c" rather than "hex.h"

Best Wishes

Phillip

