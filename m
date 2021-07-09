Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B19BC07E99
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 16:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F399613B5
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 16:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbhGIQGw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Jul 2021 12:06:52 -0400
Received: from mail-am6eur05on2075.outbound.protection.outlook.com ([40.107.22.75]:50273
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232487AbhGIQGv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jul 2021 12:06:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NxMQ1mS2Y9tfNpHhdBWNbPBG4/u2idF7EUb90Kbw79thP1PZCvWlRw6cfZlU/06e3tbrMwNeU3QTH3DBPNp5Or7rE4cUR7jIf3QBLv7hAHgeYbXRLiuUuGDg+wZ8j5BElji65bRVIt8nLahF10WxbIceZUIZeJpxO8E8aMDorVT1cadoQJ+0iWedaS2xzfy0QUUs9Cx/KSpFPj6MqO9SboE1Xhj4WnnWs+XQoKmpvWAsg6FoSsyICU0gRfW8aFUlr7N6twxAU91171x46Lci/CfknyZo06xrNbccUArTEX9vSPzgx6eQopiFA7wdMejPfi6NwIWHd4disieXoFKn+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=893oQj/ivoj73RZWZ8z3Wt+nsoic10dQvtysS5vq+Qc=;
 b=NxCf7NF/vWvp8JwxvxJmLQmr9dm3YfhkgeNqKKWTxJMuLB+qqGHNbGLpR81Jreus2SUbMPqNBgoGNGxJc6F7rrZU1Lq1kGZwoq6XtOn97LRzRO0ZI90gq1cQvO+9ScHmLczGPf4Z0x0vwFd3AtX6XwWwxTBpSYgK5UkTkCrA4rhXLzryvFKOmDm5jCB0qTTE3CVjXq/ZzwjEsVESX2DIwl+Le7KpDisVBexMHQqSk+asn/+xdqS8aYbrLBiEG79h/YiD+T09VsMzIxI2zvNzWHbL0HLKL0FFoDmS2glcDxtvjZpaHu7LjV8M0tYYmPFK9OichEftFvQEwGlgjtCAHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=campointnet.onmicrosoft.com; s=selector2-campointnet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=893oQj/ivoj73RZWZ8z3Wt+nsoic10dQvtysS5vq+Qc=;
 b=YEFgkZ0xLDU29vgc8s6WgWXahPduzWThloFXOT7MX/WfHLZADS/OuWoP5cmslWVCHMGkasDeFgR2t/B/wuBKc7ifzQaVM8U+XVOmhKb4FzofNF7M2Eq5t3P1ADV2T+L9p+QXFH3S4ue2Bviwx0f6DPE0iL3GepUSIhgBC05vz2M=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB4318.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:ad::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Fri, 9 Jul
 2021 16:04:05 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d8f3:d5f9:226:e9aa]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d8f3:d5f9:226:e9aa%3]) with mapi id 15.20.4287.033; Fri, 9 Jul 2021
 16:04:05 +0000
Subject: Re: unit tests / cirrus ci fails
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
References: <a7aca5f5-3a5e-b13c-ccae-3e515c774420@gigacodes.de>
 <YOhmAGig//yfABWv@danh.dev>
