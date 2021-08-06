Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4605CC4338F
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 12:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16F2E61131
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 12:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243660AbhHFMVp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Aug 2021 08:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243653AbhHFMVo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Aug 2021 08:21:44 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CF7C061798
        for <git@vger.kernel.org>; Fri,  6 Aug 2021 05:21:27 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id j1so16363635pjv.3
        for <git@vger.kernel.org>; Fri, 06 Aug 2021 05:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=lcCTIWF+5nC6CIEIZbIjr9OjPwJ0Uj5x81oSUgEe+3I=;
        b=X0ttfniJyBjHPomIHL1h6+OOyTe9R4VkAbigtcipKVUu6fyR6tfUm4D4VFn4v4/ea6
         o4leR9nxE+PQwtU85Fxz//fa5YMPACxst7f8tPvQYMasGGHteWfzMjkG/EV0Gc9c9NIh
         YHJNGgRWFAgsNLbxsgAS7JmcNlLfZxcxP+xsV/BnkcpjkPrAeEr528SFasK58akpIW+0
         ffL77cpy9jBVNCqDz4YJoJsh/O1leN7IKuwadiYJn4jWIlTptzDK9vJQ9UqTNnQVish/
         DRT9CQCTbVoySj/V5Eva/4B+6zm9Sg5/nTgTl/fdTHXOiCa2VJnBAWtLoJy4SdB0JZHN
         /J+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lcCTIWF+5nC6CIEIZbIjr9OjPwJ0Uj5x81oSUgEe+3I=;
        b=Afg68j40hXT+ofOCR1k7HZm3QqU4AJnWzN0C/Pwk8yopSdgkv1+gwEuu2pquNbqRBP
         RvKEZ2IuZqhdNDdgYp43HhEfu0XAAflGmBft5O0qNnW9x1ffeSWplespIg3g1fad6Y99
         81y2Xjy4Mc6w9NScW/JqwbdhI98Ywjdu6gSBumtTMfxhovNgR0DJ47D5cl9QoO6MCvDQ
         v3bVMkEGqB/i/DKiPOkpxxt3zVJXUSAysCa7anklmkeCG4GeqFK4rJs27bNbTrW1ns/4
         q7F3YFL7DvdxNfnBqjSN5paK5CPfqhqvveJBHmnWQEP+LNhD9dH3R84/8OC8PvXT39+L
         c4Ew==
X-Gm-Message-State: AOAM531Nh48aEQlREG97KbAWX4BVEGvmpshLodBuWkvnab5EklbsuB/J
        dZMqb9M2AhfPvl4yPEETEItmJOn5hlQ=
X-Google-Smtp-Source: ABdhPJybN9SJQGAAekI0iQPL/Q9cy13uhMla6uTzEP2utxmXfphi1UT3EtNFZFjPp3OUQsI441ithQ==
X-Received: by 2002:a63:b09:: with SMTP id 9mr1319189pgl.53.1628252487184;
        Fri, 06 Aug 2021 05:21:27 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-75.three.co.id. [180.214.232.75])
        by smtp.gmail.com with ESMTPSA id 69sm1434841pfx.55.2021.08.06.05.21.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Aug 2021 05:21:26 -0700 (PDT)
Subject: Re: [BUG] Amending a shallow clone -> orphan branch
To:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        git@vger.kernel.org
References: <64760969-1ead-2bfb-6f98-1161d385c0ca@syntevo.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <b3083a15-f2da-0eae-b07b-8a641c613906@gmail.com>
Date:   Fri, 6 Aug 2021 19:21:24 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <64760969-1ead-2bfb-6f98-1161d385c0ca@syntevo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alexandr, welcome to Git mailing list!

On 06/08/21 07.04, Alexandr Miloslavskiy wrote:
> Consider the following steps :
> 
> git clone --depth 1 --single-branch --branch master 
> https://github.com/git/git
> cd git
>  >1.txt
> git add 1.txt
> git commit --amend
> 
> This results in an orphaned branch, where a single commit contains 
> entire tree.
> 
> I understand that this is a bug, because certainly git knew shallow 
> commit's parents and could reuse that when amending?

I tested that, and below is `git status` after the test (using Git 2.32.0):

> On branch master
> Your branch and 'origin/master' have diverged,
> and have 1 and 1 different commits each, respectively.
>   (use "git pull" to merge the remote branch into yours)
> 
> nothing to commit, working tree clean

So you're amending merge commit by adding dummy file, so that your 
`master` branch becomes divergent against origin. That dummy file isn't 
contained in any commits that are included with that merge commit.

-- 
An old man doll... just what I always wanted! - Clara
