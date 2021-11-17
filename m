Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D524C433EF
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 09:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1472361B54
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 09:05:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234770AbhKQJI3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 04:08:29 -0500
Received: from mail-eopbgr150088.outbound.protection.outlook.com ([40.107.15.88]:42989
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230064AbhKQJI2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 04:08:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iGTX6Jjhf+MXpbVIW9CYM2k5y0aYsjZ6aC3oYYPrJiuvwsJImzmMDBgmMDoGkKnp/CmBGXwgDDzZtm862PW12O49zc4lKF+Ma7WajIqW+qUTpEd2nBwKYGTRDQBSpTP/fCsy88dLZCwhUv7Zo6SxJ2+As5EuBUNyQdfW/Plti+kN+iIhqPL8Dfjy/g0Lg9c6z8m3EWtlVaXq+x7+NxW61X2uHZaVBsvfqde+OFQUaRz1Ku+T8MsVSncvmHigqKx20KNKbZy2krH2Xih2ly8P/ZmxD/oBbtcFvbMqDdfz5P6/3wVhzUHW1VhppiQrSh7swTuhACZr8U+fBnpmBu+J3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KCLnnMkzY0sKbgQBvzXYbWYbwGnh6oZ9YUf61c4EgMs=;
 b=X6q/hPUBqq3Xc5XiBnuugQ/GVF8uGOPTmN4aRNHTQ2Qhlk7rX+Clg+L9lUY4GKaIGO0t8g0itHCKlgFrbcmAGEbIvq0F9ejJHZlvW13jC8v2jtHPQnadHSryN29ft96Yh4UTSnVYD1Y1pfQYilb6Ul9V27d1yjAEdHChw0FKH3V0LXKpZKeRa60+enxe1KsuaQoUmuA6uW/KJTWsWLp/qFMLdRbp5Yp1zt7gFEzJs78/UexN5ogulT11GGZQNBRH8d/iLJ3s30oy8b6GNk9QRIBPoYx8IVLHm1IH9ZmSjir91A3S8ekVHCcWLXAahvoQDygf5RujmAZ01VOJ2UDqBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KCLnnMkzY0sKbgQBvzXYbWYbwGnh6oZ9YUf61c4EgMs=;
 b=ebJ6SYhcnIkPy8b5Z72jNLx/79UCX9Dw8fUtXc6EBUfPjKSFoVRNtNh2j7LYXzZAyHZo+cn9f6rgEjm0ZRPt7cJyxuZFiClWztM2+axXsD31p6vPvqs9WG/xNCqPYks4hz4/hO4psy8Kb/wkkiE4QWHQhVF2piNJXYJYEvJ/SBk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PA4PR10MB4559.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:be::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Wed, 17 Nov
 2021 09:05:27 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391%5]) with mapi id 15.20.4713.020; Wed, 17 Nov 2021
 09:05:27 +0000
Date:   Wed, 17 Nov 2021 10:05:26 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Adam Dinwoodie <adam@dinwoodie.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] test-lib: show missing prereq summary
Message-ID: <20211117090526.ldy5eonhbdgo2nyo@fs>
References: <20211115160750.1208940-1-fs@gigacodes.de>
 <20211115160750.1208940-2-fs@gigacodes.de>
 <211115.865ysts45o.gmgdl@evledraar.gmail.com>
 <20211116141938.gbaufny5o2boptvh@fs>
 <xmqqpmqz42kj.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqpmqz42kj.fsf@gitster.g>
