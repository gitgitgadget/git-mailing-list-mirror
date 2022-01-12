Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30287C433F5
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 13:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353804AbiALNtd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 08:49:33 -0500
Received: from mail-dm6nam12on2073.outbound.protection.outlook.com ([40.107.243.73]:36313
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1353755AbiALNtE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 08:49:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EnDYMr0EXciqd7XqOqoCt6C4Ro+GnlVzlzsraSqdc+4/ZRFmWbJs4RM/0bmFYZpybl3CI3bctvy9WzJzz2ogCjlVH2bJX6AurGPjGhTcWDuQ+O1Un6DyF/vhJoXO5YLX5jxk8I21M61wGILqOVJIHak+/HcN4wgjUTb/SdjOEXkU9I60FYcU8HDfjfwqE2D5Ugv+BIejDtDm+Dr6D/hk3cwPUQZAh/xuezNEF1hqvUuWmDsgqU5TglRq5Uo+iaF1+u4Y6Zqgfp1KUaPCAljkHaeJNBOqpfUEF5QXA4/xtI5yumgrfICjihLeB8l76gOo7x39Kn4Hshalr4mWyoQPWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VhX5ZBHedIFNsEJWupxZgZ9lwVsGIDpvzNd7ez8gA5s=;
 b=em24e3AaB/yN2fNHQUjP8ejB3uFV4mVffvxVpUTNJHxcWl/W5qFlVKMODXX0uAwwCgCoHLyihr9zIhAnpfQ7l7azkf+Bd66M0B9CTdeKkIbUSIqRpFe1AE0m5kVFBCIP3X2HWxMP9VEXN/+KSicNQDT+CejlFQjRb26XOIQXPNYwtcreZfzFdEg4F2byrk7UIOPTYzjyc9bL1XFG/twvJtKlshseWV0aMpMjfbFvMihnGredql9ZcZiBpcsqZ7Xkr+puQwRA53iyYd06UXEsK2b31EYbI8pdobBq+cIZG29YHj0anUAnSaEvOtwDihT7XfwdvSCn0yf/e2p40pPtDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VhX5ZBHedIFNsEJWupxZgZ9lwVsGIDpvzNd7ez8gA5s=;
 b=DdI7Q/paogNH8KBDkr02xa2fVJXgDBcswT9oyN9Kx6mvRPZbJeTV2pdq7rFaAebN7Nu1WRInPBz/7Fzc+I+71lE8LBogYgoSmNDJkVcp7RUzPhDpm83Uw/rur/tYBjLkRomEARnev5iCNFNL8vzveiIBwI9hzvCeEEXfcZGgnBv/ZHILFULbHH/sVh1p0yvwjSpzK/bMlLb3fVo5YuCR8eTu5v1qbPyCLSZTOoxkWIXh5cKg2MeeTCegK7j/k4uJGTOcoD035Of507MxLvVIFQG8hUf1NPgKMaoaCCh4C0K8fC74vE/25IqFQgMgmi8382xhgUnnFEiNUbFzXzocgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by DM5PR12MB1594.namprd12.prod.outlook.com (2603:10b6:4:e::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.11; Wed, 12 Jan 2022 13:47:36 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed%4]) with mapi id 15.20.4888.010; Wed, 12 Jan 2022
 13:47:36 +0000
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
Subject: [PATCH 14/20] git-p4: ensure every comment has a single #
Date:   Wed, 12 Jan 2022 13:46:29 +0000
Message-Id: <20220112134635.177877-15-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220112134635.177877-1-jholdsworth@nvidia.com>
References: <20220112134635.177877-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR04CA0137.eurprd04.prod.outlook.com (2603:10a6:207::21)
 To BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 508ffc4c-c492-4245-d022-08d9d5d21750
