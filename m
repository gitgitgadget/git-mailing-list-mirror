Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF20C20281
	for <e@80x24.org>; Tue, 26 Sep 2017 14:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937260AbdIZODQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 10:03:16 -0400
Received: from siwi.pair.com ([209.68.5.199]:19748 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936707AbdIZODP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 10:03:15 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id E93FC8458D;
        Tue, 26 Sep 2017 10:03:14 -0400 (EDT)
Received: from [10.160.98.77] (unknown [167.220.148.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id AE3D58458B;
        Tue, 26 Sep 2017 10:03:14 -0400 (EDT)
Subject: Re: RFC: Design and code of partial clones (now, missing commits and
 trees OK) (part 2/3)
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peartben@gmail.com,
        Christian Couder <christian.couder@gmail.com>
References: <20170915134343.3814dc38@twelve2.svl.corp.google.com>
 <5d295ab3-310e-321e-6e88-69484eb9ce8a@jeffhostetler.com>
 <20170921155150.1d57d89e@twelve2.svl.corp.google.com>
 <5b251b02-fe00-3d99-8ae2-d6df0193ebe0@jeffhostetler.com>
 <20170922155235.7b50de91f0370d9101cc4faa@google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <4cc2e996-250d-c62c-905d-b75467d7fe09@jeffhostetler.com>
Date:   Tue, 26 Sep 2017 10:03:14 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170922155235.7b50de91f0370d9101cc4faa@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/22/2017 6:52 PM, Jonathan Tan wrote:
> On Fri, 22 Sep 2017 17:19:50 -0400
> Jeff Hostetler <git@jeffhostetler.com> wrote:
> 
>>> In your specific example, how would rev-list know, on the client, to
>>> include (or exclude) a large blob in its output if it does not have it,
>>> and thus does not know its size?
>>>
>>
>> The client doesn't have the size. It just knows it is missing and it
>> needs it. It doesn't matter why it is missing.  (But I guess the client
>> could assume it is because it is large.)
> 
> Ah, OK.
> 
>> So rev-list on the client could filter the objects it has by size.
> 
> My issue is that if the purpose of this feature in rev-list is to do
> prefetching, the only criterion we need to check for is absence from the
> local repo right? (Or is filtering by size on the client useful for
> other reasons?)

The prefetch before a checkout may want all missing blobs, or it
want to work with the sparse-checkout specification and only get
the required missing blobs in the subset of the tree.  By putting
the same filter logic in rev-list, we can do that.

It also sets the stage for later filtering trees.  (My current patch
only filters blobs.  It would be nice to have a second version of the
sparse filter that also omits trees, but that may require a recursive
option in the fetch-objects protocol.)


> 
>> FYI I just posted my RFC this afternoon.
>> https://public-inbox.org/git/20170922204211.GA24036@google.com/T/
> 
> Thanks, I'll take a look.
> 
