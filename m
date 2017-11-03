Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B45620450
	for <e@80x24.org>; Fri,  3 Nov 2017 18:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751790AbdKCSem (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Nov 2017 14:34:42 -0400
Received: from siwi.pair.com ([209.68.5.199]:62037 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751290AbdKCSel (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Nov 2017 14:34:41 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id E415E84550;
        Fri,  3 Nov 2017 14:34:40 -0400 (EDT)
Received: from [10.160.98.77] (unknown [167.220.148.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 8162F8454F;
        Fri,  3 Nov 2017 14:34:40 -0400 (EDT)
Subject: Re: [PATCH v2 0/6] Partial clone part 1: object filtering
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        peff@peff.net, Jeff Hostetler <jeffhost@microsoft.com>
References: <20171102175013.3371-1-git@jeffhostetler.com>
 <20171102124445.fbffd43521cd35f6a71e1851@google.com>
 <bd41699f-19c7-02a0-0af1-8f22b3277a1b@jeffhostetler.com>
 <xmqq7ev7pfln.fsf@gitster.mtv.corp.google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <97585434-6d57-dad4-d7aa-e48dacec1b3f@jeffhostetler.com>
Date:   Fri, 3 Nov 2017 14:34:39 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqq7ev7pfln.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/3/2017 11:05 AM, Junio C Hamano wrote:
> Jeff Hostetler <git@jeffhostetler.com> writes:
> 
>> Yes, I thought we should have both (perhaps renamed or combined
>> into 1 parameter with value, such as --exclude=missing vs --exclude=promisor)
>> and let the user decide how strict they want to be.
> 
> Assuming we eventually get promisor support working, would there be
> any use case where "any missing is OK" mode would be useful in a
> sense more reasonable than "because we could have such a mode" and
> "it is not our business to prevent users from playing with fire"?
> 

For now, I'd like to keep my "any missing is OK" option.
I do think it has value all by itself.

We are essentially using something like that now with our GVFS
users on the gigantic Windows repo and haven't had any issues.

But yes, when we get promisor support working, we could revisit
the need for this parameter.

However, I do have some scaling concerns here.  If for example,
I have 100M missing blobs (because we did an only commits-and-trees
clone), the cost to compute "promisor missing" vs "just missing"
might be prohibitively expensive.  It could be something we want
fsck/gc to be aware of, but other commands may want to just assume
any missing objects are expected and continue.

Hopefully, we won't have a scale problem, but we just don't know
yet.

Jeff
