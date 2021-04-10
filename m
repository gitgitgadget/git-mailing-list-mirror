Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B2DC433ED
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 01:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDF85610CD
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 01:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235302AbhDJBDm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 21:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235268AbhDJBDl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 21:03:41 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C41C061762
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 18:03:26 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id l12-20020a9d6a8c0000b0290238e0f9f0d8so7405917otq.8
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 18:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=qyCaHiRnQOm4yGMfbi60w21zZrl0QKRUPnoP4rwn3t8=;
        b=DSyrcJsKcNw7merYnI6yue5Dy6WxaTUyNAYzO081CPsADeQkTgpUWx8bnZbKVjM5uD
         6TVBfqwtreRbcDH/hKc0zLda0AQSSCvatEo5Rlw6bfiZdTxgC9WNn8ljr4Qg1Yl8U/V3
         wqLLe3AygfYWD6YIzBdxuEjWnmeMeYn+nN6E/g+C9h9sGZOoUo9HtVX1BRllzoerfXj5
         fVUlu32idZ+4/p0LWpRdp5gEdFwNJWlkiFaoSG3S/VKVKGSyfKA0BzFQp02Fg9LNNJNq
         s0//2UglfJadS+SMBdMwfWnxWuZUFnd50je4N1GqdFBuLYMqJYfGbeBpoENlzmw2dBLK
         ixFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qyCaHiRnQOm4yGMfbi60w21zZrl0QKRUPnoP4rwn3t8=;
        b=SNpWrxfj/Xs2OGsPV/dHmiPblfIyeg/m/kRzb/laTnMX45Zveu/6SBdsfEiR0O6Evc
         3AbbY4wKyLzwg6Z8CAz3VmjXpIiWnz2A4gXv/n2xz1SkN1MYt8KuL4n9x9zEzdH3ZSBX
         7CiAmNOjSwd+L9u4MZgxriC4rBblanbYa7FSo+tOJCYD/u2o53qQNVwJBxiCD7mR60rU
         vZtggWqRvEbf9PyUadqgDssHpe21PjqkWHfZ7s/5sn7jJMfhKsKwhmNuojydfJ/sTZf8
         DBacdaaSzHikLRPWc79RE4yDCS2LCnNRhuCI4M6vMDSeJHP3gRpeo5Y7aq3CW7rjtH4W
         iifQ==
X-Gm-Message-State: AOAM530HC6DZ9LDqyB2ld1A6UzzzO64UanNzk+Olex48xXuHW/aL94z+
        hgSz5XgM9ApmzeJQcW9Kg1Jpoz1EDF4DIA==
X-Google-Smtp-Source: ABdhPJw9yOBaQ07S+q+3Zr+Kfp9fukFPEIeDkvsVNW3o0SCTgcVS3kKVC8i/R9mtuCK72ADiattumA==
X-Received: by 2002:a9d:2e1:: with SMTP id 88mr14373489otl.120.1618016605280;
        Fri, 09 Apr 2021 18:03:25 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:e556:d73b:6b67:5b9f? ([2600:1700:e72:80a0:e556:d73b:6b67:5b9f])
        by smtp.gmail.com with ESMTPSA id l191sm865134oih.16.2021.04.09.18.03.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Apr 2021 18:03:24 -0700 (PDT)
Subject: Re: [RFC/PATCH 0/2] here-doc test bodies
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <YHDUg6ZR5vu93kGm@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <42b187cb-6417-0353-cf63-c6379be53208@gmail.com>
Date:   Fri, 9 Apr 2021 21:03:24 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <YHDUg6ZR5vu93kGm@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/9/2021 6:26 PM, Jeff King wrote:
> I've been wanting to do this for years, but after getting bitten by a
> misplaced quote the other day, I finally did. This series allows you to
> do:
> 
>   test_expect_success <<\EOT
>           something 'with single quotes'
>   EOT
> 
> Thoughts?

Odd. I _just_ hit this for the first time today. I didn't know
about the $SQ trick, so I just modified my 'sed' call to drop
the single quotes from the string I was trying to match [1].

[1] https://lore.kernel.org/git/36aa6837-722c-9ef0-84cc-77e982db9f6e@gmail.com/

I think this is a good pattern for this kind of thing. I
imagine that if the test itself needed heredocs, then they
would be interpreted correctly when evaluating stdin (as
long as a different identifier is used).

I also like the "EOT" pattern as an example.

Thanks,
-Stolee
