Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDEF3EB64DD
	for <git@archiver.kernel.org>; Thu, 13 Jul 2023 08:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234389AbjGMIbP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jul 2023 04:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234292AbjGMIav (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2023 04:30:51 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E965B98
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 01:22:00 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fbc5d5742bso3148645e9.2
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 01:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689236519; x=1691828519;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=e8y6J0cLn6gtepKVv6UruQtv+gPrhsX391LRQ3Bu4f4=;
        b=mk3hwKTzBRXnEeDNIjjX/rjYY/7bqJsYUEiDrS8pMpneEAcfyb04SlNrT25nmd/GiL
         2CXkTJtx3KaoWT0QC5PVSfdpvGMZ1O4Bc9uR89X+m68/kO5Q0JOE1miXSWJUBBkNIbHZ
         K8wZZBjMBJ0I0UGf372cm77QyqXEmwGAyEDtn1Ge6SxT0dhjWMRYbTVU/QaKJnKWPyE/
         /4EARYyjqVvc1QM1HHJzlRIRQw2bbwcjOksWBvp7SjeMa+mjg75H/oSSFpRJDm8pWcM3
         /AovlBljVOuQ5d1vpgki5oywTjRdEaYjnm5hFofncwfay2wtbPo+DSr8KSHbap0rSGoK
         lGfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689236519; x=1691828519;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e8y6J0cLn6gtepKVv6UruQtv+gPrhsX391LRQ3Bu4f4=;
        b=Yla4D5vZGMaZxbEMwIzsLy8TzpaNIrQ4dc836wXm0Yww3LxkNoLFTPomPzmatfh4Zi
         ZtRH6IP/8yKa2v5cugmFPT9EfVQgcHVX2NVoClkEWob6gcQv8P9O6/t3dTokpgou/6xc
         kWB3aL54BOSsGP14/30qoKHKz9VuHYBgvHm21+hFoz2QBK7dHnL6rApGtlOY2d+5ir+x
         glz+Ec+whKW2TuXl9MfFbB2qTHjqDjuoIggc4gVOLe7W0jL3x6Glong3l04uTHLqvmPW
         3zcRvjn24ZC6GEailvpllU+mWZG9OeE3w3YCR8uHia3cddTsRBE6gEBCwcFy7fo4jNOi
         MBig==
X-Gm-Message-State: ABy/qLYZ7g5TzprQtRnKds9PyNDAeCWYwgxozUd29lc3xlJn0Wcob/EZ
        jBuEldc2IldX0Rj6AtOxuyM=
X-Google-Smtp-Source: APBJJlEicgI7J1Dj9kWFhdIjqSPMGhqNaAjBu9zuz9HQSi7fzaHWAvaolnlPSj2RLLzZNJ2dAwfvQg==
X-Received: by 2002:a7b:c8cf:0:b0:3fa:984d:7e99 with SMTP id f15-20020a7bc8cf000000b003fa984d7e99mr870592wml.22.1689236518846;
        Thu, 13 Jul 2023 01:21:58 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.235.211])
        by smtp.gmail.com with ESMTPSA id 9-20020a05600c234900b003fbc0a49b57sm7156956wmq.6.2023.07.13.01.21.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 01:21:58 -0700 (PDT)
Message-ID: <5d2cf09f-34c7-9a88-bab2-8bf348dd13bb@gmail.com>
Date:   Thu, 13 Jul 2023 09:21:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 02/20] packfile.c: prevent overflow in `load_idx()`
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>
References: <cover.1689205042.git.me@ttaylorr.com>
 <d6902cd9e7f7f2a6b8044c8fb782a28c23e15600.1689205042.git.me@ttaylorr.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <d6902cd9e7f7f2a6b8044c8fb782a28c23e15600.1689205042.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor

On 13/07/2023 00:37, Taylor Blau wrote:
> Prevent an overflow when locating a pack's CRC offset when the number
> of packed items is greater than 2^32-1/hashsz by guarding the
> computation with an `st_mult()`.
> 
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>   packfile.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/packfile.c b/packfile.c
> index 89220f0e03..70acf1694b 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -186,7 +186,7 @@ int load_idx(const char *path, const unsigned int hashsz, void *idx_map,
>   		     */
>   		    (sizeof(off_t) <= 4))
>   			return error("pack too large for current definition of off_t in %s", path);
> -		p->crc_offset = 8 + 4 * 256 + nr * hashsz;
> +		p->crc_offset = st_add(8 + 4 * 256, st_mult(nr, hashsz));

p->crc_offset is a uint32_t so we're still prone to truncation here 
unless we change the crc_offset member of struct packed_git to be a 
size_t. I haven't checked if the other users of crc_offset would need 
adjusting if we change its type.

Best Wishes

Phillip

>   	}
>   
>   	p->index_version = version;
