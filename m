Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FD3C433E6
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 19:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16ACE23406
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 19:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388276AbhATTLc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 14:11:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392605AbhATTLN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 14:11:13 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9ABCC061757
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 11:10:32 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id f132so26163150oib.12
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 11:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GOJ5/KMMRjYVhTSi5SpYFpEh8pnW7WHeiN8pwV7Y1oY=;
        b=TJRelPMdITvLlSTnHFGS8ZQKkKVCT56yshaNr7T3sHmU0ljmjn4sEClXFNPaqFWqGl
         A3sz6ATIsMmMAvTQ5I8VFsjZ/NiED6+y4kM9du0lDY2Vtmhufb0miHyISEeBYjiZLM9H
         WNeZgu3gcPeUKIH0Qhg3hgdIgLxKAkKkI6LC5WqYP6V5MlXkI1wRVWeyyA6ADNkYTnD+
         XwhEi25D4x+FW8Fwix7qZcXkwlkHUgzJxSh9804zcLstqZebPVzg0nWs6gdS3NqMHK58
         tRM966qLnThUKm4GcvlL+kgpHaCMS1Q0xVAatoh4fefTMQDr5i8i8Kxwu6q3d0TOG8qi
         sDNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GOJ5/KMMRjYVhTSi5SpYFpEh8pnW7WHeiN8pwV7Y1oY=;
        b=KHo56UDWFog6qATv6DHb1SOxrFyeNk1hMrSLdxgM/vG1h4Jdm3AD8PRQAsBKQ7KWss
         yIpqMGfszBTO83rYEsrCtI3jRNGc41EP0y83aAYn8W8rrNTzlyXNSMt1KCge6tK1rN0F
         pcUdJmej7qFUJIzG9uCasg/07Ih8QZ02g+0Pz/g5ZSaEMddTP0Hs9RnOIN/TKBdko+0d
         3XKH8zctVMYbaonYZEE9NymVXFAFXR1ir/OOFpK8lnW3GjfYy3TOGfmwEieNVyddO4Yx
         Jlil+vmKbzNbrkyLFz9OZyvy8XWl91+vlRt9xLmw8DVkGBtVcvyHHpyLZGVBCtB7nBU3
         LWDw==
X-Gm-Message-State: AOAM532n5cDft/IcQIvFPb8zCS+PYhiH376f4LKQbWejwJB15B9qPa2h
        7TuKy8nFv2EtBd56Z3/5j+SHurtYhWI=
X-Google-Smtp-Source: ABdhPJyW530MR2se8r4lIPw3BIPey9tCRFztSFkKMMgA3LVHC2HO4WEyctF5pQvCB91fEfqhiAUmJw==
X-Received: by 2002:aca:2301:: with SMTP id e1mr3820143oie.22.1611169832048;
        Wed, 20 Jan 2021 11:10:32 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:710c:cecb:a7d:75ab? ([2600:1700:e72:80a0:710c:cecb:a7d:75ab])
        by smtp.gmail.com with UTF8SMTPSA id e205sm538836oia.16.2021.01.20.11.10.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 11:10:31 -0800 (PST)
Subject: Re: [PATCH 1/9] cache-tree: clean up cache_tree_update()
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.839.git.1611161639.gitgitgadget@gmail.com>
 <0bccfd34ae5924aef0432fd6727debb75c052da5.1611161639.git.gitgitgadget@gmail.com>
 <CABPp-BFiNvPaAffQ0uBfpkHY1WM2gR3ssvpwzxpDhrZmZZjiDA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <bbed0d73-fa9d-92a0-3bc4-1d44263bb2fb@gmail.com>
Date:   Wed, 20 Jan 2021 14:10:30 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BFiNvPaAffQ0uBfpkHY1WM2gR3ssvpwzxpDhrZmZZjiDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/20/2021 12:21 PM, Elijah Newren wrote:
> On Wed, Jan 20, 2021 at 8:54 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:...
>> +
>> +       if (!istate->cache_tree)
>> +               istate->cache_tree = cache_tree();
> 
> This is the only substantive change.  It seems fairly innocuous, but
> it makes me wonder the reasoning...I don't know/remember enough about
> cache_tree handling to know when this would or wouldn't have already
> been allocated.  It seems that this would have had to segfault below
> if istate->cache_tree were ever NULL, and I don't see you mentioning
> any bug you are fixing, so I presume this means you are going to be
> adding new codepaths somewhere that cause this function to be reached
> under different circumstances than previously had been and you need it
> to be more safe for those.  Is that correct?  Or is it just an
> abundance of caution thing that you're adding?  If the latter, any
> reason you chose to allocate one rather than assume it's a violation
> of design invariants and BUG() instead?  (Perhaps the commit message
> could add a sentence about the rationale for the extra safety?)

It's something I need in the future when I use the cache_tree_update()
in more places. I think I call it two times, and either I need to
initialize the cache_tree member outside of both, or just make it a
feature of the method that it will re-initialize the cache-tree.

Note: the implementation treats an initialized, but empty cache-tree
as "invalid" so update_one() correctly populates the full tree.

Thanks,
-Stolee

