Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D892C433F5
	for <git@archiver.kernel.org>; Sun, 16 Jan 2022 16:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235574AbiAPQHh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Jan 2022 11:07:37 -0500
Received: from mail-dm6nam11on2054.outbound.protection.outlook.com ([40.107.223.54]:56160
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235584AbiAPQHc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jan 2022 11:07:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e7SRD70EvRIyl5DENnRMBVKs0uyj9+w/Ztod7SIk7KNvsSEQuU5XUk8zJLjop4nBKFP5Uquh1GO1vjvwBImqOiQaMz+IvuhCUY9pDK7B//bk96WU0UZ3EMqFy+Bk19ACBbQEcRzqGGvUWb/8XkjcJW2g86XJVi9Hif6Bzh4fJUoUCYAvE7nWmUox/Jp/nGwF1dePfuQsPhN5nCgHh0DRcv8VqUB40HwBv4O80pltmeCi/EjCi+qQ9I5RcPYAN38l6Cz6E9MOO+OVeF42h07VJUclbomfXQrNgPUH98SA2sKa/YcZobIaWFoNqo82RMHWxXWJyHAbaz67EIyhSW1YXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NxT7Z/pT+Hlh4+29oPZGlZ6diV04CD9HmlSUJXgkHy8=;
 b=AzB9t/vKnFbq+PDPBvEKx9o7s1kFhhgJe9EkXNfCA/IC2cflzZn+NpV7HdKYwurSLmpOT7LJYiNZl1KKYOTCpr5aQF1KSddk9c4IlmLmjSuEDMjtiCLR7Qi2YoIg2MsNGha5mzxAnVd+4AnF4RmE4xO/1l1+TdlFjs0HfvsoA/gU7U7+BQON7j7Iseni5M6lXGBcHdxziiOBLywYXIqnvqyWNKnSjNLF8SUFSeTvfnjO0/4ZwjwHF7PRaXRSjLe82PAWqKvDBpSN96FVIvuyawa8mw9NED9cNmDzRXaaKyGY9wddeIcHamBRXwfy1S51jdeTfoneMwzpX+BDA3Xutg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NxT7Z/pT+Hlh4+29oPZGlZ6diV04CD9HmlSUJXgkHy8=;
 b=kfIA+ccSM5HiaWonf4bPYbsTn7KnhR4U47b5G7djU7PrzQ8LsC/dFi6Zu75oWFW7dVI03mXKDjrQIwqi2r7MAf5eLEEGswgSKcCsJFVddEGBj/D7lMzWaXZR1QkrkF+DZ8EVSJ1lODIjM/lLAE0Li6b1C10znKAGksJDgNHae/LFRCTWsxZoGLg/6JYGFS/dcR9tfvC0kHFMW6GQKXxVPfJf9nVsyfRKtgJoCIIxlK4bQ4++RUiochf2tk2npbCnADgYmZZsoDdOVvL2Yt0pM2520A7b4i6FpdDSYOMjNWTzE7b7m5VOOL+QjmLkO56+aGN8Ud1eR3Woeg7yFuR/iA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by BYAPR12MB2597.namprd12.prod.outlook.com (2603:10b6:a03:6e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Sun, 16 Jan
 2022 16:07:31 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed%4]) with mapi id 15.20.4888.013; Sun, 16 Jan 2022
 16:07:31 +0000
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
Subject: [PATCH v3 09/21] git-p4: remove spaces around default arguments
Date:   Sun, 16 Jan 2022 16:05:38 +0000
Message-Id: <20220116160550.514637-10-jholdsworth@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 21e33407-d59e-4e33-f726-08d9d90a4cc9
X-MS-TrafficTypeDiagnostic: BYAPR12MB2597:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2597A4566DA34C0E25178DA6C8569@BYAPR12MB2597.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:158;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MInQGJstMAYcd1nxKr6UCzoHUHhVfE06QOSd/+pQfJ1p/rVozKB92O/nerMfsqxRZVdtyozB3ppNC1VeyWxYCRz5c0P1X8+V0bwW6bNbD5iOLF1so6XGNIOQFmoAFyqxtbz4UGccuZu5E6QRGAaHoxSWCojGg9U61KTrehiJqlwPr7DwC5h9fnIRvmuLMmVyWD49RQfKwApVYWuVpuQGPKXboiNptnOh3QEs5e8Bjcvy4mOYvfQ6zk0loqnhEYmHezcccUGM4aOB916O1pWYxMs6/D875mbSngBu1EmNwTUe6SeeIj7kSDbOTXqH1DXRfYVuk4efrC/DoxT9QiFe0Mecaj5vYKow8n/rsCsMpvKZ753CtSAOooRmAZBF+DW3WDq9gp8qBLHjFjeTini6GhZq+OCkKGtWhrGZQ3po1gY3qecPq/77H0OqHmv1l0LDhr5y0YCBqaCT8hxfoj1ziwyzZ5lZN1xY9ufIEsXPky+MqAFeD4l1sYYii0CLL+3gkt5YDnMsG8LUOlC3WCXxuuXdwxBYsZlhdxhGwzTKevFCe1RQveQkwaq2C/0DSNMKhb28G5iQaqkM/m9fp9m7MR1DVaPeejszmx6TOSO8Y04luv48QlgjY+vze9iepOpccpNGdVvxOa9Qx2Z17FM8z25BBeK1/AQ0K0GnVcSqvdV/kDxfemgIfj1aD6mRFAOMx9xx+Ifa13D2qk+fu6ChxBBzTbDZSr1lTAyQcs8+gvy80Wvt/Yrpsrp2BIJ2ZHN+a950tLVxqmzGnIUtTIA9d/paAlf6sR2ldmDR5asHnx8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(966005)(38350700002)(38100700002)(8936002)(4326008)(83380400001)(186003)(1076003)(6512007)(110136005)(54906003)(107886003)(8676002)(5660300002)(316002)(66556008)(66476007)(55236004)(6506007)(52116002)(86362001)(36756003)(508600001)(66946007)(2906002)(26005)(7416002)(2616005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Afvg3txLLyONFTNHogOdyuo1H2IEYCk0t8ZT3zHOfltAP/YnEYfkKVx9xD+A?=
 =?us-ascii?Q?gyvUTJppdYBGpoow8N7SsoOKDE1YCe2ONUp7I8zkki19LeiiptCvRDL56K22?=
 =?us-ascii?Q?Z5IhOgs3bFtPRpuj6xgF3O2/vbcCYtq7eRjW91cRk+nh0NaHTEpB0qpyIcNV?=
 =?us-ascii?Q?hp/zL3ZkeLSkY5n3oPK3DngbCPxxU0nPLEYp5BVe3DM7jK5Q0U3akIvVm5m6?=
 =?us-ascii?Q?ty7QRHxeCqF2eHQ9y4UkUA/6SVTi9bNcNVmScQvHjRnEJWn/HtZx52Ntt/1S?=
 =?us-ascii?Q?vsQwqPS8dpcbpiVQ3tRjaodNfxi9849mFqaoxu18XfowpNUQoSl8P5M/f7pc?=
 =?us-ascii?Q?Sr9uFRbnaoJeV7a6nlMvDvOooK0jY6xKq1M8qI3wWfoNhOuBMr+8YgUg7mpK?=
 =?us-ascii?Q?pOTDhrIVBVDZqi9nI0tzaoe70aswaOGkiLzqsb/gwEB4zrenrYpASqE2OSkg?=
 =?us-ascii?Q?HJfIQNG2BiQ3o8qx74PlWlLyuxXooQm2VVfphSQ3jaUKmZepOg05QPv1oxlP?=
 =?us-ascii?Q?aH0w+IvmdMVxp6dhMEiGhtMFQEGiqMtDKhqCRgC/uZ7ALmAAN+deiWGZBcR0?=
 =?us-ascii?Q?IQSteXuE5VajelmupRGaVNoUGrwDf8uQBE0OlPm/cIiiZJ9/o2JlesthKenm?=
 =?us-ascii?Q?TPp1x/xNnt5XhoRZzShVTOdvbaWDegHutzbzsiyp1T03RKdeg4SNCFnkR85b?=
 =?us-ascii?Q?R2O2IWWUKP7G12B0lzvM9NnxK4MQ6NZpk6+kJOqrfGS6aQSgUhU3L+Hdxx+o?=
 =?us-ascii?Q?WXX6NDmGdnDAoykjVN0rZ4DUAuj5AFJkS3Wudpef+7/XuI3k7Hn4pTmk2V1E?=
 =?us-ascii?Q?y17UuwsgOspwhya90gRB/P32Y8Q4q6bQ6yjL89/uWJekCf9e78IwB96UtKEe?=
 =?us-ascii?Q?/I1YmVz4FTT0tKi8/+5dk/kbSzgef7iN4K0TixJS5ZVE6xt+c+ii0ThbAi2q?=
 =?us-ascii?Q?tk1KxtanPiLRJcUDgpQjccxzkwz0AhOn4T1QlDNXk/jSYvrtb90xPFbVLVI7?=
 =?us-ascii?Q?VfKo0Slncip4U5485mvf58uqiEvgfuVr5vMW7DLTtvHA0we3SbVzW5zCGfRx?=
 =?us-ascii?Q?LmC/x0QJZSgAWvNiYeYMMJ8BLD+D9zBcLMFH0lq1RuEiPCaS0jsttpMcjP38?=
 =?us-ascii?Q?wToQdM8KEYfGd/su3kUh+hnNJ8iw5/ibXHhi0rb03AW+YtijDQaEXI3l2cbJ?=
 =?us-ascii?Q?aVja/yGuBa4ipMxpATj7xGJUCn8S6AOTmoWZb7hbdT4jz0RujBFNU7YBcjyn?=
 =?us-ascii?Q?Ti8x5Nk/9Wm+EHua3wm4aD6bzIyIdIYZ1kR1SlifhzEUzFc6syOC37oWA94v?=
 =?us-ascii?Q?HctfjXRC4eNdVF51e95Uo5Cm45A1veLgJBrdzXWfwkA/AYTw9Uxd874Amlf+?=
 =?us-ascii?Q?t/BdDOy7c9d7aYKvjA3iZNnZxhQbG7GfrS1X2UkTMjLZvJW6KVg5i37zSGKi?=
 =?us-ascii?Q?K/hv136cOYh3tEn3PL3cRrRUDLOIE3b+UrU7GcAEXqd95x2FYwC9hnEFCsKd?=
 =?us-ascii?Q?2UY/r2ajETLktTRHK1as3AaA1HA+88nilvg9Xzjc7j2GPrFphisvgTiY8eZN?=
 =?us-ascii?Q?JPyHQyx52+ldMYNrxKYEDfEYxGb7IuMoiiJMSezLR7xK6Jv13rBq0xrTpDS1?=
 =?us-ascii?Q?N0cMwJrc5cyqfeQKFosVkjc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21e33407-d59e-4e33-f726-08d9d90a4cc9
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2022 16:07:31.1933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rIkzdi0Gd+LESXFAu66BSDZmnjvHgerXYUpcQ8NUnH0Gcqml0EO6YOEuERDIfu8oObjc0l0ktusJkPvrvIm+FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2597
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
index df15aaf9d4..534f260e9f 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1098,7 +1098,7 @@ def branch_exists(branch):
     return out.rstrip() == branch
 
 
-def findUpstreamBranchPoint(head = "HEAD"):
+def findUpstreamBranchPoint(head="HEAD"):
     branches = p4BranchesInGit()
     # map from depot-path to branch name
     branchByDepotPath = {}
@@ -1126,7 +1126,7 @@ def findUpstreamBranchPoint(head = "HEAD"):
     return ["", settings]
 
 
-def createOrUpdateBranchesFromOrigin(localRefPrefix = "refs/remotes/p4/", silent=True):
+def createOrUpdateBranchesFromOrigin(localRefPrefix="refs/remotes/p4/", silent=True):
     if not silent:
         print("Creating/updating branch(es) in %s based on origin branch(es)"
                % localRefPrefix)
@@ -2896,7 +2896,7 @@ def isPathWanted(self, path):
                 return True
         return False
 
-    def extractFilesFromCommit(self, commit, shelved=False, shelved_cl = 0):
+    def extractFilesFromCommit(self, commit, shelved=False, shelved_cl=0):
         files = []
         fnum = 0
         while "depotFile%s" % fnum in commit:
@@ -3327,7 +3327,7 @@ def findShadowedFiles(self, files, change):
                     'rev': record['headRev'],
                     'type': record['headType']})
 
-    def commit(self, details, files, branch, parent = "", allow_empty=False):
+    def commit(self, details, files, branch, parent="", allow_empty=False):
         epoch = details["time"]
         author = details["user"]
         jobs = self.extractJobsFromCommit(details)
@@ -4473,8 +4473,8 @@ def main():
 
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

