Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A159C1F424
	for <e@80x24.org>; Thu, 21 Dec 2017 14:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751828AbdLUOGa (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Dec 2017 09:06:30 -0500
Received: from siwi.pair.com ([209.68.5.199]:48561 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751620AbdLUOGa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Dec 2017 09:06:30 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 6EECD844C3;
        Thu, 21 Dec 2017 09:06:29 -0500 (EST)
Received: from [10.160.98.77] (unknown [167.220.148.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 2DB70844C1;
        Thu, 21 Dec 2017 09:06:29 -0500 (EST)
Subject: Re: [PATCH 2/4] stat_tracking_info: return +1 when branch and
 upstream differ
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20171220144245.39401-1-git@jeffhostetler.com>
 <20171220144245.39401-3-git@jeffhostetler.com>
 <20171220161407.GB31149@sigill.intra.peff.net>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <1c4d5de6-566e-5b5f-7cfc-66b2874a7d63@jeffhostetler.com>
Date:   Thu, 21 Dec 2017 09:06:28 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20171220161407.GB31149@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/20/2017 11:14 AM, Jeff King wrote:
> On Wed, Dec 20, 2017 at 02:42:43PM +0000, Jeff Hostetler wrote:
> 
>> Extend stat_tracking_info() to return 1 when the branch is
>> not up to date with its upstream branch and only return 0
>> when they are equal.
> 
> This means that callers all need to be updated, but there's no change
> that the compiler could catch. You've updated all of the calls here, but
> any topics in flight would need to be fixed, too.
> 
> I don't see any any in pu, but there are a number of long-running forks
> hanging around these days.
> 
> Is it worth introducing a small change so that any other callers which
> get merged in force a human to look at them? I'm wondering if we could
> just re-order the "upstream_name" argument or something.

Good point.  I usually try to avoid signature changes to minimize the
disruption, but as you say that can be a good thing too.  I'll add an
argument rather than using the null field trick.

> 
>> --- a/remote.c
>> +++ b/remote.c
>> @@ -1983,7 +1983,9 @@ int ref_newer(const struct object_id *new_oid, const struct object_id *old_oid)
>>    * is not itself NULL.
>>    *
>>    * Returns -1 if num_ours and num_theirs could not be filled in (e.g., no
>> - * upstream defined, or ref does not exist), 0 otherwise.
>> + * upstream defined, or ref does not exist).
>> + * Returns 0 if the commits are the same (the branch is up to date).
>> + * Returns 1 if the commits are different (the branch is not up to date).
> 
> Slightly pedantic, but we'd return 1 here also if the branch is ahead of
> its upstream, right?

Yeah, poor word choice on my part.  I'll fix.

Thanks
Jeff

