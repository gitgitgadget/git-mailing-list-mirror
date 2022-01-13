Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41285C433EF
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 13:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235526AbiAMNs0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 08:48:26 -0500
Received: from mail-dm6nam10on2042.outbound.protection.outlook.com ([40.107.93.42]:49472
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235498AbiAMNsW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 08:48:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WSunskmVr2PAMV2I7Mh7giof1Co3rG1JVaF2U903sufJhvXmh83k1S+3Jb2FL/tF3T5RmVB+rxEXGsIb58TJ35/q/rZtHH0XAYggfgPhZTgG14D56fWzSF1qlu0roUQ5ttKZldov0esc4xsmxmJWXQRlP0xKP5YJuKZHGxYWhgo03jCExKXWmwJ9g0SdtFX/fxYDb00X59AChFFbmVAF6qe6P1q4Rwi11AHYIJW45ApEiQjdijqF+XbaeHLjNyRCHHG55wMcOfKPHqpINOk6CVcUvt4RdOsZS8DuJXamC2/ei8AHzN/Fa1GgeXyP0JgltddkQHVyhHsabXRC5ZeaMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=APbXoeiBbFBz/A5rAP9ENE4BwY1It4qAFiXo/g0bdOM=;
 b=fjSzRTK4sxqpDjLd5YbM853TNSGtj9Guf6c+jnFimKSqai8YEZfv50o6dSbpa969qDR0Wln0206tIq/irTVHQFbQpaj+sU7AnqpP1E8+FXqhjgu6HHUfJKH2fKzfEfMg2RlATGyGQuBG2xL6k4zlZnaChT5rCQn4Xe6yZkeicyZfFZLIqe0nTZ7MDNsgBTVlddraev/abgvEZDew9bKM6klGkHzBPy/C6QVm7UVDlfVzJFGe1wGblIXas+8JWvgZz8b2I89FmWpVjwFHcKfVViPs+zkD3H0rT2BemiAIoQdz1KGUq9iBXHplySyFGj9EQ5Cgda0HwzsgRGNaCqqGXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=APbXoeiBbFBz/A5rAP9ENE4BwY1It4qAFiXo/g0bdOM=;
 b=fcfsu+6lpd2gP8TiJ3hQ7PcBlnB5f/Lsh+/7tk9HGbHHE9YmYFxm6MUEBMtbUJvi2e4vO3NGoXnJ7YPQZrJOchBsimPs9O59lvVnhpYJrD67J4Ankm3LKWh/ZIUvarbT3Q0S2HjI7Ep+kB6Jz2689PNio9/yZ7ezHm5WdOIwg9EKvXs6BP2taWF6hw9arlWibpkswn7mHSrnYkvIqbaYI7OIybzdMtuKW8RDdTpuHYDD0xn3z11UIbZ6lJcS8eKPlDwzsUACAKXxB3e1omICAVJuMJn7j4DnL2JWAhiwQx1VuQpaForj/lc3sEi4dnfmD3/OknFY8573ohP7OP3FTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by MN2PR12MB3791.namprd12.prod.outlook.com (2603:10b6:208:167::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Thu, 13 Jan
 2022 13:48:20 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed%4]) with mapi id 15.20.4888.011; Thu, 13 Jan 2022
 13:48:20 +0000
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
Subject: [PATCH v2 11/21] git-p4: place a single space after every comma
Date:   Thu, 13 Jan 2022 13:47:18 +0000
Message-Id: <20220113134728.23192-12-jholdsworth@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7d5651d8-f17a-47d3-ae19-08d9d69b5bea
X-MS-TrafficTypeDiagnostic: MN2PR12MB3791:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3791BDD1F6E3DF7577942AA5C8539@MN2PR12MB3791.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:67;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sz39/TQlixpi3DrINpEH0aB4UKxOpb/UVClk/0d5SfktjRbpCoB5WpU1LHCvvFm2sZuXo1rLch2xv5V8JBe2uxHkmGYABV7c48KvGZIQ+CIkjWt1/zdRiz4vEA5hkQVENqywu3TW98hpXu1v/FFHFiu2DwUNxGeIVxTXg+JvdBEyF+tbGsUueBjA8iFxT63txmCqELHYDPHrVOXEQbJR981PYmhT7ELgV8rGM4aL2ElssMsAwuB9tuF/bwSzTKvby+7qW/xId1gH9EuThAtyi56WMyWwRvZX5Vd49Q2SXdhUzz2NWVp6fqN8vHrOS3RCchl7Kqn0cbWpTOxIDLqeqE3aVSjuZdTQHri3G4WZ43p4/sTxJmRNAeh0kraOX8ZJYNdGXqsqicLxgI6xvsG4nigxqAIAlQ8E09aDwapwDIpuP/I+6HUesMMJU/ni4XqTIyiKwcAZSk7Tq9tBUibqf3smuAsGFI0yoqRkCKl29Bw3UrVqYBMx3DSm5JWZUsx2jaIXqrC9VjibL9io60W7lJBpTilnGh5ju6p9sR1PvzxRgecIoF1ji4U8e5piNvyWws1tMRJrWC6/yLeOTUUJuXUDpKGqR6OInJL8Jou+JtjtUOzDHgm+H7nAfuDg9yWDc5Hug9zefXHt09HoOFrcKpNvYgXArqfbYzocPaj19fPa3GMKsgjmsiTpTEaNYzJF2iScUAln6ekSFuggwuGx/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(5660300002)(2906002)(8676002)(186003)(66946007)(66476007)(6486002)(66556008)(7416002)(52116002)(38350700002)(110136005)(508600001)(36756003)(8936002)(83380400001)(1076003)(4326008)(86362001)(6512007)(2616005)(107886003)(6506007)(54906003)(38100700002)(55236004)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eceYzjs8m9L24JdfCi1mx6ExpwITqTAPGhbEnWah9xHsJdR9QiN4d0/LheFk?=
 =?us-ascii?Q?jx33tSzCHgch6xWVWdsGRB03MeeNQVRTRR6mCkd2aLc12Y2iYqFXTLpU6ByG?=
 =?us-ascii?Q?QNrcFdL9MEKDNore6942Eotu1crgpRcz28N/9LtqX5JrhWyz0N0BnT/58OK0?=
 =?us-ascii?Q?VuDva1vO3v57vlQO1srU3oDuEm13w0Hd7x/rOhdmMMyhjDw3xKr+usBCmt5z?=
 =?us-ascii?Q?qup1c+DDcYzyIggPZp+VAZjRHn4V2LqJpuoMV5VhOxMz7GIILFn9U8CXGuuy?=
 =?us-ascii?Q?l6eBu+uLPLKEiYo///DKI9AcgzdUsRoAgtZR0jBuHRTuUuPJA2BNnm2aBenK?=
 =?us-ascii?Q?6oj3PP6tbFHz5gVeuPFc7GXA0NngMZqXG2y/xEn14V8eE3w6TAxmMmq20PcJ?=
 =?us-ascii?Q?BDcdbd4NBg0zgfmiHtUtS/YbxsPh8YwupSGqFkJSKVmXLlAQ7g6TewlkZe4m?=
 =?us-ascii?Q?l/B3RMSJltjFF+Kzwcupk1FjYSx5W5RbHCvM/GJqsgDSvqZOwvlb5r4N/e2O?=
 =?us-ascii?Q?vd8pE4AJPhrJZIFCwOQdQtDgF1N8nw1JHrLfXm8YgsnE0e7ke3+mp9wOFlTI?=
 =?us-ascii?Q?RpZGXqQGmc9yg/EyHNzIVnjdbsyDzQ30c2K5/eFCRbOzPtBoyChGOJkP57yc?=
 =?us-ascii?Q?x6yeJfVAOrq9MtlCdloi3a+hQg5XEFj3lsin8viVr3PXKaI3be0Ed+m/AAXi?=
 =?us-ascii?Q?hNuorqXE9EUxE5bhC8q1qNCaAnpHsC97+yHMBIaNXTt6eSexxTvPS3gAj2to?=
 =?us-ascii?Q?lC1NZDqeAlVUJfnFE6CU88YN/OEvJu36yVIYxKvYLGFgDn6Mfwb51zOOTIYn?=
 =?us-ascii?Q?lGVCIBGfVD//laIFk/RdNlWW+2VXE7gsVihDdzgFk82oS8oxq8g0dja8n6PA?=
 =?us-ascii?Q?nJlIit7QFPjZx7pImcdK9PXUOgQNBnDfq5r3blKjMqXMV/q2lZp5l/ozbbHG?=
 =?us-ascii?Q?+eHHOqV00HeOReTa8W3bm40AhwxV9JVKECtHeScB4wgsjO3kqLwRzwkdJ1Ai?=
 =?us-ascii?Q?Mi2SriFXBBlJN5xj3ps/EOoOYHvPgSITGex7IAnV3YPgEb562TY9m8+pX0QW?=
 =?us-ascii?Q?DsXM0CqgiSwewhX2tkcbFMVXYbcYAg7pp6V33y1mpuq2Z9te6XyXWBhtosMH?=
 =?us-ascii?Q?osKMH47Fm1RbZnDsriaKvDtP7Y5UQ90hdZh/+TR/X91TOlDm+jMQMuHfWfc6?=
 =?us-ascii?Q?O0MuOfZy4qlsdDt57dK2UqVw9bt0bfP57CIqEZtYki2Rt7PZjbYgapA2OD29?=
 =?us-ascii?Q?Dc+C/yv517i5VFEAmmwmNQatDAswZ00RAGXRwVzo57YaGkv25dUR2hJMPT+l?=
 =?us-ascii?Q?hNvannptXTyyai2HuTSvS/0zNpwhJOaInGKJprympEHv82Fw1jwR80Syh+9X?=
 =?us-ascii?Q?ogQys9EIZsPTRBPMzNU/bEDq1gRWMD+Q4EWYkuw/cEZJZi8mK1sYtbFvPqZ1?=
 =?us-ascii?Q?ReIetcdY2IuyhV5Ag4tXp8lMDBQM/GTAMFrlKeel4JWlHs+CERLHOoj62QJE?=
 =?us-ascii?Q?aosLwvJOa3VKh0f73BuXIUPP4Fw+Kg39YXz2xL0eWEXnr9m+H4xdsbxL/tGM?=
 =?us-ascii?Q?JVxNvk1NTmSHW5Olpo6FHv4EP9++yFWXYgmhPMd8C0YjGBYtDyoTds2m+9gZ?=
 =?us-ascii?Q?w0AM7YnoeWIIuU6P0OL2nTQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d5651d8-f17a-47d3-ae19-08d9d69b5bea
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 13:48:20.0642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wmVT8/4U4yiVMcxeBZudXDdp3Ew7lYyTDA19tlwB3rWWXDdh07CuIdF+LC4QT5SOOkpHSEe+leYkSlOE1GXOjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3791
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch improves consistency across git-p4 by ensuring all command
separated arguments to function invocations, tuples and lists are
separated by commas with a single space following.

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index e069e8b448..996f344dca 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -99,7 +99,7 @@ def p4_build_cmd(cmd):
 
     user = gitConfig("git-p4.user")
     if len(user) > 0:
