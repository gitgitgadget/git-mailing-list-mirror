Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831DDC433EF
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 13:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245243AbhLVNHs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 08:07:48 -0500
Received: from mail-eopbgr150042.outbound.protection.outlook.com ([40.107.15.42]:25732
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236364AbhLVNHs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 08:07:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qf644t/cDceKCq8QCnVpJ3+cJBugO8k8G7npwUEDDq6rjroLg8IJF46MThcxvXV2ZOirwhH9K5G7bH3w0jDlx1Di4mRJWeNBaf6JxqFXLCCIkCJGNen5Mq08XOjiKwRAXHFhMjhL1vM/bfNtgebHJmhuPG6WOLG1ujf+WHCI3kCX/NW4VvXKiUBY8/1XFdWycIr4qY2UoIwPImbnicdMtErP3QcjNDuOXH35A7IsyZvLXWPMOWpntGC5mqgF3dIPdA6dh/uZ0P/6b5Ha0pmHFB0+1HfSzKn9yUKJeF6QCx0WsEzfLqA3Nj6Y1dx7IhuKAFha3wgoOhbh6WxyeTvhEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KkTboZGZO5uce/dBw/m35zttWK97WYH3pxghAMCpyCE=;
 b=D1FSoKO/oYLpKBmmFHF4mOODaZVfwq0rwGF49EP5oAptxJMYmbCmW5cF0+jbix34tlEtoDhlCW1VIx81DsQkQnFsDVFoVeYEmmC5yuCS+vQQP5s5O7ZNbKKkPE0sS9vdT+VDSfKHg8wSCL7nkH5SenvqK2t2p3n+VsaVFdZJFUlC/6nDnRpJY51thU05TBoK+29DbkL1DlNtVE94rRwO2g2k/C3s2Wi7L0zt62gVGFzpxkCyyFQE5sjMtKNWZTCpNKa3c7u1OWxQ7Icyc8zew7eMT4rRhgxn5GbUnAZnwEaYxkv7MGTqFYNSYmvaJV5/4j/tLK3ponGjaJVWNVUO6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KkTboZGZO5uce/dBw/m35zttWK97WYH3pxghAMCpyCE=;
 b=Z7qMe0HK71qJe15ImFf/C+6oaOHJEK2/UOpawJWJHB8aIgT9N061lm0uVVrcQ7Bf6xVAPhsMlyINSyjFhRpfHwXAEYlFWtdeiquc0Ly+I6ez+5niJkmcTzuWPk4pqR4dMvX6bfk8haWz9rXz7IpSFM02ou8BQwnidUUfLLzFX+0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PAXPR10MB4752.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.18; Wed, 22 Dec
 2021 13:07:45 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::486c:1c10:65ef:90f9]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::486c:1c10:65ef:90f9%6]) with mapi id 15.20.4823.018; Wed, 22 Dec 2021
 13:07:45 +0000
Date:   Wed, 22 Dec 2021 14:07:44 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        jrnieder@gmail.com, jonathantanmy@google.com, steadmon@google.com,
        chooglen@google.com, calvinwan@google.com,
        workflows@vger.kernel.org
Subject: Re: Review process improvements
Message-ID: <20211222130744.4dmpa6joac2rc2vt@fs>
References: <YbvBvch8JcHED+A9@google.com>
 <20211217183942.npvkb3ajnx6p5cbp@meerkat.local>
 <211222.86ee65pb60.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211222.86ee65pb60.gmgdl@evledraar.gmail.com>
