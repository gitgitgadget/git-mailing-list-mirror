Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7932C4332F
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 14:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236944AbhLQOGZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 09:06:25 -0500
Received: from mail-dm6nam11on2049.outbound.protection.outlook.com ([40.107.223.49]:17684
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236815AbhLQOGV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 09:06:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=crsAlMnb6032Qq0YbpEVwhlwaYHkcDUBMB8NdedxyMzP3FbNccHAONrr2SflIEkK7QGZq2jiT2FC2zM3u8wiZvn5RexeOGzoFCdZ4BsddACUVwNZmQluHOp5znhg8/etudKio1sdMwOI7PrOxhw72LXnI+DuzyZNTfbCWxO2WaEw0e9h/0b+bCvY1AO+/HbBcAzR0LQ7xBVcO2AoLhuNKHQk2M3BEOUtqk6kGZeyrs47xQhrXq6GugA0ovsZkI5ozNYRDDvL0d6zbFXTXe4Exg2RflHJ6GdWY5Bt+0yTU5cgwprPRGjvzpxaq1BKw59uawoOOXFJ1XFmbMlNdDEy6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yBifl8jR36tlI5uIi7mUgKdGghu/TlDJsc02+LQmmbI=;
 b=UEbjEkdWQk646333aV60nNUiGbRa2NRAoVVlw31+CeOKmdFRMQHxdK5F4QhINsHsTvGKPobtkMQml0OQo+In45KEVX7rV8MDywdTzLc8/eetEHhxacgvxvvJvIWdJ6sdJsQQoobW5G+y2Y7bZ5m4gdThJwuZXYyjEVe4YU7zpRv1ZIAq5g09xbgRCDLQ5xf4s+fvJhE+NztFVmQAiiFIzwpBuUKOd3pjDpS4sKsb+tyjGpfjbiHfOJzO5h4PZo1nheO8SLFma61ho8DBtXNh4SJUnw6+EDznGJnjKBMZMhT5uq9FHMqUFO3xX3NYZQ4plGBg154yjWtosvhoBnEQsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yBifl8jR36tlI5uIi7mUgKdGghu/TlDJsc02+LQmmbI=;
 b=LVEcRalRyYct/VEiiy3T+9CcDxEP67D2t3EQZHaMH6bteN3U+o31gt80VmEKNLgZi+CFLTpMRJ61YujjMUDaNf7HlKaxRxtNyFmFxASYULPLAwHT0axgsQFT9TPV4g9h53vic2jNippTmN2AOeISB7XWLyXdk37VyU2sydcNDTqRUWgx68x+5GSzh2feuKL2yLk13SJYO0JaY3b3nPAKd4ZxGU26Zpo7bGJFczsJR5H/vRHX5dh0ttUMzj8IVULznb+u6MbknnKr+CVeQcmLhnifDQtWkJd+NtYg2LuyXTWiT+9WDueA0rjIGMtPV9CfrKR/midy/TBDvjF42FFsOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB3361.namprd12.prod.outlook.com (2603:10b6:408:67::19)
 by BN6PR12MB1250.namprd12.prod.outlook.com (2603:10b6:404:17::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Fri, 17 Dec
 2021 14:06:19 +0000
Received: from BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592]) by BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592%3]) with mapi id 15.20.4778.018; Fri, 17 Dec 2021
 14:06:19 +0000
From:   Joel Holdsworth <jholdsworth@nvidia.com>
To:     git@vger.kernel.org
Cc:     Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Luke Diamand <luke@diamand.org>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>,
        Joel Holdsworth <jholdsworth@nvidia.com>
