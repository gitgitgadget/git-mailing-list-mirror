Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9C7C4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 07:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E266860F8F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 07:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234209AbhHCHni (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 03:43:38 -0400
Received: from mail-eopbgr70040.outbound.protection.outlook.com ([40.107.7.40]:20590
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234137AbhHCHng (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 03:43:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YF3uQB45hqI6iHun236op4zcUaAeymnD8a0Po/l4TWMre3qq5eQspu05zgTKsJyDNQ+tWduEkX9axJYnKZvvnlfldDFNlwRmkCtjCXkAJdo4BGt/SUZf4dhVeg4mbsnjPUU1lCvG7yPhBMKRWiGEQQ7uB6x9caEeOpFpY9sUnuhZbNUH/QVKXE6CYqd51Rj4kmo7neJAbC8YqTUMvP6gWhw29mMS8McIaU8KV/A8sy1+9HyEEdrjuGVQcxHgW4ddu+dTNqJjPoqfufY0gB/m+W8lhRHMRFmZUwcACP/wQ7u04Xy72Wt5j3bpFrwEiSO4sk5VQKuqACnGc3cPaeKm5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6n5kW4MmivVEauuVQlTOBiGvQprW7K1uCOtoiDoEico=;
 b=hk2RrUt3aNb27C4r7H25cpOG9RFmnN9UakdVykqyBXPcBeKZEplWNrj80A7ZD2fB07UJglOr0rWvwGnq/Hggm6n9CA1veb1oz1wGhmDNche53DU+94vws6XJdpFxE14Ign1JY/WRGC4lDnLl+wZ1oQzKdjlmktHGq+zI5gvv1x5H27AfugerrjjhGBna11aafw/ru1xxE7jBlrji15SQDniiHN/R+VeDcFI/Vh4XAhKvxvhn2fRADIJAy6Y0NMMI5HFNRQNJVyx+r8LZV+IhbKg7FPqSn9ZrHWXb/JcDYyW2p1W5RAyhZbA3QjeMhjivxFgkzTVWPYibXj4Or9v5vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=campointnet.onmicrosoft.com; s=selector2-campointnet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6n5kW4MmivVEauuVQlTOBiGvQprW7K1uCOtoiDoEico=;
 b=OB2+t8gezDSlxOVDCYsrOpgZJH2gqm7dcGPmKww20RdNCha6JlbBvy1jm+fHLBxsalIQtJM9jv//QyJTGc3WsosODkJuDa7XXkgQmPU+upEZICHcC7Vq/NYj2OgA5GW4w3NatC09e6cAWc+fnNffh/FNjXekfmTwS3ZS55n5hg8=
Authentication-Results: tilde.club; dkim=none (message not signed)
 header.d=none;tilde.club; dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB3771.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:47::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Tue, 3 Aug
 2021 07:43:22 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d8f3:d5f9:226:e9aa]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d8f3:d5f9:226:e9aa%3]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 07:43:22 +0000
Subject: Re: [PATCH v6 5/9] ssh signing: parse ssh-keygen output and verify
 signatures
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Jonathan Tan <jonathantanmy@google.com>, gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, hanwen@google.com,
        sandals@crustytoothpaste.net, rsbecker@nexbridge.com,
        bagasdotme@gmail.com, hji@dyntopia.com, avarab@gmail.com,
        felipe.contreras@gmail.com, sunshine@sunshineco.com,
        gwymor@tilde.club
References: <725764018ceb5bcecc748cc5169d4305ea9d7d23.1627501009.git.gitgitgadget@gmail.com>
 <20210728230452.2719333-1-jonathantanmy@google.com>
 <d4bda019-bbea-6645-e46a-18a702d3f0ad@gigacodes.de>
 <76cc0f7d-90d9-18bf-e749-feff8e584453@gigacodes.de>
Message-ID: <91adff99-5f56-643d-e328-472256dc60a1@gigacodes.de>
Date:   Tue, 3 Aug 2021 09:43:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <76cc0f7d-90d9-18bf-e749-feff8e584453@gigacodes.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0006.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::16) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:ea:5820:600:5dc9:1fd2:e8fb:a1c8] (2003:ea:5820:600:5dc9:1fd2:e8fb:a1c8) by FR3P281CA0006.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:1d::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.8 via Frontend Transport; Tue, 3 Aug 2021 07:43:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e3de614-3009-4d74-4881-08d956525e70
X-MS-TrafficTypeDiagnostic: PR3PR10MB3771:
X-Microsoft-Antispam-PRVS: <PR3PR10MB3771788A308AD5F323563356B6F09@PR3PR10MB3771.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dU/bAozu7AqdluyA8VvhwysOQA/9v7oHcLvINlHYMnj6pR7nyzrN2gU9FoNQeryFZguujH9YKGvX8lrp/QuFbFM0r6I/aukGSD1oQQVID7eC72MwjJFhdtlLzWxQRqR7+KngYtj9Tmph3mIc6mccffVg1FqtzuZjTfyEiQGyRNQtVOWiL/ZkNi6YYAANN0PnvqjhDJEAMIbZSX7jt18yS9wwwq2EtfUcOe08+vo7rM5xqBsgfpLqeovdSc4RxBlGU1QE9tlt4sVjg5NlHyqPpROYvsRnXe+VY1jTdXn6s0HZC/bSgoF76sbNDNAlZAQE9yahZi/0xet2VsMoJmPXG4I4+2rR5hKLkaOsz07zOSKOPN3TCHZAubnHNfBY+nQvVS9AiruJ7DXIaGvbuxpTIUWJehmfEVycsI9Y+zCG8Umxk+j3PdnvqO+0cNEkUEevXTnrTTAqcabPWU5thVnrxGjk1yr2bLwt5lw21ecT8mLL7jjNSOe6erCKWAOl0P8dRbPy3RCfsfNlPU4tluFNIXqbs120/oiD5otFleLYWi90/wJBXyRLklqRXnVlIzon/2+YRC/vU38c+OSqnEVQjegaNF2+HsQMyaIiJ6zlFIv8nBydA5jZYxAKOUQOcsIBe0p2OT2Oyf5mnDpXxNuonkTKDfxJQKYl651eaBPmQ++stj3phrQE7GpM2CSxH4KNkenbPuKSUbcTh33/Rqk1bKf/pAMZUEQpNbDCi+y6/M0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(6486002)(15650500001)(8936002)(31686004)(52116002)(31696002)(7416002)(316002)(36756003)(86362001)(66556008)(38100700002)(66476007)(478600001)(6666004)(53546011)(2616005)(2906002)(66946007)(4326008)(83380400001)(5660300002)(8676002)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3lMTmZYUUgvenF1THJNcHdSc3NMNElJRGNpS2hkTnphdTZVMDJYNmNxdnh4?=
 =?utf-8?B?YWpseDJQTC9JdmZSTVU0STdWMlV2SVZzb3lxMTBKUllUZ0FVdW1lalZERDVB?=
 =?utf-8?B?aWdtS045R2cwOW1Kb3IyVWM1NUtZSE1PaFFWQXR5Z3dBLzhlZDZ0LzZ0bHBJ?=
 =?utf-8?B?clYrNTVtVHNQckVLZ1lMbHRrcmNvVUowV0RLZ2xQQnBJUUpGeWd5Q1pSSTRV?=
 =?utf-8?B?dWgrYVNlb2NHNDV1UXduQlNTYzNMNVdMWXI2UzhEdXBDU2llL25hLy9HSXUx?=
 =?utf-8?B?WFRIWkF5UkcwL3RNTWo2cFFZeU1Va3pvYjdPVXBHUXl1YkZ6NEtUY2FMelUy?=
 =?utf-8?B?OWx5UnBCSnJTakxuajhjSWdNMk5vS3ZHUStaWlpld1E1QWIxTFR4VWlBb1lY?=
 =?utf-8?B?ZzZJQnR1YXFWTnhGQnNPVEIvUXNMeFErdHlZUktnaWh4YlE2cUdsank5N2o2?=
 =?utf-8?B?bmVWQS8vOTVySjBqdjIraDkrLzRpblluem54cDQ3Uy8wb0hHVW9iS21LNDBY?=
 =?utf-8?B?SmpJSlFvMDFuc0ZjM0cvcmVUNForQURiWUZFU1o3RDJ2R0NsY1V3WmVYOTVr?=
 =?utf-8?B?dVQ1bHh1c2FOZXNFZThQbUlEdXNjNkMyajNvRnRKMVRDNnE1REVGM1V4OVBH?=
 =?utf-8?B?dEJWVVlOUGx4NnFpbGRLd1FqNHhzMy94YXNWU0RBdlo4a0YzVmpSa2dPbjZP?=
 =?utf-8?B?aWlsTmNBR0hZYnRQck9xVkdpMEdQZmlGUVQ1ZzJqaUNTWCt3NVZqVlZuUU1F?=
 =?utf-8?B?MHVCUTRISVdKMldYc0NpMzFVLzNJZ29TRXFyU1NETUNVL2pDcXNjWEpEYitZ?=
 =?utf-8?B?djRGd2h4R29zRmZlTkZqQUNhK2p6RzJwa1hvb2czK1lJclhUWXVBamE3K0Iv?=
 =?utf-8?B?UDNsYW42WWhJNVp4ejFPNytBWE1NMElFQXFlbWZyK0NHSGl6QVN5d0pENnZC?=
 =?utf-8?B?anJYMEJmbE5uTWYzVThGNG5oL3pmcmVDMUVvaVlER1BDU2E3cGVLblJRd0xW?=
 =?utf-8?B?clpwUzJucEhvT2ZNQmVTM3ZhZGxxMG9CY055MHpOTUMrckJPWUhSQ3AzdENJ?=
 =?utf-8?B?ZGFUMlIyM2RCaEpZWEFzM056Sy9Lc2V6dEFKUWkzcTU1em5aU2JnYW5uTEpn?=
 =?utf-8?B?VmdDVWVSTUh4eUlnQkhicDVRZmxKQkFiUWFLaUN1OGFMMjNvbjd5TUJ4Si8y?=
 =?utf-8?B?NGRLT2FyTFViQXRvQ2p1a295dTBVYkhDWHRPTm9IcmUxNXdpNXFFS2FaQnND?=
 =?utf-8?B?ZTVuenBkM0ZJY1drV2I0bEgzWVJQMURtU3BKcUp0RUdSdklXSk9BQ1J6Q0ZZ?=
 =?utf-8?B?L3liMkQrVkhIL2R6ZkFlM2VkL20yK21YWmk1MTB6cm1PSFhaTEhVUTBJYmlY?=
 =?utf-8?B?UTBKbkxRem9tRHBYc2JKdDlSVVRqaENQNUFIeXc0YTlEdEpNcmdNZXlaVnZt?=
 =?utf-8?B?NXY2R1RFV3Qvek5RSVJYZU9iTHpRL0Q1L1BNZWRMYVBVb0Z4Y0dBUUZaSmVh?=
 =?utf-8?B?SkVMSW9IbVJyUEhFY21uRVhUekIzNzRud3hLOVoxTnhlUXpYWHNGbkVVeXVH?=
 =?utf-8?B?YTl5Z0RHNkViS3NyNXJnV2ZUTFoyeVdOSEQzYStxN1FTaUh4TW55NDdBaVBG?=
 =?utf-8?B?eitia1lReEVubmU3bUozb1N6ci9BaWR0VnJqMHhnckN3Q2Z6bE5ieGhDUzAw?=
 =?utf-8?B?VW1NV2g2TzhlalJsR1hKNnFDZzBQV2s5UlE4TmdTeTliajUyb3RLdE1XOW5a?=
 =?utf-8?B?enFkWFBDVEVXQ3hzT00vOHlUR0xFMjllN1poc3IybVA0ZzN3RnhjcmV2WThi?=
 =?utf-8?B?MjJLV3BwSlY5Skc2ZktSR3V5L044OTYzWjMralNQd2JlR0w1R2JFQUVZcUha?=
 =?utf-8?Q?mG8Jl+xXJIy8h?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e3de614-3009-4d74-4881-08d956525e70
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2021 07:43:22.3430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UnkGZEvMKHAdwOv57Kmk4zNNO29L+Z0LsNsk2SM83F/V7u9yZpWuHi7FRtgVeOXQ578L1FXcAaDvD+yVqATeaJGKCqlnw7q0q5UJ96gGyiE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3771
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 29.07.21 15:52, Fabian Stelzer wrote:
> On 29.07.21 11:48, Fabian Stelzer wrote:
>> On 29.07.21 01:04, Jonathan Tan wrote:
>>>> to verify a ssh signature we first call ssh-keygen -Y find-principal to
>>>> look up the signing principal by their public key from the
>>>> allowedSignersFile. If the key is found then we do a verify. Otherwise
>>>> we only validate the signature but can not verify the signers identity.
>>>
>>> Is this the same behavior as GPG signing in Git?
>>
>> Not quite. GPG requires every signers public key to be in the keyring. 
>> But even then, the "UNDEFINED" Trust level is enough to be valid for 
>> commits (but not for merges).
>> For SSH i did set the unknown keys to UNDEFINED as well and they will 
>> show up as valid but not have a principal to identify them.
>> This way a project can decide wether to accept unknown keys by setting 
>> the gpg.mintrustlevel. So the default behaviour is different.
>> The alternative would be to treat unknown keys always as invalid.
>>
> 
> I thought a bit more about this and my approach is indeed problematic 
> especially when a repo has both gpg and ssh signatures. The trust level 
> setting can then not behave differently for both.
> 
> My intention of still showing valid but unknown signatures in the log as 
> ok (but unknown) was to encourage users to always sign their work even 
> if they are not (yet) trusted in the allowedSignersFile.
> 
> I think the way forward should be to treat unknown singing keys as not 
> verified like gpg does.
> 
> If a ssh key is verified and in the allowedSignersFile i would still set 
> its trust level to "FULLY".

i dug a bit deeper into the gpg code/tests and it actually already 
behaves the same. untrusted signatures still return successfull on a 
verify-commit/tag even if the key is completely untrusted. my patch does 
the same thing for ssh signatures. i'll send a new revision later today 
with all the other fixes.
