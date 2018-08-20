Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E50281F954
	for <e@80x24.org>; Mon, 20 Aug 2018 19:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbeHTW73 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 18:59:29 -0400
Received: from siwi.pair.com ([209.68.5.199]:41135 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbeHTW73 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 18:59:29 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 2249A3F4094;
        Mon, 20 Aug 2018 15:42:34 -0400 (EDT)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id EF3BF3F4088;
        Mon, 20 Aug 2018 15:42:33 -0400 (EDT)
Subject: Re: [PATCH v7 09/16] fetch: support filters
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20171208155851.855-1-git@jeffhostetler.com>
 <20171208155851.855-10-git@jeffhostetler.com>
 <CACsJy8D3nC+fXFYMKWh6AStbMVOVfmcAvAT9tBqtG9K6r043eQ@mail.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <409954a1-6aff-f187-ec3e-c0bf044d279f@jeffhostetler.com>
Date:   Mon, 20 Aug 2018 15:42:33 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8D3nC+fXFYMKWh6AStbMVOVfmcAvAT9tBqtG9K6r043eQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/19/2018 7:24 AM, Duy Nguyen wrote:
> On Fri, Dec 8, 2017 at 5:00 PM Jeff Hostetler <git@jeffhostetler.com> wrote:
>>
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Teach fetch to support filters. This is only allowed for the remote
>> configured in extensions.partialcloneremote.
>>
>> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
>> ---
>>   builtin/fetch.c       | 23 +++++++++++++++++++++--
>>   connected.c           |  2 ++
>>   remote-curl.c         |  6 ++++++
>>   t/t5500-fetch-pack.sh | 36 ++++++++++++++++++++++++++++++++++++
>>   4 files changed, 65 insertions(+), 2 deletions(-)
>>
>> diff --git a/builtin/fetch.c b/builtin/fetch.c
>> index 1b1f039..14aab71 100644
>> --- a/builtin/fetch.c
>> +++ b/builtin/fetch.c
>> @@ -18,6 +18,7 @@
>>   #include "argv-array.h"
>>   #include "utf8.h"
>>   #include "packfile.h"
>> +#include "list-objects-filter-options.h"
>>
>>   static const char * const builtin_fetch_usage[] = {
>>          N_("git fetch [<options>] [<repository> [<refspec>...]]"),
>> @@ -55,6 +56,7 @@ static int recurse_submodules_default = RECURSE_SUBMODULES_ON_DEMAND;
>>   static int shown_url = 0;
>>   static int refmap_alloc, refmap_nr;
>>   static const char **refmap_array;
>> +static struct list_objects_filter_options filter_options;
>>
>>   static int git_fetch_config(const char *k, const char *v, void *cb)
>>   {
>> @@ -160,6 +162,7 @@ static struct option builtin_fetch_options[] = {
>>                          TRANSPORT_FAMILY_IPV4),
>>          OPT_SET_INT('6', "ipv6", &family, N_("use IPv6 addresses only"),
>>                          TRANSPORT_FAMILY_IPV6),
>> +       OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
> 
> Documentation is missing. Please add something to git-fetch.txt (or
> fetch-options.txt) about this option. I would make a patch but I don't
> know enough about this to write and I'm in the middle of something
> else.
> 

Documentation for --filter=<fs> (and --no-filter) were added to
rev-list-options.txt.  The opening paragraph talks about --objects
which would need to be omitted for fetch and clone, but the rest
of that text is relevant.

I'll push up a patch shortly.

Thanks
Jeff
