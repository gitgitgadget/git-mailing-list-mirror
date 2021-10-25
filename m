Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F426C433EF
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 08:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D46A60555
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 08:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbhJYItZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 04:49:25 -0400
Received: from mail-vi1eur05on2088.outbound.protection.outlook.com ([40.107.21.88]:54624
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231940AbhJYItY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 04:49:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RJzrJzmUzVFCMYigSnwowzT4uwsx/LexbBimesASufzqOlPk9SgsncCX3g4Q6WMjjZvelc/XCYjHFi6+5wKXgvbmmkUspv854a+ZyJ6TCHAWPGHV5wHGu15R8SNPw3IF/Y+Qy6501iGuUaq2+X1im1M/kiXoAINdhW4vpDazgeTkEWzM0dYt3YEP/w4WsxOQ/9ZqHeYbvWFyjZdXIOZpFQKxR+76oZDv8kq08mqIqsrQ3prGCwGXoD0IjmSu/EBqNKm9LMtQry5bUIaFkwBEMOw32dbcO7wdnLxusVsd8jxMf5iHp/8YfuLd9hT8LNdF+9r9T0IfrNXRNIF+e/urBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=epqkAONdwPPxg60qWy8jBt5ALY2Rzy3soS287EOhiDg=;
 b=WLkHQLHN+ONrzwF29ePwmObDZqRQHqDg0EJy5hAOexwbzShMSS5irtsEKxoO9638mpBAB+zeFNJEQifDnSn5/k15qVnIq78wHJmTdog1jCRhEyur2fUqAf4nQr851IQeoVOjqkQiPeIGd3aoH2DhqAwMR/Q+gPXrGf7G6aiDqYbOMcSx43/k6z9/v0uNEkI4qy64FcfTxsUlg+LQiu3OkVjvZRwVUaUewxUAXmbySwBGmpqvBNa5Zx4GtL5AMqy5mawX42vPMvm5rvRdQKsyjNEQZkG81ym4662Y/mfWKDDwoqIXO4mHNkcH4RiAkCMCHS356of4roWffNonHg/zDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=epqkAONdwPPxg60qWy8jBt5ALY2Rzy3soS287EOhiDg=;
 b=TeGtPTTOR0fLx97X18L2m/3Um5cArBR08H51ehwYzx1npSuydgzjXXfMzixAOkNOxXYOZeCLay9431Ggt0I7ukMICB5LWBuGyOVqudgenNWc8Qjug0W0+Yza+rwj3iUj1zzoZKO6LdTb0hv1Uy9X4Vtqo9hTUNHpj9YOAHJe7Yg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PA4PR10MB4509.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:108::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 25 Oct
 2021 08:47:00 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939%6]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 08:47:00 +0000
Message-ID: <bc6b915a-7aa0-298b-e1ec-bf548e4dbdfc@gigacodes.de>
Date:   Mon, 25 Oct 2021 10:46:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] gpg-interface: allow selecting key id with env variable
Content-Language: en-US
To:     Marco Beck <mbeck@eaddrinuse.net>, git@vger.kernel.org
References: <20211024193625.148-1-mbeck@eaddrinuse.net>
 <xmqqsfwq40w7.fsf@gitster.g> <YXXMroOBvDERXIMP@octopus.int.carobme.de>
 <8661a491-5ef1-a469-878f-7dd81d4a1aa2@gigacodes.de>
 <YXZpyWesc8VRWYwr@octopus.int.carobme.de>
