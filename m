Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961F0C433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 00:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FB3F6140A
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 00:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353953AbhKPA0r (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 19:26:47 -0500
Received: from mail-am6eur05on2055.outbound.protection.outlook.com ([40.107.22.55]:50720
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1349117AbhKOUDK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 15:03:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LOgBgbZET4pz5wFYTKndTm+/yrg82Sj/vJwvBsEys4qWWlRTdjYpZi4D/T8uGSaiioLc4ulS3/iAkWRdyWiW6pAdz2JC5gSB7XGcdZvh/qSfmZCZXe1wL1L0Lqpq6bh3m/J6hNBy9B/nnXTo6+Zn3NV45vUtcY1fY0YnKcrMFRKSowEKnIGBrCQajn10Gz9U+iSD8PCfEb9Cc7HX1Bn0LN3o3X0P8DL9iWMc0RLTqg8g6NQ4ALPY/8jDsJhvJDggwz79wOn955q8Zlf/iWynI66bMWOOBSSwZTIbik0epFmhsluaFd35UJSqB2SXSE5R5Xp8Pk2nGZ2N296KxVUdZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CYpOHHQHomvkmmhh4LH2/UaVs1sH2x02wlQk6mc9F7w=;
 b=Q6G51YUte11FOD2/eiVujaBWNew6U85GZxFjEkvkMxKKhm31TzSv5tm0nwH+bU5NMQUUds0u1461Ujg1lDfVvhetIbl9zzFXR4a2Gp/R0zaGaPLVAK5eJ6kUVXRQSa8pElrL0B49pQH/iByUmjo2uBqN1oGBjTSnw0zOBHE6oAOWxMNTRsa+5gyv4XltxaeA85yvHYHmP8Ll14BcOVLY6Pd7otpSEeLqraYT1PtbShxhxH/90VgxqI0YU3OVTjwk6ndpRfm2umiRmVl8GEa9tN/kou9TGIBAs7TWu6SBbV9Em+9RHLBmVVwNXPkQebqpSYXbNJvyoXQy+Y9LhGit3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYpOHHQHomvkmmhh4LH2/UaVs1sH2x02wlQk6mc9F7w=;
 b=Nn1GgY51GPf5hEjzMMtGDnVqHwYEkpiayj9G9VIiZJsaChvOmfk7J180tPVVmKAADALyTyoxFql8WXmIvbNdipdj50EZ9I/MAyPHbB8R9x6PB+1KlNIYaTh5YUNZ3/kgVUDzjN8s6LTkgSimbxR70JeIemO8d1tFLA/1bK7m62w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PAXPR10MB4656.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:159::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Mon, 15 Nov
 2021 20:00:12 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391%4]) with mapi id 15.20.4669.022; Mon, 15 Nov 2021
 20:00:12 +0000
