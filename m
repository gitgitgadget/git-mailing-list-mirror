Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5894AC46467
	for <git@archiver.kernel.org>; Wed, 11 Jan 2023 22:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235897AbjAKWJ3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Jan 2023 17:09:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbjAKWJZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2023 17:09:25 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2040.outbound.protection.outlook.com [40.92.91.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CD3E87
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 14:09:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJ3/8GxhTds8p5juNP+WxTM1SOfTycsHC1KKo6xcIlP+c0t2RbJHShNyZqi/Nh5S7zdueUq0oRJ+8YyO+71qWua+KYF6dn45WPJW616jW4nxVjYxbyZ/M8gfwqNd9YEXohicw2pj/EVUMjKs2oM3EvUT9pL9/3EGnFz9s9yAUOwLe4s4S9JUhfyFITdv9IM+PgO85mm1oxyeQy9SQYxNwaFMHYeRYUzEApQihj+Z7s/yAdAv///90qWwEq+aHhSXRNFItGKNVdKU1uWAcLkS/Vfp3Tt7zo12zH84MeznAFcZQhJ9EWhQG+sFaXxXsrqpffGyyoMJybmSI3Q14is2Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lUOFuMQ43vSzg/ANQD7cSVhKOQE8SLTbtwQbTFdY7Zo=;
 b=NXbIy13HYY1THp0pfwDo62v0fmfQyoLGLXFABOFiH2sV8Hgh1fPsdfi9O84gvYKCi7OhBBzCl9FIPAn/E2KHcjP7pMCgA184v5PLTpP055S83BkM2f0a5jbMMFwNg7gPczRwzwBQ/AU+3THDwHEtLAnAajNIX7g2ULlvg9yHMJ+f6fDiqcrVIKIqWYCOSsmb86l6TyTyLRfuWevW8J0COoJQC1Zd0k1IkQ85YtPaYjEAoIE2e3xuMbIovtFGClZr4EV5QgIi/uiXRq/OfQtfeQMctWDIiC+3obwZlR1FgVNaGeFfrqpW14kMOy+uLtAwXu/wu/D9j/X5qdC8BkHcSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lUOFuMQ43vSzg/ANQD7cSVhKOQE8SLTbtwQbTFdY7Zo=;
 b=TjTZ/AFzVGirM+1OwwXVwEWO3+3p+Hjt1cmuBM2WsragqsovT/bxd7mU0/YqfZ1xN3FWi1fu6MZ6vPL7xtYhUwC+V9/TR3fcFfSUHvFY+YEjOoNM+B/Z/NOeKv93TAVUp+OPvIAQtLdwhTf/nPKE7xIFk6ivDtroLvKjo/nZrbbblRGCfU574d+B2SaVBzGQ+eBl2PspXJ5L/7Ez5rDGNcVhTGHdUxf6NY57hpBYodv1sSk0IzLZacdpGsfiU1iEK4xh1OJLhWAUoKPD2pdOBabpWIeJyortXsvqTsitt4NA8bP8s0dFFNX4ERAlCkU2O/9BLXlmmT9qxkbkFNh6Jw==
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com (2603:10a6:20b:609::16)
 by AM9PR03MB7868.eurprd03.prod.outlook.com (2603:10a6:20b:433::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Wed, 11 Jan
 2023 22:09:22 +0000
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::8428:153c:704f:4519]) by AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::8428:153c:704f:4519%8]) with mapi id 15.20.5986.018; Wed, 11 Jan 2023
 22:09:21 +0000
Message-ID: <AS2PR03MB9815234B918C9C566F21FABBC0FC9@AS2PR03MB9815.eurprd03.prod.outlook.com>
Date:   Wed, 11 Jan 2023 14:09:14 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v4 1/8] http: read HTTP WWW-Authenticate response headers
To:     Victoria Dye <vdye@github.com>,
        Matthew John Cheetham via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Matthew John Cheetham <mjcheetham@github.com>
References: <pull.1352.v3.git.1667426969.gitgitgadget@gmail.com>
 <pull.1352.v4.git.1670880984.gitgitgadget@gmail.com>
 <b5b56ccd9419353a4bf5bc9d751a711af07d2197.1670880984.git.gitgitgadget@gmail.com>
 <c255896d-637d-f7b0-8698-10a2112852c1@github.com>
From:   Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <c255896d-637d-f7b0-8698-10a2112852c1@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN:  [McuTpW7UuKr4duGr9qU50yCPh1UWRrFi]
X-ClientProxiedBy: BYAPR07CA0011.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::24) To AS2PR03MB9815.eurprd03.prod.outlook.com
 (2603:10a6:20b:609::16)
