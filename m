Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EF0C433FE
	for <git@archiver.kernel.org>; Tue, 31 May 2022 07:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244546AbiEaHfP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 May 2022 03:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235204AbiEaHe7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 May 2022 03:34:59 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2067.outbound.protection.outlook.com [40.107.21.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2A474DC9
        for <git@vger.kernel.org>; Tue, 31 May 2022 00:34:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lNpdpgH1D5OjYv4YoVY7nB/ifHNvGnX2ZtmuAO5FL2LbxBtqnZd3JKGw4I86PMOaMCT47iivb6ZbrrO6+/GEROFclv0z/GvAqevLkbPqE0OVBCK0s02k4I5kFgPkcA+iGQifs/drkeEz92H4Na520Jmh5+9jNaaMgO+teSdHNxexsXDzVprfPTjOZPo2bqW7QgAbHn/IgbOH30s2iWnjyvsM0B6Ijs6VRlUhrtkpVxnTTOx20LLD7JjVggmgWqF8jVSTRi8S2kZntdgmn4mz9/rBCvx80rsM5jNuOOm1F2WQx5W1jclzo5KE/6C99laT3j+9hF75kukMNB0TqxyWMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CAtLSIlUfu08wRWffbQu8R1MG5YXoz89o9tip39/z2E=;
 b=NRN5GeTbozthVwtUIV+//jhjrgy1lF/CDF4z5CY+fO6v7f+WCCsTlbfHF+iGx+KeTldP76ryq5vgBeCtTqNo5KJR9sG4SLq2Z2vcdRQx/AkQY/OM87RtR8c8/RuxZM1oL2xbruucYz02d8a+l+wLyeaHBs+BS3xwVd+omae9M729B48063gazTJVKKA5mMNiS06Vbh8i3NGxcVGj3yLAA/9Do2XU8mFx7FXrH2rzRBYd7REczywID3tdCWVU7Wokd5YubvXTf8zVTXHmGCQJaowXKI6KipPP8C/ocK4dTjfca2ERnzoI7QJeWDd/XRWfzp+CI0tA8SttFvYBMDfnNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CAtLSIlUfu08wRWffbQu8R1MG5YXoz89o9tip39/z2E=;
 b=sXtZmXUne2K/D7fKqO+ebMnHWJj1UANAPwv/5mBylC5HNHCPFcezx8Zrf2t3xU82yS2W5cpTHPUnxJJSiZtRhX/mgvCbJ/tvPiguezz1ye/LkbP4uhVOri8s64zLMaNubAZK2k1ESg1HfZ8+NUN3CbVLOBf4RR/312oq47//O/g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB4189.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Tue, 31 May
 2022 07:34:46 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b4dd:8ff5:e52f:a55f]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b4dd:8ff5:e52f:a55f%8]) with mapi id 15.20.5293.019; Tue, 31 May 2022
 07:34:46 +0000
Date:   Tue, 31 May 2022 09:34:45 +0200
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Andy Lindeman via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Andy Lindeman <andy@lindeman.io>
Subject: Re: [PATCH] ssh signing: Support ECDSA as literal SSH keys
Message-ID: <20220531073445.iuovy634ufp5xims@fs>
References: <pull.1272.git.git.1653932705097.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <pull.1272.git.git.1653932705097.gitgitgadget@gmail.com>
X-ClientProxiedBy: AS9PR04CA0088.eurprd04.prod.outlook.com
 (2603:10a6:20b:50e::8) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5301ba66-d812-4352-321e-08da42d80961