X-ClientProxiedBy: AM5P194CA0022.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:203:8f::32) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8845b2c-4493-4f65-bf5d-08d9c54c0ba8
X-MS-TrafficTypeDiagnostic: PAXPR10MB4752:EE_
X-Microsoft-Antispam-PRVS: <PAXPR10MB475253BD25D0D63F991ED3E3B67D9@PAXPR10MB4752.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dy0veYC5h1C/2nlcPqjpPF7hvAuAfIpAPRN59dboprfESApouZXLAEtQDSfcjOmjhLrq7TdeAatpKEKtEI0bI195uBNUeiNbQTCLYoQIM3KtQS6FdWS6txoLtjxbrvG0Y8ghYwzFyBAZv3Yi4xFd8W/li0YXilO9TIH0QkjePM5Wt1+TZKQ/Qcz7/gks+UDzCWZyFHxFsob21cm/bY/E3WRi/+M7ovsiv5WXDx9eVpzP6W8++CXlsXt1QHnpL8YH2dwGvHyxiGjykHogywF7+yTNg9yMHmsuYhoiYO5XIjpO//XNm2jifY7VQxrY/45q9ZXjnReOyYSl8ZeFiXTD1AtZjSBaDYACr0CeSOZ3oP5p5nuxtMrrrwQLZL0QEarM8oirRkc3YMNAaon5RP5HnEUpMRpScyhnw38fr5Dha6RsLsfp7ZpivTU+g10zK/aLNleW1/9XLZTO4TVD5FNqeJID5EtpgFYACbNp594a4fa4H7y8gmSLai7jku8ZLU7iEAZTZ8waO6wQhdpYw+IN5eVRv5g6f190eGToB02m08OZmvSmBTCY7S0V7qr71LN7/TicAkC65jC2UuQspv0AYxBmNx2wJX600uwpfFmql8ZkQmCOj5IBV4dkT3N4lpe/YVPIF9deMyHn8AZ0pVEyfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(7916004)(346002)(396003)(366004)(39840400004)(136003)(376002)(6512007)(6486002)(83380400001)(38100700002)(5660300002)(9686003)(66476007)(4326008)(3480700007)(7416002)(66946007)(66574015)(66556008)(33716001)(508600001)(8676002)(6506007)(2906002)(316002)(8936002)(7116003)(54906003)(53546011)(186003)(86362001)(6916009)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTZTNU14RUszSTduSkFRNi9IYWZpNVJIS05VWWFZY3Q4UEZZYWRpK3FKTyty?=
 =?utf-8?B?emhpTzN6SlJuTkU0TlgxMWUxTTNMVWFzNHFMeEFnbnV6Vi9zQVY2R2ttRjZo?=
 =?utf-8?B?clpGS29WVEpwYnA0a2tYLzZYaGNQS0lHcENsdmdQSWw3YWRoNDFNVTM1SFF4?=
 =?utf-8?B?dWNYT1k1VmFsNytTcHNHa3JiUlkrVEF6YkR3WGlpbGZpT3NiWXlQL0x3R2s5?=
 =?utf-8?B?K1BEbTJpSDlFTDNEbW5TY2JDa0ZQbTFKeit5ZHJRZGRZWDNEOHRDQVEzWU84?=
 =?utf-8?B?STJQMnVycXRZcWs1ckl5UWh2ZXR2THAwZVd4bHlyaHRaajU5S3F2d1dEcjBJ?=
 =?utf-8?B?ZU1uNVhHSU4zVUhRYWR1ZWYrUVNjWkFWQkxEV3pTdTMvVkgwem5WTDlMUkJD?=
 =?utf-8?B?bzcwT25WaC9wcTZNcThhNVNvYVgwVGFXRlg2cFJHYmE4VXNZeGVJeG5vRDBE?=
 =?utf-8?B?REJRRHZkcjd5ZEl1Tjk0aHJXdnhUa01EUE9JVHVxL3hRbW5Pd2tRK3h6MTUv?=
 =?utf-8?B?N3NUb0ZFWlNjWHhlb092TXlXaUlSdmM0b0x6bjR1MGdreGV5MW5tckhoZmZk?=
 =?utf-8?B?L05uYXNHbmx3NTN6QXNuNmxsVjYzUGFXbFRTYVlzNTgzV2x4K0lEM25uOGVj?=
 =?utf-8?B?ZS9IVUhNa0srSDVBMk8zRTNDWFRWbTZQcmRDYkJWbmQxUldqZVYrM0ovR3lH?=
 =?utf-8?B?WTlUZzJnYkQ3NWJ3dDJRd0VRaTJiUGJ6WldRaDVLeDgrczR5Z2FmNmgwenFE?=
 =?utf-8?B?emVaQm9nT2pvalRGSU5mRWlpTFprUnZTb3FIY2ZwWTJBdm1lN25jangzWm1n?=
 =?utf-8?B?RklmL0dXNkpGblNFT0RLWU9jdng4c01ZZEowUFFCaXFTSEtiekZNcjkrQWFN?=
 =?utf-8?B?UnExQWlUemZ5NE01ZFJ1ZldmNlZRYU9pMkFrUHpQTEptUmZkNHBBek5NZFdN?=
 =?utf-8?B?WlBRUC81RCtkTGtONE9YZlhVbVV5Nk9NTWxSNzZhUEFpU21mSm1iM0lEYk1l?=
 =?utf-8?B?RW1TMU1DQjdscnVvT1RielRPVTRBYkZBcjNEQm1oNU53cy9MY1JBa1BiTWY4?=
 =?utf-8?B?ZVB0Vm8yckFyd3BDWUdxYTRFY1QwWWJRR1V4R2tqclV4dkY1WXUrL2RtUE9p?=
 =?utf-8?B?ZVBnU1psWFpRL3gzRjVIV2c2aGNrWlhEYytzNDBiOFlneWkybS8raldINnlX?=
 =?utf-8?B?eDFFeWNneUxuYlNvVlRIYmo3Rld3MldrVWt0ZWdjOTdOTE04cHQ2R0ZMR1I3?=
 =?utf-8?B?MUlPRk93VkhNaU9HK2llenpyaHFEMGU2RHc5akpqSHdoUkl2eFdJQUU4Y1B0?=
 =?utf-8?B?TDRyMld2dDdKMWZ1TDRNOFl1cFBHb2dMY1hMNUxRaWwwbnVDK1d4SWxkSlI0?=
 =?utf-8?B?ZHp0Z3FSUUh5T3RkU1g5dEZUN0pPOTRPNkhZNVdMSDZPV21XOG1IaEtQQjg1?=
 =?utf-8?B?L0QwcU1sdTFTWVpnWDZJUFA1KzZaekR0bkpaa21mOTd5QXdRZWFlUXZ3UVRr?=
 =?utf-8?B?bVpDYVl2VU5wNlN0WHN6bGoxbjN5TG1COFpZWW5mbUhGaGpKWjQ1TTcxMzhi?=
 =?utf-8?B?dzVCaVZ4U3FxWTU3L2x3clcvOU9VOGtQSURJMXBPdEpsK3ZxeVZlQTgxN1Jq?=
 =?utf-8?B?enhtUnB6cS9FZG1iU1ZCSFlaWGxUZzRwVEdzN2dRZlI0a2o4ZlNLSDBmcGJh?=
 =?utf-8?B?MVRBeDI4bW9XQ0plU2NFaURYbDliQUwyODR1M1QzU2xrVUZ0MTYvdEZ5NUFD?=
 =?utf-8?B?NFZWQUtMUnF2ZVNQc1llWWowaGMvRWxET0x4cC9FbWtLMDArUkdPcFZEejRk?=
 =?utf-8?B?dHFPNHY0ZFdDajRlcE5YbEJQTTlzQlNaMHFnRE5NaHJHSHBMR2F5MHZpbEht?=
 =?utf-8?B?QzYxeWFyeU5weG45cUJxaXh1aUNiaFlnVFZKS0gyMldrNVMvUVRDY2JOdWhJ?=
 =?utf-8?B?bW5VRGhRbHFSRVlOaVp6QmFKZVJudWVyb3U4d2dEZDIyVnFrVE84NjNWbjA2?=
 =?utf-8?B?NVNxZHczYWtWMVQxUnU0OWN5bS9oRTZncFZkeTBZN3czTWJ0NUJ6TTgrQWhi?=
 =?utf-8?B?cHhTZ05QUjdRZU9ERjFKRWNieWF5NnAxQVhtcU12a2xieVI3V3hWZzk2c2JC?=
 =?utf-8?B?cmp1TzRLYlN3MnJhV28xU3pwZHZzcHhNYlpXdHZCTFdZcy9IQ3NoWHF5UHRs?=
 =?utf-8?B?L2RQOFZ2cFdSU1QxWDFaWmFaNTR1bzYrUHVnQnpSUTcrUGtBSWN5ZHNVbUlJ?=
 =?utf-8?B?NlNPQ1JKZTU1THA2L2ZSWXVXTklURlZjRURiWnNFZHJ0MHd5c3J6b2JCM0Ri?=
 =?utf-8?B?VUJ2MW5VUzFVdUlVakZwNnhLcG9veU9aNVdqcFBudktBdFZwdERyYXNhdjZL?=
 =?utf-8?Q?UiMzQEgtoLm7Ifx8=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b8845b2c-4493-4f65-bf5d-08d9c54c0ba8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2021 13:07:45.5630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VhNZ/u3FwMLELWX0hHzfd/XDdFNkv7OwvsQmucBXWljmMt0nJdYbCC3IUxHAkwYo1ALgGYzOgcLRtCovBHYVRl8CJuDeNaY+arAoQSgi9w4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB4752
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22.12.2021 04:26, Ævar Arnfjörð Bjarmason wrote:
>
>On Fri, Dec 17 2021, Konstantin Ryabitsev wrote:
>
>> [...]
>>    - on the receiving end, the patches will be written to a dedicated
>>      lore.kernel.org feed *as-is*, but also sent to the recipients after doing
>>      the usual From/Reply-To substitution and moving the original From into
>>      the in-body git headers (i.e. same as GGG does).
>
>That GGG does this is one reason I haven't considered using it. It
>breaks all sorts of E-Mail workflow assumptions from polluting the
>address book for every person who uses it, to any "from:<addr>" search
>needing special consideration etc.

I agree that this is a very annoying side-effect of GGG.

>
>Of course you'd need authentication etc, but is there a reason for why
>such tooling can't work more like an SMTP relay and less like GGG which
>(for some reason) insists on taking over the "From" header?
>

I think SPF/DMARC spam filtering will prevent tools like GGG to do this any 
other way. For GGG to be able to send with your From: you'd either need to 
give it access to your smtp credentials or configure your whole domain to 
allow GGG mail servers (basically github) to send email for it. I think both 
options are not really something you'd want.

>I think in its case it's because it wanted to mirror all the discussion
>to GitHub. But presumably a ML-native tool won't have that problem (and
>presumably GGG could do the same mirroring by following the ML after
>submission).
>
