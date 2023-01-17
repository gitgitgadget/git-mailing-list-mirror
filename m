Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A4AC38142
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 22:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjAQWl1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 17:41:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjAQWlE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 17:41:04 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03olkn2101.outbound.protection.outlook.com [40.92.59.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB59F3CE2A
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 13:52:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j3r3XSla18H+/8sKd5kUR7hhhnSY95wWPdJC+3+7aiy4winaqVYnsKeKmbv9wfhCU7nEzkHtp9nS4ids4S4WXanJtXy6QuMQroAz5XPNxR6jI9XBhUjIZj2MRmK5FzqenWQ1QvyQV8uavSrjm1b4CrjYWv91vYQdnLBfISp5AhapVnSUXfrgJerjM8yUT1DQn4uUBOcTlxanSs67E5I/BGSOwqgTGQKql4uWlePLLMakL7QSN2q4SwrkiBhEDrGdN44DLZ/shyG9OeLZWj9+L1TMRRt18aXcVK9cJpCreEPoMSwHFum1R4Z45uBys95TGn0+ykKl/1nl0LlV2SMK+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1LumHZHNfeOzYl6OrJPbldKhammWEG5/hRsqH3NC/QE=;
 b=KsmrennHG6Wa4nJ7x2aMGM9PoCbLvTBFRTq5TlLZb0Aa8FQMN3SteJvHVgA5DFYEI60t1VkSnglTFFnjFVlJLQnpkJLpvi1nXoAUx/fK0UMYdru1wrassBRLIyIzYa6AklZTOJjaodFFlitpBlkZXa94Gvq4V1tzwK9Cty8moUbg4Ue1BzGDmY3os/vkz5Pib5q0Xwp7f+pGAD2CDyD6C5vkhS79f+A/0WG1QtarVOaud+tzwFDGsYvRys/M1Q6AhCMqcU2b5Q5ij/ldO3bNEIceHkRRn2P6CRuvVFWZ3bBjsfToTz2ARoiB8cDrKQ7iGy+a/BfHZ7Z2hplcJ8qlnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1LumHZHNfeOzYl6OrJPbldKhammWEG5/hRsqH3NC/QE=;
 b=M9VUZRaPjbUBiDw7TJk74sbzTxxXa0HwZFacbhj3vOpkII8DVUiK03laFtjrO60toQdk+WIk9n5NFcuvDtfJDxj2WwnJFIUJ3DO/liM92GABmF9LvY3S0duH0it02signhr+zQJKEsN0+Rc9foAfIhZ5G4i96s2mc6yhYigUedI6XoxHXRO0yVvlCphgrbT7mLQsJXDHfY5pd1AZ5mmhSxDx281gl78/m0P7p2gU0cqbSLh7OItq9qWy3MUZ2c+30yMw0bIbaOqIf8imCT0I7Mni5Veyx1mEiGCykqwlO4woUNCdjBQPdlRnK16hYKN4T5VGLn1K5tMzafnutyXh9w==
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com (2603:10a6:20b:609::16)
 by AM9PR03MB7250.eurprd03.prod.outlook.com (2603:10a6:20b:263::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Tue, 17 Jan
 2023 21:52:06 +0000
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::8428:153c:704f:4519]) by AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::8428:153c:704f:4519%8]) with mapi id 15.20.5986.023; Tue, 17 Jan 2023
 21:52:06 +0000
Message-ID: <AS2PR03MB9815C5C045F3138287070F1AC0C69@AS2PR03MB9815.eurprd03.prod.outlook.com>
Date:   Tue, 17 Jan 2023 13:51:59 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v5 09/10] http: read HTTP WWW-Authenticate response
 headers
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Matthew John Cheetham via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>,
        Matthew John Cheetham <mjcheetham@github.com>
References: <pull.1352.v4.git.1670880984.gitgitgadget@gmail.com>
 <pull.1352.v5.git.1673475190.gitgitgadget@gmail.com>
 <bcfec529d9581db3181cc6f3b3d4b4b8d315ca0c.1673475190.git.gitgitgadget@gmail.com>
 <230112.86wn5s2l5r.gmgdl@evledraar.gmail.com>
From:   Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <230112.86wn5s2l5r.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TMN:  [8yeRl2J8khgfEmkZFw7znMAg6z+LFxGt]
X-ClientProxiedBy: BYAPR11CA0043.namprd11.prod.outlook.com
 (2603:10b6:a03:80::20) To AS2PR03MB9815.eurprd03.prod.outlook.com
 (2603:10a6:20b:609::16)
