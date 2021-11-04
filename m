Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5CCC433EF
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 16:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33E2761216
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 16:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbhKDQ5k (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 12:57:40 -0400
Received: from mail-eopbgr80051.outbound.protection.outlook.com ([40.107.8.51]:50754
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231543AbhKDQ5j (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Nov 2021 12:57:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oBkgOUgnI03rnwh1I5MySsC0bn4TM58SsL1nyPSe3Ltl/HE9V9DbU1TD4DGHC1OxEovbt2DL4FcekbMH+HUhIhBdrZfbBjrHJep7kyGuqYoOnyVMMHrTeodKhEr10uQEITApZ+4SoWcGqBcIQUE7Tnii0DOqEps2ex+VmkzyAb3Hh1fJ2VUKV4yxzIaCydL4jbwSv0RHbOyfOGYkyB41grWaI7NS2wtwlMv5DYHKho7ZlUhc1gvaVi3/p+DjVJaASiN7QDf2kwX1B4bdvi0d9ueHogXEDC3T1f1/DTqIn2/Y98EeFLxFUlzCtpTgWILbD6VFIDHrmkHXbfx7MLPMGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PYMHdBQjCZMbRXs4CSXSmJKm8lsxmewQ57iVf3PXofU=;
 b=nu0wo8Lid4DcIzd+53Z65+Uv7H0MYhb3S1GCgNv3mqWEXKRztEdImYx/cGZomo2VcUt43V/ROoShz0B6W/kGg10hbTIRFTpxaaaQ95e6zoOqzkVCPRZq3XuTa/1zQvKbp+iPhAftUiQJsveK+Xfr/VE9cewSk+6+abKptPV/l0eEWhPDG3wJQLvGBFgQh6RgpLQCLlOCqrQIkS52fvkkqGpXpaIkf2u5sV4zKmwcjDyDSXjW3I/lJ54O0d1Dtpwj46DVO4VBcz1ecNzGeRYQCzWbxZmMkomDhS1HoJkVh8PWEqzU/ZUBZ8vhu4orwMkfB3QqhbliJhBOyBM/tTu8og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PYMHdBQjCZMbRXs4CSXSmJKm8lsxmewQ57iVf3PXofU=;
 b=dBfibzqDAHCfoQZbClODovaieUad9E/uTselhon6zFYMr8BqjhrNwvg0ralsr7npzISYS1E/xo/KiIpDjSKzqaQisOLuLmaX4NnWgGNSgwl/K6nP695EcX0rwFqkxVHwarFyxeHopIGp1d4pDErCDgveMdHVyidRH4JpIg2wFFA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB4221.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Thu, 4 Nov
 2021 16:54:59 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391%4]) with mapi id 15.20.4669.011; Thu, 4 Nov 2021
 16:54:59 +0000
Date:   Thu, 4 Nov 2021 17:54:58 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/6] ssh signing: verify key lifetime
Message-ID: <20211104165458.zphsk7jgdnyh7ybs@fs>
References: <20211027080616.619956-1-fs@gigacodes.de>
 <CA+kUOakzQ5aEQf81rQULiz6FRdmCLnbhspt9e6behPS3sbZT8w@mail.gmail.com>
 <20211103194558.xqcsaljvcoontnal@fs>
 <20211104163142.GA1419@dinwoodie.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20211104163142.GA1419@dinwoodie.org>
