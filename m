Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E968CC678D5
	for <git@archiver.kernel.org>; Mon, 20 Feb 2023 13:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbjBTNs7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Feb 2023 08:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbjBTNs5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2023 08:48:57 -0500
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2094.outbound.protection.outlook.com [40.92.103.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E95BEF97
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 05:48:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D9XQhWgcL2kw5L56WGEyCYf9ikf1k9DmQqS5LL9QKPpDbW3SU2sBJ7JGhEbNh2lMB28kOV+mZEUykn/WoPrtXEHoyvVmsnTUsLjiQlIlHXvGXY567A6GaJBgnZaW24zrTmowebOoKuNDpQKAE0zOLv+7u5QU3n9NrQtsBNKlWTCcFxzZlTFa3eOCnGmO8WQpw6S3ZOon3hk8D/OtN9+mnKCDkPmrMODIJhjC34XC3ckrjQGGR4Pf4jsa4t8b4hXt3J3APtpRpPc6nJ/nCALhDyvVXUu8msXJcMi1XG7OynDEMXc4sUgFnoMQvPJacIiapKrwRzr51ZGbOrvdf99UrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nPLlfQoyVpvQH7vD32lZ3jlkpno0aYrTIM+ibmWMkrE=;
 b=k6Hmc+1tXjMVQ0pI68/62cIACMePih8twdFkI8xpsoVFW9s/K5CnnmLkU3hZfhM3KspAPn3exnDht67Ffk0013gOnDbPcnUC5b61JplVTrzkhckSIqKpffqyIvMz91nseNec88awdnztM1Zmwki84xvqhEAK0367gkgEZo4mobjSfwi+77hU50uE/oQ4Mo5J22F7EXXCBmFZT5D6RY4GwNmZERDOVJI3joYQaoF+SZMaGxqctBoPSwQXH1J/g50+woDU3mNA2QT4xUNMsMyV7x8mFrwxCg9eqZ/jhTewy6Hd1d2fwqbZx9kd+zEsNGNWcoR/SgmCyY7iFdTlbo5Yjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPLlfQoyVpvQH7vD32lZ3jlkpno0aYrTIM+ibmWMkrE=;
 b=hmrC0ZXfHMcvv1LN6oZENnPtL+kRuFE+tQk4bFcSxU6/PGIgCqum4/OV575VwSA4g5LEMkeNfKv6Ha9hpT8TQBvDYkvqjuUQe0Fw0Fy6ee5e6OKg0qgzHvQKYfh1bapex2zZ+Knd2Y22kI9Kn3OzC5RboIc+lMTL9dkgwEwW47rKH/WQMOxaw+TMKyxZiEXIvuZ8AdbH4TSRNmTHnrEa9xB9mLtc9oFDdlmNwTL78sEDOWFshjxp3uMZLI+5ysoTST0JJ9p2YWUG+GOa/RapYSceyw0/G3Ua2+gxOo1G15+UcJ8YCt7SMESNnd6cmlmnUykCwaSG1U/EpGj4ak+zBw==
Received: from BM1PR01MB3139.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:6a::13)
 by PN0PR01MB6099.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:70::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.16; Mon, 20 Feb
 2023 13:48:40 +0000
Received: from BM1PR01MB3139.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::e5e:d4d4:dc64:b9db]) by BM1PR01MB3139.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::e5e:d4d4:dc64:b9db%7]) with mapi id 15.20.6134.015; Mon, 20 Feb 2023
 13:48:40 +0000
Message-ID: <BM1PR01MB3139513364F951DC31B4DD29FAA49@BM1PR01MB3139.INDPRD01.PROD.OUTLOOK.COM>
Date:   Mon, 20 Feb 2023 19:18:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: How to find places where I can contribute?
Content-Language: en-US
To:     Ankur Saini <arsenic.secondary@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
References: <BM1PR01MB3139C97DD4B99D3024847874FEA79@BM1PR01MB3139.INDPRD01.PROD.OUTLOOK.COM>
 <9DDB074D-2966-4096-B256-4035AB8EA778@gmail.com>