Date:   Mon, 15 Nov 2021 21:00:11 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2021, #04; Sun, 14)
Message-ID: <20211115200011.yr6wmyzmdyoaf6d7@fs>
References: <xmqqv90tfhh2.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqv90tfhh2.fsf@gitster.g>
X-ClientProxiedBy: AM7PR03CA0010.eurprd03.prod.outlook.com
 (2603:10a6:20b:130::20) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2a02:908:178:20a0:d22:c58d:d0a4:a83a) by AM7PR03CA0010.eurprd03.prod.outlook.com (2603:10a6:20b:130::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15 via Frontend Transport; Mon, 15 Nov 2021 20:00:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20be02e1-ecd7-43d8-5f1a-08d9a87288c6
X-MS-TrafficTypeDiagnostic: PAXPR10MB4656:
X-Microsoft-Antispam-PRVS: <PAXPR10MB46564D85777CF0E01058749DB6989@PAXPR10MB4656.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:913;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HME4T84JdWoV9Ir7WAzcL5t+yTu1nnxEcfOyGefUZf+r2yDNDe9KnQ7MJ4SW9Chepjk3sTo5lCd2A4RIG0PbC0iqyxku4Fo1+sjAtSdDzMuvfbgOIupykcsP5S3g9Iqc2vKtuQNRYwwt5ByvHFDSEedV7ql7KL9D/F+ic5Axv+xRwXThQtwAcwd3JtAsedXioLhOWypPVc7pF0TNZaVjK2879fo1qxSACd21p5gzCmkchJ0C4LNxY8EDRmHwK8EgEWNqR4OjhK7rjxe2/f6VBlwpvFmwzDqxE4+vqIv70y1Wldt+PguJvx3JK2uCgnzQZdgcLN35rHF6mbIn9/HX/YHPp6alLPB4Up9iR288uT60TzKhN86/IkLiMEu12bb9z5d0p8RFgQQjBrMhW2qr/zCqgJDuP6gtDgymaa7S+aC1xzT59HUdBE8ZI0HPKPWxZHnwOn76jDeYFqH2ZBueK7MPdCXzHNPr5cMVIGT9AuXFq+0bPHHSESDXckcaN5G3mPA5FXjFb5XlS7pM4bKR/ijSMa1mTzDTmG1/cyVWiwS3VeluFZ6113Mr/UMYgBJTX/gdQNI9x3yyWaELkzHkA69IaGHz+IqFmaHlhDE4Q7uFnSxdA2LVb7o6nEHxZoELQTZSON6JcLTdtvblQ1RZtQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(7916004)(396003)(376002)(39840400004)(366004)(136003)(346002)(86362001)(4326008)(4744005)(9686003)(6916009)(66476007)(1076003)(316002)(6486002)(2906002)(38100700002)(6496006)(33716001)(186003)(53546011)(66946007)(8676002)(5660300002)(66556008)(8936002)(508600001)(4001150100001)(52116002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MC9PaVpnK2xHMVZBcVlObFc2RUZ1b0VzYXZHcmszcWxUQ2dWL1lPeVQxTENL?=
 =?utf-8?B?b0hHUTlpRVQySmxjZDNQM0ZhbXBweC9MNjUxcEk3U2I3SS9qVkhjaUNWdG4x?=
 =?utf-8?B?L09yU2V1MU8wSGE2eXhaM3VDSk9XYS9VbWcvUk1HcUlBek9pNzZKVTN2WXdo?=
 =?utf-8?B?TW1TNnhYLzlNMVdtOUF3Vm1EMlNCVlNtK0VQVGErVWxKOWxVaU9zTzE1bDFS?=
 =?utf-8?B?dmliVlROV01HcFBDaWlaMWtOR21nSnNnUkFhT3c1K2JoS1R0dU5yVE0wN3Jw?=
 =?utf-8?B?MDE1cGYwcDlrak45SXEzY2x4WUppSmxYdGJLYmVUcUE2WFhubm80RFVBYVRS?=
 =?utf-8?B?Q09KeVQwOWM2VE1qclQwOUhEaHNsWDhLWGZhMUdlV1FMdE42TnN6UUtLMDhY?=
 =?utf-8?B?WE02ZmVRblRzbWdaWEp5L2k0aTI2YUorWHlHcjRJWVo0akRrdWtGUE5YYmdF?=
 =?utf-8?B?K1VnYmduTTFkVjJMdkZQYkt5SE8vdk9LRDlWUVkwZlR4aUZoY2ZHUExuemZG?=
 =?utf-8?B?ajljTXR2NlBGdHd3TWM0czJOa2tWZ21Kc21lZW5iNU0zNVVsZWRmT09MbXl3?=
 =?utf-8?B?VmpPaGZsMlBtU3JRV2NhMkRjNStPcWFhbEdVRjBkL2V5MVlIZkdUVnRjU3Uv?=
 =?utf-8?B?bFFtQmFWZzNDcTBPbG9UNk1YcjMzNkM4eGdLRTF5eTNNclFGbFJDZUUvSWla?=
 =?utf-8?B?eEpxVkpRSnFSbFgrYk40MFhGRTNjZVN4RFJIdS8xVmZYeFc5S1Brd3NKRHpk?=
 =?utf-8?B?WXg1bXJGS1gzL2pTelRwQkRRY2NqNC85L2N6S1VBK2RxQUFiWFhqQlE5NmZ2?=
 =?utf-8?B?ajFCSE1CeWZRMDQ2NDM2cXUzenkrc2hHOVRpL2JkOUxudTJFbmt6b1ppNDl0?=
 =?utf-8?B?UkZMR0t3cllnNXhZdnN3MzY0R1g2azlncWdHZzBOZVYzajQrUVc5VHNWYkdI?=
 =?utf-8?B?cGhyWVN2TVY4ek5Ndy8xaWpqN3RLZWJrb3loUTdVRjFlUkhxcjJpaitwUlhI?=
 =?utf-8?B?QkN2Vys5dGFodnhJcjV4Nk9TUDBaaTF0bS9qUzIzL1YzRkFNMVFJRXVIM3R1?=
 =?utf-8?B?Um1OcEM5Y2xreDIyUXBjV3RhamVLcHpGMWxFeXBENFg5b29ydHVJbDArMUpM?=
 =?utf-8?B?ZWtXd2hONW9TMmFFSGEzVndyamZGTHFVRzJ5SVM4N3k1djRvcVRkMHdPd2R2?=
 =?utf-8?B?WXFkYVcrMkQ2OXlqZytidmVpazRiQlYrRmtzRDRSUjhtZDc4ZlpMZGM5Z0Q3?=
 =?utf-8?B?WmVJT0dhNUl4bWIwZ09SY3VMMDNBYjlBZFFWMzZia1ArQ0VCb0xWaUh5WXdN?=
 =?utf-8?B?YkRpYzYwU1h4Q1F1Rk1CZ2NyMllQK0F1U1JWMjV0aUhTZHVRVnZ6NUUxTXRl?=
 =?utf-8?B?VkxCZ2JxZDdhb29VZ3l2a1lnREJPWmhZOVVGWmpmSXRxUFp6dWFmYmpISFh6?=
 =?utf-8?B?S1VWYjRDSkNYYWYxTWxwcG4yQmVnRGhuMVIyWlNDRGpyeno4Q2I0SlpNQm54?=
 =?utf-8?B?RVpLRFhSVzJPZ0ZkVnJDd1J1YzYzWjMvV1hLVjBBSG5xbjI0aU5RdWRnMWlh?=
 =?utf-8?B?WjR2NnVVVHE5aHV1Wkd1empxSDFxeFltNzZ5UnlFckNwZHhBYjlFNmE1ZURC?=
 =?utf-8?B?dlR6ME4yUTRuMGlMTElwOXpWcTJtU21FNTdnM0ZzalNKSzRoV1VFR29Ebnp3?=
 =?utf-8?B?c3llTnlUVTVjc2pxeEtjY2h0ck9DdEdDTnQ2L0l6bVhZOURuVmNLaUdteHhw?=
 =?utf-8?B?RGV1N09ZbHpHc2l5cXVsdUd5S2lOSC9mOHE2Zm90NU1GVEk5MFZVZytnQXdG?=
 =?utf-8?B?bFlkV3JKQ09iYmdlMWYwYStaOWFiUEVyNTBWY0dNOVg5NWQrcDNLdmZvUm5q?=
 =?utf-8?B?VjdKbm1SQW1FUlV6Zm1ENnNzSFNMMzRISVZzaXZTVjZYZ0tFcndrbFVLK29q?=
 =?utf-8?B?Rk1mZXllY0hRZTR0cXdXZkIxSE0vdVVEOTlIdmFFTG56dVVLWXMzblhyZWNv?=
 =?utf-8?B?WDVYZ0ZiWURZdHJ5VnpvbnV1QWtuVjFKa01lNXVyVWN2QmZHeXRiNEtialZ1?=
 =?utf-8?B?QlZ4dEJkcmpDQnZ0MjI2NzRKWEZRUFZqQk9VYXdlZmpTMmk5aHBxOHQvMUgr?=
 =?utf-8?B?WHZzZkMxVWlkUG9ZSUpSdmR6Y3FVZDlvWFJnODZEanpYWXpDOEpOeThKemww?=
 =?utf-8?B?MjZJR3BNY0J1V085aTgwZUtEdklnMUlmOGxWcE1CbGRjTWd0R1hEVmdzanQr?=
 =?utf-8?B?aVMwVzhQYmsxODlodTIyamRhdWxrUFNIaG1nV2NZa2NoT3FYOGdGdXU2bW5D?=
 =?utf-8?B?emxsU0NUMUcyUjRlQjJXVzV6MkFrNWJBL29jRHBqbDh6ckhJalRWVTd2d3ND?=
 =?utf-8?Q?d6gftmYqFe6AoBWE=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 20be02e1-ecd7-43d8-5f1a-08d9a87288c6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2021 20:00:12.5300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ubU/s/7YK0n7PkGGFQskcnk83V8h2uUu3IA7UYHU4n+8RdhU7fDpKXSS+y0dfRF+xDi4WePojMcTwcA2iGgtle5qeXoT9Mn+dIDxCGwr31c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB4656
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15.11.2021 09:37, Junio C Hamano wrote:
>
>* fs/ssh-signing-key-lifetime (2021-10-27) 8 commits
> - ssh signing: make fmt-merge-msg consider key lifetime
> - ssh signing: make verify-tag consider key lifetime
> - ssh signing: make git log verify key lifetime
> - ssh signing: make verify-commit consider key lifetime
> - ssh signing: add key lifetime test prereqs
> - ssh signing: use sigc struct to pass payload
> - Merge branch 'fs/ssh-signing-fix' into fs/ssh-signing-key-lifetime
> - Merge branch 'fs/ssh-signing' into fs/ssh-signing-key-lifetime
>
> Extend the signing of objects with SSH keys and learn to pay
> attention to the key validity time range when verifying.
>
> Will merge to 'next'?
>

Please wait. I'll send a reroll shortly that i was holding back until
the release. Just some minor changes from the last review round and
improved test prereq to make sure ssh-keygen is working as we expect
like we spoke about in the other threads.

