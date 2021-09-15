Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73F0C433EF
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 04:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF3FF6103C
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 04:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbhIOETG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 00:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbhIOETF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 00:19:05 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70AD1C061574
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 21:17:47 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id x2so1471864ila.11
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 21:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OTKtNCW2yGNvkQwMZZXvrtugcNHPJ9ycqx1jcxqo19s=;
        b=H0uY+8cXQ2Qc9nF06gnOoKTf3Nzr914yTKG92uCi0at0tTlzFQr6mxiiDc7LZA4xDk
         1osER79CULMplMni81fIeJ7CAMEDD+RiIBJQtE58JLb028MUEW1W59dIlSdSJ0Uu5gDc
         GU8ZttDECzs7ivhHuUg5Yaqo0CVKgeDfV4MG9A1NKzT4J22y0el6ukrWWfNQIzYyGHpB
         BItxL24NwOBG3IL6sI9nUdJhluUKHPu0QxVE4hWRgGqUE3b5E681nyhWd5dW/vkKwWTn
         sBS/dc7l5CD/++Gut5khdO+Xv7zQ5jFNWKS7W2hYgTnFUSAp4KF/IQKNvzoB5PS5AbMJ
         yiUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OTKtNCW2yGNvkQwMZZXvrtugcNHPJ9ycqx1jcxqo19s=;
        b=ki120rPMeyl5zOXnyzcLnsJrQVuiSJfr79nD7ybl1uQSmSuI6J9tZH3XFaxWWBWCZz
         BaGZy3A7yTVZmk7m44EYw91ERm1jD5GiOg6N1vlS0LV3SdTybhK+B3UJaKN7ujjNSzLF
         BcKqs404n9sFlMfX+uZs7avS5aTM1fElYqgR14UDea6yee2t8RjuRg9qDv3CxjXNMQFh
         a+GnZ4yma+aOFfqKfhQQW64t3LLARf9QXI5/KvtQb5aAvFqk+4I+KQlpxhyxDoViKNuI
         1yfKL1pd3aDMQf9Hjogg5WoOG3CxG4zjawHAQXTyThinGPshkJ+WZFOsYkuJXX0u+oXK
         9fBQ==
X-Gm-Message-State: AOAM532IviKhbQiTKI8UITdwXiSnlB35rU29XF/qbIF5+gRR6LKzHZbZ
        n5Zo5ZK2o+FnAGzoRWSGolutvsH8V/Ik4UJd
X-Google-Smtp-Source: ABdhPJxLvh1iI/8QkheauICYiZPOndOuscrP8dA59UT+ZzNBlLPzcXudYKNmVq/ASF7P8fg2drOeeA==
X-Received: by 2002:a92:c145:: with SMTP id b5mr14195172ilh.203.1631679466895;
        Tue, 14 Sep 2021 21:17:46 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x21sm7602526ioh.55.2021.09.14.21.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 21:17:46 -0700 (PDT)
Date:   Wed, 15 Sep 2021 00:17:45 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 0/11] limit memory allocations for v2 servers
Message-ID: <YUFz6RqVaBunxJ7y@nand.local>
References: <YUC/6n1hhUbMJiLw@coredump.intra.peff.net>
 <YUE1alo58cGyTw6/@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUE1alo58cGyTw6/@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 14, 2021 at 07:51:06PM -0400, Jeff King wrote:
> Here's a re-roll of my series to limit the memory a v2 server is willing
> to allocate on behalf of a client. See v1:
>
>   https://lore.kernel.org/git/YUC%2F6n1hhUbMJiLw@coredump.intra.peff.net/
>
> for an overview. The existing patches are mostly small fixups pointed
> out by reviewers (thanks!), but I did take Martin's TOO_MANY_PREFIXES
> suggestion in patch 7 (without the change to the name of the constant it
> seemed too clever to me, but with it it seems just the right amount of
> clever).

Thanks for this. The two new patches look good to me, and I took a light
skim over the ones which were modified since v1. Everything I saw seemed
very reasonable to me.

    Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
