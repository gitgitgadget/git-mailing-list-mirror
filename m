Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A6DC2B9F2
	for <git@archiver.kernel.org>; Sat, 22 May 2021 11:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26B5361164
	for <git@archiver.kernel.org>; Sat, 22 May 2021 11:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbhEVLS4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 May 2021 07:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbhEVLS4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 May 2021 07:18:56 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1C6C061574
        for <git@vger.kernel.org>; Sat, 22 May 2021 04:17:30 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id c20so22456780qkm.3
        for <git@vger.kernel.org>; Sat, 22 May 2021 04:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Hc6nhSH7KItlbmavt8bxT00KdKuSkbSuf49PWit9zCc=;
        b=MOplE9NgeCGl4CEwEzOQNiw8sBK7iKAFFldCNmVx0fFB9BvavNYvADE5pcr52k0ew5
         CThQEGZAr9ZpPIV+ObKTY8Swye8J92oHvUCrETKpbbWk+xUkX6Ag6YZDgfr8BLDIJVTc
         wt81nA53nh201gC/FTRBJ+MInA21Du+CMCF+feSi2C+1m8qYrt+nbzkHiX9Elt2wNc1p
         Bw6+FkBto6B8ezIvaRqS6TouJM2dBokhl/r/QnS0/I+YYmZoA0b8z8jYSYNrwPMLYvJD
         OFLq2FW6TNWy2UkYLFbMepwYqyaJoCAcMvcbAKEJg3/zxozge1asAy40vlQd01gVeC7H
         5PhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Hc6nhSH7KItlbmavt8bxT00KdKuSkbSuf49PWit9zCc=;
        b=GWHmXZxq61j7O7Xc4B8zxCvo3pCC4uICliMbJMriNhInfzeoPtkWlkZ92TME+Q5pIn
         9MT95BAkGlexGTyZNkJ7eaokgizDth4e9JyIGb1V8RkhJx607ZRaACw70mC/vJezWZ5m
         ebz3w5xEmo2g6lbH+Af8BDR83YodGg/s6lFZ8aIGaaN7pZsMJCyZQiIOeJycgikOq3OS
         njfMulj6aFBmpz9cteNzPzILbkDMwdBsvWXbIMDAzUEA3qXiXFIUjsfC/kt/aYOF0/W7
         Xqr28ICMUY246lNIpv3HvHUlWVNc37I8XtdHVX7NVwfTAXP6u148Mitlx0TCN3ehlGBp
         gbjg==
X-Gm-Message-State: AOAM533/9x1qrvPyLOye2xoAXQfOH8NqDxi+fIgxNJ1iMAhYsI2ZBtxv
        90l7/pk1+gXgFfps9sicGiU=
X-Google-Smtp-Source: ABdhPJxzD7SENv/EL6b71Bs6yYH6Ar86MW3xzcNZkdoD726lEkU5WFD4QumefUZ+ved5dtnstk1EKw==
X-Received: by 2002:a05:620a:16d8:: with SMTP id a24mr2848482qkn.34.1621682249751;
        Sat, 22 May 2021 04:17:29 -0700 (PDT)
Received: from Derricks-MBP.attlocal.net ([2600:1700:e72:80a0:1d24:e7dd:dfbe:c524])
        by smtp.gmail.com with ESMTPSA id q185sm6764938qkd.69.2021.05.22.04.17.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 May 2021 04:17:29 -0700 (PDT)
Subject: Re: [PATCH v3 00/13] Optimization batch 11: avoid repeatedly
 detecting same renames
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>
References: <pull.859.v2.git.1620094339.gitgitgadget@gmail.com>
 <pull.859.v3.git.1621490982.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <7ac3d84e-d33f-5076-df9a-c91ece7a1265@gmail.com>
Date:   Sat, 22 May 2021 07:17:28 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <pull.859.v3.git.1621490982.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/20/21 2:09 AM, Elijah Newren via GitGitGadget wrote:
> This series avoids repeatedly detecting the same renames in a sequence of
> merges such as a rebase or cherry-pick of several commits.
> 
> Changes since v2 (thanks to Stolee for the reviews!):
> 
>  * Patch 2: Wording cleanups (typo fixes and whatnot in the documentation)
>  * Patch 5: Expand the comment to explain the purpose of cached_irrelevant
>  * Patch 6: Add a cache_new_pairs() helper, remove extraneous line deletion
>  * Patch 7: Typo fix

Thanks. I'm happy with these changes.
 
> Not included: Additional trace2 metadata beyond that found in v2; I'm not
> sure what to record that would help (see
> https://lore.kernel.org/git/CABPp-BFdxn9f0-jUjY6Ake_6kX-jeN1EEzpeJeTg+TV4wfepwg@mail.gmail.com/)

Such a change could follow later, especially if we are diagnosing
a tricky issue that comes up during early use. I commented on that
message including my ideas about tracing, but they are optional.

Thanks,
-Stolee
