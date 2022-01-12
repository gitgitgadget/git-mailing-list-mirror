Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCD1C433EF
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 13:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353732AbiALNtU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 08:49:20 -0500
Received: from mail-dm6nam12on2052.outbound.protection.outlook.com ([40.107.243.52]:20961
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241069AbiALNrx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 08:47:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aF52WuEZMms5g0XkkUxx1mEHOzgRqfJZID6vR1JG7WSy/0eGJh7f0ovelkUqOAdebPL8v9u8XCgyxqggaVuv6g8S27NTND+lFzivkBG9CCc9CW8mPXSpKSOCZWL1NxdrC96TfuqBB4O4uaiRaC+ENGqo+jAWXq4cTp9rZpxeUNpavk8sXd67HvuJsSanHugZvFePUUBo2b2VEUM1fZjpv+QnLzcmBDYw4pNepHK90jYeNF8qQPALSL1NX0nGoON++6OmvigUtlyl73yQBjpRgeFsTomYA9pnUEzh7xcoikunMkWf7W5yS85YtSSFDajkQmMovqNmhjhWdyQK9/VzYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y8oX9VPQP4nkilu5Xe71CHGtDr9Oe3Fov1+yfGiQ16o=;
 b=B1lXq8cldj0ZMgRKeB79WsTVNj6jrl3s/EgwYYh6Y8Wb6sQQwjTbAMvIiV2xLygRsEjdUh25vdilAGE0SkafnXUs3EYRsJFoNuc6CowIrBfHCBDz+J9zVZuF03gbJJjNQuhMIGcqzohOc0W6108I/RGUyilPXxtfqwBLAUh7k/djS/Dhq3yNopX+IqkozAO3nlWIIch+mjlNEdC/hHI6Zg6VZ+QGqhf9O4sjfieka/KQ5WAeRrBNOQoP4rOoWMLoxmuStjjMUMTzDFHpguMmEq4fh9nYUHOgWIoMHr3Wv1L3uXNPLfxDJefo3w0XdObJ5LlLUN1s7LmUWWGvU3Sm4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8oX9VPQP4nkilu5Xe71CHGtDr9Oe3Fov1+yfGiQ16o=;
 b=HyHIQ3zFXfqt+KBc+CbsNKCBaYCD5nTshUpF6f10eEv5j5LHa94eHUbpvUX3Tbk0IBivt8Ti0ZQu1+OY4dtkurGZCBgbKFJnmsftqZldPS1mYTAqXzTkB0Pipo5EM4rGcKMYyq/4UMul42J8IH8GzIxq1oP+1MteF7T3gAOFTYWBCyyw9ip7pdnLcASShkWe3Kc5yIg9AbmP2fPOC9LSgoKu6QImWZFvJLL9filWH07tJhASANml/E1g8MJLAP+J12WuqCmy9rsEUk104iRueJjiiYDsYbJ53eLpdJPv61Wa01fe8xwWDA8Sc6IJKjfYG+uZsyQbO44jRyrhHjrSLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by DM5PR12MB1594.namprd12.prod.outlook.com (2603:10b6:4:e::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.11; Wed, 12 Jan 2022 13:47:28 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed%4]) with mapi id 15.20.4888.010; Wed, 12 Jan 2022
 13:47:28 +0000
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
Subject: [PATCH 10/20] git-p4: place a single space after every comma
Date:   Wed, 12 Jan 2022 13:46:25 +0000
Message-Id: <20220112134635.177877-11-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220112134635.177877-1-jholdsworth@nvidia.com>
References: <20220112134635.177877-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR04CA0137.eurprd04.prod.outlook.com (2603:10a6:207::21)
 To BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 269d7701-7ad0-4cc4-4de1-08d9d5d212af
