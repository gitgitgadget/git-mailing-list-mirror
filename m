Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2EE0C433EF
	for <git@archiver.kernel.org>; Sun, 16 Jan 2022 16:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235593AbiAPQIG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Jan 2022 11:08:06 -0500
Received: from mail-dm6nam11on2054.outbound.protection.outlook.com ([40.107.223.54]:56160
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235553AbiAPQIC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jan 2022 11:08:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OMiv3y/TK9w8nXzGfBgTeVtWdmWXze0f/Nc96Wh5Ssl07s1gx9w5SDQXEUN0lOEg47ng+MetxnT92KB4myvZyvprQhRBrchg6VA42iQ7nGkjS1nYLVJEEcmrHmwIvNUvqxKPDYPXOUfApk00z04aSnS5kYOgs6gQd+Nxz55T7ypZeTyAbSRFTPNc8D25t8UDv23P0FHE0UvmOdZydLNds5FdNmgcItnMM7hxBm4bX7xEDSsLoi6nGjO1snwYzjBdIHMPxzszQvhXq5RU632Jt6PI3EY43QhU6Fx8/i+yUTW3XFI40uHsW0zDgZkSlk8W97BLHOtZmFqdx0PWzNoTqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=58aNcymmEYRrA/qI0sg/uYU5Mv9/B0JW5po+1QVmZew=;
 b=em9Y1qlP2fNAD1MhrBOV3wEJgKfpezjtGYLcbM9SZNF48TM08U6nIYKgwzRiOypvcRgmP7tV09gHIfE89gAGz///omi74HhJjxZrP6j8R29+XTbxct8NREVUDRf2wY43jhFC8AHhBNqRZEb3Y6y4zDQCJyxwPw2SWjCgrsbCcqgLeP4HL+2bUKliI9ETI+q3wq8Y8Nma3waMyvUPGA1DdVW+lZLhmylCCEYpUC5EOIZt3LT5voRSiqF6uLSK5DIYnl6c5jHwFhDBUEj/guOMaWZzhc8BTzoDhF8LtL08hRKPxL5GrVGO0clAiYiWbkV48rEay6jb4OIFn11Gc11QIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58aNcymmEYRrA/qI0sg/uYU5Mv9/B0JW5po+1QVmZew=;
 b=hI7P55w7jyarpoKhlkaU/9frIj1pkOcnGhLBt7Tr12Yz3jZutKSEYCb2cNgM0DUvZjV5p0SnV1heVDgdUmOuWELRN+x4HTWGE0DW7dNBZIY12o9IpKrZB36iY0box9tMX4vQE2JLBli/rcWED3iGQ4VgIs6whp3TVwbvxAi9IVI0ftVaguzgIguYgHuCNu7/kNPlYW8sfxuqbWPTHCv/VJ3Qi84/+ymSu7yJlRwgntBGIPsdv0pkLJn7Ixm0vEHMKmAutFseht5OOiRQAxuKrY8lqqT49lE0CDvsMDmgQyjcgcxnSLT7oXcO3HiqlXthw6xDYVXrsuMQNdmjm2dJVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by BYAPR12MB2597.namprd12.prod.outlook.com (2603:10b6:a03:6e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Sun, 16 Jan
 2022 16:07:42 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed%4]) with mapi id 15.20.4888.013; Sun, 16 Jan 2022
 16:07:42 +0000
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
Subject: [PATCH v3 15/21] git-p4: ensure every comment has a single #
Date:   Sun, 16 Jan 2022 16:05:44 +0000
Message-Id: <20220116160550.514637-16-jholdsworth@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8f041bb8-a946-408a-8365-08d9d90a5378
X-MS-TrafficTypeDiagnostic: BYAPR12MB2597:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB25970FE6B3987FF25FD55472C8569@BYAPR12MB2597.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:357;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qipl9XexMzr99YH9AGfNztirS+xarS1jeABOwH07+xkdG9FUplE4HlaOAHWq6jvYNQGa1RahI6TGR6gdcXCujl+Q9ygJfhUF3dFn9y/mRwq0CfrcjJTjcEzzilgxRvsPxfT4Rtem9K+VU9jbU/UIahrAZ7NAcRM5puVYtXiXGTs7cPt5JRVqruZEIgsTPEXlIgtGDEgk6rLaJvQDB2ghMDNK4lT5+BbDDylnKJ8fk1BY4/PpBtHwBWofGbtmpg/1/3wH1MrNGmQ2fu3p14WNfYcPoJY2DzXRYQSxv1Q5/YoZzVwvMHD/KB3iDKDYhdFpeORgEc7KLuc7DtXhXxyXLZYPsTdnl+9Y3iUUvYibC3MwCWHAKrxLhsSsp6d3/UAcLT3ts+cLQfmJ6/shdIfeAztBbExQRQmLaztFkNsSrAUP6dpHtqLF6gEjEXwQSaEp49UffRIMUDptegEFko2qM/nCn/LIA3IxHoadKXCLDod385Uw+syZKD42dc7dHvCthDM+Zi3vRs/bE6miSX8KgcaxPhZtmuHeOQl9szMN5nXnx8pSxw7GbsO/fZXH1dfydBKKgwJUnT23tNZa8Zv8u9mY5X944kMFzboRwA4oTqMAVUSvVDf1hFsAtu6iJmdorI2CJM2Ke/3C3K/7Ev6SuE7ClVlyjQnACjgs2NNtQUH1Olu0CEAXfJf1ZGA8k5cki1zkRBbFo0hQ8TZz29FxrGJIulutFUyCy35761w1DfrCqpBIm5eOlCoMAfgqKKlYSnC2tHiWVwaLeHoeV03dwK++rS0/CgcRGpOk8SG9F0Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(966005)(38350700002)(38100700002)(8936002)(4326008)(83380400001)(186003)(1076003)(6512007)(110136005)(54906003)(107886003)(8676002)(5660300002)(316002)(66556008)(66476007)(55236004)(6506007)(52116002)(86362001)(36756003)(508600001)(66946007)(2906002)(26005)(7416002)(2616005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ARaH4WV7+xyS8mkQ5XtUA1kFpga1+FWW8DDqH1JJBMrpMutT0kYZurw2cVHf?=
 =?us-ascii?Q?S7BStzqBDXGtPYKOxsT80SBFGLQ4wflZxmjD5s2cP1FqR3gJXcgtEfGqi7pR?=
 =?us-ascii?Q?0TCqBCrapAXq6T6kHpOdRN2Es2xwnq82U9ZxnoYABm0fI8wqLuKKlx/pxCFo?=
 =?us-ascii?Q?AiC501UCEJWBKIbnEcBk2w+PWveCBQArS8aQJTGhOU/rv5VKh0d+reWSrEP2?=
 =?us-ascii?Q?Bx6FvPWvQwVQLGNGcPOtIVHyRQN7jScXS6v8lsFsDe9/FpwY4C6O5y3JEyZy?=
 =?us-ascii?Q?Gw/vAMrFz8UTQIrZZFBHBmFoVPXEcvP7b9Ysbjt7P4xYmWW0jPwuKfx8oj+K?=
 =?us-ascii?Q?hqzMg/2KI8rnZhCMbXMOADK2UjE+E8ARkCHD5uvldAFf8YCOEPTOYectQVmT?=
 =?us-ascii?Q?RFfobBO9VFF2iYu1TchJMEHMgTcrMmSThwqbK7BHNYSx3/+q4OLHPkH1ph8I?=
 =?us-ascii?Q?Jxy6SZJbb0BB2jKNIsJx3j3K3BTDFL7RFT6DzRbGS8RAMgs5GEksfU3zoT6M?=
 =?us-ascii?Q?nrv7eSSrUxxx/q3Y01VvJmziEbrSeGyfsUcP7ttBTfPO8gBVF5sSEN6tYNwn?=
 =?us-ascii?Q?QPBYLaF5cacUu937886ynxch5AuDng+SrfRgLHWwOjE/wA+LaWgWjNJ/RLst?=
 =?us-ascii?Q?KiRFocRxpSYrGJwOz7eQWnGVxdC3Wjc4j+KPhaMJsd0hQNr/jYMammwIbhHM?=
 =?us-ascii?Q?twD8IScfM6pW+Drq+NH1yQXJ49FOn7vGmyU+bVFXSX3e/KnYcIoqUqg7YyZ2?=
 =?us-ascii?Q?ndq8iE3ruIx0mGUSgAtrekh7R7GrTS9ebf975nJ/soqmBvuVgjMKVqSKyzl/?=
 =?us-ascii?Q?6oQPxrUUXlGYytIIOFxsWwuzWydakZHGUb1hDILIPBTAf3MrgYR+9HYlKBVR?=
 =?us-ascii?Q?Hq9edyMTWuNjuha/rrV7LbvlA0XP26sld7nSOkGsmTGa3Lj+eX36KGhUjWLs?=
 =?us-ascii?Q?5h3TWqa5Av8P9bj2flbotEKNwrfHshWimdpFtR03YSsbB3tZj1WRKsmKbCQ+?=
 =?us-ascii?Q?G2M8hmV6dFdjYjO5B8VNfBZNZeJIIQlEuF7IIRtQ+gSJZKP9Gsc2B51Il+J3?=
 =?us-ascii?Q?fe7z2g+M4+KbYVKxO5uaf3NtVx/CYpmc6x0eH79rtlUZdSKLVvfSW6QrLoGD?=
 =?us-ascii?Q?JQ14DYdYWhm5m4KsnTdsQNqEsaxMoq8fUBY44FP7z0PQM8BKtOUOi0hAJYu+?=
 =?us-ascii?Q?DT2VGfiUkc5a7OD6bDMWAKHLzTrLT1OpL+EmnR9+FQEp0i1u8baMBKIV0ZEo?=
 =?us-ascii?Q?Z/vZn+20iHOhbQfVXFd4ls/YwnuCzVSPoPHXas0fy0ZgpnLd+/LpMqW1hqKE?=
 =?us-ascii?Q?/73wLUXCYjK2V88ZYUpR/AMm3ee8tgVAs82Ljlzw2C6OxWXZcpFRPw0nXV1B?=
 =?us-ascii?Q?w/quLSBOgIknvuPawhfSWCfPNVwN8Kp3bv/LswiZDtJipStjLudQNVPFte6I?=
 =?us-ascii?Q?3FzHWMpbjbZHQVLsXgt1mvdO+eJ7lYItwPlDMz76AGuMB51rgCifkwNm1R/P?=
 =?us-ascii?Q?hbqDvwx1H5lmKU8JtUW88qfM9GOU5pnLdUbfv1xpW59xDiq7rG2iwxzbi+t2?=
 =?us-ascii?Q?qFRbACaneFyLyBQ13tEur2svaS81HpTxToz4VPsqxLqHT69CXZb83djuY3MB?=
 =?us-ascii?Q?Px5Glz1x45YhzbMLr4cJhbw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f041bb8-a946-408a-8365-08d9d90a5378
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2022 16:07:42.4661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ERlshVmBL6ueDxX5LJtZAAvDnAuSLeRvRwI9CQ41y6KhECtf3kNBYjLmS5cDiDNYulafzuO3kDiAXnWwrImVZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2597
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
index b542d47a03..a014bdc7a5 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -953,7 +953,7 @@ def branchExists(ref):
 def extractLogMessageFromGitCommit(commit):
     logMessage = ""
 
-    ## fixme: title is first line of commit, not 1st paragraph.
+    # fixme: title is first line of commit, not 1st paragraph.
     foundTitle = False
     for log in read_pipe_lines(["git", "cat-file", "commit", commit]):
         if not foundTitle:
@@ -3543,7 +3543,7 @@ def getBranchMapping(self):
                     continue
                 source = paths[0]
                 destination = paths[1]
-                ## HACK
+                # HACK
                 if p4PathStartsWith(source, self.depotPaths[0]) and p4PathStartsWith(destination, self.depotPaths[0]):
                     source = source[len(self.depotPaths[0]):-4]
                     destination = destination[len(self.depotPaths[0]):-4]
@@ -3702,7 +3702,7 @@ def importChanges(self, changes, origin_revision=0):
                 if self.detectBranches:
                     branches = self.splitFilesIntoBranches(description)
                     for branch in branches.keys():
-                        ## HACK  --hwn
+                        # HACK  --hwn
                         branchPrefix = self.depotPaths[0] + branch + "/"
                         self.branchPrefixes = [branchPrefix]
 
@@ -4093,7 +4093,7 @@ def run(self, args):
             self.getLabels()
 
         if self.detectBranches:
-            ## FIXME - what's a P4 projectName ?
+            # FIXME - what's a P4 projectName ?
             self.projectName = self.guessProjectName()
 
             if self.hasOrigin:
@@ -4106,7 +4106,7 @@ def run(self, args):
             for b in self.p4BranchesInGit:
                 if b != "master":
 
-                    ## FIXME
+                    # FIXME
                     b = b[len(self.projectName):]
                 self.createdBranches.add(b)
 
@@ -4212,7 +4212,7 @@ def __init__(self):
         self.cloneBare = False
 
     def defaultDestination(self, args):
-        ## TODO: use common prefix of args?
+        # TODO: use common prefix of args?
         depotPath = args[0]
         depotDir = re.sub("(@[^@]*)$", "", depotPath)
         depotDir = re.sub("(#[^#]*)$", "", depotDir)
-- 
2.34.1