X-Microsoft-Original-Message-ID: <2a625fd7-06c3-3f7a-0d11-0227dd20ccfe@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR03MB9815:EE_|AM9PR03MB7868:EE_
X-MS-Office365-Filtering-Correlation-Id: bef38922-456d-4a26-013c-08daf4207dce
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DhWxpa2vaQoeNiiqg9Y+FfaY+U5atwxG0OgI15VD29HpI6DsMJJ2Mskw5lxTqExGJ/IIdSg/iN/5HpbI5OrilcO0XAzM92LSGMOdFBIwCFZGptP6jUmXNo1wJL3325JPWPvvf/gKzaJLwkPkDfmMUhzXisygUjzAUHts/bWUrbaYBuZowwPwfG8/pUpiafR5i6YbFwgZ6w6TZwPke6dHRl/puoLvuO34zwm4FzdZPS39AciV/O2rslXP1TsbOoQYoO13MaHznlJptptwG67dqqiYedLC2rEQGawf4xPSGvSFCf9A6CLSuv6UMgZBVJs3s954NEmBDz3utwpD32oShkkUSzzepuZDzNGNq3Xi6S+0eI0lNohAc7Pj6pfwf3a2SpMVo0kI20NWp0gLjC0oRi7KbLu1+HWu0IOS/iAH2uRN0ZsrojFY+p+P/qdF+5e8KS7LzXpTTXq6BdD1vnw0Pt8kgZF1ggSTTW9E1I61UfkNjZRbxg7BwDKZJQQo35kCadkIvnBAJW4zrb4Uw1DGYIsw79gDh17fpOoRGAz1FR/J89yTdbe+48hWBiTtKATeSZBonKmXFwiCehluxSXKtTl++TlPVfZLvHfJrTHx3GVgm3wTYRQcYQN7tXHCVx7LJmfmZf4jEDopoKQNc8I+uICaPzhNqEMSw2ZXzpQOJthQ6Lg9O+Wq/yVW5G9BUz+n
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkNrK29oZTl6SWF0Tk5oT01HdjJ2YUluUE5rZVFSZmRCR0tyNjJYSHRYeEMv?=
 =?utf-8?B?RzZBZkxwNHhSQ1NqcEV3MHRmdnRhR0hJQUxPYmJTaSsvQ0UzeG9EL0h3eHk2?=
 =?utf-8?B?Q0pFOXlXMmxaRzI5WnYrR0JQM2Q5Um42R3oxUXJXSGcxQW1JSnM4QW9wUWQ1?=
 =?utf-8?B?U1UraXVaSkNISUZyYkswQUVjYksyUmVRa0NxbzRuTGxrT1Y5eWo3dWs5b0ph?=
 =?utf-8?B?bXFaRFhMTDdlODYyZDA4YzZIcDZ0Zi8zOXNXaW9xMW0wbnBZWVBCSWV2OGF2?=
 =?utf-8?B?K2phbmo3R1FjMVJVOU40elRPZ3V6V3Vkck40bDVWN2ZmY3Q5S24yQlBiTTcx?=
 =?utf-8?B?dFd6WGIxL2JBeEpQeTVvdlMyRHVGeUE4bGhkd3NkWE52RFJVSnhGTG9aTS8z?=
 =?utf-8?B?WGtBSFRrTjlaRytXcWlQb1ZmRXBhVDRzZmZTZ0dYcGE5ZFRKQi9mWjlJc1BC?=
 =?utf-8?B?bW40UENnOGdaejdvV1hLUlM2bEhiZDBYVHVtVk1KK2xTN1ZJdVJld01VWWNH?=
 =?utf-8?B?MkZGU3k0a1YxNW1wdmt3VXRJZnZqcDNRTU40QmhKaFlsTjVHUUQ3clRBdk5s?=
 =?utf-8?B?SmtCYW5DMGg0TWxZRXNDYjdyNzFPQmRVY0p0ZFlqejA0d25zL2J2UllQM1U4?=
 =?utf-8?B?RkpKUEdWc0J4VHpzd1FaR0pMODhvT2tJZ3J2VHc5TUdxZGhWMnlCU1RaMGFz?=
 =?utf-8?B?RzJpWEhFTUh6NXI2eGJUcjZBVDBWbVpGV0lCOEx5ZUxwcHBMLzlEbmRyRXh0?=
 =?utf-8?B?WFl1NU1Ib2U0L2pYMkdlWW5hZFVFSVNrNVhpandIb0lVa2IyMFI1dVRFRUh3?=
 =?utf-8?B?by8rL3lyVDV4Ry9nNjA4QTEwd0VoTmJBelA5RVNOdDhXMVhZdFdyR1c5RllW?=
 =?utf-8?B?U05QSU9BV0d4MkxsTDRPbVQ4bjJkc2lINU9oUHR6ckxKWnVwM2xJTmxCakRG?=
 =?utf-8?B?ZFVKYVFVUzdxL2RyS1BkRzRvcktqN29tTWU0MllZZjg2WVVWUzFObk9vTnk2?=
 =?utf-8?B?eEZ6d0xyVHN2K29TdlRJTmY4STRYRlBaUUFaaURYWGZmbW54U0hTdndLT216?=
 =?utf-8?B?Y3hNRkpBdmk5enJBZE9IaTlLM0c5c3FWdDh1T0pobFN1ZXcxREl5Sk5MTktm?=
 =?utf-8?B?eEd0ZU5IbUhKTnUvVVJVUUdsZGJhRVFIUnB2YWpadUtyT0p6bWk1aEppVU00?=
 =?utf-8?B?MWdZZXlyT01LYXBjTGRLcU9FRmFDNU43QnNSQ3BRS2p0N3FKK3U5K0loY3RI?=
 =?utf-8?B?NXdGSGVLMUJhWFJLNVVDOEljZEhoSkhwZnBQVFE1Wmdrck5rU1lvVk5JWXps?=
 =?utf-8?B?bk56SVBlb3BmSGJQZ2h3Z1Z6QlJzNXp5VWFWSUlCd2RDaHQ1ZE9LQ0c2aUJ1?=
 =?utf-8?B?ZGpObkhIdDc3RVFQenlSRnc4ZFdleVJRcVdZbWFsY1AvY1U0U0hPNHZ5NkVi?=
 =?utf-8?B?Vzg2V2xqRmNsSHo2Q2ZySUpMYTQ3Nk5IZ2VPL1RHYytlZm84alZpL1A2T00v?=
 =?utf-8?B?U1F6K01oVnVLYnl2UWtHVG9PRTNCQkRaMU55V2xOdDdZbmJsdEhUYVdsc2h0?=
 =?utf-8?B?TmFOTHFBQU1jSU5aRzJsUXJMaStvd3JzeG9sbW5hQ1RPUktnM01TaHpwM2FY?=
 =?utf-8?B?QTQwZWFTQStmT1FVODM2TithYlhIdXdvZVl3MU5hMkg3RDBMUHI1cTVYTG9F?=
 =?utf-8?B?S25FUTFiZFZqdGNhWVFOU3YraHFSN2ZWNjdib2NySkZCUFRRSXZOSExBPT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bef38922-456d-4a26-013c-08daf4207dce
