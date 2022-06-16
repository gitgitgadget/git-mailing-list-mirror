Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9B3C43334
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 14:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377520AbiFPOFh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 10:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbiFPOFc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 10:05:32 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-oln040092075056.outbound.protection.outlook.com [40.92.75.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D613539825
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 07:05:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dtONBkbfvaK01xdUDWOYTBavPzLYwHuqWdBqf+MhiJunEdXzGK525MUNkN9ZK6CcSAvSEai8Q+r54PiM7fvVmhBftZeM5AgsNmZiYqIBdFqCltCI784KXljznJjKgqDv36QURmFVSgrPWhmw+FhjKOUfYsmYmS757a0tkCqJIlOJkcjYP92DRc8NOfcjxUSig08DbjKJN0er1f/hnACP7X/Fx5CwmdtE3kmVrFanX5FtmabMujmmwkRyq9HRefPAelmt+q9sj4aWuOafOD8waOkhzgwHSJbOZulkz5spxCuG/SbqHp18+1ghl7jEwopzo3rLkU/LH5cWF6BbN42kRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eLRyyJNDqmjaC+bBlX6NOgGU1cJ2l6rjqAdElKVvIXg=;
 b=Z2qB1VlJIAcNS19mgETCBXV6RVdjffUeC9DTX+KsDb0Fea1QZ8iAoN9oKXCthmAk7dm/vjqWy0A6FjNGauqVTjHD+720UwtnOB70Hb5M5LsBebyXUP8YnhSTAIi4eHtc4sM3oOId8iQ/8v/UtpQXeyPwdp76XV/0TLD46J5ZOYa8muas/ZEHQnXCA6iXrpg6Z3pdPx7B80xYBNG+lnAxvZiOpHq+0r7p9aw8f9lDkIkRYQUppWQahRoZLaMhhpjMmlm3cVAriWj2d3YMxidQuQIa9ebIy082xxOFU/ohfKr5wXoFKIDXObdh2AGhgkYGwKyawIKYWjh1P1OIJWEEXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLRyyJNDqmjaC+bBlX6NOgGU1cJ2l6rjqAdElKVvIXg=;
 b=TPiNX7RBX9LbK7DuPPfhiA6q9nEWtVYiJRe8a8DHwXlvPHddA3gd4anHGHuP3x55QV0U5ci/pdCsZnQ3KlBmoq34NTyR61czD6SpFvg/1v3wPB0qwWaxpcS9n1R/Ng/3LGPvup4te4Ua8cDa77wAaglCQip/C8LqnQ7u7/L6ZfcW2ccKHQsm7gs4093pxx8quSqhdDYi3yvtibF8aEyp/g0QT+L9nq1S6HBImQdJ9F3mnLDI0WEuLqm+pyiAkRC6NL3/3IwknusI5mDGriimC9tm3vJs3t3K1Ur9zUwnQ8USsxKo1/wnRXMQw/ONHeppS5GTEBqzXKrr8zS4OPLBmQ==
Received: from AS8PR03MB8689.eurprd03.prod.outlook.com (2603:10a6:20b:54e::12)
 by AM6PR03MB4918.eurprd03.prod.outlook.com (2603:10a6:20b:8a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Thu, 16 Jun
 2022 14:05:29 +0000
Received: from AS8PR03MB8689.eurprd03.prod.outlook.com
 ([fe80::4561:15ad:14ab:e95c]) by AS8PR03MB8689.eurprd03.prod.outlook.com
 ([fe80::4561:15ad:14ab:e95c%5]) with mapi id 15.20.5332.020; Thu, 16 Jun 2022
 14:05:29 +0000
Message-ID: <AS8PR03MB86896658C0807DF7F03ABBFAC0AC9@AS8PR03MB8689.eurprd03.prod.outlook.com>
Date:   Thu, 16 Jun 2022 15:05:27 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [ANNOUNCE] Git v2.37.0-rc0
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqwndk10gg.fsf@gitster.g>
From:   Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <xmqqwndk10gg.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:  [/8iTr2eGbkW6T1PXkI2brnEx09JoPa9fdtGef7ybRmE=]
X-ClientProxiedBy: LO2P265CA0127.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::19) To AS8PR03MB8689.eurprd03.prod.outlook.com
 (2603:10a6:20b:54e::12)
X-Microsoft-Original-Message-ID: <67e81ecd-55e8-98fc-4dbc-a294fbb4916b@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91046905-7bde-4eb7-a9e7-08da4fa144c3
X-MS-TrafficTypeDiagnostic: AM6PR03MB4918:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: smXaGBvDfLnoVT63yGoI7IQabn8qalOrQPQd//u++vSahpdT7Wfmqkp3Jvt+wTmJp/yNwIjxA3QjepMlZvJZ8Ka5EbOUs2Zj1hA85rzH0eHpdaXqQ7WnP0f0phy9lqcDliNbTBIwA74bnYECuWYEa2ZfglG7tc4V9V09fZeA5bjPinJge6ZUVqqD4N4OSXpF7WhWyvseZjLRbsJy7008xaEYVvzjele8IVHy1xJhuHExkQAPolFdHTWWyScm9gkWXwgf3p7CivsfxKMR4c6yHQgG6ZRgpgxf09bf04FXVx5H/IsCoBxwmxmpEkN3HRTexJ4iGkegPSBfqR/ADpjGtrGk9ZPHiPo6cBayt5njLgreiJ7muBdBxjVtjyylRXGaiSiNQ/cDb5xrjyEwI/2+XoByaaZobUimNKqokd0g7R1gbRcIhvfKdVask5zMVk+u6r1ls4LYF1HvvBIHHUYoN1/EXmDmTGFeKh5hE7ymyFvbsFhGyDa6bfoxlFoJrJ19zWSN53KQbSflHdSYRHm5W6cfKFCXEtOm04hIhWab8aeVI8QOvNtXfo5ZZSM6LeXhUcqdxRad0qxPmQBaRVyjiXXPzW1HWETK8Y8LVk14EqxJue6eyhYYXuZpJ1skNTf6
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVAvMU44UUtjUXpwc2ZVMFU2bVNqbHRXWDRVT0ovN3h4cnl2NjhpdW5TMEs4?=
 =?utf-8?B?RXFia0RENi8xejVTM3R5YXhLaWdmeUF2VjB0NEJTaVE3TVYxaU1aTW5SUlVl?=
 =?utf-8?B?NUxKZmhabjVoR1NXOWZuWUpzeUdvclFJKzFhN2pNNnBFWGs0MDRGenQ2d0lk?=
 =?utf-8?B?ZUxkZUoxZk9JZDQ5ZXRBalk3VjBZOGdtWWFCalp1aXFWYVg0MWNYSnMzQm1J?=
 =?utf-8?B?cW1ibU5rZVc5OGR3clVFUWt6ZXBwKy9LaWYwYlBXN2NWNlVSMHMvNjJxeDkv?=
 =?utf-8?B?Y1V4RzJQYy8rVzNqc25CbXFRcGFKTXpCNFA2TUhKM1hFVDVmRDJTWSsyQXlW?=
 =?utf-8?B?NnBYZ3J5NTI5Y1BEVkNyZkI0a0U2cGRPbkFWcm96WjhxMnoxWGtpMlMvYmZa?=
 =?utf-8?B?NUh2dXh4dVpaRUE2RXU2ajRudDhpTU5iSTlnU001VmdSVm9xdHlEd0EyV3RQ?=
 =?utf-8?B?T2ZQK0p5OVhvWlBEMU5McEZMVklNS0lPaEJRQmtib1pWclVYeGk2ZlFMWWlZ?=
 =?utf-8?B?VUIxSHdZaEpMdzF6dDdYSStmRmw2STJqZzRMUkpRZy9QMXlUUzRveFFqY3Y2?=
 =?utf-8?B?QllQQkNMbWJIZ0RjZnBTTjRHekpITzh1YTcvbHNLdjdIV3ZrUGhCSnhObmdm?=
 =?utf-8?B?anI2TVBQYVhOWC9qM011QmdNaGtkbmR6cFVveitNOFVLWlNYZEgvKzVtNjJz?=
 =?utf-8?B?dnpEZ0RUNUJIZWl1YUlhVEVZY21yKzBlc1J0YmdNMWRodFR4THptTSs2eVNO?=
 =?utf-8?B?eHdrcVh4S3dCKzdtVzFKTENGV2Zjcmc3R2orVnZabUVjU1FNMjArTktmMW1n?=
 =?utf-8?B?VkVCVmN3dk91dDFXVmZWdk1QeVFnaUlGNDI4RWgyeCsrRmNXakRSU2tWZFpt?=
 =?utf-8?B?bWVTcFhCWHg5Smt0dERlY1JSYnBFZHhWMFNvN3pkemVNWUFxNDliVEVOUkpj?=
 =?utf-8?B?dmdmNkNEMVhRUTBFZ3ZOZVphOWlPREViVjFWcDYwaWM3cDNtTm9QKzN6OEdM?=
 =?utf-8?B?L2p4TW1nM2lZUndERDlEUVdmemR2RnVSNkRpYlhxQ0prcGhyVlExVjVQTzJ0?=
 =?utf-8?B?Z3A0cEFZT3owOE5Wcmh2U3NMWmlST1Ercmd1MVI1RjNLb2JORittVG81enhJ?=
 =?utf-8?B?aDRLVVR1bHdPdndydm1oL1Q1U3VZVkpZazNITGtHLzZ5YWlnM1ZFMnBmdHdn?=
 =?utf-8?B?My9sdkJ6MlBNSm94bmZ2c1ZqT24yUWZRVWJBZSthWnYzN3VPa2MxZm9nUFI5?=
 =?utf-8?B?KzNYSzJYY2tyMmZ1ZnYwbDhDODlJSzArNnlZZXpzVXVaQUI2ZGw2bkxOVU5G?=
 =?utf-8?B?VW9DYnFlWjVscEg4UlFPMVQwbW9TL3hKREhYd3hIN1FNbU8rSjhBTU1Mb0cx?=
 =?utf-8?B?clJQOG9IenpwNzIveU4yQ3R6UUlqT0FySVo4MEJ6eDJseFBtSEQ4Ykp5c3Uy?=
 =?utf-8?B?NkhGODB6bzk3QjJqL3lGSzVMRWNXYnhwVmRmdXpPdFQvdTBjQ2s5aEZSNSs1?=
 =?utf-8?B?V284UThIYm1iM2poL1lFZE5MenVISFB1VGRSWTBOMmFjdGlHOFQvSVBpMXFu?=
 =?utf-8?B?SU5lR3IyMVB3bEJLbEZXQ2pyT2QxMGc4VkZHdTI1MU15YzJFbk5LaVY3NWIw?=
 =?utf-8?B?RTAzUmpWUXZWY3FmSm5RR3hJaGh4ZjFNV0hjVzk1Yy9SV0IzemR2SUI0ZWN2?=
 =?utf-8?B?QlRFQ2hsYWU3dnczYTJmN3BLRGtNbURodm1ZUGFFRjNieTBKNFRKdjhCMEpH?=
 =?utf-8?B?NWFWcWxtMXdiL2NmUWVtbGhIMjl4ci8wdUQ0dmVqcFF2NHM1U0gwK2dwcUtL?=
 =?utf-8?B?RUlxQnJSVHNyNWlITnJaY3d1dWhzYnJCUmJGMjJvdmNhY3RTWFdZMWJFc3dG?=
 =?utf-8?B?eTZwMVl6ejl4OThvZC9LRVZ6M20vcHZwVGd0WmI2bHdqZHplWDFPclpKRUdC?=
 =?utf-8?Q?6nwreOLdX425YRCVuCo4G+MNrsL3t7M5?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91046905-7bde-4eb7-a9e7-08da4fa144c3
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB8689.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 14:05:29.2098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB4918
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-06-14 02:46, Junio C Hamano wrote:

> An early preview release Git v2.37.0-rc0 is now available for
> testing at the usual places.

I notice that GIT-VERSION-GEN doesn't seem to have been updated to
reflect "v2.37.0-rc0" as the version number like in previous rc0 
releases. Is this just an oversight?

   https://github.com/git/git/blob/v2.37.0-rc0/GIT-VERSION-GEN#L4

Thanks,
Matthew
