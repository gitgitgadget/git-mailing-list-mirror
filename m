Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930F8C433EF
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 06:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6712C60F38
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 06:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233965AbhIQGdU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 02:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232934AbhIQGdT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 02:33:19 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07ED5C061574
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 23:31:58 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id f21so5526787plb.4
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 23:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jZm/xqguNmDg7/S9Vd8GCtXmKTTUA8KU+lk/ca04VlM=;
        b=qey9koXxdSByWnVtcuWRxPsBGFhfMbSKLROR8yrM4ipUWn1pEBRpd80P4bzAVvXLLl
         BicZCwvm7iIPBrPakYkn4khzwRqoEMpr3uGFpU/7O8b6xm0ErRFeGze19Kojoikozn7t
         IOHgE49ZFOCGvO8wqjgZ9UPLwxzGyRvKfpIhCkZBKp4JuoVc6ZFQMElm6xk3UJ260Qyq
         pW5buleTXhJpGjdKJ+4n0HnRdORM8+ovZkzu21h6nGJiq22kIqdBrsXAHIKcuOoRc+ia
         pz2uTHLPn6xWyd9ETkHvYtHD61neMp3zJ4r5hanKZ7YWXbNGKHyGUP4xqweNfgOk3Hfq
         A1HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jZm/xqguNmDg7/S9Vd8GCtXmKTTUA8KU+lk/ca04VlM=;
        b=xvaHi+a87jxOOtjuKJ4V4qjvcM6yCwD0+X9QS4Unh5UqhU4+atEud0ObHAJ+tu+Tlh
         H7eX+Y5GTyDAsHImrcpH54cWNLRy2NDKvjNEos2+p5B8EdqL9dikhAnwmMeLr7CD1YhZ
         uFq0zWliefiJZMHYmYdcX56vD/deO70helfSm8UpDODNybPpkt26+7wg/eDUhsI+EQBd
         NMTaHnsd7emP33lIljRRZnG0WlCHd4CuXvpvT5VhBxwHYKXNITjXBVqIwiRffQ+cmPeV
         XqxH+8XqWi2JK25kiiaeTzaHelAfjjqkbdYxOVSxJjX0DYOw61YiIHdDi6QmBWxbdRpt
         pGdw==
X-Gm-Message-State: AOAM532gPEK9ggX9WUiuuHAQXIQ53T26VLGsq/kDQ5pzcwx/whXd4YpY
        z4NMBHf43EXoVT9+K4wxCUshhWpqL3HDig==
X-Google-Smtp-Source: ABdhPJxQ99SIQxb1j3edKvlR3sjS+p+zFPMrmU8BGyKwGwBK4hC7klTFHc/SQqqu6693zahErplheA==
X-Received: by 2002:a17:90b:17d0:: with SMTP id me16mr10513901pjb.49.1631860317406;
        Thu, 16 Sep 2021 23:31:57 -0700 (PDT)
Received: from [192.168.43.80] (subs09b-223-255-225-237.three.co.id. [223.255.225.237])
        by smtp.gmail.com with ESMTPSA id a20sm9143517pjh.46.2021.09.16.23.31.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Sep 2021 23:31:57 -0700 (PDT)
Subject: Re: [PATCH 1/5] fsmonitor: enhance existing comments
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1041.git.1631822063.gitgitgadget@gmail.com>
 <6be687ba39d49f56a0729d3197ecbf3a64041357.1631822063.git.gitgitgadget@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <2b7f0885-bb76-d695-941d-3160a8d62ccc@gmail.com>
Date:   Fri, 17 Sep 2021 13:31:54 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <6be687ba39d49f56a0729d3197ecbf3a64041357.1631822063.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17/09/21 02.54, Jeff Hostetler via GitGitGadget wrote:
> -		/* If we're going to check every file, ensure we save the results */
> +		/*
> +		 * If we're going to check every file, ensure we save
> +		 * the results.
> +		 */

Why did you split the comment above?

-- 
An old man doll... just what I always wanted! - Clara
