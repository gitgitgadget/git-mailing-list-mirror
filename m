Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D1DC6FD1C
	for <git@archiver.kernel.org>; Sat, 25 Mar 2023 13:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjCYNKI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Mar 2023 09:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjCYNKG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2023 09:10:06 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2098.outbound.protection.outlook.com [40.92.41.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702901284A
        for <git@vger.kernel.org>; Sat, 25 Mar 2023 06:10:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F++Smxa6x0XK4btdn1nApktymdwB19D1L7K5x5vrjCsguutCoi+Q1snbYz6Lq9Tx/p1QZQ/IH6WukShueEFojpHNQDglJQyuNfli4062MCXIEICbzpdigp8oI8ZvD7HxdyWjmvsgCaG45rKp6OcrB2nJKZJtz/axEX584wJ6Z0KbTGWMg3qJXpUCRJSAHsT8K1Uitr9VmYCDpQll8ZeLuSstK1KeeTqtAUjVGocCf2imAC2WzfeiV0WNsfGdl/B2/ZhHxPVKSG26nTq/PtDMVWNQEB8puM/9fhrt/yjFPhXAA3WkWwPEk6sJR6k7RhPcpj9iZaglbRBhAxlBNBoV0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+wQgefnQXxqPPdafdJRn+EhI3/62BVrtVsl/tBNyFw=;
 b=nb3WO4Vul+pbJqPinhlZUlzHVEoK3tk8IL8hBsbzpvRjXhZwjUNRazFndQBIedNXGUI9WJbss0Q/r5IdEw38BX13XVhd0KjXFgVu+k4Iz8ZeiKQVQlq1kXP5syoCqynuZiv4a+0HUizUTqMbvfGVyZGq9N0quXRZrh7phHzMxSs1uv46WoP1pF5P5JG2hMCXr5bvX8m1THYyQmaJHlm5iRWD6vguP68pWdjqOfVzDllGCG7Ck7UsIGPJeDx6RNdMw7mmFYEeAEOW0EOvjoyYdMf+JQwqZTCDbGx43ddCShNQAtWtUyC/ajUREb386tTRtCJHdYBnVpwGSbMZuvZryA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+wQgefnQXxqPPdafdJRn+EhI3/62BVrtVsl/tBNyFw=;
 b=vL2LdxMcXg3rzSxNwX+WmcJ3tUpJeik8gki6UhGeXSkobuM6SgpHsMYCNaUmMTRu8yVGYd2qCAWgjuTBllSo1c/qcCfJt3iyqpEkezjvoE6i63Mjc/6ruOpVpEMi6bN1px9VI4BMRK5/qZX4xh6etZYoOGQ3jV3sXPfTbh1BLHKyC8XuilUrNOBqLxd3DtCZb/xGmONwZyWLmXqTkPK2Vcfq+xNGa7ZppH8cski5UYHK3OnRkTxHB3sYEdJocuSWun7A6/Wgm1rgCNhKarDJImRcyjT2as8SbA0a/nAxBdXr44B0R1oyyQjhsS8SbIs//KcqHoQktD7xZMBE64SKtw==
Received: from MW4PR20MB5517.namprd20.prod.outlook.com (2603:10b6:303:22e::15)
 by SJ0PR20MB3642.namprd20.prod.outlook.com (2603:10b6:a03:2e9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Sat, 25 Mar
 2023 13:10:03 +0000
Received: from MW4PR20MB5517.namprd20.prod.outlook.com
 ([fe80::ae9:1282:c6ba:d6d7]) by MW4PR20MB5517.namprd20.prod.outlook.com
 ([fe80::ae9:1282:c6ba:d6d7%8]) with mapi id 15.20.6222.010; Sat, 25 Mar 2023
 13:10:03 +0000
Content-Type: text/plain;
        charset=utf-8
Subject: Re: git bug: Perl compatible regular expressions do not work as
 expected
From:   Mario Grgic <mario_grgic@hotmail.com>
In-Reply-To: <CANgJU+Vn8ZLGcAYbuDeNkv6T5YdX6t20BqGQDPB0VL_TzoGSWg@mail.gmail.com>
Date:   Sat, 25 Mar 2023 09:09:59 -0400
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-ID: <MW4PR20MB5517888E63C13099E284B97590859@MW4PR20MB5517.namprd20.prod.outlook.com>
References: <MW4PR20MB5517583CBEEF34B1E87CCF1290859@MW4PR20MB5517.namprd20.prod.outlook.com>
 <CANgJU+Vn8ZLGcAYbuDeNkv6T5YdX6t20BqGQDPB0VL_TzoGSWg@mail.gmail.com>
To:     demerphq <demerphq@gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.7)
X-TMN:  [y7ySrtvlzpAVzSHugCkyqaM6bAhgiiis]
X-ClientProxiedBy: YQBPR01CA0108.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::44) To MW4PR20MB5517.namprd20.prod.outlook.com
 (2603:10b6:303:22e::15)
