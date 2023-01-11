Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2BEC5479D
	for <git@archiver.kernel.org>; Wed, 11 Jan 2023 22:11:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236026AbjAKWLU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Jan 2023 17:11:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235894AbjAKWLQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2023 17:11:16 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2103.outbound.protection.outlook.com [40.92.90.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E0D33D69
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 14:11:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eT8R8PghgtzzKctoyeP8oH4eFxI0Jpqz3pZmpNAMkxK3OF/08xfkuI02PVZpFDGIqdhgsy1yCZvR1ny+nce0OWKa1PKxg86TY0SW3uwWFPzmParTG4jrm2FfYklG5y1mRz6Ov7ohAXCR44K3wxKLeH2RavSYKaJIIHSCWtBqnMHBp//FdPD9xvTcDEny+V8AnkSKVRIC4L/O7f7ZF3bKlzWJZboBroNB1tUxKK+YO0cQw0n2qQvzUjt/PqPfMCjqV4QWiIpklbLyrjEH5eRx4X2CQGIMmq1dBrbjxXP5ChWOiGpKSVfIyi7od9f3yZMKKz2QrBBPrDbRdqTSEgL+sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7R6AQlGiXhFdivc71JqU0BcZSh4Vdghc7IbSzQWEf8c=;
 b=T4UKMxjmXOy0W0BapNWgJIugZNXfCmBmUgTf51g9/MeNwiDkhjUyqwmTOwdBowwC7tgh85+0+FV+YHFbZtKzMPifHiYJ33IaOH/G+CiwcxkvCYH04UuroasG0Aq5ntj7yC5sOM5ovYJVvke8lhbpFqroFsxhVIiStPzQKNIL36FEBBAmUKRQM2A4jKQP0484wEAGtIA+nGVzYI+dNY+d/Y6mg8/UTwkYPX8VGlMNo38KEk3bZ45O3LUEyVpYqbQAX6+k6/9SbeF/sDIk2TfFfii8nF1NgE/Tpb9GenvbWhv1RapLFWiQdN8aikVOlqxYfVJu79184OUnsoRIpflhRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7R6AQlGiXhFdivc71JqU0BcZSh4Vdghc7IbSzQWEf8c=;
 b=iJZCejaqmGJBGUEpZe127W7B67xgEXYAlZ5brXCRiMo9lvbGXYD0NtBesquhf0KjNdsNGQSFEAzx01cmWJTqaUIdCkgReJLky3yW2TKmGKY1NvabTLf0CDE3H+wImRn9SMgejx9VTKPyaTCB64yhZk554oFdcT7YnBho9EVutYwWCxYp8xPgnUqQWW6NrryyTtkb3RO3Y8+Zjt5EoG+VcJEvXHuVUiNoXPfl+L/5U8C2ix5wLfzGxn5+XxdCfZKa85dJhudbrSS+WUKoUrggeDYK1Aj9f8TYr+7K/qs4adUUAEtTxtS1eC4KTLKENWF/dt1BcBCIYskwaQmIhlGCXQ==
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com (2603:10a6:20b:609::16)
 by PR3PR03MB6490.eurprd03.prod.outlook.com (2603:10a6:102:7e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Wed, 11 Jan
 2023 22:11:12 +0000
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::8428:153c:704f:4519]) by AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::8428:153c:704f:4519%8]) with mapi id 15.20.5986.018; Wed, 11 Jan 2023
 22:11:12 +0000
Message-ID: <AS2PR03MB98153C2C0EC082257F091B7DC0FC9@AS2PR03MB9815.eurprd03.prod.outlook.com>
Date:   Wed, 11 Jan 2023 14:11:04 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v4 1/8] http: read HTTP WWW-Authenticate response headers
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Matthew John Cheetham via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Matthew John Cheetham <mjcheetham@github.com>
References: <pull.1352.v3.git.1667426969.gitgitgadget@gmail.com>
 <pull.1352.v4.git.1670880984.gitgitgadget@gmail.com>
 <b5b56ccd9419353a4bf5bc9d751a711af07d2197.1670880984.git.gitgitgadget@gmail.com>
 <221215.861qp13tfh.gmgdl@evledraar.gmail.com>
From:   Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <221215.861qp13tfh.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TMN:  [HXhLuDUFRb7UiFr0nIDc+LNrAiqHxJJ8]
X-ClientProxiedBy: BYAPR07CA0007.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::20) To AS2PR03MB9815.eurprd03.prod.outlook.com
 (2603:10a6:20b:609::16)
