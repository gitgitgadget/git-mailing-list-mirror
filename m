Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750AFC4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 19:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DD9C60C51
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 19:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbhG0Tem (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 15:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbhG0Tek (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 15:34:40 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1552EC061757
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 12:34:39 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id g15so16512671wrd.3
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 12:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NM148Yenx0aRQZg8SgylafeDfx+lHFg5qNVhfj415Nk=;
        b=oiUfK4Z5WIb2DDNaradP6kxHARb1jUXEzujxHjFPfv1QEunqtLDZkHuEM7BUMd4lKq
         KO8iyUnL11+FIV3D3lrcM7gaQgt07i/K4HLtpwHUCf3bURbAi8DSEtX2LLSVrjz0Z0Rg
         zdHcUX6cA+lNzwYFg3YCazC/0jUWhm5+jLlnzM0VAN5w7F2ZJBpFQ/zQMX72mvD1nKvQ
         z1HEDDkZTiIJd9fvkRpYPnTmVUaoFOTcvSW9W5ECDSEQkarTi3WnsjlVNKoDmb8Fw9E0
         ot5HLU5UYjYbvqzB0dvj5rRmO1fevcAtp+7gjbOVk4WNK8tJy0kemDDOXhBZh8R+IXJt
         xvdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NM148Yenx0aRQZg8SgylafeDfx+lHFg5qNVhfj415Nk=;
        b=lpLbT2xt1UHkeysM5xCD3GwQt9a1l/MonwOSFFo0Xi30anLMkJie3E3ERR7dIiHFh8
         7QEYhUgxrXI1XURhlTUl9Rjub64xtur4hbsRvLauQh/QCsesp1emes076opxf3E6AgEQ
         KYsJCv2x5kka60H0opiT/xdtDJr2WjVobtidyRsjvtFG+ZDgCbk9dRxVNNVdcv6qHE6w
         ZTyeMnPytjElvLlUsk/PBCbobO32xYRUAhBdP0K0PZnpGFm0jXOgHwwn1X19t18DLy9D
         29k2XDTdmzjsgQZ2It3fNIf8pSGCJ1ZB/b7gVWs9pIoOKuSBm19Sq09EgK0ycBNS/Bt+
         00iw==
X-Gm-Message-State: AOAM5303ddyE94XcyT8W7cjXfXGYK8WmFp/u4pYJgBCpEf2IQejJPZnp
        efBgne5LX50CVSqt3nYhKV5+okyeZjk=
X-Google-Smtp-Source: ABdhPJz7sbOz0IIfCUx3p7a0ZzwxE8nMMBqIvxO+VLT1mgwzvGMQDzZh6sXhVtVuj9/QBj1Q+f/n0g==
X-Received: by 2002:a5d:598f:: with SMTP id n15mr26139778wri.133.1627414477611;
        Tue, 27 Jul 2021 12:34:37 -0700 (PDT)
Received: from [192.168.1.14] (host-2-98-21-22.as13285.net. [2.98.21.22])
        by smtp.gmail.com with ESMTPSA id 11sm3689602wmo.10.2021.07.27.12.34.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jul 2021 12:34:37 -0700 (PDT)
Subject: Re: [PATCH 11/12] builtin/rebase: fix options.strategy memory
 lifecycle
To:     Andrzej Hunt <andrzej@ahunt.org>, phillip.wood@dunelm.org.uk,
        Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <20210620151204.19260-1-andrzej@ahunt.org>
 <20210620151204.19260-12-andrzej@ahunt.org>
 <6e02fc85-42a4-8b19-1fe7-3527c2308a24@gmail.com>
 <CABPp-BEQkUQLt-ZbwdO+ecd2rumttBUKUmh3=7LaKRxwXCkB+g@mail.gmail.com>
 <d1ef45c1-067e-abde-62a2-1df2c12ba3a3@gmail.com>
 <9f298c97-07d6-7117-baab-6a44359c44d2@ahunt.org>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <b03736e4-af30-7f91-d920-d917fc619d12@gmail.com>
Date:   Tue, 27 Jul 2021 20:34:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <9f298c97-07d6-7117-baab-6a44359c44d2@ahunt.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Andrzej

On 25/07/2021 14:03, Andrzej Hunt wrote:
> [...]
>>>> Given that we are
>>>> allocating a copy above I think maybe your alternative approach of
>>>> always freeing opts->strategy would be better.
> 
> I will go down this route for V2. Although on further thought: instead 
> of my original idea of moving the string to replay_opts (and NULL'ing 
> out rebase_options->strategy), I think it's better to create a new copy 
> when populating replay_opts. The move/NULL approach I suggested in V1 
> happens to work OK, but I think it's non-obvious and could break if we 
> ever wanted to use get_replay_opts() more than once - creating separate 
> copies reduces the number of surprises.

Copying the string sounds like a good approach. I've looked at the V2 
patch and it looks fine to me.

Thanks

Phillip
