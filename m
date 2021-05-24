Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD7EC04FF3
	for <git@archiver.kernel.org>; Mon, 24 May 2021 12:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30E8A613B0
	for <git@archiver.kernel.org>; Mon, 24 May 2021 12:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbhEXMhu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 08:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbhEXMho (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 08:37:44 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B07C061574
        for <git@vger.kernel.org>; Mon, 24 May 2021 05:36:16 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id b15-20020a17090a550fb029015dad75163dso11081165pji.0
        for <git@vger.kernel.org>; Mon, 24 May 2021 05:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=MvHz0ESahQl1XHyfiTV3+zW6g/Jn8f77uC6uBcvK0wU=;
        b=qIf3ZhKho1XLBlVI/lV7KgJwCnfAcCZB5Az/aPulPGZnQfYk73fq1v84XESwGuSqSS
         1+6y0iN/bqflVkP66kTYoraqU5E3lRF/uFW1swcOma0yJhGYPrZPNT6l/b3O53hmfkc9
         9A0uc9eGTGvf4t6gaD9FIQt10NR02PB91GWdtOy2dvLVxgE/0Tx04Cg5pThFvKTn+c0K
         4fUCQKbJgbzcr8OMBnkDd6xdcFmpqQTf5CMXsn9xUMPy6jQcoOabyCyaYfxbkQOlOg9h
         gPrW8zeoDVo4pU0ZhJweVDX5hoqDILlcmTec4aNitsu8OmrqBNcYVSNLtTfS9XPVGpe/
         FITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=MvHz0ESahQl1XHyfiTV3+zW6g/Jn8f77uC6uBcvK0wU=;
        b=YSmiiEWvwUG1PQAheVDvzKA53k6PGbrNZuvjFjuA43/H8qgf6YMaRyJ52DXn7cQBZg
         xnBvTUZ8RI/TFuWTyDNzLcryZ4nJ4yVTWCZt6t6A1hIHB5w0VOAghWhnTL3wz3Y547Og
         7TtH09s5fC/M63/9VVotxcagq/KLFhXktkUlFKhG90ddmdF9Qq/V3fy08981W3BcJswO
         lbqjj01mXYCJZoVrcWemeZclYGnjlj24sd/8J7Q3s6MywGDqDh1Vaq8VREtxjjWZQKI1
         gcJstp8MhrdkVp/M/w3/Tsr6Oqne8QhLvs1i3nj+jj0xJrjPB2kITbV2OaafvYX5KYQY
         hDDw==
X-Gm-Message-State: AOAM530gF7+H+x1+RvswyPj/dsjOjmE+zCRRu3k6zWCbHUlTPZp2YR4E
        t6BPdWBALLRGJxsA3q6NuyIOB3W1qyEoLx41
X-Google-Smtp-Source: ABdhPJz3NeB1EBbdWWDEJ1aQnma2qNDMjSeqP0M0SMH1rIs2UCTYGJuMd9DV9bku8j0hFYGCl+/0TQ==
X-Received: by 2002:a17:90a:7c4b:: with SMTP id e11mr21148312pjl.73.1621859775916;
        Mon, 24 May 2021 05:36:15 -0700 (PDT)
Received: from localhost ([2402:800:63b8:812a:adcf:8995:bb0b:8236])
        by smtp.gmail.com with ESMTPSA id p14sm12253351pgb.2.2021.05.24.05.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 05:36:15 -0700 (PDT)
Date:   Mon, 24 May 2021 19:36:14 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4 2/4] maintenance: introduce ENABLE/DISABLE for code
 clarity
Message-ID: <YKudvp0m3m+Yi1+m@danh.dev>
References: <20210520221359.75615-1-lenaic@lhuard.fr>
 <20210524071538.46862-1-lenaic@lhuard.fr>
 <20210524071538.46862-3-lenaic@lhuard.fr>
 <8e013441-08dc-fbb5-f9b9-649b2ffd78db@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8e013441-08dc-fbb5-f9b9-649b2ffd78db@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-05-24 10:41:18+0100, Phillip Wood <phillip.wood123@gmail.com> wrote:
> Hi Lénaïc
> 
> On 24/05/2021 08:15, Lénaïc Huard wrote:
> > The first parameter of `XXX_update_schedule` and alike functions is a
> > boolean specifying if the tasks should be scheduled or unscheduled.
> > 
> > Using an `enum` with `ENABLE` and `DISABLE` values can make the code
> > clearer.
> 
> I'm sorry to say that I'm not sure this does make the code clearer overall -
> I wish I'd spoken up when Danh suggested it.
> While
> 	launchctl_boot_plist(DISABLE, filename, cmd)
> is arguably clearer than
> 	launchctl_boot_plist(0, filename, cmd)
> we end up with bizarre tests like
>  	if (enabled == ENABLED)
> rather than
> 	if (enabled)
> and in the next patch we have
> 	(enable == ENABLE && (opts->scheduler == i)) ?
> 			ENABLE : DISABLE;
> rather than
> 	enable && opts->scheduler == i
> 
> Also looking at the next patch it seems as this one is missing some
> conversions in maintenance_start() as it is still calling
> update_background_schedule() with an integer rather than the new enum.

Yes, in this form, I also think the change looks bizarre.
And, it's entirely my fault.

I also agree with Ævar that 0 and 1 is meant well for off/on.

However, I still think

 	launchctl_boot_plist(0, filename, cmd)

would require some degree on code navigation to figure out what would
that LoC does.

I'm thinking about rename the function. But, it would trigger a forever
bikeshedding, which shouldn't be a blocker for this series.

> I'd be happy to see this being dropped I'm afraid

So, let's drop this patch and start a new conversation when the dust
settled.

-- 
Danh
