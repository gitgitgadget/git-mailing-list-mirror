Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A35671F454
	for <e@80x24.org>; Mon, 11 Nov 2019 01:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfKKBHg (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Nov 2019 20:07:36 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:47054 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfKKBHg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Nov 2019 20:07:36 -0500
Received: by mail-qk1-f193.google.com with SMTP id h15so9842402qka.13
        for <git@vger.kernel.org>; Sun, 10 Nov 2019 17:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DD/SwzrVFd7ioQg2fqQjQfcGA7EoWdkl70XtQ+MPf+w=;
        b=hT6H0IyNgUshDqRpZiqfoRbaAexpex/YbfWxM4gWqF6fj1+LKXguhjpkyoz31w32+/
         7PJOQvPA6qrqxhaeSc3S0yyg7joSq4M5ZT1talsRiAUTjC6/U8XeHKMGwSHM7z9fZSoH
         O76N6RAVl6IagrOSwLP84UXvhRdb6zIGNOQwB5iok1qfIMKoACj3mqGbCZ2fLeQD4vYY
         Qnl93rUqdk5807RYQeGBzeBSDl56q5ka2EmnokgV2TnVRy8iWJdkSYgubdgDSd6ZAB3f
         CN0RTQtTWEBWIPIMrQczjtZW0kDK00odWSD9GKd8XKZxGI549yzd+AhD9T+9qUKo9ZpR
         86HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DD/SwzrVFd7ioQg2fqQjQfcGA7EoWdkl70XtQ+MPf+w=;
        b=lhygSzepqm6FhfuO8sB9N+4zuXTiK5Y81/jyovtlLRBDH3HlBTjMy18rd3jCD3YJ8z
         6o/qotrM73cQmh6Nma2z/FWaMYlBVQJxEMApahvc/yqZQldBCKyju7dILGVwvJ39rRB+
         TjYeKFYvb6wRv3BdWrz4jaYjjVgi/KS2DjoVQOlgp9HyY2bwyK7MVYtWnD/C7bRPFjCa
         +wZOxHq2MLP4YwPachchN7G8YxDqj2z5xeE9AxKM81rucPx9GjBtaCYPWGYGyDrgibqv
         EcBznmsfw9ru6VzieoGmjgv349SBtx2Lx3lCi02NHIXN+J82NdSCExIgdX5U8uGEjsI8
         j9aQ==
X-Gm-Message-State: APjAAAUVkmVd/NLKYvJwCtJOVjhfBktOd+CBTThGHoI6kqGSA3MUscmK
        LApSe0uxiHKuSuLk2F+Iroo=
X-Google-Smtp-Source: APXvYqyndGWe3tWdsPO/8bT/hkUSMNB80h9qEcRN6xAl3ak8OEILEbUFOSVeVvrT8Yc1k90b+p+zrA==
X-Received: by 2002:a05:620a:12f0:: with SMTP id f16mr3633677qkl.167.1573434455128;
        Sun, 10 Nov 2019 17:07:35 -0800 (PST)
Received: from [10.0.1.19] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id n62sm6770720qkn.47.2019.11.10.17.07.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Nov 2019 17:07:34 -0800 (PST)
Subject: Re: [PATCH v5 6/7] revision.c: generation-based topo-order algorithm
To:     Mike Hommey <mh@glandium.org>
Cc:     git@vger.kernel.org, gitster@pobox.com, avarab@gmail.com,
        szeder.dev@gmail.com, peff@peff.net, jnareb@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.25.v4.git.gitgitgadget@gmail.com>
 <20181101134623.84055-1-dstolee@microsoft.com>
 <20181101134623.84055-7-dstolee@microsoft.com>
 <20191108025007.bphr7ynvskeoe6tb@glandium.org>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ea07fd13-7d0a-4636-1aa4-453f6b837735@gmail.com>
Date:   Sun, 10 Nov 2019 20:07:31 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:71.0) Gecko/20100101
 Thunderbird/71.0
MIME-Version: 1.0
In-Reply-To: <20191108025007.bphr7ynvskeoe6tb@glandium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/7/2019 9:50 PM, Mike Hommey wrote:
> Replying to this old thread because I have questions regarding the
> patch, in the context of problems I had downstream, in git-cinnabar.
> 
> On Thu, Nov 01, 2018 at 01:46:22PM +0000, Derrick Stolee wrote:
>>  static void init_topo_walk(struct rev_info *revs)
>>  {
>>  	struct topo_walk_info *info;
>> +	struct commit_list *list;
>>  	revs->topo_walk_info = xmalloc(sizeof(struct topo_walk_info));
> 
> Not directly from this patch, but there's nothing that frees this memory
> AFAICS, but then, that's also true for most of the things in struct
> rev_info.

This is true, the 'struct rev_info' doesn't get cleaned up at the end.
It is probably a lot of work to find all the consumers and get them to
clean everything up, and the value is rather low. I believe the expectation
is that each process will only run a revision walk at most once.

>> diff --git a/revision.h b/revision.h
>> index fd4154ff75..b0b3bb8025 100644
>> --- a/revision.h
>> +++ b/revision.h
>> @@ -24,6 +24,8 @@
>>  #define USER_GIVEN	(1u<<25) /* given directly by the user */
>>  #define TRACK_LINEAR	(1u<<26)
>>  #define ALL_REV_FLAGS	(((1u<<11)-1) | USER_GIVEN | TRACK_LINEAR)
>> +#define TOPO_WALK_EXPLORED	(1u<<27)
>> +#define TOPO_WALK_INDEGREE	(1u<<28)
> 
> Should these two flags be included in ALL_REV_FLAGS?
> Should they be reset by reset_revision_walk?
> 
> At least for the latter, I'd say yes, otherwise you can end up with
> missing revs in a subsequent topo-order revwalk.

This is probably true. Sounds like a quick contribution could
be in order?

Thanks,
-Stolee

