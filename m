Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68977C433FE
	for <git@archiver.kernel.org>; Sun, 16 Jan 2022 16:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235569AbiAPQHb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Jan 2022 11:07:31 -0500
Received: from mail-bn7nam10on2073.outbound.protection.outlook.com ([40.107.92.73]:64736
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235584AbiAPQH3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jan 2022 11:07:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NMzYJOV0LaqUEhK4Sh1WoRTjJe/2H4QwCkS+vNDqpPtkVmuJXoZhCLJwGqNE0lZXcUMd0nN5RCeyuymIj0WWXI7oKX8M3THwOch9hmQW6DvCJxzOoMu/Zmj4zutu/L70o9ycaHdfcpUznJ9tEqRUQDiJ3fgh0rx3+S5KbfWTRs0WePnjM9Bf/wGTH8j8hi9Gnwg+j4P1KOvr72cpySG6qFzH37uo7460XL4asg/Lb/yP0IWyCuVLM414OQDCfhrk1XqR8aYxvwQotqi4QIJjeO/s1PZrcOKuPIATGmo8VOtkWflztEgmfGUwvmP/71pAj0lAzLrfF0eix6eaJWs+ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X7nUqMc/gXf98eKjlZUQCmpfdBK7o88IoxXonobp8Bk=;
 b=a2YgTQOtYCqqnl2DQxl0tZ1MSXf/Oz3K3D9uhlcHNRG4Y70H4yXHG4DOsMMZC/FlUmCvTR7ipCccc8olW7ZyOK9osQH5Fh5RrpZr344dJECdjJl+O05Lx4A8OATOHvdnXMXDK9Gj15dIR/twCARnQZ2QLccZnN8lIOSYSni/KZ/gFHmQiJxbPE/PAt83emSwrun5djNiwnVSGtmBuejUdShPvGpc+/IWw9Kh7C29sXeqasdiXVHJJBp/jbpWdlwNbHa1ruJVHsD41eA5zIYB2wlyoM/tiHnBm1yJzz/HaSYMmUc2t+16OcrLxGG2T2XD+ZOgoeDEcORGdGSROQrTrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7nUqMc/gXf98eKjlZUQCmpfdBK7o88IoxXonobp8Bk=;
 b=bt2r4Dn5JabJb5Or2D55Wgzc/gflw1T8q4PgE5YxE6HiAkotsh7twLJbGKlbM8wd8Q8GSH7kFhq8p83MfqsQBFi1ivUidFAGjRQQ+thax/6+ke6VkJwqhNTWHbiVZgRRGOd61W8FLcEmr7obm42Gnbs+3zJcMFrjTYLCUC0qbCwh32zsts++pmfe3cJwtzbFryLmxLVJfqsi52APZ447UiDGPSfk21tdASn1AcGfgxq3tfKmIFnpBfjRTYyfyIa3dWTmm6aqpzIi4xWdu9SfiCxyd/hKj0Sx4YfDaDbndSMGMy808Z9tQWEuvH558E7AcwRh1145nmc5HSx80ebwfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by MN2PR12MB3088.namprd12.prod.outlook.com (2603:10b6:208:c4::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Sun, 16 Jan
 2022 16:07:25 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed%4]) with mapi id 15.20.4888.013; Sun, 16 Jan 2022
 16:07:25 +0000
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
Subject: [PATCH v3 06/21] git-p4: remove commented code
Date:   Sun, 16 Jan 2022 16:05:35 +0000
Message-Id: <20220116160550.514637-7-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220116160550.514637-1-jholdsworth@nvidia.com>
References: <20220116160550.514637-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6PR08CA0019.eurprd08.prod.outlook.com
 (2603:10a6:20b:b2::31) To BL0PR12MB4849.namprd12.prod.outlook.com
 (2603:10b6:208:1c2::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5fce3241-fa54-4238-953d-08d9d90a4987
X-MS-TrafficTypeDiagnostic: MN2PR12MB3088:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB30887C760302E0FFF2C43316C8569@MN2PR12MB3088.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:115;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PB7gpRs6IjvMY6tE2E/uvoejt6VC9hymDsQUHhWvV4PFvlz+acZzs6EmVa8wi8adEcw1QIN3jPlyFqeuAyiUEgqoHmcYAQV1CD/2/+T4jnJAcmKNnfhS5R8vz0xLqscSlUks+tbFYByEVtzwY7/nwUZ7S3Tl0/dpoJrxQ/LLKFnBzECaanT9+F0olaYm1wYxjWXBsKDWU2KzokBIlndiZPAhmQc0MtDbF9vOplEotYXpGuWdPBTmHz8rpPRq9mgP25V1chAk/0c4R/I5muoWL5dFuDOPcMhxqg86CHbcUMv2Fj8X5rFfRni+UY/W8fL0bBjJh1qInxP4kVqi+QTN+EAFTSMJQOK2jJqkaOTnFY9NR2SRhr51+yBzs+n6SPBzjRDMlcTDDrRM0BIIbjQPOkq1FOXA3uwbXsI4ttL16pODqbysnr/3rPTVM1V+hQGdNlDt5msFBub1+kxxernoRKKmNs2C9hai5oimlUru5PpK54a/1pEjSmw7BMhXW/+JLqHVnC7udj4BLla2ydMtxl3gpMryp6vNimvRVFbFwB1Bn6keVHW8Hu0wWC99lkpi9R8fQEGvTuOtdRBi8FV3tB/cCZhtZVNdhdD/P6KsnAY0EFpD691DcOZcNlk/j2x4Ao6prd15t37U+Sssk7K0HEQdr0VGNGmXqzpoYILEtTwHNzK7J4D0d+hXN9nQbXYTPJboQNOrbmyzbNrunE8XTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(36756003)(54906003)(107886003)(7416002)(110136005)(83380400001)(2906002)(186003)(52116002)(38100700002)(316002)(6486002)(8936002)(38350700002)(2616005)(4326008)(8676002)(6512007)(5660300002)(66946007)(508600001)(86362001)(55236004)(1076003)(26005)(66556008)(66476007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R8VqiwWztS8WuHKBOp+pVPnLWkimXCRi8kGa+9dwE9g7u8yLffoBf1xaY6qE?=
 =?us-ascii?Q?lApK7GJCand4vPgUfRxEZwalH11tECmPeD2OEMdxwrxqtq+Rr54927fz+EoM?=
 =?us-ascii?Q?1DEsB2+TrMM1Z/NprIvadtYIJ9mHTrlSjozMbOsguzpYorfDtJv2ZBAxGU+J?=
 =?us-ascii?Q?rPudXUJ+y/PboLGinSdO5Z1CClJY8HgusuJ840GmPvyUofLd4U6AJk/gOrKu?=
 =?us-ascii?Q?KTI3446MZW6DubB/Ut5L1BEMd6XQ0visk6Y/0h+GN2dRiaU5FaYqBYMA3EP7?=
 =?us-ascii?Q?L5yREmAKKLP+FyyeVPXVYfTRH5zLDW6KZzOChqjQgcF1TotA/2/h+WFEUaME?=
 =?us-ascii?Q?dHJXw3mY1KoFHyGeMnnzuAnSE+odFFzVimVwSAMJ9Bqb4w3jdZSHaGcqUQ2k?=
 =?us-ascii?Q?x2tU+ttMpKNblnnbn1LLijjmpErpWXrQv5PoyXcMrCCEIubij7IZFbS+actN?=
 =?us-ascii?Q?urdCJDTD4hqIxTjRrGka20FKYzgAc19NwDaC51A/AKP2qVhoigI/m7+lLTJj?=
 =?us-ascii?Q?EPO0pM1PKO1XR+6u/rXTm7ARyngZO/EADf9fFnwlW6hmkLdcv7HhShHbp2au?=
 =?us-ascii?Q?FKbezJojkO7ezyule/PXn0fW5gad/+nV2FLQ3hKHGFWxW7G0d58NDaYNL2VJ?=
 =?us-ascii?Q?6XOfYxzb2Qka5fM3UPgz7WmacvbaTeUXkJIOcZuEh/Hi8xrWLbXtk5Wwz36O?=
 =?us-ascii?Q?JGcayvgXO8UGIVoYLzvguHHeEAgJ3DThMJMKnc3jkO/s5NOJbzaf8aTr6g99?=
 =?us-ascii?Q?S+DTYdWk/mMGS3bUlTPdS27KZeQ90PGfxe4zlbrbxFBqM0VFqZCJqKZG9wuv?=
 =?us-ascii?Q?wdMNj2MeLM6XV0rbng36PA8UsN/53lwiGUskTtBXXpi9yzedfXo98kxSl3cZ?=
 =?us-ascii?Q?gH+Mnm1nCHAksuFWGGchAWRzMOiknhKtTFDh7sMCZNW9HICUxual+cfD8vgF?=
 =?us-ascii?Q?biEoqg6HNDnyn78A3qYcg/ifaLFsQg545y/FAJ5OinAu6V9Ac54WQxKHJ8UC?=
 =?us-ascii?Q?tKYCL6Hs6zIgXmSB1mLdTusW6E7J1iZdP1tg/HhZYpnz4+HEl1yrJ21bqejW?=
 =?us-ascii?Q?6Y5oT+uAehk3xQFMVAAzSr6Dbz6mP2rOyQ/2lSojhkV3BiWbwBt1gG0x2nsv?=
 =?us-ascii?Q?qN36W/lzaIcfM9OxL43AhsEWjFCQfspmxT0xCJjdEFxZYthx4Vxk3yJqWpjU?=
 =?us-ascii?Q?J/zEE7dkd5yl3IkG/E1xtSC2NRnVCX744m0yEP/YkRGvarV15YKgGV3Bntxl?=
 =?us-ascii?Q?Q+UC2eABceMAyS/jkvMYITp/fqtMncwvwi5FlSuM/EBonXgETq5MW8cCJ56G?=
 =?us-ascii?Q?cwUEW+voC4JwiOICC7DOhZMaDM1O0INGSx2EKuumGQJqDis+cv5OkZ9gZePx?=
 =?us-ascii?Q?9mgdldH+0FY2DuxWkfbEniFDdsWNfZU9wOJs8QPUv2ax9fni96v6jdaz12W4?=
 =?us-ascii?Q?FQPZWZiXhpDd60AbQ6hncMwLD+v3MmSZXXhV5vQ66kcCU1D6jYubT9+R+IXB?=
 =?us-ascii?Q?DUea6AGthMsd93N8ec8ByQmF5BljGknPONywsrK9+mE7xXC7Jfgm4FVANbtc?=
 =?us-ascii?Q?ZTjuGrY6WnkiuaFDhEtYEzq801X4ARKaBkxf1hDmrIZ/VOFIzyAdBKXQmN7p?=
 =?us-ascii?Q?VPUVDiRlSDUaTeLfB0H9WFw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fce3241-fa54-4238-953d-08d9d90a4987
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2022 16:07:25.8033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5WqquN2Rfby0W4Wmxg4/awZs+h/q7v9GxBrKHXY4KzHQ1rs9/PCSL7sox3Z0Q4cxUHT7jkSmSjZrvG1LghvBJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3088
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously, the script contained commented code including Python 2 print
statements. Presumably, these were used as a developer aid at some point
in history. However, the commented code is generally undesirable, and
this commented code serves no useful purpose. Therefore this patch
removes it.

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 01e4e58561..bfd39b430f 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -3641,23 +3641,18 @@ def importNewBranch(self, branch, maxChange):
         self.gitStream.flush()
         branchPrefix = self.depotPaths[0] + branch + "/"
         range = "@1,%s" % maxChange
-        #print "prefix" + branchPrefix
         changes = p4ChangesForPaths([branchPrefix], range, self.changes_block_size)
         if len(changes) <= 0:
             return False
         firstChange = changes[0]
-        #print "first change in branch: %s" % firstChange
         sourceBranch = self.knownBranches[branch]
         sourceDepotPath = self.depotPaths[0] + sourceBranch
         sourceRef = self.gitRefForBranch(sourceBranch)
-        #print "source " + sourceBranch
 
         branchParentChange = int(p4Cmd(["changes", "-m", "1", "%s...@1,%s" % (sourceDepotPath, firstChange)])["change"])
-        #print "branch parent: %s" % branchParentChange
         gitParent = self.gitCommitByP4Change(sourceRef, branchParentChange)
         if len(gitParent) > 0:
             self.initialParents[self.gitRefForBranch(branch)] = gitParent
-            #print "parent git commit: %s" % gitParent
 
         self.importChanges(changes)
         return True
@@ -3800,8 +3795,6 @@ def importHeadRevision(self, revision):
                 newestRevision = change
 
             if info["action"] in self.delete_actions:
-                # don't increase the file cnt, otherwise details["depotFile123"] will have gaps!
-                #fileCnt = fileCnt + 1
                 continue
 
             for prop in ["depotFile", "rev", "action", "type" ]:
-- 
2.34.1

