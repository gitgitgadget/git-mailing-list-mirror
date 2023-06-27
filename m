Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F65C0015E
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 19:10:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjF0TKu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 15:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjF0TKs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 15:10:48 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89788FD
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 12:10:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+x76BsrW/Xxxq7RUJqIf2cyajXiUwGKaOVVJQjvXLEwv/SierKUfL+fSBpfBQXchZsbj62GZrF/bcHCYkDJIMj+dSEkHWq58iXP67rBGln57LwE2PvGFTe7Wu8pIJoVthk9f8uJ3F2iPPuSpapIIKfSufBntrh8Egu6zmqgzcLw6LeZy82TbB0Y08hdGyyptWHTrEV/A2Ei6up4do8k3E0Z8veOWNki+f89s2WcXGTBVATmUYdfeAXA4rvgLNzfHNDe9xUcCOesReZRc/8U37iO2E4HcdoK1pvvgvgzn/1IPN9ZTakGhYRjKR+8obkKqq5PrOpFsZpSUEjRRuXXfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/oA9y5yKoMlWVesHCAVKiv6YBhPj+0SOqFRiT6VUgs=;
 b=dag+SazH5/Brseb7cCcUI99d/JgcvJF07ckTFnIVbuukYofLk2ubuT8dktSwwoxM96dolcBGP71lQwb3p0QRkpPy4jxRLzGB2zVbabDO+7EUyVgAXcztWuZgl2/29P5daq55zTAsBtiRPWEO4GRg8nN0rb24TNaAu2TfbnB1XZJLizLjstX27qnAIJ7Q/mghfEml/KfZeGbQYSMQSVvUe+azfv2utNVUQexxDIFP/0wLu/xi3O3g2R98eHtA49W78m2h3d5XkHosRLalD1qaDNPYkGlOvJ1GfJKPuVCq401DewfDY3PemRy1kiqmf3DhtWasU9o2u6GzDDVmfxrb6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cedaron.com; dmarc=pass action=none header.from=cedaron.com;
 dkim=pass header.d=cedaron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cedaron.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/oA9y5yKoMlWVesHCAVKiv6YBhPj+0SOqFRiT6VUgs=;
 b=nfSeGD71Qph+nyi3OqDjlHZNFlqhTueqGIUElN2WStWNtEDbx7aQ++pXWeB2HeeNz/kAs3o8c9dISJCgJFDgjyg3b59K+TPbE0OydNL1oCO9EORQQRhrIsJBDhodNwIpksLCx6uOTtRenEQLY0mP2Kh7sGwNiBTrV3ptO7m8E/FaFWaVFzaHtRvMbU6vB4GciTJ/hxBUS0wqUqj5/LATMWPy1boVl38f+R/jvfbkdgriyBVNVolmpmW4xVagjRDyb7gk5FWMOveFIiDBjWU9djJwg5oNsRbK5EADEveHSD7xmKnMKj+6cvQjel5kvMNEeIGqoAd26P69WhURLaNkIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cedaron.com;
Received: from BYAPR20MB2758.namprd20.prod.outlook.com (2603:10b6:a03:fb::15)
 by IA0PR20MB5729.namprd20.prod.outlook.com (2603:10b6:208:437::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Tue, 27 Jun
 2023 19:10:38 +0000
Received: from BYAPR20MB2758.namprd20.prod.outlook.com
 ([fe80::90c:ffc6:cad4:993]) by BYAPR20MB2758.namprd20.prod.outlook.com
 ([fe80::90c:ffc6:cad4:993%7]) with mapi id 15.20.6521.024; Tue, 27 Jun 2023
 19:10:38 +0000
Message-ID: <4f28a9c4-b422-69b7-ccc1-2661d756d876@cedaron.com>
Date:   Tue, 27 Jun 2023 12:10:36 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] ll-merge: killing the external merge driver aborts the
 merge
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
References: <6e1b9ce4-e86d-fe30-e5de-27a3be57eefd@cedaron.com>
 <xmqqttuze2fh.fsf@gitster.g> <xmqq4jmzc91e.fsf_-_@gitster.g>
 <CABPp-BG-KDu0fAC=bydz9A56xguSmgwO6SFDdxZ8h=90qR1PUA@mail.gmail.com>
 <xmqqv8feb0vo.fsf@gitster.g> <xmqqjzvt92nw.fsf@gitster.g>
 <59b7a582-be68-3f7b-a06f-3bd662582a1d@gmx.de> <xmqqedlwhgf9.fsf@gitster.g>