X-Microsoft-Original-Message-ID: <dc8bb61b-66fb-4b33-0843-8bbbf5559d2d@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR03MB9815:EE_|PR3PR03MB6490:EE_
X-MS-Office365-Filtering-Correlation-Id: 45353e97-1434-43b5-d3c5-08daf420bf6a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XmgTzG+tJQDvFXuUUzVS5WKO28HH1NA+3dkMy9JKvFWpwNss+1YODfgAmb4lVU4REGR4tiXqukQ07qmvAwttmnyxEopfvQJmX+6hNjrPPpRXONfMNHO7tg68VvlZbx29PXkP2Q3Akhy3RknfBDj8JwV/wiSpa4AnWx5eArg/UMTAI8HPhb9rD/nD+qLmV9fYiBevDIW/kn03uEh+949W+bigL9PcrtSzx2NZyVgZ5vc2N+EtAgCPQHkebdK2wiP3ELXVHzXcQUFPbE51/WtlSM3Gu9RBcV6Fpal+0237je5pecSLuq27vZflm3TYn/TThIdqOlpbEOab1cNblXF3SEkt7XlafNm49Wc+91bFAlXvncI+cJ31sNAe0Svpvzwy1SKg24sU2oh+4kLPeCsNLw6erZguuf1KahfLVzSST4aR8TfzgaFm0rHfrawt29E9GnWXogwkUhZScvg5dRIR39fgeoR5Lso5adSz9Q/IhXpxW2G4Sm0YRVJPvQZeHpaHT02JfzM0W1iv4Xcz7MlXh4r3IAXDj34rcsW51y5fg3S+2UufGZLsHyuSUOtnXpBSeA0J7LBc2obtLIwpmA/yDD0cYlNv3IOtSfk4xc+UjN7+IlBz89pYiyfv1T5ENtxK32mVXhsGS2oq/QVjl0VkNg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVZEbHB5Si9taTJ4TFVpazdhaVVQcDlSV28wSFZ6WGYrcmdxdG80VFhLN0xQ?=
 =?utf-8?B?M0RKakxQdEh5QXdubFZCRUhad3BzSWIvbEI5ZUN0RXpSS0gxb2xhYmVXMXJk?=
 =?utf-8?B?OFgyYW1lSkFpbU5OOGxLQzdtejdRTTE4ZjZqUW54MitYdEZVREc2WlJVWlU1?=
 =?utf-8?B?b3dMVjMzWVI5T2xhMEY0STQ3aURiWVkzeExTUE9tR251dzFXMU42MFhDbnRn?=
 =?utf-8?B?TFVDdE9XZVRiV04yUWNVS3NvVGl1cVVLN2hUSEQ2c0JTeXZwVmc3WGhBbGtl?=
 =?utf-8?B?RmdoZi9pVWJaODBXbmFmUkdHQlN5eU5FQUVPbVZiL3QwdTNQdzRQa2hQemRx?=
 =?utf-8?B?SVZoeG5VOUdhb3JuWDlkNzZVN3ZoazV3NHhrYjBFdk5uZ1NubTJWNkt1Mm1q?=
 =?utf-8?B?cytmQS9ONkVBa1pWZUNPMWVEMmt4V3JpS2hYK3g5Tk1laWtwR1RkQ2ZOclVw?=
 =?utf-8?B?bVJFNzYzV1g2b0RFblQwckNReUFiWEpIS3Q2VWdkMUZQQUZUTEFHUVNjN1hq?=
 =?utf-8?B?UitIaW9MZFp3S0ptNFhkbGNkbUpOMk15NTB1SCtYRVIwUkJ6aHZHZkR1V01j?=
 =?utf-8?B?RHU0enRkeDVzS0xKZ2pQMzlYcWljcWJmWFNvUGxZNXY1OTY0SUo3U2VuTWQ5?=
 =?utf-8?B?Q1ZlRWs4S0xWWkZmWTRJQU5sZldKb2RtajlyVmd2QTZCM3dvYVF5OHVtcDYy?=
 =?utf-8?B?MmxpMFVmakpmYVgxc3BwWEtBLzcvcGc2MmdjeTJJeXU3ck9HR1hIQi9mZlJo?=
 =?utf-8?B?LzVSUG8zUGNhb3ZDVHRtOWJtb3JXVFRLa292dTlpbExvUldSM2lBQitlMlhs?=
 =?utf-8?B?enZFamtFb1lkSHdCUDBDbTgwL1VtVmFCMUdXalY3RWdFOXd0YVNDQ3RqZzEw?=
 =?utf-8?B?ZXlDTTB6SVdPdDBqNisydjFjRGVpb0Exck9BYWdHaFFLV0pQY3Q3Rzc5elpM?=
 =?utf-8?B?eUdFeXFVblZrVkhVMS9CYnZxVTluS0JuWStRamlLeEljRzZFT0trRS8wRTZl?=
 =?utf-8?B?QWt3QjNIK1VwSlZHeDNMTlpwUklRRUtJNERBMFJ0bk5weFhTcGJGVGVHQm1G?=
 =?utf-8?B?dkk1K0h5RU5QUDJaZFZkTU0zUVRiamtvMGcxU3U1aFB0ZjdJMVpBL1YvNXlo?=
 =?utf-8?B?RlFtek1tSUh4ejdMT0lMNE1Pc1Bra1hwMmw3VVM2Q3RaTFBPbW9lOUhDVjBT?=
 =?utf-8?B?OStRQ01DcjMxY0FpdkxrRkxmaTJOeEtuTXRUT2lXcjl4Y01ra3JqaWR1TmdL?=
 =?utf-8?B?ZWNzeThIMENIVXZTczhocUo3aGZ3MklBdHVpSm04NFRzcHFueVNjYTZVNmlR?=
 =?utf-8?B?aXUvenBOYk9OOFY4d2c3d0pCSmdNNURHSUk3OHg2UXZsVzNoSVd4NVdCN08y?=
 =?utf-8?B?VTNhRlpZckN0TS9PZy9tTE4wbHRMUmdkZDB3ZHp0Q0J3SFZKNW4xTXhOL2I2?=
 =?utf-8?B?UTgwQ1ZNaFdKbnZ6Y3dDUlA0RzRvcG5GNUhwTzFZc0x0a1hYajFiYmU1MWFM?=
 =?utf-8?B?bDJ4Z2lvL3pHYWRMTjB3alZrSEphY2RFdkZ6YXpYK05jMVk5ZzFKWTFKMkxh?=
 =?utf-8?B?RDJmcmFVbGhJSzViRCtOMm1jb2dEcTRxaFdJTFMrd3dCWWM5L1crUVlwblpw?=
 =?utf-8?B?a3FKMUdDcExMYzFmditPZlJmTWY4SFdiT0l4ODJmaTdYL1A4cjR3ZHZ4NzhR?=
 =?utf-8?B?NUpTUVZ0T1hYdUFrZjR0N0FVMVpvQ0dYdnRxdGtUT2JBa0YrWXhraTFnPT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45353e97-1434-43b5-d3c5-08daf420bf6a
