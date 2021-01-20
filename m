Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9BFC433E9
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 15:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B31E23381
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 15:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390965AbhATPxa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 10:53:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391155AbhATPvo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 10:51:44 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C23C061575
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 07:51:04 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id f6so14561259ots.9
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 07:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RI71Uiz5xetXDKgugkLiqFABBHMbcXEn63sLM7atCt8=;
        b=GIBT1+Cis5DTfVJTTtHvtycMyncvaX4lPYnyI9qZMaa2MB3BCCYz6AXZjdJCMUfkS8
         LC+dT+BqkvJidJXVeheXCmW3Duy2IWyFhHU4CGdFD776+OCpjqjuJ2SzgUcrx0Q6bJGb
         /G7HjBc3r9dmGVJwhUu1T4/I7im60KUAEvTENJQihXMY/ohXkR4/pFK7osvm/K1MZOju
         kOyVfOEhv/OUqbCiQcfrDZQR5hAs/bAOqmH97g+s4ByKOT42TuxkZeHc1Hbm/tPNdXRM
         2yqJXwDU/Bnd/fwtGd/l0hk5/jJOfOWFvYDjXAAI8y6PnnU2QnvqkOExhLoeJfvlTKjt
         l0qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RI71Uiz5xetXDKgugkLiqFABBHMbcXEn63sLM7atCt8=;
        b=Xz0ARxaGQgOOuBjvkIlcmCGViAXs3jXQTH071UCZOc6D87bgbX79hIKXORo08ZWHdR
         zlGk2ij/oUzZHoY/lDm95w0cfwGdm9Hq/VqujFMCIWtMXC6DmmSuIwAu6mTNbaCD0ux0
         +geA12Kv/I65dElezI1YRblsND4VdgjAYjYGJLo4q7WiR/ouBJTXJA2FpEUtllTbij6V
         YxMxGxUMhmE04UTLqPLQMabfONikJnRqy8U6plDbxDVcT4vWpRJJzDaWFMNQh5qCGeX4
         R+JJ6KLsQl/IG5L6NObHQyd5KniF5MNznBqRUO+J3RGkF8aLfi5qBvDULWqWYzs/l1UN
         Y0Eg==
X-Gm-Message-State: AOAM533i51yh0NuMfMSNWZPuk4OiQpNelTR6BuQrnf7jCI623Pwhs6by
        lFn3/RjYZr/gAjxFNJ2pRw0=
X-Google-Smtp-Source: ABdhPJx7fWleIkmOCdNce9MrDMSPWvKq/ZTYim1aNG0IcSOlqp5IGeO3cKrgx1Jlr82RoCb1rgArXg==
X-Received: by 2002:a9d:4e8f:: with SMTP id v15mr7178502otk.121.1611157863848;
        Wed, 20 Jan 2021 07:51:03 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:710c:cecb:a7d:75ab? ([2600:1700:e72:80a0:710c:cecb:a7d:75ab])
        by smtp.gmail.com with UTF8SMTPSA id j11sm483780otl.18.2021.01.20.07.51.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 07:51:03 -0800 (PST)
Subject: Re: [PATCH 09/10] builtin/repack.c: extract loose object handling
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com
References: <cover.1611098616.git.me@ttaylorr.com>
 <a808fbdf31afc9ad9ba0ab27ce889e5a2d1a01ae.1611098616.git.me@ttaylorr.com>
 <98c65017-8c22-a21f-0e86-a15d91bd7f70@gmail.com>
 <YAg/WU01bvfsMxgX@nand.local>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ae13318c-f894-6c9a-414c-e7911abdef76@gmail.com>
Date:   Wed, 20 Jan 2021 10:51:02 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <YAg/WU01bvfsMxgX@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/20/2021 9:34 AM, Taylor Blau wrote:
> On Wed, Jan 20, 2021 at 08:59:48AM -0500, Derrick Stolee wrote:
>> On 1/19/2021 6:24 PM, Taylor Blau wrote:
>>> 'git repack -g' will have to learn about unreachable loose objects that
>>
>> This reference to the '-g' option is one patch too early. Perhaps
>> say
>>
>>   An upcoming patch will introduce geometric repacking. This will
>>   require removing unreachable loose objects in a separate path
>>   from the existing checks.
>>
>> or similar?
> 
> Mmm. I had imagined that this would be read either in the context of
> this series, or by someone in the future long after 'git repack -g' had
> been introduced.
> 
> I could see that it's confusing, though, and I do agree your wording
> makes clearer that the option doesn't exist yet.
> 
> I'm happy to send a replacement or reroll if you feel strongly, but in
> either case I'll wait for a little more review first.

Definitely don't rush a re-roll for my nit-picks.

Thanks,
-Stolee
