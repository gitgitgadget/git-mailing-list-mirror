Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4803FC433EF
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 13:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353712AbiALNrd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 08:47:33 -0500
Received: from mail-dm6nam11on2052.outbound.protection.outlook.com ([40.107.223.52]:31597
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1353692AbiALNrS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 08:47:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B+8MUr4PATMIzophLNR4rlFEDWzccJtkthG6cJxGZ1QD9ebqUKEDqwof/uLchwJ9kjqecgqoOfCGWCX8IanpK1NAX5w/rYG6yLsD4k9SQhEux+OPd0KdDhK8tmrOsrq4KD64hptUMzqpd+Q8HHxLK1pvjAjw7y9cjmhzQLZHiMon8el4m4reRg6NJ+FcNNXkE8jcXbGZnePYk2O//4hNGP1wqJWl5pVTOc1GWVO8zEMArk/i+CXTe5xC4GyTLylBp79LyQtkIlTvinyW8Kd/3vtfHffOz+1HuMdTG+bi58HURQPUNpaUPzwXvqzL/YxoDQk54BBW/1AhX5940znxPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifBCojCXDHgbNxeNyfSOL4Sp3EosjyB1Y071Ejs4SSg=;
 b=O2pYeyOt1NDBjUBJD8zA3ZckQwJPVD4k1/NbupYhS7FqsnhFZH+Iw7blV53lcQhu26z4/pRgBtdymE3/2hLyhCCIAyF3B0HqRBhJr0D6Sw99ERJqRiC37cFzuWKgIbMAIjTXZCrxDyqsm5GxHltOwKk9qKOfYd0s5bjdcoyvO9sxVDXNaL30dVOpvTp9M7uaz2+fDQR+FjqybZFiiX5sygaC90XpfLKmZqjJk+xYtwKi88Y4y4GOqEdu3fzWslUxzIEJJN0n8ggu7hwAC6vr0yL0Mv/F5QBMNl0tf31NtGBaUc5/7fZONnrhJcZbaKbcq3dJVojXs4XkboEoCjqXLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifBCojCXDHgbNxeNyfSOL4Sp3EosjyB1Y071Ejs4SSg=;
 b=E8GSHRnZkigpLL1iEX51FpmQjo5XVG5S7w5Z+VxRRE+1hFrdS5Q6Ctf92COXP03aze4UZg0FN3L9s5MyU5OFygNjObW4/kKaMhbfFuLyGeaQGBBG2VSXcqzkHNUqsYEa1TcvibKoD6madFcUfYpFeg3drKGL2hYxgsi2dMsXt0uSBUzUpNJuvyhYaDUwN3PEPTm9AZr/9+84JW4HHok5DYmtswlZUdzqlJ6tumAM4YcMJ3Sj4UCqvlAfMk6i/fj10qDHTbbddSwYIyVjqWmk+XgaiyPEAoTmtpDzcxw4T7s5ax98ZucCMteeqzHBKI6oVewvkQ9jsqPROhfw15cY6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by CH2PR12MB4136.namprd12.prod.outlook.com (2603:10b6:610:a4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Wed, 12 Jan
 2022 13:47:14 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed%4]) with mapi id 15.20.4888.010; Wed, 12 Jan 2022
 13:47:14 +0000
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
Subject: [PATCH 03/20] git-p4: indent with 4-spaces
Date:   Wed, 12 Jan 2022 13:46:18 +0000
Message-Id: <20220112134635.177877-4-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220112134635.177877-1-jholdsworth@nvidia.com>
References: <20220112134635.177877-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR04CA0137.eurprd04.prod.outlook.com (2603:10a6:207::21)
 To BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ed987bb-3da8-49e6-b90e-08d9d5d20a53
