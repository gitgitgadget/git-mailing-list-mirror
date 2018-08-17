Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 458561F954
	for <e@80x24.org>; Fri, 17 Aug 2018 12:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbeHQPkX (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Aug 2018 11:40:23 -0400
Received: from mail-qt0-f176.google.com ([209.85.216.176]:39932 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbeHQPkX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Aug 2018 11:40:23 -0400
Received: by mail-qt0-f176.google.com with SMTP id o15-v6so2494521qtk.6
        for <git@vger.kernel.org>; Fri, 17 Aug 2018 05:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=O9ofBmH59cKRa9pR4yd35lrnNuP58570BVTlZ05mJJo=;
        b=Imt2rrN5ec6In28IXi0NZhA0avCVCMEf7Lb/PM9ZuqUjniJSyPo0X+8rmgPVvDmKMH
         RswhK9IaEjjOLRjRETZtKnQN67TsdyaWngE4or/wnOPAD8l+4h3ua80aKsGcNCeDUrIm
         CkJZBUsUPKfUZdPu0dfGmFGO8407AtQ+a/LyFHeGJM4wvOHgDBk3xeydwTfpDll6OZi9
         InL+wujC/NfZS7cYc0ET0TrgPGlEpNgjA0Io6JHScb6BbV1DgIYOsFNJMMJplPFSMhmF
         xxcLFjcis52xjxeObcL3aOQy2YupMwYJegijCGPgaMNIZad7WmnJJUzEzawAhi3rudEX
         /pvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O9ofBmH59cKRa9pR4yd35lrnNuP58570BVTlZ05mJJo=;
        b=UQV8dr/JULI/kVJknlX03ZnzVFSgNsUGxOMNYqvFTT+6qenHWl2GBVUNRT+vGKPadK
         2ZsqdDCp1goeZRRSOBU1ue6QwIFGeF8DEMDwnNw0OppQFr5zOXVemaSXVwMsibUChk1A
         EUSQfpYDHkO15f/8pxMHtkXfilTBOY/Z1gJvb7sVRtx6Dxg/8T0wMTEeSsxmjosjosvh
         YEe0dcgur1oRsJbfenbFurk7yzuHn+fP7S5SByO1I+m2weQxdVPSA5aYjWOtJ5yd0kCw
         IGq008y/H7tMRxzJKLPJ8LN5PMMyBmpAwhmDLf5JN92fO6Pl1JzdPF+gvG34TH6aktFp
         6HlQ==
X-Gm-Message-State: AOUpUlEX+DADmifySlQn4r30GsYbQVzW3Q2E6auHKAONIckF39nPSblZ
        CDlnXkBPIzqRpj7fN4FE6KE=
X-Google-Smtp-Source: AA+uWPzcKj3Mphtw+RpkpK+tUwZdgEWF8oBp1tPPYOeHbxeUTMonO85c7ush0q55ncfhUvb3s82Imw==
X-Received: by 2002:a0c:be15:: with SMTP id k21-v6mr30514442qvg.1.1534509425768;
        Fri, 17 Aug 2018 05:37:05 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id i128-v6sm1130745qke.36.2018.08.17.05.37.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Aug 2018 05:37:04 -0700 (PDT)
Subject: Re: [PATCH v3] checkout: optimize "git checkout -b <new_branch>"
To:     Duy Nguyen <pclouds@gmail.com>, Ben Peart <Ben.Peart@microsoft.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <20180724180122.29212-1-benpeart@microsoft.com>
 <20180816182653.15580-1-benpeart@microsoft.com>
 <CACsJy8B84T9HSJKAErNAyoMwbBpu6Gwgyz3RsvmqD0+o=bg3Ng@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <448bd740-73fb-aa3a-ded0-e4012cf6ec21@gmail.com>
Date:   Fri, 17 Aug 2018 08:37:03 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACsJy8B84T9HSJKAErNAyoMwbBpu6Gwgyz3RsvmqD0+o=bg3Ng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/16/2018 2:37 PM, Duy Nguyen wrote:
> On Thu, Aug 16, 2018 at 8:27 PM Ben Peart <Ben.Peart@microsoft.com> wrote:
>>
>> From: Ben Peart <Ben.Peart@microsoft.com>
>>
>> Skip merging the commit, updating the index and working directory if and
>> only if we are creating a new branch via "git checkout -b <new_branch>."
>> Any other checkout options will still go through the former code path.
>>
>> If sparse_checkout is on, require the user to manually opt in to this
>> optimzed behavior by setting the config setting checkout.optimizeNewBranch
>> to true as we will no longer update the skip-worktree bit in the index, nor
>> add/remove files in the working directory to reflect the current sparse
>> checkout settings.
>>
>> For comparison, running "git checkout -b <new_branch>" on a large repo takes:
>>
>> 14.6 seconds - without this patch
>> 0.3 seconds - with this patch
> 
> I still don't think we should do this. If you want lightning fast
> branch creation, just use 'git branch'. From the timing breakdown you
> shown in the other thread it looks like sparse checkout still takes
> seconds, which could be optimized (or even excluded, I mentioned this
> too). And split index (or something similar if you can't use it) would
> give you saving across the board. There is still one idea Elijah gave
> me that should further lower traverse_trees()  cost.
> 

We have investigated some of these already - split index ended up 
slowing things down more than it sped them up do to the higher compute 
costs.  Sparse checkout we've already optimized significantly - limiting 
the patterns we accept so that we can do the lookup via a hashmap 
instead of the robust pattern matching.  We will continue to look for 
other optimizations and appreciate any and all ideas!

In the end, this optimization makes a huge performance improvement by 
avoiding doing a lot of work that isn't necessary.  Taking a command 
from 14+ seconds to sub-second is just too much of a win for us to ignore.

> But anyway, it's not my call. I'll stop here.
> 
