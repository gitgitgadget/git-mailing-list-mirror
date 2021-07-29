Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BFAC4338F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 21:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 930EF60F01
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 21:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233400AbhG2VMk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jul 2021 17:12:40 -0400
Received: from mail-eopbgr150080.outbound.protection.outlook.com ([40.107.15.80]:1039
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233372AbhG2VMj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jul 2021 17:12:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gwn1x/EwNEcgTyyLibiA2Qjm8XQxeUFrtL/yhuVsaucIjpVbW5vgiIZwedMrEtpeXpxob7GOR1dCs1w+m1Qat/gmyf5R8dknB1nCu98UncobGrYJGxYp/AqdsrJLYuM18PNC7ugYhqbmnfGYBVxduVqdht1+Wj1DT5oXuTXh9oEeEFCv5lKuEBAVrwUTEfXFeXiLkk89wE6vkZsZCXdT+tpmPaaA6gnG6tcBff59Jtf5bIphjvmmesro3CR+WMvV+OLjdaLYQIa36wu54d8pUGP736xgZ/KcYISAgBzRcAalL1/kR17If4yL0llzRfjDOzgU9w54vl24mbhB7VjTqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCRq16SfQ9G6Tq8M0gjeSO3f+3mzri8pSYcIFVg8tIM=;
 b=dxwmT8Pupx/2RFWHaobQbS78sGNAGaiw5Jrykif3Gt/53efb5Dmj8lhDbPBZPcBee+G4PFV3SDO/s/qOEoQtRaVJFJ+QHgP/zcCozMyW1+nARbpxXe7K9WXc4elF43zX18FcviW+v3+8Tx4x5JcszSIRGbcQnFkCiJYxciV005m1BC5m/vjKiHqC/KcuCwQII5HcvNfpevo8QnG14r2Febw7TWJxdxPRbacErrDHRoKjj3JBvRxCX2PcJ4v3O9PoIhvmZqxHF5bH1xIc00UYq1GGmQDmx+055jHpmcjl60QXFs5Utc8/ak94hc/agGJtANETjFBSKDcFxTpUyMvw7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=campointnet.onmicrosoft.com; s=selector2-campointnet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCRq16SfQ9G6Tq8M0gjeSO3f+3mzri8pSYcIFVg8tIM=;
 b=tboXy4IMTaQ1t/IBpIwYSrmXvtMfZ4Dklq56+PcCgTN1+REmKIl0SqmBVwJ5W4BCE1CPUp3mV8b54MBeT5q5gJj+yoqjmzyxACsU4OtPIV9apQa/XUPW5opW8nu4RLERFWaIRoSxwBW4y5gAPEg3Uvl6ltvcRjyNnOPMTaZI5XI=
Authentication-Results: tilde.club; dkim=none (message not signed)
 header.d=none;tilde.club; dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB3818.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Thu, 29 Jul
 2021 21:12:34 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d8f3:d5f9:226:e9aa]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d8f3:d5f9:226:e9aa%3]) with mapi id 15.20.4373.022; Thu, 29 Jul 2021
 21:12:34 +0000
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
From:   Fabian Stelzer <fs@gigacodes.de>
Message-ID: <8b8fafad-0c49-0d17-b8f4-3e797a3fc9b6@gigacodes.de>
Date:   Thu, 29 Jul 2021 23:12:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <039a01d784bc$e92568a0$bb7039e0$@nexbridge.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM8P191CA0005.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::10) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:176:e980:2d4e:7e07:50bd:bf92] (2a02:908:176:e980:2d4e:7e07:50bd:bf92) by AM8P191CA0005.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:21a::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Thu, 29 Jul 2021 21:12:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8dd8e8a3-bd41-4480-683b-08d952d5957a
X-MS-TrafficTypeDiagnostic: PR3PR10MB3818:
X-Microsoft-Antispam-PRVS: <PR3PR10MB3818CC0AA8DCB038029DD031B6EB9@PR3PR10MB3818.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KE38Iy1NWNILxiReANESzKCSRsiFTQkBulGsb9smoe/ciyFiiQK++iLl1ugiXdWQlTpVpWhZe6qiS90EZew0GtJ2j9sA4vOmZr2hwlPXaxDqx8PeEW8M4txjCdzT73hUjbI7ASAByKsD2Sq5xLInOkDluNKtYLmauafaOEPL0mTyrN6X2XtvZL90OLiM7q4NQoOxkBxCulUK/ZdWYrx1gJhCM+VM3ihdRoOIH4r2V/+bIfw8IhecCnL4MkusnoAgs1dVPLVwqrSYi99nLuVsHGil0WBvee8XNpcGzylmrP8yIuN/1B8krLDj0UDAB9K0f8Elyr+bIcn3AQTGeCCLqxfKosfZ3OLb1EdrmYihgBJo93N4be+zLsWcKoasv2JoQkEUt8cMRlztNKx+ULUbw3WG9nh5aWxrKXkmLBBPYx2rmAEdpR78jBbAvvh1QcGCwNag2Vj+iII9RjMBn7y+whRGmjh5EdHd6EZtTfOOf4P014mBRemFMhKwpn8H/JQxUmSBUPJLc8OVKac+RzWLHyIsPgIgeOZfVbUkA3OOsz3RuSt0eZrlXDec/diUSUlqg7BaJIQND1NHg8cuYMbJbWszPgLnxodL6FoPTVla2VZAnAYORYjpo72cJcr6Yy7KXY2J48NwSViCqLSmFomONzTT2pVYJXok6BUagp3dI0fMTFwZvm0DBRXp0krClqHsYOY3IUADbEssajjgb/KZsJQDTCmZDzTz+vnUIH8WQcM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(366004)(376002)(39830400003)(136003)(7416002)(86362001)(66556008)(15650500001)(2616005)(478600001)(5660300002)(316002)(8676002)(31696002)(52116002)(66476007)(2906002)(66946007)(186003)(36756003)(8936002)(110136005)(53546011)(4326008)(38100700002)(6486002)(31686004)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1hDNy9NVnh2anplMkJrNHpRN3NrVzJXcXR0aGVmUGY4VzExY05pamJTbGZY?=
 =?utf-8?B?LzNwbTlHL2ZxN2l4cUFiRVZoMlRWcGFHek1XNWJwejhoclR3SmNjSHZZU1JD?=
 =?utf-8?B?Ri9qS1I4LzJPcGduNDlOZFAydnlvNGQ1N2xnNHZIUEtDdy9TM0loWFF5QTlS?=
 =?utf-8?B?Vlh2cGJka3JwYngrdE9FZERQNGUwV2FYbGVuWk95UDRzYlNsUHJZU0lQaXB1?=
 =?utf-8?B?R0U4OXFOQmZVYkV6TjZlRHY5bFpsaDBnbEg5VEJ2OTJzcW02c3NCbkhTOTFG?=
 =?utf-8?B?TEZUVWJqdmpTS1BXbm5vUFRSeTc0RHNPRS9Qc0QzZ3dPd25yOEc0ZGF6aTBu?=
 =?utf-8?B?K2lXUWNOOVB4V1dEWTNOWlo2TlN0WklzZkdzb0dxd1JTM1UyMVdQM0VSN1Ba?=
 =?utf-8?B?dHdKd1NXY0RWUG5rUG8vS2E2UmpxK2VldmhjQnFSVFI0OUJyNndwVEQ1T1Ez?=
 =?utf-8?B?MVFMQXdWQ3RUSW5xSEdzOEhiSHV0dzdVMlF6ZmV4NGxwSXdRSHovN3VyL3Ur?=
 =?utf-8?B?aU9CQ2t6MmwzRkx1Snc4ZG0vSnovbVVydWdaajcyMTdhV2FFb01zYW9kTVZ0?=
 =?utf-8?B?SlpFbVdqZ0lvbFFra0tHcW91TGF5M3lRZmFYYjg3L0Z1N2c5blBkZ1E4VDZq?=
 =?utf-8?B?K2w3ekk1bFp5UmpuTjVaZFRXakZUUUgydHJXTWpYb0NUNEdQQ0d6TGt1YmlJ?=
 =?utf-8?B?WlZzTno4a3MzallKTlBMY2c2ay92SnFUVTg1WHc5cGRlYzFVbm9MRjVwYkhO?=
 =?utf-8?B?cWJZcUdCVGxZT0IxbGJOWnpSM1lINlBrWnNiZ0p3VXVSMUkyV09nUEpZaVFS?=
 =?utf-8?B?eTdxbjQ4Q2djYXhMS1JNTlgzNEk0dUZOMzZYeUc3My90YkJkalVCN3pUTUQz?=
 =?utf-8?B?dDcvRWZqRnQvOEhFbDVHdmlrSlhnOHlSanllbDZ5ZVpFVjZXTXNJZm9FSnZT?=
 =?utf-8?B?amx1d2NvckFHRk0yd3A5dkc2WHdjZExWR3NMNXlPRFN2R2dvSkk4RjZzTkZR?=
 =?utf-8?B?ZjNCdHQ1MkRBdlNQTllCTkk1YVF5VkNvakc3VWppNVFZbjNHT2tUS0s0WXND?=
 =?utf-8?B?ek9oNUdIeWRNU1prOUhZNTdybkJyQzBzRUU1dk4vUkxIa2RuT0lxS21IbDRJ?=
 =?utf-8?B?RUhsdWdKUzNzRElBVTlvNkF1bXBKVVpBMHFVU3lndmdHS0NyZi9DZE92dktN?=
 =?utf-8?B?V3JkU0VuUndPVnFHejUzYjg4YXpOYzRpNllWM2FaUW5iU295VzhxQzlHbXhF?=
 =?utf-8?B?YmJoekdiMkdxMWtIL0RMTjNCQy94NDlNeWg3UnI4U0hXdTVkM2ZyZUl5b2FQ?=
 =?utf-8?B?OW9KUWpOS1lDaTFQUHZzWjNCSnRIaldLSWcrZFpoSHk4MDhCa3ZVNHdCYWFS?=
 =?utf-8?B?MktMdWVmbU5wb2Q1ZFBhNW5hbU9Bcm8xblVyWUs2bEtjNGFlS3NjZEhnT2Qv?=
 =?utf-8?B?NzhvMWpXTy9wd1hZVzc1MXgyQTF0Ym9BWHRIbTlVa25aWHBuQjJsekt4eGIv?=
 =?utf-8?B?M3Eyc3ZoU2M1b3NmZjVOVW91K1NCWVRyY0xIVTBmbmdLOXROdlRINWpDSHkr?=
 =?utf-8?B?RCt6SW0xcHVVOFl6TFYrSDh3b2tGaW56ejcxd0VWM1hYcWV4VUZWOVhvd25J?=
 =?utf-8?B?VnBuVU5PUU1MQlFOME93TFkwSXVIOWsxODBaWEtRYkxDaDRaNTcyZmtIU1dv?=
 =?utf-8?B?K2wvYms3VCs0bFkrUFpVMGRiUHZBbVpwR2FiZTIzVEhCK3RnU2ZjczVEczM2?=
 =?utf-8?B?NlhvdU8vc2lUWm1kYnNuZ2ppV3ZjQWFlakhGelRZRW5vbnpRZVE2Z1UwaVBs?=
 =?utf-8?B?UFpJbTUwdDVpVVJwMXpGR0hPblpGdnFBbVRFSTBqRWRQeGNmTVdvaFdoZENw?=
 =?utf-8?Q?f25inDCfqC3jG?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dd8e8a3-bd41-4480-683b-08d952d5957a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2021 21:12:34.0129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MuA4HEEbwMaINhYUkyqpnI+WEJcYii0GdAvJuZ5cANKj0oGcn8MzYCFRSYUH9EPhKDH/3dMQEou3ySV+Epu8h3jwf5Kk40N9N1gLMj0DHBY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3818
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29.07.21 23:01, Randall S. Becker wrote:
> On July 29, 2021 4:46 PM, Junio wrote:
>> Fabian Stelzer <fs@gigacodes.de> writes:
>>
>>> On 29.07.21 01:04, Jonathan Tan wrote:
>>>
>>>> Also, is this output documented to be stable even across locales?
>>> Not really :/ (it currently is not locale specific)
>>
>> We probably want to defeat l10n of the message by spawning it in the C locale regardless.
>>
>>> The documentation states to only check the commands exit code. Do we
>>> trust the exit code enough to rely on it for verification?
>>
>> Is the exit code sufficient to learn who signed it?  Without knowing that, we cannot see if the principal is in or not in our
> keychain, no?
> 
> Have we not had issues in the past depending on exit code? I'm not sure this can be made entirely portable.
>

To find the principal (who signed it) we don't have to parse the output. 
Since verification is first a call to look up the principals matching 
the signatures public key from the allowedSignersFile and then trying 
verification with each one we already know which one matched (usually 
there is only one. I think multiples is only possible with an SSH CA).
Of course this even more relies on the exit code of ssh-keygen.

Not sure which is more portable and reliable. Parsing the textual output 
or the exit code. At the moment my patch does both.

>>> If so then i can move the main result and only parse the text for the
>>> signer/fingerprint info thats used in log formats. This way only the
>>> logs would break in case the output changes.
>>>
>>> I added the output check since the gpg code did so as well:
>>> ret |= !strstr(gpg_stdout.buf, "\n[GNUPG:] GOODSIG ");
>>
>> Does ssh-keygen have a mode similar to gpg's --status-fd feature where its output is geared more towards being stable and marchine
>> parseable than being human friendly, by the way?
> 
> I do not think this can be done in a platform independent way. Not every platform that has ssh-keygen conforms to the OpenSSH UI or
> output - a particular annoyance I get daily.
> 
