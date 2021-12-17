Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C593C433F5
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 13:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236776AbhLQNsw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 08:48:52 -0500
Received: from mail-bn7nam10on2079.outbound.protection.outlook.com ([40.107.92.79]:37774
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234468AbhLQNsv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 08:48:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VEpBq9eSEANYAxqK673JeO5sMNY5I9rUvLMhQ3pc0PiTzzyoYYwwj3NMSnOWF9NGkcpuyNY9aOEf7+GtaBk5G3KkqCi4TDoDeiZ7Gvc5mlk8T8D7idM4Tl8pJFvCstgsGVrGV4oLoa2tDUurbOnjo0p7eYv4194IwQbnrZaw1sM0Le99e7lvYGjpGsLlNWOZ/73qnPG0zcKIeLLK+sRGUjzo8pgjT5kMSAyErj1kcHv4rkI5mAN0tEX0ERm3wBEg1WNOQJH/MHHdOyKQyFL+YOJdW97HprVKgl7LiryRp4TM+0utn6J0gUEfp8qENoKZvzs53MvTl5u1iviqJM7ekg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CCe4aNjGY2xB6lRvyF4xuhhL20Ef4Pnzabgo3UGv6fo=;
 b=YTqdHLSRFiXGtPxkOE1Iso8DMQy5WGP1rnvDOVltS+Wk6nB4VY1j7Ii6ap2Oqzof+nqIlos0rv33KK49tIl8875uJEF6Mjyzacww0cOBMIhXMxFpA3L8i3HI6rtPCvy8UoMa3YH5scHLww0z9pJUFOjtnLIZAD/D2I3txIV9yhQ3JPg7M+yX3LsKX3kpb3sNJlFT2TEQNH4tQVJ3cWTjwDDFGNO0g+ubkuNWmNGxpXTwZk0T1l7znMU2OH7cldAophxxw2RZZksfYMTbxJ+EYaLlUQ5hzSlkca6ZQHgL8RocfADuRhTNkIykX8a/F/zvdKmeYu+fN7xAspzDlgt0NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CCe4aNjGY2xB6lRvyF4xuhhL20Ef4Pnzabgo3UGv6fo=;
 b=jhnVDePIk5jd+KdgfTfIUavr1WHkSSBCPX2jKYLAKNYFOA+tCrZKRrN+kQVrg6TIy8zH8vz5xDjcXd4z/QrMirToqjL4bPpHrGKD8cKQ9Wjv5jRSmaAOwV5Xu2Q0OIDZnKEls4l4J9nGotRKPRgkXrpzm++/ieVq4q4Uhf2/uZUs8UfALnwV544KU3RPQ/9FnwnvOXzr57297/QsZFZ+N7HnywSgmrf4X9NdkkCmSISPfTBfLdFrmM8SG+BLFd977Wwfh+r6fDtPfeU4l4p8D78jYQOSTlMIcuBIwiy7ESCAa55e6mcnd/gEwNVDYTs1JGDOkW1gO8TrTZnF7JJVbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB3361.namprd12.prod.outlook.com (2603:10b6:408:67::19)
 by BN6PR1201MB0018.namprd12.prod.outlook.com (2603:10b6:405:54::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Fri, 17 Dec
 2021 13:48:50 +0000
Received: from BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592]) by BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592%3]) with mapi id 15.20.4778.018; Fri, 17 Dec 2021
 13:48:49 +0000
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
Subject: [PATCH 1/2] git-p4: remove "delete" verb
Date:   Fri, 17 Dec 2021 13:48:13 +0000
Message-Id: <20211217134814.2112631-2-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211217134814.2112631-1-jholdsworth@nvidia.com>
References: <20211217134814.2112631-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0113.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::10) To BN8PR12MB3361.namprd12.prod.outlook.com
 (2603:10b6:408:67::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39574874-e6cb-4e40-4952-08d9c163f45c
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0018:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB001833E101F9BF1C9A114118C8789@BN6PR1201MB0018.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:949;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /5xis+jy2AeVcfuKZ3h3gt263Cr7uRFSY7gvhB93KmQxRMhuAvMuQTr724TpJGaK43Wyj85FDQQPzHzwlhT7vAcLd2bCJZ3yu+PzDu/azyF9nOq85yqI4Z/loPf+mj1kxEcHkfkzzvswXMRyfEgYMJdC0ZrTTqQA6/+GnzID1H8Je+nUI8Z584LnkEBi2q3xn3r3whi4wCgOd7fA4h7glkxnsnrJrknFiD6pIkw1CJedlew5pSJJ090020mV9SLyyVw/E+uAOzLvt6TC5S/+CF12bgf4MMBOJg9PCORPEdb4sVznQ8XVtepq7cmayRQ9AA2/sdlSpchqx5WOMyufSqe08Kusd4VwwUEpuy/+m4m0oM4NZGB3vr+hjWgeYhNVo9wnZRqk+/gYqam/srJq3DndoVbwauJroljbvO9WHMyP6UEk5GmAzcuPMeSyIXdb3KdFSCG8PBg5DYmbnUzYhrMx4fcjXZup33LAkfwdqfuUmOQsjXtelJUDL9AYWvfhkzpDchiyBOsyiysV7HEX4BY5qBOWBT0qVeoKtHmjKeal+51pNe67aIlraPNa44le1ZGcZ4ctmq41VZgyeFpBDsM+stwaCJHL4CoDFx3cxiH9W9XJrnSGwywu0/geiZLJOxZB0s7WI95Z7b1HE/EvcHlPTstfzSmTI0AcL+jk8BfrFu7cYXtQgl+I5Jh2tYzhQdHoRrL0AFWihVDbopsEaw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3361.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(1076003)(4326008)(6512007)(316002)(36756003)(54906003)(66556008)(26005)(4744005)(5660300002)(66946007)(6666004)(2906002)(83380400001)(8936002)(508600001)(107886003)(38350700002)(38100700002)(86362001)(52116002)(186003)(6916009)(6486002)(2616005)(6506007)(55236004)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1f9QhfcFlOO0jgeWdKXLcOSzawIq95214CYJbq2m+zxy/FTg9sQNILSFEKwe?=
 =?us-ascii?Q?HGVMZPOADHs/G+73boGo6pT4/AMafS/7Y5R7Pnvu3NufT1e7JlXIHpcq5TVj?=
 =?us-ascii?Q?9qfyLSRRBn7vznyD/vNTwQm9bc2qiDPXDv2/dg95QfzRLhymYI9Ltn+5JZvl?=
 =?us-ascii?Q?eLxSEqNmaT44awFTcZofvMEB3SuSA4VVdDiFbWB8qtszH+pUOUKUZ/5kI1D3?=
 =?us-ascii?Q?aKrq2/Qf1bvF01iZ/tRNOWc8yDl2mwBu9uJVVtNYk9LqCFmyUCTQOd3FZW+W?=
 =?us-ascii?Q?gdzCPUq5K//B8jqWpRaiEfbyEIKlMbuXKR90nsUG37TDOByj2YKFQ63FOowH?=
 =?us-ascii?Q?ArLJaxYeIFMEp0XCNXN3pJd8mQ35r5c9aR5gsX81NuaJLOiPtV7oE/1WpnRt?=
 =?us-ascii?Q?xuIb9e08mE2PoGT8CLtPunxwL0u2Aj+OpGq22VpOlkIw2+QWfi1gX5xG1ag0?=
 =?us-ascii?Q?vFCYWWrRSeXNL1z81B9lHSjoCUv8W3GojVGWraoOSY7sHQOETHyT4Xu5HG40?=
 =?us-ascii?Q?6ugDN1xN32FXiPiSvw1rKYKgybaKAhhdcLeYqqHeJhBA4pj6Aq0zqSMUNOfc?=
 =?us-ascii?Q?TPH0ssuO77fupMGqa2dYZJUDEq6IjNhCcqn8YqDTqnri/LbuvbuAUHQA+M6K?=
 =?us-ascii?Q?vXHyC9nzxIS4pG9E39qV9L/w+nEGflsnXYB+f8w/InndsxRfbJOMANkH/EaE?=
 =?us-ascii?Q?gRzk6jZhHTS8PxLgZackIzFwzgAnP3YSfKFXdH0hd9VlA7YnowvUo7E4yp2C?=
 =?us-ascii?Q?GoP+1/Pt/X030n/d3ZgSmepOEf1po8XTbC/6f8cT79ASmvH+brNbEoyZRFQU?=
 =?us-ascii?Q?hMmMF5cI+m9QhyO7H3xal0YKLFY+irl/NXN/+tGvQ99cHA6YivwC50WmgZDb?=
 =?us-ascii?Q?xDhGZBEY4YEJtWvkWbrqUhJV2XyRWes1Msq5ZGSRRVAfKmNgULjxww3LkbT1?=
 =?us-ascii?Q?DdDZbMIRyxYwzWo1lPkOPczIpuas1Rhbs+GvMFGsAVAXNNZ/g5RwFkA9BBEd?=
 =?us-ascii?Q?51bcJ095/yIxoDWV0KZiIntOG6i1LDgF/Ej5JcoNiJ49DARSaRPvlZLZNDtP?=
 =?us-ascii?Q?1F4j0zEs/SHKq/DXqfJ11X+EJ4mtCE7ao8fS6EtdAw3X4J94inx9DL+YompT?=
 =?us-ascii?Q?HQemPIyRUunoPvJSqoE6jpH6FYaX9v+EmG0F4lqbE4ZPrSX8dlSmH35Xuyhf?=
 =?us-ascii?Q?CG34tMnQ4gpq3goZfyi1CPLHFDqcl6BdeHqAei1IEUZvcVpeeOiYWJkG26G5?=
 =?us-ascii?Q?s8kBILfS+E9T9Jhy874O9ftZrf9jQr5jADDGyvz7aSnnpLehuqujQozsK8u7?=
 =?us-ascii?Q?9dUK802wLi24zvF3G12snnRFO73BrT8ETJOQ4jZ9MT15XO390nNtljH+rY9w?=
 =?us-ascii?Q?oUWjrBSry2bjDtV0jVr2YYOuo4nH2WHJn9cABG0e1jyc+F3DsZfHcWoO2zqo?=
 =?us-ascii?Q?Onq9Guom1Qbr4GD4JKHTUJ4TUS6HDxMXSTSO9Qhhw41mhiWRYz3F6+kUIlAw?=
 =?us-ascii?Q?vNj+qB5G4Zbe6GaGchtiph/QZfh3hoEzYUo7lvzpwSi79Jk+LUQljwq+mDF6?=
 =?us-ascii?Q?u4p7OAChAADZf+rEDd+3do113urB9K92PPW5flNSzgZkNSgiZKkBfplldTJt?=
 =?us-ascii?Q?77QV6fBy3Ux5iuPvgnyFMqY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39574874-e6cb-4e40-4952-08d9c163f45c
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3361.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 13:48:49.7896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /VZ3QftXbpOwkowXzdBsseMb7DrL4LTzMHJKbYQETTUdQI5QSqwjssojKJ6PwB+AQDAqnd7VEd4lHJ6KploZBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0018
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The git-p4 "delete" verb is described as "A tool to debug the output of
p4 -G". However, the implementation provided is of no useful benefit to
either users or developers.
---
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

