Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CD861F463
	for <e@80x24.org>; Thu, 19 Sep 2019 20:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732829AbfISU70 (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Sep 2019 16:59:26 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41901 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732070AbfISU70 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Sep 2019 16:59:26 -0400
Received: by mail-qk1-f194.google.com with SMTP id p10so4914891qkg.8
        for <git@vger.kernel.org>; Thu, 19 Sep 2019 13:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kZvUMlCoBuyEDthI3xpY0WsP/yJ/AOWV3j2xRiY6gDs=;
        b=oTqC+iufOZiVlEdQQWYxcxdR35aTYFkrs5z0lNAM7w8jheEihSAAxg2bkg4EqnM/yf
         mM6w7/ZJvOJKMx+GiNYqTqawd8/BuheQyJO44/3iyMwtSseqmRKUXbiRU5QMldtJqJNo
         bKJXJ8uK8yQNsM6kXJ7GEy1cLaiRCZZH6f0XiGlAVHobQm+Hhfx/2qNNjDv4sDCUA1Rp
         p4cttK6K73vC54DVVf/7kYZZlAdBM89PzPKLTHEnkaz6AFAERK9oXzzHaCyujs17P93H
         nKUZZWegobW3Mzp6YMBCjga3kfIOwJRmSY8PLSYqfMfQC3OoAJcdi/iotpf3ne8w+8VR
         dCJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kZvUMlCoBuyEDthI3xpY0WsP/yJ/AOWV3j2xRiY6gDs=;
        b=R4j9i1TNM3Zz4qMLAki5hlT00xxMvO88RZJw6Cm6DIsIo9alt6KOGXmdcpqTjGZ6ZO
         E4pemp5fY4sOCcDMYLrWdOH7iD5N65StMCmEUUoQOOPqPGqjcK9nCQ4h43SyoLAA91oY
         OZ2Lxafcs7N06ud93uAB8mZrByimjIpp++zehHk83MOTGLWwojnrsO1wzmE1DU710eel
         +lvyXQ4emsYRNLQHaJusiz/OgpBF6ZriT/Pzlq8VWWEUYn1h+ahi0RROOMvJkvuCMWR3
         yXEeT4G9oBNAwhtTBmEH+NVxI1kUEXCBEg2XFeWsatN/edExSU4WCziF/CQHagHhIhEr
         B2Pw==
X-Gm-Message-State: APjAAAUrmBk2m5xTTN+SalPzojhVSbcJAVe8VSSt01+oXuebnx7nBVe4
        dXiawsVGTio4YEhdSlljP7Q=
X-Google-Smtp-Source: APXvYqxRX8Db4CshaqLE5tPi76HQecjZq4iMOjQNXmN0bo4ShYEeIslN8No6Bd0KBeorzGcA8fZzCw==
X-Received: by 2002:a05:620a:16da:: with SMTP id a26mr5087990qkn.412.1568926765457;
        Thu, 19 Sep 2019 13:59:25 -0700 (PDT)
Received: from [10.0.1.19] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id j17sm5066238qki.99.2019.09.19.13.59.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2019 13:59:24 -0700 (PDT)
Subject: Re: [PATCH v2 09/11] sparse-checkout: use hashmaps for cone patterns
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.316.git.gitgitgadget@gmail.com>
 <pull.316.v2.git.gitgitgadget@gmail.com>
 <95a3285bc6021daa236d98d7e1bbdc5c45fc73b0.1568904188.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <6b461ad3-164d-46ff-4a68-99f8e6562a72@gmail.com>
Date:   Thu, 19 Sep 2019 16:59:23 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <95a3285bc6021daa236d98d7e1bbdc5c45fc73b0.1568904188.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/19/2019 10:43 AM, Derrick Stolee via GitGitGadget wrote:
> @@ -848,6 +953,10 @@ static int add_patterns_from_buffer(char *buf, size_t size,
>  	int i, lineno = 1;
>  	char *entry;
>  
> +	pl->use_cone_patterns = core_sparse_checkout_cone;
> +	hashmap_init(&pl->recursive_hashmap, pl_hashmap_cmp, NULL, 0);
> +	hashmap_init(&pl->parent_hashmap, pl_hashmap_cmp, NULL, 0);
> +

Just a head's-up to anyone looking at this series: this is not the
right place to set use_cone_patterns (without passing a flag or
something). This same path is called from the .gitignore machinery,
so if you have a non-cone pattern in your .gitignore you will start
seeing warnings with core.sparseCheckoutCone=true.

I figured it out only via integration tests with our C# layer. In
v2 I'll fix this and add a test to make sure it stays fixed.

Otherwise, everything is working as expected.

-Stolee

