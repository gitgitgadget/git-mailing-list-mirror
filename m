Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E165C00A5A
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 23:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjAQXZY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 18:25:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjAQXX7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 18:23:59 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2022.outbound.protection.outlook.com [40.92.90.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04C5A45DA
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 13:17:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WVNqjrUw9pLJgf0YuGnpjTZE/WnFKzVFbsiJEaKS8sbwRvznEsdjZwV+UuFUdIaFYTe+rBuzZGsBs81BpCxDpncVTpPmM/L6z6xBscGV3LttAvJmYLPZySrbZZo5peSAQe7jPpY5h1ZMXGuIPs17zDvwD5RPaGsSFQuKf17B1yDTNtGALUuk4Yio/9IsBIxTtpZxQxGruwH4gZK9LodNITqM2cpIdTy0l+7aCp0JMN+qYs66RyrB40eWqiYcBejUqQ3Qc4Jsc+OPFy3LI56sEzBZ7nBoit/nnyOez3sxa/PeCAFHLr13Nc4j1B+5p1bDH5eKBouEoeivmGjsGFuhHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ws5T2PtKlhHaYb+Do2pizfRXFKovf+BYBXDTrzJp6dM=;
 b=FKCX+wVxzFu0Y7D92p5Be5aBN9ermYPI5bHObK6k6IWiHSg7x/AeB1g1gfRvEQly4zqxW2bLFAegaKJ97bfNT7+8x4+uW/QGs7JpOcIxjywToC3kZaEBzoW+a5CENDiz5HzFRFLzjH/PRD1L0KhzNApwoo3TorIWfNuLqfeiDMANDQIBc65CNWQRAk8JujfX4Ou2HikO5JlHOl+0mJvEj/MwYosw/MO/nzB40tCPwfCNq3M7VK5s2Y6TgvaTBvjMW3QxRLlcqWLdXNopPK6s1m3DEDgRFi4EsUJd+ll84mGJib4VG+HeiA4XQr3ky1PFMBsvtDkTOWSm1b65VrNTYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ws5T2PtKlhHaYb+Do2pizfRXFKovf+BYBXDTrzJp6dM=;
 b=XgYV4V0BqVZBGllvXkHxki+DQzVUNeAou0NGpcQLSc9/5qAOZdayuJTnBqGnDoACwvSri8LhvUqTqYKKO2R6+Ww/DpFqu+onKYOBEOjpppuPYIsxYgivb74abiIwvPL0CDyAJUolalJM5NJratMLvx0Y3horgyT/9oLPiI7xx1p9eJr513VFqsr8E+Mejee+AsQ8/rbnVrr8O3TMcwp/bcilpLRHzczg5dSYYoQC5XicwwqYm9aPjMCdfldVFvcMyUquHhHyPAzPlBW94dD9YPg/KErSJGRGz79MtBL0Qnf9b7Cvc4eXM3DOcvlA7bFsyhWxf15mRbnhO+5Tnwtfeg==
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com (2603:10a6:20b:609::16)
 by AS2PR03MB9696.eurprd03.prod.outlook.com (2603:10a6:20b:60c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Tue, 17 Jan
 2023 21:17:00 +0000
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::8428:153c:704f:4519]) by AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::8428:153c:704f:4519%8]) with mapi id 15.20.5986.023; Tue, 17 Jan 2023
 21:17:00 +0000
Message-ID: <AS2PR03MB98150A57C1F9729CCEFE4EB3C0C69@AS2PR03MB9815.eurprd03.prod.outlook.com>
Date:   Tue, 17 Jan 2023 13:16:53 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v5 03/10] daemon: rename some esoteric/laboured
 terminology
To:     Victoria Dye <vdye@github.com>,
        Matthew John Cheetham via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Matthew John Cheetham <mjcheetham@github.com>
References: <pull.1352.v4.git.1670880984.gitgitgadget@gmail.com>
 <pull.1352.v5.git.1673475190.gitgitgadget@gmail.com>
 <8f176d5955dfc83616a39622972aaa71a71f5599.1673475190.git.gitgitgadget@gmail.com>
 <da31180a-5beb-4f0e-667b-ddceba941e9f@github.com>
From:   Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <da31180a-5beb-4f0e-667b-ddceba941e9f@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN:  [TrG9Q568Y+ZQGryIQjuy9xSUbQQ3tKDu]
X-ClientProxiedBy: SJ0PR03CA0290.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::25) To AS2PR03MB9815.eurprd03.prod.outlook.com
 (2603:10a6:20b:609::16)
