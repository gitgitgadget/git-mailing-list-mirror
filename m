Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B495C433FE
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 13:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235551AbiAMNsn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 08:48:43 -0500
Received: from mail-dm6nam10on2081.outbound.protection.outlook.com ([40.107.93.81]:50574
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235538AbiAMNs3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 08:48:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LSgWxKYH63Y4MuOKpQLAYx6B7HBa+MnokYfze9CtrCj+0ZDI/prOhEbs1iAjgY2plWiyKftiMtHVeiA7eRPjRvMH1pjm5xFfKez9EvOAZInl/FJu6MdcY6L3XdzQaL1Jk31NKzn6Esvnnr23VNXOcPSArm6LaqDLTD6bDWQUqZyfmDjdiGA9/iVavb1bjGahdBDNUZ1VNUGSdHS3JWUHzuvWHyZ1Cu4W21BeHMy+4rIl3UWeHng9O9qYZmth0YN0Az0IT0Rpw0zdAkaIYrqB8EG9caU8IxAtisS9cXp1kAtvZ/NlGbn6Owl78E6mop64f8r54sbmEFWF7lK2zNkN2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=81oUkrcOo5XubaIe2SUFRffCnpIWuWMhgILKTZfmGmI=;
 b=D5HOsRedne9MuMjGlRfTSPnWdz0xve9vzW4WuhkqonqOselrfrYFaeshZ9hJkfSCJlzdcMZtJBC8f106h9/zlbx5cB1F8zE16JSh9X3NggbIaV/4aNUa9zC+4duiMiHqbL+t2lWs0LQ/wMXuM8kfXlMJlvUcsaXb8WfvVtm+lpK7BFanlj8PxDPqOwbdioyJW9W/pMGZwSZsNWNorNT1xQJfuXx9PPlHpvJ5oRE6ptA8vNafXymBezW3y2OnQsLzNc6IIlVWMC+bTBWONnRaID9ipliLaevYxXQnsV+CZTwEyMZCg0YwMXt520TP9U7VRxK/GJcv6FCunQqdURCkRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81oUkrcOo5XubaIe2SUFRffCnpIWuWMhgILKTZfmGmI=;
 b=kjtdFysZprSKDJ7LrboBzeZqJ/FlcXthqaFlr9/4dFuHOSDPSMeX4Vheth8vTOh/v6zQ+xQqfPj9IvloexLlIeBDQ8XkRQGEZ2XhMWtsVxZKgx0irflEC3l5dG7rINSX+ama/OLZFgIx+4hZBc6OObqT8OekHPrAWTKK2HEhVF2hZKhRmv9CMIzlIKpZC2vtqF4wgtL0FSmVyJnraB8mJaWxESKzVLQ9DkC7OFNYWwfn3mZPLKpm7OB+paxa8803ue0KIyp907I744oTc9DeSWjprdT9sROfoCutEef44CLwyZJPj6p6T6+jk/uTU/9boPjV3Hmpe+DW63bxE0OP1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by CH2PR12MB3944.namprd12.prod.outlook.com (2603:10b6:610:21::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Thu, 13 Jan
 2022 13:48:27 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed%4]) with mapi id 15.20.4888.011; Thu, 13 Jan 2022
 13:48:27 +0000
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
Subject: [PATCH v2 15/21] git-p4: ensure every comment has a single #
Date:   Thu, 13 Jan 2022 13:47:22 +0000
Message-Id: <20220113134728.23192-16-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220113134728.23192-1-jholdsworth@nvidia.com>
References: <20220113134728.23192-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR06CA0101.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::42) To BL0PR12MB4849.namprd12.prod.outlook.com
 (2603:10b6:208:1c2::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1b44a5e-63ef-4964-81e6-08d9d69b603d
X-MS-TrafficTypeDiagnostic: CH2PR12MB3944:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB394474C0415F7E0420C4BF29C8539@CH2PR12MB3944.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:357;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /WHGWvRJzTZ07okosGpCXw7mmwC8i3I0/mIsPSNqhc39JiQrh2h2EDf6zvvtrwgLGgk5rHwfVoI7PM0HLtDgZmuXTtySjxpb2yBlcwDt2rEsN3SXubRpLDKS0+QZPS2u9F4uUoBE5aiXpWvxTEccQOpHURq+j/cxSziFS3w548GN1SSiVITC4z2QzMGJLtZXAChqPMLZZna2bVlkX62X0H1Vjnt/bYVdxU1P3+/jU/uVuAwV3hJkidVy1MZULg5ZUXsOad/pfzs/hxKUEL/qRS7xDnu26Y/taTok3otbYJR49+8HLhTV7s+40OqZUlReGd4WLCGmn9md8ow3Z0VVzOtNzSI0/H7go4J9nEKeX9d2suJkrJ2dMutm2lUmvjkSAOSCvtabAH2dUL59hoW8BJ9HBqVzjlUVQBpWewP1R5r+3MD3v3uiT6FeFdDTaP1Ab5WUKF8/EkXsMYJ4RZ8OGL0x+A3Rg9KwifjkV6VQmpgYRiNXyVldErT35EINCL78WvNQjjEvxU9XzQ18lVYS3qIPRzN/Hb25J1No0gzmRDlzyL85O4E9RF/xqdJ22QpCmv7+oKySz3tM9Xd/OcKxwAq3bGsp//b4QS+CF86xdkSeGw12UAMkXN0GeV0Y5DNgyNHaR2HRqk3wffMsYRPcUiD6RiO1/DNow7EiCAMi/aZmXT8fEtFB7olZY3VlrxoXa+WYLlc6p4bRD0FA9vfL5SsB+4Cb/LIqIX1ftqXaXbF00PvOhWs83/Ne38VzFOHqFcsiBnG0nu9PLf/GaB/rYXtSTxUgEBEzlzGLCNoHaHs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(966005)(66946007)(186003)(66476007)(55236004)(86362001)(316002)(6506007)(26005)(36756003)(7416002)(38350700002)(4326008)(6486002)(8676002)(2906002)(107886003)(8936002)(110136005)(508600001)(2616005)(66556008)(54906003)(38100700002)(6666004)(1076003)(83380400001)(5660300002)(6512007)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PXRHkxFNGApnbMMgEEjCZ2qSoNkyATEjdu1O0e5I/v954C6lXYLyrFhzAiyJ?=
 =?us-ascii?Q?rQ6rxawV/oVTs5Xo1/8hCMlDRpMGDSSWUnftXjGFgkvguGiSXUtWjG+Q8L0u?=
 =?us-ascii?Q?9Au09AaG+84lLMQ/HEL2pR6r6AN8CLYy9BMpdRzztUPLcDugo27n6G9qksZ9?=
 =?us-ascii?Q?VbdfxIKT65eMBkDhdtP0Xdt0UfWP8blEjK7h849TeWao2svXHevRKxsk5Q9v?=
 =?us-ascii?Q?CSTS36weMVc5pEQ5ShTuMKyA+v1IN7nhb474W0WkofLZba5el5Rxk3CNIvwW?=
 =?us-ascii?Q?okwW+ShyB5LJfShpZOxl95BU5pbE9GHG2zYfAFh4kFR3B2ndakQ3efCLeQ+X?=
 =?us-ascii?Q?ctzex8iGpU4bAfKYYAuYv4fZCHeaQQrBiuBdSu34JgQYyDeeftkopBZdZkvw?=
 =?us-ascii?Q?sHgrHGH2bHGpZek2+HKgVzyTy8PN+etgtO8x8UAX6pMdxlVycdZVY+r3dlsg?=
 =?us-ascii?Q?iAiN9OY5/PdvA1DZFRIC+Q37KetvaM+aPzcyxbnqBegy0Gozn2n1NSg4i5mn?=
 =?us-ascii?Q?im7yzAdK+52IfS5VKRD5t49vWI4U9j3k43E8zOMO8w8tAYdDhkN1fxjZOSDy?=
 =?us-ascii?Q?trlXMNGWXtvArjzJ0qquuSCTOFv0JBoJsyb2YwkkGkG7+ISXrgfZ6/JRVie1?=
 =?us-ascii?Q?K9oYzCuF0t5P32oy27fjUJ6hN4TfTcq+K8hLUTFcxOVuhiVby8h/XFvkaFZq?=
 =?us-ascii?Q?culR14nC5qDXCWjMh6kZFkfybg7TAfd+GY85RDiKwO/bQXhBVh2b86GGevlq?=
 =?us-ascii?Q?soCVeFDw0oPcMtAS38DxKw18krTHMq5uwy0Yk1XGlIg0GzUDIT407zdKsynl?=
 =?us-ascii?Q?rptwrt1VI3ztAyZ6uAltPbJXiEeUkS483ZdNuRT0+INPQ7isO4gtKqWhB3R2?=
 =?us-ascii?Q?1tb46JlNwksFys2hDROz3htAdYVypwKXQvhn0NWP8hQJxV8prI41N1svbBWL?=
 =?us-ascii?Q?vQ8W7W0/jVU40gpvA//aZDcfoAXTgkO5V59oIxN8xCphi+yR7m98m4wJ6Een?=
 =?us-ascii?Q?Nv6+5Ds9i2x5YudBNxA2vAVw8v+Z734zqi49E3OPztkp8fvFMX9Brq8hRthZ?=
 =?us-ascii?Q?idBEv0Dzi5Lh444bLhGDMNnGdkWwi0QLcUqawgZfFtoXekPWWyp1fofqC2Z6?=
 =?us-ascii?Q?ow6Ni2svzZsXSCYiOuDrbTqBLH5MqkbCi9/D56Lhw1hlsFoBroSvZrAb/NpK?=
 =?us-ascii?Q?/IFRrIFnskHZVNKTeXVGHuIss0lBYZ1y5Trslm5NmTCs0H3V2vVuljyg2zlF?=
 =?us-ascii?Q?UO4JV8arpCUe9pUm9qf03h30sogtetL1hKB/eF1bzY0B35cz34gdnTDG1796?=
 =?us-ascii?Q?39PH4PRiyj4I2X23a7/fYiSiSwyYTuE9y7wGT4JVkkEptRgKovfTG6T11p3N?=
 =?us-ascii?Q?07QWIfeEKv3oWuva8VWsMC3fiqhngCXZBrE3qXiMjw7z//FRjjrfa+eaK2Sn?=
 =?us-ascii?Q?f18FyvIk6sVtmTBnl2Ank8QuiMe3vyJdjBHMbLEO79fo0GMMaGV/k9JviPam?=
 =?us-ascii?Q?YKNpCVA9ETH9fDeagrTQsxOlkt+TVhCovv0S41LXZp1k4bwRzB/Q2vK4yKLj?=
 =?us-ascii?Q?dQw5Dxz0hfI536dDHm2/m+Sndgtxt9QUo60/IKDAPdeRnZQrZ/wINICWc9LF?=
 =?us-ascii?Q?YLnqrEfbUfwV6QuFUODrS2c=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b44a5e-63ef-4964-81e6-08d9d69b603d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 13:48:27.4116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5gTiaBS0iINMENt5jHfOK/1xeLgdlVoHmw+cJZRYJFiOA2yPFNpgjSeoS+iI9+q+QaQQSIt86vBqLaf+oKRFVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3944
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PEP8 recommends that every comment should begin with a single '#'
character.

This guideline is described here:
https://www.python.org/dev/peps/pep-0008/#comments

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index f77a5ac000..5c2f2145d7 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -968,7 +968,7 @@ def branchExists(ref):
 def extractLogMessageFromGitCommit(commit):
     logMessage = ""
 
-    ## fixme: title is first line of commit, not 1st paragraph.
+    # fixme: title is first line of commit, not 1st paragraph.
     foundTitle = False
     for log in read_pipe_lines(["git", "cat-file", "commit", commit]):
         if not foundTitle:
@@ -3560,7 +3560,7 @@ def getBranchMapping(self):
                     continue
                 source = paths[0]
                 destination = paths[1]
-                ## HACK
+                # HACK
                 if p4PathStartsWith(source, self.depotPaths[0]) and p4PathStartsWith(destination, self.depotPaths[0]):
                     source = source[len(self.depotPaths[0]):-4]
                     destination = destination[len(self.depotPaths[0]):-4]
@@ -3718,7 +3718,7 @@ def importChanges(self, changes, origin_revision=0):
                 if self.detectBranches:
                     branches = self.splitFilesIntoBranches(description)
                     for branch in branches.keys():
-                        ## HACK  --hwn
+                        # HACK  --hwn
                         branchPrefix = self.depotPaths[0] + branch + "/"
                         self.branchPrefixes = [branchPrefix]
 
@@ -4108,7 +4108,7 @@ def run(self, args):
             self.getLabels()
 
         if self.detectBranches:
-            ## FIXME - what's a P4 projectName ?
+            # FIXME - what's a P4 projectName ?
             self.projectName = self.guessProjectName()
 
             if self.hasOrigin:
@@ -4121,7 +4121,7 @@ def run(self, args):
             for b in self.p4BranchesInGit:
                 if b != "master":
 
-                    ## FIXME
+                    # FIXME
                     b = b[len(self.projectName):]
                 self.createdBranches.add(b)
 
@@ -4226,7 +4226,7 @@ def __init__(self):
         self.cloneBare = False
 
     def defaultDestination(self, args):
-        ## TODO: use common prefix of args?
+        # TODO: use common prefix of args?
         depotPath = args[0]
         depotDir = re.sub("(@[^@]*)$", "", depotPath)
         depotDir = re.sub("(#[^#]*)$", "", depotDir)
-- 
2.34.1

