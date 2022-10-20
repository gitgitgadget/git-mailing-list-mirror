Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E063C433FE
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 08:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiJTI4Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 04:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiJTI4X (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 04:56:23 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on0630.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1f::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2369C172B52
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 01:56:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJOxRk9ZESN3Oit+XserZ0M/12wIt91DgjOG7AfbhMPwWW4O9MaqRDKtJlMxc5eWrcwdRoknEa70epkUM2T9Dkf/7Y1GeDVCCjpmywsoQ+gZlTl2kzTyuLeYgRmT7xbu59rLXcT6//2jcYDcMokL0FsBNbKJmASZ2sWzOY4fAhjbJkU0i4BZgTJwgujUAU0GF2P+RW32jdFmhRgUa6iGV5Eu2Ojvi5C6yzZcJqjuVb7fjAmKKP8BwFhyXSC25r7ZSkZSht+R0KD0SFKR/QUSd643k7SHzqSTSWVDaTXRSUxl6rek7Z4t3Iai4QelYq2LlyKuvYj7h3RCBzSzvOkI9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l06T4N5rhJ2oxcGCryYeUIADwFoNWnyvY/JhUfYRbeg=;
 b=MQBqRm5MJ5BjL5A3nsq0hB+7nn0NaW37ESNRPOJXiOqkYnpniYNP/Dx7zoa7Fr+lJ6OcP9TUenMSqViLIfew8Aiq+mV5ALE9dUMJ8CsOySQkypt1sJBGBUP7zCaY2z6+XMxuu56HwJHlwnDPNyFYUZRvhR3oqdkcH4mU1FndoFi+hZ8j+1jVUwYMc/+EwDaxpJPogQSVVg4n/qRcb3S3OSdzu5K3QQfkzUbaRDLLZyR6jkzuUrBVlNZga6muCnispVBQbNM6tAuBzTrh++8kFWx2aV1jIVt3jh4YDNAUbAXsVuCHZ98u0WAcoqSRbdbzBgSinnaxANX2VKQDqno07A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l06T4N5rhJ2oxcGCryYeUIADwFoNWnyvY/JhUfYRbeg=;
 b=FxsScEyse5oHmT3Nev2RgJDO3SneEAL/VCpvKGL3kVIMf7AzSZGJyEHBbckuuc3aoCLYvuAySaT91OUwGNuVf/yj5Ec55vS2woRyVSy77DO+KpyzYtJU2ILrKO0BGxhWdYa3B+r4sjMBP2XR5xV+4fq8k4uvpKPerpURcl/armDzb0GdjC9EMXyX3QQPLSBVNz9ctTCxqLe0/NBQa90aFZ66omM4cTMMQklPtCqKoDFNsdsGV0Nbp67OVi519aOdJ2MnNhakLn87KA1BuSyg0bQ5R0gfcZzvWBq7isZsjNkDbp5+9GtMne2b1rhYHJ9A8YSsJ6jedI6l9ZosuBKmiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by AM7PR04MB6872.eurprd04.prod.outlook.com (2603:10a6:20b:106::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Thu, 20 Oct
 2022 08:56:18 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::5e5e:1989:e5ec:c833]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::5e5e:1989:e5ec:c833%3]) with mapi id 15.20.5723.034; Thu, 20 Oct 2022
 08:56:17 +0000
