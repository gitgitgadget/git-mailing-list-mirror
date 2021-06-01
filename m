Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3778AC4708F
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 10:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1927260FDC
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 10:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbhFAKsD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 06:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbhFAKsC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 06:48:02 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B879C061574
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 03:46:19 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id 76so13684236qkn.13
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 03:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=f0d6D+reFINJm6q1ZKjQAyikywtx4HejA1yM6enexHM=;
        b=hLO89lExUj99yCqSDyJo+hU53hsKh5B9389SbNxPgtSUgBzDd6Z9lE4T6LKOIrge1d
         SgBLPsMwm6H0E12bFHAkkxuqlzVZRWcr/OtwEc3p+slNh5NgtckKnfqGGXKPQYHxOGEi
         IuQbb0Rb8z0BWxuUWUJPcCPBNm2HXxnWwew/a4gIPvJffCgi195L9cE9ypg3Iq2anAUV
         gr8FP3DTvA1zgixIcd1kMDfzj8pThsikecvXE/E/beZNdlXIKUnkr2CpBMSDX6pMJZBx
         39H5pMesv0yEfFFPHPIMBcPCHt9j+Q8OoecRVkvuSirbHrXXTEcS//NeossQldUC8Cph
         1z5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f0d6D+reFINJm6q1ZKjQAyikywtx4HejA1yM6enexHM=;
        b=Qw9SN9+Pr6Z1OMFnvkuuKjh/A4wh8lmiMB2gWw2m8FqDOUNM99Ft4AFBc3oZXZRxqq
         fw7he5zCHJlRtJYjqwe8jXv0eMmC/mBWRCvGDdxLLEDB5zv4rcKE9jmps73GPLqLne52
         EW1gkwRXvm47jx1V9AikhGI7EqvmjOkJZnDLhpLmTgU38HV57EaE71y9BURkh6Gkv2uZ
         /AeWwhcjFEXEu7lcc3iqvElNWQaI6WS6hytIxqTU44uS/OyEcVRPi9JAgCO7sOkgSOtO
         K07ArW1RwfXJ3+EyqrmhzqptW+aZurhBNKlK96z46dcknfNNr/VH4mp7jfSgzXhBIaZc
         z94w==
X-Gm-Message-State: AOAM533eyfZuRJ7LtWTO55PGHw1YVn27zntzQV3X2jINsUtfvNhb5mOB
        TPU1m6WiIFTle8ZcqHQG9cc=
X-Google-Smtp-Source: ABdhPJx0fk1gy+lYLqgq5nHwYbI8jGxUsv2O4OEAsLJUQePmZI17IB4tElJowpgropoqYihRAZnqYw==
X-Received: by 2002:a05:620a:2a0f:: with SMTP id o15mr20633721qkp.295.1622544378580;
        Tue, 01 Jun 2021 03:46:18 -0700 (PDT)
Received: from Derricks-MacBook-Pro.local ([2600:1700:e72:80a0:e809:8add:2f2c:424e])
        by smtp.gmail.com with ESMTPSA id 42sm10035098qtf.37.2021.06.01.03.46.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jun 2021 03:46:18 -0700 (PDT)
Subject: Re: [PATCH] clone: caveat note on converting partial clone
To:     Jeff King <peff@peff.net>, Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org, dyroneteng@gmail.com,
        levraiphilippeblain@gmail.com
References: <20210529120730.38472-1-bagasdotme@gmail.com>
 <YLQH7i5IPSdBnDko@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <08cfd066-dda5-40a7-8467-5e621e0ea619@gmail.com>
Date:   Tue, 1 Jun 2021 06:46:17 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YLQH7i5IPSdBnDko@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/30/21 5:47 PM, Jeff King wrote:
> On Sat, May 29, 2021 at 07:07:31PM +0700, Bagas Sanjaya wrote:
> 
>> Currently partial clones can't be converted into full clones, because
>> there is an issue where the remote can't send all missing objects
>> required.
>>
>> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
>> ---
>>  This patch is based on "clone: document partial clone section" by Teng
>>  Long [1].
>>
>>  [1]:
>> https://lore.kernel.org/git/pull.745.v5.git.git.1614695133486.gitgitgadget@gmail.com/
> 
> Wouldn't:
> 
>   git -c fetch.negotiationAlgorithm=noop fetch ...
> 
> work?
> 
> IMHO that is not ideal, and I would like to see it work even when we
> provide "have" lines to the server. But if we are going to tell users
> something in the documentation, pointing them to this technique is
> probably much more helpful than saying "it can't be done".

Any workaround is better than none.

At minimum, I would expect a summary of the discussion instead of
a pointer to a mailing list thread.

Thanks,
-Stolee
