Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD28C433F5
	for <git@archiver.kernel.org>; Sun, 28 Nov 2021 12:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352645AbhK1NCY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Nov 2021 08:02:24 -0500
Received: from mail-eopbgr130073.outbound.protection.outlook.com ([40.107.13.73]:16926
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1357490AbhK1NAX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Nov 2021 08:00:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Te+tPRJE0XX+PnWEpZO7GaEkM30/3ow2lv3CKsTw0mIpS1PD9NZSKrz5+QmxUsSBMi1RZ+AQSlPt/lxXMSa0NKYh/II79VDdZtlOSIKlsaZUcNW+zy5FDA+3S2D4zbFZX6DXrWLzQIL7LK3YyN2GJKFVJ89Krl4Jp55XEFyxxlJJAYVzemIkfrR+4Ei3nk7yPf6J9PZpHnFrlvusTXu1QCeWvyFuzyPRwHYXWTP3pwVjYTfpxjC9xItHV4SLT3H1HtvNm+ppzixWTDQN5u00C0YEcDDanCiGfj9om8XCwUbMTM2s5SJjj7BmdH7mWCIU/lQn0JI+PQteHaMVzgvGLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fRHmswTW/Sbrum73kd2RUNI2E6v/T4WJlZIU10h7y2c=;
 b=W5lA2Tno9vwZwYMLbQ0NfMdwoupuVCJSbAQOxw9I2Gqyk3nMBx/ITVcTTmecWo7Xu+gl4ql809MWRQvRI5wovE3J/GTGiA/I8w2NxAHKj+Yf4MBJ3OZR7pF69Nw8ivO0DRONa3KaSGKn5j+G2piYZiPl8i3376xlONfvJyru06bwSK/XEZ3+NSO9en5AXke8rgZ4dTpmO92zX8WSrnmhLRFQJEQg4iOp28//K9pM4AYp70ZWs0CDDAc31KXTg5f/41u3DOGUOZPr9ub1hPGvAhp3p8tjUF2B8kcMMqeQ3GRe0pFLosvgu9Vakx4yQuIXRwdGhhM2C5Ott/ucTCpwNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fRHmswTW/Sbrum73kd2RUNI2E6v/T4WJlZIU10h7y2c=;
 b=DgzjwNuhPntK1o6v9F7m6JzbtUlWgiW+BaFj67ws4k6fSp6vs/xfoXajiGL6q7cn6ntX7BrgtScd2cPGl4OyaKEmcMG0airE35AYdwwJkCO2DUrYnV8DVGt0ih+3iNMEHs1ywXcucg1ohUmw1sPoMyyQC5zg9qeLXUC/ewsdmEQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PA4PR10MB4496.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:103::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.21; Sun, 28 Nov
 2021 12:57:05 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b%6]) with mapi id 15.20.4734.023; Sun, 28 Nov 2021
 12:57:05 +0000
