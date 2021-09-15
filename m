Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2564DC433F5
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 09:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 028F96121E
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 09:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237229AbhIOJNd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 05:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237090AbhIOJNd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 05:13:33 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49B1C061574
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 02:12:14 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id bg1so1200383plb.13
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 02:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZhcEBK5MZ7GoO/YIJo1pJMeURrKKO9umMBTcYUI5vMg=;
        b=j4Oxla4DgM+kYo4sPH1VRMtmde03aAAjO6P/+A9pP5vR8RxDMbHMJT73IgsaPud7Lf
         wxTv1lMmy4dui5ryloh5ubcz86QJ90beEiEW0v+L1n9wNKZc4xgHT1kbVeNGwT/G4ez2
         gcfFJWx0K0C72AzetNEZwuqo8c+Loc4zhlkrCFcxgTMheA/GuGOQo3sYKqAmg6b1ifzZ
         qKx/LDwZLbZa4gNrgHD8yyj4jjV81XQoPMYBrkgGj2GfIizYWyguRPyNQ9IVcpekUcMs
         l3d6Dz1EOrzI5klFey8olX8isrwpe7V34iOaQ7h4mvBM7pbnsWbdIcKyJ3/tx8Sw7SLZ
         CVaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZhcEBK5MZ7GoO/YIJo1pJMeURrKKO9umMBTcYUI5vMg=;
        b=q+DgzGNujfore3YxoVT8c6Lc/KiC8s4SP6Fo6OC7s562U3Vkv5RDfGh8jrdE1tVUdM
         R/enI3NSREuuEmoKnBc14N5YjL9uA4WB/Hk1YK9/z0YjXnBO1fPV87tLCUtsvsXbnA5C
         Rb1xPDXQI/svnfJ+8TMFs2MBCFOeNvgtlMsAjQyZpair+x2eHb8aDaLje9kYpSsl2GQr
         7gwb7UN2juMluI345LNFCkCBX7D36Saj1FMZEu3YChoZrPM7pV/Iay9Mcz6GGLkR12sg
         3xSRLUG0QE3BZiWXfVefvKK0/aSrNV0McDCvUKpXjTIG516JrrXGSf/qeUqlF4EXymKq
         Xnbw==
X-Gm-Message-State: AOAM530QGLMt23sXrfrIl1QHjBfhv8GYGLhMI14XeirbW3d9mWEDTE03
        Y1KxD98iozjZXSdqJyh2vaQ=
X-Google-Smtp-Source: ABdhPJy/UlGRaid6P72u8WBfk8XBsBZ6Jwyb/IazymurxPHS7vPOsSH6yDs5/5JgYNt8CKgkM7K9Yg==
X-Received: by 2002:a17:90a:7c42:: with SMTP id e2mr7284580pjl.132.1631697134344;
        Wed, 15 Sep 2021 02:12:14 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-4.three.co.id. [116.206.28.4])
        by smtp.gmail.com with ESMTPSA id b5sm4176536pjq.2.2021.09.15.02.12.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 02:12:14 -0700 (PDT)
Subject: Re: [PATCH v2] pack-revindex.h: correct the time complexity
 descriptions
To:     Kyle Zhao via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Kyle Zhao <keyu98@qq.com>,
        kylezhao <kylezhao@tencent.com>
References: <pull.1039.git.1631695337775.gitgitgadget@gmail.com>
 <pull.1039.v2.git.1631696964072.gitgitgadget@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <67cfff14-8158-6401-b0f2-1f6de37c5815@gmail.com>
Date:   Wed, 15 Sep 2021 16:12:11 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <pull.1039.v2.git.1631696964072.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15/09/21 16.09, Kyle Zhao via GitGitGadget wrote:
> From: kylezhao <kylezhao@tencent.com>
> 
> Time complexities for pack_pos_to_midx and midx_to_pack_pos are swapped,
> correct it.
> 
> Signed-off-by: kylezhao <kylezhao@tencent.com>
> ---
<snip>...
>   pack-revindex.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/pack-revindex.h b/pack-revindex.h
> index 479b8f2f9c9..74f4eae668d 100644
> --- a/pack-revindex.h
> +++ b/pack-revindex.h
> @@ -109,7 +109,7 @@ off_t pack_pos_to_offset(struct packed_git *p, uint32_t pos);
>    * If the reverse index has not yet been loaded, or the position is out of
>    * bounds, this function aborts.
>    *
> - * This function runs in time O(log N) with the number of objects in the MIDX.
> + * This function runs in constant time.
>    */
>   uint32_t pack_pos_to_midx(struct multi_pack_index *m, uint32_t pos);
>   
> @@ -120,7 +120,7 @@ uint32_t pack_pos_to_midx(struct multi_pack_index *m, uint32_t pos);
>    * If the reverse index has not yet been loaded, or the position is out of
>    * bounds, this function aborts.
>    *
> - * This function runs in constant time.
> + * This function runs in time O(log N) with the number of objects in the MIDX.
>    */
>   int midx_to_pack_pos(struct multi_pack_index *midx, uint32_t at, uint32_t *pos);
>   
> 
> base-commit: 8b7c11b8668b4e774f81a9f0b4c30144b818f1d1
> 

OK.

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara
