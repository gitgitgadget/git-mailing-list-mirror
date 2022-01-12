Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223FFC433F5
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 13:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353741AbiALNr5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 08:47:57 -0500
Received: from mail-dm6nam10on2057.outbound.protection.outlook.com ([40.107.93.57]:44001
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1353708AbiALNr2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 08:47:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BVM5og8XT3NT+/3vqXhpJcYb/FiMU2wKFS/tf8xPO1zUmle0s5lHvMMpa421DuotROws1vfuBWYq2isj0y/+PPU5ryz8f4xwSqZuA0pf7D/pT3AlGU4qLrUjSmtiZ9P++aMGY3uQ6By0tKCklRd+kRXCt97LQgfPmdDhI+HpAMPU0WEIvSMSYSAPZDb2o6rcjPmHSuqbLA6hqLGci5yTk4HHXZvG1dLVah2AnSrVX4VeWkQMt27d5KY6haVTPaUODhYRrA/zI32GkYn+7LY0QcyNPIZb2dyuSOhSck/O/IcLMGl9akXZMnr9bcQqXBaWZipsR7QnCIlLopaThdhXZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SJEnspccawyOVQV3jwqKRJ3hhQU8kVH/zT6Y0X/O8iM=;
 b=Xwso6nONq0Wn93D7HSsGjNlw8ZQ9irE3xwpcciNCiuOpPCM8obdgmIKsG0jxcFoLXQeRT8UHWRbVwp+vQHXTwzhC14OUJeJMjKExUiURnJk4VmmYEV01imLLdA+nnjsxhSL6O5dW+d3LKoaqJHUr1ou64P2D0PXT+9u+i/32XNSamfNKAl+8su0a/t1s5eZRrtB8TADkUmWvQ3DZD09MzYCfsP6MZsbUZogBoJfzYtF/ZcCJfALU17dzo1a/kauLWcAArklh8AU8YGI1eA1pyyxqLbhjZPyfuOzL2n9aXYE9Fh0EEDwlp26xBHCdOUmOcki6Thtk+/LmZ3Yk2VkpWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJEnspccawyOVQV3jwqKRJ3hhQU8kVH/zT6Y0X/O8iM=;
 b=DuWJiq6AtXDvCWK4pBOy/wgiRURQYu1WKNivxaEbS1QlNdxhJV+v9QIMTYIVphX1omrV7liUeSVeyyCvBicx38tbnAukv3SxfsIJjRpEPMYKQFnMG1QdsptE1uwLZtGfQhA62YLwkbHa+u9H8Z29KbG64vGou8LGYzs6Lw5mLFdYUZ1Cqos82hNJuMYIfw3yVrYyu/in7hsPRoHA0JtQcgpAnt5HtpNKLa8ISdyqM0JQ597WxKtd/3MPMI0i4YNcgrKiIoeluYIYL1WIKka0Bl7ACCigqjNSPxHoUd9h66R+qAArE00uOOsPss+AKiE2I3/F3+j+SsDodQaIfh33NA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by MN2PR12MB3693.namprd12.prod.outlook.com (2603:10b6:208:159::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Wed, 12 Jan
 2022 13:47:26 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed%4]) with mapi id 15.20.4888.010; Wed, 12 Jan 2022
 13:47:26 +0000
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
Subject: [PATCH 09/20] git-p4: remove spaces around default arguments
Date:   Wed, 12 Jan 2022 13:46:24 +0000
Message-Id: <20220112134635.177877-10-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220112134635.177877-1-jholdsworth@nvidia.com>
References: <20220112134635.177877-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR04CA0137.eurprd04.prod.outlook.com (2603:10a6:207::21)
 To BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 636aa3f0-6afb-42d0-4cc9-08d9d5d21193
X-MS-TrafficTypeDiagnostic: MN2PR12MB3693:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3693344DF9C525CF4B496E19C8529@MN2PR12MB3693.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:158;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F/+duNyS8Mu81EPdxJb68gFvHeN+7GtAWkFGc+lg+ZePCBvTlJvFUVJlNodhc2T0KDsRL0KTOVINC0f4IozZW9ymqwPP7DPAJLiM0zpIJlxJDJdkP1dQwOlOvLccZw4d6AerS+Ro8AjlK3muAWUkyUKrCvpCpaWL+yhQsM+taa5rlnOSrDSKGYuKPTtUi7AnOvmluxDOF2U7wnWvgyoyzloxh+WQGF5JFhsleLea6tdPGt5BgWChAfPs+Ga0FYXtGLwCm/TrHFWNrY/JvetHL1KV2tTfrABpOFfEPvgodacza1NTnRRk6n04mIKXzDUGv0BymnTanPcrhR11hQDQ3jYlLzmsa1xVxdH894MYroR/ctPJdnT2EdVfgdmN2cORDokyfJJQVsfVqDprFbLfDIebK4JTQDcrjbwOwC9JNWg0PN7/+m0hF1ZByepBN4rKKkhlDIzkrIbC7+Ne6ZDLPGUEJPTEIo0Bx1Q7ydIm55OHYE80TbNEi2rsml7sb2VzLoRykKG9iOk46KmAres8L4P3MkUX3dCiKzI9bmAC9fks6Ny1J9QAxplk28Sjr4LcK2vFKi7UDWoW5t8JLIyNa9+UTOnUuziU4yfPkSkB7qB9orDqC1t49h8NmqTkVb+WC+F0sNugxe3GJvGZhEIiP4EfgHXD0tYcVOEfNg2GSbzFhx92SktAfBKAv57wv+CFwAoxJMfjPmLH6p0sK0vX3GSBBtVH4h6TJWd4z2t3fZ8rlu0JNrc6aaqZd66LYBgCJdsCqjaCg3sEieqftVjzj4SCIJJGqevb6GbscPRUPgE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(1076003)(508600001)(7416002)(8676002)(107886003)(8936002)(4326008)(86362001)(966005)(2616005)(186003)(6486002)(66946007)(66476007)(66556008)(110136005)(52116002)(38100700002)(38350700002)(6512007)(26005)(54906003)(316002)(83380400001)(6506007)(2906002)(36756003)(5660300002)(55236004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8WFj5Dca2cwN0EwXTDjyKzNnSXVLuhasGAcqoGphN3Gs/jE4VuuDIvsjHCdh?=
 =?us-ascii?Q?kDQ62HDjDouDpoAu72MPhYZXEqu4Qdnfd7ddq3wgdB7d7pIhlkOhsQKDFS51?=
 =?us-ascii?Q?1tw3sONjoLpk+amsuyUnAV/5yBI8m0w+1mfmCHa3rM4lJ7UvWZ7E/HcPUQfj?=
 =?us-ascii?Q?/A0Wf4MwXXF0qViNUJBHMqwFvJp0Bdcz+9xtKlwR8k23mUk4Q95faPw1HLS6?=
 =?us-ascii?Q?48c3PrSKioKrMXflgn3SDrYcmX00up1z7LDt5yzGZnpVQFWjLTvsolQSOzFn?=
 =?us-ascii?Q?Z98eG+gA1XJ4OPChQxN1OADjLvlrR5aMgGLAu6vv3BWRyL43obkTcQ11bsC8?=
 =?us-ascii?Q?pm51p6honwmI5CuOFGhkGH1Bmpw0qYGomjVHmZ0cTjEf38f4v6Gj0P8kCh45?=
 =?us-ascii?Q?sKzMPClCSGbKAciS34vBs9L52Sj4py4wiW1Mtuzg6q0WXbv6pcuwR5lrPozN?=
 =?us-ascii?Q?Lkk37TgQEGYqe6Ad+69HMqyTNau2NIUle0XPcBl6eN4qmdB8wxzH0wRF0Xso?=
 =?us-ascii?Q?DRt7CHpWdZnWSA8rR2PkglRhqhcYewgvKTUwNr64Nj+coyb7Gv7WwtxO1UgE?=
 =?us-ascii?Q?AIdF6UvmCA4GdSfbxPOynnOODPdgxPh3q+bfIG9Aow5IbjktWCX5Dg1hOhus?=
 =?us-ascii?Q?zFNmSJFWa7h4Mg0k3v9TbB+uGANug6XJRknpCatzsWzyWX5AzezmTGm5HsBi?=
 =?us-ascii?Q?Tnj92hwDze2z8Ink5+883OIo0gHmVYRlu1scnFz53C4GMIkDcc+vPhG2Qskd?=
 =?us-ascii?Q?tqwcmj8LbTuE7ApSV5HK0viNUlMaiirdmHEG22PsyM4CcDIFlmtQmiUjm46w?=
 =?us-ascii?Q?J26DM6CuVfih/2OCs8bIixCbSGv6WIEZRoHbPEeG2gEkCkqVD9POB5QdnzIx?=
 =?us-ascii?Q?EGIPZgJ7fVTAl34HfyYs09hgdLclJXiyvD+IuW5DXYB0mmuU2EqowaXeAxu9?=
 =?us-ascii?Q?yZSL9W2v63PKag+xpbGFadiOSHupd8h2uBtxQQoBLwNyHpekVT6sDkRKQfjp?=
 =?us-ascii?Q?sUlmYcQNQ/aeZeimOGgtCm6bVb9IKfhfQugEIMuHkkNASyhIpiN+bH8FG/xa?=
 =?us-ascii?Q?uo4GsiMd3F0mPf5WRVvlDT3VIjfVP+tf4D3iCECwBPjin076VhEC3gx2pdHo?=
 =?us-ascii?Q?HtbZKex3tfc6bJnfr2znoz8pBPjfOxwUZlgLIKCaMNYvzfXqDNHwDelgXfCG?=
 =?us-ascii?Q?9KcRZJyzmyyx3rxZMODZ5w0Jo/N8mXfB20OeMZtaFR65YqqLB1I0hVgd+7MX?=
 =?us-ascii?Q?mmO7ckF7oj1CbzSxGplQNMxpXNhHTigQx16kpClzo2VpePIhkvhFOMH/GyCC?=
 =?us-ascii?Q?Yy1GPoeAugQhU0ifLBEaod7Av3G0/IUfiQkfyypbO146/qKN/vsPkbN8dD/Z?=
 =?us-ascii?Q?NMUgqFXNeyoXj3ot3GtlOnX/1KZy2f9Ih5V8/NmB0REm3hDmiTqTA3x4TI0C?=
 =?us-ascii?Q?AuePqjBX2Ag9mO6dR5fu0owHOZxh1DqisUJeFm/OU9nXKd649n+ruKo94gPf?=
 =?us-ascii?Q?PwICP1emulrD2MjBLDcgrYgF+iLhQHPSxqFNITGKhVBh8VLKxClFs4wC1k/e?=
 =?us-ascii?Q?ZM56UL1vCLlU7TSM334sCCjtAxzZxjJ00G3H9Ht6AOB/YYTP/Zh7ojeJDijS?=
 =?us-ascii?Q?flwbALne3byEraxlLX69U+c=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 636aa3f0-6afb-42d0-4cc9-08d9d5d21193
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 13:47:26.5131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GcfXel5BMonf2PzL+N5ammtYkdIw1hCAHeHax8iDTVoOgrV/zQHyzuVIcBnN7pEu5Lup1+wCWbCJtZsQ1Auubg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3693
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PEP8 recommends that there should be no spaces around the = sign of
default argument values of functions.

This guideline is described here:
https://www.python.org/dev/peps/pep-0008/#other-recommendations

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 39c1fb7d4c..c6201b8d23 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1113,7 +1113,7 @@ def branch_exists(branch):
     return out.rstrip() == branch
 
 
-def findUpstreamBranchPoint(head = "HEAD"):
+def findUpstreamBranchPoint(head="HEAD"):
     branches = p4BranchesInGit()
     # map from depot-path to branch name
     branchByDepotPath = {}
@@ -1141,7 +1141,7 @@ def findUpstreamBranchPoint(head = "HEAD"):
     return ["", settings]
 
 
-def createOrUpdateBranchesFromOrigin(localRefPrefix = "refs/remotes/p4/", silent=True):
+def createOrUpdateBranchesFromOrigin(localRefPrefix="refs/remotes/p4/", silent=True):
     if not silent:
         print("Creating/updating branch(es) in %s based on origin branch(es)"
                % localRefPrefix)
@@ -2910,7 +2910,7 @@ def isPathWanted(self, path):
                 return True
         return False
 
-    def extractFilesFromCommit(self, commit, shelved=False, shelved_cl = 0):
+    def extractFilesFromCommit(self, commit, shelved=False, shelved_cl=0):
         files = []
         fnum = 0
         while "depotFile%s" % fnum in commit:
@@ -3338,7 +3338,7 @@ def findShadowedFiles(self, files, change):
                     'rev': record['headRev'],
                     'type': record['headType']})
 
-    def commit(self, details, files, branch, parent = "", allow_empty=False):
+    def commit(self, details, files, branch, parent="", allow_empty=False):
         epoch = details["time"]
         author = details["user"]
         jobs = self.extractJobsFromCommit(details)
@@ -4487,8 +4487,8 @@ def main():
 
     parser = optparse.OptionParser(cmd.usage.replace("%prog", "%prog " + cmdName),
                                    options,
-                                   description = cmd.description,
-                                   formatter = HelpFormatter())
+                                   description=cmd.description,
+                                   formatter=HelpFormatter())
 
     try:
         (cmd, args) = parser.parse_args(sys.argv[2:], cmd)
-- 
2.34.1

