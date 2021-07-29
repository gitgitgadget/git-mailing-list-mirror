Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F38C4338F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 21:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD268604D7
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 21:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhG2VVY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jul 2021 17:21:24 -0400
Received: from mail-eopbgr60041.outbound.protection.outlook.com ([40.107.6.41]:7809
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230344AbhG2VVY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jul 2021 17:21:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WvVBpVhYA5CvdJfOE6pLCh+0SzcRbzj9bzAF8F/9kX5ZUh7uxf0sp1soDMZmOR6vFcuhyGniOYC0QyivlzJilQLqgC8A4gdrtACPCWlmzZdAXx3GgiW5dBKgXrRhXxsjQMH9lYiYehyUfCmBsF8LIVJVDEg38k/Gx+7pX37x88G2EwpatNwkjCbJ0wxqr4ST6NG9q3b8foZnxUz4CMHJlDgl4iuuTP0WwCxMrvu6qOXmx7MvwVYQRViVXZYsFygbwGAQAeH9U5sLEYMO2RtHMdccrGAG0kyx4v3vxeU9L47DhUqegytpI/XAvYyEthH7Ey83W8euLVVGLegpF95OFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/CKUkhcGnkwNfOSX4E/C9GDXr8E8kCrfcXFOWIZsn4=;
 b=jsrTHt4u/GKyDZS4oAOb1FPjw2y9gJ9nk8Zcc6x7/z7HT+LzXcJIEjMeDg1e8uvci+L0zJLCyXDF73gfCyOSzL+ldhR//YsK8jzo+UdsrTzFgb5ahtEw6OcSAWm/uc5XordWiIhRj+37yjqoYrVjGlUan2MNJ0ne13xmbX58rDgCexfpiBNLoGxp4em1lOLEN5l0mca3oNa8YZsy58xT4BHv2mhQPMvuGvpJmvItyN+lc5OM8zR8Ywy/+fGcxUZgMPsdZBC85zzXdvmEIk/c0PH8PaS+Gv3zVbUTSeU6v643S2a8PuvWXJXo0YFdtNs4dX3Pxy/DLmrWDJYhr6oAJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=campointnet.onmicrosoft.com; s=selector2-campointnet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/CKUkhcGnkwNfOSX4E/C9GDXr8E8kCrfcXFOWIZsn4=;
 b=taX3e3F/xTPN23UKLiGWCmdJ7IF2keiBo6SsK9sx1Ce0jK7UDenMFesxoEhWYxSJQwHDkjTLPGBKR1m8wUjgjK0XRmDrA6l27fElo8FJKJB0Ot8cF8BJW3tnQklmUQW5d1VYQy1GSFPTqZs8yC31WQyaUQgNyu/dZFeLc+Li2fs=
Authentication-Results: tilde.club; dkim=none (message not signed)
 header.d=none;tilde.club; dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB4319.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Thu, 29 Jul
 2021 21:21:18 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d8f3:d5f9:226:e9aa]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d8f3:d5f9:226:e9aa%3]) with mapi id 15.20.4373.022; Thu, 29 Jul 2021
 21:21:18 +0000
Subject: Re: [PATCH v6 3/9] ssh signing: retrieve a default key from ssh-agent
To:     Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        gitgitgadget@gmail.com, git@vger.kernel.org, hanwen@google.com,
        sandals@crustytoothpaste.net, rsbecker@nexbridge.com,
        bagasdotme@gmail.com, hji@dyntopia.com, avarab@gmail.com,
        felipe.contreras@gmail.com, sunshine@sunshineco.com,
        gwymor@tilde.club
References: <071e6173d8e418349d94fea97624e8cee9f1dde5.1627501009.git.gitgitgadget@gmail.com>
 <20210728224832.2717826-1-jonathantanmy@google.com>
 <f3e72ec9-3ed4-9955-a7bd-042fa6eb016c@gigacodes.de>
 <YQL84R7qNv8pnHro@google.com>
From:   Fabian Stelzer <fs@gigacodes.de>
Message-ID: <655f49be-7752-ca07-e9dd-9923300096ba@gigacodes.de>
Date:   Thu, 29 Jul 2021 23:21:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YQL84R7qNv8pnHro@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR0P264CA0248.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100::20)
 To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:176:e980:2d4e:7e07:50bd:bf92] (2a02:908:176:e980:2d4e:7e07:50bd:bf92) by PR0P264CA0248.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Thu, 29 Jul 2021 21:21:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8226262-3393-425a-86ef-08d952d6cdf0
