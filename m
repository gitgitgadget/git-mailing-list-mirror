Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1462C433F5
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 08:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A318A611AD
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 08:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbhIJIHE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 04:07:04 -0400
Received: from mail-am6eur05on2064.outbound.protection.outlook.com ([40.107.22.64]:18912
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231668AbhIJIFN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 04:05:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I1Pv8FF0DrVNWiMid4s+2ksUHTKtV1hm7xHU0yCvSqjUh7C6NDyEbflMePRwUs8OxYPk5swUvS1sHQVzqQAjQ9BnupDbvKdX9wqQIUcVUlx5/sS3D2ul+AcyS4hfwIiHV8fRP7b4Xn48Rem7Yt4qmqQrYagtMo8iDrta6QBybYtySEEES1jcx/yC08oI2A/fq4DrP5ijpThzl+OV5lxW0mgNQt32tSFGXLzk/HyHRhDwi1M1w+UdzzNtcH9PT11ILuPnO0Hzisc8Os6iSN7AvmEjJ4fZOQ2jDrswfeAuNZ1BN9B6it6oMZIC8cDOlfWAIbweuuCsC6zaibPzFYSgJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ZdPYKM9g5IKa1/wRcNDaPS5DFJBffmiS/PQMZiSdaGc=;
 b=CJYarAuupH8E7iEW8gS0RXkAsbdVN+acZ8trpH+Qhd1FK5Zm1xf/6tJxezH34PSOTDFw8aj1Ul8kkax75FzGncYWqq+AEL0mq8iP8bGN2gW3VPKJHgLB5wKKZ1sa8M1OWQVPn5ushD0bR5TSe83UIg6VMNfbUp9PGq+j1ZRR17LEeBSmAfaxLMHA9Y0lTAB2VcrWEecpxsMSB1tfy3uAmM7EYNLX/KLu2scX56p9vlTksGYXn5yXWInFX2uKJcxFx1lUpEvl5PLZOpjPlJqLIC/ZxNF7/5gxKNWRc/FT463nAgf27XhTu86UCLCBhOrsftcED4e2Ge9rE/r9G3nS3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=campointnet.onmicrosoft.com; s=selector2-campointnet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZdPYKM9g5IKa1/wRcNDaPS5DFJBffmiS/PQMZiSdaGc=;
 b=WunR4W6Q6B9RuGuCU8/Qn77Z7RWSL6004/whqORKJy0+MEw281bk+5GBJb0v7mSIsMspfPwSLWq9utfQkWTHqYaqKC2GNjVRezA/y+MZZmsuATc6Molcxrr+Vzug9hxary0MIwP9NKwkniWhrWT5je61DkxLpIJ355gQQyE4OgU=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB3883.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:40::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Fri, 10 Sep
 2021 08:04:00 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939%6]) with mapi id 15.20.4500.017; Fri, 10 Sep 2021
 08:04:00 +0000
Subject: Re: [PATCH v7 0/9] ssh signing: Add commit & tag signing/verification
 via SSH keys using ssh-keygen