X-Microsoft-Original-Message-ID: <bc2e4d7a-e970-3712-a148-a6f794a222e3@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR03MB9815:EE_|AM9PR03MB7250:EE_
X-MS-Office365-Filtering-Correlation-Id: b946ea2a-7b09-4ba2-d7c2-08daf8d51365
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NVzzMYQbr7SySXjQt7SwmjlSAB/U8bQSHMuGw1IsXQab4le9w/fdmTiGdeIWSw+Z+q7qGxuo0mQ4PCZ52xetvXMkjcGIEoGKjvSz96Lbl9jv1djPm/aNLy9iUU700tqTNWLNt2DlnQZ9H7HY9qn3IEgQGhZry6dCZsQILKwgYTHrqMJj3l3GkM/UH5S7VU2G2KXEkDETN1Q/O16puU8zgM83sRLbBV5It6hMmgTjyqE18AIFtdOH8Tz38xvWjrZaQhEebbrWp9HHH02tet5oZ6HHaiHiug0vpwVqEsmJKtjqle+hqflDGunMhHJAPthuTZ9muXJb29gworQwrdaByWmqAF/ysvM/VHjO08UBoa+YSE33BVr3xUb5pIvV6iBJEXfbOfR0vzKrmraBmpHszjHc/xF0omuFePK6zlRdnp7lEKVw8FGiKuwRJUVWQ/PbApbwQ04CcsccqvH0QaxMq4XDKqyxWs+Qtu9PlevFFxwTz/slrRIei5rH8feMfq0dpGKJIneNDkAHZN2T4G+GR0OW3Hwg7wtSVx+nt0HSuryZ5FkE7uql10BijU3F9VqZigd1CaPO1gMSyWzJXumrZ9qtK1sQAP1Sk3PLLZ5qiNLVbcNzn8J7U2owHYDWTan6kS8TzsByO0RxVCvQ9gB6cQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REk0N2x2ckQrYitwTWthZ1NOanJhSHR1aC96YmxXY3dFZ1pmRHM3TnRrQlJ6?=
 =?utf-8?B?cVlyQzBrTkwzUFNNM0JvelJMZVNQU09XMEowYUdiTzhrb1NFU1JJZEUzL0lX?=
 =?utf-8?B?bGtQZ2xlZ2VUN2o2dkg0RXFTc2x0L2VqNkd2KzFBSlNiNGQzcUh2VmtXbmxP?=
 =?utf-8?B?WFpKY0Q3Nm1qT2xRM3NTa3dLWXdsNGlTUmcwZDRZRXRnY3p0czQvRDk0UkxB?=
 =?utf-8?B?MURpb3N3TTV3dFV2dG1SMVoyUDRwSjFNWDVkUmkzSWNsWGFJVFU1R2xhbkIw?=
 =?utf-8?B?Z0MwWEIvelJOYTlvbmVuUnU5NUhUbkRVSFo4dnY3c09ZWm9mT3J4UVhJU1Fj?=
 =?utf-8?B?WTZGM05UcnM0RUpIbnZpQzY5d2hQRlJQUTRNWXdCYnFnNkJMbXJKa2dqQkF5?=
 =?utf-8?B?S29KenF1dEp0OURpVkdVZUMvcGhzbEhBL3Q3Z0xJQUpJNnJOOEkyU0J1dTRp?=
 =?utf-8?B?Z3g0MDhWc1ZpblNVTXppWjdBR0pSZDM5RFJaMHVrTHMrM3BWQ2lwaW1BV3hN?=
 =?utf-8?B?OXdpZEhIYTNDb2FtdE04blBrQTdVZDlvbnZQVXEzUytmTitnMlNiMlgweFFk?=
 =?utf-8?B?ME9uQXRMYlo4cFZEWHRjNytOem5RbW14V2ZRNUdpaHN1SS92eUhESzNITUxq?=
 =?utf-8?B?VVpaMzFUNUxxejBKUVh4NGQ4NHZhcEtEWk53aFhhcGg1VFZPTU56ZVNodEE3?=
 =?utf-8?B?bnlJNjQvWVJmZy95YzNiek5Ha05XVEFmQytUL2IvZ1hzV3BMTk83K1J0Y3Yy?=
 =?utf-8?B?d2R6ZHFiTlFVVGhQL2czSllQbm03SE9QbUwwWjUwTFFNYnlYa0x3cTJXbUdh?=
 =?utf-8?B?Nlk5SUhFelQyQUgybWZCM2pTeXpoSFFoV2hLa0NwM3l0RytYWW1zUVl3bWpx?=
 =?utf-8?B?UkVjZ2VNdUtDck9nOWZvUnQvNjFRNGFneS9sVWxBRmRpWmZaMUFyd2J2YTZ0?=
 =?utf-8?B?WEtnR250UHlZS1NqYk03NG8rRGZzc0p1UGcyMFNQeCtRVDE2eDROTE1pZTlm?=
 =?utf-8?B?R3hoMXpQRVBaYUQ3dXlXZ21tcGJaTFVKSGJja0gzOW02Z1BPU1dzengxeEtr?=
 =?utf-8?B?VmprNzh1a0FHVS9uZ2lsblJERDZLcXBRN1M5eUtHcHhpblpaRS9NdlhhVmVR?=
 =?utf-8?B?a1FSSFBTby9adWRCbDV0WDV4OU1XbXVHSGU3ZytXWmNOWHF4cTEvTWtIRncz?=
 =?utf-8?B?ekllRG41LzRjaWYxYTl4WmdMcm1aL25TSFZHaXVSK0sxRk96TXNJWVZDNmxU?=
 =?utf-8?B?eVhUU2l2Z1Fac0F0aFFOMFdJMkR5aFNneHRDb0grY2F0SzJWbDVRc2lUZExU?=
 =?utf-8?B?QjNuSTNleVowUE12OEZaU1FVY21UTXRxUHVrZm1pNlVHbExEUmM2L0Z2ekov?=
 =?utf-8?B?eXkwTlJYNjV2ZmhJbmFta3BSbTVWSXpJWitUekFCV2xOZ1h1NW52d0RJajNy?=
 =?utf-8?B?TVA3UTVwUGgxOWRoR3QyRDM2M01veWhqK3djaHJEdUdta25uMmFKcFY3cVdh?=
 =?utf-8?B?ZFdWVEJ4N2oxTTBBOWg1YjVtZlVkWEdGbVM4aTBpOUtyVnFldUtleUhDZVV3?=
 =?utf-8?B?UWs1N3NBTDN5dmI2eEFLVjU3NGNkNXpmbktUMFdlMlFtdkZOYWdSY0srZzQ1?=
 =?utf-8?B?Q1hLUStYWXNGVWFBZDJxSjFCWDA4U2VzNE9UdFVyMG9LRlRuczZMWXNocFkv?=
 =?utf-8?B?LytUTE5JdCtBTlF6b3BHWE9TNHJrS3FxdDZDeVVnYUNNVXJoOXRZcnF3PT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b946ea2a-7b09-4ba2-d7c2-08daf8d51365