From:   Joshua Hudson <jhudson@cedaron.com>
In-Reply-To: <xmqqedlwhgf9.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0001.namprd07.prod.outlook.com
 (2603:10b6:a03:505::11) To BYAPR20MB2758.namprd20.prod.outlook.com
 (2603:10b6:a03:fb::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR20MB2758:EE_|IA0PR20MB5729:EE_
X-MS-Office365-Filtering-Correlation-Id: 34753bf7-a974-45aa-788c-08db77423103
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Kd414qBSkyqrcmApBfqKea1/UqUhDKaDDmvvgwYAAhnR6ZB/3jHUy7kJWTtlVu11jNz+9ScTYAhlmmMm3PiYZo4u2uAX2Di/UlO2xcRMoPs7i3Oi2cZSsTPQ4FCUqvp6yhOl7htL2Qg+nlzCwVBcqBxAomi05ryWDD8JgXpfDVFpjSseKFM+Qy1vbbh+mWguprHs3/zmhGbkj9udN0VrJXR3+LhYO/a88r1r9HeP6sTP5R8iL4TYeoiRoIMoNDyWLz9Z+2McwbJhphR4VfkTv8YRkCCLSqFLOWal+kId9D0RXrdqv4zXOxJ9GTfsvgbuqOMewwibAhH4pEnFbQXCIynArI1s6fVdsu1Z2IOAqW9yE/O31ZD/IP+rNhXOP0xzz85rz1Oi4ypnBYSjCNv4avB19JS/IZMA37D2Y20HVKvSjAMER/SgOc3+hweKZJrF8W395md4vnrpCZ+1am+L2dxgvXT8dUDCDUpEJm7tf0Bf/FemX3e1RSDUSIwrMtAp2MQ+AqTRTVrRDsl8uMIviWnVmZB2Mazt/27FPWlKRKyEMxxublOJv7Ss1Iv4KfNDdf8PSYGHOzBZ4JUSFYryZVPFuza0y+rrhCv3rwVlTWHBunLwthfRXjtVWOZyHzkKFK8a2YwDVwOjInrV13mLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR20MB2758.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39840400004)(366004)(136003)(396003)(376002)(346002)(451199021)(8676002)(66946007)(4326008)(66476007)(66556008)(41300700001)(8936002)(316002)(6506007)(6512007)(186003)(26005)(53546011)(4744005)(110136005)(478600001)(6486002)(2616005)(5660300002)(2906002)(38100700002)(31696002)(36756003)(31686004)(86362001)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NU1qdGlLZzRzdjJtajREY2h6NzJqODRnZFVETFQ5NUV5cmJOQk9iWG1OcWkw?=
 =?utf-8?B?NWlNWWMvbEw4NFRHdU1uNUF3M3hnTGszU2tUYm9oU0N4K1h2S01EUWhQU3pi?=
 =?utf-8?B?Wm5RdkFhOEd5S2p6eUVwV3htN2JoNUZlWXA0RUp3SVFzOFA4TGJ2SWJUL09W?=
 =?utf-8?B?NjRvWEF2VHViU0g5WlRia1lmRXUwVzRUanJ4VlRxSXNTdmJXQ1hsTDYyM3Ni?=
 =?utf-8?B?VE84WVlBSXFsRDRUVldxZW9ZS0F4NEJVbjhMQUV5WjNxNDFGOUwxeHl5V3lk?=
 =?utf-8?B?RFF2Q0N5M0V1bXhHanZ0L0g5b0xLemRId2dBRURyc1BLL1d5UWVkRjUzVFpD?=
 =?utf-8?B?WjV6eFpPMFR3TXArbzJSR0FQYmdyRFYrT3Y3cUtLZTZ0cjl6bERhTHJMNHgz?=
 =?utf-8?B?UTNKMmkxOHZxMGFYZ0VrTFByV0djWjdoSGJwL1RQTm5nLzN3endmaWZnbTBP?=
 =?utf-8?B?SGszbUdMekhCRHFaTDRabGQyaDhQZ040bzd1Nkt5UlJYaWdVM1ZkeFQ2d0xo?=
 =?utf-8?B?TFhrZUdMT2d5ODBQcVVjb21TYTRVZnZvTklBYmdXVHJKdmJ4b1F2czhJSzN0?=
 =?utf-8?B?d3hOSE1yakRMNGpUM1ZNQTVYUnZsOEpWYmYvQm1SaGFLa0tFVHBDdEhUaDFj?=
 =?utf-8?B?eHkybWZNUWpybGl4eFhrY0drQ0JZS1RWcEhrWHBCODlmUmk4MHd6eTJiSTNX?=
 =?utf-8?B?RklYakU1UUNSaDJTZWROQldkRFoxcHQ1WkU3TER2VG5oV1pCVGxuRnBwODlI?=
 =?utf-8?B?Y1hSNWxSdmVtcHpLYlpFWFVDb3FxckgwcnBnR3ZZelBrdTMrckhheTRmSjR0?=
 =?utf-8?B?cDQvZG1ueWgwVEwzazV2NlNnQ2ZoWWx1ZFhGcGxnamJ2RFM2R29lQ0JDYVNu?=
 =?utf-8?B?REo2OVRWN2FDbjhleENzZy85RlA4VDl0SHY1Mm1obC9lYlRrb1lxU2xka1dp?=
 =?utf-8?B?WFBPeGV0M1VBek8wUnJkckd0d3dYTElhbTF2Q3NFREZZaFluUkpaamxSMXJx?=
 =?utf-8?B?K2xZVHJpeHM0RVlId09kcURpK1kyY0VvZ3pueUhWekREcndHUGFnaFJybHdn?=
 =?utf-8?B?NytYaUcrSjNzOXFXZHFSNS9Pc0NZK2VETFE1NW4waU41UnJ1bmo2SGg0VEtF?=
 =?utf-8?B?RCtEWnJvOEZYRUVVOVFxWWIxdkw1UlBxNUI4aldlUWUyUU9ZTTRPcHJWTzNY?=
 =?utf-8?B?WkQyNnJFbVI4UmNIYTBZQUhSZlpJVmo1ZUNsbW50YlYyNHNxVHpXM3Rza3k4?=
 =?utf-8?B?aWhXUUFxd0wreHRheGFHcGEyd2I2U1dTbWFMTGx6VjBNN0ZTRW01cWJNU3Zz?=
 =?utf-8?B?cHNvRVE2RS9lYTU5alNsT3QxdG02dTdTUzl6RXRzVVJkaUlha3ZNdTRSc2Fw?=
 =?utf-8?B?VjVqM2NsbW95bHV0NnNxV2dudlhFR2VtN3VuWTVGelF2NkpjN3Y3Uks2Mitx?=
 =?utf-8?B?ajdtRStjUmNCUDVxUnNzb2xkTTFYWnZFUXRrT0Y4cTlsRThkSTEzdTV5dENI?=
 =?utf-8?B?T1FtdU43Z2J2Q0hpT1N1Q0poZmo0VWo2UTVpOVUzV1UrOWpYOWxmNnRBTmxP?=
 =?utf-8?B?SUtlOGZBVUMrRk9MeWsxcXBFRDhrY0J3QW1qZnBOek1SSTNVV3JaWk5BTkEy?=
 =?utf-8?B?a0hYeVpXWkJYaHdLVjhzQjZsT1VqekdTd1dMRHNhVjdCMmFheU9rSXN4Y0R5?=
 =?utf-8?B?L215S3NEVTJmSmRhYkNEd3ZIQ2xkNlNXd1lmUVhCNW5VWHJkb3lQNFJrMTNH?=
 =?utf-8?B?MmpJdFZsVWpCcUtZMDY2b3NTa2YzQndoUUVGK284eDFVZi9MakJaL3hYUHMx?=
 =?utf-8?B?VjdmNjVwZWd3azNBM0pRVmMwdzNiT2ppM0h1UFlmdyt6SWQrTCsxQ1F3K0U2?=
 =?utf-8?B?VDdFRWc3SEd1QzR1YmVFSWVHWlloNGZGd1JmOGNJQnlZMytOMlJmOUhaL1pj?=
 =?utf-8?B?azRQVDd2d1NxdFRNSVNjK3NYM1Z5cDZqVGladEZFUXdET2xvUEZmaW5XSW8w?=
 =?utf-8?B?VmZZQU9TRWpkZTZUV2pSVEg5M2g2VUdxSDRSWG01SkZqVnVxRHcvWkpQMzVv?=
 =?utf-8?B?QlFXcTVwMzF4d0lSV012WXQ0YkZKZ29vRTFabnNLb2haRm5CcERWL0JsK29X?=
 =?utf-8?Q?ywKttrwizvWxt8A+mdCneTB7m?=
