Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1BDC433F5
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 08:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 482B561057
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 08:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbhJYIdj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 04:33:39 -0400
Received: from mail-am6eur05on2059.outbound.protection.outlook.com ([40.107.22.59]:18465
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230019AbhJYIdi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 04:33:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AuJaJ3aSE491eWfDiVKwOqDUR46/odkEjvr9sBpW6bO5cVhiMNhp1qUXJexQUJLa6ylVms7LS9mF/aQVWtZq77yykkOwH00JZsn+Xum+u0k/pikU/r0LQIxWHYLNEbSSzdVh/iugSnrn5V0voeKa7XR8Q7bKw4FAwWe5qR9wePviIFL+AvW2tqRUpSXfAlrzR5v+DfNBJsbZ/t6qx209U66MHCA7S54eQYAb+OMNMj8W/jQzmGHbpBCgAluTsfqmRd2/JyCorf6h/SoM+UkcPKNKxZUWijbhMIbnfZxz4mo+6tHI+GoEpmlzHhPjbIIcTYGTer7dDaefYNMnWVcP+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sjgDHCpL1yI3uon/zcfICd1LWFv3V75wCoCIjV4CY98=;
 b=fO/KKeafeR8ZjbrhuGCKiBQJr6OpgM6oyCSeBRtVfUq87VUdIyxNI/UXYp5CKqxmTV5d74pwB8vwaXdvj1q/ngv8KaQBMh4izKmaZGCy2C3P9YPOCnEB3VZ1Sya++7NhDERrc8ccEwWm5y6rTYY8IiR2nIOK24eiSaAGvd5looIMsSNCUntAAfSJCgTapAg1Ss0voW6g+8xpZlyPddJ+m+mYpI7dY2Ex3YLDYMZmxkC9ew4obFsMoGKTvCekDMxCH0D/Q/zTlFT2djKWFiK4wwv+S9wlW06vMMrSKNXFqMl6TK8M7Ew/gZpx/z4ilwKD+lBubcAonBayjj6wx/gkpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjgDHCpL1yI3uon/zcfICd1LWFv3V75wCoCIjV4CY98=;
 b=LQ3w9rTXQ3DbB2PURpWN/R6ssqpbnnG4DfXYC5ARNAEX7j6Gp2b3lkGc58l+mH3hkD54a0tGANJ2pXKTa/rZB/Y1fLGMlJcGXWdRCUnT7vkU1E9UKLQ/Fd2I3fPYvp0EIulPrcsKND83yZUhfNibGpNLoBmp//+aEFm6QEDIr84=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB4173.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:94::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Mon, 25 Oct
 2021 08:31:14 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939%6]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 08:31:14 +0000
Message-ID: <51099904-a962-eb23-8baf-9ce15fff7d10@gigacodes.de>
Date:   Mon, 25 Oct 2021 10:31:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH 3/6] ssh signing: verify-commit/check_signature with
 commit date
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Gwyneth Morgan <gwymor@tilde.club>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>
References: <20211022150949.1754477-1-fs@gigacodes.de>
 <20211022150949.1754477-4-fs@gigacodes.de>
 <211022.86ee8dj6uv.gmgdl@evledraar.gmail.com>
