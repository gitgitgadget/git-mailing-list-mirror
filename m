Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C86E21F453
	for <e@80x24.org>; Thu, 27 Sep 2018 17:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbeI1AQs (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 20:16:48 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38185 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727612AbeI1AQr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 20:16:47 -0400
Received: by mail-qt1-f193.google.com with SMTP id z13-v6so3740783qts.5
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 10:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=BqCaf7ewZGouMAf4+grLf4pptkAHSzszxSi9BCNVRwM=;
        b=vf3Gye/FUl/8/lQa0YBXWr4BkGyyGcBtN7ROv8UJVXmLVNvApBM/RUFFIY9V6LWOU+
         ZNfMwdh3qwaPR22B5oiHYiWJi2V2f/huv1bsCaCHEXnIeO6ySptNKR1YBl2Oe0Ho+nGC
         62cQmYxAy4RQuWjj7IAKIFvJDkC6hk+Xryp7EXk4hyGNf/xLEQGgOgR27RhVf0mBM2bC
         3XwRPLxYapBl+DgyxW5y46CGJpSDHz8JvPO6RGuod7+i0rPbh9W19ztrxuDjh2YasFTH
         ZwXRPPyMjx6yAVsnC6oKupb0t9cWY1lx9nwvZYIWBQLnc7+eLBdEXoJa4voUe6wbK/b2
         RTHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=BqCaf7ewZGouMAf4+grLf4pptkAHSzszxSi9BCNVRwM=;
        b=L+v7oyriVuVx9bqCaaaj/Snwm77JgNSqO6ga/90CMfzMQcKc4gaF/EsaS19lXN58kR
         mcxwM/mZgzTgu/M/1d2JbKm4nmI5nImkHhnKqgT+Vkrmy57l9/QXawBz3poytEFXJtKL
         xaidYDnL8Afod1cetsIkOGCv0uP4ouMYb3PNnlnFpMW9JHSoctgtlTo8E5S/AL5En5gL
         9iGM13m7xI1Z/+NNsm70Wq2IXeVr3OTC3eJTAKLEDdKchJHFx4A8FCLDAPgx0FMVa2yG
         20xMP4+/yLYViB1WDLImMAlxUkKLZmkk6YVDHxZo9jwkvcArZ10GQIEb0ylR7p4dITz6
         Bzog==
X-Gm-Message-State: ABuFfojtynVxCTUz0zoyqSNlZ+8Nw7GvvcwSqA08Wy4ObCuyUSpQZSOK
        Q89k5SYeuww+bzWgbC6ag3+sFSvDT2c=
X-Google-Smtp-Source: ACcGV62zZa3c7s6xgc+0ebCHIQbiATrXVPQzEQWNkFzhc7KwT8EPeisVJcK+iE63lKMRMir9rJbGvA==
X-Received: by 2002:ac8:3a64:: with SMTP id w91-v6mr9258087qte.144.1538071042037;
        Thu, 27 Sep 2018 10:57:22 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:1455:e436:6b50:1b07? ([2001:4898:8010:0:fd8a:e436:6b50:1b07])
        by smtp.gmail.com with ESMTPSA id p63-v6sm1736355qkl.45.2018.09.27.10.57.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 10:57:21 -0700 (PDT)
Subject: Re: [PATCH v3 7/7] revision.c: refactor basic topo-order logic
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     peff@peff.net, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
References: <pull.25.v2.git.gitgitgadget@gmail.com>
 <pull.25.v3.git.gitgitgadget@gmail.com>
 <020b2f50c5703e8291577b008fdfa567093c6eab.1537551564.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <7b1640a0-4002-9e5f-ea06-4504a5cc9f43@gmail.com>
Date:   Thu, 27 Sep 2018 13:57:21 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <020b2f50c5703e8291577b008fdfa567093c6eab.1537551564.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/21/2018 1:39 PM, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
>
> When running a command like 'git rev-list --topo-order HEAD',
> Git performed the following steps:
>
> 1. Run limit_list(), which parses all reachable commits,
>     adds them to a linked list, and distributes UNINTERESTING
>     flags. If all unprocessed commits are UNINTERESTING, then
>     it may terminate without walking all reachable commits.
>     This does not occur if we do not specify UNINTERESTING
>     commits.
>
> 2. Run sort_in_topological_order(), which is an implementation
>     of Kahn's algorithm. It first iterates through the entire
>     set of important commits and computes the in-degree of each
>     (plus one, as we use 'zero' as a special value here). Then,
>     we walk the commits in priority order, adding them to the
>     priority queue if and only if their in-degree is one. As
>     we remove commits from this priority queue, we decrement the
>     in-degree of their parents.
>
> 3. While we are peeling commits for output, get_revision_1()
>     uses pop_commit on the full list of commits computed by
>     sort_in_topological_order().
>
> In the new algorithm, these three steps correspond to three
> different commit walks. We run these walks simultaneously,
> and advance each only as far as necessary to satisfy the
> requirements of the 'higher order' walk. We know when we can
> pause each walk by using generation numbers from the commit-
> graph feature.
Hello, Git contributors.

I understand that this commit message and patch are pretty daunting. 
There is a lot to read and digest. I would like to see if anyone is 
willing to put the work in to review this patch, as I quite like what it 
does, and the performance numbers below.
> In my local testing, I used the following Git commands on the
> Linux repository in three modes: HEAD~1 with no commit-graph,
> HEAD~1 with a commit-graph, and HEAD with a commit-graph. This
> allows comparing the benefits we get from parsing commits from
> the commit-graph and then again the benefits we get by
> restricting the set of commits we walk.
>
> Test: git rev-list --topo-order -100 HEAD
> HEAD~1, no commit-graph: 6.80 s
> HEAD~1, w/ commit-graph: 0.77 s
>    HEAD, w/ commit-graph: 0.02 s
>
> Test: git rev-list --topo-order -100 HEAD -- tools
> HEAD~1, no commit-graph: 9.63 s
> HEAD~1, w/ commit-graph: 6.06 s
>    HEAD, w/ commit-graph: 0.06 s

If there is something I can do to make this easier to review, then 
please let me know.

Thanks,
-Stolee
