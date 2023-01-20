Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40782C25B50
	for <git@archiver.kernel.org>; Fri, 20 Jan 2023 22:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjATWGE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Jan 2023 17:06:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjATWGB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2023 17:06:01 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2078.outbound.protection.outlook.com [40.92.89.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BFB85369
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 14:05:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JqZGd7Imp0mwJtIXBaUfMizSq8U8eJ0ERT5KXWBBEcXhhxCT3grNQOSsKb8s3t73DHAczvA0TfykHO3ynlWtGEwhIjL7E+zXMgBFp7Yvl4g4ihy3nBf2Ciu9SPxjmSeRiC4fCr2OSay8rk2TWVyyuzxtlGTfaEdDzDUtcueLtFo155QVOVQ1NI5CIoD2/MB1tKhOwzX8nL+COHXvvR3EHRLLDuQ+km6qaYRTrxX5TrEnJn4qMnABwuelyFtYiD8ChqhBKR83ymPb90b3E9gr6cCCgelTcL7BDxU6edXkcU8Gotfeh1CdHUlgE94Jtbu8RPOfzoooVLb19Iu4JitbpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eD9b2JqqPxC5Z2f9J3h9rWGQle/D+1HR8NE8l+PPo/U=;
 b=Iy8Rise9l+SJCYeYAXZAXeG7zgS5kN+tgSfFm4vaI8t3iGL66fHn4+hYY+y0QJC10NHijc3DEP1I9MxDUNMPqB9+ctGvtfbtrLj3wiv2GJWQwd5CdxdAw15dkHroUnZ8fEgP4LoPzLXfvm4ieFrIbreS4umlth5l/v+qCA7H5hwmHXXWldfI/wpPNq0ESJBcezQAO8CHrVjcgzY5l8AN26Y3Mnyrc/bJPJBSdDw/+78tJRsncmMXGSs5W7vhB3+9fdcSqfTEWXRZLrBJtE0Prj3nXJ9P7I8gB8YM8VP3mxsZkiCZtj2vBua60GStAtNoicbM66aqgblH8vI0RWX5aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eD9b2JqqPxC5Z2f9J3h9rWGQle/D+1HR8NE8l+PPo/U=;
 b=uePgWdfWkcQtDARke74tJVmu7h1byE4YMfOWronWx17Zu7L0SDZDArs8WPWCu8Me8gBYf3mEZoGYKSHp1nsm+Lq1/ycmQ4HgGdoYvkxVd4chIBwlCqZPGQNoZVFYnaEnW5Ga64hWHvDiCcjGPEZ+EbDpG0Lso3VOi393mfRExP0JZejJXsE/m0Ni/mO+INAolgv74/dwkuUnjk+ZuZRUvTH6jLJxlQY8IcptaH3TQSKRgfjQq/rUrd26Kd5muldWCPw8vEp90uyrrLyL6eJHf1wQa596v4vehaBmd2CSHXB3nlEryynu2H9qXrRbx7DN6gpknVFv+SWt6Ixs+V3y9w==
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com (2603:10a6:20b:609::16)
 by AM7PR03MB6676.eurprd03.prod.outlook.com (2603:10a6:20b:1b9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Fri, 20 Jan
 2023 22:05:52 +0000
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::8428:153c:704f:4519]) by AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::8428:153c:704f:4519%8]) with mapi id 15.20.6002.025; Fri, 20 Jan 2023
 22:05:52 +0000
Message-ID: <AS2PR03MB98152D5781CC52065A71C43EC0C59@AS2PR03MB9815.eurprd03.prod.outlook.com>
Date:   Fri, 20 Jan 2023 14:05:45 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v6 11/12] http: read HTTP WWW-Authenticate response
 headers
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Matthew John Cheetham via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>, Victoria Dye <vdye@github.com>
References: <pull.1352.v5.git.1673475190.gitgitgadget@gmail.com>
 <pull.1352.v6.git.1674012618.gitgitgadget@gmail.com>
 <bc1ac8d3eb3ac6e1161f6b6b67343874c10cd14d.1674012618.git.gitgitgadget@gmail.com>
 <230118.86y1q0vzhh.gmgdl@evledraar.gmail.com>
From:   Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <230118.86y1q0vzhh.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TMN:  [bczrsHy3S9ePB7mCULKdueKuvKA3REKL]
X-ClientProxiedBy: MW4PR04CA0240.namprd04.prod.outlook.com
 (2603:10b6:303:87::35) To AS2PR03MB9815.eurprd03.prod.outlook.com
 (2603:10a6:20b:609::16)
