Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C60C64ED8
	for <git@archiver.kernel.org>; Mon, 27 Feb 2023 17:15:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjB0RPG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Feb 2023 12:15:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjB0RPE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2023 12:15:04 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2075.outbound.protection.outlook.com [40.92.91.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245A41EBE2
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 09:15:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V4ptXWBvh76lPbpnY+4wr4WO44lLRG+5LdzqT3eiU8VvZgjtU1GxXJ5JOW6fSLcG3dQOnD0KAK2O0mKJ/KH93coAfyr0TioBtQyuH9JoymHnucUKo+5e94nIUtD/z0VzxbWEx3iMzWS714fwyEEal7x1KJ6RM4i4XUDxG+Ba9pUB4JgWArEHRtVBfAaG8nVukPgDKDAD2tgi5daECa5si8g9TgxkSTdL12nIxDitjBUj0wThK2RFcerVYNd9HRbySsfLMI8LGV+wpZMXqMJZSLaixERhoszamG95FjA2l0kXMO+jx7hZ63cFJy2L0CIt6S/5OVY1toJflsn1iJJgWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oy0Bc5KyK8DGeySU7SRGM2XoWo7deG1nqjXKRSU6pyQ=;
 b=manxLQThHKBX7Zx+zjN50MOyNdwZPyITMnywIv0wSC9Rep4Yf6nYT4IHBOUZ7etLu/Sw/U/jt5ntVqoc4sHbYqqLJBf4dNV+1+l5khXmIaSvLp3iE8CAcE25IYuqCL2NGyvwjEM9yg4bWybqYu7CzKmxged3IPhdLDM0imHy+W4NvNZEtXv0Whm5KUwp7AEBNcEjBED6qEw2Z2ODH3HWNIoUz6q4eTmYR/mAo5n4omPz74e15iKxx/acIDoVNGx4zMYhlmQmMx3BQTGPzV7VFd+ZtoWcZnPLhUSpr6C1B1FNQRmOFHVOjaEDjwEsjPn8q8vdPFa2SquY6jQwZWs+Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oy0Bc5KyK8DGeySU7SRGM2XoWo7deG1nqjXKRSU6pyQ=;
 b=Y+cjYPs6O3KXsTQOXNFQu2IxwNgx0l+zwRTcfUaO1S0CB5RsgdYUk4NLODW/+YikpNk56Ov7jIEWl2VBixkRyl24rK44ZSW/8yTmzZCDvOfZXtrPy5ZD4jVT8S9zGJ2hKIFkGKJgzwlcrqQrgPqob37ISQqvvWXw1jelfAB2EWzYivBqzWrMNHWRVz1ABfdcMB4w0U/YupkMu37VWsyWIz0d7miO8EkgX5QvHoGImlrW7d+zTyLXrFDkl79qldPFiA/laUQAVsD/9xBPQch53J3KSfNCLNaM0PMux4jlb3aj0QSZRRMpiW/iwmXm7r5p4O0Y3aQhRqFUX0BL9zC7jw==
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com (2603:10a6:20b:609::16)
 by AS8PR03MB7160.eurprd03.prod.outlook.com (2603:10a6:20b:2e5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.27; Mon, 27 Feb
 2023 17:14:58 +0000
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::7674:1fe5:785:a469]) by AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::7674:1fe5:785:a469%7]) with mapi id 15.20.6134.029; Mon, 27 Feb 2023
 17:14:58 +0000
Message-ID: <AS2PR03MB9815D1DE582E0DC94C18535DC0AF9@AS2PR03MB9815.eurprd03.prod.outlook.com>
Date:   Mon, 27 Feb 2023 09:14:49 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH v10 2/3] http: read HTTP WWW-Authenticate response headers
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <pull.1352.v9.git.1676496846.gitgitgadget@gmail.com>
 <pull.1352.v10.git.1676586881.gitgitgadget@gmail.com>
 <703ac15222fdcfc98751b11af725cc1395134bd1.1676586881.git.gitgitgadget@gmail.com>
 <Y/c1+Llb/D27eWdg@coredump.intra.peff.net> <xmqqo7pk6u2h.fsf@gitster.g>
From:   Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <xmqqo7pk6u2h.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN:  [ZH4bMTQSRaHwbbVQMSrjijpmUv2x31XGYz44gMYB8d9gQEKPPxxSuJ5yCg1f7JUC]
X-ClientProxiedBy: SJ0PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::17) To AS2PR03MB9815.eurprd03.prod.outlook.com
 (2603:10a6:20b:609::16)