X-MS-Exchange-CrossTenant-AuthSource: AS2PR03MB9815.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 22:09:21.8466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7868
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-12-14 15:15, Victoria Dye wrote:

> Matthew John Cheetham via GitGitGadget wrote:
>> +static size_t fwrite_wwwauth(char *ptr, size_t eltsize, size_t nmemb, void *p)
>> +{
>> +	size_t size = eltsize * nmemb;
>> +	struct strvec *values = &http_auth.wwwauth_headers;
>> +	struct strbuf buf = STRBUF_INIT;
>> +	const char *val;
>> +	const char *z = NULL;
>> +
>> +	/*
>> +	 * Header lines may not come NULL-terminated from libcurl so we must
>> +	 * limit all scans to the maximum length of the header line, or leverage
>> +	 * strbufs for all operations.
>> +	 *
>> +	 * In addition, it is possible that header values can be split over
>> +	 * multiple lines as per RFC 2616 (even though this has since been
>> +	 * deprecated in RFC 7230). A continuation header field value is
>> +	 * identified as starting with a space or horizontal tab.
>> +	 *
>> +	 * The formal definition of a header field as given in RFC 2616 is:
>> +	 *
>> +	 *   message-header = field-name ":" [ field-value ]
>> +	 *   field-name     = token
>> +	 *   field-value    = *( field-content | LWS )
>> +	 *   field-content  = <the OCTETs making up the field-value
>> +	 *                    and consisting of either *TEXT or combinations
>> +	 *                    of token, separators, and quoted-string>
>> +	 */
>> +
>> +	strbuf_add(&buf, ptr, size);
>> +
>> +	/* Strip the CRLF that should be present at the end of each field */
>> +	strbuf_trim_trailing_newline(&buf);
>> +
>> +	/* Start of a new WWW-Authenticate header */
>> +	if (skip_iprefix(buf.buf, "www-authenticate:", &val)) {
>> +		while (isspace(*val))
>> +			val++;
> 
> Per the RFC [1]: 
> 
>> The field value MAY be preceded by any amount of LWS, though a single SP
>> is preferred.
> 
> And LWS (linear whitespace) is defined as:
> 
>> CRLF           = CR LF 
>> LWS            = [CRLF] 1*( SP | HT )
> 
> and 'isspace()' includes CR, LF, SP, and HT [2]. 
> 
> Looks good!
> 
> [1] https://datatracker.ietf.org/doc/html/rfc2616#section-4-2
> [2] https://linux.die.net/man/3/isspace
> 
>> +
>> +		strvec_push(values, val);
> 
> I had the same question about "what happens with an empty 'val' here?" as
> Stolee did earlier [3], but I *think* the "zero length" (i.e., single null
> terminator) will be copied successfully. It's probably worth testing that
> explicitly, though (I see you set up tests in later patches - ideally a 
> "www-authenticate:<mix of whitespace>" line could be tested there).
> 
> [3] https://lore.kernel.org/git/9fded44b-c503-f8e5-c6a6-93e882d50e27@github.com/

There is a bug here. Empty header values would indeed be appended
successfully, but this eventually results in empty values for `wwwauth[]`
being sent over to credential helpers (which should treat the empty value as
a reset of the existing list!!)

Really, empty values should be ignored.
My next iteration should hopefully be a bit more careful around these cases.

>> +		http_auth.header_is_last_match = 1;
>> +		goto exit;
>> +	}
>> +
>> +	/*
>> +	 * This line could be a continuation of the previously matched header
>> +	 * field. If this is the case then we should append this value to the
>> +	 * end of the previously consumed value.
>> +	 */
>> +	if (http_auth.header_is_last_match && isspace(*buf.buf)) {
>> +		const char **v = values->v + values->nr - 1;
>> +		char *append = xstrfmt("%s%.*s", *v, (int)(size - 1), ptr + 1);
> 
> In this case (where the line is a continuation of a 'www-authenticate'
> header), it looks like the code here expects *exactly* one LWS at the start
> of the line ('isspace(*buf.buf)' requiring at least one space to append the
> header, 'ptr + 1' skipping no more than one). But, according to the RFC, it
> could be more than one:
> 
>> Header fields can be extended over multiple lines by preceding each extra
>> line with at least one SP or HT.
> 
> So I think 'buf.buf' might need to have all preceding spaces removed, like
> you did in the "Start of a new WWW-Authenticate header" block.
> 
> Also, if you're copying 'ptr' into 'buf' to avoid issues from a missing null
> terminator, wouldn't you want to use 'buf.buf' (instead of 'ptr') in
> 'xstrfmt()'?

Sure! Good points.

>> +
>> +		free((void*)*v);
>> +		*v = append;
> 
> I was about to suggest (optionally) rewriting this to use 'strvec_pop()' and
> 'strvec_push_nodup()':
> 
> 	strvec_pop(values); 
> 	strvec_push_nodup(values, append);
> 
> to maybe make this a bit easier to follow, but unfortunately
> 'strvec_push_nodup()' isn't available outside of 'strvec.c'. If you did want
> to use 'strvec' functions, you could remove the 'static' from
> 'strvec_push_nodup()' and add it to 'strvec.h' it in a later reroll, but I
> don't consider that change "blocking" or even important enough to warrant
> its own reroll. 

That wouldn't be too much effort, and would help simplify overall the move
to using `strbuf_` functions. Check my next iteration for this.

>> +
>> +		goto exit;
>> +	}
>> +
>> +	/* This is the start of a new header we don't care about */
>> +	http_auth.header_is_last_match = 0;
>> +
>> +	/*
>> +	 * If this is a HTTP status line and not a header field, this signals
>> +	 * a different HTTP response. libcurl writes all the output of all
>> +	 * response headers of all responses, including redirects.
>> +	 * We only care about the last HTTP request response's headers so clear
>> +	 * the existing array.
>> +	 */
>> +	if (skip_iprefix(buf.buf, "http/", &z))
>> +		strvec_clear(values);
> 
> The comments describing the intended behavior (as well as the commit
> message) are clear and explain the somewhat esoteric (at least to my
> untrained eye ;) ) code. Thanks!
> 
>> +
>> +exit:
>> +	strbuf_release(&buf);
>> +	return size;
>> +}
>> +
>>  size_t fwrite_null(char *ptr, size_t eltsize, size_t nmemb, void *strbuf)
>>  {
>>  	return nmemb;
>> @@ -1864,6 +1940,8 @@ static int http_request(const char *url,
>>  					 fwrite_buffer);
>>  	}
>>  
>> +	curl_easy_setopt(slot->curl, CURLOPT_HEADERFUNCTION, fwrite_wwwauth);
>> +
>>  	accept_language = http_get_accept_language_header();
>>  
>>  	if (accept_language)
> 

Thanks,
Matthew