Message-ID: <09e125ea-5ea5-40c8-575e-57cb7e1806ff@theobroma-systems.com>
Date:   Thu, 20 Oct 2022 10:56:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
To:     git@vger.kernel.org
Content-Language: en-US
From:   Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: git-send-email adds a second From: in the body if eml contains one
 already
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0103.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::16) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|AM7PR04MB6872:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b6d6b20-a467-48af-8a88-08dab278f385
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6rphyXF7lytvgMCpsl9vbQQ7GyyxYuG7HMoOW8pFS2/7I2EITAxFROX2lr0xj6SRRD+0YxUkbmc3qef7bdTL//tJezmg4P+DuE3R6/AB1acjPazVuUyZtJWuh0iEhfTfuJkX5dMkAx4Vnykljc7JPCiCIbCa4UcIGbtrS5aGmrq1VBbhCSsC7KBT3ouLh7+yc76iTp44A5crcW3KNKJ4vtIbgmw1C1AmXxnXRGQSaIuhT1j4379lvK5un14z9FW55vNCcLmEL8zQu+W61uTDL8dBbzXZ9BsGG2TWf6BXYnct0B2OKCWEH+170h8c/vpTJH/eXlaYvmav8IMpC2JuJaXHWPEl4WN2HQG/T6e9eBBybj/DxSy3XZGHPAtC2D2o5pIhl9Mw/k09LpHiLVbF4ZijhWEYmGPE/dWOG8VEjogx4vGAQV5eyAYDrMzVAmX225IhtPyc9L5YpaKTPH5DMJqA72WzzOuJ00B8wVIqDodJlz71yZ3I57dNV5X2WDjkdD2CNeKJlRK77B4LE+FSQpo1Amf9lTjvUlSEu9BFBU4QdrC+4e3LyL7QaKzqP7eh8Y7qG/4YTeiEaCKPvdLaP1KbYEJhfSqZppGqDzTY93kUwgyx8+abVbFeS5ZumYFPPDNamzvABCsQmqK5KsEas/0yUHASes8oXJgjezgEsKa7dxByXmaBT1noLJ6Pu+ITdrCLQRdXxlWxyTHYydy+uYGgex19QgXngtsohbjyxWFsSnpAr413yLqe0R7kcY+cED7kwDuJcIY1Rsmqg+rNujgib+MfrlO6p36yGk0CRJx7vAxvKi3OWdp3GvcVKDwQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8536.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(39840400004)(366004)(396003)(376002)(451199015)(316002)(5660300002)(44832011)(186003)(66476007)(66556008)(6506007)(38100700002)(66946007)(6512007)(26005)(2616005)(86362001)(41300700001)(31696002)(966005)(53546011)(2906002)(8936002)(6916009)(8676002)(478600001)(6486002)(36756003)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qnh1ZU5VME0yYmVscGhITlk1a1ptbWppQzVlU29TNXhYZkMwMEtTN2lyMGFr?=
 =?utf-8?B?azlrZXcyeGd4aTNScTNIS1FpOUxhVUttSGFtVlhLbEJSNXB6NE5qWXlia3Bn?=
 =?utf-8?B?UGFvaTYydDhKUlV6SHNDRjZmWCthVHVQZWtXdTRJdmlOc0l0ZG5TRUZuVGln?=
 =?utf-8?B?N05VSVR4SDUrSVlQem5jV1FXS3N4aHBuZGhvVG5UenVIQkFaSGdPS2YrS3pZ?=
 =?utf-8?B?eHlHaFRXdEpFSEpRZlNHUFY1bnRmZkU1a1NldVhPQkhGaENTUEJtV1JiYkJJ?=
 =?utf-8?B?MEVwVWNXalZEQkJrRWtiS0VIbUIzalpYSWhnMU5PZDJtY0tmTTFIWVhtWjNw?=
 =?utf-8?B?WnR3enBtZnBOYXFPL3FMZ2o1WUlhRzlJUFE5cXNBc2FjdGNVQjJmYjNSdUhi?=
 =?utf-8?B?b0ZVME00cndoMXNqaHhJTTFIL00ySjBJRjh4WTNWZUpoZ0pXZmNWRFo1Ti96?=
 =?utf-8?B?c2xTZmlLRzFqL0M2bzVsQUhkQ3NCQTExWmNXbnd3elhYc0NEeXNMb2lvNGVq?=
 =?utf-8?B?WnlyQzA0emVQOE5VN09sYldZcGVJK0xzTW9BMHhoMU9EakMzTDh3QlBqeGxW?=
 =?utf-8?B?UktuVWluUXlraDhib084Q0VMVS9BaW9mWjE3QWgvUkppZERNNTkybVorYkV6?=
 =?utf-8?B?UHRnamlkejNEbThXS2VNeklDZFN3WWYxSzNqSllMcEQwTTNvWFUrWCtldzZB?=
 =?utf-8?B?TWh4c0ljOU9qM09Rd21XVGpHS3RQTGx0MnltT0N0N3UweGpXTEZXbWh0MG5p?=
 =?utf-8?B?V0FoZDZFS05lUEQ5NlZKMFJCMHd2ZmVXNFV3N3JYUlMvVUxSRHBPbkliSVhz?=
 =?utf-8?B?akw1WmFtWlQ4QXh3N1JFTlB2dkNXeUluNStCL3dqTHBQbjZORHVRY0trVWYv?=
 =?utf-8?B?dGpTd3J6ZWVSYkcvNmxrak9RTHVyWW1ubGVUem82THRmNVlQVDBTblhPNHBa?=
 =?utf-8?B?RzEyZ0dHTFhiamVxbzdDSTNBbW1Sa0xsWWlJbDAvcGZWZEZBOHBFZHlsbUJh?=
 =?utf-8?B?S0x0NWJHYmVzUkFZOVd4eTBnS1lUa3d2QUlJMUtvdGNHZCs2ajArN3krWkwr?=
 =?utf-8?B?L0UxeGFhSjNVZ2d5YU54VGFwNHQ3elRQUFNTaXA5cTJEeUpmc0RPdmVnVzdU?=
 =?utf-8?B?M2QvU0VFaUFKR0Yrd0NvWXIzaU1PTGxMUUZZTjArWUNOd2dzQkM0MnNCclhD?=
 =?utf-8?B?KzNrNVdob091VmJKdjh3ay81Um5ZdXNjbEkrNnNmNFk1bzhZOHhMWDVyN0Z5?=
 =?utf-8?B?a1RlQWc5S0R6K2drdGNaYmdMQUg4Wnp4SzRaVi9yZXowMjlwdTRBbnVRcWNB?=
 =?utf-8?B?VjJMN253aHVwdTZKWWtCeDlLd1RTL0JSbkh1VHU2UGVlMUloQXhqbEc2bklU?=
 =?utf-8?B?TTZzTGgyNkVTZkVNelliT1pYejYxdCtHWmRsUFZqWElvaVVSSWVDVHVIOUVI?=
 =?utf-8?B?UWppVDV2LzluelJRMFJBbHh6UnMreS9qRlFWNDlpTmlrVWNaKzgraFZ5bGpP?=
 =?utf-8?B?dlp2L1hoR0lRRUhaOHQ0RzhnaHRyeVZNWDRBUmQvMEx0ZHdubllzYWUyS1F4?=
 =?utf-8?B?M0ZNTGN0U1V2SUFaTy92ZDBncGJGV01yUlh3REYyWU1FKzRqM3o4dGE4emhn?=
 =?utf-8?B?VEhnY3QyZFFFcnF5cW9DcXQ0UFZQeXhQa0dweFQ1clFxN3RUM0s5cEpFSmFu?=
 =?utf-8?B?bHdDcjRYZTY4VURNN0tBWXF3RlE0SXNVMHlSc3lDSjBXbHBCK2tCTXpxbDY4?=
 =?utf-8?B?UXc4bGJ6UVJEakl6T1N3a3dmNTB6SEpoRmk5QVo1aFNseWFaQnAvdzBMRk9B?=
 =?utf-8?B?dTNNak1WdU9CSFFMRkRyTzhkOTZ2NmNyeHpOUStMeTBOVG5USm9VdmF4R1Bm?=
 =?utf-8?B?V2xER0hZRU5qRzRLaVFUN1kwK25tSDlnaTlBbmZLaUFzOTVKSnBIRGtaVVpC?=
 =?utf-8?B?VWtxNVVTMjEvOHZjTmNaMzc5NUdPK0ZCcUdVVzhzcDVZdXZiREdybDllRXNP?=
 =?utf-8?B?eVpueWQ1ZXZKZFhoTWMyeFJ6ajlDZFZuNWhXN202ZVBpQVJlenlrYk1OQkFs?=
 =?utf-8?B?UFp3Q2ROcTVEcDNyakRiZDZBRUlCcCtXLy9PV01SMDZSTWtFSGhUVnpIMklN?=
 =?utf-8?B?dnI1ekFYcllVd2JOdDRVT2hkZEdxdEZNTEgxTGJDZHFoTG1ZSVpDVHpRVVg0?=
 =?utf-8?Q?Xarl54TeoYMC6bo59uGRets=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b6d6b20-a467-48af-8a88-08dab278f385
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 08:56:17.8718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9sNdzVjDRaUxb3GJ41IRknyeUQYVCpQY25zQr05C4i/Lukl7k2/ybJjMUBBP0YKv+5LIQFFkrLk+Dvgr2jZCVpTcDjtsAyTyVCJbI9NrTQAMtyEgQ7ilzpoKYG/eP2pI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6872
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I recently encountered some issue with my particular setup.

