Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D734DC433EF
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 12:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380750AbhLCMXh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 07:23:37 -0500
Received: from mail-am6eur05on2064.outbound.protection.outlook.com ([40.107.22.64]:15776
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1352004AbhLCMXh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 07:23:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SsEotRdxvJ+/0Wc5Q9t17i2Co9gdDCwLWiT3R0X3ex9oDGZss25O2sI+IvdH6nTcF8FfprJmW+p1snDpl19uHFd8mlUTuJqGqI/DgS0WuGDtr0DQyHg9DuBsY0QIsRxnf91RrcVXFeomc040N2RODZ6P9EYen+nZHqUC+RBTHnJZvdOlwSj/+wh1yiQuPvyTedDpQEKKEJB6g7aIeavyXvBO5CZcWCMn+BhnEEiZqKBm29FQ6lEU2RTzxnDdS7MGABrAU/RuDEUwD972Gl8jzm/UxCORXJvzEAp4BpESazyIRhqw1jutjfORWUdUEChhhyaPDQOdY4oR6Joem6K/uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uR3i6jY+1iNPWKQmod0FECtpxKjnMHhzcBiY41Y9wZc=;
 b=GNa58G4z8cLX5nA7Xk9cCiHplHkMwOBCQSU7DFrEGw3GTsd6+LTWjYCHvbyMAU7Nu52sLoWcQwoQNonepqhDRrQ+txLkdNttryaGlgLTdCBP6wwR+qr8EGTY21SSD+CWaOdXiXsrwBkmVbvP5+fPZL4oX4Mbe8mUvs9xLLCKqT9+BKuPc0LXeNS5c79wKVNelFUqYZ+qd14hi52W6iZ+PELvTxxMr3Ey2ZRxwgu6XV4dEpBnKg45P4L3cLGIrdpv2phkqeF8ig03zqWjpe/ayXddYv4HN89FYsOsmnCyNNNRQ5i9WhR8kI+pKtW+P758Tv7ZPLu/hRrT0GbIN43wDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uR3i6jY+1iNPWKQmod0FECtpxKjnMHhzcBiY41Y9wZc=;
 b=CMUST/Buxu8Nendj2ggRGb0Re+2vzrFEYkl3AI6WsxNGSjwSPsvNn6Sq5YOFWUoGV21j5h96Fl+bAloFbPPvG8Sd06T6jkdPgnySIyXe9xU7EjrUaWEUpPQS10XAIAVqQ7+K8CKq9UpMfD3vFX7oox2SJtfhSg0fXnbj61sJF40=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PAXPR10MB4784.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:151::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Fri, 3 Dec
 2021 12:20:11 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b%8]) with mapi id 15.20.4755.014; Fri, 3 Dec 2021
 12:20:10 +0000
Date:   Fri, 3 Dec 2021 13:20:09 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v4 7/7] ssh signing: verify ssh-keygen in test prereq
Message-ID: <20211203122009.lvuz2w7xrp7yapcw@fs>
References: <20211117093529.13953-1-fs@gigacodes.de>
 <20211130141112.78193-1-fs@gigacodes.de>
 <20211130141112.78193-8-fs@gigacodes.de>
 <xmqqczmfyi44.fsf@gitster.g>
 <20211202093126.nuuvxjnhbkdu5pwn@fs>
 <xmqqwnknue3n.fsf@gitster.g>
 <211203.864k7qszy7.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211203.864k7qszy7.gmgdl@evledraar.gmail.com>