X-MS-Exchange-CrossTenant-AuthSource: AS2PR03MB9815.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 22:11:11.9407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR03MB6490
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-12-15 01:27, Ævar Arnfjörð Bjarmason wrote:

> 
> On Mon, Dec 12 2022, Matthew John Cheetham via GitGitGadget wrote:
> 
>> From: Matthew John Cheetham <mjcheetham@outlook.com>
>> [...]
>>  /* Initialize a credential structure, setting all fields to empty. */
>> diff --git a/http.c b/http.c
>> index 8a5ba3f4776..c4e9cd73e14 100644
>> --- a/http.c
>> +++ b/http.c
>> @@ -183,6 +183,82 @@ size_t fwrite_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffer_)
>>  	return nmemb;
>>  }
>>  
>> +static size_t fwrite_wwwauth(char *ptr, size_t eltsize, size_t nmemb, void *p)
>> +{
>> +	size_t size = eltsize * nmemb;
> 
> Just out of general paranoia: use st_mult() here, not "*" (checks for
> overflows)?

Sure! Good point.

>> +	struct strvec *values = &http_auth.wwwauth_headers;
>> +	struct strbuf buf = STRBUF_INIT;
>> +	const char *val;
>> +	const char *z = NULL;
> 
> Why NULL-init the "z" here, but not the "val"? Both look like they
> should be un-init'd. We also tend to call a throw-away char pointer "p",
> not "z", but anyway (more below).... 
> 
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
> As we already have a "struct strbuf" here, maybe we can instead
> consistently use the strbuf functions, e.g. strbuf_ltrim() in this case.

That's a good point. I can move to using strbuf functions entirely.

> I haven't reviewed this in detail, maybe it's not easy or worth it
> here...
> 
>> +
>> +		strvec_push(values, val);
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
> 
> It makes no difference to the compiler, but perhaps using []-indexing
> here is more idiomatic, for getting the nth member of this strvec?

Sure!

>> +		char *append = xstrfmt("%s%.*s", *v, (int)(size - 1), ptr + 1);
>> +
>> +		free((void*)*v);
> 
> Is this reaching into the strvec & manually memory-managing it
> unavoidable, or can we use strvec_pop() etc?

Again, good point. I can rework this to pop and push a new, joined value.

>> +		*v = append;
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
> 
> ...Don't you want to just skip this "z" variable altogether and use
> istarts_with() instead? All you seem to care about is whether it starts
> with it, not what the offset is.
> 

Again, a good point. Thanks for the suggestions. My next iteration will include
this.

Thanks,
Matthew
