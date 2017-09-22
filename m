Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B489F202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 15:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752087AbdIVPqv (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 11:46:51 -0400
Received: from avasout07.plus.net ([84.93.230.235]:56460 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751876AbdIVPqv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 11:46:51 -0400
Received: from [10.0.2.15] ([147.147.86.16])
        by avasout07 with smtp
        id Cfmo1w0030M91Ur01fmprS; Fri, 22 Sep 2017 16:46:49 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=CrLPSjwD c=1 sm=1 tr=0
 a=dubYQqM3tRRTmV8xSh8cXQ==:117 a=dubYQqM3tRRTmV8xSh8cXQ==:17
 a=IkcTkHD0fZMA:10 a=mhkUloOPBIUvhMHlNB4A:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 2/4] commit-slab.h: avoid -Wsign-compare warnings
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
References: <f120046a-f0b3-6199-a2fc-65a5fd37c0a3@ramsayjones.plus.com>
 <20170922052916.fiafkbykroenq65n@sigill.intra.peff.net>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <5c82e442-9d3a-d748-248d-3ea55a91f777@ramsayjones.plus.com>
Date:   Fri, 22 Sep 2017 16:46:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170922052916.fiafkbykroenq65n@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 22/09/17 06:29, Jeff King wrote:
> On Thu, Sep 21, 2017 at 05:47:36PM +0100, Ramsay Jones wrote:
> 
>> diff --git a/commit-slab.h b/commit-slab.h
>> index 333d81e37..dcaab8ca0 100644
>> --- a/commit-slab.h
>> +++ b/commit-slab.h
>> @@ -78,7 +78,7 @@ static MAYBE_UNUSED void init_ ##slabname(struct slabname *s)		\
>>  									\
>>  static MAYBE_UNUSED void clear_ ##slabname(struct slabname *s)		\
>>  {									\
>> -	int i;								\
>> +	unsigned int i;							\
>>  	for (i = 0; i < s->slab_count; i++)				\
>>  		free(s->slab[i]);					\
>>  	s->slab_count = 0;						\
>> @@ -89,13 +89,13 @@ static MAYBE_UNUSED elemtype *slabname## _at_peek(struct slabname *s,	\
>>  						  const struct commit *c, \
>>  						  int add_if_missing)   \
>>  {									\
>> -	int nth_slab, nth_slot;						\
>> +	unsigned int nth_slab, nth_slot;				\
> 
> I have a feeling that in the long run these should all be size_t, but
> it's probably pretty unlikely to overflow in practice. At any rate, the
> slab index itself is an unsigned, so it probably makes sense to match
> that for now.

Yes, I briefly considered that, but I didn't want to think about
possible effects of the increased size of 'struct slabname'. I suspect
that it is very unlikely to cause an issue, but I had similar concerns
with the 'ALLOC_GROW' patch, were it would have been more likely to
cause memory pressure issues (to e.g. s/int/size_t/). I decided that it
could be addressed separately, with a patch on top, if necessary.

ATB,
Ramsay Jones