Date:   Sun, 28 Nov 2021 13:57:04 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Subject: Git SSH/GPG signing flags and config
Message-ID: <20211128125704.4twinfd3wriwdntz@fs>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
X-ClientProxiedBy: AS8PR04CA0090.eurprd04.prod.outlook.com
 (2603:10a6:20b:313::35) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2a02:908:178:20a0:d22:c58d:d0a4:a83a) by AS8PR04CA0090.eurprd04.prod.outlook.com (2603:10a6:20b:313::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend Transport; Sun, 28 Nov 2021 12:57:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 713b089d-a28c-496c-12ac-08d9b26e9445
X-MS-TrafficTypeDiagnostic: PA4PR10MB4496:
X-Microsoft-Antispam-PRVS: <PA4PR10MB4496C8F80DBE30A29D4B285AB6659@PA4PR10MB4496.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dnl5NhSWj15NzsLvJMcQZ7GIBiAhg9NEh2A4OT0S1z5KM2odNQoaTCEfL/WNKwmeDAWYLm4NVkghxocjqYKKy4/eUiVRQyTeiqCLQ+gc83dOuIWsqQcmyje3UewL2bVphR+VpMaPxVmQ62gycGZDoKec3O7ucdsutIXYERL3T68aVlIu6tcj/P/Ak84M368WVhRmxdkC3L/kiw4/odqvAUfFxZISqfICrC7bdBheMUhOOJtuFVAQ1e89xJ9Q4leZ5DjK5LCjkduyLmcNurOeQrMR8IK7FHiqUemB3OJ8QVeDpZo8kuJPMIXqtvFu+cRoOuesKGAdCkpLZbZam17Jz+tQikUVsY4134NoY0IuAV0DTw6BLO1SZQmIHkcLej+tibDS1nnZJJvc1fQalMAsADz4JEHYjKOYCIePpo2xy43ZaG+QG4ZzPQf5F3/VVOBvKsnlt3PnYKBvjw3zxoHs1BCDNxnC+iARL5We4s5/wyGhZzJ+VyimK2/Jj+FG/ggK8VCJ2DafF1YeS63vx/AkIPkpCKhUhu8LPghr/Iz7ixNSHyKQ4oPM2v3z2hG5lmpqhCyPgqKANFhhL4i+kxXxZI4j4xriiV1rUBxrVqnxAFrkfqd658Ye+alJa2Zkms8YMWLkgNkN3+5OCq79Y31esQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(7916004)(4636009)(136003)(396003)(376002)(346002)(366004)(39830400003)(66946007)(316002)(6486002)(2906002)(66476007)(508600001)(52116002)(33716001)(5660300002)(38100700002)(1076003)(9686003)(66556008)(186003)(6916009)(86362001)(8936002)(6496006)(8676002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmJ6MWhtTXRVaThmTEdMcFkrSUd3UUZnZjN1WHgyeFYxMm9IeGFjTk9uZk5X?=
 =?utf-8?B?S205Z0NMWG5oaXIxZjd0QlhzOE5QZ1dLTjY5V2ZtRWcwVU9PM1ozVm1Oc0VJ?=
 =?utf-8?B?bWIxOFl4bDdzWWhpMzEvQ0F1aFhtQjVuTzJCRCtzenhIbFZndTY2REY3Tm1m?=
 =?utf-8?B?VWFNU3FPRUpmKzNlTTNReEczVnhseVBrNUVFOTYyNWZXLzN1SjdiVWUrem56?=
 =?utf-8?B?VmFIL3RsWkw0dGNIYWo1ZDJXa2FMQUhOQkpiRkZDNUxLOUtUaU5NTVl5cEhY?=
 =?utf-8?B?ZDczU0tUckFQSW10ck5EbHhvOTZNakVGQzVFNHZEQVFHS054aDEwd0VUSkM3?=
 =?utf-8?B?S1lLaVNwY1FKZFdmSXFMb2d0ZFZwVkxlVi81dnlqSlFzdW1naE5LVk40RmJr?=
 =?utf-8?B?eCtwTXhsZk9MdjNiSElLRU1Lc1BxTXVVVWk0UEphenQxTEhpMHFNeXNFZ0M5?=
 =?utf-8?B?Y2laZHFkQ21lSWFTZC90eEdGSVd5bHROZG1LV2tralhRM2lEWURhL2x3bGlt?=
 =?utf-8?B?TmVoQjgzWDQwbDllTTJONXM3TS93NkFpc0RoT1FDSUEvRjBQZjNsVkRJa0tU?=
 =?utf-8?B?NXhqbklwR2hHQ0x3TEZ5TnNNOXh5MEdHMkI3M2xMWGw1TW1ObEpTVWxFZzc0?=
 =?utf-8?B?cHkySGM2Tjl2T3VhWlV0OHg4Wnp6TzNSbFpyZ2I5T0pKYWNyc3JJUmR0MGdq?=
 =?utf-8?B?YStXNEp3QXd4anVZeENGUGp0eDh3YU0vdDBFUUtJazhwSGNCbjBxTkZ4WENp?=
 =?utf-8?B?b3RKbVlONnNrQlRXRHFRQmxad1FLcXYxY08rbkRJWnF4OVRaMlZEL3dkV3lz?=
 =?utf-8?B?U2trcjB4N01ZTDRPYS9jT3FHQUZ1cmNWTmkwV3psaFNBQmJ5a0hsdTNuVm1Z?=
 =?utf-8?B?dHd4NitkbzV6S2FZbTE4K0N4VUFUd2M2OE0xbG5iZ3YvbE9MSkxJQTJkWFVI?=
 =?utf-8?B?Y2hkWW9salBpa3Z1YlphU1hCR3VpYzdJMlplWFUzRzAvQ1RsK0JiQkZnbGEv?=
 =?utf-8?B?ZkF0U0dwVDF5RTVCb1VaRGVBYmRRaTVoSGpZMzhjRkpIU3FvK3VIKzFzRWdq?=
 =?utf-8?B?OGJmdk9VZVJaNHZhSTNDMFRMY1NDV25kOWlOeU5aSUpaK25hM0VwQk02NnFO?=
 =?utf-8?B?RHFYbmRxcVZqTkFQSDRPOTUyTThpOG52eU1qTEpvc1JZU3NrNXBBOUdKTnVi?=
 =?utf-8?B?NzRwOUp6ajd2L3hRejVrZXJFVHIyOGh0ZG02NzdMSy9JR0FOYmkyaFRnZHVl?=
 =?utf-8?B?QjBjV2VNeDR4TEt4dWNKeFVlSUZzTDM5MGdtM1cxK1IwVHY5OXh1MVdlMVJn?=
 =?utf-8?B?N0d3MmE1ZHJVMmtBK2c3MFNjNThBOFBOY0ErYWtnOHBrZURzd1NvakNlQmk5?=
 =?utf-8?B?T1NmRGNEVmhpMHZwNGpKRFZYbm0rUzlSUHRtMVdwZUVWWnp2Z1ZIamtLcW1I?=
 =?utf-8?B?ZU9Da1hwK09tZExTQjN5Tmtzbzh5THg4OVdWUnRNTTkrM0hYU0ZLYmVTUVlu?=
 =?utf-8?B?djBqeUViY3lLajhVRFh6bHRPOHVCTUZXRktQdnlOWHlMM25ZbHRXMUJzYkhh?=
 =?utf-8?B?UEIxa21UdlhiTElXVmo4MGpBWk9ZTWxhckc5dllYN2J1MUc1eHozYlBac202?=
 =?utf-8?B?VUFUQjU0eGdJQkFkeUxjTVpRa0llRXVuVmk4bGs0aG40VTFRSytvYkdCMzd3?=
 =?utf-8?B?U2dxcTB3MXovM0tlVUZFNTFyU2EzOXJhZk1RbThaREF1ZEhra1RReXd6aU5h?=
 =?utf-8?B?ZFE0MDh4WlplUW9vek1LUlI4dmNJSG1ZcGxuUGkxdCtXc2JPUEYrNE1HOHVZ?=
 =?utf-8?B?YkhxRW5Qbzh3dkNHd3N5V0VVK0lNOHpxalFicnJZZkJ4VEErS0s1WFk1MnV3?=
 =?utf-8?B?TFMweUFMWlZqZlcyRmxOVjZZdk5qMngzTXFUNjV2aXF2bmxxREZ4dUsyMG85?=
 =?utf-8?B?NHZlUjd0eUhJRXJDTlZ1MEZuU0J1VkgwVWVJRW8vTGRqZmFKV1hrSTQzKzl5?=
 =?utf-8?B?Y2tnN3F3ZFhESW55bFdiNnBLK2xvdjhpR3pKdkpwYUhIZ3dEUmx5Q0JNczZa?=
 =?utf-8?B?dXBrQkxOZjdJalVrcDU2czEyQkVxUVBPWDBiVWd5RS9lajZ5N0xOWDVKK1V3?=
 =?utf-8?B?Z1M3OXpORUtKN3pmSStqSHU2MVk3dlRtbXd5OFlXbmVqc09kMVdOWllxdFhB?=
 =?utf-8?B?TDNxR0F0OUlqVnF5VHVzMEpLcXhlcTVGSlAvY2w1TTdldllNTFQyNXpRZ3Nq?=
 =?utf-8?B?ZExqL0RTWmdLd2pzUHI2MGJoTHJjMXlTVlAzYzBBRTEvK09kU2xBcXcyRFFX?=
 =?utf-8?B?L3o0VEZkVWtiaWlNTWhobHIwbE43M2RlYlFsL1UrK0pwQVJIWHVvdz09?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 713b089d-a28c-496c-12ac-08d9b26e9445
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2021 12:57:05.4293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /PKLqzcMAIMy2U/0fYtsGqnNFZ1v7BKZAqzuRbenvDRNGj4Tc52qFbwD+n38rf4ic7KL2fM7brO5IsiFpnLWYTh+v94UOeKvdxNt7EUal98=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB4496
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,
the `signing git objects with ssh` series was released with 2.34 and i'd 
like to thank everyone for your support and the good reviews!
I think it would be beneficial now to adjust some of the wording in flags 
and the config. Currently everything is configured via gpg.* and all the 
`please sign this` flags are named --(no-?)gpg-sign.
I would be in favor of a more generic flag independent of the signing 
mechanism. Adding something like `--ssh-sign` would suggest that you'd be 
able to switch signing format with it which i think would not be terribly 
useful. If you need to use multiple signing mechanism those would usually be 
configured per repository and can easily be done with an `includeif gitdir:` 
in your config.
Therefore i would suggest just adding a generic `--(no-?)sign` to all the 
commands that support gpg-sign right now. The only problem i see is a 
conflict with `--signoff` so i'm open to other naming ideas. The same goes 
for the config. `sign.` as an alias to `gpg.` would work well with the 
current settings.
Let me know what you think and i could prepare a first patch for one command 
to see what the alias / config / docs change could look like.

Best regards,
Fabian