X-Microsoft-Original-Message-ID: <199df29e-679e-f97b-cdb2-bc228df5f8a7@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR03MB9815:EE_|AM7PR03MB6676:EE_
X-MS-Office365-Filtering-Correlation-Id: 61ca1977-3721-41f9-6636-08dafb327ee3
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B6n7KyrKVyedg4q3DL37pa1Hw/EVoeSQi5v5ZGqzgbXKYqVRS8xL6yAUF3LJyQxupwJSRzKKk6LyOpVZVfQVDX37BQzW6c6ORiFqwDyv9S5FSkSTfMiZRfuYUZyADmfyCMOk2tLn5lpzl1JqcPNHH9mPxk4FDba8U8EqnMKlUPq+ETvdt1StzoIXS2fiNezf0u9e3iyReIbSD/37mwCxvHV2AmQ5nFhtAJxSbNaQYOb6IDdf14+0s8SOz92hS976fDn8SnDWuWnsWVTb25xs5Tj/NZ1P510g/gXi1D/6QgGwzsETbb1nDX2zUR320aP82wkiKp6e3iAX58leIqPPzSUQJa2M5TdPI1AFXFkE9TZvGev1tWt/c8NHvVfze7DH33oDiNUiVy7k75DOBEuYBkgP3ODYyftzpgPYOxUbjDZyxiBrwEV/y0lvlYmzwy1HBCyDZeb1+Pv6jv+Z97MSIilQwuMHwIceyDh670mShjSnNwdIkIhKRzxwNZxk0Ku9sqI8FO0LJRd/1YzUzJTMhmAmQNEHEtg+ysCYxbrgGv+h+iCQPZQKZCNej/MJMEkdzDax6VvATvOiOkZGKcCa2k7EHM2qmsDkcyhvf/GpYZi3EEv47+TEMjA8aPCHJfkO2RGWP9oRePDd9HyGbgs6sg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGo2Rnk0TExEaXlHa2JWRjk0WjFtb1dXQ0Rtc3kxUGVQZHZ4MFlwOWlpWis2?=
 =?utf-8?B?Q2FTUFA1djAxSWhwdlhwbkNGa3Q1QStwQnJEZ1ZHSUJYWVArVm5Pd0E5aEZY?=
 =?utf-8?B?MEQzbmFkRk9qSk0xSHBaOHNwVmEzZjRtSEg3NGtVQWttWXIyYnJXQnYxb3c1?=
 =?utf-8?B?Y2VwbE94enRMYnpwbWtPd01KaHF6VSszTk9yQ3FXWEljMUdEZHJSYnNFSHNF?=
 =?utf-8?B?Tzhtcm5QVWhvRERtWU5zUkhTYUJtK010bkZpUWd0Z2dHTHI2Wmw1b3ZRTkZG?=
 =?utf-8?B?Rm1uQ0NyQWdmTUIrU0NwdERqQS9WSFo2ZWRFUW9UczgwbmxCNWN3VGl2cVI2?=
 =?utf-8?B?OVg0aDhwUDNRZDVhdDlWYVlIOUwrdlI3ZWg2QVBFKzNncXdmMm1HQXFvM0hN?=
 =?utf-8?B?aHVwUHRVUzJoTmFhbnNBRnZHQ2tmWWtTQTlqc1hmQUdBcFQ5WEpyZTUzTzh2?=
 =?utf-8?B?U1c3UkpXcjJLR2Q5V3hUcUM3eTNxRHROUWx6b0dRb1EvdFFjd0g2VXhPdERk?=
 =?utf-8?B?dVNmQ2dDMEx0WHMrNGtVVHdMVXZsRmJGU2JZN09mY3dGS1ZTZkVlSkdkdEV4?=
 =?utf-8?B?dXlodFVYRVREdy9RMG5iUVpFNlprQk9OcGVzYmJXMFhBMXJoYTlJd0tUWlY3?=
 =?utf-8?B?UTZZVy9xVEl0ZDVrVkgwZWR4dVpzSGxNRGtsR1QyUkt0NVpVaUpKenNVQ3Yv?=
 =?utf-8?B?SmQzN0dLWVZ3UGlHRzd4R2lHbWxpQXBPdzVzYm4rdFJDRmN1WTBzcC9GV29W?=
 =?utf-8?B?bHFVQ3ZMd3Q2bStHUGtuMUcyMUFTK2xmYUhRODcycWJGaTR5SzJBWUtpbEgz?=
 =?utf-8?B?emRySTdSUnE3VzUvUExGczJZeHFvM1BCUG9zNnBOeGhFc2lHRExORTBWL1ln?=
 =?utf-8?B?SG96dVdweS9pOUhMSWRLR2ErWkVIaTlWVjBnODg3ZXJxemJjWE5wVktJQ291?=
 =?utf-8?B?c3FBNWc4U2RuUnNGeGVHRzRwZGVwL0hqZ1ltbjhYbXM5VzJacjNqRVJqU0Vh?=
 =?utf-8?B?VHlqNGZ4dkJ5M2pDN29ERVl3Nk5iTU4zUkZpcjN3Q0NJN0pFOWc1VmVsVUhs?=
 =?utf-8?B?NW1CVUgzWGU2TDFIczFUMTRZaUFzWFhSSXZtcnlNWHJRSFEyM1hURGRnNWJ1?=
 =?utf-8?B?NklBam1UQUdSc0w3K3FZY3FJZ3c1MFRzMkx3aEF3NmlHQkpGa3BObDM4cVB1?=
 =?utf-8?B?SWRuRGIwWnpsSG51VlBMU1c1dlBROVV6SHZrZUJ4ajAxcmRDZmJJTG5Ocnc2?=
 =?utf-8?B?NHQwazRxVXg1Z0RNWVBEclFIOU1zSlk2Q2JhMjJFdGhPZHN6SzBDWW9jM3E4?=
 =?utf-8?B?amo1cWp1ZnJMM1JvRFRXays5aURVWlVHUjFLeTNVdFd6TkpFdHBYWU4vbHRO?=
 =?utf-8?B?dTlHdzBkWko1cVZtR0ovVnBxMjlDSWhVSHNXT1Z2T1FDYWY5QjZONWthVTA0?=
 =?utf-8?B?ZGFobWNXbjZ3cWtGK1JtdVJJUWhPVDNtd2tCc1ZpT0x1K29CNzJGUDRSUFAy?=
 =?utf-8?B?L2JOb2ZLeFI1UjM3QkRvcTVOZ2MyR0U4WWFHSGQvaXRuVDlqcXpUeVNxYWxZ?=
 =?utf-8?B?UGE1UmhKRFdUek9zSUV0WkV6OGFtTzlzeTBQb0FKUkp2Y0p5SzVuREtaUDZJ?=
 =?utf-8?B?blQ4YWhXU2Q3WEd6VTRZQ3dRWVJOQXZzRUgxMVN1Um4rTXZhVGVMbGhNQ1hH?=
 =?utf-8?B?eUR2alRXN0p0bncyV09BWlc5MCtPWnphN2lWempBK05YdERIM2xSK2p3PT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61ca1977-3721-41f9-6636-08dafb327ee3