X-Microsoft-Original-Message-ID: <f1f62e02-538e-0513-436f-13d9555afb70@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR03MB9815:EE_|AS8PR03MB7160:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fb3042b-2389-4128-d9fb-08db18e626be
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uoMMSEkgcD1ESeUmL/bdAS66e6etE8uvN/9XDwB/taK2t+cGp5wsZQFrO3OysWRtmtPSzOFMD2i/yb0Vkm2K+exGa5BiMRpNdtsYpH0fgrSGVkJRqCcyi9CQdo15g9RBKtrH3kOV0E5wCKRli5W3copnY0+gtugmZzpKebQhNU65GvxnUlJ9aS5fWIFDfG0zdlmjSKVxAjX4nrHXQ/D86rtQJ5Ulv1tYHus1lvlu/YyXuEZ3bQAruM6v2JH1HcupMRxVmyCk90IUClARHczU2JIYNRFQuyRYpijZgIPjfTZVnXwulY3NzxX/egkOIsqfJr5BS2azxBpzqz4pp61iGURQtcsD3vy3tzoNzkRRGIshzpW25DGaoqWeyOnG0WNlwCBZpQskvhDa61jAOOezLfHKtJe5Ylnl6YHUPK0H77s3wuSX7tSO3WCwe6DoKd8Nv7RxLhNZWPa9dgkrCRHGoAzO7xmhiU1oNcS2cyhHRa9Y/o1RYp6YteJREZR9T3KanU6xpsNXKSqJOLrn5//E+hG2SLDU75C5A4Qcf4ovZIJenraTPl42lT0nVcPT5tEuKP6R2OCYH3ci152SYv8iScp/W1cn2ljKs6V7/MQFz0jFBPyEmlcmDDXyKcyGlZ8A8VOJnhYfpWYWZPN9s7nAtA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qzk3d2NqYVBCaG11WHpvUVk0b3NYZ1M5dk5teXMrTTViT0FnbnhiSDUreVo4?=
 =?utf-8?B?WWoxRjFtNmN2TmxxbGRnUFdvZHMybkExZ24veEdEL0pIcmpha1owRlA4RXU4?=
 =?utf-8?B?aVRld0tQTDkwWSs1MnNSQ016V1BHUWUwZi9RS2p5S3ZhaHFhdVdxYWY1eFM5?=
 =?utf-8?B?ZXU3Y0FQMEQ5YmZ0NzdQV0g0amozNE5TckVlb3cwTFh3M0VQUUJuKzg5d1ZX?=
 =?utf-8?B?S0ZPSC9sZUNDaVAwLzc4RGRDMnkzQ21vcXo3cEFUMkphc2luUk8yZmdIWmk3?=
 =?utf-8?B?VFhIM1JCKzZZNjVsRXdHOUxtWEZEOVluT3FvMnRMcHZ3UHcxSkNzSGlqWkxM?=
 =?utf-8?B?NEVzQlpIbEZJc1FUKzBJNkFwNWY1WG9JSllvL1FZWmJjU0p0Zndkd2daSVlO?=
 =?utf-8?B?dlpEdERycVV0b0tmVURCZ0tHVmlCRmp0eVJYSXJxUVQvMWNrc0FxVXRHQXls?=
 =?utf-8?B?TmNob1VOV0Y2MG8yZlNUcGpIOUwwajRXUzB6QlJKOGUwaEFRVmVvanh6WHNj?=
 =?utf-8?B?cW5TbGdQakI5U3JKbi9QVnBFc2liOFhTb3c3K3orRDhyalhxWStyeDJ6eVhz?=
 =?utf-8?B?blVQUjhBbXlQMzhBa21EM0Mwd1pINkpvR21UOXR5bGNrMmFXRFhRM3FqS3V2?=
 =?utf-8?B?OExaMDZyOFYxNVAzcy9GSk9rRkM3Q3p0UktKVWltQTU1dTA2VlRCSDhWY3g3?=
 =?utf-8?B?ZGNZZ0tzZWtIdFBBQU5IakVJUkhWN3czWW1yNXpITExHbmxEOS84NDZMUzNq?=
 =?utf-8?B?c2xvYUVjeFlocHcvQm5EOENsZ1ZMb05sQzIraWJmSDQ5TVppbkFUbTFjQUtV?=
 =?utf-8?B?WU81MUVBcGRyN3FHOTROYlE4UUNyYkpRL3I1alhvSUNTMTJNZUhPdlBFdVJh?=
 =?utf-8?B?Q2J0OURDT09kTmNQSmhjNWc1NXRTVTN4M2RHYUhSRDMrUWVpdzBGaXp6M0dH?=
 =?utf-8?B?bkVGdzBsUkwrUnRodWFyWXlSd05LM0p4NG9sd2V2a0REeVZiYVFVYWZKMDI3?=
 =?utf-8?B?VXlFN3dIYzFlYjdhN24xSXllaWlZdHhHYXVYeC9mTXorMmF0RnRmWWorWklZ?=
 =?utf-8?B?SDlpK0E2dHZWUjRCcUZReDNBYjZTbUgxM1VwNEo1R0QxOWJjK2swVEViaEhO?=
 =?utf-8?B?RzZzc2RpWWt1WlZkKytvNml3N2JUNGpkVTh0K3dsRllacFpmT2d6UXFocEJN?=
 =?utf-8?B?dDFSSjNHaDd3MHRuS2lLZ002WGFIUGt3SGVManVQNlgxK2NHd1oyOS8xVWZh?=
 =?utf-8?B?YnhkVGNQeEtRRm8yTDZLKzBvZHNGR0w0Vm12L3duN0ZnN3dwYWY2QUVKT3Bi?=
 =?utf-8?B?SUhDbFh5SHVGN2xjZ29pV1ZpaDJ6anFTSlE4dHZLUHVLMmJleHZycDNHK1lD?=
 =?utf-8?B?ODhGNVBuYzhTeFFRZVlGV05jd0pOVlZkLzBIWmVmemdWY2trRnpyRUM0a3hw?=
 =?utf-8?B?R1VYRFE3NWErNWFvaU5tZTUwL0s4Q0NXR1RuVG9Mb09WK3FYMFp0M3ZvK01q?=
 =?utf-8?B?b0hoVEsxSUtuZVVGWnJ0a05iamxNSlMyRmpLNTZUN3ZweEdsWTd3aWlldmJY?=
 =?utf-8?B?dU9hNjNmTGx2dmxIemVFUHc5b0kwQUZWd2J5WkR4YmpMVENUT04xSHZtVW5I?=
 =?utf-8?B?RjhIQkNpL0gvYnQzZjdYVHQ2OHRHdHJ2eFVzYnNvSW51NDdpM2g5ZU1vVFd2?=
 =?utf-8?B?TjZyc0FCbXozQkJxTnA4YzBYYTg3WkJiNEFCc0J1d2syajIyVnlZcnp3Wks2?=
 =?utf-8?B?V1dHb2hrUGlYdThCcEpPQll5Zjl2SjcrazZNSUxDaFZUTy9qcHZtMjB6Nkd2?=
 =?utf-8?B?eE9XQlY2anZ4QU12V0pXdz09?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fb3042b-2389-4128-d9fb-08db18e626be
