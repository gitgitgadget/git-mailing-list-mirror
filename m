Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED622C433EF
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 08:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239568AbhLFIm6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 03:42:58 -0500
Received: from mail-vi1eur05on2043.outbound.protection.outlook.com ([40.107.21.43]:38597
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239563AbhLFIm5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 03:42:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cZ3Z44m1oHULvW+R6fF1rdpDye6/AoJVDTpgyak4l41DMHxY8MAL5W3/wpQOvot1Ur6Mrv80Yek3YW41EX03DwUHXHxtvzPmXz9hOA0mVSJ1FxXhuvr38TVHyk76KUbO3o8jN6YqsyM8MiMRBlao+OwbWbGaiv6e/R/9eL7UCGQ7bURx0XCDzklej9bl/IX9N6TtF4T16fDCCwq6j0FO76QFy+lxaeGgVIq4DOxhW4yZ8i3gOu6ZFbVHom/JDba4IUeVFPKVsUpb1BAGhPQsvIMXEcyX2JT0faTrVGbF4+ufHkMWK32Ewjo0kro7nOCcHeeEQI2v8nz1/oTU7dLEMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y0POnnCYsIK7BTah6wM3wfXGfWEEM4PqAvFxbjbuRAM=;
 b=VvPOgG6Jg2NpCMSrDm84/J/9MxBJtL2PNIRh4aiKs/8tsUzS26lW+fT6EBQFyXp0z9PKY/feTuVLYT3sE+6GYugaXJYuObhHlWbxq7UbxldYtdXUbmOjprveFHTELJ6dRuEhmECvT7O9JrO9Q2BeSR5urth2Xm8ntnEjbgFf5b0UIbeYpk2oUZk3u9eFlsV++Tc3WAyMp5vFeKDAeEUKHlPuh7YpVntDZzKXJJDyi/kDQe0N5HOwxP91vjXCXCt0DGsRudJzeWjNqvpLPCzjHQkxhr0sDNFC09eWQUX+u9UO6vHpTo44Boh7snH7jEzIY/v2fdwgFqpp1xRuG0mkxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0POnnCYsIK7BTah6wM3wfXGfWEEM4PqAvFxbjbuRAM=;
 b=CZnDFK09RUmUtR531LrS4OyEzE8tygzDcOmfkG1oWQC0n66JTVZYPkWZ6BKjhBNr4uie9dgrh2H/y9C3/G9oCmzzx83pL2XRMIE0qRI98IUm22eQgQYy1DNFSO0XiRigBh6vSALVtZIZcystCrXlFumVsUcI0kcDgnCylow2XS0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB4094.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:97::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Mon, 6 Dec
 2021 08:39:27 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b%8]) with mapi id 15.20.4755.014; Mon, 6 Dec 2021
 08:39:26 +0000
Date:   Mon, 6 Dec 2021 09:39:25 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Damien Miller <djm@mindrot.org>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        pedro martelletto <pedro@yubico.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gpg-interface: trim CR from ssh-keygen -Y find-principals
Message-ID: <20211206083925.tuy2w3wzlgpc36bj@fs>
References: <pull.1090.git.1638538276608.gitgitgadget@gmail.com>
 <Yao+l0ckDWZNf4AE@coredump.intra.peff.net>
 <20211204131149.cvyu7dvf6p66dotq@fs>
 <70cee773-9547-e3cf-9327-ac0213d327e@mindrot.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <70cee773-9547-e3cf-9327-ac0213d327e@mindrot.org>