X-MS-TrafficTypeDiagnostic: DM5PR12MB1594:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1594AA721B1B28773F65966AC8529@DM5PR12MB1594.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:67;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9R93TdCHsbAldO9yb00sOCGLRjYDhyh2uxYXr5E7uk35LT8bRIWK7+AdnZN4pYKvbPuS8uBT+vw0GXeaidEwRoU6RhJrh0Ri6mocAAuq5Edr/W/Q7X384MvIBaWEgPlBiwk8xZ9x3f/HQD/LjEz+Y1iyigqWBy6cpSx2UJ9J42dS4cNxAZ5Bw9Q3LThgkG02iDzsxX1r2Beglt5xALTSOo4Qh52IE+AdA+oFJjADm4cefuVgajO3upZXddrtJTZuX+8MBTATCCVv2oYHQj2XhOG7C4fS7yLnrConT14rl/K0QLw92fV+kx7KsX4/6689t0+tvxUloyEJn7xUPXkTiS0IDaJHjGn7ZnKzbLKVvOEi00arYhMYDOvCEVM28FUzYMIERoDvyma5fnza1AEMjI0SFIDTiP8an48DLOI1n4Bb1m95iE+AqOxYFiWd0X7q7rB2o1l0GNxJFT9GMcuqaJa7mTL13yMuDD4Jg+8cD8W6sqYFJPQxVmz8YdG89VzM9HcTR7SHphnOtGraJTmLQA+BrQMCjqdWWMTB6iTBL8oFxGU2uOaR2aBmHlO6lrXV1VNINtwYAq+dXoeuJVcuJfSWMb3eSd7KOgSJ9G4eAfdgABhoKHGpFt/7c9ybuJ78xBrjjC0KS9JBs1NLuTsFmtF26DF8I0W6/AwoDZvSv2q3u1DxBZaHXF+7e7EqxLQuCzizco4DJkLPQCqWnGtRxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(5660300002)(1076003)(26005)(38350700002)(2616005)(55236004)(186003)(54906003)(66946007)(52116002)(38100700002)(6666004)(8936002)(7416002)(83380400001)(8676002)(107886003)(66476007)(6512007)(508600001)(36756003)(316002)(86362001)(6506007)(2906002)(4326008)(110136005)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SHRTTr0dAlpCrEuwrp8j/B1fuJEyQa253rXD2a2tXdVWxE+Xje5bkUte/aKB?=
 =?us-ascii?Q?s8O7ViZroucOcDRhIf2jjbZ07AysPRzR/DLEYvM1LaOgPMhHqoCcXWskw+fH?=
 =?us-ascii?Q?y/WZEAnpvMiRa0d7/X1sqUcbyrKGgnnDOMcsS5LS8N+e+jtWSk+cEmOPC6QX?=
 =?us-ascii?Q?pwFshvJVC5H25NRg2Wa8UAKEhHaWA2cEy3ERbYy/mEZ6gR+xptBhCoDLs4mh?=
 =?us-ascii?Q?CxjkX+tkIfxPFEBdLN0+fAs8ZiiodmHorp/dEY9PbjDo1KPG5/E1OBCx2tw1?=
 =?us-ascii?Q?/xeO1weh7KnmRy77SadEPPEDoit1F4aAcdNlnA+M2Hi0z3Vr7IPZrsiH5QnO?=
 =?us-ascii?Q?acMqhoFmsHmSwKTpBkOJYRTy6LZXEF0ClOYI8ggQKvE9sz6D4LzzFhBS2ePl?=
 =?us-ascii?Q?tp2tOYDzkZiQDjQI3SmK3r/CTdQFzyCpH+uS3g9XqStMAfV4AmTcu8lqfX5U?=
 =?us-ascii?Q?P/XmfaRNpUIXWc1+AjKaTgUYTfEPbrYOB8zDJnd90sdhfjnEL6YXeBjX7hIw?=
 =?us-ascii?Q?9XVpvusjnM5iKeryh99hlVo3fxjoVnj1RoLasK7g9bL4UC4LRGJ0t+5sbJRC?=
 =?us-ascii?Q?uqr751Wwu3Lm+km3os8ThuxNZnFTl8Y2QTWcfuBDoLp9LRnKAqk+c2A7uiXO?=
 =?us-ascii?Q?xNyGIhsYYZj4B4YglCs6XFRncXgzlvMLOIprf3LlOcIo7BQG3wkQadxJ3xwe?=
 =?us-ascii?Q?Gak/eY5HFP3eBfCT24cS9c2/I59Wjjk3Emj1I5ZPY4MUYVdQ8REWAIZPSmz6?=
 =?us-ascii?Q?66qXnwlL0KJdfQLhaAFR3pTnUrfy1WJaDyXaibpzk++3dlgQdG41JpNQFXfY?=
 =?us-ascii?Q?47jm8zGsAPxU/TYXtr3oEhAqwnV3UPnSCLMBdMqb7utrPqzamTqli2cxSqXs?=
 =?us-ascii?Q?vWbjZ5KxQg6RzVymG1/QO+I0MDvE8Ny4lXnkdsWdkujTJfnIEQll5w6iGwmy?=
 =?us-ascii?Q?oNIAKY4VejwqD3/5HT0UfGDZewjHy7+7bHjpPooj7Rjx64NAU5C7Qhl8XG3I?=
 =?us-ascii?Q?XRVud4CtLdAC5KnoJ410ihgIHXvSnCgl4Z8GfSynq2myPC2Mo5q9FaHMCtdI?=
 =?us-ascii?Q?CS5HHIACP2GOCgWCy/F+9CUKkVxZZ2Y6txCElvmkt9F7gumzLEJHw+KsiXc1?=
 =?us-ascii?Q?BNhFFqpwQXj0B0E6662PWZcKHenX+S7wItl3Nxy7OK/Ug/Be13w36IuEziSP?=
 =?us-ascii?Q?+pFOa/ab+/7mvkcykUOdv0SG3ZX61CiQS/tGdfLgLrX/olJyMy55TthVvS35?=
 =?us-ascii?Q?Kq6Skqx7DrpiErNh+YT2m8vQMU5ky+r2AkCGaNZcFhC8bO2UbZ2I/QikxFtU?=
 =?us-ascii?Q?LIZewezaKedcky3vXizpWtrgHdRB6/1FXWg4ZxgzTXJDxt21TiYoOSjADxb2?=
 =?us-ascii?Q?7zwJISiF/T1s5+4z+uRsgAht0FfsFfoPeaVayw9n78P/089bKLMIBQLrBzSj?=
 =?us-ascii?Q?FXXLQiQJaRvcHJ79g5sEJX9iYaD5qJfcwqfJfNuCAUnRmM2m1GKQRPNJcZN0?=
 =?us-ascii?Q?xXbSgH6bKj4kp+vUJMnw18YkRdAyD29PFfNZta2LNkHjimLR3+wl114PP+/v?=
 =?us-ascii?Q?6NgJo0nS8WuHlmxNOduOFyPBJcjZ29tkzVHzSDE1c2r2xJeQE20xQ3TArs/c?=
 =?us-ascii?Q?wGmvGn3bj/IqTVyXCj3QfRM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 269d7701-7ad0-4cc4-4de1-08d9d5d212af
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 13:47:28.4681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9aXddOz24sHXlIogMIN+jVKT99elww3ZrI9nqNcygvRpcYq9Qqjdc6ggDvnDSWpk3T4coK+WWk2LI7ryPeB7rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1594
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch improves consistency across git-p4 by ensuring all command
separated arguments to function invocations, tuples and lists are
separated by commas with a single space following.

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index c6201b8d23..0e54be57b3 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -99,7 +99,7 @@ def p4_build_cmd(cmd):
 
     user = gitConfig("git-p4.user")
     if len(user) > 0:
