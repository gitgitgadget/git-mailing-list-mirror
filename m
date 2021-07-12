Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD9F2C07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 15:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B850C61206
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 15:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235293AbhGLPL4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 11:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbhGLPLz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 11:11:55 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9384C0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 08:09:06 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id z9so4230634qkg.5
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 08:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A984OwvCuOF6DMKyU3/8w2AHt+zQVxCx9xWFM4scbX8=;
        b=FG5vOg+CD5D5cMJ/P8OKpHgfmnCwodjl30oXrcXIm6/CMokvwYI29ut2r5pkI8AQDd
         zW5VYWj7CIh1QyWq26r3DDm+NZENyKH9wN3wThRI1iK8SQVX1sWNSg4vx6d8lP0HK0h9
         rpiDnA5//BWhM0dTQ9abu1U2oBHAwnELJC+cEcpenMjhCLhrKk4ksF+M96U1BGtAPUwm
         9svAfWqvgUBjRAjqL6oHCPJ37pAcWvbeFds72CN5gU3eVcmvBG73T3NffR76SnQce0aQ
         a10y3K/OAirzzt314012qapEsf7F7szWr1Qe9w+hpcoemSxOiAOYsn+rJLcfc0R/SpvV
         k2gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A984OwvCuOF6DMKyU3/8w2AHt+zQVxCx9xWFM4scbX8=;
        b=TPUj5qySFc9e7MpTNhw0iUYofZb/cxHfwHAQqCLyHI7bMdpKnBwufMiyKLUtPZsmgv
         Bf9JugidtJfyllIgZOhVBvDp1QGfdYGS3y07MtlLxwb3gDp60xrJ9Wu8im18qKZMLaaS
         Weh5vdxDr/XmKfZU0BFxxYwHgo5QxgKh6+3TjtnVx+yxkfrjZOEYObYtHqL7K2gCkEVw
         XPCRhZpMrQFXRp6TOddSPmmX+x00RhoR4Cl0yjcsc6hVJ3Wu96GqWGAFPjAe8JXVZ6TE
         TI5AxX9zJHk+njoyXX4aXIc5a5++k+m6ViGR1bVT+3WgwbshKwi/RIvodoI1syMfbklL
         UR1g==
X-Gm-Message-State: AOAM533lLVgwHW54YLSB8+qO7Q1p3a/duu7gBYdz5MFkFt3U8kp681Np
        eb9omvYbCV4oUTGk2zjVzZA=
X-Google-Smtp-Source: ABdhPJzdQIR1J5rr3E26v1cM0XBnM7pO+sZpxLUHkjdAE2ZxR4QdD980FjVOt5NbWG84SMctHr1s8Q==
X-Received: by 2002:a37:59c7:: with SMTP id n190mr52476500qkb.146.1626102545653;
        Mon, 12 Jul 2021 08:09:05 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:91f8:61a:4701:b6c? ([2600:1700:e72:80a0:91f8:61a:4701:b6c])
        by smtp.gmail.com with ESMTPSA id d200sm3021971qke.95.2021.07.12.08.09.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jul 2021 08:09:05 -0700 (PDT)
Subject: Re: [PATCH 3/3] diff: correct warning message when renameLimit
 exceeded
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
References: <pull.1044.git.git.1625964399.gitgitgadget@gmail.com>
 <44a5d5efaa637d01ec3266b34f31d46acce5ef24.1625964399.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <9707b299-3846-6388-36ba-e8d93a28e2ac@gmail.com>
Date:   Mon, 12 Jul 2021 11:09:03 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <44a5d5efaa637d01ec3266b34f31d46acce5ef24.1625964399.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/10/2021 8:46 PM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> The warning when quadratic rename detection was skipped referred to
> "inexact rename detection".  For years, the only linear portion of
> rename detection was looking for exact renames, so "inexact rename
> detection" was an accurate way to refer to the quadratic portion of
> rename detection.  However, that changed with commit bd24aa2f97a0
> (diffcore-rename: guide inexact rename detection based on basenames,
> 2021-02-14), so now the correct way to refer to quadratic rename
> detection is "quadratic rename detection".  Fix the warning accordingly.

Now that I read this more specific reason for using "quadratic", my
earlier comments on patch 1 are slightly less helpful. Specifically,
I was recommending to continue using "inexact renames" but that is
not 100% true anymore.

I still think this "quadratic rename detection" is perhaps hard to
parse as a non-expert. This subtlety of some "easy" inexact renames
definitely makes the definition harder.

Since the steps that find inexact renames without the quadratic
algorithm are heuristics, perhaps this portion could instead be
called "exhaustive rename detection" or even "expensive rename
detection"? It perhaps implies more directly that the limit exists
as a way to prevent an expensive operation.

Thanks,
-Stolee
