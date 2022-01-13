Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0334CC433EF
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 13:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235490AbiAMNsP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 08:48:15 -0500
Received: from mail-mw2nam12on2069.outbound.protection.outlook.com ([40.107.244.69]:26926
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235480AbiAMNsH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 08:48:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NmKksRKpJkYd5kC0PumiqAwTPJKJseergqb8Uveep3/mxQ7ONYcgMjHLx79QmwdNEL+M5gdcZOyoew5WNtRtnDUKJ0pSul5SP4y7oDv5vTSJVlv68Welyuc2RSYRNRa5ZGJlRkbpb3THr3YM+sv8bnA42MUoqbbVVZXjMrLASPYWAWenfwCLwVC7kIFLjjJpq7PEjEVHsl2qXWRdIIRIncrw9OFBN72R9Wr8XGsQzHW7C4KDP3x2VDcabuGC0QZbBGzEPslFGRo7pvoW6wXdMMsU3FPm5khOdCXQM2/MHoXxMabsq6DXsUe4Q/7oh+0KY5tZkpMxBnxQl6sj1pCwgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifBCojCXDHgbNxeNyfSOL4Sp3EosjyB1Y071Ejs4SSg=;
 b=JMictTVGwGlkBZr0eJgM9Fs659AlRkfsY1THiAPWw/m3ziI/zzuiNc/ajHDqltQjI8bVtJeYLgIBd4AHCFbBV+uUJ1+4Ib1kb26lxgo5uR5EFFRRu+EgNsTWboXV7SHtu89CP798HrF8Q/al3aQDB3LfvaXfVcZjI85DrVNiDSTDT/z1IJ55PYtEcA1xNwKKs5V5jlOMw1MabIrS8oY80oxrSlpRGG8cw2rNy9Tw9x0M531PS3fnuXwJOlsMtZwj26GLPnvXdhWe8vZ1aH3QVGLLzOElbsEsmma8SOiMmFmFI0W0t877agrVpeOOmCa4aCoLZrLggsbi2aaVtYXwhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifBCojCXDHgbNxeNyfSOL4Sp3EosjyB1Y071Ejs4SSg=;
 b=JTVb7Ycduc3HJHos/fKDtp3bkersIY3wzSDGqbeJnR+xE4eLf0BeC1RNzEMvv53IhsaRyOLXEykPcMTy0o893SLPYqgsSHsj3+Ho7JajT3qg8tALi9h7ZPjQtUYGuqZfGptnNhx5O6603r5lMQoiaQPWpU8n6JTr3qqsCk0pRI/VrXS+stPw043wWG7lvlNX3h6jgJf8ENQDN539H34kxFC0lJeTyWWLQaxjTAKp2f84SVC4PzM4Q4897wuXFGkLLrDJFyzM9RidkQwh5B1wHYzW5HtYB+hNAMNj/wBs35qHJTeaw4C7a2CyjCYdvwdj51vK33V19guX3bhbe3uEYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by SN1PR12MB2447.namprd12.prod.outlook.com (2603:10b6:802:27::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Thu, 13 Jan
 2022 13:48:05 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed%4]) with mapi id 15.20.4888.011; Thu, 13 Jan 2022
 13:48:05 +0000
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
Subject: [PATCH v2 03/21] git-p4: indent with 4-spaces
Date:   Thu, 13 Jan 2022 13:47:10 +0000
Message-Id: <20220113134728.23192-4-jholdsworth@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 153de589-87d1-4a44-8133-08d9d69b5308
X-MS-TrafficTypeDiagnostic: SN1PR12MB2447:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB24475669879F422BC5343820C8539@SN1PR12MB2447.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:95;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AodhBLxfNRCHUWeolWfgoylu2DaYFN5REPV55JBJcwVRs0ToFXJY2D5iKepl76bGHQ0oEVCWvdJ4MiNItlvW0qoxGIEqs3rEY/25PQjnYSOgo006WgDXoi6VBdnEh7LLrXStyz8YZQgeM5QGzEhVN6q3qcnOPvifq/JTfj+/kYcyUbU8Dkr4GTt9X2S+bY/5Nd6l0PMpGsEaMkFstjUqpl8nyChTJIWah8gVh9o6RV8t9JGfNa1fNGogK4mNTSDblRqZW9MW8AArebjSAMXHuG0k4TotpvfwWMIF7wydUPi16Lx0mZ+ZMsg2znAzfmVf7SjodSxL9ZUz5ADmuGA82ZaFqSC9IXTuRKKfHQK9pJVarip7BD+ezF+PUmN5ZOpOdK6ew8RT/fG2XdUmk7g4LRRMmMrUDDIPpsv2rtjuDTAfC4NozV1i77D6ldePWSzjMdVPxguu0T0UZ8kOunz+Rt+E004SL8UfMBo+Ql0h434YwhFQ0zdVj+o1SYFwc8AB283JC3IyeydL1qmdxkDVTHowxCM9ozEOlnVcDW/vpxQUQ0Wuad4e+TpxkOPQ1mKntRVQ5ESfyK0xqapfdlBTsm8fSec6rgnya9/8wQuZZDkCvgbBCBrIcmZT1GSPXAtd7wOIN8r8/GJAxasDyRv8j+ePtx7vcYMmtstTOwWzQcQ5m4Spo4a86IylXRw0a0eeim3K0ys9e/2LtA0pU+nuF2VEPsdfRTxktSUU1ggjEQZV4HIKuYwWGWkRTELIROflZRNNsZmaVCo/ilIfRW7EGoNek+sAyDlJ/cUp7VG1Byc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(1076003)(8676002)(66946007)(8936002)(26005)(83380400001)(55236004)(2616005)(4326008)(107886003)(6512007)(6666004)(36756003)(6486002)(186003)(54906003)(316002)(38350700002)(110136005)(38100700002)(7416002)(966005)(508600001)(66556008)(5660300002)(6506007)(2906002)(52116002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h3nSciJ4/mJHmysSvr8Pl5T5bfDTwIV5wni7n8vePxaJxyd/DvhxOn8Kcajq?=
 =?us-ascii?Q?e1l4x0lki9FDhO2mlgijyooNl9fvq2YIB0W+upaTuCoK2yOeJJQ9LUmrLiGV?=
 =?us-ascii?Q?EuPcegqNomNRiyGAndb404oWaq0+tnIkjqRAPtnY4cLhaGw6nAcaRwcoh+iT?=
 =?us-ascii?Q?0JjDiQdCztlP61yE/hq1SEmLYCUZPS/AUoctYRaiE/pyWTXf6YGaiAIQcYK1?=
 =?us-ascii?Q?LTEl1vRxCsqzmPI2LdWwvdHPTcmHOlNDeOxV8ZDFzfaywlU47Bb2IBcbrnUX?=
 =?us-ascii?Q?vauH3SS4BcvdV/kKnB8mqI0/D05NPEEtOAdYPbU43MAOAB3hQv+vbJQwTtvK?=
 =?us-ascii?Q?amnRmYLO7h3cSHHdXHUHZSDv0G90HyETeF20lFwRhlCk8DAeoVxhSMSKDpTt?=
 =?us-ascii?Q?LuGuRTCiCsQKaN//iEz4vgvWu27hx+7vlJ8L0LTt8uEDPDihSflKewVuYxIu?=
 =?us-ascii?Q?SfvynSTIAsLbT6NSO6k5zVyycmSuZ6MB2CWKDwBuusmYWzFzo49bhe0dC/cx?=
 =?us-ascii?Q?b4RU3yV5n2U38gcCuK24fwKsVCx7V/yZ90liub8q9WhqH3SffqmQw1n+a09F?=
 =?us-ascii?Q?bVUKU7qhcoSkdzS8BajHsrJRFkuOVY3bXYpCPMtuemo3oBiDN/t0zU/kwS05?=
 =?us-ascii?Q?vTJM1QH5VgCw3DWjexy0AMaQ9p5Kfuv20DwOlAKbvK7xIGDqdgNkw4/x53B9?=
 =?us-ascii?Q?eA9fj5UYj+lR93rXHBs+J3Mrwh4+igQlYh9J9HBIh4ueA3ifPNlTf7x3Mf2Z?=
 =?us-ascii?Q?Bh142giz2N6UXA5mcCVh6g70fwONNcfsWBMlJFNSocYjmu2/yDpCdtKO6CM4?=
 =?us-ascii?Q?qhkqZ2ela+DZXfn7I19zubAHUiLbx9Eq6ogZ7AsYzLya2rkr6a4XE0Vk8oVs?=
 =?us-ascii?Q?7RQKyaA3PLsd/SdoI0IbofFRj3v5E+6DcatVDhrxzZ8VT+Teax9wST88SSHD?=
 =?us-ascii?Q?ZUPwlXhXvzHL05t2ezgihtKzqGn95VOGHgjTNRVOIT713Qnae+4X0zuwVbPi?=
 =?us-ascii?Q?C+PjTRytcX4lluBPftLkNavQ41LXhQ/EFzqvoc19v9eDJJzbEgdVTPdjCtpe?=
 =?us-ascii?Q?S3BnUAUSUFkpt8OuzOi/ZkEi5wbBAqPSMU+J6SjQDUh4WK6Y2TIyLp84zl8t?=
 =?us-ascii?Q?3na3BZTB4SmhDyZk/X7Vliva+RgyLzUQ1RnE+a9mjtD1XOx/1ke1r8RqDxT7?=
 =?us-ascii?Q?odmnqOXvAVysfY/2+CrRkP5idN3OtS8Rfk1iGvThdPdaz62RyiDv0B/OROaH?=
 =?us-ascii?Q?72K6z1VMGyXqbP79urUlGN0CEJxN9qCFZXEHZ5DzeObHgKL6Q/XmiTyHy+PD?=
 =?us-ascii?Q?xJzgFfkbWLsHJPgyO3uhpp38p8kfUOyEyj5dz5fOwt75Ldfz4rUIzp20orvh?=
 =?us-ascii?Q?LA7yf9VgShCkW94Uk6gdLopGxMeHriCE7jpwblkc74hguRXwg+3AoFN4KhVw?=
 =?us-ascii?Q?QV040Znv85Uu6LpHQINcMMenqYp+wfHVnTdjOOHeYTz/j7Y/Ah00ggIk8o31?=
 =?us-ascii?Q?4Bc8Szb3ztLRXD8IuLJxTGjWrXVzmLAdztDDdEqfC590IESHpGyZ6T/eREKO?=
 =?us-ascii?Q?8myLOKz0JZEb1e6XUsMAYQlgsufVL7kuvz7xFR1CGZZL8Z8vNv5dyPBDcIai?=
 =?us-ascii?Q?Aen3AZYqSb5GEzEP8q5i9sQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 153de589-87d1-4a44-8133-08d9d69b5308
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 13:48:05.2539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E/0vWxViyEbXtJDLhzN6mvFVP0nNneIwla+d+CfS88P1Zz/ioQZXOEmWB/W9j94uOlNVMG9n331IdvippDiGXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2447
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