X-Microsoft-Original-Message-ID: <D10D8F05-D6B1-4E43-889C-B01E6C690D20@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR20MB5517:EE_|SJ0PR20MB3642:EE_
X-MS-Office365-Filtering-Correlation-Id: d00ccda4-c615-4b11-ec3a-08db2d323ec7
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vdHbNv5dZNZm+lgtiClseQe/o9yC0oks0Jdj/FwAxumAK2yDWDYTQhUrAfjfV8d+qWo5DMz3vD0D/iE/bURzVOV+xA+ucu5S9YgeHyBAldOOaGH2iq+A5zVHdMV9NZhKKtcWxHV3Cx0X/5QBwrSeurElK2OH9T9cwvI79CRxDd/brl0xshrfN2IxOh3rwV5Y+ey5+n91Dape6nEMe3wRjPc9nq9MPXo6xXpgm7kbQ5nadvi+Yh1+tQime6szDHcJq7uEm4yAcXafeGHj/+Rq/7zHsawiZlCTPAk8WbyICbuI3HZZliyYbobznQB3b2RzShFuisPnufvUE+zYNHypZ18QZo/7TIbdHYir04bkdYDj2jXb8QstLTQOEJArRI6CEd7HNx/MxmZ/Vlpil2Y7BSSsRvME7NiZPhNgX6rCWZ0uliOo90JuX7dZDR3VMXoU5xlmfIHS70rBm2NUtoieXoKyOHYVyVMvzCijdVPhjIJm0wiZhQ9Vupl5XzChXi5RnjVcGmfBmCa+yygweMNDy02IRm2NchmiXLg+wldH9pW5wdipmAKAaDgbrwIoKn7abkgY3R7aYcYXdyznG3LqLyRvAp4Fj7loSuDRyWY9ljOMPOBnl7wHH61B25hvwa0F
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzZsWUtPaUNJOC9JRWErc3BzSkVQbCtFV3Q4TXB2enh3RGdiUjllY3FpWEFi?=
 =?utf-8?B?eXE1SEVDQ0VFY29DWlNkeE0xNi82RXMxTmtBLzlDZk5IS01kUW93K0Rld1Ay?=
 =?utf-8?B?ZGZQdmZ1WVMva3FuUjVNSFE4a3FwYlpDSHVPS2FhSUR3cys2b0lwOWFBTkti?=
 =?utf-8?B?MzQ4elVNYWxwK1EyS241SHE5c2ZqUTVjU2lnTy92OEduazQzbTk5SzRvNU8w?=
 =?utf-8?B?bEpqUWhBRGxPbzcxNnZsdExSR3RPOXFnR3JkcXZ5ZDZ6Z2grK3FkS0wyYXE5?=
 =?utf-8?B?eThiWkdCVElXejg2eDRnMDNLa0VBV3BXa0V2b0ltR1Z3OWlWVnkzYTNwdkpk?=
 =?utf-8?B?SnFCcDdwYkZTczBOWXNzMU9QZXBYcGpwRE5oLytFV1M4eUM1OEphM3dUcmZt?=
 =?utf-8?B?M3BQTlQvWlFHdDJFcjkvaXU2Y0hKNWNjWEpEWHd5WVB3aUFtNXRkdHV0NGdH?=
 =?utf-8?B?aTY2MnhIS3o2ZG0yQzJ4T3dCWjh2SkhvTE8zaFYxYkdpTC9qUkV5VmFUYXc1?=
 =?utf-8?B?UHAvOEFoSU4wN0pyR09YRXNQNDI5cWx1QW0wZWNuMVJWNEFvWHFRNWxYMnZz?=
 =?utf-8?B?ak42UllTc0pkODJqL0pnekhmdEZRRjd4RUpYY0Roc1VaMWs4MzU5cVdqdGZ5?=
 =?utf-8?B?VU1XWGIxTU01ZVdaLzVCL2s0cHQ0a254NFV0UmxoOENaWmxnMDRlTHV5emRE?=
 =?utf-8?B?ZEFhc1FVNjdGNiszWFlMbTd4NksrYkVVT1FzSFRVY2xmd3VKNUU2d2t3V1FD?=
 =?utf-8?B?L3R4WExaeVpiNExEcS9vanRDTFc1a1M0OXQvR0hBSnpVMjFXNlBhMW9OSjBQ?=
 =?utf-8?B?V3h3K3QwY1lLMFFYWlphM1dxQkxoOFM1bnp6bG8wR2prNmdEMldTL0V6d3FQ?=
 =?utf-8?B?dEY5UlgwZ3ZGMXFrYk1HUnNJQzdneUlHZWZ0Y0tpN1R4YTVpZmt2SmRmTlBT?=
 =?utf-8?B?TXBzNHZhMWtJeHFmNTJTTzVYdVBYSEZrQnpTZnZrT3FDZFhxNlVQQlhwZ2FZ?=
 =?utf-8?B?Zm1zUjhqeHV6MjlUK0RqZHk4aTFFUjIvcUFGREM5V2hKVTdEcm5LaHIzUVlw?=
 =?utf-8?B?WjFGTWJjaWREdVkybU5YdmtWVUhUOGp2cUU1aktGYlpWNTkyMVZjdThSMWFj?=
 =?utf-8?B?M3dacDFGbzZyVE9DUUFIZ2JSbHFqV2hRc3Rlc2dKNTFmaTgvN3liOGk2MUtI?=
 =?utf-8?B?anllbExWNHAwcVZBOWdyUHQyWU9pZHBSa3AreGdUUE9kVjVOWEp3TStNRW5x?=
 =?utf-8?B?L3Q2cWhXVHFBYmRMWVFIR0tDWGNVdmR2RmpUdDk5WHRXaTZaaVVXOTRzd1dh?=
 =?utf-8?B?dDBSSitzbWNRQ0UySng2NTJDSmxoTkJoVW5XTFBRWEZTelFUVmoxcU5jK0pG?=
 =?utf-8?B?b1lwSHV5czZSYyt5OWk2bUFlRTYyOHJxTzFTUy9HR2FxMTdQWU8za2d0d0tG?=
 =?utf-8?B?TFNJbHNYYkNhQSsrNDZrTHFFdWxmQUVCTTA4MmdwL1B5VG1oSVZvZW5Od21t?=
 =?utf-8?B?SEVTMHJzZ2YrbjgrcEFqQmJhb1JGeEppWVBNR2xsZjNQaUdEZzlxRnlDcllv?=
 =?utf-8?B?V3YyaytVY2dLTzJCdzNiTFBVZ3VveitUdXJtTlFEeW5kZkZnSUs1d2dEWVNl?=
 =?utf-8?Q?ZanJvMZ8V+fgs9HSNMSfYw+/VDdB2JpmKXm3klot6WbU=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-9803a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d00ccda4-c615-4b11-ec3a-08db2d323ec7
X-MS-Exchange-CrossTenant-AuthSource: MW4PR20MB5517.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2023 13:10:02.9922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR20MB3642
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The lowercase -p is to print the output in patch format. You can rewrite th=
e command line as=20

 git log --all --patch --perl-regexp -G '\bmain\b=E2=80=99

I still get no output in any git version after 2.38.4=
