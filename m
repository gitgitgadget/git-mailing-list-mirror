Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99B2C433F5
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 16:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244750AbiBJQrg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 11:47:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244673AbiBJQr0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 11:47:26 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2067.outbound.protection.outlook.com [40.107.100.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3A4125
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 08:47:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IchISCpP/gaHreIoM7rBtWrcXebtHgqBfZ7hksULF1sAkSctkuHpiEaHJ9vVRerSXmq7LHAAj1R+7lC2io1/apmlz4I4oL4QH+VOT0Jiu3GsUr27O/g/2V26ay90NmlAzGSsVbX+CJbWMlCtDADMo68EEjiMVESIhwUV59dzF2Fpw2NSb67IYnarSqSJ0UrmT42DUfsx03NyoxPc2ZlVTmLx9h3EQo9gY0WwOmbfb2RbTYXBKnVaeFXmNU9+sZYdAIpSEksv1ups+tUXJVRYAfhkss3mKHvVvh83K5TUSCLjw6uf0Y9YRN+qc7eNIbkeWarhlDJSWsRMN67g3gUdQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lujEaAYbe6RVaKCoApcfhS0K3+e/QU3NGS0/pIyNf1A=;
 b=jsii24iw5qMGRdooB2p/lXKTTQYmC6mqP0CBpqK65Xz86NFgdSr2BhquIgQqXwaJX7gf8+JhbjE3/bA2qNBxC0GssQ1W6W2sHmOU77toB9PXJCFfPIPcn4ae3/85WkuEZNGZ5uymAhtnSdVNRQoQ3Om92m6G0kqA4eIVDiKqinfG2+OO8jTX+bCzk9qTnDhc5rZUBB/XG4CgrPeBtIX5wSvwtHybUwEmQB2aCPDkrYSSd66w8CdxfDfFu2lYOiWxAfxNvWj7T1zX1ZWkISM6SzYxiLJ8OoSLg3V6HHHN5epvY1AdHPKE16x9gD0yjuE7E4jJxB4C2VSSEnK1I74nDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lujEaAYbe6RVaKCoApcfhS0K3+e/QU3NGS0/pIyNf1A=;
 b=oc5k7FuPev6n8cOfYgQI7dcW19u8s/zTvWys8MNu+/KmKV71AWFJrapqYYSOtKfhrVHbcP2jhHXBbI7sIOaOs0p66q4uOfhAuZ5RjEB8cf7Szg5SJb8du28nP5AGDbluZ/VmYT8qLyNuWCVQ7b0nUEtZ4ZRmKZ57oeBAw89Ay8MoZiA9aDFgvurytDho4u9oYNiBtq4Vtf9EJzbfwCi0oAZAE/Rm8FqpgBlEfw5vmsHyrUHKoFqolq+GCW9aVyXggu1cIVQxmvjatbZExE9eb+c69bLoKy3VVdNfoieqYVtX+Vf7cSLuA4j5DjBO4pqMkteYvL/jHbS945rFDh5hkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by DM5PR12MB2421.namprd12.prod.outlook.com (2603:10b6:4:b4::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 16:47:25 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::dca7:5323:3:cc10]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::dca7:5323:3:cc10%2]) with mapi id 15.20.4951.021; Thu, 10 Feb 2022
 16:47:25 +0000
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
Subject: [PATCH v4 16/22] git-p4: ensure there is a single space around all operators
Date:   Thu, 10 Feb 2022 16:46:21 +0000
Message-Id: <20220210164627.279520-17-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.35.GIT
In-Reply-To: <20220210164627.279520-1-jholdsworth@nvidia.com>
References: <20220210164627.279520-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0069.eurprd04.prod.outlook.com
 (2603:10a6:208:1::46) To BL0PR12MB4849.namprd12.prod.outlook.com
 (2603:10b6:208:1c2::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60d964cf-1a9b-46b4-2363-08d9ecb5045a
X-MS-TrafficTypeDiagnostic: DM5PR12MB2421:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB2421BD4FD0D96B9769BF2CC8C82F9@DM5PR12MB2421.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:159;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fgxCd0M9R1qDiJJHB+vLHzYaooNopAfEo/S1SkImO/o24XgUJmGsvnqPKWJ0a6wuDmbXaOersU2fVmjZbYo/vuW32Cb+DCNYFH1BXU5wcG/WkT/Jsk8nhXTiLzUrHiAwpoXlMNr13pOYck8qIRWjpMHhNNXoPnEfngzD8M6JVMxguX5+cGYpTMjltORiemjVWGgtNaA1+ZyDos/TSHfDcyVUyEVD6BbTkqs+xb7++faEa0t0PFN1qtLpD6aELoAtiKQRlXnCFvFm/mLjQRwwxCUz+xxwNZRLLQT2HL8nxMETSXRxJdnFz/QwoHk7Y+0pKnBLlabzO0/6so0YTIYCtbrsCNCUf47DdC5Mb2scCcoFoXqAWvbrQ1/BstViwZQK6zQphVvUQQDlCRauybDmrjGz9HSco0h0yOWPaHPLnIadI03zCieSpfs47X/l6aDAJpPcI9DdKjI8eEQFpfHNpo7jtYWc/QyjwruIXYTMGQ+b31IVopESUxkGCQXojdCkInLicOBRP5fc7rcooCANJ9INGPppPb0skkVqWUU+Xulq92uHlfMU1DTLzJwwWxUtvbqHLpkFhD5Ml6WNMwthQiw5uBgF7SCILsFgQoSFZNNd5nVQADuYQZPLVXKelbhhzzaQXJncr0GT3/kfnTGVpn4KZEzAt6VUxusYxX96pajxXkbTje8/jj8BtQLsRa8/HHKjn+qyiDVbOou9ywtsUv8a1FXSr2IMgZILU8bdCBvpciqg1UlDLTa4MyReOaSqbjijAigza5ay7hRfI2sj66u83ePnG4i6yPoligDs3G4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(38350700002)(2906002)(52116002)(86362001)(6666004)(508600001)(6486002)(6512007)(55236004)(6506007)(186003)(8936002)(8676002)(66556008)(66946007)(7416002)(5660300002)(110136005)(1076003)(316002)(4326008)(36756003)(966005)(54906003)(83380400001)(66476007)(2616005)(26005)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qxawcfAIS4II/z8tded40AL3cztQUvEmJHSOy95gFEo0Pnnaq0ms0L7r0XZB?=
 =?us-ascii?Q?6cP/zDdzJ2I5tv6ciMsTFVQ3oFhEn6Xkl2nWZ5mej5MnDfgNtH65SoJ1c2IX?=
 =?us-ascii?Q?QTvZfuzD2/gs06TQSTzKWJl6DDl16eH5vKnFRGx13bLsoO8q3e/SQ6tvNHAq?=
 =?us-ascii?Q?Ru1lYRi3n+a8EJzTLFHHPH9sxBUyj5MdrixIot9dqyUjELRgMmAKo9NEddR0?=
 =?us-ascii?Q?nBNmjGRWeXS8DpZt4mSthdbQ+ie1tzyOQOO+IkFjPLxHlVb3Odnrs8Wz+oRv?=
 =?us-ascii?Q?O0Xi2DTtKFUOAKcPeCefm2y51lrqpxxKdywwW/CirwPuBHZ1wiV+r66g3a+U?=
 =?us-ascii?Q?nqpDhuHR/Ni2xcG4AiiHS8THVq96Y9ubB8ALg6hKNDt0CX1iacv4bhR/Ekss?=
 =?us-ascii?Q?+j1SmxRQ/JRUY3qLWcJpENiSfTOniEUmyosGVLXQT44tzbSvHWYk9yP4SOiY?=
 =?us-ascii?Q?9MpyF6GpRrmpBWDpQNoLen1HMScRU+5IPkVI+zlnR4q/xiWwzEmf1JblL67W?=
 =?us-ascii?Q?wXwrJiWrull/AXWL6qy1P+Sb+vdardOcZZVZMBbz0ZSIBL2w5IYqj9E+Ekxp?=
 =?us-ascii?Q?nh821j6ZdkIVJxj7SghLt0c8td0U8HPLKC5qx5MXl5NIFF+v8awJbRXUUzjr?=
 =?us-ascii?Q?gQBiLtVUHtmsZbAfgub+qT9zx2nCjyEWbXwdB2CLrv62vlYkzSdXoY4nageC?=
 =?us-ascii?Q?rogZNfMeYpPmRciaRIVi/ZW+xp1L4bWFDistlrBIGSkbCI59WZpZZozBts7d?=
 =?us-ascii?Q?Z5Ctogp5wByp6QtEcRUzWI4sDM6PbyKglzA3jE8KgT9/oC2zPGbEv5CtmGKa?=
 =?us-ascii?Q?78FU2UpC3EdFizEYPL4hHN7I1I77QEfaONLiVQKxnq9vQOQRCt2LkYp9fsqE?=
 =?us-ascii?Q?/6GL5N8HstfpXMI+xgF8UhMIc/yM/wUoR6IbC2nx1/6mGUqgBw5BJ9rjz5/E?=
 =?us-ascii?Q?8aBU8goZ0mtldI4a+BJLBidMYkoB+6k2aZuH9FnfL1UTClunqUFn9uBJBz2P?=
 =?us-ascii?Q?EhefD717M1/BcN/DS2QXLQUDwUdoKKyo7xC6tMlnHFQxy6KbQ6RyQlPUY8aX?=
 =?us-ascii?Q?q4K3TkAG/63KwBzojMO5JWi7OjZ2bLW7mmb+Xvnoxm0OX5FAeyWy07v+lgpG?=
 =?us-ascii?Q?fjYLbCnIVpeJqFJI+1Xsd9jemw28nvwS7H0xhG5BhaWNzYUULtu7Cx77giIC?=
 =?us-ascii?Q?HU6dVH/EpHk6oYHcyGFWEU3GcEVjiAf3DjZtcCeO44aD1JfEV8DCTugXALup?=
 =?us-ascii?Q?54+nT3FK8gi7kZvFImZMpThhzUDnBXUG7Z//aMBjBJuhk7kiQRKMVzB64VoJ?=
 =?us-ascii?Q?2v+zvJPWlynwDz/Kw/OdnIhGpM8dbEQrL+pY2edAFYPMEMtjMkHkHrN+Rz1H?=
 =?us-ascii?Q?yYe2e1OgMz0YOZ5cnntPFzkPA9t6ZnRetoaGTKnScTdPkIEbe+PUzXr3c0qM?=
 =?us-ascii?Q?HJ6/t50UdV6O3YR/yaGJc4BnQA/xAcWurIisEmgmuB10ixRYKw2j4hXjMBXn?=
 =?us-ascii?Q?HB20+qXEzaDFLcNEwS8Wlqs5Hr9bYq4r9mM/Yg7DWH0+NtjtB030AeWaZbZH?=
 =?us-ascii?Q?ZeCEy13a5UgZCZ+j4GnLVPee0EPFn//P1EGr0IDMaGIytVc74f2GkDSi2Pnx?=
 =?us-ascii?Q?/FBHAebe0U2L1VwI+0NXhaI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60d964cf-1a9b-46b4-2363-08d9ecb5045a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 16:47:25.8074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8YxKowtEA0q5U29rygDwlbPVExYPTnaERdNeNKjr63Lz9mRKZTQaXeSDwGEoTkPsX/NhPsqhHpH9SF/M7/scEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2421
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PEP8 requires that binary operators such as assignment and comparison
operators should always be surrounded by a pair of single spaces, and
recommends that all other binary operators should typically be surround
by single spaces.

The recommendation is given here in the "Other Recommendations"
section

https://www.python.org/dev/peps/pep-0008/#other-recommendations

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 88c2b5213e..97c2f82ee8 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -67,7 +67,7 @@
 defaultLabelRegexp = r'[a-zA-Z0-9_\-.]+$'
 
 # The block size is reduced automatically if required
-defaultBlockSize = 1<<20
+defaultBlockSize = 1 << 20
 
 p4_access_checked = False
 
@@ -201,7 +201,7 @@ def prompt(prompt_text):
         sys.stderr.flush()
         sys.stdout.write(prompt_text)
         sys.stdout.flush()
-        response=sys.stdin.readline().strip().lower()
+        response = sys.stdin.readline().strip().lower()
         if not response:
             continue
         response = response[0]
@@ -2339,7 +2339,7 @@ def exportGitTags(self, gitTags):
             # Create the label - use the same view as the client spec we are using
             clientSpec = getClientSpec()
 
-            labelTemplate  = "Label: %s\n" % name
+            labelTemplate = "Label: %s\n" % name
             labelTemplate += "Description:\n"
             for b in body:
                 labelTemplate += "\t" + b + "\n"
@@ -2842,7 +2842,7 @@ def extractFilesFromCommit(self, commit, shelved=False, shelved_cl=0):
         files = []
         fnum = 0
         while "depotFile%s" % fnum in commit:
-            path =  commit["depotFile%s" % fnum]
+            path = commit["depotFile%s" % fnum]
             found = self.isPathWanted(decode_path(path))
             if not found:
                 fnum = fnum + 1
@@ -3925,7 +3925,7 @@ def run(self, args):
 
             p4Change = 0
             for branch in self.p4BranchesInGit:
-                logMsg =  extractLogMessageFromGitCommit(self.refPrefix + branch)
+                logMsg = extractLogMessageFromGitCommit(self.refPrefix + branch)
 
                 settings = extractSettingsGitLog(logMsg)
 
-- 
2.35.GIT

