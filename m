Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8417C34056
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 19:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 673CC2465D
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 19:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kX0WGd/9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgBSTdT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 14:33:19 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35012 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgBSTdT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 14:33:19 -0500
Received: by mail-wm1-f68.google.com with SMTP id b17so1980469wmb.0
        for <git@vger.kernel.org>; Wed, 19 Feb 2020 11:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ieZDFUL8BwlFawxBxTHvAigF4OMXOMk5mVZo/BSetcg=;
        b=kX0WGd/9oppJ/C2yaZ1MpBHlj/BlAxHiY6SGeVqrmx444x7BAi8+2RA8vxk/eYp3iW
         QqIbtlHqfry1IUZuzRuKRiiDJNE6Rsk4auRr79y9r12jBl9qJ4clKD0oz0S0TS/lGyC0
         okb65yR+eq066lZm/H/4g1VutfFnFgJNXaYn0M5L4ty+K4yRPP3qc3FhWj8v+e9WXV4D
         ScBvKcKk6Y7MT6obioMZO+gbWVr/0qVPgcKvhEXLGL9ZYUWvrtnwKVoqhKHuR3KLwSlT
         y4AzNymYemKUm6oeRHSvpOR9/OmA8/mKYlGPFp2XxF9Via4c3UVtSqxM+kMGScxlPmGZ
         1djQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ieZDFUL8BwlFawxBxTHvAigF4OMXOMk5mVZo/BSetcg=;
        b=FfQ6RmxCMKwVifq6FcXCIGXgtIU1zuvEytR3BVFE9f3s/H09bJQhuOKpK8lJVKgDTX
         w96xVpvKbuYEbrcIH3q/dzogB1tCbciyvmQ/+UDLy9SzYXgtWFFO4x9oF0v8bU/LtuK+
         abgpRD5zHCAsKPsY2dknnaZTN0+DzABzI2XDY/G8ACJD5mWa/9zyyMkP68kGV2HhNMVQ
         t0IssNERqHEX6sHopRJVKFhNi9H9T45AbanSF4rKDo+24Acm4XY/96B0L5CdgI3sFkk2
         zeLMn25vxkvwUCsno7e47NNzg9VypBqFWt2As9xYsFx9tg049V4NtH61BUhE5tbVi5uJ
         qimw==
X-Gm-Message-State: APjAAAUVR0miYc5FEX6B0Vr+V/vqF/KXyVh0V9d2pNWXi7GrkMjK6UI1
        VVqq+4wMGdS2brfThNtZjJUk+Pqf
X-Google-Smtp-Source: APXvYqzvj3RpkG1BOaWFTfMpb8HYVojZ6FvplvTdMO7J2rT4sTzq819jgiJks7olztMr04gfysdAyA==
X-Received: by 2002:a1c:b0c3:: with SMTP id z186mr11372775wme.36.1582140797480;
        Wed, 19 Feb 2020 11:33:17 -0800 (PST)
Received: from [192.168.1.240] (85.25.198.146.dyn.plus.net. [146.198.25.85])
        by smtp.gmail.com with ESMTPSA id y8sm1007504wma.10.2020.02.19.11.33.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2020 11:33:16 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] t3424: new rebase testcase documenting a stat-dirty-like
 failure
To:     Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <pull.712.git.git.1581959751454.gitgitgadget@gmail.com>
 <CABPp-BEtnmzDp0E4=0y9eEMKQ89FcrsK9h-1Mqcd2FDV_EBohw@mail.gmail.com>
 <ed8dc52c-db50-f6fa-9583-8ad4af23d327@gmail.com>
 <CABPp-BHBv+_HkExM1q6WAZZyMhR=UPNQZDhE8jFSQFNoCtgytg@mail.gmail.com>
 <deae766d-f552-2e30-fb49-e7e187ee984b@gmail.com>
 <CABPp-BFij++-6P2ht1EacGXaX4vA_CuBQEfz6M9w9CadXHC8Jw@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <73f32ad3-204e-09a8-d424-5a3534358676@gmail.com>
Date:   Wed, 19 Feb 2020 19:33:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CABPp-BFij++-6P2ht1EacGXaX4vA_CuBQEfz6M9w9CadXHC8Jw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah

On 19/02/2020 16:00, Elijah Newren wrote:
> Hi Phillip,
> 
>>
>> HEAD is now at abd8fe3 side1
>> Rebasing (1/2) # picking commit1
>> DS mtime, mode before merge 1582109854, 120000
>> DS mtime, mode after merge 0, 120000
>> Rebasing (2/2) # picking commit2
>> DS mtime, mode before merge 0, 120000
>> error: Your local changes to the following files would be overwritten by
>> merge:
>>          DS
>>
>> So it looks like the problem is that when we pick commit1 we don't
>> update the index entry for DS properly in merge_trees()
>>
>> Best Wishes
>>
>> Phillip
> 
> Oh, indeed, so this was my bug.  Thanks for jumping in and
> investigating; I probably should have found that lead but I just
> didn't.  Anyway, with your extra information I dug around for a bit
> and I think I found the fix.  I'll post it soon.

I'm glad that was helpful, thanks for fixing the bug

Phillip
