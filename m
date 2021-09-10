Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B275BC433EF
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 19:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B7ED60E54
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 19:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbhIJTue (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 15:50:34 -0400
Received: from mail-eopbgr30087.outbound.protection.outlook.com ([40.107.3.87]:44162
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233185AbhIJTub (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 15:50:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oEWtLsJAUfr4tEfEQv8T0jeFkL5OZkz4pvkDXT3w3pxu+ZmvUxe3hP5rnC0u7iyNwLw5kNa/ZZHD+CvjIB7hofHfeYMJb38NiJWYhmoJYBON5eYaTw3oouTLOQzrY5oRv5UmtMcyzbQTwMypn2zluM6UzUEP/LZ8CGzPG798rizYFsP6OOnh7Vqnpnv41Z6jPRjQFIqDVXd4qMS1Cdxw6tHmGTV0LkzatoztBnAAv11K6hkgSnLpe5fxUrSoygM1zGmUp3dOZ4jvDaYHINXb7j4roPfgKZzbGWNWTTRXfsfSyAneodYktP0dvZpm7eOkbRjEsowqTD0BXf790vIpuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ChrLPh/pPyEzeqcEfH3iRUVMltOEZqA8KTkQkIE1Whc=;
 b=QacCAn+VBW/xbin1P3BWmN1L7S59Rx48sYCmrb80Pwn4GpTbqtvCoQ7Hqjth4mJFvn4cTuE6r7cCFs16Dx9+kqkHazXJVN9suIFKsGszH0h09Cp16a6cCC+a1nYyagzapOe56sxIxgUf60bYC1vwzKbraDyKfzXnPuC4JGaVzVsuuY5ZA9mHz7SexowJT0eRGuoibL9dw1tKApRNcG4UGJ9pwS8m+KAYgV0O+YHOP/HouWFoThqGvTwEr/cquKkzuqNMOUC1qYysJp1j48CjOYtvgYgV/DYBoDnD5Um8Adq+Eg/U8tsZXMX0SDnV2wf8izzJeLkENPYCZDlYylkY8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=campointnet.onmicrosoft.com; s=selector2-campointnet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ChrLPh/pPyEzeqcEfH3iRUVMltOEZqA8KTkQkIE1Whc=;
 b=ocN+FXWNrs2mgdld5o0cYE0ZmwEFiGq9prIGTXZ9rL+UYTHW8KEnnHW7A+eMbqjh5xBzjZ8yn9XF1+g+33qLTGedCM00OdaCMeDRLK8CHjGUyUm2dzCz7gCJMJ1c/hTsZTRJZdd6j03vnBlCaNLMwR3U9obRRFfw2FnzsM6Yl+g=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB4094.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:97::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Fri, 10 Sep
 2021 19:49:17 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939%6]) with mapi id 15.20.4500.017; Fri, 10 Sep 2021
 19:49:17 +0000
Subject: Re: [PATCH v7 0/9] ssh signing: Add commit & tag signing/verification
 via SSH keys using ssh-keygen
To:     Junio C Hamano <gitster@pobox.com>
Cc:     carenas@gmail.com,
        Fabian Stelzer via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Gwyneth Morgan <gwymor@tilde.club>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>
References: <pull.1041.v6.git.git.1627501009.gitgitgadget@gmail.com>
 <pull.1041.v7.git.git.1627998358.gitgitgadget@gmail.com>
 <xmqqczpv99u4.fsf@gitster.g>
 <9075cdd1-e34d-5dcb-f2b8-69ae4abf587b@gigacodes.de>
 <xmqq4kawcmqg.fsf@gitster.g>
 <4500892e-9efe-550c-73fa-37a3a69bc737@gigacodes.de>
 <xmqqsfycs21q.fsf@gitster.g>
From:   Fabian Stelzer <fs@gigacodes.de>
Message-ID: <532d97e7-8c91-df6a-6d90-70668256f513@gigacodes.de>
Date:   Fri, 10 Sep 2021 21:49:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <xmqqsfycs21q.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: FR2P281CA0030.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::17) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:178:20a0:d22:c58d:d0a4:a83a] (2a02:908:178:20a0:d22:c58d:d0a4:a83a) by FR2P281CA0030.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.9 via Frontend Transport; Fri, 10 Sep 2021 19:49:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 834b0663-9b8b-4e09-4bac-08d974941303
X-MS-TrafficTypeDiagnostic: PR3PR10MB4094:
X-Microsoft-Antispam-PRVS: <PR3PR10MB4094E9C3D6A8472A9C15F15CB6D69@PR3PR10MB4094.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SjszOPUoLwDDoWqOlza1vneD19K7NGSmbG/VJIoGiZlEnfpkzr3D0gllg8dBoDBXPm1Honcz5F6fiQV0InsRKlnNpK5/ySYDWlAV/hjQ7+Sg7C2FfIRi4d/J5ib4DJY3Z5nUNeSLj5j6kVsEFS3wOxAbLR88ii5U9gw0fFl0miaJLsiOtWTP3ZwBXtHzoY7/Dbm06BCH11gsRpQjaxYEu7Nxf8FIIFvS23tnJUHwAdGl75xlc8Q17+R2WfD+eyCtWHaQGXBMLo1XV46XG7kIr1vzdMivkGpoRQYYcymQ8UP3MCWKJp9NWMAwB/grrPXb+4frAKNnSRCuBxme6PLBRQsIuyg8o31bZ+LlL3HS+btcGofs7CzpSks+bPsvAcgDE6iw9P/Cd2VKmcU5gOp8MDcZRvblcizCVddMABAlgrm2tm4v7SlBB8HAvgUioTGkdvOy/kILarCXGvx1HxD1HvFNGShB/zWw8VvDsviMJHHJmKJNg8MugpAZRfKO0dQCSk0Q8LCYMLNY17alScKGDp8RqJni6NEHXvMydfointOon686piF1nDZrLddQon4aiG58mk61kwjRfQYMRdxr5WVq253XOz7UY3s8S6npOU2AMm+Mth5kxinQx4afIe1bQRH/BKtyeW9vTHc7u7WoEOLOaYzgSGiuXOxHdagMNAaSp/PpAvL2t6vg7oDqo6YeGwdTxD+7RKqJTyCuZabitem8R+Q9MLPugnx04eMDnoE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39840400004)(376002)(136003)(346002)(31686004)(66946007)(36756003)(8676002)(5660300002)(66476007)(31696002)(66556008)(4326008)(52116002)(6916009)(53546011)(186003)(6486002)(15650500001)(2616005)(478600001)(8936002)(316002)(6666004)(83380400001)(86362001)(2906002)(38100700002)(54906003)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkN6UGZLcHY5V3pUZGQrQ25DWWJ0SjZaVjhKQytoVHhqN2plTjh6Ly9HeldZ?=
 =?utf-8?B?M2c0VVY3VW9ZL0hKc0plTXpPRExROHcyRCtVUzMwc0xZaklLeHkxM1R3ckN2?=
 =?utf-8?B?VEhZU21DUlpEN0VESUJkYjNQYktWcXc5Qk5VaSs1SWdCZ0dxQVVZd1dkelVk?=
 =?utf-8?B?RW4vWEZPdjMzVkY3Umt1cVNRTjMrQTB3NlhlQzVyVEd2UXQyUHQ4R1pURlJv?=
 =?utf-8?B?eklrbUV6azFJd2d1TmY1ZXlQVURNeHh6WDhTK2ZCTWVNMXUyQ1Y0cFNHWStv?=
 =?utf-8?B?STZFWWpKTU1Oeml6aFd2RE9RZkJDN25vK0lVSU5EMTVFMDZyV3J5ZldjOFNa?=
 =?utf-8?B?REdEQUVSTWFWUnpTMGFtNWxBZXQ4aUV4R3g2Vm9QMzJJSEIvTlpvREI1Zlk2?=
 =?utf-8?B?MGYyVmNTMU04VGVBZ0J6d2daQVAvblgxYzFBTVkrcGx1akk0ZURzSTd3bFRN?=
 =?utf-8?B?aVhaYy9sVk5DWUgyb01vdzBreEVzS3dxL2ZBL2ZYdnd1bG1pU2RFSzUvdEtG?=
 =?utf-8?B?anNqV3hVVWNwTFkrOUZxaWE4M3l2alBvWU02WkpKaDluKzBYUUNtVVFXeTR4?=
 =?utf-8?B?SmtaUmFtMkp0WHRJKzJ4QzljbzA0NEU0VStaeHVwang0blpLbEdKYmFmeGk1?=
 =?utf-8?B?cWkrdFcyZ3BzdVhOZ3VjQldISUhvTzVlS2pYUCt0N0NML29hNVd1NE9oMnU4?=
 =?utf-8?B?OEZOR085YkgwbWMxVm5QZEtpUXN1V2tpNmxCYmhMa01MN3pwMWFuQnlycmNk?=
 =?utf-8?B?OTltNGwyNnJZNmduSU5JbjNnYmI0MFk3Q2p1UUJVell5bnhuNWlwQ2FNMmdy?=
 =?utf-8?B?VlJObDcrL3RKcnBrOUE3THZnakRHUFdKeVVGV1pnZmd4S0JCSk5sSlNjb3hr?=
 =?utf-8?B?VjArQkhlakxzMkdyVG1zNm56VDc3UUFySjJrcTdwaTZNWDgxQTdPc2lVemtU?=
 =?utf-8?B?Q05nV2dlZ2o5L21xTWpSNmcxbGVSU0NnQ1V4L1RqM2hzVHo1UVE5MlhzSSti?=
 =?utf-8?B?dmNoUWxrcXJyZGxCSkt3RTdELzNEVUZkMEM3OHhrSmdUYnNrYnhaL3Z2cWJS?=
 =?utf-8?B?WHowUUNBdHRxSlppK1NVd3ZPMVB5ekgwNXlwV3dsMnp2N1l3dUJXTGxuVGZa?=
 =?utf-8?B?NVZGNS9ZNjJOeWZ1aU0xTVp5V0c4aGxYN1hWTE9XcThPeEpWU0x6K3REcGlW?=
 =?utf-8?B?UnNrbjJOd0NDcGwzMHRBdmJuQmJkZHo3bmZsZzhJZ2JraG9IZEdqQWRyNzRy?=
 =?utf-8?B?U0tDbFd5cFFPMi9uRE9COVZ2T2dKcmswUkptUEgvN01YdEpZN1MrMGplbUl4?=
 =?utf-8?B?aGlrRWUrYXNDYzVEQUpqUDVKalU1RFFnbE8zaExKbkV5cWhMMlJhMDdGR2Mz?=
 =?utf-8?B?dVRZc0g3a0N0Z2hWNGZ0ZXRjOHI4eDdZWG1hT08wclZHZ2puMVZFREFPbWs0?=
 =?utf-8?B?YzIySkhta1dMc0Z5YXJZV2g0VE83YjFRSWh3MXFOZFFlZkpacGRWRjYyblh5?=
 =?utf-8?B?RGhHWTFHeDdoTnRNSmFYYktjVmRXNll4OTJINUVhVU50QmdtVWlyZTVuRTNR?=
 =?utf-8?B?QmFqbVlaQ3Yza05yZWpNSUtPeCtERlQxeGUrR2Z5LzhrZnpNUlRPOERVc1BO?=
 =?utf-8?B?QXhhc2F4OHFybERwa0NIa2ZmYmluUURpWGpIQk9qZ2ZieVZoaWZwcy92OEdU?=
 =?utf-8?B?YnRaV2NyamlrVW9zQmRmZWRzK1FGYUJpbWVBY0V6dThoRDRDc1oraTRLV2dw?=
 =?utf-8?B?cDZkM1VJYnphVmJWS29LVW41eGU2QXJiMGJrMUpsNlZVZlhzQzRPZ24wcmI5?=
 =?utf-8?B?T2J0SW11WEVFVVZZSzJoZ21WaTV0MEhIRzAxUVlZZ3dLUzVaanc5YW52VWtZ?=
 =?utf-8?Q?2tYcDcc7bRh7Z?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 834b0663-9b8b-4e09-4bac-08d974941303
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 19:49:17.3685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iuZLAALYVlqXcZBCRbs3dTT47E6+QzcjLlxhuH2X42d7qYOmlV4Z5+a7ciGxzTLrMHjZjaVQOh/fFG3b6AzFQZp/rmL2rCZ1kD1IBf6Avi0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4094
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10.09.21 20:44, Junio C Hamano wrote:

> Fabian Stelzer <fs@gigacodes.de> writes:
>
>> It it not so much an incompatibility but a hard bug in ssh-keygen of my
>> own making :/
>> There is nothing we can do on the git side to fix this since the
>> find-principal call will always segfault no matter what.
> So... we cannot do anythying utnil a corrected OpenSSH is made
> available, but once we can link with a corrected one, do we need to
> do anything further on the patches in your topic?


OpenSSH will probably release a new version in October.
I will send a new diff of my patch in a bit after the CI runs are
through fixing a bug with some buffers that could sometimes lead to
memory corruption (i war releasing a buffer while still iterating over
its contents), a small test fix and a minor improvement using
git_config_pathname instead of string.
Besides that i think its good.

For the key lifetime changes that require openssh 8.7 i will send a new
patchset afterwards.

>
> I am guessing that the ideal endgame would be that we can merge what
> we have down to 'master' and ship it in a release with a note that
> says "OpenSSH 8.7 is broken---do not use the ssh signing feature if
> you cannot update to OpenSSH X.Y (or stay at 8.6)", and that is why
> I haven't kicked the topic out of 'next' and kept it there.

Sounds good to me.
Thanks