https://lore.kernel.org/lkml/20221019-upstream-puma-sd-40mhz-v1-0-754a76421518@theobroma-systems.com/raw 
is the problematic mail, note the two From: lines in the mail body.

This particular patch has a git author (Jakob) different from my local 
git identity (Quentin Schulz <quentin.schulz at theobroma-systems.com>) 
which is different from the sendemail.from configuration (Quentin Schulz 
<foss+kernel at 0leil.net>).

I created an eml file with `b4 send --output-dir dir` which gives the 
following:

```
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Date: Wed, 19 Oct 2022 17:41:28 +0200
Subject: [PATCH] arm64: dts: rockchip: lower rk3399-puma-haikou SD 
controller
  clock frequency
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: 
<20221019-upstream-puma-sd-40mhz-v1-0-78f7eded8a11@theobroma-systems.com>
To: [snip]
Cc: [snip]
X-Mailer: b4 0.11.0-dev-ce3c3

From: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>

[snip]
```

git config sendemail.from is set to:
Quentin Schulz <foss+kernel@0leil.net>

I sent the patch with `git send-email mail.eml`.

I initially reported to the b4 community but was advised to also fill a 
bug to git tool since it is believed a second From: shouldn't make it to 
the mail if there's already one. See b4 bug report: 
https://lore.kernel.org/tools/9bdb42f7-661a-77ed-97e5-33ba7a31fd9e@theobroma-systems.com/

I'm using git version 2.37.3, the latest in Fedora package feed for F36.

Let me know if I can clarify some things or help debug/test stuff,
Cheers,
Quentin
