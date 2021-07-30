Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6A9C4338F
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 14:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80CC460F01
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 14:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239301AbhG3OcV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jul 2021 10:32:21 -0400
Received: from mail-db8eur05on2083.outbound.protection.outlook.com ([40.107.20.83]:39434
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239042AbhG3OcU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jul 2021 10:32:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aVWr+WXSYB6bwufhU4+SAFePgUyWC4sQIQBpJK3+SeoDJc/scKTh4lOe/8ObsDaAUXweyPJCOGQsMxIPTkoudHFXwYUHaib3JQf895jAB/gzF7fV3sjwBtYMrsuDmBBIZnLiB9b0BAmLRupOdykRjx+TVsGai1CuRNQ4m1I919zQ2qvXsWNi81402fEnZJEG0B9XMwStJzM1b85Dqqn0ov+scvOUVacHKzE9AdRKrNekmxU/Pl3Pe6QkDPMAMzN78IFinD2Nq5tD5Cf1TwgDJrBnCavQ5NxatWPPM3yY18Lc83gVkqOa7qpCBt/LvvOOpXAmG89DMjhSQ5sE+264gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ld9LUvmRKvH+HLcKf4xpuPy3H2RDNmNKeqYbmw5yuhE=;
 b=oDw15eiNJZPO+sk8jAh5F27ITOCHyphQMJyqrjNIyuQVx63ylEQWVhWoxfUBrJRhKJT8GgeMFi8iUqi7xZXbk4iDlWPb75oDjGD7Tp2AfOJV5Vkrm7GQ1NecL5fmHtiRLyJwJMHm79YZIr7sKAgcIIoO3eL/DUJY5woD1wSEfeVJa48d8BGMmgUPuEA7KjJ4OrMkr6O1LOYuV2078TlRQAhdix4U2AoK2FvzDoGre/XuGpFiHBXKymq7/YwSiW5JIKCoQ/+ZCgLG1NUl2uk3MOTvdty8z0qhoN0rKesmTAmfSOO1VdtXKFJLMK8dH1sBUzn1ebG8VwkRJ/nYTOq1qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=campointnet.onmicrosoft.com; s=selector2-campointnet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ld9LUvmRKvH+HLcKf4xpuPy3H2RDNmNKeqYbmw5yuhE=;
 b=Bm+nvqYSg9NHtkw3e/KnJ7ZXiZ7NRyMffwmFCYbLPlgY26gcpA68vbr+8uvZwk2u9KvRKaNm3el+3lGVz0VQHKMOUj7TVuNzzMDVwiriB8z3LtoW5ysdYblltGIrlhv9h2q7MOa5aBiZsyblqFrzcBZ7KaAmoI+rAojFVR1R6rk=
Authentication-Results: tilde.club; dkim=none (message not signed)
 header.d=none;tilde.club; dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PA4PR10MB4590.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:101::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.17; Fri, 30 Jul
 2021 14:32:13 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d8f3:d5f9:226:e9aa]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d8f3:d5f9:226:e9aa%3]) with mapi id 15.20.4373.025; Fri, 30 Jul 2021
 14:32:13 +0000
Subject: Re: [PATCH v6 5/9] ssh signing: parse ssh-keygen output and verify
 signatures
To:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Junio C Hamano' <gitster@pobox.com>
Cc:     'Jonathan Tan' <jonathantanmy@google.com>, gitgitgadget@gmail.com,
        git@vger.kernel.org, hanwen@google.com,
        sandals@crustytoothpaste.net, bagasdotme@gmail.com,
        hji@dyntopia.com, avarab@gmail.com, felipe.contreras@gmail.com,
        sunshine@sunshineco.com, gwymor@tilde.club
References: <725764018ceb5bcecc748cc5169d4305ea9d7d23.1627501009.git.gitgitgadget@gmail.com>
 <20210728230452.2719333-1-jonathantanmy@google.com>
 <d4bda019-bbea-6645-e46a-18a702d3f0ad@gigacodes.de>
 <xmqq8s1o4zn8.fsf@gitster.g> <039a01d784bc$e92568a0$bb7039e0$@nexbridge.com>
 <8b8fafad-0c49-0d17-b8f4-3e797a3fc9b6@gigacodes.de>
 <039b01d784c0$518b7440$f4a25cc0$@nexbridge.com>
 <ef39f1f8-9da1-25e9-ec30-b7023705b58a@gigacodes.de>
 <03a101d784c9$0cb413a0$261c3ae0$@nexbridge.com>
 <30489b9f-8bbb-22c3-bd36-95f430a45ba9@gigacodes.de>
 <001601d7854e$e0d24960$a276dc20$@nexbridge.com>