X-OriginatorOrg: cedaron.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34753bf7-a974-45aa-788c-08db77423103
X-MS-Exchange-CrossTenant-AuthSource: BYAPR20MB2758.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 19:10:37.8659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a1e0d90e-c09b-4bb6-9534-4bb03188f5a0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: shSDKIohA7KnMyjLWkBrhLgoRe0XSLoVB3WcbpQM2eBMYKYd9a9UgVeOhPVMN2w9Yokv7BiNc2I5kxGaoIsvRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR20MB5729
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 6/27/2023 12:08 PM, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> On Fri, 23 Jun 2023, Junio C Hamano wrote:
>>
>>> Junio C Hamano <gitster@pobox.com> writes:
>>>
>>>> Elijah Newren <newren@gmail.com> writes:
>>>>
>>>>> Reviewed-by: Elijah Newren <newren@gmail.com>
>>>>
>>>> Thanks for a quick review.
>>> Unfortunately Windows does not seem to correctly detect the aborting
> Sorry, I did not mean "abort(3)" literally.  What I meant was that
> an external merge driver that gets spawned via the run_command()
> interface may not die by calling exit()---like "killed by signal"
> (including "segfaulting").  The new test script piece added in the
> patch did "kill -9 $$" to kill the external merge driver itself,
> which gets reported as "killed by signal" from run_command() by
> returning the signal number + 128, but that did not pass Windows CI.
>
Do you need me to provide a windows test harness?