X-MS-TrafficTypeDiagnostic: DM5PR12MB1594:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1594E1D6A104D1E1C863C3F3C8529@DM5PR12MB1594.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:357;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ko+x0TnLDWx9UwGLP3tqy9bIYpZ3qPe/JNdh4hutJviPoH71KkXhYVOZ2gnNquKwHOaTpg7zKPz7vnwfP6IYCgLm5blQJahGpWjZzntEM567mCdACgL5j8qnbXmR/fuuQ3b6tv5fKXDiwKPnX0ss6QQBzSDGqR3L6gVc3Ue44RuP8YPuy86coDwV5NG4Z5hGMD34hsledLNF1TEnool+h1VTPf/tvZGYHvoGYaYXA8HlnnUuYgK7irIh+TT88nuRVC0uf2gw68GYdZdbKRkJaws3CdvirWH+un+jiilkQAO0mAna+H4e9oV9v/zZpMTH3NXQC5krisUtutoRcIkiBbMzLPr1gJ+vQtPdjWz14W02AVn/patarrYd82YiVBmp+yyyrpkI9Ubk3UXpntAyXOa5OBwqIrRgiaL/3/+r7Cr6GjqNwjrpkHqkg5rxigcJGi8TomA6hw27uMo0RUUJJmw86et4ENvv6i3a5KzCVmky+rNUa9gsBhDcUIq8QDEEmGwSOTxAyUE+hwAPXKhLIgE6aDjKzfQAGZE3KOFqJ9eOY1HzomwZ90GRWo2aUGBoQ5+lMoWvYUmxQBaPJXr9hHoTlRJxU0qw7YhwravLme+8NGyzAMDg/ui3yFS1+wfBK1Nq4k5okIn9t8HdKGIS9iJf6h/Ao3V9z+sCGkRcQwZXup+bDUura+IZVGc2HhjC2yfR/+U60EbkKNkpT3pRSJDgl9VwPqNJLuYTsUJrvmkfObhId2ow3ApHGdk/jiHmNctYXRzYWRGIhto5lUSOZxHIRwBcVvQ433W+p1k3Fzg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(5660300002)(1076003)(26005)(38350700002)(2616005)(55236004)(186003)(54906003)(66946007)(52116002)(38100700002)(6666004)(8936002)(7416002)(83380400001)(8676002)(107886003)(66476007)(6512007)(508600001)(36756003)(316002)(86362001)(6506007)(2906002)(4326008)(110136005)(66556008)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IZ5Oo0ax29qswE5Z4lp5LCJUxRQA3wnXvKBLfsgSl6HpOUjIIFPVVGbg28s+?=
 =?us-ascii?Q?k2p7p/CMGIj3CenGaplr7cDo6NDJeIfxyMZ01BUWbnwBh6oWNLA6l7GGsb1g?=
 =?us-ascii?Q?CV1JQqmrjmCG3Xx2sUSnTmeo2bd0FvJ4nkA6y/dpWADunbkdHOBsp02GZdTK?=
 =?us-ascii?Q?5Jtgbq/AkFA05Ns4uO7NqR4Knv3S06HWozjVKOWP5/PX75eyhqqiGFqvhLwm?=
 =?us-ascii?Q?fEH67Bc/XRUpXdGQMpRyXO5KBvrjWWfxKf79JvaDMQ7IEzen6wtuaWoq+bun?=
 =?us-ascii?Q?j9BeR2ep3ufvXXXNxXpn8vMZwDhJ3H2l/hoIVS4kjcU3dEdhX6P3eeN2OuS+?=
 =?us-ascii?Q?7TprBcwbEPtfJYlyjEQ7oTFwh/lTRCkvWC2JqXBrMvVKLqWml6ftenz7jK5G?=
 =?us-ascii?Q?78x0sGN9IQg32Cz5tkT7R2PWboYqimIfVLi1k+lRyonHB+Ng64SzqsLU9UrZ?=
 =?us-ascii?Q?tAIlF4uTiHj9mFAz0+cbJN3mAYAu/JPcoHLzNSCu6LOdrYgslOYln9m4kIJ8?=
 =?us-ascii?Q?mqM91L6tLfg91q4xfHo4kMqT2AAnUXcfz0iWwC0GbBCOZuBFWmXqHKpnO9np?=
 =?us-ascii?Q?2hwAh0CrduNG1kLtqAu32Djn/epDBHceTS4sIXZNKqS3gutmSQB+Gab1WVqO?=
 =?us-ascii?Q?so3caLhg8b/JOuYz6M5FDx2aRBVCyJmU6ZPUe15CNK/W8XFnsWTajdJufkug?=
 =?us-ascii?Q?KigBn88lsAoWTV8k944+0K1vX2880YRpWQ/uuBOZNeEzcg1k9vDTvT7qjJlG?=
 =?us-ascii?Q?2s0bguh5RWgueA9BwChYTMqSwRQyg42UhKa2ZTqrxftgYVgaLTD4fcvAuvsj?=
 =?us-ascii?Q?VIv/j4CBkU24e2+H2TdcX6sSYwscSGMNloNYZApRnFkrvtK9f5CFJZN4jdtx?=
 =?us-ascii?Q?mBQcDktkruIMxsOH55/0d4Xto76ksuynU3gqeCU6MoaNQ4xZXbHtiNTMSHX9?=
 =?us-ascii?Q?S5OZqEv4jkReQTfaxFJNPPEUrsHAAsj9eH3tAWMa6eJGy6SJDA4bUg9EnLod?=
 =?us-ascii?Q?XVvUbaJJ3TrDnHks7KZEWoUWbgQ+ExDPzgUWk6o/mbouMpRlYzTBnVu0Erfv?=
 =?us-ascii?Q?/Ug7Wexq5jirQbM0PyWItZ915nyRchSYNtqt18ftplQii7AdEXeuPXq3ojOG?=
 =?us-ascii?Q?veE+jCxYuvf/BAtETKMnNz267ZVI/pM+mp+0k8zdeXrmIUrrhFQAJ17M+0yn?=
 =?us-ascii?Q?0A6K+y8MV9nkRytbUxbx9Hjc5Bn8JpLGmMfXkHOcCPmIhnPEBL8vjZ4NXU0z?=
 =?us-ascii?Q?9X+K0K/h8buGZNtmEocjV/LfCIcXO2PNQzoitIDyuiwtug+IsFgW5oNFx6md?=
 =?us-ascii?Q?by6hRY1c4YzTuxFT4qPTbr3m+tsiCX+vLQ4saJ9cKNzKPEo9IPmQmj9bXiwO?=
 =?us-ascii?Q?Ky1Zj87CjOWQ0iFNm6M+VwQVxqZN2WGV29o9SIfo3+0+OZJldZORntwb4Pps?=
 =?us-ascii?Q?hOVStPLzORD0ftDvzn6cMqZOFUHuI7PYWapO8zsL/LiLPxyRcV7OTEEY7ev7?=
 =?us-ascii?Q?lAuJwIX2XXTYIjIfWQ79ZkHFdR4RSQ//V4IiIFMpaLv3MimHOOyTF98v/gHE?=
 =?us-ascii?Q?HYSJIejnWTrThho7sTN2GGXtj2DLVoFosg4sBgJNs4bgFdn5q+ZI5dYDtS55?=
 =?us-ascii?Q?9wKWEDduQWAULtdMvSdw3Rc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 508ffc4c-c492-4245-d022-08d9d5d21750
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 13:47:36.2218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FKwqShu37iZphmb2E26p+vzTjELZDhk6xGCuVrtujB1doCkmZpUhPr+zD30/NiccbFFB9LVy0koxkklspz8aYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1594
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
index 7bfa282f7e..404de3e86d 100755
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
@@ -3557,7 +3557,7 @@ def getBranchMapping(self):
                     continue
                 source = paths[0]
                 destination = paths[1]
