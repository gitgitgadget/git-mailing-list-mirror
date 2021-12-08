Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6E3C433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 14:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235126AbhLHOeR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 09:34:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234866AbhLHOeM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 09:34:12 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E51C061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 06:30:40 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id l8so2315596qtk.6
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 06:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=lK/SGbkmQH4DqCHAPr14VasX1AhOPQw2C3R7a8OvzpY=;
        b=S7pTKEqnoFmLj9ib1Id7tSUFPa+nuzynNLuDXtXiE5pbO/2IlrtDBsBROdlrgF32Bz
         7pt21weYQ1mcmzHYcUHA4Pm9sv59/RM0z/18e+JYT33yJbwJLIG8iPwRboQW1GUpfTZf
         itLlVChmVsWV+P3jZgeJmO6X7tZ+ZHMMOnTDlBU6ROkt78RvL3mA1GcpZTL0JgeGUftY
         pp/TC6RAB6Ywgb8kB4TM+R8Aj9pzx26plE9nBuqtjhJFAukCQi+iWjFQxlSNCx+bIlri
         hF53PFsOqZHWtjjYq8DSYZ+hW0dhj6Ks1n0rKDPTcnqipvQ70G8oO3xRzkstNF3GzpJm
         HXPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lK/SGbkmQH4DqCHAPr14VasX1AhOPQw2C3R7a8OvzpY=;
        b=Wu/E3MnV++EmRPiItMCviALb4x4+cyKeA+1CaYDkBxZTjtjh/OdBbrZRstSplVqax/
         9vdU7ztJOSQ3xvHMRfNwZ5ZVU0nYiFjfXO5I6Bxsjm5VehE00jWB7NhFNpcoADJ/W/0a
         o/g6GJUHQ8OyIaiYGocwHgc5Pj5G5Cx7QF3ro9D2SYH0TlvvkAIdVq6rQiU6gcdfZha3
         jsaQ18F9q+gMgfCnGf0Q2hX9ZiYBZGieMmNjvsKmeBarxJnbYEZO9FP31NTJoOUnycQc
         IArwGzBG6Hurb9LZ0qymdA4nAIdwp78AQWgq4tmo2nwCnIo00z6I+hMBR5rfsfFQou64
         zGlw==
X-Gm-Message-State: AOAM532hJJbRQ5E+YmGPHBKhVATHUqhnks415wkpW4LRdaqfmO6o02ZV
        SNvBLJFzHlkiaqznpbEScg8=
X-Google-Smtp-Source: ABdhPJzv5azVawRX9bpfOMWlTb1qRfm7v8RZsxkta10VQJy3lD2JVkHFMjJuAbL5y0W4loPqPGhBaw==
X-Received: by 2002:a05:622a:389:: with SMTP id j9mr8998202qtx.504.1638973839860;
        Wed, 08 Dec 2021 06:30:39 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:5056:be20:f10c:bfd5? ([2600:1700:e72:80a0:5056:be20:f10c:bfd5])
        by smtp.gmail.com with ESMTPSA id s6sm1573632qki.23.2021.12.08.06.30.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 06:30:39 -0800 (PST)
Message-ID: <a7b4c6aa-c8cd-eaa7-f4b5-dee0028cc4d2@gmail.com>
Date:   Wed, 8 Dec 2021 09:30:38 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 02/10] reftable: fix resource leak in error path
Content-Language: en-US
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
References: <pull.1152.git.git.1638899124.gitgitgadget@gmail.com>
 <603bd1d4f6e4ceda02a5165eedd3ae5b92b8929e.1638899124.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <603bd1d4f6e4ceda02a5165eedd3ae5b92b8929e.1638899124.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/7/2021 12:45 PM, Han-Wen Nienhuys via GitGitGadget wrote:
> From: Han-Wen Nienhuys <hanwen@google.com>
> 
> This would be triggered by corrupt files, so it doesn't have test coverage. This
> was discovered by a Coverity scan.
> 
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  reftable/block.c | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/reftable/block.c b/reftable/block.c
> index 855e3f5c947..d7347bb3152 100644
> --- a/reftable/block.c
> +++ b/reftable/block.c
> @@ -188,13 +188,16 @@ int block_reader_init(struct block_reader *br, struct reftable_block *block,
>  	uint32_t full_block_size = table_block_size;
>  	uint8_t typ = block->data[header_off];
>  	uint32_t sz = get_be24(block->data + header_off + 1);
> -
> +	int err = 0;
>  	uint16_t restart_count = 0;
>  	uint32_t restart_start = 0;
>  	uint8_t *restart_bytes = NULL;
> +	uint8_t *uncompressed = NULL;

You define this here...

>  
> -	if (!reftable_is_block_type(typ))
> -		return REFTABLE_FORMAT_ERROR;
> +	if (!reftable_is_block_type(typ)) {
> +		err =  REFTABLE_FORMAT_ERROR;
> +		goto done;
> +	}
>  
>  	if (typ == BLOCK_TYPE_LOG) {
>  		int block_header_skip = 4 + header_off;
> @@ -213,15 +216,19 @@ int block_reader_init(struct block_reader *br, struct reftable_block *block,
>  		    uncompress2(uncompressed + block_header_skip, &dst_len,
>  				block->data + block_header_skip, &src_len)) {
>  			reftable_free(uncompressed);

But it is already used here, because it is defined within the if()
block. You need to remove that definition, too, or your change here
does nothing.

...

>  		/* We're done with the input data. */
>  		reftable_block_done(block);
>  		block->data = uncompressed;
> +		uncompressed = NULL;

For example, this nullifies the local version of uncompressed.

(I had to double-check that this even compiled, which was
surprising to me.)

> +done:
> +	if (uncompressed) {
> +		reftable_free(uncompressed);
> +	}
> +	return err;

Remove that local declaration and this will be a good patch.

Thanks,
-Stolee