X-MS-Exchange-CrossTenant-AuthSource: AS2PR03MB9815.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 21:52:06.8210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7250
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-01-12 00:41, Ævar Arnfjörð Bjarmason wrote:

> 
> On Wed, Jan 11 2023, Matthew John Cheetham via GitGitGadget wrote:
> 
>> From: Matthew John Cheetham <mjcheetham@outlook.com>
>> [...]
>> +		} else if (buf.len) {
>> +			const char *prev = values->v[values->nr - 1];
>> +			struct strbuf append = STRBUF_INIT;
>> +			strbuf_addstr(&append, prev);
>> +
>> +			/* Join two non-empty values with a single space. */
>> +			if (append.len)
>> +				strbuf_addch(&append, ' ');
>> +
>> +			strbuf_addbuf(&append, &buf);
>> +
>> +			strvec_pop(values);
>> +			strvec_push_nodup(values, strbuf_detach(&append, NULL));
>> +		}
>> +
> 
> I've written something like the strvec_push_nodup() patch that preceded
> this myself for similar reasons, and as recently noted in [1] I think
> such a thing (although I implemented a different interface) might be
> useful in general.

A fair point, and reading [1] I see there's some concerns about making the
strvec interface more complicated w.r.t. ownership vs saving a `xstrdup`.
In light of this, I'll drop the commit to add `strvec_push_nodup`.

> But this really doesn't seem like a good justification for adding this
> new API. Let's instead do:
> 
> 	} else if (buf.len) {
> 		const char *prev = values->v[values->nr - 1];
> 		/* Join two non-empty values with a single space. */
> 		const char *const sp = *prev ? " " : ""
> 
> 		strvec_pop(values);
> 		strvec_pushf(values, "%s%s%s", prev, sp, buf.buf);
> 	}
> 
> There may be cases where a public strvec_push_nodup() simplifies things,
> but this doesn't seem like such a case, just use strvec_pushf() directly
> instead, and skip the strbuf & strbuf_detach().
> 
> I haven't compiled/tested the above, so there may e.g. be a typo in
> there. But I think the general concept should work in this case.
> 
> 1. https://lore.kernel.org/git/RFC-cover-0.5-00000000000-20221215T090226Z-avarab@gmail.com/


There's a bug in your suggestion. We're `strvec_pop`-ing from the array
which also frees the previous value that we want to use to append to in
the next call to `strvec_pushf`. We need to keep a copy of the previous
header value around.

This should work instead (adding an `xstrdup` and `free`):

	} else if (buf.len) {
		char *prev = xstrdup(values->v[values->nr - 1]);

		/* Join two non-empty values with a single space. */
		const char *const sp = *prev ? " " : "";

		strvec_pop(values);
		strvec_pushf(values, "%s%s%s", prev, sp, buf.buf);
		free(prev);
	}

Thanks,
Matthew
