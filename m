Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 126761F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 16:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729484AbeJKXtn (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 19:49:43 -0400
Received: from mail-qt1-f176.google.com ([209.85.160.176]:43856 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728262AbeJKXtn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 19:49:43 -0400
Received: by mail-qt1-f176.google.com with SMTP id q41-v6so10501851qtq.10
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 09:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=678+7KBF9mf88+Fnv+Cxi0eU0ugoK7pUj5XCfPfes3Q=;
        b=hNTaNEDls6dk+wIYJRC21Kx3qlfWgWIRuql3O9eJnuTGV+u2EQ33Kz1NfyVt94m9Ht
         uaJkZ35EBRPcR1X5jSnaADojrjLst9KsX0zx3aoTVf2MWb9lcggwgJU92UIscAcG42NY
         uEzSHhDnNbRnayiECNWc+Cr9HsVwf5Cc+o4JuBV4T2gbNAaP0VbDlSichiSWp6bXF/55
         W2XPSC+ss895P/jMVgt5pjPbNNcrw9M5qepWPhRiIy4YWAdg09Xfvg4m2KXkrCh4ggFU
         witlm5W1vC9F4X784N37hno8rOIsovSnUyH0tTGD0eisQWSRapqzQANYVWzpjkaqA+tY
         DWhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=678+7KBF9mf88+Fnv+Cxi0eU0ugoK7pUj5XCfPfes3Q=;
        b=BKoX0FQsTdJM3p5Zy+cIgHQSx8wtKEOgXI1VZTVsfOCMR6jIarp/wlblAAaI2A/Zk0
         7rCdrZp3Z2wpH17hakDqLO8r0xS3PlAuXlUvzUz4KCTiMhBdXUj9D8cKD1zeYw/SiD9G
         n5hjQ9iysLVeAl59996XuAc1hpyfJAefiOMfcmKs/3NbcN7xVFEAWnRhasewMEj7Zinl
         f/m6PSyOP6n4Rb0uN+CI/4/dMMl+JjnvutW/llkURk8s1tezaNjJRj5mZAbqGBxEajDd
         yQmszEQiPWMr/1u5+eK6L1AiKDM+vLR2Pz9I9owFwmx5v+E8hJTfEEMD9Ai0hSC/9yPv
         GEAg==
X-Gm-Message-State: ABuFfoj3SmAzNYPBTfOeOzDq6lOqMbTPapDee0WVA2bkWxp7OF4cb9xk
        EMRoU0rYfiqVrGL6nkKl5SY=
X-Google-Smtp-Source: ACcGV60IOZM0E2FaRFMqFrO8oAQmEf9a1QiC/b/WxPyCbwvSBLs6HiTGuPOSYddJbi8+PfCmx/M9CA==
X-Received: by 2002:a0c:90c2:: with SMTP id p60-v6mr2272494qvp.173.1539274906609;
        Thu, 11 Oct 2018 09:21:46 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:60fa:c2a9:b517:a087? ([2001:4898:8010:0:4a30:c2a9:b517:a087])
        by smtp.gmail.com with ESMTPSA id o96-v6sm4138293qte.22.2018.10.11.09.21.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 09:21:45 -0700 (PDT)
Subject: Re: [PATCH v3 7/7] revision.c: refactor basic topo-order logic
To:     Jeff King <peff@peff.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.25.v2.git.gitgitgadget@gmail.com>
 <pull.25.v3.git.gitgitgadget@gmail.com>
 <020b2f50c5703e8291577b008fdfa567093c6eab.1537551564.git.gitgitgadget@gmail.com>
 <20181011153510.GF27312@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <1c0eb7d3-7f31-9377-d42f-4ac2f36ac26a@gmail.com>
Date:   Thu, 11 Oct 2018 12:21:44 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181011153510.GF27312@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/11/2018 11:35 AM, Jeff King wrote:
> On Fri, Sep 21, 2018 at 10:39:36AM -0700, Derrick Stolee via GitGitGadget wrote:
>
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> When running a command like 'git rev-list --topo-order HEAD',
>> Git performed the following steps:
>> [...]
>> In the new algorithm, these three steps correspond to three
>> different commit walks. We run these walks simultaneously,
> A minor nit, but this commit message doesn't mention the most basic
> thing up front: that its main purpose is to introduce a new algorithm
> for topo-order. ;)
>
> It's obvious in the context of reviewing the series, but somebody
> reading "git log" later may want a bit more. Perhaps:
>
>    revision.c: implement generation-based topo-order algorithm
>
> as a subject, and/or an introductory paragraph like:
>
>    The current --topo-order algorithm requires walking all commits we
>    are going to output up front, topo-sorting them, all before
>    outputting the first value. This patch introduces a new algorithm
>    which uses stored generation numbers to incrementally walk in
>    topo-order, outputting commits as we go.
>
> Other than that, I find this to be a wonderfully explanatory commit
> message. :)

Good idea. I'll make that change.

