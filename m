Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF4E61F462
	for <e@80x24.org>; Thu, 30 May 2019 14:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfE3OBv (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 May 2019 10:01:51 -0400
Received: from siwi.pair.com ([209.68.5.199]:31040 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbfE3OBu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 May 2019 10:01:50 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 2BA103F4090;
        Thu, 30 May 2019 10:01:49 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:c90f:aaf8:aafe:c1ce] (unknown [IPv6:2001:4898:a800:1010:7a45:aaf8:aafe:c1ce])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 81FEB3F4051;
        Thu, 30 May 2019 10:01:48 -0400 (EDT)
Subject: Re: [PATCH v1 3/5] list-objects-filter: implement composite filters
To:     Matthew DeVore <matvore@comcast.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthew DeVore <matvore@google.com>, jonathantanmy@google.com,
        jrn@google.com, git@vger.kernel.org, dstolee@microsoft.com,
        jeffhost@microsoft.com, jrnieder@gmail.com, pclouds@gmail.com
References: <cover.1558484115.git.matvore@google.com>
 <1f95597eedc4c651868601c0ff7c4a4d97ca4457.1558484115.git.matvore@google.com>
 <2b47d4b1-ea62-d59e-77e0-d95dfad084e0@jeffhostetler.com>
 <xmqqh89e31fg.fsf@gitster-ct.c.googlers.com>
 <20190529150228.GC4700@comcast.net>
 <9f1025ec-a3d7-c5f4-4a7a-15e4131f2b87@jeffhostetler.com>
 <20190529232746.GE4700@comcast.net>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <0d8973e7-5b29-fb09-a435-3bf2ec23269f@jeffhostetler.com>
Date:   Thu, 30 May 2019 10:01:47 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190529232746.GE4700@comcast.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/29/2019 7:27 PM, Matthew DeVore wrote:
> On Wed, May 29, 2019 at 05:29:14PM -0400, Jeff Hostetler wrote:
>> Was sparse:path filter the only reason for needing all the URL encoding?
>> The sparse:oid form allows values <ref>:<path> and these (or at least
>> the <path> portion) may contain special characters.  So don't we need to
>> URL encode this form too?
> 
> Oh, I missed this. I was only thinking an oid was allowed after "sparse:". So as
> I suspected I was overlooking something obvious.
> 
> Now I just want to understand the objection to URL encoding a little better. I
> haven't worked with in a project that requires a lot of boilerplate before, so I
> may be asking obvious things again. If so, sorry in advance.
> 
> So the objections, as I interpret them so far, are that:
> 
>   a the URL encoding/decoding complicates the code base
>   b explaining the URL encoding, while it allows for future expansion, requires
>     some verbose documentation in git-rev-list that is potentially distracting or
>     confusing
>   c there may be a better way to allow for future expansion that does not require
>     URL encoding
>   d the URL encoding is unpleasant to use (note that my patchset makes it
>     optional for the user to use and it is only mandatory in sending it over the
>     wire)
> 
> I think these are reasonable and I'm willing to stop digging my heels in :) Does
> the above sum everything up?
> 

My primary concern was how awkward it would be to use the URL
encoding syntax on the command line, but as you say, that can be
avoided by using the multiple --filter args.

And to be honest, the wire format is hidden from user view, so it
doesn't really matter there.  So either approach is fine.  I was
hoping that the "filters (plural)" approach would let us avoid URL
encoding, but that comes with its own baggage as you suggested.
And besides, URL encoding is well-understood.

And I don't want to prematurely complicate this with ANDs ORs and
XORs as you mention in another thread.

So don't let me stop this effort.


BTW, I don't think I've seen this mentioned anywhere and I don't
remember if this got into the code or not.  But we discussed having
a repo-local config setting to remember the filter-spec used by the
partial clone that would be inherited by a subsequent (partial) fetch.
Or would be set by the first partial fetch following a normal clone.
Having a single composite filter spec would help with this.

Jeff
