Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009D7C433F5
	for <git@archiver.kernel.org>; Sun, 19 Dec 2021 15:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbhLSPlA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Dec 2021 10:41:00 -0500
Received: from mail-mw2nam12on2052.outbound.protection.outlook.com ([40.107.244.52]:55520
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229870AbhLSPk7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Dec 2021 10:40:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPAoSKFRaeBIplxhQyHHrJq19KrnJwtgxz8OhLD56rumfOFIWqVGNi3vPc2MwWHDL27kf+mDiVi+ULGpe9aqrdKfXdT2pTKYFIRIGbUgYLuW0cMpuCrovwx1t65ZE1SO6O+CI7po+ttdubF5Apxr0g0NqyqV+7jrNB5WLkTB9rTQNjwKX3ehIoRgx7yieVECnzgpbE3aCDhkplHBwLXNFWSBK43pAICN3nCEPeyHDsuCufzQEHXNQgNlYkAnaeinEnZEhlJeV4R0XO5pHsdZwMGkMhIg84Fuo/tUVkCQY7+guHzMz2ov3ZKSN99s98zRxRcceecHA+V5Fz9Yj3kjTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3fB2IF+bGDIL5QhSGJ+URmH0csJP4MjvR05payCQHiE=;
 b=WtPVjG7dQ+nG4AmkE1ytqFo4ff09F3/7uH4W4SzFwWQqD25siz8AS3a3mmsjs12mLOU6ndMsFmCo6Oub1KEZwf5mGvykoB8DbvJlzcIED2hD2b+gXjImbjQ4XQa7clnnW50YIemw4T/zt/W5NdX506pF1sOdxkCkhMHdlmJmY3buUwBE8H1YL+U92LDrr9J7J3Oray5MS1n6NUwSdlaOO3r7ijlw2/wZxEdXIuK5cLG4RMLno76Ar7+iMUAcLiC9JsUv170sudo2WaDLvwyNoE3VjN8kcnRQ73VQAi2/Qx9aTpkJrYcR3eqD55pi6PaiolfFpPB5FGjUAscF6C0AVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fB2IF+bGDIL5QhSGJ+URmH0csJP4MjvR05payCQHiE=;
 b=lirDMfhPNsoeuvE+bZHk462Dw2dc/9UglIlM0u7BoOlFrWQqAK8EViL5LJSixKojnDnIoCPs19OqETrpfqDVf/wU617Noe40llHCQb2irWx+egRhLNOeLessYLSUUVUrOsXRWDHmMPTrlSFepCfu0y4b7CzAmqbSIhzXnfhnG6ZAQomYWL3J5Rbkv9Oy5aApnfotL8bXOyU3qKtb/1HobLX6Hw0VoE9sJ1SbtC7tmNYEbqQk22itcTSeI2XfdQL/cj9dSly+Y6rMWLGMF6YkYiJVscg9XcFhWY5uXu0o9Dwj9VhSleNv0tnOumqutlIl70jwD+thTnT3viaDWwdapQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB3361.namprd12.prod.outlook.com (2603:10b6:408:67::19)
 by BN6PR12MB1186.namprd12.prod.outlook.com (2603:10b6:404:1c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Sun, 19 Dec
 2021 15:40:52 +0000
Received: from BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592]) by BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592%3]) with mapi id 15.20.4801.020; Sun, 19 Dec 2021
 15:40:52 +0000
From:   Joel Holdsworth <jholdsworth@nvidia.com>
To:     git@vger.kernel.org
Cc:     Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Luke Diamand <luke@diamand.org>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>,
        Joel Holdsworth <jholdsworth@nvidia.com>