X-ClientProxiedBy: AS9P194CA0008.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:20b:46d::27) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by AS9P194CA0008.EURP194.PROD.OUTLOOK.COM (2603:10a6:20b:46d::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Wed, 17 Nov 2021 09:05:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49b50c2e-3a4a-477c-927c-08d9a9a9660a
X-MS-TrafficTypeDiagnostic: PA4PR10MB4559:
X-Microsoft-Antispam-PRVS: <PA4PR10MB455978169D72541BF55F10F8B69A9@PA4PR10MB4559.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:324;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V4uPAELg0MK6iIx78NlRxxNErlMMv2Vpu/iursen0+nWYZnVtlN909Mb9pIKJ2+O0cMC4RuqPc7+PB9yU+Et56tarkYra6f4OvIdGsXF55L0yVngxhougnzyWq1Isyt7o6z27nE5q43Aj7GRwtDq1/K3Er5NATGOklOQWT9yFOzGDTKvZ++O7fzGVtdF8YFjFn5Bs0ZrHwg0i61AcUbqqUnUslj8WZ1QyfVzl6jQsyGupjGfAWZrZ0rGBKh5j4DL6jeoVhkxPEEA2IXjNR+h2TO1UHTkCRsc5ACe0la0xRC1Ddi3H/cWAbhmzz/H9gmcN1v5l0caLo6ow0jYNFUZHgkI7HhiqCd6S8Mkho1t2GH6qd5ZtmOFuBY79qf+OYuTo1ik/ebR45t4e/uya/mOQiOZf9PtuyqKKObjexjgrjtmMU32ja22Ct+rB3TTNNCnHR7tni46e+yXMbToqR2VOP19a0g/Fe3gzLjUlDCM7OJaBxnOYhRK8kDsjn9/IiyaQR/VRxbl6O7GZwkVpWuRKA8pQX4D8kn/xQr9fUNYFmzF4H0H7a6n1YIFnLtlDDc94uyHoDaM4Nw/ugwU4Fbeld3vLCY6s2hPwMi61tipUWP33+5gIZ87P17uqAQ7DT4uBpMLGU+0HXLwY2Q1bU2OaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(7916004)(39840400004)(396003)(366004)(136003)(376002)(346002)(33716001)(1076003)(6496006)(8936002)(508600001)(8676002)(83380400001)(66946007)(186003)(66476007)(66556008)(6486002)(52116002)(66574015)(53546011)(4326008)(86362001)(9686003)(5660300002)(38100700002)(6916009)(54906003)(316002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2gyWVNObHVzOWh3L1E5QWxvZ05iZnFpL3hwblV2RVAvOFdkSldtMEhWOU1T?=
 =?utf-8?B?Yk1iUFNzV01Ia1BBRGMxdzg1aUlRMWFteS82YUYvU0k1Nk5odTVuenpoZmdq?=
 =?utf-8?B?MzQvNGhIcllLU1Y0UmFtYnhvUlhFZlpRbmtXWi83UUpjd0h3bDlvanBVMjls?=
 =?utf-8?B?MWp2UWRHZHJoK0hNY2tTU3R0T2w4b1RkUXZING9RTWpjMnpaN05rTkFYdUpY?=
 =?utf-8?B?Y2xtRk16THc5M2E0b3dDeWhvUWFRMVh3MXVNcDZ1OE1HY3J2Q2VPOWswbTFk?=
 =?utf-8?B?U3FJbG4wUm1NNk1lUktUc1krUHM1YVNHaDBJZFlBeS9nWnBMS0FjZm9wVzBv?=
 =?utf-8?B?MFFGK0ZZMkpFK1NuME1SdXBrd3U2ZXJYeGlUaDkyNlh0VVBrWUJYYmFqZXho?=
 =?utf-8?B?QUx3WUJLdkZRZi9yRkFwNGhEelpCNnhWWGZ0NFE3enRLRmFzMFhKVzRIc2xX?=
 =?utf-8?B?M2t6M2lQNDg2MFJ1dUliN0pNbSs4M2Uxck1tdmNjYUVtM05kb0tKcnkwbGRY?=
 =?utf-8?B?VFRkeGliNFNxQ1NVaEs4eDJLaHNkOVo2Z1hrOG9BYUJBd3NncnYwWk56WXJ3?=
 =?utf-8?B?d2FXWWNEelRxeDZvYkw1ZTVIWFRZWEQvZ3ZzN1QramxCaDlCMFRlaUFjN0Fj?=
 =?utf-8?B?ZWdsc3J4MXJlSW0yUExzZWdiV3hZaEpnRnZBa0IrQ2dtUUU1ZDlLSTE5VWxm?=
 =?utf-8?B?OVZRWlNTU2crS2hLTHVMbEVBcTAzeU1jc21FbXlDYmpsSEJid2pZYnZSUVEz?=
 =?utf-8?B?d2FlTlVvcEU2Tk5TS3hCQ2ZlVzNGNEVTbUd0VmVHMlA3Z3VnZ2pGVlVvbDJR?=
 =?utf-8?B?SEU3WnhCYy9EQzM4aGljcnJ0aWhLc3phSld1cEI4dDg4WmVHejNQUDdIWTh2?=
 =?utf-8?B?OVBCb0QrR2gzZDlOK3JXOXJkZXh2dkJPMkhiM1ozVmdMMDk4czZYUUhCQkx4?=
 =?utf-8?B?aElzZ3FGVm5oUUcxTlJLdXg4UE03aGgybmRtRlpEZlZCQWd2VUpNSlZUQW9p?=
 =?utf-8?B?d3BpbGpxbTVLTmw4VkVJdlVBMFRaUmNNL0h6RXNMUmtBdE50VHJMazd0N1RI?=
 =?utf-8?B?TVljYy9XNU9ITHVTSm9jMU1ySktzN1d2b25VSjBVY0VDbGpjYkJaem1EeldY?=
 =?utf-8?B?UFJtbm8wSm9tWmFHSVFYVVpJbGtVZUtLSnBVR053ajNBT2ZKZXlsYkYxR09k?=
 =?utf-8?B?MlNFQUlocVpaanNmdE43c1Nma0hKbHJPemNnNm1aMlpmT0NMcVR3bGFXODc0?=
 =?utf-8?B?VCtwV05pTU5PSVZFSVVHSURWK3FBamRjNVQ4WUZrUEZSS2FMTHVMa3FnSjRO?=
 =?utf-8?B?Z1NYZ0oxb3dUejcvK0VZQ2NiK1MzdHpVOUVZcTlDTmZLTUs0ZlZLUVozSG41?=
 =?utf-8?B?REFUbUhxNG9QUUVreFVUT1JyT213TUl5aStrQ251RnFPZ2Fud2JraEVUOHEy?=
 =?utf-8?B?MFFaUlZxNjN1UzEwazJvVEtMd0NncFlVdTBtMkM0czFEKy9ldDZLRVJUTUhv?=
 =?utf-8?B?T2d2MGw2WW40QW1PcTdzMmRqc2JBYzlNNHByNStscGJ4Y3RjbzBBMGl2bk84?=
 =?utf-8?B?VU1wNWxYaXJYNWFKMjBVVmhhNWFHQ280eTUxdFYwQWtwK1hRY3RUbERsWFND?=
 =?utf-8?B?UmsycHNiVlloVklIMnVJUHZ5ODVLZkxmQ3BtTXFML0h1YWtXWUE1Q1N2Vm9t?=
 =?utf-8?B?ZnlHc21IVEllVVc5KzVsNTIybHBPMWhmVFhZREJ6Y2QvRmd0Sk80aGtPclE3?=
 =?utf-8?B?bVM2aUZCMXFlY3dURFlmRFU3MXZHRDFMaXQzOXNxL1FoSmJaVW1TcXM0bGJX?=
 =?utf-8?B?MWEzeDdNaFlNREd0ZVFHbnJ1SXNaY3dOYkV2aVI1ZFNwS1kwRG13V1ROMXF1?=
 =?utf-8?B?d0pjNE5XU2YxZ1JabHJPMWhOU3NHY09VckUwdkNCaFNEK2hSWlI2b2VBa0Qx?=
 =?utf-8?B?VlIrK0dFcWpiRGVHa1RQNWQ2VWpYb2UzSGdKeS8zU2ljcWlnQzBqSHJCQVhL?=
 =?utf-8?B?WitPQW1ZYXlYY1pDVUxOckxNTkFlVHdVVklIR1BxOW5Rd1VadlZxLzRvSjBY?=
 =?utf-8?B?b1hLZllNNHlJZjZxMERHNVQvMHZXZTRFenRKMm9VcHVIc00rZEIrUGp0Z2ZX?=
 =?utf-8?B?NWE1N0RuUXB4Ymo2Ym44ZDVyT1BtRmJYODNPaU4rWm56SVUxcUVkV2hNdmlo?=
 =?utf-8?B?Yy95U2lBa2xjRFE3RHZQazJKMTkxbUxEMHFxbktoWW5CTVlKcGNFSUV6bnFr?=
 =?utf-8?B?d2lEWUw1RUJ4dEJxUG84djNYdk8xSWMvbzc1S2oydk5vY3lrWmNTQytjMHVR?=
 =?utf-8?B?U21TZ0U2Yno1UzY2cm05UDBCa2F2NEs2L3Zmem5DanVFOWtXRkJ2M1Y0NnFy?=
 =?utf-8?Q?Ok4eaud8gCsYc2jg=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 49b50c2e-3a4a-477c-927c-08d9a9a9660a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 09:05:27.7087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rY4Tt9ex6P6tI1Ja5taL6t1kQPvdTkYTlgmHGG4431iBUUcStLUhYYjxWJYnm0LO/uxtx5cOmMRmRCXpSWzSr3fEYYgSYiYG4O3jdw9KmTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB4559
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17.11.2021 00:19, Junio C Hamano wrote:
>Fabian Stelzer <fs@gigacodes.de> writes:
>
>> On 15.11.2021 18:44, Ævar Arnfjörð Bjarmason wrote:
>>>
>>>On Mon, Nov 15 2021, Fabian Stelzer wrote:
>>>
>>>> +if test -n "$missing_prereq"
>>>> +then
>>>> +	unique_missing_prereq=$(
>>>> +		echo $missing_prereq |
>>>> +		tr -s "," "\n" |
>>>> +		grep -v '^$' |
>>>> +		sort -u |
>>>> +		paste -s -d ',')
>>>
>>>What is paste? Some out-of-tree debugging utility?
>>>
>>>I think you might find a better way to do this shown in my
>>>"ab/generate-command-list" topic, currently in seen. It removed most of
>>>the same sort of tr|grep|sort etc. chain in generate-cmdlist.sh.
>>
>> I've looked at the generate-command-list code and TBH i still think this
>> is a better solution. If I read your change correctly you've removed the
>> sort and unique completely since it was not necessary for the use-case.
>> In this case i think it is. Since we call tr with `-s` the grep -v might
>> not be strictly necessary though. Also in this case these commands are
>> only called once at the end of the test run and not in any kind of loop
>> like in the cmdlist code so i think this variant is much easier to read
>> and debug with a negligible performance impact.
>
>I tend to agree with you.  The snippet we see above is quite
>straight-forward not over-engineered.
>
>> I tried writing a sh only variant and this is what i came up with. Not
>> sure if this could be much more simplified. It looses the sort though.
>
>Fun, but I'd rather not go there, unless this is a performance
>critical bit, which it is not.
>
>Thanks.
>

Ok, i've sent an update fixing the commit msg typo and with \012 instead
of \n. Even if might not be an issue it won't hurt.

Thanks
