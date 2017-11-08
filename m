Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 906AD1F43C
	for <e@80x24.org>; Wed,  8 Nov 2017 14:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752617AbdKHOji (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Nov 2017 09:39:38 -0500
Received: from siwi.pair.com ([209.68.5.199]:63180 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751839AbdKHOjh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Nov 2017 09:39:37 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id C3FB384557;
        Wed,  8 Nov 2017 09:39:36 -0500 (EST)
Received: from [10.160.98.77] (unknown [167.220.148.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 61EC184556;
        Wed,  8 Nov 2017 09:39:35 -0500 (EST)
Subject: Re: [PATCH v2 0/6] Partial clone part 1: object filtering
To:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20171102175013.3371-1-git@jeffhostetler.com>
 <20171102124445.fbffd43521cd35f6a71e1851@google.com>
 <bd41699f-19c7-02a0-0af1-8f22b3277a1b@jeffhostetler.com>
 <xmqq7ev7pfln.fsf@gitster.mtv.corp.google.com>
 <97585434-6d57-dad4-d7aa-e48dacec1b3f@jeffhostetler.com>
 <20171107164118.97cc65c4030de0922b19ddd6@google.com>
 <xmqq8tfhoai3.fsf@gitster.mtv.corp.google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <de392bf3-bd53-1c17-3a43-c2e1604cbd59@jeffhostetler.com>
Date:   Wed, 8 Nov 2017 09:39:35 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqq8tfhoai3.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/7/2017 7:54 PM, Junio C Hamano wrote:
> Jonathan Tan <jonathantanmy@google.com> writes:
> 
>> I can see some use for this parameter - for example, when doing a report
>> for statistical purposes (percentage of objects missing, for example) or
>> for a background task that downloads missing objects into a cache. Also,
>> power users who know what they're doing (or normal users in an
>> emergency) can use this option when they have no network connection if
>> they really need to find something out from the local repo.
>>
>> In these cases, the promisor check (after detecting that the object is
>> missing) is indeed not so useful, I think. (Or we can do the
>> --exclude=missing and --exclude=promisor idea that Jeff mentioned -
>> --exclude=missing now, and --exclude=promisor after we add promisor
>> support.)
> 
> This sounds like a reasonable thing to have in the endgame state to
> me.

OK thanks, I'll change it to --exclude=missing in my next version.
  
> 
>> Having said that, I would be OK if we didn't have tolerance (and/or
>> reporting) of missing objects right now. As far as I know, for the
>> initial implementation of partial clone, only the server performs any
>> filtering, and we assume that the server possesses all objects (so it
>> does not need to filter out any missing objects).
> 
> True.  It does not have to exist in an early part, but I do not
> think we would terribly mind if it does, if only to help debugging
> and development.
> 
> Thanks for thinking it through.
> 

Right, it could come later, but having it here in part 1 as part
of the initial series completes the pre-promisor portion of these
commands.  Having a print-missing option lets rev-list -- as is --
be used in a bulk-fetch-object pre-checkout hook or as part of a
"give me what I need before I go offline" command.  This is useful
by itself.  It does augment the dynamic fetch-object code added in
part 2 and the unpack-trees changes in part 3 to call fetch-object.

Jeff


