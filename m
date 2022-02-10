Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B29C433FE
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 16:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244720AbiBJQrT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 11:47:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244623AbiBJQrN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 11:47:13 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F47EA4
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 08:47:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eR06Rblol6jIXwAaVlw+Sjcum5VDnbyuwsladoWGhbxk4Vnnnw7D5ltLAc1VWmhbQrmmAnwKhY6ZYxer5iKwNF16KwXevL5BW9zdVEUTLP9sHQpgYnaOx6lSSmPwSNMTBCMH7xDmyt4kgnrEdt3mZVncRn/kRXPAvTpN5R5zDAbz1CpfpvO+QtLmwxbOqzIzNR/k28Xxn2NxM4lquKrgKhUUkbMX2aPjElh5uDgd2XiD3K/OsvjOJ+Wl0EWh7InlQurxTznvpsbCPwv+nQslJWrv3t6wnz9xyUXSuClwetsnqLlqN6VDChfxEQd6UWHfLIHfk46PkTXIHWEJBZmOqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hXAVpbJeBxh44J/eNn3GdnQYcyKkfdn8a+rR0dEy0OM=;
 b=UFDn7anORP9J7/iSq5fS6NDhQGuWWqJndjfviZeKVM66/JeSv5p82N8/JnP5Fmc1Sx4HqHbUkgk09Mo/QiTcpE409aPJaEtCqlnHE3jQJ1AuALqt+f6ARUXfYC58TpsnOuvaUeuNc+oX9jtOgoPJ+Djqif0mzjdQa3RvnFI+wuOxUaGdFk5/fg6slnGC4RhK0dVGk0KbV1ySBa9elUfrRtg7UgqvN7nx+cqq5lgNZbb4/wsJTx9zHLB/r505wyyJlsLLJqlQvruFLC9/biq+YqpOJdwperFdEwFeXUVtLcPv2aLWIErH4VcD0bRNccuShPHxCMs34F5BKqwPefc5YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXAVpbJeBxh44J/eNn3GdnQYcyKkfdn8a+rR0dEy0OM=;
 b=CpEgB+iMLTzQ0PVRuLUQFc+wmBRaopA04prkWeALLGSRXjhtZXd9aJh3e1qNCx+QoXjOwh3h17XxfGllnIomC7eZ8f7n7Cf/U8qB01DmbAxdZMrC+LM1uGfkhhaGkGf/tpKmXjHcH3Vgfozc4h2vPyI2vryrnLqmNjp95lqGOQ0BX9vWMo+19hHvhk6FY9gAnGPFNCex0whry2u+blUK8OH29kNLd76ZlWoVhIyJY2hxWcjZiYVtTox6OCm2HPZZ3VlplO3bBdTeaf8U5HvIjFl1qSWtw6EmBXWi6+WoAYUcXip5LTLlMmQPtFIaCFMKixuHVZSyxgGVw93dzPa73w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by DM5PR12MB2421.namprd12.prod.outlook.com (2603:10b6:4:b4::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 16:47:11 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::dca7:5323:3:cc10]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::dca7:5323:3:cc10%2]) with mapi id 15.20.4951.021; Thu, 10 Feb 2022
 16:47:11 +0000
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
Subject: [PATCH v4 09/22] git-p4: remove spaces around default arguments
Date:   Thu, 10 Feb 2022 16:46:14 +0000
Message-Id: <20220210164627.279520-10-jholdsworth@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: da79b1c7-3ecf-435a-a2a8-08d9ecb4fc00
X-MS-TrafficTypeDiagnostic: DM5PR12MB2421:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB2421D0047BD1F0DEC9816747C82F9@DM5PR12MB2421.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:158;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qAh2UuXiOPLCrBWFmYnjsb7JsDD8MNJ156+571JD21fxTWzxH7gnH/MMSGLCT8xTW/iA72LehvhBCLin1+Vcz9NHnb8Mn4dCUfdfRr+l6LZUprv7e0J4IZ3//+9ynwDzDSXOB3aMZMiZ8YG8A3W4F0C0BHcewv2q/rWAX8jWM89cy2oyhHVL/MmH09qnLE49IAtzJysAn2705falGOMKNOHSLygA9fEWbKfyTUg65+aX4KVWMJAmdK58X+B9fTVdJdnRQvUFWViTa0DvzwnZpNIwPSQ+Hgr4A7iOm2QNQBY+wjd8+k5vkov7bt6qJvWonYYBsj+B8vDh/b+NVVdFEw4mV0nI2Y8ONL6aJobW3BXmxBR6IN8RS/8XH66RfV+x3pqf+6FCKbz9ClMgZOU3fEM7iAkd70KQABxpKyBGVlxid5XA8Yl6v/oQlZQcO+ZmOklMfDkzxAGD8/0t41h3LF1jqYlasA5OxKIwm8wlfMAaXpLvszOV8SHKflogV0IV+sO60V2aJhYJcZgmW8kNRZjyfLrUfBW74zvE4tpXNEjGf/8lOuNgeFlQrShdUdy8D0LUlPApCZTuK7J2VqJ953uNcy3ARJJoAdmNNPOJMK4h0SF7jfwO3B0lubeC2tQcnBg47BHkpkAmPNo/sn5yMMnZCFD+dJr/aN0e/M9/BQ7bUgIKqbUBtxnX90cdnDOqiEVYpLfgpekqiWKjQgBMQlsksUuRhzT/kJn61D9CcbficnseQ2iP1PlSFRfUdsiuuwDUCTvmkyS3+FTSl1dJyuG/YMCCfepTd5Y0Ltolmao=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(38350700002)(2906002)(52116002)(86362001)(508600001)(6486002)(6512007)(55236004)(6506007)(186003)(8936002)(8676002)(66556008)(66946007)(7416002)(5660300002)(110136005)(1076003)(316002)(4326008)(36756003)(966005)(54906003)(83380400001)(66476007)(2616005)(26005)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RDtA9X/jX+99JeougmsA0BZQpA2lTeQa3khtYsZTWUgksgEj1bPNWp4pTX+f?=
 =?us-ascii?Q?o6uVoaq1IUOJOgknsC1j9Jhh6ROWCG2lY7hpUdJbbCTrn7Sj6oPQJML6zqQc?=
 =?us-ascii?Q?xBxsMOcEBo4IHizrlXxfQa3luq+5cfzBevwkJ6CTVHhI2QipWcpNfKGg1P+u?=
 =?us-ascii?Q?wpCFzkekP5IrP2Ew9kT2XLNcTxCJV/kUPIiC8x/SFl6Jk1wbgfLUGe09y0l6?=
 =?us-ascii?Q?8I9o52udhD5QPUpe4Oj6KMJFIwAQfCyDTK1sOZJW8HaEeeapbbbAgdRsVRMz?=
 =?us-ascii?Q?+AhaZgiR8Mq7naWaRr5x3/8CqVkO4aGiBM3NdpHsJQKm/XK8QiqgeWVajIE4?=
 =?us-ascii?Q?7MA3Gia54oK2byWHcZLa3Cq72Ps24+TeQVOGlN38iv+vV8VrVNFg8MKbpDLj?=
 =?us-ascii?Q?T0j6tnOIzBtT3gazSOx3KDJTHlrI1X6BEjpGjxOWYtJbrqlt5nz2cc998DYP?=
 =?us-ascii?Q?PpIXz1/hxPROtPD/fHnHyEvivxoYgu4mVdJqavyZxRFH0lS2W6xwaLZReaTw?=
 =?us-ascii?Q?as2nqSm3mNSkp7g2cvWEmTg7b2kELPB3v3tT6W2QoMQPzKOytfIXIQF0AHYG?=
 =?us-ascii?Q?/ex6KkycL007YamQZ1raW4ZD8rHKsN99HkF2FV4MTp/e3NPxWtYaqKWv//0t?=
 =?us-ascii?Q?XfN6XVUX1NxVGCbPthOQ0iPS/UINO3zUXorKrCTvnm3OvUYRS2hx+58Au2rS?=
 =?us-ascii?Q?cP62gKJiT3oyFGf0b9BxoFgBS+e7iRlWkLUUvysDtjsrSpAWiD0seqcbBq92?=
 =?us-ascii?Q?AqQ7uTzkjbh6435dFpwyXexCrjPb4gsDW2AQT2MWtKGik2XFlM1BGkXDj95e?=
 =?us-ascii?Q?WDKJo4g2/cG5UK/finlJUjAh+GKpI108TN4kIlfQF4x2dKhm1ghp54mrdvCP?=
 =?us-ascii?Q?ZKAbgajEldarwBfWyDI9/ZlYBJAFYx0bnmvb7LPd30xn5jF8TDP/I9UceJnx?=
 =?us-ascii?Q?fdqXv56giOrINFOLpR/tVCX9KyCiAfjHUy7vordz0OTL+RLVT6yiqYsBOzqO?=
 =?us-ascii?Q?EVfSBlJRU8Jlbw4R+Mss4ZHxIaFOIDvvB1y2+24Aee8gC1XtzYlpBOsUH8CC?=
 =?us-ascii?Q?aqzWv5hBqPUJZtdyuBYKQk2aOnnHlVzaaPDm+sm7HMwogwZ1DK3slL4ECCfM?=
 =?us-ascii?Q?UL8VpA0fwZy/SnkPMh40XvuMMxD6cQG6BeijRq8bTiD7xvwCVsw5K60LsUFG?=
 =?us-ascii?Q?Lmbkcb6OgxurYe2u1DtB7cn28NT3OQy/wwD0m425feRp69fW1lR2bcCnM1fx?=
 =?us-ascii?Q?tc/qkbagQx/L7EgGpifFKAO41dtvYT9exDxFCvZpePq9RH6hd5NTIvnb1hot?=
 =?us-ascii?Q?smsOF3xBcuW1NqYdmtSGExuhwS8N5uiZ3aU4g9z2K9YtG15FavhPjxDQmLRW?=
 =?us-ascii?Q?sEIJoSSLqOPP0VKDY2iideEkorwhgzLZu+H9C2WsLj6Pc1fg++Ko1mlr12oz?=
 =?us-ascii?Q?iK4VM+fjIsVrkyCyG8OwjocNe9dcGZDswqUufW50CG9ho6T5NG0vwAYBWM/4?=
 =?us-ascii?Q?H4oNbvvzVLVkvVuZ+T8IqdMZWSG5mSIAiiS2KbX5SI3wNMVsxKa2Uv7anLbX?=
 =?us-ascii?Q?VCEN1TCsc1q3lho69AG1N9GGwc2qKri4wWbkfneMWxbMWAjIH/QJaoifiPBs?=
 =?us-ascii?Q?TwvGL2n3znFfBqHiUqYjj6Q=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da79b1c7-3ecf-435a-a2a8-08d9ecb4fc00
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 16:47:11.7981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jD7v8dvdDH+oKffxJMl2JnVTso6bjYnpMFRDUp4/B3M6Wm2DGLITCWOKwicIyVxIm+rIOwZSAp8w6aQ3ZWWFgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2421
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
index f8d07cfd7f..0353bca289 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1040,7 +1040,7 @@ def branch_exists(branch):
     return out.rstrip() == branch
 
 