Subject: [PATCH v2 1/2] git-p4: remove "delete" verb
Date:   Fri, 17 Dec 2021 14:05:46 +0000
Message-Id: <20211217140547.2115095-2-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211217140547.2115095-1-jholdsworth@nvidia.com>
References: <20211217140547.2115095-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0128.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::45) To BN8PR12MB3361.namprd12.prod.outlook.com
 (2603:10b6:408:67::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48650ec1-fb3f-4df2-116c-08d9c16665ee
X-MS-TrafficTypeDiagnostic: BN6PR12MB1250:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB12505EC1C2B7060485B40C5EC8789@BN6PR12MB1250.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:626;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MjaZ9YkXopUO21V2J7DBQ7yz+4Sx4k/nJAuKB0U5I61p0MTPxUQLK6vyUnVFw9n2KIVJoYlZlrGSzPUbFWQ9AJhsp89+auVI89o7SIxZ+lXz7aVtIVD+MEJAgjoruuDqXcKMe8D3IkKZeT444tvAVqWznJmdloEm7CbAi/TnfVkBl8PzJ0leKDEqUFvJuA3a7BpvYMdy60Xikd27BJ6OiCjEmGsnOvKCPbQCtsw2zM2U4lKMKBgnUMbcUkzkpNbmB9OXoV62aIpmPScL4z8zPEPDM5pDXfvhg8VFdNaxGgnv9X6pff6m2GNC7t0nOncY2rxANRu20QNPwO0dPr8jrzQrr9NGUif/6XryCvySXA9Ta3SfTrtqR5k2HMm5PUL9u0fWc4IKkeaQLC8DJar78NbiW111tlAH5rSDW4cCKO1HAa4+YcERXscDRxrrOvlGiuKhXUEO/deklVtEP+RG4TZWqxwXTt/EOEuZwRFbhTCMcidJgx+7pAs+AcCcYoUHOZQREK5XbiMtHicnAj76X9dg6LJDiHsSPj/EJyWe4qHwRoI0lk0hFbqkc+7hS8vVIDjcpMEZf943/SirNM+jGnYPSG+2UnWYeBlbWbWk+zK+nuGyUBZZI8GUjY5027ElJcXgoJL5uFwu/7wekWZvrip7YmGNABjHPogHvf2RQ/uacZvSBCVSyt7qfjXTJaYjZCoMaWuD9tghHnmO2m4qTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3361.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38350700002)(38100700002)(8676002)(83380400001)(66946007)(6916009)(66476007)(36756003)(1076003)(6666004)(186003)(2906002)(8936002)(66556008)(107886003)(5660300002)(2616005)(6486002)(55236004)(6506007)(26005)(52116002)(4326008)(6512007)(86362001)(316002)(54906003)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bN29ZVcg2Gz3Xg9WTaoagvHRzOnO0qnDnFOf1cXa41ZHXbk25j1yasbkmoMt?=
 =?us-ascii?Q?Tt13VCWE7pBt2cp5Rn0nHmXCbZHS3mzIukTbftGgmj1UusTj8IshqaRnO46V?=
 =?us-ascii?Q?43isORGz7e1R4MG6ua2jJOT6vwxDPKIyMKmYjEaRmuFi6L4E5WxPtUVVLDrN?=
 =?us-ascii?Q?eC4qPcV2OB7Ki6fjvYqC8X3admIjcN7cR51kRpydBLJSaBjbzbkeOaNGmQOF?=
 =?us-ascii?Q?fcHp6dGycK0rsM+jktZLr1ILXu4Rhw3cGr5djR9cC9XaODJ0w0ZmkZeqYhOE?=
 =?us-ascii?Q?Fo9Yw0ruNfMM3cJLKiGjD7og3fhBuz5DEF9ySPqBEufNO29MH1PMcf4rvDJK?=
 =?us-ascii?Q?uYDPkeH7MI/0qFzl6sK52GvZEEtcVeYEPpNN6ZwfJIlmtb3KzTK4mT6+RC0o?=
 =?us-ascii?Q?zgk+UUbWQiEQPpF4wYEqKgEzASLvA8FCEBeW2/uubH4TZoN/aJ+2pAn4PjQf?=
 =?us-ascii?Q?DQPK8eQQCX+0AwOpMPPSmkMS4Mv+D1f/l8gt2RyD6rU7yHs67RMjRQtnyP3k?=
 =?us-ascii?Q?InlrTtU///QzOxVXDsLsvkJV5gjEplrNBjL82Ini8VhEvFUC+u/Ss88Mz/12?=
 =?us-ascii?Q?2+okW1UZMg4HroLhFq9xR0BAj2r4ye3gdLBABZWKG8zV1dKkfuXC81PhR7iq?=
 =?us-ascii?Q?jXFXaMcYFz+Ug3g3ch3W7Wk6zullwbCzOQXvN0g45JU0mHGME/8D31lO/Q/x?=
 =?us-ascii?Q?snbkELkCM7VU0W+lJ2/arlXYk26FYhCyoy5B7WfvuBd70Xo1fHeg2GhhOqX5?=
 =?us-ascii?Q?7s1PGczf4EB13DpyfuzYeFqG5dh+UgKLr0EIpvPKk2zwCxJZWBdpCK4QqYHH?=
 =?us-ascii?Q?lXaSL6zutBw5m1ewH4OxD/yVu0zPF6UXwZ8pTrdEhZXvyXM1cXcfIb/fo9Hv?=
 =?us-ascii?Q?dkIaV1D2a+8ZuA2sApVIvzVOwJ5ypnW8bKt/rFNfVHbnkZjiwbc/Topb6m6n?=
 =?us-ascii?Q?fKHir41C70mCtufZU7G0NBxsGfxY2oDxrpxQUcwjnL8aeC6gykUQV4xDE1Tx?=
 =?us-ascii?Q?s0vLaCI0cdj8xuJeQfKzyGDO4KzkC9VymhLjmpEeLz4Zj8F0cG5Gzcxjpnve?=
 =?us-ascii?Q?B0skSXRMs9ggEWA2ZA38i2fZIMGF4ui6Gnl60VXAPptlX5E94m5ALIpYVf+l?=
 =?us-ascii?Q?MeS7bHZx867aWKRye0u6b9kEeaNajHUgOfK2b4SfCrDOGn8bdQypzQ13eBlm?=
 =?us-ascii?Q?HgyniVzPd07wFbqZBVnMmSSvbG9x4rMoIWAihRLwp6KZri6uv0zwSFrDjgDt?=
 =?us-ascii?Q?jtRfwFwUs94R0BixirrKW07Wi2W9j3i1Vbs6shWjslENeSZN1Qt18KZd7QQA?=
 =?us-ascii?Q?wTYBy7nIbh48hZZ8susuOXNI1IdNL0PnjyOsOrxYDAoOHvxrw1lat3bBaWwg?=
 =?us-ascii?Q?J5zOP4PbKTjLkAqZv28eFV1E00P8tgyG/9VFgniBaJX2nOxqUS7ATGfr6VhE?=
 =?us-ascii?Q?+SAzjQ9ij62RiFEp7fLOcYGdUNOnK059NWvaEnXu6pQVW1/gbFwZQxuwLAyY?=
 =?us-ascii?Q?2VgeFCuXG2DQ2tJhD4V4nMdLsRpI9KKXc0W582C+AguRd5Xvpyhb/auMrz/x?=
 =?us-ascii?Q?nw+FwOAvKX0uXk1JScIsanafuwI0Og/Z1TbSYPF5eIkOr7lF4MB2qZCwifWc?=
 =?us-ascii?Q?/ssi7c4eBSm07W+xI/zT+w0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48650ec1-fb3f-4df2-116c-08d9c16665ee
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3361.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 14:06:19.2760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OHaUoUBXTYq5LdznhUDP890/G1UhZsP3iyWrT2nCSiLHE/PzUkKx6bHfoP0oh7ol7itTnQK2ubneLGbdQXRu+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1250
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The git-p4 "delete" verb is described as "A tool to debug the output of
p4 -G". However, the implementation provided is of no useful benefit to
either users or developers.

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
Adds Signed-off-by tag

 git-p4.py | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 2b4500226a..b7ed8e41ff 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1532,21 +1532,6 @@ def loadUserMapFromCache(self):
         except IOError:
             self.getUserMapFromPerforceServer()
 
-class P4Debug(Command):
-    def __init__(self):
-        Command.__init__(self)
-        self.options = []
-        self.description = "A tool to debug the output of p4 -G."
-        self.needsGit = False
-
-    def run(self, args):
-        j = 0
-        for output in p4CmdList(args):
-            print('Element: %d' % j)
-            j += 1
-            print(output)
-        return True
-
 class P4RollBack(Command):
     def __init__(self):
         Command.__init__(self)
@@ -4363,7 +4348,6 @@ def printUsage(commands):
     print("")
 
 commands = {
-    "debug" : P4Debug,
     "submit" : P4Submit,
     "commit" : P4Submit,
     "sync" : P4Sync,
-- 
2.34.1

