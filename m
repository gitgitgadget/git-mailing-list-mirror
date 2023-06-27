Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D16FEB64DC
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 21:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjF0VOn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 17:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjF0VOm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 17:14:42 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2046.outbound.protection.outlook.com [40.107.212.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294EE1727
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 14:14:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6Oz+oozvwLXKBFsYbsbXP9M3EkN/RalSpDCz8qcWAgS36KMaNT2EaTB1DA1NeRulMbi/8A2ls/+nroA+U1kLhlkHPqruifnydiOc9SRHcAIgZdliNVvyVPiEi6yajoYO42V73GzvKC+q2uPy0cJVsNgEKVRMD5v90ooI5wUlAxDJppe2OzbD5rrxNjaRtKk6p2C0sgVhBjN6qP5LRqsJr/RnZNqNkvtqMWLhTD6PCRZFOHxl+VPMPa7ciSQrWSrBweYpZQJRWW8uHdNSAmeKdHqF+JGIA9+5DMnNcv2+SpVQzB6eCz0nKEOuVaQpLb8tNUQRRtJlkKQF+IamRMZ8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aaFvKyPBuCVHay/fww7KeBu7qc93sqf9lnn9WulotHM=;
 b=g9a7khyCP0PyTf01A+Ok2gWP97D/HNUDwk3N/2j8afALeFJ9+Z/m8QEaFwon1Ua1tBwuRdnYQHq3R9tGi1ojRctyg27cY4ULr+ZKQPGD02ZTpNfJnPbeLnigGoi90dKWOTZDUvKURjRWAclsJh1pgdAbWZmb/yod4mK6Voqitce5G4YE9NgtfEWs/Jefddp247g3dE72AH9CvqcSLuUlYAii9F8u2+DL1I2x8tEF/qW1YBFWJW5MjYZITTUZdjt0/BwxBomPBDP2R+U71rqHbbx1cdVjkZa7wipfwuGzewa7zwjnsFAE/z0Ys6fhN6BC8GqzMxF4q/Aar6mnuHbbUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cedaron.com; dmarc=pass action=none header.from=cedaron.com;
 dkim=pass header.d=cedaron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cedaron.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aaFvKyPBuCVHay/fww7KeBu7qc93sqf9lnn9WulotHM=;
 b=klesBY7/6DHz1ig3ekkfYBXNURkU7Nhda2aymd1vJQsPbi5RhtfPpFbe1xPFxUjL3ZO5Knm8Qa4VST3Q2LyUsz2U9L7n/dKDNN4dAMJeWqYest0lvo3ahBSzi0syegi+K2Eu75GmDZEhLjFdE7aapojUZJm7AHSI8EOQ0tDxJQ3MSirNeYIh/2x8yOJfj2dnfIw1f1+WX7cz7VLh5ap3RVnekLRMOK6xiZvfRR2EeFuebvnCnYhrTXZpfQkC69RuSCCElhjGLCOJnZN982cJmV7Kf5S0onx1gOJhtR9+dyw4eef0yuF6geOavkdZaf19x5+ttQSuoKRbu6GWJxTy8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cedaron.com;
Received: from BYAPR20MB2758.namprd20.prod.outlook.com (2603:10b6:a03:fb::15)
 by PH0PR20MB3704.namprd20.prod.outlook.com (2603:10b6:510:20::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Tue, 27 Jun
 2023 21:14:33 +0000
Received: from BYAPR20MB2758.namprd20.prod.outlook.com
 ([fe80::90c:ffc6:cad4:993]) by BYAPR20MB2758.namprd20.prod.outlook.com
 ([fe80::90c:ffc6:cad4:993%7]) with mapi id 15.20.6521.024; Tue, 27 Jun 2023
 21:14:33 +0000
Message-ID: <cd5046d4-d66c-9dac-87e7-cdb638124170@cedaron.com>
Date:   Tue, 27 Jun 2023 14:14:31 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] ll-merge: killing the external merge driver aborts the
 merge
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>
References: <6e1b9ce4-e86d-fe30-e5de-27a3be57eefd@cedaron.com>
 <xmqqttuze2fh.fsf@gitster.g> <xmqq4jmzc91e.fsf_-_@gitster.g>
 <CABPp-BG-KDu0fAC=bydz9A56xguSmgwO6SFDdxZ8h=90qR1PUA@mail.gmail.com>
 <xmqqv8feb0vo.fsf@gitster.g> <xmqqjzvt92nw.fsf@gitster.g>
 <59b7a582-be68-3f7b-a06f-3bd662582a1d@gmx.de> <xmqqedlwhgf9.fsf@gitster.g>
 <4f28a9c4-b422-69b7-ccc1-2661d756d876@cedaron.com>
 <xmqqttusfz9b.fsf@gitster.g>
From:   Joshua Hudson <jhudson@cedaron.com>
In-Reply-To: <xmqqttusfz9b.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0087.namprd05.prod.outlook.com
 (2603:10b6:a03:332::32) To BYAPR20MB2758.namprd20.prod.outlook.com
 (2603:10b6:a03:fb::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR20MB2758:EE_|PH0PR20MB3704:EE_
X-MS-Office365-Filtering-Correlation-Id: faec47a3-6f7c-477b-ab79-08db775380ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dzHon2cnKP+pB/4GBfQfG+Tf2JqWGNZ+XYfdV/Cs5mntslCD9CLrhvmlpTVzoOr8VJg/ttC4/8IOkT0AETUIxkum2VLetAqhqxNIfgv0M4TflcDCRdLa7hjv3j9sOjBoE6eeNhxzd2kBaEvkzBUqu2q9rhIm1ZJHQDb6oLh09R151qJzpyIu0cnLjIa0KOsNIuGcqHhVA0BZD8psGTIk4DEqu3pA2i4gww59B7V1zrXhaFhd8GyZlsyd0ldKsThgasXJ62oRp7RlnuRzQrpf1i8WZ63ZFJotVHDxrXCto99OY1C1Mc4alScAU0hD4rgTLt/2eYauo/5xBMX4SYhVVZaRvfoaCnV1M0GZ7yHSb/7npqsPzlV8fR+QhjyPEzOWTpdqsUxgZJ0/SCTdYZkcDh9/lljIXTxgGHBGU+LSveKNOnOKmwvk/9UXn3rplGM00z9n8Rud6KfiRUdGE5ikhOrvL/CeKbVQdKyVBufpgX7ksoGxq2VrHMcH6joU6pEevt+1zzoNwxRd/kxlKqGt66mve1w9467guZB7YRFKt4hRjr6nIaQ7Oa5NDXQg4MK0WWu6eOGbt6561yMVo4IswWIB57dJ3fM8vy+gabC5mZ0oxFaLueVtq5eCLEo4mRgCeUrc/D3vsfyAjnQs3EdAhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR20MB2758.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39840400004)(396003)(366004)(136003)(451199021)(53546011)(966005)(6486002)(83380400001)(54906003)(26005)(2906002)(2616005)(6512007)(6506007)(478600001)(186003)(5660300002)(36756003)(38100700002)(316002)(4326008)(66946007)(31696002)(66476007)(41300700001)(8936002)(8676002)(66556008)(86362001)(6916009)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzhsamlCWU5ON0lBSXVFS2dUZyt3YjNTR29WWnowUU95V1RXZitIcTVQZmJG?=
 =?utf-8?B?Wkk5ZnZLL2hXS0paZWdkbnNDc1UvMmRUM1RvbDFjdGwwZEFSNmRKOFBxYjF5?=
 =?utf-8?B?SXR6ZjV0MGdNVXJic3phendBbnMrYi9aMmhNcTFneGV4OGNONTZ2WGtQTTVQ?=
 =?utf-8?B?K0ZxbzlhQVBwc3dzOUszM3RZR1hVUFUrRCt3bHh5R3Rhck1KRitLYStadTlC?=
 =?utf-8?B?dU1JZ3JyS0VSMTZBWmFRbEVKbE9JaC9DU3hoczlWVm5wdE5HZThpWEE3UlNO?=
 =?utf-8?B?QmFZeVRHU3I1Q1NVTy90RWs3b2tMdFkyQ3NmWERtMXNPUFNlM0NKMjVNREts?=
 =?utf-8?B?S1BLck00M0d1Y1k4d056M1RvbWlSRjMwWjZIZkYreGt4WFpXS09pNWY2dWFa?=
 =?utf-8?B?cDZSRW56UjlwZGZPUnM1RnRpYXhDU1RrRURJaHZnUDJaMHlMSnVjUFRIUTkw?=
 =?utf-8?B?bk9PR3lCSkxxNUl2U1dSdFBydlBibzdocXg0S0dMazJpMDRncmhjc1lMQ0c1?=
 =?utf-8?B?S3IzV0xkTjZUaDM3aGlPZkkzaTA4MmZpRFU3Q0prR3hKd0M1RG5FVGsrOHNr?=
 =?utf-8?B?QzE5Rm1XeUR2bFluS0w4MDdRL3d6MEIzVHFjSUp3QUZnVnNkOVhhWVVJYmJH?=
 =?utf-8?B?TTZ5dWtMZ01sR3QxWnpwaVVWdVpOMkp1T3NoclRHNG9OQkZSZFcyUHZKL2lz?=
 =?utf-8?B?bFpzZkhCTGxqdHl3c01nYlVmNDg4TVlRa0NZVjdoUmRzWTg5cEROZjIzOUJl?=
 =?utf-8?B?eFkzbDJtSkt6U1I4UnFjTUpVNVdZc2hlT1JRSmszYjNuemJxdHI4MEZnR2RN?=
 =?utf-8?B?clF1T3BLUlRvK1FJa2srNWtGVDczTzI5cS9DSFgyeGZPYm81bndybjByTHJk?=
 =?utf-8?B?bmVRZ3FoZVMwZmE0dm11ZlFXeUJMYmZlWE5WbUkvbWhTSHdzQmxRUW5ibitx?=
 =?utf-8?B?UExWSUszVEo5VUtKc0FTbmpVRHg2cDArRjg5TFhnMnhLYVlEdXRNcERFYTNm?=
 =?utf-8?B?a2RXNWx3eWhVN0ZrZHJXRTR0L2JmT29kZFl0L2laWm5SL0ZmaEpURDk1OWJY?=
 =?utf-8?B?cGYva3V5TzAxajQyVS9TY2hWWTZuWGpMeHZjeGRINUZCRnpHQmk5T293TWpv?=
 =?utf-8?B?SEprVTd4Uk9kLzdITGM4L2haUEFlek03WEhPUlZBK3pOZStkNjZlOUhCTlZk?=
 =?utf-8?B?QXdyOEdUN1c3a0U3eHVaVnpiTUMxZlVhUy8vZkh5NFZodWl3V0lZZWgvK1pm?=
 =?utf-8?B?azdHc0RweUd6bGdnWS9XcENrbEZtUmhGUmpmSVNROUZiaFJxNFVFS3ZBQVZh?=
 =?utf-8?B?ZjZlZGprVzhIVWxMenExVHJwalVhcUJxNm05dXg4L2s2TWR4WU55MzVDNzB0?=
 =?utf-8?B?V2VtQ3BSV1o3Q2JQQmtHU0JkdGZKRFh4eDBZR2kzd3k5U3ptclVGb1RENXNk?=
 =?utf-8?B?ZHdBc2JFYml2K2x5YjNLcXNUM1MwT2s3QzJWbHVDT2lFVVdiMmk5QkNieUZI?=
 =?utf-8?B?Z2JueVY1R2NRdFllMXI2R2hWV1ptOWhvcGxRSGRiMmZWL0ZSNmwxMExxbENN?=
 =?utf-8?B?eXgvWDFZSFFub1dobGx2UzE1MlRJTDRHY0RjQ2VOeVlmaFFocExyRENFaGw0?=
 =?utf-8?B?RmRHRitkLzRQMFAwczJma083UzlxajdVeHpSYjVwMnNCMjYvWEY2Mkw0SE1h?=
 =?utf-8?B?djJzYVNyTTdoNG9DZ2pSWHJXQlBmbmErMjE1Rk9xekk5NUlkZUIwcDF6R0ZQ?=
 =?utf-8?B?UjU5a0pDUkRUczVPa1Y0K0Q4ZVhxSTBUU0dzdFNDZ0xPQjdKSUxPNFJvTWRR?=
 =?utf-8?B?MWFPeWd6cXZHei9BUUo2UlZ3YW8rUFRuYWlaWEErSzVxZWU2N3VPWE1sT0tn?=
 =?utf-8?B?Vis4UlJSTVgzWktveDIwRUx0VXQwWlNLa3JIZUdPM0ZyM2lBRi9IYjBzWis0?=
 =?utf-8?B?cG02RFI0bUI3RlB4anNRSzM1K3Y1Z3l2dHFaTTFvdVFVV05pbWdLNk0rMjBD?=
 =?utf-8?B?ZkYxcjFuNHh0dnJwY3V4YmQxYVpZdnZHUlFhaWNZVGtxY0wxU0M3dGdtU3Zx?=
 =?utf-8?B?Ri9mMDdsTDF5Slk5U1dOWGxpR1ZMdFZ3QmFMS3NqYW5rUnRRM3NGY2NkUG8x?=
 =?utf-8?Q?DO9Da4uYDxypsmZg3QIL255Ce?=
X-OriginatorOrg: cedaron.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faec47a3-6f7c-477b-ab79-08db775380ab
X-MS-Exchange-CrossTenant-AuthSource: BYAPR20MB2758.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 21:14:32.9894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a1e0d90e-c09b-4bb6-9534-4bb03188f5a0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e8B0JhPyv6HRZvATv3VSiCtJMCyJXgLtrUZssJNv/7hLzwdce50ZjFT4ajYN8dx7GiJFy8khXSFgzk2GtgGECQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR20MB3704
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 6/27/2023 1:04 PM, Junio C Hamano wrote:
> Joshua Hudson <jhudson@cedaron.com> writes:
>
>> On 6/27/2023 12:08 PM, Junio C Hamano wrote:
>>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>>
>>>> On Fri, 23 Jun 2023, Junio C Hamano wrote:
>>>>
>>>>> Junio C Hamano <gitster@pobox.com> writes:
>>>>>
>>>>>> Elijah Newren <newren@gmail.com> writes:
>>>>>>
>>>>>>> Reviewed-by: Elijah Newren <newren@gmail.com>
>>>>>> Thanks for a quick review.
>>>>> Unfortunately Windows does not seem to correctly detect the aborting
>>> Sorry, I did not mean "abort(3)" literally.  What I meant was that
>>> an external merge driver that gets spawned via the run_command()
>>> interface may not die by calling exit()---like "killed by signal"
>>> (including "segfaulting").  The new test script piece added in the
>>> patch did "kill -9 $$" to kill the external merge driver itself,
>>> which gets reported as "killed by signal" from run_command() by
>>> returning the signal number + 128, but that did not pass Windows CI.
>>>
>> Do you need me to provide a windows test harness?
> Sorry, I do not understand the question.
>
> FWIW how "external merge driver that kills itself by sending a
> signal to itself does not get noticed on Windows" appears in our
> tests can be seen at
>
> https://github.com/git/git/actions/runs/5360824580/jobs/9727137272
>
> The job is "win test(0)", part of our standard Windows test harness
> implemented as part of our GitHub Actions CI test.
>
> Thanks.
Try changing kill -9 $$ to exit 137 # 128 + 9