X-MS-TrafficTypeDiagnostic: PR3PR10MB4319:
X-Microsoft-Antispam-PRVS: <PR3PR10MB4319B35E38E9A01EF322FCC4B6EB9@PR3PR10MB4319.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ad3QqIgEUFcihfrPvNcilDzQdYtqn/rabTN110ojDPqvGrnTwoVSQrG3rA19vppthSho//XdBnqX/gU2qeozfIQvOp+q8EbC6CM3jDG+rxe2Md0ryijCEc55KnkmMDqqk8MBp3pfqMESy3/xr3oRY7sXb7C42YBKJxPlZrDVP0ee/IMlCmUmX2AvnnI6Pgkm0dHJfd0+8st0nXnYW06Ffwu9LHnRr0FL3YOOCBE5jE2pytcQIosaILGDiL9hQUn39dYqNslI40H5LJhfLBCtrUMBavjwHtZ3r5JCTwmukD7gjdrAUuvokoYTfhr27HFIQJBjBNwL66iS3TvMPRGHXDNIkWF2xsSGRjV8b5cTRaMr0Oy1WDuQoQh+zA5XVJjueUaf/MqO0xt+/mpL5cUkaowPBVyrP9ugsc3ZKcP5DznVEfCjmbG4zxlr+d82nW5b8Aj0/f3KyrQkKtdpJPWTWWG7/uIccOhHQrXOlsUEmM2lFpylHTvCNVrgocS5OpiY7rMJ/Z9/wdvkiplFp8MBJveGjSJge0PkfJxlTAPwFldP2Ac47d+lpDmgI34GLSMeyGTH4AolQVqjC6lCBuj8rHajfeI9TtlZPmR7mVbxvM3a2ZZYF7PRDIf8inn9aTMeSqcDIMEl09kISl+cxv1FThXmngyhoY1kWbW+SxYxLEG4Kz/+WOpc4wAfvQAGD6vr5vGkO5MWVpxiYFRNCU95PLyX4TLehzYXunapKWt1dg10Vf9sX/0qyrrFFK3XyUQf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(376002)(39830400003)(396003)(346002)(6486002)(83380400001)(8936002)(921005)(2616005)(186003)(66476007)(66556008)(110136005)(316002)(66946007)(86362001)(8676002)(31696002)(53546011)(5660300002)(7416002)(2906002)(36756003)(31686004)(478600001)(52116002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGJYMmRvOHFlU0FjQlNUUFlUNE1HbTJCRngzWHE3OFJ0ZW4yRGlLbWJkUlFt?=
 =?utf-8?B?aW1yVFpRbjFJNWhBTVFSVU1zcVRMSElYUDFqZUdxcXJIMjZNT0RPKzFMSDN5?=
 =?utf-8?B?WnRLZzJQM3dCSVlwYVg2SC91alhiNkZkRmswMHZ4dVQzVHVEL29Id2Y0S1I4?=
 =?utf-8?B?dkNJS21vQnlmbmlTWStrVktMRFA2RWFFeG5jcE15dEJlSzB3Q0lDZ3lacFZh?=
 =?utf-8?B?UFhJbWkrYU10WFQrVWtTUWxXQ0E1Rjg2b09hWjFBUENaOWtpVW05ZlRTUk96?=
 =?utf-8?B?TWdKL2tFdkRUNE1hSEk3ZXdnNDVqdDZLdklFUHBSQ3gzcllQMFdWWG1ab2Fa?=
 =?utf-8?B?SzNkRzZzZnRnNkNYQlVlbGNVcDAyNGhtczVYbm9yUnJrMWwvTHhzY0FKMmJh?=
 =?utf-8?B?ODlEbzBvK0x1NnVodmJ4REZPbTdBblpRUEVwVTI4Qzh4Wjh3Y3JIN1RiVFZu?=
 =?utf-8?B?eWR3Y3M1UDdQK1g0VW9Ga1FFRUJWMDdlREtoTkVyeHVzVStRaFMxVXJJR3ZC?=
 =?utf-8?B?TFJGazUzT1AzR2orZlZueFZ3djA5amNnZWtmbmlJd0NXbTZoTzFhanZXQXI5?=
 =?utf-8?B?SkIvbXM3MXZGaEtNRUZDb1Z6cnRHd1ZBbHdiVjFORTd2aVBYUUVJV2dPR1pa?=
 =?utf-8?B?WlpKV01EeTdGNUVhYkVJcWtubzM2MkRFbkJrclcyS0dpZHdQM05QOVltNDdt?=
 =?utf-8?B?R2hVL1dFcFhkOUxnS2puMkhPUXc0eXYwMk5uQ2RPQkNlbEFmbWU5R2h0WXI0?=
 =?utf-8?B?bnpJMDMrVmltTy93ekNrWTRVVDBuNUhlTGNPdFpYU3ZzcllFTUFZVTV0ZGN2?=
 =?utf-8?B?M0JTM240Z2RBUFZuTUlvVkxMeVF0NFdiYkN6SEVkUUFid0FRNS9ROVhKc1NF?=
 =?utf-8?B?N29UVVFITXp1MGhCeS8xTHlWZTJuRngweFZaOVphbTY4ZDYweGZyTmNrUUox?=
 =?utf-8?B?TCt1YmdGOVowTkpWWDlDVGlrU2N6QW9UdjZFN3JmeVoydE1CZk5lR0FnQmhQ?=
 =?utf-8?B?VmpoaTl0ajQvNnBnc2JiL1lxL1pBbmJwZ0JiM1ExY2NvS054MDFSQlJxd0tM?=
 =?utf-8?B?WkVGNFpjMXNQWXVHQmszc3BLM3hOOFFUWWlpc1lGcmJqWiszd0UzMEFFZU5u?=
 =?utf-8?B?dkxqQ2VmT29CWThCZm9ZU3ZhTXBINXlObDM3SlRhclN5UTBaRFA1ZVVidkxx?=
 =?utf-8?B?T1JEaWNmZm5mNkJocjlQdkM2S3FJODRIMkdRVWdxeHM3bDdmOU9yQjhtdVBj?=
 =?utf-8?B?ZFVzMXZ5OXhjeVVwT2Rib0IrZTc1TGdwYyt1eXZSM3JIUVN6TlcydURuWEJ1?=
 =?utf-8?B?WEVjam82dkVqUnFxZXRNU0dEVWljSUVtRGZYSFM5VTdFTTRSU0gxc0JYR3lJ?=
 =?utf-8?B?alhiQkNrQVRLanZyWHJUYVRBOE9ERmJIUWdoSmJFYnBpR2w5S0Z2VE40SzJw?=
 =?utf-8?B?OG43bWloeExDbkxQOXQwbjB5ck5vMENqazBuRGh4NURrN0JBc2Y3SE5DbHFC?=
 =?utf-8?B?MThHRG1vRmdHTzdBdzhUSlhxcHJ6TlEyUWdWRWoxbHdKQVdoWG04MU5YMU9V?=
 =?utf-8?B?RmR5b0ZNZTZJeUhiMVZGaHppSmh5VDg5RVpPZmV0cS94b3RidmcyQVltV1JV?=
 =?utf-8?B?VW4wbjFDWHJ4Qm55dHJjSWlnZWlPejZCU0lPT2MvNVhZaXdaL0ZacEIrTTYr?=
 =?utf-8?B?S0pESVdjMnlsQzhwWUJ1M2JXYVFPTkpPSllSei8rTS9HQVpzL1pEMnZUWVhr?=
 =?utf-8?B?QmdRYW12bXh3VFBKK09RZk13b1dOZHFVZUV5MjE3Tm04bzhtZG0ySE52RVJw?=
 =?utf-8?B?S2s5VHYzTE5JbzZpUUk5bzJ1OWg3dWVDT2R1d0xrL0NSRTlVeUpWeXFEeTJH?=
 =?utf-8?Q?y/gy2Yj7Np+bv?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f8226262-3393-425a-86ef-08d952d6cdf0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2021 21:21:18.2322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gRgt6ktxpv4J0qTa1B/1icYPYCW4uGX2ddF2OanrTAqOpJj1jWLSBDMzNwO9CkmTcbFpLIK5n1VErQWFwBkoV/l9NqEmJKQ9tZwzmCG8Uns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4319
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29.07.21 21:09, Josh Steadmon wrote:
> On 2021.07.29 10:59, Fabian Stelzer wrote:
>> On 29.07.21 00:48, Jonathan Tan wrote:
>>>> if user.signingkey is not set and a ssh signature is requested we call
>>>> ssh-add -L and use the first key we get
>>>
>>> [snip]
>>>
>>> Could the commit message have a better explanation of why we need this?
>>> (Also, I would think that the command being run needs to be configurable
>>> instead of being just the first "ssh-add" in $PATH, and the parsing of
>>> the output should be more rigorous. But this is moot if we don't need
>>> this feature in the first place.)
>>>
>>
>> How about:
>> If user.signingkey ist not set and a ssh signature is requested we call
>> ssh-add -L und use the first key we get. This enables us to activate commit
>> signing globally for all users on a shared server when ssh-agent forwarding
>> is already in use without the need to touch an individual users gitconfig.
>>
>> Maybe a general gpg.ssh.signingKeyDefaultCommand that we call and use the
>> first returned line as key would be useful and achieve the same goal without
>> having this default for everyone.
>> On the other hand i like having less configuration / good defaults for
>> individual users. But I'm coming from a corporate environment, not an open
>> source project.
> 
> Doesn't this run the risk of using the wrong key (and potentially
> exposing someone's identity)? On my work machine, my corporate SSH key
> is not actually the first key in my SSH agent.
> 
> Rather than making this behavior the default, could it instead be
> enabled only if the signing key is set to "use-ssh-agent" or something
> similar?
> 

If we introduce a signingKeyDefaultComand we don't need the 
"use-ssh-agent" flag.

If user.signingkey is set it is used no matter what. A private key needs 
to be available either in the specified file or via ssh agent.

If it is not set then an automatic way to get a default key would be great.
So if we set signingKeyDefaultCommand to "ssh-add" (or a script 
returning a key) then the first available key could be used.
If this variable is unset and no user.signingkey is specified we fail 
and tell the user to set a signingkey.

If this variable is set to "ssh-add" by default or unset and needs to be
set explicitly set to have an automatic default key can be decided.
