Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C31C43461
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 12:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2D33221E7
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 12:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/ttt6dl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbgIQMyk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 08:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbgIQMyg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 08:54:36 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77C2C06174A
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 05:54:34 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id g3so1686653qtq.10
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 05:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=WIGfNoI1U0Diux3hB2MHOhgK5GSzKZdFxs0F4e7041I=;
        b=N/ttt6dlsG8WiONepvUAun4leIWolHVsrCMTOwl5lcCjAzCAE5DmLgoJbPIPTUeeBB
         IDyxgB8Vr828MIQ6p+pAN7V6/qkdP+5fEUb0svQhP+hFFTCzyRk40KRYNDUHmqud08yq
         2XVRfyIMArQL+QsJbMPHpmbvHc3cYgINalwRazPSlIQYkmeGK57cwtHsENu8ukMI6NEr
         1/+4+ZPpeodQLvPJUTfzVcnirGz7DsAAeV0blpyF9FJ9GpnnNt2QchkX5aBQ4GzpvWwj
         TKG/vZ7/V7NhMc0w1rOTDsIA/+yjr9zGJfylCGst9Kkncj56nxmIBcM9GC1Pw88AGIe+
         GsBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WIGfNoI1U0Diux3hB2MHOhgK5GSzKZdFxs0F4e7041I=;
        b=JhhBv1adTj57Xq4qMkNWP2LdsbqLpGm7qI5ndaDlGA6PGqHFlkxLz9eCm7glGR8uAV
         T4zyNYqB5eZ4Y4qFghWwdPz8kSdhxWe3PnF2PHBvZAQmj5+OpwRby0v7QuDKxUIKpGLV
         HHjIU3GAuJC087pljgoOXCIn6YJNbOyK9HnYRVzUZBjproyiCcOkJy/4ctVgv4nIa2xI
         7HNT3DXxuC7l/bTtBr2PEA0y0mbnSuswt/lsIm68dKeuNIQ7ARH7zTiHj02zLOpuP8MI
         OykCMY+WxB6e9pQx5NLMV5CQzmvKvBOnIv8ZU4k/tBAw+sCsaqdANjxPRYhpDHxEXDSf
         nmLg==
X-Gm-Message-State: AOAM532JfHq642FRBiu5j6yRSIZrvjqDYkuD8Jb6ekTkMG/FHzuhUoCO
        10UklGU/hRd9yoxdNp+Qg5Te4Dkvmdpy2A==
X-Google-Smtp-Source: ABdhPJxUP4GgQsFNoulA3bgyJaJEtepuar9bpIuJXm71THTnXD/5IPA/B1SXJKjfPgzsWydSD/puPg==
X-Received: by 2002:ac8:75d4:: with SMTP id z20mr21832018qtq.370.1600347272386;
        Thu, 17 Sep 2020 05:54:32 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:acfa:efc8:96e3:6e10? ([2600:1700:e72:80a0:acfa:efc8:96e3:6e10])
        by smtp.gmail.com with ESMTPSA id p20sm22178060qtk.21.2020.09.17.05.54.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2020 05:54:31 -0700 (PDT)
Subject: ds/maintenance-part-1 (was Re: What's cooking in git.git (Sep 2020,
 #04; Wed, 16))
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq8sd9t679.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <39e940da-c8ee-9371-84e3-1bedbe86bf5b@gmail.com>
Date:   Thu, 17 Sep 2020 08:54:30 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:81.0) Gecko/20100101
 Thunderbird/81.0
MIME-Version: 1.0
In-Reply-To: <xmqq8sd9t679.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/16/2020 11:47 PM, Junio C Hamano wrote:
> * ds/maintenance-part-1 (2020-09-06) 11 commits
>  - maintenance: add trace2 regions for task execution
>  - maintenance: add auto condition for commit-graph task
>  - maintenance: use pointers to check --auto
>  - maintenance: create maintenance.<task>.enabled config
>  - maintenance: take a lock on the objects directory
>  - maintenance: add --task option
>  - maintenance: add commit-graph task
>  - maintenance: initialize task array
>  - maintenance: replace run_auto_gc()
>  - maintenance: add --quiet option
>  - maintenance: create basic maintenance runner
>  (this branch is used by ds/maintenance-part-2 and ds/maintenance-part-3.)
> 
>  A "git gc"'s big brother has been introduced to take care of more
>  repository maintenance tasks, not limited to the object database
>  cleaning.
> 
>  On hold.
>  cf. <0b35829f-a83b-a093-2dc5-0e7d3b42fd15@gmail.com>

This message [1] includes a simple forward-fix for the
parsing logic. I mention a re-roll in my preface, but
I was talking about a potential re-roll of part-3 when
that gets more feedback.

My hope was that the quick fix could be applied directly
on top of this branch and then cook in next as planned.
I'll accept a delay if you think that is merited, but "on
hold" just seems like you are waiting for something more
from me.

Thanks,
-Stolee

[1] https://lore.kernel.org/git/0b35829f-a83b-a093-2dc5-0e7d3b42fd15@gmail.com/
