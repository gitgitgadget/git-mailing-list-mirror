Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D6C820365
	for <e@80x24.org>; Wed,  4 Oct 2017 13:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752498AbdJDNan (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 09:30:43 -0400
Received: from siwi.pair.com ([209.68.5.199]:46955 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752461AbdJDNal (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 09:30:41 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 55FD584621;
        Wed,  4 Oct 2017 09:30:40 -0400 (EDT)
Received: from [10.160.98.77] (unknown [167.220.148.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id E5923845BA;
        Wed,  4 Oct 2017 09:30:39 -0400 (EDT)
Subject: Re: [PATCH 00/18] Partial clone (from clone to lazy fetch in 18
 patches)
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>, Ben Peart <peartben@gmail.com>
References: <cover.1506714999.git.jonathantanmy@google.com>
 <CAP8UFD1WiceKDX9s0hszXXKy+TOxAOvHZyr002HMYkkgbFgD7w@mail.gmail.com>
 <xmqq8tgsipi5.fsf@gitster.mtv.corp.google.com>
 <cb818dcf-beab-10ac-5e58-f56377af4f6a@jeffhostetler.com>
 <CAGf8dgLu-TeK8KbHv-U+18O+L2TxKcGv5vFFHy38J6a_YXRfew@mail.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <6ee48dca-5483-9c7f-4c10-f9ca6fba7239@jeffhostetler.com>
Date:   Wed, 4 Oct 2017 09:30:39 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAGf8dgLu-TeK8KbHv-U+18O+L2TxKcGv5vFFHy38J6a_YXRfew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/3/2017 7:42 PM, Jonathan Tan wrote:
> On Tue, Oct 3, 2017 at 7:39 AM, Jeff Hostetler <git@jeffhostetler.com> wrote:
>>
>> As I see it there are the following major parts to partial clone:
>> 1. How to let git-clone (and later git-fetch) specify the desired
>>     subset of objects that it wants?  (A ref-relative request.)
>> 2. How to let the server and git-pack-objects build that incomplete
>>     packfile?
>> 3. How to remember in the local config that a partial clone (or
>>     fetch) was used and that missing object should be expected?
>> 4. How to dynamically fetch individual missing objects individually?
>>      (Not a ref-relative request.)
>> 5. How to augment the local ODB with partial clone information and
>>     let git-fsck (and friends) perform limited consistency checking?
>> 6. Methods to bulk fetching missing objects (whether in a pre-verb
>>     hook or in unpack-tree)
>> 7. Miscellaneous issues (e.g. fixing places that accidentally cause
>>     a missing object to be fetched that don't really need it).
> 
> Thanks for the enumeration.
> 
>> As was suggested above, I think we should merge our efforts:
>> using my filtering for 1 and 2 and Jonathan's code for 3, 4, and 5.
>> I would need to eliminate the "relax" options in favor of his
>> is_promised() functionality for index-pack and similar.  And omit
>> his blob-max-bytes changes from pack-objects, the protocol and
>> related commands.
>>
>> That should be a good first step.
> 
> This sounds good to me. Jeff Hostetler's filtering (all blobs, blobs
> by size, blobs by sparse checkout specification) is more comprehensive
> than mine, so removing blob-max-bytes from my code is not a problem.
> 
>> We both have thoughts on bulk fetching (mine in pre-verb hooks and
>> his in unpack-tree).  We don't need this immediately, but can wait
>> until the above is working to revisit.
> 
> Agreed.
> 

Thanks.

I'll make a first pass at merging our efforts then and
post something shortly.

Jeff

