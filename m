Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D748DC2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 15:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A169E206D5
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 15:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u8Shwrpv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbgA3PUF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 10:20:05 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36764 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727186AbgA3PUF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 10:20:05 -0500
Received: by mail-oi1-f193.google.com with SMTP id c16so3853359oic.3
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 07:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DLfhEz6k9r8p2VvZOxcGzxHz/5Zzenhe9G9LmrEq4RM=;
        b=u8ShwrpvsOhAGGG2FTLvOd/sWbkXt5SMuOM1XL0RGkPZuo2zIMXTUJ/vuqsAZMqR3I
         GkemecN2WVujq6QvNl6lVc5rr83inn/w2h18cm379fpdwmIm0qVc4CMi/Qbg3z+PvxOZ
         cYWQf/wiC8ct1yF/aPhLJONMEMt8NjI2ZCuc9Kga05yFA1nQFSzYCtdm4dnIQM1G6oCY
         PaeyeeboWUqIGcbTrRb2n4Vu4fkJTMzSG0UNEsbtql8e8C5eYAyA3VyW8RyafALcnIxB
         5LMn6JgMNZpC64mmUV4zIiSSZVKYDKfDBoLDZqIBdxMyveyhY2cj4B3f/PZlcal9lELu
         mDXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DLfhEz6k9r8p2VvZOxcGzxHz/5Zzenhe9G9LmrEq4RM=;
        b=nW06IbYlQkHAGjpWJyCXzYTkji+dZ83ZcfE1YXnFXoNN3z3wTH87PmPWX4JD16cQbu
         K7p9okUGTijXrnKwWqNcHRiw7FMGVulhgxuhadEDl3qJ+nd7RiCW2b1ZZUkQ+F9fcqFn
         +ZYRCRmX5TLGfxhgXCAqKFbI24rEi46+YDdIHOZjevVJGmymdutNnCqlLjn18fZ174uf
         SUOk0GwM19qFTbXAmQG/jywc2jDSgFzykfYOS2hlhN+8TJnbW52lKX6PTjPm331DbbD0
         EjmK89xvBaHetN3BGxINFOgjvnqrULNevOOxkHYifhmELCA0zFCfIi5BlbBupKLrTfKw
         wV9A==
X-Gm-Message-State: APjAAAVmKwOyXBSrd3taGx8txeEW8xttCF8tXItz9GRuUW1I6A0EszMe
        9HDeVTZkCTFAJFd9hNjJwe78J3MmiFU9xA==
X-Google-Smtp-Source: APXvYqwAeVPJTybCxAhBlHZm7fH1+kQFwQzOy1mMVsPue38X5el0VVKc74tMj1Czb541AdeNfDYXBQ==
X-Received: by 2002:a05:6808:3ba:: with SMTP id n26mr3290702oie.62.1580397604685;
        Thu, 30 Jan 2020 07:20:04 -0800 (PST)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id i7sm1719753oib.42.2020.01.30.07.20.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2020 07:20:03 -0800 (PST)
Subject: Re: [PATCH 3/6] dir: fix confusion based on variable tense
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Martin Melka <martin.melka@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Elijah Newren <newren@gmail.com>
References: <pull.700.git.git.1580335424.gitgitgadget@gmail.com>
 <e6d21228d126d62fafdde185c180f9f5ba64c458.1580335424.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <183dfd55-7693-3a96-dbe3-418580a706ea@gmail.com>
Date:   Thu, 30 Jan 2020 10:20:02 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
In-Reply-To: <e6d21228d126d62fafdde185c180f9f5ba64c458.1580335424.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/29/2020 5:03 PM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> Despite having contributed several fixes in this area, I have for months
> (years?) assumed that the "exclude" variable was a directive; this
> caused me to think of it as a different mode we operate in and left me
> confused as I tried to build up a mental model around why we'd need such
> a directive.  I mostly tried to ignore it while focusing on the pieces I
> was trying to understand.
> 
> Then I finally traced this variable all back to a call to is_excluded(),
> meaning it was actually functioning as an adjective.  In particular, it
> was a checked property ("Does this path match a rule in .gitignore?"),
> rather than a mode passed in from the caller.  Change the variable name
> to match the part of speech used by the function called to define it,
> which will hopefully make these bits of code slightly clearer to the
> next reader.

I agree that some of the terminology in the .gitignore is confusing,
especially when the terminology was used in the opposite sense for
the sparse-checkout feature. I think this rename is worth the noise.

For reference, here are some commits from ds/include-exclude that
performed similar refactors:

468ce99b77 unpack-trees: rename 'is_excluded_from_list()'
65edd96aec treewide: rename 'exclude' methods to 'pattern'
4ff89ee52c treewide: rename 'EXCL_FLAG_' to 'PATTERN_FLAG_'
caa3d55444 treewide: rename 'struct exclude_list' to 'struct pattern_list'
ab8db61390 treewide: rename 'struct exclude' to 'struct path_pattern'

Thanks,
-Stolee