-                ## HACK
+                # HACK
                 if p4PathStartsWith(source, self.depotPaths[0]) and p4PathStartsWith(destination, self.depotPaths[0]):
                     source = source[len(self.depotPaths[0]):-4]
                     destination = destination[len(self.depotPaths[0]):-4]
@@ -3715,7 +3715,7 @@ def importChanges(self, changes, origin_revision=0):
                 if self.detectBranches:
                     branches = self.splitFilesIntoBranches(description)
                     for branch in branches.keys():
-                        ## HACK  --hwn
+                        # HACK  --hwn
                         branchPrefix = self.depotPaths[0] + branch + "/"
                         self.branchPrefixes = [branchPrefix]
 
@@ -4105,7 +4105,7 @@ def run(self, args):
             self.getLabels()
 
         if self.detectBranches:
-            ## FIXME - what's a P4 projectName ?
+            # FIXME - what's a P4 projectName ?
             self.projectName = self.guessProjectName()
 
             if self.hasOrigin:
@@ -4118,7 +4118,7 @@ def run(self, args):
             for b in self.p4BranchesInGit:
                 if b != "master":
 
-                    ## FIXME
+                    # FIXME
                     b = b[len(self.projectName):]
                 self.createdBranches.add(b)
 
@@ -4223,7 +4223,7 @@ def __init__(self):
         self.cloneBare = False
 
     def defaultDestination(self, args):
-        ## TODO: use common prefix of args?
+        # TODO: use common prefix of args?
         depotPath = args[0]
         depotDir = re.sub("(@[^@]*)$", "", depotPath)
         depotDir = re.sub("(#[^#]*)$", "", depotDir)
-- 
2.34.1

