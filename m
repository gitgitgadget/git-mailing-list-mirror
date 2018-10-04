Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF7261F453
	for <e@80x24.org>; Thu,  4 Oct 2018 22:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbeJEFG4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 01:06:56 -0400
Received: from mout.web.de ([217.72.192.78]:47899 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725758AbeJEFGz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 01:06:55 -0400
Received: from [192.168.178.36] ([91.20.58.167]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MfHsM-1gN6Mg0Kvy-00Onsq; Fri, 05
 Oct 2018 00:11:16 +0200
Received: from [192.168.178.36] ([91.20.58.167]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MfHsM-1gN6Mg0Kvy-00Onsq; Fri, 05
 Oct 2018 00:11:16 +0200
Subject: Re: [PATCH v3 2/5] fetch-pack: load tip_oids eagerly iff needed
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net
References: <9f51ac28-73e9-2855-c650-7d695945e286@web.de>
 <20181004213813.158688-1-jonathantanmy@google.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <a82bf622-8ef8-5525-c3a8-b983d0cfe662@web.de>
Date:   Fri, 5 Oct 2018 00:11:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181004213813.158688-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Nx/ISHnvigGRVl+KB7JrApebTh747kJGXn3/1V075svTUsOOYQq
 d/M57BldBh6Vc+MUdNj8hJK3AymD6iohrCz2Ikzpd88kz7dWmRQ+y0QJw+sG3xQNTGQHF1+
 414cuvmcV21fqk6JY/toRe3UB3pNz32fQF6OcWOJv8JM3ZYBR/U+G8QML81rPmM4rDGqvpJ
 jOqk/dM5Lmqf/9deaJOfQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PqFwgJFFZQQ=:550HQfm7O3fRw08yIMjD75
 FyGNLM4FCB0/nBg2mwprGav9eV/88UrsYNR8DCSM0OmWGpPMTOzKY0PwzOqHulgScwh1fVzvT
 APHSYqTh0IDevJuvEYUMBtMF7Wyhw2ppPRVWWIF8dJDQl5+IrQKgnHaEpi0p0L8fpvyPfiHPA
 sftk4G8gru+8gvYF+QrToqpKy6VjOPMGjVPL4eMWPo6qhP5Acxt+MmOYngXpoZTnCDUydEEQG
 vC3izxTIEVK+oWSl1KgxTpMyqL162f+w1SV58Lj3PunqXX0qcs0EtarnlmLOsYsFA/lew7XuG
 Zj7X2olDn8cpypI9n8XrJ/82bsAR8WyG9JfsG+NIeulTDXPvH3lyIfHUShi+QTrvo/ArPjImW
 Lqm9BBM33p432aVRliapn1US6Wc3NyHK6kmmn3Hvl7xmsluNBaJKZX2OrHN+8GdyOA5jxwbof
 OwjQSQ1/IPx7eIKkqhccdGIuCIa2AOfGj9fpfFnzXQLHIsf25X68FLCzK7v4NzhGSd7dG6g+7
 e9i8+TtZgtA2vIBlWqG11UjXWGpHTNq2pRfL9kWYzTE8er+qbWQHFG6RCzl+MEKQUJhPdeWte
 iB70MKWmWrkdm18NweLrr6plEi4wOgBqVnElki4zd43O7EOyJnS6mevVYA2m4SufitwHAWCIp
 h/eyTomMa1+MHl5icB/vTAkn3RdPRqajRLR4/0NMcV7I2QLb7btOjZxAOKzXFbycaycUSwGAM
 rEBsBwdMMWxR9MNsTuuzM9ukp7vzDvQlKY3R07v88l3MQ4k2gRobrWvpxisVziqwFYyBXRNsG
 k3Kg63SZSmPVnaHFzEPPx1YUEHrmTI+bPIBTmqkrtq9jbtnMNg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 04.10.2018 um 23:38 schrieb Jonathan Tan:
>> Determine if the oidset needs to be populated upfront and then do that
>> instead.  This duplicates a loop, but simplifies the existing one by
>> separating concerns between the two.
> 
> [snip]
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
>> +
>>  	/* Append unmatched requests to the list */
>>  	for (i = 0; i < nr_sought; i++) {
>>  		ref = sought[i];
>>  		if (!is_unmatched_ref(ref))
>>  			continue;
>>  
>> -		if ((allow_unadvertised_object_request &
>> -		     (ALLOW_TIP_SHA1 | ALLOW_REACHABLE_SHA1)) ||
>> -		    tip_oids_contain(&tip_oids, unmatched, newlist,
>> -				     &ref->old_oid)) {
>> +		if (!strict || oidset_contains(&tip_oids, &ref->old_oid)) {
>>  			ref->match_status = REF_MATCHED;
>>  			*newtail = copy_ref(ref);
>>  			newtail = &(*newtail)->next;
> 
> I don't think the concerns are truly separated - the first loop quoted
> needs to know that in the second loop, tip_oids is accessed only if
> there is at least one unmatched ref.

Right, the two loops are still closely related, but only the first one
is concerned with loading refs.

For a true separation we could first build a list of unmatched refs and
then loop through that instead of `sought`.  Not sure if that's better,
but maybe the overhead I imagine it would introduce isn't all that big.

> Would it be better to expose the
> size of the oidset and then use it in place of
> "tip_oids->map.map.tablesize"? Checking for initialization (using
> "tablesize") is conceptually different from checking the size, but in
> this code, both initialization and the first increase in size occur upon
> the first oidset_insert(), so we should still get the same result.

It would work in practice.  If there are no refs to load then it would
try to load those zero refs for each unmatched ref, which shouldn't
really be a problem, but I still find it a wee bit sloppy.  Too
theoretical?

René