X-ClientProxiedBy: AM6P195CA0014.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:81::27) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by AM6P195CA0014.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:81::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend Transport; Fri, 3 Dec 2021 12:20:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c228cab-ad08-4059-cd5b-08d9b657404d
X-MS-TrafficTypeDiagnostic: PAXPR10MB4784:
X-Microsoft-Antispam-PRVS: <PAXPR10MB4784401B8DD2FE0C304BC8A0B66A9@PAXPR10MB4784.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +P2kirZP/y6ze/pD3d6xT2xUwVDsb9WutSOgXDVQ4w8IrB0rlcYaBIwSFOwiSIy09f03SNUXod4Y2ltYIpGCqUMzswvgov00W7bwr4mYeNjVX5e9zfBNcFDqlAHyRF/mhHqd4XQFhcAI/neK9yi0xRH6kWgkWNSHpCpxaVoygygEAxXibY3HSRY4/vpyv/AJfRXI+A1MUFM44hHbfofCtvrXMZgZ4NtFTH7gYtEmm4DHCYNb4SXLVFmVjIux44FxZUgcJd44yI+YndtyqJwRBPe2Ng9QsNadl7nfJn/ov+zArwKtk+ZjTg7u+jHULyUNdhhCHOU9TIwfHMl3BMs1ztNa4AWjAeadTiU0EVKDouCx2MdfkNCYXQXWbJVIxSALfFlV7fRnaWVvB2ka7Psb5fACTXFqcpmRYTSluYtC5pgyYkTVacwt5opRGpemoPeBlcOHveop4UpEn3iliIhwph3ccejk3vH8pQI3H43qaPtB9LHRCSRPKMcfec6mptqyHqYyf27b0XlFU6vCGVShF7BsrHgDV884F5h5jt9Mxpquwx816OLr/rHmeFPbf8L9EIqQECVwfggxaOsl0zlNTi8GttNk+JdkdctxgOf0To7tqfZrFCucphv+i8L4Y93MhJMnlVJW2ZX9N041e5MpKZIA3WjtzX5d+gaOJMDuo3L/69EDCePNj+IZvVShRLubvtj3QXUEuZzQ0pHEgZKLE+Vsbgmga3WMAte1HlMGxWs7GzK6dvKyMEQK1U/ZtAjJrBSkIC7O67YMxbFcPJT4On3+VWugFNf7lvJFhINCvww=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(396003)(39840400004)(346002)(376002)(136003)(53546011)(38100700002)(4326008)(186003)(83380400001)(9686003)(6486002)(33716001)(6916009)(5660300002)(66946007)(66556008)(8936002)(8676002)(508600001)(1076003)(66476007)(966005)(66574015)(316002)(2906002)(86362001)(6496006)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXpCSEQ0SUFHbFpiVGZ4dmhYSnlPOXNhVVZaUHpML0UreXRmd3d6dVJLOGJa?=
 =?utf-8?B?MW51b1dENEtzT2Rudy9XM3gzZ0UvV3BjUmoxZ1lkczJ0eUZkMGdVQlc0SUh0?=
 =?utf-8?B?alBxcEllaHZWYlFaNVE3S0hhbUtkOHZMM3VVL250NnBreXdBVVY3UnJZNnF0?=
 =?utf-8?B?bHBXUWV4MDdKVHlWZ1pUNEF4S1Yxc3YyNHNqbjZuOHEvN1owbk44K2hHRmRi?=
 =?utf-8?B?b1BPRUVHcXFta1RPa2pwWVlUTVNPYWMvT3pLa1d4cjFrMlhhaHhHeU1UUTNR?=
 =?utf-8?B?TkxoaVNPTXBvK2dYbDNNaDVvdFNHcE1pNEEyeXlTMFowZGMweG1Mb3FuSEpj?=
 =?utf-8?B?bFh3a2c2OTZ1OU1RV0tjeEVyRDlHNjcrUlFiZWJOZUVZakJxc2NTQVM3ZHJv?=
 =?utf-8?B?OU9JOHMwWTY1ZWV5MjBFblhqYlFlbHp3Z1o3N1lJajFsTjk4OFVOMy9IL1Rs?=
 =?utf-8?B?L1RtclJpWjRYWC9lU1JTNWNZTTc2cWRlSi9GTlV5aU5halRUKzFWV2NXTEVB?=
 =?utf-8?B?aTJCNFh3TWRRamt2MkdUb1pLU3g0a0JTeFVKNnJrcjlIUm9TNnVrbWkyS0lt?=
 =?utf-8?B?RjJSYTVyQlpML1dvNWowMllHSmg2NG9tY3d0NjZ4T3VmWkNEVlFxKzY4U0Nr?=
 =?utf-8?B?L29nOURZaXVoUEgrTitZVkd2cXQvcTUzbm8rMTBMSGZtYTF5UFlhZXdNcjNE?=
 =?utf-8?B?a0ZudUNiVlBFY3QxakU0QjFMRThJWjZDT0QxbVlnMnY3eExoc0c2SE1vV01Z?=
 =?utf-8?B?SVY0Z2p4NThIcURTOEVZS3FiM1ptNHRYSVBKRWtkK3VjQ1dJSUZYa3dndTU3?=
 =?utf-8?B?RFRMT2ZhT3YrelJ2NS9rSGtsbnVaYlEyeFFjYlc1M1ZKOUs4TVNmZmI5SUZJ?=
 =?utf-8?B?T1l0dEJLZDVybEYreGs3MmxPdkVnMDU3WjR5ZGwzdk1oLyt2bDNpMTVnZ1VN?=
 =?utf-8?B?cXpqU2k3V28zSFF1N3BSTVFQQVV4Q1VuMFR4VDJDSUZhc1lHMnZQUWFrM3Ft?=
 =?utf-8?B?cUhvQ3haTTI4Q0lSelV3ZW9NNm9Gd0RlNXZJSzZqb20yd3NObWFiSFNQR0lv?=
 =?utf-8?B?UnRKZ2R6TlBDZXpDdmhJSW1nYmxhM0JCR1pqeFBhTERBT2h4Q3l3dngwT2c0?=
 =?utf-8?B?K0JqSkp5QjN0WHZsRzRmaGp1OFBiOFhJelNZL2JYYkFOU0hXNUlDbXlnVGpD?=
 =?utf-8?B?WXU0TmRWbmpuSzlHaVJlT25XVFBoOTgzeTB2dVN0RTUyMGlIRGZNVUhMaGd5?=
 =?utf-8?B?bGw3blI0endTSHc4T0V4VHl1akV0QWtXWXlWTWF2ck5pb3VZbzZNRGxHZmI4?=
 =?utf-8?B?bDlhRXNRcXRya0xvS3lOcFl5aENicmlEenNHSVh1WEZXSU1zMytVemxyMUFl?=
 =?utf-8?B?Q3JVUWJsNkErWWRzOE9JLzFSaThKc213cTBlUENaRjhxOHZ1dW1VRGU4ZFh0?=
 =?utf-8?B?bGtJVDNVZ2J6QzhFeEtPQXp1WmpFZ2hCNUFEbUptUXZRd0hpVXMzZW10d3BN?=
 =?utf-8?B?SlZ4MUN2MEp0QStNWVpPdC9mS05HdG1FZGVpYnhaOGNUQmc4dUtOdHdlNVdv?=
 =?utf-8?B?MDNIbm1vTVA0bnYrYjNYekQ1cW1iMC9nSUw3K0tQZEJTamYxc0Y5YU9IR25X?=
 =?utf-8?B?dkh0L2Z0TVUvRnFIcDRvVC80M3hmdldVSXdWUVJXbVJDT3dGd3NqRFQrM2Iw?=
 =?utf-8?B?RFhleVBkTk82Rm54bk84Y29ENGF5WDM3OGNubVhGUHdhUVMvc1o3endzRGRN?=
 =?utf-8?B?b2RCZmV1cXJJRzdBaGVCNkIvSFRqQ084RXNKY05GYy9xZDhNRU1EbEg1NTI0?=
 =?utf-8?B?K0xMc2o0M3NLeWtzY2I5THpkajczYW01N2xGaHlIWjFFMUs3bWo0UlJSQ0tF?=
 =?utf-8?B?WjRZZTVabjlpdmhyNi9OYTBHbmN3WGdSdG5zVGZkWURIb2VMbXYwM2FpZHpE?=
 =?utf-8?B?MmxRQkhMbktPNndvMGF2Vkw0SUhnSU1ET3kxM0k3dFNEcmxKSkZOODJTZldz?=
 =?utf-8?B?OXFoUkhLZTdqdkVySFdvcnk3ekdRd2s0dzNZbXhVYXFoUWFGRUk5SkQ4ODR6?=
 =?utf-8?B?a3cwdEppZTB0VitZb1F0WldGRTRTSURFTGRObEZUNER6eHZ6b2dYNGlmWVVK?=
 =?utf-8?B?ZjdLeWFaQWF3MmhmUHgrcjcyS0F0bkI0WkUydkxkMVVQVWpOZXl2NWN2NDl4?=
 =?utf-8?B?Y1NFb2JvYU5YQnpvVndmRnZ0TWhHM00wV0JSVitKd2hhNTIwZVB0ODlKMzJx?=
 =?utf-8?B?Q0Z2Tjkya2oyUjdrOXBRVGxjUE1ERFZxeFdyQWNZNVdzUlpQRnliVkpTZ2cv?=
 =?utf-8?B?Mkw3MC9hMGxXUnVaUE5MVnJET2RZYjRXOFAxY1BTN0VySGR4OWZtVFA1Slh5?=
 =?utf-8?Q?uDDgrSPqhZr8PwNA=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c228cab-ad08-4059-cd5b-08d9b657404d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 12:20:10.7921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GMPs1smMCkkBxdchSf85A78ZLp4xOp56C2k3PgtykyEqm661M59llUAi/5AdeCH3j422ZD5ZTjbTlTJY2le4Zj1lBKEmsd+nNgLNtz7Bwwc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB4784
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03.12.2021 12:07, Ævar Arnfjörð Bjarmason wrote:
>
>On Thu, Dec 02 2021, Junio C Hamano wrote:
>
>> Fabian Stelzer <fs@gigacodes.de> writes:
>>
>>> Yes, that looks good. In this case the conflict is rather trivial, but
>>> how could i prevent this / make it easier for you to merge these?
>>> Especially since in this case the conflict only arose after a reroll
>>> when both topics were already in seen. For a new topic i can of course
>>> make them as "on top of XXX". Should I in the future rebase the
>>> "support non ssh-* keytypes" topic on top of this series and mark it
>>> as such? Or whats a good way to deal with things like this? (besides
>>> avoiding merge conflicts altogether :D)
>>
>> For this particular one, my rerere database already knows how the
>> conflict and its resolution should look like, so there is nothing
>> that is urgently needed.
>>
>> If the other topic were to be rerolled, since either has hit 'next',
>> basing it on top of the other, essentially making the result into a
>> single series, may be the easiest (and that is basically avoiding
>> conflicts altogether ;-).
>
>...but to answer a bit of Fabian's question: Just as someone giving
>these two topics a brief look it's not clear to me why the existing
>GPGSSH prerequisite needs an adjustment at the same time as adding a
>test that uses it (in addition to existing tests).
>
>I.e. was it that it was always wrong, in that case I'd expect a patch
>that fixes the prereq and doesn't make any other test changes in the
>same commit as [1] does.
>
>Or does it need to be more strict to cater to one new test being added
>in the same commit, but that strictness doesn't apply to existing tests?
>
>Then maybe it should be a new GPGSSH_THAT_NEW_REQUIRED_FEATURE, which
>can in turn depend on the GPGSSH prerequisite.
>
What [1] needed was another keytype set up for some tests to run. I could 
have done this in the test itself or in a separate setup function. But since 
all the other keys are set up in the prereq and we might want to reuse this 
new ecdsa key in other tests as well this seemed like the better place for 
it.
A new prereq depending on GPGSSH feels kinda wrong to me when it would just 
create the key and always succeed otherwise. I guess this is a side effect 
of using the prereq to do setup as well (something that we discussed in 
https://lore.kernel.org/git/YYXAwxmhrLLMBqa+@coredump.intra.peff.net/ ).

>Which, incidentally would help with any textual conflict, but more
>importantly makes for clearer end-state, and maps prerequisites to those
>existing tests that need those specific things, and not a more stricter
>& recent requirement.
>

The problem here was just that I also refactored the existing GPGSSH prereq 
to be more readable while doing the same for the new one. Only refactoring 
the new one while leaving the older one just above it untouched would have 
avoided the conflict but would have needed a follow up series. In the future 
I would probably do that or leave the code as is and refactor both in a 
follow up.

>I don't know/think that any of this needs re-rolling, just my 0.02.
>
>1. https://lore.kernel.org/git/20211119150707.3924636-2-fs@gigacodes.de/

Always glad for your input.
Thanks