X-MS-TrafficTypeDiagnostic: CH2PR12MB4136:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB41368D017BF3039ACC910B78C8529@CH2PR12MB4136.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:95;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dqLbZ4K/k8X+s/uJSsXYePGp+9P00jp+KOYbK9ZM6iY6WuqzMLg+BSDNdg8qiHl11vS2JrHUYPr4RwljAMW2rO87DXJclilpV1mG6AaE9Kr5dnaaf2kCOo+vjiEYSFLxyfkSa/fKTbjvCvmBSbw/eFD9ZGU3eUVwVO54hSqvnn8klgkgwFKBWMSoQcUQG6UMkNwl61fNUhwWb9vpZeLsD4QkYpWN0CcpGM7zN1IijbDqu8XuKRDtO4ePVbToXGUFx3pZd/uitjeIa1U8Q3Nveinqlr5vI/lUp6eLzc6MpBao1q8Ht1TMTMJol3LXgikEVPxf4TeIIN0AC4NbTxT/oSyKi8LAfICKvbItl0wOJe1BynjUE2L1Z1w63wVa0+aQWJa6fEHk4lxuZLps3zSBphpkuuTHt+h5GUBbgBKaaNJD2J9EhZkv9D75TOPJwm3aHnRGmDAAIbiIwamwZEgHp17Ru+g0OZPG5/19Elcve92Ob5H/GhZbtUlnDRTJzCqRxGQtU9NK4H4VckRkWvfZ7vTtOdQ0Z2uvll770SzCSUu/YhGH4s5V9xhXHLHc4UmWZp9itf+tbDOPjAxMLR3x87iBa/jRGX+mF6whmqReyyWjgnIvXtPldSnVtbqQp6zsPBTSrKz61UU0vfMU11IL1HpNfR/ZchQt4zkepu2Uz739ZP6jKKyEjz+O2ov+RD9TfiRadnvPpXAz86uNQ9uxZ2Qzi+A6rVbHyJOvx3Lw+nQTmKosZr+LOfmYIdiNn3WrzAMFKi40XUkjZZIBbib9NWi3rRauqrXi1FsccOJ8aZo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(966005)(26005)(110136005)(8676002)(6486002)(2616005)(38100700002)(86362001)(7416002)(36756003)(54906003)(5660300002)(8936002)(6512007)(4326008)(52116002)(2906002)(1076003)(66476007)(6506007)(66556008)(186003)(38350700002)(316002)(107886003)(83380400001)(66946007)(55236004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sBYTZlrk8sxOld0+mkK9+tCJ4cGFRpPv9HdG+3ayq7gWOIawLfA1wwGXM4f3?=
 =?us-ascii?Q?7FYiT/5uf5l23vFYYn9UI8mN7DiacuL4SFNnLsLKtQRnGdP7V+oIEfPgiqyx?=
 =?us-ascii?Q?0VW3k42kqGrhkYR/boueNQCoZtFkihUiNZ8vKeW75Ui4ptMOGSRGulVb7BNf?=
 =?us-ascii?Q?c/2I9mvXJA0V/q0xHPbyOJB1/k6NJMi0Q6JOTQK837J4vjMVO/COYM6mRtAE?=
 =?us-ascii?Q?RJAZzJYQUvmW3Tpk2VQYlUsNo54Sh3NkanRc4mdtAJFVqP9z3aMaugxl+QF2?=
 =?us-ascii?Q?7sMF9gDcv16qb+P2ARol0P0e5zlGvdpGt7EbgGxxajw9Xtjv4SBfw82EeLyv?=
 =?us-ascii?Q?DPtWFLjnWnUcebC0y/ZCboXBrrVNCqJROmNuWWJ+6YBUQShlx0XeHHWxRUAT?=
 =?us-ascii?Q?2elyFxkZMVDCAGlLDHNmNoB8phGV5rux1B8krL2mkDaa7MzSzxrQWenkhuM0?=
 =?us-ascii?Q?gkyO/2Lc6oY6f1/I+iqbsXjf1/8tsfSubnSazF8hFQd/e9j17TEFkhqh40EP?=
 =?us-ascii?Q?zK7BWLNy87OTJQKrKqPg/kZe3VU+uPyHnHoTufsGt/ZqRFjC0ItoQkbGtSEU?=
 =?us-ascii?Q?THSk+MFeXgPSA7dP1Vl5CkuUNTHPaX3JrCoyL/o53w79sSL3pbLThse1OW/N?=
 =?us-ascii?Q?zoKc1fyB6x/12co4tow86Kuin3luAjVRumqM51XoVZqQpV7hIitkX8Oi11zR?=
 =?us-ascii?Q?o/289VspL/39MKcN5tAHg1Zj7k+pZDaz/tdINh3DSxF1/nJfmZAdmJYbSOS9?=
 =?us-ascii?Q?PowDgorAqUKOghCm8SezJztKCcFAaQTH0/jBxkB8wz0GRF4XJ8njoG96nWWn?=
 =?us-ascii?Q?nxXD+0oPY0vDDZnEO3AV20zCGcnJfDJyaNofhkN9zlTJC0Zsm5i2BTNj9JAO?=
 =?us-ascii?Q?Pp0zJmaKGZwOlroqZsXB0ydpzpC7Czq406SAoijQY1ohISmKBVII0PVLg7fI?=
 =?us-ascii?Q?1ixRBQFNktF+0cdX+Oe1LUfXiZWU9W4FhkwAsvT9pcwG8oc6O33W/MRThJ9R?=
 =?us-ascii?Q?R3qJdV7u+9TP7//SBaWo0uEkj1/LfiMwfn9M2GcCANlKPGTDOsI2ntD/JfUN?=
 =?us-ascii?Q?XKCaxfmqduGiC6/kzrI5/u7CwexNzX3b+u30HRggszpzZ06caSZ7n6OpZuKl?=
 =?us-ascii?Q?4RgFBmSmjE2QfMVtw5guGDV2KiGyvlqIyJ2l8zUoEgO6OFcm9177xryHGzNP?=
 =?us-ascii?Q?BsUJFB01dd5exblaTK7wJkuoqDbw6+HvtjtbFodhveHU0pWj+uwiAH98llXA?=
 =?us-ascii?Q?r+hGEVSyuYKV+2IjdXTkYx/zXHplJ4CopwFK5pvVm0UYgewKdCZf+2Do0RbI?=
 =?us-ascii?Q?Jh/L4VJZcInh+/IrvV+wZ6Ia+rdlH5loTIAgzU8Pco4y49zHttfffHYQcUfi?=
 =?us-ascii?Q?I+Dq1C3rU/S3d58MIIlAjmmk3oqC+VtBJtqU36fYwKhpSGHH7xEpNH1uCnf8?=
 =?us-ascii?Q?WUJDoQhW3dFqqNy16R/qc4UYycQ2hnKEuJyl0BsdxNplzbnFmqCvcLvLd5YT?=
 =?us-ascii?Q?lek9QPkjUlXQxu6oWLKIt61YzUXOLwjccumLdlDZGAzwh8Yns3aLYiy8sNEi?=
 =?us-ascii?Q?AAKPHM40lDn6zrm7WCqaIGeq2+iMR9Li9qeZ11UfzUZ1W5KvPIskV0yuIrGq?=
 =?us-ascii?Q?2jJs35tB4q8AamvoTywY8Y8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ed987bb-3da8-49e6-b90e-08d9d5d20a53
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 13:47:14.4305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K9BR4gGtfs6Ym1fHplf5U+iLO/lG9jpZbZ0n1ZzxzPh6z9VbjQX+fxbzZoeQDMY+NFJ8XP+lIfYk+JyQNLSvgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4136
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PEP8 recommends that all code should be indented in 4-space units. This
guideline is described here:

https://www.python.org/dev/peps/pep-0008/#indentation

Previously git-p4 had multiple cases where code was indented with a
non-multiple of 4-spaces. This patch fixes each of these.

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index cdf64df2b5..5fb3e09875 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -950,12 +950,12 @@ def extractLogMessageFromGitCommit(commit):
     ## fixme: title is first line of commit, not 1st paragraph.
     foundTitle = False
     for log in read_pipe_lines(["git", "cat-file", "commit", commit]):
-       if not foundTitle:
-           if len(log) == 1:
-               foundTitle = True
-           continue
+        if not foundTitle:
+            if len(log) == 1:
+                foundTitle = True
+            continue
 
-       logMessage += log
+        logMessage += log
     return logMessage
 
 
@@ -1167,7 +1167,7 @@ def createOrUpdateBranchesFromOrigin(localRefPrefix = "refs/remotes/p4/", silent
 
 
 def originP4BranchesExist():
-        return gitBranchExists("origin") or gitBranchExists("origin/p4") or gitBranchExists("origin/p4/master")
+    return gitBranchExists("origin") or gitBranchExists("origin/p4") or gitBranchExists("origin/p4/master")
 
 
 def p4ParseNumericChangeRange(parts):
@@ -2188,7 +2188,7 @@ def applyCommit(self, id):
         submitTemplate = self.prepareLogMessage(template, logMessage, jobs)
 
         if self.preserveUser:
-           submitTemplate += "\n######## Actual user %s, modified after commit\n" % p4User
+            submitTemplate += "\n######## Actual user %s, modified after commit\n" % p4User
 
         if self.checkAuthorship and not self.p4UserIsMe(p4User):
             submitTemplate += "######## git author %s does not match your p4 account.\n" % gitEmail
@@ -2637,7 +2637,7 @@ def run(self, args):
 
         # exit with error unless everything applied perfectly
         if len(commits) != len(applied):
-                sys.exit(1)
+            sys.exit(1)
 
         return True
 
@@ -3472,7 +3472,7 @@ def guessProjectName(self):
                 p = p[:-1]
             p = p[p.strip().rfind("/") + 1:]
             if not p.endswith("/"):
-               p += "/"
+                p += "/"
             return p
 
     def getBranchMapping(self):
-- 
2.34.1