From:   Fabian Stelzer <fs@gigacodes.de>
Message-ID: <db030e49-edb0-8f4b-0e51-a89b2a4a47a8@gigacodes.de>
Date:   Fri, 9 Jul 2021 18:04:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YOhmAGig//yfABWv@danh.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PR3P191CA0034.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:102:55::9) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:176:e980:2d4e:7e07:50bd:bf92] (2a02:908:176:e980:2d4e:7e07:50bd:bf92) by PR3P191CA0034.EURP191.PROD.OUTLOOK.COM (2603:10a6:102:55::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23 via Frontend Transport; Fri, 9 Jul 2021 16:04:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a10912e0-9b03-4c15-cc10-08d942f32cf4
X-MS-TrafficTypeDiagnostic: PR3PR10MB4318:
X-Microsoft-Antispam-PRVS: <PR3PR10MB431871F16441A0575BABA93DB6189@PR3PR10MB4318.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BkxbTwijFuvk9iZszV1c4j6t+3sFYHHOSMs4syc6J7ggiuPyJmvIMnsexBevB5PcPM/jsbAy6mPiDwkxbOlViJ565J9TMwBjA7NKppFlQtsc7ortFI/CfwX63qGL1RYg/+zYVJhle6jKdnDNsw8QdxDMl1SG/+E566aDT5SKvysYYD5s62CCEvQMcROZkO27EkpZUjrPQgKUwyqxQJ70tnJmZq1oAeGT5UVbeC/T7L70RPIzW8qcNoqh7tTmHXSreVLsy65oQHWeQnFKliO1p48/I5cLbwmmILLTLyZoAVP7eFFMNEvutlqkCBW3kNJ1D01Xs6e+DDEpCG/k0RzQ5RkJPNDIjgF/jKbPVkhi4jhvIvSe9rwPfMZCD8SGcLuijlTc9HOsknYej4NgTTX1DvfTLfou0L7KkmfAVso1OBvnFzTOzwj2iIQb+pgQKL91WbmcLjgGqiR0TuTjWFJx4F2YC0QkegGHMna16fIsptYgGHutM9txstXGZurf75N6tGlO54lEB/TdGyKhBmq5htklX3DwWe3zmtGIoTfJ/icCtAWVmfkA91kFjtmvtW/5r+CUf7vGW75UUPHHZ1rX+mgC1Me6e/tPD1wRTbiqpBj3hDQk1MTnXnf7a0bdOuZvrnZcuOtYZL5xLneuWnixe+xAj/C2Vaw1NYzoQYziPEq2i1YxXI4k5zzrTycU1LZA2CWrAu76h40o/0rkvB/O4X07Z7E/txxQwJmjUZ3NxbLIyljcG+g3gelkVz3tEpusg+EGpUnTJZ2aB9BmCUMyty3AbSdoLmSVfibKbSlrJr6VhqdhRgEF5Qav7B3RmnpH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(39830400003)(366004)(346002)(396003)(136003)(376002)(2616005)(6916009)(66476007)(6666004)(66946007)(31696002)(38100700002)(8676002)(86362001)(83380400001)(8936002)(478600001)(53546011)(52116002)(2906002)(4326008)(36756003)(31686004)(5660300002)(186003)(316002)(66574015)(66556008)(966005)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blRTSUNlU0k0eURUZzVucUtSTTdETkdzQ01nQ1J2bWx2eW1JOUlDOWd2VXcx?=
 =?utf-8?B?TXhQSHNVZmgrWEpYenFCNnJaM1M0d3ZlcmJnMXhqeVJ1NnhHL1pad09nOWth?=
 =?utf-8?B?NHM0dFZYellmL0IzV3VMbE5Hdkc4c05OSXlsMjYvTUdhWkdmS0FvWEQ4Nkxl?=
 =?utf-8?B?RHo3NmQzR04zUFZuZE41TG1halc4S3Z3ZEQ2NGxSREhMQThzb3NiNzZ2TkM3?=
 =?utf-8?B?dE10STkxTUhUZWlKMDZobEJCaXdXalJvbEJRSzdDOCtUb0JyMlVvcEpDZmVD?=
 =?utf-8?B?bHdmSEdvUkxmVW5sVVVSSkZxSmlVU3ZHTE1sdlMzVHlla1A3eWRocUpyaWtT?=
 =?utf-8?B?TzdZNjE1U1dpdC8xaVFCMm9NUXFJS01JeFVtOG1qTEp0SDRtQWQ3endXY2F5?=
 =?utf-8?B?L0V4d2J4SjNWTUpwT2JWS1UxbnY3bmNhc1FzQjhxSU1aQnBjakJCSDhsYk1u?=
 =?utf-8?B?YkZzMWlQdVVlc2xwRDBydmdzbW1rUkpmdUxRVjBTeTM3eFZmOTRISm12SXZ1?=
 =?utf-8?B?MFhUMVRHN1ZLUmhiSVJMd1ZzREFSU0FpSkcrbTErVHE2N1pEQW5YUEdqRG00?=
 =?utf-8?B?Vm1yRDFJdU45R0JZZU9sUTR3Q3ZROENCV20wVjRtTjRRSG40S09lY0hFb2s3?=
 =?utf-8?B?OXc2WGRCenRDRmJQTnBZSW55aUpxYmlKVHg0T09LV2F1N2dRTWhyMnBiVDRn?=
 =?utf-8?B?NkU5UkZBdzFHTWphZUU1TXBJeDR6WlVGUkRnRHlrQnpONGcyaUJUYi84ckx6?=
 =?utf-8?B?YW5xVEdqQnFCdjl0ZXR3L1JvS0x6bGxGT0ZKNXY3WEowTEpFdU8wSWM3MzZh?=
 =?utf-8?B?ODZ5bVBuMzY2Rml1OU1xOWhBNWoxcU42elVrS29XVC8xWVNwSHE4QmVnOEFD?=
 =?utf-8?B?aEk4L3AxR2VnZ2pMSHBCaERjZzVhQXF4VytVQ0xZS05jeTlwT3R5RUJkcHRZ?=
 =?utf-8?B?UmMyenpsVVVkcys1UGZERWwzczZ4TG5GejZtUWZkOVNXam41aXRhcldxckow?=
 =?utf-8?B?V3BNdWloL3hTNHQrR1NMR21TZFdGZkY2YWdZSHV2WWIzWTh0UjhYd290ZXpx?=
 =?utf-8?B?RnF3SmhBVGNSY1dTZXJ1bVFLbmlrUzJ0anl1Q1d5RTM5VVAwYXpXblNnRWpR?=
 =?utf-8?B?OENFd2pXS1BwZlc0Q0RNZVltdEZBWmtSSGRBbHpWV3B3ZVViaXp1TDVFcTlB?=
 =?utf-8?B?VjJaVStraHk1SkFvOTFQM2xRaTI1dWxuNVhOZmd2WXRoYkxXZjhlYUQ5OVpm?=
 =?utf-8?B?V2tteGF2Rm8wTkRCWW1sMWpjS21EbXltUU1IQlhzK0d4dkJmS3doenRjeE1x?=
 =?utf-8?B?RDVvbkRBWnVLcjY4Rm44dERJUFQwbHZMUnB2enM5ZC9pSlBBQU5qbUxOSVNX?=
 =?utf-8?B?cHZUeGZPZ05BQVdzWndLbTR5eVVmallWbjJjUW1wOC81MUd0U1BqcXlkc3Bk?=
 =?utf-8?B?dFJrN2N0czZmUzhMSG9pRElNak5QV3RqdDZQQVpBa3F0djBMUWdiL1JvQXp3?=
 =?utf-8?B?VGtuWWN1NzR0VG9KQ25neDk5K2hpYTl5bDVHaXhKbVdab0FqU2R4eDVsTXNl?=
 =?utf-8?B?WkNaSHEzZ09Mc014YUJseldyNjdaeE9BQ1hwV2xOSVVKcTJWaENFSXBZYVM4?=
 =?utf-8?B?SnRWMU5IKytEdWQ3S1dDa3JjV0NJSXdLc2lORzMwdHJaQ21iTnJkVnVKRG9Z?=
 =?utf-8?B?NUpoeTRuSEI4OFZaMTZaNWMvakZZK2QwSUl0cGdDNzV5K3NBQmpEZXR2cndP?=
 =?utf-8?B?ZjhuMW90RWZNUEtFUUdBc25wRHRrbjJaT2lkQ2JsUUFMVHQycnJQMjF2RnZw?=
 =?utf-8?B?ZHpSZTZ5Q0xMSnMrQTU4d25JRGNKSm5hTzhaVGw1WGpCQ1prYWdKZTlFYmhJ?=
 =?utf-8?Q?nBsWn5P8Wzdfj?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a10912e0-9b03-4c15-cc10-08d942f32cf4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2021 16:04:04.9965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UWi7PizyQuqapQI0xiZNJpln/n5kAlfGfw96orxutt2GieWblsrENeI63mUb/FAOqIUcMBlDfsg9mqnJEQ3o7ERAdWHZg34p3prpyPP1bqs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4318
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09.07.21 17:06, Đoàn Trần Công Danh wrote:

> On 2021-07-09 15:31:01+0200, Fabian Stelzer <fs@gigacodes.de> wrote:
>> Hi,
>> i'm having a issue with a failing test on my pull request.
>> https://github.com/git/git/pull/1041/checks?check_run_id=3028222798
>>
>> I have added a bunch of new tests and they fail on the freebsd12 test that's
>> run via gitgitgadget.
>> Is there any way to enable verbose / debug output on these or a simple way
>> to run tests manually in the same environment?
> I don't know about cirrus CI, but, skimming over the log, it run into
> fatal error after skipping t4202.71, I think the bashism in
> "test_lazy_prereq GPGSSH" is the culprit.
>
> "|&" in "ssh_version=$(ssh-keygen -Y find-principals |& grep -q "unknown option")"
Thanks, that was indeed (part of) the problem.
The new tests themselves are failing now and i have no idea why on 
freebsd :/
Are there detailed logs publicly available from the CI runs?
Or is my only option to set up a freebsd 12 vm to try to replicate this?
Does the ci simply run "make test" or is there another mechanism involved?