X-Microsoft-Original-Message-ID: <4aac4fb5-0a64-b082-37a6-ee09858beebe@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR03MB9815:EE_|AS2PR03MB9696:EE_
X-MS-Office365-Filtering-Correlation-Id: 757e593d-23ac-40db-50ab-08daf8d02bb1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b5Fdv78x9avXEKeQEO2UzUqG8xNsNOu/LYhpGsRy4KJ+kgNUpzA+dePQsJfGWkaettzTQKht7RdzdztIPm8X6ZVmi3Mofz34jAqfe6zv0nUgBd5vLgfbV4f56yYys4mQTU99UQlneytk9yK8r7/o2emEIHM17lm2EttGk67d1aak7uLLvt7D8omGTzjSqBjEUVbdr6QX+wTEI4ISiSLPBk+yFk4YtwLQGKuVwupf+mFZbTjndMhxfwucMLzWaXXKG/gAW8NjlZXIMQg2OZRHbFExvibhg39z5ojXCFiXAhqbynW7XgHoxNRU/cOpdTx6NawfjW6aJY2luNpT48oYPiC9T9r+pzNm9451N3oJytlMQNjPZ3VAzjkad+r30Mjrb2fO6AI5AVF2fnMoiEFeCKOiyZV8DuSvA9ua+Yvd3bi2/9bigT3ILY4MsrIKZek6RVYrXHCRn26aH3dbzRGzAEGOLg1w3q7KPnFdoFyLwn0NIBww8g9Mnv/+vPlOtUMaFWpW/VUQsrLiKYCr5tqnyQBScyjO/Pm5TcpisX3l6TVpOjOUjRXTQjgTnNm+fem5C3oKhBUFF9iObt5RTyAh+uotlT3crMSslrWT+3h1VYkGtlhtLPV2W2MBAy2jj8i1lyBrnEYi3M6GcaAvbhyNIw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWNGMnVBcTM2QnRTb3RDdUovd0sxcUtMZm1sVkJGb203aVF4c2UxTGtSYTll?=
 =?utf-8?B?d0xaMFdQNnVmS2x4WFZvZzRvY0g3VWNXVVlDMGZCeXB4OHQycytZbzJKeTlp?=
 =?utf-8?B?anRjcVB3VldrUkllVWVtWXkrVjZlYTlTdkdlWW5NSzk4c29aZDVWais2cjFU?=
 =?utf-8?B?MDJoTDBsbG4ycnZURVVPeDFmNC9XZWZDU0lLeWJpeHQ2L1hnTmh4MFB6b0hY?=
 =?utf-8?B?cGEyOUpmR3IrendqUUFFTERZOGVhT2Zrby9DcXhVNVNMSm1WYUxWZ0RnRWFH?=
 =?utf-8?B?T3pWK3JYRFQrRmhLVlJMdG9mZ1lKRlFudDNNcnZ1U3Foa2JDaENXOVVqN29j?=
 =?utf-8?B?QjJuc1E3cnZyYUNhdktoZlR4OU1pQVBMZ1JodUtZMjRRVFZrcEllcmxGN1dZ?=
 =?utf-8?B?OWw0SDhpaUxKMTR0bmFQVFloa0JPb05SMlRMdnRTdnFTa24yL215T3BveUMw?=
 =?utf-8?B?RVpWVDZ0SkZZZzZjVkVWRTBhZ1BlNFJNQk9DNWxmeXE2TnRXV0JhK01sOU5w?=
 =?utf-8?B?VE81blNZZ1daN2JPMkFCbjJvd0d0RHNKam9ENFkrL1ArTzcrZ3cxZlJwa1c5?=
 =?utf-8?B?MXphYVVqM29GWlRtYUd2SVEzeGx0WUNIdHB5a1VDMURsTWtaeTRXNW96djhq?=
 =?utf-8?B?VEhQUEVqdWlhZVN0MkNDVE5kaVg0QmluYkRBa3VBWmlvOEU0WUs2SStLM25M?=
 =?utf-8?B?emtKVzVJSWRmL050OTdHcnZ3TkpjTzY3bnMyYjljcmJjY0RoYzhlSnFCNmYv?=
 =?utf-8?B?dys1VHBueGlpVktBT2RqV2crandZMWVHZGx0YVA4OExYc1FZaVhHZXpscVJM?=
 =?utf-8?B?NGZaUHRnemZCdzlnMXVuNUdsUzhTdFlCRUZ5RDVlNzV5S0IrVTZRaDVONGZy?=
 =?utf-8?B?a29IZEVnTnlOT2tybDZQM1FsdWRiNld5RERnMVBuZlR4NUh1OUE4TGdJdU5C?=
 =?utf-8?B?WFhUNE5raUF5SUh1eE5IMTNhYWgxSTBYa1JEZVEwK3Z2VkJtSW9ObU9FeVBt?=
 =?utf-8?B?dmoyQy9PY2VuVDg5cXRicGtHckV5b0E1U1lxVENrWmxPQ2pFSzRwN0xFdGNx?=
 =?utf-8?B?YW41RXgzUU05Mnp1QVF5N2cwYmR6WEw1U3RyOVNTZEJqSmhiSW9Ddllublho?=
 =?utf-8?B?bERtUlJXaTdTUElZZVNSRnRYZjNhZEt1c3Y0U2NSVGhWSDRhbkpsV2taMjNO?=
 =?utf-8?B?OHNlVmhwUnozbzArMzVzeFNkZGJGZktqa0FGcVZueHR4eVhnWUhGeFhwb0dI?=
 =?utf-8?B?VUs0M0hvcU5BSjFrZURiWkRyTEI0Z3p4WXJ5OEdWc2N2VVZya3NVOGw4Qm9z?=
 =?utf-8?B?TXFJSi9ncEl3bWFNbmJpL2pFK013RWlSQTdrNEhvQnhLbWFTMWpxd3RXL2JB?=
 =?utf-8?B?SGJSTERPM29COFVHeEZMZTRKNCtEa0ZCVkNucmtlcXhkVkZ3K2FZVUc5Y0dE?=
 =?utf-8?B?U1MxaVVDeTRxdm05VUZ0RlJGd3pXZGJHT1NONitDZmJEci8rT1FqWi9VVEcr?=
 =?utf-8?B?ODRJWmg2UVJxL051emovc0I4MzB4QytlekRnaFZnZ2NVNUJ5OWM2WXgyWExz?=
 =?utf-8?B?bFNPUWFWZnlielhucDFzOVJBUTV3Qms0cXo2dkQ1N0lna2Nka1hucmt4YUcr?=
 =?utf-8?B?cUd1WlVSekhtZXg0bFBSekd5MzVkWmM0QjVaTmw3Z01raXR3YXhKU1h4b0o4?=
 =?utf-8?B?MmU3QUsyalhKVG1lM00vQlBHTEx5a1NPR3JqdlBBV3FaMEd0djlGTmR3PT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 757e593d-23ac-40db-50ab-08daf8d02bb1