From:   Fabian Stelzer <fs@gigacodes.de>
In-Reply-To: <YXZpyWesc8VRWYwr@octopus.int.carobme.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS8P251CA0024.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:2f2::27) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from [IPV6:2003:ea:5820:600:c042:75a0:fd5e:1472] (2003:ea:5820:600:c042:75a0:fd5e:1472) by AS8P251CA0024.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:2f2::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend Transport; Mon, 25 Oct 2021 08:47:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f2f538b-f963-414d-887c-08d99794027d
X-MS-TrafficTypeDiagnostic: PA4PR10MB4509:
X-Microsoft-Antispam-PRVS: <PA4PR10MB4509F1CF62233358497F96ADB6839@PA4PR10MB4509.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +CxJF6oLqbA721onZ5qju7lSZTKiFk8tNVhCK7//fwTUTG9TqNoJCg+Wp/3nQm4TjMB1qwEE4UEotibApLmsyl9sdz/GquDiuPwPo74IpfFjwn5mMobA8Uuq0koXW9uAoet/ByzFwf/6FJILoG92QGrWn53ihogcl5irus07YG/Wp3gmQAEEsXcAJYdLoi1pAoBF19ITK1DYeDaUDncWDHufImy/jj1bpN4X5UyQPQxuMCgu/T3wU9LSfvVZ55yCQ8quAKrdFTz9+P189qMzUsT5Zdg+DJDwTDFaO09VMnXvuhMzXoCa5+CuNwSy8ArDDLmcIc0k++NFFq0ZZn0MKyci7zcXCnlzYHPe7bdlP/L37t54xO136/F7NW1qnKEIZqt4KUU5/2FyGsCQ0nZBt3dOxKDEXiG3e7eo9zsSO2KL6mQ5hBg748ZoUuLbcrORmtDetT9Xtw4Q2cLEGBzfDZcWl9eP2fl8D2DvrEZ8z209tIvKtBChUf/uY1VnliuhyHu+aMiMjjpJx7q67X9me8TTRopy9yoUfw3IOpJc9hUf8I8G+7rO/TbPcLfZ6VVIjwUH6ahIVgfdFMn1yE+OnFrvlIfrIWwgbZzkeGQW+/WiTQv91ADMIOqmEQeXasbjJ9UujIO4tLFwcnyeH0LjpYl+wHzrulHHZ14Mhh2096kyv7CSVemCMzDH485ez+317IjOhDp0XL8CpUoTZLdr9HH4qzvAHrmjzEeTSnA0FnsAsv4gcC/vFzamBLhZskm7G+6sozu6i5hgeaVgHrXjgPTSd6N8pwNGOxp0gnyr4z4eEHQUR8ZAs2CoTiPV5VYz3VLWSIUlYKknUZNt+UFxUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(366004)(346002)(396003)(39830400003)(2616005)(36756003)(38100700002)(86362001)(186003)(31686004)(66946007)(6666004)(8936002)(508600001)(83380400001)(966005)(31696002)(6486002)(53546011)(2906002)(316002)(5660300002)(4744005)(8676002)(66476007)(66556008)(52116002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2ZMd20wcjJRekNhc2hHbmE2UTBtakx5YlhEU2JCdXV1cFR4cTZTK1Nmb1kr?=
 =?utf-8?B?Z0x3c05hZkRyRFR6WkhBT2NTWTFIeUIrUVFwa2pMWnFvbmJYaHl1dGxoTkkx?=
 =?utf-8?B?eWhybHVNZ3JnajJFa21uclZqSDVtOCtMRklJbFNrTlNoT2FaTjU1N3JmTS9U?=
 =?utf-8?B?Nktocmt2djlNdjZlcjgrQkw4blhwNCtRMGd4MWI0TkQ2eTFGRDdQNy9UNkVv?=
 =?utf-8?B?dnpxMnFpdi90Y2UyY3l5K3k2T1dIMTM0d1k5dEpOeExUcUdaSEpuanFtYUlG?=
 =?utf-8?B?WHo1bFNPMHFrWjJ6clJKTnh3cy9FS2Z6OXFzM1BvQ0hZVlF0QnhUaWRsTHpG?=
 =?utf-8?B?N1orRjZMVVFaN2grdmNSYnpnK0pOSVc1WW5MbTRnZEtGc08rUXMyTys5YjIr?=
 =?utf-8?B?Y2lrZU1keWVsd0xtdjQzR1VGMUZEaVpqd0c3a0RQei9mdjloNzRkTDJ0SElJ?=
 =?utf-8?B?VythVXVXWTlnNXFtZHRvRFlJc0srdlZXV0F1Y1N0azM3UkNOVTZJcmNtajdy?=
 =?utf-8?B?NERTaDE3Ykk0WlZQTFJxMk12U290RnlRM1duQTRkTllPYVNiVFY1R3JNRVM4?=
 =?utf-8?B?aGp1ZTBIc2I3SnBSVjlVUGZoVWZNdGdVa0ZCRkNKYy9wcW1mbkp3S2tNdnVK?=
 =?utf-8?B?MHhKM0JVZjJ3T2dxOFNzekpvT3g5Y3BWR3J6RXJUNnhPVHNVTHhuQ0hET2RW?=
 =?utf-8?B?dW9MVHpIQjVDVFFuVkNNbjhuL3NhZDVLb3BVeFRyRU80STgyTHhZcWRrTVpL?=
 =?utf-8?B?bHEyRDNWODVtOUlHMkZOdS9GYnBiUkpVeHJWUFk1bXRYVnNxdWp2SThza0JL?=
 =?utf-8?B?RjJyUkt3K3k4Vi9KTmRGQmNBd3kxSnRVMHI2eGYxNTJZdDVMT3dxUitJRm80?=
 =?utf-8?B?Y3RZeVJ3dWQ5YUpjWjcydGdLWTNtQUJKdGJHS1RCZzB2S3B4SnM2S0dzQ01q?=
 =?utf-8?B?TXkvSjVmbFI2cWVTazN4U3FmTnM4Y1NKV3BaQjNPWnNRRHJKaGJFNG5iTFFZ?=
 =?utf-8?B?RWk2UlZlN3UxaEZoVVBEOFl5UnpQZXhYQ01INUNYQ2IwRHhnMGlHM0REcWRW?=
 =?utf-8?B?bEdwc3h4SEdqUlc1RHBHNS8wQThHUk5Dck9weEhOeVpKM1ZyK1RZUng2N2g2?=
 =?utf-8?B?YVhqMzNHL0JCcWh2Z2krd3RUazVUaG5iTjJPUDlJTUdtWjJhbW1rTlp6ZWV2?=
 =?utf-8?B?S00zbGhaM0l0Y1lEQ1JsS0Z4WXpucjlWdVRWOTVGSm9FOHE3eFZHdnlVenRi?=
 =?utf-8?B?N2FUcm4wSHVJT3N4Vk5kalhXZnBJM1hkWnV4Smp5ZE5ZMWVsYUlVeUM5aC9I?=
 =?utf-8?B?YUZkUEdnT2Z5SGMyQXR2a2pmcGlzRVdpaGNxUzJOU3JUTjcvS21Kc2tpTzM5?=
 =?utf-8?B?RWl5TDF2TW5KMnIzSHJXczRsendlOXhDRlBKa1ZUVHFNR1F0UjdNR1kwcGR2?=
 =?utf-8?B?TTgwZWFpU0VXRGk0bW10dDJKbWdMYWdIaldsM1VTTncwaWJHVmh1N2VreW9x?=
 =?utf-8?B?czRyc2IvQW1LSHI4aGpxd2VsYjVnRnowSDljOUQ4NE9hZkJZV004RHF5WGgx?=
 =?utf-8?B?dHJFQTVWY1lYekM4bW5vT1dYM2tMcFcvUlo3b3B1OXloSmJ4UFBLRkZBenZG?=
 =?utf-8?B?TE9pZm04UFNGcnJPMnN5MXcrS1ZtK2orclUwUFdaeTlWam1GbjZOOXBGcERH?=
 =?utf-8?B?WjVweHFSNjZnK1VDMThZNHQ3SXQ4VXR3bys4ZHd3RVBTUVFDQWtxMzhOSUdx?=
 =?utf-8?B?UHQzbGlUT0VsZ0wvSnVtcUxWQ2tVaXM1WE1jQVRUa3JhYjJuLzhIRDUzYUZw?=
 =?utf-8?B?U0hEMXYyMjIzeDBUWVd2OUEyUDRnOTF3T0RXWkFvTGxVTXkzV0NFV2h2VU1Q?=
 =?utf-8?B?Q3A3bFBKZTBlQWxUUUdNOFdLamV5RVRyT29kR3pobXZRSGtpcm5LQTlseW5l?=
 =?utf-8?B?VWRDMXZRKzdsUDk3YjAyZW56dHQrUU9IaGVDc216U08vajNjcDhxQk5NY01x?=
 =?utf-8?B?bE5NU0NESmVkam5PUGJMVzVwaW5VZlFPVUh2SGJrdEQvc2Q1TldzaGFRenMx?=
 =?utf-8?B?ZmNWc2NsN0xraEdUVWMweGc2QUtJZE5ha3d3a0ZiVytmcW95N01wdSsxc1NX?=
 =?utf-8?B?Mnd4aDZ0SkJJRHJqc05LOFdWaG1HSGtsUmROcytObWZQTHZ4ZEhDbmRDTHVq?=
 =?utf-8?B?V2xLYnpyZyt6ZFpIOEc4Y1daMEU1TThBcW02VU1hbnVhRUFXNjFvQ3phRW5N?=
 =?utf-8?B?OTV6amZHQzBnRUdjb0xZeXgrZXRQRFlqVEZmK3paS2ViNlNIK0cramkzZ2V4?=
 =?utf-8?B?cWswK2ZBR0lzSXVHQjRTdUFpbzFoby9FK1gwTG53M2hyanFrRlRZQT09?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f2f538b-f963-414d-887c-08d99794027d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 08:47:00.3217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: inlJJ31tlIW7MUEB20OwAHcX0yvrW9fda6V6VDyGZTa3Ty5oKD2J68bIQlQgcLZKjRwF/SN79mKHkAOyQRIT2/6NZIQ3RO2BDcgHnVKAESw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB4509
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25.10.21 10:24, Marco Beck wrote:
> On Mon, Oct 25, 2021 at 09:31:33AM +0200, Fabian Stelzer wrote:
> 
>> [includeIf "gitdir:~/projects/work/"]
>>  path = ".gitconfig.work"
> 
> Yeah, that's what I added to my config recently just for signing key
> selection. I'm using direnv[1] for some time now to switch between
> different "profiles" (more than just Git settings) by just setting
> some environment variables and it was nice to have everything in one
> place. That's why I disliked adding the includeIf to my .gitconfig.
> 
> Thanks anyway,
> Marco
> 
> [1] https://direnv.net/

If you insist on using environment variables there is:
GIT_CONFIG_KEY_<n>
GIT_CONFIG_VALUE_<n>

https://git-scm.com/docs/git-config

A bit clunky in my opinion but you can set any config variable via env vars:

e.g.:
GIT_CONFIG_COUNT=1 GIT_CONFIG_KEY_0=user.name GIT_CONFIG_VALUE_0=testing