From:   Divyanshu Agrawal <agrawal-d@outlook.com>
In-Reply-To: <9DDB074D-2966-4096-B256-4035AB8EA778@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [VcRNPz33f1LzAWyd4iHjs+KTnGKJPA2wNL9ZrB40jzYelPeTU3LyFpKuUaqzn5WD]
X-ClientProxiedBy: BM1PR01CA0166.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::36) To BM1PR01MB3139.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:6a::13)
X-Microsoft-Original-Message-ID: <ce112b40-09b8-8a83-bef7-587baeffd21b@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BM1PR01MB3139:EE_|PN0PR01MB6099:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cb8c0de-d921-42d1-03ed-08db13492ca4
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1N2dpo2r0dPeMEG6rINBvPZb4grMf959hn4EVuJ0vo6YdO3PoOjimxHvtElu2DpZxao0cTuGP/VT7fWPJZzGBreqF5T69qyfUmeLfYb7Nr/Pu7EoUwPSmD6etLA1p14zQ0HV4F6FpfwZYzFWOKLWnTEZGkAtjTG8aCtP2D1PxJW9s6ELBNC3UkQ5PvsorYSe6b2s189q/aRK5dq5PkrFxVaL3XQmQCapIDBwWI9jsJ/3l4Za0qR5jVzRM8A+EF1bfwBFXfePUjsQZnpoWhDxzGvTDbd0HGSSZEgsWXvEtLY6B0/JsgQig69K8tvTgUYYFKwyYyfbWSu5CDsL4EbEZYv2knfk5p/kbDnP0HadIZFdg5CN7jHKWAbOUxw2WC7yD95Uwg7vzLJqM0RQix5glHFleuP9iCSDnVU8//6N8T/G/yI9bZCVKh+8H7WUrSlRzGPj3cxec7qAMhQOk2pl7u1XF9TTK+vwU678Bh2gUgswJ63TgIan6cmI7m5G3gcABVIasmBkYmx8kq/fyS9hnrlHYbaYADbt933hdFdTSUmmbT/SkQG7H4HWeZpOsUTeflcfBMudD3wNK6WuiT8V0/dB9FnTM4QwKjamFvswh4XES2+CPnBlHVpqKBpzgi3d
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVpaYi9DY2VtUFNmMHZ1dnhRSlNQOW9IRGhlbWRzU0pCb0FSb1BJUG1LVE1n?=
 =?utf-8?B?WnB2bFpIN0N1eStWWkdDQ2VPdFJCK3V1a1JGVjN2UWo2cGNJREpUVHpXRmho?=
 =?utf-8?B?RGU0bEJ5V0FVRnprVXRSeWdZdnVXYlhudk4yVUNrNnNHZzF6MWV3Q2hiLzRZ?=
 =?utf-8?B?Z2YzSjNtOUo5U2s1WXBER1MranNFRlVheVF0R3dpQlFUbk5ZdUk0M0t1aEhL?=
 =?utf-8?B?V1BGTk1NTjVrV2ttMkl4blpONGJjRkczVzMyT3J1VXNRb3FyQktkSGhFajAy?=
 =?utf-8?B?NDY3Nk5wVDREK3BWREJYVk5YMnptSG1JWmJtRUQzb1RLS2liTW80RkxJTmxr?=
 =?utf-8?B?Z3Z4MVJQN1BPQW9YQU4vWFkzdXljaU1oYVZ5ZU91Z0hEVXFWY2RnWDVPQm55?=
 =?utf-8?B?cFdzbWRMdjR2UkVmU2hZbGtyWXlWdFR3Y3YrM3I5aGJmdjNSVjY2NytFNDZZ?=
 =?utf-8?B?LzBxZVFxbWU1c2xJMURyajh0V2VFb1praHQvOSt2VytjbURCbXc5c3pHV0o4?=
 =?utf-8?B?VzhiOVRzc0JwZ0ovYzFHMWl6bG1YdGZkU2xJdGRtTUpEcTdjb2JPeStpZ2to?=
 =?utf-8?B?YUNIU2YxQUE4b3pRQVh5ODNqOEppbmxVUm0vdTIxY3ZuQWpOUzU2OFlmaVZw?=
 =?utf-8?B?cnlMVHRNc0tQMWgzSHZyMFJKcUM0dkc1NUpQRW5OZjAyUy9ka1RCTkZBRmRG?=
 =?utf-8?B?SzJrdnYydUZpNW42UW9IUGtaRWVGQTVqUGdiY1JJMVAzclBSVE95aWVKQjha?=
 =?utf-8?B?TEpxMGlnYkk5QlNERXBsckczT0RkOC9qQ2tFVEVvT0pRZVRWU1YyS2dTYUEw?=
 =?utf-8?B?dDdycTV5blNzb0ExZ0RtNGRJY2pEL2JCaFZkZzBoQ1kvdFJCTzdvdFdHRFBZ?=
 =?utf-8?B?Z0hKL0NSTll4WjZwRmR2Z2VzQzZGUmV2ZStnTFVDWEJTaUVpWFUvaEdYSWtB?=
 =?utf-8?B?SGZaRTU3YWVIa0Q4WlZiRDUxbkd6eHNhazlFbUt5OEF5Y21KNDA5c3VqMm1i?=
 =?utf-8?B?Ky9pZUt0eWh4M3VRb1FINk1rOXk4ZUJwVDJKcCtxby9RSm4xU3lVZ0o2WVFF?=
 =?utf-8?B?dmFvcmVaNzYxSFFkVzhGYzlYdEhweitGczUyVVRwK2J1WG1FejhhN2gyR2ho?=
 =?utf-8?B?TmNKRWozejIyWGhKRVpxYys5Z3VSOGRjK0xFWTF1Z3dGb2dsOHlIaXpFVTN5?=
 =?utf-8?B?Y0JRYW9GUmxVbVlyWXJuMC9QZU1GWUpFRXlOYVlyd0k5NmVYWlUwOFh1UlZh?=
 =?utf-8?B?OFNaZHkyakllbUtTVE54OHg2SFJDaVc1NEtlR0M1Q2x3bkMyaExBS2xtY1Nm?=
 =?utf-8?B?L0hCenVvTWd2UWVOcXRxVmFFZzlDNFhXejJzZUZvRC9sYytmMUxCMjZtRUQz?=
 =?utf-8?B?T2pNNjlaV3p6QjNEb2lvTVZ5Y1BlVWxvT1lzQmZqcElFK1VPN1dPRkpLZGs2?=
 =?utf-8?B?V3hJTHlFY1AyMWxpdERsc0tKTUkvdFNIL1JNWnB0a245RDkyLzRQQUFRMVJU?=
 =?utf-8?B?bFlLckFkWXdNaXFnWTdBbkZQc3RNSmlsbG5kK1IrZ0RYdG1JL2lSYTE3Ymcy?=
 =?utf-8?B?alpiZXQ1NVAybmFRSlJlMER5eHhDQm55QVJxVHR2WmR6dURGUTlXY0Y4c2dz?=
 =?utf-8?B?aW8vSkREcjYwKzgrZUhlckd3MVNjNU1lU3pLTGhFU3orTmJ3QUZaMmFnRFlI?=
 =?utf-8?B?V0tPVVJSZFEvZkQreXJ3OVZYUTQvTEdkaXNpUTI2bEhqQUVlVGQ0dVo5WG9R?=
 =?utf-8?B?WFFNZkZQdzJXdm00RTFkU2RzMGFUcVdaSUFMdytXeEc1ZHFnSlRtNlVQRTVz?=
 =?utf-8?Q?Nd3ZJDrRxgiZ5smuLX/orowwk3FdBovfhtzZk=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cb8c0de-d921-42d1-03ed-08db13492ca4
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB3139.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2023 13:48:40.7575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB6099
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Ankur, this is helpful.

On 19/02/23 21:00, Ankur Saini wrote:
> you might be interested in "Searching for bug reports” section of 
> https://git.github.io/General-Microproject-Information/

- Divyanshu

