Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B76C636CA
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 00:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5D316109E
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 00:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbhGSAyY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Jul 2021 20:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbhGSAyX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Jul 2021 20:54:23 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20620C061762
        for <git@vger.kernel.org>; Sun, 18 Jul 2021 17:51:23 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id o8so8709800plg.11
        for <git@vger.kernel.org>; Sun, 18 Jul 2021 17:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Y7oLXTefGyRGrlqXK3spxwXedfmCUtPhAvEHH6DwlGE=;
        b=LNYvXI3Ff5iykgZf2okveQYG7PW6/1ir2E4lwJ0o1R15Yh1CeMY2kYakNrRW0ZM+ul
         QfjHOv55GJR85WtOakeHs+GLFff+tss2zH5GbdwNdSewCiZtBEq4cMe4A8Y6sx35OQba
         afWSP8D/5m+fwagCRtXquCuKAUKLs7+qqcfB8KuJBVUUVOi2gViJmambRlJTaoBKsyQW
         ElR01xclC/O4ofue/3M8tcfjLAfG4P+kFo1G94OY3LRtOqfjiWH+TYH8ud9eBVW0s+0V
         W5TNyue2VoHmVzRTAFDQbuZUlyDNkkgj7PaJHtuOH7Nem/MaiGvs6nNZQGEi9o1Ngv3W
         09mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y7oLXTefGyRGrlqXK3spxwXedfmCUtPhAvEHH6DwlGE=;
        b=f7wD5l5G9Kg98XEMVt9TrPkZ0a/e3eSz1X/pDZF8e3GTv2ojgf2X7m0bzpc3YOS+dK
         XAxevbsiJy0c6pweYpt45u4IqGSHcXuL40CxxnSPtof+L58QM/IprWBU6vc3zIlo6bm7
         K/dr+4zVn6tObu4iFeC6rozAX/sLDP05zKfvzchJz7oTKPLmlSOutllFinGu4iqCqlUb
         ZFbeeWToXaIRKkaPbM72Y6+1dnH9CZghtysBuOECoIn7kIzxEE3pye8JouP0H5n538kL
         +70tLF32JBe6WPlu68vH63exgHvkms5hoHt2Dp9S95/kA+LTEj0b41Vp8BaKvkNDITmG
         Kmxg==
X-Gm-Message-State: AOAM533ZoHlC9q5Y13BnSWD4r1mOIFTcywunGsdhd9Ye/9bbzazlLbdR
        97YHyZYixjC4TWjME83A7jE=
X-Google-Smtp-Source: ABdhPJz+zLlVl1WimopEZfO3w20XjWXgLfbcpX6xQJK3g2ED8fqMousqyQKGgnZhmQmTqLMQwo1GFQ==
X-Received: by 2002:a17:90b:1109:: with SMTP id gi9mr27428589pjb.61.1626655882629;
        Sun, 18 Jul 2021 17:51:22 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-5.three.co.id. [116.206.28.5])
        by smtp.gmail.com with ESMTPSA id 37sm1711302pgt.28.2021.07.18.17.51.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jul 2021 17:51:22 -0700 (PDT)
Subject: Re: My Git Dev Blog - Week 9
To:     Atharva Raykar <raykar.ath@gmail.com>,
        Git List <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
References: <ED260A04-153A-46D5-8A84-CF517085DEC9@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <fcb14e9b-c76d-9a54-fccb-d66e7de04f7a@gmail.com>
Date:   Mon, 19 Jul 2021 07:51:17 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <ED260A04-153A-46D5-8A84-CF517085DEC9@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18/07/21 18.59, Atharva Raykar wrote:
> Here's my latest blog post:
> https://atharvaraykar.me/gitnotes/week9

You wrote:
> Interact more with the community by asking questions in your patch cover letters and replies to reviews.

Did you mean something like [RFC PATCH]?

-- 
An old man doll... just what I always wanted! - Clara