-        real_cmd += ["-u",user]
+        real_cmd += ["-u", user]
 
     password = gitConfig("git-p4.password")
     if len(password) > 0:
@@ -303,7 +303,7 @@ def run_hook_command(cmd, param):
     cli = [cmd] + param
     use_shell = False
     if platform.system() == 'Windows':
-        (root,ext) = os.path.splitext(cmd)
+        root, ext = os.path.splitext(cmd)
         if ext == "":
             exe_path = os.environ.get("EXEPATH")
             if exe_path is None:
@@ -1839,7 +1839,7 @@ def patchRCSKeywords(self, file, regexp):
 
         print("Patched up RCS keywords in %s" % file)
 
-    def p4UserForCommit(self,id):
+    def p4UserForCommit(self, id):
         """Return the tuple (perforce user,git email) for a given git commit
            id.
            """
@@ -1848,14 +1848,14 @@ def p4UserForCommit(self,id):
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
-            (user,email) = self.p4UserForCommit(id)
+            user, email = self.p4UserForCommit(id)
             if not user:
                 msg = "Cannot find p4 user for email %s in commit %s." % (email, id)
                 if gitConfigBool("git-p4.allowMissingP4Users"):
@@ -3272,7 +3272,7 @@ def streamTag(self, gitStream, labelName, labelDetails, commit, epoch):
 
         gitStream.write("tagger %s\n" % tagger)
 
-        print("labelDetails=",labelDetails)
+        print("labelDetails=", labelDetails)
         if 'Description' in labelDetails:
             description = labelDetails['Description']
         else:
@@ -3478,7 +3478,7 @@ def importP4Labels(self, stream, p4Labels):
 
             if not m.match(name):
                 if verbose:
-                    print("label %s does not match regexp %s" % (name,validLabelRegexp))
+                    print("label %s does not match regexp %s" % (name, validLabelRegexp))
                 continue
 
             if name in ignoredP4Labels:
@@ -3801,7 +3801,7 @@ def importHeadRevision(self, revision):
         newestRevision = 0
 
         fileCnt = 0
-        fileArgs = ["%s...%s" % (p,revision) for p in self.depotPaths]
+        fileArgs = ["%s...%s" % (p, revision) for p in self.depotPaths]
 
         for info in p4CmdList(["files"] + fileArgs):
 
@@ -4304,7 +4304,7 @@ def renameBranch(self, branch_name):
         """Rename the existing branch to branch_name.N ."""
 
         found = True
-        for i in range(0,1000):
+        for i in range(0, 1000):
             backup_branch_name = "{0}.{1}".format(branch_name, i)
             if not gitBranchExists(backup_branch_name):
                 gitUpdateRef(backup_branch_name, branch_name) # copy ref to backup
-- 
2.34.1

