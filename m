Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 816F11F453
	for <e@80x24.org>; Thu,  1 Nov 2018 16:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbeKBBPu (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 21:15:50 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42598 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728335AbeKBBPt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 21:15:49 -0400
Received: by mail-qk1-f193.google.com with SMTP id u68so8630879qkg.9
        for <git@vger.kernel.org>; Thu, 01 Nov 2018 09:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=DOsOZ5uWuH3sIVyT+JHWTG4VhvWyhNWAoyntm330dZQ=;
        b=jwCPslrSVccdky/LpXEXmqmMnZBGqUkUlNpm0iql2ZddsCSj0h8FHL6qm48vKux5Fa
         K8i4oux9UC3gzTRecyU1QjZXyD5JHFXY4HgBhCTZFdDK5RSA3EFHbxyPpGW3jl1YlCwg
         Mri83EFtKMSYUBDejp45VVWdKzM+625epCgGaEFYevSgt+8aL11b56ZuxJZ5B/8s93G5
         ybTZUBfZzRIoV9Nd/kMZjqWawS2KNNOCIK8Um4rlBfYwo3GDnDgsXGBU43PRHwnjS4Eb
         Bbrus9uzFV8YiTogtQauT8tAtxLGBUpP8RGX/kHbRzQUhdZBJSdh+eAEXKHW9Hps+cJf
         kgwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=DOsOZ5uWuH3sIVyT+JHWTG4VhvWyhNWAoyntm330dZQ=;
        b=kxpbWd/9QSCtapSYD/C+wHdcvtH38qB00WuH9Sme3c+iBliOyLZPHpNwvjhaVV1so9
         yGQdy0zqr2UV+uRqXdsQgudiAcdWSqd565UYa2N3N6Iv41xNwb8jDFbbgWoF/c0cKnSr
         K+8HFzEiwFJvkYJY3H8gvROF17bQtO9L/IwKlYA5sshguJ4RSa++Ni7qvPZIUPRdvUoj
         cxxWslZlj00qBtSY4c0NZPzrUqG05pAMGzCFMJu8o5T+Wra5Yj+iSDKzVgg4n08VKcKG
         SR7SWSALo+aHBmSN5NHi5yl1b9bNRpFrw0yNi//KOzENZWyq/nVKc5Lzrp9VQenf5k6+
         5fbQ==
X-Gm-Message-State: AGRZ1gLed7k/vce5Wroi0X/iRoastldUEo0I1SN2U/QCl0V6nmLSBDy/
        kmOrpKAX2EJ8mRTFf9DNhd4=
X-Google-Smtp-Source: AJdET5d5N/FFNUClYEy74nctC80SI8s1CkUbUmkt8mIurpVZLVQkwM+CE38XHwBIj8LwK79wvipmdA==
X-Received: by 2002:a37:1fc8:: with SMTP id n69mr7178483qkh.175.1541088732355;
        Thu, 01 Nov 2018 09:12:12 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:eddc:3ff3:d342:de1b? ([2001:4898:8010:0:d712:3ff3:d342:de1b])
        by smtp.gmail.com with ESMTPSA id w1-v6sm18744493qkd.6.2018.11.01.09.12.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 09:12:11 -0700 (PDT)
Subject: Re: [PATCH v5 6/7] revision.c: generation-based topo-order algorithm
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, avarab@gmail.com,
        peff@peff.net, jnareb@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.25.v4.git.gitgitgadget@gmail.com>
 <20181101134623.84055-1-dstolee@microsoft.com>
 <20181101134623.84055-7-dstolee@microsoft.com>
 <20181101154857.GW30222@szeder.dev>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <7ee1b2b4-b748-85d7-ab0f-4446a466d196@gmail.com>
Date:   Thu, 1 Nov 2018 12:12:10 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <20181101154857.GW30222@szeder.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/1/2018 11:48 AM, SZEDER Gábor wrote:
> On Thu, Nov 01, 2018 at 01:46:22PM +0000, Derrick Stolee wrote:
>> 1. EXPLORE: using the explore_queue priority queue (ordered by
>>     maximizing the generation number)
>> 2. INDEGREE: using the indegree_queue priority queue (ordered
>>     by maximizing the generation number)
> Nit: I've been pondering for a while what exactly does "order by
> maximizing ..." mean.  Highest to lowest or lowest to highest?  If I
> understand the rest of the descriptions (that I snipped) correctly,
> then it's the former, but I find that phrase in itself too ambiguous.

It means that our priority-queue "get" operation selects the item in the
queue that is largest by our comparison function (first generation number,
thencommit-date for ties).This means we walk commits that have high
generation number before those with lower generation number, guaranteeing
that we walk all children of a commit before walking that commit.

Thanks,
-Stolee
