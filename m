Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910C4EC873E
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 16:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244000AbjIGQ6a (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 12:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245074AbjIGQ62 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 12:58:28 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371641FE8
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 09:57:59 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-53fa455cd94so915763a12.2
        for <git@vger.kernel.org>; Thu, 07 Sep 2023 09:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694105809; x=1694710609; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f4AocqqsUqqRBeGnNtqeujHPMGZz+7lQsPFiPokXrBY=;
        b=im9XDmrOxmWqtRo5TRuImdDdcCwgObru70/aRxpsuC/8G4QomfSy7FgZxiR4UcsGJ0
         Gct0JFrQ/hbVPtnneY4rZIUdCjp1wp6MYUwSKHKe2XBljWRSl/6Q7pojUmrHl48VWHje
         wfxvYycEIP51H6i/AoyGkAQGkD61enZkhe9uo3Q1oZUfYayTAQdd2HUcdllAPbww7lEj
         dBmbf3f3GBmm1GVPMZgmY/gpcqe51iqTPaPMdOZ8ozZkak65BmF/UYw6YrmhwQie0OLP
         ODas0qM0ySHPewfDPc+62ceRjCqY7D8SjHwYPkbsG8bnzqKZr6sOlhWlC0EakeJjfRDr
         Hk9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694105809; x=1694710609;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f4AocqqsUqqRBeGnNtqeujHPMGZz+7lQsPFiPokXrBY=;
        b=L0AtqPLnvUhzRF5/Wba8sUnyS+oVDQ2aMKtRmUnissN3Q7FesBgyoDMZX4OqyByz4C
         ENgrv4JVK+xQQfKFIRWQqOW2JA5bqmzM5ai6/MVbD0qytXybiNg70kIAZO1DQVXh7TWw
         CgzmOhL+ILaHa+eJOI4Ag4mZ7N8pkQNVeyORCQeCyDPeO/pRO36aRC0wZBdmrxZ94Qhs
         oaufa4q7uLq2ZeUTgicDQBaeSeET3WdBYNJYX7AEsSNxHa9zRI2jLXnoQQthlYa/V2me
         iebLtyae0tiIfwGqFIwIdWkL5DnZ8ycs5cjHZPrEulsbjokIvV+4aqqNnBRxNHZVkuul
         MO5w==
X-Gm-Message-State: AOJu0YyINiQcRKEV5tv56BN9j0aoW55rqGp65TcjTZeC+H/ap+3zxH2U
        Ekd05tCbgQlECHMhTyP920HO4BCohTY=
X-Google-Smtp-Source: AGHT+IFkESZYRrwXaOG/TWVkIC+ZB1jkkiQGhgTTW8MifmtC/ORluJusq0iCfqopcWBeEeSrzFcaNw==
X-Received: by 2002:a17:902:ec84:b0:1b9:d2fc:ba9f with SMTP id x4-20020a170902ec8400b001b9d2fcba9fmr19862786plg.11.1694077591786;
        Thu, 07 Sep 2023 02:06:31 -0700 (PDT)
Received: from [192.168.0.106] ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id x21-20020a170902821500b001b8953365aesm12321100pln.22.2023.09.07.02.06.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Sep 2023 02:06:31 -0700 (PDT)
Message-ID: <919e4a91-18c6-f3f2-b7de-b407f791cc14@gmail.com>
Date:   Thu, 7 Sep 2023 16:06:16 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [bug]fatal: fetch-pack: invalid index-pack output
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     mingli zhang <zmlfoolishfish@gmail.com>, git@vger.kernel.org,
        Jonathan Tan <jonathantanmy@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
References: <50B3E989-0405-4B05-9940-D3943C62260A@gmail.com>
 <ZPHHuiFn3v06hhVe@debian.me> <xmqqwmx9q1he.fsf@gitster.g>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <xmqqwmx9q1he.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/09/2023 23:53, Junio C Hamano wrote:
> Bagas Sanjaya <bagasdotme@gmail.com> writes:
> 
>> On Sun, Aug 14, 2022 at 05:09:13AM +0800, mingli zhang wrote:
>>> ...
>>> I use git 2.36.1 on MacOS Monterey 12.3.1
>>> ...
>>
>> Related discussion is in [1] with the fix for OpenSSL users is in [2].
>> Please test.
>>
>> [1]: https://lore.kernel.org/git/ZPCL11k38PXTkFga@debian.me/
>> [2]: https://lore.kernel.org/git/20230901020928.M610756@dcvr/
> 
> I somehow think they are not related.  The EVP thing appeared only
> in Git 2.42 and the report says 2.36.1, which was released in May
> 2022 and predates it by more than a year, no?

Ah! I missed the point.

mingli, can you test v2.42.0?

-- 
An old man doll... just what I always wanted! - Clara