To:     Junio C Hamano <gitster@pobox.com>, carenas@gmail.com
Cc:     Fabian Stelzer via GitGitGadget <gitgitgadget@gmail.com>,
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
From:   Fabian Stelzer <fs@gigacodes.de>
Message-ID: <4500892e-9efe-550c-73fa-37a3a69bc737@gigacodes.de>
Date:   Fri, 10 Sep 2021 10:03:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <xmqq4kawcmqg.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR01CA0132.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::37) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:178:20a0:d22:c58d:d0a4:a83a] (2a02:908:178:20a0:d22:c58d:d0a4:a83a) by AM0PR01CA0132.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Fri, 10 Sep 2021 08:04:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8226ba00-2edb-43e3-1bd8-08d974318c52
X-MS-TrafficTypeDiagnostic: PR3PR10MB3883:
X-Microsoft-Antispam-PRVS: <PR3PR10MB388321F6A98E4CA20FA1B96EB6D69@PR3PR10MB3883.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qnDCzoDzlihbBlo9gQ4kKfqayCkMg+8xAQevX5IIJ5TTbqevevYFB36txzhR1+jNcpomgnjXnMNcwGu2srKyWpKnTqu4MRikqKR5y8wK7KFXv8d7rKEcz1FqUDGG7UbRKaWX0pYf4g+fGtEBZ0K42jOsvQNArllljB6Ebl4Lh41ZeC2Rzs8vwK1lCD0Z6NJCODRE2KA0YQKoBDtVi2yZFtWNxFhpn7mXpvnJQjQRbeu6RLAA0/llwZgbPMIx5rigG2VXfYXDjfBc4V5FMfRCNUUzizWNrp4FryzQu6vY9e+D0JwA0vXRdgfIZ25e3ljZsMzdTtTQj8ucDkhJ5bRdQWuTF+kkm/jx7au0W0PDLcfX82OA7FiENCY89opf2eBrpg4Li7LJaldER/SUETLPqPalB0o+luJniIuREBTsdvctTxNFEtdZFV8kAPevnbqb+bbS+ViVBRfJeH31SdSCVmGFlDfoCYSh8QNt3OUAmNJlPhiNoTilbPKFbhn9/RBI8m0VrWcWSW4OW5bz1S+7POY62EyLXn/e/sHUeGY8JCpkTw9QhhV+vLi724gwi2JllSA6YLRoXFWherAeAca0BRKsE/Tp8nGJ36S4cRoEaChYBFFxKiTQohDvslRFr6066yTfKVohZ2Wg42zP62PCWTwVcens+KyeOWAQh9ihGEzoIerG8h++gAsG0pOuTsGB2vaY24FrrvKEv4Ta24Wpzw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(136003)(39830400003)(396003)(346002)(366004)(376002)(66946007)(8676002)(66476007)(8936002)(6486002)(86362001)(31696002)(2616005)(66556008)(5660300002)(38100700002)(52116002)(4326008)(2906002)(316002)(83380400001)(186003)(7416002)(36756003)(15650500001)(53546011)(478600001)(31686004)(54906003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVdtcVNMSEZ2aStISkJ2SlR4SENsREdRQ1ZialllbTZKTFgvTkJMc1hVTWJm?=
 =?utf-8?B?S3hQTEFVNCtueU1RTllwbWxKZExUTnpSc1dja2Zkc3gzUEpRWGhhSVVYczli?=
 =?utf-8?B?cjJUeVZCZzJveUlyUWhWYlg1MHRxYUlSZlBhMXlzY2FLZnFDM2hxaHM2cktw?=
 =?utf-8?B?ZUVxK0RDMUN2VWxvOHpucGhCc00yckFab0dGVTczSjFYeDFIdVJFWWJrcUZr?=
 =?utf-8?B?Y3VvaWtXTFV1QytmSnp0ZnQ2YXJnV2pNUmkyem9DdFBXZlR4TmtmWkc3N1Yz?=
 =?utf-8?B?WjJFN212bmI0UmRqZ2hVZGtxSWRQQkN6Y1RDMUV3d3ZjTUxvUEs5WXNxQXFq?=
 =?utf-8?B?SmlZK3EzMjNOZHBTcFdwUldCbzRXN0pqUm0zSWF2MXg1OVc1T3BrNWlmclhq?=
 =?utf-8?B?aStkUnkveEtIMWtmeDRZUDNPMUcrTU5VQXVCTERFTVJQM0lIL21lb0lHeHlu?=
 =?utf-8?B?VTlkajlyZTd1SGY0bTVJSzZXS2lDTHpseGV4bVdOQ3pVV3JqZFR4K2M4OHF2?=
 =?utf-8?B?MUxBZmZ2QkJHbUlVWUMvdDVFZ2ZCWmhFQ1JtMXVITnlLRFh1bDc5Z0V1REV6?=
 =?utf-8?B?QlVYV3ZobzBNR2ZWS052RVBMYlRRMzNOd3huM0ZaTDRzMlVpd0l6bVp4T1VV?=
 =?utf-8?B?Z1pHQlZ0aWFKd0NjcExnR2dTeHEvNUpBMUl6aEhnVU85MHFtVEwxcFFPS3Ez?=
 =?utf-8?B?Tm5HR0ROUEN6R2JOMnlhZTBRSmQrZE96czk5M0dIQ1V1RTJza3dHUDRycVpH?=
 =?utf-8?B?ZkxuVmw1SEdJaVhzL2ZTK0ZyV2RnUFVJSXVidkRySnBORFBLdUkxekZXcVNS?=
 =?utf-8?B?cVk0dkNhbXJDd295STY0S3Y5V1pxMVpCNklwdm8vQXRmZ01aeVJyTkdXaGNw?=
 =?utf-8?B?MTFzQk41MVI3aVFTdVpYaVI4V3Y0emxQeUhNYXpJYUhHRUVhYm1lL0NoY1Vn?=
 =?utf-8?B?WnAxMVp1UzkvR21RT2lDOGx0Qk1JeC83UngwWDdkZ054dnRQV2svKy9EenFt?=
 =?utf-8?B?SDVycmpHVlRqbTNDUXFDZStrTXZLbmYzeCtHZFNRNDRPYU1aNVovamlhTGpz?=
 =?utf-8?B?R2U2WEJRTFNyRUh4ckMyMmFpVGJONW5uTlN6bGVqQzRBOFFRckFLN0hVSmU3?=
 =?utf-8?B?UEFybGhhUG1PTFVLN2xJWEpWdTdNcHUxYWlsZ1RqOXVBYS9PYTE5T0NucGh2?=
 =?utf-8?B?WldKSGRiSzU3TTJhcWxEVVJraE4yK1NlSnQxM2xHcElxSXRMUFd5U1N1N1Ra?=
 =?utf-8?B?d2FaTTZwTGZvUjFSUjVLTHpKamVZaHBrYUtOVEZWWmNLNjZGczk2VTUybkFU?=
 =?utf-8?B?UjJPMkNXYzNXRFVmVEx1NXJ3RW1YT01SZGZ4TklPdkRQekRMblhGYlZGQlRu?=
 =?utf-8?B?KzhyZHdnZWg2OThVdCtEbU9nSmNwSTREaE15bERuYVlVMmRSRXUrMUd1NkY4?=
 =?utf-8?B?bzRQTlVEdm9BaGgwUzBxcC9iVGIxSndKcGpHQ1dKNER1QTA3Vm5KdUdrSkpF?=
 =?utf-8?B?QnBFeWFOOElzSDNuT3UwcGdxQ3h6ZElTME8rVGtJTXNuTVVWT3ZCY2VSZ3dl?=
 =?utf-8?B?a2gva3hsMnFEb0xpbVlQdXB0Sk43MGF6WXRTTnZySkdNekU4TnZ6Z0NTdlVi?=
 =?utf-8?B?NS9GWThmK2YrY1FDbUxnSUFHMDlJaEI4eVBNZUYyOFcxMGc0Y015aHBmYTU3?=
 =?utf-8?B?YUtSZDlXbERLNXVLM2RKMzJEVTlBT2dqd3I3b0dRaEdBbWhtUGhYczA4cEov?=
 =?utf-8?B?cGExZUFocFU1TGJVSVRyNzJ6VGE2ZDQzNTlMZ09nRFA4NHBtZzVEb1ZTTFVC?=
 =?utf-8?B?WlRZQXFuVFRDL3c2TmluaFF2ejd3MFJXb0Y0emJFK24xMlAxOTNpUS8yOTc2?=
 =?utf-8?Q?mvZ2HisLMKg3R?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8226ba00-2edb-43e3-1bd8-08d974318c52
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 08:04:00.6942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dCGwmALZdVOWGQmMgKrP4hdO3HNbDGC1hrNpcNNnLuAT5f0XhvZaQxALsTzG+HqFtlySfkB0h0wiRzZZyjlAYWRpYWEodPexeA7ld3kx7Yc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3883
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07.09.21 19:35, Junio C Hamano wrote:

> Fabian Stelzer <fs@gigacodes.de> writes:
>
>> I have this prepared but not ready for submission. I wanted to wait
>> until openssh 8.7 is released (which happened recently) to make sure
>> their api for this newly added feature does not change.
>> I will be on vacation for the next 2 weeks but can submit it afterwards.
>> I have a few additional features in mind but wanted to wait for the
>> basic functionality to settle before piling stuff on top.
> Reasonable.
>
> In the meantime, people seem to be finding issues with OpenSSH 8.7's
> keygen, so before doing any *new* things, we'd like to see an update
> to make the stuff already posted and reviewed to work with the newer
> OpenSSH.  Hoping that the fix for the incompatibility with 8.7 is
> small enough, I am planning to keep the version we already have in
> our tree (in 'next' but not in 'master'), so that an incremental
> patch will be able to highlight what the differences are when the
> bug is fixed.

It it not so much an incompatibility but a hard bug in ssh-keygen of my
own making :/
There is nothing we can do on the git side to fix this since the
find-principal call will always segfault no matter what.
I added an optional parameter some time ago for printing the public key
on verify to make "trust on first use" easier when we get to it.
Unfortunately this bug made it into 8.7 but is already fixed in master.
Thanks to Carlo for spotting it and sending a patch.
I guess i owe openssh writing a test for it since the command seems to
not have any at all.

I'm not sure how git wants to handle this since i don't know when a
fixed openssh release will be available and we certainly shouldn't
include the signing feature in a release until they do.
I can't really find a way of detecting the broken version since there's
no version or anything else i could find in the ssh-keygen tool.

I will continue writing some tests for the verify-time/key validity
feature. The tests will need some version/feature detection from
ssh-keygen as well so maybe i will still stumble on something that
allows us to detect and warn on this.



