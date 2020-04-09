Return-Path: <SRS0=Te6D=5Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44AD5C2BA2B
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 14:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14F92208FE
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 14:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLSBKpZL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgDIOAu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Apr 2020 10:00:50 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39451 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbgDIOAu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Apr 2020 10:00:50 -0400
Received: by mail-qk1-f193.google.com with SMTP id b62so3984767qkf.6
        for <git@vger.kernel.org>; Thu, 09 Apr 2020 07:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ApaCQKx7CZdFlWDKB13ttZxTsxuJqaft205MmTyrxvo=;
        b=WLSBKpZLJXS8gPjrBRJmxPSJuDiZuDsVSev4rNVwjJztSkJmmTvVXF+1cRugEjpKF+
         qegBz03zQ/Lm9MyeLsDnFT3v6dhR3gJ4U73icd7EqXv3xhOchDJ26qJCmsW4thwXrjsQ
         1VBaVOsgoxFjx0dg7kBzrRoI1wn81286q5DMS5J47Jv9u6VgXBnAuNd5XOu5Fsly+R/9
         vSMocPZTKeaPCyFA4ckKrioVbqS+UoOKxOB8b+KcWjLhGSyiTxx8CubQEwIVUnGn8gmE
         qi36XtqCIh6b+yybmfzaXzaoosNUjgwBebhzeTUtQdxyRSv+/o9Svd08f6a6HAw6tQ95
         3bww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ApaCQKx7CZdFlWDKB13ttZxTsxuJqaft205MmTyrxvo=;
        b=VblG6UgvgmHa0quR3cOXoeSTxAGwz17/bn+iN9L1ubgGZTj9+CmVmuCxRpdCfKTT4i
         vnsMNSbqZqnvOMelQzcnjrIzFVs/5UbsfwH+79Pjze/PdPL5zAg7g9WT8RS1LlZnWgCz
         0KHRT3bzleLc4BBIHyp7Eeuhl78dWWjDTP+VL457UAr0zqfCyGUINUApSOYO3YVY/V9q
         YYGMsTMaOVnrwONj155KB5XpOPclihzn1MiCxLfaH5Q56KG+6GjJXWyR4xRdlFMtRrb6
         dL0Fgz9KLDCdd2hwxQvN8h9F4xkc21aMsosiKgYc1AyqvykjE1DWQlXxwweZNOaaLf3+
         DlpQ==
X-Gm-Message-State: AGi0PubHvm4MC5KyvoP1rJZitVHKradQUSvxMo+AkeqQB30vArli1bjc
        wF6rT5KO2424+FCllu+zgb0=
X-Google-Smtp-Source: APiQypIkt/yBGe0fQNns6qr11c3sEbkmv6rD8uUAlzMcWsYwpoFXit6JhhOoA57u7636hfF7DEA1WA==
X-Received: by 2002:a05:620a:55d:: with SMTP id o29mr13146688qko.305.1586440849669;
        Thu, 09 Apr 2020 07:00:49 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id v187sm21731737qkc.29.2020.04.09.07.00.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 07:00:48 -0700 (PDT)
Subject: Re: [PATCH] bloom: ignore renames when computing changed paths
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Philip Oakley <philipoakley@iee.email>
References: <pull.601.git.1586363907252.gitgitgadget@gmail.com>
 <20200408223111.GC3468797@coredump.intra.peff.net>
 <72fa2e30-b841-9600-ae2c-21a269817f1c@gmail.com>
 <20200409134724.GA3494212@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e3ace6a6-eb2e-0544-c9fa-eaed6e9d6c6f@gmail.com>
Date:   Thu, 9 Apr 2020 10:00:46 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
MIME-Version: 1.0
In-Reply-To: <20200409134724.GA3494212@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/9/2020 9:47 AM, Jeff King wrote:
> On Thu, Apr 09, 2020 at 07:56:43AM -0400, Derrick Stolee wrote:
> 
>>> So we really aren't detecting renames in the first place! And indeed,
>>> checking diffopt.detect_rename shows that it is unset. So I'm curious if
>>> there is a case where that would not be true. I _think_ it would only be
>>> true in a program which ran init_diff_ui_defaults(), but never in
>>> git-commit-graph.
>>
>> So our issue was really that the partial clone prefetch logic was just
>> overly aggressive.
> 
> Right, but I'm not sure how this patch could ever have helped, since
> it's just setting a variable to the value it _should_ have already had.
> 
> Or do you just mean that the issue would have gone away with Jonathan's
> patch to make the prefetching less aggressive?

Yes, with Jonathan's patch we stop downloading blobs during Bloom filter
computations. The patch this is "replacing" disabled that download in a
different way, depending only on if detect_renames is false and the diff
output doesn't need file contents. (Jonathan's is better.)

-Stolee