X-ClientProxiedBy: AM6P192CA0032.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:83::45) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by AM6P192CA0032.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:83::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Thu, 4 Nov 2021 16:54:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27c01969-472a-4939-7108-08d99fb3d62e
X-MS-TrafficTypeDiagnostic: PR3PR10MB4221:
X-Microsoft-Antispam-PRVS: <PR3PR10MB4221868E8CF7E9574A7EA22FB68D9@PR3PR10MB4221.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F2s8F5AWjWwcgjq2OWcNHQP3UNtYsfyTp5g1+oEB0gmYB+JP05Q1h+vJnqPMRjY1LkZ4HMprXvY/TL5te0kSP3wu6tn3ixMMxadqneWjyaog4MpWqQYoWeAeeQhOBz+kaiDvUm8TOjv0FXjsukPLdyERA5QuS8vuyQP8u7P18bjf5LNfy/xEJrrp49r1f1jm6qIXdWx1KO6qOtBa1V1c4bXF7TBcaHWHT7pc8VTs/Cmsrio5wfSVXa37qERSQvapcifAXwlV/ORlgPC+Qhsq92eRLHm9SwO31Oulda/47MeLxrzBTKHUUwhSo3qBNpu29xb9i4hrwIGoy853oVK/JkNhFD1DkZFDjpg/KxuoEChPe5yHzWDJHnjSuHGJNq7Y5kjEvxU4rn1TxpzXCyn6XfNsg2pphMXL6QAhqCj7a1dKztbwRKPCmRDbUszJVjJO3fmdp89+qz0jZ7/hTzriI14vnWAo6sh0cFi2CjwqpDzW70FjDew9BwSxgOCdEfJFMDKolBIV3cwi/cZEHbBcTiBdm5hcekYAso/7TdFsqtklm9StGUSNZA7Hx9AhsBJssIwcDP1o8u22x9niWTtPdlcxdOBBI/nNo2/fC3EBAioxj0y2vgd+WOl7Ox8NPP9LKkBPun3abVv9plVmTj6ldw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(7916004)(376002)(346002)(136003)(396003)(366004)(39840400004)(9686003)(66476007)(66556008)(66946007)(52116002)(6916009)(33716001)(508600001)(86362001)(53546011)(8676002)(5660300002)(38100700002)(4001150100001)(6496006)(1076003)(54906003)(186003)(2906002)(83380400001)(316002)(8936002)(6486002)(15650500001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlFYQVRJRzJ2UTE2LzJ1MnlTY3lqSEU1cXpnazNKYllEL0tkMjlXL1F0RlMx?=
 =?utf-8?B?QUNjZUtVbXpCV3hQWEdFcndCbGlXbjdjMnpkNWpGbDVSR0E1cUFLeHlFbDY3?=
 =?utf-8?B?bDBXSGpvR3lYeFVTcVBwSzhOQUhpL0M1cmxtZWl2Q3FyN0hEUFA2V2s3Mlh5?=
 =?utf-8?B?Ly9XR1NISUo5V1Y3L3VaWWJkeXZkMmtaODhJZW5VajBrTlZnYlFlUUtXUDJF?=
 =?utf-8?B?T3NxR0xaR1h5bkg1S2x5U0JqN0gxVU01Mk1tQ1VST2NoYW11bW9hbzBONFV2?=
 =?utf-8?B?Q25PSmJtanVuYWw1b0xtM1JuQ25lUUlvQWpsSWpKQlNvcjJWdURjbWFXVU1q?=
 =?utf-8?B?NkwvUnhnZUNndTdHSkZFVTROblh6MnJ2LzhOWXc2c1UvSTRnWS95QUErdSth?=
 =?utf-8?B?a09DT2hmWXdEMGpQeFlkQmJjN3RWMmVTcVEzQjYxbnVFcEQxWTN3Y1pxMTFS?=
 =?utf-8?B?TndnVVRYU1ZESU5QYWU4K3Z0azdTT2cyU2tnL2YyMElrK25KeSsrZktBa3RL?=
 =?utf-8?B?eEFRTHVKTHlwejhiTElub0NFUDc0Vy9JUHJPaDFKZHV2OEJPZlAwL0NEY1NQ?=
 =?utf-8?B?SVhEUFZLM2pZSFh1b0RNb0dTN3A0RTlXMEhrdm95eEtqY3JoRFNDeG9KQTNk?=
 =?utf-8?B?RVc5b1JJclR3VEJVbzl2MFQycDEvbnAwbVNsV29iL2xBTktPWWRSOGJmYlQ4?=
 =?utf-8?B?d29FWDJGOFRwZG5vRzRIOGRyS2R1VGxid0ZjdjdMdGMxc1RsYVdGT2lZeXJs?=
 =?utf-8?B?Ly9OVTYvMHpmNzZOZmRiaVZ4MitSTmxlQmxlNUszT3dQM0ZKQ2kwcmthTEhW?=
 =?utf-8?B?a2diYWZRYnpPV2grK2dnUEZCZ1lVL2FlSmN6T2pPZFpsZ3N4N3JkMzc4cU42?=
 =?utf-8?B?dnpRS0tmWHVRUHdNUktkVkhnbXp5WXVPdUdYVnVtTzhWWWJMaU5meDZVU1Zz?=
 =?utf-8?B?Q1BSajRRaWhKOFl5cUVhcXVLNyt0eDVqT2kxMzMyQzlOdVpHNXpZUFluQUd1?=
 =?utf-8?B?a1VPR1lneUNFNm9Hb2N5NzBoay9wWTNUTks0b2RYVVJZcThMNktJMGN5MFNV?=
 =?utf-8?B?R3kwd0xpZFVSWEpzS09sTkxXOWVaQlR2Vk1ZQVNJL21CalAvdzRScEFNNVRC?=
 =?utf-8?B?WU1HKzRSbHZ4VGNqd3RTeDZjbk0rNzFaY3lJRU0zaktSbm55YytlcVIrY3RL?=
 =?utf-8?B?Q1hCbmNEcTR1QjdrN2E0eTBlLytIZndBRWYrZEpVTThmUVVTY3J1VUlZVW5s?=
 =?utf-8?B?WllMaHJIanFZVEliZ1Zqek1GeDhWQzYyT1FLWTJqYUpaUFVyNzNCZWxBQkdN?=
 =?utf-8?B?Vno2d0VCTU9VVjhtM2xwZk8rc3VEL0Y1VWVZRDNpbzhQUWdud21MdW56UUJY?=
 =?utf-8?B?UzhMZkJIYi9rdFFUYTJuZzJ0alU2UCtRNnpBejluNjhoYmhXLzhMbjc3RVJa?=
 =?utf-8?B?ZW9nT0xwWEJaNk9HVXVPUzhwVG9Ra1l0MThUWDJSa1BzM2JmaktPUUFqSWUy?=
 =?utf-8?B?T2tOZ1hyUGZZcGJ1b281N3BBVlZjZjJsL2oxOUxXa2xmaS9GMFltZEhhbG5x?=
 =?utf-8?B?ZC8vVkpSZ0FpREY1VHV5b0lkMmZ5dGpUdXBJTGVnYlY0NHcrTElWRThWNUN0?=
 =?utf-8?B?QnpxbzdRVHREa3pVMHZ2N0hGdzJnR0xleWM5MDRxaVQ1VGVIbjJobENDbm5H?=
 =?utf-8?B?YTV4RXc1NU5sdHZoOXdCRHRneVpvcEhhMzgweHRlYjJIRjI2T21VMWx0MXd6?=
 =?utf-8?B?N2RLK2ZIdVp0RE5SYWlFcVpNS0c1ZFFwL1lSV0MvSE5ORGE1MmsrSS9ETmt5?=
 =?utf-8?B?TEdWVENJRENmaWtIY1dZOW9xYzJWUEFmWUNDN05XaXQraEdYeHl0SVFRd2xZ?=
 =?utf-8?B?YUZ5UVhiNXVnNEppZkthVnZEdFZxV2FJSjgxa1BTOU5JSEtCZ1hFT0hwbjdQ?=
 =?utf-8?B?aDdwaGJseDZVd3hRMm5nZ1RrdFlacmduZFVCSkxGRVRQNHZzNGFGZmxMRlJW?=
 =?utf-8?B?eWFIUU5BbXl6ekgrR0ZHYVJFR3FDazUxdzJ3WHNweDlRR2pSc2EwU0RCM0JS?=
 =?utf-8?B?UmpiejN1ankvZE9PTmNSL3ZLcWhuZFpsNHRzSE1ZbDQ1bmcrdWo0U2NIamxW?=
 =?utf-8?B?N21QVEZzMXVsVnA3ck1VYjJKZ3VGQVdtOXY3RTErZThPMmR2MnJQK09GWlhz?=
 =?utf-8?B?WTNmbFRDblkyVmNiaXVjSGN4K1hMQzRMQ3EzKzlUeEVwcG9MSkh1RTRzWUd0?=
 =?utf-8?B?SitwUEpOcXJCQVI5TTUxNjBLUjRPNUc1aFhVVHROMEU2ZDZwb2xTSXNvTnpv?=
 =?utf-8?B?bG5vQXRCU1paeEhoaERSOGdINDhHK3NNWGw4dkRPV2tjTjk4dmU5Zz09?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 27c01969-472a-4939-7108-08d99fb3d62e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 16:54:59.1921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dbniXbp5Xw8BlS46gNVxTtZb5nI695rlq+trFW6nucoBoAFxNcRD8qKX2C82XOqF8hMuuEGQcd34ROhcsNbIzv127Q9faAAySwNo2y+bMao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4221
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04.11.2021 16:31, Adam Dinwoodie wrote:
>On Wednesday 03 November 2021 at 08:45 pm +0100, Fabian Stelzer wrote:
>> On 03.11.2021 19:27, Adam Dinwoodie wrote:
>> > On Wed, 27 Oct 2021 at 09:06, Fabian Stelzer <fs@gigacodes.de> wrote:
>> > > This series adds key lifetime validity checks by parsing commit/tag
>> > > dates from the paylod and passing them to the ssh-keygen operations.
>> > >
>> > > changes since v1:
>> > >  - struct signature_check is now used to input payload data into
>> > >    check_function
>> > >  - payload metadata parsing is completely internal to check_signature.
>> > >    the caller only need to set the payload type in the sigc struct
>> > >  - small nits and readability fixes
>> > >  - removed payload_signer parameter. since we now use the struct we can extend
>> > >    this later.
>> > >
>> > As part of testing v2.34-rc0 on Cygwin, I've found this patch series
>> > is breaking t4202, t5534, and t6200.
>> >
>> > Specifically, bisecting points to f265f2d630 (ssh signing: tests for
>> > logs, tags & push certs, 2021-09-10) as breaking t4202 and t5534,
>> > while responsibility for t6200 seems to be 9d12546de9 (ssh signing:
>> > fmt-merge-msg tests & config parse, 2021-10-12).

Ok, i should have read this closer / checked the commit. The commit you are
referring to is not part of 'this' patch series, but an earlier one which was
indeed merged and part of the rc.

>For t4202-log.sh, the failing tests are "72 - setup sshkey signed
>branch" and "75 - log ssh key fingerprint".
>
>For t5534-push-signed.sh, the failing tests are "8 - ssh signed push
>sends push certificate" and "12 - fail without key and heed
>user.signingkey ssh".
>
>For t6200-fmt-merge-msg.sh, the failing tests are "3 - created ssh
>signed commit and tag", "7 - message for merging local tag signed by
>good ssh key" and "8 - message for merging local tag signed by unknown
>ssh key".

Could you send the full output of these tests directly to me?
Best would be sth like the full output of
"GIT_TRACE=1 sh t4202-log.sh -vx"
and maybe for one test with the trash directory in a zip file (just run
the test with -vix, it will stop at the first failure and leave the test
files in place)

I don't have much experience on windows (especially not cygwin) but
maybe i can spot the problem.

>
>> What openssh version are you using? (ssh -V)
>
>    OpenSSH_8.8p1, OpenSSL 1.1.1l  24 Aug 2021

That should be recent enough for this to work.
