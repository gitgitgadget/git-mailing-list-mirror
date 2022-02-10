Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685C2C433EF
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 16:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244734AbiBJQrz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 11:47:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244733AbiBJQr2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 11:47:28 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2077.outbound.protection.outlook.com [40.107.100.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E69125
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 08:47:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hgug+ey0y7CEv10u/Tzb77NEqpBDg/Ffmy+1Bfvfh8CIFYEQ6lR16zXdQ5mx2QvW8Ma7bZTwNYRlx6aLGMl7cgERxMhjLy/6F/A2MXPyh7fVXAOUdNMk3ZoYSIyx8CEh2lNbkpBujn0yIG+dhbhZkSqaLZ0C6lmH2s5oxG51U54rTZ4A+uavntJ0Mp4S8mlspkNfknQXScq69+cO+HXK4Tl1XASsHERV1zbXpGf/U6LOr/c2FVbTELFz+ptULyppIdWSXYWJjMxB7/6gTPM42VJuko6DNc1xtHuNH0Z5HZlqEd4i+brpuZihPbwyxiJmDs6AIxMHZCcPPwVBAb/a/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3mM5spYZvXTdEVQmfT6OO//9te0umlxdMASqF2h8Gk=;
 b=myhRNDeqdY8J3RSREC3P8EaHVgEpuqC5NpBf3vIJ75tIOrKkdMOj4lWf4fZDfl/O5xtq5/NgvVmF8pOGNFEJ0GuDTvOlYHhs4QLd//csK1vB0EJp1IAItselQIuT4Vk2HOHM2S9AcCPgRjxXWhTIFQkuq1iL300ymqGGccMkGrVF94t8DDjZHlt3+UXZN8hm3z2IQ/lKg/lccIC4Ga8OG0NNUsJ6D8ezWJFB9HaK8Pdh0VXO1ng3usBmOZRPNReWSxADJstHJkgsoLpm2Dsu1INXpQkZWSrQVdHLt5c7wn4yvamZiRx5uqENno5hDoJdNyIq+r5yJT6skk/Qofv/Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3mM5spYZvXTdEVQmfT6OO//9te0umlxdMASqF2h8Gk=;
 b=n1g3fGrb6Lw3BrXH3T6bfS1jA9LGm8PgRxpjsz0/jKSW5xHu7xpV1o4wyl+TUmqP18Gpxp8U0qjMhMMnnzHvabt0QZAdsi3MQQB7M8aYQYO4VDZMkmD+lbvjZmTzIvaBHto4JfTAeS10wIIT8eLBD0yDHrmXcF+b05OUdkxQNZsTCCmgbQYlhMxDlbImOgd5sLqODSzeKtVrRlWUa7GHLyY/hnLEQ8PzLustqIdOjJyE+LrFsXD34QBZY2Odyy0/Ba3eI+27d9HLuCrxp0fW14/ABGpLioviWqRdPjgBkse++XsWB+yvxz4Lzc0kwcW6DcrUv23ftVmB2k6/J7XzQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by DM5PR12MB2421.namprd12.prod.outlook.com (2603:10b6:4:b4::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 16:47:27 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::dca7:5323:3:cc10]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::dca7:5323:3:cc10%2]) with mapi id 15.20.4951.021; Thu, 10 Feb 2022
 16:47:27 +0000
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
Subject: [PATCH v4 17/22] git-p4: normalize indentation of lines in conditionals
Date:   Thu, 10 Feb 2022 16:46:22 +0000
Message-Id: <20220210164627.279520-18-jholdsworth@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5f297ce9-de5b-4046-06b5-08d9ecb5057d
X-MS-TrafficTypeDiagnostic: DM5PR12MB2421:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB2421DA58572C6615F1A1D684C82F9@DM5PR12MB2421.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ph7fnYLevAGZzumy4flfHV9ZqxL7StmxgYByqD0YQGGtR7Lk2O/nRQBkMOxEdfhdOLcLUYiijYCNIPzw+mh6E8XzEclzTXEXLI60V3uyJFkRJumfrw7MsFG5Vi0p42Us2/h9yTvAT0WOa5l4EUgLaKiCjezL9ygCxnqLmb2Zq2XZgfAkrZxoiapzapl3oO5Ew/TyhVlQARfJsKZWP4Nchomg4bb5/HLuMT3Bmpbm9z/sXXgtub6Pn8NssCG+SdoNPdCGZuZs3oUZluyYSAcjnC9nmmyAda8ZDlIV8Szcm8KfXWcZCTRzjWojFy6+8NXlHqJrarHA7oKWytr1u71usM3OBwhrVt7SCUbk+hdkWeeiyZzG4e+pXzIdz3YfsF0vLSgg38ljbX4UNJ0prE8EJtFOJcg0IlrF/G6I1LX1TOP5l5GjugFA14r8k4qbf+vIU0OPnb+kekvBt/sfz7l5qvLjARMxG1lfm925uVM9wHrfCx+HYFNpGpu21jTRIblOtwsl9fWi14ZkqWzqsSkBiakbNN/+JqmjEbJ6DWPyLEwLeQsLP3MUUPQCo2Y15uj9clXbTlLUefjH0Kz9WIXuROaeexmGUEqDL1Et9AWQDhRIWAGYlB0Qnpjl8rza/H0qRtkFHgBfJWCIHooFI/kiKjHL9ijMgpZdVhfbuqjQ+k+DsTtVCrbJS5j7+qi96UkYdZkTygyPbYwt74X1yqsz1CS/e1O8ctaiBeyMe1vFCXo0Zq/tw++hLiYtDFrpb2Ke9Eyz5Z9qSUoyF8aL1ZLyTOnRzepNXDr5OkShDQaB0/U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(38350700002)(2906002)(52116002)(86362001)(6666004)(508600001)(6486002)(6512007)(55236004)(6506007)(186003)(8936002)(8676002)(66556008)(66946007)(7416002)(5660300002)(110136005)(1076003)(316002)(4326008)(36756003)(966005)(54906003)(83380400001)(66476007)(2616005)(26005)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UM79IJp0jWLOIlUZiDvhWYF0R70zW71/22D4ZRHJ/VPaAtpNQK9aJpBnBk2/?=
 =?us-ascii?Q?ffYP1UdYzTBEZt0esbglPR7H2vNE44JO9KYczDG9NAMQvJOq+3/IGRrFquht?=
 =?us-ascii?Q?A2NKavZCs4F/kuX2WuWv0L+dtvqQxZMUQUpKfOICiFCSle3jAkNQUu935R1/?=
 =?us-ascii?Q?G3nGR/m5/ntWrnbCNumoKI9KMH6cKnu+e4z940j3tTWyBCuQ/mr+t957qAx6?=
 =?us-ascii?Q?txu39k8FDOrUG4JGQ0LUhxjkaSfPoJaT+Tbh34MIJ5A5mi/W54fCm5AFLDc6?=
 =?us-ascii?Q?A2xkKY3UOEVL0mRmznLq5nsyzWwzd92lG+M5o4613ZOfhda3QqnNlMQxGM8U?=
 =?us-ascii?Q?j9JsRckYOjscRD/2VxR4FAXg10UWQaNpXVH166ejO7Y4sPW1Hw3trWVPxXHI?=
 =?us-ascii?Q?pygCPx6rjqWyzJtJ8NNc6Hxu8RkpaYMw3DERgGhwcTdv/YLHzdJ+Zl7DAu0h?=
 =?us-ascii?Q?+dX69+opQ1bMir2hdiuunZPmsiApfyNW3XLdU//f7jq3DvlBmxyUDEZI+ek4?=
 =?us-ascii?Q?cPmOkLX5RlYUyCZYiHI7lq/4J8d+ztA9rHxkc1AiGkgHw0dthL0AGb9PeAzS?=
 =?us-ascii?Q?IxOsiIM/ib0Dp8+BeNHXy/2l3yYoOD8ANaDxePDOuzae55GJTWmNutyrQiwa?=
 =?us-ascii?Q?pVd/A2FAzh8AEVpFnWb9dgfW4piJMDMiD0WRH1Hit6ezASMwKsxq1zRLCoVm?=
 =?us-ascii?Q?2ZidxGAPStJIZ8I0H8KgG8Zgk1jiVRdx8uO8WuKp6K/0gf+pDAiY1fJAM0Fv?=
 =?us-ascii?Q?oSTAyua0vEsBOUO4+93yt33E+CiGDHpprvCVGttP/6/hOtgx9cMx7LKP8/Vp?=
 =?us-ascii?Q?jwV3FwMZ6ePM4weNgfRW4Q6OPHwRZM9ajSn+MiOlrP7nd4GtHqC1aOa4ltNV?=
 =?us-ascii?Q?p9/3z6CUn+B7SZijz9/oYvJ1mTg1HuqerHHgyk2PVauKSQdU9I5dE60P7l0x?=
 =?us-ascii?Q?qe8vBh+Z+nih+s/5WY/w2hKGGMu74DjR7c6V8gnhF5TTShmQMP7/kR8uvV8J?=
 =?us-ascii?Q?Kzcmp98OcXDZlXkWG8///ndP3H1QFKQn9kB4S1qORc+fmuN+JqA3l+Kk5WKb?=
 =?us-ascii?Q?Ar/er5NHJ1EXL1zckyxVktbWSjp/iC1Wn+vnF8ZaXRM238HrohdgemLtoB8R?=
 =?us-ascii?Q?IOzU9qJRpbDHMKENl1mKxeePTbkc+K5Srd9cHQ/UUS2WNQiTzXCFL1LrgDIp?=
 =?us-ascii?Q?jgZzBJ5NHN383cwI/MSNBfHKLvHk6Eh2z9FOje7xuKvn3Roy0fgFyVTMJsi6?=
 =?us-ascii?Q?xOyoa7woIEbrshBSlHKxx+b93LYul0x3Zj24r86L+nLsSf1Xato6uVRH+bZv?=
 =?us-ascii?Q?lmxSf8Xxq7Hks/I1DFUAETBA+qrf9vH71PEirHR/fH/uFIs/Q5ul4eC0Lt85?=
 =?us-ascii?Q?ZUU6+xEmPYiDSkQxjP7tjCbBOVk2+/BDM5bU5DtPMaGc4x1suxpgcgYrkEwh?=
 =?us-ascii?Q?2iUhPDQwtnQJrTCsZnwQJ1dVbTBd7ST+2GmmVK7lMF0dAH3q6eEpjDria6rs?=
 =?us-ascii?Q?M43BW9gFha7cX5v1whJ5yO+gX8akIibyCeaEI4VJ+tNeFjE+e6iz9H8/zjBc?=
 =?us-ascii?Q?Uzb3sddnDcnBngc+ciJzfEs7+Nv6a0JxjU4slNCMLttT5nb5dEvqGNMlJpQx?=
 =?us-ascii?Q?iLuFPZfELsN1+2M/3J3LYxA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f297ce9-de5b-4046-06b5-08d9ecb5057d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 16:47:27.6982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ZMt7R1yRp47tz2ZTZ3rFniY6zsY4uwMT8EKQnWoHiqtdepwn/RQ7O7f8E82DiVdX3HQSLBKRKeFw0tlwL/AMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2421
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PEP8 recommends that when wrapping the arguments of conditional
statements, an extra level of indentation should be added to distinguish
arguments from the body of the statement.

