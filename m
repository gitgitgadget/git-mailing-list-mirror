Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA06C433EF
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 13:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235539AbiAMNs3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 08:48:29 -0500
Received: from mail-mw2nam12on2069.outbound.protection.outlook.com ([40.107.244.69]:26926
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235516AbiAMNsX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 08:48:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UxSpstkCRP1g5+6mmSPedy5FD/F+4eruy8lZccGKU7cxwUVBD2betilc/9XdZY7U5esmg/0maLuKEQQCgFZq6H/nXQNScoB/pijjMfnFxTMSRM9zfCZUUX73vo3ALCmjpLtgfhP5XZRpsRE+VKvrt0/nrNsBg9YPQS7WgrVZC5JwAgeMjbuKnWmxLGcwkmnef25kH4AE26EdisBLmFFzg2Ko7ss06o84NIOiu+jMskkQdQYgzBbbXl72yrKzAP4Sp/ZVUh1QMQekDUG42uYYFJNT9lEPj01cUAInBDkspnixFYKbmzE92B1EFk3aG/DHkStrRTpAXzuitbSqJ9d2Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4U9GNC8d6waPh+KEu9VVRBVcSMagmjASUfGF3bzZBTE=;
 b=mxVCdyjXw8HDoG7h1UgO75zvAut1OWsBK6qGGrqQPXRzupWqMZSVlyEPffWWuGCS2/4vt53xldec/9FnR0co7QOYerz79YsGb+muvYnQzOqjyOg6zpemHhkdaY7kM5dXPHMJD38/x/Jzhoy83NHLtQtcniN4wHQm55ctq0jFYZxZ8XFp1yEdY3KwGq6yj/aHbA4vmQ7/h0c88ofedlzGtWCCNvyDNM2ye5SvPljTuDdLkne5WSJpoM4qfaR80JVkngarJHDBAksdZpBXPrNZePjQ/CFD35AesV9ctPxVx/j6Furldl+Kz5V+t/lY4x+IFivQ6mpegxCRgN9Wptk6Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4U9GNC8d6waPh+KEu9VVRBVcSMagmjASUfGF3bzZBTE=;
 b=XCTZi7Opfe+9W4Zq0Tk5yhyykKtSkCn9lSJCHb9VZNdRu5DS+xbh9gwPkqIj5bEVeIXr94LpgQB49ZfG6DYvBs+O8rVtJqpGy6lV2w4wDYyQ6b1ondZABsOeZIx4k8mCnhgL0zlRU8UN6gXvafKrY5SqrHlcR3o/vkWVznk7tp5fB25huT4MlXMn+30j9w31XLh2cY7VjtjE4ro1al/fo3lr3+kOLVDzt6sqj83RQ842FD03UwZb4YAOHqAumoZKrcMv74uchXKO35YXqq1R/UyMUq0m8YDz4fkfC7AH8hXpsPTfqLgbijieGkfUE+xrgtMJ5qCXon43f2++0lr5Lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by SN1PR12MB2447.namprd12.prod.outlook.com (2603:10b6:802:27::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Thu, 13 Jan
 2022 13:48:16 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed%4]) with mapi id 15.20.4888.011; Thu, 13 Jan 2022
 13:48:16 +0000
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
Subject: [PATCH v2 09/21] git-p4: remove spaces around default arguments
Date:   Thu, 13 Jan 2022 13:47:16 +0000
Message-Id: <20220113134728.23192-10-jholdsworth@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: fe55388b-2ce8-4b9b-b667-08d9d69b598b
X-MS-TrafficTypeDiagnostic: SN1PR12MB2447:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB244780BC72BAF8D84A918D1BC8539@SN1PR12MB2447.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:158;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IjMnwjXAuIFapNWP03KyrPxn5gCpjOroAup05Wu0dHeQlEq7KgQV3RLq/TDZvaxTATXTy9qMW2NINkZ+sH9hHAySowfzaFTW2H7rQ+4qDCMoDUI85Cm24OjzQnlxZC60rv2d27R4KceABfAyskUHgAUM9Z4OZXjBT83/SJ6v8adcuBBjQcXzSnMrn/QeeFGamHI9vxq0CkmIYLR7YhNJNjk2IQynSiTD6uhlJoM9l4hrDdIxAfBDhmhx74mTFmIfopqqy5GmGubN/ptNKJepgpjpUQRy6H1i2pWETZTbZf4cD8YgAuGWLpCRBr8Lc8vzGLZ3PIXvigRZ/Zqr75tvryGMLrgXJO8r/wxPhdVDln3MAf1VQWnkeCaLTX8TkLduWekXFLkHriwkxWvdAYoKspE4eVZVOqmUZu4QvbU6z27FXuucPC0guJRKizhtRPshSmFLxcOZw/d8oDRXRtNnuhSdP4PE1UHM1IepRDCXrmo98aEbhSuSwhk2wYvXI6n0hyEwPY5YJw8bDziFKx0Qa7RNZ1Mst4gZfxNsqkIdWgVAMGxriXE3vfKUZCcqfxy9EpXrqh1a8Ke9EBhRyV+0ei60yfZA03e5Maw62vxzizcoPUIUCv7KsbJYRMrNQYJ8y4hfUachiGOUIfbwc66tqoA748XvwcOqHMoSLyrBea/7QaAhWxhALQxXQAXhDNq2eEXUPeeim5vGcslQ+ycyQGJoWsIYuAB1SvZulQxP+c2BBmaLeoI9+zFX0aJtFlASSsEFMLTIiz2csbDWj7BZMriRHl3vq2ssRzD8gV+8MwE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(1076003)(8676002)(66946007)(8936002)(26005)(83380400001)(55236004)(2616005)(4326008)(107886003)(6512007)(36756003)(6486002)(186003)(54906003)(316002)(38350700002)(110136005)(38100700002)(7416002)(966005)(508600001)(66556008)(5660300002)(6506007)(2906002)(52116002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9xpqwPmIxqbE1G+EEXCfdVzV0m/FMf3/kou7/gfi/XmIRl7kfHSBcsZAIvr1?=
 =?us-ascii?Q?R3kk/G8e7SDcv2QeMsU9zp/s+N+hJjGM4SKrLjDZXf2ij5mAOQDLU4zKVSd4?=
 =?us-ascii?Q?r/0tC7pfp/+ncV2JH65Jowyl3BEiZX1ixRSBCSOVzcFm+HKOWEO8N0QWcGjC?=
 =?us-ascii?Q?mv/WZAhkJmcv6kwoALB2ULeYvK+C/e7uQhIoyBMZfNCfu8tKIf9tBT1bhDB5?=
 =?us-ascii?Q?B27MiuCvz/e0xzF9K8cO/WeKq8s52kGfNGyQ0/f/yotGOqNm2gENbu27yBZ0?=
 =?us-ascii?Q?rZCxOpKMr4r45iS7nrhKp6cGQSd2wyG/CabO25DnSIyQJBHqb4kYaxNgQD8Q?=
 =?us-ascii?Q?TvQIgIRP0XOcpwl0M9wOygjbZsogN9HDOCpiybv0aJvhTUl4FWLlKW8G8FG2?=
 =?us-ascii?Q?Kc0bxqtX/67BB44U6q5JUHqYeTflFB+BLFb0AF8fZO3g9xXCjYjaM6c5t3Yc?=
 =?us-ascii?Q?aqUA8gQgv/+q6E5iWsGIwpR2t5UW/jxMBVFED8tyqKcIB/3CsjDGA/XpMQ3V?=
 =?us-ascii?Q?hZvCsyXxeM4aJAKT33zb32vKYb5zEsQ9rTbcgn80xw7qVTDbJnCpAnTjRjmb?=
 =?us-ascii?Q?RcVGr7jYg89IiZQJT9R7/sy9RR7l+VJQcER87xrdB6mNNXftwHiD3FIMUVcI?=
 =?us-ascii?Q?fElLew081Y3y8CgRGrr45w9h7ORbE7RUKWbpSE27EAdcCCxQlPxhy4r4hYkh?=
 =?us-ascii?Q?efz/SSH/ky9JFxdN9QUFJy88+QmZXOWexu03P2dYK62lMM3tiCU4F5y+C8N9?=
 =?us-ascii?Q?S0/Qu0ODK+BbDfCPCmVGVFatCckuBsTa9luy2gAScNG0FTBVK6lWhqlCNW6w?=
 =?us-ascii?Q?1VTO/AT9wmMroy50h82TfREr8yr/epLLoVM4m1ohKuh7+ekPNqW4hp9ab4hX?=
 =?us-ascii?Q?9pSBoPM8GLcLmypb8SdeqRQy4dgA6QFKGfiQZ+hPa4Gykr39iB/eklCFSYdB?=
 =?us-ascii?Q?IBrlzC+gce6UgGYzFI/Ki3M6XWqQMQgABuR5J2HiHy3bpXC2adkeBSkMh8K0?=
 =?us-ascii?Q?Am0eUz/wE/ZG9cALkeTIaOCF0FBc84n4SlPcux879HfRliWWoBnLECvG8s24?=
 =?us-ascii?Q?w37/Pd/iIu9acx7Bys6+DLqfsWpYsatxNMnS8Va05+Ptq5s88+OhAyzLrh9N?=
 =?us-ascii?Q?GvoYEBw8iQC3ybhXtKakwwEsDr0tiTQVsTaq5euGY5ij6rm8iLve+OzxE2St?=
 =?us-ascii?Q?QVO0Zy+jFVZ71XAx4G8QvjJcQsDK5C8H6/Q2a9iEql5jANGyuCgMRqWm5yPD?=
 =?us-ascii?Q?C6/ZkWYmJuh9EkBtev0/p7mRwBhjMa4V8t9TAP2MA5bcA5DpQ/KHLKz4NygG?=
 =?us-ascii?Q?4ZiOYdxOylhEszfJw4++yiMWr6fD5lInxu6ZBJN7uj8d3jJg+r8rBjjpJElj?=
 =?us-ascii?Q?MqgWgjMw3EVLMcEvpRZ3V2a1QeGNMWWW/v6/5ufMHpnsX5GliESPL33TdOPV?=
 =?us-ascii?Q?XiZFjujjFJ5p1z9GBduxqnPE7WkeKDlev0WN9DYC31qZ+Wbpsf7x/cCKuHYF?=
 =?us-ascii?Q?pVshlMvKdNEQIFXUDZtWJ8xGmY9jwoZnsMLKgtKAohVUWctokbVGveBnLtUC?=
 =?us-ascii?Q?rVDHRfG1VoeTwmdm3Gg+wPgm3CBiJ9f6h/nFbxAvG1ZlggzmUn707Zrl0JHG?=
 =?us-ascii?Q?KlPN/wEtc0rUDWCW8KSEMsM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe55388b-2ce8-4b9b-b667-08d9d69b598b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 13:48:16.2270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MXvRQDrxmIEtGF+jipNkVElSeWV+wQQxwPSaDRNlOTMyBwnnnXX2L4mgMQqkuI/9tMEO4e+/iZJz/qiDXhWZ1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2447
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
index e3898a7e28..a5052bf35c 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1113,7 +1113,7 @@ def branch_exists(branch):
     return out.rstrip() == branch
 
 
-def findUpstreamBranchPoint(head = "HEAD"):
+def findUpstreamBranchPoint(head="HEAD"):
     branches = p4BranchesInGit()
     # map from depot-path to branch name
     branchByDepotPath = {}
@@ -1141,7 +1141,7 @@ def findUpstreamBranchPoint(head = "HEAD"):
     return ["", settings]
 
 
-def createOrUpdateBranchesFromOrigin(localRefPrefix = "refs/remotes/p4/", silent=True):
+def createOrUpdateBranchesFromOrigin(localRefPrefix="refs/remotes/p4/", silent=True):
     if not silent:
         print("Creating/updating branch(es) in %s based on origin branch(es)"
                % localRefPrefix)
@@ -2910,7 +2910,7 @@ def isPathWanted(self, path):
                 return True
         return False
 
-    def extractFilesFromCommit(self, commit, shelved=False, shelved_cl = 0):
+    def extractFilesFromCommit(self, commit, shelved=False, shelved_cl=0):
         files = []
         fnum = 0
         while "depotFile%s" % fnum in commit:
@@ -3341,7 +3341,7 @@ def findShadowedFiles(self, files, change):
                     'rev': record['headRev'],
                     'type': record['headType']})
 
-    def commit(self, details, files, branch, parent = "", allow_empty=False):
+    def commit(self, details, files, branch, parent="", allow_empty=False):
         epoch = details["time"]
         author = details["user"]
         jobs = self.extractJobsFromCommit(details)
@@ -4490,8 +4490,8 @@ def main():
 
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

