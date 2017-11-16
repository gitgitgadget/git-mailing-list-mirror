Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71B43202A0
	for <e@80x24.org>; Thu, 16 Nov 2017 17:44:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965923AbdKPRn5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Nov 2017 12:43:57 -0500
Received: from siwi.pair.com ([209.68.5.199]:37133 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965907AbdKPRnp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Nov 2017 12:43:45 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 46805844E6;
        Thu, 16 Nov 2017 12:43:45 -0500 (EST)
Received: from [10.160.98.77] (unknown [167.220.148.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id E9F32844DF;
        Thu, 16 Nov 2017 12:43:44 -0500 (EST)
Subject: Re: [PATCH 02/14] clone, fetch-pack, index-pack, transport: partial
 clone
To:     Adam Dinwoodie <adam@dinwoodie.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net
References: <20171102203129.59417-1-git@jeffhostetler.com>
 <20171102203129.59417-3-git@jeffhostetler.com>
 <20171103133229.1612a60560469af53c380a76@google.com>
 <20171108180127.GG20681@dinwoodie.org>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <18ed2934-bf90-dc40-5d94-9de058d8f7f1@jeffhostetler.com>
Date:   Thu, 16 Nov 2017 12:43:44 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171108180127.GG20681@dinwoodie.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/8/2017 1:01 PM, Adam Dinwoodie wrote:
> On Friday 03 November 2017 at 01:32 pm -0700, Jonathan Tan wrote:
>> On Thu,  2 Nov 2017 20:31:17 +0000
>> Jeff Hostetler <git@jeffhostetler.com> wrote:
>>> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
>>> index a0a35e6..31cd5ba 100644
>>> --- a/builtin/index-pack.c
>>> +++ b/builtin/index-pack.c
>>> @@ -222,6 +222,16 @@ static unsigned check_object(struct object *obj)
>>>   	if (!(obj->flags & FLAG_CHECKED)) {
>>>   		unsigned long size;
>>>   		int type = sha1_object_info(obj->oid.hash, &size);
>>> +
>>> +		if (type <= 0) {
>>> +			/*
>>> +			 * TODO Use the promisor code to conditionally
>>> +			 * try to fetch this object -or- assume it is ok.
>>> +			 */
>>> +			obj->flags |= FLAG_CHECKED;
>>> +			return 0;
>>> +		}
>>> +
>>>   		if (type <= 0)
>>>   			die(_("did not receive expected object %s"),
>>>   			      oid_to_hex(&obj->oid));
>>
>> This causes some repo corruption tests to fail.
> 
> Confirmed: I see this patch, or at least f7e0dbc38 ("clone, fetch-pack,
> index-pack, transport: partial clone", 2017-11-02), causing t5300.26 to
> fail on 64-bit Cygwin.
> 
> For the sake of anyone trying to reproduce this, I needed to cherry pick
> 66d4c7a58 ("fixup! upload-pack: add object filtering for partial clone",
> 2017-11-08) onto that commit before I was able to get it to compile.
> 
> Adam
> 

Thanks.  I've removed this from my next version.  I think it was
left over from a pre-promisor version.

Jeff
