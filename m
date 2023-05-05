Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E41C77B7C
	for <git@archiver.kernel.org>; Fri,  5 May 2023 17:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbjEER7h (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 May 2023 13:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbjEER7f (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2023 13:59:35 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF54DE2
        for <git@vger.kernel.org>; Fri,  5 May 2023 10:59:34 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-559e317eef1so30221267b3.0
        for <git@vger.kernel.org>; Fri, 05 May 2023 10:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1683309574; x=1685901574;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+/jCv8AAoZ/tPht8YHvdGn4rEcLsHccJgf5K7kUjxFk=;
        b=Ns4MM04fiMFH01GM30tbCeQF8qyYq2jqrnYG5koIY2KvMWnABHJcvXj3scQZ6xMGeD
         wdfR80iOdIyEm50/zV/w3PV6IABM9gpMfwWQw9pWtptBxSDCRItL0l10fmxcCixmB5n2
         2Stf41p6+t2QYiI2cSrBlTteOWERZ8mKPUMkDjrQbBHqUO01t7DdPceUv7QCsqWJVKuD
         Se9yYn74cTFhPkLRGDTD2LAcpLC1tgoUgcj5LhPE7823EBOBajXmwv7GWtJ4jlNxbDil
         Vnb0LavsDRM4yBHwTO+Zw3bg4HTk+aPnfWlotrc21tkAYFzEXvjL20u2u9KoPMfcK5k6
         cx8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683309574; x=1685901574;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+/jCv8AAoZ/tPht8YHvdGn4rEcLsHccJgf5K7kUjxFk=;
        b=lDEjgowM8gD96DJVvkTaSDJkwdqhSXc0nLXaXVhQ+9A85yAAGfN7Wym7ovtrlFMJLc
         L37ZmB1vSKd/we4pPGazAN+lGRnQ/OepwYwvfgVWIyq+yEh3TKPFPH9yLMacGVFrOzDT
         YzxoM+6bs2Opvr5xhykTQY9FAMsTz/BvoW3v8OpKfEI08Qu19jVMQtmRfsDMHnXVXH04
         3qqcmLHXoSY+vwYa0ZlNvO8a/ppThtmfsV8IXrzCAxj3Fi/EJCDav9XiKvdXQeQZN+gI
         SmIEF1gGCG9FzOo5khvRQJ6SqGI4KddaJ5jMKX2cOQexRsZqxH2ZEAiCs7jNAmY5eIBx
         TNXg==
X-Gm-Message-State: AC+VfDyCUwbtf2U1NDkl3pL/1sgbDIGItcE51rDxrDH/EwbElpZ8Zhte
        qaxq7Y8MMXojiU8sVQo/K+GW
X-Google-Smtp-Source: ACHHUZ7+9BQeadU44UQPkWXoHFyz7IgYH0BRB80AvLCdPoa95KiNXdHSNv7jd4LOZbwcwyKn9ZMZ0Q==
X-Received: by 2002:a81:a157:0:b0:559:e240:3c27 with SMTP id y84-20020a81a157000000b00559e2403c27mr2411601ywg.23.1683309573992;
        Fri, 05 May 2023 10:59:33 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:fcac:2b0b:1f40:7f1a? ([2600:1700:e72:80a0:fcac:2b0b:1f40:7f1a])
        by smtp.gmail.com with ESMTPSA id h19-20020a81b413000000b0055a85ab2704sm602263ywi.20.2023.05.05.10.59.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 10:59:33 -0700 (PDT)
Message-ID: <6c8d9142-9013-f3f0-0619-b3780b86b6ab@github.com>
Date:   Fri, 5 May 2023 13:59:31 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 0/2] pack-bitmap: boundary-based bitmap traversal
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
References: <cover.1682380788.git.me@ttaylorr.com>
 <cover.1683307620.git.me@ttaylorr.com>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <cover.1683307620.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/5/2023 1:27 PM, Taylor Blau wrote:
> Here is a reroll of my series to implement a boundary-based bitmap
> traversal algorithm that I worked on towards the end of 2021 with Peff.
> 
> The algorithm is unchanged from the last version, but the implementation
> has been made much more straightforward, thanks to a very helpful
> suggestion from Stolee.
> 
> Instead of hackily trying to write down all of the UNINTERESTING commits
> between the tips and boundary within limit_list(), we can just perform a
> commit-only walk, which will give us the set of commits that we need.

Something that didn't seem to get attention in this version was buried
deep in the commentary of my high-level review [1]:

> For these reasons, I'm surprised that this patch completely replaces
> the old algorithm for the new one. I would prefer to see a config
> option that enables this new algorithm. It would be safer to deploy
> that way, too.

I still think it would be nice to keep the two algorithms for at least
a little while instead of completely removing the old one. Let's gather
some more evidence and get more reps in with the new algorithm before
making it the new default. I could imagine a scenario where someone
really wants to spend the extra time to make sure none of the objects
reachable from the UNINTERESTING commits are included in the output of
this diff.

[1] https://lore.kernel.org/git/a143150d-7cf5-c697-0e48-0f7af1c6de8f@github.com/

Thanks,
-Stolee
