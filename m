Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D4DC636D3
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 19:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjBFT0C (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 14:26:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjBFT0B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 14:26:01 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02olkn2099.outbound.protection.outlook.com [40.92.49.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810C31B339
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 11:25:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ALVvAQ8lO+AGcqDfyPhhgftikPlikX3oXSHgd2wQTPaSGWMMf0k8zF6crLVGjfQsg7LkaXZSG4q1dMnaxJpLSPGsJOhWmRkgWB2OwrpCwrIk3dEoR9pIoUYchBxsy/CL9O78CNgJaOpICVyvFnK3r4L8vn5IVJQrFCD9hsORD7HoJSq1Q1xpbh9c7az/s4I06SJw834EO3gZElrLEBWFBA+tJ0lK/67CcpN4ibLkd5yoBjbIxnzQc8FK+5UXrgHiNKK1EMXniLXdM9iBYlFgrMf59vrven8NFiUXz5oP1uJh//MWz+sJkRj3ax2/eef997MlCZjQwr5zNkK74wuqkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kgozUPwPtJ3fToSIfXqDsoH1Jj6gT+hDA3Mtcy6I9uE=;
 b=bqq9GG8NEPsdX9X4kjOEpE4Wcmd75rKjTdNmbJo0OgtDO5uBVLRTky1CnaKmnardeSU6J0tTKwJ3vtvdr5Im7jlxnbxNre23yJRXq81FZXgwx8eY1o35ZKTRKCugPubDzG6n6W3/xCpPiK+1c/d4i5MkvWHw0f5sXQ+YxSlGYoiiUDnn12igSx6nFpHzc0FG/g/6Ib54N6uA+V8uwx42piITkzwZZcLfMgwGbnUiIY2sny/9r8J7pS24aKbdMxQG+InE4mqcz9ubTNEoUkKNFg7LD27NQdNCo5jq4di6Z8vgUnGnOngH1fACgPPMcjjhzBUOK8i/Lyhw/FnlE8kVWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kgozUPwPtJ3fToSIfXqDsoH1Jj6gT+hDA3Mtcy6I9uE=;
 b=TKB2Q8IXK1GVh/jqxT7UlFjN7Ah9zB+3NTaSLoq2+4FvvU+142hoIb6o2+vcohq2cRWHHWXajSo79iHptpkJjloCWljrgDnqcEkkqb+TsOueIkhbYgPPEiRm6RHHh9ESTvr6pPbKWwO8uSUnZbR5L9ds3hAc5Oc9WhXrU6LVoE+pXC8+yjOz1XKBLDZSIUZ5LBIuNlWkgyxFrrAjxqt56AffweIExoP4fEMyQ6O/ydPQukrYUbc4A2K4f/UHjVeSKonzz2Vbe1V3xrB3060WUJk4leB/CLQRDQzKIlgZQGgFn9kELgOSMOScL7GU+EWTwKizICP+HDLTOmj/7n6cJg==
Received: from DB9PR03MB9831.eurprd03.prod.outlook.com (2603:10a6:10:461::15)
 by AM7PR03MB6354.eurprd03.prod.outlook.com (2603:10a6:20b:1b0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 19:25:57 +0000
Received: from DB9PR03MB9831.eurprd03.prod.outlook.com
 ([fe80::fc02:6831:74ff:f92a]) by DB9PR03MB9831.eurprd03.prod.outlook.com
 ([fe80::fc02:6831:74ff:f92a%7]) with mapi id 15.20.6064.032; Mon, 6 Feb 2023
 19:25:57 +0000
Message-ID: <DB9PR03MB983150E73B1C963C628CBE75C0DA9@DB9PR03MB9831.eurprd03.prod.outlook.com>
Date:   Mon, 6 Feb 2023 11:25:49 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v7 11/12] http: read HTTP WWW-Authenticate response
 headers
To:     Jeff King <peff@peff.net>,
        Matthew John Cheetham via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>
References: <pull.1352.v6.git.1674012618.gitgitgadget@gmail.com>
 <pull.1352.v7.git.1674252530.gitgitgadget@gmail.com>
 <5f5e46038cf526714f3c5b89ffef2b895b503242.1674252531.git.gitgitgadget@gmail.com>
 <Y9JWnQeEV0weV4yu@coredump.intra.peff.net>
From:   Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <Y9JWnQeEV0weV4yu@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN:  [U2HirOWBIV3rJFDcKwSridbt2r7R2hU4]
X-ClientProxiedBy: BY3PR04CA0026.namprd04.prod.outlook.com
 (2603:10b6:a03:217::31) To DB9PR03MB9831.eurprd03.prod.outlook.com
 (2603:10a6:10:461::15)
X-Microsoft-Original-Message-ID: <e2dd1dc1-abfd-9d10-957c-901ad12e0fa6@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB9831:EE_|AM7PR03MB6354:EE_
X-MS-Office365-Filtering-Correlation-Id: 98b95a31-ac4e-4c89-f082-08db0877f892
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZRWQydyxgzITZJ97fpJd/by1OaIvtiVYuJJh/NPHZKMkNK68UYINdtlFUZIoqv0xtEIyKdLwgztNbQb1OLU1UcxYhsgWabLnLS1Nn6Ymnf0rx5MNmXYRL7HzCa0gkgkmhCnTUdlOVX551B/4ngUFZVq8PvvppEp9xp+F7Fzzt8JSQ1r6plajPw5WA4bMrgMrVXJfR4qfpxgLwssJp7dzDxHXzFJAKTLQZ0hqg3pk3/bOJ1a6GMeix+KQ+3tPFWu2tyIfyozBH6v6rhgHr29A0DnaBAak62zudowEDtl8RBEWX6JweRjuGcqtgXzevtokQrm2A9DxsPx+MMLDc7B/kh5d4VwlXEfzYMKe0QMRhRxhzmePTF05bmkxAwSXVuOSOmDJpFCqJhG7ZhTKs8g47Jc4RmGTrrYK6mg5fqAW9kaWG4/k0UdsSXG4yHmoAuUvfaohVCTMckdYrfxjxEwl6z6aIZPNANPa1dvVh19TpPuFMM6b/sEnya9KRe33fQiyLHyqm29sIK+Lqv8xsKBCQ97Nk8RZMXe/sDMUdv0w7wr42F/8kAOCbazRFXqOQrA2D/eLThrwrLhKlw8TzNEpLEapdG4gnFK59HdMftcUkbX9mnw8WU0b3Td903g7QMD0X9teNzclrIO2hK+jfEV9uw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3A3ZG5FcUJsRXVPZ1JmbHhKdGVaUDBIZitRTzBrcEpIN2t0THBBTXZ1dUV3?=
 =?utf-8?B?QVd3T29FS0s4M29NMDJnakU2cG1zVnQ0aXg1dWZZYng3a0piR1dWM1FTeWdP?=
 =?utf-8?B?b2ZlSTVleXV5RFdJR0FZSENWdlBLZ2ZtcG90dVlrVENpdysyMlJ3QUo1c0ty?=
 =?utf-8?B?MThraFJxK2t1bkR1QWVpMHhOdkViVDdoQlh1VVU1RURKTDdFdHYzd1FML3lm?=
 =?utf-8?B?eC9VdWhIVU9RdmZyMi9BSjVINlNiRzZNM1JlOE5Jb0NvSlNkbFdkQTZjRng2?=
 =?utf-8?B?SDhwRWZnUDdzQ0lDblZzbGJwSThnclpPMzgwaENSNE43VWVqS0dGUWl4anhq?=
 =?utf-8?B?Zlp6amdaaDNsaVJiaFVtb3gvc0dJaWtNSkdJcEo0ZC9LR2NrOTkzV25NQmN4?=
 =?utf-8?B?Qkdvc2c2Z2JqOVRmbzJQMXRwS3ArYldZS3ZyVk8wbG9GemtyWkMvUkJoMGxV?=
 =?utf-8?B?cUxYR2Vxa1JxL09Dc3E4MExJdHpKZWx0dVlHQVMxUUhVUzRLQTF2UjR4TTE4?=
 =?utf-8?B?dFAvY0d5Zk54aEFSSE9kK3lRMlBIOU41aDFnaW5sY3ZmcjlCM05rZGhPOTZV?=
 =?utf-8?B?WktoWll6Qi9LakoremdNRHBQSGdDRXhzdWlnUDRKcnN3RW9XK2VlSGpuQnBa?=
 =?utf-8?B?b3FLV084U3ArRjAwRzB0TndtZndLakU2blVzMHQ2RnlwRGZ4SjFUOER4V2x3?=
 =?utf-8?B?MEl5dktVaVlhVTA1VlNvOTgyeHNCdXFiNDVicWx4bTdtYkVDRG1kdEpYaHNV?=
 =?utf-8?B?bTkxdWEzSUJNZ1BIWkRIQW9Hc3FGTnNLZm4xNU5XYWpqY3RORTdRalN6QXZv?=
 =?utf-8?B?WFlYckNnYzRPRDgvK3l4a3FJZVVaMEpia2ppeHRBYnFzZmhtemxlMjNtQjVH?=
 =?utf-8?B?eUtvb3drMENwNnZZRnJBYmJKeE9hWmFjeFRNQU91K3NLTnA5ZStIZzNyNWFN?=
 =?utf-8?B?SGdoMXRRVm5zRkM5RlNaRzZhUTZzQVIxQ3Q0UDRVcThHYlFLNHUyVlhqOUsw?=
 =?utf-8?B?N1d0ZXQ1Q1pXektFdWtwU1A2Vzh6YW9GdGFEUUQ1R1p3VENGamFVejFUamtF?=
 =?utf-8?B?SHIrS2FqVEJwMXM3QmZwYjhDMmVaYUNqN2VFV3F0bXk0QUhHRmw0QmdFRTQ2?=
 =?utf-8?B?My96UHJoRTJiZzg2elc1NDZmQk0rcVdIZ3poc0drbnVlRGc1ZFd1Q1QvU21Q?=
 =?utf-8?B?bGE3emlCMmpUL3pXQ2l5OXZ4dXlCQTFWWWF4OVRadGczUFo0VXJLbWJHVHZr?=
 =?utf-8?B?SDc0MXYxSHpMNzdTNVppa3JweDJsN2huSlNlSGdpSFZBMVd3aTZlZnA1Wmxs?=
 =?utf-8?B?aWIvbEpTVm9raGtMR3Q1Q3FrMVBJZjNGajI0STdZTkRRUHdzd0JjWFJ5alNh?=
 =?utf-8?B?MjBUVGxZSmM2VzFqam5CT3c1VG5ualJ5bDlOKzdIQm9QRm1lTFRFSWswZGhX?=
 =?utf-8?B?M0llVDVMakk0OHRQbGFLU01yOG1hdlM2V1FjTmhjekh6ajZIZE1TNXhJUEll?=
 =?utf-8?B?UTg0MmpJV3ozUWdOcEUyZ3V1S3NOM2dpYSs1cXMrdU9YYW5jNUFHeVFnY3g4?=
 =?utf-8?B?bWdwd0d6TTM5eVJlZG5haEQ3TGdadEVvVjlyZWdpVkZIdGhNb09lcEk5QitI?=
 =?utf-8?B?VG1BZEJaR1IrL3NMaGNoZ1B4T0tIZ284eWo5NkJEdjJCSkorSytJRk5MdGE0?=
 =?utf-8?B?RW9uVVovd3kxQTlHemhzOFFtemt6azU5bXUwYUNrQjRJc0YrMU9wSTdBPT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98b95a31-ac4e-4c89-f082-08db0877f892
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB9831.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 19:25:57.4286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR03MB6354
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-01-26 02:31, Jeff King wrote:

> On Fri, Jan 20, 2023 at 10:08:49PM +0000, Matthew John Cheetham via GitGitGadget wrote:
> 
>> From: Matthew John Cheetham <mjcheetham@outlook.com>
>>
>> Read and store the HTTP WWW-Authenticate response headers made for
>> a particular request.
>>
>> This will allow us to pass important authentication challenge
>> information to credential helpers or others that would otherwise have
>> been lost.
> 
> Makes sense, and the code looks pretty reasonable overall.
> 
> A few observations:
> 
>> @@ -115,6 +116,19 @@ struct credential {
>>  	 */
>>  	struct string_list helpers;
>>  
>> +	/**
>> +	 * A `strvec` of WWW-Authenticate header values. Each string
>> +	 * is the value of a WWW-Authenticate header in an HTTP response,
>> +	 * in the order they were received in the response.
>> +	 */
>> +	struct strvec wwwauth_headers;
>> +
>> +	/**
>> +	 * Internal use only. Used to keep track of split header fields
>> +	 * in order to fold multiple lines into one value.
>> +	 */
>> +	unsigned header_is_last_match:1;
>> +
> 
> Stuffing this into a "struct credential" feels a little weird, just
> because it's specific to http parsing (especially this internal flag).
> And the credential code is seeing full header lines, not broken down at
> all.
> 
> I guess I would have expected some level of abstraction here between the
> credential subsystem and the http subsystem, where the latter is parsing
> and then sticking opaque data into the credential to ferry to the
> helpers.
> 
> But it probably isn't that big a deal either way. Even though there are
> non-http credentials, it's not too unreasonable for the credential
> system to be aware of http specifically.

I had considered possibly introducing an opaque property-bag style of
'protocol-specific properties' that, for example, http.c would add the
WWW-Authenticate headers to as something like `http.wwwauth[]`.
Other protocols (like smtp:// or cert://) could add their own properties
if they needed or wanted to also.

Thoughts?

>> +static size_t fwrite_wwwauth(char *ptr, size_t eltsize, size_t nmemb, void *p)
>> +{
>> +	size_t size = st_mult(eltsize, nmemb);
> 
> Here's that st_mult() again. Same comment as the previous patch. :)

Yeah I'm gonna drop this. Your arguments make sense; it's not going to be a
problem in reality :-)

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
> 
> OK, so we just copy the buffer. I don't think it would be too hard to
> handle the buffer as-is, but this does make things a bit easier.  Given
> that we're going to immediately throw away the copy for anything except
> www-authenticate, we could perhaps wait until we've matched it.  That
> does mean trimming the CRLF ourselves and using skip_prefix_mem() to
> match the start (you'd want skip_iprefix_mem(), of course, but it
> doesn't yet exist; I'll leave that as an exercise).

Fair point! I can replace most of these with operations over the curl ptr.

> Maybe not worth it to save a few allocations, as an http request is
> already pretty heavyweight. Mostly I flagged it because this is going to
> run for every header of every request, even though most requests won't
> trigger it at all.
> 
>> +	/* Strip the CRLF that should be present at the end of each field */
>> +	strbuf_trim_trailing_newline(&buf);
>> +
>> +	/* Start of a new WWW-Authenticate header */
>> +	if (skip_iprefix(buf.buf, "www-authenticate:", &val)) {
>> +		while (isspace(*val))
>> +			val++;
>> +
>> +		strvec_push(values, val);
>> +		http_auth.header_is_last_match = 1;
>> +		goto exit;
>> +	}
> 
> OK, this looks correct from my knowledge of the RFCs. I saw something
> about isspace() matching newlines, etc, in an earlier thread, but I
> think we'd never see a newline here, as we're expecting curl to be
> splitting on our behalf.
> 
>> +	/*
>> +	 * This line could be a continuation of the previously matched header
>> +	 * field. If this is the case then we should append this value to the
>> +	 * end of the previously consumed value.
>> +	 * Continuation lines start with at least one whitespace, maybe more,
>> +	 * so we should collapse these down to a single SP (valid per the spec).
>> +	 */
>> +	if (http_auth.header_is_last_match && isspace(*buf.buf)) {
>> +		/* Trim leading whitespace from this continuation hdr line. */
>> +		strbuf_ltrim(&buf);
> 
> OK, makes sense. This will memmove(), which is needlessly inefficient
> (we could just advance a pointer), but probably not a big deal in
> practice. Using the strbuf functions is a nice simplification.
> 
>> +		/*
>> +		 * At this point we should always have at least one existing
>> +		 * value, even if it is empty. Do not bother appending the new
>> +		 * value if this continuation header is itself empty.
>> +		 */
>> +		if (!values->nr) {
>> +			BUG("should have at least one existing header value");
>> +		} else if (buf.len) {
>> +			char *prev = xstrdup(values->v[values->nr - 1]);
>> +
>> +			/* Join two non-empty values with a single space. */
>> +			const char *const sp = *prev ? " " : "";
>> +
>> +			strvec_pop(values);
>> +			strvec_pushf(values, "%s%s%s", prev, sp, buf.buf);
>> +			free(prev);
>> +		}
> 
> Likewise here we end up with an extra allocation of "prev", just because
> we can't pop/push in the right order. But that's probably OK in
> practice, as this is triggering only for the header we care about.
> 
> The concatenation itself makes the whole thing quadratic, but unless we
> are worried about a malicious server DoS-ing us with a billion
> www-authenticate continuations, I think we can disregard that.
> 
> -Peff