-        real_cmd += ["-u",user]
+        real_cmd += ["-u", user]
 
     password = gitConfig("git-p4.password")
     if len(password) > 0:
@@ -1839,7 +1839,7 @@ def patchRCSKeywords(self, file, regexp):
 
         print("Patched up RCS keywords in %s" % file)
 
-    def p4UserForCommit(self,id):
+    def p4UserForCommit(self, id):
         """Return the tuple (perforce user,git email) for a given git commit
            id.
            """
@@ -1848,11 +1848,11 @@ def p4UserForCommit(self,id):
                               "--format=%ae", id])
         gitEmail = gitEmail.strip()
         if gitEmail not in self.emails:
-            return (None,gitEmail)
+            return (None, gitEmail)
         else:
-            return (self.emails[gitEmail],gitEmail)
+            return (self.emails[gitEmail], gitEmail)
 
-    def checkValidP4Users(self,commits):
+    def checkValidP4Users(self, commits):
         """Check if any git authors cannot be mapped to p4 users."""
         for id in commits:
             user, email = self.p4UserForCommit(id)
@@ -3275,7 +3275,7 @@ def streamTag(self, gitStream, labelName, labelDetails, commit, epoch):
 
         gitStream.write("tagger %s\n" % tagger)
 
-        print("labelDetails=",labelDetails)
+        print("labelDetails=", labelDetails)
         if 'Description' in labelDetails:
             description = labelDetails['Description']
         else:
@@ -3481,7 +3481,7 @@ def importP4Labels(self, stream, p4Labels):
 
             if not m.match(name):
                 if verbose:
-                    print("label %s does not match regexp %s" % (name,validLabelRegexp))
+                    print("label %s does not match regexp %s" % (name, validLabelRegexp))
                 continue
 
             if name in ignoredP4Labels:
@@ -3804,7 +3804,7 @@ def importHeadRevision(self, revision):
         newestRevision = 0
 
         fileCnt = 0
-        fileArgs = ["%s...%s" % (p,revision) for p in self.depotPaths]
+        fileArgs = ["%s...%s" % (p, revision) for p in self.depotPaths]
 
         for info in p4CmdList(["files"] + fileArgs):
 
@@ -4307,7 +4307,7 @@ def renameBranch(self, branch_name):
         """Rename the existing branch to branch_name.N ."""
 
         found = True
-        for i in range(0,1000):
+        for i in range(0, 1000):
             backup_branch_name = "{0}.{1}".format(branch_name, i)
             if not gitBranchExists(backup_branch_name):
                 gitUpdateRef(backup_branch_name, branch_name) # copy ref to backup
-- 
2.34.1