From:   Fabian Stelzer <fs@gigacodes.de>
In-Reply-To: <211022.86ee8dj6uv.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6PR02CA0005.eurprd02.prod.outlook.com
 (2603:10a6:20b:6e::18) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from [IPV6:2003:ea:5820:600:c042:75a0:fd5e:1472] (2003:ea:5820:600:c042:75a0:fd5e:1472) by AM6PR02CA0005.eurprd02.prod.outlook.com (2603:10a6:20b:6e::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend Transport; Mon, 25 Oct 2021 08:31:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05fdf807-fbca-463a-0f15-08d99791cecd
X-MS-TrafficTypeDiagnostic: PR3PR10MB4173:
X-Microsoft-Antispam-PRVS: <PR3PR10MB4173F23F57DB2DC159DD1348B6839@PR3PR10MB4173.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UvBJSw/rQonrxHHwwGBrxtRGpU4bjxW2XMocSZ+wsQzlhKY+ylHf5MCd7Nisx+9uZo6cXkvedglr4irRxjBft8NYfri5ggPI/M0xsEx1gyRIzMNaQt2CyYe1coIY9NaAie4natJbxb6DuBPZi/SNY8+3ljDKzbYxf5ixGLQhS85Lkf6sUOGaC+t0TR7u4lZc3703gK3BWoN73cNcWb0nOUqVdQj0qJgAVDXNkragzFVPBXZos2NJCQoL7aDfejGKSLSmARejpHvyz9MayBsYuJBRU+SgTiKRLcZrZD2PDqbInQ0w7B+id5o9SbgiRKpaXqbKHKg7zUFIIEE4wnRy636dlvNXfF9s+PysUgiChba1l0ktTdY/buFFWnKVZ36T0ADu4eOlQXmEk60UVYm+hs5RxI12enGtI5ueBG1uoobLYe1GHKR565pSeNBTweoLwgwEQtrS0luk0R6WvCXzEW/BFfqyyQECinuD/VzSj5q4Ge5OaUcTB+jCg7RKTlNWyHXRI7Vh3AVU4dPm6LjUA19okE5FhPMjO5NDWaPpidz6TFyPylc8FguPSJuFVgiLoSAYCEByK2qkjON841RLuPre17zXJNifn/ZNiio3paMG3MxMNuwKLE+FIi1iTTQ6VprFZsaiRbd+wM5BiqNjDvph5INmBFomOGyVtI7jdXM+DTbxRcxuFlZbEpORSDIykoXw3d3ilRzd8WAoFoaqiAG6S+ADsImMNrCNs+TmtU4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(39840400004)(136003)(376002)(54906003)(5660300002)(53546011)(31696002)(4326008)(86362001)(7416002)(508600001)(186003)(52116002)(38100700002)(66946007)(66556008)(6486002)(31686004)(8676002)(66476007)(36756003)(6916009)(316002)(2616005)(558084003)(66574015)(2906002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVpqalYxUDhoM0xWcEFKSWpsY2dsZzJXcWxYS3BOcEZ5b2htTmMxczFIYThp?=
 =?utf-8?B?clB6VnNIb1c5RnFCTEx6K3poM3FVWmdEMEJUZkU0aWZFeElKSFNQSVQzeEtv?=
 =?utf-8?B?RkRoWWU1UjlVYnBxREM1aWJRdGE1eGcwVmZyTWVsNHl2dzI5WXE1T1VxeEFF?=
 =?utf-8?B?YmhGcnpJeXR3RWN2T0E5eHZyanZRcXZjbDgzektKQTJYNi9ORW15VVE4akFT?=
 =?utf-8?B?Z3lkVExwVmpYTU1yT3lSWFFFaFRwbzVqWVl4d0oraEhvdURuRXdjNlA0RDV3?=
 =?utf-8?B?Mloyc0RmdVppQW1pdWNVL0hUclZiZTYzZFpDWG94ckxTWFZ6S05IOU1aZmZ6?=
 =?utf-8?B?OEk0NUFwa1hGK2s5eFhZckRSR0RldmZBSjdRaG9WVU1tcEF0VUJVRExnaXBl?=
 =?utf-8?B?MG9ya1hKMTNZZk9Jcm5qd0VvSUNGT0E0SzdGaExKYWpyV08wWlc1T1ZsTEU3?=
 =?utf-8?B?cHNQdDNobDVYRGpXN2pFMHJVZjY0V29RZk9GbUR0RlVhcXpBMHFnYXdVTy95?=
 =?utf-8?B?YmJ1cjBNZmRaOThKM3I2emFmaFJURXJ4ZVNNZVhiNy9Ba3FCUkJVUGRxY2R2?=
 =?utf-8?B?bkVmZUt3SldoalFsL1A1allremZaYTgvV3JNYWw1NVdaNVJWc0ZVRHZzdERU?=
 =?utf-8?B?emMrRG9nc2NFRUwvVTRiMVlUZDJNWWhKTGZpbG5EdWtZZW5PSDlmczNXL3BY?=
 =?utf-8?B?elZkY3NZd3Q5TWxScExyR0xTMzBiTXFHWDlUMUpibVhtSHgrbGFwdW03ZWZN?=
 =?utf-8?B?N3dIRncwbjZ3ci9mS3orQVhJTDJDbVlocWNoYTlYMkxxbzBoQmRQMnJLWlFj?=
 =?utf-8?B?WUJib2xFcEhUQWJxNmNFZ1RkVkxjalR0cU5GYUpGNTd5cURuTjdxZWxGK2ZF?=
 =?utf-8?B?SVNrT2NYY2o3eitHRjRQM1BMeHowdmNyWURCejFxT3JTTHRnOXdYWmh6dGZO?=
 =?utf-8?B?UjNySm9jS1lmQVNSd3drNnh6VTVEQ3l6UmtpdlJvVHhFblpWcTRrdVI3dEVY?=
 =?utf-8?B?ODBWZjB3c2d2MDM0VFBOT3JQN3VhTjBHZ1czSjR1cWV5VjI0N2t2eEswc21Z?=
 =?utf-8?B?WVRYVmRDSkNsOWJ1dTBMdDNuZjNrb2Q4VEVvYm9xR3pTWXduYlgrSkJiU0Ns?=
 =?utf-8?B?Zk9KcUNUM1RZMEZ2bHNOSDR1REtVZkRJenFZVjNVdU9PeVkzeFZlTWZTZGU3?=
 =?utf-8?B?MURjVFVpKzRXakozcHppeXBWMnE0ZzcyV1dZMHVyWEgzMms2Vk45MDh0YzdR?=
 =?utf-8?B?Ti8vL0lzaGZCZE9BRGNabzMrWW56L09CVFFmVENqSlRDZ0M1NTVZMzNwZ3hG?=
 =?utf-8?B?cHNKcnE0ci80ZXY3UHN5NENWUldGUGhjTzFNWXgrTUVNcE0wVDAwUXRUOEs1?=
 =?utf-8?B?aFl5L01MOVk4VXNwVHl5b25GRXdkSDh6c0tnM3RwTTJMcXdQMFRPUzFDTHRj?=
 =?utf-8?B?ZHpUUEF4eWpXZUJTcjdyOTB5RUhGcUdaVTFDMnZRMitJWEt5QituYTl5bUNK?=
 =?utf-8?B?TkR6bnBjRDNaK0tjVzBITkd3V3Q5QmtaTXNHR2FDL3ErS29yTktMMHovK2hB?=
 =?utf-8?B?THhlS3FveWkrY05wYk1NYmpQRzZmbkVpVXVZM0VBaTZnL1o5T2wxUEI3M2tn?=
 =?utf-8?B?WkRtcjlDdzhRZzF1TmVwQXo1VTYxd3RaOWxjM0s0dnF3WnlscXF1anlRMCts?=
 =?utf-8?B?bHhtY1FhVE1ZTGZXOFRnME9IT09BZG9CMm9majFpMmZmVmFQOCtwaktGck0y?=
 =?utf-8?B?Wk00RnlxMk5yMlVPL2tYMnBvenA3SDBZMjNxSXFLeS9ab0FNRVlHNGlUN0V3?=
 =?utf-8?B?S1JtbGRjUjRYWjdoZDJKWDlOZG5kZkJRTVg0S3h1ZTEzanZFaUxaaVExY0pH?=
 =?utf-8?B?ZFUzMjNLN1BieERPaWFaWUhibk42VlEyQTJDVnFFek1rZ0J2UXg2S0xuZGVj?=
 =?utf-8?B?bjMwZmhCeDNtWW5sM1BMUEFDUW51eG9uQUE3QnY0aVJ3bGpSYmV2RDJIRnpu?=
 =?utf-8?B?MUd6em4zYnF3bm91V2htaXpRSHdjRU5qSVdNN0l0VmVHTDhzVDFidXhvN0NK?=
 =?utf-8?B?elgya0xlRmhwQXBIVmdOcmRnTGRGM0ZEQTZpMVNPd09jMGV1N2RkWHYyS0gy?=
 =?utf-8?B?Z3ovR0l5NUhaOCt3TFdxbG10QzFkVjVXUW1US3p5QUx0NEU0L0xOM2NVT0hN?=
 =?utf-8?B?UTNLTlNNQUtsNjZRYWM2VkVRUmZZbDU2R3BpRExoekFJd05jQ0w0MHhZVGhM?=
 =?utf-8?B?bVJUV2x6VXBEWVhkd0FpalRmblYzS2xya2pGc2piYkJZMGxFOFVEd0tFT1J5?=
 =?utf-8?B?bnhxeitRbkZLNHFSTGVRa2wvL2JTYm45SlUzdWU3UTNEdUFkRVh6QT09?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 05fdf807-fbca-463a-0f15-08d99791cecd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 08:31:14.6796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o0bKB5/jKEiDxAYuZ/zGlO8KSUBospz6lrrxqWzeB2/CVgP7Rh+ZQfl/3t4egUf+HQKPGmNS1wSQEtgm3F12XtOa7+LKhlgjVJu8lmKQjj8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4173
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22.10.21 19:37, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, Oct 22 2021, Fabian Stelzer wrote:
> 
> [Just nits]
> 

Thanks for your review. I will fix/adjust all of those in the next
iteration.