Subject: [PATCH v3 0/2] git-p4: improve formatting of numeric values
Date:   Sun, 19 Dec 2021 15:40:26 +0000
Message-Id: <20211219154028.3288756-1-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0098.eurprd04.prod.outlook.com
 (2603:10a6:208:be::39) To BN8PR12MB3361.namprd12.prod.outlook.com
 (2603:10b6:408:67::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7d704c6-9757-4c74-50da-08d9c305eff8
X-MS-TrafficTypeDiagnostic: BN6PR12MB1186:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB11863279C9D7889A4D52737CC87A9@BN6PR12MB1186.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rMxDqXuSO9muc1WlIdGu14Jy2X+fSPjc4FKqKEXXjW95Zmjid4zfoo0n3xmfkcSdBS5yJahbm7Wa65nDp3nxrlRGFr0+/Q0Z9DFgz16tlghp2asUr5Cn6MDLWSlas3lA2mx66FYQLzKklPsK1HqlkjD62DNnMESG30pRKxHuZIx7syP/dZdAfmzMVOcfSWokY6nd8WqoTEI6Bdz+HiV/Xpx3pcxwQeULhrZRxCDeW/pXhp2a/0o8rvd+nEcCBovr5SHATtRmhtgCmAfv0zuUIygCUAObzRPPtf1A9lQ2x/aEgMc6qpcCORezA+exS3VJDc2A9/zXGzGnwuNAWhER9mBhTVacs3v0TK/0aPhT4D5/a8trj5NlOdnsqi8BjNqK9xFZPxe/2581WSxd9YPKZgm2JCPa0Yzk+E+i5SVA/++AZA2dJirvsyvVGmiPPMXQjgtaOJ0n6P393GBBU1eaKwa5gWxBJlzRstQrLe8weWNiWXN3d6ZEAmsjCIyKaZpkb2yEfu2ybKgvhcxt/V8n9slz1Jv1p2fahKfcgDKQSdjiZ/5Da7hpDvJukwSMPGG6M5BckeCrUMAxQF5bOU1ufS4v+8v7/tS+Ivv1zMNIds3Ajod0IqmFFFn4zTEIlDlvnoVXb+FrwzUxEcp5TPkRKHV2itBrxHcZF+dDzTNoKQAZ686nIh09OfKwkgC+yEu1nKy/90dEFn1yORo6NyFQVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3361.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(186003)(6512007)(26005)(6916009)(52116002)(8936002)(6506007)(66946007)(1076003)(4744005)(8676002)(66556008)(6666004)(55236004)(66476007)(508600001)(6486002)(2906002)(54906003)(2616005)(38100700002)(38350700002)(107886003)(36756003)(4326008)(316002)(5660300002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9045Vq5qRZgRKXwdS+GZxSumIHeu0aEgwY48WeycTTw77ITUvxwTNe9/6z5l?=
 =?us-ascii?Q?nYBrjHkE3qB3jczohBn3IViEQ413eBdC1W4a1swy5eR3atNI655zlrVy6DOr?=
 =?us-ascii?Q?GQcRsyY+Yq2ucKigpFUR5zycHWukpZw8zirrVedH6yNBpDAieXVlM4Jwctzc?=
 =?us-ascii?Q?UWmlptXfaG7Xkz1seChv18mGC8+BQJFM4c/Dc0I6QWBIaXT3+5WL61hDFWEI?=
 =?us-ascii?Q?GlHQP6me0O+NVKRYH9t3cRw+2+591mNyLpknFUjzHOcU0HtXcaimW+o9jlOB?=
 =?us-ascii?Q?CaeE9624AJQ5gqcr97LQFq3rn5KZQVu2LPyBEI6xraz3vEvNGVaSW0ItfvZq?=
 =?us-ascii?Q?a94TKm4IHsnDmcZbb9OJ9TRJhad4zGPseuzx2LMbPCGQnImxe9OYVl08faGK?=
 =?us-ascii?Q?HDSH4hR4FJMSHRROjsZqntHVBOrYR5lkWoEs/y5cBuj6Tm2TEw4jpXXHHlB+?=
 =?us-ascii?Q?CRSUAtgbZDVZu8FtlWceXb6cZeM6mDjgxg0fTBdp+efzQYLKxpUeFHrquy0U?=
 =?us-ascii?Q?R3ZjeXOMtzhNRcwfq/8xMeAetzVMUYh2MxZv4/7qG8l83gmuxaulROySr7NT?=
 =?us-ascii?Q?4EqLzJ62GcQq+Rclf7l1tyOV5do1PTwLNsTzqcASlJy/P9EIYe6yXSuXWG5E?=
 =?us-ascii?Q?OZd0huWuwic29S0XbRT0IesSIWRPaz4q/JaebeqkqwftLMz0YVGPbXELQOSH?=
 =?us-ascii?Q?9yd5dJ5bee9Krjm4raLCLEjm3NTitSP8IpNom6OUQREJLF3U352r6FtAkV35?=
 =?us-ascii?Q?J5rnOKOnbJMM8bMRiXs0QQdxG+wbCv+CR+4kpazK9nx1POUnXsdzKdZNM/GM?=
 =?us-ascii?Q?xUikGglhyqIGugbLPWYjZJask8161SUwtFlHXueAgLcq46n/l7HtH3ycTUNC?=
 =?us-ascii?Q?bfwwE3fSOF9Pbyn50AAhFDVVwqQ9KfQI2F4zhgNwUp6RpjgXvCeUxWzl5/qO?=
 =?us-ascii?Q?ZCreptk6T9mBwVGJX0MvuMoedjgN4d47rKT+yLxFPyOv7emyv6TgQzFJDrgJ?=
 =?us-ascii?Q?HO6hLOfyuYJ+Pz3m6QSR8YbIRNcDToxHnkyNxp+VARR4c8dx0t2HJ9LM7QrU?=
 =?us-ascii?Q?gN3tZLKWLaM+iMW/nBhapIbt8z7QgTWiFF6PT96PpZwqx+NY+dy2XBRXJo40?=
 =?us-ascii?Q?mxHj9nbZyE3V1gct01bQq+mWbUDU9i463KazMYaq3+0ckJHqbrlqESC+oP53?=
 =?us-ascii?Q?1dJP/2oPEeNfLp5+xaUy7D2Si2lYt95pQx2156z98arWQjFXe2F5qy0jsUhB?=
 =?us-ascii?Q?dPRgrhffVbhQaYAOFV9Sf1z/8euourwUCUJGohsQP/pmiqxdXUW28gxnTqHd?=
 =?us-ascii?Q?BPl7dpyvmeSoKDMgIPhDr9s9oTTQMkJcwOdlXHmgYovh3KA31F6B7nX/NC5+?=
 =?us-ascii?Q?GBUOUAmQfQ6rQArm2/8nzKVxIc4XNtzLiC0gXXYeB+Jl+fAuERfTcidZxocV?=
 =?us-ascii?Q?aOejKMTpWCVjST3vjwn1Z1q1fMMw80PohE6HvG2FM5wlx65lTjWTa4oIjmlP?=
 =?us-ascii?Q?sb8zWmwt5vGbtYbiCvVy4IcahsxfwoVZyhAPauTHpfnWJS52xMXL+f6wrBET?=
 =?us-ascii?Q?DDlUbJWAefjHOljcM+iCUt1MgMuPAdi94R74CFQLzd/KWwKTevvR5+oJRxSt?=
 =?us-ascii?Q?pu1MNqyl9u64a6TsaJWm4Eo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7d704c6-9757-4c74-50da-08d9c305eff8
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3361.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2021 15:40:52.0395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wng3FpfF0eH1w9GNtDaRiu47htIrehDNGpQe8Irv1FzapMcfM8wbUcacD0EFIEjwFVH96lpBy8A91XPsYwcCpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1186
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch-set contains patches designed to improve the way in which the
git-p4 script reports files sizes and percentage values in an effort to
improve the readability of the logged messages.

Joel Holdsworth (2):
  git-p4: print size values in appropriate units
  git-p4: show progress as an integer

 git-p4.py | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

-- 
2.34.1

