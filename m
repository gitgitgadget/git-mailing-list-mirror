Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 124401F97E
	for <e@80x24.org>; Fri,  5 Oct 2018 20:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbeJFDOA (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 23:14:00 -0400
Received: from mout.web.de ([212.227.15.4]:37477 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728160AbeJFDOA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 23:14:00 -0400
Received: from [192.168.178.36] ([91.20.58.167]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MF3iV-1fwlA32Ds3-00GLME; Fri, 05
 Oct 2018 22:13:36 +0200
Received: from [192.168.178.36] ([91.20.58.167]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MF3iV-1fwlA32Ds3-00GLME; Fri, 05
 Oct 2018 22:13:36 +0200
Subject: Re: [PATCH v3 2/5] fetch-pack: load tip_oids eagerly iff needed
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
References: <64911aec-71cd-d990-5dfd-bf2c3163690c@web.de>
 <14e57ec8-b8a2-10bd-688d-1cb926e77675@web.de>
 <9f51ac28-73e9-2855-c650-7d695945e286@web.de>
 <20181004220711.GA28287@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <c75fa650-d2b4-9979-a1f2-25d75c6f447b@web.de>
Date:   Fri, 5 Oct 2018 22:13:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181004220711.GA28287@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:i1A6TZQ9qAFn8UvaWaFKktWkKZIgxS8bJwEZTcUb0JbFhZ4nfYP
 5r8garkfOUV1qQTBak9TG9xEpZ6G642HgcYoMOFYPDNpdljoXr5Vo7jiJAOvyYb0ToEdYof
 vbQK92rAw9hzN0bgRx7XcXaZoSwT2jOYFb7pJMW6JMPsg190WtHzVBGUxlfs/D0sS3rsQ5Q
 Dpjzy/FF6dqWH+5J3MUCg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8JuCD0auGAs=:bdIHQJPfk6Vr16GMWuL5A7
 2ztqskmg9a4Fyv/aBZxTKxMlkgak3rnvOCjwKdtk/CiN6wGSNmBxklp4xCfkIoGqBJFLmFeep
 37Bf/3TIeQ2GShzRcuae/0Ejv5WCCh8GsITU9XiZSIM0E2pmWj3h7n9jzzdjhyQu6/4daVrAO
 w786gIXdl1uxsJlPbMx5/g9oiE7kRB6re+AYVmwRtSKop7I8+7JMmAibJRTQ0NpiXb89cuCBq
 JRHXvbvsP+5IPJRk1VTuL9CHAXqNBdHj8AOQHbTg2bnHhNsMfT3/CNU7AiVhcSPBPncypQIhZ
 Plo5NQaVrEMObUPRL2Y/YuwVZmlBdp+gbeEowbXAklcZUwAaLXzKrWOGqBu6LXJ3Tsn2nD+Fm
 n4ltCMFsRDAlSloWEzhhOTpY2J0x5mpTHlOBVPO5dRvwKcJgrPOifEAfxBMTP79wAApw5nPjW
 WY8iY2YA66Dgz1dRcIDKyZEYv5uBMvy9jgz1myPZFgXXvqa2D7XnjxA+ME59qqN2zr+HIajEz
 u/5Q3AcxC8DrhgpBCGVjdkVG+sJ+Z8llbrp3doIyGqrCxl6wvOmZXQFWbpnntA7C8zzHjBkhr
 dk6UZcDlXayBso9unlW9+sU8jb0eQq8K8xGsFr7glZT/ADLFa7kI4S54Kl2uu/7mw3eefJdQl
 vISuPsd4HE0ezQoqpxa/ERtlozZVA+Gq2cAlnXpkw0Wv9PlwmEc07wJNr1e8P5HRYIc6JiJAs
 GtWu65S+w4RpV+yIRt4xXVZyKNu+Jq+IoGJEV7TvX4k4s18SucOTXvKHJlKC88gMEgXYPqO77
 Qrl6M+GAqlpIHHqihnyZR74NSceIsVlnglS59T399gkrowzfeo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.10.2018 um 00:07 schrieb Jeff King:
> On Thu, Oct 04, 2018 at 05:09:39PM +0200, René Scharfe wrote:
> 
>> tip_oids_contain() lazily loads refs into an oidset at its first call.
>> It abuses the internal (sub)member .map.tablesize of that oidset to
>> check if it has done that already.
>>
>> Determine if the oidset needs to be populated upfront and then do that
>> instead.  This duplicates a loop, but simplifies the existing one by
>> separating concerns between the two.
> 
> I like this approach much better than what I showed earlier. But...
> 
>> diff --git a/fetch-pack.c b/fetch-pack.c
>> index 3b317952f0..53914563b5 100644
>> --- a/fetch-pack.c
>> +++ b/fetch-pack.c
>> @@ -526,23 +526,6 @@ static void add_refs_to_oidset(struct oidset *oids, struct ref *refs)
>>  		oidset_insert(oids, &refs->old_oid);
>>  }
>>  
>> -static int tip_oids_contain(struct oidset *tip_oids,
>> -			    struct ref *unmatched, struct ref *newlist,
>> -			    const struct object_id *id)
>> -{
>> -	/*
>> -	 * Note that this only looks at the ref lists the first time it's
>> -	 * called. This works out in filter_refs() because even though it may
>> -	 * add to "newlist" between calls, the additions will always be for
>> -	 * oids that are already in the set.
>> -	 */
> 
> I don't think the subtle point this comment is making goes away. We're
> still growing the list in the loop that calls tip_oids_contain() (and
> which now calls just oidset_contains). That's OK for the reasons given
> here, but I think that would need to be moved down to this code:
> 
>> +	if (strict) {
>> +		for (i = 0; i < nr_sought; i++) {
>> +			ref = sought[i];
>> +			if (!is_unmatched_ref(ref))
>> +				continue;
>> +
>> +			add_refs_to_oidset(&tip_oids, unmatched);
>> +			add_refs_to_oidset(&tip_oids, newlist);
>> +			break;
>> +		}
>> +	}
> 
> I.e., we need to say here why it's OK to summarize newlist in the
> oidset, even though we're adding to it later.

There is already this comment:

	/* Append unmatched requests to the list */

And that's enough in my eyes.  The refs loop at the top splits the list
into matched ("the list") and unmatched, and the loop below said comment
adds a few more.  I see no subtlety left -- what do I miss?

René
