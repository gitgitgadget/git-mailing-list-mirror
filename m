Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCA8C4332F
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 13:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353845AbiALNti (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 08:49:38 -0500
Received: from mail-dm6nam12on2043.outbound.protection.outlook.com ([40.107.243.43]:61056
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1353738AbiALNtZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 08:49:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RoFvvVdE5syALkYirs5KfYKZrfdqj64Ji62K9lQCnCzwDjd6on+c/Jts3Dt5OthGWkV+QZrD5VzH7wRqJuYR0OHNeOdNSIDMK2hvGnGDRdGWC6MT3wcHfMKTWUR0dPpQoLsEZCRm2Ay5fP1J+npCPw0b2Gv2S8ExhWeNBjQF91eYfm3fdzqpRV3dDelxkazAk+BPZlon8fdWIsDIp8V1Bxt3kUfqkyW9RUv0k0/0UtUp7v1l3MqlJnezkUUS90LUqG/FqbVP5ZS+Q+UhQrblUrteKmliNGhdm7EO0azAJYfnh4D9mM0LoLxCSYdE2FHvCP/H/pXasINFW/H1yhkyTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P4RW3CwHRu5AhWGd8SBYcPwqw6ICbvKjUmwancHoanM=;
 b=gFNOsYA3MvaLDiJrH6Vm8Z0PNY7XukCBlwzouLo0O8eyqs6eSmyMzYAF4NPnLAKb6Fs+ahsBp0NQVl5DH0IrNTh7gLFXB+n9IYGq6oT2bM+i5ZY0/Cczg1sahxFKkazUAx7tr/BYg1nihxwwSUEhQV7RcTdsjo097Gn1XZ1ThrDqFBvrtYMHXFNclfPUzgqQuBJiazZRqZAL/b64ShTfXQci/NkpyKjdJZaEyj00KqcyFxkC3qVP/JCOoKsiRfbxNWzmSnofYdZGEuwHSWjzT2EDl/ZR5S5xw4TNvJezdKFemHtwgfqcb0WeXQ/sRzmDOPNHwiJQbJ4Vixi9WB/qGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P4RW3CwHRu5AhWGd8SBYcPwqw6ICbvKjUmwancHoanM=;
 b=jbSHlv8hgERRdFmIz5OHB67NN+awOM2RFmRJzjXG7INBmIQVXGyPkZ0rQwdUGX7Vy4Qs7MpR9Yqalw0A4ApfSGF0gJ8mnl/hzlOzE03D9fTj+W1A1uLcHiWvHXAuxL2ibg0Vjb1MAOjIHwYxYQjEXWjcZCWmTVvcRS1xagB0AI/gyrLHdku7oS6RJyyzBfHsLpHcxdK05wjBFmqxy5IV7hLZVppRu2y0OwFRO0eI/EMRIcL08k7BrTaetxJ/GEPUKmvc3R6eFUBI28i4D/fcU4fC9CpZVbm9+6hF4l3FkwoeWtZ7BL2XAo5SneO4UGtjMkqDjrC3xwrZWkoZvDMr/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by DM5PR12MB1594.namprd12.prod.outlook.com (2603:10b6:4:e::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.11; Wed, 12 Jan 2022 13:47:45 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed%4]) with mapi id 15.20.4888.010; Wed, 12 Jan 2022
 13:47:45 +0000
From:   Joel Holdsworth <jholdsworth@nvidia.com>
To:     git@vger.kernel.org, Luke Diamand <luke@diamand.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>,
        Joel Holdsworth <jholdsworth@nvidia.com>
Subject: [PATCH 18/20] git-p4: only seperate code blocks by a single empty line
Date:   Wed, 12 Jan 2022 13:46:33 +0000
Message-Id: <20220112134635.177877-19-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220112134635.177877-1-jholdsworth@nvidia.com>
References: <20220112134635.177877-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR04CA0137.eurprd04.prod.outlook.com (2603:10a6:207::21)
 To BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1063e25c-27ca-4499-fede-08d9d5d21c85
X-MS-TrafficTypeDiagnostic: DM5PR12MB1594:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1594EB4C00FE0D0C82647B10C8529@DM5PR12MB1594.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TdA5zKtSKqKVI7WfXv5N6D8k4FFjqFjWe1yPSIGS2rcndYUU74CAY5pxm1VM3jKOZ3Ik70ux6ZsVlu8xTNJl1KvRTDuq2sHo6QBuzh3Ia20Lk/ote7C26EQm+KkWvIMnVqeWQUV0Ybi3Pl7eqZJhNKbZZEiQaKTevfAOLqmfWpRWDyK4f/czC0Bx6YMKtrRsAsfsSo4A2XU7e2SKYa4KrVMrhU8vJR15skxGhJit5F+9hRXlPeO5p3SWcckPSo80hNWlLsITfMWkWTVYyCQ2TjWLU7eE68TnHQIYkck+8p6v/XrofFcS1nptq9AjfP9dS6W1ea6l0vvbt8ma+H40GXECDi93HpIS6cPPXq5EotGz7+VDUEwNktGEqQIyrmkj4CxP4pnp/97GpbTyzVPYSKxJUqKicW3Le+zG+jqWQMGCLiySqdXzmJ4AiZ+TOEsqlAIPafivNVuOsP0Y67yFq13gkqtJtrAJQ7X4pihvNsFp+0et397IsHj7rfLEwCrBRuUO4e45mRXoIWq8RR3HgyGrsPTtfxYDCP7cy84dgNhkGMd2I0FsGfU7LQ4cRixsoJ86MpbArc3Bktp0RbIn+9ug6aW2cV7A8/rS6sBmYdCROSNbmefzwvQeAGWighZXzm8PZbJ6wa+FrO4ict7UW1dWYkYL7SiZkoq+sF03PyBvXeg6bRPYsERFCh39iBbZSfWXQB4gWfYHhkT54rmlZZ2catl0BuRTfCWjupT3obCHqm5Z2xCqyDGRluOXzU7k/1/gY44k7qMXhw5cQ6wcMh6Ma5mYB9hByhxLZ3IZaLw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(5660300002)(1076003)(26005)(38350700002)(2616005)(55236004)(186003)(54906003)(66946007)(52116002)(38100700002)(6666004)(8936002)(7416002)(83380400001)(8676002)(4744005)(107886003)(66476007)(6512007)(508600001)(36756003)(316002)(86362001)(6506007)(2906002)(4326008)(110136005)(66556008)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0yEh4FFpG42SFbW+heIP8fEfpkMLCaYdbdJcE9FAjbk4ZSY623zXv4WzzMVs?=
 =?us-ascii?Q?cdaC+ocIOJFsdPO4kGIdS7QcNC8LRyysx/O24VqIf/QrF+C4ieiYKZ0iez0Q?=
 =?us-ascii?Q?UvqJsX51rL7cVL/DUzxDuRu13p4c1TsAfRYAVqPZPJoMiAKGMoc3jaf79hL7?=
 =?us-ascii?Q?8AtVfIFfLgJUNF5KSZZcmikT4SaQU6bw5FZirH9DsN6tAvnQ2J095sjK1SNK?=
 =?us-ascii?Q?ja3wd51MjYkHMZ2vttWAT7U40AT1q18mHgOupgZhpDLXTQoOFUx7dsEDZ8vC?=
 =?us-ascii?Q?KzuCzGOGESTY8QLGzpLE2aBtbxJ7csFOwecyLjr72V4MwmCiSIFHemWmuZci?=
 =?us-ascii?Q?DzrevB+YYz3VpWLPPVO6IXxahkXD54P9qufLrCAFBIEtSXfEQKLt304EODen?=
 =?us-ascii?Q?38sTh8LuFttT54mxk8LoNpL9CONlETUmnp52XiQFiGcJqB1iLh+QKDtL6G3S?=
 =?us-ascii?Q?apppxEqwmIBdb9trH4TrQcNPBU+RjPjraF061QUlCpjsu7dFtYya3swVDBPm?=
 =?us-ascii?Q?FS+3LsGeOKsBSgfXCHKWCQ3A2mCnQPzjPjqFIeWd24b1D5O39KiIuzuAO2SM?=
 =?us-ascii?Q?mzQkKhJQEuM3Vr4DPKs6yRvOvIB9NX73IZfkoLcLm8c+ajzFSCWEnJNzVQIi?=
 =?us-ascii?Q?OTRaYPUIBlMcMglE0Vh4XruDg/gOWlQhoTgdWDEY5opE7K13WSk+lDNJBoUK?=
 =?us-ascii?Q?ef7q52GCzIAdlmJBhE7BDOQDoSbvXRLBerOohgGgmEUsh8HSx7uBGXtfPXpv?=
 =?us-ascii?Q?u66PdZavWcGUdpGx21tAb+IVtVDDNYOK1ztFc1MuzIXteDjSiJgnpRUN33UN?=
 =?us-ascii?Q?IK9gawf3PR2eKzF6UrvoU0Gz8gbGt0BYfNcqk909KMKxBXxuT8gnRey3LQOE?=
 =?us-ascii?Q?IxGYyRYJayuzWZsnOYStCyWk3vjiJo10O/N2atR572EtXkOgGMuqU9/vxTeF?=
 =?us-ascii?Q?L1meYXrzLNJQ1tfRm95uyA8iklzv67yiVBR3nJojAW7Arctgv+NhSK5mz2I9?=
 =?us-ascii?Q?P70cHaECePgDMthuWD/KrBCXizSJPt/8zfEKBLgcbhYgQOTHxZmtM6SMWvWs?=
 =?us-ascii?Q?oxtO9T4Nbiacx+PmbqQ2hY3Dt3O+gnA9y6qIpcIySZbMoDCI1ysBzhxDiATh?=
 =?us-ascii?Q?QLYoHjF8ba4Hp1uuIYmzDDs02vd2IZzKhMgEELD1AQIA4Jt2O+np9hBmmOi5?=
 =?us-ascii?Q?4bLL8IRwsGWpsuaC6UpBHqcUXBAnsvZMyBTRuqnDPYh/JcvKCP4tIeGH7Qsi?=
 =?us-ascii?Q?uTXi+JBA/eka2uwKBfcFqsDYteVzI5I4mAfoKGA+Zl5EgfpLHERAMW5OPLD8?=
 =?us-ascii?Q?7Ky9lWqx11McGEp4lVp7FTnO1sWn/2s/NyNVJTk8sXYrqlbII531P75Lv5Xc?=
 =?us-ascii?Q?6x4MwPia9N0drXN4R0VJWVjHcDJMq6+YxM5WBA0OjS/3RWbhGjPnAAdBlOQ4?=
 =?us-ascii?Q?wh0P3QAj2BjlcSexRPdTLa7etdtHf/A+B51j4hpliHANkMgf4ppJ3TWJvKsT?=
 =?us-ascii?Q?5G88NVtUbG0kB5Gkks1vyD6xTO7KptSYwkwiNvKGHDNmhLVbTcmMoDKLfflO?=
 =?us-ascii?Q?0GypapGKhBSpEcbW0YkAqncuDmcLLLKjMn1xsePDEt9E6U6nQvNirZbGPM3K?=
 =?us-ascii?Q?pU/nhXnpYX0tChat8cjy/j8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1063e25c-27ca-4499-fede-08d9d5d21c85
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 13:47:45.0058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zkj6lf8+O/W+QclTCi+iALnTbpIvTFeemvbRj7gHr4BmZwaBT902UL9OTD/vqazlOVMiC6BNwb5FnJCU45K2MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1594
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PEP8 recommends that blank lines should be used sparingly to separate
sections in the "Blank Lines" section:

https://www.python.org/dev/peps/pep-0008/#blank-lines

This patch replaces all double blank-line separations with a single
blank line.

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 2 --
 1 file changed, 2 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 2a3409ebd2..58f11ee41c 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -3593,7 +3593,6 @@ def getBranchMapping(self):
                 if source not in self.knownBranches:
                     lostAndFoundBranches.add(source)
 
-
         for branch in lostAndFoundBranches:
             self.knownBranches[branch] = branch
 
@@ -3816,7 +3815,6 @@ def importHeadRevision(self, revision):
                 sys.stderr.write("p4 exitcode: %s\n" % info['p4ExitCode'])
                 sys.exit(1)
 
-
             change = int(info["change"])
             if change > newestRevision:
                 newestRevision = change
-- 
2.34.1

