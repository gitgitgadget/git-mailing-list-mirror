Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F21C433F5
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 16:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244698AbiBJQrQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 11:47:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244673AbiBJQrM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 11:47:12 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C99D1BA
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 08:47:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CVxAenmqe7ficoO/V6/SKaQNFaQfBivnp6kQ8MiLVRuEh1Sr4mRY6NOob06p9U/c80TFbjJ8t/JFmzHyM17W1XU2S5k5YYrgvdntv5HH3vJz6FERxQvX6eq9xd1Ijepp8TIlj9nVSzuaZZ+/m8dLPIrLoUj5m/y/lBuRdl2h7/eolH9kc7ciUBK9SsABcBFdrD4ug9u6CfyRg8xNYABNXYmP+xO+gJSAzGt7X5q1PYzItFv9KN9mzmJXIPRWCttIrRf/2rEMOn6AXuHEZlken6xTITKX2l7HtN8cLpLykpIZyRxFuTmGt4XPGhPrXi4eZ2ucUYVW+vwQxtN/BPzeZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XSrFuIuQTkh8gAHzpqD4mRovhGa7yu+X1dqu4D6fKMk=;
 b=XFqv6PJol18zndHa465HxTAzOr79NW62bCSV3kIYxm+hWW7xraPEgVrQGwHXM57VNtouQ+Oyx/sLqJrNCI6L78i3oY3ACw0JK9byssHalWBT88/c1tD7MgxiUxV8V1Z9j/CWLTfaSQt/ArpEDAfGNVCfFomJk38qN07wGreRgei6lLwXszVwnpD8Y2fbrVEiYN85/ljS9+Ah0wAr6WnN3nBCeDHNMBrW8h1EyCrlMfBEgoiOELlI/SHlaS78ooF6OtmX6brd7tNU67uBgJtnaRnUZl4laqx7WKGHT7w3edNCSvhh14BGLZT/XR9VFwQKdXR9tfm+Yf7CzrqTp1CzLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XSrFuIuQTkh8gAHzpqD4mRovhGa7yu+X1dqu4D6fKMk=;
 b=cxLU3P7mY/c6lh6BT6T9sIOS8483Dh3jWuO9HB1kbrmnQ3/5O/8dJ+Rsnq8/3R53zMo9LKr8iFl3RL+9LY1uXO5sBakckEkSTuuUcL2NwCN4PKOcPXGwHbS/9W/65uXmBDr9o1h7h6ZFM1qrDAQTZGg+Pmz+a2O6xII7YV8EhBZhQXuVfV6u4tqfqkk0B0J7NDV80KoAzyuWgJAhugv8x9K7NXvDcARxT0Ht8WMM3rNk778jJGwXP72v27rSjGCCDEvwpIELXqsFMLkd2GmCyBwAgF+G9T8ciw7++pk0Oi8ZuZnC3cr75WFQkf235JYjpeaw2LYpFro+ma5/OaZ/HA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by DM5PR12MB2421.namprd12.prod.outlook.com (2603:10b6:4:b4::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 16:47:06 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::dca7:5323:3:cc10]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::dca7:5323:3:cc10%2]) with mapi id 15.20.4951.021; Thu, 10 Feb 2022
 16:47:06 +0000
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
Subject: [PATCH v4 06/22] git-p4: remove commented code
Date:   Thu, 10 Feb 2022 16:46:11 +0000
Message-Id: <20220210164627.279520-7-jholdsworth@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: d3ec245e-4644-4b16-f1bc-08d9ecb4f899
X-MS-TrafficTypeDiagnostic: DM5PR12MB2421:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB2421268F580D691D56DF496EC82F9@DM5PR12MB2421.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:115;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dLE5zq1uxD0fixoZY/3Ck7V5kxMejWyzF0nrxvzOCf6Oprm0ahXjKVYu8oXvnKgIQZeqSOX4DTJhBZKwi8hCdSoyUnbDRFRHh0sGNLB7V14dMejwgXc8ivBUGo+m5E9BxerdlnYGb3bFgphQ/lwIsHISJPKy+6NFUOCg/ZMCq3+IB3uTPhP7Rt5moAPOtzp7zYZ1tXFAk0HduGA58xu5OCupE8nzNDx2vTxK65qD1oezuv8Irkl3t/t/uEemqdGducVsUPGI6GD+tmfpDnXyDp1IxGYh2SlZOo2gHIRuTuB366luTQ8sOELpU1cL1kysP9v6v6iuA1B0Kyt0aGu9u2s/3/6ZnbySR3Dsqf9m/h4Rv4pdu2EOHhNIUf7l/BkrBjqBl4pOUzwTsa2oMV/o4wzqan2xkj5NR60OD7TocwTj67VCbExnWgUN8bqXGYhULQvUKh6dm051UUPL/3wag6CMRNacCpl58kF8MlPbQeHgIQylRX3QQMiBdbmE3AfGfZfZ7wVx2l4ZGByrhF7ZSXv1qBtXfAh7d8TwDTI2eCwIgr8kMNsCUa5ZFMC4G8exiW9AqnpwnWrc4zWgrnS+rFGBA/tUi1vXx7M4Ofb2Aj/RVA2jGTNXDxsLorOCfatzevhEW4mziKSl3Vh8SQMRZMALZ6EMiE03PVFKRWJCydSbVoRPzDcokO4M0HvwzUlrR0tTfeyfwnHnBz97qhflWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(38350700002)(2906002)(52116002)(86362001)(6666004)(508600001)(6486002)(6512007)(55236004)(6506007)(186003)(8936002)(8676002)(66556008)(66946007)(7416002)(5660300002)(110136005)(1076003)(316002)(4326008)(36756003)(54906003)(83380400001)(66476007)(2616005)(26005)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sTiugPGIKe7jTxX4Yh34FnNuWlsTqVmbeerENJg8KEJ08UWEL8qjq5E2jZbc?=
 =?us-ascii?Q?rCHGiUCcBhUmYbgk8KHCh0OSBWZQZYoSbFhNazIgDMz/1AyvLmmFLh3x7g8w?=
 =?us-ascii?Q?KgDkoJV08iYDx18DgbiOS7RYSUSWFVbiVp5fzSpmKkd0d+K5TGycBXpGRkws?=
 =?us-ascii?Q?l71415N6d/eLai1bijOZNZzBeO1kjUUvjW127mnct0nI7N2cWpq/Ll/yFXfB?=
 =?us-ascii?Q?+dpQaAq7hpxQPE+ttCTo+q6uECTQRYY9UYWE2HWP5B/V6A5ErHdBcZamEhBu?=
 =?us-ascii?Q?+VC6fx+NzLIuJTmnk1qqSZSe6nGhsQhFFtuxpJo3mpYExTTtZdYkJDlEoBti?=
 =?us-ascii?Q?eKPA0EE0BP4OSvHDsmsVVEhYBxwjsDNiJEuRFNMcfMvf6AdvFFVGKvkBq3oy?=
 =?us-ascii?Q?ECVRvNFX6p62RSuZWJE9xo4Uq0LtsScSopL06mH7usuNp/Xg7u7AeIBipZQA?=
 =?us-ascii?Q?qd2nmozISxMfNLR3b8FGvrxZYo4eiSAH/dV71FLOBW4epiW9tLVdVOIJTTOL?=
 =?us-ascii?Q?zxXHdaH2wGiJPQDAdL+zDsn7EsarX/9fo1rnu+BKnWZ9pDpLQ7ybRoEltWiK?=
 =?us-ascii?Q?DVKPEKDFr2aLiegCU8Ci/EBmuzWbx9ABiDF52HzY3MIse2UTmRqW5Y4XI6WX?=
 =?us-ascii?Q?YWwGL0+9GWcO7YH37v/CdA5HO4rQsPsGLy9QlgSaO5hpFU+kJrT3AQ3HJJA/?=
 =?us-ascii?Q?zjRsEK1SpJQKhWoOzkd9zllUjoQG33TWSTvyjEtxrMy5BMNdVhRlnWW+fZi0?=
 =?us-ascii?Q?HO/LsI0VyVfdpSKAdnDE9aRM40FSREap7VTRpmOLTEiN/U4h1iNCXlZLbzC4?=
 =?us-ascii?Q?vtbG6+n1YB64l01zLJWzZDz6X+5tcyK5X83IG2l047GMj+UpyUS/+lxyHR10?=
 =?us-ascii?Q?X2n8c/8vJTGUvRB2JN9Oa1/3Pp2uQ+oUFA5kjgYQ5yYP0XTai5QhGy6cARR/?=
 =?us-ascii?Q?VpYd2zY4FodistxcyhWRaq83GER8IwQolfMEXNSap9oVYjQr3dnlQ1E6sMOP?=
 =?us-ascii?Q?G/OjV7fo6PEyolGYrtyZkN/FdOjMjuVUFK9myDwisVnNtRniEhr/y8ZErZ0u?=
 =?us-ascii?Q?i1Ugvb9hpuGfFdDyPiy98edNX24s0iws7ltWPzjcVm71xv24mf0CTzeBh4HW?=
 =?us-ascii?Q?3s+8vD5QtTLF6hY7oKQoj5kl/3ochGS/0ZYUmj4QhOiItLOiih2/Jpl7Vlbf?=
 =?us-ascii?Q?mjmNW9TxNl5ni+I5KzwCzh5uFD9ChiHJLZiuAQxscjMy2ufYngwWtFh8MMPb?=
 =?us-ascii?Q?bxdNc9+bwJO0Z1ghXzPtvp+gzpwBgQGdhbk0Kwp6tK7y/ngmSL0P2LzmEOJQ?=
 =?us-ascii?Q?dzZbhbs6VeTIxRnMpt3qyENDMjbQIgZRts+oYRnwMYBBUK9VJL40CfXIbOyw?=
 =?us-ascii?Q?yhaFqK3tcd8JyKI6AqpvM7ShYswUYJdgrRK/UejOF/KFZnIgzGzjcMgaOabi?=
 =?us-ascii?Q?E/NSE0/yi/Xfu4QGzD7BdxUBcF0jqya0+lRfzMTLqQNgCxOxQj3NdIcaT+0X?=
 =?us-ascii?Q?yOOS6ZvFzsv8NvXYCg4cXPyJRSXLErdlDFsnoiy38L4TrWvOhkwWdF0YVqLz?=
 =?us-ascii?Q?oDa2SQtmvLvJ6r6vjECmhcvfxqFWlgFvwHgRjCu2OuCe0GeUUj/dh7tyu8Gf?=
 =?us-ascii?Q?ye92dyPA88DlUYt6o9uakJo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3ec245e-4644-4b16-f1bc-08d9ecb4f899
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 16:47:06.1099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FPIt8z8soowtA2nynM8NvJgGESEWh1JJllsguHm84g7GevsuQ4+3uWotRd6OsRc2c37wjNpL3ta9F73OYMgvRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2421
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously, the script contained commented code including Python 2 print
statements. Presumably, these were used as a developer aid at some point
in history. However, the commented code is generally undesirable, and
this commented code serves no useful purpose. Therefore this patch
removes it.

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 892b964eec..53e99f81b7 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -3583,23 +3583,18 @@ def importNewBranch(self, branch, maxChange):
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
@@ -3742,8 +3737,6 @@ def importHeadRevision(self, revision):
                 newestRevision = change
 
             if info["action"] in self.delete_actions:
-                # don't increase the file cnt, otherwise details["depotFile123"] will have gaps!
-                #fileCnt = fileCnt + 1
                 continue
 
             for prop in ["depotFile", "rev", "action", "type" ]:
-- 
2.35.GIT