X-MS-Exchange-CrossTenant-AuthSource: AS2PR03MB9815.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 21:17:00.1129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB9696
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-01-12 11:44, Victoria Dye wrote:

> Matthew John Cheetham via GitGitGadget wrote:
>> From: Matthew John Cheetham <mjcheetham@outlook.com>
>>
>> Rename some of the variables and function arguments used to manage child
>> processes. The existing names are esoteric; stretching an analogy too
>> far to the point of being confusing to understand.
>>
>> Rename "firstborn" to simply "first", "newborn" to "new_cld", "blanket"
>> to "current" and "cradle" to "ptr".
> 
> Thanks for this, I agree that the new names make the code much easier to
> read.
> 
>> diff --git a/daemon.c b/daemon.c
>> index ec3b407ecbc..d3e7d81de18 100644
>> --- a/daemon.c
>> +++ b/daemon.c
>> @@ -789,7 +789,7 @@ static int max_connections = 32;
>>  
>>  static unsigned int live_children;
>>  
>> -static struct child *firstborn;
>> +static struct child *first_child;
> 
> minor nit: you changed "firstborn" to "first" in 'daemon-utils.c' (aligning
> with the commit message), but it's "first_child" here. If you end up
> re-rolling, it would be nice to make the names consistent across both files
> (could be 'first', 'first_child', 'first_cld', or anything really).
> 

Fair point. There's no technical reason to keep them named differently between
the 'libified' functions, and the actual variables for the callers.
I shall align these to `first_child` in the next iteration.

Thanks,
Matthew