X-MS-TrafficTypeDiagnostic: PR3PR10MB4189:EE_
X-Microsoft-Antispam-PRVS: <PR3PR10MB4189F51B35DC49DE4C47049EB6DC9@PR3PR10MB4189.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PRpdn5l3OVhrCIrCr5DEV5n4Fsf79VfcVvrvT4xX1s3cbwMyaScrxudBAbJLxct1NscuWVtcN5PO+0N0QmEfBqqTW3+g8oIzBYmO1Bi5Qv3DfOPzFHZ1SwVaDCnrS5u+lXxbeoUi0rERdzTqr9yFORYL+m6IbC7erc4kkLzb49Uiswn2atBsT13zfYCHMvSzbUVJnxNMjkyt1/iZtFJiGT3ydOTKpKvG02NRWcBVIDjjl6IC/JW0FNoLmKk4mPvdzluCAeK82Pdf9SBe/mT1ueLuS4LioOSd6LGMAg2RjZX4WWG0wM30p565aPrhriIAYMatiRwhEdbyYeOyV81bLHVKa7laGfjjLAwR6hjY2j/A1Du1U62jnu9PBcs+oDmcJAdjW6MFd4nb73YbVMEIxbCSxQBjhQEw7V1GAAowiLdjOYqYClPPFmSCo3hBGAb3CFl3Pt1eWQAe3bh/dmsLOQK6BlKl5LVOPAFoV/9TdKTRfHHX5/kgpgM/l8uEERHQAt43Mv/J6y0syLbJ+tW84VkveJRDY/C2Evq1A0wQKCrURRBPTubzrDa0HkHug4mqeJG4exSSivQxmPrLsyGySYaVv/FIXRYmP3DF5K6WHdKdM4Ek4F3AOVwKK+hQXLhP23xxDLHBKIIVSGl9o5OSYdos4hkzVRDD+K4gH1pKqNpjAFhssi0D9Kn4U8ZK4/g6+0rCzBi9otg6kscE+rId6PQtAlmCeE1fbZ3eAnyLmTs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(396003)(39830400003)(376002)(136003)(366004)(346002)(316002)(33716001)(38100700002)(66476007)(4326008)(8676002)(6486002)(66946007)(66556008)(508600001)(8936002)(5660300002)(86362001)(966005)(53546011)(2906002)(83380400001)(1076003)(41300700001)(9686003)(26005)(6512007)(6916009)(6506007)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RE5iNTNXMmFQSmJGMGU5d1d6V0s0cEdlc3dPUTRiTDA2Y2xTUU9iSm1GcW4y?=
 =?utf-8?B?VERCbTNxQXcyMGp5T2VsR0xMcExHUTM4SDV4c1VBdEpQZDkrM0xLb1lVRGxs?=
 =?utf-8?B?OGFRc1FoSkc5clNPSTFEZ1g5U0JzWk5LK0g1Z0hUV041bDlxcUlUamNtVlc4?=
 =?utf-8?B?RFNtYXhLUVpxSEhURE1MU3BWSmErNFE1RCszVGZ5S2dHOExhWFhINm8wV2NQ?=
 =?utf-8?B?SE9QQWM0cnBjUWRnL2d3Y2hVaXlOSnNCT2NqYzNxOGVublhKVXl0WDg4WkxG?=
 =?utf-8?B?U0VpTEhTTDVzZ09lSHNPVUJHUVBKU0xMMlBZRDIwK2ErclZDSUJzSmVKOGlI?=
 =?utf-8?B?Szd3bEw0SC9zZDhyc3U4UFhkMFBNelNmTk9nZnE4dEZlR1dNb3NwNjJBLzVx?=
 =?utf-8?B?dzh0NHU2LzZNUmhRZzFIWC9pUERab3lkT3RYaDhJS2xTcm1iTlZJdzNVTGRk?=
 =?utf-8?B?RW1oNUtucXFoYzloeW56YkNPTFRpZmVuQVo5TFdpZDJEdURKZnZRc2xlL3Fi?=
 =?utf-8?B?N2JIblQzTHowRjF0bSs4Tlh0TlJZbVc3WVhJZWVkOVl6NXpwQVhSWDFNU1RL?=
 =?utf-8?B?ZUhhOTZ0eERoNzFuak9VaTB2N0FWaTR3aFJTZlNQOXkyR3lTbmNvRW1uL2lq?=
 =?utf-8?B?WTUwOEI0QnBOV2NLaXo3eVlHVHBTUWVGL1NQVXRvSERwMEpJZEhTckZSZEN6?=
 =?utf-8?B?TUhFZkFLWXhZbTRkRUNNZ1N6c3FFNEJvOGdKdkdBSUhFMFhuc0w2RTJNZklR?=
 =?utf-8?B?QmpYbVlDU1pVN1Znc0s0eExRdTdPNHA1bXFMMmRGM2pqT3RLQVd6WWNNb3M1?=
 =?utf-8?B?WjlzSFVBRUxJTWxuSURia2k2bHhIL0dia3U3UE1EenI5eSt0c1dDK2V0eGhG?=
 =?utf-8?B?OURNaTJPUGxlQlQ1czdTQUZIdmZ5TlhaQjFpQlB0bC9DKzBFUzkwd1hzUSsx?=
 =?utf-8?B?S0gvZndVWXB0MUtrWnVsdXZEV290WmQ2ODdTdnBJODlSdVQzcU5OcllHaEh0?=
 =?utf-8?B?WmNiQVFhZTBhOXJoL0FLOVBoRlNQS1FkcmE2ZktsdFZHYjY0bmNDVWVsRU95?=
 =?utf-8?B?R3RCdnRSNDI0NWVESndlQnRMd2x1cW96b2FUR3hKeTdGWG1FYm43eWZ4N1VH?=
 =?utf-8?B?cXpkVi9wU2g3S2V1OFpQbHZMNDNkT0xvbkcrb3V3WWdUK3BHeHpFN1IxdStl?=
 =?utf-8?B?dE9TWHVPQTBIV2VhYU54cTdpQlFCTll1NDlqak5IMDFJOVhpbmtITFNaUmNE?=
 =?utf-8?B?OW5zWHA1N044V3oyWWthSWNpZlBTUzgwWUlRbnJpRmdYSTVId05zWU9kWFFn?=
 =?utf-8?B?SG1HV0pNbHBmcDZPeDYrODhTQmVabk5OeTlZN2N3QmR1c2hGS0dic3lGUk9C?=
 =?utf-8?B?aEltTFBWY0RLVWh5ZFk5czZVREY2c2REU1Bza3NpVWpmUkQ4SnVLT1hjNVBo?=
 =?utf-8?B?My9HWHJndmNPMEl2TVFJejNFRWdZUDdCaks0aWkwQzFmOExucndKSDFUOEQ2?=
 =?utf-8?B?K3pjTGtlNVh5c29NM09aTE5vUnZyWGRmeEgrbWpmYzNiUmVUTUFDZUtQeWpR?=
 =?utf-8?B?cjdiVG5DM0FYdGFWbVR3Y1ArWjBsUDFQZTFGYWUwVXorL0EwbFg2bUh1Qm8w?=
 =?utf-8?B?Q1prTmlaNVJFZWVvMkpuaFZndUY1VG1ueVVBR2xsRXE1ZjBCamVneE1NMTF2?=
 =?utf-8?B?d2lYYzI1L2VzRkJIS3BkRkVScjRNVkw5MjdSOVVjc2g2WnJYUVBwT0dTcWFH?=
 =?utf-8?B?NjhIU3JVUFJqUUwyWXpBLzRodG16MDFpdXpxVjJrSTc3bm9wbC9iS0ZIMXoz?=
 =?utf-8?B?Sk1GTm5jMCswblN3R09OY2FsaEFuZlhQelFoZ0kwM3QvaUJ0bWtLL21pb28v?=
 =?utf-8?B?SnhTbjdJSEc1QnV4Sko2TUdzWkNvazI0NWQ5UmphWXVzWjZrRkRFRTlXNUVx?=
 =?utf-8?B?eTVGalIyOWg5Z2JneG1vcmRJUHNBMVBmR0dZYWt2K2x3QmFHU0pyKzdyUzYy?=
 =?utf-8?B?ODZoM2E2b0lmKzF5cFROQmtEWDA0TUd6M3hUYnQ0UUV4dXJndHNZM2ltR0tq?=
 =?utf-8?B?cndrZDBMSkNwTzdXN0QrUFkxN0FuSkFvUUhWVGdyWklPOW9jRGZUcWpEZjEy?=
 =?utf-8?B?b3pJMG1PNHRYa2h0ZUxiM2lWamZHQ01vVjFoSHp3akNkbVVlMy9TeEpHODZy?=
 =?utf-8?B?R2JOL3FHUlg0YWxYZnVrek1haUJhamt3ZEJaNlBieVpxOUswTnFQR1E3eGJ6?=
 =?utf-8?B?b3NIZDF1eWxEUkJBTUprTUJSZHdxUFJQdXRCZW9PWHJPMlJVdlZuMnZDR21q?=
 =?utf-8?B?dkwyRW9ib0RCakUyYThPVndGVDQwMXdBaXU1Z1pVbENNMDkwckJSdlh1OGhW?=
 =?utf-8?Q?vLvH6+c6KJRF+uo8=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5301ba66-d812-4352-321e-08da42d80961
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 07:34:46.5173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XuRIgYsWUImH+gAJP+VgfHUu33eM/KdEQcl3/U8zH5QyGPopAJWE6VL0rEpadUhV1NnJt8aBo1DP0GYmPfQv1EPf8soF2eRp93iJT3IMwrQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4189
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30.05.2022 17:45, Andy Lindeman via GitGitGadget wrote:
>From: Andy Lindeman <andy@lindeman.io>
>
>Keys generated using `ssh-keygen -t ecdsa` or similar are being rejected
>as literal SSH keys because the prefix is `ecdsa-sha2-nistp256`,
>`ecdsa-sha2-nistp384` or `ecdsa-sha2-nistp521`.
>
>This was acknowledged as an issue [1] in the past, but hasn't yet been
>fixed.