This guideline is described here:
https://www.python.org/dev/peps/pep-0008/#indentation

This patch either adds the indentation, or removes unnecessary wrapping.

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 97c2f82ee8..a25adc8bae 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1085,8 +1085,7 @@ def createOrUpdateBranchesFromOrigin(localRefPrefix="refs/remotes/p4/", silent=T
         originHead = line
 
         original = extractSettingsGitLog(extractLogMessageFromGitCommit(originHead))
-        if ('depot-paths' not in original
-            or 'change' not in original):
+        if 'depot-paths' not in original or 'change' not in original:
             continue
 
         update = False
@@ -2098,8 +2097,8 @@ def applyCommit(self, id):
                     if regexp:
                         # this file is a possibility...look for RCS keywords.
                         for line in read_pipe_lines(
-                            ["git", "diff", "%s^..%s" % (id, id), file],
-                            raw=True):
+                                ["git", "diff", "%s^..%s" % (id, id), file],
+                                raw=True):
                             if regexp.search(line):
                                 if verbose:
                                     print("got keyword match on %s in %s in %s" % (regex.pattern, line, file))
@@ -3112,9 +3111,9 @@ def streamP4FilesCb(self, marshalled):
                 self.stream_file[k] = marshalled[k]
 
         if (verbose and
-            'streamContentSize' in self.stream_file and
-            'fileSize' in self.stream_file and
-            'depotFile' in self.stream_file):
+                'streamContentSize' in self.stream_file and
+                'fileSize' in self.stream_file and
+                'depotFile' in self.stream_file):
             size = int(self.stream_file["fileSize"])
             if size > 0:
                 progress = 100*self.stream_file['streamContentSize']/size
@@ -3930,8 +3929,7 @@ def run(self, args):
                 settings = extractSettingsGitLog(logMsg)
 
                 self.readOptions(settings)
-                if ('depot-paths' in settings
-                    and 'change' in settings):
+                if 'depot-paths' in settings and 'change' in settings:
                     change = int(settings['change']) + 1
                     p4Change = max(p4Change, change)
 
-- 
2.35.GIT

