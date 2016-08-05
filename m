Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9931620193
	for <e@80x24.org>; Fri,  5 Aug 2016 21:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968600AbcHEV3h (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 17:29:37 -0400
Received: from siwi.pair.com ([209.68.5.199]:17169 "EHLO siwi.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968589AbcHEV3f (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 17:29:35 -0400
Received: from [10.160.15.137] (unknown [167.220.148.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by siwi.pair.com (Postfix) with ESMTPSA id C172A845EE;
	Fri,  5 Aug 2016 17:29:33 -0400 (EDT)
Subject: Re: [PATCH v4 5/8] status: print per-file porcelain v2 status data
To:	Jeff King <peff@peff.net>
References: <1470147137-17498-1-git-send-email-git@jeffhostetler.com>
 <1470147137-17498-6-git-send-email-git@jeffhostetler.com>
 <20160805210222.a2rvlmioim4psbhw@sigill.intra.peff.net>
Cc:	git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de,
	Jeff Hostetler <jeffhost@microsoft.com>
From:	Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <57A504C0.1060808@jeffhostetler.com>
Date:	Fri, 5 Aug 2016 17:27:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20160805210222.a2rvlmioim4psbhw@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org



On 08/05/2016 05:02 PM, Jeff King wrote:
> On Tue, Aug 02, 2016 at 10:12:14AM -0400, Jeff Hostetler wrote:
>
>> +static void wt_porcelain_v2_print_unmerged_entry(
>> +	struct string_list_item *it,
>> +	struct wt_status *s)
>> +{
>> +	struct wt_status_change_data *d = it->util;
>> +	const struct cache_entry *ce;
>> +	struct strbuf buf_current = STRBUF_INIT;
>> +	const char *path_current = NULL;
>> +	int pos, stage, sum;
>> +	struct {
>> +		int mode;
>> +		struct object_id oid;
>> +	} stages[3];
>> +	char *key;
>> [...]
>> +	switch (d->stagemask) {
>> +	case 1: key = "DD"; break; /* both deleted */
>> +	case 2: key = "AU"; break; /* added by us */
>> +	case 3: key = "UD"; break; /* deleted by them */
>> +	case 4: key = "UA"; break; /* added by them */
>> +	case 5: key = "DU"; break; /* deleted by us */
>> +	case 6: key = "AA"; break; /* both added */
>> +	case 7: key = "UU"; break; /* both modified */
>> +	}
>> [...]
>> +	fprintf(s->fp, "%c %s %s %06o %06o %06o %06o %s %s %s %s%c",
>> +			unmerged_prefix, key, submodule_token,
>
> Coverity complains that "key" can be uninitialized here. I think it's
> wrong, and just doesn't know that d->stagemask is constrained to 1-7.
>
> But perhaps it is worth adding a:
>
>    default:
> 	die("BUG: unhandled unmerged status %x", d->stagemask);
>
> to the end of the switch. That would shut up Coverity, and give us a
> better indication if our constraint is violated.
>
> -Peff
>

got it. thanks!
Jeff
