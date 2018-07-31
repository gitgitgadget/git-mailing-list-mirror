Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CF781F597
	for <e@80x24.org>; Tue, 31 Jul 2018 16:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731697AbeGaScC (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 14:32:02 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:37846 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727471AbeGaScB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 14:32:01 -0400
Received: by mail-qk0-f194.google.com with SMTP id t79-v6so10704409qke.4
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 09:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bgyEzhP6TvnhYxLG1p9j3bzKQGh0q6X83jvepcn/lJ8=;
        b=KeyUxpo79y2w9oH2cp2zXZSmwrWHkVxDU7qZAFHOqHWND3U2ZhIMgnr8ODvc5jH9PI
         fWksap82aO5YdAfk5qULpKubWvqC6wNj8fIvoJbDJz889W5rTPKKCUnuBgQmir1ppKTT
         VN+I9WCmDALgN4NzlG5hlXy4pgmPe9aNdC96i70zSX8lj38kasYZ3cQPj6myyUSdCjpC
         rl5IzMf1iwH5oVYMOOzfDuYu7gmKv/DwuE1CeuuchWrvChNiS73AGdmtMSxcB3CuvUhP
         2gNWccUCbvs1kKWQzqoWu3dr3UgyH9SE4i39hbh4uZhTg59x7uG/Wmie0m7veYqWZshZ
         7ymA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bgyEzhP6TvnhYxLG1p9j3bzKQGh0q6X83jvepcn/lJ8=;
        b=iuG3hbyBa4mrXobgZcE2G34FWWcOA+doVuqJae6ie3VDo6gRgf+kE5NsaQUhlVtuGX
         v1AQmiO4Cv6GcX9jwtsTxGVR1lKHA+TvGnnjpNf+lXp8YG2Qr7eQrUTn3hcP+moKaWvY
         IAa0SIshzcdQq+MNtR/GKsypQ2WkpHz78dcxqozn7q/MZNggv+qGhdQ7HtqSGE5aNT+w
         egmDBv9ZgYa+Rt50x1/tMPeC2Up4LofUnMzv4PgMRtJB/Ug+I+EC7c9oBmrS9vHePoow
         +euEKwp7oqjpx4N6Y2GKYJTPdlDLRpE/JmOev+cnzfWoob1uWmXU8jLp9xkLQ2toD0pp
         o1Cg==
X-Gm-Message-State: AOUpUlGsxo8mwTAhOHTCbL7crBN0/ht+7IZKYxSErT9TlewnsO7Ybwvo
        qRmMlvrhhXyQAZG4EQg8YklxyCWH
X-Google-Smtp-Source: AAOMgpdStueP/KEmgNtcG6mLh5ynAdnrueR3jaUnSfV/tJ+Mfg+QNL+R6dONXuDUOYRiDbQ+BaPblw==
X-Received: by 2002:a37:5f03:: with SMTP id t3-v6mr21043436qkb.193.1533055850826;
        Tue, 31 Jul 2018 09:50:50 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id t28-v6sm9690060qki.82.2018.07.31.09.50.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 09:50:49 -0700 (PDT)
Subject: Re: [PATCH v2 0/4] Speed up unpack_trees()
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <20180727154241.GA21288@duynguyen.home>
 <20180729103306.16403-1-pclouds@gmail.com>
 <9a9a309c-7143-e642-cfd8-6df76e77995a@gmail.com>
 <CACsJy8BUBjPngHz=icHomor-LJOkMLwZ9bQ6YJDxnoXGg++vjg@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <cc3c4dbb-d545-6a6c-b20e-6a8ca66fc210@gmail.com>
Date:   Tue, 31 Jul 2018 12:50:48 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACsJy8BUBjPngHz=icHomor-LJOkMLwZ9bQ6YJDxnoXGg++vjg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/31/2018 11:31 AM, Duy Nguyen wrote:
> On Mon, Jul 30, 2018 at 8:10 PM Ben Peart <peartben@gmail.com> wrote:
>> I ran "git checkout" on a large repo and averaged the results of 3 runs.
>>    This clearly demonstrates the benefit of the optimized unpack_trees()
>> as even the final "diff-index" is essentially a 3rd call to unpack_trees().
>>
>> baseline        new
>> ----------------------------------------------------------------------
>> 0.535510167     0.556558733     s: read cache .git/index
>> 0.3057373       0.3147105       s: initialize name hash
>> 0.0184082       0.023558433     s: preload index
>> 0.086910967     0.089085967     s: refresh index
>> 7.889590767     2.191554433     s: unpack trees
>> 0.120760833     0.131941267     s: update worktree after a merge
>> 2.2583504       2.572663167     s: repair cache-tree
>> 0.8916137       0.959495233     s: write index, changed mask = 28
>> 3.405199233     0.2710663       s: unpack trees
>> 0.000999667     0.0021554       s: update worktree after a merge
>> 3.4063306       0.273318333     s: diff-index
>> 16.9524923      9.462943133     s: git command:
>> 'c:\git-sdk-64\usr\src\git\git.exe' checkout
>>
>> The first call to unpack_trees() saves 72%
>> The 2nd and 3rd call save 92%
> 
> By the 3rd I guess you meant "diff-index" line. I think it's the same
> with the second call. diff-index triggers the second unpack-trees but
> there's no indent here and it's misleading to read this as diff-index
> and unpack-trees execute one after the other.
> 
>> Total time savings for the entire command was 44%
> 
> Wow.. I guess you have more trees since I could only save 30% on gcc.git.

Yes, with over 500K trees, this optimization really pays off for us.  I 
can't wait to see how this works out in the wild (vs my "lab" based 
performance testing).

Thank you!  I definitely owe you lunch. :)

> 
>> In the performance game of whack-a-mole, that call to repair cache-tree
>> is now looking quite expensive...
> 
> Yeah and I think we can whack that mole too. I did some measurement.
> Best case possible, we just need to scan through two indexes (one with
> many good cache-tree, one with no cache-tree), compare and copy
> cache-tree over. The scanning takes like 1% time of current repair
> step and I suspect it's the hashing that takes most of the time. Of
> course real world won't have such nice numbers, but I guess we could
> maybe half cache-tree update/repair time.
> 

I have some great profiling tools available so will take a look at this 
next and see exactly where the time is being spent.