>
>> The walks are as follows:
>>
>> 1. EXPLORE: using the explore_queue priority queue (ordered by
>>     maximizing the generation number), parse each reachable
>>     commit until all commits in the queue have generation
>>     number strictly lower than needed. During this walk, update
>>     the UNINTERESTING flags as necessary.
> OK, this makes sense. If we know that everybody else in our queue is at
> generation X, then it is safe to output a commit at generation greater
> than X.
>
> I think this by itself would allow us to implement "show no parents
> before all of its children are shown", right? But --topo-order promises
> a bit more: "avoid showing commits no multiple lines of history
> intermixed".
>
> I guess also INFINITY generation numbers need more. For a real
> generation number, we know that "gen(A) == gen(B)" implies that there is
> no ancestry relationship between the two. But not so for INFINITY.

Yeah, to deal with INFINITY (and ZERO, but that won't happen if 
generation_numbers_enabled() returns true), we treat gen(A) == gen(B) as 
a "no information" state. So, to output a commit at generation X, we 
need to have our maximum generation number in the unexplored area to be 
at most X - 1. You'll see strict inequality when checking generations.


>> 2. INDEGREE: using the indegree_queue priority queue (ordered
>>     by maximizing the generation number), add one to the in-
>>     degree of each parent for each commit that is walked. Since
>>     we walk in order of decreasing generation number, we know
>>     that discovering an in-degree value of 0 means the value for
>>     that commit was not initialized, so should be initialized to
>>     two. (Recall that in-degree value "1" is what we use to say a
>>     commit is ready for output.) As we iterate the parents of a
>>     commit during this walk, ensure the EXPLORE walk has walked
>>     beyond their generation numbers.
> I wondered how this would work for INFINITY. We can't know the order of
> a bunch of INFINITY nodes at all, so we never know when their in-degree
> values are "done". But if I understand the EXPLORE walk, we'd basically
> walk all of INFINITY down to something with a real generation number. Is
> that right?
>
> But after that, I'm not totally clear on why we need this INDEGREE walk.

The INDEGREE walk is an important element for Kahn's algorithm. The 
final output order is dictated by peeling commits of "indegree zero" to 
ensure all children are output before their parents. (Note: since we use 
literal 0 to mean "uninitialized", we peel commits when the indegree 
slab has value 1.)

This walk replaces the indegree logic from sort_in_topological_order(). 
That method performs one walk that fills the indegree slab, then another 
walk that peels the commits with indegree 0 and inserts them into a list.

>> 3. TOPO: using the topo_queue priority queue (ordered based on
>>     the sort_order given, which could be commit-date, author-
>>     date, or typical topo-order which treats the queue as a LIFO
>>     stack), remove a commit from the queue and decrement the
>>     in-degree of each parent. If a parent has an in-degree of
>>     one, then we add it to the topo_queue. Before we decrement
>>     the in-degree, however, ensure the INDEGREE walk has walked
>>     beyond that generation number.
> OK, this makes sense to make --author-date-order, etc, work. Potentially
> those numbers might have no relationship at all with the graph
> structure, but we promise "no parent before its children are shown", so
> this is really just a tie-breaker after the topo-sort anyway. As long as
> steps 1 and 2 are correct and produce a complete set of commits for one
> "layer", this should be OK.
>
> I guess I'm not 100% convinced that we don't have a case where we
> haven't yet parsed or considered some commit that we know cannot have an
> ancestry relationship with commits we are outputting. But it may have an
> author-date-order relationship.
>
> (I'm not at all convinced that this _is_ a problem, and I suspect it
> isn't; I'm only suggesting I haven't fully grokked the proof).
The INDEGREE walk should not stop until it has explored at least to the 
point that all indegree 0 commits are exposed (relative to the current 
state of the walk).

At initialization, we walk from all starting positions until the maximum 
generation number in our queue is less than the minimum generation of a 
starting commit. The starting positions that have indegree 0 are then 
added to the topo_queue, and the sort order dictates which is the best. 
 From this point on, we can only create a new "indegree 0" commit by 
removing a commit from the topo_queue and decrementing the indegree of 
its parents. Those parents with indegree 0 are inserted into topo_queue 
and compared to all other indegree 0 commits. Thus, we will always 
explore enough to make the right choice relative our sort order.

>
>> ---
>>   object.h   |   4 +-
>>   revision.c | 196 +++++++++++++++++++++++++++++++++++++++++++++++++++--
>>   revision.h |   2 +
>>   3 files changed, 194 insertions(+), 8 deletions(-)
> I'll pause here on evaluating the actual code. It looks sane from a
> cursory read, but there's no point in digging further until I'm sure I
> fully understand the algorithm. I think that needs a little more brain
> power from me, and hopefully discussion around my comments above will
> help trigger that.
Thanks for reading! I understand that reading the code is useless 
without understanding the high-level concepts. I'm happy to iterate on 
this. If I can find a better way to explain the algorithm in the commit 
message to avoid the "huh?" moments above, then I will.

Thanks,
-Stolee
