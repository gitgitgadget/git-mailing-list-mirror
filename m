Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D58C433DB
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 06:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C32061A18
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 06:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhCZGs4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Mar 2021 02:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbhCZGsY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Mar 2021 02:48:24 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE742C0613AA
        for <git@vger.kernel.org>; Thu, 25 Mar 2021 23:48:23 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id c17so4233537pfn.6
        for <git@vger.kernel.org>; Thu, 25 Mar 2021 23:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=IOG2b4gEYej4iola88iOfrBY3UBMth3uGd8l30v/GGE=;
        b=HRvMi1ZFlwCH72SyqJ8R4nEl7nu8oI1IXK5b7ezDt8bQPaEphKa/KqvF4R/vKk8LLK
         yGiFu/WuSAtkzm0Q51U2dOP1Na996Yzt8meACqPD6QcTEORoSGhERsCko87nV/DmM24z
         mX10OgF3chOWwjm1UoJF52BgoSe9P1osA6+vTnXdX0PRw1zT947dwus5wgjiyZKg27aO
         Yn6mzAuh6OCd76r5sDoSIN1xOjXmubab+NVcV8PdY+S58ml16DTNzacB0P2oFg3qcAuz
         hARbvhfAbJFDmwUjHMkNX5cla5Af95MZ8nCq92aKfa0GHx/cKZavJOumFqtQsPqtNHQc
         aw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=IOG2b4gEYej4iola88iOfrBY3UBMth3uGd8l30v/GGE=;
        b=I0KG7EGQg4QutHo52uqwFo72w9HDVXTL/No2iQBaQ58zHz36KnmxsVGCvEJSBbSGOk
         +KaCAWrRJnN2iCSz84E2tq8poHqG35hWn8pa52KA8e8LARTynhnJ/K6tb3LOwzgCDPrT
         LIcijUaB0nJ5NOv+qwALqiHwvkNaiwSbkhiGIKx7rKP4v3oFLFA1RL+1KmfSRHy5WYuP
         hDNt5WatwPWR9WDWajvbK+LabShj8Xhou1UtHGvsMbt5Hv18v0nWUBOoCURvTvsrRMp2
         Q/c32jj1oL06q15WHwdTDyS45467TIvi7tmaAz0lij7gXThAN3vahLy0VeydyFiQRxTL
         2yyQ==
X-Gm-Message-State: AOAM5329jkR3TOsR+qiUyXVfIKvFE527Zupdnz0tGct04oumqOpZoXFa
        5inS3kMaBUVow1u21NhJLbAdCizSneVpIQ==
X-Google-Smtp-Source: ABdhPJw24u7nKnV2Cdd+BIVLzFPsWP9qO0q8dlCGqS+GByqvpKARTIIPKUFgpMjZt/22Ouy7kHW6pg==
X-Received: by 2002:a63:374e:: with SMTP id g14mr10612839pgn.56.1616741303007;
        Thu, 25 Mar 2021 23:48:23 -0700 (PDT)
Received: from [192.168.10.22] ([182.19.8.85])
        by smtp.gmail.com with ESMTPSA id y26sm3764416pfq.187.2021.03.25.23.48.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Mar 2021 23:48:22 -0700 (PDT)
Subject: Re: [PATCH] cache-tree.c: remove implicit dependency on
 the_repository
To:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
References: <pull.915.git.1616701733901.gitgitgadget@gmail.com>
 <f187df01-8e59-ac74-01e1-586a7a63fd4e@gmail.com>
From:   Chinmoy Chakraborty <chinmoy12c@gmail.com>
Message-ID: <123f4d24-0975-d4f0-286b-d8c053e079ef@gmail.com>
Date:   Fri, 26 Mar 2021 12:19:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <f187df01-8e59-ac74-01e1-586a7a63fd4e@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 3/26/21 2:01 AM, Derrick Stolee wrote:
> n 3/25/2021 3:48 PM, Chinmoy via GitGitGadget wrote:
> 2. Rebase your work onto ds/sparse-index, so you also fix the
>     new use in sparse-index.c.

     I'll try to rebase my work on top of ds/sparse-index so that it's 
fixed too.

     Thanks, for the reply :)

