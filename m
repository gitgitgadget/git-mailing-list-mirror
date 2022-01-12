Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13823C433EF
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 13:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353735AbiALNru (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 08:47:50 -0500
Received: from mail-dm6nam12on2043.outbound.protection.outlook.com ([40.107.243.43]:52832
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1353695AbiALNrW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 08:47:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YhyosaubuJIf1tBeiRTaP3AxlA/GF3nqDRBCsEbkek7H/otie/b07JDmi8f8YR32MX2O/fLo0h1W67v/jBk9VQtPJXUsiYVHjiwZs0UZTkAffmXcN9cFU4QAgOl4Ya8SacwGRFwQfVSgwAUEs3/y+WbrJ0iblMmeg0xoY0R30pLgUtYnIV2bZ04YHtAaRVeWQPzHuCucb0p+jRr6mJiD4WbOYus5J80y1C7uWMAdhgyKlEHzQSATC8Nb2qn9/17gnmy8E5796YCjUS/8fWHu9XhHrxFxPkVcJW6qpOC97eftH+tAIaUJf080MMIfIOOwT4RJ+dkQs6UwOnefcqr9+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GkRlc2ZoKpEbXaKRId3KYl35DXEpVt0xi11ZA/TOGoU=;
 b=iCe6jx9mXdbgtIGAqovu1FirIUcsjvozFWwG/Nt4vV/qjPb06sZrgubjubM57PyUsd9NH0L8AycvnhMHVRlC7nmxDydxXwGEzfVQo2/d/KcXmv5O5Yrz7oeQLo21bxdNnAe2ArQEdZn7qK8rFRAMQ6vIR4/bCus/wOT0rf8BoHmrsgmRiIOVYsp6ROBHU/X/KghePSyEz3+Yo0VNET0e6kQuZgIuEWLZuYCun14EjdIpn0rLXeE/7hiCSXxRaPGmsyBVYLFUvyA2gwJcqTGA4ycQiRFltkOBIicnCby6CJOsaxtKcJ0nhownTLy4opHiOL/MYcCN0aGv5RPjR4mDqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GkRlc2ZoKpEbXaKRId3KYl35DXEpVt0xi11ZA/TOGoU=;
 b=EJCnuHRQLHyk8fWbAEAX13MbPg5deaq6EI5N39/Wvo1j4dMd4ojeDZx9lBl8K763SnwtkYxnpsBa8bhA32nd3EhTSrrONytcDQj2lJtSodou0VVWku1241IScRf70DOwZDgiTy4Ym+bKrVvL8+OxW/H7ydv8WQcLLtWBGECNdKzFEHeTA5GBhlxCqMAsgw4mM63mKpooUGGgp3BupmzQfPNE3AxdHFb41VFI/bhNnvgRpPCJ/ZGGQturbxYBIbzKB1YQrMIqr7ZVePlDIzQUOFYgr6gZeU1HjbM/uelXDjPZE81L2r6+BNChywe5RiwiAzW66OoULnQnCavJXKe5NQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by DM5PR12MB1594.namprd12.prod.outlook.com (2603:10b6:4:e::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.11; Wed, 12 Jan 2022 13:47:20 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed%4]) with mapi id 15.20.4888.010; Wed, 12 Jan 2022
 13:47:20 +0000
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
Subject: [PATCH 06/20] git-p4: remove commented code
Date:   Wed, 12 Jan 2022 13:46:21 +0000
Message-Id: <20220112134635.177877-7-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220112134635.177877-1-jholdsworth@nvidia.com>
References: <20220112134635.177877-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR04CA0137.eurprd04.prod.outlook.com (2603:10a6:207::21)
 To BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11f008b8-3723-4832-b1b1-08d9d5d20de7
X-MS-TrafficTypeDiagnostic: DM5PR12MB1594:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1594D6EBBBBFFE97DAA5EA32C8529@DM5PR12MB1594.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:115;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ydtJeup6OqgxgZOq3AiCRPNlVZ/w6x8NZfNEf7yiRq094kW8y2eXIIXYuAgvEXEA1qsZEpVt22G8fj5RdaY7xxTITVKZGz+QgL9109CTqKmZWoFUKqOcjfzF6VK78ZCJirAffIbflAN4+HlrkQ3RkLHz0iCmUWChiW9yE+rbfOs7tEsWwc7xUtLggCydpGnQqYVUNWEImunj5maKqmtEXigNqaFeO9fPqKGuIidvLDEpHdHaGX9DLNEFSFQS+spgWCBtspkq3zqZdnSYiP18xVw2/22rYtHvI2yEXkyXBKnoOsD+w9RYYjR1IBWVuOoZ462cy00i0T6K2FECBU6QIox1lzpf0m8oQ+fIUPcxSxXTVhHejAYLl95/kLVGCBjAnBO72v7HMZc7Bk5SlyB3e1CG7GTPTFZd7VE1aD7HsiaYtgOy6fnfuK/olYN9lSRmlz7Mp/Tjo2dysQiszxas+oU3OBIb7bU0Qvzpg3DrEnOib24X1YqCnXMoRGgOWUT2YjBxCrNDURWKHvAnsofXQnMH2rh+P0ZfQlLwEGbFnBsK9UUXaBr+hAHHJQNOXJjTxLbaBgew4jQjZtMTJjAX0IFjHLI0lP1R6w1wxLRuLGVW4KxcYDouOfm4WmYmwxDSV2ISOzMZNj05iIRSR+eokw2RmEXkaaCTz9ltgatqU5CqOjoZX8I2vAIiSts8KPWU7CUwTcml0rgVJfFNKYvrKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(5660300002)(1076003)(26005)(38350700002)(2616005)(55236004)(186003)(54906003)(66946007)(52116002)(38100700002)(8936002)(7416002)(83380400001)(8676002)(107886003)(66476007)(6512007)(508600001)(36756003)(316002)(86362001)(6506007)(2906002)(4326008)(110136005)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ybtu6G4e8OeKi7eaHIoGYuP97fR5tEtDyEBQrJs1SI8E4jZVFsRYX73PHK+n?=
 =?us-ascii?Q?0SRYuisQt7L772mvaLIBbimiWJx877+M757iMoUKiBnmRc493OyfnEF5TIFO?=
 =?us-ascii?Q?0vxuUq7e5xkO8rE7XrN1E8GRA2EiL98sci9NUUzrWS/f+uDXC7HZ+CTiipTQ?=
 =?us-ascii?Q?Zl6eSJ0Qhr+NP5OArUiLYakw52UUHUf0v1uj3sTtSVpvDz2MujTWB3rNnz3q?=
 =?us-ascii?Q?7Dl8P9e2G+iZGfUlme628f+C/jifIrUFVFKvaeFPWP28GR2PSEp3mhzX1o2K?=
 =?us-ascii?Q?eU6JS1FD8qkq97fYUVyFLsrAiINGtHKmF0PHfltfVg7ebOHKVMIq/WfIqAQZ?=
 =?us-ascii?Q?RXruLyNAjC7GE48NkiuT3K/ubdeRVEtwOg4ZwkpopYKp/B9zdq7q0SgVBsDv?=
 =?us-ascii?Q?pLWsV8T6QG9X73tawgur1xJoVhHZIW1PA+Z0yEBRyPCzWfLydEEt0y3tkoGw?=
 =?us-ascii?Q?SHltFLMywoQsjLOsEnyiZVylnms+KjLGLl9IgXHSeK15R85EonzdtQxLLazO?=
 =?us-ascii?Q?wV9OIxzCm7V514K+P7QMaN7EKEBMGn8iTBiF/+ptl2B+Si1iIr7Daewq/Rp6?=
 =?us-ascii?Q?avWEk2bpUuC/SRw65r+A26m8kN59yi1zR6U3AQ4xt6kdEs0bvAjVC4TumzxI?=
 =?us-ascii?Q?KmKzK6Sg7v3HKt3gdHjIPm0iVE4RnOuYZy0FNvo2S85TxCUd1iSHhE6hWZB7?=
 =?us-ascii?Q?YeO+oXWOl/7AK6EjzDwNqrFdZcVX8HUgxkFrUweunVXVUkB7k1vi6c5f9jW0?=
 =?us-ascii?Q?Oaw+OFj/NWmsm1fK1epr50rlsUtdQtUd3WDu8R1py8LrKqyD0CCjNpKb86Zj?=
 =?us-ascii?Q?gtVQbpNcZboV2lcET5iZD0GmKbBNKOnK2LpyCQrIJf0XHvrupjaG62ZwDl7J?=
 =?us-ascii?Q?+z/6U/g/H1hl62wVL46czNPDuNQ1DQ+KjJoeBZwIkHzHZNkzCTQko6zkiU9F?=
 =?us-ascii?Q?skeJWz/MqLHD83AnOWLkZoO8fUTDl4jbFG6bhDGazM+LoUKjmcKo0R22l+L+?=
 =?us-ascii?Q?mV1t5iboU5Ofl1ZcxeHLG/g+AeAnqXQO8uGCynEky666cbhrJLOeARTBTaIw?=
 =?us-ascii?Q?pni+qDGpf4piBCzY2r1QktXw0niJfnnTB6vsMOLXtinh/ODb6vw4qGRlJ7jl?=
 =?us-ascii?Q?w1oys5KM3dr4d6eC6jtBXidguxxTjmKjwWVw281voKsoj6Rh0RXIkARZCsSD?=
 =?us-ascii?Q?KnF5FkAfmfWzEzCEC2KBwr3Nl2oWGfkDTIhUPL7aFHb/esfhC1eZZu8fzSEI?=
 =?us-ascii?Q?lvD2oodv64xXIpu2ePCbekG8JX0LzjnZNeet3s/TybqFat/7GZANYe+RZNVn?=
 =?us-ascii?Q?R1QdJF3CJgCNyWXj/PKoSn7rgGd/R3s52VTzYfss17qyMf5RXDeUwssn5nuq?=
 =?us-ascii?Q?Tw4EIv9pf8ju2CjrkXiXMx0AYekCgMJnAdcP/MHu7RqEcUqIsZ9mspoB7bGE?=
 =?us-ascii?Q?2/o6NN8ylLpaoubHLX6KYZgnisIOB23TR5Ua8wFx7keRdq413WRf8FKsUy+x?=
 =?us-ascii?Q?aESUhXSUQBffprTq8CRpFSRzwlen/pu/75/p9XbDA4L+oVpsejx2lFLCLj7Z?=
 =?us-ascii?Q?ZDcGFq8UW5j0/piuGsWbe/OjWqxoWMsab5N6tqLE37Agn7OC1QlC+K8aCiLJ?=
 =?us-ascii?Q?Vndi6t2TGqigwotk1p1406I=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11f008b8-3723-4832-b1b1-08d9d5d20de7
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 13:47:20.3709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: enxa01iqbijPiIj/U2Wv+e2Az2SO43Pbz9/p8WndcgQa0G43Iw+QSNZWlINSUeQaImkek4cjPKt8ElrnzhWJsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1594
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously, the script contained commented code including Python 2 print
statements. Presumably, these were used as a developer aid at some point
in history. However, commented code and therefore this patch removes
them.

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 0bd1ba00ba..ad385d6919 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -3654,23 +3654,18 @@ def importNewBranch(self, branch, maxChange):
         self.gitStream.flush()
         branchPrefix = self.depotPaths[0] + branch + "/"
         range = "@1,%s" % maxChange
-        #print "prefix" + branchPrefix
         changes = p4ChangesForPaths([branchPrefix], range, self.changes_block_size)
         if len(changes) <= 0:
             return False
         firstChange = changes[0]
-        #print "first change in branch: %s" % firstChange
         sourceBranch = self.knownBranches[branch]
         sourceDepotPath = self.depotPaths[0] + sourceBranch
         sourceRef = self.gitRefForBranch(sourceBranch)
-        #print "source " + sourceBranch
 
         branchParentChange = int(p4Cmd(["changes", "-m", "1", "%s...@1,%s" % (sourceDepotPath, firstChange)])["change"])
-        #print "branch parent: %s" % branchParentChange
         gitParent = self.gitCommitByP4Change(sourceRef, branchParentChange)
         if len(gitParent) > 0:
             self.initialParents[self.gitRefForBranch(branch)] = gitParent
-            #print "parent git commit: %s" % gitParent
 
         self.importChanges(changes)
         return True
@@ -3813,8 +3808,6 @@ def importHeadRevision(self, revision):
                 newestRevision = change
 
             if info["action"] in self.delete_actions:
-                # don't increase the file cnt, otherwise details["depotFile123"] will have gaps!
-                #fileCnt = fileCnt + 1
                 continue
 
             for prop in ["depotFile", "rev", "action", "type" ]:
-- 
2.34.1