-def findUpstreamBranchPoint(head = "HEAD"):
+def findUpstreamBranchPoint(head="HEAD"):
     branches = p4BranchesInGit()
     # map from depot-path to branch name
     branchByDepotPath = {}
@@ -1068,7 +1068,7 @@ def findUpstreamBranchPoint(head = "HEAD"):
     return ["", settings]
 
 
-def createOrUpdateBranchesFromOrigin(localRefPrefix = "refs/remotes/p4/", silent=True):
+def createOrUpdateBranchesFromOrigin(localRefPrefix="refs/remotes/p4/", silent=True):
     if not silent:
         print("Creating/updating branch(es) in %s based on origin branch(es)"
                % localRefPrefix)
@@ -2838,7 +2838,7 @@ def isPathWanted(self, path):
                 return True
         return False
 
-    def extractFilesFromCommit(self, commit, shelved=False, shelved_cl = 0):
+    def extractFilesFromCommit(self, commit, shelved=False, shelved_cl=0):
         files = []
         fnum = 0
         while "depotFile%s" % fnum in commit:
@@ -3269,7 +3269,7 @@ def findShadowedFiles(self, files, change):
                     'rev': record['headRev'],
                     'type': record['headType']})
 
-    def commit(self, details, files, branch, parent = "", allow_empty=False):
+    def commit(self, details, files, branch, parent="", allow_empty=False):
         epoch = details["time"]
         author = details["user"]
         jobs = self.extractJobsFromCommit(details)
@@ -4415,8 +4415,8 @@ def main():
 
     parser = optparse.OptionParser(cmd.usage.replace("%prog", "%prog " + cmdName),
                                    options,
-                                   description = cmd.description,
-                                   formatter = HelpFormatter())
+                                   description=cmd.description,
+                                   formatter=HelpFormatter())
 
     try:
         (cmd, args) = parser.parse_args(sys.argv[2:], cmd)
-- 
2.35.GIT

