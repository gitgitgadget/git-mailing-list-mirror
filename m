Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A917EC43460
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 14:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FB12613B2
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 14:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236988AbhD0Owz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 10:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236173AbhD0Owz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 10:52:55 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E99C061574
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 07:52:12 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id t17so31753686qkg.4
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 07:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LBJsdYa4Aset44/sSyMe1NfeESK0/HQDDOzH+N7K4CU=;
        b=XCho3icKtnrgYRY+ueFzMKiz78wZXfhPiBsk4Yyrc7kKUTcmlHmi95dBC6lyuvR8fQ
         vi6L1CsXXezjcm43GYFWxsfYOAbMc+uTXvvADHLetUl/JtrPOKM4iIdob4I39FJ4BEUy
         aCAgqSJaofTfPcBAckqc16xCbRDNSOXPIEOSdzOyslcTekvfG73jPWahBYqfB3ngkbz6
         8TMFFWv5ZKzfEKznGdOOUoQYs3eHi8VHNLMHW88Omg6kUa93dg1MEo76HiVrXvt4YKbH
         T/whFMgfzrG6tUOROtoU9zTcf7NekZnH0uWz1g1O69c1ny9R/oucu0YSrt1pH8HBVKM2
         9CaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LBJsdYa4Aset44/sSyMe1NfeESK0/HQDDOzH+N7K4CU=;
        b=JChKhqyoYqReeky0wNB45/ypexXyIJ/JxpmU/MBFhYh/oa1aPz80Zey7rMFGyXGAF+
         J3da/R/NpZT3892IuMha9apGNDK4fDupkWn9XzXU+kaBUO7abvCP1QEEVu6O/LpDfm69
         i5ps1uJUxGDEmhRquQq0DtVrx10d80+jfxynwC9PcI/P05wFgBySPu54hhzYihyuMxf1
         nHAeztNqv0xJc+0MCMVJgpo3wn306Oo+gYYUXyf0d2WYNBbnfUcFGxzCAk6LeKxaKny/
         F9IljjTFeNXy/FdAQ4YoFcqgN6uLW8wpBuepjloMkVQcuFUUDiKqe7Wo0HO+UpLR8hwf
         oliQ==
X-Gm-Message-State: AOAM533WMi4GUfc+6zX2TCiCXR1GYaKC8ixqjpcrxyXF0fUST8USKhrp
        MRU2zcV40WdM8ALx9MA14rw=
X-Google-Smtp-Source: ABdhPJxR7uXZEfj4sJ31s7SiUiE8smbFebQeFbmJ2uOB9J3tTXyZ2kR7Ix6ZrdcDKU0hFfpowVgU8w==
X-Received: by 2002:a37:a1c4:: with SMTP id k187mr23590939qke.448.1619535131112;
        Tue, 27 Apr 2021 07:52:11 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:3839:9ece:547d:49e5? ([2600:1700:e72:80a0:3839:9ece:547d:49e5])
        by smtp.gmail.com with ESMTPSA id g185sm3016004qkf.62.2021.04.27.07.52.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Apr 2021 07:52:10 -0700 (PDT)
Subject: Re: [PATCH 20/23] fsmonitor: force update index when fsmonitor token
 advances
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
 <d699ad597d2c40cd2c0fe8abbf75b5386d4cf0f2.1617291666.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <91ee1b83-7db6-1578-9725-b3ae263ea023@gmail.com>
Date:   Tue, 27 Apr 2021 10:52:09 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <d699ad597d2c40cd2c0fe8abbf75b5386d4cf0f2.1617291666.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/1/2021 11:41 AM, Jeff Hostetler via GitGitGadget wrote:...
> +	/*
> +	 * If the fsmonitor response and the subsequent scan of the disk
> +	 * did not cause the in-memory index to be marked dirty, then force
> +	 * it so that we advance the fsmonitor token in our extension, so
> +	 * that future requests don't keep re-requesting the same range.
> +	 */
> +	if (istate->fsmonitor_last_update &&
> +	    strcmp(istate->fsmonitor_last_update, last_update_token.buf))
> +		istate->cache_changed |= FSMONITOR_CHANGED;
> +

This could lead to extra index writes that don't normally happen in
the case without the FS Monitor feature. I'm particularly sensitive
to this because of my sparse-index work is trying to solve for the
I/O cost of large indexes, but perhaps this cost is worth the benefit.

I'll keep an eye out as I do performance testing.

Thanks,
-Stolee