X-ClientProxiedBy: AS9PR06CA0055.eurprd06.prod.outlook.com
 (2603:10a6:20b:463::6) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by AS9PR06CA0055.eurprd06.prod.outlook.com (2603:10a6:20b:463::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Mon, 6 Dec 2021 08:39:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 464cfe56-abd1-497a-afce-08d9b893e961
X-MS-TrafficTypeDiagnostic: PR3PR10MB4094:EE_
X-Microsoft-Antispam-PRVS: <PR3PR10MB4094D4B7F8D986CD80CF8475B66D9@PR3PR10MB4094.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D9O5Adc9o4EOCGe7Hd6tLqnsYT/ouP3U9S+lkws2D9/pe30vEb45mnFV3e1pB0uE9mardIB0/+B06qKIahjKL9xBL9t4UoPg/qu0prKUNUnjPksD1FbTy089rjWpDhT3zImCkrywldWVbKQC9wymShaQZ88e59UmWlqQPCAdGAaW9pzDJ25bCfan9T8dN7/5uWE/qtAPzUYjNab8MvDoKu0L9LsqCjhu/5HkC9yUOI4ZVmdmF+1LkGhO2usKqST1ctgTn94k9OjAYIXHKjQMiitH7Lpxop8vRsspcTKMpUPxpZgF8jPSi8BHJ3BFiuzU1tn6+c7DscizwT4Lu6Lc8+yEgf6acTAz0kch9zqlPDHxzoqPSBU46n5yr++QXzUoEfMFWfaCNxjNg3bSBHA4tPXo6J1FpY61pUDzHuHxDDNLZ2QPuRQRXytQM+Lywzfrao4KAVz2zIoJjtnrMDDCXYkP5S/Kzq4Sc0eqRfmucBcnjdU+JGJqRlIFZsLU+wHwAvnPUkJ0yTSrzBVcjs1UcdwgWaa2pNowQst4x1NLWnXgLNQFTHIENlmcY4siZGiT2F9jo1EjG3iiHrkSy112Aely4QMhN1vfL/mFWD0Unb7p0ki8cdgeaMVIGuAt7qbf1jjsDktggSRCtUhnDwJlJjgS0vwiFlvVYrWMfrlyHI86bfAr1cOxvQHF4lWNeBn0jabqtXx0uwXtrjTNw2ifI/qXyKIQunZQjWt4pWOdS50=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(7916004)(346002)(366004)(376002)(39830400003)(136003)(396003)(86362001)(38100700002)(33716001)(54906003)(83380400001)(6486002)(508600001)(66946007)(1076003)(8936002)(316002)(66556008)(66476007)(8676002)(186003)(2906002)(6496006)(53546011)(9686003)(5660300002)(4326008)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlhnWVZTMEtmVlA2MHR5TWF6cUFIMi9UenVZY0Q0bHhhaTFHa3FwL0xUK01v?=
 =?utf-8?B?Qk5URi90Wk1USDdyMmdiczkvYmpDWEFLalBvTFpWV3pWb3RJRS8wVFM4bXA0?=
 =?utf-8?B?cG1EQzhpMEZOUHZ5YzA5U3hvaU9KdStQMU8vMXNoQU9GQ0dHOFV0VVM1S0RL?=
 =?utf-8?B?ZENGRktOdzEraFEwd2pLNTNKUDhTTkdReXBOczkvTUZNMWp0WDFQakRDU081?=
 =?utf-8?B?NExmNExZcjU2VzJXMm9TRnB4Nk52UzZPVE1mTEFjWUt1a3pGaGlyVE5BUHJm?=
 =?utf-8?B?VS9xZmdWOW82K0daUEdLRjhlTE5nNVBtcmRKbXoranhub2kwYVBJV25MSFNh?=
 =?utf-8?B?WE1xbm1wRmlTYkhVcHNKQ1o3ZkgxSjBBaFFWY0txSGw5WlZISm5vSTNFVW1I?=
 =?utf-8?B?cnZkYWhvR2JrMTQrR1dSRkNqUXI2L0h6Z3NickkyMXpoOEdsaGR4bDNoUm5a?=
 =?utf-8?B?aXZXRzRjMkNHdmVXTWEvSEtzekRUU2QwbWFjRVZ3czRjdXJROFdoQXBTaDFm?=
 =?utf-8?B?Ylh6ZnJZSm9KNTNrRXAvRUNiK3ZzemJOaVBuOHlEcHNyWXJJaUpmVDZmbVlH?=
 =?utf-8?B?OVFmcCtoOWlNQ24zVEhJLzZicXplNzYyRHFwT1laR2djZjgyL0szdkFNTzJo?=
 =?utf-8?B?TG04dTM1TG01SVdIdGVld3BlWlZLZldOK01uM05NeFZJMWpwaXJBNHFsbDUr?=
 =?utf-8?B?OXB3Z3VYT1hOQXZVMnkvWThLTjNLWExQS1NPMzRlTjB5dDFjUkJwdVZESnY5?=
 =?utf-8?B?Q0d6SnFpZUlNNmtuZ1BiQWY1Y3g0ekFkZmIwMWV4TmM2UWppK25PektFVzBy?=
 =?utf-8?B?WStsZUF5TExsK3l1V2VGdklvQUdvaXFUZ0FyNzJJeG9vQ2twWC9MV0I3MlQ4?=
 =?utf-8?B?U1NVTXViRWd5bmxhMXdFOGNDUUZabUtTQjVJM1VFZFdLamZvTnFNemJzbFJ1?=
 =?utf-8?B?bjVhSVhQVFR5bERVTUFPeGNCbVNFaXNVSi9oQ3A1dUV3ZElFZjlTVHFNTkpW?=
 =?utf-8?B?Yk9Vb3FEYWhnb2hCOW90ZlNNNUxLSnc4R1lpcWFqaE0zdXVzazJjMmVQbnFI?=
 =?utf-8?B?aU5FNHo2L3UzalM2Y0hwSHlZZDV1MzJQdzRJeWYwOWJNWk1JR1NZY3FubDlv?=
 =?utf-8?B?d0piU1pSU3ROT2gxcEQ0M21pd1RlbEhpRjIrTnhLZ0duYSsxQXN1WXZqWHF3?=
 =?utf-8?B?ZFFxRERyODFvSWRWT1VQWlRuRVRSVGtzeEtqNjZwZXBNVGxrZU5Xb25GeEpD?=
 =?utf-8?B?M2lDaFgrM1RlYUJkK21iTkkzMWk4eEdpT2hKQy9wVmJCM1loRE5oUXQ2bVZt?=
 =?utf-8?B?eFIvcUFwWUppU0MxWGFxWEpCVEd0TXhkYTM5ZjZSbkF3VFhRTVdiZnRjaG9x?=
 =?utf-8?B?SVlRZy9obzlzRXRaWVNYTExLVHNJMFg4ZTlsWVRmZm5Vc3FJU3YwbG1LYTFW?=
 =?utf-8?B?QnpINXFHQkRMVDhVaXloNWF1RjZaSFFEZWFPOE1teEJhalRNOU9TMkcyVVk0?=
 =?utf-8?B?amFkYVFKNzlhUi9leFBZZ0hzbS9rcjhkTHVzeFBVZExXV0xpOU1Gd3NiR1J5?=
 =?utf-8?B?cktDUmxuZWVmWVBxdERPbS9jT0hBSGNhdVF4QXhOU25IMDBBOWxXazJkb2xt?=
 =?utf-8?B?UTdDQW5YZDBrV1RzTld4RjhBT0ZoQmVkM0pZN3dGQ1NDNlcrajhYMTNrcVVa?=
 =?utf-8?B?UThSWUp6OGlRZFdYZU9iaE1nMmZrZzlCcUlmd1U5eVBXaysvRkRMbnZRVXRX?=
 =?utf-8?B?NTFwNERuM3U4aDk3TEJES014R3lQVUNhL2xsYTZaTjNOTUJPQ0Z0UTh1Qk5h?=
 =?utf-8?B?WkRZbWd0RytKT1poMEo5RHF0aXY2MGJrWWNhSDJKbC9ZVTArcUlzV2JkalJ0?=
 =?utf-8?B?c3p4VDVvK0ZQdXlReTFUcDI5bVJwQldrZFh5Tjl1K0p0NmFiSCtHSjg2UnNa?=
 =?utf-8?B?dzJIdk84TDI2aG9ZY2NiL1c0T2Jib1VBaVJTcVpWOFIyUk1hNzRxOWIvTmEz?=
 =?utf-8?B?dGhsTHlzVFQ2NE1mS1Zjblhya2RhSlF6cUFLTEhzVXN0SVVrYmVyZm9SYlUw?=
 =?utf-8?B?TEIweHBxQjRNcm0zWE9KU01BMkI4c0lyNFFWVzlJdGxQcFJydzZ4eUJDV0th?=
 =?utf-8?B?aDJXNHBmT2lUOHpJeGd6Y3VYVDVXM3ZSSkI2RHN0UnVOblBrOHNXYXFyd05z?=
 =?utf-8?B?YnNxcjJsZHFyN2hnOUl2TEF3Y01VVEMwSDREOEF4UDRPbXlCUXVmRHpYa3Zj?=
 =?utf-8?B?R0lNK0hXcWhLNDJLQnN4NmtCQmpGM3JlZkRaemFCNUtBeHVQdUhtUmxoU3ND?=
 =?utf-8?B?YWh0Tnc0aDVzQ1ZGQklzZmtBTGZNZER2N1FLL3pNbzdFbkhUV3R5dz09?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 464cfe56-abd1-497a-afce-08d9b893e961
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 08:39:26.7301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VmJVk6jSFKcuM9uT2uVHbLjmfF0ZnhgtcYxgOknGoL/ZwXEOTk9FmlUxPIWaUwcNPk/1BFT1T09q8yGgZi3n9usSKZz8WhDSS/7oejgjGgg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4094
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06.12.2021 10:06, Damien Miller wrote:
>On Sat, 4 Dec 2021, Fabian Stelzer wrote:
>
>> > I'm guessing probably not, but when it comes to something with security
>> > implications like this, it pays to be extra careful. I'm hoping somebody
>> > familiar with the ssh-keygen side and how the rest of the parsing works
>> > (like Fabian) can verify that this is OK.
>> >
>>
>> A good point. I just tested this and CR is a valid character to use in a
>> principal name in the allowed signers file and as of now the principal will be
>> passed to the verify call `as is` and everything works just fine. When we
>> introduce the patch above a principal with a CR in it will fail to verify.
>
>Are you sure? I thought that we split principals in allowed_signers on
>most whitespace, including \r. Follow:
>
>https://github.com/openssh/openssh-portable/blob/e9c7149/sshsig.c#L742
>https://github.com/openssh/openssh-portable/blob/e9c7149/misc.c#L452
>https://github.com/openssh/openssh-portable/blob/e9c7149/misc.c#L408
>

Sorry, I should have mentioned that I quoted the principal. Within the 
quotes whitespace (and \r) works. Since find-principals then returns one
principal per line the line ending issue can come up.

>> I've added Damien Miller to this thread. He knows more about what the expected
>> behaviour for the principal would/should be. I think at the moment almost
>> everything except \n or \0 goes. Maybe restricting \r as well would make life
>> easier for other uses too?
>
>IMO sensible content for the principals section would be printable, non-
>whitespace characters, excluding wildcards ('*', '?'). ssh-keygen mostly
>assumes that the file is in good order, but maybe it could be stricter.
>

Ok, I think we can make sure of that when adding principals and use Junios 
suggested patch for trimming the \r at the line ending.

>> If we add `trust on first use` in a future series I would assume we use the
>> email address from the commit/tag author ident when adding a new principal to
>> the file. Can the ident contain a CR?
>> Even if it did, I would only allow a list of allowed alphanumeric chars to be
>> added anyway since a principal can contain wildcards which we obviously don't
>> want to trust on first use ;).
>
>Yeah. my mental model for the allowed_signers file is that it's similar
>to ~/.ssh/authorized_keys in that it directly controls authn/authz
>decisions, and if you put bad stuff in there then you're going to have
>a bad day...
>

Thanks for your input.
