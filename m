Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7858C1F404
	for <e@80x24.org>; Wed, 12 Sep 2018 14:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbeILTi6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 15:38:58 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35921 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbeILTi6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 15:38:58 -0400
Received: by mail-qk1-f194.google.com with SMTP id 93-v6so1238193qks.3
        for <git@vger.kernel.org>; Wed, 12 Sep 2018 07:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BFlspfx7bov+4BGqLBGGOC9H9DoNX4gKqD+pcoMvXgM=;
        b=PZ9FBc2dMIE8HitMvL8lZknGA+xvkaWtBbPgJVjJAl2j92vxHcajRGnTpkQ18bEUae
         W5Ux0koSLiPVKW8ChKIl75mGbb1r2rP+hMcUKdeD2yO6l1DBbDLF+3GTgkHqM5RhJ52X
         3qqIZxXU5wNeEk+m/cc2Vjh4phFmLXMgwVbUj8RH8Xx5IEHB5GoHBKw170r8kpjz/KnX
         emzhN29X78rSnkvFnxP3j6e78gk3v0t8w/qKOHShbTwnF2oz6a21fGv/OQm7s0MEqJlb
         47FL5CZriVqqPtHhPpQc7tViioCyLWs/Bd561oxuYQjReNFWHqc7bGCUK0kPzt8Meey7
         ziDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BFlspfx7bov+4BGqLBGGOC9H9DoNX4gKqD+pcoMvXgM=;
        b=dMv/zC3xVbsIIR2jUR9L3ooLbTC4wZ22jfBCOLenisHVVwkFCYzKvOvS/oCQyBiIiu
         YaQLinOuBAUk8IBcmCPl/3tWqVulJXuoGSER8TmHQwgN5Fal0KXQjX02OcaMDLcgpAiu
         tZqdDVcI4OZgrXaxUlSuEnRa2AxOfEosgUW/4h+CUwnM5b574Sh3KZZAJegpl5/XSqij
         i704GhEEFJN/ZZn5lN1jC7cfeqXXql/s2NBvJJ9tFdronqhNbr4rn2rr23Dqt27jQ3EL
         S4dlSiDFoC57a9Ij2MgkpiyGm3bx1gnYAMQpmrV9E0icAwnxchAL0XMvGmFtf7BlK4vp
         fPPw==
X-Gm-Message-State: APzg51BZITxS3NCPy1F+Ny8QfWFBYeNdcTo/BAPPMER8Y/aPY0JU723m
        iCJ2AiynYi1FM7fc/wgvEVA=
X-Google-Smtp-Source: ANB0VdZzywBKhTkeL42k8f6KamRN+y85W2BwMdUq3655YH0noRD7J8LBe2Q6s7Y+xcmdH4VhwDggOQ==
X-Received: by 2002:a37:c5d4:: with SMTP id k81-v6mr1617964qkl.66.1536762850444;
        Wed, 12 Sep 2018 07:34:10 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id g14-v6sm752836qtc.66.2018.09.12.07.34.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 07:34:09 -0700 (PDT)
Subject: Re: [PATCH v4 0/5] read-cache: speed up index load through
 parallelization
To:     Ben Peart <benpeart@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Cc:     "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20180911232615.35904-1-benpeart@microsoft.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <ad06ba0f-b436-ff6a-8ae7-21054b9c5b6c@gmail.com>
Date:   Wed, 12 Sep 2018 10:34:06 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180911232615.35904-1-benpeart@microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/11/2018 7:26 PM, Ben Peart wrote:
> This version of the patch merges in Duy's work to speed up index v4 decoding.
> I had to massage it a bit to get it to work with the multi-threading but its
> still largely his code. It helps a little (3%-4%) when the cache entry thread(s)
> take the longest and not when the index extensions loading is the long thread.
> 
> I also added a minor cleanup patch to minimize the casting required when
> working with the memory mapped index and other minor changes based on the
> feedback received.
> 
> Base Ref: v2.19.0
> Web-Diff: https://github.com/benpeart/git/commit/9d31d5fb20
> Checkout: git fetch https://github.com/benpeart/git read-index-multithread-v4 && git checkout 9d31d5fb20
> 
> 

A bad merge (mistake on my part, not a bug) means this is missing some 
of the changes from V3.  Please ignore, I'll send an updated series to 
address it.

> ### Patches
> 
> Ben Peart (4):
>    eoie: add End of Index Entry (EOIE) extension
>    read-cache: load cache extensions on a worker thread
>    read-cache: speed up index load through parallelization
>    read-cache: clean up casting and byte decoding
> 
> Nguyễn Thái Ngọc Duy (1):
>    read-cache.c: optimize reading index format v4
> 
>   Documentation/config.txt                 |   6 +
>   Documentation/technical/index-format.txt |  23 +
>   config.c                                 |  18 +
>   config.h                                 |   1 +
>   read-cache.c                             | 581 +++++++++++++++++++----
>   5 files changed, 531 insertions(+), 98 deletions(-)
> 
> 
> base-commit: 1d4361b0f344188ab5eec6dcea01f61a3a3a1670
> 