X-MS-Exchange-CrossTenant-AuthSource: AS2PR03MB9815.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 17:14:58.0737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7160
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-02-23 11:49, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
>> Alternatively, you could copy the tolower() loop from skip_iprefix().
>> Something like:
>>   
>> diff --git a/git-compat-util.h b/git-compat-util.h
>> index 28456241b6..f671a0ec3f 100644
>> --- a/git-compat-util.h
>> +++ b/git-compat-util.h
>> @@ -1296,17 +1296,13 @@ static inline int skip_iprefix_mem(const char *buf, size_t len,
>>  				   const char *prefix,
>>  				   const char **out, size_t *outlen)
>>  {
>> -	size_t prefix_len = strlen(prefix);
>> -
>> -	if (len < prefix_len)
>> -		return 0;
>> -
>> -	if (!strncasecmp(buf, prefix, prefix_len)) {
>> -		*out = buf + prefix_len;
>> -		*outlen = len - prefix_len;
>> -		return 1;
>> -	}
>> -
>> +	do {
>> +		if (!*prefix) {
>> +			*out = buf;
>> +			*outlen = len;
>> +			return 1;
>> +		}
>> +	} while (len-- > 0 && tolower(*buf++) == tolower(*prefix++));
>>  	return 0;
>>  }
>>  
>>
>> looks right to me, though only lightly tested (via t5563). I'm happy
>> with either implementation.
> 
> Yeah, the alternative version looks clearer to me.

Will update - thanks!

>>> +static size_t fwrite_wwwauth(char *ptr, size_t eltsize, size_t nmemb, void *p)
>>> [...]
>>> +	/*
>>> +	 * If this is a HTTP status line and not a header field, this signals
>>> +	 * a different HTTP response. libcurl writes all the output of all
>>> +	 * response headers of all responses, including redirects.
>>> +	 * We only care about the last HTTP request response's headers so clear
>>> +	 * the existing array.
>>> +	 */
>>> +	if (!strncasecmp(ptr, "http/", 5))
>>> +		strvec_clear(values);
>>
>> Since "ptr" isn't NUL terminated, using strncasecmp() may walk off the
>> end. I think you'd need to check that there are five bytes. You could
>> even use skip_iprefix_mem(), though of course we'd throw away the output
>> values. (For strings there is also istarts_with(), but I don't think we
>> have a "mem" equivalent).
> 
> Yuck, thank you very much for carefully reading.  I missed this one
> when I queued it.

Oops! Will update in a v11

>> The rest of the parsing looks good to me.
> 
> Thanks.
