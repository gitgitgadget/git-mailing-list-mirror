Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F332EC433FE
	for <git@archiver.kernel.org>; Sun, 16 Jan 2022 16:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235546AbiAPQHX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Jan 2022 11:07:23 -0500
Received: from mail-bn7nam10on2045.outbound.protection.outlook.com ([40.107.92.45]:27873
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233455AbiAPQHV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jan 2022 11:07:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h4Gmkd3Pd0jMbGEgVZ1O9enDsoo2z6xeXgqtNDvlxqWA91ihlYfmr6zcSjClUnLqAcNPHJlD9zH0SV03zNnSLhZP77jhhnTdfzaYn/QERKC8Pmkm5DJ9uJDJ9a9ZHLIJPkZHZBtV9VjEzEOkSy20KHsFuffLMag+oPdai0KEjIFsOz8fCEr/DODuF9Xo0sJ76Z8xuDP8Poa9S4eLGzYVGZhlzemc4nqFFLjrn2+gjf+HNn4d34EcaTDOEmnshJWA6YYyzeIjgq04cmPSCD7LGoPP5BFpn6+ytwaU536bL4eZu2NVhktK0/m9M+giTsKYAw/5jH91w9sJ+V2urO9mIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QepGtwCHHsSnxvFhb8K3n1sSSDgsdlEFQinxxbdGnDY=;
 b=Wl+E8A1c0Rc9kYh/WP/R8ufGWeK9XMu9WrOQu/6AeHDxnbk6hSzB7HUYeKvuqxUHrG4Rs/w6qC0Cl/Dw866LuY6Ji3p9UL7X3gNJcyvsuVZ0zDjNM1LzNRzl+90r6noU+MDiHV5AOOnwWXK5K7wQybsJQhDFQhTJbSyzpaggvIylaqvE+PKQS0lPx3m68PI6Z7nXf0Ug3MZ8GvbTYm4SG0vSsktP4dU09m+749/AX6q4ixyIIRj2nDexxzF2hTZTgUAu7lX1uJOKMOMRG1VvqLKgO6KRYb1g7PlHFB+aQIA88IWItL8jncOj6or+iRR+IQ5Kw1sxCNp9xs+tpoWUrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QepGtwCHHsSnxvFhb8K3n1sSSDgsdlEFQinxxbdGnDY=;
 b=l031T4Na1j+bAGu7NBJy8Gb2xJmZJHFzWlisrzbyqncayquY6+Vq/BRicXE6opJvgXPG7qqIuxLfZR4Lw0IFpw99K4ljhs6KwAcJ9iJVKK6qBbRbVNjv2PKAOa4nSTIaLeMhC8gJfssegHLVjS24xFEg0GBlcBKGpFDUrbeoon45c8ztmjFJqk4acoqvzoxO5xBZq+bMJxaP4Dnhpi1xJO5iULS5SQjNcUBmbEspEQHZOSnct1emi8R1uEa3NEPmQ5xvUuduiTtkGiyAd5FBvnUWgRbEWMa9fKdB5mcsVrQp9ZIytmA8w8mKcMVxk9GwlUJJnZRo++I5N2f7N5qI3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by MN2PR12MB3088.namprd12.prod.outlook.com (2603:10b6:208:c4::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Sun, 16 Jan
 2022 16:07:20 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed%4]) with mapi id 15.20.4888.013; Sun, 16 Jan 2022
 16:07:20 +0000
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
Subject: [PATCH v3 03/21] git-p4: indent with 4-spaces
Date:   Sun, 16 Jan 2022 16:05:32 +0000
Message-Id: <20220116160550.514637-4-jholdsworth@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 90dfefa3-6a98-4cb1-5b71-08d9d90a4604
X-MS-TrafficTypeDiagnostic: MN2PR12MB3088:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB308873C86B4DF261BFA1763EC8569@MN2PR12MB3088.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:95;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G//S7tz+ktLhrdqwVwxN775deBika19jRdOOvbP/LIDilZrIibGR38yIkARP/k5/22sZmA0GLK8vrCTBpFnXFaIkc2pS/PumhGcyc+9+eltMAOL+DCK2kwhzZkhmzoscbJGvQVIXMrWvAHYtsGwN9G0vqhPdeIUrbr8c5v3PHGGZf40KRNyjflBB9PokBIRwS76b2ZR46ud7rF0Bdg5HhAMHnknTxThoLdNGFaH00QIY6eVyqPrT/Lxw97x1cUdaNletAbVuAxjDR/T8vhzOZQvmf39WGaZGtg4PfnSs3VkxaI9k2sZNqYOVcQ0i+NEfGkCHrypB6pgM1IQEWcXFmtvwhNQnc8XZGFXOmhaIOBgs98LACs2qeU4M1PeFfcqtZTcXlK8XcxUX45cTyWftlLqlbeDS779oUY1vkTNVKp6InJrzdShKkaMXeLxFdJQ7qeM82ddlk4MC5jciXtxjJw1L0VXUzVh0wU2wv8Y8/SwFuZwzr3HdVLxQi//Cbkg3efwWHkqCfnk/rccNaT1gPsAJ31hgPMJzc9qExUTHM8hv2FddD+wzyrHBObAOkeHkHDEn49zTPJOo8smbTPRvtUzgamlX3K3t4YLioiETlLYm1gfBN5FxB1ywQat0gRuCCmB4mKhz+DWqSVB96LHhMB7eykze66g1Wj0xr/tTHIOIDkuRCt6ST6yYtJDfysJMFf1EcsZGuBPZlZiMTfcJ5FhCSmc7pyRCQJliuYKyfIZ0ffS2AbbrxpUqRpikH+PlJ0xd++WM57ItJeJFo64fvJZ6aaC8td/pkVjLTOqNAi0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(36756003)(54906003)(107886003)(7416002)(110136005)(83380400001)(2906002)(186003)(52116002)(38100700002)(316002)(6486002)(8936002)(38350700002)(2616005)(4326008)(8676002)(6512007)(5660300002)(66946007)(508600001)(86362001)(55236004)(1076003)(26005)(66556008)(66476007)(966005)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9fxZjoNXbCYspC1wRXBjJ317YOSyZEFRqc5IN0D5my6P4pqW0avbiiuMyj63?=
 =?us-ascii?Q?Q282/FaUNL0M1j/goTqJ+yR5s2Jaj53oqMRvEoDVtlmkv0aMNj0a9UTW98Sl?=
 =?us-ascii?Q?FWzA/T4GN+cXb3QbkRtiapRrGMjkXAWJX/yJI8Dt+N3ByqAmWRFt3jKMYrin?=
 =?us-ascii?Q?WczkR43LDB0oZqQvTrF/gaJD/O9EuAOqQBTdI48nX7GnuDnVbJjpgxrn4YAf?=
 =?us-ascii?Q?leE2D9qH33wNF0PoeAqHKVskLF4YAzNfCyKWn7E1lx3NHYy2EpUkM2Xz0NNB?=
 =?us-ascii?Q?UH43R3KVOf6k68xZDA+ZRt/a9jz3Z5Ucsdi8sZH3dB0rHHSx1rwrb/puupy5?=
 =?us-ascii?Q?llhJjAu8bn4L4iCJyM/OHY49xwvuCcWpYK5hqJTjzSO5ZxsUe+bc8IRpgeHJ?=
 =?us-ascii?Q?HBPW2OFyVqOINZ/8XhShIVJocu1ittdcM46XdSFArt5v5yfgKeuZZIzAZ2RC?=
 =?us-ascii?Q?rl0n+3t9a3NIj/gyV6TZ1fZSyY3h4k0kukRLmuOJQ03M/8A2G4wF89wgGIX8?=
 =?us-ascii?Q?aPJTTHrRRxIF1fOyVzVwMkLluAL25+xMDPUT1CiK2SeLNPkdyxGNY5vXN8Xa?=
 =?us-ascii?Q?CuIJtjNEBFOs+/lcl0IhNOLIE55hVbmyD/G30+xsUOaDJyIhUhF3k0honvV/?=
 =?us-ascii?Q?oXlSaLAdchyxpbVMCYULkUnWNa+JvNPtH5/7EYkpkrYolBcVLeimxBGKYQEs?=
 =?us-ascii?Q?fgB67TI3QIR3f9XbbPq/mclZR2VqQ1kDfpvG032rR1fmc3Z8Bk4Aj+UOryHI?=
 =?us-ascii?Q?fzUWAixK3/MgH33gU2e65SqmCndJ9xeXUEA+dPrR/ezITkxDyHgigs7kmG5t?=
 =?us-ascii?Q?nDBNhw9OstweWx29uizDoCNi97euMzpX4CwQ3/cdDL64zn19NkPc/YS/V2HU?=
 =?us-ascii?Q?pOmK5NA/yY6xZ7MKONH/6KMjFq+AsEz43FPQwE34czPrU8yZw6EY2fwTDtyO?=
 =?us-ascii?Q?yKFRgwYdfs8fkY04kw94CJXpdn0lvHTKWymAStd4zq9Vz9ny+1+z2qn9OELK?=
 =?us-ascii?Q?y4Vlc0BxHmmOus7L7gVhdsQ2oHICIIR2EhfQTLTUeKg8WcSjOkA146oWTVaz?=
 =?us-ascii?Q?EpmgAWqGh6SaWquQFXsEH1eECSCusO9j1Y5UYwajOOMBL5fU/Etdz76KCW1z?=
 =?us-ascii?Q?oQVgoxzlTrCodBchkf5qaRL/92uHBYZH9yGVLy1mcN30FaFNcgrf+zbpyryT?=
 =?us-ascii?Q?C+anLGaqeqh7788ionw9nzSZgQ7yV+iuB4BW1e2a7aHy89V8Svrc7dWkM0nF?=
 =?us-ascii?Q?ipHa7TK6UDBvkwp/9JQlvfMnvXwjhI5+XDRcS9fIyJfPh8GGtDAIbegSrmeo?=
 =?us-ascii?Q?O/CzjmLv9/am/TEJj3LnMuJrG9MU2O6PiWmzLmZvL96VOyAbPm+zzozq3nPa?=
 =?us-ascii?Q?PiGK0q9kjai5ZPeHvezowLdruqcoQVf+B4goqfYV2by6Vyn4iRPVcH8YHuA0?=
 =?us-ascii?Q?FzcNiOMIrITc/Q1ifnSWpsXFimwc5Gtsxs1iju/PREPPZKq9V/4SokWevetC?=
 =?us-ascii?Q?ApigtFNYe9L3x18MmgLmrjYC3v3BqvEWFG/eWRj0urobQ8+u04wnXCaknb6i?=
 =?us-ascii?Q?BK1m0UaRf2SQhle3iyXquHYEqJ3MzGymQxCf+XAPNJtVyqsasjtl4AIuZu2u?=
 =?us-ascii?Q?NevrYMZoUMrhn2If/sC4CCk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90dfefa3-6a98-4cb1-5b71-08d9d90a4604
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2022 16:07:19.9257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JmxryOyxJNPLnFsrUqhakB9USlw7A8iTOIJ8Xsc/YL1J4AqtS89ugbM4Nidl4LuAMb1Strdk3sAwOvyQyEJYlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3088
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
index 3d30a71d1e..eceda0fb76 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -935,12 +935,12 @@ def extractLogMessageFromGitCommit(commit):
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
 
 
@@ -1152,7 +1152,7 @@ def createOrUpdateBranchesFromOrigin(localRefPrefix = "refs/remotes/p4/", silent
 
 
 def originP4BranchesExist():
-        return gitBranchExists("origin") or gitBranchExists("origin/p4") or gitBranchExists("origin/p4/master")
+    return gitBranchExists("origin") or gitBranchExists("origin/p4") or gitBranchExists("origin/p4/master")
 
 
 def p4ParseNumericChangeRange(parts):
@@ -2174,7 +2174,7 @@ def applyCommit(self, id):
         submitTemplate = self.prepareLogMessage(template, logMessage, jobs)
 
         if self.preserveUser:
-           submitTemplate += "\n######## Actual user %s, modified after commit\n" % p4User
+            submitTemplate += "\n######## Actual user %s, modified after commit\n" % p4User
 
         if self.checkAuthorship and not self.p4UserIsMe(p4User):
             submitTemplate += "######## git author %s does not match your p4 account.\n" % gitEmail
@@ -2623,7 +2623,7 @@ def run(self, args):
 
         # exit with error unless everything applied perfectly
         if len(commits) != len(applied):
-                sys.exit(1)
+            sys.exit(1)
 
         return True
 
@@ -3459,7 +3459,7 @@ def guessProjectName(self):
                 p = p[:-1]
             p = p[p.strip().rfind("/") + 1:]
             if not p.endswith("/"):
-               p += "/"
+                p += "/"
             return p
 
     def getBranchMapping(self):
-- 
2.34.1