X-MS-Exchange-CrossTenant-AuthSource: AS2PR03MB9815.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 22:05:52.6021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR03MB6676
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-01-18 03:42, Ævar Arnfjörð Bjarmason wrote:

> 
> On Wed, Jan 18 2023, Matthew John Cheetham via GitGitGadget wrote:
> 
>> From: Matthew John Cheetham <mjcheetham@outlook.com>
> 
>> +	strbuf_add(&buf, ptr, size);
>> +
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
>> [...]
>> +	if (http_auth.header_is_last_match && isspace(*buf.buf)) {
>> +		/* Trim leading whitespace from this continuation hdr line. */
>> +		strbuf_ltrim(&buf);
> 
> 
> The mixture of this isspace() loop and then strbuf_ltrim() seems odd,
> why not stick with the strbuf API?
> 
> I.e. after skip_iprefix() strbuf_splice() the start of the string away,
> then use strbuf_ltrim() in the first "if" branch here?

You mean like this?

        size_t size = st_mult(eltsize, nmemb);
        struct strvec *values = &http_auth.wwwauth_headers;
        struct strbuf buf = STRBUF_INIT;
-       const char *val;
 
        /*
         * Header lines may not come NULL-terminated from libcurl so we must
@@ -216,11 +215,11 @@ static size_t fwrite_wwwauth(char *ptr, size_t eltsize, size_t nmemb, void *p)
        strbuf_trim_trailing_newline(&buf);
 
        /* Start of a new WWW-Authenticate header */
-       if (skip_iprefix(buf.buf, "www-authenticate:", &val)) {
-               while (isspace(*val))
-                       val++;
+       if (istarts_with(buf.buf, "www-authenticate:")) {
+               strbuf_splice(&buf, 0, 17, NULL, 0);
+               strbuf_ltrim(&buf);
 
-               strvec_push(values, val);
+               strvec_push(values, buf.buf);
                http_auth.header_is_last_match = 1;
                goto exit;
        }


I don't particularly like this given we're now introducing the 'magic' number
17 that's the length of `www-authenticate:`, plus `strbuf_splice` is doing
a lot more work moving pieces of memory around rather than just producing
a new starting pointer to the start of the value (skipping leading whitespace).

> Likewise this is open-coding the "isspace" in strbuf_ltrim() for the
> second "if". Maybe run the strbuf_ltrim() unconditionally, save away the
> length before, and then:
> 
> 	if (http_auth.header_is_last_match && prev_len != buf.len) { ...
> 
> ?

The suggestion of trimming and comparing lengths just makes a piece of code
handling a little-known edge case less immediately obvious in its intent in
my opinion. The current implementation of "if starts with a single space"
matches the definition of continuation header lines, rather than re-piecing
together this from "why are we trimming and comparing lengths?"
Perf-wise the current implementation is only adding one extra `isspace`
call which we're potentially about to do in a loop inside of `strbuf_ltrim`
anyway. Plus, the common case will be a single space anyway.

Thanks,
Matthew
