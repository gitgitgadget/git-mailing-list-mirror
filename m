Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4284E1F453
	for <e@80x24.org>; Thu, 25 Oct 2018 13:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbeJYVdZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 17:33:25 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:41249 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727302AbeJYVdZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 17:33:25 -0400
Received: by mail-vk1-f193.google.com with SMTP id c82so2145233vke.8
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 06:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=zVimiNSprk2V97wndNvzsG9pmQUtPjQt5fcVcpTl+sg=;
        b=akfZACaBrHky0RQiucQyzaKfhMmy7HmpCdTJtKRLg83JFa/rMQiXM9021aaa9FTAs0
         sS0ctwnzfZzj/O67GnxPQ/Ic0MmcXNXIDgSICy0mKo6cIROkcDlPH1H3nYjUWSyMb91X
         vriavK6Ebpp8A/7iGfIAgrAqb6prD2FCo/o58jYuQrt9j61zGwAjSqj1zxTAvAlMqJsN
         eNeqxojlM+f06mw1lr3NX/6pIeM8ID0Xf3xyhq52RwDE5Pl43KyX5pTtJAHA+3bwO7ug
         933LTNuSD2j9hhgpzFWdz66fp9OfE3kgDRQRLhYImao+cnxJYtb4j46cu9lgLW+GnWOU
         Vt8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=zVimiNSprk2V97wndNvzsG9pmQUtPjQt5fcVcpTl+sg=;
        b=ZIlcrqhwWrCdvA8t9zp4qfuayhWrwkshi9Qk8NfPl721H9irxgklweEiRq5wdjJHSq
         /j1rruEgUe8BkwjOcSv6D3AKGYMNgW2Y+jMIMjd2DlDcIccm2wiTUAzFUqSr/jqK+Bzl
         u2ERZzgIywxatWuUbv86TC9zdHcHg5b+kN+Ms57lJEudjFsg//PsnrlN/CoyIb0ts4JE
         V92vzncW8cBLZGXTOARdMZvhkE/v1ag7ZaPyxaahQgPriMZhhiYTEUYCGyLUUnNzGBw+
         /jMIJcT53LCDDo4Va1Xtv8ewrb/ngSj5Da0WpFiIee2/AvAfvQHr/pLgZAA4euIuvkTQ
         6zKg==
X-Gm-Message-State: AGRZ1gJc7lOBSEhuPZJduAqA3czxjnwu8IjxROFpP2rdk2u2BcS7aZ0j
        ouKV5b+o4DoMsiuTWQ6Dr3I=
X-Google-Smtp-Source: AJdET5dwtILHAO8Vh9v4OtLDUQ34iRmnTUJ5ZCQHNKnIKqNvLE3J+Vt9MIipsd/w2c/jFmYB8IRB4w==
X-Received: by 2002:a1f:32cd:: with SMTP id y196mr656431vky.12.1540472444580;
        Thu, 25 Oct 2018 06:00:44 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:400:6399:f3e9:8001? ([2001:4898:8010:0:ed35:6399:f3e9:8001])
        by smtp.gmail.com with ESMTPSA id j7sm1805545vsd.17.2018.10.25.06.00.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 06:00:43 -0700 (PDT)
Subject: Re: [PATCH v3 7/7] revision.c: refactor basic topo-order logic
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.25.v2.git.gitgitgadget@gmail.com>
 <pull.25.v3.git.gitgitgadget@gmail.com>
 <020b2f50c5703e8291577b008fdfa567093c6eab.1537551564.git.gitgitgadget@gmail.com>
 <20181011153510.GF27312@sigill.intra.peff.net>
 <1c0eb7d3-7f31-9377-d42f-4ac2f36ac26a@gmail.com>
 <20181025094345.GA18794@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8dfc5be8-e3f8-51ab-cdf8-1f083c503a58@gmail.com>
Date:   Thu, 25 Oct 2018 09:00:44 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:63.0) Gecko/20100101
 Thunderbird/63.0
MIME-Version: 1.0
In-Reply-To: <20181025094345.GA18794@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/25/2018 5:43 AM, Jeff King wrote:
> On Thu, Oct 11, 2018 at 12:21:44PM -0400, Derrick Stolee wrote:
>
>>>> 2. INDEGREE: using the indegree_queue priority queue (ordered
>>>>      by maximizing the generation number), add one to the in-
>>>>      degree of each parent for each commit that is walked. Since
>>>>      we walk in order of decreasing generation number, we know
>>>>      that discovering an in-degree value of 0 means the value for
>>>>      that commit was not initialized, so should be initialized to
>>>>      two. (Recall that in-degree value "1" is what we use to say a
>>>>      commit is ready for output.) As we iterate the parents of a
>>>>      commit during this walk, ensure the EXPLORE walk has walked
>>>>      beyond their generation numbers.
>>> I wondered how this would work for INFINITY. We can't know the order of
>>> a bunch of INFINITY nodes at all, so we never know when their in-degree
>>> values are "done". But if I understand the EXPLORE walk, we'd basically
>>> walk all of INFINITY down to something with a real generation number. Is
>>> that right?
>>>
>>> But after that, I'm not totally clear on why we need this INDEGREE walk.
>> The INDEGREE walk is an important element for Kahn's algorithm. The final
>> output order is dictated by peeling commits of "indegree zero" to ensure all
>> children are output before their parents. (Note: since we use literal 0 to
>> mean "uninitialized", we peel commits when the indegree slab has value 1.)
>>
>> This walk replaces the indegree logic from sort_in_topological_order(). That
>> method performs one walk that fills the indegree slab, then another walk
>> that peels the commits with indegree 0 and inserts them into a list.
> I guess my big question here was: if we have generation numbers, do we
> need Kahn's algorithm? That is, in a fully populated set of generation
> numbers (i.e., no INFINITY), we could always just pick a commit with the
> highest generation number to show.
>
> So if we EXPLORE down to a real generation number in phase 1, why do we
> need to care about INDEGREE anymore? Or am I wrong that we always have a
> real generation number (i.e., not INFINITY) after EXPLORE? (And if so,
> why is exploring to a real generation number a bad idea; presumably
> it's due to a worst-case that goes deeper than we'd otherwise need to
> here).

The issue is that we our final order (used by level 3) is unrelated to 
generation number. Yes, if we prioritized by generation number then we 
could output the commits in _some_ order that doesn't violate 
topological constraints. However, we are asking for a different 
priority, which is different than the generation number priority.

In the case of "--topo-order", we want to output the commits reachable 
from the second parent of a merge before the commits reachable from the 
first parent. However, in most cases the generation number of the first 
parent is higher than the second parent (there are more things in the 
merge chain than in a small topic that got merged). The INDEGREE is what 
allows us to know when we can peel these commits while still respecting 
the priority we want at the end.

Thanks,
-Stolee