Hi Andy,
thanks for your report. We have decided in the past to not explicitly cater 
to every key prefix and instead use `key::` for literal keys.
See 
https://git-scm.com/docs/git-config#Documentation/git-config.txt-usersigningKey

`For backward compatibility, a raw key which begins with "ssh-", such as 
"ssh-rsa XXXXXX identifier", is treated as "key::ssh-rsa XXXXXX identifier", 
but this form is deprecated; use the key:: form instead.`

>
>[1]: https://github.com/git/git/pull/1041#issuecomment-971425601
>
>Signed-off-by: Andy Lindeman <andy@lindeman.io>
>---
>    ssh signing: Support ECDSA as literal SSH keys
>
>    Keys generated using ssh-keygen -t ecdsa or similar will currently be
>    rejected as literal SSH keys because the prefix is ecdsa-sha2-nistp256,
>    ecdsa-sha2-nistp384 or ecdsa-sha2-nistp521.
>
>    This was acknowledged as an issue in the past, but hasn't yet been
>    fixed.
>
>    https://github.com/git/git/pull/1041#issuecomment-971425601
>
>Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1272%2Falindeman%2Fecdsa-sha2-keys-v1
>Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1272/alindeman/ecdsa-sha2-keys-v1
>Pull-Request: https://github.com/git/git/pull/1272
>
> gpg-interface.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/gpg-interface.c b/gpg-interface.c
>index 280f1fa1a58..086bd03b51d 100644
>--- a/gpg-interface.c
>+++ b/gpg-interface.c
>@@ -779,7 +779,7 @@ static int is_literal_ssh_key(const char *string, const char **key)
> {
> 	if (skip_prefix(string, "key::", key))
> 		return 1;
>-	if (starts_with(string, "ssh-")) {
>+	if (starts_with(string, "ssh-") || starts_with(string, "ecdsa-sha2-")) {
> 		*key = string;
> 		return 1;
> 	}
>
>base-commit: 8ddf593a250e07d388059f7e3f471078e1d2ed5c
>-- 
>gitgitgadget