From:   Fabian Stelzer <fs@gigacodes.de>
Message-ID: <6f5f654c-fd5f-a8a5-acdc-14e24f6843c6@gigacodes.de>
Date:   Fri, 30 Jul 2021 16:32:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <001601d7854e$e0d24960$a276dc20$@nexbridge.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR07CA0105.eurprd07.prod.outlook.com
 (2603:10a6:207:7::15) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:ea:5820:600:5dc9:1fd2:e8fb:a1c8] (2003:ea:5820:600:5dc9:1fd2:e8fb:a1c8) by AM3PR07CA0105.eurprd07.prod.outlook.com (2603:10a6:207:7::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.10 via Frontend Transport; Fri, 30 Jul 2021 14:32:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e616339-ccb2-4d9f-b270-08d95366d294
X-MS-TrafficTypeDiagnostic: PA4PR10MB4590:
X-Microsoft-Antispam-PRVS: <PA4PR10MB45901D8382881A89EC60572AB6EC9@PA4PR10MB4590.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O2NA8E1pyIiHpPA7AaC3yoDEeW9RAoTvmaEpA9ayoLyf8TUDkQcsmas2UDLCKYFAvdQk+/H3FMLgUdkTe/QGthEymiDtrF9XqcaC/wZq1QLFfg7/ibHIRdLDe7cqztzbTme4EFxBaZU4m1LwH/KCf0lj1jQrU03qzhsOdGRPIV69iizIPdm1DFam4GqYMk1CEm/m5uKYnvOp+cW1WxaQMvSVpzClb1nm4qcIEIU3XkdvlkXTJY6oYuZ2I5I08u4mIBVtkLGSix5Xs+mNXByILCGI3KxdKwj4ZCmzD/8VwieybH/6np2mxOl9mN7vUt4sf2urz18v3rCqJXMaO3xZuUfLJ+wac9zIGXuLY8qMSvB4jeQBSmzy2xwffktAFYB2DXn7udtUPAUueCWsztP0dNORA0VUfQYWGtLyKU+A8J33bmkC1ADZAY+xjmwTUL9bVkwv1N2EIcNCi5X76V++Upq2d1vhmEy2O1Ky+OwTORTCNLVaSvUn97lgo4e8R5hzTOKnjGgnFcugao1KZBVhV9+QoQ06YuciQfhp7ST+mm4rtNYxvPCQhZPzBT9NLrsKUH3RnqVcOumkRp2qfVGimPE0YOvV/UysR540M+NS/O0Arpe6xqaqf4D7wPZwtsLzHz7NkkIKTMtR7iltQFMNVz45yoSMuWEzpv7gNDW3GLmJ5rbkq7GRcuU/vAD+jO8qaYS4Ajel2hNLOQ3d5rIEA/NPq7chAD5GpDOrFYnJDQ78UvU2cxCzAKpdYNvfMErG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(39830400003)(366004)(136003)(376002)(8936002)(52116002)(38100700002)(31696002)(186003)(66946007)(53546011)(6486002)(83380400001)(66556008)(15650500001)(66476007)(2616005)(478600001)(316002)(2906002)(8676002)(7416002)(110136005)(36756003)(4326008)(31686004)(86362001)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDc5M2ptNndVNnBoQkRTQWIwVmRkWmExMjFBQTA4Z1BsSUQ1L2h1NmlXRnQx?=
 =?utf-8?B?dkwvMStIeUQ2SjhBNkU4OHM5RjZqZkJob3FHeGxXcjAxYTBlcU8ydjJtRW1q?=
 =?utf-8?B?cHF1b3RqbHhtQnlDTlE1RU54eXo4QlJQQWE5S3VUemNRYWpEVWE3YU1Bd0o0?=
 =?utf-8?B?Qm1zbVB5Q2c1a3NiQTdSaEFPd1RtNVBCS21RV21adVhlNWxuRWV2UzZYcm43?=
 =?utf-8?B?dk9WZnR3ZVBrdUdrTllrbkZhK0tuK1BVZ29SNktmSGlZVko5WUJrbkR1WW43?=
 =?utf-8?B?YjB6OHdiemhzMzFZb3RINHNQTXJ2UDU2YjN4eDZ1dVlFU3I3Y2FMVFlENXdC?=
 =?utf-8?B?TUdNczl0ci8vZEFwWjNOTXhWSjdXbzNGaEFDNmVvMEptSU1qSUlmQjl3cDJ3?=
 =?utf-8?B?RXF6Mjg2YjI0MTJDbUdHcUhCZEpBOW9jbDBDYjFiaDgvbmZSZ1hxY0pDTFA3?=
 =?utf-8?B?SXlydWlhaFlma2FYUTU4cmNOZzJoaTVDY2NBUjhuK3A2OHNlREV0TVd3OFIv?=
 =?utf-8?B?bnVMbXNtMzR5aWx4WXhNSDVqemRxUjFKR0hkZStTcCtFQUJkL3VYMGZ0SmlM?=
 =?utf-8?B?VVZ1cWp1Vi83RnFQUVRBWEJHL2xOZ1RYMnFUazlOY3VIYVF5WEx3RVNtQUpq?=
 =?utf-8?B?ZXQ1M1JWNFd6Rjd4ZVQvWDhiREF5a0lUZWszY3lRY3JURUtZZk1HSlhodGQv?=
 =?utf-8?B?RHpHcXY5Z0Y2QXRTZEhaY2lhd2xBTGVPVGQvc29wMHBSNGZvdFluT1lVZnNP?=
 =?utf-8?B?REFBTmcxcGNyZzRGZGdrMzhNVHB4ZlNCOFRtaStGbXd0Q3RqTEVaN1F0SGhq?=
 =?utf-8?B?VUJ5Q1pndmVwUU0wWms3UU5QcnBiWHJHK0dOMnZXcUgxRWhqM0hsekhkdXdv?=
 =?utf-8?B?VEduZllHeWNCdUhnSFVYMktYaVRGYTJtcVNtdXV4K0VZWEx6SzFkZU1XL2M4?=
 =?utf-8?B?ZmZ4eUFrOTZRWE9MaTJSek9CT1R6VGZQbEV0UFJCU00ycksyMW4zOFN2TDJT?=
 =?utf-8?B?T3VFTGd6RkN6dXNjQm1UKzVxTytvR3N6blpIVWxQcTV2Q1J2SUdDL2paYUxt?=
 =?utf-8?B?N2RKMmg3N3FMZ2FlcWlXL3ZNeWQ1ajBWSmpWblJvcFdQaEJ1OVBFRCtvYWpU?=
 =?utf-8?B?anZQb0w1Tm1uMlRmL0l2YlpubzJBaWtoV2JKOW02RFJTeHN5RGl6bHI2WEMw?=
 =?utf-8?B?VEZmaW5SbWxBcU14NlNNYjZhSGxrczRlM25NV2lCUG9Wd2tlVHZEdmh6Wk40?=
 =?utf-8?B?b2hqaEpid1ZtbW5iTzN0eFVmSTFwMGVBZlJ0Z01HZVhHQnZVVmhIZ1kwdFlB?=
 =?utf-8?B?NFgrR0pzNVpsdzVKNTdjd3RtVGZjUTFkOTZVeUYvaDdhTWVucStCdHJIMzZp?=
 =?utf-8?B?NWVUSkJybDdhbkpxeXM4aXdmTHlXQ2h3Z1UwaEFPYUpONEdBQTFMZW5qLzE0?=
 =?utf-8?B?RU9MSGYveEc3cExWTXdoSXByMlVjeU1PaVNlTXpuOXovUFZTQTRxeFN1aGFv?=
 =?utf-8?B?K3dRSjAvUlpsbUg5RVpabGNxai9ObkNCNnZ6VnZoOTFjYW5Ob1krcGpvQUZn?=
 =?utf-8?B?RlVjTm1jRmVIM2hkWkF6NzJUNGtmLzU0YzFHZlkxV2RpTG9qY3IzZ0FkZXR4?=
 =?utf-8?B?eGZyaU0vbmhKSUc5TEYwcUF4QW42eVNBTjJpaGx1eUNaWmZyM1ZIUUdhUlVW?=
 =?utf-8?B?SFUxb0h1V1B5aGUwSXFBWGRhN1ZhVmpVZnhpcHZ2eVVwN0hVcmpERVF1V0ls?=
 =?utf-8?B?amhCMVRFQnZXb2xheS9UMlRTejIyWDlQSE9nWFpZQkdVQXVDakxGUXVaaVhD?=
 =?utf-8?B?R0orOUVLVmRoQ29TTWFqTU9VTUlENXBTanRFQzNPMXcxbDQ4YXpvRmRXSUw2?=
 =?utf-8?Q?HoCYOKIrzA1/X?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e616339-ccb2-4d9f-b270-08d95366d294
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2021 14:32:13.5321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GeNduSPI02Rnn9EFuASt8MMr66H9ixoPkenEpSmCqVeauTrWp+iH21XA0s7eSMChaTNryjj0bxwwSoJhwqqpHjyV+2pJt6ruQ70FIraAiA8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB4590
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 30.07.21 16:26, Randall S. Becker wrote:
> On July 30, 2021 4:17 AM, Fabian Stelzer wrote:
>> Subject: Re: [PATCH v6 5/9] ssh signing: parse ssh-keygen output and verify signatures
>>
>> On 30.07.21 00:28, Randall S. Becker wrote:
>>> On July 29, 2021 5:29 PM, Fabian Stelzer wrote:
>>>> On 29.07.21 23:25, Randall S. Becker wrote:
>>>>> On July 29, 2021 5:13 PM, Fabian Stelzer wrote:
>>>>>> Subject: Re: [PATCH v6 5/9] ssh signing: parse ssh-keygen output
>>>>>> and verify signatures
>>>>>>
>>>>>> On 29.07.21 23:01, Randall S. Becker wrote:
>>>>>>> On July 29, 2021 4:46 PM, Junio wrote:
>>>>>>>> Fabian Stelzer <fs@gigacodes.de> writes:
>>>>>>>>
>>>>>>>>> On 29.07.21 01:04, Jonathan Tan wrote:
>>>>>>>>>
>>>>>>>>>> Also, is this output documented to be stable even across locales?
>>>>>>>>> Not really :/ (it currently is not locale specific)
>>>>>>>>
>>>>>>>> We probably want to defeat l10n of the message by spawning it in the C locale regardless.
>>>>>>>>
>>>>>>>>> The documentation states to only check the commands exit code.
>>>>>>>>> Do we trust the exit code enough to rely on it for verification?
>>>>>>>>
>>>>>>>> Is the exit code sufficient to learn who signed it?  Without
>>>>>>>> knowing that, we cannot see if the principal is in or not in our
>>>>>>> keychain, no?
>>>>>>>
>>>>>>> Have we not had issues in the past depending on exit code? I'm not sure this can be made entirely portable.
>>>>>>>
>>>>>>
>>>>>> To find the principal (who signed it) we don't have to parse the output.
>>>>>> Since verification is first a call to look up the principals
>>>>>> matching the signatures public key from the allowedSignersFile and
>>>>>> then trying verification with each one we already know which one
>>>>>> matched (usually there is only one. I think multiples is only
>>>>>> possible with an SSH
>>>> CA).
>>>>>> Of course this even more relies on the exit code of ssh-keygen.
>>>>>>
>>>>>> Not sure which is more portable and reliable. Parsing the textual output or the exit code. At the moment my patch does both.
>>>>>
>>>>> What about a configurable exit code for this? See the comment below about that.
>>>>>
>>>>
>>>> I'm not sure what you mean. Something like "treat exit(123) as success"?
>>>
>>> How about gpg.ssh.successExit=123 or something like that.
>>>
>>
>> I don't quite understand what the benefit would be. Do you have any specific portability problems/concerns where the ssh-keygen format
>> is different or exit codes differ?
>> I think using a script that provides exit(0) on success and the correct output to wrap ssh-keygen and setting it in gpg.ssh.command can
>> already cover edge cases when needed.
>>
>>>
>>> Is there documentation on the possible arguments the patch series will use for this so one can create a wrapper script? I had to look into
>> the code to find out what GIT_SSH_COMMAND actually required when the ssh variant was "ssh". I'd rather not have to do that in this case.
>>>
>>
>> The documentation in ssh-keygen(1) is quite good and straight forward for verification and signing. Again if you have any specific
>> portability concerns i'd be glad to help.
> 
> I do know the ssh-keygen interface and that does not really answer my doubts.
> 
> My point here is that ssh-keygen is not always available in the same form on all platforms. Providing a full emulation of all arguments is not effective or likely even possible, and a waste of time. I'm asking for documentation on what specific options you are using for each function. OpenSSL is not available everywhere, and even where it is, the latest versions are not always available. It is important to know what the specific interface is being used.
> 
> 

Fair enough. Where would you expect to look for such documentation?
I'm not sure sth like config/gpg.txt is the right place for this.
